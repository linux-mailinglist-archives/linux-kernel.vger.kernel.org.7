Return-Path: <linux-kernel+bounces-664926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1535AC6246
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083904C0DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 06:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007D2459FE;
	Wed, 28 May 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0TywvJ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFF24418D
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414633; cv=none; b=gYPOFa0Krw2Gb9AgGo+v0WQl4TDbstlozb9QdbPwre0u11n0PbMVROYwgBcdKgTuUX2fr8r/iuysn6PWasN9SmSE059ttm92ZZO11j8jLz7a81U36wh9aNKnKlNrLjPuFMrTnJlN5wfxdzl8MXlim9Uu/+SMc3NS97SWJLsW5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414633; c=relaxed/simple;
	bh=QE9b1joO3P53vlD1O5kxYhXU8+LWJX93eEfFeNpQ0XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYTUDH31uOL6TcQCDikpaSJ4lNuTARRwQ56xMKv58U6F4qhLuP7GabpwzDgUIlPr2olsZhNGovfDsB3EEB8FhzgFsfNjgptrXTXgWpsrHgAHUW4blAQAMvzHRAuiriD/IfLGFXtyRHXJjCnZ+lqWLa1kSVg77NDMuxGm9tbjg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0TywvJ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748414631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+iZWJRbVoWfyzg7P4mKc5R5mrCEqCCYAsV0aepJYIeM=;
	b=W0TywvJ+lkiIW0jp4vrc02fn/T7ryJVri4clxhDK0KFzW2jkw6CknTVBIwPmcTXnkEBoJg
	9UdWsLxjzxO9g7jVfTw6E2B4qvsMktQUAWYJGJafeQ05OG2dVOG/4XxrRTGucUzqBtZo6w
	RJQFw1Za5eZlDzOOZ2wd5NFzrSR5JtI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-S_FDkzDKMLGg3BuDeSuiLA-1; Wed,
 28 May 2025 02:43:47 -0400
X-MC-Unique: S_FDkzDKMLGg3BuDeSuiLA-1
X-Mimecast-MFC-AGG-ID: S_FDkzDKMLGg3BuDeSuiLA_1748414626
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D602D1954207;
	Wed, 28 May 2025 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.248])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0CAC1956095;
	Wed, 28 May 2025 06:43:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 16/19] virtio_ring: factor out core logic for updating last_used_idx
Date: Wed, 28 May 2025 14:42:31 +0800
Message-ID: <20250528064234.12228-17-jasowang@redhat.com>
In-Reply-To: <20250528064234.12228-1-jasowang@redhat.com>
References: <20250528064234.12228-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Factor out the core logic for updating last_used_idx to be reused by
the packed in order implementation.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 43 +++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1bdd332d515e..e8e0d1204f52 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1757,6 +1757,30 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
 }
 
+static void update_last_used_idx_packed(struct vring_virtqueue *vq,
+					u16 id, u16 last_used,
+					u16 used_wrap_counter)
+{
+	last_used += vq->packed.desc_state[id].num;
+	if (unlikely(last_used >= vq->packed.vring.num)) {
+		last_used -= vq->packed.vring.num;
+		used_wrap_counter ^= 1;
+	}
+
+	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
+	WRITE_ONCE(vq->last_used_idx, last_used);
+
+	/*
+	 * If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call.
+	 */
+	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
+		virtio_store_mb(vq->weak_barriers,
+				&vq->packed.vring.driver->off_wrap,
+				cpu_to_le16(vq->last_used_idx));
+}
+
 static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 					  unsigned int *len,
 					  void **ctx)
@@ -1800,24 +1824,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
 	ret = vq->packed.desc_state[id].data;
 	detach_buf_packed(vq, id, ctx);
 
-	last_used += vq->packed.desc_state[id].num;
-	if (unlikely(last_used >= vq->packed.vring.num)) {
-		last_used -= vq->packed.vring.num;
-		used_wrap_counter ^= 1;
-	}
-
-	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
-	WRITE_ONCE(vq->last_used_idx, last_used);
-
-	/*
-	 * If we expect an interrupt for the next entry, tell host
-	 * by writing event index and flush out the write before
-	 * the read in the next get_buf call.
-	 */
-	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
-		virtio_store_mb(vq->weak_barriers,
-				&vq->packed.vring.driver->off_wrap,
-				cpu_to_le16(vq->last_used_idx));
+	update_last_used_idx_packed(vq, id, last_used, used_wrap_counter);
 
 	LAST_ADD_TIME_INVALID(vq);
 
-- 
2.31.1


