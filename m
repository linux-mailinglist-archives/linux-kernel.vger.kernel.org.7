Return-Path: <linux-kernel+bounces-858253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC612BE97D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8440E3AB936
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21CA32C930;
	Fri, 17 Oct 2025 15:00:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C532F12D7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713238; cv=none; b=n2IBVXtxqKvODC4UEjpgDKJqbQmIfndPPSkZvV10vlkwxLdbaXUufO6GMQP/XpURyj+8mauez9VGXuudiRmxeOCeOCwIm9BLWcREcYKtdBScUJECY4jWBlSx8vHk2bWww3sKCusRnsyCAQU5ITOzGLU+UXjgJPvKS5o05LJStx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713238; c=relaxed/simple;
	bh=xRvDLRixebYPSYwTuPzWzUvQiPgr3KsCHUzve9UgeMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9HEPBFr0wtGNM9fmSw2POoF1G3qLXOkpcaf+xqPTH0/qftAU+7PuYnWAsoV6usGUHT4/3RqGbj5F+OfNWWLTjIO5VD5JLc3ovC5q9WdZatP9pgSa5W5woG9NO7+v/qn02QStTKGSqJmOgusUFY4EO4R+WWemhP77JrbzPtoEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lwJ-00028D-Pd; Fri, 17 Oct 2025 17:00:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lwI-0044jX-3B;
	Fri, 17 Oct 2025 17:00:19 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A0CA4489289;
	Fri, 17 Oct 2025 15:00:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 17 Oct 2025 16:59:59 +0200
Subject: [PATCH can 1/3] can: bxcan: bxcan_start_xmit(): use
 can_dev_dropped_skb() instead of can_dropped_invalid_skb()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-fix-skb-drop-check-v1-1-556665793fa4@pengutronix.de>
References: <20251017-fix-skb-drop-check-v1-0-556665793fa4@pengutronix.de>
In-Reply-To: <20251017-fix-skb-drop-check-v1-0-556665793fa4@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 =?utf-8?q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>, socketcan@esd.eu, 
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-2196b
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xRvDLRixebYPSYwTuPzWzUvQiPgr3KsCHUzve9UgeMQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo8ln88IspOhek6G2ZvTtEwUJ3WTyKkZgEMRnh/
 Xvh67H1RCmJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaPJZ/AAKCRAMdGXf+ZCR
 nIuUB/9w+vSk2ohkks7AVj4R3v9dUk0UVMeZh6rLYXJttbgEDD5Iv1UYMk2x8GtaF+ZDd/GtVU5
 nUsNekRejup2UXxGHA5RcfV0NccrtMld77ji+CTAGLJC5W2pk5BX68ymXPgVUYnOgbz8rtxZEji
 7WlOq/5rId3SDasoTD65ab5l8QXfMos5rZyq0lubMlT87lZSCQ0h3a242+mEUqq0GyHjDq1FDC5
 7QMoYNtWIeB2CXW7IjEkaeVn6dwnmTSErotlhsWX8x5IMnvwteY4GAll2Sfnb5Q6tvqBaUa2Fmz
 oymQfHOG1wvdzJaSKWrlHeKgln1Ym4K1HBNTxk+0KTYHh/KN
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In addition to can_dropped_invalid_skb(), the helper function
can_dev_dropped_skb() checks whether the device is in listen-only mode and
discards the skb accordingly.

Replace can_dropped_invalid_skb() by can_dev_dropped_skb() to also drop
skbs in for listen-only mode.

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20251017-bizarre-enchanted-quokka-f3c704-mkl@pengutronix.de/
Fixes: f00647d8127b ("can: bxcan: add support for ST bxCAN controller")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/bxcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index bfc60eb33dc3..333ad42ea73b 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -842,7 +842,7 @@ static netdev_tx_t bxcan_start_xmit(struct sk_buff *skb,
 	u32 id;
 	int i, j;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (bxcan_tx_busy(priv))

-- 
2.51.0


