Return-Path: <linux-kernel+bounces-831859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E2B9DB82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3950217963F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AAE2EA147;
	Thu, 25 Sep 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3DZftnb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE972676DE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782399; cv=none; b=SjRQUgNS7aH3nN1wTfXAPXPxKOp0Ec0z7+W61Onn37daxWDN7mpdni15LAB8KHo8zIYQBBtscx0YyazmkTh3c4kQTpwjh2AJSYx7q2ds3Yz6RnDpeUBOKlt2WMArpRg6DldLwnaQskQLp96txJWVBf71obp/2P37XlBLTgYckAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782399; c=relaxed/simple;
	bh=ozLTijDRgnJ2QvZ8Aw2II3feKEvz+93h+AB8NQ3ZEDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgdQ2E4XEV/PQaEXQigWuWFnBLszmVP9c5H4HAjw1znRxR3NNNGBEjQQ8zg7WwJwkFaH0oHHct8BcfPZlMzYMlTZy1g7A+GZqb6ejtWvL+4ziK7hH2dFgm1M9Mfj2WBSVh0GXHn9ECBzrfcQhIXLV5xo4WTKgV9zangHZMZj0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3DZftnb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758782398; x=1790318398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ozLTijDRgnJ2QvZ8Aw2II3feKEvz+93h+AB8NQ3ZEDA=;
  b=V3DZftnbnajKFTY/fwu5JkxKPAUnvr1QZXdj9YjOPVdOGw/pBMAuXUby
   1OJBp7mpG+5QoIYuTj3mzgmwjyIZCzwjYZjTuZF/C4tiDJGQQnUfwNkXM
   KPrcsDGxB/Ox/tdi8hlZ26ebpz3UQglqkyfckUZSpcUlHUxBP5dhYToTr
   Uf6p0fsvOSd+zc5GqgfECI/uiZULg6n9KYe3II3bBnhsKoULvDntL+3jo
   GNeQkA9XpxB2FDyYPsSkqAJ/niQL+ZCd8dHAc4FEumPWzkXAJ4/mIwm/p
   XhjfSznTpqRGr44dlQFqkp/8txXeA+WY7M6AML7/iinstgXo4IiahhzPQ
   A==;
X-CSE-ConnectionGUID: y8eKgLg5TkWMi+hIgOZecw==
X-CSE-MsgGUID: l8Bj+++6RSm39x1YdPZM4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="72193208"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="72193208"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:39:57 -0700
X-CSE-ConnectionGUID: 7A/kssaeSfiY1UbVwThkAw==
X-CSE-MsgGUID: xJ322nVSTRKSruZ4aMwHGQ==
X-ExtLoop1: 1
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Sep 2025 23:39:54 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] firmware_loader: Replace simple_strtol() with kstrtoint()
Date: Thu, 25 Sep 2025 12:08:12 +0530
Message-Id: <20250925063812.2269501-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated simple_strtol() calls with kstrtoint() in
timeout_store() and firmware_loading_store() functions to
improve input validation and error handling. The simple_strtol()
function does not provide proper error checking for invalid input,
while kstrtoint() returns an error for malformed strings.

This change adds proper validation for user input from sysfs attributes,
returning -EINVAL for invalid numeric strings instead of silently accepting
potentially malformed input. The behavior for valid numeric input remains
unchanged.

The simple_strtol() function is deprecated in favor of kstrtoint() family
functions which provide better error handling and are recommended for new
code and replacements.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/base/firmware_loader/sysfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index add0b9b75edd..92e91050f96a 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -47,7 +47,10 @@ static ssize_t timeout_show(const struct class *class, const struct class_attrib
 static ssize_t timeout_store(const struct class *class, const struct class_attribute *attr,
 			     const char *buf, size_t count)
 {
-	int tmp_loading_timeout = simple_strtol(buf, NULL, 10);
+	int tmp_loading_timeout;
+
+	if (kstrtoint(buf, 10, &tmp_loading_timeout))
+		return -EINVAL;
 
 	if (tmp_loading_timeout < 0)
 		tmp_loading_timeout = 0;
@@ -157,7 +160,10 @@ static ssize_t firmware_loading_store(struct device *dev,
 	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
 	struct fw_priv *fw_priv;
 	ssize_t written = count;
-	int loading = simple_strtol(buf, NULL, 10);
+	int loading;
+
+	if (kstrtoint(buf, 10, &loading))
+		return -EINVAL;
 
 	mutex_lock(&fw_lock);
 	fw_priv = fw_sysfs->fw_priv;
-- 
2.34.1


