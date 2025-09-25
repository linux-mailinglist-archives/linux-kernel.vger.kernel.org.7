Return-Path: <linux-kernel+bounces-832057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E24B9E403
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D29F189247C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482DA2E9ECD;
	Thu, 25 Sep 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWFhLQ5p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781E2E92DA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791633; cv=none; b=eGnGav/rCFOYnKDHVc4B086fT73v8VlPyuFbJBTdt+0UVH0O9GP/fEkwoNtYSp+HNoqIy+huJhrmKRRRYCms2Qyx5K+AhmgEIu3r4qnpu2KVoCxjAxo5JRq2I7WqLGalxKDav+4CRzqZsXF2SYwjZ4pN0rf473P64cKjdShhMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791633; c=relaxed/simple;
	bh=9PYuUF/DYNZD3i4NXd60/aqNFPJGSMuk3TXdcJ3Krww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sF8Pjpj/mgXR9+S4hBSk1262FuI+ecg0V2+DZUxfR6ofws9nCRG+aUbviuJTTgdSZdJ7YKmc9/UAkNHf4zUzzSooR5ts/3EfxpwYrAVow0n4t6akXKCLw6Y/qpDzu/2WGsLDj2CTBTVmjv7zkrNtZ+7JiI3NIl5rlttYkeFQTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWFhLQ5p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758791630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/QNNhx0VTtnBtXTR4YMB03fF9qZTx0+PBNjpo35Ye4=;
	b=dWFhLQ5pRaI/K7v4nfZcrsPpNZS7kAcPMrqzmfFVUkr8zSNzHYn7+cvBsyX4X8h80C0+DA
	sZhQ6muJs+KBXE6RcP+2RiyBgGKgSNG51JRcv2LRjsL6/DtG/emHZxhrAw+CyqpqSylpGR
	GanDMcKCn31acg5B9/IRAbYl8H+Q4S0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-jhPUio_GNyG1upvAI_BmVg-1; Thu,
 25 Sep 2025 05:13:47 -0400
X-MC-Unique: jhPUio_GNyG1upvAI_BmVg-1
X-Mimecast-MFC-AGG-ID: jhPUio_GNyG1upvAI_BmVg_1758791626
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3543180057C;
	Thu, 25 Sep 2025 09:13:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCD631956095;
	Thu, 25 Sep 2025 09:13:41 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 1/6] vduse: make domain_lock an rwlock
Date: Thu, 25 Sep 2025 11:13:30 +0200
Message-ID: <20250925091335.1964283-2-eperezma@redhat.com>
In-Reply-To: <20250925091335.1964283-1-eperezma@redhat.com>
References: <20250925091335.1964283-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


