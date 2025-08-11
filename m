Return-Path: <linux-kernel+bounces-762210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C72B2038F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA118C047B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9CE2DFA26;
	Mon, 11 Aug 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gZvEZYbD"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5C2DECAA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904500; cv=none; b=lnDUD9FsbI3VVRPWyHQQzXys1L1M3YbVVkbpr/TTWqlT43uX0cET7/9SBZ6MRyqHlQjqDJZUHT9/+oZ7eG6DEt/k3w3xsM54ckDtu4SnblTA6ZnI+Kd42VKq5G7YyOFTsLRVysC04mMAz9fyFNJG/IGX1HTyo3ZwQ3PRO+UDS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904500; c=relaxed/simple;
	bh=6RMVgeBehurPfBfL/r9EvLbL3T6ZeyXaePSaxIzUJDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqeTnG0ABgeRW5NSUCYjo7crbP8qt3eXsokLb5R0VF9kbzTvljJoxafgcIh+1BswDO0eQpUVVWSUxOmX1CSMiKj4fxfyeWXanxz0Vz9l+GvxdY2Lo4QlU2i6VpjVcGvWHFm0m2GELbUziLlGG+W+G190xjKBBTfH/vv36Bdjndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gZvEZYbD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OGdEPpBUhj7h+P7gI7AN/cn/c6kSjD1T1RA7M9+TKc=;
	b=gZvEZYbDwNfEHgTALwzWVqLWcoB0NLvOAWdYQodiEA5lGNODD0kwbO1cMffi17+D9hf6MH
	jFOJk8exjf263bohWMQwNU/3KW/TYRVHyYARFeJj0sCU6UVSNePfEPscw4QXNG5Ho6O2Y4
	WILibzRKykahmiLa/CABSqALtyanJWk=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 2/6] LoongArch: Add kexec_file support
Date: Mon, 11 Aug 2025 17:26:55 +0800
Message-Id: <20250811092659.14903-3-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-1-youling.tang@linux.dev>
References: <20250811092659.14903-1-youling.tang@linux.dev>
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

The image_load() as two parts:
- the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
- the second part loads other segments (eg: initrd, cmdline)

Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
but ELF format is not supported.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/Kconfig                     |   8 ++
 arch/loongarch/include/asm/image.h         |  18 ++++
 arch/loongarch/include/asm/kexec.h         |  12 +++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
 arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
 arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
 7 files changed, 219 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/kernel/kexec_image.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40ac..fd50c83f7827 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -625,6 +625,14 @@ config CPU_HAS_PREFETCH
 config ARCH_SUPPORTS_KEXEC
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_FILE
+	def_bool 64BIT
+
+config ARCH_SELECTS_KEXEC_FILE
+	def_bool y
+	depends on KEXEC_FILE
+	select HAVE_IMA_KEXEC if IMA
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
index 1f090736e71d..829e1ecb1f5d 100644
--- a/arch/loongarch/include/asm/image.h
+++ b/arch/loongarch/include/asm/image.h
@@ -36,5 +36,23 @@ struct loongarch_image_header {
 	uint32_t pe_header;
 };
 
+static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
+static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 0x0, 0x64, 0x62};
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
index cf95cd3eb2de..3ef8517a3670 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -41,6 +41,18 @@ struct kimage_arch {
 	unsigned long systable_ptr;
 };
 
+#ifdef CONFIG_KEXEC_FILE
+extern const struct kexec_file_ops kexec_image_ops;
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
index 6f5a4574a911..bd9405ee3888 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/kexec_image.c
new file mode 100644
index 000000000000..fdd1845b4e2e
--- /dev/null
+++ b/arch/loongarch/kernel/kexec_image.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec image loader for LoongArch
+
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(Image): " fmt
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
+static int image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct loongarch_image_header *h =
+		(const struct loongarch_image_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h))) {
+		pr_err("No loongarch image header.\n");
+		return -EINVAL;
+	}
+
+	if (!loongarch_header_check_pe_sig(h)) {
+		pr_err("Bad loongarch PE image header.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void *image_load(struct kimage *image,
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
+	kbuf.buf_min = 0;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = le64_to_cpu(h->image_size);
+	text_offset = le64_to_cpu(h->text_offset);
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
+const struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+};
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index f9381800e291..008f43e26120 100644
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
+	pr_notice("Command line at %s\n", (char *)cmdline_ptr);
 	pr_notice("System table at 0x%lx\n", systable_ptr);
 	pr_notice("We will call new kernel at 0x%lx\n", start_addr);
 	pr_notice("Bye ...\n");
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..bc91ae0afa4c
--- /dev/null
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -0,0 +1,46 @@
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
+	&kexec_image_ops,
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
+int load_other_segments(struct kimage *image,
+			unsigned long kernel_load_addr,
+			unsigned long kernel_size,
+			char *initrd, unsigned long initrd_len,
+			char *cmdline, unsigned long cmdline_len)
+{
+	image->arch.cmdline_ptr = (unsigned long)cmdline;
+
+	return 0;
+}
-- 
2.34.1


