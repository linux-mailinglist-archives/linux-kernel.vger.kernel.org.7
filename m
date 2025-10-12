Return-Path: <linux-kernel+bounces-849390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6473DBCFFE8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7788C3BD68A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4121019C;
	Sun, 12 Oct 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtYjYXk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B81A3154
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760252397; cv=none; b=qLg0Gs6gvrEdLLt9SFFmmAqU0V7sKofY5+VrfZqKDquE9olGxcrItF2qEiKM8Htz4eRIpJdnxnpikDzOqm8nqSK8V0mERwf0z+fQTzAKtVgxXwvVvuKB0Y2uIvpEVUVgXQrAOQILpDIlYTNpIyyiLGTGa5xYK94wbFWvtigSNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760252397; c=relaxed/simple;
	bh=77zuiySPdjhs3+W9heR5TXbrRLy69D4PruJGMHlXl6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmTLMGRt4p003ezgo+Q0a9plZFnSEyyUU2Pac0ORdmRyeBXruxjTSETXft2Lk7dyqs2xLN3fPhTI437NGNSv96a70TaeloUdZxCDI1ZX5JeVcgC4xxbFiGHvCReYdy3G8i1A0bEMHuQ2p3qwj/MJVENoeNPoUSZPuv1DAE85NwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtYjYXk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7023C4CEE7;
	Sun, 12 Oct 2025 06:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760252397;
	bh=77zuiySPdjhs3+W9heR5TXbrRLy69D4PruJGMHlXl6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtYjYXk98WWKuUcgi97iurAjpPu5twj1qiDE7i3aAPmL3t+Rv/G0KfNQD3lwlsOEq
	 CRc3ZMkMxCwhxwxQQEDF3ih6xIA9mrFE01r1qp04Zt2Y+LpHXKs7eet2Zmw3pl2OT0
	 HN0hxDqMycoeMtLd0c0Kc3c0T3seMGV1xYnlE3gbHU+tLPhwEeoIVwj0Io0Myv1OgW
	 HZo4WkOIAxSa+jCb32bRyiBpeiC+LnHve/h3vj3DdUJeQrC601pw51qltBANpfwQmi
	 OgVVryhbwgYcmQHECIIsFbs5Ne1lpuoeSXX8woDX///tQRlphSkR+9j3SOBOQEI5fu
	 IySUmjf8uvx7w==
Date: Sun, 12 Oct 2025 02:59:43 -0400
From: Guo Ren <guoren@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: Define pgprot_dmacoherent() for non-coherent
 devices
Message-ID: <aOtR39pl5xjyYHn1@gmail.com>
References: <20250820152316.1012757-1-apatel@ventanamicro.com>
 <aOtFpju/42kVkBsx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOtFpju/42kVkBsx@gmail.com>

On Sun, Oct 12, 2025 at 02:07:34AM -0400, Guo Ren wrote:
> On Wed, Aug 20, 2025 at 08:53:16PM +0530, Anup Patel wrote:
> > The pgprot_dmacoherent() is used when allocating memory for
> > non-coherent devices and by default pgprot_dmacoherent() is
> > same as pgprot_noncached() unless architecture overrides it.
> > 
> > Currently, there is no pgprot_dmacoherent() definition for
> > RISC-V hence non-coherent device memory is being mapped as
> > IO thereby making CPU access to such memory slow.
> > 
> > Define pgprot_dmacoherent() to be same as pgprot_writecombine()
> > for RISC-V so that CPU access non-coherent device memory as
> > NOCACHE which is better than accessing it as IO.
> > 
> > Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 91697fbf1f90..00d8bdaf1e8d 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -653,6 +653,8 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
> >  	return __pgprot(prot);
> >  }
> >  
> > +#define pgprot_dmacoherent pgprot_writecombine
> I missed this patch and sent out a duplicate one [1]. Maybe the comments
> from [1] could be appended to this one.
[1]: https://lore.kernel.org/linux-riscv/20251011155746.1558731-1-guoren@kernel.org/

> 
> Tested-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> 
> > +
> >  /*
> >   * Both Svade and Svadu control the hardware behavior when the PTE A/D bits need to be set. By
> >   * default the M-mode firmware enables the hardware updating scheme when only Svadu is present in
> > -- 
> > 2.43.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

