Return-Path: <linux-kernel+bounces-781033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA8B30C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90D3727C06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666D286889;
	Fri, 22 Aug 2025 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbx5ldeO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8541E48A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833618; cv=none; b=Mjxl8GrFzCr55Aui9+os8cUdz0LjAn3gAd56z958idGmWIp0Lw9KsW3u/xupJGELktlhL4h3qpQu+Bw36D1I8nUK697y8622JTbM153BRPtUMiB0+IS39iKsgUrfO7IMDIDYoOoeBEE7cAM+pqOiwIY/CKdSUsJX9j7yxVS2bJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833618; c=relaxed/simple;
	bh=8ae7BQ/H/X/z4I/Wl0/AJn7VdqEwsqiB6/27yyCXE+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZW66ejL4TiwOOQoeEdIksWLFo+gDZ+Ct4D9rDy0lg7KZKFgh99iTODXGo1wu4axrl5egABEYvhgOmbadnlX4zjsHd31J/XxJxlIQI3uIOXt4wAE5tgjcNZbXtKr9Z5BcJBnlbQamzcT7WeQRMC+ebujTwKb5wQyv+pd7bDZkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kbx5ldeO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755833615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vED3sHUD/eaxwLo5XUmcXYQAR0YhiuGg9wbVZx1Y6yI=;
	b=Kbx5ldeOpZRAf3z8CQNsvgPR/h0bwtPlyceS961nfUtDnVAsLeXGHibIiU87yj1jS4Mbxm
	5HhQERTCx1uZxDH0jxt+kKQdD+zo/R30ufTK1d7vFbGPQtCckzXpaxUGP3vn0rzmiHBYDQ
	tHrJ34Jechif4VOwhEruC6Saa8uFxa0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-AuXN_JCMMFm-2Msz8Mk6JQ-1; Thu,
 21 Aug 2025 23:33:31 -0400
X-MC-Unique: AuXN_JCMMFm-2Msz8Mk6JQ-1
X-Mimecast-MFC-AGG-ID: AuXN_JCMMFm-2Msz8Mk6JQ_1755833609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 999AD195608B;
	Fri, 22 Aug 2025 03:33:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CE29180029E;
	Fri, 22 Aug 2025 03:33:25 +0000 (UTC)
Date: Fri, 22 Aug 2025 11:33:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Brian Mak <makb@juniper.net>
Cc: Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, x86@kernel.org,
	kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Message-ID: <aKflAV8XNjqeu1Dj@MiWiFi-R3L-srv>
References: <20250805211527.122367-1-makb@juniper.net>
 <20250805211527.122367-2-makb@juniper.net>
 <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
 <aKbZ1h5mjtfoFMh8@MiWiFi-R3L-srv>
 <20250821045319.72e81f40e021e54e2131ac44@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821045319.72e81f40e021e54e2131ac44@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/21/25 at 04:53am, Andrew Morton wrote:
> On Thu, 21 Aug 2025 16:33:26 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > On 08/20/25 at 09:47pm, Andrew Morton wrote:
> > > On Tue, 5 Aug 2025 14:15:26 -0700 Brian Mak <makb@juniper.net> wrote:
......snip.....
> ---
> 
>  include/linux/kexec.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/kexec.h~kexec-add-kexec_file_no_cma-as-a-legal-flag
> +++ a/include/linux/kexec.h
> @@ -460,7 +460,8 @@ bool kexec_load_permitted(int kexec_imag
>  
>  /* List of defined/legal kexec file flags */
>  #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
> -				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
> +				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
> +				 KEXEC_FILE_NO_CMA)
>  
>  /* flag to track if kexec reboot is in progress */
>  extern bool kexec_in_progress;

Yeah, this is a good catch and great fix. Without this fix,
kexec_file_load syscall will failed and return '-EINVAL' when
KEXEC_FILE_NO_CMA is specified just as below code shows. So, for this
patch, 

Acked-by: Baoquan He <bhe@redhat.com>


And, by the way, has the user space kexec-tools got the change merged
to allow KEXEC_FILE_NO_CMA specified?

And, Alexander, I am wondering why this is not captured when you test
specifying KEXEC_FILE_NO_CMA case. Or you just skip the no_cma case
testing?

===================================================================
SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd, 
                unsigned long, cmdline_len, const char __user *, cmdline_ptr,
                unsigned long, flags)
{               
        int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
                         KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
        struct kimage **dest_image, *image;
        int ret = 0, i;

        /* We only trust the superuser with rebooting the system. */
        if (!kexec_load_permitted(image_type))
                return -EPERM;

        /* Make sure we have a legal set of flags */
        if (flags != (flags & KEXEC_FILE_FLAGS))
                return -EINVAL;
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	......
}
=====================================================

> _
> 
> 
> and the second patch I placed in mm-unstable:
> 
> From: Brian Mak <makb@juniper.net>
> Subject: x86/kexec: carry forward the boot DTB on kexec
> Date: Tue, 5 Aug 2025 14:15:27 -0700
> 
> Currently, the kexec_file_load syscall on x86 does not support passing a
> device tree blob to the new kernel.  Some embedded x86 systems use device
> trees.  On these systems, failing to pass a device tree to the new kernel
> causes a boot failure.
> 
> To add support for this, we copy the behavior of ARM64 and PowerPC and
> copy the current boot's device tree blob for use in the new kernel.  We do
> this on x86 by passing the device tree blob as a setup_data entry in
> accordance with the x86 boot protocol.
> 
> This behavior is gated behind the KEXEC_FILE_FORCE_DTB flag.
> 
> Link: https://lkml.kernel.org/r/20250805211527.122367-3-makb@juniper.net
> Signed-off-by: Brian Mak <makb@juniper.net>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Borislav Betkov <bp@alien8.de>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Thomas Gleinxer <tglx@linutronix.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/x86/kernel/kexec-bzimage64.c |   47 ++++++++++++++++++++++++++--
>  include/linux/kexec.h             |    5 ++
>  include/uapi/linux/kexec.h        |    4 ++
>  kernel/kexec_file.c               |    1 
>  4 files changed, 53 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/kernel/kexec-bzimage64.c~x86-kexec-carry-forward-the-boot-dtb-on-kexec
> +++ a/arch/x86/kernel/kexec-bzimage64.c
> @@ -16,6 +16,8 @@
>  #include <linux/kexec.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_fdt.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
>  
> @@ -212,6 +214,28 @@ setup_efi_state(struct boot_params *para
>  }
>  #endif /* CONFIG_EFI */
>  
> +#ifdef CONFIG_OF_FLATTREE
> +static void setup_dtb(struct boot_params *params,
> +		      unsigned long params_load_addr,
> +		      unsigned int dtb_setup_data_offset)
> +{
> +	struct setup_data *sd = (void *)params + dtb_setup_data_offset;
> +	unsigned long setup_data_phys, dtb_len;
> +
> +	dtb_len = fdt_totalsize(initial_boot_params);
> +	sd->type = SETUP_DTB;
> +	sd->len = dtb_len;
> +
> +	/* Carry over current boot DTB with setup_data */
> +	memcpy(sd->data, initial_boot_params, dtb_len);
> +
> +	/* Add setup data */
> +	setup_data_phys = params_load_addr + dtb_setup_data_offset;
> +	sd->next = params->hdr.setup_data;
> +	params->hdr.setup_data = setup_data_phys;
> +}
> +#endif /* CONFIG_OF_FLATTREE */
> +
>  static void
>  setup_ima_state(const struct kimage *image, struct boot_params *params,
>  		unsigned long params_load_addr,
> @@ -336,6 +360,17 @@ setup_boot_parameters(struct kimage *ima
>  			sizeof(struct efi_setup_data);
>  #endif
>  
> +#ifdef CONFIG_OF_FLATTREE
> +	if (image->force_dtb && initial_boot_params) {
> +		setup_dtb(params, params_load_addr, setup_data_offset);
> +		setup_data_offset += sizeof(struct setup_data) +
> +				     fdt_totalsize(initial_boot_params);
> +	} else {
> +		pr_debug("Not carrying over DTB, force_dtb = %d\n",
> +			 image->force_dtb);
> +	}
> +#endif
> +
>  	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
>  		/* Setup IMA log buffer state */
>  		setup_ima_state(image, params, params_load_addr,
> @@ -529,6 +564,12 @@ static void *bzImage64_load(struct kimag
>  				sizeof(struct setup_data) +
>  				RNG_SEED_LENGTH;
>  
> +#ifdef CONFIG_OF_FLATTREE
> +	if (image->force_dtb && initial_boot_params)
> +		kbuf.bufsz += sizeof(struct setup_data) +
> +			      fdt_totalsize(initial_boot_params);
> +#endif
> +
>  	if (IS_ENABLED(CONFIG_IMA_KEXEC))
>  		kbuf.bufsz += sizeof(struct setup_data) +
>  			      sizeof(struct ima_setup_data);
> @@ -537,7 +578,7 @@ static void *bzImage64_load(struct kimag
>  		kbuf.bufsz += sizeof(struct setup_data) +
>  			      sizeof(struct kho_data);
>  
> -	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
> +	params = kvzalloc(kbuf.bufsz, GFP_KERNEL);

Wondering how big the dtb blob is, can you explain a little bit about
the kvzalloc usage here?

Except of this, I have no other concern about this patch.

And what's your plan about the user space kexec-tool change?

>  	if (!params)
>  		return ERR_PTR(-ENOMEM);
>  	efi_map_offset = params_cmdline_sz;
> @@ -647,7 +688,7 @@ static void *bzImage64_load(struct kimag
>  	return ldata;
>  
>  out_free_params:
> -	kfree(params);
> +	kvfree(params);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -659,7 +700,7 @@ static int bzImage64_cleanup(void *loade
>  	if (!ldata)
>  		return 0;
>  
> -	kfree(ldata->bootparams_buf);
> +	kvfree(ldata->bootparams_buf);
>  	ldata->bootparams_buf = NULL;
>  
>  	return 0;
> --- a/include/linux/kexec.h~x86-kexec-carry-forward-the-boot-dtb-on-kexec
> +++ a/include/linux/kexec.h
> @@ -395,6 +395,9 @@ struct kimage {
>  
>  	/* Information for loading purgatory */
>  	struct purgatory_info purgatory_info;
> +
> +	/* Force carrying over the DTB from the current boot */
> +	bool force_dtb;
>  #endif
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
> @@ -461,7 +464,7 @@ bool kexec_load_permitted(int kexec_imag
>  /* List of defined/legal kexec file flags */
>  #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
>  				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
> -				 KEXEC_FILE_NO_CMA)
> +				 KEXEC_FILE_NO_CMA | KEXEC_FILE_FORCE_DTB)
>  
>  /* flag to track if kexec reboot is in progress */
>  extern bool kexec_in_progress;
> --- a/include/uapi/linux/kexec.h~x86-kexec-carry-forward-the-boot-dtb-on-kexec
> +++ a/include/uapi/linux/kexec.h
> @@ -22,12 +22,16 @@
>   * KEXEC_FILE_ON_CRASH : Load/unload operation belongs to kdump image.
>   * KEXEC_FILE_NO_INITRAMFS : No initramfs is being loaded. Ignore the initrd
>   *                           fd field.
> + * KEXEC_FILE_FORCE_DTB : Force carrying over the current boot's DTB to the new
> + *                        kernel on x86. This is already the default behavior on
> + *                        some other architectures, like ARM64 and PowerPC.
>   */
>  #define KEXEC_FILE_UNLOAD	0x00000001
>  #define KEXEC_FILE_ON_CRASH	0x00000002
>  #define KEXEC_FILE_NO_INITRAMFS	0x00000004
>  #define KEXEC_FILE_DEBUG	0x00000008
>  #define KEXEC_FILE_NO_CMA	0x00000010
> +#define KEXEC_FILE_FORCE_DTB	0x00000020
>  
>  /* These values match the ELF architecture values.
>   * Unless there is a good reason that should continue to be the case.
> --- a/kernel/kexec_file.c~x86-kexec-carry-forward-the-boot-dtb-on-kexec
> +++ a/kernel/kexec_file.c
> @@ -255,6 +255,7 @@ kimage_file_prepare_segments(struct kima
>  	}
>  
>  	image->no_cma = !!(flags & KEXEC_FILE_NO_CMA);
> +	image->force_dtb = flags & KEXEC_FILE_FORCE_DTB;
>  
>  	if (cmdline_len) {
>  		image->cmdline_buf = memdup_user(cmdline_ptr, cmdline_len);
> _
> 


