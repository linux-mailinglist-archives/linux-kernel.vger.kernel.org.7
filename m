Return-Path: <linux-kernel+bounces-895652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC0C4EAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF973BDF65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940063431EA;
	Tue, 11 Nov 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLPwo99M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821663009F8;
	Tue, 11 Nov 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872070; cv=none; b=NyAO5VbPRY/+QJHnWHJkcp/DZ8nEsc45nCwcD9Ga5vyzw811+lLKLCWnbssBkdd3/RgAci8R3e/SdXQA6446RfVYKlHG1RK1++MUm7Sx49NSXIlhBEcGQEDncDJRm/u/zWN0kLfCDYva5dzXutiztn/zHZ+ZXo7VkU4aHRtUtwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872070; c=relaxed/simple;
	bh=iAH0LTL+4qRzuduo577LGKOMsbGbDY9vXHc/u0ctUVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIDO6rLXLL5PxvyNE3/DxXLkwC55mAiaf7kpQOFOl/v69nESUwqCO1AcyoLh4jwkj183WVhVk24szHJuYOa/s2GUoRhj4uXrb3Fvwydz5s7K/NCgOJRAje1RERICPjaPRSc8nzkTqRIt0Ls+Ur7eflsF1wsbR/gNEPkAFjnc+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLPwo99M; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762872069; x=1794408069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAH0LTL+4qRzuduo577LGKOMsbGbDY9vXHc/u0ctUVk=;
  b=RLPwo99M9kjDOZ1rajhdNOQZYNXPA6tOuDY3CKj4FABAUvOys11/qo1g
   PSIdH4o/GSkohkpv6yLwDVw27FAdVJ39lZyq2I2uwYHR6zBOQm2YwiI9s
   ThLiRkMwUFHI+E4YJn+mxeSUzsk/TjMjCgWvJYIGzWaZQwNWqFmQCDuN/
   6NmjAt276GI5TpYCf2gH7AzQDWbXi6Rek1lq2zQN7/bTmEP929xepWzlR
   +VT9wnt/aEf8uqot4ZdU2YflRKpVtBYFvlc7/H8vzjaNYHHFt0tNu4vXp
   DbZRIOwFF9Q+w39WaaJfZfdeZwUipe9qmlh8nNKAk9KaGW6fGmq+8jv60
   Q==;
X-CSE-ConnectionGUID: 0HSB53ecSm2Ofx84ONnjpg==
X-CSE-MsgGUID: BoSdqC5jT4+/uZ/Hsq5SvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="68793478"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="68793478"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 06:41:08 -0800
X-CSE-ConnectionGUID: LB+Qego2RbSri0Rhg7q2HA==
X-CSE-MsgGUID: VODNQr1MTsKmoDbvJp0wRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189407292"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 11 Nov 2025 06:41:06 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 255AB98; Tue, 11 Nov 2025 15:41:05 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 2/2] devres: Move devm_alloc_percpu() and related to devres.h
Date: Tue, 11 Nov 2025 15:39:58 +0100
Message-ID: <20251111144104.910241-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111144104.910241-1-andriy.shevchenko@linux.intel.com>
References: <20251111144104.910241-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/device/devres.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 18 deletions(-)

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
index 8c5f57e0d613..a2186893b574 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -96,6 +96,22 @@ devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt, va_list ap);
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


