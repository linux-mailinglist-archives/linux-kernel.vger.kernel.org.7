Return-Path: <linux-kernel+bounces-831754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED5B9D7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E8F7A444B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242F2E8B82;
	Thu, 25 Sep 2025 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejehJ79G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264072E8B67
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778999; cv=none; b=C+tcJk0PxgUk7DsLozsFcT5aHVGwNw1aBcXGbKQt5p0Z7a2TAq5MFMUP15xzeGs2atvJxgMf2bHSJ5iZ+63axCNG692Zk0QwEiwcFU3OzHg7SzgwwZqSbXcXucjmGLSPYutKgQc72qLHAY0DMrB6b+zma2vTLP4gF2+hQpWLRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778999; c=relaxed/simple;
	bh=Q904bhQTSkf1SPlX7P2YHTYOSMBTO+a/QYeGYdLat7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jzQQP2Hh8ZhgzmZmcxMYuXrwyqzedi3lfIjBc5cRPemDRyUmiwRkcBNc7qsEB3xpA4zp09l3RB2IaV7e6FXPrCE6nw+GxwJ4wTMfokEId66Ca/R3zezYyfRbpjFdvD9I/tpy4Sr4LlzIBLw//h7qeV+DzQoZCIyMyZpW5HzAfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejehJ79G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758778998; x=1790314998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q904bhQTSkf1SPlX7P2YHTYOSMBTO+a/QYeGYdLat7g=;
  b=ejehJ79GHSWpw8sZYRdGNhq8W1mcXXauW0o8R41InA+VY96nGPr0DiOd
   OtINjAzS2oajSjUIauZcXkIEyqYtRxX8k4ceVt0v60Qmvn7Nbzx0OGT2l
   GTOeasTbyEoCgizb/ksjT1XHAOaERGHzeW/XaJeji6GDFhvb7ojh6l7gA
   WS3eBDckSdifVWBlNszeSVgkvb2iG8yey29NZeW3piNcpHAZumtn8ceJ+
   8ieLg+xNy/rybD+4/d+ybPaPjl3+MtTZZvmhGbz0JFAfiDvmO4RiP8Zwj
   IeUCEy8J9gQ2iP5uK08dB6qLVtLCsxalMx0baBwCFwvBEPjxZH9m8sj00
   w==;
X-CSE-ConnectionGUID: y0gDxHCWTsObkfnNCWKDyw==
X-CSE-MsgGUID: saHN4x+CSfCzPm0Df5hb8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60301668"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="60301668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 22:43:14 -0700
X-CSE-ConnectionGUID: hpbQk4JUSd22gQdlMUxj3g==
X-CSE-MsgGUID: /ey4sfw4Qq6564S9S5F+Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="181625382"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 24 Sep 2025 22:43:12 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] firmware_loader: Only call cancel when upload is active
Date: Thu, 25 Sep 2025 11:11:29 +0530
Message-Id: <20250925054129.2199157-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cancel_store() function currently calls the firmware upload cancel
operation even when no upload is in progress (i.e., when progress is
FW_UPLOAD_PROG_IDLE).

Update cancel_store() to only invoke the cancel operation when an upload
is active. If the upload is idle, return -ENODEV without calling cancel.

This change improves safety and correctness by ensuring driver operations
are only called in valid states.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/base/firmware_loader/sysfs_upload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 829270067d16..c3797b93c5f5 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -100,8 +100,10 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&fwlp->lock);
-	if (fwlp->progress == FW_UPLOAD_PROG_IDLE)
-		ret = -ENODEV;
+	if (fwlp->progress == FW_UPLOAD_PROG_IDLE) {
+		mutex_unlock(&fwlp->lock);
+		return -ENODEV;
+	}
 
 	fwlp->ops->cancel(fwlp->fw_upload);
 	mutex_unlock(&fwlp->lock);
-- 
2.34.1


