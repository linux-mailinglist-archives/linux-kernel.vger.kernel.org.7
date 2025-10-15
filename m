Return-Path: <linux-kernel+bounces-854761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39FDBDF501
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A1119C7119
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728C14BFA2;
	Wed, 15 Oct 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="udULT81v"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BC2FB985
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541559; cv=none; b=gyuYOjA6CzKRndFrivAWn90fwpLVE0yny8PFZcu0gBwGwaHzrRwhKpqtvHNbGvjCneZYDPlpOZ4Boe5eOF3OeAWyR6vAcBh+GS//nR/isDO6g3qBouCwTLdSyRNQtvn5E0halw+RlRUNxRvK3Po+Nl7N1O3CbhsIT7oGr9uej7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541559; c=relaxed/simple;
	bh=a9xKhDk+BGtJ4JiaTrGo1b0mvMJxDoS0zpI5Gu5pD4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3E/Yj+h2fD1f2CU1/dMDNUts100TpiRjXPeA/r6lmLrplBi1kB8De+H8p0vzt4K+3xUZqMmyWiol/oOYaI+BkRX+5roIR+fVdZJdf+FpJ2I6QjBjmhFSxgBnKgJ+KC/xvv45g+9Swwk1DL7NKkz5nCK3BWpRGZE4o01ECEJryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=udULT81v; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760541553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSAoHN+I0q5gvwL07/+w9FpvcidtI68SZ5LkGFNNr6w=;
	b=udULT81vHIEVtIBF5XvtutmVrlGPzNupoyXCUuAEkSjJ5KIHh+zFjEWykswdr5yVjG9eAv
	S2y3mltUcBCzV9/DoUrxNsqRQtreuXr4DGXKGSwGIkjWff9qBg0OHS/MKV/rZEW9VL59DF
	c2ZDhOOd2eIZ1QLTvCqFHicpK3drHjk=
From: Dawei Li <dawei.li@linux.dev>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com
Subject: [PATCH v5 3/3] rpmsg: ctrl: Introduce RPMSG_CREATE_EPT_FD_IOCTL uAPI
Date: Wed, 15 Oct 2025 23:17:18 +0800
Message-Id: <20251015151718.3927-4-dawei.li@linux.dev>
In-Reply-To: <20251015151718.3927-1-dawei.li@linux.dev>
References: <20251015151718.3927-1-dawei.li@linux.dev>
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
 drivers/rpmsg/rpmsg_ctrl.c | 35 ++++++++++++++++++++++++++++-------
 include/uapi/linux/rpmsg.h | 27 ++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index 28f57945ccd9..efb207506e5c 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -75,19 +75,30 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 				unsigned long arg)
 {
 	struct rpmsg_ctrldev *ctrldev = fp->private_data;
+	struct rpmsg_endpoint_fd_info ept_fd_info;
 	void __user *argp = (void __user *)arg;
 	struct rpmsg_endpoint_info eptinfo;
 	struct rpmsg_channel_info chinfo;
 	struct rpmsg_device *rpdev;
 	int ret = 0;
 
-	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
-		return -EFAULT;
-
-	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
-	chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
-	chinfo.src = eptinfo.src;
-	chinfo.dst = eptinfo.dst;
+	if (cmd == RPMSG_CREATE_EPT_FD_IOCTL) {
+		if (copy_from_user(&ept_fd_info, argp, sizeof(ept_fd_info)))
+			return -EFAULT;
+
+		memcpy(chinfo.name, ept_fd_info.name, RPMSG_NAME_SIZE);
+		chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
+		chinfo.src = ept_fd_info.src;
+		chinfo.dst = ept_fd_info.dst;
+	} else {
+		if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
+			return -EFAULT;
+
+		memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
+		chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
+		chinfo.src = eptinfo.src;
+		chinfo.dst = eptinfo.dst;
+	}
 
 	mutex_lock(&ctrldev->ctrl_lock);
 	switch (cmd) {
@@ -110,6 +121,16 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 				chinfo.name, ret);
 		break;
 
+	case RPMSG_CREATE_EPT_FD_IOCTL:
+		ret = rpmsg_anonymous_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo,
+						    ept_fd_info.flags, &ept_fd_info.fd);
+		if (ret)
+			break;
+
+		if (copy_to_user(argp, &ept_fd_info, sizeof(ept_fd_info)))
+			ret = -EFAULT;
+		break;
+
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
index f0c8da2b185b..02befb298f71 100644
--- a/include/uapi/linux/rpmsg.h
+++ b/include/uapi/linux/rpmsg.h
@@ -29,7 +29,8 @@ struct rpmsg_endpoint_info {
 #define RPMSG_CREATE_EPT_IOCTL	_IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
 
 /**
- * Destroy a rpmsg char device endpoint created by the RPMSG_CREATE_EPT_IOCTL.
+ * Destroy a rpmsg char device endpoint created by the RPMSG_CREATE_EPT_IOCTL
+ * or RPMSG_CREATE_EPT_FD_IOCTL.
  */
 #define RPMSG_DESTROY_EPT_IOCTL	_IO(0xb5, 0x2)
 
@@ -53,4 +54,28 @@ struct rpmsg_endpoint_info {
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


