Return-Path: <linux-kernel+bounces-762838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE2BB20B57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D1E3B1A74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB3218584;
	Mon, 11 Aug 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHtq1ZCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E51DC9B8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921283; cv=none; b=b7DaobAuva55cgywWGPjT9NigX1kmICCNK+zamBaMuerLhYBss75kkayeFeMwbLQTwMjWUGBh4iFGf1R8YCjwP1zkX9HObRWGkLl9cdydfq9nZHRiOB16sKw7LSMZpUAT46DHeLAAvEgBbxYezEqGS2mZhr8MBgsnglmbysMow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921283; c=relaxed/simple;
	bh=mmglv790KGYDyohM6cmLFFriSeuAx7IxQWdGKZS5/ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtTpMCdyeD1Ht/kQsMIop/QrY+2GhU2F4ByTntHBeHwfGwQLWqzWOCHFIpAwup17/cJpjT1P/uwvxov+Y7Iu6Mquq7uDNaAW7rn6BZ+nQlha8LIvm7S+0D1KyC96JhVFhqGlMzno4LNwiQJspC6DW2U4Ok40D2y5I2yNXao805U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHtq1ZCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A524C4CEF9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921282;
	bh=mmglv790KGYDyohM6cmLFFriSeuAx7IxQWdGKZS5/ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qHtq1ZCMcp5T5QZ2uBm1wwv1TViLXYR7pztOFJVjrALKti2s9Punj4v43dMFmH5Vj
	 DA5QsNK1so3O2sDR2gOiG5zELJ4VLpXxneUjSYqZwOgyTl0qx4S0X6kEt67HeRtDVd
	 cvg9RDnB9Xq4owT/WlKfed27GumPejXNgWYlluYvOfm3OOIB2wSSB014FJ7CVbThL2
	 Ny8FhNJ7GW1XTOy6cyjV65F6X8ZGjFYfocPJQQFr0pUPRDq2kKC89CP2eO+sTwFdjm
	 o8v2h/uO7VJ1PW3F4ljMqFY8lbbp34tr6SYJea5nve+O+/+001VL/VTPbp0l25qZo0
	 /TD+OGuyNWRHA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7789106a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:08:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5m09LuEvuUJa0uSJWZ+8UxXEDiRhviUAmteX/45mR5lHgqKtSfhKAC2U2f8SqnVZ8ew2PYJTQna0xTX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/98A6NMyo1XgzDdgDoOBztvCxEhAjC0lL+YRElfJlGibnjYr4
	/BjVwIQu/ZPEUoGrR5iSUnfBpy0x/I8iqJwRsQEXDUAJ1jbKsdYIVwMXFYeA+zp3orOCyjxCMOQ
	tfxRItSHIpHosgRoQAa9maqOUMKEhYx4=
X-Google-Smtp-Source: AGHT+IFBi4foYHAxmU5BEbts5BEj/H+5zlsoTVLd0teYehjXCYtNHa7BIsgXrMBiPdLbDdPTjzWQElkO3PR5kW7Zk30=
X-Received: by 2002:a05:6402:5250:b0:618:b9e:4d46 with SMTP id
 4fb4d7f45d1cf-6180b9e4f32mr6160019a12.6.1754921280990; Mon, 11 Aug 2025
 07:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev> <20250811092659.14903-3-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-3-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 11 Aug 2025 22:07:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
X-Gm-Features: Ac12FXx3wygiT0KUxDdTLKBIqdJd8ge_J4YtkVREbi-861CaXIwjYcJ3xA7tgyU
Message-ID: <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Youling,

On Mon, Aug 11, 2025 at 5:28=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patch adds support for kexec_file on LoongArch.
>
> The image_load() as two parts:
> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> - the second part loads other segments (eg: initrd, cmdline)
>
> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are suppor=
ted,
> but ELF format is not supported.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   8 ++
>  arch/loongarch/include/asm/image.h         |  18 ++++
>  arch/loongarch/include/asm/kexec.h         |  12 +++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>  arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>  7 files changed, 219 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/kernel/kexec_image.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index f0abc38c40ac..fd50c83f7827 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -625,6 +625,14 @@ config CPU_HAS_PREFETCH
>  config ARCH_SUPPORTS_KEXEC
>         def_bool y
>
> +config ARCH_SUPPORTS_KEXEC_FILE
> +       def_bool 64BIT
> +
> +config ARCH_SELECTS_KEXEC_FILE
> +       def_bool y
> +       depends on KEXEC_FILE
> +       select HAVE_IMA_KEXEC if IMA
> +
>  config ARCH_SUPPORTS_CRASH_DUMP
>         def_bool y
>
> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/=
asm/image.h
> index 1f090736e71d..829e1ecb1f5d 100644
> --- a/arch/loongarch/include/asm/image.h
> +++ b/arch/loongarch/include/asm/image.h
> @@ -36,5 +36,23 @@ struct loongarch_image_header {
>         uint32_t pe_header;
>  };
>
> +static const uint8_t loongarch_image_pe_sig[2] =3D {'M', 'Z'};
> +static const uint8_t loongarch_pe_machtype[6] =3D {'P', 'E', 0x0, 0x0, 0=
x64, 0x62};
> +
> +/**
> + * loongarch_header_check_pe_sig - Helper to check the loongarch image h=
eader.
> + *
> + * Returns non-zero if 'MZ' signature is found.
> + */
> +
> +static inline int loongarch_header_check_pe_sig(const struct loongarch_i=
mage_header *h)
> +{
> +       if (!h)
> +               return 0;
> +
> +       return (h->pe_sig[0] =3D=3D loongarch_image_pe_sig[0]
> +               && h->pe_sig[1] =3D=3D loongarch_image_pe_sig[1]);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_IMAGE_H */
> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/=
asm/kexec.h
> index cf95cd3eb2de..3ef8517a3670 100644
> --- a/arch/loongarch/include/asm/kexec.h
> +++ b/arch/loongarch/include/asm/kexec.h
> @@ -41,6 +41,18 @@ struct kimage_arch {
>         unsigned long systable_ptr;
>  };
>
> +#ifdef CONFIG_KEXEC_FILE
> +extern const struct kexec_file_ops kexec_image_ops;
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cl=
eanup
> +
> +extern int load_other_segments(struct kimage *image,
> +               unsigned long kernel_load_addr, unsigned long kernel_size=
,
> +               char *initrd, unsigned long initrd_len,
> +               char *cmdline, unsigned long cmdline_len);
I think the RISC-V naming "load_extra_segments" is better.

> +#endif
> +
>  typedef void (*do_kexec_t)(unsigned long efi_boot,
>                            unsigned long cmdline_ptr,
>                            unsigned long systable_ptr,
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 6f5a4574a911..bd9405ee3888 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)     +=3D sysrq.o
>  obj-$(CONFIG_RELOCATABLE)      +=3D relocate.o
>
>  obj-$(CONFIG_KEXEC_CORE)       +=3D machine_kexec.o relocate_kernel.o
> +obj-$(CONFIG_KEXEC_FILE)       +=3D machine_kexec_file.o kexec_image.o
We only support the efi format, so we don't need to split a
kexec_image.c like RISC-V, just put everything into
machine_kexec_file.c is OK.

Huacai

>  obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
>
>  obj-$(CONFIG_UNWINDER_GUESS)   +=3D unwind_guess.o
> diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/=
kexec_image.c
> new file mode 100644
> index 000000000000..fdd1845b4e2e
> --- /dev/null
> +++ b/arch/loongarch/kernel/kexec_image.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec image loader for LoongArch
> +
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + */
> +
> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/pe.h>
> +#include <linux/string.h>
> +#include <asm/byteorder.h>
> +#include <asm/cpufeature.h>
> +#include <asm/image.h>
> +
> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +       const struct loongarch_image_header *h =3D
> +               (const struct loongarch_image_header *)(kernel_buf);
> +
> +       if (!h || (kernel_len < sizeof(*h))) {
> +               pr_err("No loongarch image header.\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!loongarch_header_check_pe_sig(h)) {
> +               pr_err("Bad loongarch PE image header.\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void *image_load(struct kimage *image,
> +                               char *kernel, unsigned long kernel_len,
> +                               char *initrd, unsigned long initrd_len,
> +                               char *cmdline, unsigned long cmdline_len)
> +{
> +       struct loongarch_image_header *h;
> +       struct kexec_buf kbuf;
> +       unsigned long text_offset, kernel_segment_number;
> +       struct kexec_segment *kernel_segment;
> +       int ret;
> +
> +       h =3D (struct loongarch_image_header *)kernel;
> +       if (!h->image_size)
> +               return ERR_PTR(-EINVAL);
> +
> +       /* Load the kernel */
> +       kbuf.image =3D image;
> +       kbuf.buf_min =3D 0;
> +       kbuf.buf_max =3D ULONG_MAX;
> +       kbuf.top_down =3D false;
> +
> +       kbuf.buffer =3D kernel;
> +       kbuf.bufsz =3D kernel_len;
> +       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +       kbuf.memsz =3D le64_to_cpu(h->image_size);
> +       text_offset =3D le64_to_cpu(h->text_offset);
> +       kbuf.buf_align =3D SZ_2M;
> +
> +       kernel_segment_number =3D image->nr_segments;
> +
> +       /*
> +        * The location of the kernel segment may make it impossible to s=
atisfy
> +        * the other segment requirements, so we try repeatedly to find a
> +        * location that will work.
> +        */
> +       while ((ret =3D kexec_add_buffer(&kbuf)) =3D=3D 0) {
> +               /* Try to load additional data */
> +               kernel_segment =3D &image->segment[kernel_segment_number]=
;
> +               ret =3D load_other_segments(image, kernel_segment->mem,
> +                                         kernel_segment->memsz, initrd,
> +                                         initrd_len, cmdline, cmdline_le=
n);
> +               if (!ret)
> +                       break;
> +
> +               /*
> +                * We couldn't find space for the other segments; erase t=
he
> +                * kernel segment and try the next available hole.
> +                */
> +               image->nr_segments -=3D 1;
> +               kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
> +               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +       }
> +
> +       if (ret) {
> +               pr_err("Could not find any suitable kernel location!");
> +               return ERR_PTR(ret);
> +       }
> +
> +       kernel_segment =3D &image->segment[kernel_segment_number];
> +
> +       /* Make sure the second kernel jumps to the correct "kernel_entry=
". */
> +       image->start =3D kernel_segment->mem + h->kernel_entry - text_off=
set;
> +
> +       kexec_dprintk("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx=
\n",
> +                     kernel_segment->mem, kbuf.bufsz,
> +                     kernel_segment->memsz);
> +
> +       return NULL;
> +}
> +
> +const struct kexec_file_ops kexec_image_ops =3D {
> +       .probe =3D image_probe,
> +       .load =3D image_load,
> +};
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index f9381800e291..008f43e26120 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
>         kimage->arch.efi_boot =3D fw_arg0;
>         kimage->arch.systable_ptr =3D fw_arg2;
>
> -       /* Find the command line */
> -       for (i =3D 0; i < kimage->nr_segments; i++) {
> -               if (!strncmp(bootloader, (char __user *)kimage->segment[i=
].buf, strlen(bootloader))) {
> -                       if (!copy_from_user(cmdline_ptr, kimage->segment[=
i].buf, COMMAND_LINE_SIZE))
> -                               kimage->arch.cmdline_ptr =3D (unsigned lo=
ng)cmdline_ptr;
> -                       break;
> +       if (kimage->file_mode =3D=3D 1) {
> +               /*
> +                * kimage->cmdline_buf will be released in kexec_file_loa=
d, so copy to
> +                * the KEXEC_CMDLINE_ADDR safe area.
> +                */
> +               memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arch.c=
mdline_ptr,
> +                                       strlen((char *)kimage->arch.cmdli=
ne_ptr) + 1);
> +               kimage->arch.cmdline_ptr =3D (unsigned long)KEXEC_CMDLINE=
_ADDR;
> +       } else {
> +               /* Find the command line */
> +               for (i =3D 0; i < kimage->nr_segments; i++) {
> +                       if (!strncmp(bootloader, (char __user *)kimage->s=
egment[i].buf, strlen(bootloader))) {
> +                               if (!copy_from_user(cmdline_ptr, kimage->=
segment[i].buf, COMMAND_LINE_SIZE))
> +                                       kimage->arch.cmdline_ptr =3D (uns=
igned long)cmdline_ptr;
> +                               break;
> +                       }
>                 }
> -       }
>
> -       if (!kimage->arch.cmdline_ptr) {
> -               pr_err("Command line not included in the provided image\n=
");
> -               return -EINVAL;
> +               if (!kimage->arch.cmdline_ptr) {
> +                       pr_err("Command line not included in the provided=
 image\n");
> +                       return -EINVAL;
> +               }
>         }
>
>         /* kexec/kdump need a safe page to save reboot_code_buffer */
> @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
>         local_irq_disable();
>
>         pr_notice("EFI boot flag 0x%lx\n", efi_boot);
> -       pr_notice("Command line at 0x%lx\n", cmdline_ptr);
> +       pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
> +       pr_notice("Command line at %s\n", (char *)cmdline_ptr);
>         pr_notice("System table at 0x%lx\n", systable_ptr);
>         pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>         pr_notice("Bye ...\n");
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> new file mode 100644
> index 000000000000..bc91ae0afa4c
> --- /dev/null
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * kexec_file for LoongArch
> + *
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + *
> + * Most code is derived from LoongArch port of kexec-tools
> + */
> +
> +#define pr_fmt(fmt) "kexec_file: " fmt
> +
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/memblock.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/vmalloc.h>
> +#include <asm/bootinfo.h>
> +
> +const struct kexec_file_ops * const kexec_file_loaders[] =3D {
> +       &kexec_image_ops,
> +       NULL
> +};
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +       vfree(image->elf_headers);
> +       image->elf_headers =3D NULL;
> +       image->elf_headers_sz =3D 0;
> +
> +       return kexec_image_post_load_cleanup_default(image);
> +}
> +
> +int load_other_segments(struct kimage *image,
> +                       unsigned long kernel_load_addr,
> +                       unsigned long kernel_size,
> +                       char *initrd, unsigned long initrd_len,
> +                       char *cmdline, unsigned long cmdline_len)
> +{
> +       image->arch.cmdline_ptr =3D (unsigned long)cmdline;
> +
> +       return 0;
> +}
> --
> 2.34.1
>

