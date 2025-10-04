Return-Path: <linux-kernel+bounces-842173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0BCBB9243
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 00:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01E7B345E93
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84A5235BE2;
	Sat,  4 Oct 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p83xI5xS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF2154BF5;
	Sat,  4 Oct 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759616148; cv=none; b=iPcv6QbCyELatvCXnQAFGO8kuka4KQ1NZnj9X3oj33rR89o9G6wjyWxiiFAJLx3i3lG+S+69nakagymlk0cPmMvRlm7ESTx02VxZc9fvR2Bppdu5dlyhtEvVbui185XFzVCUzKhMXwfbS+Xc9EzkKzlhP+OI+7RsNUlcCuyCkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759616148; c=relaxed/simple;
	bh=qaOCsP4oe6v4+XQagMpOX+PTxSAsjOjOnpdwZh4rx/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhpK/JN7p0XEZCXFIomftW4Si0Pumx0s0pifUkpYfxAMezNriH96Gra01IOhkJiw98lnQPjK2uvYujf03lXVkIFJZJ7FeD9yujKEjERH6Y4rhfThIxcCDcP0/pYXIMRj2LYzcnWwvcwRien1Sr8JNDgSvnOvEcEuEq4TCeoW49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p83xI5xS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCC7C4CEF1;
	Sat,  4 Oct 2025 22:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759616147;
	bh=qaOCsP4oe6v4+XQagMpOX+PTxSAsjOjOnpdwZh4rx/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p83xI5xSqfFgq5p3pEEevSuazrmM93RK0RNbgDvLAx3gI3wCk3LkZr7ILrgRb53dJ
	 CNMN5NiH8QhbF8b4q0kDAZe60e+Ymgk4b+iD0+lazopL1EXKwQXrJfaFWRJngiu/PO
	 QXQW63PAHlL/dttQgRzOGyy+jMcMCb5CnYIuibAQOgtcdg6mLu2eGAhD+5/xo2Lu3j
	 4GicMNKx2NnV0XYWhJVvGnmzia/xCXTC+HvJO/dPA7gnt7dB50KKpTC8WLz9RRk2W+
	 zEwwunlLzfboURxW/ij3fZ7jkyTdI0kTomAtN/QOejhkGRyEkmaWB0yEZRAswOzTnW
	 1Q1ugVFXDPbbg==
Date: Sat, 4 Oct 2025 15:15:45 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
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
Message-ID: <aOGckdJcY44hD4Hn@x1>
References: <20250915095331.53350-1-ziyao@disroot.org>
 <20250915095331.53350-3-ziyao@disroot.org>
 <aOBSOZzOAeelS6Gi@x1>
 <aOCEt7UGpSyWTury@pie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOCEt7UGpSyWTury@pie>

On Sat, Oct 04, 2025 at 02:21:43AM +0000, Yao Zi wrote:
> On Fri, Oct 03, 2025 at 03:46:17PM -0700, Drew Fustini wrote:
> > On Mon, Sep 15, 2025 at 09:53:28AM +0000, Yao Zi wrote:
> > > TH1520 SoC is divided into several subsystems, most of them have
> > > distinct reset controllers. Let's document reset controllers other than
> > > the one for VO subsystem and IDs for their reset signals.
> > > 
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > 
> > Thanks for sending these patches.
> > 
> > > ---
> > >  .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
> > >  .../dt-bindings/reset/thead,th1520-reset.h    | 216 ++++++++++++++++++
> > >  2 files changed, 223 insertions(+), 1 deletion(-)
> > > 
> > [snip]
> > > diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
> > > index e51d6314d131..68ac52ed69de 100644
> > > --- a/include/dt-bindings/reset/thead,th1520-reset.h
> > > +++ b/include/dt-bindings/reset/thead,th1520-reset.h
> > > @@ -7,6 +7,200 @@
> > >  #ifndef _DT_BINDINGS_TH1520_RESET_H
> > >  #define _DT_BINDINGS_TH1520_RESET_H
> > [snip]
> > > +/* DSP Subsystem */
> > > +#define TH1520_RESET_ID_X2X_DSP1	0
> > > +#define TH1520_RESET_ID_X2X_DSP0	1
> > > +#define TH1520_RESET_ID_X2X_SLAVE_DSP1	2
> > > +#define TH1520_RESET_ID_X2X_SLAVE_DSP0	3
> > > +#define TH1520_RESET_ID_DSP0_CORE	4
> > > +#define TH1520_RESET_ID_DSP0_DEBUG	5
> > > +#define TH1520_RESET_ID_DSP0_APB	6
> > > +#define TH1520_RESET_ID_DSP1_CORE	4
> > > +#define TH1520_RESET_ID_DSP1_DEBUG	5
> > > +#define TH1520_RESET_ID_DSP1_APB	6
> > > +#define TH1520_RESET_ID_DSPSYS_APB	7
> > > +#define TH1520_RESET_ID_AXI4_DSPSYS_SLV	8
> > > +#define TH1520_RESET_ID_AXI4_DSPSYS	9
> > > +#define TH1520_RESET_ID_AXI4_DSP_RS	10
> > 
> > This doesn't seem right. The numbers for each subsystem should not
> > repeat. Here the DSP0 and DSP1 items have the same numbers: 4, 5, 6.
> > 
> > This causes both clang and sparse to complain. I think you can just
> > change this so that TH1520_RESET_ID_DSP1_CORE is 7 and so on. The
> > indexes don't really have any concrete meaning other than how they are
> > used as unique keys.
> 
> You're correct, it's a copy-paste error, just like the one spotted in v1
> of the series...
> 
> I'm not sure why either my GCC or sparse yielded no warning about them.
> Will figure it out and send v3 with this fixed. Much sorry for these
> stupid mistakes.
> 
> Best regards,
> Yao Zi

Have you tried using W=1?

I do see the warning in gcc with that:

pdp7@thelio:~/linux$ rm drivers/reset/reset-th1520.o
pdp7@thelio:~/linux$ make W=1 CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv C=1 -j16
  CALL    scripts/checksyscalls.sh
Documentation/.renames.txt: warning: ignored by one of the .gitignore files
  CC      drivers/reset/reset-th1520.o
drivers/reset/reset-th1520.c:655:39: warning: initialized field overwritten [-Woverride-init]
  655 |         [TH1520_RESET_ID_DSP1_CORE] = {
      |                                       ^
drivers/reset/reset-th1520.c:655:39: note: (near initialization for ‘th1520_dsp_resets[4]’)
drivers/reset/reset-th1520.c:659:40: warning: initialized field overwritten [-Woverride-init]
  659 |         [TH1520_RESET_ID_DSP1_DEBUG] = {
      |                                        ^
drivers/reset/reset-th1520.c:659:40: note: (near initialization for ‘th1520_dsp_resets[5]’)
drivers/reset/reset-th1520.c:663:38: warning: initialized field overwritten [-Woverride-init]
  663 |         [TH1520_RESET_ID_DSP1_APB] = {
      |                                      ^
drivers/reset/reset-th1520.c:663:38: note: (near initialization for ‘th1520_dsp_resets[6]’)
  CHECK   drivers/reset/reset-th1520.c
drivers/reset/reset-th1520.c:643:10: warning: Initializer entry defined twice
drivers/reset/reset-th1520.c:655:10:   also defined here
  AR      drivers/reset/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  MODPOST Module.symvers
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  CHECK   init/version-timestamp.c
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
  NM      .tmp_vmlinux1.syms
  KSYMS   .tmp_vmlinux1.kallsyms.S
  AS      .tmp_vmlinux1.kallsyms.o
  LD      .tmp_vmlinux2
  NM      .tmp_vmlinux2.syms
  KSYMS   .tmp_vmlinux2.kallsyms.S
  AS      .tmp_vmlinux2.kallsyms.o
  LD      vmlinux.unstripped
  NM      System.map
  SORTTAB vmlinux.unstripped
  OBJCOPY vmlinux
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  OBJCOPY arch/riscv/boot/Image
  Kernel: arch/riscv/boot/Image is ready
  GZIP    arch/riscv/boot/Image.gz
  Kernel: arch/riscv/boot/Image.gz is ready
pdp7@thelio:~/linux$ head .config
#
# Automatically generated file; DO NOT EDIT.
# Linux/riscv 6.17.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="riscv64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=130300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24200


Thanks,
Drew

