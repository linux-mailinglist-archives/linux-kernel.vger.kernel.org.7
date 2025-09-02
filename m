Return-Path: <linux-kernel+bounces-796018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C1BB3FAF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6761A87AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADC2ECD23;
	Tue,  2 Sep 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSJMcf0s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992F2EC547
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806348; cv=none; b=LCKx7H1RpNSicF0nHdgZzx04QG6Uvj9wXRBBUDyknas6KDE7e9ZzW1xQkYtFzQwMSk49PnD5GzwaBMFLq34zjPg5YHeXmdPu8ksa8yqomEj54xIYLJtXcvEh5JtSjScGlDB6nkh+jxNgGec3rQPTWFu1zQYN9khVB3ck2NOrsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806348; c=relaxed/simple;
	bh=bmdHYgxlrSJ4C+/l7uub89+wrMG6ofKMt8evfvkO93g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tm74sVN2H2BCL9Qg+1gGTucEnJetvlmmNzwruwsYOGTWTz25mC/ym6x7aLNdFjhctMIkkkC/EqGfXKFX/GLZqSF3bELuHclvOZrn3YwdEwmMCZosVmHNHrD5JAqUXzCylmEIWNK//VY06JsUxTb2NSzlw1i09gKx4l2VYP3cKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSJMcf0s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756806346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2Ve4CgS6Jqh9ORpRtoAAIe0w/LUc4ir/s41Tz+S/dE=;
	b=bSJMcf0siIUmz4LWRF60tE3ps7OlPiKqPci3o79iSw+2N4clLIjm3ThSb5LLJteMC5+P73
	/b3O9EfDulkjTw0TvCmvGkdbi5dClKnjyuZvdnnU6sO/MA46tFf3C8A/rn3o29pFqntTnd
	xVI7lcX3MG79U5EpPi/N4pggU3FUWdY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-zDMNXxcaO0m724NnD0wczA-1; Tue, 02 Sep 2025 05:45:45 -0400
X-MC-Unique: zDMNXxcaO0m724NnD0wczA-1
X-Mimecast-MFC-AGG-ID: zDMNXxcaO0m724NnD0wczA_1756806345
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3200a05dfso45826341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806345; x=1757411145;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2Ve4CgS6Jqh9ORpRtoAAIe0w/LUc4ir/s41Tz+S/dE=;
        b=gidWy6iwunKgl0NHnB6GCa/uVOrPlCVTO3XvqTets2ZwjK6ndN54Sn4fgjG77xr8R4
         PUTNksKtTnrwmhn5pApeGE+gyDF86Y6hTOKOE6sWK9ZUgnEQLikoT7XGlRw/fNOBU6PF
         DGIpQRyz38LL9skltAYvmhVdU0R0W8Llb+5W5M/9DPmXaGOUviCGNvpyRo63dJiedkaa
         9mCnUeIWjybx3HrutO5tJ7n3pD5zAOqTxYQxUXf9YTxDWe6ClOPvlpDuGKzHdV3jmmfI
         abjAGB4Pr1xRNF/g6qtdEL3LeT4cdOnjeFXrxwPSOSAGPyQO6WiMYiqWL+0WPw7t9jUV
         GPcw==
X-Forwarded-Encrypted: i=1; AJvYcCXviQvChEh7goLj7AIcOgE6cs6O1R2FNPoAD42Xr7U2lRPuCJrYIvzjdCkMcCmqc1S0MhGKzsB0Lk6xyDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+Yf5Q0Z+2jAMRqf1Lu7xPkgPdwX09vhkmh2K6MNd4fGYlQ+J
	c5XUc1HOLbxUz+k/FwucaL20gNZuJcLlwHYRBd8Qm19mimpzASATGPBlJgrwKyA6khzTzNbP3eO
	338vJ4vGb/e0BIXp+Nh88pcFRI8nBQAp3famJ+mVJ+sY7caS1BhNgB2k1mwN29MZ/
X-Gm-Gg: ASbGncvzDS78KlW0xGfyuV/Bw9NA5REw44pocNyE7SQ1UQSIRn012ApnVsi0IZrxqWX
	+twdJPJTQ7tkrOoRFD5HlYVk6xh3loDs5goxYZgBnYHG6Oc420+LRrGtm+5nnPTYxWQXEbqLvSc
	2JQS8pXF7w8zUJGY2CNYfYEAJEZTMgRgrSWdLPAbvEUdYzghota1718PB+fB3ZoLqow9oBL4/Kt
	CYlHvf6SuB2YDr5FnZc3z5uLVICTl/RS4Rkp6cXCoo+2ASSBeD2kjohmG0v3xqdP7uXFIqMy+8V
	kl0IfTdRmbPQeWbLSaL/70BV2alyQ1bTIqs=
X-Received: by 2002:ac8:5dc8:0:b0:4b0:71e7:2d7e with SMTP id d75a77b69052e-4b31b85ea03mr128189551cf.8.1756806344647;
        Tue, 02 Sep 2025 02:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrXB5u8zkFeeKDAOLeeb1BWItMmJbWssZqtK3k4jcmoOb1/w6NiXzFGMOyMKcLcHSLWa38dA==
X-Received: by 2002:ac8:5dc8:0:b0:4b0:71e7:2d7e with SMTP id d75a77b69052e-4b31b85ea03mr128189311cf.8.1756806344112;
        Tue, 02 Sep 2025 02:45:44 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3461e04f5sm9734241cf.19.2025.09.02.02.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:45:43 -0700 (PDT)
Message-ID: <3c75ce2b-a863-40e0-9280-120cafc3542e@redhat.com>
Date: Tue, 2 Sep 2025 11:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasecmp kfunc
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756804522.git.rtoax@foxmail.com>
 <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 11:19, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

For the series:

Acked-by: Viktor Malik <vmalik@redhat.com>

> ---
>  kernel/bpf/helpers.c | 68 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..238fd992c786 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3349,45 +3349,72 @@ __bpf_kfunc void __bpf_trap(void)
>   * __get_kernel_nofault instead of plain dereference to make them safe.
>   */
>  
> -/**
> - * bpf_strcmp - Compare two strings
> - * @s1__ign: One string
> - * @s2__ign: Another string
> - *
> - * Return:
> - * * %0       - Strings are equal
> - * * %-1      - @s1__ign is smaller
> - * * %1       - @s2__ign is smaller
> - * * %-EFAULT - Cannot read one of the strings
> - * * %-E2BIG  - One of strings is too large
> - * * %-ERANGE - One of strings is outside of kernel address space
> - */
> -__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> +int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>  {
>  	char c1, c2;
>  	int i;
>  
> -	if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
> -	    !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
> +	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
> +	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>  		return -ERANGE;
>  	}
>  
>  	guard(pagefault)();
>  	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> -		__get_kernel_nofault(&c1, s1__ign, char, err_out);
> -		__get_kernel_nofault(&c2, s2__ign, char, err_out);
> +		__get_kernel_nofault(&c1, s1, char, err_out);
> +		__get_kernel_nofault(&c2, s2, char, err_out);
> +		if (ignore_case) {
> +			c1 = tolower(c1);
> +			c2 = tolower(c2);
> +		}
>  		if (c1 != c2)
>  			return c1 < c2 ? -1 : 1;
>  		if (c1 == '\0')
>  			return 0;
> -		s1__ign++;
> -		s2__ign++;
> +		s1++;
> +		s2++;
>  	}
>  	return -E2BIG;
>  err_out:
>  	return -EFAULT;
>  }
>  
> +/**
> + * bpf_strcmp - Compare two strings
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> +{
> +	return __bpf_strcasecmp(s1__ign, s2__ign, false);
> +}
> +
> +/**
> + * bpf_strcasecmp - Compare two strings, ignoring the case of the characters
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
> +{
> +	return __bpf_strcasecmp(s1__ign, s2__ign, true);
> +}
> +
>  /**
>   * bpf_strnchr - Find a character in a length limited string
>   * @s__ign: The string to be searched
> @@ -3832,6 +3859,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  #endif
>  BTF_ID_FLAGS(func, __bpf_trap)
>  BTF_ID_FLAGS(func, bpf_strcmp);
> +BTF_ID_FLAGS(func, bpf_strcasecmp);
>  BTF_ID_FLAGS(func, bpf_strchr);
>  BTF_ID_FLAGS(func, bpf_strchrnul);
>  BTF_ID_FLAGS(func, bpf_strnchr);


