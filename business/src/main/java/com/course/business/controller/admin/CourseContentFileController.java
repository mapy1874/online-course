package com.course.business.controller.admin;

import com.course.server.domain.CourseContentFile;
import com.course.server.dto.CourseContentFileDto;
import com.course.server.dto.PageDto;
import com.course.server.dto.ResponseDto;
import com.course.server.service.CourseContentFileService;
import com.course.server.util.ValidatorUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/admin/course-content-file")
public class CourseContentFileController {

    private static final Logger LOG = LoggerFactory.getLogger(CourseContentFileController.class);
    public static final String BUSINESS_NAME = "course content file";

    @Resource
    private CourseContentFileService courseContentFileService;

    // courseContentFile query
    @GetMapping("/list/{courseId}")
    public ResponseDto list(@PathVariable String courseId) {
        ResponseDto responseDto = new ResponseDto();
        List<CourseContentFileDto> fileDtoList = courseContentFileService.list(courseId);
        responseDto.setContent(fileDtoList);
        return responseDto;
    }

    // save, update when id have value, create when id is null
    @PostMapping("/save")
    public ResponseDto save(@RequestBody CourseContentFileDto courseContentFileDto) {
        // validation in saving
            ValidatorUtil.require(courseContentFileDto.getCourseId(), "course id");
                ValidatorUtil.length(courseContentFileDto.getUrl(), "url", 1, 100);
                ValidatorUtil.length(courseContentFileDto.getName(), "file name", 1, 100);

        ResponseDto responseDto = new ResponseDto();
        courseContentFileService.save(courseContentFileDto);
        responseDto.setContent(courseContentFileDto);
        return responseDto;
    }

    // delete
    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        courseContentFileService.delete(id);
        return responseDto;
    }

}
