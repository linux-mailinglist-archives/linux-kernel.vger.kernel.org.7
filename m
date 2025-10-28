Return-Path: <linux-kernel+bounces-873963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD0C152E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB84E06E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C132D450;
	Tue, 28 Oct 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT4z4Xby"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DF24676A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661991; cv=none; b=aEvOHixiHqSPUIG2SqHEg32OpXu4rGEX5NXbla1ZAoiFw/qw15XqcoCkVdtg1OvIDBcAW6JSt2h5IsqCSfMlWU6Dxp2DvdFdCdOeuhSfcj2SPeNwhnd7tuQDey16UYvamG6VTYdA8UWa4h/QLqLqoJNAJ8m/rJXSgfrnv822em8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661991; c=relaxed/simple;
	bh=NEMq1QwVWGTO1PLTTQMmdZ3LbdDaen7sDe5zlw5wwnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRmk9uV2RVWMeeo4Ue4YsL8ZfOhSSUYZoGdZhJ2PAuvcU4B51T7as98IOyOas+WBn1AVz7Ef/zdmVMgg0zeexCbZZHS8AC2Ueejn65q8NG7kZIMQJUG8zlFo4wvk1lNQ2hu6N+zcTQ5ykAYJ7ghwqSBI6gMsNx/xAwRRuHH8MDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT4z4Xby; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so8331556a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761661989; x=1762266789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D93iiJ3dCsDGMRKsIegYWo/bl71Ckop0JjDdJuUp4+A=;
        b=ZT4z4Xby5ruNyGbxO9WS/4pyn+EkcmsCU7RxPCU0ZAosfmpRJJaudgo0Jf62zgKJlH
         /qKTfQ3CoD2dUd8mUZUY+DQVERgxgfW3UWDf47RyoEJITskwdFyCl0RpPRCICUmh+v92
         RJs1ErW0ebP2GQvEu0ZBn40AdrWWWq8l/vH8q4GRWe8voOiL/y7frnMF2rfewLRagfUC
         Vawu/sjnytgrn9Ki7Xb6tTdyTDMvhI3Kcr5x/LjcyQdsfyxnWQS8rgCtSlef90ye2eUI
         eCMGhXSLqh+Rcg+R5c+8mji3KDAqrjtX9vZvo4NNrqvStUtNhsIR7RXlnShw5+q5DmhB
         D9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661989; x=1762266789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D93iiJ3dCsDGMRKsIegYWo/bl71Ckop0JjDdJuUp4+A=;
        b=jd+a08q6GMIdtBXjUvymOkfz9Ok8y70jvvRdBg6HR46egh1w8gybOONubsEaUFXzN5
         +BvevYFojLKhE65SfCiKekMXYIcYRS1jNi7S/P3DOsMJztpl++faAtzWUWd6/jJuBKuT
         To3+H5rYVLVLSQ1DVgj8ixH7S6s/X2bhWN3pYbUamsliMBkqcSC6ocEEhLUNM+EbvC6z
         ms3qTBITz+ICnlhuPhyZiU6cKH7WGgfxFqT45jQrhi+18cm2GYNYjdcuzbJ4fGKbyyjy
         Cmg2+8rKLRl+HN8y+9eHudQJ12fXaxBKhiR+rkCYT/yl+N33Xt68/aRONKdCXOG2I3H4
         kCKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuV2brkyrEFKgVJkiJuhArXNw/bWiw5wb0I7WhiDVINC26nOx7VlPj8WhtXE3E2+Y0YUiX5nIsSi3eLe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5c+oeBXc6AztFGjTfh5smssOQLFGMuWHpVhtK/AUtv4jACisL
	uZ6Ov944tacajE45PEah5uIo0qkqII1XC+pxwthoRxCq+QGLe6rUKPjS
X-Gm-Gg: ASbGnctahQCCuESJzAOgmN35h0aPDx2VUZFsTgoMN9qqXjfffd+cV3/l+v5idCEmttk
	r/mD4dOZhR7P+fVQidPEFj8dLsBYbXTCY+9TMNaoqpZn7QYGlS0TB2hDp8soHNjYg7t4MuoVvfL
	npgQevs+w2UNBByh/UT4Rc2JDCY5zMRBl9ceDl4Vua3jW82xYK/5qbKt8vHEOcoWq8f5WfAZS9E
	cD4Pp8ZSRcA2roLe9YM61NIKCPbzRFMlxRDdoBF/H6Pex+7lmhl1InjuJqnh5BSPB9JHsjTY4/+
	NrQ2/BEgdPR+4zFRLTC29CmP1mqelnrruP/3QumlmxQxMGc+MwDLYVKlRMo6gSDmX13Aoe+8pp5
	MUKO7xC9UQLiww3FxBby/GmrGJMDHgYg0Ahv5oBeFubiRSAA/4t4ZdA1p+kR+wy3XvUUxbZMCSK
	gTJBRzFLqmlIVh4w==
X-Google-Smtp-Source: AGHT+IFxazy1uo7lguaYfMUdntQxPnZeb5i61czGYGQ3K0U8mqn48jz+w9wNFW2dtNumYz8Q2nBdZA==
X-Received: by 2002:a17:90b:3905:b0:338:3221:9dc0 with SMTP id 98e67ed59e1d1-34027c0782dmr4653120a91.37.1761661988872;
        Tue, 28 Oct 2025 07:33:08 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:c0a1:2245:cbbf:7e28])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm12397037a91.5.2025.10.28.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:33:07 -0700 (PDT)
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
Subject: [PATCH net v6] virtio-net: fix received length check in big packets
Date: Tue, 28 Oct 2025 21:31:16 +0700
Message-ID: <20251028143116.4532-1-minhquangbui99@gmail.com>
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
index a757cbcab87f..461ad1019c37 100644
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
+	/* Make sure that len does not exceed the allocated size in
+	 * add_recvbuf_big.
+	 */
+	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
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


