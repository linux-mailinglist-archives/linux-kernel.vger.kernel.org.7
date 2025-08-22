Return-Path: <linux-kernel+bounces-781096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B561DB30D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EFFAC7421
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341628B407;
	Fri, 22 Aug 2025 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SFACTXNi"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B0287514
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836382; cv=none; b=QuKjy9IVVPtYiDgzoajlgmOErWzKtF0NCJ1hMZ1les9D4yNPiftg8+7Et4ijzmNhd7bxf1L/f3lwMIkQOIiCENkVBv/D0ssG67grYcei8S0cX28cHvRPMCmNXCGv4IbWg5PBWCIsI81YEbU1nv79lDnoUHheoPFynn4zmj5IWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836382; c=relaxed/simple;
	bh=IIZxIcx+VM9Ab1JBZUZhZx0zb2Ztx2e+P4nlRyHfZLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErAC2sGjWMoVaNSQySMkJ54QA9kDJ2LCUqwehT4fjYKhDUQiq8PD+yJ0qANwDfwYOta+7YEIHeDJUZZPoWG1jQsEuERLLJLqU0JlEYv7CbVncTkHaBGd3kEBBthV8BS05P2cepDllo9TT1hQfZ+N6xee9sk770aiqwx5FissW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SFACTXNi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 377E22600C;
	Fri, 22 Aug 2025 06:19:32 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bio1E6EwgHOZ; Fri, 22 Aug 2025 06:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755836370; bh=IIZxIcx+VM9Ab1JBZUZhZx0zb2Ztx2e+P4nlRyHfZLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFACTXNitBQo9+gWUltgn2IGHXCF2nSNW/ai54B8OVEORXzKhpl3Uw6VswaUWF74v
	 VbHyHO5W5RSv/DMgOK7O0nk/FigLH0nehkqp9t/fqhlx/Vvw90n5VuOciO8ju2cVmZ
	 G0IdL5wTfh4d7Wn6Wc0NpELaGV/6j53yxkVflIIYntJmj0Jg2WO4PtjsrXZgDCq3cF
	 bI4kDrwHI54LLM7Kg0eeva7T7exTUHCJZ/0RVhzgpZkMn/XfdxXil4tBxKUoNPS1jB
	 1czB+c7Sgk4kiORWcgAgx3x8iasfxXaVY9j6zvCtaDAYiNMq/8gHouKtdVhU0jBKIT
	 U/eN0bH+Z0+CA==
Date: Fri, 22 Aug 2025 04:19:09 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
Message-ID: <aKfvvYVyBEkrDp9I@pie>
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev>
 <aKVwHOM9KNEpUZF4@pie>
 <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev>
 <a15ad5bd-f54d-466c-8bdd-6f5b5936abee@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a15ad5bd-f54d-466c-8bdd-6f5b5936abee@linux.dev>

On Fri, Aug 22, 2025 at 10:56:18AM +0800, Youling Tang wrote:
> On 2025/8/20 17:13, Youling Tang wrote:
> 
> > Hi, Yao
> > 
> > On 2025/8/20 14:50, Yao Zi wrote:
> > 
> > > On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
> > > > From: Youling Tang <tangyouling@kylinos.cn>
> > > > 
> > > > This patch adds support for kexec_file on LoongArch.
> > > > 
> > > > The efi_kexec_load() as two parts:
> > > > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > > > - the second part loads other segments (eg: initrd, cmdline)
> > > > 
> > > > This initrd will be passed to the second kernel via the command line
> > > > 'initrd=start,size'.
> > > > 
> > > > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images
> > > > are supported,
> > > > but ELF format is not supported.
> > > > 
> > > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > > ---
> > > >   arch/loongarch/Kconfig                     |   9 ++
> > > >   arch/loongarch/include/asm/image.h         |  17 +++
> > > >   arch/loongarch/include/asm/kexec.h         |  12 +++
> > > >   arch/loongarch/kernel/Makefile             |   1 +
> > > >   arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
> > > >   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> > > >   arch/loongarch/kernel/machine_kexec_file.c | 117
> > > > +++++++++++++++++++++
> > > >   7 files changed, 289 insertions(+), 11 deletions(-)
> > > >   create mode 100644 arch/loongarch/kernel/kexec_efi.c
> > > >   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> > > ...
> > > 
> > > > diff --git a/arch/loongarch/include/asm/image.h
> > > > b/arch/loongarch/include/asm/image.h
> > > > index 1f090736e71d..655d5836c4e8 100644
> > > > --- a/arch/loongarch/include/asm/image.h
> > > > +++ b/arch/loongarch/include/asm/image.h
> > > > @@ -36,5 +36,22 @@ struct loongarch_image_header {
> > > >       uint32_t pe_header;
> > > >   };
> > > >   +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
> > > > +
> > > > +/**
> > > > + * loongarch_header_check_pe_sig - Helper to check the
> > > > loongarch image header.
> > > > + *
> > > > + * Returns non-zero if 'MZ' signature is found.
> > > > + */
> > > > +
> > > > +static inline int loongarch_header_check_pe_sig(const struct
> > > > loongarch_image_header *h)
> > > > +{
> > > > +    if (!h)
> > > > +        return 0;
> > > > +
> > > > +    return (h->pe_sig[0] == loongarch_image_pe_sig[0]
> > > > +        && h->pe_sig[1] == loongarch_image_pe_sig[1]);
> > > > +}
> > > This check is still too weak and doesn't improve comparing to v1.
> > > 
> > > > This could be simplified with a memcmp(). Also, this check isn't
> > > > strict enough: PE files for any architectures, and even legacy MS-DOS
> > > > COM executables all start with "MZ".
> > > I've pointed this out in my previous reply[1].
> > Previously, I had considered adding a specific LoongArch magic
> > number (such as "Loongson") in the loongarch_image_header, but
> > this is incompatible with older versions of the kernel, so it
> > remains the same without further checks.
> > > 
> > > >   #endif /* __ASSEMBLY__ */
> > > >   #endif /* __ASM_IMAGE_H */
> > > ...
> > > 
> > > > diff --git a/arch/loongarch/kernel/kexec_efi.c
> > > > b/arch/loongarch/kernel/kexec_efi.c
> > > > new file mode 100644
> > > > index 000000000000..7741f1139a12
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/kernel/kexec_efi.c
> > > ...
> > > 
> > > > +static void *efi_kexec_load(struct kimage *image,
> > > > +                char *kernel, unsigned long kernel_len,
> > > > +                char *initrd, unsigned long initrd_len,
> > > > +                char *cmdline, unsigned long cmdline_len)
> > > > +{
> > > > +    struct loongarch_image_header *h;
> > > > +    struct kexec_buf kbuf;
> > > > +    unsigned long text_offset, kernel_segment_number;
> > > > +    struct kexec_segment *kernel_segment;
> > > > +    int ret;
> > > > +
> > > > +    h = (struct loongarch_image_header *)kernel;
> > > > +    if (!h->image_size)
> > > > +        return ERR_PTR(-EINVAL);
> > > > +
> > > > +    /* Load the kernel */
> > > > +    kbuf.image = image;
> > > > +    kbuf.buf_max = ULONG_MAX;
> > > > +    kbuf.top_down = false;
> > > > +
> > > > +    kbuf.buffer = kernel;
> > > > +    kbuf.bufsz = kernel_len;
> > > > +    kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > > +    kbuf.memsz = le64_to_cpu(h->image_size);
> > > > +    text_offset = le64_to_cpu(h->text_offset);
> > > > +    kbuf.buf_min = text_offset;
> > > > +    kbuf.buf_align = SZ_2M;
> > > > +
> > > > +    kernel_segment_number = image->nr_segments;
> > > > +
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
> > > And this still assumes the loaded, secondary kernel is relocatable,
> > > with neither extra check nor comment explaining its limitation.
> > > 
> > > Please see my previous reply[2] that explains why loading a
> > > non-relocatble kernel with kexec_file API is reasonable.
> > LoongArch is a non-position independent (non-PIE) kernel when
> > the RELOCATABLE option is not enabled, the kernel contains certain
> > instructions such as la.abs, which prevent it from being relocated to
> > arbitrary memory addresses for execution. As a result, limitations
> > exist that make features like kdump or kexec_file dependent on
> > the RELOCATABLE option.
> > 
> > Strictly speaking, we need to add additional checks: if the kernel is
> > non-relocatable, the loading operation should fail directly. For a
> > running kernel, we can easily determine this by calling
> > kallsyms_lookup_name("relocate_kernel"). However, for a kernel
> > that is being loaded but has not yet started execution, it is difficult
> > to easily determine whether the currently loaded kernel has the
> > RELOCATABLE configuration option enabled.
> > 
> > For ELF format images, we can determine whether the loaded image
> > contains the ".la_abs" section in the following way:
> > static struct mem_shdr *laabs_section(const struct mem_ehdr *ehdr)
> > {
> >         struct mem_shdr *shdr, *shdr_end;
> >         unsigned char *strtab;
> > 
> >         strtab = (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh_data;
> >         shdr_end = &ehdr->e_shdr[ehdr->e_shnum];
> >         for (shdr = ehdr->e_shdr; shdr != shdr_end; shdr++) {
> >                 if (shdr->sh_size &&
> >                         strcmp((char *)&strtab[shdr->sh_name],
> > ".la_abs") == 0) {
> >                         return shdr;
> >                 }
> >         }
> > 
> >         return NULL;
> > }
> I attempted to parse the pe header to obtain the sections information
> and found that there were only two sections, '.text' and '.data'. We
> cannot parse whether there is a '.la_abs' section like in the ELF format.

I think it's fine to just leave a comment indicating this doesn't work
with non-relocatable kernels for now.

Best regards,
Yao Zi

> The reason is that when generating vmlinux.efi, when the ELF vmlinux
> is converted to the original binary file through the 'objdump -O binary'
> operation (arch/loongarch/boot/Makefile), the remaining sections are
> merged into the '.text' and '.data' sections.
> 
> Youling.
> > 
> > Thanks,
> > Youling.
> > > 
> > > > +    kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > > > +              kernel_segment->mem, kbuf.bufsz,
> > > > +              kernel_segment->memsz);
> > > > +
> > > > +    return NULL;
> > > > +}
> > > > +
> > > > +const struct kexec_file_ops kexec_efi_ops = {
> > > > +    .probe = efi_kexec_probe,
> > > > +    .load = efi_kexec_load,
> > > > +};
> > > Thanks,
> > > Yao Zi
> > > 
> > > [1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
> > > [2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/
> 

