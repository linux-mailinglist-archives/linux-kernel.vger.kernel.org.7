Return-Path: <linux-kernel+bounces-808742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F716B50442
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88FD18848EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0331D378;
	Tue,  9 Sep 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iKyeMhFC"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686447F4A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437986; cv=none; b=DF+v3f0bu2RMI5oweQa9vlHTc0W+BuPl7KC9kR3/mR3Wb0ONIfKXwC1vtq3kv/iO3bDFtqWG6u0JA+YljRYP5p/69HD8iIDj07fj+eynhf205IQJbh1R/Au5f4CxFZEkTuBA0R4mX4p9r/nsLxv/40l2nQiaixb1890ZxtwVQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437986; c=relaxed/simple;
	bh=gNg8AqfR0tciB3ysEt43D3UHmeklQnCdJd6jEFYWjjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqDJ49JXCNRZO1qVfrEpKKuwJgwgytQdXFrPfuHPRg7hTUfiCBGVevEFack/0PJOzQksv04sW4o9EFhzNgpUZHLH0fzmuskSDlhjdaOJAWbIVxtEzinBzETO9r74uaxBld4iBoMNlsUIiFDkz1IJ8Toh7JO/576DViIK9ZeqFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iKyeMhFC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-889b846c568so223357239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757437984; x=1758042784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLUjg7yNG/ewQNg8kcK05UeNpGcVlJZKIKA/TtV5FkM=;
        b=iKyeMhFCx5QyLzib+c0UcMUyy3ci9O35rqkX52CzGjFLcIRPpbnuvQXbSdV0ae+gLG
         nLWhgFjuBZNPiZF6inrxX+CA+RE5ewT/7KGB1YJeNcSPdVyMZ4BsTexmnZpuaw5ArUPQ
         +yLJMvEke0l3vTxAgt+J7NsamHsH5C3EFtyR9nNEu+0dQzh+xve2E23EGLFXWlQs9TNa
         v70afC1HZI7RnAxRoPw1YBz3Ub0ZTp5+p/XHLcuqRisZeHMnj/1gc8ZrwrHb3X+NFgrE
         CgB13cmOAYjtXJHwpKzhG0JKdbTRDlCTeaJex9BNtegCWuVNOD0sTu95MJvJRqZBAH+p
         HqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437984; x=1758042784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLUjg7yNG/ewQNg8kcK05UeNpGcVlJZKIKA/TtV5FkM=;
        b=vmWOZmnRQDQqAee35GKV1yZWbKrpUT3snfk2JwWsudDuVavdzOwlzFE99JldKvbwUd
         yZ9C9QuM3SDykoQXcXHza14bjhu9qQF2zABFjdxqnAY/jGMk4i0UNCZsopaold2s3Ffc
         Xp908a3u78wZO8lg54V1hyqZ+VTNJzBDeOhLur8EwY379vur/s7HEKeIbH+BYibxsTrJ
         G0IAjzOT7eT+ty0ih29Y1sW/VEJZLKCRJq66qH+XRPuYGq8k4BYrxwrtezNRgzZYjoVr
         HVl000LJk6oMUK5MGdh+RqHRBYZMgnIiVgwUrWZUt4cs9cOEAUGWzwQ7mH1SJUN8mIvS
         dG+w==
X-Forwarded-Encrypted: i=1; AJvYcCVPnAPgSTsyvEh7yibXHrRzhR5Memxkrg3cZIbSsb/R17SBocQNH5B1/ttHPmIJK4wlztNg2TMS1uTG0c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyoqOdpaisgfzXRbLEhVv2PtZtW/NYYCfFYk1tjOeqvhACiMq
	1Qg12nRrUDwwF7Jf0ft04yVUFNsRJKWnpKC3FGVERtEnxV3xhT7/deERScmHNoexHew=
X-Gm-Gg: ASbGncsdnleI7ETUQbgrc7DS9Qbo7efwrCIg7JqXhNI7QqLUEZNtQk4rJ03tQWjmPiU
	u8BlvBNrVUV9XGbo7blRhmV8WE2Gc3OIxkzPGJlbZEzzJVBoqoTW7c9DYRja/0u44WsgqKJj0ur
	OoYXqKUK9xz5b+y8CI1rrZYQhpSA8AaEgE3r5md8NfHrU37gEoP9FPbAmbbgx3bcZ+sHQNRjfm8
	W8wvjpa8cHmA7jG1KBfldoY1eNyqddOYfuwHk56Ik/x1iXCKo0D/Li4TDbMfxJlTcrVx760RPws
	xt1XtV68PPh2o1K6Is3ASn7fSlK2WbvgUlYDfjf2pd8mAFYYW/sVa31oLxqPYo8x5FeDPbWqv3S
	RR9+yhrWhCLx3hE8ejFfXVMolVoercAy4vCk=
X-Google-Smtp-Source: AGHT+IEMFpaj8bMLzDHV4JtX7+vWxYaXCZCBKZ479bbfT1RoejNAOJVpK28JUe1NbmGtyLq/mXgp8A==
X-Received: by 2002:a05:6e02:1a0c:b0:40a:e839:a2e4 with SMTP id e9e14a558f8ab-40ae839a49bmr96540285ab.30.1757437980965;
        Tue, 09 Sep 2025 10:13:00 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5104c5a4d0dsm5507495173.0.2025.09.09.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:13:00 -0700 (PDT)
Date: Tue, 9 Sep 2025 12:12:59 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V10 3/5] riscv: Add RISC-V Svrsw60t59b extension support
Message-ID: <20250909-2130daabd7f57a8a357c677f@orel>
References: <20250909095611.803898-1-zhangchunyan@iscas.ac.cn>
 <20250909095611.803898-4-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909095611.803898-4-zhangchunyan@iscas.ac.cn>

On Tue, Sep 09, 2025 at 05:56:09PM +0800, Chunyan Zhang wrote:
> The Svrsw60t59b extension allows to free the PTE reserved bits 60
> and 59 for software to use.
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig             | 14 ++++++++++++++
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpufeature.c |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a4b233a0659e..d99df67cc7a4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -862,6 +862,20 @@ config RISCV_ISA_ZICBOP
>  
>  	  If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_SVRSW60T59B
> +	bool "Svrsw60t59b extension support for using PTE bits 60 and 59"
> +	depends on MMU && 64BIT
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	  Adds support to dynamically detect the presence of the Svrsw60t59b
> +	  extension and enable its usage.
> +
> +	  The Svrsw60t59b extension allows to free the PTE reserved bits 60
> +	  and 59 for software to use.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>  	def_bool y
>  	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index affd63e11b0a..f98fcb5c17d5 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -106,6 +106,7 @@
>  #define RISCV_ISA_EXT_ZAAMO		97
>  #define RISCV_ISA_EXT_ZALRSC		98
>  #define RISCV_ISA_EXT_ZICBOP		99
> +#define RISCV_ISA_EXT_SVRSW60T59B	100
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 743d53415572..de29562096ff 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -540,6 +540,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
> +	__RISCV_ISA_EXT_DATA(svrsw60t59b, RISCV_ISA_EXT_SVRSW60T59B),

svrsw60t59b should come before svvptc. See the ordering rule comment at
the top of the array.

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

>  };
>  
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

