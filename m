Return-Path: <linux-kernel+bounces-797630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D766B412B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E445E42AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073F92C3260;
	Wed,  3 Sep 2025 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d68UxUnI"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEC2C21DF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868549; cv=none; b=SRSknT03crc9AZqbxqbjhaiNIF98EuIXUsqNWwaMiyuzD1wpmzjYaiJJkUgekQWOqNKxoUWCKkXCiDEk9I+ohadXdE7gjExxrn/1Snup3toLN8sfOioS9EpVQ0vbvhIzCObJZtNnQ6eVe55UcHgOqD0x+0MY6iOn8xZ8VJRky7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868549; c=relaxed/simple;
	bh=OmcHN8DTdWzNc+Nw36q0A/0SOtjkrcHRKZb80MwQQ7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8GeU5bbFzGPNXeH7/I76D1E0eu/+mu2ZihsCFu7Uv6HUJUXZUBRYSUjp1/7bhMAaBdSSMdBf8HanyPjJoWH4k/DmdxyTdYHRx/rnJahfQJbdzbucFS11xwE1z1z7EpMS+z9FOkFrnXT6E2+2QcWkArBuIHEDaTUF01lui2by+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d68UxUnI; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83PuVuFgr80Y4Y/zYHwpjQEYSpCD6sDbiyfLT6lkmLg=;
	b=d68UxUnIXjvuVa5rxu2nU6DO7egzUULtp+BtNzj3zbtN9KhkF3t8AtWpp+Gviys0zLUzdq
	kLxhIXbepBg3bh44dg7whRy6yqKN3B6aRu7Y0yK4R6Fka0QjhMV+jZAM1lyK1WkoI7+CvR
	RbfNyyD7gxlJID4K5akBEgfIkqNCdyc=
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
Subject: [PATCH v4 4/7] LoongArch/kexec_file: Support loading ELF binary file
Date: Wed,  3 Sep 2025 11:00:57 +0800
Message-Id: <20250903030100.196744-5-youling.tang@linux.dev>
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

This patch creates kexec_elf_ops to load ELF binary file for
kexec_file_load() syscall.

However, for `kbuf->memsz` and `kbuf->buf_min`, special handling is required,
and the generic `kexec_elf_load()` cannot be used directly.

$ readelf -l vmlinux
...
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags Align
   LOAD           0x0000000000010000 0x9000000000200000 0x9000000000200000
                  0x0000000002747a00 0x000000000287a0d8  RWE 0x10000
   NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
                  0x0000000000000000 0x0000000000000000  R      0x8

phdr->p_paddr should have been a physical address, but it is a virtual
address on the current LoongArch. This will cause kexec_file to fail
when loading the kernel and need to be converted to a physical address.

From the above MemSiz, it can be seen that 0x287a0d8 has not been aligned.
Although kexec_add_buffer() will perform PAGE_SIZE alignment on kbuf->memsz,
there is still a stampeding in the loaded kernel space and initrd space.
The initrd resolution failed when starting the second kernel.

It can be known from the link script vmlinux.lds.S that,
    BSS_SECTION(0, SZ_64K, 8)
    . = ALIGN(PECOFF_SEGMENT_ALIGN);

It needs to be aligned according to the SZ_64K size, so that after
alignment, its size is consistent with _kernel_asize.

The basic usage (vmlinux):
1) Load second kernel image:
 # kexec -s -l vmlinux --initrd=initrd.img --reuse-cmdline

2) Startup second kernel:
 # kexec -e

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
index 000000000000..175d8d935e11
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
+		*text_offset = __pa(phdr->p_paddr);
+		kbuf->buf_min = *text_offset;
+		kbuf->memsz = ALIGN(phdr->p_memsz, SZ_64K);
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
+	/*
+	 * Load the kernel
+	 * FIXME: Non-relocatable kernel rejected for kexec_file (require CONFIG_RELOCATABLE)
+	 */
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
index a454e9dfc339..81913359b7a1 100644
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


