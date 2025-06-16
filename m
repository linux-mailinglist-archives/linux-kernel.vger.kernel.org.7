Return-Path: <linux-kernel+bounces-687902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E8DADAAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06EA47A5CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2452426C397;
	Mon, 16 Jun 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZIWwnCN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9ED26E717
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062351; cv=none; b=iZF5cLEwYAhzUbIOHHj2u0UWp0HIPbHDcrbXg7rMVHe7cpOCLGBD2GbETVYsXsEKzG6iZwzlIUi/Zc7NAlKioHZV5fr2yxvKnnvgwGAZQWWrFsfr6vfLWT1sLEj7gtCR5bJfLZuXSD1TUyQVwg+9dbxQ4FLQdyHNmFB2LYcIwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062351; c=relaxed/simple;
	bh=R2g4TwySJDJJocU4xK4nOTDTSRAr1GmJ2/lN3ltr1qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2trK+fu3/YNceNl+8fsUZvMkv1CqoAvXU8eRZ3WJ/Pq3tYAZYPb03oWPmZ7EG9fgUF4vSONWaoAHyvGNLgHf9HeZrAi1/AXnOeKmgaPSV80VxGBXEmzvOhnalDSnZN6fBNlDk3x41C9Gzv03tQLKnpN8KaVSjrHyKsel6UtFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZIWwnCN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750062349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5oGRzY001stMjDiZhS80KlkkuWn5cfO4rLHANW0IMQ4=;
	b=EZIWwnCN/F+7MAWbD+6DiOj7Mz3EEg0P5b+SRR3M0QyOf9yWESdud+kwGMjildIx0Egoxo
	oss026bGMECUJIg/6RYa4qkKuOaaZenZmYqGFYMZDTWCrXktiZ1o1gI42JRHvTiWiBoNbd
	lhZT9x15TkUxYFLJrZlNPUb+KNPxMrk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-QXeykfAKOvCloURUsEpyzw-1; Mon,
 16 Jun 2025 04:25:47 -0400
X-MC-Unique: QXeykfAKOvCloURUsEpyzw-1
X-Mimecast-MFC-AGG-ID: QXeykfAKOvCloURUsEpyzw_1750062346
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F555195608D;
	Mon, 16 Jun 2025 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 379C9180045B;
	Mon, 16 Jun 2025 08:25:42 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 05/19] virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare variants
Date: Mon, 16 Jun 2025 16:25:03 +0800
Message-ID: <20250616082518.10411-6-jasowang@redhat.com>
In-Reply-To: <20250616082518.10411-1-jasowang@redhat.com>
References: <20250616082518.10411-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e7be480bee67..8ee5393803f0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -713,9 +713,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return -ENOMEM;
 }
 
-static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
+static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old;
 	bool needs_kick;
 
@@ -732,12 +731,12 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	LAST_ADD_TIME_INVALID(vq);
 
 	if (vq->event) {
-		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
+		needs_kick = vring_need_event(virtio16_to_cpu(vq->vq.vdev,
 					vring_avail_event(&vq->split.vring)),
 					      new, old);
 	} else {
 		needs_kick = !(vq->split.vring.used->flags &
-					cpu_to_virtio16(_vq->vdev,
+					cpu_to_virtio16(vq->vq.vdev,
 						VRING_USED_F_NO_NOTIFY));
 	}
 	END_USE(vq);
@@ -1597,9 +1596,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return -EIO;
 }
 
-static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
+static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
 	bool needs_kick;
 	union {
@@ -2454,8 +2452,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
-				 virtqueue_kick_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
+				 virtqueue_kick_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
 
-- 
2.34.1


