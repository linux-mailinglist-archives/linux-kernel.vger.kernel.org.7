Return-Path: <linux-kernel+bounces-649150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB76AB80D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 10:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21BD188DE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA528AAE8;
	Thu, 15 May 2025 08:31:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A458190685
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297869; cv=none; b=ePvg50iqe3OnMTidsYLgRrnTlHNyzg+hHUnQvWwO8jjP1YO0ddFkD1XFiEC47xQjBX+rXS7GIkjMe9rlmNVW+tySUYRm4POUSUjXDvL52m5Lal77mSKcvBVC3q+SqAxJ/LN6dVQqfEgLgGGCt1mPt3Xime4VoZJra5JKmdro/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297869; c=relaxed/simple;
	bh=0Pe2j0oXCZbo69Dqx7B15NyJMv5NjWuFBulofgo6Jhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/tOuVknCqfgO83kNFHDVChSrKQlA0XLIHP+WpjkcxgGI0TqaS5J0du1CIzQgiXq+vVFMEM2vr4op0TW7R6cJ5sXJdYETfvp53349VzrN/4VQsCqiBP9V20ePx411NDzpEQmQi4gAqP8pnDbHCH9yFnxhor/RXCtASb0Wv6H2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTzZ-0002Xx-Sm; Thu, 15 May 2025 10:31:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTzY-002qOd-2j;
	Thu, 15 May 2025 10:31:01 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTzZ-00B8CY-0c;
	Thu, 15 May 2025 10:31:01 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v4 1/4] net: selftests: drop test index from net_selftest_get_strings()
Date: Thu, 15 May 2025 10:30:57 +0200
Message-Id: <20250515083100.2653102-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250515083100.2653102-1-o.rempel@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The test index is redundant and reduces available space for test names,
which are already limited to ETH_GSTRING_LEN (32 bytes). Removing the
index improves readability in tools like `ethtool -t`, especially when
longer test names are used.

Before this change:
  3. PHY internal loopback, enab
  7. PHY internal loopback, disa

After this change:
  PHY internal loopback, enable
  PHY internal loopback, disable

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
---
changes v2:
- use ethtool_puts instead of ethtool_sprintf
---
 net/core/selftests.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 35f807ea9952..9146e33db25a 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -408,8 +408,7 @@ void net_selftest_get_strings(u8 *data)
 	int i;
 
 	for (i = 0; i < net_selftest_get_count(); i++)
-		ethtool_sprintf(&data, "%2d. %s", i + 1,
-				net_selftests[i].name);
+		ethtool_puts(&data, net_selftests[i].name);
 }
 EXPORT_SYMBOL_GPL(net_selftest_get_strings);
 
-- 
2.39.5


