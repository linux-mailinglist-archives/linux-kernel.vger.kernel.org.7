Return-Path: <linux-kernel+bounces-860216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C402FBEF9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4727E349733
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759A2DC354;
	Mon, 20 Oct 2025 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI50a7xV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DD2DFF13
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944243; cv=none; b=uCluZwzdSKDLhl+0GGz2nUEtyHUXLEecfFCccLKig8XZzWagPUcZOv1gWQph4+4yil5VzcQVFT4WzWaNB1UEp4siiHBQwAzt6Y9eJDn0JVB/SrR/YryQjD81hx6e4EG6mGyOLgymrmAk94gKF6MPBL0ybd1FIbp4hZ8Qa7+E6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944243; c=relaxed/simple;
	bh=2AF9JULOtNLoExoVfNQOkRMExvLAyJLGg/Da80HqSKA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKJ2lhu7mgS+tOfMsztn2MYDn62qBlWuHo6jb+GDQ/kdbaLWJVvKFRFjavWiuNlpWLkyum1Hftb5A7YVBYXAVXZkarIxFJR9c2yu6U8haLzTO/LNcoAUoqZ4MIINJ6BGmffcGboLcR0Uke6Oyyney6ewC2Ct22vdM6C4mx+FjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dI50a7xV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaiPNv+1QjEcx0X1VKNsOwZsuKWVqyQbYrUVmXFh3Qo=;
	b=dI50a7xV0p6aFAwbexaXpLmTdmW22Q+3EaKRTVbf3jKLjPoROTXu87d9QcgCYoM88oLElp
	g87Pyr4ro/jm498dJ65fH3+iefiyp6tRco93hMkMy+OgjeEwrNBbD8meQ74EaLftnW+o3X
	7RRN1P2PRyOuwrPNLnogoV1yH1WIwUg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-K0LxA86PPm-q9Ef9NQs94A-1; Mon,
 20 Oct 2025 03:10:36 -0400
X-MC-Unique: K0LxA86PPm-q9Ef9NQs94A-1
X-Mimecast-MFC-AGG-ID: K0LxA86PPm-q9Ef9NQs94A_1760944236
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA9901800669;
	Mon, 20 Oct 2025 07:10:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F363C30001A2;
	Mon, 20 Oct 2025 07:10:32 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 06/19] virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
Date: Mon, 20 Oct 2025 15:09:50 +0800
Message-ID: <20251020071003.28834-7-jasowang@redhat.com>
In-Reply-To: <20251020071003.28834-1-jasowang@redhat.com>
References: <20251020071003.28834-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 39 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index aadeab66e57c..2c0c677cb6fc 100644
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
 
@@ -1440,7 +1440,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return -ENOMEM;
 }
 
-static inline int virtqueue_add_packed(struct virtqueue *_vq,
+static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 				       struct scatterlist *sgs[],
 				       unsigned int total_sg,
 				       unsigned int out_sgs,
@@ -1450,7 +1450,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       bool premapped,
 				       gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, c, descs_used, err_idx, len;
@@ -2262,9 +2261,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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


