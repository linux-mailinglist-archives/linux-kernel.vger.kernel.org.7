Return-Path: <linux-kernel+bounces-824123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C4B882A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D12D1BC6CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13A2D47ED;
	Fri, 19 Sep 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qi9vMu7+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677A2D46C6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267152; cv=none; b=SxCtHiZiGzF8VFlppJ5hiGs6U8KML00TGDWYWi7l3wQGFv6HZOErQwXa0j4DYWb7FupWY0/mDtcqez2UO8WJWVbF3lbAJXc+xBD4/aq6Q3uczh58c5SpZnsbBgaq/TG7KxCqtvrHB0RFcyGX0Qy7xeJX61QuxPn/blKfU3hz41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267152; c=relaxed/simple;
	bh=4QjQQt7FhlBMMNfCdijzFIrxETBMVjHBCei8Cag4cNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCZz5hAoQUOy9U/LcThcGvxnu05C/cniKPsrcaB20YPYE4G56SWYGojmFQcO9UmlX8liSp9/mqdNXdQwWC+Yz5yE5xSjnFV7RRzv5YpISvHbKQ2THtawyxtEDdQRFjW1n7HFVVpcXoee27XisuDuusMeLHdF7n9SIvSrXB2yl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qi9vMu7+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqVjgRVYTyXk4aefzATba9pEScbbb4drMUS+64g1cTw=;
	b=Qi9vMu7+pBkwDvHtuuSyrp1KhotmfJ0Xl1HA3MLycIExNkUmBpzqv38KPcWVw1co8QQAsH
	0Lw9/g/ZSKqIxTtCBTWyFtJEo7sp5R3x7EQ35bi47gT1oxv3sLUilmup7nVyIy7clW24y+
	IT8VjeYnCTucqbIy/21Iiwl11TpLcNI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-5cSZeCaRNKi5eBRFXnaFkg-1; Fri,
 19 Sep 2025 03:32:26 -0400
X-MC-Unique: 5cSZeCaRNKi5eBRFXnaFkg-1
X-Mimecast-MFC-AGG-ID: 5cSZeCaRNKi5eBRFXnaFkg_1758267145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD9331956058;
	Fri, 19 Sep 2025 07:32:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1CAF19560BB;
	Fri, 19 Sep 2025 07:32:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 06/19] virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
Date: Fri, 19 Sep 2025 15:31:41 +0800
Message-ID: <20250919073154.49278-7-jasowang@redhat.com>
In-Reply-To: <20250919073154.49278-1-jasowang@redhat.com>
References: <20250919073154.49278-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index aadeab66e57c..93c36314b5e7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -476,7 +476,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	return extra->next;
 }
 
-static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
+static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
 					       unsigned int total_sg,
 					       gfp_t gfp)
 {
@@ -505,7 +505,7 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	return desc;
 }
 
-static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
+static inline unsigned int virtqueue_add_desc_split(struct vring_virtqueue *vq,
 						    struct vring_desc *desc,
 						    struct vring_desc_extra *extra,
 						    unsigned int i,
@@ -513,11 +513,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
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
@@ -525,12 +526,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 
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
@@ -540,7 +541,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      bool premapped,
 				      gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
@@ -565,7 +565,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	head = vq->free_head;
 
 	if (virtqueue_use_indirect(vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
+		desc = alloc_indirect_split(vq, total_sg, gfp);
 	else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
@@ -612,7 +612,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
+			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
 						     VRING_DESC_F_NEXT,
 						     premapped);
 		}
@@ -629,14 +629,14 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
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
@@ -649,7 +649,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (vring_mapping_error(vq, addr))
 			goto unmap_release;
 
-		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
+		virtqueue_add_desc_split(vq, vq->split.vring.desc,
 					 vq->split.desc_extra,
 					 head, addr,
 					 total_sg * sizeof(struct vring_desc),
@@ -675,13 +675,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
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
 
@@ -691,7 +691,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* This is very unlikely, but theoretically possible.  Kick
 	 * just in case. */
 	if (unlikely(vq->num_added == (1 << 16) - 1))
-		virtqueue_kick(_vq);
+		virtqueue_kick(&vq->vq);
 
 	return 0;
 
@@ -706,7 +706,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-
 		i = vring_unmap_one_split(vq, &extra[i]);
 	}
 
@@ -1440,7 +1439,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return -ENOMEM;
 }
 
-static inline int virtqueue_add_packed(struct virtqueue *_vq,
+static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 				       struct scatterlist *sgs[],
 				       unsigned int total_sg,
 				       unsigned int out_sgs,
@@ -1450,7 +1449,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       bool premapped,
 				       gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, c, descs_used, err_idx, len;
@@ -2262,9 +2260,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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
2.31.1


