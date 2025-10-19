Return-Path: <linux-kernel+bounces-859554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C733BEDF0D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3344E8325
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA2242910;
	Sun, 19 Oct 2025 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7/MiI4M"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAF23F413
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854645; cv=none; b=UWTE/vymmrQ/Hzfd226KFtknlxKMYx9R+IxIOY9puGvgj3rdH1tt/R4He3iIRZTrJsQQOv8ci+tRBzG7OciosXlwaMcotAdMeoSB8XKDWuYwUoNL+EbiUV6imKYCaSPzy35dnQywQR3ZF0xFbay2RgNITa2vnn81T0jPvEILdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854645; c=relaxed/simple;
	bh=MjyxXjQK8WF0Qh6z6OoE1qF+pWY4l7hHei8XCn0lQdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWwF2aQuPcBp7vo/6qKW4fbzpTrbijUJCMVFXoBWmOptbiVcNKmt/yzR5HBd8BiVzDkMo3ICwTG/mckvYcxmTNv7U2QyBGBEd6e2xQhkpDBPt4swgI1puG4g3WXTQUekuzKFvdilrwnH49PQZFcNYc6B/iN1v+eHi7AUppcrstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7/MiI4M; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so647291b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854642; x=1761459442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHtfDmtNu58qaeT00d02kMdjaM8J6l+T+7ap5Uqy+yE=;
        b=J7/MiI4MSJf6VZQ0X4PP2QcvvfLOee0scyW9redhmiMdx3w6FFVSi5UY6PMHnfeTUD
         VqetPpN7S2VjWY3I9Gm+8YbPj9GIHbc8zajjc+bzu1YMOYZYwzj6gshmdn3I2rpU6xMt
         dE5+62oxzUBEM8A6Cp5x37WfPhxDsphBAf+Q/JIj3uSMYLWqkS/RZTMkLcmyLp62XS6r
         cypIwMnjSY31JCzjmeizQTLr4f6aXRq+cm2VqYXcolsAixm5fQNjdR6nleyweOcF8AB4
         sZKO8kj28AMHEehy1vzngPU62ltjGrcmi0twj6Z5N7q/UMiEviMvKsfNRndvRn7Hm27D
         NvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854642; x=1761459442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHtfDmtNu58qaeT00d02kMdjaM8J6l+T+7ap5Uqy+yE=;
        b=j+jiiaiuqHhJ7mQJJ4PI3W6LC3QYoi+XcmF3N+JfrjToa9K1Ds3E3zUtQ9oWQglF+y
         dvVJgjNntsiOdQD05gyB3CfG+goSueiutDp1VbCYBg54rLGI5Aq+LD9iOFWdwYcTqenT
         vPnWNX96cbsPx3TCyhsjEpO1AeGIulOiHUuq2npjlzjrh1fWDI2qSwm6HxakzdFVF6lj
         1z5jF0s6JjoZg/Zao4LTuZv8ilqJ9XK8jgB38r7WJP7PxTdVVLxGQ+zBW/iQqAd5IWLg
         2inc9fKvQLOVVHmH5Cl/lJtkr7CJ/NVGDZbZ40/Xb6EtGyrJokP09cutwlqV0qkI3aYO
         lIdg==
X-Gm-Message-State: AOJu0Yzmw3UnriZVutrnY3OzKYmDhEA/2Z85mgPxaesu/YLlHXQiOKX1
	iq9P/fCwACnmzCAOON6cAvyuQdbcyfOMv/Nh5EBwHR7spBoBLyAtRq09JYTSHw==
X-Gm-Gg: ASbGncsSFrq0bA+M5XkcGy9wAh+nxeRYGFmorRj4NVMLLKueBG0kYvdBtVI927H76Gs
	Aa0bqHSVShh1mgQWeY3uxL9MqnYPgS4g0FeMnZdgMnshRQ2dPLtAntVanQtbJH09zLJnR8Pjl6p
	7M8rBYYAvRTPdqoJcx9VFSpC49UoIw4c1kiIYgsvWrJfESzCA3NdC4QoXOfNKlhD8rHa9BWpXi3
	I6RMEEQIbZHijL918CraO2YwI0SNdHI6zezDu+QvHMqU1P4MxyRHBTuGhFtiJON6AGqOhucMQnH
	fQ548ly5gaqDL6nG/heW6cVY2rJhWFQr2v5Q33JJcqJ/wuRv8zdGchGy72GKhm5LzvITPo9Q28V
	BtPJhxqYMQKDO6Qn0pX0rZIlc5PEm4tjnK7meL74nWQzIKCydE8dCjLXxVQ4s0FrlxMyaea2yCD
	QwTv/WXeIqj7Npn4RsY+fPz7a6wQ==
X-Google-Smtp-Source: AGHT+IF+l7vrEZFb1JvgrlXqJojLzFTrJb7A2HoVWh6qL7YExVTjo54P1fLRx45jmPuBVut01m7GGw==
X-Received: by 2002:a05:6a20:3945:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-334a8629db6mr11280818637.44.1760854642239;
        Sat, 18 Oct 2025 23:17:22 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:21 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 15/16] kexec: Integrate multikernel support with kexec_file_load()
Date: Sat, 18 Oct 2025 23:16:29 -0700
Message-Id: <20251019061631.2235405-16-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

This commit introduces:

* Multikernel flag support in kexec_file_load by adding KEXEC_MULTIKERNEL
  to KEXEC_FILE_FLAGS, enabling user-space to specify multikernel
  operations through the file-based kexec interface with proper flag
  validation and ID extraction.

* Instance-based memory allocation for multikernel images through
  kexec_alloc_multikernel() that allocates kernel segments from
  instance-specific memory pools rather than system memory, ensuring
  compliance with device tree resource specifications.

* Multikernel control page allocation via kimage_alloc_multikernel_control_pages()
  that provides page-aligned control structures from instance pools
  with proper alignment validation and conflict detection against
  existing segments.

* Enhanced kimage_file_alloc_init() with multikernel instance association
  that extracts multikernel IDs from kexec flags, validates instance
  availability, establishes bidirectional cross-references, and updates
  instance states to LOADING during the load process.

* Integrated memory hole location in kexec_locate_mem_hole() that
  prioritizes multikernel instance pool allocation over system memory
  allocation, ensuring multikernel segments respect reserved memory
  boundaries and resource isolation.

The integration maintains compatibility with existing kexec_file_load()
use cases, such as crash kernel, while extending it for multikernel case.
Standard kexec operations continue to use system memory allocation, while
multikernel operations automatically use instance-specific pools when
the KEXEC_MULTIKERNEL flag is specified.

This enables user-space tools to load multikernel images using the
more secure and flexible kexec_file_load interface rather than the
legacy kexec_load syscall, providing better integration with modern
security frameworks and signed kernel verification.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/kexec.h |   3 +-
 kernel/kexec_core.c   |  61 ++++++++++++++++++++++
 kernel/kexec_file.c   | 116 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5e9e9ad1dfeb..b907b7a92fd2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -477,7 +477,8 @@ bool kexec_load_permitted(int kexec_image_type);
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
-				 KEXEC_FILE_NO_CMA | KEXEC_FILE_FORCE_DTB)
+				 KEXEC_FILE_NO_CMA | KEXEC_FILE_FORCE_DTB | \
+				 KEXEC_MULTIKERNEL)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7db755e64dd6..61ad01acd034 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -476,6 +476,64 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 }
 #endif
 
+static struct page *kimage_alloc_multikernel_control_pages(struct kimage *image,
+							   unsigned int order)
+{
+	/* Control pages for multikernel must be allocated from the instance's
+	 * memory pool to ensure they stay within the reserved memory regions
+	 * specified in the device tree configuration.
+	 *
+	 * We use mk_kimage_alloc() to get memory from the instance pool,
+	 * then convert it to page structures.
+	 */
+	void *virt_addr;
+	phys_addr_t phys_addr;
+	struct page *pages;
+	unsigned long size;
+	unsigned int count;
+
+	if (!image->mk_instance) {
+		pr_err("Multikernel image has no associated instance\n");
+		return NULL;
+	}
+
+	count = 1 << order;
+	size = count << PAGE_SHIFT;
+
+	/* Allocate from the multikernel instance pool (page aligned) */
+	virt_addr = mk_kimage_alloc(image, size, PAGE_SIZE);
+	if (!virt_addr) {
+		pr_debug("Failed to allocate %lu bytes for multikernel control pages\n", size);
+		return NULL;
+	}
+
+	/* Convert virtual address to physical */
+	phys_addr = virt_to_phys(virt_addr);
+
+	/* Check alignment requirements - control pages need page alignment */
+	if (!IS_ALIGNED(phys_addr, PAGE_SIZE)) {
+		pr_err("Multikernel control page allocation not page-aligned: phys=0x%llx\n",
+		       (unsigned long long)phys_addr);
+		mk_kimage_free(image, virt_addr, size);
+		return NULL;
+	}
+
+	/* Get the page structure */
+	pages = virt_to_page(virt_addr);
+
+	/* Check for conflicts with existing segments */
+	if (kimage_is_destination_range(image, phys_addr, phys_addr + size - 1)) {
+		pr_debug("Multikernel control pages conflict with existing segments: 0x%llx+0x%lx\n",
+			 (unsigned long long)phys_addr, size);
+		mk_kimage_free(image, virt_addr, size);
+		return NULL;
+	}
+
+	pr_debug("Allocated multikernel control pages: order=%u, phys=0x%llx, virt=%px\n",
+		 order, (unsigned long long)phys_addr, virt_addr);
+
+	return pages;
+}
 
 struct page *kimage_alloc_control_pages(struct kimage *image,
 					 unsigned int order)
@@ -491,6 +549,9 @@ struct page *kimage_alloc_control_pages(struct kimage *image,
 		pages = kimage_alloc_crash_control_pages(image, order);
 		break;
 #endif
+	case KEXEC_TYPE_MULTIKERNEL:
+		pages = kimage_alloc_multikernel_control_pages(image, order);
+		break;
 	}
 
 	return pages;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2d9d5626c8da..f9979c1d9f9e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/dma-map-ops.h>
+#include <linux/multikernel.h>
 #include "kexec_internal.h"
 
 #ifdef CONFIG_KEXEC_SIG
@@ -309,6 +310,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	int ret;
 	struct kimage *image;
 	bool kexec_on_panic = flags & KEXEC_FILE_ON_CRASH;
+	bool multikernel_load = flags & KEXEC_MULTIKERNEL;
 
 	image = do_kimage_alloc_init();
 	if (!image)
@@ -322,8 +324,50 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 		/* Enable special crash kernel control page alloc policy. */
 		image->control_page = crashk_res.start;
 		image->type = KEXEC_TYPE_CRASH;
-	}
+	} else
 #endif
+	if (multikernel_load) {
+		struct mk_instance *instance;
+		int mk_id = KEXEC_GET_MK_ID(flags);
+
+		/* Set multikernel image type for proper memory allocation */
+		image->type = KEXEC_TYPE_MULTIKERNEL;
+
+		pr_info("kexec_file_load: multikernel load - flags=0x%lx, extracted mk_id=%d\n",
+			flags, mk_id);
+
+		if (mk_id <= 0) {
+			pr_err("Invalid multikernel ID %d in flags\n", mk_id);
+			ret = -EINVAL;
+			goto out_free_image;
+		}
+
+		/* Find the existing mk_instance */
+		instance = mk_instance_find(mk_id);
+		if (!instance) {
+			pr_err("No multikernel instance found with ID %d\n", mk_id);
+			ret = -ENOENT;
+			goto out_free_image;
+		}
+
+		/* Check if instance is already associated with a kimage */
+		if (instance->kimage) {
+			pr_err("Multikernel instance %d already has an associated kimage\n", mk_id);
+			mk_instance_put(instance);
+			ret = -EBUSY;
+			goto out_free_image;
+		}
+
+		/* Establish cross-references */
+		image->mk_instance = instance; /* Transfer reference from find */
+		image->mk_id = mk_id;
+		instance->kimage = image;
+
+		/* Update instance state */
+		mk_instance_set_state(instance, MK_STATE_LOADING);
+
+		pr_info("Associated kimage with multikernel instance %d\n", mk_id);
+	}
 
 	ret = kimage_file_prepare_segments(image, kernel_fd, initrd_fd,
 					   cmdline_ptr, cmdline_len, flags);
@@ -731,6 +775,61 @@ static int kexec_alloc_contig(struct kexec_buf *kbuf)
 	return 0;
 }
 
+static int kexec_alloc_multikernel(struct kexec_buf *kbuf)
+{
+	void *virt_addr;
+	phys_addr_t phys_addr;
+
+	pr_info("kexec_alloc_multikernel: called for segment size=0x%lx, buf_min=0x%lx, buf_max=0x%lx, align=0x%lx\n",
+		kbuf->memsz, kbuf->buf_min, kbuf->buf_max, kbuf->buf_align);
+
+	/* Check if this is a multikernel image with an associated instance */
+	if (!kbuf->image->mk_instance || kbuf->image->type != KEXEC_TYPE_MULTIKERNEL) {
+		pr_info("kexec_alloc_multikernel: not a multikernel image (mk_instance=%p, type=%d)\n",
+			kbuf->image->mk_instance, kbuf->image->type);
+		return -EPERM;
+	}
+
+	/* Allocate from the multikernel instance pool using the proper API */
+	virt_addr = mk_kimage_alloc(kbuf->image, kbuf->memsz, kbuf->buf_align);
+	if (!virt_addr) {
+		pr_info("Failed to allocate %lu bytes from multikernel instance pool (align=0x%lx)\n",
+			kbuf->memsz, kbuf->buf_align);
+		return -ENOMEM;
+	}
+
+	/* Convert virtual address to physical */
+	phys_addr = virt_to_phys(virt_addr);
+
+	if (!IS_ALIGNED(phys_addr, kbuf->buf_align)) {
+		pr_info("Multikernel allocation not aligned: phys=0x%llx, required=0x%lx\n",
+			 (unsigned long long)phys_addr, kbuf->buf_align);
+		mk_kimage_free(kbuf->image, virt_addr, kbuf->memsz);
+		return -ENOMEM;
+	}
+
+	if (phys_addr < kbuf->buf_min || (phys_addr + kbuf->memsz - 1) > kbuf->buf_max) {
+		pr_info("Multikernel allocation out of bounds: phys=0x%llx, min=0x%lx, max=0x%lx\n",
+			 (unsigned long long)phys_addr, kbuf->buf_min, kbuf->buf_max);
+		mk_kimage_free(kbuf->image, virt_addr, kbuf->memsz);
+		return -ENOMEM;
+	}
+
+	if (kimage_is_destination_range(kbuf->image, phys_addr, phys_addr + kbuf->memsz - 1)) {
+		pr_info("Multikernel allocation conflicts with existing segments: 0x%llx+0x%lx\n",
+			 (unsigned long long)phys_addr, kbuf->memsz);
+		mk_kimage_free(kbuf->image, virt_addr, kbuf->memsz);
+		return -EBUSY;
+	}
+
+	kbuf->mem = phys_addr;
+
+	pr_info("Allocated %lu bytes from multikernel pool at 0x%llx (virt=%px)\n",
+		 kbuf->memsz, (unsigned long long)phys_addr, virt_addr);
+
+	return 0;
+}
+
 /**
  * kexec_locate_mem_hole - find free memory for the purgatory or the next kernel
  * @kbuf:	Parameters for the memory search.
@@ -743,8 +842,21 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
 	int ret;
 
+	pr_info("kexec_locate_mem_hole: called for segment size=0x%lx, mem=0x%lx, image_type=%d\n",
+		kbuf->memsz, kbuf->mem, kbuf->image->type);
+
 	/* Arch knows where to place */
-	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN) {
+		pr_info("kexec_locate_mem_hole: memory already specified (0x%lx), skipping allocation\n", kbuf->mem);
+		return 0;
+	}
+
+	/*
+	 * If this is a multikernel image, try to allocate from the instance's
+	 * memory pool first. This ensures multikernel segments use pre-reserved
+	 * memory from the device tree configuration and respects the pool management.
+	 */
+	if (!kexec_alloc_multikernel(kbuf))
 		return 0;
 
 	/*
-- 
2.34.1


