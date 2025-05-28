Return-Path: <linux-kernel+bounces-664922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC06AAC6240
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 08:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852833A6399
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25AB2459D0;
	Wed, 28 May 2025 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3kjKGgn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F63248F70
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414616; cv=none; b=GKvUXK/KhL67qcKDrqFzm5K95H2maz161A13XL/2//oq7gBfjBEXjtLJ++kZbW8nIqsb9JBiYEDhgwRJH4P6pxAKkKSbwP7UWdP9B7vlOAZJAWLjkWgsuw0Gn5uh2yoRudsNvgNj9sZ0cAkWX5vFt6XH01IVCwwNoriLakaVOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414616; c=relaxed/simple;
	bh=WQU0LqOIk8xwleFRyVkTAJjKysslqlYuFoJtdgIQ0p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvt6qo+1/rBhUrhpqvAej6Lzs19ItJZIN6pCrTtFMxdiKwrIxoSiM1HYXvO27Agk+pz93KzsbfR/DSwLz1NUV08YGZb4Ld6Fso+72GvI85rLXiJqVQxKYO/eDhjCqc/jQAm2vDtsfxPn8MDcdFvXLZpQlF+cU82jLoaStYosyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3kjKGgn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748414613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp5QmWbkmkpcqLHwlNESI2AZ36K1FEsPP4gXBzu/xG0=;
	b=T3kjKGgn91SrUKG1Hilul/mhZUKf9h0qwsIJ0JU6/GTgVSOVHMCLUmcQAE3txjB858r1ik
	++US4E+CyAEousPy+ZsjqbpyHVc2lM9/1jQDwd/xuo0IASBrz8CZvTJzI8MWExhZeDGHyw
	hJY9bILLsuUbOKIP8qjX0yEKt0Q4zdw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-dx1BPb3FNTGtvUIDUdEd4g-1; Wed,
 28 May 2025 02:43:32 -0400
X-MC-Unique: dx1BPb3FNTGtvUIDUdEd4g-1
X-Mimecast-MFC-AGG-ID: dx1BPb3FNTGtvUIDUdEd4g_1748414611
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 252C3195609F;
	Wed, 28 May 2025 06:43:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.248])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5F7D1956095;
	Wed, 28 May 2025 06:43:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
Date: Wed, 28 May 2025 14:42:27 +0800
Message-ID: <20250528064234.12228-13-jasowang@redhat.com>
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

Use u16 for last_used_idx in virtqueue_poll_split() to align with the
spec.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 03b17bc275dd..b14bbb4d6713 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -801,7 +801,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-				 unsigned int last_used_idx)
+				 u16 last_used_idx)
 {
 	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
-- 
2.31.1


