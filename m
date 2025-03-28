Return-Path: <linux-kernel+bounces-579671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E1A74748
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188B717EFF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75A21B1AC;
	Fri, 28 Mar 2025 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzyX4McR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85121ADC3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156309; cv=none; b=E/y314Gi+cmzAiC9CglhPlsX2jkRA0v62QSWvWo4J4Jwit8u5NxWYqMvHrwo16cre5r4F5hQZQAvHn8QoPNLhUnhEgkOA1LyksdyNREVn4Muih2PMc5+bY1jNwE5rsdmq9V0ykEYw7Kq8yHSVdB4QEcjkrAdrBeBUIe7qBhZvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156309; c=relaxed/simple;
	bh=wIG24BP4KbeeSBv8xr/nJOYnA/BFHJv/ei7O7EK7sXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPL+9fyRkbxCMKNGL17DH3W5LjTeLoJbuPwdECGHL3YEGVT1Cadut3mwG4o7SXQC/USDQ0VrNOgURoZ7j2lfTLD35KfWPYlXm0VScmS5hEppduqX8g72cM74eaQOJzO8ekpcURVhEFkjK7yN0ULaipXC/TX2KWKYkNVhhjwKBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzyX4McR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=murG6KBh9otTUyvN8dy531qkVUcnNgqF1WBgav4fl0w=;
	b=WzyX4McR/n+RziLp94mk4/FRd5G5jRgr43PicuTgOvKGnvY+IGqs/baoIfzybBByJ41GZl
	1pgI/C6bXNQLMClRuBzNka5jU8V0uSGJddtl9OrJLojz6pV3BhHM66jDJ6ynkoqZApCdQj
	R8mjtVEmAFy4uzoNtplyczv9ILUNCmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-65LlPFQ6PyCWTvnfL9A_6g-1; Fri,
 28 Mar 2025 06:05:05 -0400
X-MC-Unique: 65LlPFQ6PyCWTvnfL9A_6g-1
X-Mimecast-MFC-AGG-ID: 65LlPFQ6PyCWTvnfL9A_6g_1743156304
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06E391801A06;
	Fri, 28 Mar 2025 10:05:04 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EFF219541A5;
	Fri, 28 Mar 2025 10:04:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 6/8] vhost: uapi to control task mode (owner vs kthread)
Date: Fri, 28 Mar 2025 18:02:50 +0800
Message-ID: <20250328100359.1306072-7-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
References: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new UAPI to configure the vhost device to use the kthread mode
The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
to choose between owner and kthread mode if necessary
This setting must be applied before VHOST_SET_OWNER, as the worker
will be created in the VHOST_SET_OWNER function

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
 include/uapi/linux/vhost.h | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index be97028a8baf..ff930c2e5b78 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 	int i;
 
 	vhost_dev_cleanup(dev);
-
+	dev->inherit_owner = true;
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
-
+	if (ioctl == VHOST_FORK_FROM_OWNER) {
+		u8 inherit_owner;
+		/*inherit_owner can only be modified before owner is set*/
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
+			r = -EFAULT;
+			goto done;
+		}
+		if (inherit_owner > 1) {
+			r = -EINVAL;
+			goto done;
+		}
+		d->inherit_owner = (bool)inherit_owner;
+		r = 0;
+		goto done;
+	}
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..1ae0917bfeca 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,20 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/**
+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device,
+ * This ioctl must called before VHOST_SET_OWNER.
+ *
+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When inherit_owner is set to 1(default value):
+ *   - Vhost will create tasks similar to processes forked from the owner,
+ *     inheriting all of the owner's attributes.
+ *
+ * When inherit_owner is set to 0:
+ *   - Vhost will create tasks as kernel thread.
+ */
+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
 #endif
-- 
2.45.0


