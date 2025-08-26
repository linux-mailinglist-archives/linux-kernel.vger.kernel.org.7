Return-Path: <linux-kernel+bounces-785773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF1B350EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E027B245003
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AD14A8B;
	Tue, 26 Aug 2025 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QJ2BpsQL"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA31DE4C9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171102; cv=none; b=hA4/R4ZQZ9xkpkLfYdHoC72cJ+eWgVK7nwoWeVZ4UpgdQpEZrq7+ThRI8UUUXVYq37JCpthm/Q4iVFMiPJKg33Zy/f2DN4qrMMAdNFMruCfNgwV95M/LfvR9atixeVZ5IHWtSeHX4VkKKzH2WeOecnmFuC8AMid2Vv7LPpNeL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171102; c=relaxed/simple;
	bh=9YcPro5M30ClwlasVFPnRn58uVsmckm+1CPemHt1mr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rrc7rySGRYPan6CPortBq3SzSebdVsBcRAcWnhHBg4rW4yO9xFAN+weSKKcZzMLYnO2xdSl9z36r1A6TTETH2glO+hB3Sg6DGc3+NZbth+CFeE2GiNIH/kKfLGG5JVUMvFYVgHMLr1Zq0iIrDjh1T0XdkXV2DXePdtBlf5NG0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QJ2BpsQL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756171098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8n0mpD5ni/YyEkFMU86GC1Wq5pnpOYWoEcccjhBPjk=;
	b=QJ2BpsQLLxPKxxQ9Lk8OeaKuEPWwW5Ol4fb7FQire5eJqnKpxRcXfTrMr2amgpWx9BEGMd
	nDxW8ZJ/xsMQxRwmayZqJtJLdJStH1g2hK2+qjb4Ljma7z30+BG+UlK+8AYKxcDPzmW9Bt
	0FHwyHN86aZlEir56QTHltKaAwuaVq0=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v3 2/6] LoongArch: Add preparatory infrastructure for kexec_file
Date: Tue, 26 Aug 2025 09:17:18 +0800
Message-Id: <20250826011722.82391-3-youling.tang@linux.dev>
In-Reply-To: <20250826011722.82391-1-youling.tang@linux.dev>
References: <20250826011722.82391-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Add some preparatory infrastructure:
- Add support for loading other segments.
- Add command line processing.
- Other minor modifications.

This initrd will be passed to the second kernel via the command line
'initrd=start,size'.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/Kconfig                     |   9 ++
 arch/loongarch/include/asm/kexec.h         |  11 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/machine_kexec.c      |  37 ++++---
 arch/loongarch/kernel/machine_kexec_file.c | 116 +++++++++++++++++++++
 5 files changed, 161 insertions(+), 13 deletions(-)
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40ac..490dc6eed749 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -625,6 +625,15 @@ config CPU_HAS_PREFETCH
 config ARCH_SUPPORTS_KEXEC
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_FILE
+	def_bool 64BIT
+
+config ARCH_SELECTS_KEXEC_FILE
+	def_bool y
+	depends on KEXEC_FILE
+	select HAVE_IMA_KEXEC if IMA
+	select RELOCATABLE
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index cf95cd3eb2de..ed7e3fc8571e 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -41,6 +41,17 @@ struct kimage_arch {
 	unsigned long systable_ptr;
 };
 
+#ifdef CONFIG_KEXEC_FILE
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
+
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr, unsigned long kernel_size,
+		char *initrd, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len);
+#endif
+
 typedef void (*do_kexec_t)(unsigned long efi_boot,
 			   unsigned long cmdline_ptr,
 			   unsigned long systable_ptr,
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 6f5a4574a911..67b9b214d212 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index f9381800e291..d5accdc4576d 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
 	kimage->arch.efi_boot = fw_arg0;
 	kimage->arch.systable_ptr = fw_arg2;
 
-	/* Find the command line */
-	for (i = 0; i < kimage->nr_segments; i++) {
-		if (!strncmp(bootloader, (char __user *)kimage->segment[i].buf, strlen(bootloader))) {
-			if (!copy_from_user(cmdline_ptr, kimage->segment[i].buf, COMMAND_LINE_SIZE))
-				kimage->arch.cmdline_ptr = (unsigned long)cmdline_ptr;
-			break;
+	if (kimage->file_mode == 1) {
+		/*
+		 * kimage->cmdline_buf will be released in kexec_file_load, so copy to
+		 * the KEXEC_CMDLINE_ADDR safe area.
+		 */
+		memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arch.cmdline_ptr,
+					strlen((char *)kimage->arch.cmdline_ptr) + 1);
+		kimage->arch.cmdline_ptr = (unsigned long)KEXEC_CMDLINE_ADDR;
+	} else {
+		/* Find the command line */
+		for (i = 0; i < kimage->nr_segments; i++) {
+			if (!strncmp(bootloader, (char __user *)kimage->segment[i].buf, strlen(bootloader))) {
+				if (!copy_from_user(cmdline_ptr, kimage->segment[i].buf, COMMAND_LINE_SIZE))
+					kimage->arch.cmdline_ptr = (unsigned long)cmdline_ptr;
+				break;
+			}
 		}
-	}
 
-	if (!kimage->arch.cmdline_ptr) {
-		pr_err("Command line not included in the provided image\n");
-		return -EINVAL;
+		if (!kimage->arch.cmdline_ptr) {
+			pr_err("Command line not included in the provided image\n");
+			return -EINVAL;
+		}
 	}
 
 	/* kexec/kdump need a safe page to save reboot_code_buffer */
@@ -287,9 +297,10 @@ void machine_kexec(struct kimage *image)
 	/* We do not want to be bothered. */
 	local_irq_disable();
 
-	pr_notice("EFI boot flag 0x%lx\n", efi_boot);
-	pr_notice("Command line at 0x%lx\n", cmdline_ptr);
-	pr_notice("System table at 0x%lx\n", systable_ptr);
+	pr_notice("EFI boot flag: 0x%lx\n", efi_boot);
+	pr_notice("Command line addr: 0x%lx\n", cmdline_ptr);
+	pr_notice("Command line string: %s\n", (char *)cmdline_ptr);
+	pr_notice("System table addr: 0x%lx\n", systable_ptr);
 	pr_notice("We will call new kernel at 0x%lx\n", start_addr);
 	pr_notice("Bye ...\n");
 
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..7fe3f182a632
--- /dev/null
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kexec_file for LoongArch
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ *
+ * Most code is derived from LoongArch port of kexec-tools
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <asm/bootinfo.h>
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	NULL
+};
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
+	image->elf_headers_sz = 0;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
+
+/* Adds the "initrd=start,size" command line parameter to command line. */
+static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
+				char *modified_cmdline, unsigned long initrd)
+{
+	int initrd_strlen;
+
+	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
+		initrd, image->initrd_buf_len);
+	*cmdline_tmplen += initrd_strlen;
+}
+
+/*
+ * Tries to add the initrd to the image. If it is not possible to find
+ * valid locations, this function will undo changes to the image and return non
+ * zero.
+ */
+int load_other_segments(struct kimage *image,
+			unsigned long kernel_load_addr,
+			unsigned long kernel_size,
+			char *initrd, unsigned long initrd_len,
+			char *cmdline, unsigned long cmdline_len)
+{
+	struct kexec_buf kbuf;
+	unsigned long orig_segments = image->nr_segments;
+	char *modified_cmdline = NULL;
+	unsigned long cmdline_tmplen = 0;
+	unsigned long initrd_load_addr = 0;
+	int ret = 0;
+
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = kernel_load_addr + kernel_size;
+
+	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
+	if (!modified_cmdline)
+		return -EINVAL;
+
+	/* Ensure it's nul terminated */
+	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+
+	/* load initrd */
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = 0;
+		/* within 1GB-aligned window of up to 32GB in size */
+		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
+						+ (unsigned long)SZ_1G * 32;
+		kbuf.top_down = false;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out_err;
+		initrd_load_addr = kbuf.mem;
+
+		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		/* Add the initrd=start,size parameter to the command line */
+		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
+	}
+
+	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
+		pr_err("Appending command line exceeds cmdline size\n");
+		ret = -EINVAL;
+		goto out_err;
+	}
+	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
+	cmdline = modified_cmdline;
+	image->arch.cmdline_ptr = (unsigned long)cmdline;
+
+	return 0;
+
+out_err:
+	image->nr_segments = orig_segments;
+	kfree(modified_cmdline);
+	return ret;
+}
-- 
2.43.0


