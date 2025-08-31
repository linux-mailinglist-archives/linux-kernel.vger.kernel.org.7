Return-Path: <linux-kernel+bounces-793547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB97B3D506
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FE63A68CE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A891E98E6;
	Sun, 31 Aug 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTfDaQ6Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62972168BD
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756669702; cv=none; b=QXLo3vaeOY+NYzAI0TzcMrjdbR6wrsba25fZrwRDzlq1ef0hpobQciEIVoULmEcEXB4/J6EJ9S6Gpx3pzhUwtjO0Widd6QCwlGBR8N2z1pKwMy2v6bYXbSdB/94IaCyQjf6C6Xv2w1qmnesNJYga1FotOurA6IL+S8fM98EekGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756669702; c=relaxed/simple;
	bh=2ZryXjK3jxFDUCPMthIjEHuPtG8uGwIyUNUoT14G/Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ni8+oOIgCbhvdKYbWGGU29WjdQ/zcEYJYi38U/Lz5J8QcU1IkSC81G4WIuvCW9XWZFl0td5z2XS27IhPbKB2D4TymGKqUFYXTW5h3F9rnkdNbT/bFVRId2mCasH2U7ES9t1Gy1L8DHMKpqJMAqi4X/xik3gEVqBsJsfy1cMDE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTfDaQ6Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756669701; x=1788205701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ZryXjK3jxFDUCPMthIjEHuPtG8uGwIyUNUoT14G/Z8=;
  b=XTfDaQ6ZyEKW0xKtlnwCxl58ko1dA4bNrJ7+zdhMfbyd+NNBch+6Pl0A
   lVEmTOGTUUrfdlenSf2AWjdc9TJtoC3hq+ZQdvrCca2FkIi08TWkiwDk4
   /kvxQbed6SbPFVKtzlHT68jUS08739AA+Lbef913a01bJeYsZbwVnsIYV
   YCIjMgmKheaWXKiaihBKhdHj8EXLhSuvakjqgRfoVBdL1ILDSHx49YXIC
   g0IsqRkCh/dl9y/ywS3t9yavXVSzEj919nJX9ApAYiAmNj6EXtWgUavHy
   aOITTQ9MKi/BI9JrQ5rTpvFgxcuyXVtPjotRV1lHhhc495ysIR5G7Rf/1
   g==;
X-CSE-ConnectionGUID: PhMCQM7gSYivkcQfMd7U5g==
X-CSE-MsgGUID: b6tA5cAnQ0yALCkD65T//A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81465372"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81465372"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 12:48:20 -0700
X-CSE-ConnectionGUID: a0QXIk79QsmqGF93GHZM4g==
X-CSE-MsgGUID: pBt3F+fDSnypCf5oCRRvrA==
X-ExtLoop1: 1
Received: from cdjpc409-it.jer.intel.com ([10.12.50.122])
  by fmviesa003.fm.intel.com with ESMTP; 31 Aug 2025 12:48:18 -0700
From: Gil Fine <gil.fine@linux.intel.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org
Cc: gil.fine@intel.com,
	gil.fine@linux.intel.com
Subject: [PATCH] driver core: Fix order of the kernel-doc parameters
Date: Sun, 31 Aug 2025 22:49:30 +0300
Message-ID: <20250831194930.2063390-1-gil.fine@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the order of the kernel-doc parameters in device_find_child() and
device_for_each_child*() functions to match the actual functions signature.

No functional changes.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
---
 drivers/base/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..fe85ca796b24 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3994,8 +3994,8 @@ const char *device_get_devnode(const struct device *dev,
 /**
  * device_for_each_child - device child iterator.
  * @parent: parent struct device.
- * @fn: function to be called for each device.
  * @data: data for the callback.
+ * @fn: function to be called for each device.
  *
  * Iterate over @parent's child devices, and call @fn for each,
  * passing it @data.
@@ -4024,8 +4024,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child);
 /**
  * device_for_each_child_reverse - device child iterator in reversed order.
  * @parent: parent struct device.
- * @fn: function to be called for each device.
  * @data: data for the callback.
+ * @fn: function to be called for each device.
  *
  * Iterate over @parent's child devices, and call @fn for each,
  * passing it @data.
@@ -4055,8 +4055,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
  * device_for_each_child_reverse_from - device child iterator in reversed order.
  * @parent: parent struct device.
  * @from: optional starting point in child list
- * @fn: function to be called for each device.
  * @data: data for the callback.
+ * @fn: function to be called for each device.
  *
  * Iterate over @parent's child devices, starting at @from, and call @fn
  * for each, passing it @data. This helper is identical to
@@ -4089,8 +4089,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse_from);
 /**
  * device_find_child - device iterator for locating a particular device.
  * @parent: parent struct device
- * @match: Callback function to check device
  * @data: Data to pass to match function
+ * @match: Callback function to check device
  *
  * This is similar to the device_for_each_child() function above, but it
  * returns a reference to a device that is 'found' for later use, as
-- 
2.43.0


