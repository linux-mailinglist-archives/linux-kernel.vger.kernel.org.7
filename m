Return-Path: <linux-kernel+bounces-765967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2571B240A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AEE77B4B44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878A2D0C8E;
	Wed, 13 Aug 2025 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtAx7n8T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA032D0C81
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064155; cv=none; b=McKjclvzCqn6kuqrIJ9V0vk8YsUHJTPJib/reEPw8AXseQrnZGHtXYUEW7Z+7ZhbXa6NHsNj6TGAaB0mkxM+I4GQflTsNuVe6BpmT9i0if19QBleRvmjaoniBv3NaxMx5FA1d8i1ILWWDZSmhXONB5i2p1TjUGuiydbYiCo4fYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064155; c=relaxed/simple;
	bh=288OXpvW8XcQdq1CYzdsEgxA4KAT4WL6xmr3dvS+N48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxcY3sAeuKblr7y3D0saMwhYQ0yWlQEXWopeI3sMxRoStb1b8blo8iWCTXHMpRG5H9Q5+Q7fcxKP66MT+t76y9R7k3+gidqwNIdWODx3Ye34/cMaJzrsUJ1H0hakkFX+jqTXHoBIBvSE2OXH5rdhwkzHXZel9txVvoc7nH+LkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtAx7n8T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k52rTVrWyoq13QeEFke/HSFi6Lcgu2unCHktMWNf2S4=;
	b=CtAx7n8T9LE3BxZXcEP1DY6AW5k9PABqo+ZRxAMKSkvyDXU7wgWoS0Y9cIBlPr31TIyRiW
	eX0/8yPEE1Md1UNzMES6ZouiODkmHjIzhZK6DZ90VwYVGf+fFqCWZTdi2KAM4hJk4n2XrA
	1KVdaIF4T6IAhZ+NFTQynmDIQl4flQI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-Zcr9m_YdM3GWN7_4RurRNA-1; Wed,
 13 Aug 2025 01:49:10 -0400
X-MC-Unique: Zcr9m_YdM3GWN7_4RurRNA-1
X-Mimecast-MFC-AGG-ID: Zcr9m_YdM3GWN7_4RurRNA_1755064149
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D16E195608E;
	Wed, 13 Aug 2025 05:49:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADA41180028D;
	Wed, 13 Aug 2025 05:49:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org
Subject: [PATCH V5 6/9] virtio: introduce map ops in virtio core
Date: Wed, 13 Aug 2025 13:48:28 +0800
Message-ID: <20250813054831.25865-7-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-1-jasowang@redhat.com>
References: <20250813054831.25865-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch introduces map operations for virtio device. Virtio use to
use DMA API which is not necessarily the case since some devices
doesn't do DMA. Instead of using tricks and abusing DMA API, let's
simply abstract the current mapping logic into a virtio specific
mapping operations. For the device or transport that doesn't do DMA,
they can implement their own mapping logic without the need to trick
DMA core. In this case the map_token is opaque to the virtio core that
will be passed back to the transport or device specific map
operations. For other devices, DMA API will still be used, so map
token will still be the dma device to minimize the changeset and
performance impact.

The mapping operations are abstracted as a independent structure
instead of reusing virtio_config_ops. This allows the transport can
simply reuse the structure for lower layers like vDPA.

A set of new mapping helpers were introduced for the device that want
to do mapping by themselves.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c  | 217 +++++++++++++++++++++++++++-------
 include/linux/virtio.h        |  26 +++-
 include/linux/virtio_config.h |  72 +++++++++++
 3 files changed, 271 insertions(+), 44 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 94b2a8f3acc2..86188ffbce00 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -297,8 +297,14 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
 {
 	size_t max_segment_size = SIZE_MAX;
 
-	if (vring_use_map_api(vdev))
-		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
+	if (vring_use_map_api(vdev)) {
+		if (vdev->map)
+			max_segment_size =
+				vdev->map->max_mapping_size(vdev->dev.parent);
+		else
+			max_segment_size =
+				dma_max_mapping_size(vdev->dev.parent);
+	}
 
 	return max_segment_size;
 }
@@ -309,8 +315,8 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			       union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev)) {
-		return dma_alloc_coherent(mapping_token->dma_dev, size,
-					  map_handle, flag);
+		return virtqueue_map_alloc_coherent(vdev, mapping_token, size,
+						    map_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
 
@@ -343,7 +349,8 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
 			     union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(mapping_token->dma_dev, size, queue, map_handle);
+		virtqueue_map_free_coherent(vdev, mapping_token, size,
+					    queue, map_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
@@ -358,6 +365,25 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 	return vq->mapping_token.dma_dev;
 }
 
+static void *vring_mapping_token(const struct vring_virtqueue *vq)
+{
+	return vq->mapping_token.token;
+}
+
+static int vring_mapping_error(const struct vring_virtqueue *vq,
+			       dma_addr_t addr)
+{
+	struct virtio_device *vdev = vq->vq.vdev;
+
+	if (!vq->use_map_api)
+		return 0;
+
+	if (vdev->map)
+		return vdev->map->mapping_error(vring_mapping_token(vq), addr);
+	else
+		return dma_mapping_error(vring_dma_dev(vq), addr);
+}
+
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr,
@@ -387,11 +413,11 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 	 * the way it expects (we don't guarantee that the scatterlist
 	 * will exist for the lifetime of the mapping).
 	 */
-	*addr = dma_map_page(vring_dma_dev(vq),
-			    sg_page(sg), sg->offset, sg->length,
-			    direction);
+	*addr = virtqueue_map_page_attrs(&vq->vq, sg_page(sg),
+					 sg->offset, sg->length,
+					 direction, 0);
 
-	if (dma_mapping_error(vring_dma_dev(vq), *addr))
+	if (vring_mapping_error(vq, *addr))
 		return -ENOMEM;
 
 	return 0;
@@ -408,15 +434,6 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 					  size, direction, 0);
 }
 
-static int vring_mapping_error(const struct vring_virtqueue *vq,
-			       dma_addr_t addr)
-{
-	if (!vq->use_map_api)
-		return 0;
-
-	return dma_mapping_error(vring_dma_dev(vq), addr);
-}
-
 static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
 {
 	vq->vq.num_free = num;
@@ -453,11 +470,12 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		goto out;
 
-	dma_unmap_page(vring_dma_dev(vq),
-		       extra->addr,
-		       extra->len,
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	virtqueue_unmap_page_attrs(&vq->vq,
+				   extra->addr,
+				   extra->len,
+				   (flags & VRING_DESC_F_WRITE) ?
+				   DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				   0);
 
 out:
 	return extra->next;
@@ -1271,10 +1289,11 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		return;
 
-	dma_unmap_page(vring_dma_dev(vq),
-		       extra->addr, extra->len,
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	virtqueue_unmap_page_attrs(&vq->vq,
+				   extra->addr, extra->len,
+				   (flags & VRING_DESC_F_WRITE) ?
+				   DMA_FROM_DEVICE : DMA_TO_DEVICE,
+				   0);
 }
 
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
@@ -2434,8 +2453,7 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
 struct device *virtqueue_dma_dev(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	if (vq->use_map_api)
+	if (vq->use_map_api && !_vq->vdev->map)
 		return vq->mapping_token.dma_dev;
 	else
 		return NULL;
@@ -3125,6 +3143,107 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/**
+ * virtqueue_map_alloc_coherent - alloc coherent mapping
+ * @vdev: the virtio device we are talking to
+ * @mapping_token: device specific mapping token
+ * @size: the size of the buffer
+ * @map_handle: the pointer to the mapped address
+ * @gfp: allocation flag (GFP_XXX)
+ *
+ * return virtual address or NULL on error
+ */
+void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
+				   union vring_mapping_token *mapping_token,
+				   size_t size, dma_addr_t *map_handle,
+				   gfp_t gfp)
+{
+	if (vdev->map)
+		return vdev->map->alloc(mapping_token->token, size,
+					map_handle, gfp);
+	else
+		return dma_alloc_coherent(mapping_token->dma_dev, size,
+					  map_handle, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
+
+/**
+ * virtqueue_map_free_coherent - free coherent mapping
+ * @vdev: the virtio device we are talking to
+ * @token: device specific mapping token
+ * @size: the size of the buffer
+ * @map_handle: the mapped address that needs to be freed
+ *
+ */
+void virtqueue_map_free_coherent(struct virtio_device *vdev,
+				 union vring_mapping_token *mapping_token, size_t size, void *vaddr,
+				 dma_addr_t map_handle)
+{
+	if (vdev->map)
+		vdev->map->free(mapping_token->token, size, vaddr,
+				map_handle, 0);
+	else
+		dma_free_coherent(mapping_token->dma_dev, size, vaddr, map_handle);
+}
+EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
+
+/**
+ * virtqueue_map_page_attrs - map a page to the device
+ * @_vq: the virtqueue we are talking to
+ * @page: the page that will be mapped by the device
+ * @offset: the offset in the page for a buffer
+ * @size: the buffer size
+ * @dir: mapping direction
+ * @attrs: mapping attributes
+ *
+ * Returns mapped address. Caller should check that by virtqueue_mapping_error().
+ */
+dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
+				    struct page *page,
+				    unsigned long offset,
+				    size_t size,
+				    enum dma_data_direction dir,
+				    unsigned long attrs)
+{
+	const struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+
+	if (vdev->map)
+		return vdev->map->map_page(vring_mapping_token(vq),
+					   page, offset, size,
+					   dir, attrs);
+
+	return dma_map_page_attrs(vring_dma_dev(vq),
+				  page, offset, size,
+				  dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_map_page_attrs);
+
+/**
+ * virtqueue_unmap_page_attrs - map a page to the device
+ * @_vq: the virtqueue we are talking to
+ * @map_handle: the mapped address
+ * @size: the buffer size
+ * @dir: mapping direction
+ * @attrs: unmapping attributes
+ */
+void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
+				dma_addr_t map_handle,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	const struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+
+	if (vdev->map)
+		vdev->map->unmap_page(vring_mapping_token(vq), map_handle,
+				      size, dir, attrs);
+	else
+		dma_unmap_page_attrs(vring_dma_dev(vq), map_handle,
+				     size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);
+
 /**
  * virtqueue_map_single_attrs - map DMA for _vq
  * @_vq: the struct virtqueue we're talking about.
@@ -3136,7 +3255,7 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
  * The caller calls this to do dma mapping in advance. The DMA address can be
  * passed to this _vq when it is in pre-mapped mode.
  *
- * return DMA address. Caller should check that by virtqueue_mapping_error().
+ * return mapped address. Caller should check that by virtqueue_mapping_error().
  */
 dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 				      size_t size,
@@ -3155,8 +3274,8 @@ dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 			  "rejecting DMA map of vmalloc memory\n"))
 		return DMA_MAPPING_ERROR;
 
-	return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
-				  offset_in_page(ptr), size, dir, attrs);
+	return virtqueue_map_page_attrs(&vq->vq, virt_to_page(ptr),
+					offset_in_page(ptr), size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_single_attrs);
 
@@ -3181,12 +3300,12 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
 	if (!vq->use_map_api)
 		return;
 
-	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+	virtqueue_unmap_page_attrs(_vq, addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
 /**
- * virtqueue_map_mapping_error - check dma address
+ * virtqueue_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
@@ -3196,10 +3315,7 @@ int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!vq->use_map_api)
-		return 0;
-
-	return dma_mapping_error(vring_dma_dev(vq), addr);
+	return vring_mapping_error(vq, addr);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
 
@@ -3216,11 +3332,15 @@ EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
 bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
 
 	if (!vq->use_map_api)
 		return false;
 
-	return dma_need_sync(vring_dma_dev(vq), addr);
+	if (vdev->map)
+		return vdev->map->need_sync(vring_mapping_token(vq), addr);
+	else
+		return dma_need_sync(vring_dma_dev(vq), addr);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
 
@@ -3242,12 +3362,17 @@ void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
 					     enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct device *dev = vring_dma_dev(vq);
+	struct virtio_device *vdev = _vq->vdev;
 
 	if (!vq->use_map_api)
 		return;
 
-	dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
+	if (vdev->map)
+		vdev->map->sync_single_for_cpu(vring_mapping_token(vq),
+					       addr + offset, size, dir);
+	else
+		dma_sync_single_range_for_cpu(vring_dma_dev(vq),
+					      addr, offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_cpu);
 
@@ -3268,12 +3393,18 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 						enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct device *dev = vring_dma_dev(vq);
+	struct virtio_device *vdev = _vq->vdev;
 
 	if (!vq->use_map_api)
 		return;
 
-	dma_sync_single_range_for_device(dev, addr, offset, size, dir);
+	if (vdev->map)
+		vdev->map->sync_single_for_device(vring_mapping_token(vq),
+						  addr + offset,
+						  size, dir);
+	else
+		dma_sync_single_range_for_device(vring_dma_dev(vq), addr,
+						 offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 37029df94aaf..e1973c7b1d1c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -44,7 +44,7 @@ union vring_mapping_token {
 	/* Device that performs DMA */
 	struct device *dma_dev;
 	/* Transport specific token used for doing map */
-	void *opaque;
+	void *token;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
@@ -165,6 +165,7 @@ struct virtio_device {
 	struct virtio_device_id id;
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
+	const struct virtio_map_ops *map;
 	struct list_head vqs;
 	u64 features;
 	void *priv;
@@ -266,6 +267,29 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
 
+
+void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
+				   union vring_mapping_token *mapping_token,
+				   size_t size, dma_addr_t *dma_handle,
+				   gfp_t gfp);
+
+void virtqueue_map_free_coherent(struct virtio_device *vdev,
+				 union vring_mapping_token *mapping_token,
+				 size_t size, void *vaddr,
+				 dma_addr_t dma_handle);
+
+dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
+				    struct page *page,
+				    unsigned long offset,
+				    size_t size,
+				    enum dma_data_direction dir,
+				    unsigned long attrs);
+
+void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
+				dma_addr_t dma_handle,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs);
+
 dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
 					  enum dma_data_direction dir, unsigned long attrs);
 void virtqueue_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b3e1d30c765b..784ce56197c4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -133,6 +133,78 @@ struct virtio_config_ops {
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
 };
 
+/**
+ * struct virtio_map_ops - operations for mapping buffer for a virtio device
+ * Note: For transport that has its own mapping logic it must
+ * implements all of the operations
+ * @map_page: map a buffer to the device
+ *      token: device specific mapping token
+ *      page: the page that will be mapped by the device
+ *      offset: the offset in the page for a buffer
+ *      size: the buffer size
+ *      dir: mapping direction
+ *      attrs: mapping attributes
+ *      Returns: the mapped address
+ * @unmap_page: unmap a buffer from the device
+ *      token: device specific mapping token
+ *      map_handle: the mapped address
+ *      size: the buffer size
+ *      dir: mapping direction
+ *      attrs: unmapping attributes
+ * @sync_single_for_cpu: sync a single buffer from device to cpu
+ *      token: device specific mapping token
+ *      map_handle: the mapping address to sync
+ *      size: the size of the buffer
+ *      dir: synchronization direction
+ * @sync_single_for_device: sync a single buffer from cpu to device
+ *      token: device specific mapping token
+ *      map_handle: the mapping address to sync
+ *      size: the size of the buffer
+ *      dir: synchronization direction
+ * @alloc: alloc a coherent buffer mapping
+ *      token: device specific mapping token
+ *      size: the size of the buffer
+ *      map_handle: the mapping address to sync
+ *      gfp: allocation flag (GFP_XXX)
+ *      Returns: virtual address of the allocated buffer
+ * @free: free a coherent buffer mapping
+ *      token: device specific mapping token
+ *      size: the size of the buffer
+ *      vaddr: virtual address of the buffer
+ *      map_handle: the mapping address to sync
+ *      attrs: unmapping attributes
+ * @need_sync: if the buffer needs synchronization
+ *      token: device specific mapping token
+ *      map_handle: the mapped address
+ *      Returns: whether the buffer needs synchronization
+ * @mapping_error: if the mapping address is error
+ *      token: device specific mapping token
+ *      map_handle: the mapped address
+ * @max_mapping_size: get the maximum buffer size that can be mapped
+ *      token: device specific mapping token
+ *      Returns: the maximum buffer size that can be mapped
+ */
+struct virtio_map_ops {
+	dma_addr_t (*map_page)(void *token, struct page *page,
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_page)(void *token, dma_addr_t map_handle,
+			   size_t size, enum dma_data_direction dir,
+			   unsigned long attrs);
+	void (*sync_single_for_cpu)(void *token, dma_addr_t map_handle,
+				    size_t size, enum dma_data_direction dir);
+	void (*sync_single_for_device)(void *token,
+				       dma_addr_t map_handle, size_t size,
+				       enum dma_data_direction dir);
+	void *(*alloc)(void *token, size_t size,
+		       dma_addr_t *map_handle, gfp_t gfp);
+	void (*free)(void *token, size_t size, void *vaddr,
+		     dma_addr_t map_handle, unsigned long attrs);
+	bool (*need_sync)(void *token, dma_addr_t map_handle);
+	int (*mapping_error)(void *token, dma_addr_t map_handle);
+	size_t (*max_mapping_size)(void *token);
+};
+
 /* If driver didn't advertise the feature, it will never appear. */
 void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
 					 unsigned int fbit);
-- 
2.31.1


