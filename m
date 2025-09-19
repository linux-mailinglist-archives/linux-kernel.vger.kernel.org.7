Return-Path: <linux-kernel+bounces-824281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B5B888F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9734C5A1EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12820304973;
	Fri, 19 Sep 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMpVkzPQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD92F3C02
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274370; cv=none; b=HjZ+ytqI9Z0zkLPPP808Gt0+YUCWlzxeNK94+PwXPZbLOpdVUNCeR6Hl40gNK6HGxmSxzBmHfRFefcEQp+Qab5awmo98I6M1B/RqY1Auq5+5W9a8oEwxL9MNYOJsoD4ZTIUCUHLugtrQ6QVZJktdk6C91WJvoS4nfS/wAnpvKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274370; c=relaxed/simple;
	bh=9PYuUF/DYNZD3i4NXd60/aqNFPJGSMuk3TXdcJ3Krww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqjdnZwc+gyxGsL5YXRE4ySgyAuZjorVHUDk0sB4rpFWdkpeZsqGCfn4CmlrotJBhHifbMg4PG4+LqdRtF1wqDHYPGYRL3x4rzDNOc0hc2AXraulnCpwiZ0V4xWAs7v2csvxM7nJfgA7RFa6hvAYqHwBnZRpd/cPZTno2iXtsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMpVkzPQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758274367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/QNNhx0VTtnBtXTR4YMB03fF9qZTx0+PBNjpo35Ye4=;
	b=UMpVkzPQYC4l7kr54yRw+uKEIZJKSHHFxRuz9Ajg4p996+SFvgaV+v8r3KsH1AlLl/R3Xx
	0oJQD2lHu3yepwfmR85LK0zIYD/Z3vYustgEZj4uJv4pdSURxtfjVSsa03F9vqRR09LCC3
	mWLT2+7TP8Op+Gh+xJyxad8U20IgJdw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-eLsjEUEoOG6-qwprAejz2w-1; Fri,
 19 Sep 2025 05:32:43 -0400
X-MC-Unique: eLsjEUEoOG6-qwprAejz2w-1
X-Mimecast-MFC-AGG-ID: eLsjEUEoOG6-qwprAejz2w_1758274362
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8037F1955F2B;
	Fri, 19 Sep 2025 09:32:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 373F71956045;
	Fri, 19 Sep 2025 09:32:37 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 1/6] vduse: make domain_lock an rwlock
Date: Fri, 19 Sep 2025 11:32:26 +0200
Message-ID: <20250919093231.960393-2-eperezma@redhat.com>
In-Reply-To: <20250919093231.960393-1-eperezma@redhat.com>
References: <20250919093231.960393-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

It will be used in a few more scenarios read-only so make it more
scalable.

Suggested-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2: New in v2
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 41 +++++++++++++++---------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e7bced0b5542..2b6a8958ffe0 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -14,6 +14,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/eventfd.h>
+#include <linux/rwlock.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/dma-map-ops.h>
@@ -117,7 +118,7 @@ struct vduse_dev {
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
-	struct mutex domain_lock;
+	rwlock_t domain_lock;
 };
 
 struct vduse_dev_msg {
@@ -1176,9 +1177,9 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (entry.start > entry.last)
 			break;
 
-		mutex_lock(&dev->domain_lock);
+		read_lock(&dev->domain_lock);
 		if (!dev->domain) {
-			mutex_unlock(&dev->domain_lock);
+			read_unlock(&dev->domain_lock);
 			break;
 		}
 		spin_lock(&dev->domain->iotlb_lock);
@@ -1193,7 +1194,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.perm = map->perm;
 		}
 		spin_unlock(&dev->domain->iotlb_lock);
-		mutex_unlock(&dev->domain_lock);
+		read_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
 			break;
@@ -1346,10 +1347,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(umem.reserved)))
 			break;
 
-		mutex_lock(&dev->domain_lock);
+		write_lock(&dev->domain_lock);
 		ret = vduse_dev_reg_umem(dev, umem.iova,
 					 umem.uaddr, umem.size);
-		mutex_unlock(&dev->domain_lock);
+		write_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_DEREG_UMEM: {
@@ -1363,10 +1364,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (!is_mem_zero((const char *)umem.reserved,
 				 sizeof(umem.reserved)))
 			break;
-		mutex_lock(&dev->domain_lock);
+		write_lock(&dev->domain_lock);
 		ret = vduse_dev_dereg_umem(dev, umem.iova,
 					   umem.size);
-		mutex_unlock(&dev->domain_lock);
+		write_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_GET_INFO: {
@@ -1385,9 +1386,9 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(info.reserved)))
 			break;
 
-		mutex_lock(&dev->domain_lock);
+		read_lock(&dev->domain_lock);
 		if (!dev->domain) {
-			mutex_unlock(&dev->domain_lock);
+			read_unlock(&dev->domain_lock);
 			break;
 		}
 		spin_lock(&dev->domain->iotlb_lock);
@@ -1402,7 +1403,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				info.capability |= VDUSE_IOVA_CAP_UMEM;
 		}
 		spin_unlock(&dev->domain->iotlb_lock);
-		mutex_unlock(&dev->domain_lock);
+		read_unlock(&dev->domain_lock);
 		if (!map)
 			break;
 
@@ -1425,10 +1426,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 {
 	struct vduse_dev *dev = file->private_data;
 
-	mutex_lock(&dev->domain_lock);
+	write_lock(&dev->domain_lock);
 	if (dev->domain)
 		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
-	mutex_unlock(&dev->domain_lock);
+	write_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
 	list_splice_init(&dev->recv_list, &dev->send_list);
@@ -1647,7 +1648,7 @@ static struct vduse_dev *vduse_dev_create(void)
 
 	mutex_init(&dev->lock);
 	mutex_init(&dev->mem_lock);
-	mutex_init(&dev->domain_lock);
+	rwlock_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
 	INIT_LIST_HEAD(&dev->recv_list);
@@ -1805,7 +1806,7 @@ static ssize_t bounce_size_store(struct device *device,
 	int ret;
 
 	ret = -EPERM;
-	mutex_lock(&dev->domain_lock);
+	write_lock(&dev->domain_lock);
 	if (dev->domain)
 		goto unlock;
 
@@ -1821,7 +1822,7 @@ static ssize_t bounce_size_store(struct device *device,
 	dev->bounce_size = bounce_size & PAGE_MASK;
 	ret = count;
 unlock:
-	mutex_unlock(&dev->domain_lock);
+	write_unlock(&dev->domain_lock);
 	return ret;
 }
 
@@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret)
 		return ret;
 
-	mutex_lock(&dev->domain_lock);
+	write_lock(&dev->domain_lock);
 	if (!dev->domain)
 		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
 						  dev->bounce_size);
-	mutex_unlock(&dev->domain_lock);
+	write_unlock(&dev->domain_lock);
 	if (!dev->domain) {
 		put_device(&dev->vdev->vdpa.dev);
 		return -ENOMEM;
@@ -2059,10 +2060,10 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
-		mutex_lock(&dev->domain_lock);
+		write_lock(&dev->domain_lock);
 		vduse_domain_destroy(dev->domain);
 		dev->domain = NULL;
-		mutex_unlock(&dev->domain_lock);
+		write_unlock(&dev->domain_lock);
 		return ret;
 	}
 
-- 
2.51.0


