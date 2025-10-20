Return-Path: <linux-kernel+bounces-860221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B7BEF9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72B1A34978D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A02E5B2E;
	Mon, 20 Oct 2025 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNlR1uNW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08C2E5400
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944263; cv=none; b=En9RX/JsOzdhp76iSDurAj/YvLGZMDNh2B24RmgEpAlnMVYbn+4bS30vlwYqvDH/qA9no2TU2I51rUTTcT/jBg+/W/S68GqWARvSwnrhAwmPnCeYq7JPeYUarnVrSf9bVwgNF0TCQ5vERPJ00ixQOrbmLMfjWYhTmJ7ksvJoyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944263; c=relaxed/simple;
	bh=6fux0mFBeJyCMolbqj8dnkmRAAZQiLMWN8ZAIi12dRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaWUMLcpQ8QERLZxA9Ib1MPtJYTW+MFEHkKiSvpAWs1L+KODvuXy8mMQA5H8p5Epz+h7QPRh/n+AgKEyqAVbhnDJZ7/NJc7+aTgj5jYgmIYjGt1my9YFHuEl5FtisYpeTHwCqIGpNUViK0J4PAduA2bDsghrxf19RGZqiYD8Mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNlR1uNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+U3weGKyjXNfQsssiioiLWp1O/UIc0AXkQ+N/oPFdY=;
	b=gNlR1uNWs2YmsTNXCBSRrPyT6Y0aiAvODTrVUS5ERgdKWZy5QsBOa8iVxLw823Xy9tiErC
	lpEDqx7V8L2CcF03E87gYdiqf+rJG6ufSC1rdv+ukMADeqkvxI9+Pd7y/2PDbT5ASskpBA
	+FMMWPBusddHEHCnb//42l4H/YwFW3I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-364wItU9Ow-HGoZBJGK1oQ-1; Mon,
 20 Oct 2025 03:10:59 -0400
X-MC-Unique: 364wItU9Ow-HGoZBJGK1oQ-1
X-Mimecast-MFC-AGG-ID: 364wItU9Ow-HGoZBJGK1oQ_1760944258
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 135F418001C6;
	Mon, 20 Oct 2025 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 174F8300019F;
	Mon, 20 Oct 2025 07:10:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 12/19] virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
Date: Mon, 20 Oct 2025 15:09:56 +0800
Message-ID: <20251020071003.28834-13-jasowang@redhat.com>
In-Reply-To: <20251020071003.28834-1-jasowang@redhat.com>
References: <20251020071003.28834-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Switch to use unsigned int for virtqueue_poll_packed() to match
virtqueue_poll() and virtqueue_poll_split() and ease the abstraction
the virtqueue ops.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58c03a8aab85..73dcc6984e33 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1699,7 +1699,8 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
+static bool virtqueue_poll_packed(const struct vring_virtqueue *vq,
+				  unsigned int off_wrap)
 {
 	bool wrap_counter;
 	u16 used_idx;
-- 
2.31.1


