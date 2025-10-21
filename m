Return-Path: <linux-kernel+bounces-863281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08014BF777A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3453E3BB7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019EC3446DB;
	Tue, 21 Oct 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SULnu3vE"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF13446A7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061547; cv=none; b=inqSnP1D4yhUITZNM8Wt3JRV1SgRTvATZ14KH5xD/m8YpV6kexZLr9OPHPqEdYcE7bDrkvwS584jsaz8pHVpwF9u3oERJE3UeZI0lug5ew+716Zc79dCMZHmvAVOGmP7GGSeK4y+LCARojq1efaaxoH77bdDXFJlyZURZ4gvmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061547; c=relaxed/simple;
	bh=NFWo4ioEJIhQFUj4F2K8PNPc2iMgiaom38xGap6Tnro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YePk8Lnhe0q55yFtUy2tvyL1SQB0+6bssdPeuDHApJ3OU/hiF/sjIy0+2sSYbStWeRxJjxBs5ZvElTo2AujZkS/ZGYRact7Us+wE9mgQRNz/oQOm33vEOCYJ0JfRll2OMAA4+UGNZMqC1zQGb62m00aMA7fsLhaLnAM5OhmY2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SULnu3vE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2909448641eso88185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761061545; x=1761666345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbUGtNpnVaPGTyOD2V45HVuJEH267XSQtThwcECfQ7k=;
        b=SULnu3vEvW0heJ1ymE+FNa7iT4dc1rylBTsKPPAwDZk9RXwULRBEi5AMGl5/jkUMcJ
         zKJOJxB7b0DfVWTPIsTA3Ui0M8HuBpZKXbABDImJpOq2saZwVLELUFKGNbn0cpKlvcCn
         qJkh/IArLUsvUGmhnUflTkYeMAVRxcg6iDIR7jRIxTWPAJJ8Ih+2GlrxCX3tyIytzkbF
         BGjKVro09lDX3c3/0pryW+5IuBHZ1e1J3GazwCNnM3cmEdlFlMUBOohoHHK7xkTBlKTh
         luWEqbJwifRm9d8ENA6/JViOfFwP+bh258PhJKeLxZhdamQsTEmqoBpi+wUJyIBtUoGZ
         N3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061545; x=1761666345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbUGtNpnVaPGTyOD2V45HVuJEH267XSQtThwcECfQ7k=;
        b=NjDzTn7KoV8EzF/hABR6digs//x5aVYS8NKPCpgjam1/jPmeyRy9QABPCH5a2pVepL
         bmS40e/GyNGWNRDgCW31TYlCvQBElzunhG41zw6CxZW4NiE66skmw6APuB8HusymAlQb
         lRkh2+KaKS2em7dqD9M6UiHSV+g6OlCcahXNTM2KUVElDnYIGBP+L+CF8Le3s7UQ8irS
         MvU/dnEEP+Fn5suB0Y9wdXR9kAJbEk/p3MBdNpJTP644yLspk1aMkM3Qxd7t2W2Goh0b
         6pvGaSnC770/aoN2MLPOImM9gp8BErjs2G3a22J01tKJpjxuaIhcaNkIOIHfOxEkRxOI
         lR+A==
X-Forwarded-Encrypted: i=1; AJvYcCVWFIUc7k1ENMm1p2oYk5IvJLfYba0zDdEJ5fGDi9XmX3e1MUENIcabNVCoF1CG+iabOUtO6Lv381r6500=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73FBka8hz57N6ukU3lqfffy5/pmLeljErb3ihXllvV6pqoj7C
	Hwh/+2w3sx0EA1Hsifc6BZIXr3/vdFjajRIoZs26J9kRuOn3+rYwxQn5
X-Gm-Gg: ASbGncuXb6niaAfWQGtfPJbj/Gy4DqTZ5ZFVS3APr5FYsMO/q94oKikLAwpRIw5WAE0
	+fe2wlECxBlFI69LoYiGZQuuOr8KRG+TlzVGclvIV/ntXuLrPCrKvKbFWW2yzYk73CyUZ85VqUz
	ROFBeeVKdaqCZKzR+wf7hAY9D4JvyP8R1/B0ecRxcE+Equr1r/I6Cd0nnQWPHpPPcM2aRaNM+kS
	QqZeocH6OWBDHvCZG5IN0bFOG2UvEroH5ADrTuyV3Q49f0Ee1k8r54YIonCKYcnKmG0bi2okhsw
	B6H7OxPLtrUZVDqcME3uOh6np0c/DC3Sj7Fo0hGtCF2CDtHnGzbP7AXLkcPOQH285QgIgThy8DO
	QTYAAkeX+Em5weGYdhqDBeciQDna9yIdIfBFMwjyQlbloCQzxFQox26RC9jUR4dGcV5/hk9fTPZ
	QhvhtsR0psdM0H/WH1kW+dTi+b
X-Google-Smtp-Source: AGHT+IF3AjXGyHtxPeuaeB1B33R8h4DcIFMmv/CIu77BJd2s9WOMRipvHjQ1kYHQ7V9Zi5jD2ZfB7w==
X-Received: by 2002:a17:902:fc4b:b0:269:7840:de24 with SMTP id d9443c01a7336-292ff8e10damr1991205ad.21.1761061544808;
        Tue, 21 Oct 2025 08:45:44 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:87f4:6771:a0ef:9e8e])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471d5938sm112628365ad.58.2025.10.21.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:45:44 -0700 (PDT)
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
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v3] virtio-net: fix received length check in big packets
Date: Tue, 21 Oct 2025 22:45:34 +0700
Message-ID: <20251021154534.53045-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), the allocated size for big packets is not
MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
number of allocated frags for big packets is stored in
vi->big_packets_num_skbfrags. This commit fixes the received length
check corresponding to that change. The current incorrect check can lead
to NULL page pointer dereference in the below while loop when erroneous
length is received.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
Changes in v2:
- Remove incorrect give_pages call
---
 drivers/net/virtio_net.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..e7b33e40ea99 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 {
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-	unsigned int copy, hdr_len, hdr_padded_len;
+	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p, *buf;
@@ -916,12 +916,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	 * tries to receive more than is possible. This is usually
 	 * the case of a broken device.
 	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
+	if (WARN_ON_ONCE(offset >= PAGE_SIZE))
+		goto err;
+
+	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
+	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_remaining_len)) {
 		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
+		goto err;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
@@ -941,6 +945,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		put_page(page_to_free);
 
 	return skb;
+
+err:
+	dev_kfree_skb(skb);
+	return NULL;
 }
 
 static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
-- 
2.43.0


