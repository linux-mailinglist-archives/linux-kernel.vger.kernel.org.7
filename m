Return-Path: <linux-kernel+bounces-778045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11881B2E0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DA1AA010F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50A334717;
	Wed, 20 Aug 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYYnC95Z"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08E322746
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702276; cv=none; b=bWnYdVuS7ZRaW9F/BzpsgA6UCqjSBk/4oBvftUbkcJjS9SXqIhcKQfb6d6ELOTJPFrcwZVA0O09UEfAvYd4rjdfP+0X8vmwiFa9uJYOrcDIbWNxhUBfgJw/JBNPEqthwhdTm77cWX4LILSCXvbhXnu3ewmd2cunu64taGHVWvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702276; c=relaxed/simple;
	bh=tb1q0p61kk4ggtfW+I2HjxsfCAKSB23I9pUdrtecWhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ/d+0d029B1+SUaX/Wj61E1JyhlSiNHuUFxQqIqnS7UH5LItjUAzNHdvSQ/40DpY/NbY10IuiWFZwO8P+Vf1UQ1tLGbJTvTy9KFfXRKBAN0vPwL3Iidv2E4imhgtLhDJhwB2Y08XKn/sT5HcH/UwEPpad9xGAtBCRNzHgR9IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYYnC95Z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445811e19dso53114705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755702274; x=1756307074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++r0iAI2yCp7ByMWBTkoq4eZJInhcfQbLd7c4fa729Y=;
        b=kYYnC95Zl9vfSncYR4QXrYXo6Ala70ZicCFFNZNyrWcjG6LA+vsXBicOaN2m7Yrj+Y
         P9dFNK2KmdAd+y8gEWlxF7S4jKQVfv5umGCoDiu2Jwyv+ijlhawacuVXpC31kEV1HLLT
         TR03gbqD6FL2Bh++z0rOprkdjmmneO7lc6kqvOte/g9ZW1ZDqkQED0L0+p/S2i4YZqaR
         dEpsOMl4h0PqN6CjM/IfxkgtlbJ8HxC/1S883jN+Of2mFCGrd7fdCN1IQzyQy1eOZsUm
         re4FmimHxqT2NEB7b2hzIc/VE3WtZRQWeOk4nzQ3X8aE/nNjT6SRbA0WyVXYNy5zM2bE
         giRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702274; x=1756307074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++r0iAI2yCp7ByMWBTkoq4eZJInhcfQbLd7c4fa729Y=;
        b=ptn+UNTwL03pJcRyGBSWOcAL/dnsC076MO5DZbPWKwLyQaysDmPktYGX5HYou8r5K8
         Hd7RliLhlmF2FezwKfDUo2uhOMDsO1lFH5kDpi1BZqgJSNRmvv+wdwqfIlv8aJwxY1YN
         PP4k0aSdOyqUdkUw3JvL3AfpYEPWyLt1PvJ5MYBjPoX3buOv4oMdl3BvWKIxqf5UALYy
         8khTyNAgIqtKLkiTL53q5dhZ+Td9VvBjG1emVypwXxsasTnfOYt2+djAFYrPR2cq7DQa
         f+J1mPIBUHCnMO4/eXdoDpQLCFPl+7/vdCpyki/94OOqvjpp8W3HDfqF3OrecRaARYGI
         r1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbUnt4yUCFgQi5FDGTWFQuHq+tGkAq3bzEtFV1KQ3nZIrrS5Lif95q2R5KUqXux8QjBqvZIWBrT0sV77o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+Zn76M64FLMa77o78g/EppnfAVolRqpkZbi3/7W1tidwFfha
	I9NzCTwlLPJ1TqsHNcv47yWvk55i1mDye4WDdjfiVLWB0F9cGYvxV5AL
X-Gm-Gg: ASbGncsrrhQDbuNUqG2pa1d1+xL8EmMxRm+g54Iw61gjNsx6GipVrx8hGek/zvifghr
	qWu2/7XAe7N9QDGQHPxADNjvAuMp0Em1WWjWmRUEqQGK/qaAK5guWYNvG7ILp6VaTWcr8XR/Oe1
	oWJGOLQVGpH9vSWxcXRekMVJ0XJ83RO3Qxbwi6hV6+7+MTdVp0n+zYzhmL/YdcOIYPIhGq4kcB6
	gh7sNrpb0nrQR2x9vpF3U3nQH5HfhkYYgkpDYLyvSMmCOJm0PoHNIar/g+XiCGDFO1xdGTEs9C7
	EwLJZIcP97GKSu6e3gqsxXEMw8Tloupqi0aKoStHzpkqZHLoJIoUv84OxKVYNLIRfT4lPbB/aks
	NfFNsIp/FVt4nHWq8fy9reQ==
X-Google-Smtp-Source: AGHT+IG5GibFX4nRPe3uAIyd9oVrLLUMsOnz3s+oCgefLCLc1FqEY0SeoiyMrK+0hu5OLASgGFtLgg==
X-Received: by 2002:a17:903:1b6e:b0:245:fc41:eb53 with SMTP id d9443c01a7336-245fc41ecefmr466235ad.30.1755702274208;
        Wed, 20 Aug 2025 08:04:34 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53eb8bsm29017525ad.166.2025.08.20.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:04:33 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:04:31 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vivian Wang <uwu@dram.page>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] riscv: bitops: Convert to use_alternative_likely
Message-ID: <aKXj_zTwvk0SwUpV@yury>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
 <20250820-riscv-altn-helper-wip-v1-5-c3c626c1f7e6@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-5-c3c626c1f7e6@iscas.ac.cn>

On Wed, Aug 20, 2025 at 09:44:49PM +0800, Vivian Wang wrote:
> Use use_alternative_likely() to check for RISCV_ISA_EXT_ZBB, replacing
> the use of asm goto with ALTERNATIVE.
> 
> The "likely" variant is used to match the behavior of the original
> implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/bitops.h | 112 ++++++++++++++++++----------------------
>  1 file changed, 50 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index d59310f74c2ba70caeb7b9b0e9221882117583f5..0257d547a96293909d90b017c8a48b508d0fd642 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -47,20 +47,17 @@
>  
>  static __always_inline unsigned long variable__ffs(unsigned long word)
>  {
> -	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> -				      RISCV_ISA_EXT_ZBB, 1)
> -			  : : : : legacy);
> -
> -	asm volatile (".option push\n"
> -		      ".option arch,+zbb\n"
> -		      "ctz %0, %1\n"
> -		      ".option pop\n"
> -		      : "=r" (word) : "r" (word) :);
> -
> -	return word;
> -
> -legacy:
> -	return generic___ffs(word);
> +	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {

I don't think that 'likely' is used properly here. The likely/unlikely
wording has a meaning of a hint to the compiler:

        if (unlikely(WARN_ON(cond))
                goto err;

In your case, it's just meaningless, because whatever is 'likely' for
one CPU, will be always 'unlikely' for another. 


> +		asm volatile (".option push\n"
> +			      ".option arch,+zbb\n"
> +			      "ctz %0, %1\n"
> +			      ".option pop\n"
> +			      : "=r" (word) : "r" (word) :);
> +
> +		return word;
> +	} else {
> +		return generic___ffs(word);
> +	}
>  }

This tabs wipe most of the history. Can you reorganize your patch
such that it preserves as much history as you can?

        if (use_alternative_unlikely(...))
                return generic___ffs();

        asm volatile (".option push\n"
                      ".option arch,+zbb\n"
                      "ctz %0, %1\n"
                      ".option pop\n"
                      : "=r" (word) : "r" (word) :);

        return word;

And so on.

Thanks,
Yury

