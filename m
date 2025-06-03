Return-Path: <linux-kernel+bounces-671535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE7ACC2CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AEE7A8DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB33528152A;
	Tue,  3 Jun 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrOXRRZ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37027281524
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942410; cv=none; b=L3SGNzU0/3Fy3z4Du1A5fAXmA79wdRU2TgXWizRh6rla3q9FZ0KNMumR8tahDi05WOtFJjo9scPLvGGb8uXe3mlhdZK6qWZw9MBygzt6rV7QM0p9qMu3BmH7BgxOVgGfvLtbpq+7aN+SsIfa7SHNX2QPyvCD2W5X4mkgiKyDaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942410; c=relaxed/simple;
	bh=XNyKE9JYr7iSbl1N3+GFaNhJw2CoHiZvplDWoLBvPPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JGkplh+j4ze4F/AJTOEakkuHAPcjj6Vy/P4fOYhPNSayuA18v75ZgdYY8zylutRXwtqm9eIeeC/FE3GgwUX+FxC5nAWMYm9GrQMW5DLGyB5aJIPeNdWfH1x+p4S8xILaTb5pfdVMIj1c75xw5tvwK9rcDXqeHMHh2AH7jm/NUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrOXRRZ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748942407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d7M1AZ3966x5zRLHqsBAGaKfG5mjdKDTJHZg7JOKy6U=;
	b=PrOXRRZ/nPCizAn4yqMZnfgjJhMgNDRoeq6RkxRYhsGRyKTDiXBu+jNsFQpY5qoFhyoS8G
	1QaD5B2RchFZsI/5+V1CpKmtCRpHyLbwJWgOE8Kpe44HT5si5C/Jwf5SFZQeVygOnWX5h3
	ezxOFmtaVQNPsszF9RS/54u4ADp3Sg4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-lZ36ZsLgMIWjBWnIaudKQw-1; Tue,
 03 Jun 2025 05:20:02 -0400
X-MC-Unique: lZ36ZsLgMIWjBWnIaudKQw-1
X-Mimecast-MFC-AGG-ID: lZ36ZsLgMIWjBWnIaudKQw_1748942400
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B42DA180034A;
	Tue,  3 Jun 2025 09:19:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88E9F1955D95;
	Tue,  3 Jun 2025 09:19:52 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: x86@kernel.org
Cc: linux-efi@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Jones <pjones@redhat.com>,
	Daniel Berrange <berrange@redhat.com>,
	Emanuele Giuseppe Esposito <eesposit@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3] x86/efi: Implement support for embedding SBAT data for x86
Date: Tue,  3 Jun 2025 11:19:51 +0200
Message-ID: <20250603091951.57775-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Similar to zboot architectures, implement support for embedding SBAT data
for x86. Put '.sbat' section in between '.data' and '.text' as the former
also covers '.bss' and '.pgtable' and thus must be the last one in the
file.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
The patch was previously sent as part of "[PATCH v3 0/2] efi: Add a
 mechanism for embedding SBAT section" series. The main patch has
already made it upstream through Ard's 'efi' tree (see commit 0f9a1739dd0e
"efi: zboot specific mechanism for embedding SBAT section") but x86 part
is still pending. Resending so it doesn't get lost.

 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/Makefile      |  5 +++++
 arch/x86/boot/compressed/sbat.S        |  7 ++++++
 arch/x86/boot/compressed/vmlinux.lds.S |  8 +++++++
 arch/x86/boot/header.S                 | 31 ++++++++++++++++++--------
 drivers/firmware/efi/Kconfig           |  2 +-
 6 files changed, 44 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sbat.S

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 640fcac3af74..3f9fb3698d66 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -71,7 +71,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f4f7b22d8113..3a38fdcdb9bd 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -106,6 +106,11 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-libs-$(CONFIG_X86_64)	+= $(objtree)/arch/x86/boot/startup/lib.a
+vmlinux-objs-$(CONFIG_EFI_SBAT) += $(obj)/sbat.o
+
+ifdef CONFIG_EFI_SBAT
+$(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
+endif
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/compressed/sbat.S b/arch/x86/boot/compressed/sbat.S
new file mode 100644
index 000000000000..838f70a997dd
--- /dev/null
+++ b/arch/x86/boot/compressed/sbat.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Embed SBAT data in the kernel.
+ */
+	.pushsection ".sbat", "a", @progbits
+	.incbin CONFIG_EFI_SBAT_FILE
+	.popsection
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3b2bc61c9408..587ce3e7c504 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -43,6 +43,14 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
+#ifdef CONFIG_EFI_SBAT
+	.sbat : ALIGN(0x1000) {
+		_sbat = . ;
+		*(.sbat)
+		_esbat = ALIGN(0x1000);
+		. = _esbat;
+	}
+#endif
 	.data :	ALIGN(0x1000) {
 		_data = . ;
 		*(.data)
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index e1f4fd5bc8ee..9bea5a1e2c52 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -179,15 +179,11 @@ pecompat_fstart:
 #else
 	.set	pecompat_fstart, setup_size
 #endif
-	.ascii	".text"
-	.byte	0
-	.byte	0
-	.byte	0
-	.long	ZO__data
-	.long	setup_size
-	.long	ZO__data			# Size of initialized data
-						# on disk
-	.long	setup_size
+	.ascii	".text\0\0\0"
+	.long	textsize            		# VirtualSize
+	.long	setup_size			# VirtualAddress
+	.long	textsize			# SizeOfRawData
+	.long	setup_size			# PointerToRawData
 	.long	0				# PointerToRelocations
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
@@ -196,6 +192,23 @@ pecompat_fstart:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
+#ifdef CONFIG_EFI_SBAT
+	.ascii	".sbat\0\0\0"
+	.long	ZO__esbat - ZO__sbat            # VirtualSize
+	.long	setup_size + ZO__sbat           # VirtualAddress
+	.long	ZO__esbat - ZO__sbat            # SizeOfRawData
+	.long	setup_size + ZO__sbat           # PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
+
+	.set	textsize, ZO__sbat
+#else
+	.set	textsize, ZO__data
+#endif
+
 	.ascii	".data\0\0\0"
 	.long	ZO__end - ZO__data		# VirtualSize
 	.long	setup_size + ZO__data		# VirtualAddress
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index db8c5c03d3a2..16baa038d412 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -286,7 +286,7 @@ config EFI_SBAT
 
 config EFI_SBAT_FILE
 	string "Embedded SBAT section file path"
-	depends on EFI_ZBOOT
+	depends on EFI_ZBOOT || (EFI_STUB && X86)
 	help
 	  SBAT section provides a way to improve SecureBoot revocations of UEFI
 	  binaries by introducing a generation-based mechanism. With SBAT, older
-- 
2.49.0


