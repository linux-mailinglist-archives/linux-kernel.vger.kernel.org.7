Return-Path: <linux-kernel+bounces-781102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C5B30D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CE25A3945
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A3328B3E7;
	Fri, 22 Aug 2025 04:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HViUmzux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3C199230
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836677; cv=none; b=cy4D8OpbjBu2gR7rd9OCvOL2AuEaUIYYeEUMHQdxQ6SAKB+Gp0nFk3I/B41Mm9oJQ4a+EXhouEZQZPl2WL77g4DLmtCO9HQuso4boVJrbtUjXYfYam4F1s8dU8ar+m1KX/2Zrws7XmGLaakXhzr6J6whsg61zcHLBneiwPd3moQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836677; c=relaxed/simple;
	bh=hdLoUiaBln2CymuyFiOoxDrvSdJ66u+W+Zz2ftDs/sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3PvMi/YkYczuomxinRl3ydHWOtj6xVLG/AVWYPTKTaQKSdm3iz4ODQooYe/l/AxERf6wLmbYmq/JePxMztQWdFr3nptw6dmDTfXgW3mpyow85c3gtDIzGhTCnjkgFYVoYW6KxrNDIqgqdh/KQBxabatXRQ9bPoErTa7Bv6P4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HViUmzux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6317FC116B1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755836676;
	bh=hdLoUiaBln2CymuyFiOoxDrvSdJ66u+W+Zz2ftDs/sw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HViUmzux+L3CSQ5OI5x5mjezVk8X6RXATvD4SScmPhIxMtkiNnPzOSTiCAZQnGc6w
	 12yO6RO6lg83om+Ol7U20Hg19fVN+7bQvA7bW5jNA/qyrad8MmLE7QgbFc64lGLqeJ
	 A8YjAFPBysqMiWCZjUL/mcZwslpyUizXcn3nh45ZxsuFs9vox4m6ulJQfdZQlw7RAk
	 V+Se4folcGspnc40Lw415v2wZWTDS6XVN9lKAecx0l7twkI/zIPidyEUrq1Ync3spf
	 WZo8vDjBB71txDVEY2+s1j/3l0nb/fRI5uBHnWiE4OeAh1J7c806ji4xp4oN0rKvvW
	 +68FJUPGkdBTw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso3259910a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:24:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnh5qTeef351SzuyNtUiRxB1IxpWnb0J29fvsTjLpJng40aK/NQPF5bxv8FleOeXyq1qOVp0Ri/aD7mPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyORAlXs3+XG9fzM4GJKozkMg0+FL4ndot4cihjwNwgl2TaeSh
	xnK7ptl9KATc1R/LCFIRPFihG1rLnz25Y4hzTtw5yeTjP7xwvbPe4WVJA79NREBr/VnjhP8wvin
	ivzPI6ZwjPieYi2BBRuF2J64eXencCnQ=
X-Google-Smtp-Source: AGHT+IHqs2pTkwgnH9/nSe+JpzBsNJVcaFHlAqfyAEAHmVa871mLL0ucnP3YWPNa5R1jHM7EdP/XNH3A/HhSkS/3jGg=
X-Received: by 2002:a05:6402:270c:b0:61b:fabb:6d0e with SMTP id
 4fb4d7f45d1cf-61c1b705498mr1253509a12.19.1755836674942; Thu, 21 Aug 2025
 21:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev> <aKVwHOM9KNEpUZF4@pie>
 <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev> <aKWt63S_wD3zeMYU@pie> <00a013bd-f30f-4b13-8019-f97a4d2eabb2@linux.dev>
In-Reply-To: <00a013bd-f30f-4b13-8019-f97a4d2eabb2@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 Aug 2025 12:24:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7jr4HuizZvNSAnmoo9z8D1Txe1_jnEgWDwWMmu0q8fLg@mail.gmail.com>
X-Gm-Features: Ac12FXz8S1QEwTy9vLsdEgi58FBIWe3h9tyYMzLwsskThXpPLmQNF7Rc6jf_69I
Message-ID: <CAAhV-H7jr4HuizZvNSAnmoo9z8D1Txe1_jnEgWDwWMmu0q8fLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
To: Youling Tang <youling.tang@linux.dev>
Cc: Yao Zi <ziyao@disroot.org>, WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:20=E2=80=AFAM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> On 2025/8/20 19:13, Yao Zi wrote:
>
> > On Wed, Aug 20, 2025 at 05:13:27PM +0800, Youling Tang wrote:
> >> Hi, Yao
> >>
> >> On 2025/8/20 14:50, Yao Zi wrote:
> >>
> >>> On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
> >>>> From: Youling Tang <tangyouling@kylinos.cn>
> >>>>
> >>>> This patch adds support for kexec_file on LoongArch.
> >>>>
> >>>> The efi_kexec_load() as two parts:
> >>>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> >>>> - the second part loads other segments (eg: initrd, cmdline)
> >>>>
> >>>> This initrd will be passed to the second kernel via the command line
> >>>> 'initrd=3Dstart,size'.
> >>>>
> >>>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are s=
upported,
> >>>> but ELF format is not supported.
> >>>>
> >>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> >>>> ---
> >>>>    arch/loongarch/Kconfig                     |   9 ++
> >>>>    arch/loongarch/include/asm/image.h         |  17 +++
> >>>>    arch/loongarch/include/asm/kexec.h         |  12 +++
> >>>>    arch/loongarch/kernel/Makefile             |   1 +
> >>>>    arch/loongarch/kernel/kexec_efi.c          | 111 ++++++++++++++++=
+++
> >>>>    arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> >>>>    arch/loongarch/kernel/machine_kexec_file.c | 117 ++++++++++++++++=
+++++
> >>>>    7 files changed, 289 insertions(+), 11 deletions(-)
> >>>>    create mode 100644 arch/loongarch/kernel/kexec_efi.c
> >>>>    create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> >>> ...
> >>>
> >>>> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/inc=
lude/asm/image.h
> >>>> index 1f090736e71d..655d5836c4e8 100644
> >>>> --- a/arch/loongarch/include/asm/image.h
> >>>> +++ b/arch/loongarch/include/asm/image.h
> >>>> @@ -36,5 +36,22 @@ struct loongarch_image_header {
> >>>>            uint32_t pe_header;
> >>>>    };
> >>>> +static const uint8_t loongarch_image_pe_sig[2] =3D {'M', 'Z'};
> >>>> +
> >>>> +/**
> >>>> + * loongarch_header_check_pe_sig - Helper to check the loongarch im=
age header.
> >>>> + *
> >>>> + * Returns non-zero if 'MZ' signature is found.
> >>>> + */
> >>>> +
> >>>> +static inline int loongarch_header_check_pe_sig(const struct loonga=
rch_image_header *h)
> >>>> +{
> >>>> +  if (!h)
> >>>> +          return 0;
> >>>> +
> >>>> +  return (h->pe_sig[0] =3D=3D loongarch_image_pe_sig[0]
> >>>> +          && h->pe_sig[1] =3D=3D loongarch_image_pe_sig[1]);
> >>>> +}
> >>> This check is still too weak and doesn't improve comparing to v1.
> >>>
> >>>> This could be simplified with a memcmp(). Also, this check isn't
> >>>> strict enough: PE files for any architectures, and even legacy MS-DO=
S
> >>>> COM executables all start with "MZ".
> >>> I've pointed this out in my previous reply[1].
> >> Previously, I had considered adding a specific LoongArch magic
> >> number (such as "Loongson") in the loongarch_image_header, but
> >> this is incompatible with older versions of the kernel, so it
> >> remains the same without further checks.
> > All PE images ship a PE signature with offset 0x3c[1] and you could
> > locate the PE header[2] by the offset provided by
> > loongarch_image_header.pe_header and check its machine field[3], which
> > should be 0x6264 for 64-bit LoongArch executables and 0x6232 for 32-bit
> > ones. At least this ensures it's a LoongArch kernel image.
> I mentioned this judgment to Huacai before. Huacai, what do you think?
> If necessary, I will add this judgment.
I think we can assume that users know what they are doing, so we can
just distinguish an EFI kernel and ELF kernel, no more checking is
necessary.

Huacai

>
> Thanks,
> Youling.
> >
> >>>>    #endif /* __ASSEMBLY__ */
> >>>>    #endif /* __ASM_IMAGE_H */
> >>> ...
> >>>
> >>>> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kern=
el/kexec_efi.c
> >>>> new file mode 100644
> >>>> index 000000000000..7741f1139a12
> >>>> --- /dev/null
> >>>> +++ b/arch/loongarch/kernel/kexec_efi.c
> >>> ...
> >>>
> >>>> +static void *efi_kexec_load(struct kimage *image,
> >>>> +                          char *kernel, unsigned long kernel_len,
> >>>> +                          char *initrd, unsigned long initrd_len,
> >>>> +                          char *cmdline, unsigned long cmdline_len)
> >>>> +{
> >>>> +  struct loongarch_image_header *h;
> >>>> +  struct kexec_buf kbuf;
> >>>> +  unsigned long text_offset, kernel_segment_number;
> >>>> +  struct kexec_segment *kernel_segment;
> >>>> +  int ret;
> >>>> +
> >>>> +  h =3D (struct loongarch_image_header *)kernel;
> >>>> +  if (!h->image_size)
> >>>> +          return ERR_PTR(-EINVAL);
> >>>> +
> >>>> +  /* Load the kernel */
> >>>> +  kbuf.image =3D image;
> >>>> +  kbuf.buf_max =3D ULONG_MAX;
> >>>> +  kbuf.top_down =3D false;
> >>>> +
> >>>> +  kbuf.buffer =3D kernel;
> >>>> +  kbuf.bufsz =3D kernel_len;
> >>>> +  kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >>>> +  kbuf.memsz =3D le64_to_cpu(h->image_size);
> >>>> +  text_offset =3D le64_to_cpu(h->text_offset);
> >>>> +  kbuf.buf_min =3D text_offset;
> >>>> +  kbuf.buf_align =3D SZ_2M;
> >>>> +
> >>>> +  kernel_segment_number =3D image->nr_segments;
> >>>> +
> >>>> +  /*
> >>>> +   * The location of the kernel segment may make it impossible to s=
atisfy
> >>>> +   * the other segment requirements, so we try repeatedly to find a
> >>>> +   * location that will work.
> >>>> +   */
> >>>> +  while ((ret =3D kexec_add_buffer(&kbuf)) =3D=3D 0) {
> >>>> +          /* Try to load additional data */
> >>>> +          kernel_segment =3D &image->segment[kernel_segment_number]=
;
> >>>> +          ret =3D load_other_segments(image, kernel_segment->mem,
> >>>> +                                    kernel_segment->memsz, initrd,
> >>>> +                                    initrd_len, cmdline, cmdline_le=
n);
> >>>> +          if (!ret)
> >>>> +                  break;
> >>>> +
> >>>> +          /*
> >>>> +           * We couldn't find space for the other segments; erase t=
he
> >>>> +           * kernel segment and try the next available hole.
> >>>> +           */
> >>>> +          image->nr_segments -=3D 1;
> >>>> +          kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
> >>>> +          kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >>>> +  }
> >>>> +
> >>>> +  if (ret) {
> >>>> +          pr_err("Could not find any suitable kernel location!");
> >>>> +          return ERR_PTR(ret);
> >>>> +  }
> >>>> +
> >>>> +  kernel_segment =3D &image->segment[kernel_segment_number];
> >>>> +
> >>>> +  /* Make sure the second kernel jumps to the correct "kernel_entry=
". */
> >>>> +  image->start =3D kernel_segment->mem + h->kernel_entry - text_off=
set;
> >>> And this still assumes the loaded, secondary kernel is relocatable,
> >>> with neither extra check nor comment explaining its limitation.
> >>>
> >>> Please see my previous reply[2] that explains why loading a
> >>> non-relocatble kernel with kexec_file API is reasonable.
> >> LoongArch is a non-position independent (non-PIE) kernel when
> >> the RELOCATABLE option is not enabled, the kernel contains certain
> >> instructions such as la.abs, which prevent it from being relocated to
> >> arbitrary memory addresses for execution. As a result, limitations
> >> exist that make features like kdump or kexec_file dependent on
> >> the RELOCATABLE option.
> >>
> >> Strictly speaking, we need to add additional checks: if the kernel is
> >> non-relocatable, the loading operation should fail directly.
> > Agree.
> >
> >> For a
> >> running kernel, we can easily determine this by calling
> >> kallsyms_lookup_name("relocate_kernel"). However, for a kernel
> >> that is being loaded but has not yet started execution, it is difficul=
t
> >> to easily determine whether the currently loaded kernel has the
> >> RELOCATABLE configuration option enabled.
> > I understand the difficulty, thus IMHO a comment is helpful here to
> > remind the reader of lack of relocatability checks.
> >
> > Best regards,
> > Yao Zi
> >
> >> For ELF format images, we can determine whether the loaded image
> >> contains the ".la_abs" section in the following way:
> >> static struct mem_shdr *laabs_section(const struct mem_ehdr *ehdr)
> >> {
> >>          struct mem_shdr *shdr, *shdr_end;
> >>          unsigned char *strtab;
> >>
> >>          strtab =3D (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh=
_data;
> >>          shdr_end =3D &ehdr->e_shdr[ehdr->e_shnum];
> >>          for (shdr =3D ehdr->e_shdr; shdr !=3D shdr_end; shdr++) {
> >>                  if (shdr->sh_size &&
> >>                          strcmp((char *)&strtab[shdr->sh_name], ".la_a=
bs") =3D=3D
> >> 0) {
> >>                          return shdr;
> >>                  }
> >>          }
> >>
> >>          return NULL;
> >> }
> >>
> >> Thanks,
> >> Youling.
> >>>> +  kexec_dprintk("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx=
\n",
> >>>> +                kernel_segment->mem, kbuf.bufsz,
> >>>> +                kernel_segment->memsz);
> >>>> +
> >>>> +  return NULL;
> >>>> +}
> >>>> +
> >>>> +const struct kexec_file_ops kexec_efi_ops =3D {
> >>>> +  .probe =3D efi_kexec_probe,
> >>>> +  .load =3D efi_kexec_load,
> >>>> +};
> >>> Thanks,
> >>> Yao Zi
> >>>
> >>> [1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
> >>> [2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/
> > [1]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#si=
gnature-image-only
> > [2]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#co=
ff-file-header-object-and-image
> > [3]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#ma=
chine-types

