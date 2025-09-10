Return-Path: <linux-kernel+bounces-810533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51592B51BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EF51C2549F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10E26F2B0;
	Wed, 10 Sep 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unnrdlyx"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70D2261B81
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518768; cv=none; b=aO+VXBejh5SLSqRRVB8ydWPUN3PBB4brhhsEGZVLOGtU9FZohjegT+zoVJyRoDYkjMtztnLMdy5EZnuMqI4bpzGu8ZnJ8U/XLYOoraxyhoY8tjV5iKvLhr+xeXEb2yhBwg86cZGBwlUz/DQEFHV2pzdGb0PRyAzt0CqB2sZpco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518768; c=relaxed/simple;
	bh=t0BBx4j77k/r4wLzkQ6QdpJr9i23fY5IO7mYzhTBa90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNZhlvxsKPUerrI1ZTHxauhIqrDunCsqXBMoxeFDUNn8ch1MeAM5WsnVfvlbAVVpJciBPPN1pl+RScqtJgW+DMcgJJH9/BHJmZnaXjnOARq8nB0iXEj47bNBw6RP0oieop5lJbV8pGl06jU3anttsyIDRW+C1CHL0d6mopvb6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unnrdlyx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77269d19280so6484302b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518766; x=1758123566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNIzyizj71N4TrhGzRu7v49ragUENadc6/+UUtmHAZ0=;
        b=UnnrdlyxE+H4xYGT5xF42bovdyaiHT1WHyAklmolaBvV1t1q6X00IDU4N4PPS7EPDq
         4nlcOXiGJe4Jgn9HuxvMTKaiNyk+JWUrC2qCsrGvh3a7LCA+6h5jEtZo9BcWMm9iwJuJ
         72yiV2I9lUv73C9RuR7051ZE2X2NmfD5Yl+rX9vYXndAb6NioLEfIWufhmBsjbabhrIF
         Ym5FoEZ9tGtwvQRFVbgcfE10z+uEhJnVaL5VDoKKnyp+QEXqO+GzdaggPZeXzfvjHqlc
         Nc+3/IgBvMQw3RU89SEiNuJfgfERfbRkxV6SRhtenlLpcwjfYO7QUhMyQyLJ7FIE+Vde
         JWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518766; x=1758123566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNIzyizj71N4TrhGzRu7v49ragUENadc6/+UUtmHAZ0=;
        b=e3Sb7O3A1dG/62OcYreG/wsLLHHLwNjiy5LG3Bwkgjxt1qmv4BncDDkyWoDTspjZLT
         8vAU0qHLtQoTt+6j+1HEUUrIcPz/lrmWiL44VhCLnlp26lllIn1oSwO2hWqyZ/PsQLLF
         X6NuLrp68t9WTS4IrBaKK/Pb4BzzaQ+ARnX26AfhLqg5TNu98JSZmk3VhWmbSGfUs79k
         +z7y3/ce12onggUpXR06M4i5BELVAA9MjlNHncqCFa6ziWZpN6dfdmM8vPSPskI82cso
         QSTY0DtLwIX9sYGuhY4SIeqnpkaMMNM81OTvgrrcSDrUBoIZgGtzjPJ6exTCv9wz5ozX
         AE9w==
X-Forwarded-Encrypted: i=1; AJvYcCV618VOfpR+L+6kkLJioQGX1H5HEe/S8okpiUkP823/8+0FIc+cN5dmm3DYHSWqczpYSMQXBY49tOiVIN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+z2p23EZ068urLilBXXjBw5t6IWsEPn8Ss2a79MVEnJFSU7t
	IxlMnN7+XnpoqoBzgRa8xr4qjarlFPKs9Fq4N7hlO+/BMYm1SrqyaJ5i
X-Gm-Gg: ASbGnctFPKHEf2N3fWSvSRZ/LKtJQ1RUkaz5ttCzeSkeJA/LdSIUJ1qxZOKAOY2pFn5
	9rN6+fi7ZTzUsDkuPnA2a4euPz8PVBWQTbvKORZiJLISjnoOPFMEmHd/zP8FGc2B2pZaWD//I7k
	FA2kyznspuqchQ0cbntkRTJMo9ekotnIRKZ8DZqw+qnG3U1NJOUolNfV1QYF3/6JzDlb2jN9Bhk
	5ibBnNjfnLWTAuCWpCaTP4QX+pjRjhHCTZ12AO0LKGD/7xLVaBQ4W/a2ohBimafJAeANf7fKb5G
	44YbSxO48VYmyYmw7W0TVMBVt028Za9ga+FOx3N6Gjsy71h/YPYT1WeB9FyYXCm3abug3CnFrKz
	jYzvtVXQPUvVCXdFPjlkQ1mRIrojgIiy8
X-Google-Smtp-Source: AGHT+IEOlqvObZUV3RxQzGGSxEugu+hq9OMCc5zjg0K2fS2Pjf8AZXtTPPCGB5s7XnoH5Swvb30hIg==
X-Received: by 2002:a05:6a20:3d19:b0:24d:b11b:e908 with SMTP id adf61e73a8af0-2533e9504f9mr23346063637.11.1757518765905;
        Wed, 10 Sep 2025 08:39:25 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab590277sm2085577a91.8.2025.09.10.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:39:25 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:39:23 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mary Strodl <mstrodl@csh.rit.edu>, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] m68k: bitops: Fix find_*_bit() signatures
Message-ID: <aMGbq2h1ElzsDrCR@yury>
References: <de6919554fbb4cd1427155c6bafbac8a9df822c8.1757517135.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6919554fbb4cd1427155c6bafbac8a9df822c8.1757517135.git.geert@linux-m68k.org>

On Wed, Sep 10, 2025 at 05:16:13PM +0200, Geert Uytterhoeven wrote:
> The function signatures of the m68k-optimized implementations of the
> find_{first,next}_{,zero_}bit() helpers do not match the generic
> variants.
> 
> Fix this by changing all non-pointer inputs and outputs to "unsigned
> long", and updating a few local variables.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509092305.ncd9mzaZ-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> ---
> To be queued in the m68k tree for v6.18.
> 
>  arch/m68k/include/asm/bitops.h | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index 139ec9289ff2d324..e9639e48c6c3c1da 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -350,12 +350,12 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
>  #include <asm-generic/bitops/ffz.h>
>  #else
>  
> -static inline int find_first_zero_bit(const unsigned long *vaddr,
> -				      unsigned size)
> +static inline unsigned long find_first_zero_bit(const unsigned long *vaddr,
> +						unsigned long size)
>  {
>  	const unsigned long *p = vaddr;
> -	int res = 32;
> -	unsigned int words;
> +	unsigned long res = 32;
> +	unsigned long words;
>  	unsigned long num;
>  
>  	if (!size)
> @@ -376,8 +376,9 @@ static inline int find_first_zero_bit(const unsigned long *vaddr,
>  }
>  #define find_first_zero_bit find_first_zero_bit
>  
> -static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
> -				     int offset)
> +static inline unsigned long find_next_zero_bit(const unsigned long *vaddr,
> +					       unsigned long size,
> +					       unsigned long offset)
>  {
>  	const unsigned long *p = vaddr + (offset >> 5);
>  	int bit = offset & 31UL, res;
> @@ -406,11 +407,12 @@ static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
>  }
>  #define find_next_zero_bit find_next_zero_bit
>  
> -static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
> +static inline unsigned long find_first_bit(const unsigned long *vaddr,
> +					   unsigned long size)
>  {
>  	const unsigned long *p = vaddr;
> -	int res = 32;
> -	unsigned int words;
> +	unsigned long res = 32;
> +	unsigned long words;
>  	unsigned long num;
>  
>  	if (!size)
> @@ -431,8 +433,9 @@ static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
>  }
>  #define find_first_bit find_first_bit
>  
> -static inline int find_next_bit(const unsigned long *vaddr, int size,
> -				int offset)
> +static inline unsigned long find_next_bit(const unsigned long *vaddr,
> +					  unsigned long size,
> +					  unsigned long offset)
>  {
>  	const unsigned long *p = vaddr + (offset >> 5);
>  	int bit = offset & 31UL, res;
> -- 
> 2.43.0

