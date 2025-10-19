Return-Path: <linux-kernel+bounces-859782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 023EDBEE8F1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A06554E1822
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F42E8882;
	Sun, 19 Oct 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="yupk4sHB"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB922B8B0
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889217; cv=none; b=sM/2goZfCO+RmU+4x63JEgJvvutitpxlclXrOcieMv0Olz805bjNqcrbNNYvCf+bHZ4M42gf22i/n1uCLNgTZc/Xv3JbgQ4YDhTWiwZkclLr2DBSxActFHodfuLOUk+yfxxtGMe6krgWsQppqetdziKWx+dcp/aP/Olu64bTOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889217; c=relaxed/simple;
	bh=7l7+12vQYvSeBq2K5mDS3VblcW6ZAMVLD6keL9mR3Rs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NCtst8rT65vZFOcnTHkO/hfWKMvvvjscW4fK6kLhLoGE6n6AZr9urfRDOVZ2rOr+jwKi3FHIIMFAIYdKt9j236MTlQQtrxM834Z0UOsC0GWktSQ5nDbg+NTKPngXhtnSLmkxvGajjIk+Z3SCjeFS7F9KElxW2A3p3cTItVLVXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=yupk4sHB; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 3996 invoked from network); 19 Oct 2025 17:53:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1760889200; bh=x6WS4gSSC3cojCRavBWi/OUmPz/su/Y/sBe19ZDjBWE=;
          h=From:To:Subject;
          b=yupk4sHBX13usKKR0MDf4qQStF4MPIXIO+VA7RorDCUj06lUA/TBVTYQJGIJZuuCo
           e0Vb1SYDh7LjFfbS+bndEFkJnY29BlqgkZB7IdEd81B4VGeuOrBq/yehGpmIETXAu5
           QQ+LKnfdgeG4SFZzS9oZH9qgrX3Deia3rbjOq3I9qXom4/yhNsCmfave45ojIJhZ3+
           gg9DonnA4F/7XBoYqKMuGP8hZ30NswO4LhZDSm5xeeZeD7xr8Qu4lAOxKh/R9iAJmd
           xl8vGZA6jui6tZQrf9pk0p0DXUkvjxB7QW4iyyZtjXDingwE11gM75dq+ntA+W63KN
           28h6eOIJGhzEg==
Received: from 83.24.149.147.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.24.149.147])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <nbd@nbd.name>; 19 Oct 2025 17:53:20 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	rosenp@gmail.com,
	luoxueqin@kylinos.cn,
	chad@monroe.io,
	olek2@wp.pl,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921, mt7981 and mt7986
Date: Sun, 19 Oct 2025 17:51:55 +0200
Message-ID: <20251019155316.3537185-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 20b9a344b7368db3f41473995158abfd
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UcNU]                               

Supports IPv4 and IPv6 TCP + UDP

In various tests between MT7986 and Intel BE200, I observed a performance
boost ranging from 2 to 12%, with an average of 5.5%.

I did the tests on the MT7915, MT7981, MT7986, and MT7921 variants. The
MT7922, MT7925, and MT799x are untouched for now and still have
checksumming disabled.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
[rebased and resolved conflicts]
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c     | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0db00efe88b0..e31b3e7e2038 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -372,6 +372,9 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
 		wmm = sta->wme;
 	}
 
+	val = FIELD_PREP(MT_TXD0_ETH_TYPE_OFFSET, 10);
+	txwi[0] |= cpu_to_le32(val);
+
 	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
 	      FIELD_PREP(MT_TXD1_TID, tid);
 
@@ -391,6 +394,8 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
 
 	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		val |= MT_TXD7_IP_SUM | MT_TXD7_UDP_TCP_SUM;
 
 	txwi[7] |= cpu_to_le32(val);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5ea8b46e092e..a3bab240afb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -359,7 +359,8 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
-	hw->netdev_features = NETIF_F_RXCSUM;
+	hw->netdev_features = NETIF_F_RXCSUM |
+			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 
 	if (mtk_wed_device_active(&mdev->mmio.wed))
 		hw->netdev_features |= NETIF_F_HW_TC;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index c0e56541a954..fe138d2e8e62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -632,6 +632,9 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	}
 	hw->netdev_features = NETIF_F_RXCSUM;
 
+	if (is_mt7921(&dev->mt76))
+		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
 
-- 
2.47.3


