Return-Path: <linux-kernel+bounces-847241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2FCBCA562
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 591604F16CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6C23A9BE;
	Thu,  9 Oct 2025 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CJCe8OXt"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F91632DD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029726; cv=none; b=mIVmNe6MnW58EUtRp+VIJXZGDXe39s0aQk91HeGQ8YktbXqiXTMO1hWtR/98FSq++zqwiuBH/cek402o989Es0Syz44/bwHC7wq0MrjAdPZyYfyLSTRXCMeDPZqbdK2yLIh7AulIJE+13m5g5+QExY07WO1dGt0ldMic1iJrL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029726; c=relaxed/simple;
	bh=M+RAuLfo/tBmntdVxoq32ugbitGYK7EIaTl/YNjZJIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRht33J++3qKX9CSgu0Vp8P9XcW+2x/nvsz/0umMU9m25sGPsply52m1ya1P8yfCntOsbv8K/16BYft9ZCJSNOWEnRb9ifsZZwFyjYMwNpg3cTY378nKSAxNGThLWTr2xopY24dUwC/Sv5Z3u+jdHLW5ofK2T1tbkEbB3Ll66nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CJCe8OXt; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so101887639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760029724; x=1760634524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmQS8Iz7W21RMhGArp3InWF9uo5uNulwnzG/3ZoVxUQ=;
        b=CJCe8OXt+k+Rg6LoybIbHMs3oA8PfaabnxcrhvL+fsnK0m3tOJ60N4zjljnjNaLA7m
         z8rUQL870Ch/9PEogSL4cdRv5EKgp0m/9gudFCJ+GkwCXlAYLYoNi2Dkfcg+STDQrmjF
         ag4FKpM59HOSnOQCWvEBPRWQtXpXci+FTuxks2DFY2t0RQCUhNFz9wwLGL3zKnvF80KU
         TtwSq/CFbxUrI+kFQSEEeUUrZx3zQsnsQXOFkyvbmeNG96K+VNPvGpizl8p2fBG3otdc
         eQkxti8s4PLmwuXS2/vY2ZxbuEPSS0KEQuueymAwS42JtAAVfW8SGETd2WUr7qaEkC+7
         K5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029724; x=1760634524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmQS8Iz7W21RMhGArp3InWF9uo5uNulwnzG/3ZoVxUQ=;
        b=raH+tXGxj2Nweico1AhF9nmR65aDuSlnF5MXwIXDC9UQiKzo9LdBJxSYCPPYAxElSo
         XvECed4oSlnd/h4gMmxocfHLoT2lcNuRQLlEju5IUEZGcr0yGreqVjPCacsMQ3TorUGX
         oM0O1Nf1Acb2Mi3TeOJHL2IhAiUqqUGZBm+R0+sAZwahAN0ComOo69Q0FtoKCMH5PUaO
         oYVNK/p/knS6EDPdB+EEinY3gOhAhN3EFxiiixdemoDNJ8XZTIdPm11lnO4vSS/sit65
         L0IGMBByhFtXrF0dnVZAsgkAPKsaaR1i3Z1qWU79CxXZPyQJNfhO7bYgQCTdakl/b39w
         wh3g==
X-Forwarded-Encrypted: i=1; AJvYcCWIienQsJiFYrxwLUpcYIO16gmhw/y+UKsl7bwGGJ0hTzoKtctOr/wQtBHIx5Bjo8ZToW497cDZCsIn9nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPyqFnd7ign1eLrWvASUzSXcYdVQcBNcNtmMDfbPStkr/DyRE
	PqPnpbV6vLYN3Odl+cmu9y25oUqZlqghT5sSzfUOkfXQxduec6I5PhwgRI7wYjy7udM=
X-Gm-Gg: ASbGncuIfnokafRPHsuiHc5rJ6lS5mFjo5R+y688YQ/lTqu1J/0M7cBdrntHAY0gM4q
	ljrHrUzE7kaBfxtVOqqteVCY83iMRdTj22TWUe8fpEXSYnf6fFwZ3kiiJcx6jT953iPtAa3OsG8
	gYN7RJaHqTIjsBOOeOu1PeHM8ZY39I35qjQl85caAnVsTzrVLcnmPbqBEZVat6RfZ2qk/Yzie9L
	R9akKypIdSwtKsbvmjQt0cpVRijT+FvFMeBdBb65QvDV/nDk+iHLYa7MOH/7Pl5loEwtTJ6PLwG
	F4EFEgCNwIrWsTTh0HllnBRuwsK1C0AvtBxDBIVcyVBGFwOqdJJomJrQlxTh3O5cnbuvhEVtCNa
	V81xLfoVZDucooSqcXwHQuU/V6DnsYe9yKlUHVP2oN7rsOdLr
X-Google-Smtp-Source: AGHT+IE9RiX0BHPrkOFXb9sFvQpft+J/Jdlyf2+rREXxjwowAkoIYFM2VcvYkhOtjlgnBzw8lgQmzg==
X-Received: by 2002:a05:6e02:164f:b0:425:94f5:5e3 with SMTP id e9e14a558f8ab-42f87472b21mr80940885ab.10.1760029724047;
        Thu, 09 Oct 2025 10:08:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90278721sm11974895ab.9.2025.10.09.10.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:08:43 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:08:42 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alexghiti@rivosinc.com, shuah@kernel.org, samuel.holland@sifive.com, evan@rivosinc.com, 
	cleger@rivosinc.com, zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Charlie Jenkins <charlie@rivosinc.com>, Cyan Yang <cyan.yang@sifive.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, 
	Jesse Taube <jesse@rivosinc.com>, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH v2 1/4] uapi: riscv: hwprobe: Add Zicbop extension bit
 and block-size key
Message-ID: <20251009-368359384e19820a18cea601@orel>
References: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
 <20251009134318.23040-2-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009134318.23040-2-zihong.plct@isrc.iscas.ac.cn>

On Thu, Oct 09, 2025 at 09:41:51PM +0800, Yao Zihong wrote:
> Introduce RISCV_HWPROBE_EXT_ZICBOP to report presence of the Zicbop
> extension through hwprobe, and add RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE
> to expose the block size (in bytes) when Zicbop is supported.
> 
> Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
> ---
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 948d2b34e94e..2f278c395af9 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>  
>  #include <uapi/asm/hwprobe.h>
>  
> -#define RISCV_HWPROBE_MAX_KEY 14
> +#define RISCV_HWPROBE_MAX_KEY 15
>  
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 5d30a4fae37a..9cc508be54c5 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -82,6 +82,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
>  #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
>  #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
> +#define		RISCV_HWPROBE_EXT_ZICBOP	(1ULL << 59)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> @@ -107,6 +108,7 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE	12
>  #define RISCV_HWPROBE_KEY_VENDOR_EXT_SIFIVE_0	13
>  #define RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0	14
> +#define RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE	15
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> -- 
> 2.47.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

