Return-Path: <linux-kernel+bounces-832258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1FB9EC38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B74B19C1D93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E7302756;
	Thu, 25 Sep 2025 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fn6bN3K/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138C3043D3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796706; cv=none; b=LolBh14RKC2QKlLds7u7d3UjBBTQgEySYIwPSgziWEczhqQ7koerIsnNGC5KXfR0KbaacPIKoEQ3+8SFOLJgzglMaSTyUiFGkkZ2QE1gGf4o/Kqt3OyRPLKKvLI5QHPes7MsL1FolC7htW5g8VA5yWWclv+MJrV2mxearWaRGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796706; c=relaxed/simple;
	bh=ZNLWvVpWyJIkKRy8TPsNGi9oM++rgXj5eq65OA7yF3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDZWjwU3SXpvY49YavscLj3lzIyP6o398BLS/BnV3Iqhji6TUhF7Z8r2215oTl4q+7zHzxj5UFKzSpWul4CU6Y7/aM9iK/R0sUCCystkvwn43WHRKIOpNWaGXZBCbcdHs5WHb5gFSBec7phT6AjxD63pmdN4Vb1//fc+QHxu1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fn6bN3K/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAV2TSkmsxXnO2vK3LDx0RpRrf46uVfrNlYOVhT+8U=;
	b=Fn6bN3K/jZzbmaBLmhrvxRheDHE1/sIqtvI3+HJ+mUD1FjBUPnRqpF7JjsEe6C1Y89QZtF
	k181crE93A/a3F4Ef66NNSwxoXTYt1VBIj+VpkbXHcMea7o+LMx3fod9mz1y5X+QgHlRXo
	nduFndWdNGPjRU40fZZVgWuQ47ri8iY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-zzOsAvejM3ejPgLBuZpVXA-1; Thu,
 25 Sep 2025 06:38:22 -0400
X-MC-Unique: zzOsAvejM3ejPgLBuZpVXA-1
X-Mimecast-MFC-AGG-ID: zzOsAvejM3ejPgLBuZpVXA_1758796701
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68D8219774D4;
	Thu, 25 Sep 2025 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35CAD19560AB;
	Thu, 25 Sep 2025 10:38:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 15/19] virtio_ring: factor out core logic of buffer detaching
Date: Thu, 25 Sep 2025 18:37:04 +0800
Message-ID: <20250925103708.44589-16-jasowang@redhat.com>
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

Factor out core logic of buffer detaching and leave the id population
to the caller so in order can just call the core logic.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fc04cdb99706..4b01c26f83b9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1661,8 +1661,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
-static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
+				       unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
@@ -1673,8 +1673,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_extra[state->last].next = vq->free_head;
-	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
 	if (unlikely(vq->use_map_api)) {
@@ -1711,6 +1709,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	}
 }
 
+static void detach_buf_packed(struct vring_virtqueue *vq,
+			      unsigned int id, void **ctx)
+{
+	struct vring_desc_state_packed *state = &vq->packed.desc_state[id];
+
+	vq->packed.desc_extra[state->last].next = vq->free_head;
+	vq->free_head = id;
+
+	detach_buf_packed_in_order(vq, id, ctx);
+}
+
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 				       u16 idx, bool used_wrap_counter)
 {
-- 
2.31.1


