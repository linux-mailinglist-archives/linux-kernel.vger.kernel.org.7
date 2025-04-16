Return-Path: <linux-kernel+bounces-607610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A383A90875
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08381886D66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E273211A2A;
	Wed, 16 Apr 2025 16:14:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45FF209F53
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820090; cv=none; b=DTdJ23Uwvfoe64dqO1lrZ3n3or4zsUZWuw8rtYACiqyC0beMI1bVggfe/AHJb/EvLvvi3+jOJCXWWmqliggVDfZaQx7ISBqGd9lIzDi+h8ffBnXrh/AGmp3tl+gq3IT/ru4kdAXlCXporPtylRvmUkSt3pArZmIL61f+vsqa7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820090; c=relaxed/simple;
	bh=5/b0fdmjcYFYBChxB9yhX8Hr5ATMJeAQw5pX8rQ4bXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u2qZWGcRxuYUGYy4RSSPKLn78Zm9mBqMLzjKMWJ1qfCTNUyliDjbabP+9bMRKgzhhb1YHuzl7KwG6CV4x9txF9jYMG0hrav4EbAKtREsTj769BzCXcOlU7iZfP27YQoUadFD1JXqmzxfZDnCdfevbXAvu4NJtUlylEOAazsQm28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-0002G0-D7; Wed, 16 Apr 2025 18:14:41 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-000c9F-0L;
	Wed, 16 Apr 2025 18:14:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-00CGQI-06;
	Wed, 16 Apr 2025 18:14:41 +0200
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
Subject: [PATCH net-next v1 1/4] net: selftests: drop test index from net_selftest_get_strings()
Date: Wed, 16 Apr 2025 18:14:36 +0200
Message-Id: <20250416161439.2922994-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416161439.2922994-1-o.rempel@pengutronix.de>
References: <20250416161439.2922994-1-o.rempel@pengutronix.de>
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
---
 net/core/selftests.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 35f807ea9952..3c3e2b2a22c9 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -408,8 +408,7 @@ void net_selftest_get_strings(u8 *data)
 	int i;
 
 	for (i = 0; i < net_selftest_get_count(); i++)
-		ethtool_sprintf(&data, "%2d. %s", i + 1,
-				net_selftests[i].name);
+		ethtool_sprintf(&data, "%s", net_selftests[i].name);
 }
 EXPORT_SYMBOL_GPL(net_selftest_get_strings);
 
-- 
2.39.5


