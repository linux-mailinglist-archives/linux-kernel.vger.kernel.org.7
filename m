Return-Path: <linux-kernel+bounces-824137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755EB88301
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1063B16FFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129F2C325C;
	Fri, 19 Sep 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK3hY+iD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB12F261F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267199; cv=none; b=F7uazTvlyEXNHVdmY3shvZsE/gj1cDzdcxY/JvK2X3Pv05NZq3BVa4LER6prnf0EkQ54UP6f4Kg1JLOD0jemEhKiul+ighYmyDiJ8jHxy5GEGnwQ/lYp7Rbr/e3vYRNbqZf0mvi31W12yp2PadMFb7zdotjN/GPQSUjk33kfs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267199; c=relaxed/simple;
	bh=r82W1lKVa/2er0+TG3wmw0sL9wy4EaTIDRdRRomCyQM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFWv802btddg+e/YuYLdVZKsHAAOElxNIitPA4yZ7xDnHc/rjo5Q3BdTURx3eAIpmZ4CHJhVhPLVF2MHTCatpMLbB81VzdMbWWt9llM3lFkLd6BXBa+t4AxX8K2jddD6E4JOgv8CztlcE+Nac5yO8v+iCgj9paot/MVWd8NKBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK3hY+iD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T23W7DIKB49P1edCgTfToWIbfhHLg1Pf5xyIauhPFg=;
	b=dK3hY+iDxu2WMleJ2HT+8u2wkiL9dqzTJUCYObwicXje3QG9Wwg17yOid4IEGbi+xYG2Dy
	neQ9eHPrbWwa5vdLDpm+I2faZD2GiLWYjZuEMGAWAgMY6QkvPUo7+09sAFkoD0MNLPahhS
	/wxaAv3kD7HXgqITVJ0sIwFtElpxW2M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-YhlN9d2UOb2dfRjJ4MgT6Q-1; Fri,
 19 Sep 2025 03:33:11 -0400
X-MC-Unique: YhlN9d2UOb2dfRjJ4MgT6Q-1
X-Mimecast-MFC-AGG-ID: YhlN9d2UOb2dfRjJ4MgT6Q_1758267190
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E23919560B2;
	Fri, 19 Sep 2025 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C1C219560BB;
	Fri, 19 Sep 2025 07:33:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 17/19] virtio_ring: factor out split indirect detaching logic
Date: Fri, 19 Sep 2025 15:31:52 +0800
Message-ID: <20250919073154.49278-18-jasowang@redhat.com>
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

Factor out the split indirect descriptor detaching logic in order to
make it be reused by the in order support.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f376f717c8e4..5aa0cd785362 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
 	return needs_kick;
 }
 
+static void detach_indirect_split(struct vring_virtqueue *vq,
+				  unsigned int head)
+{
+	struct vring_desc_extra *extra = vq->split.desc_extra;
+	struct vring_desc *indir_desc =
+	       vq->split.desc_state[head].indir_desc;
+	unsigned int j;
+	u32 len, num;
+
+	/* Free the indirect table, if any, now that it's unmapped. */
+	if (!indir_desc)
+		return;
+	len = vq->split.desc_extra[head].len;
+
+	BUG_ON(!(vq->split.desc_extra[head].flags &
+			VRING_DESC_F_INDIRECT));
+	BUG_ON(len == 0 || len % sizeof(struct vring_desc));
+
+	num = len / sizeof(struct vring_desc);
+
+	extra = (struct vring_desc_extra *)&indir_desc[num];
+
+	if (vq->use_map_api) {
+		for (j = 0; j < num; j++)
+			vring_unmap_one_split(vq, &extra[j]);
+	}
+
+	kfree(indir_desc);
+	vq->split.desc_state[head].indir_desc = NULL;
+}
+
 static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 			     void **ctx)
 {
 	struct vring_desc_extra *extra;
-	unsigned int i, j;
+	unsigned int i;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
@@ -799,34 +830,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	/* Plus final descriptor */
 	vq->vq.num_free++;
 
-	if (vq->indirect) {
-		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
-		u32 len, num;
-
-		/* Free the indirect table, if any, now that it's unmapped. */
-		if (!indir_desc)
-			return;
-		len = vq->split.desc_extra[head].len;
-
-		BUG_ON(!(vq->split.desc_extra[head].flags &
-				VRING_DESC_F_INDIRECT));
-		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
-
-		num = len / sizeof(struct vring_desc);
-
-		extra = (struct vring_desc_extra *)&indir_desc[num];
-
-		if (vq->use_map_api) {
-			for (j = 0; j < num; j++)
-				vring_unmap_one_split(vq, &extra[j]);
-		}
-
-		kfree(indir_desc);
-		vq->split.desc_state[head].indir_desc = NULL;
-	} else if (ctx) {
+	if (vq->indirect)
+		detach_indirect_split(vq, head);
+	else if (ctx)
 		*ctx = vq->split.desc_state[head].indir_desc;
-	}
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-- 
2.31.1


