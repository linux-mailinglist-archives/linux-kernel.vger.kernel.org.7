Return-Path: <linux-kernel+bounces-759019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F5B1D720
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EA8727672
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47F24E01D;
	Thu,  7 Aug 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B88poinw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196724728B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567907; cv=none; b=I/Pw0X1AJcN9BxBvi/R03dHl2GM2mG3cjFY5isV7d5i+HfVXdqg79RsDJW4E81ZOkDeoLwiYLH95CQGWU2ydV3XXkzBUc1WnDSr/XLYuziw8vJ7BnhtzdvnEUitlO6fjqkMMpc0qKZfb7K0WnOHH3HGVpvQl7mJT5CQcJRyOfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567907; c=relaxed/simple;
	bh=4GqqtD6r/J+qJYTCtvusDSzd9AUifqrR9yMkqBkYBCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFy48nL1serjIWkoW9QmV53kPM4VJt6kmAFPoCbnvSzwZYB1+qLp9RUMxt/7ZucmBPQ69ZQkNMIfXk9Ubpm2o6zEf7fPhOU8dpmhFBYQ7l9RbRuX15ekg5DnQ5DZTX+qxHXADgWWwRC5vmHYcjKmwEc48D8kyc21GwBaKjMlv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B88poinw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30olQZNnCwbIJcZghnvNoky1fgd4ygoIyrsrUZJTwig=;
	b=B88poinwjEhgjR3qYYTh42jxERdZOBij3MlTG2vRCg3y+xlt+l+PAgOqmwyN6vdcATvF9M
	2iP9P4/PwwwysM+AZ80wGb2qFbKwkacUPL0xSFPrK/6W8AeVlcmxMkCS0tMScYY1nfhgvO
	US+Wrm2UGrWzjr4b2DtL5Q9wgBa3E18=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-KWz9ZUurNiKZJeivLS0bRw-1; Thu,
 07 Aug 2025 07:58:23 -0400
X-MC-Unique: KWz9ZUurNiKZJeivLS0bRw-1
X-Mimecast-MFC-AGG-ID: KWz9ZUurNiKZJeivLS0bRw_1754567902
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AFBD1956089;
	Thu,  7 Aug 2025 11:58:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D597E30001A5;
	Thu,  7 Aug 2025 11:58:17 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [RFC v2 5/7] vduse: add vq group asid support
Date: Thu,  7 Aug 2025 13:57:50 +0200
Message-ID: <20250807115752.1663383-6-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-1-eperezma@redhat.com>
References: <20250807115752.1663383-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add support for assigning Address Space Identifiers (ASIDs) to each VQ
group.  This enables mapping each group into a distinct memory space.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2: Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
part of the struct is the same.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 259 ++++++++++++++++++++++-------
 include/uapi/linux/vduse.h         |  36 +++-
 2 files changed, 230 insertions(+), 65 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index a7a2749f5818..145147c49930 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -51,6 +51,12 @@
  */
 #define VDUSE_MAX_VQ_GROUPS 3
 
+/*
+ * We can do ASID thanks to (ab)using the vduse device and the vdpa one. So no
+ * more than 2.
+ */
+#define VDUSE_MAX_ASID 2
+
 #define IRQ_UNBOUND -1
 
 struct vduse_virtqueue {
@@ -91,6 +97,7 @@ struct vduse_umem {
 };
 
 struct vduse_vq_group_int {
+	struct vduse_iova_domain *domain;
 	struct vduse_dev *dev;
 };
 
@@ -98,7 +105,7 @@ struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
 	struct vduse_virtqueue **vqs;
-	struct vduse_iova_domain *domain;
+	struct vduse_iova_domain *domain[VDUSE_MAX_ASID];
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
@@ -126,7 +133,8 @@ struct vduse_dev {
 	u32 vq_num;
 	u32 vq_align;
 	u32 ngroups;
-	struct vduse_umem *umem;
+	u32 nas;
+	struct vduse_umem *umem[VDUSE_MAX_ASID];
 	struct vduse_vq_group_int groups[VDUSE_MAX_VQ_GROUPS];
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -440,14 +448,28 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+/* Force set the asid to a vq group without a message to the VDUSE device */
+static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
+				       unsigned int group, unsigned int asid)
+{
+	guard(mutex)(&dev->domain_lock);
+	dev->groups[group].domain = dev->domain[asid];
+}
+
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
-	struct vduse_iova_domain *domain = dev->domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
-	if (domain && domain->bounce_map)
-		vduse_domain_reset_bounce_map(domain);
+	for (i = 0; i < dev->nas; i++) {
+		struct vduse_iova_domain *domain = dev->domain[i];
+
+		if (domain && domain->bounce_map)
+			vduse_domain_reset_bounce_map(domain);
+	}
+
+	for (i = 0; i < dev->ngroups; i++)
+		vduse_set_group_asid_nomsg(dev, i, 0);
 
 	down_write(&dev->rwsem);
 
@@ -619,6 +641,29 @@ static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx)
 	return dev->vqs[idx]->vq_desc_group;
 }
 
+static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
+				unsigned int asid)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct vduse_dev_msg msg = { 0 };
+	int r;
+
+	if (dev->api_version < VDUSE_API_VERSION_1 ||
+	    group > dev->ngroups || asid > dev->nas)
+		return -EINVAL;
+
+	msg.req.type = VDUSE_SET_VQ_GROUP_ASID;
+	msg.req.vq_group_asid.group = group;
+	msg.req.vq_group_asid.asid = asid;
+
+	r = vduse_dev_msg_sync(dev, &msg);
+	if (r < 0)
+		return r;
+
+	vduse_set_group_asid_nomsg(dev, group, asid);
+	return 0;
+}
+
 static void *vduse_get_vq_map_token(struct vdpa_device *vdpa, u16 idx)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
@@ -833,13 +878,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	int ret;
 
-	ret = vduse_domain_set_map(dev->domain, iotlb);
+	ret = vduse_domain_set_map(dev->domain[asid], iotlb);
 	if (ret)
 		return ret;
 
 	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
 	if (ret) {
-		vduse_domain_clear_map(dev->domain, iotlb);
+		vduse_domain_clear_map(dev->domain[asid], iotlb);
 		return ret;
 	}
 
@@ -883,6 +928,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.set_group_asid		= vduse_set_group_asid,
 	.get_vq_map_token	= vduse_get_vq_map_token,
 	.free			= vduse_vdpa_free,
 };
@@ -893,8 +939,10 @@ static void vduse_dev_sync_single_for_device(void *token,
 {
 	struct vduse_vq_group_int *group = token;
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain;
 
+	guard(mutex)(&vdev->domain_lock);
+	domain = group->domain;
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
 
@@ -904,8 +952,10 @@ static void vduse_dev_sync_single_for_cpu(void *token,
 {
 	struct vduse_vq_group_int *group = token;
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain;
 
+	guard(mutex)(&vdev->domain_lock);
+	domain = group->domain;
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
 
@@ -916,8 +966,10 @@ static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
 {
 	struct vduse_vq_group_int *group = token;
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain;
 
+	guard(mutex)(&vdev->domain_lock);
+	domain = group->domain;
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
 
@@ -927,8 +979,10 @@ static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
 {
 	struct vduse_vq_group_int *group = token;
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain;
 
+	guard(mutex)(&vdev->domain_lock);
+	domain = group->domain;
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
 
@@ -937,11 +991,13 @@ static void *vduse_dev_alloc_coherent(void *token, size_t size,
 {
 	struct vduse_vq_group_int *group = token;
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain;
 	unsigned long iova;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
+	guard(mutex)(&vdev->domain_lock);
+	domain = group->domain;
 	addr = vduse_domain_alloc_coherent(domain, size,
 					   (dma_addr_t *)&iova, flag);
 	if (!addr)
@@ -958,8 +1014,10 @@ static void vduse_dev_free_coherent(void *token, size_t size,
 {
 	struct vduse_vq_group_int *group = token;
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain;
 
+	guard(mutex)(&vdev->domain_lock);
+	domain = group->domain;
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
@@ -967,8 +1025,10 @@ static size_t vduse_dev_max_mapping_size(void *token)
 {
 	struct vduse_vq_group_int *group = token;
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain;
 
+	guard(mutex)(&vdev->domain_lock);
+	domain = group->domain;
 	return domain->bounce_size;
 }
 
@@ -1107,31 +1167,32 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	return ret;
 }
 
-static int vduse_dev_dereg_umem(struct vduse_dev *dev,
+static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
 				u64 iova, u64 size)
 {
 	int ret;
 
 	mutex_lock(&dev->mem_lock);
 	ret = -ENOENT;
-	if (!dev->umem)
+	if (!dev->umem[asid])
 		goto unlock;
 
 	ret = -EINVAL;
-	if (!dev->domain)
+	if (!dev->domain[asid])
 		goto unlock;
 
-	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
+	if (dev->umem[asid]->iova != iova ||
+	    size != dev->domain[asid]->bounce_size)
 		goto unlock;
 
-	vduse_domain_remove_user_bounce_pages(dev->domain);
-	unpin_user_pages_dirty_lock(dev->umem->pages,
-				    dev->umem->npages, true);
-	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-	mmdrop(dev->umem->mm);
-	vfree(dev->umem->pages);
-	kfree(dev->umem);
-	dev->umem = NULL;
+	vduse_domain_remove_user_bounce_pages(dev->domain[asid]);
+	unpin_user_pages_dirty_lock(dev->umem[asid]->pages,
+				    dev->umem[asid]->npages, true);
+	atomic64_sub(dev->umem[asid]->npages, &dev->umem[asid]->mm->pinned_vm);
+	mmdrop(dev->umem[asid]->mm);
+	vfree(dev->umem[asid]->pages);
+	kfree(dev->umem[asid]);
+	dev->umem[asid] = NULL;
 	ret = 0;
 unlock:
 	mutex_unlock(&dev->mem_lock);
@@ -1139,7 +1200,7 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 }
 
 static int vduse_dev_reg_umem(struct vduse_dev *dev,
-			      u64 iova, u64 uaddr, u64 size)
+			      u32 asid, u64 iova, u64 uaddr, u64 size)
 {
 	struct page **page_list = NULL;
 	struct vduse_umem *umem = NULL;
@@ -1147,14 +1208,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain || !dev->domain->bounce_map ||
-	    size != dev->domain->bounce_size ||
+	if (!dev->domain[asid] || !dev->domain[asid]->bounce_map ||
+	    size != dev->domain[asid]->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
 
 	mutex_lock(&dev->mem_lock);
 	ret = -EEXIST;
-	if (dev->umem)
+	if (dev->umem[asid])
 		goto unlock;
 
 	ret = -ENOMEM;
@@ -1178,7 +1239,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		goto out;
 	}
 
-	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+	ret = vduse_domain_add_user_bounce_pages(dev->domain[asid],
 						 page_list, pinned);
 	if (ret)
 		goto out;
@@ -1191,7 +1252,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	umem->mm = current->mm;
 	mmgrab(current->mm);
 
-	dev->umem = umem;
+	dev->umem[asid] = umem;
 out:
 	if (ret && pinned > 0)
 		unpin_user_pages(page_list, pinned);
@@ -1234,26 +1295,43 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case VDUSE_IOTLB_GET_FD: {
-		struct vduse_iotlb_entry entry;
+		struct vduse_iotlb_entry_v2 entry;
+		struct vduse_iotlb_entry entry_old;
 		struct vhost_iotlb_map *map;
 		struct vdpa_map_file *map_file;
 		struct file *f = NULL;
 
 		ret = -EFAULT;
-		if (copy_from_user(&entry, argp, sizeof(entry)))
-			break;
+		if (dev->api_version >= VDUSE_API_VERSION_1) {
+			if (copy_from_user(&entry, argp, sizeof(entry)))
+				break;
+		} else {
+			if (copy_from_user(&entry_old, argp,
+					   sizeof(entry_old)))
+				break;
+
+			entry.offset = entry_old.offset;
+			entry.start = entry_old.start;
+			entry.last = entry_old.last;
+			entry.asid = 0;
+			entry.perm = entry_old.perm;
+		}
 
 		ret = -EINVAL;
 		if (entry.start > entry.last)
 			break;
 
+		if (entry.asid > dev->nas)
+			break;
+
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		/* TODO accessing an array with idx from userspace, mitigations? */
+		if (!dev->domain[entry.asid]) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->domain[entry.asid]->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->domain[entry.asid]->iotlb,
 					      entry.start, entry.last);
 		if (map) {
 			map_file = (struct vdpa_map_file *)map->opaque;
@@ -1263,7 +1341,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->domain[entry.asid]->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
@@ -1413,12 +1491,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
+		/* TODO: Using asid from userspace, need to mitigate? */
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) ||
+		     umem.asid > dev->nas)
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_reg_umem(dev, umem.iova,
+		ret = vduse_dev_reg_umem(dev, umem.asid, umem.iova,
 					 umem.uaddr, umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
@@ -1431,15 +1513,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
+		/* TODO: Using asid from userspace, need to mitigate? */
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) ||
+		     umem.asid > dev->nas)
+			break;
+
+
+		if (umem.asid > dev->nas)
 			break;
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_dereg_umem(dev, umem.iova,
+		ret = vduse_dev_dereg_umem(dev, umem.asid, umem.iova,
 					   umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
 	}
+	/* TODO can we merge this with GET_FD? */
 	case VDUSE_IOTLB_GET_INFO: {
 		struct vduse_iova_info info;
 		struct vhost_iotlb_map *map;
@@ -1452,27 +1543,32 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (info.start > info.last)
 			break;
 
+		if (info.asid > dev->nas)
+			break;
+
 		if (!is_mem_zero((const char *)info.reserved,
 				 sizeof(info.reserved)))
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		/* TODO asid comes from userspace. mitigations? */
+		if (!dev->domain[info.asid]) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->domain[info.asid]->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->domain[info.asid]->iotlb,
 					      info.start, info.last);
 		if (map) {
 			info.start = map->start;
 			info.last = map->last;
 			info.capability = 0;
-			if (dev->domain->bounce_map && map->start == 0 &&
-			    map->last == dev->domain->bounce_size - 1)
+			if (dev->domain[info.asid]->bounce_map &&
+			    map->start == 0 &&
+			    map->last == dev->domain[info.asid]->bounce_size - 1)
 				info.capability |= VDUSE_IOVA_CAP_UMEM;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->domain[info.asid]->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		if (!map)
 			break;
@@ -1497,8 +1593,13 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	struct vduse_dev *dev = file->private_data;
 
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
-		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	for (int i = 0; i < dev->nas; i++) {
+		if (dev->domain[i]) {
+			vduse_dev_dereg_umem(dev, i, 0,
+					     dev->domain[i]->bounce_size);
+			dev->domain[i] = NULL;
+		}
+	}
 	mutex_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
@@ -1768,9 +1869,12 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	if (dev->domain)
-		vduse_domain_destroy(dev->domain);
+	for (int i = 0; i < dev->nas; i++) {
+		if (dev->domain[i])
+			vduse_domain_destroy(dev->domain[i]);
+	}
 	kfree(dev->name);
+	kfree(dev->umem);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
 
@@ -1877,7 +1981,8 @@ static ssize_t bounce_size_store(struct device *device,
 
 	ret = -EPERM;
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
+	/* Assuming that if the first domain is allocated, all are allocated */
+	if (dev->domain[0])
 		goto unlock;
 
 	ret = kstrtouint(buf, 10, &bounce_size);
@@ -1933,11 +2038,20 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 		if (config->ngroups > VDUSE_MAX_VQ_GROUPS) {
 			pr_err("Not creating a VDUSE device with %u vq groups. Max: %u",
 				config->ngroups, VDUSE_MAX_VQ_GROUPS);
+			/* TODO: Need to destroy dev here too! */
 			goto err;
 		}
+		if (config->nas > VDUSE_MAX_ASID) {
+			pr_err("Not creating a VDUSE device with %u asid. Max: %u",
+				config->nas, VDUSE_MAX_ASID);
+			goto err_nas;
+		}
+
 		dev->ngroups = config->ngroups ?: 1;
+		dev->nas = config->nas ?: 1;
 	} else {
 		dev->ngroups = 1;
+		dev->nas = 1;
 	}
 	for (u32 i = 0; i < dev->ngroups; ++i)
 		dev->groups[i].dev = dev;
@@ -1977,6 +2091,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+err_nas:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2069,7 +2184,6 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
 	file->private_data = control;
 
 	return 0;
@@ -2101,7 +2215,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
-				 dev->ngroups, 1, name, true);
+				 dev->ngroups, dev->nas, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
@@ -2137,11 +2251,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return ret;
 
 	mutex_lock(&dev->domain_lock);
-	if (!dev->domain)
-		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
-						  dev->bounce_size);
+	ret = 0;
+
+	/* TODO we could delay the creation of the domain */
+	for (int i = 0; i < dev->nas; ++i) {
+		if (!dev->domain[i])
+			dev->domain[i] = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
+							     dev->bounce_size);
+		if (!dev->domain[i]) {
+			ret = -ENOMEM;
+			for (int j = 0; j < i; ++j)
+				vduse_domain_destroy(dev->domain[j]);
+			goto err_domain;
+		}
+	}
+
 	mutex_unlock(&dev->domain_lock);
-	if (!dev->domain) {
+	if (ret == -ENOMEM) {
 		put_device(&dev->vdev->vdpa.dev);
 		return -ENOMEM;
 	}
@@ -2150,13 +2276,22 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
 		mutex_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
+		for (int i = 0; i < dev->nas; i++) {
+			if (dev->domain[i]) {
+				vduse_domain_destroy(dev->domain[i]);
+				dev->domain[i] = NULL;
+			}
+		}
 		mutex_unlock(&dev->domain_lock);
 		return ret;
 	}
 
 	return 0;
+
+err_domain:
+	/* TODO do I need to call put_device? */
+	mutex_unlock(&dev->domain_lock);
+	return ret;
 }
 
 static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index b4b139dc76bb..d300fd5f867f 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -47,7 +47,8 @@ struct vduse_dev_config {
 	__u32 vq_num;
 	__u32 vq_align;
 	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
-	__u32 reserved[12];
+	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[11];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -82,6 +83,17 @@ struct vduse_iotlb_entry {
 	__u8 perm;
 };
 
+struct vduse_iotlb_entry_v2 {
+	__u64 offset;
+	__u64 start;
+	__u64 last;
+#define VDUSE_ACCESS_RO 0x1
+#define VDUSE_ACCESS_WO 0x2
+#define VDUSE_ACCESS_RW 0x3
+	__u8 perm;
+	__u32 asid;
+};
+
 /*
  * Find the first IOVA region that overlaps with the range [start, last]
  * and return the corresponding file descriptor. Return -EINVAL means the
@@ -172,6 +184,16 @@ struct vduse_vq_group {
 	__u32 num;
 };
 
+/**
+ * struct vduse_vq_group - virtqueue group
+ @ @group: Index of the virtqueue group
+ * @asid: Address space ID of the group
+ */
+struct vduse_vq_group_asid {
+	__u32 group;
+	__u32 asid;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -232,6 +254,7 @@ struct vduse_vq_eventfd {
  * @uaddr: start address of userspace memory, it must be aligned to page size
  * @iova: start of the IOVA region
  * @size: size of the IOVA region
+ * @asid: Address space ID of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
@@ -241,7 +264,8 @@ struct vduse_iova_umem {
 	__u64 uaddr;
 	__u64 iova;
 	__u64 size;
-	__u64 reserved[3];
+	__u32 asid;
+	__u32 reserved[5];
 };
 
 /* Register userspace memory for IOVA regions */
@@ -265,7 +289,8 @@ struct vduse_iova_info {
 	__u64 last;
 #define VDUSE_IOVA_CAP_UMEM (1 << 0)
 	__u64 capability;
-	__u64 reserved[3];
+	__u32 asid; /* Only if device API version >= 1 */
+	__u32 reserved[5];
 };
 
 /*
@@ -289,6 +314,7 @@ enum vduse_req_type {
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_GET_VQ_GROUP,
 	VDUSE_GET_VRING_DESC_GROUP,
+	VDUSE_SET_VQ_GROUP_ASID,
 };
 
 /**
@@ -344,6 +370,8 @@ struct vduse_dev_request {
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
 		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
+		/* Only if vduse api version >= 1 */
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
@@ -367,6 +395,8 @@ struct vduse_dev_response {
 	union {
 		struct vduse_vq_state vq_state;
 		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
+		/* Only if vduse api version >= 1 */
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
-- 
2.50.1


