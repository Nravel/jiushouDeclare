/**
 * Created by Administrator on 2017/10/17.
 */
//验证搜索框是否为空
function hasString(obj) {
    obj.value == undefined ? obj = obj[0] : "";
    return obj.value.replace(/(^\s*)|(\s*$)/g,"").length
}
