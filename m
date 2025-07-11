Return-Path: <linux-kernel+bounces-727513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31950B01B29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0C87643EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66928DB46;
	Fri, 11 Jul 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4T6AdP0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13928C2A3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234471; cv=none; b=bWQnrca6enLTzG5GVt/Bfv3QriNV6sOlf1rrbFu74iFabMPE0s8GylrlM/zPShIMD05UomXx9bj85ix+hPCIw8Es3WR6Eik9UhSRgEVqUHXrexbwvd4OkJAF4mpElYGXI7+YO1tWiow505TA2bdwEqPA+lAYwimSk/fHKBkw+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234471; c=relaxed/simple;
	bh=auQ3GV5t9cb+UbsFmKjYSAFQIKHd7DFsO/rjMwstnf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xclvc6daxKZ9tgGpkTaorvhAw6M8bevILR7KoMPTgmWgW7l0Fu7EBJUdPinRcLUpqxZlW+lU/P/Inr+L2vIxXmcfavGM9rg6waWUFfysrwwI26FSFAdRBjlpniIMg2+lfq9dUMNCf1LybE3xlHd65Gw11S9sTmcqIIOMuSENmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4T6AdP0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752234468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z08Gbg8lHqpscUl1/iAogzg3iZSbLo4ofQx8HgtMHOs=;
	b=f4T6AdP0ovozBgiKYG2fUnu1BYx9UUh52Yf1d1a1s9pAxdfbnrWFR86hhQVueOkTr8r7ll
	HB44QWS31yhdClwg0YRHTmB3Q/DwDzl/z4mPf7Djf1gcW2jM6gYpfdbrupsj/1nxaefEj6
	KTaecixzFoXCLOcAEB5+21k0RicU25A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-oZdPUaeDPtC06VEGWVj_IQ-1; Fri, 11 Jul 2025 07:47:47 -0400
X-MC-Unique: oZdPUaeDPtC06VEGWVj_IQ-1
X-Mimecast-MFC-AGG-ID: oZdPUaeDPtC06VEGWVj_IQ_1752234466
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45311704cdbso12747135e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234466; x=1752839266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z08Gbg8lHqpscUl1/iAogzg3iZSbLo4ofQx8HgtMHOs=;
        b=ObhyCyedKQhOfV+FeOyqzjVPeS+8boeqnSPznymsq/s1RV8LU/uuKC2MDZsNioq/ub
         5Rc9mvbTy99pYKHjSjspQZJn3xnEe/b1bbleWTbm85yy+kMS0BerApZKUIDfE5kE7I0T
         ntAFMvdTrew0CUPbIDvHvJb+RKIaE6mPyW6Z10avR7csH54+OqTSHvA8Z2osxSuhOvqg
         JtiFX315Jvp7yf41IurdFPYVZJbGU3qRH48QT2uTybxKGHY2gLbnFv3Q99pEQ3cUJ5KJ
         IuYNDJq3S7Z12obQtdqnQ6Jl1CYRdE6k8UPgB8peMateanc4wV+WE75sV1o8trtKzxLj
         c1sA==
X-Forwarded-Encrypted: i=1; AJvYcCXt6m7llBzSWeiTySJrhe5qdWkzATXc+9QmKjI0Qs1Gp4i8k6WwAqod61O0v/ovtxlSfjhnReSIOnLGqGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZ/MmLB/EhdaQieMJ08RUc/4uMl7GjA3jzNkMRojoIaC6HpE5
	weZjPEJn+tkXiPHP69PtHYnbhVT1CI+0Qd0U3IL9hSeX+DFgT3Ggsiwel/fGyRQ+vhRqA3KWv8v
	wTP3IRRecJD3h6JqW9QwDVBy6fK6nJ5MMWGmcf2rvk73fXR2/5YPCETYSCKFTeLBRLQ==
X-Gm-Gg: ASbGncuAMse3Sbikqr/3msZmRdsQyG7V9x7pW638Mm1et8PiaswJVMGffV470YkQmnr
	2NZk1mO5QBGD9tj6aB7iPbT8a+opn2jdhsX+icrh5lVQxgS9ZFcky7bk1RWoa1APbeRS/gFqDLs
	8Bj+gBQSbK4nphsRXX7Mjc2ZT5osGzhiC4aHBBEg31a9vVxwfnPKmjVY9k+dz1tHN1ehTEJltT/
	QNLuFzeUvNkRbbuGA2LCdjAMvovWhR1Q2pg/AWq9WyKd+HJS93O10/6uwrvwz4PDkjZWvDkiwFU
	/8yuTR1pCcIBLgkK35ZOgMW3E0WBbnWonj9dU28W8Qc51teUuABw9hThS3/ud/6/QDW9jk5Aulg
	arNxcy31TeII/GBGAgQ4IRx1hsrXr2pxByTiqqvQRdj/U3P+t8QjEhrTaEDCXSz8I3+I=
X-Received: by 2002:a05:600c:474c:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-454ec12744cmr30550285e9.10.1752234466067;
        Fri, 11 Jul 2025 04:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi3R3bNrLa+24gylSjT157lm4D7L1IJX001V+RG3F77sHY/3q4HFovSzv9MSWIahtebYUIBA==
X-Received: by 2002:a05:600c:474c:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-454ec12744cmr30549735e9.10.1752234465456;
        Fri, 11 Jul 2025 04:47:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a15sm4192005f8f.6.2025.07.11.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 04:47:44 -0700 (PDT)
Message-ID: <377d74d6-a7f9-4e94-9276-168a26d49210@redhat.com>
Date: Fri, 11 Jul 2025 13:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] x86/mm: Simplify clear_page_*
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-11-ankur.a.arora@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250710005926.1159009-11-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 02:59, Ankur Arora wrote:
> clear_page_rep() and clear_page_erms() are wrappers around "REP; STOS"
> variations. Inlining gets rid of an unnecessary CALL/RET (which isn't
> free when using RETHUNK speculative execution mitigations.)
> Fixup and rename clear_page_orig() to adapt to the changed calling
> convention.
> 
> And, add a comment from Dave Hansen detailing various clearing mechanisms
> used in clear_page().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   arch/x86/include/asm/page_32.h |  6 +++++
>   arch/x86/include/asm/page_64.h | 42 ++++++++++++++++++++++++++--------
>   arch/x86/lib/clear_page_64.S   | 39 +++++++------------------------
>   3 files changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
> index 0c623706cb7e..a8ff43bb9652 100644
> --- a/arch/x86/include/asm/page_32.h
> +++ b/arch/x86/include/asm/page_32.h
> @@ -17,6 +17,12 @@ extern unsigned long __phys_addr(unsigned long);
>   
>   #include <linux/string.h>
>   
> +/*

/** if this was supposed to be kernel doc (which it looks like it is)

> + * clear_page() - clear kernel page.

"clear a kernel page"

Although I am not sure what a "kernel page" is.

Did you mean "clear a page using a kernel virtual address" ?

(we have a handful of "kernel page" usages, where we talk about non-user 
space allocations)

> + * @page: address of kernel page
> + *
> + * Does absolutely no exception handling.
> + */
>   static inline void clear_page(void *page)
>   {
>   	memset(page, 0, PAGE_SIZE);
> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> index 015d23f3e01f..28b9adbc5f00 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -40,23 +40,45 @@ extern unsigned long __phys_addr_symbol(unsigned long);
>   
>   #define __phys_reloc_hide(x)	(x)
>   
> -void clear_page_orig(void *page);
> -void clear_page_rep(void *page);
> -void clear_page_erms(void *page);
> +void memzero_page_aligned_unrolled(void *addr, u64 len);
>   
> +/*
 > + * clear_page() - clear kernel page.> + * @page: address of kernel page

Same comment as above.



-- 
Cheers,

David / dhildenb


