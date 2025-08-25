Return-Path: <linux-kernel+bounces-785287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F548B34893
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D5E1B21CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD9301033;
	Mon, 25 Aug 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M2Pk6Cr/"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C30301006
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142520; cv=none; b=sbchSKpCZkfBOh8jOZftUtRYLNY8+b0hqHIHX3xry2/XS13MH/sZEmC+/9NqlnApVovDzLgmZmw+jO5ZolkfFPg5ztD8OFmP1SeUyktaaOWO+X17yRzH/lmBcJ77NewGzlmpJAp60pc1FU18jGyuIXrc3HssyfGWct53BVZKNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142520; c=relaxed/simple;
	bh=jT/ylMlEQRDNlFQw3ZQpII4o4YK4hEQMjtkjgsk9Zc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6lsFz+eIf1pmMrCmtEKQ88S+HDU1uU7klHpv9hBES1bX1mXAJ1o2YAUpmnIAjJLfjKnW2cIDPO/NSkjLH6p7EYZsUDNxOHH1UGRo6HBz01WPpmDl1+HVctvE2kAWEr+r27oHb2DigJLEI9mEXZeis+0SfWYEjJnA62oRDMT7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M2Pk6Cr/; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756142514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vTIzMbFo+qzt9TXdUaDMScLRHehevEhpnDaT3qnZd+8=;
	b=M2Pk6Cr/NRoBM198R9TzybFkP0aG+rlM/lfiJS0dZPVd0h9B81MeZrarhd8s5viMlWK9FS
	mD8yHIq5H/YfenXORLuHdhfQQn9zt2/RxrDF7/muHI/LtukH7FUN8ppXd8L9AZgll+cD0K
	MbnXYlOQKFkKlLEVdozmXxwITQljMLE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: macb: Fix offset error in gem_update_stats
Date: Mon, 25 Aug 2025 13:21:34 -0400
Message-Id: <20250825172134.681861-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

hw_stats now has only one variable for tx_octets/rx_octets, so we should
only increment p once, not twice. This would cause the statistics to be
reported under the wrong categories in `ethtool -S --all-groups` (which
uses hw_stats) but not `ethtool -S` (which uses ethtool_stats).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Fixes: f6af690a295a ("net: cadence: macb: Report standard stats")
---

 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b29c3beae0b2..106885451147 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3090,7 +3090,7 @@ static void gem_update_stats(struct macb *bp)
 			/* Add GEM_OCTTXH, GEM_OCTRXH */
 			val = bp->macb_reg_readl(bp, offset + 4);
 			bp->ethtool_stats[i] += ((u64)val) << 32;
-			*(p++) += ((u64)val) << 32;
+			*p += ((u64)val) << 32;
 		}
 	}
 
-- 
2.35.1.1320.gc452695387.dirty


