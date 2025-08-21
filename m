Return-Path: <linux-kernel+bounces-779683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0DB2F743
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3D9178E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8D2DFA5B;
	Thu, 21 Aug 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mRGZom4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0C2DAFD9;
	Thu, 21 Aug 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777201; cv=none; b=BpILoEiNqUdmfPebxBiFSkurl9OC0qgfD0FLsEy5sE2k7CrSuTHPy0AeYaH0NYsL8zVi5sp8LJP5bFnO2ks1NPAYVbnNoHeiFl2Wh1VFblZgN1Op0O4HHJ4T4Kyau/GBAYKzXWzF+EH5ojJL+OI/8zxSRshbCH44muMk+ZtxJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777201; c=relaxed/simple;
	bh=x5kxTzWqBCYssiMEo0DTtYkVmAm8zy4FuX0Mfb7pLLs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r7mSoy7s2y4qW0LmQ229zFKMvmW/f8CQlMiZqJUaN3L0U3p3R4hRMmX+VtuN+IUhHtXbxgK1tNI21BvlpX1m794EZuLXNbo1HUIaom84ytfJPVFTDslxiJllVOeIpQ8cl/Vbkf7UmKKuuMBymMhy5iEpk1WOkKNPYKGm0t0hP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mRGZom4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E753C4CEEB;
	Thu, 21 Aug 2025 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755777200;
	bh=x5kxTzWqBCYssiMEo0DTtYkVmAm8zy4FuX0Mfb7pLLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mRGZom4XfgUeNcPZgDAJrnyc+nZ4bDcz+SEVzpBuaT0i002GKaJIlXBpatKnve3jn
	 jHi83YMjRE9qCoGfJ98VlDb6FqqVxrhBc+bxDPVx4VXpQHIqkNN1dX2mRDxDKx2v/e
	 BU+byz05zLIbem8rll6p1jhhHsXoKRZ6bhThPNaY=
Date: Thu, 21 Aug 2025 04:53:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Brian Mak <makb@juniper.net>, Dave Young <dyoung@redhat.com>, Alexander
 Graf <graf@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 x86@kernel.org, kexec@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Message-Id: <20250821045319.72e81f40e021e54e2131ac44@linux-foundation.org>
In-Reply-To: <aKbZ1h5mjtfoFMh8@MiWiFi-R3L-srv>
References: <20250805211527.122367-1-makb@juniper.net>
	<20250805211527.122367-2-makb@juniper.net>
	<20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
	<aKbZ1h5mjtfoFMh8@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 16:33:26 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 08/20/25 at 09:47pm, Andrew Morton wrote:
> > On Tue, 5 Aug 2025 14:15:26 -0700 Brian Mak <makb@juniper.net> wrote:
> > 
> > > Commit 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > > introduces logic to use CMA-based allocation in kexec by default. As
> > > part of the changes, it introduces a kexec_file_load flag to disable the
> > > use of CMA allocations from userspace. However, this flag is broken
> > > since it is missing from the list of legal flags for kexec_file_load.
> > > kexec_file_load returns EINVAL when attempting to use the flag.
> > > 
> > > Fix this by adding the KEXEC_FILE_NO_CMA flag to the list of legal flags
> > > for kexec_file_load.
> > > 
> > > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > 
> > A description of the userspace-visible runtime effects of this bug
> > would be very helpful, please.  A lot more than "is broken"!
> > 
> > Also, could we please have some reviewer input on this change?
> 
> I didn't receive this patchset, and kexec mailing list is not in CC.
> I don't know what happened.

Well that's annoying.  kexec@ and linux-kernel were on the cc line.

Here's what's in mm.git's mm-hotfixes branch:

From: Brian Mak <makb@juniper.net>
Subject: kexec: add KEXEC_FILE_NO_CMA as a legal flag
Date: Tue, 5 Aug 2025 14:15:26 -0700

Commit 07d24902977e ("kexec: enable CMA based contiguous allocation")
introduces logic to use CMA-based allocation in kexec by default.  As part
of the changes, it introduces a kexec_file_load flag to disable the use of
CMA allocations from userspace.  However, this flag is broken since it is
missing from the list of legal flags for kexec_file_load.  kexec_file_load
returns EINVAL when attempting to use the flag.

Fix this by adding the KEXEC_FILE_NO_CMA flag to the list of legal flags
for kexec_file_load.

Link: https://lkml.kernel.org/r/20250805211527.122367-2-makb@juniper.net
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Brian Mak <makb@juniper.net>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/kexec.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/kexec.h~kexec-add-kexec_file_no_cma-as-a-legal-flag
+++ a/include/linux/kexec.h
@@ -460,7 +460,8 @@ bool kexec_load_permitted(int kexec_imag
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
+				 KEXEC_FILE_NO_CMA)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
_


and the second patch I placed in mm-unstable:

From: Brian Mak <makb@juniper.net>
Subject: x86/kexec: carry forward the boot DTB on kexec
Date: Tue, 5 Aug 2025 14:15:27 -0700

Currently, the kexec_file_load syscall on x86 does not support passing a
device tree blob to the new kernel.  Some embedded x86 systems use device
trees.  On these systems, failing to pass a device tree to the new kernel
causes a boot failure.

To add support for this, we copy the behavior of ARM64 and PowerPC and
copy the current boot's device tree blob for use in the new kernel.  We do
this on x86 by passing the device tree blob as a setup_data entry in
accordance with the x86 boot protocol.

This behavior is gated behind the KEXEC_FILE_FORCE_DTB flag.

Link: https://lkml.kernel.org/r/20250805211527.122367-3-makb@juniper.net
Signed-off-by: Brian Mak <makb@juniper.net>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/kexec-bzimage64.c |   47 ++++++++++++++++++++++++++--
 include/linux/kexec.h             |    5 ++
 include/uapi/linux/kexec.h        |    4 ++
 kernel/kexec_file.c               |    1 
 4 files changed, 53 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/kexec-bzimage64.c~x86-kexec-carry-forward-the-boot-dtb-on-kexec
+++ a/arch/x86/kernel/kexec-bzimage64.c
@@ -16,6 +16,8 @@
 #include <linux/kexec.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
 #include <linux/efi.h>
 #include <linux/random.h>
 
@@ -212,6 +214,28 @@ setup_efi_state(struct boot_params *para
 }
 #endif /* CONFIG_EFI */
 
+#ifdef CONFIG_OF_FLATTREE
+static void setup_dtb(struct boot_params *params,
+		      unsigned long params_load_addr,
+		      unsigned int dtb_setup_data_offset)
+{
+	struct setup_data *sd = (void *)params + dtb_setup_data_offset;
+	unsigned long setup_data_phys, dtb_len;
+
+	dtb_len = fdt_totalsize(initial_boot_params);
+	sd->type = SETUP_DTB;
+	sd->len = dtb_len;
+
+	/* Carry over current boot DTB with setup_data */
+	memcpy(sd->data, initial_boot_params, dtb_len);
+
+	/* Add setup data */
+	setup_data_phys = params_load_addr + dtb_setup_data_offset;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = setup_data_phys;
+}
+#endif /* CONFIG_OF_FLATTREE */
+
 static void
 setup_ima_state(const struct kimage *image, struct boot_params *params,
 		unsigned long params_load_addr,
@@ -336,6 +360,17 @@ setup_boot_parameters(struct kimage *ima
 			sizeof(struct efi_setup_data);
 #endif
 
+#ifdef CONFIG_OF_FLATTREE
+	if (image->force_dtb && initial_boot_params) {
+		setup_dtb(params, params_load_addr, setup_data_offset);
+		setup_data_offset += sizeof(struct setup_data) +
+				     fdt_totalsize(initial_boot_params);
+	} else {
+		pr_debug("Not carrying over DTB, force_dtb = %d\n",
+			 image->force_dtb);
+	}
+#endif
+
 	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
 		/* Setup IMA log buffer state */
 		setup_ima_state(image, params, params_load_addr,
@@ -529,6 +564,12 @@ static void *bzImage64_load(struct kimag
 				sizeof(struct setup_data) +
 				RNG_SEED_LENGTH;
 
+#ifdef CONFIG_OF_FLATTREE
+	if (image->force_dtb && initial_boot_params)
+		kbuf.bufsz += sizeof(struct setup_data) +
+			      fdt_totalsize(initial_boot_params);
+#endif
+
 	if (IS_ENABLED(CONFIG_IMA_KEXEC))
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct ima_setup_data);
@@ -537,7 +578,7 @@ static void *bzImage64_load(struct kimag
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct kho_data);
 
-	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
+	params = kvzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 	efi_map_offset = params_cmdline_sz;
@@ -647,7 +688,7 @@ static void *bzImage64_load(struct kimag
 	return ldata;
 
 out_free_params:
-	kfree(params);
+	kvfree(params);
 	return ERR_PTR(ret);
 }
 
@@ -659,7 +700,7 @@ static int bzImage64_cleanup(void *loade
 	if (!ldata)
 		return 0;
 
-	kfree(ldata->bootparams_buf);
+	kvfree(ldata->bootparams_buf);
 	ldata->bootparams_buf = NULL;
 
 	return 0;
--- a/include/linux/kexec.h~x86-kexec-carry-forward-the-boot-dtb-on-kexec
+++ a/include/linux/kexec.h
@@ -395,6 +395,9 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+	/* Force carrying over the DTB from the current boot */
+	bool force_dtb;
 #endif
 
 #ifdef CONFIG_CRASH_HOTPLUG
@@ -461,7 +464,7 @@ bool kexec_load_permitted(int kexec_imag
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
-				 KEXEC_FILE_NO_CMA)
+				 KEXEC_FILE_NO_CMA | KEXEC_FILE_FORCE_DTB)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
--- a/include/uapi/linux/kexec.h~x86-kexec-carry-forward-the-boot-dtb-on-kexec
+++ a/include/uapi/linux/kexec.h
@@ -22,12 +22,16 @@
  * KEXEC_FILE_ON_CRASH : Load/unload operation belongs to kdump image.
  * KEXEC_FILE_NO_INITRAMFS : No initramfs is being loaded. Ignore the initrd
  *                           fd field.
+ * KEXEC_FILE_FORCE_DTB : Force carrying over the current boot's DTB to the new
+ *                        kernel on x86. This is already the default behavior on
+ *                        some other architectures, like ARM64 and PowerPC.
  */
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
 #define KEXEC_FILE_DEBUG	0x00000008
 #define KEXEC_FILE_NO_CMA	0x00000010
+#define KEXEC_FILE_FORCE_DTB	0x00000020
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
--- a/kernel/kexec_file.c~x86-kexec-carry-forward-the-boot-dtb-on-kexec
+++ a/kernel/kexec_file.c
@@ -255,6 +255,7 @@ kimage_file_prepare_segments(struct kima
 	}
 
 	image->no_cma = !!(flags & KEXEC_FILE_NO_CMA);
+	image->force_dtb = flags & KEXEC_FILE_FORCE_DTB;
 
 	if (cmdline_len) {
 		image->cmdline_buf = memdup_user(cmdline_ptr, cmdline_len);
_


