Return-Path: <linux-kernel+bounces-822841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39743B84C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A093B7ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AAD30C11A;
	Thu, 18 Sep 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwGuZumW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9430C0F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201441; cv=none; b=gpGLr7eduFmRUlSZMwmmlYkKyfMg1xy8njadYCRMAQDOz5OVzw2NtenihtSwn4bkv0XDAOTGUKqyqNbJcVSvooVTvGQGrWh4k5NE37FiGVAw+lz6AYBE4j+z5a8xQ3xEAhoWOSp2iv490pioIA0gUlmRx4nUBecQneuiZAeRZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201441; c=relaxed/simple;
	bh=HyQ8KCr8bpy6N16GzTZOo7lPRr6VBHlCVz/5w3LKQgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbhwOEF+s2ga1EvjjjoGURNH0ZvCxQ//FDzTjnOOHxHDGjMrot+wAhB6maE7e089qvGd1RuEhEhOFacCf4Z3DJniDGtubrM1pW1TG97eo02x7UzZAQKMABAXa+j6wqVCVFBusZH+SGUI3t9lX7trimD0S6Ua+VRRdLLHBTr4zRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwGuZumW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758201439; x=1789737439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HyQ8KCr8bpy6N16GzTZOo7lPRr6VBHlCVz/5w3LKQgg=;
  b=XwGuZumWpT1vcqxlzHqGiL+PB+ANUCMOJYElwicrJDwtTCV0gWfKwS5i
   9icucv8PfQbKHXJJjmYOjHKiYrNY1xNcx5SE9u8/9gSvOdAXKVRL5oOv3
   5+maDWnhoADwxrb1C6uZkGTNiw7ETocck9zDl3/tjChxXX06tq/VZpU4o
   4LN4x/TI4x0PZthN942J7ZPqSTdDbczKvtTjPRmGw1XRfmUW0zx4g/7Vh
   XKgtKaLNjXjYvcJfySQelxbL/mQhMJ+CLNJZXUu5if435aLE2zcmFFxhB
   8tMBwUdN7XzKE52FxachJTaJmN9rIxYgJ93qVMCuxTmcW/Z7ji1FWMa1O
   w==;
X-CSE-ConnectionGUID: uPPT5GqCTGu6E+8PiFh7uQ==
X-CSE-MsgGUID: Cxw/1LglRy2XcMXSsKltng==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77970720"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="77970720"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:19 -0700
X-CSE-ConnectionGUID: HsZYEMfLR3miYme8ygZ24g==
X-CSE-MsgGUID: CKEJ96A1R1ahrZEgbmNQbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174648837"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:18 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next 5/5] mei: gsc: demote unexpected reset print
Date: Thu, 18 Sep 2025 16:04:35 +0300
Message-ID: <20250918130435.3327400-6-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918130435.3327400-1-alexander.usyskin@intel.com>
References: <20250918130435.3327400-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discrete graphic card can go to D3cold.
On the exit from D3cold the link reset is performed.
Driver did not expect such link reset and print warning.

Print debug message for unexpected reset in discrete graphic
case and remove infrastructure to print warning is some cases.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me.c   | 42 +++-----------------------------------
 drivers/misc/mei/init.c    | 17 ---------------
 drivers/misc/mei/mei_dev.h |  6 ------
 3 files changed, 3 insertions(+), 62 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 3172dc095b53..d4612c659784 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -493,43 +493,6 @@ static int mei_me_hw_ready_wait(struct mei_device *dev)
 	return 0;
 }
 
-/**
- * mei_me_check_fw_reset - check for the firmware reset error and exception conditions
- *
- * @dev: mei device
- */
-static void mei_me_check_fw_reset(struct mei_device *dev)
-{
-	struct mei_fw_status fw_status;
-	char fw_sts_str[MEI_FW_STATUS_STR_SZ] = {0};
-	int ret;
-	u32 fw_pm_event = 0;
-
-	if (!dev->saved_fw_status_flag)
-		goto end;
-
-	if (dev->gsc_reset_to_pxp == MEI_DEV_RESET_TO_PXP_PERFORMED) {
-		ret = mei_fw_status(dev, &fw_status);
-		if (!ret) {
-			fw_pm_event = fw_status.status[1] & PCI_CFG_HFS_2_PM_EVENT_MASK;
-			if (fw_pm_event != PCI_CFG_HFS_2_PM_CMOFF_TO_CMX_ERROR &&
-			    fw_pm_event != PCI_CFG_HFS_2_PM_CM_RESET_ERROR)
-				goto end;
-		} else {
-			dev_err(&dev->dev, "failed to read firmware status: %d\n", ret);
-		}
-	}
-
-	mei_fw_status2str(&dev->saved_fw_status, fw_sts_str, sizeof(fw_sts_str));
-	dev_warn(&dev->dev, "unexpected reset: fw_pm_event = 0x%x, dev_state = %u fw status = %s\n",
-		 fw_pm_event, dev->saved_dev_state, fw_sts_str);
-
-end:
-	if (dev->gsc_reset_to_pxp == MEI_DEV_RESET_TO_PXP_PERFORMED)
-		dev->gsc_reset_to_pxp = MEI_DEV_RESET_TO_PXP_DONE;
-	dev->saved_fw_status_flag = false;
-}
-
 /**
  * mei_me_hw_start - hw start routine
  *
@@ -540,8 +503,9 @@ static int mei_me_hw_start(struct mei_device *dev)
 {
 	int ret = mei_me_hw_ready_wait(dev);
 
-	if (kind_is_gsc(dev) || kind_is_gscfi(dev))
-		mei_me_check_fw_reset(dev);
+	if ((kind_is_gsc(dev) || kind_is_gscfi(dev)) &&
+	    dev->gsc_reset_to_pxp == MEI_DEV_RESET_TO_PXP_PERFORMED)
+		dev->gsc_reset_to_pxp = MEI_DEV_RESET_TO_PXP_DONE;
 	if (ret)
 		return ret;
 	dev_dbg(&dev->dev, "hw is ready\n");
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 32ce6a879207..b789c4d9c709 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -89,22 +89,6 @@ void mei_cancel_work(struct mei_device *dev)
 }
 EXPORT_SYMBOL_GPL(mei_cancel_work);
 
-static void mei_save_fw_status(struct mei_device *dev)
-{
-	struct mei_fw_status fw_status;
-	int ret;
-
-	ret = mei_fw_status(dev, &fw_status);
-	if (ret) {
-		dev_err(&dev->dev, "failed to read firmware status: %d\n", ret);
-		return;
-	}
-
-	dev->saved_dev_state = dev->dev_state;
-	dev->saved_fw_status_flag = true;
-	memcpy(&dev->saved_fw_status, &fw_status, sizeof(fw_status));
-}
-
 /**
  * mei_reset - resets host and fw.
  *
@@ -128,7 +112,6 @@ int mei_reset(struct mei_device *dev)
 		if (kind_is_gsc(dev) || kind_is_gscfi(dev)) {
 			dev_dbg(&dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
 				mei_dev_state_str(state), fw_sts_str);
-			mei_save_fw_status(dev);
 		} else {
 			dev_warn(&dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
 				 mei_dev_state_str(state), fw_sts_str);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 23afa381a0a0..0bf8d552c3ea 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -551,9 +551,6 @@ struct mei_dev_timeouts {
  *
  * @dbgfs_dir   : debugfs mei root directory
  *
- * @saved_fw_status      : saved firmware status
- * @saved_dev_state      : saved device state
- * @saved_fw_status_flag : flag indicating that firmware status was saved
  * @gsc_reset_to_pxp     : state of reset to the PXP mode
  *
  * @ops:        : hw specific operations
@@ -654,9 +651,6 @@ struct mei_device {
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
 
-	struct mei_fw_status saved_fw_status;
-	enum mei_dev_state saved_dev_state;
-	bool saved_fw_status_flag;
 	enum mei_dev_reset_to_pxp gsc_reset_to_pxp;
 
 	const struct mei_hw_ops *ops;
-- 
2.43.0


