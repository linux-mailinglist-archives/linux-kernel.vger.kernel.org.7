Return-Path: <linux-kernel+bounces-849383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E84EABCFFA4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 08:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEFB1895148
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 06:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5C212557;
	Sun, 12 Oct 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg3mm9Pc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8092AD32
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760249269; cv=none; b=Ya64h1qWjvx6dvc94F5/yvbMXoYNK6VrfrpNdvEsFnDKkgYjw5sP/rs9TA6mk974SYQ+n7kWtI4J/LP8C4r6m10mkY4Pg4uWgz4LS4+JQ7zOWcODUFmiN1Fcit117NrnwOb/YUVF8c5NKhLyLop94qL9MCTQF1Cr9wkJvC7/Ugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760249269; c=relaxed/simple;
	bh=rK12P4zeLhl5dtVhuIaoUuWetGo8+ztMKq3/BFcQ8Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBryRfbCHcuM3Jdn58pnxPpp+mhRol0XXKdVYBdDsZmoXAsR/PPpkEMkJjkjSiJ27ZrnelWiHrQb2IrlhGzVbWPi1g9KmRMBQjJWVuntfOB5BpX4eFHAYyHc4ltroWQzYnTFPqJnbdsgKstkj6fb+SHnuIVNNt3Lf+oEk93DYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg3mm9Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD6FC4CEF8;
	Sun, 12 Oct 2025 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760249267;
	bh=rK12P4zeLhl5dtVhuIaoUuWetGo8+ztMKq3/BFcQ8Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tg3mm9Pcneyg7FlIlIo0yoNLQLgbU/EruZIviOVfP4woAGYTOP0xCMBZ3D+8mlqdK
	 SzCyfXlYygGOHak6FkQKlYLtd4HN3MoJNaoMkjRcMLDJXuHdHs+y/s88dRh4VoDSmi
	 95pJkf4H+8fPCA9CumGuehpGE0HY08d+rqspd7tsdDTE7DoyBCi6NI2tVzB3kjpvqg
	 mgOlPSYqOnaPvqKilYMPDsw6eP6LXQTnKm3DduZvd5yTev/hSePAVosEe2YmVW6Omu
	 UKCo2sAR76HCJarFVJbzZsRxZCxvhI65wbdKo8ZTL9zBMIYwXtt+3SDjdGvkYiSqWh
	 gWFyQGk3mx2hg==
Date: Sun, 12 Oct 2025 02:07:34 -0400
From: Guo Ren <guoren@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Define pgprot_dmacoherent() for non-coherent
 devices
Message-ID: <aOtFpju/42kVkBsx@gmail.com>
References: <20250820152316.1012757-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820152316.1012757-1-apatel@ventanamicro.com>

On Wed, Aug 20, 2025 at 08:53:16PM +0530, Anup Patel wrote:
> The pgprot_dmacoherent() is used when allocating memory for
> non-coherent devices and by default pgprot_dmacoherent() is
> same as pgprot_noncached() unless architecture overrides it.
> 
> Currently, there is no pgprot_dmacoherent() definition for
> RISC-V hence non-coherent device memory is being mapped as
> IO thereby making CPU access to such memory slow.
> 
> Define pgprot_dmacoherent() to be same as pgprot_writecombine()
> for RISC-V so that CPU access non-coherent device memory as
> NOCACHE which is better than accessing it as IO.
> 
> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 91697fbf1f90..00d8bdaf1e8d 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -653,6 +653,8 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
>  	return __pgprot(prot);
>  }
>  
> +#define pgprot_dmacoherent pgprot_writecombine
I missed this patch and sent out a duplicate one [1]. Maybe the comments
from [1] could be appended to this one.

Tested-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

> +
>  /*
>   * Both Svade and Svadu control the hardware behavior when the PTE A/D bits need to be set. By
>   * default the M-mode firmware enables the hardware updating scheme when only Svadu is present in
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

