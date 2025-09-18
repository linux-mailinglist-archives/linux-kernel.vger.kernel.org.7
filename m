Return-Path: <linux-kernel+bounces-765961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678D2B24098
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1037C68801A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F323D7C7;
	Wed, 13 Aug 2025 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwRnO/BS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A12C1585
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064137; cv=none; b=jusbzwsGvVFCIWh5+Xc1s+8mXckT6gMG4IzhsTB575DJurJUg3NEffKqouiH0XxPL8NkKuTFlwVwMneRIUWk58k4AEKF8hXLcy+PqpIe0jUlE3F+NSC4y6tUs3JpfV68e5PzdLYxlDJWwZVH6BkxQFIRNbs10o3PC9CbXwKR2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064137; c=relaxed/simple;
	bh=3NgP69ZIidL2PedX3D/vVBsM7x97X20bJSOKU4P0Bpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKy8WOH2DYR9gxL660JR4NbRwFxlf+fGJ0W6ULuiCTMuix0CraJzqZn7P0ofqbSTFTc9vyAvj3tKdgatCUqxIDZGgLG8hNFTV4KjrZhBzmakb+F2DhzVuqYzo2XGZxA4xIat3vSeKfbsgx7yqVXimXiJI00JtwZXIA7uzrgr6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwRnO/BS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEFSDGpbV88H0GYy2d3GXMr9/s0bna5eXxPzXidUw9g=;
	b=MwRnO/BSJOz+5pAk0eXj/IudKt25GfEaigLWKNxh4peuSGRrVV5tTnbRdoQ9yNBuGVQq7w
	mESpvtFLq9Zd3nNhMjhkCR0g0ECKjx2447Iqtih7twP/VwpObTEN363I4rCODc62fiGR+P
	mdLJEKQrKDPa0S73ckzxEtXSaAVCcA8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-XpVwxH1fN6Ge4nsx9cqjhQ-1; Wed,
 13 Aug 2025 01:48:51 -0400
X-MC-Unique: XpVwxH1fN6Ge4nsx9cqjhQ-1
X-Mimecast-MFC-AGG-ID: XpVwxH1fN6Ge4nsx9cqjhQ_1755064130
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC85E1800446;
	Wed, 13 Aug 2025 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A56F180028D;
	Wed, 13 Aug 2025 05:48:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V5 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
Date: Wed, 13 Aug 2025 13:48:24 +0800
Message-ID: <20250813054831.25865-3-jasowang@redhat.com>
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

This patch switches to use dma_{map|unmap}_page() to reduce the
coverage of DMA operations. This would help for the following rework
on the virtio map operations.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 55 +++++++++++++++---------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 103bad8cffff..75e5f6336c8d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -405,8 +405,8 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 	if (!vq->use_dma_api)
 		return (dma_addr_t)virt_to_phys(cpu_addr);
 
-	return dma_map_single(vring_dma_dev(vq),
-			      cpu_addr, size, direction);
+	return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
+					      size, direction, 0);
 }
 
 static int vring_mapping_error(const struct vring_virtqueue *vq,
@@ -451,22 +451,14 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	if (flags & VRING_DESC_F_INDIRECT) {
 		if (!vq->use_dma_api)
 			goto out;
+	} else if (!vring_need_unmap_buffer(vq, extra))
+		goto out;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra->addr,
-				 extra->len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vring_need_unmap_buffer(vq, extra))
-			goto out;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr,
-			       extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       extra->addr,
+		       extra->len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 
 out:
 	return extra->next;
@@ -1276,20 +1268,13 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	if (flags & VRING_DESC_F_INDIRECT) {
 		if (!vq->use_dma_api)
 			return;
+	} else if (!vring_need_unmap_buffer(vq, extra))
+		return;
 
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra->addr, extra->len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vring_need_unmap_buffer(vq, extra))
-			return;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr, extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       extra->addr, extra->len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
@@ -3161,7 +3146,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr
 		return (dma_addr_t)virt_to_phys(ptr);
 	}
 
-	return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
+	/* DMA must never operate on areas that might be remapped. */
+	if (dev_WARN_ONCE(&_vq->vdev->dev, is_vmalloc_addr(ptr),
+			  "rejecting DMA map of vmalloc memory\n"))
+		return DMA_MAPPING_ERROR;
+
+	return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
+				  offset_in_page(ptr), size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
 
@@ -3186,7 +3177,7 @@ void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
 	if (!vq->use_dma_api)
 		return;
 
-	dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
 
-- 
2.31.1


