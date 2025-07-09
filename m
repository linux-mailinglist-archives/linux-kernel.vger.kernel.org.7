Return-Path: <linux-kernel+bounces-724030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C63AAFEDBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA53561A73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C12E8892;
	Wed,  9 Jul 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIpUUnwE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BB2E9EBB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074823; cv=none; b=LYEXfR4ys6a5+rPxqcA3aiWLyUQEiOKjrQuavvMGGzRXMsuw+qjxybYplBtklccuC8AQv7evWO2HnqUO7T2kyGFH7mt7HBYiQADDEomFcHZfVNeSevVNooiqJ3MFzz/2eDUNpTPMgTjYL3BUh1/cNGmrcuVHvqVhnjOWaDZSTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074823; c=relaxed/simple;
	bh=tM9CLPpScYeCCW2oLJV3kMsU78uOMFiRt0SCPLEJxdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doYIai8KOKKXPXVAyOr2AuUesaEdCuOx0jUUPZJpuOYRTjulKaaNlTv8wj9TS35MNJ8UCYnJEhSIM81v2TT4NROyX+MWV6QjmH2PqwF0i5/yIvi9HadUTNc5SMfonpcNdAmM5BXdhMUH615jP0rj+W4sdFbIgjq3E9CBOABMBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIpUUnwE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752074820; x=1783610820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tM9CLPpScYeCCW2oLJV3kMsU78uOMFiRt0SCPLEJxdg=;
  b=ZIpUUnwERdTthKbV9N0VW1jwXKSd5NPWwE4y+z4ImJFZc7pVuGbH+h5V
   eUd+n9/9pzalcqf+GS05RwOBf6UdUOKN1mKNM+i7Ej6ZTmtxsJPtfMQAG
   J27CdUEElI4+TXgwspzXbD86KFhy7/EvhKgRThFE4cYvEkapv84Me/SV9
   X1irglzsEsjYOHPPzzBqby4u1EnzevSy1kOxhZTzsN/prPKdVG3LCRTad
   hVlKroUbM63gKqJ1AfR9Qfeq+ehMFn+iGviRqrUzc108dK1BBzrTR7tpK
   SesDLF0bwGeTKSCwM19dtsVCted5mnfXkp8S0d89wb8oYZt6iBsQTOAH1
   g==;
X-CSE-ConnectionGUID: nsPQkaSjRD2UzAzPGtBWBg==
X-CSE-MsgGUID: DkmtVaSPSMOJfVcNGupBzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54487396"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54487396"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:59 -0700
X-CSE-ConnectionGUID: tgGH3uxvR/uXNdK6ZI/bYw==
X-CSE-MsgGUID: NM6g+BxqQCSgtBCoO5I9Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155557878"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:57 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v3 5/5] mei: hook mei_device on class device
Date: Wed,  9 Jul 2025 18:13:44 +0300
Message-ID: <20250709151344.104942-6-alexander.usyskin@intel.com>
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

mei_device lifetime was managed by devm procedure of parent device.
But such memory is freed on device_del.
Mei_device object is used by client object that may be alive after
parent device is removed.
It may lead to use-after-free if discrete graphics driver
unloads mei_gsc auxiliary device while user-space holds
open handle to mei character device.

Connect mei_device structure lifteme to mei class device lifetime
by adding mei_device free to class device remove callback.

Move exising parent device pointer to separate field in mei_device
to avoid misuse.

Leave power management on parent device as we overwrite pci
runtime pm procedure and user-space is expecting it there.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus-fixup.c    |   6 +-
 drivers/misc/mei/bus.c          |  24 ++++---
 drivers/misc/mei/client.c       |  82 +++++++++++-----------
 drivers/misc/mei/client.h       |   6 +-
 drivers/misc/mei/dma-ring.c     |   8 +--
 drivers/misc/mei/gsc-me.c       |  16 ++---
 drivers/misc/mei/hbm.c          | 121 +++++++++++++++-----------------
 drivers/misc/mei/hw-me.c        | 100 +++++++++++++-------------
 drivers/misc/mei/hw-txe.c       |  60 ++++++++--------
 drivers/misc/mei/init.c         |  47 ++++++-------
 drivers/misc/mei/interrupt.c    |  45 ++++++------
 drivers/misc/mei/main.c         |  47 +++++++++----
 drivers/misc/mei/mei_dev.h      |   8 ++-
 drivers/misc/mei/pci-me.c       |  20 +++---
 drivers/misc/mei/pci-txe.c      |   4 +-
 drivers/misc/mei/platform-vsc.c |  26 +++----
 16 files changed, 318 insertions(+), 302 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 90dba20b2de7..e6a1d3534663 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -386,7 +386,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), 0,
 			    MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
-		dev_err(bus->dev, "Could not send IF version cmd ret = %d\n", ret);
+		dev_err(&bus->dev, "Could not send IF version cmd ret = %d\n", ret);
 		return ret;
 	}
 
@@ -401,14 +401,14 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, &vtag,
 				   0, 0);
 	if (bytes_recv < 0 || (size_t)bytes_recv < if_version_length) {
-		dev_err(bus->dev, "Could not read IF version ret = %d\n", bytes_recv);
+		dev_err(&bus->dev, "Could not read IF version ret = %d\n", bytes_recv);
 		ret = -EIO;
 		goto err;
 	}
 
 	memcpy(ver, reply->data, sizeof(*ver));
 
-	dev_info(bus->dev, "NFC MEI VERSION: IVN 0x%x Vendor ID 0x%x Type 0x%x\n",
+	dev_info(&bus->dev, "NFC MEI VERSION: IVN 0x%x Vendor ID 0x%x Type 0x%x\n",
 		 ver->fw_ivn, ver->vendor_id, ver->radio_type);
 
 err:
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index d90d830b8261..00ea20afa15b 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -637,7 +637,7 @@ EXPORT_SYMBOL_GPL(mei_cldev_enabled);
  */
 static bool mei_cl_bus_module_get(struct mei_cl_device *cldev)
 {
-	return try_module_get(cldev->bus->dev->driver->owner);
+	return try_module_get(cldev->bus->parent->driver->owner);
 }
 
 /**
@@ -647,7 +647,7 @@ static bool mei_cl_bus_module_get(struct mei_cl_device *cldev)
  */
 static void mei_cl_bus_module_put(struct mei_cl_device *cldev)
 {
-	module_put(cldev->bus->dev->driver->owner);
+	module_put(cldev->bus->parent->driver->owner);
 }
 
 /**
@@ -1286,16 +1286,20 @@ static const struct bus_type mei_cl_bus_type = {
 
 static struct mei_device *mei_dev_bus_get(struct mei_device *bus)
 {
-	if (bus)
-		get_device(bus->dev);
+	if (bus) {
+		get_device(&bus->dev);
+		get_device(bus->parent);
+	}
 
 	return bus;
 }
 
 static void mei_dev_bus_put(struct mei_device *bus)
 {
-	if (bus)
-		put_device(bus->dev);
+	if (bus) {
+		put_device(bus->parent);
+		put_device(&bus->dev);
+	}
 }
 
 static void mei_cl_bus_dev_release(struct device *dev)
@@ -1323,7 +1327,7 @@ static const struct device_type mei_cl_device_type = {
 static inline void mei_cl_bus_set_name(struct mei_cl_device *cldev)
 {
 	dev_set_name(&cldev->dev, "%s-%pUl",
-		     dev_name(cldev->bus->dev),
+		     dev_name(cldev->bus->parent),
 		     mei_me_cl_uuid(cldev->me_cl));
 }
 
@@ -1352,7 +1356,7 @@ static struct mei_cl_device *mei_cl_bus_dev_alloc(struct mei_device *bus,
 	}
 
 	device_initialize(&cldev->dev);
-	cldev->dev.parent = bus->dev;
+	cldev->dev.parent = bus->parent;
 	cldev->dev.bus    = &mei_cl_bus_type;
 	cldev->dev.type   = &mei_cl_device_type;
 	cldev->bus        = mei_dev_bus_get(bus);
@@ -1487,7 +1491,7 @@ static void mei_cl_bus_dev_init(struct mei_device *bus,
 
 	WARN_ON(!mutex_is_locked(&bus->cl_bus_lock));
 
-	dev_dbg(bus->dev, "initializing %pUl", mei_me_cl_uuid(me_cl));
+	dev_dbg(&bus->dev, "initializing %pUl", mei_me_cl_uuid(me_cl));
 
 	if (me_cl->bus_added)
 		return;
@@ -1538,7 +1542,7 @@ static void mei_cl_bus_rescan(struct mei_device *bus)
 	}
 	mutex_unlock(&bus->cl_bus_lock);
 
-	dev_dbg(bus->dev, "rescan end");
+	dev_dbg(&bus->dev, "rescan end");
 }
 
 void mei_cl_bus_rescan_work(struct work_struct *work)
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 3db07d2a881f..159e8b841564 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -262,7 +262,7 @@ void mei_me_cl_rm_by_uuid(struct mei_device *dev, const uuid_le *uuid)
 {
 	struct mei_me_client *me_cl;
 
-	dev_dbg(dev->dev, "remove %pUl\n", uuid);
+	dev_dbg(&dev->dev, "remove %pUl\n", uuid);
 
 	down_write(&dev->me_clients_rwsem);
 	me_cl = __mei_me_cl_by_uuid(dev, uuid);
@@ -635,12 +635,12 @@ int mei_cl_link(struct mei_cl *cl)
 
 	id = find_first_zero_bit(dev->host_clients_map, MEI_CLIENTS_MAX);
 	if (id >= MEI_CLIENTS_MAX) {
-		dev_err(dev->dev, "id exceeded %d", MEI_CLIENTS_MAX);
+		dev_err(&dev->dev, "id exceeded %d", MEI_CLIENTS_MAX);
 		return -EMFILE;
 	}
 
 	if (dev->open_handle_count >= MEI_MAX_OPEN_HANDLE_COUNT) {
-		dev_err(dev->dev, "open_handle_count exceeded %d",
+		dev_err(&dev->dev, "open_handle_count exceeded %d",
 			MEI_MAX_OPEN_HANDLE_COUNT);
 		return -EMFILE;
 	}
@@ -709,9 +709,9 @@ void mei_host_client_init(struct mei_device *dev)
 
 	schedule_work(&dev->bus_rescan_work);
 
-	pm_runtime_mark_last_busy(dev->dev);
-	dev_dbg(dev->dev, "rpm: autosuspend\n");
-	pm_request_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	dev_dbg(&dev->dev, "rpm: autosuspend\n");
+	pm_request_autosuspend(dev->parent);
 }
 
 /**
@@ -724,12 +724,12 @@ bool mei_hbuf_acquire(struct mei_device *dev)
 {
 	if (mei_pg_state(dev) == MEI_PG_ON ||
 	    mei_pg_in_transition(dev)) {
-		dev_dbg(dev->dev, "device is in pg\n");
+		dev_dbg(&dev->dev, "device is in pg\n");
 		return false;
 	}
 
 	if (!dev->hbuf_is_ready) {
-		dev_dbg(dev->dev, "hbuf is not ready\n");
+		dev_dbg(&dev->dev, "hbuf is not ready\n");
 		return false;
 	}
 
@@ -981,9 +981,9 @@ int mei_cl_disconnect(struct mei_cl *cl)
 		return 0;
 	}
 
-	rets = pm_runtime_get(dev->dev);
+	rets = pm_runtime_get(dev->parent);
 	if (rets < 0 && rets != -EINPROGRESS) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		cl_err(dev, cl, "rpm: get failed %d\n", rets);
 		return rets;
 	}
@@ -991,8 +991,8 @@ int mei_cl_disconnect(struct mei_cl *cl)
 	rets = __mei_cl_disconnect(cl);
 
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_runtime_put_autosuspend(dev->parent);
 
 	return rets;
 }
@@ -1118,9 +1118,9 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 		goto nortpm;
 	}
 
-	rets = pm_runtime_get(dev->dev);
+	rets = pm_runtime_get(dev->parent);
 	if (rets < 0 && rets != -EINPROGRESS) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		cl_err(dev, cl, "rpm: get failed %d\n", rets);
 		goto nortpm;
 	}
@@ -1167,8 +1167,8 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 	rets = cl->status;
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
 
@@ -1517,9 +1517,9 @@ int mei_cl_notify_request(struct mei_cl *cl,
 	if (!mei_cl_is_connected(cl))
 		return -ENODEV;
 
-	rets = pm_runtime_get(dev->dev);
+	rets = pm_runtime_get(dev->parent);
 	if (rets < 0 && rets != -EINPROGRESS) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		cl_err(dev, cl, "rpm: get failed %d\n", rets);
 		return rets;
 	}
@@ -1554,8 +1554,8 @@ int mei_cl_notify_request(struct mei_cl *cl,
 
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
 	return rets;
@@ -1683,9 +1683,9 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
 
 	mei_cl_set_read_by_fp(cl, fp);
 
-	rets = pm_runtime_get(dev->dev);
+	rets = pm_runtime_get(dev->parent);
 	if (rets < 0 && rets != -EINPROGRESS) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		cl_err(dev, cl, "rpm: get failed %d\n", rets);
 		goto nortpm;
 	}
@@ -1702,8 +1702,8 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
 
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_runtime_put_autosuspend(dev->parent);
 nortpm:
 	if (rets)
 		mei_io_cb_free(cb);
@@ -1972,9 +1972,9 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
 	blocking = cb->blocking;
 	data = buf->data;
 
-	rets = pm_runtime_get(dev->dev);
+	rets = pm_runtime_get(dev->parent);
 	if (rets < 0 && rets != -EINPROGRESS) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		cl_err(dev, cl, "rpm: get failed %zd\n", rets);
 		goto free;
 	}
@@ -2092,8 +2092,8 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
 	rets = buf_len;
 err:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_runtime_put_autosuspend(dev->parent);
 free:
 	mei_io_cb_free(cb);
 
@@ -2119,8 +2119,8 @@ void mei_cl_complete(struct mei_cl *cl, struct mei_cl_cb *cb)
 		if (waitqueue_active(&cl->tx_wait)) {
 			wake_up_interruptible(&cl->tx_wait);
 		} else {
-			pm_runtime_mark_last_busy(dev->dev);
-			pm_request_autosuspend(dev->dev);
+			pm_runtime_mark_last_busy(dev->parent);
+			pm_request_autosuspend(dev->parent);
 		}
 		break;
 
@@ -2251,7 +2251,7 @@ int mei_cl_irq_dma_unmap(struct mei_cl *cl, struct mei_cl_cb *cb,
 
 static int mei_cl_dma_alloc(struct mei_cl *cl, u8 buf_id, size_t size)
 {
-	cl->dma.vaddr = dmam_alloc_coherent(cl->dev->dev, size,
+	cl->dma.vaddr = dmam_alloc_coherent(&cl->dev->dev, size,
 					    &cl->dma.daddr, GFP_KERNEL);
 	if (!cl->dma.vaddr)
 		return -ENOMEM;
@@ -2265,7 +2265,7 @@ static int mei_cl_dma_alloc(struct mei_cl *cl, u8 buf_id, size_t size)
 static void mei_cl_dma_free(struct mei_cl *cl)
 {
 	cl->dma.buffer_id = 0;
-	dmam_free_coherent(cl->dev->dev,
+	dmam_free_coherent(&cl->dev->dev,
 			   cl->dma.size, cl->dma.vaddr, cl->dma.daddr);
 	cl->dma.size = 0;
 	cl->dma.vaddr = NULL;
@@ -2321,16 +2321,16 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 		return -EPROTO;
 	}
 
-	rets = pm_runtime_get(dev->dev);
+	rets = pm_runtime_get(dev->parent);
 	if (rets < 0 && rets != -EINPROGRESS) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		cl_err(dev, cl, "rpm: get failed %d\n", rets);
 		return rets;
 	}
 
 	rets = mei_cl_dma_alloc(cl, buffer_id, size);
 	if (rets) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		return rets;
 	}
 
@@ -2366,8 +2366,8 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 		mei_cl_dma_free(cl);
 
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
 	return rets;
@@ -2406,9 +2406,9 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 	if (!cl->dma_mapped)
 		return -EPROTO;
 
-	rets = pm_runtime_get(dev->dev);
+	rets = pm_runtime_get(dev->parent);
 	if (rets < 0 && rets != -EINPROGRESS) {
-		pm_runtime_put_noidle(dev->dev);
+		pm_runtime_put_noidle(dev->parent);
 		cl_err(dev, cl, "rpm: get failed %d\n", rets);
 		return rets;
 	}
@@ -2444,8 +2444,8 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 		mei_cl_dma_free(cl);
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
 	return rets;
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 01ed26a148c4..031114478bcb 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -275,12 +275,12 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp);
 #define MEI_CL_PRM(cl) (cl)->host_client_id, mei_cl_me_id(cl)
 
 #define cl_dbg(dev, cl, format, arg...) \
-	dev_dbg((dev)->dev, MEI_CL_FMT format, MEI_CL_PRM(cl), ##arg)
+	dev_dbg(&(dev)->dev, MEI_CL_FMT format, MEI_CL_PRM(cl), ##arg)
 
 #define cl_warn(dev, cl, format, arg...) \
-	dev_warn((dev)->dev, MEI_CL_FMT format, MEI_CL_PRM(cl), ##arg)
+	dev_warn(&(dev)->dev, MEI_CL_FMT format, MEI_CL_PRM(cl), ##arg)
 
 #define cl_err(dev, cl, format, arg...) \
-	dev_err((dev)->dev, MEI_CL_FMT format, MEI_CL_PRM(cl), ##arg)
+	dev_err(&(dev)->dev, MEI_CL_FMT format, MEI_CL_PRM(cl), ##arg)
 
 #endif /* _MEI_CLIENT_H_ */
diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
index 651e77ef82bd..6277c4a5b0fd 100644
--- a/drivers/misc/mei/dma-ring.c
+++ b/drivers/misc/mei/dma-ring.c
@@ -30,7 +30,7 @@ static int mei_dmam_dscr_alloc(struct mei_device *dev,
 	if (dscr->vaddr)
 		return 0;
 
-	dscr->vaddr = dmam_alloc_coherent(dev->dev, dscr->size, &dscr->daddr,
+	dscr->vaddr = dmam_alloc_coherent(dev->parent, dscr->size, &dscr->daddr,
 					  GFP_KERNEL);
 	if (!dscr->vaddr)
 		return -ENOMEM;
@@ -50,7 +50,7 @@ static void mei_dmam_dscr_free(struct mei_device *dev,
 	if (!dscr->vaddr)
 		return;
 
-	dmam_free_coherent(dev->dev, dscr->size, dscr->vaddr, dscr->daddr);
+	dmam_free_coherent(dev->parent, dscr->size, dscr->vaddr, dscr->daddr);
 	dscr->vaddr = NULL;
 }
 
@@ -177,7 +177,7 @@ void mei_dma_ring_read(struct mei_device *dev, unsigned char *buf, u32 len)
 	if (WARN_ON(!ctrl))
 		return;
 
-	dev_dbg(dev->dev, "reading from dma %u bytes\n", len);
+	dev_dbg(&dev->dev, "reading from dma %u bytes\n", len);
 
 	if (!len)
 		return;
@@ -254,7 +254,7 @@ void mei_dma_ring_write(struct mei_device *dev, unsigned char *buf, u32 len)
 	if (WARN_ON(!ctrl))
 		return;
 
-	dev_dbg(dev->dev, "writing to dma %u bytes\n", len);
+	dev_dbg(&dev->dev, "writing to dma %u bytes\n", len);
 	hbuf_depth = mei_dma_ring_hbuf_depth(dev);
 	wr_idx = READ_ONCE(ctrl->hbuf_wr_idx) & (hbuf_depth - 1);
 	slots = mei_data2slots(len);
diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 5a8c26c3df13..f147258e7c28 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -106,11 +106,15 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 		}
 	}
 
+	ret = mei_register(dev, device);
+	if (ret)
+		goto deinterrupt;
+
 	pm_runtime_get_noresume(device);
 	pm_runtime_set_active(device);
 	pm_runtime_enable(device);
 
-	/* Continue to char device setup in spite of firmware handshake failure.
+	/* Continue in spite of firmware handshake failure.
 	 * In order to provide access to the firmware status registers to the user
 	 * space via sysfs.
 	 */
@@ -120,18 +124,12 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(device);
 
-	ret = mei_register(dev, device);
-	if (ret)
-		goto register_err;
-
 	pm_runtime_put_noidle(device);
 	return 0;
 
-register_err:
-	mei_stop(dev);
+deinterrupt:
 	if (!mei_me_hw_use_polling(hw))
 		devm_free_irq(device, hw->irq, dev);
-
 err:
 	dev_err(device, "probe failed: %d\n", ret);
 	dev_set_drvdata(device, NULL);
@@ -252,7 +250,7 @@ static int __maybe_unused mei_gsc_pm_runtime_resume(struct device *device)
 
 	irq_ret = mei_me_irq_thread_handler(1, dev);
 	if (irq_ret != IRQ_HANDLED)
-		dev_err(dev->dev, "thread handler fail %d\n", irq_ret);
+		dev_err(&dev->dev, "thread handler fail %d\n", irq_ret);
 
 	return 0;
 }
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 4fe9a2752d43..ccd9df5d1c7d 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -239,7 +239,7 @@ int mei_hbm_start_wait(struct mei_device *dev)
 
 	if (ret == 0 && (dev->hbm_state <= MEI_HBM_STARTING)) {
 		dev->hbm_state = MEI_HBM_IDLE;
-		dev_err(dev->dev, "waiting for mei start failed\n");
+		dev_err(&dev->dev, "waiting for mei start failed\n");
 		return -ETIME;
 	}
 	return 0;
@@ -271,8 +271,7 @@ int mei_hbm_start_req(struct mei_device *dev)
 	dev->hbm_state = MEI_HBM_IDLE;
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
-		dev_err(dev->dev, "version message write failed: ret = %d\n",
-			ret);
+		dev_err(&dev->dev, "version message write failed: ret = %d\n", ret);
 		return ret;
 	}
 
@@ -312,8 +311,7 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
-		dev_err(dev->dev, "dma setup request write failed: ret = %d.\n",
-			ret);
+		dev_err(&dev->dev, "dma setup request write failed: ret = %d.\n", ret);
 		return ret;
 	}
 
@@ -351,8 +349,7 @@ static int mei_hbm_capabilities_req(struct mei_device *dev)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
-		dev_err(dev->dev,
-			"capabilities request write failed: ret = %d.\n", ret);
+		dev_err(&dev->dev, "capabilities request write failed: ret = %d.\n", ret);
 		return ret;
 	}
 
@@ -386,8 +383,7 @@ static int mei_hbm_enum_clients_req(struct mei_device *dev)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
-		dev_err(dev->dev, "enumeration request write failed: ret = %d.\n",
-			ret);
+		dev_err(&dev->dev, "enumeration request write failed: ret = %d.\n", ret);
 		return ret;
 	}
 	dev->hbm_state = MEI_HBM_ENUM_CLIENTS;
@@ -443,7 +439,7 @@ static int mei_hbm_add_cl_resp(struct mei_device *dev, u8 addr, u8 status)
 	struct hbm_add_client_response resp;
 	int ret;
 
-	dev_dbg(dev->dev, "adding client response\n");
+	dev_dbg(&dev->dev, "adding client response\n");
 
 	mei_hbm_hdr(&mei_hdr, sizeof(resp));
 
@@ -454,8 +450,7 @@ static int mei_hbm_add_cl_resp(struct mei_device *dev, u8 addr, u8 status)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &resp);
 	if (ret)
-		dev_err(dev->dev, "add client response write failed: ret = %d\n",
-			ret);
+		dev_err(&dev->dev, "add client response write failed: ret = %d\n", ret);
 	return ret;
 }
 
@@ -752,7 +747,7 @@ static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
-		dev_err(dev->dev, "properties request write failed: ret = %d\n",
+		dev_err(&dev->dev, "properties request write failed: ret = %d\n",
 			ret);
 		return ret;
 	}
@@ -788,7 +783,7 @@ int mei_hbm_pg(struct mei_device *dev, u8 pg_cmd)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret)
-		dev_err(dev->dev, "power gate command write failed.\n");
+		dev_err(&dev->dev, "power gate command write failed.\n");
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mei_hbm_pg);
@@ -847,7 +842,7 @@ static int mei_hbm_add_single_tx_flow_ctrl_creds(struct mei_device *dev,
 
 	me_cl = mei_me_cl_by_id(dev, fctrl->me_addr);
 	if (!me_cl) {
-		dev_err(dev->dev, "no such me client %d\n", fctrl->me_addr);
+		dev_err(&dev->dev, "no such me client %d\n", fctrl->me_addr);
 		return -ENOENT;
 	}
 
@@ -857,7 +852,7 @@ static int mei_hbm_add_single_tx_flow_ctrl_creds(struct mei_device *dev,
 	}
 
 	me_cl->tx_flow_ctrl_creds++;
-	dev_dbg(dev->dev, "recv flow ctrl msg ME %d (single) creds = %d.\n",
+	dev_dbg(&dev->dev, "recv flow ctrl msg ME %d (single) creds = %d.\n",
 		fctrl->me_addr, me_cl->tx_flow_ctrl_creds);
 
 	rets = 0;
@@ -1085,7 +1080,7 @@ static int mei_hbm_pg_enter_res(struct mei_device *dev)
 {
 	if (mei_pg_state(dev) != MEI_PG_OFF ||
 	    dev->pg_event != MEI_PG_EVENT_WAIT) {
-		dev_err(dev->dev, "hbm: pg entry response: state mismatch [%s, %d]\n",
+		dev_err(&dev->dev, "hbm: pg entry response: state mismatch [%s, %d]\n",
 			mei_pg_state_str(mei_pg_state(dev)), dev->pg_event);
 		return -EPROTO;
 	}
@@ -1103,7 +1098,7 @@ static int mei_hbm_pg_enter_res(struct mei_device *dev)
  */
 void mei_hbm_pg_resume(struct mei_device *dev)
 {
-	pm_request_resume(dev->dev);
+	pm_request_resume(dev->parent);
 }
 EXPORT_SYMBOL_GPL(mei_hbm_pg_resume);
 
@@ -1119,7 +1114,7 @@ static int mei_hbm_pg_exit_res(struct mei_device *dev)
 	if (mei_pg_state(dev) != MEI_PG_ON ||
 	    (dev->pg_event != MEI_PG_EVENT_WAIT &&
 	     dev->pg_event != MEI_PG_EVENT_IDLE)) {
-		dev_err(dev->dev, "hbm: pg exit response: state mismatch [%s, %d]\n",
+		dev_err(&dev->dev, "hbm: pg exit response: state mismatch [%s, %d]\n",
 			mei_pg_state_str(mei_pg_state(dev)), dev->pg_event);
 		return -EPROTO;
 	}
@@ -1276,19 +1271,19 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 	 * hbm is put to idle during system reset
 	 */
 	if (dev->hbm_state == MEI_HBM_IDLE) {
-		dev_dbg(dev->dev, "hbm: state is idle ignore spurious messages\n");
+		dev_dbg(&dev->dev, "hbm: state is idle ignore spurious messages\n");
 		return 0;
 	}
 
 	switch (mei_msg->hbm_cmd) {
 	case HOST_START_RES_CMD:
-		dev_dbg(dev->dev, "hbm: start: response message received.\n");
+		dev_dbg(&dev->dev, "hbm: start: response message received.\n");
 
 		dev->init_clients_timer = 0;
 
 		version_res = (struct hbm_host_version_response *)mei_msg;
 
-		dev_dbg(dev->dev, "HBM VERSION: DRIVER=%02d:%02d DEVICE=%02d:%02d\n",
+		dev_dbg(&dev->dev, "HBM VERSION: DRIVER=%02d:%02d DEVICE=%02d:%02d\n",
 				HBM_MAJOR_VERSION, HBM_MINOR_VERSION,
 				version_res->me_max_version.major_version,
 				version_res->me_max_version.minor_version);
@@ -1304,11 +1299,11 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		}
 
 		if (!mei_hbm_version_is_supported(dev)) {
-			dev_warn(dev->dev, "hbm: start: version mismatch - stopping the driver.\n");
+			dev_warn(&dev->dev, "hbm: start: version mismatch - stopping the driver.\n");
 
 			dev->hbm_state = MEI_HBM_STOPPED;
 			if (mei_hbm_stop_req(dev)) {
-				dev_err(dev->dev, "hbm: start: failed to send stop request\n");
+				dev_err(&dev->dev, "hbm: start: failed to send stop request\n");
 				return -EIO;
 			}
 			break;
@@ -1320,10 +1315,10 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		    dev->hbm_state != MEI_HBM_STARTING) {
 			if (dev->dev_state == MEI_DEV_POWER_DOWN ||
 			    dev->dev_state == MEI_DEV_POWERING_DOWN) {
-				dev_dbg(dev->dev, "hbm: start: on shutdown, ignoring\n");
+				dev_dbg(&dev->dev, "hbm: start: on shutdown, ignoring\n");
 				return 0;
 			}
-			dev_err(dev->dev, "hbm: start: state mismatch, [%d, %d]\n",
+			dev_err(&dev->dev, "hbm: start: state mismatch, [%d, %d]\n",
 				dev->dev_state, dev->hbm_state);
 			return -EPROTO;
 		}
@@ -1337,7 +1332,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 
 		if (dev->hbm_f_dr_supported) {
 			if (mei_dmam_ring_alloc(dev))
-				dev_info(dev->dev, "running w/o dma ring\n");
+				dev_info(&dev->dev, "running w/o dma ring\n");
 			if (mei_dma_ring_is_allocated(dev)) {
 				if (mei_hbm_dma_setup_req(dev))
 					return -EIO;
@@ -1357,7 +1352,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		break;
 
 	case MEI_HBM_CAPABILITIES_RES_CMD:
-		dev_dbg(dev->dev, "hbm: capabilities response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: capabilities response: message received.\n");
 
 		dev->init_clients_timer = 0;
 
@@ -1365,10 +1360,10 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		    dev->hbm_state != MEI_HBM_CAP_SETUP) {
 			if (dev->dev_state == MEI_DEV_POWER_DOWN ||
 			    dev->dev_state == MEI_DEV_POWERING_DOWN) {
-				dev_dbg(dev->dev, "hbm: capabilities response: on shutdown, ignoring\n");
+				dev_dbg(&dev->dev, "hbm: capabilities response: on shutdown, ignoring\n");
 				return 0;
 			}
-			dev_err(dev->dev, "hbm: capabilities response: state mismatch, [%d, %d]\n",
+			dev_err(&dev->dev, "hbm: capabilities response: state mismatch, [%d, %d]\n",
 				dev->dev_state, dev->hbm_state);
 			return -EPROTO;
 		}
@@ -1384,7 +1379,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 
 		if (dev->hbm_f_dr_supported) {
 			if (mei_dmam_ring_alloc(dev))
-				dev_info(dev->dev, "running w/o dma ring\n");
+				dev_info(&dev->dev, "running w/o dma ring\n");
 			if (mei_dma_ring_is_allocated(dev)) {
 				if (mei_hbm_dma_setup_req(dev))
 					return -EIO;
@@ -1400,7 +1395,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		break;
 
 	case MEI_HBM_DMA_SETUP_RES_CMD:
-		dev_dbg(dev->dev, "hbm: dma setup response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: dma setup response: message received.\n");
 
 		dev->init_clients_timer = 0;
 
@@ -1408,10 +1403,10 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		    dev->hbm_state != MEI_HBM_DR_SETUP) {
 			if (dev->dev_state == MEI_DEV_POWER_DOWN ||
 			    dev->dev_state == MEI_DEV_POWERING_DOWN) {
-				dev_dbg(dev->dev, "hbm: dma setup response: on shutdown, ignoring\n");
+				dev_dbg(&dev->dev, "hbm: dma setup response: on shutdown, ignoring\n");
 				return 0;
 			}
-			dev_err(dev->dev, "hbm: dma setup response: state mismatch, [%d, %d]\n",
+			dev_err(&dev->dev, "hbm: dma setup response: state mismatch, [%d, %d]\n",
 				dev->dev_state, dev->hbm_state);
 			return -EPROTO;
 		}
@@ -1422,9 +1417,9 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 			u8 status = dma_setup_res->status;
 
 			if (status == MEI_HBMS_NOT_ALLOWED) {
-				dev_dbg(dev->dev, "hbm: dma setup not allowed\n");
+				dev_dbg(&dev->dev, "hbm: dma setup not allowed\n");
 			} else {
-				dev_info(dev->dev, "hbm: dma setup response: failure = %d %s\n",
+				dev_info(&dev->dev, "hbm: dma setup response: failure = %d %s\n",
 					 status,
 					 mei_hbm_status_str(status));
 			}
@@ -1437,38 +1432,38 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		break;
 
 	case CLIENT_CONNECT_RES_CMD:
-		dev_dbg(dev->dev, "hbm: client connect response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: client connect response: message received.\n");
 		mei_hbm_cl_res(dev, cl_cmd, MEI_FOP_CONNECT);
 		break;
 
 	case CLIENT_DISCONNECT_RES_CMD:
-		dev_dbg(dev->dev, "hbm: client disconnect response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: client disconnect response: message received.\n");
 		mei_hbm_cl_res(dev, cl_cmd, MEI_FOP_DISCONNECT);
 		break;
 
 	case MEI_FLOW_CONTROL_CMD:
-		dev_dbg(dev->dev, "hbm: client flow control response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: client flow control response: message received.\n");
 
 		fctrl = (struct hbm_flow_control *)mei_msg;
 		mei_hbm_cl_tx_flow_ctrl_creds_res(dev, fctrl);
 		break;
 
 	case MEI_PG_ISOLATION_ENTRY_RES_CMD:
-		dev_dbg(dev->dev, "hbm: power gate isolation entry response received\n");
+		dev_dbg(&dev->dev, "hbm: power gate isolation entry response received\n");
 		ret = mei_hbm_pg_enter_res(dev);
 		if (ret)
 			return ret;
 		break;
 
 	case MEI_PG_ISOLATION_EXIT_REQ_CMD:
-		dev_dbg(dev->dev, "hbm: power gate isolation exit request received\n");
+		dev_dbg(&dev->dev, "hbm: power gate isolation exit request received\n");
 		ret = mei_hbm_pg_exit_res(dev);
 		if (ret)
 			return ret;
 		break;
 
 	case HOST_CLIENT_PROPERTIES_RES_CMD:
-		dev_dbg(dev->dev, "hbm: properties response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: properties response: message received.\n");
 
 		dev->init_clients_timer = 0;
 
@@ -1476,10 +1471,10 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		    dev->hbm_state != MEI_HBM_CLIENT_PROPERTIES) {
 			if (dev->dev_state == MEI_DEV_POWER_DOWN ||
 			    dev->dev_state == MEI_DEV_POWERING_DOWN) {
-				dev_dbg(dev->dev, "hbm: properties response: on shutdown, ignoring\n");
+				dev_dbg(&dev->dev, "hbm: properties response: on shutdown, ignoring\n");
 				return 0;
 			}
-			dev_err(dev->dev, "hbm: properties response: state mismatch, [%d, %d]\n",
+			dev_err(&dev->dev, "hbm: properties response: state mismatch, [%d, %d]\n",
 				dev->dev_state, dev->hbm_state);
 			return -EPROTO;
 		}
@@ -1487,10 +1482,10 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		props_res = (struct hbm_props_response *)mei_msg;
 
 		if (props_res->status == MEI_HBMS_CLIENT_NOT_FOUND) {
-			dev_dbg(dev->dev, "hbm: properties response: %d CLIENT_NOT_FOUND\n",
+			dev_dbg(&dev->dev, "hbm: properties response: %d CLIENT_NOT_FOUND\n",
 				props_res->me_addr);
 		} else if (props_res->status) {
-			dev_err(dev->dev, "hbm: properties response: wrong status = %d %s\n",
+			dev_err(&dev->dev, "hbm: properties response: wrong status = %d %s\n",
 				props_res->status,
 				mei_hbm_status_str(props_res->status));
 			return -EPROTO;
@@ -1505,7 +1500,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		break;
 
 	case HOST_ENUM_RES_CMD:
-		dev_dbg(dev->dev, "hbm: enumeration response: message received\n");
+		dev_dbg(&dev->dev, "hbm: enumeration response: message received\n");
 
 		dev->init_clients_timer = 0;
 
@@ -1519,10 +1514,10 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		    dev->hbm_state != MEI_HBM_ENUM_CLIENTS) {
 			if (dev->dev_state == MEI_DEV_POWER_DOWN ||
 			    dev->dev_state == MEI_DEV_POWERING_DOWN) {
-				dev_dbg(dev->dev, "hbm: enumeration response: on shutdown, ignoring\n");
+				dev_dbg(&dev->dev, "hbm: enumeration response: on shutdown, ignoring\n");
 				return 0;
 			}
-			dev_err(dev->dev, "hbm: enumeration response: state mismatch, [%d, %d]\n",
+			dev_err(&dev->dev, "hbm: enumeration response: state mismatch, [%d, %d]\n",
 				dev->dev_state, dev->hbm_state);
 			return -EPROTO;
 		}
@@ -1536,77 +1531,77 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		break;
 
 	case HOST_STOP_RES_CMD:
-		dev_dbg(dev->dev, "hbm: stop response: message received\n");
+		dev_dbg(&dev->dev, "hbm: stop response: message received\n");
 
 		dev->init_clients_timer = 0;
 
 		if (dev->hbm_state != MEI_HBM_STOPPED) {
-			dev_err(dev->dev, "hbm: stop response: state mismatch, [%d, %d]\n",
+			dev_err(&dev->dev, "hbm: stop response: state mismatch, [%d, %d]\n",
 				dev->dev_state, dev->hbm_state);
 			return -EPROTO;
 		}
 
 		mei_set_devstate(dev, MEI_DEV_POWER_DOWN);
-		dev_info(dev->dev, "hbm: stop response: resetting.\n");
+		dev_info(&dev->dev, "hbm: stop response: resetting.\n");
 		/* force the reset */
 		return -EPROTO;
 
 	case CLIENT_DISCONNECT_REQ_CMD:
-		dev_dbg(dev->dev, "hbm: disconnect request: message received\n");
+		dev_dbg(&dev->dev, "hbm: disconnect request: message received\n");
 
 		disconnect_req = (struct hbm_client_connect_request *)mei_msg;
 		mei_hbm_fw_disconnect_req(dev, disconnect_req);
 		break;
 
 	case ME_STOP_REQ_CMD:
-		dev_dbg(dev->dev, "hbm: stop request: message received\n");
+		dev_dbg(&dev->dev, "hbm: stop request: message received\n");
 		dev->hbm_state = MEI_HBM_STOPPED;
 		if (mei_hbm_stop_req(dev)) {
-			dev_err(dev->dev, "hbm: stop request: failed to send stop request\n");
+			dev_err(&dev->dev, "hbm: stop request: failed to send stop request\n");
 			return -EIO;
 		}
 		break;
 
 	case MEI_HBM_ADD_CLIENT_REQ_CMD:
-		dev_dbg(dev->dev, "hbm: add client request received\n");
+		dev_dbg(&dev->dev, "hbm: add client request received\n");
 		/*
 		 * after the host receives the enum_resp
 		 * message clients may be added or removed
 		 */
 		if (dev->hbm_state <= MEI_HBM_ENUM_CLIENTS ||
 		    dev->hbm_state >= MEI_HBM_STOPPED) {
-			dev_err(dev->dev, "hbm: add client: state mismatch, [%d, %d]\n",
+			dev_err(&dev->dev, "hbm: add client: state mismatch, [%d, %d]\n",
 				dev->dev_state, dev->hbm_state);
 			return -EPROTO;
 		}
 		add_cl_req = (struct hbm_add_client_request *)mei_msg;
 		ret = mei_hbm_fw_add_cl_req(dev, add_cl_req);
 		if (ret) {
-			dev_err(dev->dev, "hbm: add client: failed to send response %d\n",
+			dev_err(&dev->dev, "hbm: add client: failed to send response %d\n",
 				ret);
 			return -EIO;
 		}
-		dev_dbg(dev->dev, "hbm: add client request processed\n");
+		dev_dbg(&dev->dev, "hbm: add client request processed\n");
 		break;
 
 	case MEI_HBM_NOTIFY_RES_CMD:
-		dev_dbg(dev->dev, "hbm: notify response received\n");
+		dev_dbg(&dev->dev, "hbm: notify response received\n");
 		mei_hbm_cl_res(dev, cl_cmd, notify_res_to_fop(cl_cmd));
 		break;
 
 	case MEI_HBM_NOTIFICATION_CMD:
-		dev_dbg(dev->dev, "hbm: notification\n");
+		dev_dbg(&dev->dev, "hbm: notification\n");
 		mei_hbm_cl_notify(dev, cl_cmd);
 		break;
 
 	case MEI_HBM_CLIENT_DMA_MAP_RES_CMD:
-		dev_dbg(dev->dev, "hbm: client dma map response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: client dma map response: message received.\n");
 		client_dma_res = (struct hbm_client_dma_response *)mei_msg;
 		mei_hbm_cl_dma_map_res(dev, client_dma_res);
 		break;
 
 	case MEI_HBM_CLIENT_DMA_UNMAP_RES_CMD:
-		dev_dbg(dev->dev, "hbm: client dma unmap response: message received.\n");
+		dev_dbg(&dev->dev, "hbm: client dma unmap response: message received.\n");
 		client_dma_res = (struct hbm_client_dma_response *)mei_msg;
 		mei_hbm_cl_dma_unmap_res(dev, client_dma_res);
 		break;
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index d11a0740b47c..346633ebc6e6 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -84,7 +84,7 @@ static inline u32 mei_me_mecsr_read(const struct mei_device *dev)
 	u32 reg;
 
 	reg = mei_me_reg_read(to_me_hw(dev), ME_CSR_HA);
-	trace_mei_reg_read(dev->dev, "ME_CSR_HA", ME_CSR_HA, reg);
+	trace_mei_reg_read(&dev->dev, "ME_CSR_HA", ME_CSR_HA, reg);
 
 	return reg;
 }
@@ -101,7 +101,7 @@ static inline u32 mei_hcsr_read(const struct mei_device *dev)
 	u32 reg;
 
 	reg = mei_me_reg_read(to_me_hw(dev), H_CSR);
-	trace_mei_reg_read(dev->dev, "H_CSR", H_CSR, reg);
+	trace_mei_reg_read(&dev->dev, "H_CSR", H_CSR, reg);
 
 	return reg;
 }
@@ -114,7 +114,7 @@ static inline u32 mei_hcsr_read(const struct mei_device *dev)
  */
 static inline void mei_hcsr_write(struct mei_device *dev, u32 reg)
 {
-	trace_mei_reg_write(dev->dev, "H_CSR", H_CSR, reg);
+	trace_mei_reg_write(&dev->dev, "H_CSR", H_CSR, reg);
 	mei_me_reg_write(to_me_hw(dev), H_CSR, reg);
 }
 
@@ -156,7 +156,7 @@ static inline u32 mei_me_d0i3c_read(const struct mei_device *dev)
 	u32 reg;
 
 	reg = mei_me_reg_read(to_me_hw(dev), H_D0I3C);
-	trace_mei_reg_read(dev->dev, "H_D0I3C", H_D0I3C, reg);
+	trace_mei_reg_read(&dev->dev, "H_D0I3C", H_D0I3C, reg);
 
 	return reg;
 }
@@ -169,7 +169,7 @@ static inline u32 mei_me_d0i3c_read(const struct mei_device *dev)
  */
 static inline void mei_me_d0i3c_write(struct mei_device *dev, u32 reg)
 {
-	trace_mei_reg_write(dev->dev, "H_D0I3C", H_D0I3C, reg);
+	trace_mei_reg_write(&dev->dev, "H_D0I3C", H_D0I3C, reg);
 	mei_me_reg_write(to_me_hw(dev), H_D0I3C, reg);
 }
 
@@ -189,7 +189,7 @@ static int mei_me_trc_status(struct mei_device *dev, u32 *trc)
 		return -EOPNOTSUPP;
 
 	*trc = mei_me_reg_read(hw, ME_TRC);
-	trace_mei_reg_read(dev->dev, "ME_TRC", ME_TRC, *trc);
+	trace_mei_reg_read(&dev->dev, "ME_TRC", ME_TRC, *trc);
 
 	return 0;
 }
@@ -217,7 +217,7 @@ static int mei_me_fw_status(struct mei_device *dev,
 	for (i = 0; i < fw_src->count && i < MEI_FW_STATUS_MAX; i++) {
 		ret = hw->read_fws(dev, fw_src->status[i],
 				   &fw_status->status[i]);
-		trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_X",
+		trace_mei_pci_cfg_read(&dev->dev, "PCI_CFG_HFS_X",
 				       fw_src->status[i],
 				       fw_status->status[i]);
 		if (ret)
@@ -251,7 +251,7 @@ static int mei_me_hw_config(struct mei_device *dev)
 
 	reg = 0;
 	hw->read_fws(dev, PCI_CFG_HFS_1, &reg);
-	trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_1", PCI_CFG_HFS_1, reg);
+	trace_mei_pci_cfg_read(&dev->dev, "PCI_CFG_HFS_1", PCI_CFG_HFS_1, reg);
 	hw->d0i3_supported =
 		((reg & PCI_CFG_HFS_1_D0I3_MSK) == PCI_CFG_HFS_1_D0I3_MSK);
 
@@ -447,7 +447,7 @@ static void mei_gsc_pxp_check(struct mei_device *dev)
 		return;
 
 	hw->read_fws(dev, PCI_CFG_HFS_5, &fwsts5);
-	trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_5", PCI_CFG_HFS_5, fwsts5);
+	trace_mei_pci_cfg_read(&dev->dev, "PCI_CFG_HFS_5", PCI_CFG_HFS_5, fwsts5);
 
 	if ((fwsts5 & GSC_CFG_HFS_5_BOOT_TYPE_MSK) == GSC_CFG_HFS_5_BOOT_TYPE_PXP) {
 		if (dev->gsc_reset_to_pxp == MEI_DEV_RESET_TO_PXP_DEFAULT)
@@ -460,10 +460,10 @@ static void mei_gsc_pxp_check(struct mei_device *dev)
 		return;
 
 	if ((fwsts5 & GSC_CFG_HFS_5_BOOT_TYPE_MSK) == GSC_CFG_HFS_5_BOOT_TYPE_PXP) {
-		dev_dbg(dev->dev, "pxp mode is ready 0x%08x\n", fwsts5);
+		dev_dbg(&dev->dev, "pxp mode is ready 0x%08x\n", fwsts5);
 		dev->pxp_mode = MEI_DEV_PXP_READY;
 	} else {
-		dev_dbg(dev->dev, "pxp mode is not ready 0x%08x\n", fwsts5);
+		dev_dbg(&dev->dev, "pxp mode is not ready 0x%08x\n", fwsts5);
 	}
 }
 
@@ -482,7 +482,7 @@ static int mei_me_hw_ready_wait(struct mei_device *dev)
 			dev->timeouts.hw_ready);
 	mutex_lock(&dev->device_lock);
 	if (!dev->recvd_hw_ready) {
-		dev_err(dev->dev, "wait hw ready failed\n");
+		dev_err(&dev->dev, "wait hw ready failed\n");
 		return -ETIME;
 	}
 
@@ -516,12 +516,12 @@ static void mei_me_check_fw_reset(struct mei_device *dev)
 			    fw_pm_event != PCI_CFG_HFS_2_PM_CM_RESET_ERROR)
 				goto end;
 		} else {
-			dev_err(dev->dev, "failed to read firmware status: %d\n", ret);
+			dev_err(&dev->dev, "failed to read firmware status: %d\n", ret);
 		}
 	}
 
 	mei_fw_status2str(&dev->saved_fw_status, fw_sts_str, sizeof(fw_sts_str));
-	dev_warn(dev->dev, "unexpected reset: fw_pm_event = 0x%x, dev_state = %u fw status = %s\n",
+	dev_warn(&dev->dev, "unexpected reset: fw_pm_event = 0x%x, dev_state = %u fw status = %s\n",
 		 fw_pm_event, dev->saved_dev_state, fw_sts_str);
 
 end:
@@ -544,7 +544,7 @@ static int mei_me_hw_start(struct mei_device *dev)
 		mei_me_check_fw_reset(dev);
 	if (ret)
 		return ret;
-	dev_dbg(dev->dev, "hw is ready\n");
+	dev_dbg(&dev->dev, "hw is ready\n");
 
 	mei_me_host_set_ready(dev);
 	return ret;
@@ -644,14 +644,14 @@ static int mei_me_hbuf_write(struct mei_device *dev,
 		return -EINVAL;
 
 	if (!data && data_len) {
-		dev_err(dev->dev, "wrong parameters null data with data_len = %zu\n", data_len);
+		dev_err(&dev->dev, "wrong parameters null data with data_len = %zu\n", data_len);
 		return -EINVAL;
 	}
 
-	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
+	dev_dbg(&dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
 
 	empty_slots = mei_hbuf_empty_slots(dev);
-	dev_dbg(dev->dev, "empty slots = %d.\n", empty_slots);
+	dev_dbg(&dev->dev, "empty slots = %d.\n", empty_slots);
 
 	if (empty_slots < 0)
 		return -EOVERFLOW;
@@ -706,7 +706,7 @@ static int mei_me_count_full_read_slots(struct mei_device *dev)
 	if (filled_slots > buffer_depth)
 		return -EOVERFLOW;
 
-	dev_dbg(dev->dev, "filled_slots =%08x\n", filled_slots);
+	dev_dbg(&dev->dev, "filled_slots =%08x\n", filled_slots);
 	return (int)filled_slots;
 }
 
@@ -748,11 +748,11 @@ static void mei_me_pg_set(struct mei_device *dev)
 	u32 reg;
 
 	reg = mei_me_reg_read(hw, H_HPG_CSR);
-	trace_mei_reg_read(dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
+	trace_mei_reg_read(&dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
 
 	reg |= H_HPG_CSR_PGI;
 
-	trace_mei_reg_write(dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
+	trace_mei_reg_write(&dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
 	mei_me_reg_write(hw, H_HPG_CSR, reg);
 }
 
@@ -767,13 +767,13 @@ static void mei_me_pg_unset(struct mei_device *dev)
 	u32 reg;
 
 	reg = mei_me_reg_read(hw, H_HPG_CSR);
-	trace_mei_reg_read(dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
+	trace_mei_reg_read(&dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
 
 	WARN(!(reg & H_HPG_CSR_PGI), "PGI is not set\n");
 
 	reg |= H_HPG_CSR_PGIHEXR;
 
-	trace_mei_reg_write(dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
+	trace_mei_reg_write(&dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
 	mei_me_reg_write(hw, H_HPG_CSR, reg);
 }
 
@@ -905,7 +905,7 @@ static bool mei_me_pg_is_enabled(struct mei_device *dev)
 	return true;
 
 notsupported:
-	dev_dbg(dev->dev, "pg: not supported: d0i3 = %d HGP = %d hbm version %d.%d ?= %d.%d\n",
+	dev_dbg(&dev->dev, "pg: not supported: d0i3 = %d HGP = %d hbm version %d.%d ?= %d.%d\n",
 		hw->d0i3_supported,
 		!!(reg & ME_PGIC_HRA),
 		dev->version.major_version,
@@ -974,7 +974,7 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
 	reg = mei_me_d0i3c_read(dev);
 	if (reg & H_D0I3C_I3) {
 		/* we are in d0i3, nothing to do */
-		dev_dbg(dev->dev, "d0i3 set not needed\n");
+		dev_dbg(&dev->dev, "d0i3 set not needed\n");
 		ret = 0;
 		goto on;
 	}
@@ -1003,7 +1003,7 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
 
 	reg = mei_me_d0i3_set(dev, true);
 	if (!(reg & H_D0I3C_CIP)) {
-		dev_dbg(dev->dev, "d0i3 enter wait not needed\n");
+		dev_dbg(&dev->dev, "d0i3 enter wait not needed\n");
 		ret = 0;
 		goto on;
 	}
@@ -1027,7 +1027,7 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
 	hw->pg_state = MEI_PG_ON;
 out:
 	dev->pg_event = MEI_PG_EVENT_IDLE;
-	dev_dbg(dev->dev, "d0i3 enter ret = %d\n", ret);
+	dev_dbg(&dev->dev, "d0i3 enter ret = %d\n", ret);
 	return ret;
 }
 
@@ -1049,7 +1049,7 @@ static int mei_me_d0i3_enter(struct mei_device *dev)
 	reg = mei_me_d0i3c_read(dev);
 	if (reg & H_D0I3C_I3) {
 		/* we are in d0i3, nothing to do */
-		dev_dbg(dev->dev, "already d0i3 : set not needed\n");
+		dev_dbg(&dev->dev, "already d0i3 : set not needed\n");
 		goto on;
 	}
 
@@ -1057,7 +1057,7 @@ static int mei_me_d0i3_enter(struct mei_device *dev)
 on:
 	hw->pg_state = MEI_PG_ON;
 	dev->pg_event = MEI_PG_EVENT_IDLE;
-	dev_dbg(dev->dev, "d0i3 enter\n");
+	dev_dbg(&dev->dev, "d0i3 enter\n");
 	return 0;
 }
 
@@ -1079,14 +1079,14 @@ static int mei_me_d0i3_exit_sync(struct mei_device *dev)
 	reg = mei_me_d0i3c_read(dev);
 	if (!(reg & H_D0I3C_I3)) {
 		/* we are not in d0i3, nothing to do */
-		dev_dbg(dev->dev, "d0i3 exit not needed\n");
+		dev_dbg(&dev->dev, "d0i3 exit not needed\n");
 		ret = 0;
 		goto off;
 	}
 
 	reg = mei_me_d0i3_unset(dev);
 	if (!(reg & H_D0I3C_CIP)) {
-		dev_dbg(dev->dev, "d0i3 exit wait not needed\n");
+		dev_dbg(&dev->dev, "d0i3 exit wait not needed\n");
 		ret = 0;
 		goto off;
 	}
@@ -1111,7 +1111,7 @@ static int mei_me_d0i3_exit_sync(struct mei_device *dev)
 out:
 	dev->pg_event = MEI_PG_EVENT_IDLE;
 
-	dev_dbg(dev->dev, "d0i3 exit ret = %d\n", ret);
+	dev_dbg(&dev->dev, "d0i3 exit ret = %d\n", ret);
 	return ret;
 }
 
@@ -1154,7 +1154,7 @@ static void mei_me_d0i3_intr(struct mei_device *dev, u32 intr_source)
 				 * force H_RDY because it could be
 				 * wiped off during PG
 				 */
-				dev_dbg(dev->dev, "d0i3 set host ready\n");
+				dev_dbg(&dev->dev, "d0i3 set host ready\n");
 				mei_me_host_set_ready(dev);
 			}
 		} else {
@@ -1170,7 +1170,7 @@ static void mei_me_d0i3_intr(struct mei_device *dev, u32 intr_source)
 		 * we got here because of HW initiated exit from D0i3.
 		 * Start runtime pm resume sequence to exit low power state.
 		 */
-		dev_dbg(dev->dev, "d0i3 want resume\n");
+		dev_dbg(&dev->dev, "d0i3 want resume\n");
 		mei_hbm_pg_resume(dev);
 	}
 }
@@ -1250,7 +1250,7 @@ static int mei_me_hw_reset(struct mei_device *dev, bool intr_enable)
 		}
 	}
 
-	pm_runtime_set_active(dev->dev);
+	pm_runtime_set_active(dev->parent);
 
 	hcsr = mei_hcsr_read(dev);
 	/* H_RST may be found lit before reset is started,
@@ -1259,7 +1259,7 @@ static int mei_me_hw_reset(struct mei_device *dev, bool intr_enable)
 	 * we need to clean H_RST bit to start a successful reset sequence.
 	 */
 	if ((hcsr & H_RST) == H_RST) {
-		dev_warn(dev->dev, "H_RST is set = 0x%08X", hcsr);
+		dev_warn(&dev->dev, "H_RST is set = 0x%08X", hcsr);
 		hcsr &= ~H_RST;
 		mei_hcsr_set(dev, hcsr);
 		hcsr = mei_hcsr_read(dev);
@@ -1280,10 +1280,10 @@ static int mei_me_hw_reset(struct mei_device *dev, bool intr_enable)
 	hcsr = mei_hcsr_read(dev);
 
 	if ((hcsr & H_RST) == 0)
-		dev_warn(dev->dev, "H_RST is not set = 0x%08X", hcsr);
+		dev_warn(&dev->dev, "H_RST is not set = 0x%08X", hcsr);
 
 	if ((hcsr & H_RDY) == H_RDY)
-		dev_warn(dev->dev, "H_RDY is not cleared 0x%08X", hcsr);
+		dev_warn(&dev->dev, "H_RDY is not cleared 0x%08X", hcsr);
 
 	if (!intr_enable) {
 		mei_me_hw_reset_release(dev);
@@ -1313,7 +1313,7 @@ irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id)
 	if (!me_intr_src(hcsr))
 		return IRQ_NONE;
 
-	dev_dbg(dev->dev, "interrupt source 0x%08X\n", me_intr_src(hcsr));
+	dev_dbg(&dev->dev, "interrupt source 0x%08X\n", me_intr_src(hcsr));
 
 	/* disable interrupts on device */
 	me_intr_disable(dev, hcsr);
@@ -1339,7 +1339,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	u32 hcsr;
 	int rets = 0;
 
-	dev_dbg(dev->dev, "function called after ISR to handle the interrupt processing.\n");
+	dev_dbg(&dev->dev, "function called after ISR to handle the interrupt processing.\n");
 	/* initialize our complete list */
 	mutex_lock(&dev->device_lock);
 
@@ -1351,10 +1351,10 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	/* check if ME wants a reset */
 	if (!mei_hw_is_ready(dev) && dev->dev_state != MEI_DEV_RESETTING) {
 		if (kind_is_gsc(dev) || kind_is_gscfi(dev)) {
-			dev_dbg(dev->dev, "FW not ready: resetting: dev_state = %d\n",
+			dev_dbg(&dev->dev, "FW not ready: resetting: dev_state = %d\n",
 				dev->dev_state);
 		} else {
-			dev_warn(dev->dev, "FW not ready: resetting: dev_state = %d\n",
+			dev_warn(&dev->dev, "FW not ready: resetting: dev_state = %d\n",
 				 dev->dev_state);
 		}
 		if (dev->dev_state == MEI_DEV_POWERING_DOWN ||
@@ -1373,18 +1373,18 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	/*  check if we need to start the dev */
 	if (!mei_host_is_ready(dev)) {
 		if (mei_hw_is_ready(dev)) {
-			dev_dbg(dev->dev, "we need to start the dev.\n");
+			dev_dbg(&dev->dev, "we need to start the dev.\n");
 			dev->recvd_hw_ready = true;
 			wake_up(&dev->wait_hw_ready);
 		} else {
-			dev_dbg(dev->dev, "Spurious Interrupt\n");
+			dev_dbg(&dev->dev, "Spurious Interrupt\n");
 		}
 		goto end;
 	}
 	/* check slots available for reading */
 	slots = mei_count_full_read_slots(dev);
 	while (slots > 0) {
-		dev_dbg(dev->dev, "slots to read = %08x\n", slots);
+		dev_dbg(&dev->dev, "slots to read = %08x\n", slots);
 		rets = mei_irq_read_handler(dev, &cmpl_list, &slots);
 		/* There is a race between ME write and interrupt delivery:
 		 * Not all data is always available immediately after the
@@ -1394,7 +1394,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 			break;
 
 		if (rets) {
-			dev_err(dev->dev, "mei_irq_read_handler ret = %d, state = %d.\n",
+			dev_err(&dev->dev, "mei_irq_read_handler ret = %d, state = %d.\n",
 				rets, dev->dev_state);
 			if (dev->dev_state != MEI_DEV_RESETTING &&
 			    dev->dev_state != MEI_DEV_DISABLED &&
@@ -1421,7 +1421,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	mei_irq_compl_handler(dev, &cmpl_list);
 
 end:
-	dev_dbg(dev->dev, "interrupt thread end ret = %d\n", rets);
+	dev_dbg(&dev->dev, "interrupt thread end ret = %d\n", rets);
 	mei_me_intr_enable(dev);
 	mutex_unlock(&dev->device_lock);
 	return IRQ_HANDLED;
@@ -1453,7 +1453,7 @@ int mei_me_polling_thread(void *_dev)
 	irqreturn_t irq_ret;
 	long polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
 
-	dev_dbg(dev->dev, "kernel thread is running\n");
+	dev_dbg(&dev->dev, "kernel thread is running\n");
 	while (!kthread_should_stop()) {
 		struct mei_me_hw *hw = to_me_hw(dev);
 		u32 hcsr;
@@ -1470,7 +1470,7 @@ int mei_me_polling_thread(void *_dev)
 			polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
 			irq_ret = mei_me_irq_thread_handler(1, dev);
 			if (irq_ret != IRQ_HANDLED)
-				dev_err(dev->dev, "irq_ret %d\n", irq_ret);
+				dev_err(&dev->dev, "irq_ret %d\n", irq_ret);
 		} else {
 			/*
 			 * Increase timeout by MEI_POLLING_TIMEOUT_ACTIVE
@@ -1804,7 +1804,7 @@ struct mei_device *mei_me_dev_init(struct device *parent,
 	struct mei_me_hw *hw;
 	int i;
 
-	dev = devm_kzalloc(parent, sizeof(*dev) + sizeof(*hw), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev) + sizeof(*hw), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index e9476f9ae25d..e4688c391027 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -160,7 +160,7 @@ static bool mei_txe_aliveness_set(struct mei_device *dev, u32 req)
 	struct mei_txe_hw *hw = to_txe_hw(dev);
 	bool do_req = hw->aliveness != req;
 
-	dev_dbg(dev->dev, "Aliveness current=%d request=%d\n",
+	dev_dbg(&dev->dev, "Aliveness current=%d request=%d\n",
 				hw->aliveness, req);
 	if (do_req) {
 		dev->pg_event = MEI_PG_EVENT_WAIT;
@@ -227,7 +227,7 @@ static int mei_txe_aliveness_poll(struct mei_device *dev, u32 expected)
 		hw->aliveness = mei_txe_aliveness_get(dev);
 		if (hw->aliveness == expected) {
 			dev->pg_event = MEI_PG_EVENT_IDLE;
-			dev_dbg(dev->dev, "aliveness settled after %lld usecs\n",
+			dev_dbg(&dev->dev, "aliveness settled after %lld usecs\n",
 				ktime_to_us(ktime_sub(ktime_get(), start)));
 			return 0;
 		}
@@ -235,7 +235,7 @@ static int mei_txe_aliveness_poll(struct mei_device *dev, u32 expected)
 	} while (ktime_before(ktime_get(), stop));
 
 	dev->pg_event = MEI_PG_EVENT_IDLE;
-	dev_err(dev->dev, "aliveness timed out\n");
+	dev_err(&dev->dev, "aliveness timed out\n");
 	return -ETIME;
 }
 
@@ -270,10 +270,10 @@ static int mei_txe_aliveness_wait(struct mei_device *dev, u32 expected)
 	ret = hw->aliveness == expected ? 0 : -ETIME;
 
 	if (ret)
-		dev_warn(dev->dev, "aliveness timed out = %ld aliveness = %d event = %d\n",
+		dev_warn(&dev->dev, "aliveness timed out = %ld aliveness = %d event = %d\n",
 			err, hw->aliveness, dev->pg_event);
 	else
-		dev_dbg(dev->dev, "aliveness settled after = %d msec aliveness = %d event = %d\n",
+		dev_dbg(&dev->dev, "aliveness settled after = %d msec aliveness = %d event = %d\n",
 			jiffies_to_msecs(timeout - err),
 			hw->aliveness, dev->pg_event);
 
@@ -438,7 +438,7 @@ static void mei_txe_intr_enable(struct mei_device *dev)
  */
 static void mei_txe_synchronize_irq(struct mei_device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
 
 	synchronize_irq(pdev->irq);
 }
@@ -464,7 +464,7 @@ static bool mei_txe_pending_interrupts(struct mei_device *dev)
 				      TXE_INTR_OUT_DB));
 
 	if (ret) {
-		dev_dbg(dev->dev,
+		dev_dbg(&dev->dev,
 			"Pending Interrupts InReady=%01d Readiness=%01d, Aliveness=%01d, OutDoor=%01d\n",
 			!!(hw->intr_cause & TXE_INTR_IN_READY),
 			!!(hw->intr_cause & TXE_INTR_READINESS),
@@ -612,7 +612,7 @@ static int mei_txe_readiness_wait(struct mei_device *dev)
 			msecs_to_jiffies(SEC_RESET_WAIT_TIMEOUT));
 	mutex_lock(&dev->device_lock);
 	if (!dev->recvd_hw_ready) {
-		dev_err(dev->dev, "wait for readiness failed\n");
+		dev_err(&dev->dev, "wait for readiness failed\n");
 		return -ETIME;
 	}
 
@@ -638,7 +638,7 @@ static int mei_txe_fw_status(struct mei_device *dev,
 			     struct mei_fw_status *fw_status)
 {
 	const struct mei_fw_status *fw_src = &mei_txe_fw_sts;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
 	int ret;
 	int i;
 
@@ -649,7 +649,7 @@ static int mei_txe_fw_status(struct mei_device *dev,
 	for (i = 0; i < fw_src->count && i < MEI_FW_STATUS_MAX; i++) {
 		ret = pci_read_config_dword(pdev, fw_src->status[i],
 					    &fw_status->status[i]);
-		trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HSF_X",
+		trace_mei_pci_cfg_read(&dev->dev, "PCI_CFG_HSF_X",
 				       fw_src->status[i],
 				       fw_status->status[i]);
 		if (ret)
@@ -677,7 +677,7 @@ static int mei_txe_hw_config(struct mei_device *dev)
 	hw->aliveness = mei_txe_aliveness_get(dev);
 	hw->readiness = mei_txe_readiness_get(dev);
 
-	dev_dbg(dev->dev, "aliveness_resp = 0x%08x, readiness = 0x%08x.\n",
+	dev_dbg(&dev->dev, "aliveness_resp = 0x%08x, readiness = 0x%08x.\n",
 		hw->aliveness, hw->readiness);
 
 	return 0;
@@ -708,7 +708,7 @@ static int mei_txe_write(struct mei_device *dev,
 	if (WARN_ON(!hdr || !data || hdr_len & 0x3))
 		return -EINVAL;
 
-	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
+	dev_dbg(&dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
 
 	dw_cnt = mei_data2slots(hdr_len + data_len);
 	if (dw_cnt > slots)
@@ -724,7 +724,7 @@ static int mei_txe_write(struct mei_device *dev,
 		char fw_sts_str[MEI_FW_STATUS_STR_SZ];
 
 		mei_fw_status_str(dev, fw_sts_str, MEI_FW_STATUS_STR_SZ);
-		dev_err(dev->dev, "Input is not ready %s\n", fw_sts_str);
+		dev_err(&dev->dev, "Input is not ready %s\n", fw_sts_str);
 		return -EAGAIN;
 	}
 
@@ -828,13 +828,13 @@ static int mei_txe_read(struct mei_device *dev,
 	reg_buf = (u32 *)buf;
 	rem = len & 0x3;
 
-	dev_dbg(dev->dev, "buffer-length = %lu buf[0]0x%08X\n",
+	dev_dbg(&dev->dev, "buffer-length = %lu buf[0]0x%08X\n",
 		len, mei_txe_out_data_read(dev, 0));
 
 	for (i = 0; i < len / MEI_SLOT_SIZE; i++) {
 		/* skip header: index starts from 1 */
 		reg = mei_txe_out_data_read(dev, i + 1);
-		dev_dbg(dev->dev, "buf[%d] = 0x%08X\n", i, reg);
+		dev_dbg(&dev->dev, "buf[%d] = 0x%08X\n", i, reg);
 		*reg_buf++ = reg;
 	}
 
@@ -879,7 +879,7 @@ static int mei_txe_hw_reset(struct mei_device *dev, bool intr_enable)
 	 */
 	if (aliveness_req != hw->aliveness)
 		if (mei_txe_aliveness_poll(dev, aliveness_req) < 0) {
-			dev_err(dev->dev, "wait for aliveness settle failed ... bailing out\n");
+			dev_err(&dev->dev, "wait for aliveness settle failed ... bailing out\n");
 			return -EIO;
 		}
 
@@ -889,7 +889,7 @@ static int mei_txe_hw_reset(struct mei_device *dev, bool intr_enable)
 	if (aliveness_req) {
 		mei_txe_aliveness_set(dev, 0);
 		if (mei_txe_aliveness_poll(dev, 0) < 0) {
-			dev_err(dev->dev, "wait for aliveness failed ... bailing out\n");
+			dev_err(&dev->dev, "wait for aliveness failed ... bailing out\n");
 			return -EIO;
 		}
 	}
@@ -921,7 +921,7 @@ static int mei_txe_hw_start(struct mei_device *dev)
 
 	ret = mei_txe_readiness_wait(dev);
 	if (ret < 0) {
-		dev_err(dev->dev, "waiting for readiness failed\n");
+		dev_err(&dev->dev, "waiting for readiness failed\n");
 		return ret;
 	}
 
@@ -937,11 +937,11 @@ static int mei_txe_hw_start(struct mei_device *dev)
 
 	ret = mei_txe_aliveness_set_sync(dev, 1);
 	if (ret < 0) {
-		dev_err(dev->dev, "wait for aliveness failed ... bailing out\n");
+		dev_err(&dev->dev, "wait for aliveness failed ... bailing out\n");
 		return ret;
 	}
 
-	pm_runtime_set_active(dev->dev);
+	pm_runtime_set_active(dev->parent);
 
 	/* enable input ready interrupts:
 	 * SEC_IPC_HOST_INT_MASK.IPC_INPUT_READY_INT_MASK
@@ -1049,7 +1049,7 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 	s32 slots;
 	int rets = 0;
 
-	dev_dbg(dev->dev, "irq thread: Interrupt Registers HHISR|HISR|SEC=%02X|%04X|%02X\n",
+	dev_dbg(&dev->dev, "irq thread: Interrupt Registers HHISR|HISR|SEC=%02X|%04X|%02X\n",
 		mei_txe_br_reg_read(hw, HHISR_REG),
 		mei_txe_br_reg_read(hw, HISR_REG),
 		mei_txe_sec_reg_read_silent(hw, SEC_IPC_HOST_INT_STATUS_REG));
@@ -1059,7 +1059,7 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 	mutex_lock(&dev->device_lock);
 	INIT_LIST_HEAD(&cmpl_list);
 
-	if (pci_dev_msi_enabled(to_pci_dev(dev->dev)))
+	if (pci_dev_msi_enabled(to_pci_dev(dev->parent)))
 		mei_txe_check_and_ack_intrs(dev, true);
 
 	/* show irq events */
@@ -1073,17 +1073,17 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 	 * or TXE driver resetting the HECI interface.
 	 */
 	if (test_and_clear_bit(TXE_INTR_READINESS_BIT, &hw->intr_cause)) {
-		dev_dbg(dev->dev, "Readiness Interrupt was received...\n");
+		dev_dbg(&dev->dev, "Readiness Interrupt was received...\n");
 
 		/* Check if SeC is going through reset */
 		if (mei_txe_readiness_is_sec_rdy(hw->readiness)) {
-			dev_dbg(dev->dev, "we need to start the dev.\n");
+			dev_dbg(&dev->dev, "we need to start the dev.\n");
 			dev->recvd_hw_ready = true;
 		} else {
 			dev->recvd_hw_ready = false;
 			if (dev->dev_state != MEI_DEV_RESETTING) {
 
-				dev_warn(dev->dev, "FW not ready: resetting.\n");
+				dev_warn(&dev->dev, "FW not ready: resetting.\n");
 				schedule_work(&dev->reset_work);
 				goto end;
 
@@ -1100,7 +1100,7 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 
 	if (test_and_clear_bit(TXE_INTR_ALIVENESS_BIT, &hw->intr_cause)) {
 		/* Clear the interrupt cause */
-		dev_dbg(dev->dev,
+		dev_dbg(&dev->dev,
 			"Aliveness Interrupt: Status: %d\n", hw->aliveness);
 		dev->pg_event = MEI_PG_EVENT_RECEIVED;
 		if (waitqueue_active(&hw->wait_aliveness_resp))
@@ -1118,7 +1118,7 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 		if (rets &&
 		    (dev->dev_state != MEI_DEV_RESETTING &&
 		     dev->dev_state != MEI_DEV_POWER_DOWN)) {
-			dev_err(dev->dev,
+			dev_err(&dev->dev,
 				"mei_irq_read_handler ret = %d.\n", rets);
 
 			schedule_work(&dev->reset_work);
@@ -1136,7 +1136,7 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 		dev->hbuf_is_ready = mei_hbuf_is_ready(dev);
 		rets = mei_irq_write_handler(dev, &cmpl_list);
 		if (rets && rets != -EMSGSIZE)
-			dev_err(dev->dev, "mei_irq_write_handler ret = %d.\n",
+			dev_err(&dev->dev, "mei_irq_write_handler ret = %d.\n",
 				rets);
 		dev->hbuf_is_ready = mei_hbuf_is_ready(dev);
 	}
@@ -1144,7 +1144,7 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 	mei_irq_compl_handler(dev, &cmpl_list);
 
 end:
-	dev_dbg(dev->dev, "interrupt thread end ret = %d\n", rets);
+	dev_dbg(&dev->dev, "interrupt thread end ret = %d\n", rets);
 
 	mutex_unlock(&dev->device_lock);
 
@@ -1197,7 +1197,7 @@ struct mei_device *mei_txe_dev_init(struct pci_dev *pdev)
 	struct mei_device *dev;
 	struct mei_txe_hw *hw;
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev) + sizeof(*hw), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev) + sizeof(*hw), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 8ef2b1df8ac7..4d1d5423b612 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -96,7 +96,7 @@ static void mei_save_fw_status(struct mei_device *dev)
 
 	ret = mei_fw_status(dev, &fw_status);
 	if (ret) {
-		dev_err(dev->dev, "failed to read firmware status: %d\n", ret);
+		dev_err(&dev->dev, "failed to read firmware status: %d\n", ret);
 		return;
 	}
 
@@ -126,11 +126,11 @@ int mei_reset(struct mei_device *dev)
 
 		mei_fw_status_str(dev, fw_sts_str, MEI_FW_STATUS_STR_SZ);
 		if (kind_is_gsc(dev) || kind_is_gscfi(dev)) {
-			dev_dbg(dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
+			dev_dbg(&dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
 				mei_dev_state_str(state), fw_sts_str);
 			mei_save_fw_status(dev);
 		} else {
-			dev_warn(dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
+			dev_warn(&dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
 				 mei_dev_state_str(state), fw_sts_str);
 		}
 	}
@@ -150,7 +150,7 @@ int mei_reset(struct mei_device *dev)
 
 	dev->reset_count++;
 	if (dev->reset_count > MEI_MAX_CONSEC_RESET) {
-		dev_err(dev->dev, "reset: reached maximal consecutive resets: disabling the device\n");
+		dev_err(&dev->dev, "reset: reached maximal consecutive resets: disabling the device\n");
 		mei_set_devstate(dev, MEI_DEV_DISABLED);
 		return -ENODEV;
 	}
@@ -170,12 +170,12 @@ int mei_reset(struct mei_device *dev)
 	memset(dev->rd_msg_hdr, 0, sizeof(dev->rd_msg_hdr));
 
 	if (ret) {
-		dev_err(dev->dev, "hw_reset failed ret = %d\n", ret);
+		dev_err(&dev->dev, "hw_reset failed ret = %d\n", ret);
 		return ret;
 	}
 
 	if (state == MEI_DEV_POWER_DOWN) {
-		dev_dbg(dev->dev, "powering down: end of reset\n");
+		dev_dbg(&dev->dev, "powering down: end of reset\n");
 		mei_set_devstate(dev, MEI_DEV_DISABLED);
 		return 0;
 	}
@@ -185,21 +185,21 @@ int mei_reset(struct mei_device *dev)
 		char fw_sts_str[MEI_FW_STATUS_STR_SZ];
 
 		mei_fw_status_str(dev, fw_sts_str, MEI_FW_STATUS_STR_SZ);
-		dev_err(dev->dev, "hw_start failed ret = %d fw status = %s\n", ret, fw_sts_str);
+		dev_err(&dev->dev, "hw_start failed ret = %d fw status = %s\n", ret, fw_sts_str);
 		return ret;
 	}
 
 	if (dev->dev_state != MEI_DEV_RESETTING) {
-		dev_dbg(dev->dev, "wrong state = %d on link start\n", dev->dev_state);
+		dev_dbg(&dev->dev, "wrong state = %d on link start\n", dev->dev_state);
 		return 0;
 	}
 
-	dev_dbg(dev->dev, "link is established start sending messages.\n");
+	dev_dbg(&dev->dev, "link is established start sending messages.\n");
 
 	mei_set_devstate(dev, MEI_DEV_INIT_CLIENTS);
 	ret = mei_hbm_start_req(dev);
 	if (ret) {
-		dev_err(dev->dev, "hbm_start failed ret = %d\n", ret);
+		dev_err(&dev->dev, "hbm_start failed ret = %d\n", ret);
 		mei_set_devstate(dev, MEI_DEV_RESETTING);
 		return ret;
 	}
@@ -228,7 +228,7 @@ int mei_start(struct mei_device *dev)
 	if (ret)
 		goto err;
 
-	dev_dbg(dev->dev, "reset in start the mei device.\n");
+	dev_dbg(&dev->dev, "reset in start the mei device.\n");
 
 	dev->reset_count = 0;
 	do {
@@ -236,27 +236,27 @@ int mei_start(struct mei_device *dev)
 		ret = mei_reset(dev);
 
 		if (ret == -ENODEV || dev->dev_state == MEI_DEV_DISABLED) {
-			dev_err(dev->dev, "reset failed ret = %d", ret);
+			dev_err(&dev->dev, "reset failed ret = %d", ret);
 			goto err;
 		}
 	} while (ret);
 
 	if (mei_hbm_start_wait(dev)) {
-		dev_err(dev->dev, "HBM haven't started");
+		dev_err(&dev->dev, "HBM haven't started");
 		goto err;
 	}
 
 	if (!mei_hbm_version_is_supported(dev)) {
-		dev_dbg(dev->dev, "MEI start failed.\n");
+		dev_dbg(&dev->dev, "MEI start failed.\n");
 		goto err;
 	}
 
-	dev_dbg(dev->dev, "link layer has been established.\n");
+	dev_dbg(&dev->dev, "link layer has been established.\n");
 
 	mutex_unlock(&dev->device_lock);
 	return 0;
 err:
-	dev_err(dev->dev, "link layer initialization failed.\n");
+	dev_err(&dev->dev, "link layer initialization failed.\n");
 	mei_set_devstate(dev, MEI_DEV_DISABLED);
 	mutex_unlock(&dev->device_lock);
 	return -ENODEV;
@@ -284,7 +284,7 @@ int mei_restart(struct mei_device *dev)
 	mutex_unlock(&dev->device_lock);
 
 	if (err == -ENODEV || dev->dev_state == MEI_DEV_DISABLED) {
-		dev_err(dev->dev, "device disabled = %d\n", err);
+		dev_err(&dev->dev, "device disabled = %d\n", err);
 		return -ENODEV;
 	}
 
@@ -313,7 +313,7 @@ static void mei_reset_work(struct work_struct *work)
 	mutex_unlock(&dev->device_lock);
 
 	if (dev->dev_state == MEI_DEV_DISABLED) {
-		dev_err(dev->dev, "device disabled = %d\n", ret);
+		dev_err(&dev->dev, "device disabled = %d\n", ret);
 		return;
 	}
 
@@ -324,7 +324,7 @@ static void mei_reset_work(struct work_struct *work)
 
 void mei_stop(struct mei_device *dev)
 {
-	dev_dbg(dev->dev, "stopping the device.\n");
+	dev_dbg(&dev->dev, "stopping the device.\n");
 
 	mutex_lock(&dev->device_lock);
 	mei_set_devstate(dev, MEI_DEV_POWERING_DOWN);
@@ -365,7 +365,7 @@ bool mei_write_is_idle(struct mei_device *dev)
 		list_empty(&dev->write_list)   &&
 		list_empty(&dev->write_waiting_list));
 
-	dev_dbg(dev->dev, "write pg: is idle[%d] state=%s ctrl=%01d write=%01d wwait=%01d\n",
+	dev_dbg(&dev->dev, "write pg: is idle[%d] state=%s ctrl=%01d write=%01d wwait=%01d\n",
 		idle,
 		mei_dev_state_str(dev->dev_state),
 		list_empty(&dev->ctrl_wr_list),
@@ -380,12 +380,12 @@ EXPORT_SYMBOL_GPL(mei_write_is_idle);
  * mei_device_init - initialize mei_device structure
  *
  * @dev: the mei device
- * @device: the device structure
+ * @parent: the parent device
  * @slow_fw: configure longer timeouts as FW is slow
  * @hw_ops: hw operations
  */
 void mei_device_init(struct mei_device *dev,
-		     struct device *device,
+		     struct device *parent,
 		     bool slow_fw,
 		     const struct mei_hw_ops *hw_ops)
 {
@@ -426,7 +426,7 @@ void mei_device_init(struct mei_device *dev,
 
 	dev->pg_event = MEI_PG_EVENT_IDLE;
 	dev->ops      = hw_ops;
-	dev->dev      = device;
+	dev->parent   = parent;
 
 	dev->timeouts.hw_ready = mei_secs_to_jiffies(MEI_HW_READY_TIMEOUT);
 	dev->timeouts.connect = MEI_CONNECT_TIMEOUT;
@@ -444,4 +444,3 @@ void mei_device_init(struct mei_device *dev,
 	}
 }
 EXPORT_SYMBOL_GPL(mei_device_init);
-
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index d472f6bbe767..3aa66b6b0d36 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -76,7 +76,7 @@ static void mei_irq_discard_msg(struct mei_device *dev, struct mei_msg_hdr *hdr,
 	 * that length fits into rd_msg_buf
 	 */
 	mei_read_slots(dev, dev->rd_msg_buf, discard_len);
-	dev_dbg(dev->dev, "discarding message " MEI_HDR_FMT "\n",
+	dev_dbg(&dev->dev, "discarding message " MEI_HDR_FMT "\n",
 		MEI_HDR_PRM(hdr));
 }
 
@@ -229,8 +229,8 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		cl_dbg(dev, cl, "completed read length = %zu\n", cb->buf_idx);
 		list_move_tail(&cb->list, cmpl_list);
 	} else {
-		pm_runtime_mark_last_busy(dev->dev);
-		pm_request_autosuspend(dev->dev);
+		pm_runtime_mark_last_busy(dev->parent);
+		pm_request_autosuspend(dev->parent);
 	}
 
 	return 0;
@@ -310,8 +310,8 @@ static int mei_cl_irq_read(struct mei_cl *cl, struct mei_cl_cb *cb,
 		return ret;
 	}
 
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_request_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(dev->parent);
+	pm_request_autosuspend(dev->parent);
 
 	list_move_tail(&cb->list, &cl->rd_pending);
 
@@ -373,21 +373,21 @@ int mei_irq_read_handler(struct mei_device *dev,
 		dev->rd_msg_hdr[0] = mei_read_hdr(dev);
 		dev->rd_msg_hdr_count = 1;
 		(*slots)--;
-		dev_dbg(dev->dev, "slots =%08x.\n", *slots);
+		dev_dbg(&dev->dev, "slots =%08x.\n", *slots);
 
 		ret = hdr_is_valid(dev->rd_msg_hdr[0]);
 		if (ret) {
-			dev_err(dev->dev, "corrupted message header 0x%08X\n",
+			dev_err(&dev->dev, "corrupted message header 0x%08X\n",
 				dev->rd_msg_hdr[0]);
 			goto end;
 		}
 	}
 
 	mei_hdr = (struct mei_msg_hdr *)dev->rd_msg_hdr;
-	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM(mei_hdr));
+	dev_dbg(&dev->dev, MEI_HDR_FMT, MEI_HDR_PRM(mei_hdr));
 
 	if (mei_slots2data(*slots) < mei_hdr->length) {
-		dev_err(dev->dev, "less data available than length=%08x.\n",
+		dev_err(&dev->dev, "less data available than length=%08x.\n",
 				*slots);
 		/* we can't read the message */
 		ret = -ENODATA;
@@ -402,18 +402,18 @@ int mei_irq_read_handler(struct mei_device *dev,
 			dev->rd_msg_hdr[1] = mei_read_hdr(dev);
 			dev->rd_msg_hdr_count++;
 			(*slots)--;
-			dev_dbg(dev->dev, "extended header is %08x\n", dev->rd_msg_hdr[1]);
+			dev_dbg(&dev->dev, "extended header is %08x\n", dev->rd_msg_hdr[1]);
 		}
 		meta_hdr = ((struct mei_ext_meta_hdr *)&dev->rd_msg_hdr[1]);
 		if (check_add_overflow((u32)sizeof(*meta_hdr),
 				       mei_slots2data(meta_hdr->size),
 				       &hdr_size_ext)) {
-			dev_err(dev->dev, "extended message size too big %d\n",
+			dev_err(&dev->dev, "extended message size too big %d\n",
 				meta_hdr->size);
 			return -EBADMSG;
 		}
 		if (hdr_size_left < hdr_size_ext) {
-			dev_err(dev->dev, "corrupted message header len %d\n",
+			dev_err(&dev->dev, "corrupted message header len %d\n",
 				mei_hdr->length);
 			return -EBADMSG;
 		}
@@ -422,7 +422,7 @@ int mei_irq_read_handler(struct mei_device *dev,
 		ext_hdr_end = meta_hdr->size + 2;
 		for (i = dev->rd_msg_hdr_count; i < ext_hdr_end; i++) {
 			dev->rd_msg_hdr[i] = mei_read_hdr(dev);
-			dev_dbg(dev->dev, "extended header %d is %08x\n", i,
+			dev_dbg(&dev->dev, "extended header %d is %08x\n", i,
 				dev->rd_msg_hdr[i]);
 			dev->rd_msg_hdr_count++;
 			(*slots)--;
@@ -431,7 +431,7 @@ int mei_irq_read_handler(struct mei_device *dev,
 
 	if (mei_hdr->dma_ring) {
 		if (hdr_size_left != sizeof(dev->rd_msg_hdr[ext_hdr_end])) {
-			dev_err(dev->dev, "corrupted message header len %d\n",
+			dev_err(&dev->dev, "corrupted message header len %d\n",
 				mei_hdr->length);
 			return -EBADMSG;
 		}
@@ -446,8 +446,7 @@ int mei_irq_read_handler(struct mei_device *dev,
 	if (hdr_is_hbm(mei_hdr)) {
 		ret = mei_hbm_dispatch(dev, mei_hdr);
 		if (ret) {
-			dev_dbg(dev->dev, "mei_hbm_dispatch failed ret = %d\n",
-					ret);
+			dev_dbg(&dev->dev, "mei_hbm_dispatch failed ret = %d\n", ret);
 			goto end;
 		}
 		goto reset_slots;
@@ -474,7 +473,7 @@ int mei_irq_read_handler(struct mei_device *dev,
 		ret = 0;
 		goto reset_slots;
 	}
-	dev_err(dev->dev, "no destination client found 0x%08X\n", dev->rd_msg_hdr[0]);
+	dev_err(&dev->dev, "no destination client found 0x%08X\n", dev->rd_msg_hdr[0]);
 	ret = -EBADMSG;
 	goto end;
 
@@ -485,7 +484,7 @@ int mei_irq_read_handler(struct mei_device *dev,
 	*slots = mei_count_full_read_slots(dev);
 	if (*slots == -EOVERFLOW) {
 		/* overflow - reset */
-		dev_err(dev->dev, "resetting due to slots overflow.\n");
+		dev_err(&dev->dev, "resetting due to slots overflow.\n");
 		/* set the event since message has been read */
 		ret = -ERANGE;
 		goto end;
@@ -525,7 +524,7 @@ int mei_irq_write_handler(struct mei_device *dev, struct list_head *cmpl_list)
 		return -EMSGSIZE;
 
 	/* complete all waiting for write CB */
-	dev_dbg(dev->dev, "complete all waiting for write cb.\n");
+	dev_dbg(&dev->dev, "complete all waiting for write cb.\n");
 
 	list_for_each_entry_safe(cb, next, &dev->write_waiting_list, list) {
 		cl = cb->cl;
@@ -537,7 +536,7 @@ int mei_irq_write_handler(struct mei_device *dev, struct list_head *cmpl_list)
 	}
 
 	/* complete control write list CB */
-	dev_dbg(dev->dev, "complete control write list cb.\n");
+	dev_dbg(&dev->dev, "complete control write list cb.\n");
 	list_for_each_entry_safe(cb, next, &dev->ctrl_wr_list, list) {
 		cl = cb->cl;
 		switch (cb->fop_type) {
@@ -591,7 +590,7 @@ int mei_irq_write_handler(struct mei_device *dev, struct list_head *cmpl_list)
 
 	}
 	/* complete  write list CB */
-	dev_dbg(dev->dev, "complete write list cb.\n");
+	dev_dbg(&dev->dev, "complete write list cb.\n");
 	list_for_each_entry_safe(cb, next, &dev->write_list, list) {
 		cl = cb->cl;
 		ret = mei_cl_irq_write(cl, cb, cmpl_list);
@@ -656,7 +655,7 @@ void mei_timer(struct work_struct *work)
 
 		if (dev->init_clients_timer) {
 			if (--dev->init_clients_timer == 0) {
-				dev_err(dev->dev, "timer: init clients timeout hbm_state = %d.\n",
+				dev_err(&dev->dev, "timer: init clients timeout hbm_state = %d.\n",
 					dev->hbm_state);
 				mei_reset(dev);
 				goto out;
@@ -672,7 +671,7 @@ void mei_timer(struct work_struct *work)
 	list_for_each_entry(cl, &dev->file_list, link) {
 		if (cl->timer_count) {
 			if (--cl->timer_count == 0) {
-				dev_err(dev->dev, "timer: connect/disconnect timeout.\n");
+				dev_err(&dev->dev, "timer: connect/disconnect timeout.\n");
 				mei_connect_timeout(cl);
 				goto out;
 			}
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 90c9eef0d876..f37f9b8b1f51 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -54,11 +54,12 @@ static int mei_open(struct inode *inode, struct file *file)
 	dev = idr_find(&mei_idr, iminor(inode));
 	if (!dev)
 		return -ENODEV;
+	get_device(&dev->dev);
 
 	mutex_lock(&dev->device_lock);
 
 	if (dev->dev_state != MEI_DEV_ENABLED) {
-		dev_dbg(dev->dev, "dev_state != MEI_ENABLED  dev_state = %s\n",
+		dev_dbg(&dev->dev, "dev_state != MEI_ENABLED  dev_state = %s\n",
 		    mei_dev_state_str(dev->dev_state));
 		err = -ENODEV;
 		goto err_unlock;
@@ -79,6 +80,7 @@ static int mei_open(struct inode *inode, struct file *file)
 
 err_unlock:
 	mutex_unlock(&dev->device_lock);
+	put_device(&dev->dev);
 	return err;
 }
 
@@ -154,6 +156,7 @@ static int mei_release(struct inode *inode, struct file *file)
 	file->private_data = NULL;
 
 	mutex_unlock(&dev->device_lock);
+	put_device(&dev->dev);
 	return rets;
 }
 
@@ -479,7 +482,7 @@ static int mei_vt_support_check(struct mei_device *dev, const uuid_le *uuid)
 
 	me_cl = mei_me_cl_by_uuid(dev, uuid);
 	if (!me_cl) {
-		dev_dbg(dev->dev, "Cannot connect to FW Client UUID = %pUl\n",
+		dev_dbg(&dev->dev, "Cannot connect to FW Client UUID = %pUl\n",
 			uuid);
 		return -ENOTTY;
 	}
@@ -1196,7 +1199,7 @@ static int mei_minor_get(struct mei_device *dev)
 	if (ret >= 0)
 		dev->minor = ret;
 	else if (ret == -ENOSPC)
-		dev_err(dev->dev, "too many mei devices\n");
+		dev_err(&dev->dev, "too many mei devices\n");
 
 	mutex_unlock(&mei_minor_lock);
 	return ret;
@@ -1214,9 +1217,13 @@ static void mei_minor_free(struct mei_device *dev)
 	mutex_unlock(&mei_minor_lock);
 }
 
+static void mei_device_release(struct device *dev)
+{
+	kfree(dev_get_drvdata(dev));
+}
+
 int mei_register(struct mei_device *dev, struct device *parent)
 {
-	struct device *clsdev; /* class device */
 	int ret, devno;
 
 	ret = mei_minor_get(dev);
@@ -1225,6 +1232,15 @@ int mei_register(struct mei_device *dev, struct device *parent)
 
 	/* Fill in the data structures */
 	devno = MKDEV(MAJOR(mei_devt), dev->minor);
+
+	device_initialize(&dev->dev);
+	dev->dev.devt = devno;
+	dev->dev.class = &mei_class;
+	dev->dev.parent = parent;
+	dev->dev.groups = mei_groups;
+	dev->dev.release = mei_device_release;
+	dev_set_drvdata(&dev->dev, dev);
+
 	dev->cdev = cdev_alloc();
 	if (!dev->cdev) {
 		ret = -ENOMEM;
@@ -1232,28 +1248,31 @@ int mei_register(struct mei_device *dev, struct device *parent)
 	}
 	dev->cdev->ops = &mei_fops;
 	dev->cdev->owner = parent->driver->owner;
-	cdev_set_parent(dev->cdev, &parent->kobj);
+	cdev_set_parent(dev->cdev, &dev->dev.kobj);
 
 	/* Add the device */
 	ret = cdev_add(dev->cdev, devno, 1);
 	if (ret) {
-		dev_err(parent, "unable to add device %d:%d\n",
+		dev_err(parent, "unable to add cdev for device %d:%d\n",
 			MAJOR(mei_devt), dev->minor);
 		goto err_del_cdev;
 	}
 
-	clsdev = device_create_with_groups(&mei_class, parent, devno,
-					   dev, mei_groups,
-					   "mei%d", dev->minor);
+	ret = dev_set_name(&dev->dev, "mei%d", dev->minor);
+	if (ret) {
+		dev_err(parent, "unable to set name to device %d:%d ret = %d\n",
+			MAJOR(mei_devt), dev->minor, ret);
+		goto err_del_cdev;
+	}
 
-	if (IS_ERR(clsdev)) {
-		dev_err(parent, "unable to create device %d:%d\n",
-			MAJOR(mei_devt), dev->minor);
-		ret = PTR_ERR(clsdev);
+	ret = device_add(&dev->dev);
+	if (ret) {
+		dev_err(parent, "unable to add device %d:%d ret = %d\n",
+			MAJOR(mei_devt), dev->minor, ret);
 		goto err_del_cdev;
 	}
 
-	mei_dbgfs_register(dev, dev_name(clsdev));
+	mei_dbgfs_register(dev, dev_name(&dev->dev));
 
 	return 0;
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 0cc943afa80a..4ab2b9100fd4 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -470,7 +470,8 @@ struct mei_dev_timeouts {
 /**
  * struct mei_device -  MEI private device struct
  *
- * @dev         : device on a bus
+ * @parent      : device on a bus
+ * @dev         : device object
  * @cdev        : character device pointer
  * @minor       : minor number allocated for device
  *
@@ -556,7 +557,8 @@ struct mei_dev_timeouts {
  * @hw          : hw specific data
  */
 struct mei_device {
-	struct device *dev;
+	struct device *parent;
+	struct device dev;
 	struct cdev *cdev;
 	int minor;
 
@@ -703,7 +705,7 @@ static inline u32 mei_slots2data(int slots)
  * mei init function prototypes
  */
 void mei_device_init(struct mei_device *dev,
-		     struct device *device,
+		     struct device *parent,
 		     bool slow_fw,
 		     const struct mei_hw_ops *hw_ops);
 int mei_reset(struct mei_device *dev);
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3f9c60b579ae..b108a7c22388 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -143,7 +143,7 @@ static inline void mei_me_unset_pm_domain(struct mei_device *dev) {}
 
 static int mei_me_read_fws(const struct mei_device *dev, int where, u32 *val)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
 
 	return pci_read_config_dword(pdev, where, val);
 }
@@ -238,19 +238,19 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto end;
 	}
 
+	err = mei_register(dev, &pdev->dev);
+	if (err)
+		goto release_irq;
+
 	if (mei_start(dev)) {
 		dev_err(&pdev->dev, "init hw failure.\n");
 		err = -ENODEV;
-		goto release_irq;
+		goto deregister;
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, MEI_ME_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-	err = mei_register(dev, &pdev->dev);
-	if (err)
-		goto stop;
-
 	pci_set_drvdata(pdev, dev);
 
 	/*
@@ -280,8 +280,8 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-stop:
-	mei_stop(dev);
+deregister:
+	mei_deregister(dev);
 release_irq:
 	mei_cancel_work(dev);
 	mei_disable_interrupts(dev);
@@ -475,7 +475,7 @@ static int mei_me_pm_runtime_resume(struct device *device)
  */
 static inline void mei_me_set_pm_domain(struct mei_device *dev)
 {
-	struct pci_dev *pdev  = to_pci_dev(dev->dev);
+	struct pci_dev *pdev  = to_pci_dev(dev->parent);
 
 	if (pdev->dev.bus && pdev->dev.bus->pm) {
 		dev->pg_domain.ops = *pdev->dev.bus->pm;
@@ -496,7 +496,7 @@ static inline void mei_me_set_pm_domain(struct mei_device *dev)
 static inline void mei_me_unset_pm_domain(struct mei_device *dev)
 {
 	/* stop using pm callbacks if any */
-	dev_pm_domain_set(dev->dev, NULL);
+	dev_pm_domain_set(dev->parent, NULL);
 }
 
 static const struct dev_pm_ops mei_me_pm_ops = {
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index 2a584104ba38..c9eb5c5393e4 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -321,7 +321,7 @@ static int mei_txe_pm_runtime_resume(struct device *device)
  */
 static inline void mei_txe_set_pm_domain(struct mei_device *dev)
 {
-	struct pci_dev *pdev  = to_pci_dev(dev->dev);
+	struct pci_dev *pdev  = to_pci_dev(dev->parent);
 
 	if (pdev->dev.bus && pdev->dev.bus->pm) {
 		dev->pg_domain.ops = *pdev->dev.bus->pm;
@@ -342,7 +342,7 @@ static inline void mei_txe_set_pm_domain(struct mei_device *dev)
 static inline void mei_txe_unset_pm_domain(struct mei_device *dev)
 {
 	/* stop using pm callbacks if any */
-	dev_pm_domain_set(dev->dev, NULL);
+	dev_pm_domain_set(dev->parent, NULL);
 }
 
 static const struct dev_pm_ops mei_txe_pm_ops = {
diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 435760b1e86f..5ae6042c807e 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -152,7 +152,7 @@ static int mei_vsc_hw_start(struct mei_device *mei_dev)
 				MEI_VSC_POLL_TIMEOUT_US, true,
 				hw, &buf, sizeof(buf));
 	if (ret) {
-		dev_err(mei_dev->dev, "wait fw ready failed: %d\n", ret);
+		dev_err(&mei_dev->dev, "wait fw ready failed: %d\n", ret);
 		return ret;
 	}
 
@@ -256,7 +256,7 @@ static int mei_vsc_hw_reset(struct mei_device *mei_dev, bool intr_enable)
 
 	vsc_tp_reset(hw->tp);
 
-	return vsc_tp_init(hw->tp, mei_dev->dev);
+	return vsc_tp_init(hw->tp, mei_dev->parent);
 }
 
 static const struct mei_hw_ops mei_vsc_hw_ops = {
@@ -322,7 +322,7 @@ static void mei_vsc_event_cb(void *context)
 	mei_dev->hbuf_is_ready = mei_hbuf_is_ready(mei_dev);
 	ret = mei_irq_write_handler(mei_dev, &cmpl_list);
 	if (ret)
-		dev_err(mei_dev->dev, "dispatch write request failed: %d\n", ret);
+		dev_err(&mei_dev->dev, "dispatch write request failed: %d\n", ret);
 
 	mei_dev->hbuf_is_ready = mei_hbuf_is_ready(mei_dev);
 	mei_irq_compl_handler(mei_dev, &cmpl_list);
@@ -340,12 +340,12 @@ static int mei_vsc_probe(struct platform_device *pdev)
 	if (!tp)
 		return dev_err_probe(dev, -ENODEV, "no platform data\n");
 
-	mei_dev = devm_kzalloc(dev, size_add(sizeof(*mei_dev), sizeof(*hw)),
-			       GFP_KERNEL);
+	mei_dev = kzalloc(size_add(sizeof(*mei_dev), sizeof(*hw)), GFP_KERNEL);
 	if (!mei_dev)
 		return -ENOMEM;
 
 	mei_device_init(mei_dev, dev, false, &mei_vsc_hw_ops);
+
 	mei_dev->fw_f_fw_ver_supported = 0;
 	mei_dev->kind = "ivsc";
 
@@ -357,22 +357,22 @@ static int mei_vsc_probe(struct platform_device *pdev)
 
 	vsc_tp_register_event_cb(tp, mei_vsc_event_cb, mei_dev);
 
+	ret = mei_register(mei_dev, dev);
+	if (ret)
+		goto err_dereg;
+
 	ret = mei_start(mei_dev);
 	if (ret) {
 		dev_err_probe(dev, ret, "init hw failed\n");
 		goto err_cancel;
 	}
 
-	ret = mei_register(mei_dev, dev);
-	if (ret)
-		goto err_stop;
-
-	pm_runtime_enable(mei_dev->dev);
+	pm_runtime_enable(mei_dev->parent);
 
 	return 0;
 
-err_stop:
-	mei_stop(mei_dev);
+err_dereg:
+	mei_deregister(mei_dev);
 
 err_cancel:
 	mei_cancel_work(mei_dev);
@@ -386,7 +386,7 @@ static void mei_vsc_remove(struct platform_device *pdev)
 {
 	struct mei_device *mei_dev = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(mei_dev->dev);
+	pm_runtime_disable(mei_dev->parent);
 
 	mei_stop(mei_dev);
 
-- 
2.43.0


