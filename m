Return-Path: <linux-kernel+bounces-657825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2DABF94D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD3A3BC26D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1441FDE14;
	Wed, 21 May 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HJjjgHg9"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B231C84BC
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841384; cv=none; b=RlJxGivhXiSQ2wLrrwDSQc+hqrpQOOdGixfpD9Du74Q9ymN3XQ3eyzzRLPeE6nSoF2G2a8JCquCuivPUGcFpyNec9hAUU/QHA618CD4ICn+6yPDz8e2zYmL48U5+mvW2btPn3hjTBIpQb0f4n9qzzC/qPXSMTPDM8DGMN+f6nWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841384; c=relaxed/simple;
	bh=YAp59Xav+yiBkkcdDDaEMYXqfegBTFFcgy6EyUOMda0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FCGZCMWLPtHgpomLlSSaxJ3+9gv/oT5Z0S/fNHy46NAls6tXEPxxeRxVsfkAqgzipAaRU4llb5hUV1FbTzuLfbeFRsZwwAdJmxy9nn47ZNMCfrF3dMrLoot9Kg1zsMN2qKqWp2WZG6cgm9YhGKlBW3ls6dvETx21k0VV29Vr6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HJjjgHg9; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747841382; x=1779377382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A1X938snYn4+crWNVxjarOAagImUmUcoxas32t2fLMg=;
  b=HJjjgHg9nza6c7jSDOwaXrdci2PoBeyc+c9MYtVCfs3xSKAjRUnNQ3KP
   1k+LUhXoA1gWMHzZLOTBzKfzEMWn673eHAIhFkEg2eS3sd7gs6l7hER1Q
   QwpKa3xih6NYMrNbpRYAiK8RyBipoYHvWcierV0/5oEvl9ur5hv9OV0rj
   bZcXFUWbVyZzYN3FMijo76m8rja4ePrRHPqX8JYMRNj4CstIudvtocyUh
   816j74YKzsIgWUZ2R26t4GVvWtEy0ev2IBm52OUgFMF7gCwWbcnXwBSbi
   Mt3udk+XlS3Jr1Z++pCZS31rK3N9ShDMxwa/34ziheSOjiZ8I9pw0AKvD
   g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="300252652"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:29:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:35120]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.29:2525] with esmtp (Farcaster)
 id 528b31b5-e788-44ae-96cb-2547648f8b78; Wed, 21 May 2025 15:29:37 +0000 (UTC)
X-Farcaster-Flow-ID: 528b31b5-e788-44ae-96cb-2547648f8b78
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 15:29:37 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC003.ant.amazon.com (10.13.138.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 15:29:35 +0000
From: Alexander Graf <graf@amazon.com>
To: <kexec@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, <nh-open-source@amazon.com>, Baoquan He
	<bhe@redhat.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH v4] kexec: Enable CMA based contiguous allocation
Date: Wed, 21 May 2025 15:29:34 +0000
Message-ID: <20250521152934.48841-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D020UWC003.ant.amazon.com (10.13.138.187)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When booting a new kernel with kexec_file, the kernel picks a target
location that the kernel should live at, then allocates random pages,
checks whether any of those patches magically happens to coincide with
a target address range and if so, uses them for that range.

For every page allocated this way, it then creates a page list that the
relocation code - code that executes while all CPUs are off and we are
just about to jump into the new kernel - copies to their final memory
location. We can not put them there before, because chances are pretty
good that at least some page in the target range is already in use by
the currently running Linux environment. Copying is happening from a
single CPU at RAM rate, which takes around 4-50 ms per 100 MiB.

All of this is inefficient and error prone.

To successfully kexec, we need to quiesce all devices of the outgoing
kernel so they don't scribble over the new kernel's memory. We have seen
cases where that does not happen properly (*cough* GIC *cough*) and hence
the new kernel was corrupted. This started a month long journey to root
cause failing kexecs to eventually see memory corruption, because the new
kernel was corrupted severely enough that it could not emit output to
tell us about the fact that it was corrupted. By allocating memory for the
next kernel from a memory range that is guaranteed scribbling free, we can
boot the next kernel up to a point where it is at least able to detect
corruption and maybe even stop it before it becomes severe. This increases
the chance for successful kexecs.

Since kexec got introduced, Linux has gained the CMA framework which
can perform physically contiguous memory mappings, while keeping that
memory available for movable memory when it is not needed for contiguous
allocations. The default CMA allocator is for DMA allocations.

This patch adds logic to the kexec file loader to attempt to place the
target payload at a location allocated from CMA. If successful, it uses
that memory range directly instead of creating copy instructions during
the hot phase. To ensure that there is a safety net in case anything goes
wrong with the CMA allocation, it also adds a flag for user space to force
disable CMA allocations.

Using CMA allocations has two advantages:

  1) Faster by 4-50 ms per 100 MiB. There is no more need to copy in the
     hot phase.
  2) More robust. Even if by accident some page is still in use for DMA,
     the new kernel image will be safe from that access because it resides
     in a memory region that is considered allocated in the old kernel and
     has a chance to reinitialize that component.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Clarify patch description
  - Move cma pointer out of kexec_segment. That is a sneaky UAPI struct we
    can not modify. Fixes non kexec_file path
  - Coding style
  - Move memset(0) to only clear remainder
  - Move kexec_alloc_contig() into kexec_locate_mem_hole(). Makes the code
    flow easier to read.
  - Sanitize return values

v2 -> v3:

  - Fix refactoring bug which meant we never exercised the new code path

v3 -> v4:

  - Skip CMA for crash kernels (thanks Zhongkun He!)
---
 arch/riscv/kernel/elf_kexec.c |   1 +
 include/linux/kexec.h         |  10 ++++
 include/uapi/linux/kexec.h    |   1 +
 kernel/kexec.c                |   2 +-
 kernel/kexec_core.c           | 100 +++++++++++++++++++++++++++++++---
 kernel/kexec_file.c           |  51 ++++++++++++++++-
 kernel/kexec_internal.h       |   2 +-
 7 files changed, 156 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index e783a72d051f..d81647c98c92 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -109,6 +109,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
 	kbuf.top_down = false;
+	kbuf.cma = NULL;
 	ret = arch_kexec_locate_mem_hole(&kbuf);
 	if (!ret) {
 		*old_pbase = lowest_paddr;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c8971861521a..7821b23bd1e9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -75,6 +75,12 @@ extern note_buf_t __percpu *crash_notes;
 
 typedef unsigned long kimage_entry_t;
 
+/*
+ * This is a copy of the UAPI struct kexec_segment and must be identical
+ * to it because it gets copied straight from user space into kernel
+ * memory. Do not modify this structure unless you change the way segments
+ * get ingested from user space.
+ */
 struct kexec_segment {
 	/*
 	 * This pointer can point to user memory if kexec_load() system
@@ -169,6 +175,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @cma:	CMA page if the buffer is backed by CMA.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -180,6 +187,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	struct page *cma;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
@@ -310,6 +318,7 @@ struct kimage {
 
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
+	struct page *segment_cma[KEXEC_SEGMENT_MAX];
 
 	struct list_head control_pages;
 	struct list_head dest_pages;
@@ -331,6 +340,7 @@ struct kimage {
 	 */
 	unsigned int hotplug_support:1;
 #endif
+	unsigned int no_cma:1;
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 5ae1741ea8ea..8958ebfcff94 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -27,6 +27,7 @@
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
 #define KEXEC_FILE_DEBUG	0x00000008
+#define KEXEC_FILE_NO_CMA	0x00000010
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
diff --git a/kernel/kexec.c b/kernel/kexec.c
index a6b3f96bb50c..28008e3d462e 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -152,7 +152,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		goto out;
 
 	for (i = 0; i < nr_segments; i++) {
-		ret = kimage_load_segment(image, &image->segment[i]);
+		ret = kimage_load_segment(image, i);
 		if (ret)
 			goto out;
 	}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3e62b944c883..b5b680dd1796 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/dma-map-ops.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -553,6 +554,24 @@ static void kimage_free_entry(kimage_entry_t entry)
 	kimage_free_pages(page);
 }
 
+static void kimage_free_cma(struct kimage *image)
+{
+	unsigned long i;
+
+	for (i = 0; i < image->nr_segments; i++) {
+		struct page *cma = image->segment_cma[i];
+		u32 nr_pages = image->segment[i].memsz >> PAGE_SHIFT;
+
+		if (!cma)
+			continue;
+
+		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
+		dma_release_from_contiguous(NULL, cma, nr_pages);
+		image->segment_cma[i] = NULL;
+	}
+
+}
+
 void kimage_free(struct kimage *image)
 {
 	kimage_entry_t *ptr, entry;
@@ -591,6 +610,9 @@ void kimage_free(struct kimage *image)
 	/* Free the kexec control pages... */
 	kimage_free_page_list(&image->control_pages);
 
+	/* Free CMA allocations */
+	kimage_free_cma(image);
+
 	/*
 	 * Free up any temporary buffers allocated. This might hit if
 	 * error occurred much later after buffer allocation.
@@ -716,9 +738,69 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
-static int kimage_load_normal_segment(struct kimage *image,
-					 struct kexec_segment *segment)
+static int kimage_load_cma_segment(struct kimage *image, int idx)
+{
+	struct kexec_segment *segment = &image->segment[idx];
+	struct page *cma = image->segment_cma[idx];
+	char *ptr = page_address(cma);
+	unsigned long maddr;
+	size_t ubytes, mbytes;
+	int result = 0;
+	unsigned char __user *buf = NULL;
+	unsigned char *kbuf = NULL;
+
+	if (image->file_mode)
+		kbuf = segment->kbuf;
+	else
+		buf = segment->buf;
+	ubytes = segment->bufsz;
+	mbytes = segment->memsz;
+	maddr = segment->mem;
+
+	/* Then copy from source buffer to the CMA one */
+	while (mbytes) {
+		size_t uchunk, mchunk;
+
+		ptr += maddr & ~PAGE_MASK;
+		mchunk = min_t(size_t, mbytes,
+				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		uchunk = min(ubytes, mchunk);
+
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
+
+		if (result) {
+			result = -EFAULT;
+			goto out;
+		}
+
+		ptr    += mchunk;
+		maddr  += mchunk;
+		mbytes -= mchunk;
+
+		cond_resched();
+	}
+
+	/* Clear any remainder */
+	memset(ptr, 0, mbytes);
+
+out:
+	return result;
+}
+
+static int kimage_load_normal_segment(struct kimage *image, int idx)
 {
+	struct kexec_segment *segment = &image->segment[idx];
 	unsigned long maddr;
 	size_t ubytes, mbytes;
 	int result;
@@ -733,6 +815,9 @@ static int kimage_load_normal_segment(struct kimage *image,
 	mbytes = segment->memsz;
 	maddr = segment->mem;
 
+	if (image->segment_cma[idx])
+		return kimage_load_cma_segment(image, idx);
+
 	result = kimage_set_destination(image, maddr);
 	if (result < 0)
 		goto out;
@@ -787,13 +872,13 @@ static int kimage_load_normal_segment(struct kimage *image,
 }
 
 #ifdef CONFIG_CRASH_DUMP
-static int kimage_load_crash_segment(struct kimage *image,
-					struct kexec_segment *segment)
+static int kimage_load_crash_segment(struct kimage *image, int idx)
 {
 	/* For crash dumps kernels we simply copy the data from
 	 * user space to it's destination.
 	 * We do things a page at a time for the sake of kmap.
 	 */
+	struct kexec_segment *segment = &image->segment[idx];
 	unsigned long maddr;
 	size_t ubytes, mbytes;
 	int result;
@@ -858,18 +943,17 @@ static int kimage_load_crash_segment(struct kimage *image,
 }
 #endif
 
-int kimage_load_segment(struct kimage *image,
-				struct kexec_segment *segment)
+int kimage_load_segment(struct kimage *image, int idx)
 {
 	int result = -ENOMEM;
 
 	switch (image->type) {
 	case KEXEC_TYPE_DEFAULT:
-		result = kimage_load_normal_segment(image, segment);
+		result = kimage_load_normal_segment(image, idx);
 		break;
 #ifdef CONFIG_CRASH_DUMP
 	case KEXEC_TYPE_CRASH:
-		result = kimage_load_crash_segment(image, segment);
+		result = kimage_load_crash_segment(image, idx);
 		break;
 #endif
 	}
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fba686487e3b..7168ebc2b83c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,7 @@
 #include <linux/kernel_read_file.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
+#include <linux/dma-map-ops.h>
 #include "kexec_internal.h"
 
 #ifdef CONFIG_KEXEC_SIG
@@ -230,6 +231,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		ret = 0;
 	}
 
+	image->no_cma = !!(flags & KEXEC_FILE_NO_CMA);
+
 	if (cmdline_len) {
 		image->cmdline_buf = memdup_user(cmdline_ptr, cmdline_len);
 		if (IS_ERR(image->cmdline_buf)) {
@@ -406,7 +409,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
 			      ksegment->memsz);
 
-		ret = kimage_load_segment(image, &image->segment[i]);
+		ret = kimage_load_segment(image, i);
 		if (ret)
 			goto out;
 	}
@@ -632,6 +635,43 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
 
+static int kexec_alloc_contig(struct kexec_buf *kbuf)
+{
+	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
+	unsigned long mem;
+	struct page *p;
+
+	/* User space disabled CMA allocations, bail out. */
+	if (kbuf->image->no_cma)
+		return -EPERM;
+
+	/* Skip CMA logic for crash kernel */
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return -EPERM;
+
+	p = dma_alloc_from_contiguous(NULL, nr_pages, get_order(kbuf->buf_align), true);
+	if (!p)
+		return -ENOMEM;
+
+	pr_debug("allocated %zu DMA pages at 0x%lx", nr_pages, page_to_boot_pfn(p));
+
+	mem = page_to_boot_pfn(p) << PAGE_SHIFT;
+
+	if (kimage_is_destination_range(kbuf->image, mem, mem + kbuf->memsz)) {
+		/* Our region is already in use by a statically defined one. Bail out. */
+		pr_debug("CMA overlaps existing mem: 0x%lx+0x%lx\n", mem, kbuf->memsz);
+		dma_release_from_contiguous(NULL, p, nr_pages);
+		return -EBUSY;
+	}
+
+	kbuf->mem = page_to_boot_pfn(p) << PAGE_SHIFT;
+	kbuf->cma = p;
+
+	arch_kexec_post_alloc_pages(page_address(p), (int)nr_pages, 0);
+
+	return 0;
+}
+
 /**
  * kexec_locate_mem_hole - find free memory for the purgatory or the next kernel
  * @kbuf:	Parameters for the memory search.
@@ -648,6 +688,13 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
+	/*
+	 * Try to find a free physically contiguous block of memory first. With that, we
+	 * can avoid any copying at kexec time.
+	 */
+	if (!kexec_alloc_contig(kbuf))
+		return 0;
+
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
 	else
@@ -693,6 +740,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	/* Ensure minimum alignment needed for segments. */
 	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
+	kbuf->cma = NULL;
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
 	ret = arch_kexec_locate_mem_hole(kbuf);
@@ -705,6 +753,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	ksegment->bufsz = kbuf->bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
+	kbuf->image->segment_cma[kbuf->image->nr_segments] = kbuf->cma;
 	kbuf->image->nr_segments++;
 	return 0;
 }
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index d35d9792402d..29e6cebe0c43 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -10,7 +10,7 @@ struct kimage *do_kimage_alloc_init(void);
 int sanity_check_segment_list(struct kimage *image);
 void kimage_free_page_list(struct list_head *list);
 void kimage_free(struct kimage *image);
-int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
+int kimage_load_segment(struct kimage *image, int idx);
 void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
-- 
2.34.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


