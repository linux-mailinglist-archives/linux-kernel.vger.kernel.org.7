Return-Path: <linux-kernel+bounces-860214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5203FBEF9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C12F94EED0D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44CB2D94A6;
	Mon, 20 Oct 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TleQ7rSk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDD2DAFDE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944239; cv=none; b=h+0EIxO2QzNBjZ2nAXjAYDWRbXixmkY4WPm01GDACsoavcD2AU/D7r5ij1s7joiWhT1gYPKDXuM9MK5l8A9FU3nfEDK2dRLMAmjNCzTnG7zDz2kOv9AT9uJwMu8LRm0KSBlv922ImA5FaGvKntHcDQmH20JQHB4vbexz+gq4r4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944239; c=relaxed/simple;
	bh=92dzLgz7GPIFGxrV7u59xZvyZkD4ZOwGTYSuMOriM2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4+2V4q/NqseNxwUzWeAxjLSgnkprjKIGggbad0jdcRe/VbXE8nv9+vE9vEvvyBEZUxwdKr3zKYV1hRIhTb1oi87a7mCHBlZfSHyE1ZA+oNgRHULHlAArA/iY/fNQ39xB1Vhaz4IozZmW6yJodmPZFHbJjd/JSJ4ZcxZHjXyQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TleQ7rSk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9X+8nJzs108oA3zz8mRtrO71MkKZ7x5Ta9F7UOdDxY=;
	b=TleQ7rSk6jTKSaOyZoY2Nxu81iIPbTi5o4aBkONfAq6FEMu0nphjQ9WuulDK6N4KLVL7QV
	lR+PxmO1KyPpuzk2nNcSH2OWdUZ1uUFwMev+bkkBIgCLhL6UL5Lz5bbsW5V+r4bSoCFaCB
	a03dm7dhyG9/pg0iUycTZqaxFKEI8sc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-b2ik-4mjMiemGa3J-GQTzQ-1; Mon,
 20 Oct 2025 03:10:29 -0400
X-MC-Unique: b2ik-4mjMiemGa3J-GQTzQ-1
X-Mimecast-MFC-AGG-ID: b2ik-4mjMiemGa3J-GQTzQ_1760944228
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 458B9180057A;
	Mon, 20 Oct 2025 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FBFE300019F;
	Mon, 20 Oct 2025 07:10:24 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 04/19] virtio_ring: switch to use vring_virtqueue for virtqueue resize variants
Date: Mon, 20 Oct 2025 15:09:48 +0800
Message-ID: <20251020071003.28834-5-jasowang@redhat.com>
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
index d8a07e0d9fa8..693671bac841 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1221,11 +1221,10 @@ static struct virtqueue *vring_create_virtqueue_split(
 	return vq;
 }
 
-static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_split(struct vring_virtqueue *vq, u32 num)
 {
 	struct vring_virtqueue_split vring_split = {};
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	struct virtio_device *vdev = vq->vq.vdev;
 	int err;
 
 	err = vring_alloc_queue_split(&vring_split, vdev, num,
@@ -2182,11 +2181,10 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	return vq;
 }
 
-static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
 {
 	struct vring_virtqueue_packed vring_packed = {};
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	struct virtio_device *vdev = vq->vq.vdev;
 	int err;
 
 	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vq->map))
@@ -2809,9 +2807,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		recycle_done(_vq);
 
 	if (vq->packed_ring)
-		err = virtqueue_resize_packed(_vq, num);
+		err = virtqueue_resize_packed(vq, num);
 	else
-		err = virtqueue_resize_split(_vq, num);
+		err = virtqueue_resize_split(vq, num);
 
 	err_reset = virtqueue_enable_after_reset(_vq);
 	if (err_reset)
-- 
2.31.1


