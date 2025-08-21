Return-Path: <linux-kernel+bounces-779061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77534B2EE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BF4A20B45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BC2E8B85;
	Thu, 21 Aug 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZU6a86i9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51A2E88A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758834; cv=none; b=JJCEHdF2uNjPq5Y0jGh7RsxWPhTfis4s21m/LSvOg80kleJWjpxGKq5oxDNFkI+Y3Epv9l568a9f7zAXZNyh5/fCtqJ5kXeMb3ZfxqxAq2XHuV7NODT0DsoGrzb7AiXjiPBIlHEsCbFFfv4kXMgNte4ypuom4nn9xj3gy7EiRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758834; c=relaxed/simple;
	bh=3NgP69ZIidL2PedX3D/vVBsM7x97X20bJSOKU4P0Bpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEaK3a6lLnJwgdMukow6YBBi1igUWLRwyfvrzHV6W9KXitFN8mOrR3dmh5PGp0R+64woofYkQXEmg9DcAy2uMYth3upinCVFiXUlkQnng+JQ6pW0Olbyf6WBNKiaFOn1lhWJxediObVd9q8RMyyr0RMy78eEPWhZmtZijEkW3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZU6a86i9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755758831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEFSDGpbV88H0GYy2d3GXMr9/s0bna5eXxPzXidUw9g=;
	b=ZU6a86i90e66hQoG33hIzybTG8BhHtMJjEQ59xFf5eEMeY9sSHA1sZfjnfnwqky0TsYeMr
	eVn5bQV1PtAA6aflIkAE4nt8AbxoFaYCchxjaVclVBgGh0NPRYK4tn3xpv5iQ2hHUHYC9U
	W8avFYqLPRgzfl44xpyCpoiFHpN1w94=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-6O4MGXEkNNOpp-ah_y1bnw-1; Thu,
 21 Aug 2025 02:47:07 -0400
X-MC-Unique: 6O4MGXEkNNOpp-ah_y1bnw-1
X-Mimecast-MFC-AGG-ID: 6O4MGXEkNNOpp-ah_y1bnw_1755758826
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6335618004A7;
	Thu, 21 Aug 2025 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A74E719560B0;
	Thu, 21 Aug 2025 06:47:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
Date: Thu, 21 Aug 2025 14:46:34 +0800
Message-ID: <20250821064641.5025-3-jasowang@redhat.com>
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>
References: <20250821064641.5025-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


