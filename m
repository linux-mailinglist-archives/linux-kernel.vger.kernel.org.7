Return-Path: <linux-kernel+bounces-824131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97EB882E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12624E3674
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A112D24A2;
	Fri, 19 Sep 2025 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+quF2w4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695562E040A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267177; cv=none; b=eHK14RxbV8b75TBQ8GjW1I6n8x58aRfDUGz5XuQzOXURtXwgerj3Oam+vSBCqTjhTxoYvIiyeh5P+iyJZRzIwthOE5MEHD0gvb7CXer7pQPrncTySJJmsZgca1FZQUwDod17lHDUwwf4Z9YGkqiz1HomG7dtoSuWTmkQ5gDvwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267177; c=relaxed/simple;
	bh=w1C0RSEHh1VzfvXKM+zrRAOIr93whV01vaguRwMBpio=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug8iFlyUNld8qOOeOxHhl6a7yhwWMh4d+4bBaiDVFNt5pHNHLCATwFKgJAWr82crvRqV5wncUKGqv/EoomGZKLtT2mGuZ9OvCucy/iiWoeRUBRmmyvP0XQO4mx6H1WaQs97ypHj+B0kT7uMvZnYzDnuXavcfpRPPn6Yr9z6/vTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+quF2w4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wBklSwaQ2zaTA0CULKLUrmSkAgxtpiImNu2NlSDBBY=;
	b=S+quF2w4C1+bp/p97o7pCgOudSGD8o9zDRmqGfhDn9JkQAb+WvU/XuDkBixlNMgbobPf1L
	s6BpbmBpao9lyK+zI4eeTQSdfjJbKiEeBU/sFoDfm77s27GbjjhL0Ozv1+voG3m7ZgJkoL
	0OSCsnKgPUMvXrB7apxEh5PJricTwtU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-WxoiZlbhNdm1gJ_pPX2_Vg-1; Fri,
 19 Sep 2025 03:32:52 -0400
X-MC-Unique: WxoiZlbhNdm1gJ_pPX2_Vg-1
X-Mimecast-MFC-AGG-ID: WxoiZlbhNdm1gJ_pPX2_Vg_1758267171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA36E1800290;
	Fri, 19 Sep 2025 07:32:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC35E19560BB;
	Fri, 19 Sep 2025 07:32:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
Date: Fri, 19 Sep 2025 15:31:47 +0800
Message-ID: <20250919073154.49278-13-jasowang@redhat.com>
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

Use u16 for last_used_idx in virtqueue_poll_split() to align with the
spec.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2290ee917c35..b1b6af297061 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -805,7 +805,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-				 unsigned int last_used_idx)
+				 u16 last_used_idx)
 {
 	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
-- 
2.31.1


