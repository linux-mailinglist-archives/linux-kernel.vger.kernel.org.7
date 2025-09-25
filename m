Return-Path: <linux-kernel+bounces-832255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD58B9EC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DDC175421
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D0301701;
	Thu, 25 Sep 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhHvQzPC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1200302CB5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796694; cv=none; b=gVOoRmgcHX8Hhfb2/Bwl7phyUE5C0UpY/X2aRU0OGIH11ZqC1SjDdSYtuAfkW+fKk3vqrb2g9XTKwfyoXE2Dk3lmmR7UMg6dq6H/FTx3BJPMq7qT0UZM8ZtPP8rpWX4jLSc8v8k2wa4DM5MeyMHXQgxpKwvOuxFWirX7hCBA9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796694; c=relaxed/simple;
	bh=ctWAoF6NDQS22pawq36XHcMmNpCzPJfLCBBhqfhJrLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hv1LS+NRdFV1m4N1ZWALvpTL4DHlTi0K6jU0IshpVAcV/JniDy2t2A+EClWnSHIwfvqd9mI7FHgSdj9cBXYqe7JpQSmjySuxJx0Mnwood2uedNXI5JcQpqcY23MtaFoG5szQtO7i4ksbv/W1E0rxvOjhrtlYBB8ByEkcdY4vG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhHvQzPC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwedawIccVQ5ghzRAqTae/e3WUnoTDtuYj1zh6XY5ic=;
	b=ZhHvQzPCDXYxirrdKVyqytc1Yf2d+l5Q8Uc5LX05z5MaKjgIgLVEA68JtFrFIvJPzHGAgt
	d9e7y3qS+6jPCqTG4uIbEkLZu9TXd9PuDjNZwzkkvUyc6uiidPrmrmm/WHx0UHRGGXl+9D
	TB6K/k6pvczWJgZnYnpxja1LjJwtluM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-KldBHiCsPpiqbm3nZUplkQ-1; Thu,
 25 Sep 2025 06:38:10 -0400
X-MC-Unique: KldBHiCsPpiqbm3nZUplkQ-1
X-Mimecast-MFC-AGG-ID: KldBHiCsPpiqbm3nZUplkQ_1758796689
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 542C219774E6;
	Thu, 25 Sep 2025 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F84819560AB;
	Thu, 25 Sep 2025 10:38:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
Date: Thu, 25 Sep 2025 18:37:01 +0800
Message-ID: <20250925103708.44589-13-jasowang@redhat.com>
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

Use u16 for last_used_idx in virtqueue_poll_split() to align with the
spec.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58c03a8aab85..4679a027dc53 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-				 unsigned int last_used_idx)
+				 u16 last_used_idx)
 {
 	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
-- 
2.31.1


