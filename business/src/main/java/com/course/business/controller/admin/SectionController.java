package com.course.business.controller.admin;

import com.course.server.domain.Section;
import com.course.server.dto.SectionDto;
import com.course.server.dto.PageDto;
import com.course.server.dto.ResponseDto;
import com.course.server.dto.SectionPageDto;
import com.course.server.service.SectionService;
import com.course.server.util.ValidatorUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/admin/section")
public class SectionController {

    private static final Logger LOG = LoggerFactory.getLogger(SectionController.class);
    public static final String BUSINESS_NAME = "section";

    @Resource
    private SectionService sectionService;

    // section query
    @PostMapping("/list")
    public ResponseDto list(@RequestBody SectionPageDto sectionPageDto) {
        LOG.info("pageDto: {}", sectionPageDto.getPage());

        ResponseDto responseDto = new ResponseDto();
        ValidatorUtil.require(sectionPageDto.getCourseId(), "Course ID");
        ValidatorUtil.require(sectionPageDto.getChapterId(), "Chapter ID");
        sectionService.list(sectionPageDto);
        responseDto.setContent(sectionPageDto);
        return responseDto;
    }

    // save, update when id have value, create when id is null
    @PostMapping("/save")
    public ResponseDto save(@RequestBody SectionDto sectionDto) {
        // validation in saving
        ValidatorUtil.require(sectionDto.getTitle(), "title");
        ValidatorUtil.length(sectionDto.getTitle(), "title", 1, 50);
        ValidatorUtil.length(sectionDto.getVideo(), "video", 1, 200);

        ResponseDto responseDto = new ResponseDto();
        sectionService.save(sectionDto);
        responseDto.setContent(sectionDto);
        return responseDto;
    }

    // delete
    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        sectionService.delete(id);
        return responseDto;
    }

}
