Return-Path: <linux-kernel+bounces-724028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B75AFEDB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532E91793E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E1F2E9EA6;
	Wed,  9 Jul 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fuk9beMK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5B2E92DF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074816; cv=none; b=iTBmbczIJjper7XzCc000M5vODYoWZG1klGoRmS+sYm6n6vI7h5gMdLMQDDFbhpqy5bf5FrR5SiT0wpdEkHrZNwq4RIbS+u6uGl4oRIglIw1bW5fdCRr5JeU+YS6HQ38eG1aLhKCnDbBQJCN48xHOik7+cu6k+AbQgCu1viqS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074816; c=relaxed/simple;
	bh=k6CpQI6U2HXDC55vGr6BSJJaxh2hOKhfwA+pkGvRtyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9KYuoO9E7z+0riK8DfEJrntOFfmKdR2xt0/yeCLwut5ZuQLemWHM4G7b5MAAM6K9PptB3qRJtb+OgRDakD4yy5VlOuebvuwbjXpbYGXzGJF6vIzOMWzvLKbWCB+LJXBENsE2vDnBsV65XskVwLCxhpQFR5KWyLCJ1IYe6TRbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fuk9beMK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752074815; x=1783610815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k6CpQI6U2HXDC55vGr6BSJJaxh2hOKhfwA+pkGvRtyM=;
  b=Fuk9beMKruWHqP+u0LHlEoO0jH+0UiSCGYUAZMq87N5kHqRja2pusVxy
   ykjSZO4mD6li7ZXsUie5UwXip5+SlaY0AxZ40ksWYFZWSQupFsjm8VnPp
   iyP/sr2KpL+rSRDTaczriKRpqTPEefgjdQsZ+EH9zUN0ibOGXSEs+jXbl
   qIMxYBIv67MFmoCBg/AcGyL+ms7OOEoJAXtYcJh+UpKImQxn6eVTPPX57
   QjcpktR2qEGFQAfOFN8I1t1WYcvzro2sybKcO+oo4wc+HEE2rDtYLf1uH
   DozxS9SNz6Aq9U8MrbTThlB2UJlK5tSaJ+nlBlbvJSjlw9poop5a/Gjzz
   w==;
X-CSE-ConnectionGUID: Ht6diTY3TdOC2SW/qvFqBA==
X-CSE-MsgGUID: BG3Lv6I2Rrik5IniyNPRUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54487388"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54487388"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:55 -0700
X-CSE-ConnectionGUID: HcFKhQ4PRBW/wNMncAMZUA==
X-CSE-MsgGUID: kpdrZ2YAQq2PBWlVgP2qhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155557851"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:53 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v3 3/5] mei: bus: use cldev in prints
Date: Wed,  9 Jul 2025 18:13:42 +0300
Message-ID: <20250709151344.104942-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709151344.104942-1-alexander.usyskin@intel.com>
References: <20250709151344.104942-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For unifomity, print using client device on bus
where possible.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 10 +++++-----
 drivers/misc/mei/bus.c       | 18 +++++++++---------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 9eebeffcd8fd..90dba20b2de7 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -463,14 +463,14 @@ static void mei_nfc(struct mei_cl_device *cldev)
 	if (IS_ERR(cl)) {
 		ret = PTR_ERR(cl);
 		cl = NULL;
-		dev_err(bus->dev, "nfc hook alloc failed %d\n", ret);
+		dev_err(&cldev->dev, "nfc hook alloc failed %d\n", ret);
 		goto out;
 	}
 
 	me_cl = mei_me_cl_by_uuid(bus, &mei_nfc_info_guid);
 	if (!me_cl) {
 		ret = -ENOTTY;
-		dev_err(bus->dev, "Cannot find nfc info %d\n", ret);
+		dev_err(&cldev->dev, "Cannot find nfc info %d\n", ret);
 		goto out;
 	}
 
@@ -496,13 +496,13 @@ static void mei_nfc(struct mei_cl_device *cldev)
 		goto disconnect;
 	}
 
-	dev_dbg(bus->dev, "nfc radio %s\n", radio_name);
+	dev_dbg(&cldev->dev, "nfc radio %s\n", radio_name);
 	strscpy(cldev->name, radio_name, sizeof(cldev->name));
 
 disconnect:
 	mutex_lock(&bus->device_lock);
 	if (mei_cl_disconnect(cl) < 0)
-		dev_err(bus->dev, "Can't disconnect the NFC INFO ME\n");
+		dev_err(&cldev->dev, "Can't disconnect the NFC INFO ME\n");
 
 	mei_cl_flush_queues(cl, NULL);
 
@@ -515,7 +515,7 @@ static void mei_nfc(struct mei_cl_device *cldev)
 	if (ret)
 		cldev->do_match = 0;
 
-	dev_dbg(bus->dev, "end of fixup match = %d\n", cldev->do_match);
+	dev_dbg(&cldev->dev, "end of fixup match = %d\n", cldev->do_match);
 }
 
 /**
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 67176caf5416..d90d830b8261 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -875,14 +875,14 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 	mei_cl_bus_vtag_free(cldev);
 
 	if (!mei_cl_is_connected(cl)) {
-		dev_dbg(bus->dev, "Already disconnected\n");
+		dev_dbg(&cldev->dev, "Already disconnected\n");
 		err = 0;
 		goto out;
 	}
 
 	err = mei_cl_disconnect(cl);
 	if (err < 0)
-		dev_err(bus->dev, "Could not disconnect from the ME client\n");
+		dev_err(&cldev->dev, "Could not disconnect from the ME client\n");
 
 out:
 	/* Flush queues and remove any pending read unless we have mapped DMA */
@@ -935,7 +935,7 @@ ssize_t mei_cldev_send_gsc_command(struct mei_cl_device *cldev,
 	cl = cldev->cl;
 	bus = cldev->bus;
 
-	dev_dbg(bus->dev, "client_id %u, fence_id %u\n", client_id, fence_id);
+	dev_dbg(&cldev->dev, "client_id %u, fence_id %u\n", client_id, fence_id);
 
 	if (!bus->hbm_f_gsc_supported)
 		return -EOPNOTSUPP;
@@ -983,11 +983,11 @@ ssize_t mei_cldev_send_gsc_command(struct mei_cl_device *cldev,
 	/* send the message to GSC */
 	ret = __mei_cl_send(cl, (u8 *)ext_hdr, buf_sz, 0, MEI_CL_IO_SGL);
 	if (ret < 0) {
-		dev_err(bus->dev, "__mei_cl_send failed, returned %zd\n", ret);
+		dev_err(&cldev->dev, "__mei_cl_send failed, returned %zd\n", ret);
 		goto end;
 	}
 	if (ret != buf_sz) {
-		dev_err(bus->dev, "__mei_cl_send returned %zd instead of expected %zd\n",
+		dev_err(&cldev->dev, "__mei_cl_send returned %zd instead of expected %zd\n",
 			ret, buf_sz);
 		ret = -EIO;
 		goto end;
@@ -997,7 +997,7 @@ ssize_t mei_cldev_send_gsc_command(struct mei_cl_device *cldev,
 	ret = __mei_cl_recv(cl, (u8 *)&rx_msg, sizeof(rx_msg), NULL, MEI_CL_IO_SGL, 0);
 
 	if (ret != sizeof(rx_msg)) {
-		dev_err(bus->dev, "__mei_cl_recv returned %zd instead of expected %zd\n",
+		dev_err(&cldev->dev, "__mei_cl_recv returned %zd instead of expected %zd\n",
 			ret, sizeof(rx_msg));
 		if (ret >= 0)
 			ret = -EIO;
@@ -1006,13 +1006,13 @@ ssize_t mei_cldev_send_gsc_command(struct mei_cl_device *cldev,
 
 	/* check rx_msg.client_id and rx_msg.fence_id match the ones we send */
 	if (rx_msg.client_id != client_id || rx_msg.fence_id != fence_id) {
-		dev_err(bus->dev, "received client_id/fence_id  %u/%u  instead of %u/%u sent\n",
+		dev_err(&cldev->dev, "received client_id/fence_id  %u/%u  instead of %u/%u sent\n",
 			rx_msg.client_id, rx_msg.fence_id, client_id, fence_id);
 		ret = -EFAULT;
 		goto end;
 	}
 
-	dev_dbg(bus->dev, "gsc command: successfully written %u bytes\n",  rx_msg.written);
+	dev_dbg(&cldev->dev, "gsc command: successfully written %u bytes\n", rx_msg.written);
 	ret = rx_msg.written;
 
 end:
@@ -1399,7 +1399,7 @@ static int mei_cl_bus_dev_add(struct mei_cl_device *cldev)
 {
 	int ret;
 
-	dev_dbg(cldev->bus->dev, "adding %pUL:%02X\n",
+	dev_dbg(&cldev->dev, "adding %pUL:%02X\n",
 		mei_me_cl_uuid(cldev->me_cl),
 		mei_me_cl_ver(cldev->me_cl));
 	ret = device_add(&cldev->dev);
-- 
2.43.0


