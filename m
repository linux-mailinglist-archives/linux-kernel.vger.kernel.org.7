Return-Path: <linux-kernel+bounces-777034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0517B2D44B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE98F5A3809
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AF32C08D5;
	Wed, 20 Aug 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UtEHQMRl"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807521B9FD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672626; cv=none; b=D+27hWAcgBAYd2N380TeIW3uHP7mkS1P4nISN7cAhdtbjVevVt6Iifb73M/AIblCUVpWO4xIWxykrI4sl4ATQiutTa9HeXRy0NERIQ5iBgKTrWu5N3OfJTiSlI151h19epOIAnVUbhYobaXstFhMv+lnWtX6/uug8p6ZkLEMXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672626; c=relaxed/simple;
	bh=wQ8qM95j2gviU1QGJ8rgqDjbocACb6XZzCLsLaODwvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjbTPtek0Jyd8P6KwH0Uj3YiPwVBm6wJS/4eILSbswvy2OQhHbXcj35AIxMXTF65W4fCdSRGK8dArPYP4uJNxDGY/js+zrkQQodxHiLdMj+bIT1Kbw5mt0na3E3kVYK3wlmo1BrVv81UycsgSmhCtDP6G0Br53ET2TRoOG7LaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UtEHQMRl; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 941A125EFA;
	Wed, 20 Aug 2025 08:50:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fau3ZIC3Npm; Wed, 20 Aug 2025 08:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755672619; bh=wQ8qM95j2gviU1QGJ8rgqDjbocACb6XZzCLsLaODwvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtEHQMRlQ8rFrMqm+LHFQT49TgwWd3va36RPDXBR7xncfCUX10XX4FyWdzKwgt6Lb
	 18LHJZDgky6OaiFfnAxm1KsLWsuTLYCJMqN1Ka2i+xv/shW19/KB2f390u4GIJGm08
	 S77rKKia+72cEmXCIQZkGcrFoWlHBTUuOsqEnUuzaoSCIxwMZJe4e714jmv/SOZ6Ft
	 CRrDb7oKPNGVKhCnefHSoPsp2KvbmCz034WIhxcsZRQBKwu138knkFNElpCtGtkJA0
	 y5o7Ly4URMwyHxBOe9gDM4SraJtw3I2FDSFgZMEOfpCiYDQ5FnuiKYyLRC223Miyak
	 7qjAWxmVGmABw==
Date: Wed, 20 Aug 2025 06:50:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
Message-ID: <aKVwHOM9KNEpUZF4@pie>
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820055700.24344-3-youling.tang@linux.dev>

On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> This patch adds support for kexec_file on LoongArch.
> 
> The efi_kexec_load() as two parts:
> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> - the second part loads other segments (eg: initrd, cmdline)
> 
> This initrd will be passed to the second kernel via the command line
> 'initrd=start,size'.
> 
> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
> but ELF format is not supported.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   9 ++
>  arch/loongarch/include/asm/image.h         |  17 +++
>  arch/loongarch/include/asm/kexec.h         |  12 +++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>  arch/loongarch/kernel/machine_kexec_file.c | 117 +++++++++++++++++++++
>  7 files changed, 289 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/kernel/kexec_efi.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

...

> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
> index 1f090736e71d..655d5836c4e8 100644
> --- a/arch/loongarch/include/asm/image.h
> +++ b/arch/loongarch/include/asm/image.h
> @@ -36,5 +36,22 @@ struct loongarch_image_header {
>  	uint32_t pe_header;
>  };
>  
> +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
> +
> +/**
> + * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
> + *
> + * Returns non-zero if 'MZ' signature is found.
> + */
> +
> +static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
> +{
> +	if (!h)
> +		return 0;
> +
> +	return (h->pe_sig[0] == loongarch_image_pe_sig[0]
> +		&& h->pe_sig[1] == loongarch_image_pe_sig[1]);
> +}

This check is still too weak and doesn't improve comparing to v1.

> This could be simplified with a memcmp(). Also, this check isn't
> strict enough: PE files for any architectures, and even legacy MS-DOS
> COM executables all start with "MZ".

I've pointed this out in my previous reply[1].

>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_IMAGE_H */

...

> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
> new file mode 100644
> index 000000000000..7741f1139a12
> --- /dev/null
> +++ b/arch/loongarch/kernel/kexec_efi.c

...

> +static void *efi_kexec_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	struct loongarch_image_header *h;
> +	struct kexec_buf kbuf;
> +	unsigned long text_offset, kernel_segment_number;
> +	struct kexec_segment *kernel_segment;
> +	int ret;
> +
> +	h = (struct loongarch_image_header *)kernel;
> +	if (!h->image_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Load the kernel */
> +	kbuf.image = image;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	text_offset = le64_to_cpu(h->text_offset);
> +	kbuf.buf_min = text_offset;
> +	kbuf.buf_align = SZ_2M;
> +
> +	kernel_segment_number = image->nr_segments;
> +
> +	/*
> +	 * The location of the kernel segment may make it impossible to satisfy
> +	 * the other segment requirements, so we try repeatedly to find a
> +	 * location that will work.
> +	 */
> +	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
> +		/* Try to load additional data */
> +		kernel_segment = &image->segment[kernel_segment_number];
> +		ret = load_other_segments(image, kernel_segment->mem,
> +					  kernel_segment->memsz, initrd,
> +					  initrd_len, cmdline, cmdline_len);
> +		if (!ret)
> +			break;
> +
> +		/*
> +		 * We couldn't find space for the other segments; erase the
> +		 * kernel segment and try the next available hole.
> +		 */
> +		image->nr_segments -= 1;
> +		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	}
> +
> +	if (ret) {
> +		pr_err("Could not find any suitable kernel location!");
> +		return ERR_PTR(ret);
> +	}
> +
> +	kernel_segment = &image->segment[kernel_segment_number];
> +
> +	/* Make sure the second kernel jumps to the correct "kernel_entry". */
> +	image->start = kernel_segment->mem + h->kernel_entry - text_offset;

And this still assumes the loaded, secondary kernel is relocatable,
with neither extra check nor comment explaining its limitation.

Please see my previous reply[2] that explains why loading a
non-relocatble kernel with kexec_file API is reasonable.

> +	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		      kernel_segment->mem, kbuf.bufsz,
> +		      kernel_segment->memsz);
> +
> +	return NULL;
> +}
> +
> +const struct kexec_file_ops kexec_efi_ops = {
> +	.probe = efi_kexec_probe,
> +	.load = efi_kexec_load,
> +};

Thanks,
Yao Zi

[1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
[2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/

