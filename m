Return-Path: <linux-kernel+bounces-638230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A208AAE2EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C26052645E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8F28AB0A;
	Wed,  7 May 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eFVs6h7h"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A688289E33
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627490; cv=none; b=Qisw5Ks30aqcK2llsPWS3wID/6Kf3gChQDIJfEAmZCtbun9B2PFxZHWx04appnCFPSxrZ/ESRYjjK4gV0Hgebl05dSqoeo6SBNd6S6diPD70JKXyB4P2NLs3b10eqpgr1kDQZlVkk8+1MGqKzOJn7DRsRczBUf+9OpqSuTCqxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627490; c=relaxed/simple;
	bh=z5pSE65ULIjqvpmH+J9vRAyHolUkWZ/Oap1Uu7HAaSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkWMBqgFo1dWlC95PWwH5sENp284x4QYwBLgIQI++KS8SoeB8oN/XDZd2YYCjaa4mIpoVJbJ/ZuT79Kj7NcxA6gGuBBv3CcVv8h158LWs/FVgraf+wu6EV/SM1RX+JCB9wYhZJI8b6bxZvSvbCCc6ztwelSHBuLETr4XluZcNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eFVs6h7h; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746627483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/32H+9/41lr99VTZd+rMmdnuXbjt0IaFlsmmN5aVGwc=;
	b=eFVs6h7hQ4X5aTOrzTFfWANQ2NH9vy51F4wteOdrqeIaY5lWZHtPB0eCKm5YIQ5N50i49N
	z38UXgiKr4rG2j2zMss5Ff6LHzC2C3XLxG5bkFDanrcEY6nac8oK0q0asq9YhS1hiPgljy
	/uFdVv5MLQOv7cUVhmRwWJbpOnT25aI=
From: Dawei Li <dawei.li@linux.dev>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com
Subject: [PATCH 3/3] rpmsg: ctrl: Introduce RPMSG_CREATE_EPT_FD_IOCTL uAPI
Date: Wed,  7 May 2025 22:17:12 +0800
Message-Id: <20250507141712.4276-4-dawei.li@linux.dev>
In-Reply-To: <20250507141712.4276-1-dawei.li@linux.dev>
References: <20250507141712.4276-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement RPMSG_CREATE_EPT_FD_IOCTL, new uAPI for rpmsg ctrl, which
shares most of operations of RPMSG_CREATE_EPT_IOCTL except that it
returns fd representing eptdev to userspace directly.

Possible calling procedures for userspace are:
- fd = open("/dev/rpmsg_ctrlX")
- ioctl(fd, RPMSG_CREATE_EPT_FD_IOCTL, &info);
- fd_ep = info.fd
- operations on fd_ep(write, read, poll ioctl)
- ioctl(fd_ep, RPMSG_DESTROY_EPT_IOCTL)
- close(fd_ep)
- close(fd)

Signed-off-by: Dawei Li <dawei.li@linux.dev>
---
 drivers/rpmsg/rpmsg_ctrl.c | 37 +++++++++++++++++++++++++++++--------
 include/uapi/linux/rpmsg.h | 19 +++++++++++++++++++
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index 28f57945ccd9..c2cfdf46ccc6 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -75,19 +75,32 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 				unsigned long arg)
 {
 	struct rpmsg_ctrldev *ctrldev = fp->private_data;
+	struct rpmsg_endpoint_fd_info ept_fd_info;
 	void __user *argp = (void __user *)arg;
 	struct rpmsg_endpoint_info eptinfo;
 	struct rpmsg_channel_info chinfo;
 	struct rpmsg_device *rpdev;
 	int ret = 0;
-
-	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
-		return -EFAULT;
-
-	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
-	chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
-	chinfo.src = eptinfo.src;
-	chinfo.dst = eptinfo.dst;
+	int fd = -1;
+
+	if (cmd == RPMSG_CREATE_EPT_IOCTL || cmd == RPMSG_CREATE_DEV_IOCTL ||
+	    cmd == RPMSG_RELEASE_DEV_IOCTL) {
+		if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
+			return -EFAULT;
+
+		memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
+		chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
+		chinfo.src = eptinfo.src;
+		chinfo.dst = eptinfo.dst;
+	} else if (cmd == RPMSG_CREATE_EPT_FD_IOCTL) {
+		if (copy_from_user(&ept_fd_info, argp, sizeof(ept_fd_info)))
+			return -EFAULT;
+
+		memcpy(chinfo.name, ept_fd_info.name, RPMSG_NAME_SIZE);
+		chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
+		chinfo.src = ept_fd_info.src;
+		chinfo.dst = ept_fd_info.dst;
+	}
 
 	mutex_lock(&ctrldev->ctrl_lock);
 	switch (cmd) {
@@ -110,6 +123,14 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 				chinfo.name, ret);
 		break;
 
+	case RPMSG_CREATE_EPT_FD_IOCTL:
+		ret = rpmsg_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo, &fd);
+		if (!ret) {
+			ept_fd_info.fd = fd;
+			ret = copy_to_user(argp, &ept_fd_info, sizeof(ept_fd_info));
+		}
+		break;
+
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
index f0c8da2b185b..934c0e76bfe3 100644
--- a/include/uapi/linux/rpmsg.h
+++ b/include/uapi/linux/rpmsg.h
@@ -53,4 +53,23 @@ struct rpmsg_endpoint_info {
  */
 #define RPMSG_SET_INCOMING_FLOWCONTROL _IOR(0xb5, 0x6, int)
 
+/**
+ * struct rpmsg_endpoint_fd_info - endpoint & fd info representation
+ * @name: name of service
+ * @src: local address. To set to RPMSG_ADDR_ANY if not used.
+ * @dst: destination address. To set to RPMSG_ADDR_ANY if not used.
+ * @fd: fd returned from driver
+ */
+struct rpmsg_endpoint_fd_info {
+	char name[32];
+	__u32 src;
+	__u32 dst;
+	__s32 fd;
+};
+
+/**
+ * Instantiate a new rmpsg endpoint which is represented by fd
+ */
+#define RPMSG_CREATE_EPT_FD_IOCTL _IOWR(0xb5, 0x7, struct rpmsg_endpoint_fd_info)
+
 #endif
-- 
2.25.1


