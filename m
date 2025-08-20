Return-Path: <linux-kernel+bounces-776990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC862B2D3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F741BC80EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF42C11DA;
	Wed, 20 Aug 2025 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRZf+3mV"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940112BE63F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669456; cv=none; b=BClCNDACFXe2FBfuEXxMhiBLA2t5WjXfPDVzLKJxyb8H8PyrwlM2lIYtt/FpVmd8qxqocg+rUL0rjOMUsV7yHpDBMLGLxGH7Q4zKCbgXtgCVVrZRuLYSUK5Tl/+flhAsy45JJcVzu6tpH5pdVH+Od8f2t97fJugXAzoy6aRki6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669456; c=relaxed/simple;
	bh=xjRkJ0XsAaJaI/+Znc10zqDKckIajqUHCCu8arY2r4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5NWCAl+5rGfjbsbwGsMGk3JbfZ2xwG9nhb1ufzDGDJbkyYJvzs4pvAQJr4iG8N+MsZoZkRdKWWsQ7Nj+5C3GS9FAhfYbNjevG5oqZMMHMJx5zX+/YZnRfgH+1+oyQTa5Cngew3WftvGHnyS4Q/JDgrxavJ6IhDDvnMXL3rG1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRZf+3mV; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBzbvApVwC+zuz1F6RmfDj67Mme+a/DUkrAhV+yXG4k=;
	b=qRZf+3mVn8Dt8h+ljDOPv/LrFxVG7+kxLW/U68gtPkcBXZGWNCikFtQ6zhSrWNYqCBMq2b
	t+9IedNCK+FuYLUWV8dILkup1Pw/cQepSU+oetS1JWNu3ylDDPWxLDO4HyL2iyvV9GabKf
	wB6Ui7fyOShYbh5EFMCVpMaFYkJhWgw=
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
Subject: [PATCH v2 2/5] LoongArch: Add kexec_file support
Date: Wed, 20 Aug 2025 13:56:57 +0800
Message-Id: <20250820055700.24344-3-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-1-youling.tang@linux.dev>
References: <20250820055700.24344-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

This patch adds support for kexec_file on LoongArch.

The efi_kexec_load() as two parts:
- the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
- the second part loads other segments (eg: initrd, cmdline)

This initrd will be passed to the second kernel via the command line
'initrd=start,size'.

Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
but ELF format is not supported.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/Kconfig                     |   9 ++
 arch/loongarch/include/asm/image.h         |  17 +++
 arch/loongarch/include/asm/kexec.h         |  12 +++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
 arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
 arch/loongarch/kernel/machine_kexec_file.c | 117 +++++++++++++++++++++
 7 files changed, 289 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/kernel/kexec_efi.c
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
 
diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
index 1f090736e71d..655d5836c4e8 100644
--- a/arch/loongarch/include/asm/image.h
+++ b/arch/loongarch/include/asm/image.h
@@ -36,5 +36,22 @@ struct loongarch_image_header {
 	uint32_t pe_header;
 };
 
+static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
+
+/**
+ * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
+ *
+ * Returns non-zero if 'MZ' signature is found.
+ */
+
+static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (h->pe_sig[0] == loongarch_image_pe_sig[0]
+		&& h->pe_sig[1] == loongarch_image_pe_sig[1]);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_IMAGE_H */
diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index cf95cd3eb2de..34799db933fb 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -41,6 +41,18 @@ struct kimage_arch {
 	unsigned long systable_ptr;
 };
 
+#ifdef CONFIG_KEXEC_FILE
+extern const struct kexec_file_ops kexec_efi_ops;
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
index 6f5a4574a911..dd6183f353e6 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
new file mode 100644
index 000000000000..7741f1139a12
--- /dev/null
+++ b/arch/loongarch/kernel/kexec_efi.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Load EFI vmlinux file for the kexec_file_load syscall.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(EFI): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/pe.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+#include <asm/cpufeature.h>
+#include <asm/image.h>
+
+static int efi_kexec_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct loongarch_image_header *h = (const struct loongarch_image_header *)kernel_buf;
+
+	if (!h || (kernel_len < sizeof(*h))) {
+		pr_err("No loongarch image header.\n");
+		return -EINVAL;
+	}
+
+	if (!loongarch_header_check_pe_sig(h)) {
+		pr_warn("No loongarch PE image header.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void *efi_kexec_load(struct kimage *image,
+				char *kernel, unsigned long kernel_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	struct loongarch_image_header *h;
+	struct kexec_buf kbuf;
+	unsigned long text_offset, kernel_segment_number;
+	struct kexec_segment *kernel_segment;
+	int ret;
+
+	h = (struct loongarch_image_header *)kernel;
+	if (!h->image_size)
+		return ERR_PTR(-EINVAL);
+
+	/* Load the kernel */
+	kbuf.image = image;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = le64_to_cpu(h->image_size);
+	text_offset = le64_to_cpu(h->text_offset);
+	kbuf.buf_min = text_offset;
+	kbuf.buf_align = SZ_2M;
+
+	kernel_segment_number = image->nr_segments;
+
+	/*
+	 * The location of the kernel segment may make it impossible to satisfy
+	 * the other segment requirements, so we try repeatedly to find a
+	 * location that will work.
+	 */
+	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
+		/* Try to load additional data */
+		kernel_segment = &image->segment[kernel_segment_number];
+		ret = load_other_segments(image, kernel_segment->mem,
+					  kernel_segment->memsz, initrd,
+					  initrd_len, cmdline, cmdline_len);
+		if (!ret)
+			break;
+
+		/*
+		 * We couldn't find space for the other segments; erase the
+		 * kernel segment and try the next available hole.
+		 */
+		image->nr_segments -= 1;
+		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	}
+
+	if (ret) {
+		pr_err("Could not find any suitable kernel location!");
+		return ERR_PTR(ret);
+	}
+
+	kernel_segment = &image->segment[kernel_segment_number];
+
+	/* Make sure the second kernel jumps to the correct "kernel_entry". */
+	image->start = kernel_segment->mem + h->kernel_entry - text_offset;
+
+	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kernel_segment->mem, kbuf.bufsz,
+		      kernel_segment->memsz);
+
+	return NULL;
+}
+
+const struct kexec_file_ops kexec_efi_ops = {
+	.probe = efi_kexec_probe,
+	.load = efi_kexec_load,
+};
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index f9381800e291..ba8d64bc6549 100644
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
@@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
 	local_irq_disable();
 
 	pr_notice("EFI boot flag 0x%lx\n", efi_boot);
-	pr_notice("Command line at 0x%lx\n", cmdline_ptr);
+	pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
+	pr_notice("Command line: %s\n", (char *)cmdline_ptr);
 	pr_notice("System table at 0x%lx\n", systable_ptr);
 	pr_notice("We will call new kernel at 0x%lx\n", start_addr);
 	pr_notice("Bye ...\n");
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..a713acf32db8
--- /dev/null
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -0,0 +1,117 @@
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
+	&kexec_efi_ops,
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


