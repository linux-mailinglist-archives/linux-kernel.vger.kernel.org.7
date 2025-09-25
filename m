Return-Path: <linux-kernel+bounces-832250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8603DB9EBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6EC4C2B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E262FC86F;
	Thu, 25 Sep 2025 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPo8mQFF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB092FB993
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796673; cv=none; b=uNn+TUea1eNSIC9IJvDtO6sE598dO68xDIr81ylAamOMn81YvouVfYiWn4d06JoxfdzB7/qv1OM87CbR8I7Do8/Syt8eO/LMMYIDbWVZQeAf/IFyJrR5UtuQc3V0JINWrz1rClaZEkkjFuLyjyQ2vePNkS5EIkX0J0HnKr1PAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796673; c=relaxed/simple;
	bh=7qDg5goKB2eLhHZ+Ed9qX3fTW71RZzlughkjBIvkQ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ls2judA6qZcyNvAGRxmTD4UBa/+hBmV7rdQqxtfxOweWNNnOjG5pWGyKdg6l/28CXryeMbqJjOfqKLNfQIitAHpu+Z4bHAK+KapJr0/zG55lqnCvCsCCVi6RprEg1ptxVFNQfAFSWbS1P6BtF/gC5I5FSQ2esfQuOU8EM+DmdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPo8mQFF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTDGrU9uhGdFfnzChF1KM1YGBCuNVqCio2exfzbo6VA=;
	b=DPo8mQFFtLr7XTYU01jY+HwD9+CQlDitBujwh1NyPjEwxnJuI+UIpt6w64f7IqIitsUh/6
	Pv2HkXklFEWbFXEWKle0XbNJRBy09ablBOOg+114zDjbnqfyelV70p98ZKZ6XzDNSARb+F
	Tq3MEGfzq0mAEMaIUoQE4ICAmqXDPNA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-Dii1i3dvNiq88WAsXX-IvA-1; Thu,
 25 Sep 2025 06:37:49 -0400
X-MC-Unique: Dii1i3dvNiq88WAsXX-IvA-1
X-Mimecast-MFC-AGG-ID: Dii1i3dvNiq88WAsXX-IvA_1758796669
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBEFA18004D8;
	Thu, 25 Sep 2025 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EEEF19560A2;
	Thu, 25 Sep 2025 10:37:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 07/19] virtio: switch to use vring_virtqueue for virtqueue_get variants
Date: Thu, 25 Sep 2025 18:36:56 +0800
Message-ID: <20250925103708.44589-8-jasowang@redhat.com>
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2c0c677cb6fc..9d084ee9f4d6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -817,11 +817,10 @@ static bool more_used_split(const struct vring_virtqueue *vq)
 	return virtqueue_poll_split(vq, vq->last_used_idx);
 }
 
-static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
+static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 					 unsigned int *len,
 					 void **ctx)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	void *ret;
 	unsigned int i;
 	u16 last_used;
@@ -843,9 +842,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
-	i = virtio32_to_cpu(_vq->vdev,
+	i = virtio32_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->ring[last_used].id);
-	*len = virtio32_to_cpu(_vq->vdev,
+	*len = virtio32_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->ring[last_used].len);
 
 	if (unlikely(i >= vq->split.vring.num)) {
@@ -867,7 +866,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
 		virtio_store_mb(vq->weak_barriers,
 				&vring_used_event(&vq->split.vring),
-				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
+				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
 
 	LAST_ADD_TIME_INVALID(vq);
 
@@ -1721,11 +1720,10 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
 }
 
-static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
+static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 					  unsigned int *len,
 					  void **ctx)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used, id, last_used_idx;
 	bool used_wrap_counter;
 	void *ret;
@@ -2525,8 +2523,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
-				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
+				 virtqueue_get_buf_ctx_split(vq, len, ctx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
-- 
2.31.1


