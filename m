Return-Path: <linux-kernel+bounces-899289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9427C574CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F2357D21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62C34EEE8;
	Thu, 13 Nov 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSl8g7pd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914A34EEFD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034985; cv=none; b=tbv0xEMPr7LbxH9ZKehvLCSQXLpbrItadCUEjYoWiDV8xO5Q3SNV9glA+wa58VpPWMcZsdExzxWze/Zrci5/EKj9p++PUWXsx3TU2lFu8GgnRf3adOKBf6gSDfo1Jjo2WXG84vNveN1mY1eO6JgiVjpOB2zukA271jXS5rxJOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034985; c=relaxed/simple;
	bh=5dS2Q3tSXdnS6d6Gec/kIwkidYN5muGr9Us+oDiv/BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvi2z73aaZHAMOx+MmZmgMt8KQV0pDTkRaFHxpQ0ZVVnlt3Bg+GsO+MCD73UQfa26pk4atpsqkuMr7rzDw54bO/L44T2zkPZ+CNBljzqVq/z9qVdMhM7wbmY5FEmV4QdcevtCbp8n+YEjJEKRpwKnGqx1ZRRLDQDkHQNUxGPfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSl8g7pd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVLC3/uInwNory+G4WKZjUMRsunXnt3TodL9Vf8ncx0=;
	b=cSl8g7pdAZguJjwDI018e0iHg4mnYTYVcrM8CWgZDQ+I9ml5qXKX1krCzg7G7dMjsLdPaY
	TPJE85JqmYe4OC11qdePuQN45qa2XgYJzOAUDI/FrzgUr/nB3oq1KRqisN1MCSWBTOTYQM
	42Z8gT2hsHsHNIXOqqC1pbbvMclSp58=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-qcyHGxRqP-2dc4nkysdD3g-1; Thu,
 13 Nov 2025 06:56:21 -0500
X-MC-Unique: qcyHGxRqP-2dc4nkysdD3g-1
X-Mimecast-MFC-AGG-ID: qcyHGxRqP-2dc4nkysdD3g_1763034980
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21BEA19560A5;
	Thu, 13 Nov 2025 11:56:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EACE19560B9;
	Thu, 13 Nov 2025 11:56:14 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v9 3/6] vduse: return internal vq group struct as map token
Date: Thu, 13 Nov 2025 12:55:55 +0100
Message-ID: <20251113115558.1277981-4-eperezma@redhat.com>
In-Reply-To: <20251113115558.1277981-1-eperezma@redhat.com>
References: <20251113115558.1277981-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Return the internal struct that represents the vq group as virtqueue map
token, instead of the device.  This allows the map functions to access
the information per group.

At this moment all the virtqueues share the same vq group, that only
can point to ASID 0.  This change prepares the infrastructure for actual
per-group address space handling

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v4:
* Revert the "invalid vq group" concept, and assume 0 by default.
* Revert unnecesary blank line addition (Jason)

v3:
* Adapt all virtio_map_ops callbacks to handle empty tokens in case of
  invalid groups.
* Make setting status DRIVER_OK fail if vq group is not valid.
* Remove the _int name suffix from struct vduse_vq_group.

RFC v3:
* Make the vq groups a dynamic array to support an arbitrary number of
  them.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 100 ++++++++++++++++++++++++++---
 include/linux/virtio.h             |   6 +-
 2 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d5c90c599698..b01f55a1c22d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -22,6 +22,7 @@
 #include <linux/uio.h>
 #include <linux/vdpa.h>
 #include <linux/nospec.h>
+#include <linux/virtio.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
 #include <uapi/linux/vduse.h>
@@ -85,6 +86,10 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_vq_group {
+	struct vduse_dev *dev;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -118,6 +123,7 @@ struct vduse_dev {
 	u32 vq_align;
 	u32 ngroups;
 	struct vduse_umem *umem;
+	struct vduse_vq_group *groups;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
@@ -606,6 +612,17 @@ static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 	return dev->vqs[idx]->vq_group;
 }
 
+static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	u32 vq_group = vduse_get_vq_group(vdpa, idx);
+	union virtio_map ret = {
+		.group = &dev->groups[vq_group],
+	};
+
+	return ret;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -826,6 +843,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.get_vq_map		= vduse_get_vq_map,
 	.free			= vduse_vdpa_free,
 };
 
@@ -833,7 +851,14 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
@@ -842,7 +867,14 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
@@ -852,7 +884,14 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return DMA_MAPPING_ERROR;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -861,7 +900,14 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -869,11 +915,17 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 				      dma_addr_t *dma_addr, gfp_t flag)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
 	unsigned long iova;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
+	if (!token.group)
+		return NULL;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 	addr = vduse_domain_alloc_coherent(domain, size,
 					   (dma_addr_t *)&iova, flag);
 	if (!addr)
@@ -888,14 +940,28 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 				    void *vaddr, dma_addr_t dma_addr,
 				    unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return false;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return dma_addr < domain->bounce_size;
 }
@@ -909,7 +975,14 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 
 static size_t vduse_dev_max_mapping_size(union virtio_map token)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return 0;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return domain->bounce_size;
 }
@@ -1727,6 +1800,7 @@ static int vduse_destroy_dev(char *name)
 	if (dev->domain)
 		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
+	kfree(dev->groups);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
 
@@ -1896,6 +1970,13 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->ngroups = (dev->api_version < VDUSE_API_VERSION_1)
 		       ? 1
 		       : config->ngroups;
+	dev->groups = kcalloc(dev->ngroups, sizeof(dev->groups[0]),
+			      GFP_KERNEL);
+	if (!dev->groups)
+		goto err_vq_groups;
+	for (u32 i = 0; i < dev->ngroups; ++i)
+		dev->groups[i].dev = dev;
+
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1932,6 +2013,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+	kfree(dev->groups);
+err_vq_groups:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2093,7 +2176,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return -ENOMEM;
 	}
 
-	dev->vdev->vdpa.vmap.iova_domain = dev->domain;
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96c66126c074..302109029700 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -41,13 +41,13 @@ struct virtqueue {
 	void *priv;
 };
 
-struct vduse_iova_domain;
+struct vduse_vq_group;
 
 union virtio_map {
 	/* Device that performs DMA */
 	struct device *dma_dev;
-	/* VDUSE specific mapping data */
-	struct vduse_iova_domain *iova_domain;
+	/* VDUSE specific virtqueue group for doing map */
+	struct vduse_vq_group *group;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.51.1


