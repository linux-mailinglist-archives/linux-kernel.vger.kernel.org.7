Return-Path: <linux-kernel+bounces-829616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C5B9777C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5482E6D29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554B30AAC9;
	Tue, 23 Sep 2025 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eBDxt20/"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B920FAA4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658455; cv=none; b=c2hiCimVQhRS+tgIL1/6eFc/n0t4UkmmzPvhbClw79y3aLKBWi0HGN1UIo5GpBCqJOhEwPXs6DAL6BmPNW8FEBq/fCGAqwbC/tKymfbs30uK7QksTV4zZ6fSVjYF4PFHfDJbOhWlIhLKyEceVbnY/SYKwsDcfQUXmnNCDCmCkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658455; c=relaxed/simple;
	bh=WUWgT1tKOtwO2U4huao73bclXHiA0HGTUhpXKrPz5CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ+45WwDxA9d2rBHqytGSBeXZX0H+As9jfsOtkg451NKfwjM8JsJr/91HD2Yv62iCysBRp2bkrK8/DQp5X7wkVT67cslVYrICa2dhMeycetEl5LGZArrldyFwKN1qfMe+NfFwATI/uvHUsfm4zqX890/RLkorz0gSsf86E/OO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eBDxt20/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d5fb5e34cso3150877b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758658452; x=1759263252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwoI4wo9zLfkjndrTS8NOMixLRyHjpBjZZO1kBexomI=;
        b=eBDxt20/IqqV6n+C6IwtbQsnVKgKO/tDxCNAI1PFfeCjmWNWY39tNNrJV8RUhpJb4a
         SA5QesJPMK1EBAaNircGnpmEPhL19wLymCGiVqNaCaBZV2X/DSINlgQfNUkralystre0
         b9GflxFO9ZPFFX4wHDMb+jJSLC1uXyWU7GmADWGTnd3dKwkZmI2IP23CPGQ7IGYOHTJ0
         u474u7OQnTSUQ8W8ZVXmvRuVu/xxPUgMJjCrfaeSY180sop1GfUiliG0ph7OMfo9eXYX
         XQfX8m8EY9V0KpDFta9ISyDaR6PhCn0Sz//QcXXHrB4fC6b06yXxs6hLjHeH/s8HzRCn
         Ut+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658452; x=1759263252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwoI4wo9zLfkjndrTS8NOMixLRyHjpBjZZO1kBexomI=;
        b=lLE4XQAvubrSbnlqC7RwnWYKJgDV00k+cr2ltuWXeT7T85KGQBTek/raglqiO41mxp
         6Q6/xeopGpJplEGsQJNG61ksz64x0+93Yk21QwuiSYveBEwXQZFq86MuXDYDAoKfdgDN
         +66U3cNOtPeO8YOhTeroK4VoLkcjNBDeFRriicALhmPJbsfBBcWSPhQHG2QtkaQIrb+w
         EqhUNUTGLllr02K6NTdNXwmoHybRfdaFMHy3zTjL+g/lnRCKsOKrCds8GIb1PDd8CKEx
         sxkjJ4d4WVuCxcKCx9mSkOH0NONIMxlnUya9HOzHIXr/ZiUeut6/vOJUSH4cY9b6XHu9
         +2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7VQUzmmKwHyDfWf7luP/W5fNvNuJr18jsZgnMXlcWkc/sVQKyIC4hGLQw7WRzWX3Dmfq07TFvzYNMdsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7BYk8buAaROtQOHpdDo7M5PX/NkjUAB0saVdvH9kfX2FHHCv
	DutJitjnpw2xzLqFXVpoSX/pnaSwpwCq2X2CLqEhSfeAEq9fOtZSsaTB+5AcduxPewE=
X-Gm-Gg: ASbGncvK7XXIaMJvEjg2XW/jOS9j7GTkgx4epWw9qHICFZeRIB9+lGRxlLYG9gpGohU
	GIgpp2xT6p6NuHBSp7xi87D51K0krjMgH4eoh0W4sCyzV+1nu5wmzlmYx/saF8QBkLtHjFKClbc
	4AvH/6Rh4lR1gJrmFszLKMJiL2OLEEvqkYFRZ74i9PJAGACrdhcvhK3krQ2mIDc23Goe1CKwNLF
	tEmy106bl1M1EUgzCC4OMOX625Ley9E3h0b9s3aijfGCu6UPpfRZcQ6jdmGo8Izr3G7iEOaEhKm
	1ZlMUsx81ewbreOhtbN+T48SQRAg+PkWuGLaZ2Pw/RKkYQ8Sg2/fVRdDSPLJqQJn9TYkj48bki4
	0G3Lu48OzqFAWVvRm70IglQLz
X-Google-Smtp-Source: AGHT+IGeCZ6j6R+MpW8BlXjZwmHOp5b59quaQ2iQXSXVNma3YEpQ2jgmW2R4eikrimp7SLuMomVdnA==
X-Received: by 2002:a05:690c:490f:b0:729:5b86:551c with SMTP id 00721157ae682-7587a54ee84mr30284947b3.0.1758658452166;
        Tue, 23 Sep 2025 13:14:12 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73971887fe8sm43349297b3.50.2025.09.23.13.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:14:11 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:14:11 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: anup@brainfault.org, kvm-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, atishp@rivosinc.com
Subject: Re: [PATCH] riscv: Move user-visible sbi ext ids to uapi
Message-ID: <20250923-5498566fbd48a3dfd61ecd08@orel>
References: <20250917085246.1430354-1-xiangwencheng@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917085246.1430354-1-xiangwencheng@lanxincomputing.com>

On Wed, Sep 17, 2025 at 04:52:46PM +0800, BillXiang wrote:
> Move those sbi ext ids to uapi because they will be forwarded
> to user space by kvm.

We don't need to publish the IDs in UAPI since they are already known to
userspace by reading the SBI spec. Indeed QEMU already defines all of
these except for the experimental range.

What problem are you trying to solve?

Thanks,
drew

> 
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  arch/riscv/include/asm/sbi.h      | 16 +-----------
>  arch/riscv/include/uapi/asm/sbi.h | 43 +++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 15 deletions(-)
>  create mode 100644 arch/riscv/include/uapi/asm/sbi.h
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 341e74238aa0..e196feaabb2e 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -10,13 +10,12 @@
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
>  #include <linux/jump_label.h>
> +#include <uapi/asm/sbi.h>
>  
>  #ifdef CONFIG_RISCV_SBI
>  enum sbi_ext_id {
>  #ifdef CONFIG_RISCV_SBI_V01
>  	SBI_EXT_0_1_SET_TIMER = 0x0,
> -	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> -	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
>  	SBI_EXT_0_1_CLEAR_IPI = 0x3,
>  	SBI_EXT_0_1_SEND_IPI = 0x4,
>  	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> @@ -37,13 +36,6 @@ enum sbi_ext_id {
>  	SBI_EXT_NACL = 0x4E41434C,
>  	SBI_EXT_FWFT = 0x46574654,
>  
> -	/* Experimentals extensions must lie within this range */
> -	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> -	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
> -
> -	/* Vendor extensions must lie within this range */
> -	SBI_EXT_VENDOR_START = 0x09000000,
> -	SBI_EXT_VENDOR_END = 0x09FFFFFF,
>  };
>  
>  enum sbi_ext_base_fid {
> @@ -263,12 +255,6 @@ enum sbi_pmu_ctr_type {
>  #define SBI_PMU_STOP_FLAG_RESET BIT(0)
>  #define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
>  
> -enum sbi_ext_dbcn_fid {
> -	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> -	SBI_EXT_DBCN_CONSOLE_READ = 1,
> -	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
> -};
> -
>  /* SBI STA (steal-time accounting) extension */
>  enum sbi_ext_sta_fid {
>  	SBI_EXT_STA_STEAL_TIME_SET_SHMEM = 0,
> diff --git a/arch/riscv/include/uapi/asm/sbi.h b/arch/riscv/include/uapi/asm/sbi.h
> new file mode 100644
> index 000000000000..d29ac0abeefe
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/sbi.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2025 Lanxincomputing Corporation or its affiliates.
> + *
> + * Authors:
> + *     BillXiang <xiangwencheng@lanxincomputing.com>
> + */
> +
> +#ifndef _UAPI_ASM_RISCV_SBI_H
> +#define _UAPI_ASM_RISCV_SBI_H
> +
> +
> +enum SBI_EXT_ID {
> +	/*
> +	* The CONSOLE_GETCHAR/CONSOLE_PUTCHAR SBI calls cannot be
> +	* handled in kernel so they will be forwarded to userspace by kvm.
> +	*/
> +	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> +	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> +	/*
> +	* Both SBI experimental and vendor extensions are
> +	* unconditionally forwarded to userspace by kvm.
> +	*/
> +	/* Experimentals extensions must lie within this range */
> +	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> +	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
> +
> +	/* Vendor extensions must lie within this range */
> +	SBI_EXT_VENDOR_START = 0x09000000,
> +	SBI_EXT_VENDOR_END = 0x09FFFFFF,
> +};
> +
> +/*
> +* The SBI debug console functions are unconditionally
> +* forwarded to the userspace by kvm.
> +*/
> +enum sbi_ext_dbcn_fid {
> +	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> +	SBI_EXT_DBCN_CONSOLE_READ = 1,
> +	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
> +};
> +
> +#endif /* _UAPI_ASM_RISCV_SBI_H */
> \ No newline at end of file
> -- 
> 2.43.0

