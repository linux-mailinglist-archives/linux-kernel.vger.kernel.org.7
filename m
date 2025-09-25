Return-Path: <linux-kernel+bounces-832257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1FB9EC32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57E9189C625
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1E73043CA;
	Thu, 25 Sep 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp7lu5hE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F53019BB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796704; cv=none; b=d1eMkyBFIMnq1Gvq/wyP+0Oyve3SOb2xpTCvNrh2VSmFPuPR9GPs0TIGaA4F9UxnhNmDGHqSEcWRwXLDLSJmwwQZfFszwHuizgdMTfgnz0swou1eSFS0JgKXGvL8bPOrZBvztrYBWfso5qAMhAgDndFFDRPD7c51VTdF0sz/nQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796704; c=relaxed/simple;
	bh=CH4rz+P+QNSzqKyOPNzKABud1pLdWxa27qUOxPHkRP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9OCBU1asPmdYFLxEJhh/Di2ZTj5+zrzEkdexeGhoLJSxOs8EqMduHXxie6RUytkQLQeBNX8SJ2TrVpUqQCl2R1kYjDeCHn6Za31ANmswj8Nt8Jhq3aiQK2KX4h38WmdqOlIBTBEnaXo6eung5pA0seDcczTIuSzJ2dJZG6OTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dp7lu5hE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVoaWeTO7eT01G00S31LXEdWXR0bg/e0kcC0ie+BVXE=;
	b=Dp7lu5hEfEV9B9TdjniUPVE9HN9/s1ZINdillhyf87y90IAf5x7tqS7vjmnF7GXMsUP6Bs
	Llpi9lLPbsj1XxI/p5zZ1Di/sWJe+Tq4UkX9zh0YnXTgKu1L4e+cZjDaqZdtTK+lY1dQXh
	VP4bMmCJQYvx888BqZZn7ZmhKs6v/mY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-qhh63tQoOFWzy6ZUKIpA8A-1; Thu,
 25 Sep 2025 06:38:18 -0400
X-MC-Unique: qhh63tQoOFWzy6ZUKIpA8A-1
X-Mimecast-MFC-AGG-ID: qhh63tQoOFWzy6ZUKIpA8A_1758796697
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8924418002C8;
	Thu, 25 Sep 2025 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27E5819560B4;
	Thu, 25 Sep 2025 10:38:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 14/19] virtio_ring: determine descriptor flags at one time
Date: Thu, 25 Sep 2025 18:37:03 +0800
Message-ID: <20250925103708.44589-15-jasowang@redhat.com>
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

Let's determine the last descriptor by counting the number of sg. This
would be consistent with packed virtqueue implementation and ease the
future in-order implementation.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e61867268c75..fc04cdb99706 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -574,7 +574,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, err_idx, c = 0;
 	int head;
 	bool indirect;
 
@@ -638,12 +638,11 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
 				goto unmap_release;
 
-			prev = i;
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
-						     VRING_DESC_F_NEXT,
+						     ++c == total_sg ? 0 : VRING_DESC_F_NEXT,
 						     premapped);
 		}
 	}
@@ -655,21 +654,15 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
 				goto unmap_release;
 
-			prev = i;
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
-						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE,
-						     premapped);
+			i = virtqueue_add_desc_split(vq, desc, extra,
+				i, addr, len,
+				(++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
+				VRING_DESC_F_WRITE, premapped);
 		}
 	}
-	/* Last one doesn't continue. */
-	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
-		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
-			~VRING_DESC_F_NEXT;
 
 	if (indirect) {
 		/* Now that the indirect table is filled in, map it. */
-- 
2.31.1


