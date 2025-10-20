Return-Path: <linux-kernel+bounces-860212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FCBEF9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9F5B4EDF03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C52DE6FB;
	Mon, 20 Oct 2025 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1WFYftx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965552DAFDE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944234; cv=none; b=tmPAoH68VsRMVyZQkNXNW2U89wY1jetmRgmlxhYYHtg619dgsFCukMvhsHZolIzE6bjkuIPSriVcOzatx2xRDt0OGOj6RQx1de84tbiy8zT/diuC0SdHJN+qtDhx5/6CAqCgOxgeX/uOQHSHZneEKNyInYp1Y86YgozaDGTpT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944234; c=relaxed/simple;
	bh=HYsHOGN3EYNOH6tOJeaoOb+gHk0SE0FJEJ4VPLlA9Z4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrVpJitRhy9FYnjrNSN1D6LH5JPhSW3NchaIBGzXZmi9oK2EiQ8dqiVb+Hvgpt6cI+7xUCiGfQ+KJWdTJMO4IvSQ7gM6MeOQYVHNa5qRiDpcMK/dw9CGBSnxD3My0aoV6zFO43QgUlkO9/eg+TsDm3dAUGNPi/jGgVLuzF9KxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1WFYftx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDhkOP2irC9AYhWmwD5Iofw1hRzZ9N7g2ReMYfK0ONA=;
	b=O1WFYftxraCMx9jFDGnvNZdMODAYI0BINjYh3zWQBOJG4AEfxoLxh9UVo4+mkoKhAv3i9T
	fepkEZ8c2qEa3STLDy7hV55lxNJxycL4VBeQ1uMq6IC2iGfpOW99KzJ6gFbXaQSnYDEihj
	BHxp17sXFlZVxUubomQ+WwpkXSD19/Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-5k4J9FGrNWq2gOCjYgmTrQ-1; Mon,
 20 Oct 2025 03:10:22 -0400
X-MC-Unique: 5k4J9FGrNWq2gOCjYgmTrQ-1
X-Mimecast-MFC-AGG-ID: 5k4J9FGrNWq2gOCjYgmTrQ_1760944221
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2B49180035D;
	Mon, 20 Oct 2025 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A173A300019F;
	Mon, 20 Oct 2025 07:10:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 02/19] virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
Date: Mon, 20 Oct 2025 15:09:46 +0800
Message-ID: <20251020071003.28834-3-jasowang@redhat.com>
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
index 73790593523a..fed3962411a1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -919,11 +919,10 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 	return last_used_idx;
 }
 
-static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_idx)
+static bool virtqueue_poll_split(struct vring_virtqueue *vq,
+				 unsigned int last_used_idx)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
+	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
 }
 
@@ -1844,9 +1843,8 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	return vq->last_used_idx;
 }
 
-static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
+static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	bool wrap_counter;
 	u16 used_idx;
 
@@ -2611,8 +2609,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 		return false;
 
 	virtio_mb(vq->weak_barriers);
-	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
-				 virtqueue_poll_split(_vq, last_used_idx);
+	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
+				 virtqueue_poll_split(vq, last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
-- 
2.31.1


