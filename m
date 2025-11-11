Return-Path: <linux-kernel+bounces-895653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C137CC4E937
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D34124F575C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516E3446AB;
	Tue, 11 Nov 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpVH0z82"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFE334C28;
	Tue, 11 Nov 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872072; cv=none; b=rTlzinDPv8yIf1UiES/baoJ0GAoWKCCgvRQIY8lxKkj3UAnj0nUSZAOmvrrhSQW4rwHQilvn2MnLPcBLgt1EiFjnD7uShUSKTqWN2yTKVs2R2y84C1KHdWLz9vkwsRTLRhtrQidkniL8+bvCpgesizYpRnKzZ9sXwLU8l3O+hbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872072; c=relaxed/simple;
	bh=CJT2bHiYVzimb6xUOlUijV6ufxC2fzRRaAwV5VvZxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW61wcR0L6p+NycEtRgCCtNinvemdrVrLSNOXUrxYAyAj4ZhpdxkCQZ58OidfdCTff9JLkDcEwBUwTDxpFFOmhRc1jvl5T6iOCTr/p6+zQZDNp2HX27PgAb1Og/y+ZWMqL+vMCI5cg5nIKXcrhn51+kI2SGJHErhQ+iOXydOthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpVH0z82; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762872071; x=1794408071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJT2bHiYVzimb6xUOlUijV6ufxC2fzRRaAwV5VvZxnE=;
  b=JpVH0z82xNdF0Ix4LVAbR8U1WuxZS6kToiKjZSfn1fB3U29ViDjc11ye
   mS53nFpBS7//RD1yh7Sz8NJUNl9s02TeFVEcF/zc1Z6dozmdwojpaWCbf
   RQvihGlRlCIcXFbBANJfbSPJc6g8DzE0oW8IcmRdSg0jSOuIiMwbUzA+H
   Ok0zMvCQX1dEllng5m+cKSBI79ypTM+DPtpexRgaRv2qc0iOaN0qr3DX3
   AbaUA2YSsFEZl8k3R2Xz987GWlLtf3ePeCKDP7I5qQGy1akdroHUfsQd+
   iNnCK23I1CJVQwXkzHFzDfkSeKKsEEQvVLvvltXuXyURNbK7kCHvguqo9
   w==;
X-CSE-ConnectionGUID: Bo4WUZPyQB693rKsC/zyAA==
X-CSE-MsgGUID: kuEySbvBQ4W2K8ofOTMeKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="68793482"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="68793482"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 06:41:08 -0800
X-CSE-ConnectionGUID: dyI0WteNTQGUcNMhK/iXZA==
X-CSE-MsgGUID: y+S2diDMTYywfLgXZzwwYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189407293"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 11 Nov 2025 06:41:06 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 223B597; Tue, 11 Nov 2025 15:41:05 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 1/2] devres: Remove unused devm_free_percpu()
Date: Tue, 11 Nov 2025 15:39:57 +0100
Message-ID: <20251111144104.910241-2-andriy.shevchenko@linux.intel.com>
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

Remove unused devm_free_percpu().

By the way, it was never used in the drivers/ from day 1.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/base/devres.c                         | 25 -------------------
 include/linux/device.h                        |  1 -
 3 files changed, 27 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 2b36ebde9cec..0198ac65e874 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -383,7 +383,6 @@ NET
 
 PER-CPU MEM
   devm_alloc_percpu()
-  devm_free_percpu()
 
 PCI
   devm_pci_alloc_host_bridge()  : managed PCI host bridge allocation
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index c948c88d3956..f54db6d138ab 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1222,13 +1222,6 @@ static void devm_percpu_release(struct device *dev, void *pdata)
 	free_percpu(p);
 }
 
-static int devm_percpu_match(struct device *dev, void *data, void *p)
-{
-	struct devres *devr = container_of(data, struct devres, data);
-
-	return *(void **)devr->data == p;
-}
-
 /**
  * __devm_alloc_percpu - Resource-managed alloc_percpu
  * @dev: Device to allocate per-cpu memory for
@@ -1264,21 +1257,3 @@ void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
 	return pcpu;
 }
 EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
-
-/**
- * devm_free_percpu - Resource-managed free_percpu
- * @dev: Device this memory belongs to
- * @pdata: Per-cpu memory to free
- *
- * Free memory allocated with devm_alloc_percpu().
- */
-void devm_free_percpu(struct device *dev, void __percpu *pdata)
-{
-	/*
-	 * Use devres_release() to prevent memory leakage as
-	 * devm_free_pages() does.
-	 */
-	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
-			       (void *)(__force unsigned long)pdata));
-}
-EXPORT_SYMBOL_GPL(devm_free_percpu);
diff --git a/include/linux/device.h b/include/linux/device.h
index b031ff71a5bd..0c6377f6631c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -298,7 +298,6 @@ void device_remove_bin_file(struct device *dev,
 
 void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
 				   size_t align);
-void devm_free_percpu(struct device *dev, void __percpu *pdata);
 
 struct device_dma_parameters {
 	/*
-- 
2.50.1


