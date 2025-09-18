Return-Path: <linux-kernel+bounces-755304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6890AB1A45B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2447B18A2296
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878C271A94;
	Mon,  4 Aug 2025 14:17:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3645271460
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317037; cv=none; b=qiYiKtTxFzKuxtHAaOF8RqtKa86sE28pxf/Upaj6aNCBhFyGsa8MW4xetDtP2Ir3VGjep5RjOYfMXUvqflFxeIWaF373tpMnFYdsqjQDQQ9ciP6x6qp1t/BQpK3UYDEtp0MGlypkS7OLVIEDfuryYxviSmK+gRn4X/8VpMYy/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317037; c=relaxed/simple;
	bh=u4q8HPwsuSE8tz9eydzR0P+TNkXExevUoYIkX+4TgoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r4TZ4qIklm6qHUjh5OnKAgGFl3K+g6SNISyaO6GZ9GOwSVfKgcj6im2wXvL7VhGMOMDsVw5MogdV6hpbnDd9CYJL4wGrG8DHIJhwfniJQ/94k0YMHUDP2829sftz4/HbgqcpiZSWqgzWzf7XhkhDude1LuTPVH1fqGmaJcXCs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uivzz-00071D-Ux; Mon, 04 Aug 2025 16:17:11 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uivzy-00Bt6V-1z;
	Mon, 04 Aug 2025 16:17:10 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uivzy-009N7b-1l;
	Mon, 04 Aug 2025 16:17:10 +0200
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Date: Mon, 04 Aug 2025 16:16:59 +0200
Subject: [PATCH] wifi: mwifiex: send world regulatory domain to driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fix-mwifiex-regulatory-domain-v1-1-e4715c770c4d@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANrAkGgC/x3MTQqDMBBA4avIrB1IxJ/oVaSLYCY6oIlMtLWId
 2/o8lu8d0MiYUowFDcIvTlxDBm6LGBabJgJ2WVDpapGGVWj5wu3D3umC4Xmc7VHlC+6uFkO2Ot
 Wd87U3pge8mMXysH/P76e5wdvfb60bwAAAA==
X-Change-ID: 20250804-fix-mwifiex-regulatory-domain-91617d84f889
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Bing Zhao <bzhao@marvell.com>, 
 "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, s.hauer@pengutronix.de, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The world regulatory domain is a restrictive subset of channel
configurations which allows legal operation of the adapter all over the
world. Changing to this domain should not be prevented.

Fixes: dd4a9ac05c8e1 ("mwifiex: send regulatory domain info to firmware only if alpha2 changed") changed
Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 3498743d5ec05719bbfa3982d646d8eb9802a06e..2090c99d9e9e025625154b23af46a275c398d20e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -686,10 +686,9 @@ static void mwifiex_reg_notifier(struct wiphy *wiphy,
 		return;
 	}
 
-	/* Don't send world or same regdom info to firmware */
-	if (strncmp(request->alpha2, "00", 2) &&
-	    strncmp(request->alpha2, adapter->country_code,
-		    sizeof(request->alpha2))) {
+	/* Don't send same regdom info to firmware */
+	if (strncmp(request->alpha2, adapter->country_code,
+		    sizeof(request->alpha2)) != 0) {
 		memcpy(adapter->country_code, request->alpha2,
 		       sizeof(request->alpha2));
 		mwifiex_send_domain_info_cmd_fw(wiphy);

---
base-commit: d2eedaa3909be9102d648a4a0a50ccf64f96c54f
change-id: 20250804-fix-mwifiex-regulatory-domain-91617d84f889

Best regards,
-- 
Stefan Kerkmann <s.kerkmann@pengutronix.de>


