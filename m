Return-Path: <linux-kernel+bounces-878463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563FC20B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9716189F5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8FD27B342;
	Thu, 30 Oct 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf7svA81"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DD2741AC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835492; cv=none; b=fDpC8jEwSb3amNLVqCSsPwIkcEBBjoAEeFMya6Qxa6lUb7bOWt/Oy11wiz53Ufn0QJy8aWIrsn9mKxYDHLznXcmFp18fopsQOGDOk4Nfmzerua6RxHhjc4thgVbvtst8nngox2P5XqxjswhMXzBx+SQIz9Y++2cBpxFB8F3WeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835492; c=relaxed/simple;
	bh=gG6Rxpv+5xwuYbGpv4ZcUhGKoTxFro2YHfn3sG0/O64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWMVAkqjVcZDkBxloppgen8GCuxsh1hw7hV4qlhetc83iWlELpua6iH2YlERwfRl80YtorcaO6VrMVF1DUC2l92oG4TngKRlOfBPG2lWa75pBKKaJWh/xPMK22jiYrmjaddOoSuyj/+9QDzE6IjuA9BbbiKjjwDX1Rwa8S4kv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf7svA81; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294fd2ca6acso6405775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761835489; x=1762440289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8i0KSYhBekRhZe3f+zVYiMKfUdeY1w53Ec33PFErQRM=;
        b=Qf7svA81zLPS7Jgqp38A8OMu2G0BSDFtQzbsnBoOeD2ObEGs1xD7+KI15v2TA/8cCm
         LXH5UurH5x0l44hLTK972xKIVAiWoFyBo5JMAl3xCESXpcezRSvbHgHR3iFJHxJmLzEy
         6XMgzqU3JDOWJiAVyr+DNvUvfpdCpRwvUx+gWhGaG1EqAVgR0jglWx4qJnUQ5P4nctRO
         D1/Mwc84QjL+psDRRLKQThFp8UqQ5n/f+zR4op5Jl/nW00eeTw4zNwXnWx0Q+TuwXv8a
         tKVnK1yLWOeU3K72tFwzqWHkdmyrrwYMs9oREKsZWtpy/xQzBdK/9aUnfLdlOnMdyyV3
         E5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761835489; x=1762440289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i0KSYhBekRhZe3f+zVYiMKfUdeY1w53Ec33PFErQRM=;
        b=iWPq5ijX1hKRfCqWv7wYQGJxoYxNLmvSVzu5iUt6eVVflSh8/H1LzzW0Vpbiw7rc/I
         T1ib59ghYmsvoBOhlcwAaRTu+dLe5CMgbIxsMmCcMsS+yB9k8cEuwP4txGh0CfycL5xE
         Ti+PODRykvBKqesICaFGv+A4s8vVO4d9aft6kzeMZ1vaMvRdH8kjWKHhXhu+9kH5E6TX
         w6eCyyTLDe+b7+Jb+xvq8SFgE8JqlHDW1q8p0K6+LDH7C9Dx+NDXGl0YisdXgtt/260k
         V6cbly2Ne/WO/gZNQhIwVj6xXV14jJ9sOjmwaq7MQ8KXkk8nNQgEppcJS/bduZIMjhlD
         59mA==
X-Forwarded-Encrypted: i=1; AJvYcCUwJ6RDM6SBZ3mq/FqYlM1YipIfpsetWkuXx5mn8j1bK62FElbMCJclG8ed1nlJoDMuzXw6tpXW/iMMfiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHWXTNTdvidUE7K+ddt5KwrXImYMxWAkbbm8WQni5OVoIJUj1z
	oDt2W84SA1DcAAcsF0A4ARmBZbWn9SCtv4CSI+4q9o8BTW+spt06hZxy
X-Gm-Gg: ASbGncuAm+ryYye5zrVJp7ZbOrqq/MmnoVz6LOCCL6PKzdjW0/BrH6dXUICALR8A2ap
	HQQzM5/xMJz87gLsbFefdzQxBKI4x8nm7jXbe6s9WKvvYOk5njnWRKDJeDaF4/o+tWwkhiuOaT5
	MqkJfV/THx8qAnH30ErCbHNc1ssPe/B4J6s3rJW+pvXHOBRO0JXUufEauIi0Nz5R2m3+aINL4M5
	yQ7Mf7lbeh4svEDBuENboLWybvaRYkSjsztpaQCKR+ldxzJj0Prb/4KwmfhLPMnoV4EFBQOEcfC
	xsbEKjim9agX1I8xk+7umujkkHWyNeb0yDjkeQ0+CvVEwBO8IJBEaXs/1fFKKI1Dv++tNPcmrM+
	4FBYDzrmwUkbZGOb/eCuIvfDhsZZvZD+HgyKtMYWLoljDRM0YsiA0OqqFETcKbfsbEBGTnbPDGo
	DjJVLFs6ATkjvp5A==
X-Google-Smtp-Source: AGHT+IFKdzh5PqIDW+UtJroUaPTVHXn8ZahZ8UZQ7XX0MsdR/YUksfFQ5V7KobNywlg1F1FyaLwELg==
X-Received: by 2002:a17:903:247:b0:266:57f7:25f5 with SMTP id d9443c01a7336-294ed098015mr40411365ad.7.1761835488722;
        Thu, 30 Oct 2025 07:44:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:f227:4662:b8d4:840c])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e41159sm188520295ad.91.2025.10.30.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:44:48 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v7] virtio-net: fix received length check in big packets
Date: Thu, 30 Oct 2025 21:44:38 +0700
Message-ID: <20251030144438.7582-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), when guest gso is off, the allocated size for big
packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
negotiated MTU. The number of allocated frags for big packets is stored
in vi->big_packets_num_skbfrags.

Because the host announced buffer length can be malicious (e.g. the host
vhost_net driver's get_rx_bufs is modified to announce incorrect
length), we need a check in virtio_net receive path. Currently, the
check is not adapted to the new change which can lead to NULL page
pointer dereference in the below while loop when receiving length that
is larger than the allocated one.

This commit fixes the received length check corresponding to the new
change.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v7:
- Fix typos
- Link to v6: https://lore.kernel.org/netdev/20251028143116.4532-1-minhquangbui99@gmail.com/
Changes in v6:
- Fix the length check
- Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
Changes in v5:
- Move the length check to receive_big
- Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
Changes in v4:
- Remove unrelated changes, add more comments
- Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
- Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
Changes in v2:
- Remove incorrect give_pages call
- Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..421b9aa190a0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		goto ok;
 	}
 
-	/*
-	 * Verify that we can indeed put this data into a skb.
-	 * This is here to handle cases when the device erroneously
-	 * tries to receive more than is possible. This is usually
-	 * the case of a broken device.
-	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
-		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
-	}
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
@@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
+	struct sk_buff *skb;
+
+	/* Make sure that len does not exceed the size allocated in
+	 * add_recvbuf_big.
+	 */
+	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
+			 dev->name, len,
+			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+		goto err;
+	}
 
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
 		goto err;
-- 
2.43.0


