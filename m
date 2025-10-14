Return-Path: <linux-kernel+bounces-853169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF06BDAD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51651925B81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1873002DB;
	Tue, 14 Oct 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HvndNs/G"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAB230D35
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464215; cv=none; b=rovBZcBJWthBZ+uVTtXOphfZ53RkODuOBhXzpa+IgTOcIUfXRKKu77/hUjnzZdMmnvP6v8LMUlumtEqEOmpWKP9Wfe4xIDSmIws/PdTDyBIJe2skjoZwG7DK18cm04Nz3b6ihaLGW6d190IIA9rU3gFY63inhF7J/lpDzoWz+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464215; c=relaxed/simple;
	bh=NbAUMswbIdDDQffAtmMTy9pVSnMavWHNhtcfzeLgDF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QslADXQulnD42lCj6gd0sY+Rw2eNm8YCZc+xhC3DNuwZI8r5lL1DnK8rf6+q2ilcEE3M5VijVmEz04BtaVfv4bcV0XWN2fXTfSurh8Lc5TtODdFZOBmgFkhXsy1HGwwZkwM7L237IOqPiLYxS0MbkQOU1gvB34YQPgE/aAWNFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HvndNs/G; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781206cce18so146249b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760464213; x=1761069013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2QNuMvMJ8hOs9o9vuGhQfun+FldhTpl0eJUr8np6xQ=;
        b=HvndNs/GG1MT9MDqI61XZLlMGn0oxugoeMSwBnlAdi7AQFp8AdtQxi3vOx8gx/k5rb
         +sffgCNLKtuGniZwRDDL33JlmfRuQh3mC5Zn6Yp/2kZKp+gBHpYL3amlTFN4vYldBS5V
         ukAoY5WkEl6E3BarJ3STcj9H8DQN3nuVScTXST1s4A5NpPWKQ+Co/zLbv6nSTLKV4xHP
         +3U1FbxgPa7vP6evpsXtqgEMoDhjlN/dXZBLJLlOSao3vZRT82GHxJj9KMS8cS0SbVb/
         i2EvCmURoTLIxl+vTMwVxf7/yeRUxDq41M7latyH4EWGc3b17X3W7L1CELOF5mVCHDg+
         OYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464213; x=1761069013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2QNuMvMJ8hOs9o9vuGhQfun+FldhTpl0eJUr8np6xQ=;
        b=T6DG3WuwKBRdxWFxbklxHZ6pRQSTvqGBFnixl5m2mB6caFv/ANSF5nAo32fUnogTf/
         BgkX8HwBhvu6WcKe5ibEalFSIuQMU0VH/Gdvr+NC/2YQwEMB1TX20qsPstE1gcbsr3pg
         oLWfGTEETaiMnGoPKsJhg3yTmdsGQBK0VlYeTozWlysJmnC253BKEXiL0HYryui162yw
         SXCHaffkTFldxmtgLxc3SXWDY5OvP4waiaH7w11fsWws/tghvSWxdxqRjtBHcl8Z1KPI
         AawhkmexaqOUsRyE61X0L/Pn6yu+I4Yg8r9w9fnf1sL8tPHRR/kO6G2Zw1G0EsW4uzo6
         K2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUarxM/01yPGcxZ0hjOaO1Ka8MaxsjN2ZYtlI6Xu2CcPLGGGKIWAYECljibLCFa+Kay/jra0oXGJEpOdno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPrKw10UODUgfla6oLFkQGMbEccqOfHo4keIMzUkp9XMAmGpX
	m0FwUKRNEue8wb31NcPpSIfgXM542IZYzqhYj/LUhTFkcNNYkTEOejfPc37K1S+7tvc=
X-Gm-Gg: ASbGnctVNNvKCUekTDpCdjMhWULnGR86NI3lnWMFkM9fcGNoVPgHqrkdhaBSSQB3NKf
	LCH1pe03LWTb201i5OcnNQR+mDDBm1HnjYjwLdUQhi7bXTAVr3UPAzDvP/ZBCGnKGKojORpCXsE
	tkmBMvSdIJJdtgUmhevWsvwKUQ6fHIgULAwhhGuchI4lyriCi3v5Dl3C1Kqiqcv4zTSxD43F2fV
	o3VmZPlvg/oqBFY2IYoLRcrUBxfUZ88gaWld+fw2wdg3iE6NtoVuoEkOv4YGHx+PMSBIFkULBKZ
	OdDXfvMqxRz6SbeKjlDAGYLwE11i85VGyWpvEWd6y1p/bKPfAoBb7ae8Owo1pWOPg876EZU5p8G
	RhZDqU4gq2WA+h/znyhD1yO16uJChWuAUXE6nSmJhte2rDYodqxgK8Q==
X-Google-Smtp-Source: AGHT+IHXEC/fYEZU7ntLTxdrj6qLAlHg65WozvdVDhTEcndBfhncNRLxc0EQohnoBL02yBvQfbeF8Q==
X-Received: by 2002:a05:6a20:a128:b0:32d:95f2:1fe with SMTP id adf61e73a8af0-32da8df32d3mr32604180637.2.1760464213348;
        Tue, 14 Oct 2025 10:50:13 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e3f89sm15486434b3a.66.2025.10.14.10.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 10:50:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:50:11 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Don't print details of CPUs disabled in DT
Message-ID: <20251014-5305a0b88ee761d57e3f29bb@orel>
References: <20251014163009.182381-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014163009.182381-1-apatel@ventanamicro.com>

On Tue, Oct 14, 2025 at 10:00:09PM +0530, Anup Patel wrote:
> Early boot stages may disable CPU DT nodes for unavailable
> CPUs based on SKU, pinstraps, eFuse, etc. Currently, the
> riscv_early_of_processor_hartid() prints details of a CPU
> if it is disabled in DT which has no value and gives a
> false impression to the users that there some issue with
> the CPU.
> 
> Fixes: e3d794d555cd ("riscv: treat cpu devicetree nodes without status as enabled")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kernel/cpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index f6b13e9f5e6c..3dbc8cc557dd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -62,10 +62,8 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
>  		return -ENODEV;
>  	}
>  
> -	if (!of_device_is_available(node)) {
> -		pr_info("CPU with hartid=%lu is not available\n", *hart);
> +	if (!of_device_is_available(node))
>  		return -ENODEV;
> -	}
>  
>  	if (of_property_read_string(node, "riscv,isa-base", &isa))
>  		goto old_interface;
> -- 
> 2.43.0
>

Maybe we should keep the message as a pr_debug()?

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

