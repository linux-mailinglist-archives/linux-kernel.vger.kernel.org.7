Return-Path: <linux-kernel+bounces-764220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F10EB2200D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87AE68677F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBC2DECD2;
	Tue, 12 Aug 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OxVOkeMn"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F152D6E4B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985402; cv=none; b=IaA0sWRCYcJvFCE2LsG2X65+Ha2HlBHbAsLvauMT9DDZOWZpZRGZ+soEKd9Vkk8OXu5IiXCdkMCajwvt+5vzkiWZk8LG0KIO1PZtrqBfn+T/uqTIBjVZuxCJ96zi9MCvOMekdwVepqk+Vd5qSx2dAv3vil8R4gVbXv5YrqjwPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985402; c=relaxed/simple;
	bh=lqChg/BwKR8Q8MrSc+NExDtpkBdUqJRQkLtzpoeak8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQCJeUfJ91Cf8uuJ04HwZMHpl73mtJ5PsQa18AtpsVDbUXKcRVY3GrXUazXqjZh5e+Gn4ekS5bHkoMts7Kw047Fj1f670l637CaMk3CTsgxvPepD8AvFXlWa5vnapabTEKDelZgaVNi4fNico+brIysIcLc4reKEaGsZOGSwGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OxVOkeMn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4415E20F50;
	Tue, 12 Aug 2025 09:56:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glnkyHfjUfM9; Tue, 12 Aug 2025 09:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754985396; bh=lqChg/BwKR8Q8MrSc+NExDtpkBdUqJRQkLtzpoeak8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OxVOkeMnfMnAz4V4Fg6cLd0ZkuTUNF0QaZcl1twXUY2nFYSk5JCXszY3FAs8l1ZwJ
	 NSzXjgxcgyOTk0rDdgy6HPyHmUqZUVXaHwIWgulMhGahWTJXh5UMSm5WM0kjyvQY7U
	 NjZklvb0VWdH29VREneUm15I73Mh/+YIRMYKdXdRbCE+x9E1yCGacFn4mNiOFAXArb
	 nCOAivxAFipg2pDgzMxqKNRQwh7ScG2/Fxni8EqMQyRjwuz6lwfc19JnC+lpwjH4e1
	 z41MsxFrf9z27VyopFJs85P/432+BFkobOJ/BIChZEa6eunWkh17aTKuRxYgu8bJWw
	 1HcD8oiLDAdvg==
Date: Tue, 12 Aug 2025 07:56:22 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Youling Tang <youling.tang@linux.dev>, WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
Message-ID: <aJrzpiSbs5Gt6Lel@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
 <aJojDiHWi8cgvA2W@pie>
 <CAAhV-H4wz2Kw=PUOVeaqCHVZV3YwWPACg1GK5J3yph6SHTwOBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4wz2Kw=PUOVeaqCHVZV3YwWPACg1GK5J3yph6SHTwOBw@mail.gmail.com>

On Tue, Aug 12, 2025 at 10:39:59AM +0800, Huacai Chen wrote:
> On Tue, Aug 12, 2025 at 1:09 AM Yao Zi <ziyao@disroot.org> wrote:
> >
> > On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > >
> > > This patch adds support for kexec_file on LoongArch.
> > >
> > > The image_load() as two parts:
> > > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > > - the second part loads other segments (eg: initrd, cmdline)
> > >
> > > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
> > > but ELF format is not supported.
> > >
> > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > ---
> > >  arch/loongarch/Kconfig                     |   8 ++
> > >  arch/loongarch/include/asm/image.h         |  18 ++++
> > >  arch/loongarch/include/asm/kexec.h         |  12 +++
> > >  arch/loongarch/kernel/Makefile             |   1 +
> > >  arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
> > >  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> > >  arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
> > >  7 files changed, 219 insertions(+), 11 deletions(-)
> > >  create mode 100644 arch/loongarch/kernel/kexec_image.c
> > >  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> >
> > > diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/kexec_image.c
> > > new file mode 100644
> > > index 000000000000..fdd1845b4e2e
> > > --- /dev/null
> > > +++ b/arch/loongarch/kernel/kexec_image.c
> > > @@ -0,0 +1,112 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Kexec image loader for LoongArch
> > > +
> > > + * Author: Youling Tang <tangyouling@kylinos.cn>
> > > + * Copyright (C) 2025 KylinSoft Corporation.
> > > + */
> > > +
> > > +#define pr_fmt(fmt)  "kexec_file(Image): " fmt
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/kexec.h>
> > > +#include <linux/pe.h>
> > > +#include <linux/string.h>
> > > +#include <asm/byteorder.h>
> > > +#include <asm/cpufeature.h>
> > > +#include <asm/image.h>
> > > +
> > > +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> > > +{
> > > +     const struct loongarch_image_header *h =
> > > +             (const struct loongarch_image_header *)(kernel_buf);
> >
> > Parentheses around "kernel_buf" are unnecessary.
> >
> > > +     if (!h || (kernel_len < sizeof(*h))) {
> >
> > Comparisons have higher priority than logic operations, so this pair of
> > parentheses is redundant, too.
> But the kernel coding style suggest to use parentheses in this case.

Could you please quote the original text? I have read through
Documentation/process/coding-style.rst again but didn't find similar
suggestions...

And git grep '[[:alnum:]]\+ || [[:alnum:]_]\+ [<>]=\?' results in more
than 7000 matches, including 25 in arch/loongarch...

Anyway, this is a little nitpick. I'm just pointing out the expression
is equal to "!h || kernel_len < sizeof(*h)", and whether it's simplified
is fine to me.

> >
> > > +             pr_err("No loongarch image header.\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (!loongarch_header_check_pe_sig(h)) {
> > > +             pr_err("Bad loongarch PE image header.\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}

...

> > > diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
> > > index f9381800e291..008f43e26120 100644
> > > --- a/arch/loongarch/kernel/machine_kexec.c
> > > +++ b/arch/loongarch/kernel/machine_kexec.c
> > > @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
> >
> > ...
> >
> > > -     if (!kimage->arch.cmdline_ptr) {
> > > -             pr_err("Command line not included in the provided image\n");
> > > -             return -EINVAL;
> > > +             if (!kimage->arch.cmdline_ptr) {
> > > +                     pr_err("Command line not included in the provided image\n");
> > > +                     return -EINVAL;
> > > +             }
> > >       }
> > >
> > >       /* kexec/kdump need a safe page to save reboot_code_buffer */
> > > @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
> > >       local_irq_disable();
> > >
> > >       pr_notice("EFI boot flag 0x%lx\n", efi_boot);
> > > -     pr_notice("Command line at 0x%lx\n", cmdline_ptr);
> > > +     pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
> > > +     pr_notice("Command line at %s\n", (char *)cmdline_ptr);
> >
> > The printed message doesn't match meaning of the pointer: you're
> > printing the content of cmdline_ptr, instead of its address, thus
> > "Command line at" sounds confusing to me.
> >
> > Furthermore, this chunk isn't related to "support for kexec_file", I
> > think it's better to separate it into another patch (or even another
> > series).
> Separating is not necessary from my point of view, indeed I suggest to
> squash patches in this series.

I realized this comment is a little nitpicking, too, so I'm going to say
either is fine to me.

> Huacai

Best regards,
Yao Zi

> >
> > >       pr_notice("System table at 0x%lx\n", systable_ptr);
> > >       pr_notice("We will call new kernel at 0x%lx\n", start_addr);
> > >       pr_notice("Bye ...\n");
> >
> > Best regards,
> > Yao Zi
> 

