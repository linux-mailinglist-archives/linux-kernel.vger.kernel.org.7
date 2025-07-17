Return-Path: <linux-kernel+bounces-735425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D9B08F20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27995A64EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05D2F6FA5;
	Thu, 17 Jul 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUEkG+d3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9F2D8DC8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762264; cv=none; b=JS42HjxJO4moXOt/M6M1yL0R+pfLorJfEmFMxtIRwFi48z2fxvmvC6xSr01u0aYLWgR67AFeDNW6/Yim69RxhY3mzmoEJHzU+xM0aQ50VRi3u2MUo2HDvLRJzXxvrcflZe4kp18NmzHmVj+7PvMduNfqxlGd0X5XT+Ifb7cUSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762264; c=relaxed/simple;
	bh=CWsPWtPFabmPCoamIgWsTQvkuyfHgWAlM1TB0EsJvYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if/VC2lFaHMl2kDIqdmxkKR2oawnMqyLFSDRsjMz8uJnB6VkTWjfkB7ee57+Vp0hP9X8MoF9Ij8dYEfFi2NC9fB7VQSyfEGqgijCOqEtE0owy/Um+znwwuOk4HgOK4B0KfUaLj2xdSBOB31On8TdjszB4MYIAz/CDOs7t12rjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUEkG+d3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752762262; x=1784298262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CWsPWtPFabmPCoamIgWsTQvkuyfHgWAlM1TB0EsJvYo=;
  b=iUEkG+d3YfNeBBNJxwGxEvc5l7/ckeRxRyW/uxX6qwcibrzyCDKKeWgZ
   7Rlb5M01jjD00IgNr+SrKHit0uxmnsCewB7uWkkdm9ummeRDHf1hGSmpQ
   EUnGet/oFC4jdE3Uqfc8xmAOCuP0tZBWdyqE1i4u9TYyBvbvxzwFqnjUu
   XqFPZ3TQtVaYqEAvxTT0OOR9OHvZlJrJ9Vdo4/Px2DlJudYkyaz9G2j/V
   tRYdXpiSH9O1uowouCJN8IBf09c4prJdC/dbVfWZB7TiGyznPhaXP4SxW
   lpUrkiDPhBLjo/rjKGZ+buY1sGpzTqlxOOTV6+Mz08ibWGfjbiCMsafRA
   w==;
X-CSE-ConnectionGUID: +AuSh2LcRRWi2+qxMeo8aQ==
X-CSE-MsgGUID: 1QHsveGgQ4O7HZcSpAmmIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="80486829"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="80486829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:24:22 -0700
X-CSE-ConnectionGUID: bSNdNuOsTE2WtQEnJrb/yQ==
X-CSE-MsgGUID: QPneHwuhS0CTsWW6IlbCPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="162105308"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:24:21 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v4 2/3] mei: more prints with client prefix
Date: Thu, 17 Jul 2025 17:11:11 +0300
Message-ID: <20250717141112.1696482-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717141112.1696482-1-alexander.usyskin@intel.com>
References: <20250717141112.1696482-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use client-aware print macro instead of usual device print in more
places to expand debug-ability.
The client-aware print macro prefixes the usual device print with
current connection endpoints.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hbm.c       | 14 ++++-----
 drivers/misc/mei/interrupt.c |  2 +-
 drivers/misc/mei/main.c      | 55 +++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 026b1f686c16..4fe9a2752d43 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -510,7 +510,7 @@ int mei_hbm_cl_notify_req(struct mei_device *dev,
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret)
-		dev_err(dev->dev, "notify request failed: ret = %d\n", ret);
+		cl_err(dev, cl, "notify request failed: ret = %d\n", ret);
 
 	return ret;
 }
@@ -626,7 +626,7 @@ int mei_hbm_cl_dma_map_req(struct mei_device *dev, struct mei_cl *cl)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret)
-		dev_err(dev->dev, "dma map request failed: ret = %d\n", ret);
+		cl_err(dev, cl, "dma map request failed: ret = %d\n", ret);
 
 	return ret;
 }
@@ -654,7 +654,7 @@ int mei_hbm_cl_dma_unmap_req(struct mei_device *dev, struct mei_cl *cl)
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret)
-		dev_err(dev->dev, "dma unmap request failed: ret = %d\n", ret);
+		cl_err(dev, cl, "dma unmap request failed: ret = %d\n", ret);
 
 	return ret;
 }
@@ -679,10 +679,10 @@ static void mei_hbm_cl_dma_map_res(struct mei_device *dev,
 		return;
 
 	if (res->status) {
-		dev_err(dev->dev, "cl dma map failed %d\n", res->status);
+		cl_err(dev, cl, "cl dma map failed %d\n", res->status);
 		cl->status = -EFAULT;
 	} else {
-		dev_dbg(dev->dev, "cl dma map succeeded\n");
+		cl_dbg(dev, cl, "cl dma map succeeded\n");
 		cl->dma_mapped = 1;
 		cl->status = 0;
 	}
@@ -709,10 +709,10 @@ static void mei_hbm_cl_dma_unmap_res(struct mei_device *dev,
 		return;
 
 	if (res->status) {
-		dev_err(dev->dev, "cl dma unmap failed %d\n", res->status);
+		cl_err(dev, cl, "cl dma unmap failed %d\n", res->status);
 		cl->status = -EFAULT;
 	} else {
-		dev_dbg(dev->dev, "cl dma unmap succeeded\n");
+		cl_dbg(dev, cl, "cl dma unmap succeeded\n");
 		cl->dma_mapped = 0;
 		cl->status = 0;
 	}
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index c484f416fae4..d472f6bbe767 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -35,7 +35,7 @@ void mei_irq_compl_handler(struct mei_device *dev, struct list_head *cmpl_list)
 		cl = cb->cl;
 		list_del_init(&cb->list);
 
-		dev_dbg(dev->dev, "completing call back.\n");
+		cl_dbg(dev, cl, "completing call back.\n");
 		mei_cl_complete(cl, cb);
 	}
 }
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 1f5aaf16e300..8a149a15b861 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -256,7 +256,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 	length = min_t(size_t, length, cb->buf_idx - *offset);
 
 	if (copy_to_user(ubuf, cb->buf.data + *offset, length)) {
-		dev_dbg(dev->dev, "failed to copy data to userland\n");
+		cl_dbg(dev, cl, "failed to copy data to userland\n");
 		rets = -EFAULT;
 		goto free;
 	}
@@ -379,7 +379,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 
 	rets = copy_from_user(cb->buf.data, ubuf, length);
 	if (rets) {
-		dev_dbg(dev->dev, "failed to copy data from userland\n");
+		cl_dbg(dev, cl, "failed to copy data from userland\n");
 		rets = -EFAULT;
 		mei_io_cb_free(cb);
 		goto out;
@@ -421,7 +421,7 @@ static int mei_ioctl_connect_client(struct file *file,
 	/* find ME client we're trying to connect to */
 	me_cl = mei_me_cl_by_uuid(dev, in_client_uuid);
 	if (!me_cl) {
-		dev_dbg(dev->dev, "Cannot connect to FW Client UUID = %pUl\n",
+		cl_dbg(dev, cl, "Cannot connect to FW Client UUID = %pUl\n",
 			in_client_uuid);
 		rets = -ENOTTY;
 		goto end;
@@ -431,24 +431,21 @@ static int mei_ioctl_connect_client(struct file *file,
 		bool forbidden = dev->override_fixed_address ?
 			 !dev->allow_fixed_address : !dev->hbm_f_fa_supported;
 		if (forbidden) {
-			dev_dbg(dev->dev, "Connection forbidden to FW Client UUID = %pUl\n",
+			cl_dbg(dev, cl, "Connection forbidden to FW Client UUID = %pUl\n",
 				in_client_uuid);
 			rets = -ENOTTY;
 			goto end;
 		}
 	}
 
-	dev_dbg(dev->dev, "Connect to FW Client ID = %d\n",
-			me_cl->client_id);
-	dev_dbg(dev->dev, "FW Client - Protocol Version = %d\n",
-			me_cl->props.protocol_version);
-	dev_dbg(dev->dev, "FW Client - Max Msg Len = %d\n",
-			me_cl->props.max_msg_length);
+	cl_dbg(dev, cl, "Connect to FW Client ID = %d\n", me_cl->client_id);
+	cl_dbg(dev, cl, "FW Client - Protocol Version = %d\n", me_cl->props.protocol_version);
+	cl_dbg(dev, cl, "FW Client - Max Msg Len = %d\n", me_cl->props.max_msg_length);
 
 	/* prepare the output buffer */
 	client->max_msg_length = me_cl->props.max_msg_length;
 	client->protocol_version = me_cl->props.protocol_version;
-	dev_dbg(dev->dev, "Can connect?\n");
+	cl_dbg(dev, cl, "Can connect?\n");
 
 	rets = mei_cl_connect(cl, me_cl, file);
 
@@ -515,19 +512,19 @@ static int mei_ioctl_connect_vtag(struct file *file,
 	cl = file->private_data;
 	dev = cl->dev;
 
-	dev_dbg(dev->dev, "FW Client %pUl vtag %d\n", in_client_uuid, vtag);
+	cl_dbg(dev, cl, "FW Client %pUl vtag %d\n", in_client_uuid, vtag);
 
 	switch (cl->state) {
 	case MEI_FILE_DISCONNECTED:
 		if (mei_cl_vtag_by_fp(cl, file) != vtag) {
-			dev_err(dev->dev, "reconnect with different vtag\n");
+			cl_err(dev, cl, "reconnect with different vtag\n");
 			return -EINVAL;
 		}
 		break;
 	case MEI_FILE_INITIALIZING:
 		/* malicious connect from another thread may push vtag */
 		if (!IS_ERR(mei_cl_fp_by_vtag(cl, vtag))) {
-			dev_err(dev->dev, "vtag already filled\n");
+			cl_err(dev, cl, "vtag already filled\n");
 			return -EINVAL;
 		}
 
@@ -546,7 +543,7 @@ static int mei_ioctl_connect_vtag(struct file *file,
 				continue;
 
 			/* replace cl with acquired one */
-			dev_dbg(dev->dev, "replacing with existing cl\n");
+			cl_dbg(dev, cl, "replacing with existing cl\n");
 			mei_cl_unlink(cl);
 			kfree(cl);
 			file->private_data = pos;
@@ -656,7 +653,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
 	dev = cl->dev;
 
-	dev_dbg(dev->dev, "IOCTL cmd = 0x%x", cmd);
+	cl_dbg(dev, cl, "IOCTL cmd = 0x%x", cmd);
 
 	mutex_lock(&dev->device_lock);
 	if (dev->dev_state != MEI_DEV_ENABLED) {
@@ -666,9 +663,9 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
 	switch (cmd) {
 	case IOCTL_MEI_CONNECT_CLIENT:
-		dev_dbg(dev->dev, ": IOCTL_MEI_CONNECT_CLIENT.\n");
+		cl_dbg(dev, cl, "IOCTL_MEI_CONNECT_CLIENT\n");
 		if (copy_from_user(&conn, (char __user *)data, sizeof(conn))) {
-			dev_dbg(dev->dev, "failed to copy data from userland\n");
+			cl_dbg(dev, cl, "failed to copy data from userland\n");
 			rets = -EFAULT;
 			goto out;
 		}
@@ -689,7 +686,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
 		/* if all is ok, copying the data back to user. */
 		if (copy_to_user((char __user *)data, &conn, sizeof(conn))) {
-			dev_dbg(dev->dev, "failed to copy data to userland\n");
+			cl_dbg(dev, cl, "failed to copy data to userland\n");
 			rets = -EFAULT;
 			goto out;
 		}
@@ -697,10 +694,10 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 		break;
 
 	case IOCTL_MEI_CONNECT_CLIENT_VTAG:
-		dev_dbg(dev->dev, "IOCTL_MEI_CONNECT_CLIENT_VTAG\n");
+		cl_dbg(dev, cl, "IOCTL_MEI_CONNECT_CLIENT_VTAG\n");
 		if (copy_from_user(&conn_vtag, (char __user *)data,
 				   sizeof(conn_vtag))) {
-			dev_dbg(dev->dev, "failed to copy data from userland\n");
+			cl_dbg(dev, cl, "failed to copy data from userland\n");
 			rets = -EFAULT;
 			goto out;
 		}
@@ -711,13 +708,13 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
 		rets = mei_vt_support_check(dev, cl_uuid);
 		if (rets == -EOPNOTSUPP)
-			dev_dbg(dev->dev, "FW Client %pUl does not support vtags\n",
+			cl_dbg(dev, cl, "FW Client %pUl does not support vtags\n",
 				cl_uuid);
 		if (rets)
 			goto out;
 
 		if (!vtag) {
-			dev_dbg(dev->dev, "vtag can't be zero\n");
+			cl_dbg(dev, cl, "vtag can't be zero\n");
 			rets = -EINVAL;
 			goto out;
 		}
@@ -729,7 +726,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 		/* if all is ok, copying the data back to user. */
 		if (copy_to_user((char __user *)data, &conn_vtag,
 				 sizeof(conn_vtag))) {
-			dev_dbg(dev->dev, "failed to copy data to userland\n");
+			cl_dbg(dev, cl, "failed to copy data to userland\n");
 			rets = -EFAULT;
 			goto out;
 		}
@@ -737,10 +734,10 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 		break;
 
 	case IOCTL_MEI_NOTIFY_SET:
-		dev_dbg(dev->dev, ": IOCTL_MEI_NOTIFY_SET.\n");
+		cl_dbg(dev, cl, "IOCTL_MEI_NOTIFY_SET\n");
 		if (copy_from_user(&notify_req,
 				   (char __user *)data, sizeof(notify_req))) {
-			dev_dbg(dev->dev, "failed to copy data from userland\n");
+			cl_dbg(dev, cl, "failed to copy data from userland\n");
 			rets = -EFAULT;
 			goto out;
 		}
@@ -748,15 +745,15 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 		break;
 
 	case IOCTL_MEI_NOTIFY_GET:
-		dev_dbg(dev->dev, ": IOCTL_MEI_NOTIFY_GET.\n");
+		cl_dbg(dev, cl, "IOCTL_MEI_NOTIFY_GET\n");
 		rets = mei_ioctl_client_notify_get(file, &notify_get);
 		if (rets)
 			goto out;
 
-		dev_dbg(dev->dev, "copy connect data to user\n");
+		cl_dbg(dev, cl, "copy connect data to user\n");
 		if (copy_to_user((char __user *)data,
 				&notify_get, sizeof(notify_get))) {
-			dev_dbg(dev->dev, "failed to copy data to userland\n");
+			cl_dbg(dev, cl, "failed to copy data to userland\n");
 			rets = -EFAULT;
 			goto out;
 
-- 
2.43.0


