Return-Path: <linux-kernel+bounces-832245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F05B9EBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187D92A171A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A62F9DB4;
	Thu, 25 Sep 2025 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcbG82qG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197662F9DBA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796658; cv=none; b=FnT80AiOLZHQJYF4fgQNxvkCh3silKjXMzc1KER5gNXPMiM/NS0pmSg09ZBP0pRMDWPjWqJXsNZd3ELagW4ktk9ExXxNK3uVTHwXFIo3UlBsN/bNPyexpNHT+oMb9jovVAy3g2gwFt5fVn+I+RMheDrS/Rmn1qknvXEfgV113Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796658; c=relaxed/simple;
	bh=4t6ixKfADhlr9xzvfuDQl77U06Jc1JbbTyleI9sfI7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFvRxoK0aRExoh+tYktTHXLAvh24XK/OQfRjAl0zWaG7eskgb6SQFZYfV7hM2KnDaLbJr/85dfvHttHLXISePN7q5pIpNzc+izCrPBqqn2aQrfHsfeKiDe2eTy/QIcTGd3noZoX8h0c95ejQDjATjXH9rP8zQwJAOVVzdtLzuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcbG82qG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFIZuPKUpfLWKhMoVS+8GFV45HPQ85k5vLQT16WEDbY=;
	b=UcbG82qGyVtUxhfFw0mwa8Bz+IvV1Txkh0LbyDgIHQBec/CspqjcXk3Yv3oHNeNMOHcH+w
	8jnt1aE+Zx8MNCPjSlNDWxtBvjOUtapyM7QrdiabikD5kyNujEe9CwCmDN5vneczRidp2b
	As6XpKk/NQcCyT694SN7trqjddPO4X8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-m4C23J8MOSW-9cfZMFh5-A-1; Thu,
 25 Sep 2025 06:37:32 -0400
X-MC-Unique: m4C23J8MOSW-9cfZMFh5-A-1
X-Mimecast-MFC-AGG-ID: m4C23J8MOSW-9cfZMFh5-A_1758796652
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E17BD1944EBF;
	Thu, 25 Sep 2025 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8907219560A2;
	Thu, 25 Sep 2025 10:37:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 03/19] virtio_ring: unify logic of virtqueue_poll() and more_used()
Date: Thu, 25 Sep 2025 18:36:52 +0800
Message-ID: <20250925103708.44589-4-jasowang@redhat.com>
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

This patch unifies the logic of virtqueue_poll() and more_used() for
better code reusing and ease the future in order implementation.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 48 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fed3962411a1..d8a07e0d9fa8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -806,12 +806,18 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	}
 }
 
-static bool more_used_split(const struct vring_virtqueue *vq)
+static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
+				 unsigned int last_used_idx)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
+	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
 }
 
+static bool more_used_split(const struct vring_virtqueue *vq)
+{
+	return virtqueue_poll_split(vq, vq->last_used_idx);
+}
+
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 					 unsigned int *len,
 					 void **ctx)
@@ -919,13 +925,6 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 	return last_used_idx;
 }
 
-static bool virtqueue_poll_split(struct vring_virtqueue *vq,
-				 unsigned int last_used_idx)
-{
-	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->idx);
-}
-
 static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1710,16 +1709,20 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static bool more_used_packed(const struct vring_virtqueue *vq)
+static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
 {
-	u16 last_used;
-	u16 last_used_idx;
-	bool used_wrap_counter;
+	bool wrap_counter;
+	u16 used_idx;
 
-	last_used_idx = READ_ONCE(vq->last_used_idx);
-	last_used = packed_last_used(last_used_idx);
-	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
-	return is_used_desc_packed(vq, last_used, used_wrap_counter);
+	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
+	used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+
+	return is_used_desc_packed(vq, used_idx, wrap_counter);
+}
+
+static bool more_used_packed(const struct vring_virtqueue *vq)
+{
+	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
 }
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
@@ -1843,17 +1846,6 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	return vq->last_used_idx;
 }
 
-static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
-{
-	bool wrap_counter;
-	u16 used_idx;
-
-	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
-	used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
-
-	return is_used_desc_packed(vq, used_idx, wrap_counter);
-}
-
 static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.1


