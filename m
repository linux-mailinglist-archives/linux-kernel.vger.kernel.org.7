Return-Path: <linux-kernel+bounces-863829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE635BF9371
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300123AE241
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7D2BE05B;
	Tue, 21 Oct 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WbHJlTOQ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45F23AB8A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088906; cv=none; b=CzRJ1P+hsQDAFAABVUJxJFbSEFAKLWFBogA6wgjz276wfGJxxceovrzUFH4LMYLt2bWq/L/s4cvAjrsWhC2Q1CcAG34j4dAn4+BZ0uyF+DI7FMdGJ40yFPprhxqjB9ypsNd1dwGLIdKRGvY8T/uKJklhhLIX+UN0wxmatC2nOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088906; c=relaxed/simple;
	bh=u88KUCgo0Toso4SvWzwWeFAxYjLKdxDftme8WjUD5Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMcruNn5ZnLM/0+vd25O9rsnfHm9qx0+bF1ziNotCK26ye1E4dDKtWnKccwB5fEvKdmaYYCmoZyyN/SGmF9/qUW2BXCVjr3tjyOuyYfTMo/2Ty/JM9Ko6NEepazsmHF2CJC4WbRzG9AH5qKiWDxpXUM8vglYRbranOb8p/gCc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WbHJlTOQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3923217a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761088903; x=1761693703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/sG1jk/D7r3ClCgjL60On0j3McaW8ML4Lr1KS/4bzw=;
        b=WbHJlTOQlzMPpFWgKtRmBkrGvLFbFmp73UWY1zlxS2+ucRw1wmi0i/PS9DpEm5YJgh
         QXZjktYaJbuP9UpAERyJoq6aGVDT/53iJ8ZWwd8DVMz/rYG58L01Hye1UzvPOEVbYG7b
         MgwZ9kuLWPzPkKM60RGZx3ka3qJzRFc5NSO44LOXV6FXxAVohJtLK38NPLiLXWNDhv7S
         VvK/7cNEf2tP0zM+7p28UVpf2Z4211Q3JiRQrksWJmW031BAJGj8BP93lV02htcFqfv3
         5JcqtrIiYwWpkALk0KixtjMjEenbHH08CifgwVTEPDq4sJybYKVFM/7fraIIbK6ej8gb
         kz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761088903; x=1761693703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/sG1jk/D7r3ClCgjL60On0j3McaW8ML4Lr1KS/4bzw=;
        b=h65scBChbVwDV512BjEVA6y2vV2r72p98sw4pvWvHXTM3ZJl0tHAsFNjQ2dMMQXNvg
         N37N/wrlduwiwYyTuDjjoKvzSF00GSHJ+8Ndhp3qG/vx8zk4hyUZk1r4ICx9cQmoM8kC
         QZM5/nPEHZGtDO1Kudh4EkHoOLkbohFOQ346fowHZHveh5Xlm6Gg2dr18UKKU6t+lsdj
         wWEW3ur2/afV8fyQVQKUdQxGkvQD91IK5f2XmsiBJF8uuerYQlBR79bLjhCP62P7qsUu
         NkJkYxPL+TN3meF2aiVk0Gj1uZWtrQtg3Zxuj10OLntz8SdRsX8AgDOT66X55/lF9r3+
         fJiw==
X-Forwarded-Encrypted: i=1; AJvYcCVeT8TRQDt5KRiVU7wXW4k5h8gPeFUocgLUy8CyemingjApX8rqPgcSDCrHdoLXNg6ThRW5zkfKkbtC6Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9PQChJkFjvzOtGt6Sg+aO7FOoaSK1vSXD5gGSOQ6qbWiaWCU
	s5RlvHAQKEQHVJK/vbj1KsfsF2qa/ZT9cQrO67484iBA2UWBMS5P73oP0rjh7orSzpc=
X-Gm-Gg: ASbGncso0pW7ZW8pB3kezY6Kwgg/hmxgbtoSvcaa3OpzpzKhEqcI8O+j+Sl+7XMoyln
	1WRy/vkwSpgSJThcHax+Al9hQUzkZ/uh7StMnajnldmzxqLPQXTRX5HQLXLUh8+gB+zrTltPY5n
	A51SS+oN5QPhagdydjhEEO/Lily6d1HG7HMd144AlOGWydmAAmlQLXn9dwCVig2LAkyxW0vdHCu
	lEbPN2rkVRdgl1UQCsZ+IsfiJq0nhE633cTELkQyWbeqR1GnRLg5o6zYGnUJg/NjTvQsy52tzMZ
	LMtTCkVeHFfIl6/FbojcYmyBnkB/2rRU/60PTbBFtp4EcA9If3/gSBtqOoslhUnIZBSmvPUmBCi
	fpapyEfqjxOywQ7pCgrwsO6jtr1Sx6GlS09I1doANyuaKThGALiVe/lqNsVHZfo635gZNrakWGj
	FI7OhFGM/k56ek
X-Google-Smtp-Source: AGHT+IE6NQoNLTk3Nz7GLQHnJMwF2PBGrN0ifVkPryTJs6MYiO3iNqHLbbOvp74DNY+7bQCnliJ3OA==
X-Received: by 2002:a17:902:ecc6:b0:290:7e29:f59f with SMTP id d9443c01a7336-290c9cf34f1mr242661745ad.27.1761088903517;
        Tue, 21 Oct 2025 16:21:43 -0700 (PDT)
Received: from localhost ([208.115.86.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a359sm662800a91.12.2025.10.21.16.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:21:43 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:21:42 -0700
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu, 
	cleger@rivosinc.com, evan@rivosinc.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org, samuel.holland@sifive.com, 
	shuah@kernel.org, zhangyin2018@iscas.ac.cn, zihongyao@outlook.com
Subject: Re: [PATCH v3 1/2] riscv: hwprobe: Expose Zicbop extension and its
 block size
Message-ID: <20251021-be53f84c246523b7c4e31917@orel>
References: <20251020152924.64551-1-zihong.plct@isrc.iscas.ac.cn>
 <20251020153309.68267-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020153309.68267-1-zihong.plct@isrc.iscas.ac.cn>

On Mon, Oct 20, 2025 at 11:33:08PM +0800, Yao Zihong wrote:
> - Add `RISCV_HWPROBE_EXT_ZICBOP` to report the presence of the
>   Zicbop extension.
> - Add `RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE` to expose the block
>   size (in bytes) when Zicbop is supported.
> - Update hwprobe.rst to document the new extension bit and block
>   size key, following the existing Zicbom/Zicboz style.
> 
> Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 8 +++++++-
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 2f449c9b15bd..52f12af43b9d 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -275,6 +275,9 @@ The following keys are defined:
>         ratified in commit 49f49c842ff9 ("Update to Rafified state") of
>         riscv-zabha.
>  
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOP`: The Zicbop extension is supported, as
> +       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
>       :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
>       mistakenly classified as a bitmask rather than a value.
> @@ -369,4 +372,7 @@ The following keys are defined:
>  
>      * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFWMACCQQQ`: The Xsfvfwmaccqqq
>          vendor extension is supported in version 1.0 of Matrix Multiply Accumulate
> -	Instruction Extensions Specification.
> \ No newline at end of file
> +	Instruction Extensions Specification.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE`: An unsigned int which
> +  represents the size of the Zicbop block in bytes.
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
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 000f4451a9d8..7a6ae1327504 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -113,6 +113,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  		EXT_KEY(ZCB);
>  		EXT_KEY(ZCMOP);
>  		EXT_KEY(ZICBOM);
> +		EXT_KEY(ZICBOP);
>  		EXT_KEY(ZICBOZ);
>  		EXT_KEY(ZICNTR);
>  		EXT_KEY(ZICOND);
> @@ -293,6 +294,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
>  			pair->value = riscv_cbom_block_size;
>  		break;
> +	case RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE:
> +		pair->value = 0;
> +		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOP))
> +			pair->value = riscv_cbop_block_size;
> +		break;
>  	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
>  		pair->value = user_max_virt_addr();
>  		break;
> -- 
> 2.47.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

