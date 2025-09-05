Return-Path: <linux-kernel+bounces-802131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50250B44DF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC0B1C82BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2A2989B0;
	Fri,  5 Sep 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Bac3SwvD"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67E163
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053766; cv=none; b=Jnj1/E5o8QNPgpAMHzdVswR51jN2/ODqH2bF18DriLvCogMAoR9Krh/Nl0WIxxgcKTx6IomL1p3EJ46kS8KH5iSnOQ4xZN0LVs2zL56Yl5hGMXSsSKcMRgC85swbeaRGe6zYGDYtydgaqth9jqqUwEwy2u+J/35zUkum8xIig5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053766; c=relaxed/simple;
	bh=IewoYa4/sNEIWeRRtA4YvIv2AUnb+uETo37xTP3tPhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuuK+7roSyrKLd5o3lA0NVTZ6fjatbcSyBvnQUzOtI9gyaFjbyXMzt/a9SjZWCrsud3iJ6hCBl3dzKqsKogPOjXwcqqAXX28d9ADTEtLKaNMGGPWSOs4lEWnb0mZ4U0Pe1uG0SYROZzafesMafMy9Sf9Ue9ZjMX+r2YerbGQMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Bac3SwvD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-329b760080fso1732247a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757053764; x=1757658564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FW7lMn0AUODjA3RFU0eDriejARFtJxq8hraVOainqwI=;
        b=Bac3SwvDoIDzc66sPfWaklRouxgTmQGTPBkQ6cqn1b4wVXQNcsU4qHRVPn3UP7CC3W
         k59f/Ock967WQrwuuHWQusPqjeHVP795Q8QNmOSOI2BP5gh/MS6VWPGRMGQTVfANMbMq
         /Z4dJNx4QyjbWa4MOkyB6OwOO+lqxilu4o2Qc5oGM/1BZGWAQh21IasiU8ZUYuTT4oXy
         h8KrgLkH1+bK7lDjvxAOiCKOlwtjYjQFuA+nbVX6mF1+Og9fajAYAb7GlJZuTWSnkK5k
         AaKnrDvXdLqPASaiEtFyHecq1Vp6eVtMVb48qOJFlEr/QR2fWA3+gEnZns+LGG53PgGE
         qguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757053764; x=1757658564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW7lMn0AUODjA3RFU0eDriejARFtJxq8hraVOainqwI=;
        b=ht8z5rQM3LO2gzwjEo/QQ2CzDUbw4jRqs3IBvdv5yLb+SAlBxIKaC9a/rt5Ldhr5rY
         mbTDtB7LKjk1EBJTYaSuAJe1gfOT9wMwC2unIFXPBkuveNQqR5PYBfZ76/jMecqbWjhb
         fUg36DCHo/kZw95u993L2JpPsieJ/Ba47H9H1z5scpFazVrH5hf6UWfuR6dGRsROWlYN
         Dy5zyW0a43Dsi+G6StwEPxa39Cb4QgaL8ivKEvbuqrDog+d8uNjEjg73U3rDIA8hewUp
         0nJSS2vfB1SUxK5Zzw0Tvwv+VrFnBfuM6TsrcFigXjrfGFNSWfX6k29HO09UMge5xK6h
         VdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUfngOGKAP/PMnpzxfj9BqQenNzSzCL5um3yFSBmWIXtLrdEU8nmDWWmqtPWs8zS6xdCu8+9EDVys3AbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kR3zRFfU0Dmgu2u6LQc9iz+LxJ1jHU0GreWdKzc0pR0OPOh7
	87qq/Nri/4M8A/bwdQU5MpQPbfhHqxOastkV3p6yTIsS6N9w54IdpDHBMFXJJ7t7eyU=
X-Gm-Gg: ASbGncuELeQocadeOPT5D6zV4Ys5egooV6QPm+/5SS+24jywab1EKn1cL5XmOQ9pszL
	oKwB17Kp0WXl7i26HgMmjcKKsMW+E5DZz0+aS6CEULqPXJsiUuRhL2Ny2sNLJNNTMQzJnw/WI5u
	C1/kC4OamvTmJGpz23fsfHflds8DP7hLLUzyFW+NyogL52hv9iHcN80l7xum0E0hKjtL+lKT/ER
	dHzkFDIxrsgfGqBx0aMQkd2+p8m4jzZIVzPLfPxETGVo8bwpLgWzcZrh+VJvwNu2I2St7mmNBfh
	bgAXsp/mlS84xpu4xtwr5ADlEmQm531oi7a7zl5JUHxr2k2e5RfAUOVtN+aDyF0OvM3OrykmHlZ
	r8G/8XvZ8Jf8rUeOz3ScGck7a7Pcl75QJNLXNHZs2hrGp73+JVr7yS4guSqfh+K/hxMM=
X-Google-Smtp-Source: AGHT+IGc3VU32PsX6C7ClVKA+lvc5cDeezn9b8o7ZgcI2xpiH2XwVhQRzLUpHdISHH74OneKcDaSiQ==
X-Received: by 2002:a17:90b:3d87:b0:32b:65e6:ec39 with SMTP id 98e67ed59e1d1-32b65e6f260mr9655069a91.21.1757053764191;
        Thu, 04 Sep 2025 23:29:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b694fa438sm6229629a91.29.2025.09.04.23.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:29:23 -0700 (PDT)
Message-ID: <97fb026b-54d7-42ec-a57c-51c8c8c44a76@rivosinc.com>
Date: Fri, 5 Sep 2025 08:29:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Fix sparse warning about different address
 spaces
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
 <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/09/2025 20:53, Alexandre Ghiti wrote:
> We did not propagate the __user attribute of the pointers in
> __get_kernel_nofault() and __put_kernel_nofault(), which results in
> sparse complaining:
> 
>>> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
>    mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *
> 
> So fix this by correctly casting those pointers.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 551e7490737effb2c238e6a4db50293ece7c9df9..f5f4f7f85543f2a635b18e4bd1c6202b20e3b239 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -438,10 +438,10 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>  }
>  
>  #define __get_kernel_nofault(dst, src, type, err_label)			\
> -	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
> +	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
>  
>  #define __put_kernel_nofault(dst, src, type, err_label)			\
> -	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
> +	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_label)
>  
>  static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
>  {
> 

Hi Alex,

LGTM,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément


