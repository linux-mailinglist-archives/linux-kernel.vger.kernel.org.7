Return-Path: <linux-kernel+bounces-724029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD4BAFEDB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E144E4E7FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D542E7F37;
	Wed,  9 Jul 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSiQv7Vq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E22E9EA5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074819; cv=none; b=mBEDMNF7KrCD56OSRf/kWspu5cW3QNdkvymbF0jRtP+QLlrD7uOE6K1gu0X5KwoBLkoZ4c7UXqzJcY4uSCoNRnsbr468x6QsXvVUQeduIoQJd9d6d4PJqfWUP12jwWtPbfu0bflKd1ySRXKCDCG3A8COQq+AkUH/J/HfdmTjBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074819; c=relaxed/simple;
	bh=Ln72KTOh4ZuEvNNyPrUYIShjo2sS1u7jxQm/geLLCnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDzmj1hqiv2D0yT6/+BiG96/HadfuQTrbZuIToaaOlJeA1rh/MK6oFH8jicsFF/NxubUJZdaT3KKmNzz/abgvIt/ypx6mMmQLXyiE0dX6P6fUr+LnU/ubyBc+yrRcUV4Udi2x4jao/OuJNl0ZhmBr3wI4up28oZe7OkvQFn/3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSiQv7Vq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752074818; x=1783610818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ln72KTOh4ZuEvNNyPrUYIShjo2sS1u7jxQm/geLLCnc=;
  b=KSiQv7VqXlgIayLNQ/7qxi/xvg5dyGGjmcSpLKj4841Px5OC/5v7J0z0
   iMtE7z7/pa83P62Lg4K/YWn+UmcOiQbkFKizi9nrhsnz8l7GUHt/943GE
   2fvtnCjdX3VsigQ0M+30vBnNNQCRhSOdFgGQPy2i0BzfYgg1PktL0IpoU
   5eV6JXSPOvnhWeiEF2clQwbebeIMNYywO4ATX3p07+g6y+2CUsFvRedsK
   uhTzSRH+pPqfcM9P8Ey7mzkAQ1sF8yK1B2Ota6eG1KAD0LkOf9A67X5Ps
   02cobr1J/d35+5pLcnPO6gNMSqUx5kkuHVKI5u12pdA3lV43vyIMFUhzH
   g==;
X-CSE-ConnectionGUID: AnxxDuB9RRy+UyRRcvFujw==
X-CSE-MsgGUID: ZA89+/rLRJuxBh6jZBTu9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54487390"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54487390"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:57 -0700
X-CSE-ConnectionGUID: rDAgtnLfRASINjWd1ei0hQ==
X-CSE-MsgGUID: aHZuZ2NRS1KP+RUQ7smHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155557868"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:55 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v3 4/5] mei: more prints with client prefix
Date: Wed,  9 Jul 2025 18:13:43 +0300
Message-ID: <20250709151344.104942-5-alexander.usyskin@intel.com>
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

Use client-aware print macro instead of usual device print in
more places to expand debug-ability.
The client-aware print macro prefixes the usual device print
with current connection endpoints.

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
index 5335cf39d663..90c9eef0d876 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -258,7 +258,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 	length = min_t(size_t, length, cb->buf_idx - *offset);
 
 	if (copy_to_user(ubuf, cb->buf.data + *offset, length)) {
-		dev_dbg(dev->dev, "failed to copy data to userland\n");
+		cl_dbg(dev, cl, "failed to copy data to userland\n");
 		rets = -EFAULT;
 		goto free;
 	}
@@ -381,7 +381,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 
 	rets = copy_from_user(cb->buf.data, ubuf, length);
 	if (rets) {
-		dev_dbg(dev->dev, "failed to copy data from userland\n");
+		cl_dbg(dev, cl, "failed to copy data from userland\n");
 		rets = -EFAULT;
 		mei_io_cb_free(cb);
 		goto out;
@@ -423,7 +423,7 @@ static int mei_ioctl_connect_client(struct file *file,
 	/* find ME client we're trying to connect to */
 	me_cl = mei_me_cl_by_uuid(dev, in_client_uuid);
 	if (!me_cl) {
-		dev_dbg(dev->dev, "Cannot connect to FW Client UUID = %pUl\n",
+		cl_dbg(dev, cl, "Cannot connect to FW Client UUID = %pUl\n",
 			in_client_uuid);
 		rets = -ENOTTY;
 		goto end;
@@ -433,24 +433,21 @@ static int mei_ioctl_connect_client(struct file *file,
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
 
@@ -517,19 +514,19 @@ static int mei_ioctl_connect_vtag(struct file *file,
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
 
@@ -548,7 +545,7 @@ static int mei_ioctl_connect_vtag(struct file *file,
 				continue;
 
 			/* replace cl with acquired one */
-			dev_dbg(dev->dev, "replacing with existing cl\n");
+			cl_dbg(dev, cl, "replacing with existing cl\n");
 			mei_cl_unlink(cl);
 			kfree(cl);
 			file->private_data = pos;
@@ -658,7 +655,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
 	dev = cl->dev;
 
-	dev_dbg(dev->dev, "IOCTL cmd = 0x%x", cmd);
+	cl_dbg(dev, cl, "IOCTL cmd = 0x%x", cmd);
 
 	mutex_lock(&dev->device_lock);
 	if (dev->dev_state != MEI_DEV_ENABLED) {
@@ -668,9 +665,9 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
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
@@ -691,7 +688,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
 		/* if all is ok, copying the data back to user. */
 		if (copy_to_user((char __user *)data, &conn, sizeof(conn))) {
-			dev_dbg(dev->dev, "failed to copy data to userland\n");
+			cl_dbg(dev, cl, "failed to copy data to userland\n");
 			rets = -EFAULT;
 			goto out;
 		}
@@ -699,10 +696,10 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
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
@@ -713,13 +710,13 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
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
@@ -731,7 +728,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 		/* if all is ok, copying the data back to user. */
 		if (copy_to_user((char __user *)data, &conn_vtag,
 				 sizeof(conn_vtag))) {
-			dev_dbg(dev->dev, "failed to copy data to userland\n");
+			cl_dbg(dev, cl, "failed to copy data to userland\n");
 			rets = -EFAULT;
 			goto out;
 		}
@@ -739,10 +736,10 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
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
@@ -750,15 +747,15 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
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


