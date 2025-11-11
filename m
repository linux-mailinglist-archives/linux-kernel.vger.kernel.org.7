Return-Path: <linux-kernel+bounces-895668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4BC4EA03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03FF54F668E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7A30EF86;
	Tue, 11 Nov 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzTpweft"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639541A3178;
	Tue, 11 Nov 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872654; cv=none; b=ZN0Si/iRpr2zEYEJHyyQ++A3tYjcsqwmFllp3nqAq/FHyc0YPgnt0h80dIDmv2DqRsoN1bbceYPwd8i/S4M45vpNbZ3X3besOcqBAORdd8FDOHXiOLGRlmM1VHOb80G2y2kVMiChpXMndSXJwv/c+k1F9WfKJVwu/1/3Yc/8A34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872654; c=relaxed/simple;
	bh=v99117MGYVWmQZnJ8EGbbfXSAArRfL4nDoBBh2bne0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEoJ/0cLpRE/JQGYEHm5UJtWJ/UjXDaAEiC0WRhOoSY299ApFYxR0MNrF1Sqgw1jDqz4l6x15MmACFmRcgBHmlmh0zikrHbozUZwKPMFXCYomFXT7+nqdakXIrLtRHjGYMXc6Jt1ZlBf4Ow/as6ukbMFBOrsEv8tFb01Xt2uRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzTpweft; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762872652; x=1794408652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v99117MGYVWmQZnJ8EGbbfXSAArRfL4nDoBBh2bne0k=;
  b=CzTpweftI8n3pomtIPEf3e4vAzOyVjpx57F9FtnPi1xw4hIIGCNnlexY
   GQuBeYTQY33vCW5zC4tJZtRAmWDcHo5luhFXiszYZSWNXgQIeudJS15xB
   QUIGTzqzCQxzot+660h5QMHS9fqDsO3zHBLKTbpUFzGiVFF665DiQF1cX
   O9rGnGlTKk7pRzGrqXFWiKdhi91BrtAMAa8Le0/RDNqWhkyXA2U4CBdyl
   OhU+ZEJwOjWWyxQhonwhmuX2eVStmbV15TcWAhw0g6UOIIeWeHmnJ4KT8
   mWfAsAZ1w4UGNZHJ+oHSLdpXjX3lZxNZHmsvG3oxyFIQRslmLjYFlpFQ1
   A==;
X-CSE-ConnectionGUID: SzuYB5imQU6IkXOYx4kfHw==
X-CSE-MsgGUID: szC5LjsYR56gN+G5XD+9cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75551553"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="75551553"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 06:50:52 -0800
X-CSE-ConnectionGUID: FGtMBDK+RgOAC3HYYAW2/w==
X-CSE-MsgGUID: qFIxIRoeSXWx1i2ax5LMyg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 11 Nov 2025 06:50:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B3F4B98; Tue, 11 Nov 2025 15:50:48 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 2/2] devres: Move devm_alloc_percpu() and related to devres.h
Date: Tue, 11 Nov 2025 15:49:46 +0100
Message-ID: <20251111145046.997309-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111145046.997309-1-andriy.shevchenko@linux.intel.com>
References: <20251111145046.997309-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move devm_alloc_percpu() and related to devres.h where it belongs,

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h        | 18 ------------------
 include/linux/device/devres.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0c6377f6631c..0be95294b6e6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -281,24 +281,6 @@ int __must_check device_create_bin_file(struct device *dev,
 void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
-/**
- * devm_alloc_percpu - Resource-managed alloc_percpu
- * @dev: Device to allocate per-cpu memory for
- * @type: Type to allocate per-cpu memory for
- *
- * Managed alloc_percpu. Per-cpu memory allocated with this function is
- * automatically freed on driver detach.
- *
- * RETURNS:
- * Pointer to allocated memory on success, NULL on failure.
- */
-#define devm_alloc_percpu(dev, type)      \
-	((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), \
-						      __alignof__(type)))
-
-void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
-				   size_t align);
-
 struct device_dma_parameters {
 	/*
 	 * a low level driver may set these to teach IOMMU code about
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 8c5f57e0d613..9c1e3d643d69 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -9,6 +9,7 @@
 #include <linux/stdarg.h>
 #include <linux/types.h>
 #include <asm/bug.h>
+#include <asm/percpu.h>
 
 struct device;
 struct device_node;
@@ -96,6 +97,22 @@ devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt, va_list ap);
 char * __printf(3, 4) __malloc
 devm_kasprintf(struct device *dev, gfp_t gfp, const char *fmt, ...);
 
+/**
+ * devm_alloc_percpu - Resource-managed alloc_percpu
+ * @dev: Device to allocate per-cpu memory for
+ * @type: Type to allocate per-cpu memory for
+ *
+ * Managed alloc_percpu. Per-cpu memory allocated with this function is
+ * automatically freed on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+#define devm_alloc_percpu(dev, type)      \
+	((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), __alignof__(type)))
+
+void __percpu *__devm_alloc_percpu(struct device *dev, size_t size, size_t align);
+
 unsigned long devm_get_free_pages(struct device *dev, gfp_t gfp_mask, unsigned int order);
 void devm_free_pages(struct device *dev, unsigned long addr);
 
-- 
2.50.1


