Return-Path: <linux-kernel+bounces-631502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA700AA88F1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA6D18964BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 18:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012F221733;
	Sun,  4 May 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFL3BHC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C46DCE1;
	Sun,  4 May 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746382992; cv=none; b=DQdI9grFvHi1LwtLPt1/9x/X4fa41/lWV4QF0BhwIUPDqMYlnw8D9EwSu3yK76WkY/wUUTQ3/c3aKVLHK1yeK7CqTCkA7BqrpDW0zuEgMUeIOaaKq6KdGiC9TBjNQr49elPiwp3ZzlFSrsL/h09kqvRQVXQDgYkMtnllGvPA7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746382992; c=relaxed/simple;
	bh=+DEWTqqRopDTu6YFhGOZndn7c+f7iPis4ZHYSU7gNBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CEkfAwlbhSO9xvleKCaBcetEZ0wEcLnFK5xa+u8WAHyhf8a0Wvn/1rYUau94pCczIjZ5xds2rkiUiliPFZhISgLcHmXjn9R9ZHva+5Jwawb02fPGKfq0gLMxpSnpzU6kyYhrFw/Ec0DLItmRobeLJWH0ZrIEVwacO24YfUW8XNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFL3BHC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EC8C4CEE7;
	Sun,  4 May 2025 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746382991;
	bh=+DEWTqqRopDTu6YFhGOZndn7c+f7iPis4ZHYSU7gNBY=;
	h=From:To:Cc:Subject:Date:From;
	b=PFL3BHC3G3FyD4dqDiWazbBXtvlVACOjOAOZeNnd4StcUCTBgmOKVXGu4mn7U9OU7
	 qWd/hBYYmqJv0JQcO+/3NiSqNfBo4nt8YidM9uGQGUivxtPU4OCl1HLAMfk7fMPSR5
	 4DWH26PsKtvy4jQsik0NJD492LaNj9pSFKSy5UXEewVZddwYRFbQNOUGozmVj90rpr
	 c8h/7K2hikdvhVg3Ea+WB1/hawRYB5K1ox8Z/XB/Z2/REBK4yxOPnmG71iTckftJkf
	 BuIRpRf03Tda4GcKuxBmW5el81k15KgfhwNbhircB1MD5BK9e2ekI12hjlPuezRjS2
	 Q/kkwUZRYtV3A==
Received: by pali.im (Postfix)
	id 7DB21731; Sun,  4 May 2025 20:23:08 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: linux-efi@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] include: pe.h: Fix PE definitions
Date: Sun,  4 May 2025 20:22:44 +0200
Message-Id: <20250504182244.30446-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Rename constants to their standard PE names:
  - MZ_MAGIC -> IMAGE_DOS_SIGNATURE
  - PE_MAGIC -> IMAGE_NT_SIGNATURE
  - PE_OPT_MAGIC_PE32_ROM -> IMAGE_ROM_OPTIONAL_HDR_MAGIC
  - PE_OPT_MAGIC_PE32 -> IMAGE_NT_OPTIONAL_HDR32_MAGIC
  - PE_OPT_MAGIC_PE32PLUS -> IMAGE_NT_OPTIONAL_HDR64_MAGIC
  - IMAGE_DLL_CHARACTERISTICS_NX_COMPAT -> IMAGE_DLLCHARACTERISTICS_NX_COMPAT

* Import constants and their description from readpe and file projects
  which contains current up-to-date information:
  - IMAGE_FILE_MACHINE_*
  - IMAGE_FILE_*
  - IMAGE_SUBSYSTEM_*
  - IMAGE_DLLCHARACTERISTICS_*
  - IMAGE_DLLCHARACTERISTICS_EX_*
  - IMAGE_DEBUG_TYPE_*

* Add missing IMAGE_SCN_* constants and update their incorrect description

* Fix incorrect value of IMAGE_SCN_MEM_PURGEABLE constant

* Add description for win32_version and loader_flags PE fields

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/compressed/efi-header.S       |   6 +-
 arch/arm64/kernel/efi-header.S              |   6 +-
 arch/loongarch/kernel/efi-header.S          |   4 +-
 arch/loongarch/kernel/head.S                |   2 +-
 arch/riscv/kernel/efi-header.S              |   8 +-
 arch/x86/boot/header.S                      |  10 +-
 crypto/asymmetric_keys/verify_pefile.c      |   8 +-
 drivers/firmware/efi/libstub/zboot-header.S |  10 +-
 include/linux/pe.h                          | 279 ++++++++++++--------
 9 files changed, 201 insertions(+), 132 deletions(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index 230030c13085..ad1a5807291e 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -20,7 +20,7 @@
 		@ is accepted as an EFI binary. Booting via the UEFI stub
 		@ will not execute those instructions, but the ARM/Linux
 		@ boot protocol does, so we need some NOPs here.
-		.inst	MZ_MAGIC | (0xe225 << 16)	@ eor r5, r5, 0x4d000
+		.inst	IMAGE_DOS_SIGNATURE | (0xe225 << 16)	@ eor r5, r5, 0x4d000
 		eor	r5, r5, 0x4d000			@ undo previous insn
 #else
 		__nop
@@ -43,7 +43,7 @@
 		.long	pe_header - start		@ Offset to the PE header.
 
 pe_header:
-		.long	PE_MAGIC
+		.long	IMAGE_NT_SIGNATURE
 
 coff_header:
 		.short	IMAGE_FILE_MACHINE_THUMB	@ Machine
@@ -60,7 +60,7 @@ coff_header:
 #define __pecoff_code_size (__pecoff_data_start - __efi_start)
 
 optional_header:
-		.short	PE_OPT_MAGIC_PE32		@ PE32 format
+		.short	IMAGE_NT_OPTIONAL_HDR32_MAGIC	@ PE32 format
 		.byte	0x02				@ MajorLinkerVersion
 		.byte	0x14				@ MinorLinkerVersion
 		.long	__pecoff_code_size		@ SizeOfCode
diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 11d7f7de202d..329e8df9215f 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -28,7 +28,7 @@
 	.macro	__EFI_PE_HEADER
 #ifdef CONFIG_EFI
 	.set	.Lpe_header_offset, . - .L_head
-	.long	PE_MAGIC
+	.long	IMAGE_NT_SIGNATURE
 	.short	IMAGE_FILE_MACHINE_ARM64		// Machine
 	.short	.Lsection_count				// NumberOfSections
 	.long	0 					// TimeDateStamp
@@ -40,7 +40,7 @@
 		IMAGE_FILE_LINE_NUMS_STRIPPED		// Characteristics
 
 .Loptional_header:
-	.short	PE_OPT_MAGIC_PE32PLUS			// PE32+ format
+	.short	IMAGE_NT_OPTIONAL_HDR64_MAGIC		// PE32+ format
 	.byte	0x02					// MajorLinkerVersion
 	.byte	0x14					// MinorLinkerVersion
 	.long	__initdata_begin - .Lefi_header_end	// SizeOfCode
@@ -66,7 +66,7 @@
 	.long	.Lefi_header_end - .L_head		// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
index 5f23b85d78ca..ba0bdbf86aa8 100644
--- a/arch/loongarch/kernel/efi-header.S
+++ b/arch/loongarch/kernel/efi-header.S
@@ -7,7 +7,7 @@
 #include <linux/sizes.h>
 
 	.macro	__EFI_PE_HEADER
-	.long	PE_MAGIC
+	.long	IMAGE_NT_SIGNATURE
 .Lcoff_header:
 	.short	IMAGE_FILE_MACHINE_LOONGARCH64		/* Machine */
 	.short	.Lsection_count				/* NumberOfSections */
@@ -20,7 +20,7 @@
 		IMAGE_FILE_LINE_NUMS_STRIPPED		/* Characteristics */
 
 .Loptional_header:
-	.short	PE_OPT_MAGIC_PE32PLUS			/* PE32+ format */
+	.short	IMAGE_NT_OPTIONAL_HDR64_MAGIC		/* PE32+ format */
 	.byte	0x02					/* MajorLinkerVersion */
 	.byte	0x14					/* MinorLinkerVersion */
 	.long	__inittext_end - .Lefi_header_end	/* SizeOfCode */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 506a99a5bbc7..e3865e92a917 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -20,7 +20,7 @@
 	__HEAD
 
 _head:
-	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
+	.word	IMAGE_DOS_SIGNATURE	/* "MZ", MS-DOS header */
 	.org	0x8
 	.dword	_kernel_entry		/* Kernel entry point (physical address) */
 	.dword	_kernel_asize		/* Kernel image effective size */
diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index c5f17c2710b5..2efc3aaf4a8c 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -9,7 +9,7 @@
 #include <asm/set_memory.h>
 
 	.macro	__EFI_PE_HEADER
-	.long	PE_MAGIC
+	.long	IMAGE_NT_SIGNATURE
 coff_header:
 #ifdef CONFIG_64BIT
 	.short	IMAGE_FILE_MACHINE_RISCV64		// Machine
@@ -27,9 +27,9 @@ coff_header:
 
 optional_header:
 #ifdef CONFIG_64BIT
-	.short	PE_OPT_MAGIC_PE32PLUS			// PE32+ format
+	.short	IMAGE_NT_OPTIONAL_HDR64_MAGIC		// PE32+ format
 #else
-	.short	PE_OPT_MAGIC_PE32			// PE32 format
+	.short	IMAGE_NT_OPTIONAL_HDR32_MAGIC		// PE32 format
 #endif
 	.byte	0x02					// MajorLinkerVersion
 	.byte	0x14					// MinorLinkerVersion
@@ -64,7 +64,7 @@ extra_header_fields:
 	.long	efi_header_end - _start			// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359b..535ae4d6866c 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -43,7 +43,7 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 	.section ".bstext", "ax"
 #ifdef CONFIG_EFI_STUB
 	# "MZ", MS-DOS header
-	.word	MZ_MAGIC
+	.word	IMAGE_DOS_SIGNATURE
 	.org	0x38
 	#
 	# Offset to the PE header.
@@ -51,16 +51,16 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 	.long	LINUX_PE_MAGIC
 	.long	pe_header
 pe_header:
-	.long	PE_MAGIC
+	.long	IMAGE_NT_SIGNATURE
 
 coff_header:
 #ifdef CONFIG_X86_32
 	.set	image_file_add_flags, IMAGE_FILE_32BIT_MACHINE
-	.set	pe_opt_magic, PE_OPT_MAGIC_PE32
+	.set	pe_opt_magic, IMAGE_NT_OPTIONAL_HDR32_MAGIC
 	.word	IMAGE_FILE_MACHINE_I386
 #else
 	.set	image_file_add_flags, 0
-	.set	pe_opt_magic, PE_OPT_MAGIC_PE32PLUS
+	.set	pe_opt_magic, IMAGE_NT_OPTIONAL_HDR64_MAGIC
 	.word	IMAGE_FILE_MACHINE_AMD64
 #endif
 	.word	section_count			# nr_sections
@@ -111,7 +111,7 @@ extra_header_fields:
 	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
-	.word	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	# DllCharacteristics
+	.word	IMAGE_DLLCHARACTERISTICS_NX_COMPAT	# DllCharacteristics
 #ifdef CONFIG_X86_32
 	.long	0				# SizeOfStackReserve
 	.long	0				# SizeOfStackCommit
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 2863984b6700..1f3b227ba7f2 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -40,13 +40,13 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	} while (0)
 
 	chkaddr(0, 0, sizeof(*mz));
-	if (mz->magic != MZ_MAGIC)
+	if (mz->magic != IMAGE_DOS_SIGNATURE)
 		return -ELIBBAD;
 	cursor = sizeof(*mz);
 
 	chkaddr(cursor, mz->peaddr, sizeof(*pe));
 	pe = pebuf + mz->peaddr;
-	if (pe->magic != PE_MAGIC)
+	if (pe->magic != IMAGE_NT_SIGNATURE)
 		return -ELIBBAD;
 	cursor = mz->peaddr + sizeof(*pe);
 
@@ -55,7 +55,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	pe64 = pebuf + cursor;
 
 	switch (pe32->magic) {
-	case PE_OPT_MAGIC_PE32:
+	case IMAGE_NT_OPTIONAL_HDR32_MAGIC:
 		chkaddr(0, cursor, sizeof(*pe32));
 		ctx->image_checksum_offset =
 			(unsigned long)&pe32->csum - (unsigned long)pebuf;
@@ -64,7 +64,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 		ctx->n_data_dirents = pe32->data_dirs;
 		break;
 
-	case PE_OPT_MAGIC_PE32PLUS:
+	case IMAGE_NT_OPTIONAL_HDR64_MAGIC:
 		chkaddr(0, cursor, sizeof(*pe64));
 		ctx->image_checksum_offset =
 			(unsigned long)&pe64->csum - (unsigned long)pebuf;
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index fb676ded47fa..57a52ba0c0b7 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -4,17 +4,17 @@
 
 #ifdef CONFIG_64BIT
 	.set		.Lextra_characteristics, 0x0
-	.set		.Lpe_opt_magic, PE_OPT_MAGIC_PE32PLUS
+	.set		.Lpe_opt_magic, IMAGE_NT_OPTIONAL_HDR64_MAGIC
 #else
 	.set		.Lextra_characteristics, IMAGE_FILE_32BIT_MACHINE
-	.set		.Lpe_opt_magic, PE_OPT_MAGIC_PE32
+	.set		.Lpe_opt_magic, IMAGE_NT_OPTIONAL_HDR32_MAGIC
 #endif
 
 	.section	".head", "a"
 	.globl		__efistub_efi_zboot_header
 __efistub_efi_zboot_header:
 .Ldoshdr:
-	.long		MZ_MAGIC
+	.long		IMAGE_DOS_SIGNATURE
 	.ascii		"zimg"					// image type
 	.long		__efistub__gzdata_start - .Ldoshdr	// payload offset
 	.long		__efistub__gzdata_size - ZBOOT_SIZE_LEN	// payload size
@@ -25,7 +25,7 @@ __efistub_efi_zboot_header:
 	.long		.Lpehdr - .Ldoshdr			// PE header offset
 
 .Lpehdr:
-	.long		PE_MAGIC
+	.long		IMAGE_NT_SIGNATURE
 	.short		MACHINE_TYPE
 	.short		.Lsection_count
 	.long		0
@@ -63,7 +63,7 @@ __efistub_efi_zboot_header:
 	.long		.Lefi_header_end - .Ldoshdr
 	.long		0
 	.short		IMAGE_SUBSYSTEM_EFI_APPLICATION
-	.short		IMAGE_DLL_CHARACTERISTICS_NX_COMPAT
+	.short		IMAGE_DLLCHARACTERISTICS_NX_COMPAT
 #ifdef CONFIG_64BIT
 	.quad		0, 0, 0, 0
 #else
diff --git a/include/linux/pe.h b/include/linux/pe.h
index fdf9c95709ba..cd2b7275385f 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -39,113 +39,160 @@
  */
 #define LINUX_PE_MAGIC	0x818223cd
 
-#define MZ_MAGIC	0x5a4d	/* "MZ" */
+#define IMAGE_DOS_SIGNATURE	0x5a4d /* "MZ" */
 
-#define PE_MAGIC		0x00004550	/* "PE\0\0" */
-#define PE_OPT_MAGIC_PE32	0x010b
-#define PE_OPT_MAGIC_PE32_ROM	0x0107
-#define PE_OPT_MAGIC_PE32PLUS	0x020b
+#define IMAGE_NT_SIGNATURE	0x00004550 /* "PE\0\0" */
+
+#define IMAGE_ROM_OPTIONAL_HDR_MAGIC	0x0107 /* ROM image (for R3000/R4000/R10000/ALPHA), without MZ and PE\0\0 sign */
+#define IMAGE_NT_OPTIONAL_HDR32_MAGIC	0x010b /* PE32 executable image */
+#define IMAGE_NT_OPTIONAL_HDR64_MAGIC	0x020b /* PE32+ executable image */
 
 /* machine type */
-#define	IMAGE_FILE_MACHINE_UNKNOWN	0x0000
-#define	IMAGE_FILE_MACHINE_AM33		0x01d3
-#define	IMAGE_FILE_MACHINE_AMD64	0x8664
-#define	IMAGE_FILE_MACHINE_ARM		0x01c0
-#define	IMAGE_FILE_MACHINE_ARMV7	0x01c4
-#define	IMAGE_FILE_MACHINE_ARM64	0xaa64
-#define	IMAGE_FILE_MACHINE_EBC		0x0ebc
-#define	IMAGE_FILE_MACHINE_I386		0x014c
-#define	IMAGE_FILE_MACHINE_IA64		0x0200
-#define	IMAGE_FILE_MACHINE_M32R		0x9041
-#define	IMAGE_FILE_MACHINE_MIPS16	0x0266
-#define	IMAGE_FILE_MACHINE_MIPSFPU	0x0366
-#define	IMAGE_FILE_MACHINE_MIPSFPU16	0x0466
-#define	IMAGE_FILE_MACHINE_POWERPC	0x01f0
-#define	IMAGE_FILE_MACHINE_POWERPCFP	0x01f1
-#define	IMAGE_FILE_MACHINE_R4000	0x0166
-#define	IMAGE_FILE_MACHINE_RISCV32	0x5032
-#define	IMAGE_FILE_MACHINE_RISCV64	0x5064
-#define	IMAGE_FILE_MACHINE_RISCV128	0x5128
-#define	IMAGE_FILE_MACHINE_SH3		0x01a2
-#define	IMAGE_FILE_MACHINE_SH3DSP	0x01a3
-#define	IMAGE_FILE_MACHINE_SH3E		0x01a4
-#define	IMAGE_FILE_MACHINE_SH4		0x01a6
-#define	IMAGE_FILE_MACHINE_SH5		0x01a8
-#define	IMAGE_FILE_MACHINE_THUMB	0x01c2
-#define	IMAGE_FILE_MACHINE_WCEMIPSV2	0x0169
-#define	IMAGE_FILE_MACHINE_LOONGARCH32	0x6232
-#define	IMAGE_FILE_MACHINE_LOONGARCH64	0x6264
+#define	IMAGE_FILE_MACHINE_UNKNOWN	0x0000 /* Unknown architecture */
+#define	IMAGE_FILE_MACHINE_TARGET_HOST	0x0001 /* Interacts with the host and not a WOW64 guest (not for file image) */
+#define	IMAGE_FILE_MACHINE_ALPHA_OLD	0x0183 /* DEC Alpha AXP 32-bit (old images) */
+#define	IMAGE_FILE_MACHINE_ALPHA	0x0184 /* DEC Alpha AXP 32-bit */
+#define	IMAGE_FILE_MACHINE_ALPHA64	0x0284 /* DEC Alpha AXP 64-bit (with 8kB page size) */
+#define	IMAGE_FILE_MACHINE_AXP64	IMAGE_FILE_MACHINE_ALPHA64
+#define	IMAGE_FILE_MACHINE_AM33		0x01d3 /* Matsushita AM33, now Panasonic MN103 */
+#define	IMAGE_FILE_MACHINE_AMD64	0x8664 /* AMD64 (x64) */
+#define	IMAGE_FILE_MACHINE_ARM		0x01c0 /* ARM Little-Endian (ARMv4) */
+#define	IMAGE_FILE_MACHINE_THUMB	0x01c2 /* ARM Thumb Little-Endian (ARMv4T) */
+#define	IMAGE_FILE_MACHINE_ARMNT	0x01c4 /* ARM Thumb-2 Little-Endian (ARMv7) */
+#define	IMAGE_FILE_MACHINE_ARMV7	IMAGE_FILE_MACHINE_ARMNT
+#define	IMAGE_FILE_MACHINE_ARM64	0xaa64 /* ARM64 Little-Endian (Classic ABI) */
+#define	IMAGE_FILE_MACHINE_ARM64EC	0xa641 /* ARM64 Little-Endian (Emulation Compatible ABI for AMD64) */
+#define	IMAGE_FILE_MACHINE_ARM64X	0xa64e /* ARM64 Little-Endian (fat binary with both Classic ABI and EC ABI code) */
+#define	IMAGE_FILE_MACHINE_CEE		0xc0ee /* COM+ Execution Engine (CLR pure MSIL object files) */
+#define	IMAGE_FILE_MACHINE_CEF		0x0cef /* Windows CE 3.0 Common Executable Format (CEF bytecode) */
+#define	IMAGE_FILE_MACHINE_CHPE_X86	0x3a64 /* ARM64 Little-Endian (Compiled Hybrid PE ABI for I386) */
+#define	IMAGE_FILE_MACHINE_HYBRID_X86	IMAGE_FILE_MACHINE_CHPE_X86
+#define	IMAGE_FILE_MACHINE_EBC		0x0ebc /* EFI/UEFI Byte Code */
+#define	IMAGE_FILE_MACHINE_I386		0x014c /* Intel 386 (x86) */
+#define	IMAGE_FILE_MACHINE_I860		0x014d /* Intel 860 (N10) */
+#define	IMAGE_FILE_MACHINE_IA64		0x0200 /* Intel IA-64 (with 8kB page size) */
+#define	IMAGE_FILE_MACHINE_LOONGARCH32	0x6232 /* LoongArch 32-bit processor family */
+#define	IMAGE_FILE_MACHINE_LOONGARCH64	0x6264 /* LoongArch 64-bit processor family */
+#define	IMAGE_FILE_MACHINE_M32R		0x9041 /* Mitsubishi M32R 32-bit Little-Endian */
+#define	IMAGE_FILE_MACHINE_M68K		0x0268 /* Motorola 68000 series */
+#define	IMAGE_FILE_MACHINE_MIPS16	0x0266 /* MIPS III with MIPS16 ASE Little-Endian */
+#define	IMAGE_FILE_MACHINE_MIPSFPU	0x0366 /* MIPS III with FPU Little-Endian */
+#define	IMAGE_FILE_MACHINE_MIPSFPU16	0x0466 /* MIPS III with MIPS16 ASE and FPU Little-Endian */
+#define	IMAGE_FILE_MACHINE_MPPC_601	0x0601 /* PowerPC 32-bit Big-Endian */
+#define	IMAGE_FILE_MACHINE_OMNI		0xace1 /* Microsoft OMNI VM (omniprox.dll) */
+#define	IMAGE_FILE_MACHINE_PARISC	0x0290 /* HP PA-RISC */
+#define	IMAGE_FILE_MACHINE_POWERPC	0x01f0 /* PowerPC 32-bit Little-Endian */
+#define	IMAGE_FILE_MACHINE_POWERPCFP	0x01f1 /* PowerPC 32-bit with FPU Little-Endian */
+#define	IMAGE_FILE_MACHINE_POWERPCBE	0x01f2 /* PowerPC 64-bit Big-Endian */
+#define	IMAGE_FILE_MACHINE_R3000	0x0162 /* MIPS I Little-Endian */
+#define	IMAGE_FILE_MACHINE_R3000_BE	0x0160 /* MIPS I Big-Endian */
+#define	IMAGE_FILE_MACHINE_R4000	0x0166 /* MIPS III Little-Endian (with 1kB or 4kB page size) */
+#define	IMAGE_FILE_MACHINE_R10000	0x0168 /* MIPS IV Little-Endian */
+#define	IMAGE_FILE_MACHINE_RISCV32	0x5032 /* RISC-V 32-bit address space */
+#define	IMAGE_FILE_MACHINE_RISCV64	0x5064 /* RISC-V 64-bit address space */
+#define	IMAGE_FILE_MACHINE_RISCV128	0x5128 /* RISC-V 128-bit address space */
+#define	IMAGE_FILE_MACHINE_SH3		0x01a2 /* Hitachi SH-3 32-bit Little-Endian (with 1kB page size) */
+#define	IMAGE_FILE_MACHINE_SH3DSP	0x01a3 /* Hitachi SH-3 DSP 32-bit (with 1kB page size) */
+#define	IMAGE_FILE_MACHINE_SH3E		0x01a4 /* Hitachi SH-3E Little-Endian (with 1kB page size) */
+#define	IMAGE_FILE_MACHINE_SH4		0x01a6 /* Hitachi SH-4 32-bit Little-Endian (with 1kB page size) */
+#define	IMAGE_FILE_MACHINE_SH5		0x01a8 /* Hitachi SH-5 64-bit */
+#define	IMAGE_FILE_MACHINE_TAHOE	0x07cc /* Intel EM machine */
+#define	IMAGE_FILE_MACHINE_TRICORE	0x0520 /* Infineon AUDO 32-bit */
+#define	IMAGE_FILE_MACHINE_WCEMIPSV2	0x0169 /* MIPS Windows CE v2 Little-Endian */
 
 /* flags */
-#define IMAGE_FILE_RELOCS_STRIPPED           0x0001
-#define IMAGE_FILE_EXECUTABLE_IMAGE          0x0002
-#define IMAGE_FILE_LINE_NUMS_STRIPPED        0x0004
-#define IMAGE_FILE_LOCAL_SYMS_STRIPPED       0x0008
-#define IMAGE_FILE_AGGRESSIVE_WS_TRIM        0x0010
-#define IMAGE_FILE_LARGE_ADDRESS_AWARE       0x0020
-#define IMAGE_FILE_16BIT_MACHINE             0x0040
-#define IMAGE_FILE_BYTES_REVERSED_LO         0x0080
-#define IMAGE_FILE_32BIT_MACHINE             0x0100
-#define IMAGE_FILE_DEBUG_STRIPPED            0x0200
-#define IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP   0x0400
-#define IMAGE_FILE_NET_RUN_FROM_SWAP         0x0800
-#define IMAGE_FILE_SYSTEM                    0x1000
-#define IMAGE_FILE_DLL                       0x2000
-#define IMAGE_FILE_UP_SYSTEM_ONLY            0x4000
-#define IMAGE_FILE_BYTES_REVERSED_HI         0x8000
-
-#define IMAGE_FILE_OPT_ROM_MAGIC	0x107
-#define IMAGE_FILE_OPT_PE32_MAGIC	0x10b
-#define IMAGE_FILE_OPT_PE32_PLUS_MAGIC	0x20b
-
-#define IMAGE_SUBSYSTEM_UNKNOWN			 0
-#define IMAGE_SUBSYSTEM_NATIVE			 1
-#define IMAGE_SUBSYSTEM_WINDOWS_GUI		 2
-#define IMAGE_SUBSYSTEM_WINDOWS_CUI		 3
-#define IMAGE_SUBSYSTEM_POSIX_CUI		 7
-#define IMAGE_SUBSYSTEM_WINDOWS_CE_GUI		 9
-#define IMAGE_SUBSYSTEM_EFI_APPLICATION		10
-#define IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER	11
-#define IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER	12
-#define IMAGE_SUBSYSTEM_EFI_ROM_IMAGE		13
-#define IMAGE_SUBSYSTEM_XBOX			14
-
-#define IMAGE_DLL_CHARACTERISTICS_DYNAMIC_BASE          0x0040
-#define IMAGE_DLL_CHARACTERISTICS_FORCE_INTEGRITY       0x0080
-#define IMAGE_DLL_CHARACTERISTICS_NX_COMPAT             0x0100
-#define IMAGE_DLLCHARACTERISTICS_NO_ISOLATION           0x0200
-#define IMAGE_DLLCHARACTERISTICS_NO_SEH                 0x0400
-#define IMAGE_DLLCHARACTERISTICS_NO_BIND                0x0800
-#define IMAGE_DLLCHARACTERISTICS_WDM_DRIVER             0x2000
-#define IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE  0x8000
-
-#define IMAGE_DLLCHARACTERISTICS_EX_CET_COMPAT		0x0001
-#define IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT	0x0040
-
-/* they actually defined 0x00000000 as well, but I think we'll skip that one. */
-#define IMAGE_SCN_RESERVED_0	0x00000001
-#define IMAGE_SCN_RESERVED_1	0x00000002
-#define IMAGE_SCN_RESERVED_2	0x00000004
-#define IMAGE_SCN_TYPE_NO_PAD	0x00000008 /* don't pad - obsolete */
-#define IMAGE_SCN_RESERVED_3	0x00000010
+#define IMAGE_FILE_RELOCS_STRIPPED		0x0001 /* Relocation info stripped from file */
+#define IMAGE_FILE_EXECUTABLE_IMAGE		0x0002 /* File is executable (i.e. no unresolved external references) */
+#define IMAGE_FILE_LINE_NUMS_STRIPPED		0x0004 /* Line nunbers stripped from file */
+#define IMAGE_FILE_LOCAL_SYMS_STRIPPED		0x0008 /* Local symbols stripped from file */
+#define IMAGE_FILE_AGGRESSIVE_WS_TRIM		0x0010 /* Aggressively trim working set */
+#define IMAGE_FILE_LARGE_ADDRESS_AWARE		0x0020 /* App can handle >2gb addresses (image can be loaded at address above 2GB) */
+#define IMAGE_FILE_16BIT_MACHINE		0x0040 /* 16 bit word machine */
+#define IMAGE_FILE_BYTES_REVERSED_LO		0x0080 /* Bytes of machine word are reversed (should be set together with IMAGE_FILE_BYTES_REVERSED_HI) */
+#define IMAGE_FILE_32BIT_MACHINE		0x0100 /* 32 bit word machine */
+#define IMAGE_FILE_DEBUG_STRIPPED		0x0200 /* Debugging info stripped from file in .DBG file */
+#define IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP	0x0400 /* If Image is on removable media, copy and run from the swap file */
+#define IMAGE_FILE_NET_RUN_FROM_SWAP		0x0800 /* If Image is on Net, copy and run from the swap file */
+#define IMAGE_FILE_SYSTEM			0x1000 /* System kernel-mode file (can't be loaded in user-mode) */
+#define IMAGE_FILE_DLL				0x2000 /* File is a DLL */
+#define IMAGE_FILE_UP_SYSTEM_ONLY		0x4000 /* File should only be run on a UP (uniprocessor) machine */
+#define IMAGE_FILE_BYTES_REVERSED_HI		0x8000 /* Bytes of machine word are reversed (should be set together with IMAGE_FILE_BYTES_REVERSED_LO) */
+
+/* subsys */
+#define IMAGE_SUBSYSTEM_UNKNOWN				 0 /* Unknown subsystem */
+#define IMAGE_SUBSYSTEM_NATIVE				 1 /* No subsystem required (NT device drivers and NT native system processes) */
+#define IMAGE_SUBSYSTEM_WINDOWS_GUI			 2 /* Windows graphical user interface (GUI) subsystem */
+#define IMAGE_SUBSYSTEM_WINDOWS_CUI			 3 /* Windows character-mode user interface (CUI) subsystem */
+#define IMAGE_SUBSYSTEM_WINDOWS_OLD_CE_GUI		 4 /* Old Windows CE subsystem */
+#define IMAGE_SUBSYSTEM_OS2_CUI				 5 /* OS/2 CUI subsystem */
+#define IMAGE_SUBSYSTEM_RESERVED_6			 6
+#define IMAGE_SUBSYSTEM_POSIX_CUI			 7 /* POSIX CUI subsystem */
+#define IMAGE_SUBSYSTEM_MMOSA				 8 /* MMOSA/Native Win32E */
+#define IMAGE_SUBSYSTEM_WINDOWS_CE_GUI			 9 /* Windows CE subsystem */
+#define IMAGE_SUBSYSTEM_EFI_APPLICATION			10 /* Extensible Firmware Interface (EFI) application */
+#define IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER		11 /* EFI driver with boot services */
+#define IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER		12 /* EFI driver with run-time services */
+#define IMAGE_SUBSYSTEM_EFI_ROM_IMAGE			13 /* EFI ROM image */
+#define IMAGE_SUBSYSTEM_XBOX				14 /* Xbox system */
+#define IMAGE_SUBSYSTEM_RESERVED_15			15
+#define IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION	16 /* Windows Boot application */
+#define IMAGE_SUBSYSTEM_XBOX_CODE_CATALOG		17 /* Xbox Code Catalog */
+
+/* dll_flags */
+#define IMAGE_LIBRARY_PROCESS_INIT			0x0001 /* DLL initialization function called just after process initialization */
+#define IMAGE_LIBRARY_PROCESS_TERM			0x0002 /* DLL initialization function called just before process termination */
+#define IMAGE_LIBRARY_THREAD_INIT			0x0004 /* DLL initialization function called just after thread initialization */
+#define IMAGE_LIBRARY_THREAD_TERM			0x0008 /* DLL initialization function called just before thread initialization */
+#define IMAGE_DLLCHARACTERISTICS_RESERVED_4		0x0010
+#define IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA	0x0020 /* ASLR with 64 bit address space (image can be loaded at address above 4GB) */
+#define IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE		0x0040 /* The DLL can be relocated at load time */
+#define IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY	0x0080 /* Code integrity checks are forced */
+#define IMAGE_DLLCHARACTERISTICS_NX_COMPAT		0x0100 /* Image is compatible with data execution prevention */
+#define IMAGE_DLLCHARACTERISTICS_NO_ISOLATION		0x0200 /* Image is isolation aware, but should not be isolated (prevents loading of manifest file) */
+#define IMAGE_DLLCHARACTERISTICS_NO_SEH			0x0400 /* Image does not use SEH, no SE handler may reside in this image */
+#define IMAGE_DLLCHARACTERISTICS_NO_BIND		0x0800 /* Do not bind the image */
+#define IMAGE_DLLCHARACTERISTICS_X86_THUNK		0x1000 /* Image is a Wx86 Thunk DLL (for non-x86/risc DLL files) */
+#define IMAGE_DLLCHARACTERISTICS_APPCONTAINER		0x1000 /* Image should execute in an AppContainer (for EXE Metro Apps in Windows 8) */
+#define IMAGE_DLLCHARACTERISTICS_WDM_DRIVER		0x2000 /* A WDM driver */
+#define IMAGE_DLLCHARACTERISTICS_GUARD_CF		0x4000 /* Image supports Control Flow Guard */
+#define IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE	0x8000 /* The image is terminal server (Remote Desktop Services) aware */
+
+/* IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS flags */
+#define IMAGE_DLLCHARACTERISTICS_EX_CET_COMPAT					0x0001 /* Image is Control-flow Enforcement Technology Shadow Stack compatible */
+#define IMAGE_DLLCHARACTERISTICS_EX_CET_COMPAT_STRICT_MODE			0x0002 /* CET is enforced in strict mode */
+#define IMAGE_DLLCHARACTERISTICS_EX_CET_SET_CONTEXT_IP_VALIDATION_RELAXED_MODE	0x0004 /* Relaxed mode for Context IP Validation under CET is allowed */
+#define IMAGE_DLLCHARACTERISTICS_EX_CET_DYNAMIC_APIS_ALLOW_IN_PROC		0x0008 /* Use of dynamic APIs is restricted to processes only */
+#define IMAGE_DLLCHARACTERISTICS_EX_CET_RESERVED_1				0x0010
+#define IMAGE_DLLCHARACTERISTICS_EX_CET_RESERVED_2				0x0020
+#define IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT				0x0040 /* All branch targets in all image code sections are annotated with forward-edge control flow integrity guard instructions */
+#define IMAGE_DLLCHARACTERISTICS_EX_HOTPATCH_COMPATIBLE				0x0080 /* Image can be modified while in use, hotpatch-compatible */
+
+/* section_header flags */
+#define IMAGE_SCN_SCALE_INDEX	0x00000001 /* address of tls index is scaled = multiplied by 4 (for .tls section on MIPS only) */
+#define IMAGE_SCN_TYPE_NO_LOAD	0x00000002 /* reserved */
+#define IMAGE_SCN_TYPE_GROUPED	0x00000004 /* obsolete (used for 16-bit offset code) */
+#define IMAGE_SCN_TYPE_NO_PAD	0x00000008 /* .o only - don't pad - obsolete (same as IMAGE_SCN_ALIGN_1BYTES) */
+#define IMAGE_SCN_TYPE_COPY	0x00000010 /* reserved */
 #define IMAGE_SCN_CNT_CODE	0x00000020 /* .text */
 #define IMAGE_SCN_CNT_INITIALIZED_DATA 0x00000040 /* .data */
 #define IMAGE_SCN_CNT_UNINITIALIZED_DATA 0x00000080 /* .bss */
-#define IMAGE_SCN_LNK_OTHER	0x00000100 /* reserved */
-#define IMAGE_SCN_LNK_INFO	0x00000200 /* .drectve comments */
-#define IMAGE_SCN_RESERVED_4	0x00000400
+#define IMAGE_SCN_LNK_OTHER	0x00000100 /* .o only - other type than code, data or info */
+#define IMAGE_SCN_LNK_INFO	0x00000200 /* .o only - .drectve comments */
+#define IMAGE_SCN_LNK_OVERLAY	0x00000400 /* section contains overlay */
 #define IMAGE_SCN_LNK_REMOVE	0x00000800 /* .o only - scn to be rm'd*/
 #define IMAGE_SCN_LNK_COMDAT	0x00001000 /* .o only - COMDAT data */
-#define IMAGE_SCN_RESERVED_5	0x00002000 /* spec omits this */
-#define IMAGE_SCN_RESERVED_6	0x00004000 /* spec omits this */
-#define IMAGE_SCN_GPREL		0x00008000 /* global pointer referenced data */
-/* spec lists 0x20000 twice, I suspect they meant 0x10000 for one of them */
-#define IMAGE_SCN_MEM_PURGEABLE	0x00010000 /* reserved for "future" use */
-#define IMAGE_SCN_16BIT		0x00020000 /* reserved for "future" use */
-#define IMAGE_SCN_LOCKED	0x00040000 /* reserved for "future" use */
-#define IMAGE_SCN_PRELOAD	0x00080000 /* reserved for "future" use */
+#define IMAGE_SCN_RESERVED_13	0x00002000 /* spec omits this */
+#define IMAGE_SCN_MEM_PROTECTED	0x00004000 /* section is memory protected (for M68K) */
+#define IMAGE_SCN_NO_DEFER_SPEC_EXC 0x00004000 /* reset speculative exceptions handling bits in the TLB entries (for non-M68K) */
+#define IMAGE_SCN_MEM_FARDATA	0x00008000 /* section uses FAR_EXTERNAL relocations (for M68K) */
+#define IMAGE_SCN_GPREL		0x00008000 /* global pointer referenced data (for non-M68K) */
+#define IMAGE_SCN_MEM_SYSHEAP	0x00010000 /* use system heap (for M68K) */
+#define IMAGE_SCN_MEM_PURGEABLE	0x00020000 /* section can be released from RAM (for M68K) */
+#define IMAGE_SCN_MEM_16BIT	0x00020000 /* section is 16-bit (for non-M68K where it makes sense: I386, THUMB, MIPS16, MIPSFPU16, ...) */
+#define IMAGE_SCN_MEM_LOCKED	0x00040000 /* prevent the section from being moved (for M68K and .o I386) */
+#define IMAGE_SCN_MEM_PRELOAD	0x00080000 /* section is preload to RAM (for M68K and .o I386) */
 /* and here they just stuck a 1-byte integer in the middle of a bitfield */
-#define IMAGE_SCN_ALIGN_1BYTES	0x00100000 /* it does what it says on the box */
+#define IMAGE_SCN_ALIGN_1BYTES	0x00100000 /* .o only - it does what it says on the box */
 #define IMAGE_SCN_ALIGN_2BYTES	0x00200000
 #define IMAGE_SCN_ALIGN_4BYTES	0x00300000
 #define IMAGE_SCN_ALIGN_8BYTES	0x00400000
@@ -159,7 +206,9 @@
 #define IMAGE_SCN_ALIGN_2048BYTES 0x00c00000
 #define IMAGE_SCN_ALIGN_4096BYTES 0x00d00000
 #define IMAGE_SCN_ALIGN_8192BYTES 0x00e00000
-#define IMAGE_SCN_LNK_NRELOC_OVFL 0x01000000 /* extended relocations */
+#define IMAGE_SCN_ALIGN_RESERVED 0x00f00000
+#define IMAGE_SCN_ALIGN_MASK	0x00f00000
+#define IMAGE_SCN_LNK_NRELOC_OVFL 0x01000000 /* .o only - extended relocations */
 #define IMAGE_SCN_MEM_DISCARDABLE 0x02000000 /* scn can be discarded */
 #define IMAGE_SCN_MEM_NOT_CACHED 0x04000000 /* cannot be cached */
 #define IMAGE_SCN_MEM_NOT_PAGED	0x08000000 /* not pageable */
@@ -168,8 +217,28 @@
 #define IMAGE_SCN_MEM_READ	0x40000000 /* readable */
 #define IMAGE_SCN_MEM_WRITE	0x80000000 /* writeable */
 
-#define IMAGE_DEBUG_TYPE_CODEVIEW	2
-#define IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS	20
+#define IMAGE_DEBUG_TYPE_UNKNOWN		 0 /* Unknown value, ignored by all tools */
+#define IMAGE_DEBUG_TYPE_COFF			 1 /* COFF debugging information */
+#define IMAGE_DEBUG_TYPE_CODEVIEW		 2 /* CodeView debugging information or Visual C++ Program Database debugging information */
+#define IMAGE_DEBUG_TYPE_FPO			 3 /* Frame pointer omission (FPO) information */
+#define IMAGE_DEBUG_TYPE_MISC			 4 /* Location of DBG file with CodeView debugging information */
+#define IMAGE_DEBUG_TYPE_EXCEPTION		 5 /* Exception information, copy of .pdata section */
+#define IMAGE_DEBUG_TYPE_FIXUP			 6 /* Fixup information */
+#define IMAGE_DEBUG_TYPE_OMAP_TO_SRC		 7 /* The mapping from an RVA in image to an RVA in source image */
+#define IMAGE_DEBUG_TYPE_OMAP_FROM_SRC		 8 /* The mapping from an RVA in source image to an RVA in image */
+#define IMAGE_DEBUG_TYPE_BORLAND		 9 /* Borland debugging information */
+#define IMAGE_DEBUG_TYPE_RESERVED10		10 /* Coldpath / Hotpatch debug information */
+#define IMAGE_DEBUG_TYPE_CLSID			11 /* CLSID */
+#define IMAGE_DEBUG_TYPE_VC_FEATURE		12 /* Visual C++ counts / statistics */
+#define IMAGE_DEBUG_TYPE_POGO			13 /* COFF group information, data for profile-guided optimization */
+#define IMAGE_DEBUG_TYPE_ILTCG			14 /* Incremental link-time code generation */
+#define IMAGE_DEBUG_TYPE_MPX			15 /* Intel Memory Protection Extensions */
+#define IMAGE_DEBUG_TYPE_REPRO			16 /* PE determinism or reproducibility */
+#define IMAGE_DEBUG_TYPE_EMBEDDED_PORTABLE_PDB	17 /* Embedded Portable PDB debugging information */
+#define IMAGE_DEBUG_TYPE_SPGO			18 /* Sample profile-guided optimization */
+#define IMAGE_DEBUG_TYPE_PDBCHECKSUM		19 /* PDB Checksum */
+#define IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS	20 /* Extended DLL characteristics bits */
+#define IMAGE_DEBUG_TYPE_PERFMAP		21 /* Location of associated Ready To Run PerfMap file */
 
 #ifndef __ASSEMBLY__
 
@@ -235,7 +304,7 @@ struct pe32_opt_hdr {
 	uint16_t image_minor;	/* minor image version */
 	uint16_t subsys_major;	/* major subsystem version */
 	uint16_t subsys_minor;	/* minor subsystem version */
-	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t win32_version;	/* win32 version reported at runtime */
 	uint32_t image_size;	/* image size */
 	uint32_t header_size;	/* header size rounded up to
 				   file_align */
@@ -246,7 +315,7 @@ struct pe32_opt_hdr {
 	uint32_t stack_size;	/* amt of stack required */
 	uint32_t heap_size_req;	/* amt of heap requested */
 	uint32_t heap_size;	/* amt of heap required */
-	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t loader_flags;	/* loader flags */
 	uint32_t data_dirs;	/* number of data dir entries */
 };
 
@@ -269,7 +338,7 @@ struct pe32plus_opt_hdr {
 	uint16_t image_minor;	/* minor image version */
 	uint16_t subsys_major;	/* major subsystem version */
 	uint16_t subsys_minor;	/* minor subsystem version */
-	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t win32_version;	/* win32 version reported at runtime */
 	uint32_t image_size;	/* image size */
 	uint32_t header_size;	/* header size rounded up to
 				   file_align */
@@ -280,7 +349,7 @@ struct pe32plus_opt_hdr {
 	uint64_t stack_size;	/* amt of stack required */
 	uint64_t heap_size_req;	/* amt of heap requested */
 	uint64_t heap_size;	/* amt of heap required */
-	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t loader_flags;	/* loader flags */
 	uint32_t data_dirs;	/* number of data dir entries */
 };
 
@@ -301,10 +370,10 @@ struct data_directory {
 	struct data_dirent global_ptr;		/* global pointer reg. Size=0 */
 	struct data_dirent tls;			/* .tls */
 	struct data_dirent load_config;		/* load configuration structure */
-	struct data_dirent bound_imports;	/* no idea */
+	struct data_dirent bound_imports;	/* bound import table */
 	struct data_dirent import_addrs;	/* import address table */
 	struct data_dirent delay_imports;	/* delay-load import table */
-	struct data_dirent clr_runtime_hdr;	/* .cor (object only) */
+	struct data_dirent clr_runtime_hdr;	/* .cor (clr/.net executables) */
 	struct data_dirent reserved;
 };
 
-- 
2.20.1


