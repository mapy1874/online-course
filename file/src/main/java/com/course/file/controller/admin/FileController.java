package com.course.file.controller.admin;

import com.course.server.domain.File;
import com.course.server.dto.FileDto;
import com.course.server.dto.PageDto;
import com.course.server.dto.ResponseDto;
import com.course.server.service.FileService;
import com.course.server.util.ValidatorUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/admin/file")
public class FileController {

    private static final Logger LOG = LoggerFactory.getLogger(FileController.class);
    public static final String BUSINESS_NAME = "file";

    @Resource
    private FileService fileService;

    // file query
    @PostMapping("/list")
    public ResponseDto list(@RequestBody PageDto pageDto) {
        LOG.info("pageDto: {}", pageDto.getPage());

        ResponseDto responseDto = new ResponseDto();
        fileService.list(pageDto);
        responseDto.setContent(pageDto);
        return responseDto;
    }

    // save, update when id have value, create when id is null
    @PostMapping("/save")
    public ResponseDto save(@RequestBody FileDto fileDto) {
        // validation in saving
            ValidatorUtil.require(fileDto.getPath(), "relative path");
                ValidatorUtil.length(fileDto.getPath(), "relative path", 1, 100);
                ValidatorUtil.length(fileDto.getName(), "file name", 1, 100);
                ValidatorUtil.length(fileDto.getSuffix(), "suffix", 1, 10);

        ResponseDto responseDto = new ResponseDto();
        fileService.save(fileDto);
        responseDto.setContent(fileDto);
        return responseDto;
    }

    // delete
    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        fileService.delete(id);
        return responseDto;
    }

}
