Return-Path: <linux-kernel+bounces-852272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2BCBD890A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DCCF4FC0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453782FCBF5;
	Tue, 14 Oct 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IoHj+x5W"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A42E2EF8;
	Tue, 14 Oct 2025 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435379; cv=none; b=WTBb7pdaQ6MXNtl7moAibc0buz/+V2SId0w1d87T9d3wL6cGWEoD9ZpVfQEtGgPo0gtuEYmKL5/nMoA7/CVXB5rAycthSEdBKJyi8ErTz2UhjMXTTVqIknWuBaLQwdnqDnn2+Tpz+4iWqESmAn3L/oEOi9wNqqGOMUGzMRhiX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435379; c=relaxed/simple;
	bh=8ZOdtFHoqv/rQpLoY48GmoTDS5BQalfi24BFCB1h7e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLeThKLmsaqXDEVPtSChhGI7uCmo0BX/I4InD7YG/BrtqHgYs55T2Xa67QzhPQittW2rQXPZjRBkjQHulc32+LPYDB4jRc2aavqr89G9OGUeQyZITQyCHbTKXS+dfXil/srhb95eS/Gl8NUWiiSxXF7aKe1K+wyT2I1jduWwj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IoHj+x5W; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D255B260A3;
	Tue, 14 Oct 2025 11:49:27 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uovdA5KCQ9Xb; Tue, 14 Oct 2025 11:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760435367; bh=8ZOdtFHoqv/rQpLoY48GmoTDS5BQalfi24BFCB1h7e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IoHj+x5WYyeUqFeY+0WSwUtV5j8UHcGZo6LEs5W+hwoGC8uuZhp3dqgnQs2N23dSR
	 vAtVe/CXt9eIFI/iXJPEcUr8gc3vKjAe6+rDfM1cozhLQJoQ4njt0rikI8x6zLGtkc
	 svTX++7yslNag10zmvUIAhuwOcfl/zx39XP+sjOz77BxufupbSqSOllbkYksU3/t/7
	 sXTz1yZMcGXOR3oTHAX4YDLL7eaPdJezuq/TfvZklX6i7Sy6R9rmlK5SGIu62ZXTv/
	 3gHGdJzzGAgPo8AhbEzKMmyGE+xnpmjCY2b+sOrKVTyyeDAK811upWwuYn+maSxbb3
	 c3hWa5dzGRQPQ==
Date: Tue, 14 Oct 2025 09:49:07 +0000
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
Message-ID: <aO4ck0IhO20T78eN@pie>
References: <20250915095331.53350-1-ziyao@disroot.org>
 <20250915095331.53350-3-ziyao@disroot.org>
 <aOBSOZzOAeelS6Gi@x1>
 <aOCEt7UGpSyWTury@pie>
 <aOGckdJcY44hD4Hn@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOGckdJcY44hD4Hn@x1>

On Sat, Oct 04, 2025 at 03:15:45PM -0700, Drew Fustini wrote:
> On Sat, Oct 04, 2025 at 02:21:43AM +0000, Yao Zi wrote:
> > On Fri, Oct 03, 2025 at 03:46:17PM -0700, Drew Fustini wrote:
> > > On Mon, Sep 15, 2025 at 09:53:28AM +0000, Yao Zi wrote:
> > > > TH1520 SoC is divided into several subsystems, most of them have
> > > > distinct reset controllers. Let's document reset controllers other than
> > > > the one for VO subsystem and IDs for their reset signals.
> > > > 
> > > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > 
> > > Thanks for sending these patches.
> > > 
> > > > ---
> > > >  .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
> > > >  .../dt-bindings/reset/thead,th1520-reset.h    | 216 ++++++++++++++++++
> > > >  2 files changed, 223 insertions(+), 1 deletion(-)
> > > > 
> > > [snip]
> > > > diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
> > > > index e51d6314d131..68ac52ed69de 100644
> > > > --- a/include/dt-bindings/reset/thead,th1520-reset.h
> > > > +++ b/include/dt-bindings/reset/thead,th1520-reset.h
> > > > @@ -7,6 +7,200 @@
> > > >  #ifndef _DT_BINDINGS_TH1520_RESET_H
> > > >  #define _DT_BINDINGS_TH1520_RESET_H
> > > [snip]
> > > > +/* DSP Subsystem */
> > > > +#define TH1520_RESET_ID_X2X_DSP1	0
> > > > +#define TH1520_RESET_ID_X2X_DSP0	1
> > > > +#define TH1520_RESET_ID_X2X_SLAVE_DSP1	2
> > > > +#define TH1520_RESET_ID_X2X_SLAVE_DSP0	3
> > > > +#define TH1520_RESET_ID_DSP0_CORE	4
> > > > +#define TH1520_RESET_ID_DSP0_DEBUG	5
> > > > +#define TH1520_RESET_ID_DSP0_APB	6
> > > > +#define TH1520_RESET_ID_DSP1_CORE	4
> > > > +#define TH1520_RESET_ID_DSP1_DEBUG	5
> > > > +#define TH1520_RESET_ID_DSP1_APB	6
> > > > +#define TH1520_RESET_ID_DSPSYS_APB	7
> > > > +#define TH1520_RESET_ID_AXI4_DSPSYS_SLV	8
> > > > +#define TH1520_RESET_ID_AXI4_DSPSYS	9
> > > > +#define TH1520_RESET_ID_AXI4_DSP_RS	10
> > > 
> > > This doesn't seem right. The numbers for each subsystem should not
> > > repeat. Here the DSP0 and DSP1 items have the same numbers: 4, 5, 6.
> > > 
> > > This causes both clang and sparse to complain. I think you can just
> > > change this so that TH1520_RESET_ID_DSP1_CORE is 7 and so on. The
> > > indexes don't really have any concrete meaning other than how they are
> > > used as unique keys.
> > 
> > You're correct, it's a copy-paste error, just like the one spotted in v1
> > of the series...
> > 
> > I'm not sure why either my GCC or sparse yielded no warning about them.
> > Will figure it out and send v3 with this fixed. Much sorry for these
> > stupid mistakes.
> > 
> > Best regards,
> > Yao Zi
> 
> Have you tried using W=1?
> 
> I do see the warning in gcc with that:
> 
> pdp7@thelio:~/linux$ rm drivers/reset/reset-th1520.o
> pdp7@thelio:~/linux$ make W=1 CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv C=1 -j16
>   CALL    scripts/checksyscalls.sh
> Documentation/.renames.txt: warning: ignored by one of the .gitignore files
>   CC      drivers/reset/reset-th1520.o
> drivers/reset/reset-th1520.c:655:39: warning: initialized field overwritten [-Woverride-init]
>   655 |         [TH1520_RESET_ID_DSP1_CORE] = {
>       |                                       ^
> drivers/reset/reset-th1520.c:655:39: note: (near initialization for ‘th1520_dsp_resets[4]’)
> drivers/reset/reset-th1520.c:659:40: warning: initialized field overwritten [-Woverride-init]
>   659 |         [TH1520_RESET_ID_DSP1_DEBUG] = {
>       |                                        ^
> drivers/reset/reset-th1520.c:659:40: note: (near initialization for ‘th1520_dsp_resets[5]’)
> drivers/reset/reset-th1520.c:663:38: warning: initialized field overwritten [-Woverride-init]
>   663 |         [TH1520_RESET_ID_DSP1_APB] = {
>       |                                      ^
> drivers/reset/reset-th1520.c:663:38: note: (near initialization for ‘th1520_dsp_resets[6]’)
>   CHECK   drivers/reset/reset-th1520.c
> drivers/reset/reset-th1520.c:643:10: warning: Initializer entry defined twice
> drivers/reset/reset-th1520.c:655:10:   also defined here

Thanks, building with W=1 does spot the issue. Somehow my local setup of
sparse cannot find the duplicated IDs for either v1 or v2 of this
series, but GCC with W=1 could.

Will send v3 of the series with these duplicated IDs fixed. Really
thanks for finding the issue.

Best regards
Yao Zi

