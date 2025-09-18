Return-Path: <linux-kernel+bounces-822839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF98B84C54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720A3581ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC12FE56B;
	Thu, 18 Sep 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbPOKRES"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88530B51D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201437; cv=none; b=Xbox13Yjy4aQTs9PiHHTb5mZeqFMC0cvkOswf+s29eshb+MRh7+LeqJVLIVDwbd67jBWPKPYZKPoWjmTnRdlhPQzfWX3vJMNB9ylfmqU0Xsg/yBFIdzxyCIm3QnfkOTSFmfExJ1dd+OYRrM75FFn69hSwD1kc+FYsxtsMQLwG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201437; c=relaxed/simple;
	bh=e7pSmlvKKaCM1hV2B4SRXTfZFTkeEmDL37d00ocErAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKKrwpeEvOd3+kjHEzTsrbEzoJneKPRSy6gni43W2XbaBYsCPcVyKKR8U3JKvb55r4yzD14W+6ue3H5eJ7+t0joDh0kljmL8X/l9M+t4p/6lUM6vJUprXx3nO6dwA+61HhxAdP/UJ5Tph96BhIedClc5Bv6/BWZ4l0NYdaVRoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbPOKRES; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758201436; x=1789737436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7pSmlvKKaCM1hV2B4SRXTfZFTkeEmDL37d00ocErAI=;
  b=QbPOKRESSzYgTKlZ0GWCHpZoD5RvaOXVsiY7AY1F31q4QDnRqFrwLO2Q
   czyQCddOwP/dNnZzyvuY5/csLyGzSoWknXYleaGTST31zQ3G7g6bspNVJ
   JUR/8xhfUnhF7x2NsjlXjxvqjX3sIQy3GU586lAEWyIXGxXGR0YX1x8Bu
   ximgOxaIO6H8iAJOJ9ewheJnMds2DDbvtrxotxcjaGHVZqj04qwJ8Np1H
   LIIvXJ04WnE10uoSnnuIfpRl360dcXq70KeDXLXKTBjrQ3hZjAhvKJP33
   iiylq1WZxx25wM8pEpJlgguxv+oTGjg+/lXbJ2VPv40zyKUVKJgQL/j1z
   w==;
X-CSE-ConnectionGUID: wNEvOjcuSpWo00ea1Gn9cA==
X-CSE-MsgGUID: zb3/uA0zQ2KOhtDZQKExNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77970712"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="77970712"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:15 -0700
X-CSE-ConnectionGUID: rxRX1tnIQIm0K6/2RUPkRQ==
X-CSE-MsgGUID: xxfcX6g6Sjih4uD04iz0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174648810"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:14 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next 3/5] mei: retry connect if interrupted by link reset
Date: Thu, 18 Sep 2025 16:04:33 +0300
Message-ID: <20250918130435.3327400-4-alexander.usyskin@intel.com>
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

When device is in D3cold the connect message will wake device
and cause link reset.
Link reset flow cleans all queues and wakes all waiters.
Retry the connect flow if connect is failed and link reset is detected.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw.h      |  2 ++
 drivers/misc/mei/init.c    |  2 ++
 drivers/misc/mei/main.c    | 25 +++++++++++++++++++++++++
 drivers/misc/mei/mei_dev.h |  3 +++
 4 files changed, 32 insertions(+)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 2e9cf6f4efb6..3771aa09c592 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -27,6 +27,8 @@
 #define MKHI_RCV_TIMEOUT 500 /* receive timeout in msec */
 #define MKHI_RCV_TIMEOUT_SLOW 10000 /* receive timeout in msec, slow FW */
 
+#define MEI_LINK_RESET_WAIT_TIMEOUT_MSEC 500  /* Max wait timeout for link reset, in msec */
+
 /*
  * FW page size for DMA allocations
  */
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index b9fb54328a7b..32ce6a879207 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -400,6 +400,7 @@ void mei_device_init(struct mei_device *dev,
 	init_waitqueue_head(&dev->wait_pg);
 	init_waitqueue_head(&dev->wait_hbm_start);
 	dev->dev_state = MEI_DEV_UNINITIALIZED;
+	init_waitqueue_head(&dev->wait_dev_state);
 	dev->reset_count = 0;
 
 	INIT_LIST_HEAD(&dev->write_list);
@@ -442,5 +443,6 @@ void mei_device_init(struct mei_device *dev,
 		dev->timeouts.hbm = mei_secs_to_jiffies(MEI_HBM_TIMEOUT);
 		dev->timeouts.mkhi_recv = msecs_to_jiffies(MKHI_RCV_TIMEOUT);
 	}
+	dev->timeouts.link_reset_wait = msecs_to_jiffies(MEI_LINK_RESET_WAIT_TIMEOUT_MSEC);
 }
 EXPORT_SYMBOL_GPL(mei_device_init);
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 2d41a05b8694..e69140fc5aa4 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -423,6 +423,7 @@ static int mei_ioctl_connect_client(struct file *file,
 	    cl->state != MEI_FILE_DISCONNECTED)
 		return  -EBUSY;
 
+retry:
 	/* find ME client we're trying to connect to */
 	me_cl = mei_me_cl_by_uuid(dev, in_client_uuid);
 	if (!me_cl) {
@@ -454,6 +455,28 @@ static int mei_ioctl_connect_client(struct file *file,
 
 	rets = mei_cl_connect(cl, me_cl, file);
 
+	if (rets && cl->status == -EFAULT &&
+	    (dev->dev_state == MEI_DEV_RESETTING ||
+	     dev->dev_state == MEI_DEV_INIT_CLIENTS)) {
+		/* in link reset, wait for it completion */
+		mutex_unlock(&dev->device_lock);
+		rets = wait_event_interruptible_timeout(dev->wait_dev_state,
+							dev->dev_state == MEI_DEV_ENABLED,
+							dev->timeouts.link_reset_wait);
+		mutex_lock(&dev->device_lock);
+		if (rets < 0) {
+			if (signal_pending(current))
+				rets = -EINTR;
+			goto end;
+		}
+		if (dev->dev_state != MEI_DEV_ENABLED) {
+			rets = -ETIME;
+			goto end;
+		}
+		mei_me_cl_put(me_cl);
+		goto retry;
+	}
+
 end:
 	mei_me_cl_put(me_cl);
 	return rets;
@@ -1120,6 +1143,8 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
 
 	dev->dev_state = state;
 
+	wake_up_interruptible_all(&dev->wait_dev_state);
+
 	if (!dev->cdev)
 		return;
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 9f2044ae6cc4..23afa381a0a0 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -466,6 +466,7 @@ struct mei_dev_timeouts {
 	unsigned int d0i3; /* D0i3 set/unset max response time, in jiffies */
 	unsigned long hbm; /* HBM operation timeout, in jiffies */
 	unsigned long mkhi_recv; /* receive timeout, in jiffies */
+	unsigned long link_reset_wait; /* link reset wait timeout, in jiffies */
 };
 
 /**
@@ -496,6 +497,7 @@ struct mei_dev_timeouts {
  *
  * @reset_count : number of consecutive resets
  * @dev_state   : device state
+ * @wait_dev_state: wait queue for device state change
  * @hbm_state   : state of host bus message protocol
  * @pxp_mode    : PXP device mode
  * @init_clients_timer : HBM init handshake timeout
@@ -588,6 +590,7 @@ struct mei_device {
 	 */
 	unsigned long reset_count;
 	enum mei_dev_state dev_state;
+	wait_queue_head_t wait_dev_state;
 	enum mei_hbm_state hbm_state;
 	enum mei_dev_pxp_mode pxp_mode;
 	u16 init_clients_timer;
-- 
2.43.0


