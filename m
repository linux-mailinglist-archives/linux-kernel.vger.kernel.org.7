Return-Path: <linux-kernel+bounces-776991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F074B2D3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7650A1BC82EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2592BF3DF;
	Wed, 20 Aug 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H4Kz/d7B"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE92BEC55
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669459; cv=none; b=C1OU+WdYNSbs9AypoaFyFjg6q4G0NvKoAkkFtDR7XnFdibUwe5pTQ+TB4/ZqDCMIzHNuKL/RtGo1+YqaUwTk+OcpL7vAz6xeJdhD/nJK1OuOhrPPrn+vjZwqMq8MS+RzBL6m6+GlX3CDb8N2JSIQ/OBbPv8CaPWu0BGkLJcvInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669459; c=relaxed/simple;
	bh=u85Q1yrHx5gTLPERw6gmJ15ZiOgWOzluuUfi/l8M1PM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfpWm2aqMqQDKcgMb3pmotw9/or9nVewhVgK1ULwUuSgiU/QZ4Gef+qL+AgXMkLP96yiXDWg5NOqb/qdgw+JxMXA9419KUZlMw51qPsRxra4+e0fCY4RxJPf1FfXB8wDrmBS3BQjkdQeGir17NAiVhgoFg0IZg29KutO8+w9hOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H4Kz/d7B; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDOGfKAncS3JpdJdcrw8JwTp9Kssefr3qjdwC73xGe8=;
	b=H4Kz/d7BkucqkiL8X/BdzyV6B7Q9H/UpIIVlMCfANdSN3mhZSl835uvTegrLLi/T0pLmtm
	ztTXtOzOmTCOaSkJcvgVRdxBRETiuhfW7C0UIctQz7AQMS+OoJsDLTeE56XznyeD8+Kh8v
	qTeOzK7Gu4RRmP3JHZfWRwrB+WzjjzM=
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
Subject: [PATCH v2 3/5] LoongArch/kexec_file: Support loading ELF binary file
Date: Wed, 20 Aug 2025 13:56:58 +0800
Message-Id: <20250820055700.24344-4-youling.tang@linux.dev>
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

This patch creates kexec_elf_ops to load ELF binary file
for kexec_file_load() syscall.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/Kconfig                     |   1 +
 arch/loongarch/include/asm/kexec.h         |   1 +
 arch/loongarch/kernel/Makefile             |   2 +-
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++++++++++++++
 arch/loongarch/kernel/machine_kexec_file.c |   1 +
 5 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/kexec_elf.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 490dc6eed749..bf2664ed7ce3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -632,6 +632,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
+	select KEXEC_ELF
 	select RELOCATABLE
 
 config ARCH_SUPPORTS_CRASH_DUMP
diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index 34799db933fb..fecfb3015abc 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -43,6 +43,7 @@ struct kimage_arch {
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_efi_ops;
+extern const struct kexec_file_ops kexec_elf_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index dd6183f353e6..001924877772 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
-obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o kexec_elf.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/loongarch/kernel/kexec_elf.c b/arch/loongarch/kernel/kexec_elf.c
new file mode 100644
index 000000000000..d41ee5fd7cef
--- /dev/null
+++ b/arch/loongarch/kernel/kexec_elf.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Load ELF vmlinux file for the kexec_file_load syscall.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(ELF): " fmt
+
+#include <linux/elf.h>
+#include <linux/kexec.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/memblock.h>
+#include <asm/image.h>
+#include <asm/setup.h>
+
+static int loongarch_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
+			 struct kexec_elf_info *elf_info,
+			 struct kexec_buf *kbuf,
+			 unsigned long *text_offset)
+{
+	int ret = -1;
+	size_t i;
+
+	/* Read in the PT_LOAD segments. */
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		size_t size;
+		const struct elf_phdr *phdr;
+		struct loongarch_image_header *header;
+
+		phdr = &elf_info->proghdrs[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		size = phdr->p_filesz;
+		if (size > phdr->p_memsz)
+			size = phdr->p_memsz;
+
+		kbuf->buffer = (void *)elf_info->buffer + phdr->p_offset;
+		kbuf->bufsz = size;
+		kbuf->buf_align = phdr->p_align;
+		header = (struct loongarch_image_header *)kbuf->buffer;
+		*text_offset = le64_to_cpu(header->text_offset);
+		kbuf->buf_min = *text_offset;
+		kbuf->memsz = le64_to_cpu(header->image_size);
+		kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
+		ret = kexec_add_buffer(kbuf);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
+			    unsigned long kernel_len, char *initrd,
+			    unsigned long initrd_len, char *cmdline,
+			    unsigned long cmdline_len)
+{
+	int ret;
+	unsigned long text_offset = 0, kernel_segment_number;
+	struct elfhdr ehdr;
+	struct kexec_elf_info elf_info;
+	struct kexec_segment *kernel_segment;
+	struct kexec_buf kbuf;
+
+	ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Load the kernel */
+	kbuf.image = image;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kernel_segment_number = image->nr_segments;
+
+	ret = loongarch_kexec_elf_load(image, &ehdr, &elf_info, &kbuf, &text_offset);
+	if (ret)
+		goto out;
+
+	/* Load additional data */
+	kernel_segment = &image->segment[kernel_segment_number];
+	ret = load_other_segments(image, kernel_segment->mem, kernel_segment->memsz,
+				  initrd, initrd_len, cmdline, cmdline_len);
+	if (ret)
+		goto out;
+
+	/* Make sure the second kernel jumps to the correct "kernel_entry". */
+	image->start = kernel_segment->mem + __pa(ehdr.e_entry) - text_offset;
+
+	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kernel_segment->mem, kbuf.bufsz, kernel_segment->memsz);
+
+out:
+	kexec_free_elf_info(&elf_info);
+	return ret ? ERR_PTR(ret) : NULL;
+}
+
+const struct kexec_file_ops kexec_elf_ops = {
+	.probe = kexec_elf_probe,
+	.load  = elf_kexec_load,
+};
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index a713acf32db8..dc6e37457559 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -22,6 +22,7 @@
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_efi_ops,
+	&kexec_elf_ops,
 	NULL
 };
 
-- 
2.43.0


