Return-Path: <linux-kernel+bounces-832254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A477EB9EBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DC27B0DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46773009F0;
	Thu, 25 Sep 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5WtOHyG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725792FFFAD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796690; cv=none; b=o9zf9cUhK+tpl4zkdOYIMd+KpmAyfpH8ZclytCrnLAlI7QMhO7zm85JD3CanteyObq7iI2XNk0nk41CYJFjAGAI6PmrbgrVcXisgBSbPRgU/ptm1vWH1U0PnZIQZ7xqJ6UIE8LQMiQD/MGyWMHhsHzOp8TaFuYphRMvWwSVecXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796690; c=relaxed/simple;
	bh=MALz/FofoEbSHEf6mQJP1GyBxEkwL9YayW4mkSbywGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhJXQxOS3vFPtEqpT1avFKWI/PhB3LjpBXI1aiIkfG1U9tdu4Ke6WYbaoQfzdo0nXQgwohGzGbbHqHhVP4kyikuSgAdQqkx9eqrg1SBrK8B3Imc8G3KiIkVMJcCKC/bejvhSYSIC/Cty/0lQli0pB1m7xNuRG/EKE4fUFs1gbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5WtOHyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYxyVzlU8ucx3XFZYxzyS++vlvHqCYS1VTslr24T/xE=;
	b=N5WtOHyGKYXIfNMuAceGJfMtr0nhSeA34Yv3VjOsGFyk6QxEnfXETcAqk8JCMGuZSbU3o+
	QheVmThl82+JSt9lLCR1iXMlHmwwUXQb2o2mptyjVGZrn1sMLo7Ufkfj3vkAlB/hHnLsKE
	tHoLnlnfmzv7Hs1QCU6B+AGkCbd9T68=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-Qa9upjgWPKCaaaeQxMJ9lw-1; Thu,
 25 Sep 2025 06:38:06 -0400
X-MC-Unique: Qa9upjgWPKCaaaeQxMJ9lw-1
X-Mimecast-MFC-AGG-ID: Qa9upjgWPKCaaaeQxMJ9lw_1758796685
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B856197740A;
	Thu, 25 Sep 2025 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE65119560AB;
	Thu, 25 Sep 2025 10:38:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 11/19] virtio_ring: switch to use vring_virtqueue for detach_unused_buf variants
Date: Thu, 25 Sep 2025 18:37:00 +0800
Message-ID: <20250925103708.44589-12-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 768933daba9a..58c03a8aab85 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -955,9 +955,8 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
 	void *buf;
 
@@ -970,7 +969,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
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
 
@@ -2646,8 +2644,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
-				 virtqueue_detach_unused_buf_split(_vq);
+	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
+				 virtqueue_detach_unused_buf_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
-- 
2.31.1


