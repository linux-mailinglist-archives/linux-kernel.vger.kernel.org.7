Return-Path: <linux-kernel+bounces-612130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B7A94B29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 04:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF243AFF71
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252EF25742F;
	Mon, 21 Apr 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSAa8VbM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088721CC46
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203524; cv=none; b=myWYOmz1EIMBUGNjfN+9BPJx3lbhML48a1CRJzKJCXtObAsqXr+vNpstF843ySQPgsvdovJ4JM2DnTHGxEf7vCfv2/rPg/0HLN9jC5FrsBDmOl243CZqh0HYB+L9Hl5a8ODl//n2+ypkLBJ+smTbNSd0gv33OXp8n+P5F+vRwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203524; c=relaxed/simple;
	bh=A4Zbqm+MVJZCQcrr+9Ai/1+sO4076QEbyY00hQ6PoxI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN8x4j3MwrqwBleQBiNzgxxDA5MF42jSndyJ/2WFjEbR6+1DTaEMxDP5EHVCB/xOcN6EWPd7TqSUBG7Za9fMAp42Ds6Ds8gOn/yFWuBlHEhRk0nSsk8SnyDAErEd0n1hKR2XuGIwXC4Go6E/jws47n8CH66zoVckdsc+ROwmc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSAa8VbM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745203522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ss3P3+pIl4el626c6K08/+BeDbxgovbAazzfH4/0Z1Y=;
	b=KSAa8VbMdx55AVQvQtn2Yj+eia5AkaadYpdWpB1j1Q+D88q5DL7AecHV8IappLMT+HD83v
	FJrivmVnD2XqNRwFq/yW4XW07/3cGvzJtv3HZsDWD/CIX3O4cUEZ0l6C4GZse2sjWcHCVK
	1jBWz6u4Fh2Ua2ZHIUEmDQkykEWcfYM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-anIgpWsfMui2vWWiVhyiuw-1; Sun,
 20 Apr 2025 22:45:20 -0400
X-MC-Unique: anIgpWsfMui2vWWiVhyiuw-1
X-Mimecast-MFC-AGG-ID: anIgpWsfMui2vWWiVhyiuw_1745203519
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C18A91800368;
	Mon, 21 Apr 2025 02:45:19 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD7D4180175B;
	Mon, 21 Apr 2025 02:45:15 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v9 3/4] vhost: add VHOST_FORK_FROM_OWNER ioctl and validate inherit_owner
Date: Mon, 21 Apr 2025 10:44:09 +0800
Message-ID: <20250421024457.112163-4-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-1-lulu@redhat.com>
References: <20250421024457.112163-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a new UAPI to configure the vhost device to use the kthread mode.
The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
to choose between owner and kthread mode if necessary.
This setting must be applied before VHOST_SET_OWNER, as the worker
will be created in the VHOST_SET_OWNER function.

In addition, the VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to add a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 29 +++++++++++++++++++++++++++--
 include/uapi/linux/vhost.h | 16 ++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index be97028a8baf..fb0c7fb43f78 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!dev->inherit_owner)
+			return -EFAULT;
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
@@ -1134,7 +1141,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 	int i;
 
 	vhost_dev_cleanup(dev);
-
+	dev->inherit_owner = true;
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -2287,7 +2294,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
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


