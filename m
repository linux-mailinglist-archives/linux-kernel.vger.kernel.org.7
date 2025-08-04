Return-Path: <linux-kernel+bounces-755348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F0B1A540
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33DA3BF56F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154420459A;
	Mon,  4 Aug 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="eQZhV50Y"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353F1F461A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319038; cv=none; b=MNeLsF8B2WFjTuvITChmYMGWxi4lsJjYbzpQ//BYVJiMUM+r2oJE07esHLXNvD9i+KnyJG8WXsjCMd3LuQB5kGMPVWavT9KRxp+1yw+ccgqtTBeWxJpeMF/yjPvXXruRcB35fji2q6kos2o5sUF5f/YHENspt04fyJx02WZtXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319038; c=relaxed/simple;
	bh=LnQxqH3lDeK67eetD5otmqjLXLITzdqMOJidSn8o2kU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WJgNOMg9VLTS/YORX/BQa9nT2Cs0EAU3nqeci1K1zt2JBcsEQs+Hq+lyNMmI6QVeuBr9Rz3gF/xf4StMF+QDQ73Wihl42TqCycAkUGsRc5za3t6mEAM9UZYeIQnbdCel9CSvBQHYZFYnozmKtnOpfhNqTqBdfihGPGXFqKhXNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=eQZhV50Y; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso6931799a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1754319034; x=1754923834; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjmP8ZmFhoD131nEzDejtjld6bY4exY6+PsLnaQyfHo=;
        b=eQZhV50Y5nLuYhq60vcTmzWbVL6fCmR9ujU+oPTnSgTD4z0J1/mC1Kn96gxlEzoK+g
         GRF8HRtxKAstHpCLgW2liDezZ5kzM6SnkE0foD1frncQxHX5BDG8dEC7S9CB/PiHjYG6
         AUY79o5wgRufQtrqUXPncqhjgKzNfKinEpiwotvFlIjgwwX9GKvfucX7LXiS/WTNLobQ
         m3Kltv0orsP1pZaqse49ueVNNkg3xLQGjBH+TAnY4euZLfnMz7W+rFAS2CbWr5taXw02
         E98/mMhY/ee6gsMb06SN4QV9Z486RN+bHXg6CIVWq/6WUQRD6xKm5L+bvkCVyNqzXoqA
         doHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319034; x=1754923834;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjmP8ZmFhoD131nEzDejtjld6bY4exY6+PsLnaQyfHo=;
        b=PSR71qwxN5UkdXlWqoZ9WvoFqbUxBuMp4AZI80FK2rDXsRGhH7M8ypHZ+pGCOwfPGg
         7Z0QJ00W0ZatXZf8VE1qbMnijCWxU1rmHqcsKGDO8rnmDFJbqjWAd0CWwOSNWsnWNUJk
         FNVL+7HPt8X1VAMBd1XFLz28ipSPtWPNb0oZM7JRIKDqMp6Xv5WaL3fdOccrHSy+OCFZ
         ZaPJ3N4uXyZhyApRdfuHoutlgz3ZRlUG1ITmH+oblDiX5q3t567Kt/zaN078UZJR/W6q
         vnrC701f2+YimTIPMlOIbUWamgBrUo4+Lvxg2VovlL0b5Wqx0zCO1QbyD9VSxepaSXud
         DZNA==
X-Gm-Message-State: AOJu0Yxp5yG8SaOQo/iKEZAioiKMMTe4AwMTR7W3hEJX+kaJnCu+pVbg
	r61mhwESp7RKZ4xzcnBqZQai1Uc8dB1Sw+FK1fZMy3GVf8gbucQK8AS4VEn+YiHhRQ==
X-Gm-Gg: ASbGncsOUm1UfjPiMuu5s1J+HlxfYHEp1rNSHS0EIwj1JkAJWaOT3TS9m464p5z2gNq
	kqW7HR1peIcNaM+8+fB4UCoAM5/b0VFS4EtNtjT8yBDHGPtzwbUTR47Tuhs8MsX6eTwHBe8AS9/
	H3nH+JVnWT0B919km8/qR4ZzmkRzRQ0zpVOIut3tUJly476+lehukz9+5dxcRBDA1DOqzstISnT
	zF2AMIvxB4mFEjBbnq5YXWXN8NJxs98iNB8vSkp/BX4alKuvcpvrmcRXzcY60g1bG69PEbYsr64
	BgzLgN8ZKC/hv6XGNtnKunP+NMxBgS4pfaQEY9JK/MsaSp1GNV7DzAQ4sfotHSuqMVlVXRAaX0l
	R4TF0RXNKRtO78c6akVVzNfGtlk+O
X-Google-Smtp-Source: AGHT+IHiGibN8H6hkzgUlMVGPcif0Yy4NcuUi+ikT+H6XAgBl1j7ouwKKo2Y7j83YjDLicot+L0TyQ==
X-Received: by 2002:a17:907:7f05:b0:ad8:9257:573a with SMTP id a640c23a62f3a-af93ffcc3bbmr1040440866b.5.1754319033494;
        Mon, 04 Aug 2025 07:50:33 -0700 (PDT)
Received: from [192.168.28.4] ([2a02:908:1578:7a43::f08])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8306sm750094466b.83.2025.08.04.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:50:33 -0700 (PDT)
From: Michal Gorlas <michal.gorlas@9elements.com>
Date: Mon, 04 Aug 2025 16:50:12 +0200
Subject: [PATCH v3] firmware: coreboot: Linux-owned SMI handler and its
 loader
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-coreboot-payload-mm-v3-1-7bb7fda9e4d9@9elements.com>
X-B4-Tracking: v=1; b=H4sIAKPIkGgC/22OwQqDMBAFf0VyboLGGGtP/Y/iIeqqAePKJkhF/
 PdGoZfS4xzevNmZB7Lg2SPZGcFqvcU5Qn5LWDuaeQBuu8hMprJIdZbzFgkaxMAXs01oOu4c11r
 JplFS3pVhcbkQ9PZ9WV915J7Q8TASmMvV4gokslJVZa7SSonBBuFs/JvEgDQZ/6xgAgdz8KJFd
 ypH6wPSdnWu8hR/k/TfpFXylBedLqtG3yVk+Y+yPo7jAzCTQg39AAAA
X-Change-ID: 20250613-coreboot-payload-mm-6642bb42284a
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Michal Gorlas <michal.gorlas@9elements.com>
X-Mailer: b4 0.14.2

coreboot exposes System Management Mode (SMM) related data in the
coreboot table. Extend exisiting interface with structure corresponding
to SMM data, and add COREBOOT_PAYLOAD_MM config.
Load Linux-owned SMI handler:
 - Place Linux-owned SMI handler in arbitrary location in the lower 4GB of
   memory.
 - Inform coreboot about the location of Linux-owned SMI handler via an
   SMI, coreboot copy the handler to SMRAM and redirects upcoming SMIs
   to it.

Linux-owned SMI is compiled in a similar fashion to the realmode
trampolines for x86. Currently supported are two SMIs: ACPI enable and
disable.

Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
---
Hi,

This patchset adds support for Management Mode (MM) payload when Linux is used as
coreboot's payload. The main idea is to delegate higher-level SMM
functions to the payload, limiting the coreboot's System Management
Mode (SMM) related responsibilities to the minimum of basic SMM setup [1]. This is
done by loading a blob with SMI handler to the shared buffer, from
which it is copied to SMRAM [2].

The MM payload is still in a Proof of Concept stage, and we are still
working on getting the patches needed for coreboot upstreamed, but I would
appreciate any feedback that you may have.

Thanks,
Michal

[1]: https://github.com/9elements/LinuxBootSMM/wiki/Proposed-design#current-design-approach---mm-payload
[2]: https://github.com/9elements/LinuxBootSMM/wiki/Proof-of-Concept-(PoC)

Changes in v3:
- merged patches into one
- rephrased commit messages to use imperative mode 
- replaced -1 and PAYLOAD_MM_RET_FAILURE with -errno
- removed delay in favour of making driver !SMP dependent
- removed get_mm_info() in favour of conditional check in
  mm_loader_probe
- added driver specific struct accessed via dev_get_drvdata()
- Link to v2: https://lore.kernel.org/r/20250616-coreboot-payload-mm-v2-0-5d679b682e13@9elements.com

Changes in v2:
- merged mm_info into mm_loader
- removed mm_loader_exit in favour of allocating memory with devm_*()
- added forgotten "\n\t" in trigger_smi()
- added gitignore in mm_handler/
- added COREBOOT_PAYLOAD_MM dependency on x86
- error handling for mm_info struct
- error handling for shared_buffer
- removed whitespace changes in coreboot_table.h
- removed INFO level prints
- Link to v1: https://lore.kernel.org/r/cover.1749734094.git.michal.gorlas@9elements.com
---
 drivers/firmware/google/Kconfig                  |  12 +
 drivers/firmware/google/Makefile                 |  11 +
 drivers/firmware/google/coreboot_table.h         |  11 +
 drivers/firmware/google/mm_blob.S                |  20 +
 drivers/firmware/google/mm_handler/.gitignore    |   4 +
 drivers/firmware/google/mm_handler/Makefile      |  51 +++
 drivers/firmware/google/mm_handler/handler.lds.S |  46 ++
 drivers/firmware/google/mm_handler/mm_handler.S  | 510 +++++++++++++++++++++++
 drivers/firmware/google/mm_handler/mm_handler.h  |  21 +
 drivers/firmware/google/mm_handler/mm_header.S   |  19 +
 drivers/firmware/google/mm_loader.c              | 202 +++++++++
 drivers/firmware/google/mm_payload.h             |  48 +++
 12 files changed, 955 insertions(+)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 41b78f5cb7351e512cbaeb6443634a4b97bf6255..5c3346d276d246f2233ff91a32b13449266fc2ca 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -81,4 +81,16 @@ config GOOGLE_VPD
 	  This option enables the kernel to expose the content of Google VPD
 	  under /sys/firmware/vpd.
 
+config COREBOOT_PAYLOAD_MM
+	tristate "SMI handling in Linux (LinuxBootSMM)"
+	depends on X86 && GOOGLE_COREBOOT_TABLE && !SMP
+	help
+	  Enables support for SMI handling by Linux-owned code.
+	  coreboot reserves region for payload-owned SMI handler, the Linux
+	  driver prepares its SMI handler outside of SMRAM, and lets coreboot
+	  know where the handler is placed by issuing an SMI. On this SMI, the
+	  handler is being placed in SMRAM and all supported SMIs from that point
+	  on are handled by Linux-owned SMI handler.
+	  If in doubt, say N.
+
 endif # GOOGLE_FIRMWARE
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index 8151e323cc434673b0fe56f1df1cec2fb7873295..893e6a9e4ea018997db819ef53fcbb8e8bccc15d 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -12,3 +12,14 @@ obj-$(CONFIG_GOOGLE_CBMEM)		+= cbmem.o
 
 vpd-sysfs-y := vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
+
+# LinuxBootSMM related.
+subdir-$(CONFIG_COREBOOT_PAYLOAD_MM)		+= mm_handler
+
+$(obj)/mm_handler/handler.bin: FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/mm_handler $@
+
+$(obj)/mm_blob.o: $(obj)/mm_handler/handler.bin
+
+payload-mm-$(CONFIG_COREBOOT_PAYLOAD_MM)	:= mm_loader.o mm_blob.o
+obj-$(CONFIG_COREBOOT_PAYLOAD_MM)		+= payload-mm.o
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index bb6f0f7299b4670d0b1f91bd7a3c038cdb412f7b..8a7934e679903e39ce1d86b4aecbc2b4e89363fd 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -52,6 +52,16 @@ struct lb_cbmem_entry {
 	u32 id;
 };
 
+/* Corresponds to LB_TAG_PLD_MM_INTERFACE_INFO */
+#define LB_TAG_PLD_MM_INTERFACE_INFO 0x3b
+struct lb_pld_mm_interface_info {
+	u32 tag;
+	u32 size;
+	u8 revision;
+	u8 requires_long_mode_call;
+	u8 register_mm_entry_command;
+};
+
 /* Describes framebuffer setup by coreboot */
 struct lb_framebuffer {
 	u32 tag;
@@ -80,6 +90,7 @@ struct coreboot_device {
 		struct lb_cbmem_ref cbmem_ref;
 		struct lb_cbmem_entry cbmem_entry;
 		struct lb_framebuffer framebuffer;
+		struct lb_pld_mm_interface_info mm_info;
 		DECLARE_FLEX_ARRAY(u8, raw);
 	};
 };
diff --git a/drivers/firmware/google/mm_blob.S b/drivers/firmware/google/mm_blob.S
new file mode 100644
index 0000000000000000000000000000000000000000..d45ff661d74ab85fbb283704df7ceeee475dcbc5
--- /dev/null
+++ b/drivers/firmware/google/mm_blob.S
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Derived from rmpiggy.S.
+ *
+ * Wrapper script for the MM payload binary as a transport object
+ * before copying to SMRAM memory.
+ */
+#include <linux/linkage.h>
+#include <asm/page_types.h>
+
+	.section ".data","aw"
+
+	.balign PAGE_SIZE
+
+SYM_DATA_START(mm_blob)
+	.incbin	"drivers/firmware/google/mm_handler/handler.bin"
+SYM_DATA_END_LABEL(mm_blob, SYM_L_GLOBAL, mm_blob_end)
+
+SYM_DATA_START(mm_relocs)
+	.incbin	"drivers/firmware/google/mm_handler/handler.relocs"
+SYM_DATA_END(mm_relocs)
diff --git a/drivers/firmware/google/mm_handler/.gitignore b/drivers/firmware/google/mm_handler/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..662f71dca9ce9dceeaf526746a6f323044296439
--- /dev/null
+++ b/drivers/firmware/google/mm_handler/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+pasyms.h
+handler.lds
+handler.relocs
diff --git a/drivers/firmware/google/mm_handler/Makefile b/drivers/firmware/google/mm_handler/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..c0069e88f51dc536878429c8e1504e9376932c04
--- /dev/null
+++ b/drivers/firmware/google/mm_handler/Makefile
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+
+## Based on realmode/rm/Makefile
+
+always-y := handler.bin handler.relocs
+
+handler-y			+= mm_header.o
+handler-y			+= mm_handler.o
+
+targets	+= $(handler-y)
+
+REALMODE_OBJS = $(addprefix $(obj)/,$(handler-y))
+
+sed-pasyms := -n -r -e 's/^([0-9a-fA-F]+) [ABCDGRSTVW] (.+)$$/pa_\2 = \2;/p'
+
+quiet_cmd_pasyms = PASYMS  $@
+      cmd_pasyms = $(NM) $(real-prereqs) | sed $(sed-pasyms) | sort | uniq > $@
+
+targets += pasyms.h
+$(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
+	$(call if_changed,pasyms)
+
+targets += handler.lds
+$(obj)/handler.lds: $(obj)/pasyms.h
+
+LDFLAGS_handler.elf := -m elf_i386 --emit-relocs -T
+CPPFLAGS_handler.lds += -P -C -I$(objtree)/$(obj)
+
+targets += handler.elf
+$(obj)/handler.elf: $(obj)/handler.lds $(REALMODE_OBJS) FORCE
+	$(call if_changed,ld)
+
+OBJCOPYFLAGS_handler.bin := -O binary
+
+targets += handler.bin
+$(obj)/handler.bin: $(obj)/handler.elf $(obj)/handler.relocs FORCE
+	$(call if_changed,objcopy)
+
+quiet_cmd_relocs = RELOCS  $@
+      cmd_relocs = arch/x86/tools/relocs --realmode $< > $@
+
+targets += handler.relocs
+$(obj)/handler.relocs: $(obj)/handler.elf FORCE
+	$(call if_changed,relocs)
+
+# ---------------------------------------------------------------------------
+
+KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
+		   -I$(srctree)/arch/x86/boot
+KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
diff --git a/drivers/firmware/google/mm_handler/handler.lds.S b/drivers/firmware/google/mm_handler/handler.lds.S
new file mode 100644
index 0000000000000000000000000000000000000000..c92c9f2fbd624d0d988be0bd0215f70c3e4284e0
--- /dev/null
+++ b/drivers/firmware/google/mm_handler/handler.lds.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * blob.lds.S
+ *
+ * Linker script for the MM handler. Based on realmode.lds.S
+ */
+
+#include <asm/page_types.h>
+
+#undef i386
+
+OUTPUT_FORMAT("elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(pa_text_start)
+
+SECTIONS
+{
+	. = 0;
+	.header : {
+		*(.header)
+	}
+
+	pa_text_start = .;
+	.text32 : {
+		*(.text32)
+		*(.text32.*)
+	}
+
+	.text64 : {
+		*(.text64)
+		*(.text64.*)
+	}
+
+	. = ALIGN(128);
+	.bss : {
+		*(.bss*)
+	}
+
+	/DISCARD/ : {
+		*(.data*)
+		*(.note*)
+		*(.debug*)
+	}
+
+#include "pasyms.h"
+}
diff --git a/drivers/firmware/google/mm_handler/mm_handler.S b/drivers/firmware/google/mm_handler/mm_handler.S
new file mode 100644
index 0000000000000000000000000000000000000000..19322010a4231cbd7d9c0aac5605a56eac098789
--- /dev/null
+++ b/drivers/firmware/google/mm_handler/mm_handler.S
@@ -0,0 +1,510 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *	Payload owned SMI handler that is placed in SMRAM (mm_loader.c) and called
+ *	by coreboot's SMI handler
+ *
+ *	Also the general comment in arch/x86/realmode/rm/trampoline_64.S is relevant
+ *	here as well.
+ */
+
+#include <linux/linkage.h>
+#include <asm/pgtable_types.h>
+#include <asm/page_types.h>
+#include <asm/msr.h>
+#include <asm/segment.h>
+#include <asm/processor-flags.h>
+#include <asm/realmode.h>
+
+#include "mm_handler.h"
+
+	.section ".text32","ax"
+	.code32
+	.balign 4
+SYM_CODE_START(mm_entry_32)
+	mov	$0x3f8, %dx
+	mov	$'L', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'u', %al
+	out	%al, (%dx)
+	mov	$'x', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'S', %al
+	out	%al, (%dx)
+	mov	$'M', %al
+	out	%al, (%dx)
+	mov	$'I', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'h', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'d', %al
+	out	%al, (%dx)
+	mov	$'l', %al
+	out	%al, (%dx)
+	mov	$'e', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'s', %al
+	out	%al, (%dx)
+	mov	$'t', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$'t', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'g', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	push	%esp
+	// ebx, esi, edi and ebp are going to be preserved
+	// (see comment in smm_stub.S if target is x86_64)
+	push	%ebx
+	push	%esi
+	push	%edi
+	push	%ebp
+	push	%eax
+
+	/*
+	 * Switch-case to jump to appropriate section for given functionality.
+	 * Macros are defined in mm_handler.h.
+	 * Short explaination of where does the magic n(%esp) came from.
+	 * Calling mm_entry_32 from coreboot pushes lb_entry_context
+	 * (see include/payload_mm_interface.h) to stack and
+	 * increments esp by 4, so now our stack looks like this:
+	 * | third arg |
+	 * | second arg |
+	 * | first arg |
+	 * | return address |
+	 * | stack pointer | <- esp
+	 * Then we push all the registers (see above) and hence our stack looks like this now:
+	 * | third arg |
+	 * | second arg |
+	 * | first arg |
+	 * | return address |
+	 * | esp |
+	 * | ebx |
+	 * | esi |
+	 * | edi |
+	 * | ebp |
+	 * | eax |
+	 * | stack pointer | <- esp
+	 * So, now to get the entry we need, we do (9 * 4)(%esp) to get third
+	 * argument (ACPI base address), (8 * 4)(%esp) to get second argument
+	 * (PM1_CNT byte), and (7 * 4) to get the command.
+	 */
+
+	cmpl $MM_ACPI_ENABLE, 28(%esp)
+	je acpi_enable32
+
+	cmpl $MM_ACPI_DISABLE, 28(%esp)
+	je acpi_disable32
+
+	cmpl $MM_STORE, 28(%esp)
+	je mm_store32
+
+	jmp restore_cb_state
+
+acpi_enable32:
+	mov	$0x3f8, %dx
+	mov	$'E', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'b', %al
+	out	%al, (%dx)
+	mov	$'l', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'g', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'A', %al
+	out	%al, (%dx)
+	mov	$'C', %al
+	out	%al, (%dx)
+	mov	$'P', %al
+	out	%al, (%dx)
+	mov	$'I', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	// PM1_CNT & ~SCI_EN
+	mov	32(%esp), %ax
+	add	$MM_ACPI_ENABLE, %ax
+
+	// ACPI_BASE_ADDR
+	mov	36(%esp), %dx
+
+	out	%ax, %dx
+
+	jmp	restore_cb_state
+
+acpi_disable32:
+	mov	$0x3f8, %dx
+	mov	$'D', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'s', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'b', %al
+	out	%al, (%dx)
+	mov	$'l', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'g', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'A', %al
+	out	%al, (%dx)
+	mov	$'C', %al
+	out	%al, (%dx)
+	mov	$'P', %al
+	out	%al, (%dx)
+	mov	$'I', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	// PM1_CNT | SCI_EN
+	mov	32(%esp), %ax
+	add	$MM_ACPI_DISABLE, %ax
+
+	// ACPI_BASE_ADDR
+	mov	36(%esp), %dx
+
+	out	%ax, %dx
+
+	jmp	restore_cb_state
+
+mm_store32:
+	// Not implemented yet. Probably would be better to do that in C.
+
+restore_cb_state:
+	mov	$0x3f8, %dx
+	mov	$'M', %al
+	out	%al, (%dx)
+	mov	$'M', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$'e', %al
+	out	%al, (%dx)
+	mov	$'t', %al
+	out	%al, (%dx)
+	mov	$'u', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'s', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	pop	%eax
+	pop	%ebp
+	pop	%edi
+	pop	%esi
+	pop	%ebx
+	pop	%esp
+
+	ret
+SYM_CODE_END(mm_entry_32)
+
+
+	.section ".text64","ax"
+	.code64
+	.balign 4
+SYM_CODE_START(mm_entry_64)
+	mov	$0x3f8, %dx
+	mov	$'L', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'u', %al
+	out	%al, (%dx)
+	mov	$'x', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'S', %al
+	out	%al, (%dx)
+	mov	$'M', %al
+	out	%al, (%dx)
+	mov	$'I', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'h', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'d', %al
+	out	%al, (%dx)
+	mov	$'l', %al
+	out	%al, (%dx)
+	mov	$'e', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'s', %al
+	out	%al, (%dx)
+	mov	$'t', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$'t', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'g', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	pushq	%rsp
+
+	pushq	%rbp
+	pushq	%rbx
+	pushq	%r12
+	pushq	%r13
+	pushq	%r14
+	pushq	%r15
+
+	movq	%cr3, %rax
+	pushq	%rax
+
+	movq	%cr4, %rbx
+	pushq	%rbx
+	or	$0x640, %rbx
+
+	movq	%rbx, %cr4
+
+	movq	%cr0, %rbx
+	pushq	%rbx
+	or	$0x22, %rbx
+
+	mov	%rbx, %cr0
+
+	movq	%rsp, %r12
+	andq	$~0xF, %rsp
+
+	subq	$0x200, %rsp
+	fxsave64 (%rsp)
+
+	/*
+	 * All the macros we compare (r)di to are defined in mm_handler.h
+	 * This differs a bit from what we do above, as ABI calling convention
+	 * is not the same for protected and long mode. First two elements of
+	 * the struct fits rdi. Command is in the first byte of the rdi,
+	 * so we can just read of di.
+	 */
+	cmp $MM_ACPI_DISABLE, %di
+	je acpi_disable
+
+	cmp $MM_ACPI_ENABLE, %di
+	je acpi_enable
+
+	cmp $MM_STORE, %di
+	je mm_store
+
+	jmp restore_cb_state64
+
+acpi_enable:
+	mov	$0x3f8, %dx
+	mov	$'E', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'b', %al
+	out	%al, (%dx)
+	mov	$'l', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'g', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'A', %al
+	out	%al, (%dx)
+	mov	$'C', %al
+	out	%al, (%dx)
+	mov	$'P', %al
+	out	%al, (%dx)
+	mov	$'I', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	// Stash the command from rdi.
+	shr	$32, %rdi
+	// PM1_CNT & ~SCI_EN
+	mov	%di, %ax
+	add	$MM_ACPI_ENABLE, %ax
+	// si contains ACPI_BASE_ADDR
+	mov	%si, %dx
+
+	out	%ax, %dx
+
+	jmp	restore_cb_state64
+
+acpi_disable:
+	mov	$0x3f8, %dx
+	mov	$'D', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'s', %al
+	out	%al, (%dx)
+	mov	$'a', %al
+	out	%al, (%dx)
+	mov	$'b', %al
+	out	%al, (%dx)
+	mov	$'l', %al
+	out	%al, (%dx)
+	mov	$'i', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'g', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'A', %al
+	out	%al, (%dx)
+	mov	$'C', %al
+	out	%al, (%dx)
+	mov	$'P', %al
+	out	%al, (%dx)
+	mov	$'I', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	// Stash command
+	shr	$32, %rdi
+	// PM1_CNT | SCI_EN
+	mov	%di, %ax
+	add	$MM_ACPI_DISABLE, %ax
+	// si contains ACPI_BASE_ADDR
+	mov	%si, %dx
+
+	out	%ax, %dx
+
+	jmp	restore_cb_state64
+
+mm_store:
+	// see comment above in mm_store32
+
+restore_cb_state64:
+	mov	$0x3f8, %dx
+	mov	$'M', %al
+	out	%al, (%dx)
+	mov	$'M', %al
+	out	%al, (%dx)
+	mov	$'6', %al
+	out	%al, (%dx)
+	mov	$'4', %al
+	out	%al, (%dx)
+	mov	$' ', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$'e', %al
+	out	%al, (%dx)
+	mov	$'t', %al
+	out	%al, (%dx)
+	mov	$'u', %al
+	out	%al, (%dx)
+	mov	$'r', %al
+	out	%al, (%dx)
+	mov	$'n', %al
+	out	%al, (%dx)
+	mov	$'s', %al
+	out	%al, (%dx)
+	mov	$'\n', %al
+	out	%al, (%dx)
+
+	fxrstor64 (%rsp)
+	addq	$0x200, %rsp
+	movq	%r12, %rsp
+
+	popq	%rbx
+	movq	%rbx, %cr0
+
+	popq	%rbx
+	movq	%rbx, %cr4
+
+	popq	%rax
+	movq	%rax, %cr3
+
+	popq	%r15
+	popq	%r14
+	popq	%r13
+	popq	%r12
+	popq	%rbx
+	popq	%rbp
+	popq	%rsp
+	ret
+SYM_CODE_END(mm_entry_64)
+
+	.bss
+	.balign	4
+SYM_DATA(mm_signature,		.space 4)
+SYM_DATA(mm_blob_size,		.space 2)
+SYM_DATA(mm_entry_32_offset,	.space 4)
+SYM_DATA(mm_entry_64_offset,	.space 4)
diff --git a/drivers/firmware/google/mm_handler/mm_handler.h b/drivers/firmware/google/mm_handler/mm_handler.h
new file mode 100644
index 0000000000000000000000000000000000000000..4f32f84371d5cff3fcf6c9d1c1c33a2d2b50118e
--- /dev/null
+++ b/drivers/firmware/google/mm_handler/mm_handler.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Derived from arch/x86/include/realmode.h
+ */
+
+#ifndef _MM_HANDLER_H
+#define _MM_HANDLER_H
+
+#define REALMODE_END_SIGNATURE	0x65a22c82
+
+/*
+ * These macros correspond to the arguments
+ * passed by coreboot's SMI handler. Depending
+ * on which one is passed in rdi or esp + x, handler
+ * will jump to the appropriate section.
+ */
+#define MM_ACPI_ENABLE		1
+#define MM_ACPI_DISABLE		0
+#define MM_STORE		2
+
+#endif /* _MM_HANDLER_H */
diff --git a/drivers/firmware/google/mm_handler/mm_header.S b/drivers/firmware/google/mm_handler/mm_header.S
new file mode 100644
index 0000000000000000000000000000000000000000..342cd60492f89f8bea8d7051650365d1eaad4c2e
--- /dev/null
+++ b/drivers/firmware/google/mm_handler/mm_header.S
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * MM blob header; this should match mm_payload.h
+ */
+
+#include <linux/linkage.h>
+#include <asm/page_types.h>
+#include <asm/segment.h>
+
+	.section ".header", "a"
+
+	.balign	16
+SYM_DATA_START(mm_header)
+	.long	pa_text_start
+	.long	pa_mm_entry_32
+	.long	pa_mm_entry_64
+	.long	pa_mm_signature
+	.long	pa_mm_blob_size
+SYM_DATA_END(mm_header)
diff --git a/drivers/firmware/google/mm_loader.c b/drivers/firmware/google/mm_loader.c
new file mode 100644
index 0000000000000000000000000000000000000000..327009a297ee13cda467442a7d508acf4806e7b2
--- /dev/null
+++ b/drivers/firmware/google/mm_loader.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for installing Linux-owned SMI handler
+ *
+ * Copyright (c) 2025 9elements GmbH
+ *
+ * Author: Michal Gorlas <michal.gorlas@9elements.com>
+ */
+
+#include <linux/device.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include "coreboot_table.h"
+#include "mm_payload.h"
+
+struct mm_payload {
+	struct lb_pld_mm_interface_info *mm_cbtable_info;
+	struct mm_header *mm_header;
+	void *shared_buffer;
+};
+
+/*
+ * This is x86_64 specific, assuming that we want this to also work on i386,
+ * we either need to have "trigger_smi32" bounded by preprocessor guards(?)
+ * or mm_loader32 and then mm_loader$(BITS) in Makefile(?).
+ */
+static int trigger_smi(u64 cmd, u64 arg, u64 retry)
+{
+	u64 status;
+	u16 apmc_port = 0xb2;
+
+	asm volatile("movq	%[cmd], %%rax\n\t"
+		     "movq	%%rax, %%rcx\n\t"
+		     "movq	%[arg], %%rbx\n\t"
+		     "movq	%[retry], %%r8\n\t"
+		     ".trigger:\n\t"
+		     "mov	%[apmc_port], %%dx\n\t"
+		     "outb	%%al, %%dx\n\t"
+		     "cmpq	%%rcx, %%rax\n\t"
+		     "jne	.return_changed\n\t"
+		     "pushq	%%rcx\n\t"
+		     "movq	$10000, %%rcx\n\t"
+		     "rep	nop\n\t"
+		     "popq	%%rcx\n\t"
+		     "cmpq	$0, %%r8\n\t"
+		     "je	.return_not_changed\n\t"
+		     "decq	%%r8\n\t"
+		     "jmp	.trigger\n\t"
+		     ".return_changed:\n\t"
+		     "movq	%%rax, %[status]\n\t"
+		     "jmp	.end\n\t"
+		     ".return_not_changed:\n\t"
+		     "movq	%%rcx, %[status]\n\t"
+		     ".end:\n\t"
+		     : [status] "=r"(status)
+		     : [cmd] "r"(cmd), [arg] "r"(arg), [retry] "r"(retry),
+		       [apmc_port] "r"(apmc_port)
+		     : "%rax", "%rbx", "%rdx", "%rcx", "%r8");
+
+	if (status == cmd || status == 1)
+		status = -EIO;
+	else
+		status = 0;
+
+	return status;
+}
+
+static int register_entry_point(struct device *dev, uint32_t entry_point)
+{
+	struct mm_payload *priv = dev_get_drvdata(dev);
+	u64 cmd;
+	u8 status;
+
+	cmd = priv->mm_cbtable_info->register_mm_entry_command |
+	      (PAYLOAD_MM_REGISTER_ENTRY << 8);
+	status = trigger_smi(cmd, entry_point, 5);
+	dev_dbg(dev, ": %s: SMI returned %x\n", __func__, status);
+
+	return status;
+}
+
+static u32 place_handler(struct device *dev)
+{
+	/*
+	 * The handler (aka MM blob) has to be placed in low 4GB of the memory.
+	 * This is because we can not assume that coreboot will be in long mode
+	 * while trying to copy the blob to SMRAM. Even if so, (can be checked by
+	 * reading cb_data->mm_info.requires_long_mode_call), it would make our life
+	 * way too complicated (e.g. no need for shared page table).
+	 */
+	struct mm_payload *info = dev_get_drvdata(dev);
+	size_t entry32_offset;
+	size_t entry64_offset;
+	size_t blob_size;
+
+	u16 real_mode_seg;
+	u32 count;
+	unsigned long phys_base;
+	const u32 *rel;
+	u16 *seg;
+	u32 *ptr;
+
+	blob_size = mm_payload_size_needed();
+	info->shared_buffer = (void *)devm_get_free_pages(dev, GFP_DMA32, get_order(blob_size));
+	if (!info->shared_buffer)
+		return -ENOMEM;
+
+	memcpy(info->shared_buffer, mm_blob, blob_size);
+	wbinvd();
+
+	/*
+	 * Based on arch/x86/realmode/init.c
+	 * The sole purpose of doing relocations is to be able to calculate the offsets
+	 * for entry points. While the absolute addresses are not valid anymore after the
+	 * blob is copied to SMRAM, the distances between sections stay the same, so we
+	 * can still calculate the correct entry point based on coreboot's bitness.
+	 */
+	phys_base = __pa(info->shared_buffer);
+	real_mode_seg = phys_base >> 4;
+	rel = (u32 *)mm_relocs;
+
+	/* 16-bit segment relocations. */
+	count = *rel++;
+	while (count--) {
+		seg = (u16 *)(info->shared_buffer + *rel++);
+		*seg = real_mode_seg;
+	}
+
+	/* 32-bit linear relocations. */
+	count = *rel++;
+	while (count--) {
+		ptr = (u32 *)(info->shared_buffer + *rel++);
+		*ptr += phys_base;
+	}
+
+	info->mm_header = (struct mm_header *)info->shared_buffer;
+
+	info->mm_header->mm_signature = REALMODE_END_SIGNATURE;
+	info->mm_header->mm_blob_size = mm_payload_size_needed();
+
+	/*
+	 * At this point relocations are done and we can do some cool
+	 * pointer arithmetics to help coreboot determine correct entry
+	 * point based on offsets.
+	 */
+	entry32_offset = info->mm_header->mm_entry_32 - (unsigned long)info->shared_buffer;
+	entry64_offset = info->mm_header->mm_entry_64 - (unsigned long)info->shared_buffer;
+
+	info->mm_header->mm_entry_32 = entry32_offset;
+	info->mm_header->mm_entry_64 = entry64_offset;
+
+	return (unsigned long)info->shared_buffer;
+}
+
+static int mm_loader_probe(struct coreboot_device *dev)
+{
+	struct mm_payload *priv;
+
+	priv = devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dev->dev, priv);
+
+	u32 entry_point;
+
+	priv->mm_cbtable_info = &dev->mm_info;
+	if (priv->mm_cbtable_info->tag != LB_TAG_PLD_MM_INTERFACE_INFO)
+		return -ENXIO;
+
+	entry_point = place_handler(&dev->dev);
+
+	if (register_entry_point(&dev->dev, entry_point)) {
+		dev_warn(&dev->dev, ": registering entry point for MM payload failed.\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct coreboot_device_id mm_loader_ids[] = {
+	{ .tag = LB_TAG_PLD_MM_INTERFACE_INFO },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(coreboot, mm_loader_ids);
+
+static struct coreboot_driver mm_loader = {
+	.probe = mm_loader_probe,
+	.drv = {
+		.name = "mm_loader",
+	},
+	.id_table = mm_loader_ids,
+};
+
+module_coreboot_driver(mm_loader);
+
+MODULE_AUTHOR("Michal Gorlas <michal.gorlas@9elements.com>");
+MODULE_DESCRIPTION("MM Payload loader - installs Linux-owned SMI handler");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/google/mm_payload.h b/drivers/firmware/google/mm_payload.h
new file mode 100644
index 0000000000000000000000000000000000000000..8fe99443afce75ac8897f1804520866efe8bb683
--- /dev/null
+++ b/drivers/firmware/google/mm_payload.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * mm_payload.h
+ *
+ * Internal header for MM payload driver.
+ *
+ * Copyright 2025 9elements gmbh
+ * Copyright 2025 Michal Gorlas <michal.gorlas@9elements.com>
+ */
+
+#ifndef __MM_PAYLOAD_H
+#define __MM_PAYLOAD_H
+
+#define PAYLOAD_MM_REGISTER_ENTRY 2
+
+#define REALMODE_END_SIGNATURE	0x65a22c82
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/* This must match data at mm_handler/mm_header.S */
+struct mm_header {
+	u32	text_start;
+	u32	mm_entry_32;
+	u32	mm_entry_64;
+	u32	mm_signature;
+	u32	mm_blob_size;
+};
+
+extern struct mm_header *mm_header;
+extern unsigned char mm_blob_end[];
+
+extern unsigned char mm_blob[];
+extern unsigned char mm_relocs[];
+
+/*
+ * This has to be under 1MB (see tseg_region.c in coreboot source tree).
+ * The actual check for this is made in coreboot after we fill the header
+ * (see above) with the blob size.
+ */
+static inline size_t mm_payload_size_needed(void)
+{
+	return mm_blob_end - mm_blob;
+}
+
+#endif /* __ASSEMBLER__ */
+#endif /* __MM_PAYLOAD_H */

---
base-commit: 981d7f91aeda17424b29f033249f4fa7cd2a7556
change-id: 20250613-coreboot-payload-mm-6642bb42284a

Best regards,
-- 
Michal Gorlas <michal.gorlas@9elements.com>


