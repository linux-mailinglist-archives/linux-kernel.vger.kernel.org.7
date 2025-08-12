Return-Path: <linux-kernel+bounces-764119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22068B21E43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E081906E08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377F2D3ED7;
	Tue, 12 Aug 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="D3qGPFXh"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6EB2C21E3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979981; cv=none; b=MzoXcRQ5jRSw8k3Iy/EfQJk5NqSoTnTrWtB4CTuy3/HvYyDFcKzItoOT1kNMtNnoaY/b2CrMKTQOPoXgMyvcGI/PCbvGa71kr550ZVjBhPTRI8j67w3/qgYMvsxbQ/PXo/7oWkqzAFAlgxktAXDiTQuY7H/H0oVluMKWMMjkKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979981; c=relaxed/simple;
	bh=o2OqDw7n5r920iRkQ3j3ACHBg5pyQbHlMjYQxfJsnm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBN4rqoOsOKIg4p838CWxi582OOhMUronwE5G0kwiukDDaGMSlvXwocxP3g9zdMa01S2ebPnUM1plwxsnUmqR3gJRNBMmQh/Ebo6QpBmN3WaPSasDEk2CXETijye6JwEMXLhLBm08PtpAkwEDLRnBRPykUJYNtsNfJxZG/EDFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=D3qGPFXh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3840F25C35;
	Tue, 12 Aug 2025 08:26:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OBZHdVsZLZlm; Tue, 12 Aug 2025 08:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754979970; bh=o2OqDw7n5r920iRkQ3j3ACHBg5pyQbHlMjYQxfJsnm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D3qGPFXhn4i/FPlSl6+s6RyHnduwgt2nrWJmIkk/awjzSfgJyi2mU/WrieGYVRjOh
	 mSUnxxTgUEla34qTIa6goSXqlJOZnmq/HXai4RDIvQFw4wejlEzVjm6uHnX/w1cr6e
	 bAjASzGD0mkbgFtYtmay/MLLWQrpow1s1wDm+HiWniO3sxV4LYgI5s/8iSugUjNrgH
	 KULv7fwdmhBsWEckGjjmZMkeBERMOjrtr2rW7PG1YSTW61ost5f9WjLlyLBurOyG+1
	 DmT1MP8ndmEPShPKd1pWma8/0ZCXVEhK/hNOefKoIXUfmwtclkgsD5Zw77lGCR38Xo
	 dKp8Gx3jAl8pg==
Date: Tue, 12 Aug 2025 06:25:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
Message-ID: <aJredf2InXhHY7ek@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev>
 <aJovKIKFqX6xi9ra@pie>
 <0767b8fe-7c04-4e73-9235-ee326ee058cc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0767b8fe-7c04-4e73-9235-ee326ee058cc@linux.dev>

On Tue, Aug 12, 2025 at 12:05:30PM +0800, Youling Tang wrote:
> Hi, Yao
> On 2025/8/12 01:58, Yao Zi wrote:
> > On Mon, Aug 11, 2025 at 05:26:56PM +0800, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > > 
> > > Add inird loading support and pass it to the second kernel via the
> > > cmdline 'initrd=start,size'.
> > I think This won't work if the exec'ed kernel enables
> > CONFIG_CMDLINE_FORCE. Is it possible to mimic libstub's behavior of
> > installing a configuration table LINUX_EFI_INITRD_MEDIA_GUID?
> The command line passed by kexec to the second kernel has no effect if
> CONFIG_CMDLINE_FORCE is enabled, which is not quite suitable for the
> kexec scenario.
> 
> Currently, the initrd, elfcorehdr, and mem parameters will all be passed
> through the command line to maintain consistency with the implementation
> behavior of kexec-tools. It is possible that the content of systab will
> be modified in the future and some parts will be integrated into systab
> (the current cmdline mode will be better compatible with the elf kernel).
> > 
> > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > ---
> > >   arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
> > >   1 file changed, 71 insertions(+)
> > > 
> > > diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> > > index bc91ae0afa4c..e1240644f529 100644
> > > --- a/arch/loongarch/kernel/machine_kexec_file.c
> > > +++ b/arch/loongarch/kernel/machine_kexec_file.c
> > > @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > >   	return kexec_image_post_load_cleanup_default(image);
> > >   }
> > > +/* Adds the "initrd=start,size" command line parameter to command line. */
> > > +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
> > > +				char *modified_cmdline, unsigned long initrd)
> > > +{
> > > +	int initrd_strlen;
> > > +
> > > +	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
> > modified_cmdline is allocated as COMMAND_LINE_SIZE bytes, thus I think
> > it's possible to overflow the buffer.
> At this point, modified_cmdline can clearly know that it only stores
> the additional commands we add (initrd,mem,elfcorehdr), and will not
> exceed COMMAND_LINE_SIZE.
> > 
> > > +		initrd, image->initrd_buf_len);
> > > +	*cmdline_tmplen += initrd_strlen;
> > > +}
> > > +
> > > +/*
> > > + * Tries to add the initrd to the image. If it is not possible to find
> > > + * valid locations, this function will undo changes to the image and return non
> > > + * zero.
> > > + */
> > >   int load_other_segments(struct kimage *image,
> > >   			unsigned long kernel_load_addr,
> > >   			unsigned long kernel_size,
> > >   			char *initrd, unsigned long initrd_len,
> > >   			char *cmdline, unsigned long cmdline_len)
> > >   {
> > > +	struct kexec_buf kbuf;
> > > +	unsigned long orig_segments = image->nr_segments;
> > > +	char *modified_cmdline = NULL;
> > > +	unsigned long cmdline_tmplen = 0;
> > > +	unsigned long initrd_load_addr = 0;
> > > +	int ret = 0;
> > > +
> > > +
> > > +	kbuf.image = image;
> > > +	/* not allocate anything below the kernel */
> > > +	kbuf.buf_min = kernel_load_addr + kernel_size;
> > > +
> > > +	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> > > +	if (!modified_cmdline)
> > > +		return -EINVAL;
> > > +
> > > +	/* Ensure it's nul terminated */
> > > +	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
> > > +
> > > +	/* load initrd */
> > > +	if (initrd) {
> > > +		kbuf.buffer = initrd;
> > > +		kbuf.bufsz = initrd_len;
> > > +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > +		kbuf.memsz = initrd_len;
> > > +		kbuf.buf_align = 0;
> > > +		/* within 1GB-aligned window of up to 32GB in size */
> > > +		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
> > > +						+ (unsigned long)SZ_1G * 32;
> > > +		kbuf.top_down = false;
> > > +
> > > +		ret = kexec_add_buffer(&kbuf);
> > > +		if (ret)
> > > +			goto out_err;
> > > +		initrd_load_addr = kbuf.mem;
> > > +
> > > +		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > > +			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> > > +
> > > +		/* Add the initrd=start,size parameter to the command line */
> > > +		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
> > > +	}
> > > +
> > > +	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> > It's too later to check for overflowing here, where the data after
> > modified_cmdline may already be overwritten.
> At this point, we append the original command line to modified_cmdline,
> so it is appropriate to determine whether the command line length exceeds
> the limit.

Thanks, I misunderstood the code logic: before cmdline_add_initrd
appends new arguments, modified_cmdline is empty instead of containing
a copy of cmdline, so this is fine. Sorry for the noise.

Best regards,
Yao Zi

