Return-Path: <linux-kernel+bounces-795670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE8B3F637
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E733A86B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E362E62B7;
	Tue,  2 Sep 2025 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il/g5DiC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63A1E868
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796934; cv=none; b=SYIiAI/589rV1MjnZe5cu+wqelopBZeP/1r6WIwNSC8fOVDqRP4a8so0IsIfrUIQd6iIKvE0dbMRqX6R+dmhd+ar9lQoJ3ijJZbIv6GXvsvVq98Gomk2goxsF+K+mIMdcZZgT02HLB7xGIWQXXuKHWKTkqwVvvICfmuIkSDBqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796934; c=relaxed/simple;
	bh=im7NYadRTHyEfmXv2PI4/RAof9Bxr0cUGhtOOsLLb0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikvPXNCZ/REf+L0kme3AmWrDU4mhXk4ilQzliOJZl867psldhU290Ix/I7AwJcurgEyqkb1ZSmMspZT9GGwWCWbjFntUp7phu3/lf/lit071lZAbacjXak+BgONZuRewDm0i6tGC0rqCf4tHn5JaCmZUo6zSYgEqMYmow2xuvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il/g5DiC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756796931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwnQVLWw3r5ceJM7DV94g3HH/db+9QctDZGqRZqZzX8=;
	b=Il/g5DiCkND9j6cnuw94wDsygMEHeNPe5IC07rqUwfnzDKm8ReAV5HSMtzOY2XvSoz1zsA
	ev28lh2vd3qRqgMdYupdnEPrk4luSYsR6O1imEKdu87Qi1KRdn8E132mtmEuUahpgGX6R7
	coHtEuDJekKHC29Kj9MgOD1WD7pb9lA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-ztaIy3xTPmKkrs9SZ6qiqQ-1; Tue, 02 Sep 2025 03:08:50 -0400
X-MC-Unique: ztaIy3xTPmKkrs9SZ6qiqQ-1
X-Mimecast-MFC-AGG-ID: ztaIy3xTPmKkrs9SZ6qiqQ_1756796930
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70faf8b375cso54074966d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796929; x=1757401729;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwnQVLWw3r5ceJM7DV94g3HH/db+9QctDZGqRZqZzX8=;
        b=SPGAhKUjeJhAZUBLYktwhBAOp8S7OVyp3lCqRizo45Y5FdKcq2cml1L1SRdQh2p89W
         SnliXkO3zvQraaEfIuj1u7kkCPce2PdB000BQkzqWvVIX5W3ruyO6y+mIK8E4D2HhObz
         /Yrd/kpkmGUZK1J5aOMhFDmujfBGTnG96Hzp54I9bJsjFaMapuM34EXg76/ASUuOJPhX
         8BEjktKqabUwFTxA4cwWfj2HrEa4GT237v/0FYfSnhatqkoAc6fOUV1cHzWAIloipLho
         Jxp2I5h2QKeq/dVF8OxqRo7ZLMu+ic8Qm6OrD+MjLhGJLLAk3LQulMa3PKPOjzER1sGW
         1nlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3uM3oMWFhS7JXtXzPI2vwYdQDB/dj9ZEQ2CTbb2IUtYZCzWUPx7TPdnADWf7dOQJs3ZDzAzf5uznObYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4fwlEv9AVzv1QZuodfE7n/svPfYYWgSf/ub2maMTPMEEIvlM
	nXr3hKCDwMFgOfj/rQy6CFRyVmsepbA7Z+CCqtapGCYdxjCCAb4qimTELLEH/AeC5l14cOW6QMM
	acdd432/fSJ7yllJUX15aZ6IauhM1qxtpnueaRrThKNuSQHg6CVH5jWcrJSTAw8MV
X-Gm-Gg: ASbGncuQGaM40v8Swrz3rY2/Tbeae3GHeVRj9nMZbUIGl1RZWSGT4lxUmbLDKzOJbyw
	/ItbB9Xr+vQhoKXJNS9W3mSIoK5cjzdlPlEPOV011X4OAoqYhiULFMhBYBnn7QCh14XnnVx3ljg
	GMoeZZBEw8+BIFeeFMmuQ9saHgMHsi5IU5eX+S4tjXXmhMSbS7Otz3lYpACHG23UPAOl2nrdzSS
	SriuohV1RJP+rImsIxKdNIRsCmqE7AYeHAgxfBoNZK9dYEVGZNqaowR/+/XqvaseoI/MZaoSgzJ
	suAOLUmvhEMwk1cscHMKZjabcCOQD42VCio=
X-Received: by 2002:a05:6214:5188:b0:719:12cf:50ef with SMTP id 6a1803df08f44-71912cf57e2mr76131946d6.28.1756796929673;
        Tue, 02 Sep 2025 00:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl9dp0yJxUygzcGwWlW4JH2MFXqf3SrOHhhWvvJyY3BMT7iNsAbljAlYrABN+Qx91wFDHhzQ==
X-Received: by 2002:a05:6214:5188:b0:719:12cf:50ef with SMTP id 6a1803df08f44-71912cf57e2mr76131696d6.28.1756796929288;
        Tue, 02 Sep 2025 00:08:49 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b644f2c9sm7383546d6.63.2025.09.02.00.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:08:48 -0700 (PDT)
Message-ID: <f0194235-19ae-43de-b73d-b2d8b7f77035@redhat.com>
Date: Tue, 2 Sep 2025 09:08:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcasecmp kfunc
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
References: <cover.1756793624.git.rongtao@cestc.cn>
 <tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 08:17, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 56 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..e807a708e5fc 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3349,20 +3349,7 @@ __bpf_kfunc void __bpf_trap(void)
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
> +int __bpf_strcasecmp(const char *s1__ign, const char *s2__ign, bool ignore_case)

No need to use the `__ign` suffix here.

Otherwise LGTM. I guess that it could be useful in some applications.

Viktor

>  {
>  	char c1, c2;
>  	int i;
> @@ -3376,6 +3363,10 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>  	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>  		__get_kernel_nofault(&c1, s1__ign, char, err_out);
>  		__get_kernel_nofault(&c2, s2__ign, char, err_out);
> +		if (ignore_case) {
> +			c1 = tolower(c1);
> +			c2 = tolower(c2);
> +		}
>  		if (c1 != c2)
>  			return c1 < c2 ? -1 : 1;
>  		if (c1 == '\0')
> @@ -3388,6 +3379,42 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
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


