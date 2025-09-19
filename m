Return-Path: <linux-kernel+bounces-824135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85686B882FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BF47BEF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409012EDD58;
	Fri, 19 Sep 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EibhF3Id"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304812F1FCC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267189; cv=none; b=DU5H2C6JXHkUgYx599dZxkPSXSkv6kdFHPL9ZZ4RbAmunleePJpnKydnedoMQVpIVwbXHPH7GZvT4TOKDWtHGG3l99ThMOjnuBVAq1d6lQ4R/VF4yjHHdQU/GsSHTTBgtjmtBCFuKwPZvGAD/VWR3sbdlJXA5gG2f1AfBXnUa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267189; c=relaxed/simple;
	bh=JVKitmswlq4ZK/WfT8XMVZwz/iP0I5UvB5KjGP8wgvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVStE+Fs6Ou25wnRk+qwpOX2t0eQdqrkVYhZyL6qUNo89d/p2IYZhDGe9y4tcwhrtB2HsQkHC0m6Zx3ktRRD/WOiS95ENNDH0DspOLMZR6yklKVY1hntJvvic60Ape4Da+j0bftXqQEW0+cYEM6RH8rZBhDgDliO1tSwW4nafdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EibhF3Id; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9YZjEGI6Oy8XJp9Y3nYR0EGZPGfX0eXgaSvK8i8cBc=;
	b=EibhF3IdsJ9ak5mu8S3ayzxpg+VSAEcouefrePSJG8gY8iwvkX8312JXTS5WoB2Z683iNI
	Dsv1FUGIohsXLBa3oquCR7+sFxJwKltHhVVl663vK+Yk08ImrMRrFbuiLSSNw95jXZZor2
	rrpOB18LBTkP8nNtMHOOQUA/kqrF+OA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-FfOlTCitN3Sw1oghdoK_Fg-1; Fri,
 19 Sep 2025 03:33:03 -0400
X-MC-Unique: FfOlTCitN3Sw1oghdoK_Fg-1
X-Mimecast-MFC-AGG-ID: FfOlTCitN3Sw1oghdoK_Fg_1758267182
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D50D195608D;
	Fri, 19 Sep 2025 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ED7619560BB;
	Fri, 19 Sep 2025 07:32:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 15/19] virtio_ring: factor out core logic of buffer detaching
Date: Fri, 19 Sep 2025 15:31:50 +0800
Message-ID: <20250919073154.49278-16-jasowang@redhat.com>
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

Factor out core logic of buffer detaching and leave the id population
to the caller so in order can just call the core logic.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0949675a3d12..a83d08070e8a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1662,8 +1662,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
-static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
+				       unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
@@ -1674,8 +1674,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_extra[state->last].next = vq->free_head;
-	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
 	if (unlikely(vq->use_map_api)) {
@@ -1712,6 +1710,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
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
+	return detach_buf_packed_in_order(vq, id, ctx);
+}
+
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 				       u16 idx, bool used_wrap_counter)
 {
-- 
2.31.1


