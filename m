Return-Path: <linux-kernel+bounces-763351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD1B213C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B0A3B66DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0D2D47F3;
	Mon, 11 Aug 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LX3nddLI"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915B1D2F42
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935148; cv=none; b=fK3/XuKByKMileaVOdDSN9sG7NSmm47ObZeuYKWnYWGuKn4pCggOgm5UNeQ0ZWdw+IZG3bSwDLTJ3kNXZkmrr7obSNU/n5+r4hJzrTD8LNtiZh6D0TXAAFhS2g6IQLlccVe/hNs6Mxd2wMFcvwc4IXW9+wi4efyKE96WkkE17lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935148; c=relaxed/simple;
	bh=5IrkZTtsgWCXjSHQu/naac3Uo1zbNi01U44yoOk6NqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC4TLC7IA1VDilYi9imNucw91KOTw59jWNOS32WWrs/dhlodcvDT0r7ISZau1zEY0KbxD/v5rbFQck40jI3s5ptEKmLbrSeXgHZCE/FrgN1K/taVMXj87qopM7Xn4vbZep4GpNLF46GN7f0S7/smD7mbDYSoXAM5mH8sl/+o908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LX3nddLI; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0426C21B02;
	Mon, 11 Aug 2025 19:59:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EjxmdH4iwM9G; Mon, 11 Aug 2025 19:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754935102; bh=5IrkZTtsgWCXjSHQu/naac3Uo1zbNi01U44yoOk6NqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LX3nddLIxM6PFJvSRQwrny2CdEJXN70Bi1TI3F5riMwPM4v4mM/cYzmS/oBqxMhyw
	 l8CN3KYcQc2LyMq/Ee+gtYNLfk8QO1fiKndHRDLeq5XKhDPGCdcEimI+CCAGdQzdXA
	 WvYv4onIzhBgoGmExJoichZyRQeotnBmmtgMWf23N2GRMFiYTwguqjeKo2+0ERs39h
	 7xiva9IG1nGTD5ekb0b3w3c9beqmcQPpJ9LilI/sFikmCIZvWAyN4znEd/iJvFWCDt
	 3btP5O61ERiKG5zucJB1IiIDN2igm2IS3G+yhzTwPjiv1qQ+MjnwR5WgES9VFBn9Kr
	 Ubl8hG4lXGp+g==
Date: Mon, 11 Aug 2025 17:58:00 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
Message-ID: <aJovKIKFqX6xi9ra@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092659.14903-4-youling.tang@linux.dev>

On Mon, Aug 11, 2025 at 05:26:56PM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Add inird loading support and pass it to the second kernel via the
> cmdline 'initrd=start,size'.

I think This won't work if the exec'ed kernel enables
CONFIG_CMDLINE_FORCE. Is it possible to mimic libstub's behavior of
installing a configuration table LINUX_EFI_INITRD_MEDIA_GUID?

>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index bc91ae0afa4c..e1240644f529 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return kexec_image_post_load_cleanup_default(image);
>  }
>  
> +/* Adds the "initrd=start,size" command line parameter to command line. */
> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
> +				char *modified_cmdline, unsigned long initrd)
> +{
> +	int initrd_strlen;
> +
> +	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",

modified_cmdline is allocated as COMMAND_LINE_SIZE bytes, thus I think
it's possible to overflow the buffer.

> +		initrd, image->initrd_buf_len);
> +	*cmdline_tmplen += initrd_strlen;
> +}
> +
> +/*
> + * Tries to add the initrd to the image. If it is not possible to find
> + * valid locations, this function will undo changes to the image and return non
> + * zero.
> + */
>  int load_other_segments(struct kimage *image,
>  			unsigned long kernel_load_addr,
>  			unsigned long kernel_size,
>  			char *initrd, unsigned long initrd_len,
>  			char *cmdline, unsigned long cmdline_len)
>  {
> +	struct kexec_buf kbuf;
> +	unsigned long orig_segments = image->nr_segments;
> +	char *modified_cmdline = NULL;
> +	unsigned long cmdline_tmplen = 0;
> +	unsigned long initrd_load_addr = 0;
> +	int ret = 0;
> +
> +
> +	kbuf.image = image;
> +	/* not allocate anything below the kernel */
> +	kbuf.buf_min = kernel_load_addr + kernel_size;
> +
> +	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> +	if (!modified_cmdline)
> +		return -EINVAL;
> +
> +	/* Ensure it's nul terminated */
> +	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
> +
> +	/* load initrd */
> +	if (initrd) {
> +		kbuf.buffer = initrd;
> +		kbuf.bufsz = initrd_len;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +		kbuf.memsz = initrd_len;
> +		kbuf.buf_align = 0;
> +		/* within 1GB-aligned window of up to 32GB in size */
> +		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
> +						+ (unsigned long)SZ_1G * 32;
> +		kbuf.top_down = false;
> +
> +		ret = kexec_add_buffer(&kbuf);
> +		if (ret)
> +			goto out_err;
> +		initrd_load_addr = kbuf.mem;
> +
> +		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> +
> +		/* Add the initrd=start,size parameter to the command line */
> +		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
> +	}
> +
> +	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {

It's too later to check for overflowing here, where the data after
modified_cmdline may already be overwritten.

> +		pr_err("Appending kdump cmdline exceeds cmdline size\n");

I think load_other_segments could be invoked without kdump involved. If
that's correct, this message is inaccurate.

> +		ret = -EINVAL;
> +		goto out_err;
> +	}

Regards,
Yao Zi

> +	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
> +	cmdline = modified_cmdline;
>  	image->arch.cmdline_ptr = (unsigned long)cmdline;
>  
>  	return 0;
> +
> +out_err:
> +	image->nr_segments = orig_segments;
> +	kfree(modified_cmdline);
> +	return ret;
>  }
> -- 
> 2.34.1
> 
> 

