package com.course.business.controller.admin;

import com.course.server.dto.TeacherDto;
import com.course.server.dto.PageDto;
import com.course.server.dto.ResponseDto;
import com.course.server.service.TeacherService;
import com.course.server.util.ValidatorUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/admin/teacher")
public class TeacherController {

    private static final Logger LOG = LoggerFactory.getLogger(TeacherController.class);
    public static final String BUSINESS_NAME = "teacher";

    @Resource
    private TeacherService teacherService;

    // teacher query
    @PostMapping("/list")
    public ResponseDto list(@RequestBody PageDto pageDto) {
        LOG.info("pageDto: {}", pageDto.getPage());

        ResponseDto responseDto = new ResponseDto();
        teacherService.list(pageDto);
        responseDto.setContent(pageDto);
        return responseDto;
    }

    // save, update when id have value, create when id is null
    @PostMapping("/save")
    public ResponseDto save(@RequestBody TeacherDto teacherDto) {
        // validation in saving
            ValidatorUtil.require(teacherDto.getName(), "name");
                ValidatorUtil.length(teacherDto.getName(), "name", 1, 50);
                ValidatorUtil.length(teacherDto.getNickname(), "nickname", 1, 50);
                ValidatorUtil.length(teacherDto.getImage(), "image", 1, 100);
                ValidatorUtil.length(teacherDto.getPosition(), "position", 1, 50);
                ValidatorUtil.length(teacherDto.getMotto(), "motto", 1, 50);
                ValidatorUtil.length(teacherDto.getIntro(), "intro", 1, 500);

        ResponseDto responseDto = new ResponseDto();
        teacherService.save(teacherDto);
        responseDto.setContent(teacherDto);
        return responseDto;
    }

    // delete
    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        teacherService.delete(id);
        return responseDto;
    }

    // teacher query
    @PostMapping("/all")
    public ResponseDto all() {
        ResponseDto responseDto = new ResponseDto();
        List<TeacherDto> teacherDtoList = teacherService.all();
        responseDto.setContent(teacherDtoList);
        return responseDto;
    }
}
