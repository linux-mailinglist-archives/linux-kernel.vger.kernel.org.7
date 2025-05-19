Return-Path: <linux-kernel+bounces-653987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF096ABC1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF97171C01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845328540C;
	Mon, 19 May 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e1whcEFn"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2102853FF
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667354; cv=none; b=aWShqxxuDq9lq+KJfAIFDmkBf54Lpk/UEb56ME7Jvc4iKAK+H7emcEmZYkMFGEDBdnmcr/pPBVGoG+jsvUwQLo+AHVsFh+vp8RfNDVYBRF/tQEsT+d2q2M15y/GFkj63OgKlIPb7eI04UYk7S2S/bHubTD02OVM5wz3yzHZ9T10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667354; c=relaxed/simple;
	bh=K9pHUUfcBh8E7oWn0vn0FhcZtgEcCkJVYQ0SWIH5A8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1lN3osW5sDHU82XrIbm1hyQ7v8yXgLaRG6uXB/X0SO0vPWy9iOtFKRsjr8R2FOUvcb0O7uHmped5Y4+sTTMR5DDIyMNh78fGrTviWhNCxAjSU1f4qFkl61Y0vmp9vpyNvCnmdy+s/r7S7tq1FVQGwBNa6NLlJmWeolsMoeAB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e1whcEFn; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747667348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM95Zlz9aBhzKf6NPGkqfcRpAXkHJ5m9qaPIrpPg3sg=;
	b=e1whcEFnjfk2P6ChuYiXWHzZwbGEjbyi77kM3XvLJ78Q4Lb1AA1zqCKioFryiNO6bc0sE3
	CDe6kQ2HffAYvI+CalrkrMVlnEb7mWzzTmkWq73AK4hUyZAlo0f4N9EMj83jdf+elgPXJf
	MZ4nIQ7iu8qpcCt01HvgUxeQbfVPieQ=
From: Dawei Li <dawei.li@linux.dev>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com
Subject: [PATCH v3 3/3] rpmsg: ctrl: Introduce RPMSG_CREATE_EPT_FD_IOCTL uAPI
Date: Mon, 19 May 2025 23:08:23 +0800
Message-Id: <20250519150823.62350-4-dawei.li@linux.dev>
In-Reply-To: <20250519150823.62350-1-dawei.li@linux.dev>
References: <20250519150823.62350-1-dawei.li@linux.dev>
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
 drivers/rpmsg/rpmsg_ctrl.c | 38 ++++++++++++++++++++++++++++++--------
 include/uapi/linux/rpmsg.h | 24 ++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index 28f57945ccd9..9f2f118ceb7b 100644
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
@@ -110,6 +123,15 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 				chinfo.name, ret);
 		break;
 
+	case RPMSG_CREATE_EPT_FD_IOCTL:
+		ret = rpmsg_anonymous_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo,
+						    ept_fd_info.flags, &fd);
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
index f0c8da2b185b..e7057bd23577 100644
--- a/include/uapi/linux/rpmsg.h
+++ b/include/uapi/linux/rpmsg.h
@@ -53,4 +53,28 @@ struct rpmsg_endpoint_info {
  */
 #define RPMSG_SET_INCOMING_FLOWCONTROL _IOR(0xb5, 0x6, int)
 
+/**
+ * struct rpmsg_endpoint_fd_info - endpoint & fd info representation
+ * @name: name of service
+ * @src: local address. To set to RPMSG_ADDR_ANY if not used.
+ * @dst: destination address. To set to RPMSG_ADDR_ANY if not used.
+ * @flags: file flags of endpoint device, valid flags:
+ *         O_RDONLY/O_WRONLY/O_RDWR
+ *         O_NONBLOCK
+ *         O_CLOEXEC
+ * @fd: fd returned from driver
+ */
+struct rpmsg_endpoint_fd_info {
+	char name[32];
+	__u32 src;
+	__u32 dst;
+	__u32 flags;
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


