Return-Path: <linux-kernel+bounces-797628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE1DB412B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E0A3BFB7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9ED2C21CD;
	Wed,  3 Sep 2025 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VthOXtS9"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE122172E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868545; cv=none; b=k+G/Jgx5FJmnzCBzkrsQLIQorYtszRQjwEB772yrbKUPa8sodM95rQkFwCd4BfD30DmDt3WRklwomc4HSp0+qdV2NUgrMETre8cq46uem7U5LJBL2j4jOsE2B+AyeBojXIjZ8mLXLW9rArNfbzphuxLXoH0ZkUz3q5X3X6MocUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868545; c=relaxed/simple;
	bh=mqb600+pneecQKzsZoignJ/8aykXWDyXNzFUolsqzrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4jKomXZqf9K3tQnRQTqk3LGXdOjCLUVnLucqpBu2W+2CTFZPAt9kP3rLRnL/jkYSm27H54+Ibj0pqMI4p8WTgiwnrmcY+ZZ49movuv+w/aHzmxX9A5K8CUaBen35/PTrQzZ+soDTtdbA5wTfOca8DaLjR+ToXomHvBU+U1ZBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VthOXtS9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y/9kZHekM+gIBRRUe68eDicKpPDtNyELOaDeeOu0CE=;
	b=VthOXtS91xS1dwsI7nuJzwzt7lhGfFY3j33cNwgTp64x7gCkivNXJwTi4G8iB9N8gEoMBE
	ffVKs54+iChzx6YS1RvXAeYHuszCM7hNfRvXHdnZjky6dpzMZKCPw47NVlKro57ZNGe/Kh
	NknhUZ1S70FseA816Wy9fc8gIVpkAtg=
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
Subject: [PATCH v4 3/7] LoongArch/kexec_file: Support loading EFI binary file
Date: Wed,  3 Sep 2025 11:00:56 +0800
Message-Id: <20250903030100.196744-4-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

This patch creates kexec_efi_ops to load EFI binary file for
kexec_file_load() syscall.

The efi_kexec_load() as two parts:
- the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
- the second part loads other segments (eg: initrd, cmdline)

Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are
supported.

The basic usage (vmlinuz.efi or vmlinux.efi):
1) Load second kernel image:
 # kexec -s -l vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Startup second kernel:
 # kexec -e

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/include/asm/image.h         |  17 +++
 arch/loongarch/include/asm/kexec.h         |   1 +
 arch/loongarch/kernel/Makefile             |   2 +-
 arch/loongarch/kernel/kexec_efi.c          | 114 +++++++++++++++++++++
 arch/loongarch/kernel/machine_kexec_file.c |   1 +
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/kexec_efi.c

diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
index ff539711c9ea..982cebd31cac 100644
--- a/arch/loongarch/include/asm/image.h
+++ b/arch/loongarch/include/asm/image.h
@@ -32,5 +32,22 @@ struct loongarch_image_header {
 	uint32_t pe_header;
 };
 
+static const uint8_t loongarch_image_dos_sig[2] = {'M', 'Z'};
+
+/**
+ * loongarch_header_check_dos_sig - Helper to check the loongarch image header.
+ *
+ * Returns non-zero if 'MZ' signature is found.
+ */
+
+static inline int loongarch_header_check_dos_sig(const struct loongarch_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (h->dos_sig[0] == loongarch_image_dos_sig[0]
+		&& h->dos_sig[1] == loongarch_image_dos_sig[1]);
+}
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ASM_IMAGE_H */
diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index ed7e3fc8571e..34799db933fb 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -42,6 +42,7 @@ struct kimage_arch {
 };
 
 #ifdef CONFIG_KEXEC_FILE
+extern const struct kexec_file_ops kexec_efi_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 67b9b214d212..dd6183f353e6 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
-obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
new file mode 100644
index 000000000000..e02fd88cf5d0
--- /dev/null
+++ b/arch/loongarch/kernel/kexec_efi.c
@@ -0,0 +1,114 @@
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
+	if (!loongarch_header_check_dos_sig(h)) {
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
+	if (!h->kernel_asize)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Load the kernel
+	 * FIXME: Non-relocatable kernel rejected for kexec_file (require CONFIG_RELOCATABLE)
+	 */
+	kbuf.image = image;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = le64_to_cpu(h->kernel_asize);
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
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 584ce9471e93..a454e9dfc339 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -21,6 +21,7 @@
 #include <asm/bootinfo.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_efi_ops,
 	NULL
 };
 
-- 
2.43.0


