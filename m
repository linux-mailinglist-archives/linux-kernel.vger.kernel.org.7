Return-Path: <linux-kernel+bounces-764479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ADDB22391
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E2D1AA2D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BCA2E975B;
	Tue, 12 Aug 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="c2tx00vQ"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0E2E973B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991811; cv=none; b=k3cLO7Y6sXQoNbXXMSloM8OZEYnVKmbCb+uFMmPbd5ahH4CZO3yziBpAQSORNnxH6l2a41ebmfhJqcDO8tz04uU243B762wnZ8vRJHUSO1ga0NHlbnGj/81pvQpccY1guUEWXGo67VvoxVHKfo+5cHxj+hUPq/l/TZyzwBDv7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991811; c=relaxed/simple;
	bh=VoQtnN8TVNFZ35OF82gYJyQyCQWCWSyi54UG/5Pr244=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJkPyj9E1DO35jA0b/f06EpBuGLukMxiDc5C156vbHoS4Z4QGefpN6ke/4eQbbkBqP1/zhAonwPn1DEtneSuuAtPGTvs8URmCEQOAaQHkOGC8PpHGxfYhSZCnB7QrcK7S77JxTypl8hfSaCDvG54zeS5iv8puNoHEAizIpZjZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=c2tx00vQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 31DAF2588F;
	Tue, 12 Aug 2025 11:43:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JUhdKEmfHZPA; Tue, 12 Aug 2025 11:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754991805; bh=VoQtnN8TVNFZ35OF82gYJyQyCQWCWSyi54UG/5Pr244=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2tx00vQAKJGnzvzuLEMjpjeoaNpI1Lx0c3Y8cYCtqN4lEKdCwFGNrqXbwho96cDr
	 De1FkMyLuefVDZ+EHP+/XKNmUy4XwSfPWGEiUj93BWfM8qh+seZfrg7OLRBKdPtyho
	 4xOzvuxmCq4q8r348zHFgM9DXNb1lhhU+ALeaggJj6kTqFkH06UOrLRRFxk6VbWsCj
	 DUqEitM07Olvng7ttQyjj6AkbsX8m+F+Oc/nN0EuOqWpP+mKScI++CAojssp9JPQli
	 bbNjTsLkTOQd6peyhyYtg9f+LfX6Uczqd3MoJV8BVGu3raF2pAoBrESbufbZwQR9ey
	 qHp4TQ/TBwk3g==
Date: Tue, 12 Aug 2025 09:43:13 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
Message-ID: <aJsGg8__ppyBrkfL@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
 <aJojDiHWi8cgvA2W@pie>
 <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
 <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev>

On Tue, Aug 12, 2025 at 03:06:23PM +0800, Youling Tang wrote:
> On 2025/8/12 14:15, Youling Tang wrote:
> > Hi, Yao
> > On 2025/8/12 01:06, Yao Zi wrote:
> > > On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
> > > > From: Youling Tang <tangyouling@kylinos.cn>
> > > > 
> > > > This patch adds support for kexec_file on LoongArch.
> > > > 
> > > > The image_load() as two parts:
> > > > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > > > - the second part loads other segments (eg: initrd, cmdline)
> > > > 
> > > > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images
> > > > are supported,
> > > > but ELF format is not supported.
> > > > 
> > > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > > ---
> > > >   arch/loongarch/Kconfig                     |   8 ++
> > > >   arch/loongarch/include/asm/image.h         |  18 ++++
> > > >   arch/loongarch/include/asm/kexec.h         |  12 +++
> > > >   arch/loongarch/kernel/Makefile             |   1 +
> > > >   arch/loongarch/kernel/kexec_image.c        | 112
> > > > +++++++++++++++++++++
> > > >   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> > > >   arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
> > > >   7 files changed, 219 insertions(+), 11 deletions(-)
> > > >   create mode 100644 arch/loongarch/kernel/kexec_image.c
> > > >   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

...

> > > > diff --git a/arch/loongarch/kernel/kexec_image.c
> > > > b/arch/loongarch/kernel/kexec_image.c
> > > > new file mode 100644
> > > > index 000000000000..fdd1845b4e2e
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/kernel/kexec_image.c

...

> > > > +    /*
> > > > +     * The location of the kernel segment may make it
> > > > impossible to satisfy
> > > > +     * the other segment requirements, so we try repeatedly to find a
> > > > +     * location that will work.
> > > > +     */
> > > > +    while ((ret = kexec_add_buffer(&kbuf)) == 0) {
> > > > +        /* Try to load additional data */
> > > > +        kernel_segment = &image->segment[kernel_segment_number];
> > > > +        ret = load_other_segments(image, kernel_segment->mem,
> > > > +                      kernel_segment->memsz, initrd,
> > > > +                      initrd_len, cmdline, cmdline_len);
> > > > +        if (!ret)
> > > > +            break;
> > > > +
> > > > +        /*
> > > > +         * We couldn't find space for the other segments; erase the
> > > > +         * kernel segment and try the next available hole.
> > > > +         */
> > > > +        image->nr_segments -= 1;
> > > > +        kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
> > > > +        kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > > +    }
> > > > +
> > > > +    if (ret) {
> > > > +        pr_err("Could not find any suitable kernel location!");
> > > > +        return ERR_PTR(ret);
> > > > +    }
> > > > +
> > > > +    kernel_segment = &image->segment[kernel_segment_number];
> > > > +
> > > > +    /* Make sure the second kernel jumps to the correct
> > > > "kernel_entry". */
> > > > +    image->start = kernel_segment->mem + h->kernel_entry -
> > > > text_offset;
> > > A non-relocatable loongarch kernel cannot be loaded to arbitrary
> > > address. Thus this loading function seems to only work for relocatable
> > > kernels, maybe it's better to leave a comment indicating the limitation.
> > > 
> > > For now, we don't seem to have a way to find out whether the kernel is
> > > relocatable (for example, a flag in kernel image header), so it's
> > > impossible to point out whether the loaded kernel boots fine with
> > > arbitrary loading address...
> > LoongArch enables the relocation of the kernel when the kdump
> > feature is enabled.
> > 
> > config ARCH_SELECTS_CRASH_DUMP
> >         def_bool y
> >         depends on CRASH_DUMP
> >         select RELOCATABLE
> > 

This only means the currently-running kernel is relocatable, not the one
being exec'ed, right?

> When enabling KEXEC_FILE, the RELOCATABLE configuration should
> also be enabled. Both kexec and kdump require this.

I'm not sure whether you're talking about the running kernel or the one
that is going to be exec'ed. This method of kernel loading requires the
exec'ed kernel being relocatable, not the currently running one.

And I think it's totally reasonable to use KEXEC_FILE for non-crash-dump
purpose, for example, linuxboot. It'll be confusing to the user if the
system just hangs after booting a non-relocatable kernel, which is hard
to debug.

Thus IMHO we should ideally refuse to load non-relocatable kernels, or
add a FIXME comment to indicate the situation that it's impossible to
determine whether the exec'ed image is relocatable.

> Youling.
> > After enabling the relocation, LoongArch is the PIE kernel. For
> > more details, please refer to commit d8da19fbdedd ("LoongArch:
> > Add support for kernel relocation")

Best regards.
Yao Zi

