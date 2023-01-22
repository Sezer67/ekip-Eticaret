import { AxiosPromise } from "axios";
import { axiosInstance } from "../axios.util";
import { api_url } from "../configs/url.config";
import { CategoryType } from "../redux/types/category.type";

export const getCategories = (): AxiosPromise<CategoryType[]> => {
  return axiosInstance.get(`${api_url}/category`);
};

export const addCategory = (data:{name:string}):AxiosPromise<CategoryType> => {
  return axiosInstance.post(`${api_url}/category`,data);
}
