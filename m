Return-Path: <linux-kernel+bounces-743608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AC0B100DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D462585B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BC622FF22;
	Thu, 24 Jul 2025 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALeiZMHz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8821C9F5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339257; cv=none; b=tyHWzjoKcAQQFRlImD+nHvfNsCJMZf8PYZ5zctfcY0Lv1uWkl1RlGh9UnpEu6jhMdlHG72zvU5vcUgIqT0qLgo2hIMGjiv0Vdb5U+jMMjepKCK8A3/c6N/191nCBpoSrEippyAnjZRl9cKkEVLEWwwYrcHAERYv3BWzLz2vqVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339257; c=relaxed/simple;
	bh=mybsbMJf9XWfYlQRyil4sH4TitgQh7iRuM8qzpD62m4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcvmkK4g47E0geY0MsvRlqbRjSH74sdw2kaHZ7ap26dRBR2PtSQs+nj/Y2l21HkfYYHHmU254+ZMgf50RJD7+TAnsmZ6AM1f8PWnkaZf2DyiTJFgVadClSJZ8TXhhDgTQ8kOAXIlNgryq2kSm8wIbWqk+kWdRACKjAWvuTePUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALeiZMHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753339255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9OqrbFE0wKx4lqeLJtA8rj6ozKgcP0h080xh9UuVZo=;
	b=ALeiZMHzhPUa0V3VMzUDr/4UCFJmnq+Fz3gCGFenJZ046XOtZT0ac6/Rt6ON44RKsbDlrH
	YOX44yH8O6XGumGUy3e+0m9EZozQjm860QnyI3R0kDmBy3afUG0kUvoX8A7o5p2LZVzbJy
	SkfEFPiruCm53zph4SHdaAM1Pl7PAL0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-wPrSeQrlPya-3q-ZGfUK6g-1; Thu,
 24 Jul 2025 02:40:53 -0400
X-MC-Unique: wPrSeQrlPya-3q-ZGfUK6g-1
X-Mimecast-MFC-AGG-ID: wPrSeQrlPya-3q-ZGfUK6g_1753339252
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10BFF1956088;
	Thu, 24 Jul 2025 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB1C218002AF;
	Thu, 24 Jul 2025 06:40:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 06/19] virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
Date: Thu, 24 Jul 2025 14:40:04 +0800
Message-ID: <20250724064017.26058-7-jasowang@redhat.com>
In-Reply-To: <20250724064017.26058-1-jasowang@redhat.com>
References: <20250724064017.26058-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 40 +++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ac14324588bb..b7489d19d8ae 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -472,7 +472,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	return extra->next;
 }
 
-static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
+static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
 					       unsigned int total_sg,
 					       gfp_t gfp)
 {
@@ -501,7 +501,7 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	return desc;
 }
 
-static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
+static inline unsigned int virtqueue_add_desc_split(struct vring_virtqueue *vq,
 						    struct vring_desc *desc,
 						    struct vring_desc_extra *extra,
 						    unsigned int i,
@@ -509,11 +509,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    unsigned int len,
 						    u16 flags, bool premapped)
 {
+	struct virtio_device *vdev = vq->vq.vdev;
 	u16 next;
 
-	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
-	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
-	desc[i].len = cpu_to_virtio32(vq->vdev, len);
+	desc[i].flags = cpu_to_virtio16(vdev, flags);
+	desc[i].addr = cpu_to_virtio64(vdev, addr);
+	desc[i].len = cpu_to_virtio32(vdev, len);
 
 	extra[i].addr = premapped ? DMA_MAPPING_ERROR : addr;
 	extra[i].len = len;
@@ -521,12 +522,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 
 	next = extra[i].next;
 
-	desc[i].next = cpu_to_virtio16(vq->vdev, next);
+	desc[i].next = cpu_to_virtio16(vdev, next);
 
 	return next;
 }
 
-static inline int virtqueue_add_split(struct virtqueue *_vq,
+static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 				      struct scatterlist *sgs[],
 				      unsigned int total_sg,
 				      unsigned int out_sgs,
@@ -536,7 +537,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      bool premapped,
 				      gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
@@ -561,7 +561,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	head = vq->free_head;
 
 	if (virtqueue_use_indirect(vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
+		desc = alloc_indirect_split(vq, total_sg, gfp);
 	else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
@@ -608,7 +608,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
+			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
 						     VRING_DESC_F_NEXT,
 						     premapped);
 		}
@@ -625,14 +625,14 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
+			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
 						     premapped);
 		}
 	}
 	/* Last one doesn't continue. */
-	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
+	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
 	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
 		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
@@ -645,7 +645,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (vring_mapping_error(vq, addr))
 			goto unmap_release;
 
-		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
+		virtqueue_add_desc_split(vq, vq->split.vring.desc,
 					 vq->split.desc_extra,
 					 head, addr,
 					 total_sg * sizeof(struct vring_desc),
@@ -671,13 +671,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
-	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(vq->vq.vdev, head);
 
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
 	virtio_wmb(vq->weak_barriers);
 	vq->split.avail_idx_shadow++;
-	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+	vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_idx_shadow);
 	vq->num_added++;
 
@@ -687,7 +687,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* This is very unlikely, but theoretically possible.  Kick
 	 * just in case. */
 	if (unlikely(vq->num_added == (1 << 16) - 1))
-		virtqueue_kick(_vq);
+		virtqueue_kick(&vq->vq);
 
 	return 0;
 
@@ -702,7 +702,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-
 		i = vring_unmap_one_split(vq, &extra[i]);
 	}
 
@@ -1441,7 +1440,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return -ENOMEM;
 }
 
-static inline int virtqueue_add_packed(struct virtqueue *_vq,
+static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 				       struct scatterlist *sgs[],
 				       unsigned int total_sg,
 				       unsigned int out_sgs,
@@ -1451,7 +1450,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       bool premapped,
 				       gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, c, descs_used, err_idx, len;
@@ -2263,9 +2261,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
+	return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, premapped, gfp) :
-				 virtqueue_add_split(_vq, sgs, total_sg,
+				 virtqueue_add_split(vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, premapped, gfp);
 }
 
-- 
2.39.5


