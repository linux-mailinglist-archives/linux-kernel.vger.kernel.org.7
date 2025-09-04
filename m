Return-Path: <linux-kernel+bounces-800919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70EB43DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BE3A041E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCDC2F3C30;
	Thu,  4 Sep 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="CxpSSWPx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498962EC54A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993839; cv=none; b=QegmUDBSqE8zv6IUdVtDSsxC+ZgLsEGQDIGFD9NGhVX57q732CxOE+uTyf1E9QVptySzi0mFjsE7XnXTeDXOnF4DxHjAppA9vypChxeOqPQDX953h4se9TZxNB52n/jnEidj5GCwgGlxVMp5ixWMkMfyFpoocM4WWNiz/frK4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993839; c=relaxed/simple;
	bh=mo4sgaKZOpF6fcEiPQVuRCY4Rqd4Fs1IcnZ2aA6pidk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtwMzWq9VdoJL5sYW7x06gnbP6car2OvUVbjkyy5+HiC1dgUKvHb4q4MdBS03gxSglnSu8hfVq58rdiSw8pKv7hsTCx9brLigulUsFfsnucpgaf6wGk2akCKiET5pFIFtv1e4ffu7DAaehlTwTlq1ozkhSevC5ydagY/Be8QfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=CxpSSWPx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-249406d5878so11285845ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756993836; x=1757598636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlQ4Sx6+JNm7Anzsg6uLNnjJoKTjxwqCeqz7s3XShYk=;
        b=CxpSSWPxAv8JfOr+XK17IrZ1utzByIiXkB365Q4ObD8u6mIa/RIn4YiRzQU+8HNTsT
         cC+d1DWqnyNLDwTjXzE5RSnRGFOS9diJfB8ZIXhxX2IWa7ok5sa4YFLh+Eikz3L4NSEd
         I2tgy0dI+nWobzzJVvIa8EC7uM7E+kG0Mi8vNuf5FShYTwJgkYcb8LEwvapKbefDZS0O
         ategc6kVxuewKCN2qvnQRDJXuBNhrCaWdTO7rxdHiBgKAJCIkBXrlLPRZcMHhscP1fJ5
         ErvHFOgkToZBkEnhsneQ+UCoIP+m10vzGnpYVNJjVox23+XfvhiDrK+zsOeCqW31GT9m
         qOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993836; x=1757598636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlQ4Sx6+JNm7Anzsg6uLNnjJoKTjxwqCeqz7s3XShYk=;
        b=SoswaE4JL/ouX7+H5BdXx8XVz8p93xoM4JTNnq94vVWKeZIDxPvW5BHlNdJSYMh7op
         jzX29pFggOJOD4QkwCQn8GhcU74q3IAOW342hFzls2cgvS6I/YrfINb3uy6I82fj1jYZ
         McSlDRVPS4lYnJnWrAEs3KW7hZzGGaEwUuKfxe5IOegCCaU0MphYIV2Mr6GAn8E9DoSP
         Q9bByuTFacs1TOLYrsLr460a5xRyXRMY5p7hw7RYfuCah2ed+FVp0+FGp30q/84PSQ4+
         suupDOscOjzdPHgH34d71mDFyi0doxX2pglXYSxbJgZ29eb+sQ9keDLUrlYqpwnaFd8I
         EVWg==
X-Forwarded-Encrypted: i=1; AJvYcCXRISxdIJrpbj52qZBgvz7TNDxeC5FET1o73dIkKFAei9fRcUnwE+be0Ftm9x+q4YpDJNnl5tjNkzZWek0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GYP8UoNLW/KkiXN/EwRzKg+in+IKNisiaLvgi7eltC3RSoo0
	7myHHDJOtvpvCjGX3n0DBeAsTuq//hk/hyOKHXLOWihTHFx/UPtCMly79AJe4Tj0cko=
X-Gm-Gg: ASbGncvo3xmI7PZkv9QgwKMoy5QaCzYgR2cyQyuOHD6uuRgtXvXhl+QBDDNURdzmYhx
	H/IV1qhnN3bvHEdOmKVkHO9qr/fNy8c+hK2CWxYjqVkg2XY7Hl4jtJFPGxFwgbSLvQdz8APvXV+
	6j1kQyce23+iVHNYAWxe+tE0SqK2NSYtOuyS5nn5Ff7LGoReOtZH2IGB/83eo0/APuxzqGzxZV7
	nhQ7ytXJgo2B/JrgJQa6RzOwbAGkQFUYiXCMZAFY7wn/oKBGyDeokJ0KGV1YxSAtOHMMhaAGUC4
	D4q2i2fxdt9ngL9A1M0Y0vbDeguwA+bZsq9Hkt5DaSqdkLeQcv8cVmv4ffLsbELgvlu11sMkeOW
	mbSoy1RD+xtDkYrR3K088cpP7dJ9lm9ukDeAOPicuiGNKfpKlFsoXMWD9m5tldnSaVhU=
X-Google-Smtp-Source: AGHT+IE++qNRXBiBncRgnIXQY1GziFXTwGi/APCNRK270AtfnhaMl41kWTSkHeIknkyFSIhHul9yOw==
X-Received: by 2002:a17:903:37cf:b0:246:9a2c:7ecd with SMTP id d9443c01a7336-24944a9afe6mr259693895ad.29.1756993836464;
        Thu, 04 Sep 2025 06:50:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9952bccasm44979405ad.105.2025.09.04.06.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:50:35 -0700 (PDT)
Message-ID: <49bdcd0c-18ef-42ec-a71d-497bc6d6414d@rivosinc.com>
Date: Thu, 4 Sep 2025 15:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: Fix sparse warning in __get_user_error()
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
 <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/09/2025 20:53, Alexandre Ghiti wrote:
> We used to assign 0 to x without an appropriate cast which results in
> sparse complaining when x is a pointer:
> 
>>> block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL pointer
> 
> So fix this by casting 0 to the correct type of x.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508062321.gHv4kvuY-lkp@intel.com/
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 22e3f52a763d1c0350e8185225e4c99aac3fc549..551e7490737effb2c238e6a4db50293ece7c9df9 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -209,7 +209,7 @@ do {									\
>  		err = 0;						\
>  		break;							\
>  __gu_failed:								\
> -		x = 0;							\
> +		x = (__typeof__(x))0;					\
>  		err = -EFAULT;						\
>  } while (0)
>  
> 

Hi Alex,

I applied that and checked that the sparse warnings were fixed as well,
looks good to me.

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

