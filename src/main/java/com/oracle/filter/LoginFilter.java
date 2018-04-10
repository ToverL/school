package com.oracle.filter;

import com.oracle.vo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebFilter({"*.jsp", "*.do", "*.html" })
public class LoginFilter implements Filter {
    List<String> list = new ArrayList<String>();
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest r = (HttpServletRequest) request;
        HttpServletResponse rp = (HttpServletResponse) response;
        r.setCharacterEncoding("UTF-8");
        HttpSession session = r.getSession();
        User e = (User) session.getAttribute("user");
        String uri = r.getRequestURI();
        String path = r.getContextPath();
        uri=uri.replaceAll(path, "");
        if (e != null) {
            chain.doFilter(request, response);
        } else if (list.contains(uri)) {
            chain.doFilter(request, response);
        } else {
            rp.setContentType("text/html;charset=utf-8");
            PrintWriter out = rp.getWriter();
            out.println("<script>window.top.location.href='" + path + "/login.html'</script>");
            out.flush();
            out.close();
        }
    }

    public void init(FilterConfig config) throws ServletException {
        list.add("/login.html");
        list.add("/login.do");
        list.add("/SimpleWord/Word.jsp");
        list.add("/SimpleWord/SaveFile.jsp");
        list.add("/SimpleWord/Word.jsp");
    }

}
