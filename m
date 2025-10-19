Return-Path: <linux-kernel+bounces-859547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6823BEDEFE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0BDE4EAC09
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF24238C08;
	Sun, 19 Oct 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HosUKOji"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703482264B8
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854631; cv=none; b=HcCYkewjCuq3gBLPN5BAMSpAyHCzrz/Oh5hXb6ZuEdD7t63rYA9AUiMk0qcy9W/NbdBmWUkS+6n1Rc3VU79RU55zXdOwY0j6NeQrjN49ybZvN466nodn032XD6M6SUC2p+KzayJwTEAf0aolWIMKkUJi19w1X8+ioGJGCb2ZVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854631; c=relaxed/simple;
	bh=X/K4RiZ73czA8/XwfmtauZrp2iq1+Yt81SKQb98QRew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AF7fNaXPv1R1v7B+F8O6a0lmXD86mQ4F+DSYYN4/WirmZZ8D+dtW0eSXuGd/2mEW5GerYz3Gxvf9IAxf6ytn6aDV8+NBVu4aiHevvoRKEzKBWimCab7cyQYsV8pQy8FJ7hCFGLdzi1OtaxCn1DsXMXvRVc3MJEwfZ2juoK2UdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HosUKOji; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f8986so32658385ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854628; x=1761459428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0wsGtkMDP+lGhx28p+RHXRkJ0fALFx2Ca8PburHIFc=;
        b=HosUKOjigdLEEScyP6+kxvKPJYbDlMZ5jTMBaAeySS4TenVNKIUcznq0Kd2Ukk+ztg
         1ngAkYfFm/uaEmUA13miQF7UJnlKiTIckWJ3vsdevtdv/LC0Cd1eLQls5ugqVSJ6Hjl0
         e6kpSsWaHKwqPhV2j5cCNnLCB326afwy20ClSHuKl+4pp1E6uH1Yr6A4rIdV3aJpmG5i
         34Riy0xuLiuxbpl1q04H8ttH9KPKk8WTEbsAAdJ5wY1JzT+0l4IrhtQ6bhVDmAi6N9U5
         VpERfwhfSeHp5gANKbjoUT4WyogYDuP/Mbe1vbJ22BE+36Euxmh0aSDbttKzw1vBGG6M
         4iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854628; x=1761459428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0wsGtkMDP+lGhx28p+RHXRkJ0fALFx2Ca8PburHIFc=;
        b=lmam4CfksBQmJLD223P2M+KFD5Iqrlm8GuOd3+VkjvU3FlQccZt9KOtkQ5aKhsLBEl
         czY2xvXMmZbrLoL0tIl7FTwbchMs5h1brdpLlWHwkKmZRcaCTEVsG9kTjjQ1uU6cUJsB
         AQI3KX1huqqZ41RZr7WlLhIXull+yEPRCOq2zdqVbzzcK6amlKPDsnYrQyOktklw0i8j
         Lge9dD5JHw/l4CvG9gJ33iWxKywPfQyjeX2lCCTSSN/ZzageBCccW+0N6Wd/v0+xuB0A
         OHK76dRIZg4flRrY51XAX6iSBYocMCXKG6cEVcvzhPvflH+BVpFIqnoylUf1idcHeIvd
         bTRw==
X-Gm-Message-State: AOJu0Yz2xn2m3SaQFbBtMs6ecIMQOklboiMZY3HcUM83YxnqDrhNg7XF
	YktEt+kixV1pXH3mmd0r4CtRaI8bEfEzCsZYcO881pNoZaEfnjuAdJYDGq2gIQ==
X-Gm-Gg: ASbGncs/YdLNQ7DS20jr5W5SMy1tL7YME/AJ77bG/pSCBP0y93X2q0sXJHkuSzAKLty
	HE2wT+VjOUaDSVymsMZ6z4XGN+s/v2T50PxL2FDkuqUUU34rRO0MG71GUimsZttFGaIiUXSkAU1
	90BqU3ajbY4UZ3LseDG99RZGYRMAVaRXuuYr+V0FptqO5um9l041iTsuNeCVLB559hYSAcpUy0P
	jEhoLuty+ahhB5HMx+J032L+DRWUHIFrrVqdc8XCfuTex90ZNU2ZCVuz4Ec/qo+Kg2Gjhj6BJaz
	5U2Cnt5G/AhL8TSbuPzQlA15HHcttjdEnavhWAdWT1BUVSDf8hPC9tUrMav3mUAXAXBTh1qJcQC
	rfJ7GcrulxNwqMJmL36BB5D6V6FVazOzaqjmHhCEHoRmiYtMHp9jcs2ArVbueRLvbeClZ3zZIsn
	+06d0P
X-Google-Smtp-Source: AGHT+IGu67uE2s3blbKf/o2fKnuxlQtS3znzk8IIHkaEnUlKNNl2NW2CaX6Hyb7Xbj4GWxwVqCqcDg==
X-Received: by 2002:a17:903:230a:b0:290:c3a6:822c with SMTP id d9443c01a7336-290c9d1b50dmr103427605ad.15.1760854628322;
        Sat, 18 Oct 2025 23:17:08 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:07 -0700 (PDT)
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
Subject: [RFC Patch v2 09/16] kexec: Integrate multikernel instance management with kexec subsystem
Date: Sat, 18 Oct 2025 23:16:23 -0700
Message-Id: <20251019061631.2235405-10-xiyou.wangcong@gmail.com>
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

Establish bidirectional integration between the kexec subsystem and
multikernel instance management, enabling proper lifecycle tracking
and resource coordination for multikernel operations.

This commit introduces:

* Enhanced kimage structure with multikernel-specific fields including
  mk_id for unique multikernel identification and mk_instance pointer
  for cross-referencing with the multikernel instance management
  system, enabling proper state synchronization.

* UAPI extensions in include/uapi/linux/kexec.h that define multikernel
  ID encoding within kexec flags using KEXEC_MK_ID_MASK and
  KEXEC_MK_ID_SHIFT, providing up to 2047 unique multikernel instances
  with proper bit field management macros.

* Multikernel image lookup infrastructure through kimage_find_by_id()
  that leverages the mk_instance system for efficient image retrieval
  by multikernel ID, replacing CPU-based lookup with proper instance
  management.

* Refactored multikernel_kexec() interface from CPU-based to ID-based
  operation (multikernel_kexec_by_id()) that uses instance CPU
  assignments from device tree configuration rather than manual CPU
  specification, improving safety and consistency.

* Proper resource lifecycle management in kimage_free() that clears
  cross-references, updates instance states, and handles reference
  counting when multikernel images are freed, preventing resource
  leaks and dangling pointers.

* Updated reboot syscall interface that accepts multikernel instance
  IDs instead of CPU numbers in LINUX_REBOOT_CMD_MULTIKERNEL,
  providing a more intuitive and safer user interface.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/kexec.h       | 10 ++++-
 include/linux/multikernel.h |  3 ++
 include/uapi/linux/kexec.h  |  4 ++
 kernel/kexec_core.c         | 75 +++++++++++++++++++++++++++++++++----
 kernel/reboot.c             |  4 +-
 5 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 69877db5360b..5e9e9ad1dfeb 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -132,6 +132,7 @@ struct purgatory_info {
 };
 
 struct kimage;
+struct mk_instance;
 
 typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
 typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
@@ -434,6 +435,12 @@ struct kimage {
 
 	/* For multikernel support: linked list node */
 	struct list_head list;
+
+	/* Multikernel unique ID (0 = current kernel, >0 = multikernel images) */
+	int mk_id;
+
+	/* Multikernel instance cross-reference */
+	struct mk_instance *mk_instance;
 };
 
 /* kexec interface functions */
@@ -441,7 +448,8 @@ extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
-extern int multikernel_kexec(int cpu);
+extern int multikernel_kexec_by_id(int mk_id);
+extern struct kimage *kimage_find_by_id(int mk_id);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 
diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
index 75cbb316d565..c65d39a66b84 100644
--- a/include/linux/multikernel.h
+++ b/include/linux/multikernel.h
@@ -102,6 +102,9 @@ struct mk_instance {
 	void *dtb_data;                 /* Device tree blob data */
 	size_t dtb_size;                /* Size of DTB */
 
+	/* Kexec integration */
+	struct kimage *kimage;          /* Associated kimage object */
+
 	/* Sysfs representation */
 	struct kernfs_node *kn;            /* Kernfs node for this instance */
 
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 346e0ff4e663..82a562ae6ac1 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -15,6 +15,10 @@
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
 #define KEXEC_MULTIKERNEL	0x00000010
+#define KEXEC_MK_ID_MASK	0x0000ffe0
+#define KEXEC_MK_ID_SHIFT	5
+#define KEXEC_MK_ID(id)		(((id) << KEXEC_MK_ID_SHIFT) & KEXEC_MK_ID_MASK)
+#define KEXEC_GET_MK_ID(flags)	(((flags) & KEXEC_MK_ID_MASK) >> KEXEC_MK_ID_SHIFT)
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 449096060fe8..ed5c97b4531e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/multikernel.h>
 #include <linux/dma-map-ops.h>
 #include <linux/memblock.h>
 
@@ -255,6 +256,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list node for multikernel support */
 	INIT_LIST_HEAD(&image->list);
 
+	/* Initialize multikernel ID (0 = current kernel, will be assigned later for multikernel) */
+	image->mk_id = 0;
+
+	/* Initialize multikernel instance cross-reference */
+	image->mk_instance = NULL;
+
 #ifdef CONFIG_CRASH_HOTPLUG
 	image->hp_action = KEXEC_CRASH_HP_NONE;
 	image->elfcorehdr_index = -1;
@@ -594,6 +601,16 @@ void kimage_free(struct kimage *image)
 	else if (image == kexec_crash_image)
 		kimage_update_compat_pointers(NULL, KEXEC_TYPE_CRASH);
 
+	/* Remove from IDR if it's a multikernel image */
+	if (image->type == KEXEC_TYPE_MULTIKERNEL && image->mk_instance) {
+		/* Clear cross-reference and update state */
+		image->mk_instance->kimage = NULL;
+		mk_instance_set_state(image->mk_instance, MK_STATE_READY);
+		mk_instance_put(image->mk_instance);
+		image->mk_instance = NULL;
+		pr_info("Freed multikernel ID %d\n", image->mk_id);
+	}
+
 #ifdef CONFIG_CRASH_DUMP
 	if (image->vmcoreinfo_data_copy) {
 		crash_update_vmcoreinfo_safecopy(NULL);
@@ -1393,26 +1410,68 @@ int kernel_kexec(void)
 	return error;
 }
 
-int multikernel_kexec(int cpu)
+/*
+ * Find a multikernel image by ID using mk_instance lookup
+ */
+struct kimage *kimage_find_by_id(int mk_id)
 {
-	int rc;
+	struct mk_instance *instance;
+	struct kimage *image = NULL;
 
-	pr_info("multikernel kexec: cpu %d\n", cpu);
+	if (mk_id <= 0)
+		return NULL;
 
-	if (cpu_online(cpu)) {
-		pr_err("The CPU is currently running with this kernel instance.");
-		return -EBUSY;
+	/* Use mk_instance system to find the associated kimage */
+	instance = mk_instance_find(mk_id);
+	if (instance) {
+		image = instance->kimage;
+		mk_instance_put(instance); /* Release reference from find */
 	}
 
+	return image;
+}
+
+int multikernel_kexec_by_id(int mk_id)
+{
+	struct kimage *mk_image;
+	struct mk_instance *instance;
+	int cpu = -1;
+	int rc;
+
 	if (!kexec_trylock())
 		return -EBUSY;
-	if (!kexec_image) {
+
+	mk_image = kimage_find_by_id(mk_id);
+	if (!mk_image) {
+		pr_err("No multikernel image found with ID %d\n", mk_id);
 		rc = -EINVAL;
 		goto unlock;
 	}
 
+	instance = mk_image->mk_instance;
+	if (instance->cpus_valid && !cpumask_empty(instance->cpus)) {
+		cpu = cpumask_first(instance->cpus);
+		pr_info("multikernel kexec: using assigned CPU %d from instance cpumask %*pbl\n",
+			cpu, cpumask_pr_args(instance->cpus));
+	} else {
+		pr_err("No CPU assignment found for multikernel instance %d - CPU assignment is required\n",
+		       mk_id);
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	if (cpu_online(cpu)) {
+		pr_err("CPU %d is currently online and cannot be used for multikernel instance %d\n",
+		       cpu, mk_id);
+		rc = -EBUSY;
+		goto unlock;
+	}
+
+	pr_info("Using multikernel image with ID %d (entry point: 0x%lx) on CPU %d\n",
+		mk_image->mk_id, mk_image->start, cpu);
+
 	cpus_read_lock();
-	rc = multikernel_kick_ap(cpu, kexec_image->start);
+	rc = multikernel_kick_ap(cpu, mk_image->start);
 	cpus_read_unlock();
 
 unlock:
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f3ac703c4695..bff6d3603a17 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -718,7 +718,7 @@ EXPORT_SYMBOL_GPL(kernel_power_off);
 DEFINE_MUTEX(system_transition_mutex);
 
 struct multikernel_boot_args {
-	int cpu;
+	int mk_id;
 };
 
 /*
@@ -807,7 +807,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	case LINUX_REBOOT_CMD_MULTIKERNEL:
 		if (copy_from_user(&boot_args, arg, sizeof(boot_args)))
 			return -EFAULT;
-		ret = multikernel_kexec(boot_args.cpu);
+		ret = multikernel_kexec_by_id(boot_args.mk_id);
 		break;
 #endif
 
-- 
2.34.1


