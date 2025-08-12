Return-Path: <linux-kernel+bounces-763836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFEEB21ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC174270EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145352D9ED9;
	Tue, 12 Aug 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0OYYP4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA4311C02
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754966414; cv=none; b=UnsdhtHlMG1Rd/GGPIHVk8H82g0mg5DCJ1iKCtBa9n9RDSxvuoucsPijcZKNh2JFwMvma2z1RBoGMt60QQpN3jo6pfII7z2t7pXCVQJj+Mb83BzqMTrrQi3ndoBGpL5Wh+/b9W+sZKjYvGItdGKZ0iwEh7EBueWSZL3YyS8JwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754966414; c=relaxed/simple;
	bh=h0sCExHWIQrvkBq4lLJhc4UFXfu4FLa6Cr0FSlpbJQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MswbPxS89seIzebVqzp8V7xdG1JF4gr5z88KuBd1KJy1j9gbCndvxBt3SbAL95BgWyGxhIat8QldkFMiC4+ku/DRBKmPMcT0y3VjhPKc2O+eNGhBwU29wHwXmrBaybf5vUO1NkPy28iiDYitOHSgeRTpYlWZYG5Wt59/yz1xG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0OYYP4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91DDC4CEFA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754966413;
	bh=h0sCExHWIQrvkBq4lLJhc4UFXfu4FLa6Cr0FSlpbJQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P0OYYP4r9RgfTACgezatQg4THw6oQjh0vm8mczdtBCZTSKTxaHV3+gVOixMR+hbva
	 j4v2MYWrvUVCdPpCKa20BLa9nKqWDEiE7kMOoCqdeaPOI0cZJ78dFVLxpMcvR3T1mB
	 nGrK1o8smGq2pnCMOcu2xvV02vK2cZSoOqPfEz5oHJP6XgSAxkRrb+WY90Vt3s05/x
	 v2n2uNRf1DrdQMrHU5ACkSCoRuZ3fgW5YFw23S21UsaLRsQQi78K6wNybeEb7w0cNC
	 Cn7mWrdPTsxDsG+1msxRTFgegEWc+YoXRw5F5gdclodV0rk2RQeqXjHZmp7SgeNH0y
	 F9QMZm15AkhIQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so8496377a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:40:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYiieCr3A71H4UrEyoVSOCfDAJv80TLdVExKbmJpRvqwZ1V1SnVglER+fdqee0J4ORamY//PWvcTEk2/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCif4sFJi5newiCGY+WT0xKFtL2zIzkXkcIMhcLw3bGXdjX/ox
	rDNJd4Y4hEOwQjoKR6ELCfk7rHQo89ATxqfykHgqZ3SzqUJPlS5uZD7F21zUF5JUTE/zk3fynDu
	oYOL8YlVvYybv9Hx7PABYGQTN1tVeZkI=
X-Google-Smtp-Source: AGHT+IEl8pi7kjXOpNNQlb8zbH2ATR266lZKgl04Ch1KqqfXfHkBvvSXbUgG1+nlMFx++zwS1pavbcNUQwYY2+7vUR4=
X-Received: by 2002:a05:6402:34cb:b0:618:4b73:916c with SMTP id
 4fb4d7f45d1cf-6184d944185mr1639752a12.2.1754966412351; Mon, 11 Aug 2025
 19:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev> <aJojDiHWi8cgvA2W@pie>
In-Reply-To: <aJojDiHWi8cgvA2W@pie>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 Aug 2025 10:39:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4wz2Kw=PUOVeaqCHVZV3YwWPACg1GK5J3yph6SHTwOBw@mail.gmail.com>
X-Gm-Features: Ac12FXxqkkcOFruSu2jZsiLb4S8iRE2quEnQNnnJIJWPwIKnomUmTxI11K6BTKE
Message-ID: <CAAhV-H4wz2Kw=PUOVeaqCHVZV3YwWPACg1GK5J3yph6SHTwOBw@mail.gmail.com>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Yao Zi <ziyao@disroot.org>
Cc: Youling Tang <youling.tang@linux.dev>, WANG Xuerui <kernel@xen0n.name>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 1:09=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:
>
> On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
> > From: Youling Tang <tangyouling@kylinos.cn>
> >
> > This patch adds support for kexec_file on LoongArch.
> >
> > The image_load() as two parts:
> > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > - the second part loads other segments (eg: initrd, cmdline)
> >
> > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supp=
orted,
> > but ELF format is not supported.
> >
> > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > ---
> >  arch/loongarch/Kconfig                     |   8 ++
> >  arch/loongarch/include/asm/image.h         |  18 ++++
> >  arch/loongarch/include/asm/kexec.h         |  12 +++
> >  arch/loongarch/kernel/Makefile             |   1 +
> >  arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
> >  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> >  arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
> >  7 files changed, 219 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/loongarch/kernel/kexec_image.c
> >  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> ...
>
> > diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/includ=
e/asm/image.h
> > index 1f090736e71d..829e1ecb1f5d 100644
> > --- a/arch/loongarch/include/asm/image.h
> > +++ b/arch/loongarch/include/asm/image.h
> > @@ -36,5 +36,23 @@ struct loongarch_image_header {
> >       uint32_t pe_header;
> >  };
> >
> > +static const uint8_t loongarch_image_pe_sig[2] =3D {'M', 'Z'};
> > +static const uint8_t loongarch_pe_machtype[6] =3D {'P', 'E', 0x0, 0x0,=
 0x64, 0x62};
>
> loongarch_pe_machtype isn't used at all.
>
> > +
> > +/**
> > + * loongarch_header_check_pe_sig - Helper to check the loongarch image=
 header.
> > + *
> > + * Returns non-zero if 'MZ' signature is found.
> > + */
> > +
> > +static inline int loongarch_header_check_pe_sig(const struct loongarch=
_image_header *h)
> > +{
> > +     if (!h)
> > +             return 0;
> > +
> > +     return (h->pe_sig[0] =3D=3D loongarch_image_pe_sig[0]
> > +             && h->pe_sig[1] =3D=3D loongarch_image_pe_sig[1]);
>
> This could be simplified with a memcmp(). Also, this check isn't strict
> enough: PE files for any architectures, and even legacy MS-DOS COM
> executables all start with "MZ".
>
> > +}
> > +
> >  #endif /* __ASSEMBLY__ */
> >  #endif /* __ASM_IMAGE_H */
>
> ...
>
> > diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kerne=
l/kexec_image.c
> > new file mode 100644
> > index 000000000000..fdd1845b4e2e
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/kexec_image.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kexec image loader for LoongArch
> > +
> > + * Author: Youling Tang <tangyouling@kylinos.cn>
> > + * Copyright (C) 2025 KylinSoft Corporation.
> > + */
> > +
> > +#define pr_fmt(fmt)  "kexec_file(Image): " fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kexec.h>
> > +#include <linux/pe.h>
> > +#include <linux/string.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/cpufeature.h>
> > +#include <asm/image.h>
> > +
> > +static int image_probe(const char *kernel_buf, unsigned long kernel_le=
n)
> > +{
> > +     const struct loongarch_image_header *h =3D
> > +             (const struct loongarch_image_header *)(kernel_buf);
>
> Parentheses around "kernel_buf" are unnecessary.
>
> > +     if (!h || (kernel_len < sizeof(*h))) {
>
> Comparisons have higher priority than logic operations, so this pair of
> parentheses is redundant, too.
But the kernel coding style suggest to use parentheses in this case.

>
> > +             pr_err("No loongarch image header.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!loongarch_header_check_pe_sig(h)) {
> > +             pr_err("Bad loongarch PE image header.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void *image_load(struct kimage *image,
> > +                             char *kernel, unsigned long kernel_len,
> > +                             char *initrd, unsigned long initrd_len,
> > +                             char *cmdline, unsigned long cmdline_len)
> > +{
> > +     struct loongarch_image_header *h;
> > +     struct kexec_buf kbuf;
> > +     unsigned long text_offset, kernel_segment_number;
> > +     struct kexec_segment *kernel_segment;
> > +     int ret;
> > +
> > +     h =3D (struct loongarch_image_header *)kernel;
> > +     if (!h->image_size)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     /* Load the kernel */
> > +     kbuf.image =3D image;
> > +     kbuf.buf_min =3D 0;
> > +     kbuf.buf_max =3D ULONG_MAX;
> > +     kbuf.top_down =3D false;
> > +
> > +     kbuf.buffer =3D kernel;
> > +     kbuf.bufsz =3D kernel_len;
> > +     kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> > +     kbuf.memsz =3D le64_to_cpu(h->image_size);
> > +     text_offset =3D le64_to_cpu(h->text_offset);
> > +     kbuf.buf_align =3D SZ_2M;
>
> I think this aligment is unnecessary for relocatable LoongArch kernels:
> it should be enough to align to the page size. See also my comments
> below.
>
> > +     kernel_segment_number =3D image->nr_segments;
> > +
> > +     /*
> > +      * The location of the kernel segment may make it impossible to s=
atisfy
> > +      * the other segment requirements, so we try repeatedly to find a
> > +      * location that will work.
> > +      */
> > +     while ((ret =3D kexec_add_buffer(&kbuf)) =3D=3D 0) {
> > +             /* Try to load additional data */
> > +             kernel_segment =3D &image->segment[kernel_segment_number]=
;
> > +             ret =3D load_other_segments(image, kernel_segment->mem,
> > +                                       kernel_segment->memsz, initrd,
> > +                                       initrd_len, cmdline, cmdline_le=
n);
> > +             if (!ret)
> > +                     break;
> > +
> > +             /*
> > +              * We couldn't find space for the other segments; erase t=
he
> > +              * kernel segment and try the next available hole.
> > +              */
> > +             image->nr_segments -=3D 1;
> > +             kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
> > +             kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> > +     }
> > +
> > +     if (ret) {
> > +             pr_err("Could not find any suitable kernel location!");
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     kernel_segment =3D &image->segment[kernel_segment_number];
> > +
> > +     /* Make sure the second kernel jumps to the correct "kernel_entry=
". */
> > +     image->start =3D kernel_segment->mem + h->kernel_entry - text_off=
set;
>
> A non-relocatable loongarch kernel cannot be loaded to arbitrary
> address. Thus this loading function seems to only work for relocatable
> kernels, maybe it's better to leave a comment indicating the limitation.
>
> For now, we don't seem to have a way to find out whether the kernel is
> relocatable (for example, a flag in kernel image header), so it's
> impossible to point out whether the loaded kernel boots fine with
> arbitrary loading address...
>
> > +     kexec_dprintk("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx=
\n",
> > +                   kernel_segment->mem, kbuf.bufsz,
> > +                   kernel_segment->memsz);
> > +
> > +     return NULL;
> > +}
> > +
> > +const struct kexec_file_ops kexec_image_ops =3D {
> > +     .probe =3D image_probe,
> > +     .load =3D image_load,
> > +};
> > diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/ker=
nel/machine_kexec.c
> > index f9381800e291..008f43e26120 100644
> > --- a/arch/loongarch/kernel/machine_kexec.c
> > +++ b/arch/loongarch/kernel/machine_kexec.c
> > @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
>
> ...
>
> > -     if (!kimage->arch.cmdline_ptr) {
> > -             pr_err("Command line not included in the provided image\n=
");
> > -             return -EINVAL;
> > +             if (!kimage->arch.cmdline_ptr) {
> > +                     pr_err("Command line not included in the provided=
 image\n");
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       /* kexec/kdump need a safe page to save reboot_code_buffer */
> > @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
> >       local_irq_disable();
> >
> >       pr_notice("EFI boot flag 0x%lx\n", efi_boot);
> > -     pr_notice("Command line at 0x%lx\n", cmdline_ptr);
> > +     pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
> > +     pr_notice("Command line at %s\n", (char *)cmdline_ptr);
>
> The printed message doesn't match meaning of the pointer: you're
> printing the content of cmdline_ptr, instead of its address, thus
> "Command line at" sounds confusing to me.
>
> Furthermore, this chunk isn't related to "support for kexec_file", I
> think it's better to separate it into another patch (or even another
> series).
Separating is not necessary from my point of view, indeed I suggest to
squash patches in this series.

Huacai

>
> >       pr_notice("System table at 0x%lx\n", systable_ptr);
> >       pr_notice("We will call new kernel at 0x%lx\n", start_addr);
> >       pr_notice("Bye ...\n");
>
> Best regards,
> Yao Zi

