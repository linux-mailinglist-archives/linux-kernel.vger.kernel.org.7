Return-Path: <linux-kernel+bounces-750291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D9AB15997
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C297D3BBB76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F591EB5DB;
	Wed, 30 Jul 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlbAukv0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867F28ECDF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860691; cv=none; b=aYa5n4Fm4WBZgL6g1Eklw/84M0qBXF8fw8V1Xn/GVcIW7FnFnK2Ur4pf7b+eMtKwSQ6God2BzDrzQAbdTQDDs4+vjh4YQxwzSonjEgqOEbgrdNmagGcj0mGL1711WCe+lP52GyuyIciCKyyp0mieiL4lo4rH+mwpW+0SkwL5xE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860691; c=relaxed/simple;
	bh=pGAOCVRw0BLj2G2xXBMzOn9p5X2PAw/oxgucy6qgMkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R48O5V8RWmcpvrD5l8r86E0GiF3m5wVVTX2GzJTEJ4qzxR3VsImmmbrt3/OWei8xf0jW6Wcd2M5XIGvDCAoQt5CoSmXaVc42XOMovddvsodbS7uEOkDs/NkR9BQ28S+iRqxOGV0V7quDbQifHP0x+SouS2Dv/ufk71Uk2WdJu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlbAukv0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753860688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tg3kHXf/VEPySXPdaIeZnW9fOV15ESdV9yA7hGdIv+A=;
	b=HlbAukv0JvBGI1Zud1n951DvJ+pj8O2MN2qBpv/A8qWpZDBUADc2AF3eqvsbHEW1HsjeW0
	BbowV4OBCfgTjhdz8xAIYKhhrWJ6gbnhv49fkjd0711CpKcM0NWjahc5EBZLOQkuxXa8PP
	oxXMlCxYDUeeyJ8BsKU5rH7U/SqyDEU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-Dp1SzmyFOle5TuJFQO5dSQ-1; Wed,
 30 Jul 2025 03:31:24 -0400
X-MC-Unique: Dp1SzmyFOle5TuJFQO5dSQ-1
X-Mimecast-MFC-AGG-ID: Dp1SzmyFOle5TuJFQO5dSQ_1753860683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1116119560AA;
	Wed, 30 Jul 2025 07:31:22 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.59])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 438C21800B71;
	Wed, 30 Jul 2025 07:31:12 +0000 (UTC)
Date: Wed, 30 Jul 2025 15:31:59 +0800
From: Dave Young <dyoung@redhat.com>
To: Brian Mak <makb@juniper.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, x86@kernel.org,
	kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Message-ID: <aInKb8qr689ytM41@darkstar.users.ipa.redhat.com>
References: <20250729182142.4875-1-makb@juniper.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729182142.4875-1-makb@juniper.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jul 29, 2025 at 11:21:42AM -0700, Brian Mak wrote:
> The kexec_file_load syscall on x86 currently does not support passing
> a device tree blob to the new kernel.
> 
> To add support for this, we copy the behavior of ARM64 and PowerPC and
> copy the current boot's device tree blob for use in the new kernel. We
> do this on x86 by passing the device tree blob as a setup_data entry in
> accordance with the x86 boot protocol.
> 
> Signed-off-by: Brian Mak <makb@juniper.net>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 46 +++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 24a41f0e0cf1..c24536c25f98 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -16,6 +16,8 @@
>  #include <linux/kexec.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_fdt.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
>  
> @@ -212,6 +214,28 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
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
> @@ -336,6 +360,16 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  			sizeof(struct efi_setup_data);
>  #endif
>  
> +#ifdef CONFIG_OF_FLATTREE
> +	if (initial_boot_params) {
> +		setup_dtb(params, params_load_addr, setup_data_offset);
> +		setup_data_offset += sizeof(struct setup_data) +
> +				     fdt_totalsize(initial_boot_params);

I suppose current boot dtb should be valid for the current runnning
kernel, if you use kexec to load another kernel the next kexec reboot
could fail due to unmatching dtb.

Make this unconditionally could break the previous working kexec?

> +	} else {
> +		pr_info("No DTB\n");

pr_debug sounds better.

> +	}
> +#endif
> +
>  	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
>  		/* Setup IMA log buffer state */
>  		setup_ima_state(image, params, params_load_addr,
> @@ -529,6 +563,12 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  				sizeof(struct setup_data) +
>  				RNG_SEED_LENGTH;
>  
> +#ifdef CONFIG_OF_FLATTREE
> +	if (initial_boot_params)
> +		kbuf.bufsz += sizeof(struct setup_data) +
> +			      fdt_totalsize(initial_boot_params);
> +#endif
> +
>  	if (IS_ENABLED(CONFIG_IMA_KEXEC))
>  		kbuf.bufsz += sizeof(struct setup_data) +
>  			      sizeof(struct ima_setup_data);
> @@ -537,7 +577,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  		kbuf.bufsz += sizeof(struct setup_data) +
>  			      sizeof(struct kho_data);
>  
> -	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
> +	params = kvzalloc(kbuf.bufsz, GFP_KERNEL);
>  	if (!params)
>  		return ERR_PTR(-ENOMEM);
>  	efi_map_offset = params_cmdline_sz;
> @@ -647,7 +687,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	return ldata;
>  
>  out_free_params:
> -	kfree(params);
> +	kvfree(params);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -659,7 +699,7 @@ static int bzImage64_cleanup(void *loader_data)
>  	if (!ldata)
>  		return 0;
>  
> -	kfree(ldata->bootparams_buf);
> +	kvfree(ldata->bootparams_buf);
>  	ldata->bootparams_buf = NULL;
>  
>  	return 0;
> 
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> -- 
> 2.25.1
> 


Thanks
Dave


