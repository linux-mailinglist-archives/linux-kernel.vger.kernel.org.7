Return-Path: <linux-kernel+bounces-897134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF02C521D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8C204E62D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3413148CC;
	Wed, 12 Nov 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFwS4I5w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AD2E888A;
	Wed, 12 Nov 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948006; cv=none; b=Le+XKGDpJilHT7U1IjhpEVthaduhI08gfCvuszfO7djln7naIuggcaPtR/mFj7CuookVTc+TAc/dh9ytGwe3BV/evIAYSFx9e6E2xC6quTq2yxkssNwp8k2T/nmovKIzuFZHxNWRsyQARktFvXJKbwC6EgwfWrWVuwi82C9yIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948006; c=relaxed/simple;
	bh=ih71AgwUzWOc1i5Rm6yDBbjgjbm3cz1P32zyBC0sogA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe+pF8Z+TPYOmLhtM2ZYySQX5T1eIOtOk/tM2s3lnbsFfJupnKsKwUZla5TwHAMc6gHeYYKAP/QoJFAjGieETDuk6g1Q/O58YA+T3zPkv2uZWBFdX25029kfns0gsmF73/f8gqH4pcnauaR+O6p6kXBhPYSUd/LyTQ6m/MtYuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFwS4I5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEA1C4CEF7;
	Wed, 12 Nov 2025 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762948005;
	bh=ih71AgwUzWOc1i5Rm6yDBbjgjbm3cz1P32zyBC0sogA=;
	h=From:To:Cc:Subject:Date:From;
	b=vFwS4I5wICLAhXXwgoZma7UDxoXj375yCEewrxPbS+jYgut+Jxzi7Xww/G6Jy2K1M
	 lcZeTNwuSuWg8r8indTzLYgy2GVboeZkhbpFRZmh8YIUvjtZofTQ9kasahUAsD20Wg
	 63+6lpp2d84V0rDstJ9FBdwWDjkKnZLilFxC+y+cxdRM2cQFIQBdmwCKDBD21q3lJh
	 Tok9G91aNP1D8p3gZO83O6qwTy5pTt53OieCTWvRdaqGCnOFoIb1EbMGst7O1N0Fsj
	 DxORPhK3KFlALXvMvsObf3SUFpjsZy4fq7e8xbe1BHX77jsCpmEzKBbnuT36B5gkVL
	 kyGcENlRHyKlg==
From: Borislav Petkov <bp@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] Documentation/kernel-parameters: Move the kernel build options
Date: Wed, 12 Nov 2025 12:46:41 +0100
Message-ID: <20251112114641.8230-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Move the kernel build options abbreviations to the .txt file so that
they are together instead of one having to go hunt them in the .rst
file.

Tweak the formatting so that the inclusion of kernel-parameters.txt
still keeps the whole thing somewhat presentable in the html output too.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 .../admin-guide/kernel-parameters.rst         | 97 +-----------------
 .../admin-guide/kernel-parameters.txt         | 98 +++++++++++++++++++
 2 files changed, 99 insertions(+), 96 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 7bf8cc7df6b5..02a725536cc5 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -110,102 +110,7 @@ The parameters listed below are only valid if certain kernel build options
 were enabled and if respective hardware is present. This list should be kept
 in alphabetical order. The text in square brackets at the beginning
 of each description states the restrictions within which a parameter
-is applicable::
-
-	ACPI	ACPI support is enabled.
-	AGP	AGP (Accelerated Graphics Port) is enabled.
-	ALSA	ALSA sound support is enabled.
-	APIC	APIC support is enabled.
-	APM	Advanced Power Management support is enabled.
-	APPARMOR AppArmor support is enabled.
-	ARM	ARM architecture is enabled.
-	ARM64	ARM64 architecture is enabled.
-	AX25	Appropriate AX.25 support is enabled.
-	CLK	Common clock infrastructure is enabled.
-	CMA	Contiguous Memory Area support is enabled.
-	DRM	Direct Rendering Management support is enabled.
-	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
-	EARLY	Parameter processed too early to be embedded in initrd.
-	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
-	EFI	EFI Partitioning (GPT) is enabled
-	EVM	Extended Verification Module
-	FB	The frame buffer device is enabled.
-	FTRACE	Function tracing enabled.
-	GCOV	GCOV profiling is enabled.
-	HIBERNATION HIBERNATION is enabled.
-	HW	Appropriate hardware is enabled.
-	HYPER_V HYPERV support is enabled.
-	IMA     Integrity measurement architecture is enabled.
-	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
-	IPV6	IPv6 support is enabled.
-	ISAPNP	ISA PnP code is enabled.
-	ISDN	Appropriate ISDN support is enabled.
-	ISOL	CPU Isolation is enabled.
-	JOY	Appropriate joystick support is enabled.
-	KGDB	Kernel debugger support is enabled.
-	KVM	Kernel Virtual Machine support is enabled.
-	LIBATA  Libata driver is enabled
-	LOONGARCH LoongArch architecture is enabled.
-	LOOP	Loopback device support is enabled.
-	LP	Printer support is enabled.
-	M68k	M68k architecture is enabled.
-			These options have more detailed description inside of
-			Documentation/arch/m68k/kernel-options.rst.
-	MDA	MDA console support is enabled.
-	MIPS	MIPS architecture is enabled.
-	MOUSE	Appropriate mouse support is enabled.
-	MSI	Message Signaled Interrupts (PCI).
-	MTD	MTD (Memory Technology Device) support is enabled.
-	NET	Appropriate network support is enabled.
-	NFS	Appropriate NFS support is enabled.
-	NUMA	NUMA support is enabled.
-	OF	Devicetree is enabled.
-	PARISC	The PA-RISC architecture is enabled.
-	PCI	PCI bus support is enabled.
-	PCIE	PCI Express support is enabled.
-	PCMCIA	The PCMCIA subsystem is enabled.
-	PNP	Plug & Play support is enabled.
-	PPC	PowerPC architecture is enabled.
-	PPT	Parallel port support is enabled.
-	PS2	Appropriate PS/2 support is enabled.
-	PV_OPS	A paravirtualized kernel is enabled.
-	RAM	RAM disk support is enabled.
-	RDT	Intel Resource Director Technology.
-	RISCV	RISCV architecture is enabled.
-	S390	S390 architecture is enabled.
-	SCSI	Appropriate SCSI support is enabled.
-			A lot of drivers have their options described inside
-			the Documentation/scsi/ sub-directory.
-        SDW     SoundWire support is enabled.
-	SECURITY Different security models are enabled.
-	SELINUX SELinux support is enabled.
-	SERIAL	Serial support is enabled.
-	SH	SuperH architecture is enabled.
-	SMP	The kernel is an SMP kernel.
-	SPARC	Sparc architecture is enabled.
-	SUSPEND	System suspend states are enabled.
-	SWSUSP	Software suspend (hibernation) is enabled.
-	TPM	TPM drivers are enabled.
-	UMS	USB Mass Storage support is enabled.
-	USB	USB support is enabled.
-	USBHID	USB Human Interface Device support is enabled.
-	V4L	Video For Linux support is enabled.
-	VGA	The VGA console has been enabled.
-	VMMIO   Driver for memory mapped virtio devices is enabled.
-	VT	Virtual terminal support is enabled.
-	WDT	Watchdog support is enabled.
-	X86-32	X86-32, aka i386 architecture is enabled.
-	X86-64	X86-64 architecture is enabled.
-	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
-	X86_UV	SGI UV support is enabled.
-	XEN	Xen support is enabled
-	XTENSA	xtensa architecture is enabled.
-
-In addition, the following text indicates that the option::
-
-	BOOT	Is a boot loader parameter.
-	BUGS=	Relates to possible processor bugs on the said processor.
-	KNL	Is a kernel start-up parameter.
+is applicable.
 
 Parameters denoted with BOOT are actually interpreted by the boot
 loader, and have no meaning to the kernel directly.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e..e85a91e63f48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,3 +1,101 @@
+	ACPI	ACPI support is enabled.
+	AGP	AGP (Accelerated Graphics Port) is enabled.
+	ALSA	ALSA sound support is enabled.
+	APIC	APIC support is enabled.
+	APM	Advanced Power Management support is enabled.
+	APPARMOR AppArmor support is enabled.
+	ARM	ARM architecture is enabled.
+	ARM64	ARM64 architecture is enabled.
+	AX25	Appropriate AX.25 support is enabled.
+	CLK	Common clock infrastructure is enabled.
+	CMA	Contiguous Memory Area support is enabled.
+	DRM	Direct Rendering Management support is enabled.
+	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
+	EARLY	Parameter processed too early to be embedded in initrd.
+	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
+	EFI	EFI Partitioning (GPT) is enabled
+	EVM	Extended Verification Module
+	FB	The frame buffer device is enabled.
+	FTRACE	Function tracing enabled.
+	GCOV	GCOV profiling is enabled.
+	HIBERNATION HIBERNATION is enabled.
+	HW	Appropriate hardware is enabled.
+	HYPER_V HYPERV support is enabled.
+	IMA     Integrity measurement architecture is enabled.
+	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
+	IPV6	IPv6 support is enabled.
+	ISAPNP	ISA PnP code is enabled.
+	ISDN	Appropriate ISDN support is enabled.
+	ISOL	CPU Isolation is enabled.
+	JOY	Appropriate joystick support is enabled.
+	KGDB	Kernel debugger support is enabled.
+	KVM	Kernel Virtual Machine support is enabled.
+	LIBATA  Libata driver is enabled
+	LOONGARCH LoongArch architecture is enabled.
+	LOOP	Loopback device support is enabled.
+	LP	Printer support is enabled.
+	M68k	M68k architecture is enabled.
+			These options have more detailed description inside of
+			Documentation/arch/m68k/kernel-options.rst.
+	MDA	MDA console support is enabled.
+	MIPS	MIPS architecture is enabled.
+	MOUSE	Appropriate mouse support is enabled.
+	MSI	Message Signaled Interrupts (PCI).
+	MTD	MTD (Memory Technology Device) support is enabled.
+	NET	Appropriate network support is enabled.
+	NFS	Appropriate NFS support is enabled.
+	NUMA	NUMA support is enabled.
+	OF	Devicetree is enabled.
+	PARISC	The PA-RISC architecture is enabled.
+	PCI	PCI bus support is enabled.
+	PCIE	PCI Express support is enabled.
+	PCMCIA	The PCMCIA subsystem is enabled.
+	PNP	Plug & Play support is enabled.
+	PPC	PowerPC architecture is enabled.
+	PPT	Parallel port support is enabled.
+	PS2	Appropriate PS/2 support is enabled.
+	PV_OPS	A paravirtualized kernel is enabled.
+	RAM	RAM disk support is enabled.
+	RDT	Intel Resource Director Technology.
+	RISCV	RISCV architecture is enabled.
+	S390	S390 architecture is enabled.
+	SCSI	Appropriate SCSI support is enabled.
+			A lot of drivers have their options described inside
+			the Documentation/scsi/ sub-directory.
+        SDW     SoundWire support is enabled.
+	SECURITY Different security models are enabled.
+	SELINUX SELinux support is enabled.
+	SERIAL	Serial support is enabled.
+	SH	SuperH architecture is enabled.
+	SMP	The kernel is an SMP kernel.
+	SPARC	Sparc architecture is enabled.
+	SUSPEND	System suspend states are enabled.
+	SWSUSP	Software suspend (hibernation) is enabled.
+	TPM	TPM drivers are enabled.
+	UMS	USB Mass Storage support is enabled.
+	USB	USB support is enabled.
+	USBHID	USB Human Interface Device support is enabled.
+	V4L	Video For Linux support is enabled.
+	VGA	The VGA console has been enabled.
+	VMMIO   Driver for memory mapped virtio devices is enabled.
+	VT	Virtual terminal support is enabled.
+	WDT	Watchdog support is enabled.
+	X86-32	X86-32, aka i386 architecture is enabled.
+	X86-64	X86-64 architecture is enabled.
+	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
+	X86_UV	SGI UV support is enabled.
+	XEN	Xen support is enabled
+	XTENSA	xtensa architecture is enabled.
+
+In addition, the following text indicates that the option
+
+	BOOT	Is a boot loader parameter.
+	BUGS=	Relates to possible processor bugs on the said processor.
+	KNL	Is a kernel start-up parameter.
+
+
+Kernel parameters
+
 	accept_memory=  [MM]
 			Format: { eager | lazy }
 			default: lazy
-- 
2.51.0


