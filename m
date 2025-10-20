Return-Path: <linux-kernel+bounces-860213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6437ABEF9AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07B134EE580
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14812DECAA;
	Mon, 20 Oct 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/cHfe/W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F717BB35
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944237; cv=none; b=HUuV0hc0tKgziA8XM7H1/gwSVEIdOSuuL7p0fVe20rUXZu/Mlu7rQsOqBgEkRWaJDm6vQ9hZQu9O5dwBld164NpwfgRKvmWO5CnGzhFpivFOgnGRMRs+wKDuRrxdM7mqDZEA8QazyT78khlZ7U5hIFPjGS+PqURE4DXvA+/OH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944237; c=relaxed/simple;
	bh=/P9F+XZD4Jw4baApW319M4i8p1Tx8WVEcfea/cWb69Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NauQGLYz4Bg+4jECAClmtXPI5cd3ocxhcZQwEm3Vpx21eFsgR2WXZHc/P+MsVbg0erGKKEp8K8vGNpqiT9jymfXonuE/YGirJvsg06MO5Y7d6/qQ16PnYWV+Cjvc6p9oqlK9OGAtXXdcWE7iaeDE4puZ1+cavbNZ40rZc4ycSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/cHfe/W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RirLQpnZ2Apia0UR72xDNP7krHXcdWwsna0GSCf+FV4=;
	b=h/cHfe/WM2h9XSZray1C+bxZrnbbD/07r7kHKmCQ1Nt9ENGn4wTUXTKw5ctjf+JxFYiO1y
	+g3AsxvQlsivbGG28wElWPHfxxa1q6LAdCtVqtkEdkKh0O0xz6lkv9BdyBxKJe5vRE6w8T
	3oZyih1GoWpFUfmdIMeCS5MgKZsRNko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-ofHfmnAYNc-yE-oarHq6OA-1; Mon,
 20 Oct 2025 03:10:33 -0400
X-MC-Unique: ofHfmnAYNc-yE-oarHq6OA-1
X-Mimecast-MFC-AGG-ID: ofHfmnAYNc-yE-oarHq6OA_1760944232
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 463F419560A7;
	Mon, 20 Oct 2025 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26E9A300019F;
	Mon, 20 Oct 2025 07:10:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 05/19] virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare variants
Date: Mon, 20 Oct 2025 15:09:49 +0800
Message-ID: <20251020071003.28834-6-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 693671bac841..aadeab66e57c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -717,9 +717,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return -ENOMEM;
 }
 
-static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
+static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old;
 	bool needs_kick;
 
@@ -736,12 +735,12 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
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
@@ -1596,9 +1595,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return -EIO;
 }
 
-static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
+static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
 	bool needs_kick;
 	union {
@@ -2457,8 +2455,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
-				 virtqueue_kick_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
+				 virtqueue_kick_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
 
-- 
2.31.1


