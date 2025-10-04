Return-Path: <linux-kernel+bounces-841916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5CBB8861
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A06534E3143
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC6283C9D;
	Sat,  4 Oct 2025 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cqlAqblR"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3954774;
	Sat,  4 Oct 2025 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759544977; cv=none; b=QIbknYlnKm+SsLGQ9U6ZAgIr9JCTmAmXTu3obix2ybRlDyWd+IOPNnqOyTHhySzNssqriG+0G842hI5s9vlj8A73ZQ7jD9hdorMefHcej7b/WLsb1KgRgDdL0PHEbBi3/yrLETTEMMORHgEM78R8FNrR7zCcALjZ0RXaR6EwLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759544977; c=relaxed/simple;
	bh=kzhYlF7toSJUYLhb6Zjs2f+TE43JU+j0Ai5mwSU6n38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUrWy1EMWGhB+XCMFCM8voUGg1pcqkaCNX5NDdFHCyDqZD4fB0MbOBeR7eOB2FMhSwiuEj++cFffiT1ZaRzuIzr8YikSCw+b2OBSmMrih2hoPW3RdsvdQqbJ/VwqPryAP5vWOuoot2ljLlO5WfQmsQtwQUTlatSq3nIMFs9rjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cqlAqblR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7A9E626222;
	Sat,  4 Oct 2025 04:22:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-mAlgRG7zDV; Sat,  4 Oct 2025 04:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1759544521; bh=kzhYlF7toSJUYLhb6Zjs2f+TE43JU+j0Ai5mwSU6n38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cqlAqblRnzhq6/cP064tVaoFUxarJaXkP0yLySa8sYNPgz6z6SYKJidlwnZtewnIA
	 qLK1FM++X1Rz+7cKIx59TfPCPTMh9fbKuG58Cl5YZ/QU0qfr4NZiQEbciQhsPjZZie
	 jvEk6AD1y+A8znqWUWrAmmVG2zBY2I112w0LOJ9+LDPiNnkXPd4iCyflRYTuR6lh4a
	 9kZ7UhXyChlPWBPSJHOwi8bH3P70W8h/yKmGuVEk1eZFe/8TSjNF3MA1tj/lVxURqU
	 /++dUO20g/4qX9Beg0bmSEKHe7SiuP+4Kw3LQexE734gZaXjSr9ObmfANvODxGMWAD
	 frPgVDe3rUqvw==
Date: Sat, 4 Oct 2025 02:21:43 +0000
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	Han Gao <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
	linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, Fu Wei <wefu@redhat.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: reset: thead,th1520-reset: Add
 controllers for more subsys
Message-ID: <aOCEt7UGpSyWTury@pie>
References: <20250915095331.53350-1-ziyao@disroot.org>
 <20250915095331.53350-3-ziyao@disroot.org>
 <aOBSOZzOAeelS6Gi@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOBSOZzOAeelS6Gi@x1>

On Fri, Oct 03, 2025 at 03:46:17PM -0700, Drew Fustini wrote:
> On Mon, Sep 15, 2025 at 09:53:28AM +0000, Yao Zi wrote:
> > TH1520 SoC is divided into several subsystems, most of them have
> > distinct reset controllers. Let's document reset controllers other than
> > the one for VO subsystem and IDs for their reset signals.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> 
> Thanks for sending these patches.
> 
> > ---
> >  .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
> >  .../dt-bindings/reset/thead,th1520-reset.h    | 216 ++++++++++++++++++
> >  2 files changed, 223 insertions(+), 1 deletion(-)
> > 
> [snip]
> > diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
> > index e51d6314d131..68ac52ed69de 100644
> > --- a/include/dt-bindings/reset/thead,th1520-reset.h
> > +++ b/include/dt-bindings/reset/thead,th1520-reset.h
> > @@ -7,6 +7,200 @@
> >  #ifndef _DT_BINDINGS_TH1520_RESET_H
> >  #define _DT_BINDINGS_TH1520_RESET_H
> [snip]
> > +/* DSP Subsystem */
> > +#define TH1520_RESET_ID_X2X_DSP1	0
> > +#define TH1520_RESET_ID_X2X_DSP0	1
> > +#define TH1520_RESET_ID_X2X_SLAVE_DSP1	2
> > +#define TH1520_RESET_ID_X2X_SLAVE_DSP0	3
> > +#define TH1520_RESET_ID_DSP0_CORE	4
> > +#define TH1520_RESET_ID_DSP0_DEBUG	5
> > +#define TH1520_RESET_ID_DSP0_APB	6
> > +#define TH1520_RESET_ID_DSP1_CORE	4
> > +#define TH1520_RESET_ID_DSP1_DEBUG	5
> > +#define TH1520_RESET_ID_DSP1_APB	6
> > +#define TH1520_RESET_ID_DSPSYS_APB	7
> > +#define TH1520_RESET_ID_AXI4_DSPSYS_SLV	8
> > +#define TH1520_RESET_ID_AXI4_DSPSYS	9
> > +#define TH1520_RESET_ID_AXI4_DSP_RS	10
> 
> This doesn't seem right. The numbers for each subsystem should not
> repeat. Here the DSP0 and DSP1 items have the same numbers: 4, 5, 6.
> 
> This causes both clang and sparse to complain. I think you can just
> change this so that TH1520_RESET_ID_DSP1_CORE is 7 and so on. The
> indexes don't really have any concrete meaning other than how they are
> used as unique keys.

You're correct, it's a copy-paste error, just like the one spotted in v1
of the series...

I'm not sure why either my GCC or sparse yielded no warning about them.
Will figure it out and send v3 with this fixed. Much sorry for these
stupid mistakes.

Best regards,
Yao Zi

> The warnings:
> 
>   AR      kernel/built-in.a
>   CC      drivers/reset/reset-th1520.o
> drivers/reset/reset-th1520.c:655:32: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
>   655 |         [TH1520_RESET_ID_DSP1_CORE] = {
>       |                                       ^
>   656 |                 .bit = BIT(12),
>       |                 ~~~~~~~~~~~~~~~
>   657 |                 .reg = TH1520_DSPSYS_RST_CFG,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   658 |         },
>       |         ~
> drivers/reset/reset-th1520.c:643:32: note: previous initialization is here
>   643 |         [TH1520_RESET_ID_DSP0_CORE] = {
>       |                                       ^
>   644 |                 .bit = BIT(8),
>       |                 ~~~~~~~~~~~~~~
>   645 |                 .reg = TH1520_DSPSYS_RST_CFG,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   646 |         },
>       |         ~
> drivers/reset/reset-th1520.c:659:33: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
>   659 |         [TH1520_RESET_ID_DSP1_DEBUG] = {
>       |                                        ^
>   660 |                 .bit = BIT(13),
>       |                 ~~~~~~~~~~~~~~~
>   661 |                 .reg = TH1520_DSPSYS_RST_CFG,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   662 |         },
>       |         ~
> drivers/reset/reset-th1520.c:647:33: note: previous initialization is here
>   647 |         [TH1520_RESET_ID_DSP0_DEBUG] = {
>       |                                        ^
>   648 |                 .bit = BIT(9),
>       |                 ~~~~~~~~~~~~~~
>   649 |                 .reg = TH1520_DSPSYS_RST_CFG,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   650 |         },
>       |         ~
> drivers/reset/reset-th1520.c:663:31: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
>   663 |         [TH1520_RESET_ID_DSP1_APB] = {
>       |                                      ^
>   664 |                 .bit = BIT(14),
>       |                 ~~~~~~~~~~~~~~~
>   665 |                 .reg = TH1520_DSPSYS_RST_CFG,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   666 |         },
>       |         ~
> drivers/reset/reset-th1520.c:651:31: note: previous initialization is here
>   651 |         [TH1520_RESET_ID_DSP0_APB] = {
>       |                                      ^
>   652 |                 .bit = BIT(10),
>       |                 ~~~~~~~~~~~~~~~
>   653 |                 .reg = TH1520_DSPSYS_RST_CFG,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   654 |         },
>       |         ~
> 3 warnings generated.
>   CHECK   drivers/reset/reset-th1520.c
> drivers/reset/reset-th1520.c:643:10: warning: Initializer entry defined twice
> drivers/reset/reset-th1520.c:655:10:   also defined here
> 
> 
> Thanks,
> Drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

