Return-Path: <linux-kernel+bounces-743607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE666B100E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533DE7B679C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7B230BE4;
	Thu, 24 Jul 2025 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMQcH59O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0122F755
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339252; cv=none; b=Ju3yQcULu4nlPxNwyB3oot8mtYGTjOyH4dtug6BBi/AobkexeeBlM9TiBhB9jNJw2r+5S8NKcluXtrhdDL4SBeshrvLMdY+5YdaAglu/afxw8SM4oYh1rwLbxWj5YRNWZU7p3whNicThShNVaQ++imKEG8ULyCJ714+CFQaT3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339252; c=relaxed/simple;
	bh=f8Hay0T5RLtr2APW8jx5BDxUXw+HF7929uZ5d5RBo3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqCTrqGgj32FVFGNhPATqEfMZc1sUQzkifPQY2pxjeQey/mdUxNPB1WPkazBBY6tj+JSruJ0zaxqBnF5nSxkD7571CnV5F2ddvdMHJQ8taCkQyRgaaWbfVP0oJXbY0ad5tTVuj6JCoNFvifQwjEQz8Uub5NZxz5K19NZOSD7HRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMQcH59O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753339250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2xXvEXElQU9pxX1JjWEG3fP5Z6meiP0S2R7oUbAZzk=;
	b=CMQcH59OZ55JCMDbPEDYmM0t6Y2Xvokw2neXeAjqE/VSiXRkezvamimlGl8ZYLSeS7+Onn
	KAX0ZqgeQePwWvREkIfc2SyiujQgTdRVmJjMrHJcQVI992LdHcJD/ceYM1XNBUoPh3PRbK
	0xXcqXXYQMBWPw4TDkQvHKnFn/WAgdY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-i-6P8BeYMfKDk7ADFKlTeg-1; Thu,
 24 Jul 2025 02:40:48 -0400
X-MC-Unique: i-6P8BeYMfKDk7ADFKlTeg-1
X-Mimecast-MFC-AGG-ID: i-6P8BeYMfKDk7ADFKlTeg_1753339247
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4619D195608B;
	Thu, 24 Jul 2025 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 105EE180035E;
	Thu, 24 Jul 2025 06:40:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 05/19] virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare variants
Date: Thu, 24 Jul 2025 14:40:03 +0800
Message-ID: <20250724064017.26058-6-jasowang@redhat.com>
In-Reply-To: <20250724064017.26058-1-jasowang@redhat.com>
References: <20250724064017.26058-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index f30d491678a5..ac14324588bb 100644
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
@@ -2458,8 +2456,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
-				 virtqueue_kick_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
+				 virtqueue_kick_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
 
-- 
2.39.5


