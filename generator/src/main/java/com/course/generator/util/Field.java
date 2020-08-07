package com.course.generator.util;

public class Field {

    private String name;
    private String nameHump; // eg: courseId
    private String nameBigHump; // eg: CourseId
    private String nameCn;
    private String type;
    private String javaType;
    private String comment;

    @Override
    public String toString() {
        return "Field{" +
                "name='" + name + '\'' +
                ", nameHump='" + nameHump + '\'' +
                ", nameBigHump='" + nameBigHump + '\'' +
                ", nameCn='" + nameCn + '\'' +
                ", type='" + type + '\'' +
                ", javaType='" + javaType + '\'' +
                ", comment='" + comment + '\'' +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNameHump() {
        return nameHump;
    }

    public void setNameHump(String nameHump) {
        this.nameHump = nameHump;
    }

    public String getNameBigHump() {
        return nameBigHump;
    }

    public void setNameBigHump(String nameBigHump) {
        this.nameBigHump = nameBigHump;
    }

    public String getNameCn() {
        return nameCn;
    }

    public void setNameCn(String nameCn) {
        this.nameCn = nameCn;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getJavaType() {
        return javaType;
    }

    public void setJavaType(String javaType) {
        this.javaType = javaType;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }


}
