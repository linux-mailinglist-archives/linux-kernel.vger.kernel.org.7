Return-Path: <linux-kernel+bounces-687907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201C8ADAAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A6B172BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86002701BD;
	Mon, 16 Jun 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M94ZoSKo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668B26E704
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062378; cv=none; b=uao58m4XNVj+RZeiLFywigm6xF6rgY9QhAnVFWPY8XurQnWa0k1tIa4ECuXO/Lj06xeW5EtsmbnmfDjzEELUQ+zHWlKd3Z3c29FP5wlPo3yWt8TPLzFvFGHK9I1MHk7NTRL1ePVHQ2EQ02o0ofAyP0wJ5uH9YUB9DvXJ+3bhASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062378; c=relaxed/simple;
	bh=pwqlNXqiThwXkwZ8WdEDyRZWZBWmhdcncW6BgL9BrcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg/RplT4U38UUbM5lBNcZYi8rwNEixtRB7qDghuykJSikVtwseRASef6+oAr7WvkM8ZtpyLnLDXk/a6ur6BHVWZESumX7y9AK2BF5fX1JSmkh21iLM/c1gZKYh6amxF1HxOwjbPRUIfTxhjxY+2COWd8z+93z27UH1AA9VK+P6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M94ZoSKo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750062374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIjPOYFvozYojOMPnuFJOvuLP8xgwC21YPpzEJOgj1Y=;
	b=M94ZoSKoSbrxyFJHO8KcJqpqqYzM089nLwLVffNgioJAJ6RxK8mgNDb1bSrqOiDUUVaBfZ
	f2QHOEVnhAqmckle0hdNG71GSLLCWyF2P3fYeV6392KBqQFpmho0EJc8ZIMnQTFBsTOf0E
	S0dTazcY3IdindoXGK3yyQDKMoqXmrA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-GNC6ExIaNXCAsj2VrGTR0w-1; Mon,
 16 Jun 2025 04:26:11 -0400
X-MC-Unique: GNC6ExIaNXCAsj2VrGTR0w-1
X-Mimecast-MFC-AGG-ID: GNC6ExIaNXCAsj2VrGTR0w_1750062370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ED1318001C6;
	Mon, 16 Jun 2025 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C522618002B6;
	Mon, 16 Jun 2025 08:26:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 11/19] virtio_ring: switch to use vring_virtqueue for detach_unused_buf variants
Date: Mon, 16 Jun 2025 16:25:09 +0800
Message-ID: <20250616082518.10411-12-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4af29a6e15e8..03b17bc275dd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -950,9 +950,8 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
 	void *buf;
 
@@ -965,7 +964,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 		buf = vq->split.desc_state[i].data;
 		detach_buf_split(vq, i, NULL);
 		vq->split.avail_idx_shadow--;
-		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
 				vq->split.avail_idx_shadow);
 		END_USE(vq);
 		return buf;
@@ -1892,9 +1891,8 @@ static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
 	void *buf;
 
@@ -2642,8 +2640,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
-				 virtqueue_detach_unused_buf_split(_vq);
+	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
+				 virtqueue_detach_unused_buf_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
-- 
2.34.1


