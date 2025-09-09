Return-Path: <linux-kernel+bounces-807270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A881B4A258
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058361898942
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE56304BC2;
	Tue,  9 Sep 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlhFbDHv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73C303A03
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399650; cv=none; b=G5vCEPu4AoGMfdpW6aRivdbxIDH2hkyzxQo5FDpPXilwd1rpNyM11hEztmCLxEkstDCwVidK5i3PLFfjZXaP7wtEzRkNj3qKlOa1P6HCGCL+MMRNxwySi8YNpcHMlh/GXz7z2IWyuhdvHKA7kR98TKPP9VLDo2WOrXet0hguo3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399650; c=relaxed/simple;
	bh=OkLV7V7U2RfHYgYd0F2dW2sdQXZStfFXTBTuBIwJJA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw6SlBWRJYYMx4CdmzJFKjSleYxtHwGDT8oLaTGNSlbpwgtqTLdo2Ka84oa2VBuNwYjX7dHIqDtdfQydf3uSNpJUz8MIu9msT7C2qPQQ9+Mp2MY2WK96JqGTwuKk31h+h5OvQB0SJ02K+a9G9Z3rIME/gKR6QJXW5Hwzt59QBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlhFbDHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757399645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwLN7sp3nt0WNSBYWuTDH2EXHW+WyUruHUDROM7d8dw=;
	b=PlhFbDHvl5F/tleTIyCQJ8R1RT7AXn5cV+p+20SjPS8hI/ywRLM7dzjeU9fqrZJYNHpA2E
	c+xU9CQPYro/OMlsu9YYeTzOwr3GlA+jexB4xRxpqTBluTfOrehOYBbcpPMFxyXmVZbNVj
	swiCRbSSuqzUHMgyQw3RTC7kddEeDvo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-T3q0jQu5MNuHVv3PGQeseA-1; Tue,
 09 Sep 2025 02:34:02 -0400
X-MC-Unique: T3q0jQu5MNuHVv3PGQeseA-1
X-Mimecast-MFC-AGG-ID: T3q0jQu5MNuHVv3PGQeseA_1757399640
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A5EB1800288;
	Tue,  9 Sep 2025 06:33:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8F921956095;
	Tue,  9 Sep 2025 06:33:56 +0000 (UTC)
Date: Tue, 9 Sep 2025 14:33:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Brian Mak <makb@juniper.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Dave Young <dyoung@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Message-ID: <aL/KUFaJF/PnVisu@MiWiFi-R3L-srv>
References: <20250805211527.122367-1-makb@juniper.net>
 <20250805211527.122367-2-makb@juniper.net>
 <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
 <aKbZ1h5mjtfoFMh8@MiWiFi-R3L-srv>
 <20250821045319.72e81f40e021e54e2131ac44@linux-foundation.org>
 <aKflAV8XNjqeu1Dj@MiWiFi-R3L-srv>
 <9F68DBD7-8A67-4FF4-AC99-5D485D9F9313@juniper.net>
 <1683D348-3A7C-484F-B21E-7828B96AA263@juniper.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683D348-3A7C-484F-B21E-7828B96AA263@juniper.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/04/25 at 07:58pm, Brian Mak wrote:
> On Aug 25, 2025, at 11:49 AM, Brian Mak <makb@juniper.net> wrote:
> 
> > On Aug 21, 2025, at 8:33 PM, Baoquan He <bhe@redhat.com> wrote:
> > 
> >> Yeah, this is a good catch and great fix. Without this fix,
> >> kexec_file_load syscall will failed and return '-EINVAL' when
> >> KEXEC_FILE_NO_CMA is specified just as below code shows. So, for this
> >> patch,
> >> 
> >> Acked-by: Baoquan He <bhe@redhat.com>
> > 
> > Hi Baoquan,
> > 
> > Thanks for the ACK!
> > 
> >> And, by the way, has the user space kexec-tools got the change merged
> >> to allow KEXEC_FILE_NO_CMA specified?
> > 
> > I don't see any recent commits to kexec-tools to support
> > KEXEC_FILE_NO_CMA.
> > 
> >>> From: Brian Mak <makb@juniper.net>
> >>> Subject: x86/kexec: carry forward the boot DTB on kexec
> >>> Date: Tue, 5 Aug 2025 14:15:27 -0700
> >>> 
> >>> Currently, the kexec_file_load syscall on x86 does not support passing a
> >>> device tree blob to the new kernel.  Some embedded x86 systems use device
> >>> trees.  On these systems, failing to pass a device tree to the new kernel
> >>> causes a boot failure.
> >>> 
> >>> To add support for this, we copy the behavior of ARM64 and PowerPC and
> >>> copy the current boot's device tree blob for use in the new kernel.  We do
> >>> this on x86 by passing the device tree blob as a setup_data entry in
> >>> accordance with the x86 boot protocol.
> >>> 
> >>> This behavior is gated behind the KEXEC_FILE_FORCE_DTB flag.
> >>> 
> >>> Link: https://urldefense.com/v3/__https://lkml.kernel.org/r/20250805211527.122367-3-makb@juniper.net__;!!NEt6yMaO-gk!EbJyF8xO2E51MyYdN3_zqCBBMj0JKoiKoPuG_8vEctQMk9uCyjX0LdSEH_FGkPDV8egxzc7w$
> >>> Signed-off-by: Brian Mak <makb@juniper.net>
> >>> Cc: Alexander Graf <graf@amazon.com>
> >>> Cc: Baoquan He <bhe@redhat.com>
> >>> Cc: Borislav Betkov <bp@alien8.de>
> >>> Cc: Dave Young <dyoung@redhat.com>
> >>> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >>> Cc: Ingo Molnar <mingo@redhat.com>
> >>> Cc: Rob Herring <robh@kernel.org>
> >>> Cc: Saravana Kannan <saravanak@google.com>
> >>> Cc: Thomas Gleinxer <tglx@linutronix.de>
> >>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>> ---
> >>> 
> >>> arch/x86/kernel/kexec-bzimage64.c |   47 ++++++++++++++++++++++++++--
> >>> include/linux/kexec.h             |    5 ++
> >>> include/uapi/linux/kexec.h        |    4 ++
> >>> kernel/kexec_file.c               |    1
> >>> 4 files changed, 53 insertions(+), 4 deletions(-)
> >>> 
> >>> --- a/arch/x86/kernel/kexec-bzimage64.c~x86-kexec-carry-forward-the-boot-dtb-on-kexec
> >>> +++ a/arch/x86/kernel/kexec-bzimage64.c
> >>> @@ -16,6 +16,8 @@
> >>> #include <linux/kexec.h>
> >>> #include <linux/kernel.h>
> >>> #include <linux/mm.h>
> >>> +#include <linux/libfdt.h>
> >>> +#include <linux/of_fdt.h>
> >>> #include <linux/efi.h>
> >>> #include <linux/random.h>
> >>> 
> >>> @@ -212,6 +214,28 @@ setup_efi_state(struct boot_params *para
> >>> }
> >>> #endif /* CONFIG_EFI */
> >>> 
> >>> +#ifdef CONFIG_OF_FLATTREE
> >>> +static void setup_dtb(struct boot_params *params,
> >>> +                   unsigned long params_load_addr,
> >>> +                   unsigned int dtb_setup_data_offset)
> >>> +{
> >>> +     struct setup_data *sd = (void *)params + dtb_setup_data_offset;
> >>> +     unsigned long setup_data_phys, dtb_len;
> >>> +
> >>> +     dtb_len = fdt_totalsize(initial_boot_params);
> >>> +     sd->type = SETUP_DTB;
> >>> +     sd->len = dtb_len;
> >>> +
> >>> +     /* Carry over current boot DTB with setup_data */
> >>> +     memcpy(sd->data, initial_boot_params, dtb_len);
> >>> +
> >>> +     /* Add setup data */
> >>> +     setup_data_phys = params_load_addr + dtb_setup_data_offset;
> >>> +     sd->next = params->hdr.setup_data;
> >>> +     params->hdr.setup_data = setup_data_phys;
> >>> +}
> >>> +#endif /* CONFIG_OF_FLATTREE */
> >>> +
> >>> static void
> >>> setup_ima_state(const struct kimage *image, struct boot_params *params,
> >>>             unsigned long params_load_addr,
> >>> @@ -336,6 +360,17 @@ setup_boot_parameters(struct kimage *ima
> >>>                     sizeof(struct efi_setup_data);
> >>> #endif
> >>> 
> >>> +#ifdef CONFIG_OF_FLATTREE
> >>> +     if (image->force_dtb && initial_boot_params) {
> >>> +             setup_dtb(params, params_load_addr, setup_data_offset);
> >>> +             setup_data_offset += sizeof(struct setup_data) +
> >>> +                                  fdt_totalsize(initial_boot_params);
> >>> +     } else {
> >>> +             pr_debug("Not carrying over DTB, force_dtb = %d\n",
> >>> +                      image->force_dtb);
> >>> +     }
> >>> +#endif
> >>> +
> >>>     if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
> >>>             /* Setup IMA log buffer state */
> >>>             setup_ima_state(image, params, params_load_addr,
> >>> @@ -529,6 +564,12 @@ static void *bzImage64_load(struct kimag
> >>>                             sizeof(struct setup_data) +
> >>>                             RNG_SEED_LENGTH;
> >>> 
> >>> +#ifdef CONFIG_OF_FLATTREE
> >>> +     if (image->force_dtb && initial_boot_params)
> >>> +             kbuf.bufsz += sizeof(struct setup_data) +
> >>> +                           fdt_totalsize(initial_boot_params);
> >>> +#endif
> >>> +
> >>>     if (IS_ENABLED(CONFIG_IMA_KEXEC))
> >>>             kbuf.bufsz += sizeof(struct setup_data) +
> >>>                           sizeof(struct ima_setup_data);
> >>> @@ -537,7 +578,7 @@ static void *bzImage64_load(struct kimag
> >>>             kbuf.bufsz += sizeof(struct setup_data) +
> >>>                           sizeof(struct kho_data);
> >>> 
> >>> -     params = kzalloc(kbuf.bufsz, GFP_KERNEL);
> >>> +     params = kvzalloc(kbuf.bufsz, GFP_KERNEL);
> >> 
> >> Wondering how big the dtb blob is, can you explain a little bit about
> >> the kvzalloc usage here?
> >> 
> >> Except of this, I have no other concern about this patch.
> >> 
> >> And what's your plan about the user space kexec-tool change?
> > 
> > When I tested this earlier on x86, the DTB was allowed to be up to just
> > under 64 pages large before the DTB failed to load. This is because it
> > has to fit into an early_memremap() mapping (relevant code snippet at
> > the bottom). Since the allocation can be many pages, I changed the
> > kzalloc to a kvzalloc.
> > 
> > For the kexec-tools change, I have a draft change that I've already
> > shared on this thread for testing purposes. I believe you said you were
> > going to test it, but I haven't heard anything back from that yet. I'll
> > raise that change for review properly once this kernel commit is in
> > mainline.
> > 
> > ---------
> > 
> > void __init x86_flattree_get_config(void)
> > {
> > #ifdef CONFIG_OF_EARLY_FLATTREE
> > u32 size, map_len;
> > void *dt;
> > 
> > if (initial_dtb) {
> > map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
> > 
> > dt = early_memremap(initial_dtb, map_len);
> > size = fdt_totalsize(dt);
> > if (map_len < size) {
> > early_memunmap(dt, map_len);
> > dt = early_memremap(initial_dtb, size);
> > map_len = size;
> > }
> > 
> > early_init_dt_verify(dt, __pa(dt));
> > }
> > 
> > unflatten_and_copy_device_tree();
> > 
> > if (initial_dtb)
> > early_memunmap(dt, map_len);
> > #endif
> > if (acpi_disabled && of_have_populated_dt())
> > x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
> > }
> > 
> > ---------
> > 
> > Thanks,
> > Brian
> 
> Hi Baoquan,
> 
> Just wanted to check back on this. Did you have any further concerns? If
> not, would you be able to provide an ACK?

I thought I have acked it, seems I only ack-ed the 1st one, then ack the
2nd patch:

Acked-by: Baoquan He <bhe@redhat.com>


