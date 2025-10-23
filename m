Return-Path: <linux-kernel+bounces-866427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B1BFFBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F5D84E6B35
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57D2E1C55;
	Thu, 23 Oct 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S4AzB1Rl"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293F2DECB0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206138; cv=none; b=Nk+69F2Y9cdUpl822b7EEMSSic/hvdasfCVkXb0acRveJdgAO+7N4yEpnXeqRZ9HtVqwdogywb7F8yNwLLiitbCUNrr2i/cseH1A2zuhKnT2zH1GO5zYGsJRls3volv4ZA7IV3hhyMMuOFjjgDuK1Cv5hBIf2TUg5cjTNtsb11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206138; c=relaxed/simple;
	bh=HBplzcD/v8P4LQ88hDGXXAsi8Ll/uXDSLS44ZAi0J4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTbWP+CApFzQJsgOeKY8j1VWmA8spyTchrC+YasqMyCmOwQS7X2y9x1QmLi1AQza5ccotsKVK/rTGnw4pRe7QQeU3s6XBBOgBUKP8FaNLS3lde5vpaoAQrzVHlqB5w/wUVaFyuLNkjMF5sqR/tw4exbtP5tOw2uPMotiBHnjoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S4AzB1Rl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59N7tUUe92131929, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761206130; bh=ldWH0RBZ8yqiEFEydFGnqBjU5Jw38WE5t1Ka8L/8fhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=S4AzB1RlJNAeDDp8EeV8iUhAkRUx93QQo2s/irJYxeWQPZb87MAOmWPtcDQQUvQnq
	 7cCCZLNbCeDBn1ZFUpD5VqEQzrGiSylIb1MnFPbDaocJ4Q+RzPp+vU00P+qULrKyaz
	 47tSUYjoBwX5RtOWIVRqnsjwP8ZbUpf9GvHMII+qjNodXjwEWCaSdV52CDg50b0x/u
	 KVPArhwUbccGW4Hhr4KJXyiKadDMms3ZogUU1ee5h2LcVo47RwFMsVvXMejqXVrV49
	 N58HzcQHc+Um75wctU3uE00YvqdLUGZbqIa3iR5oEnanOHiwBrYd393HxQVeahgA76
	 l60aLu+U2Vw9g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59N7tUUe92131929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:55:30 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 23 Oct 2025 15:55:31 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 23 Oct 2025 15:55:30 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Thu, 23 Oct 2025 15:55:30 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linus.walleij@linaro.org>, <tychang@realtek.com>
CC: <linux-gpio@vger.kernel.org.org>, <linux-kernel@vger.kernel.org>,
        <cy.huang@realtek.com>, <stanley_chang@realtek.com>,
        <eleanor.lin@realtek.com>, <james.tai@realtek.com>
Subject: [PATCH] pinctrl: realtek: Select REGMAP_MMIO for RTD driver
Date: Thu, 23 Oct 2025 15:55:29 +0800
Message-ID: <20251023075530.14739-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The pinctrl-rtd driver uses 'devm_regmap_init_mmio', which requires
'REGMAP_MMIO' to be enabled.

Without this selection, the build fails with an undefined reference:
aarch64-none-linux-gnu-ld: drivers/pinctrl/realtek/pinctrl-rtd.o: in
function rtd_pinctrl_probe': pinctrl-rtd.c:(.text+0x5a0): undefined
reference to __devm_regmap_init_mmio_clk'

Fix this by selecting 'REGMAP_MMIO' in the Kconfig.

Fixes: e99ce78030db ("pinctrl: realtek: Add common pinctrl driver for Realtek DHC RTD SoCs")
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 drivers/pinctrl/realtek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/realtek/Kconfig b/drivers/pinctrl/realtek/Kconfig
index 0fc6bd4fcb7e..400c9e5b16ad 100644
--- a/drivers/pinctrl/realtek/Kconfig
+++ b/drivers/pinctrl/realtek/Kconfig
@@ -6,6 +6,7 @@ config PINCTRL_RTD
 	default y
 	select PINMUX
 	select GENERIC_PINCONF
+	select REGMAP_MMIO
 
 config PINCTRL_RTD1619B
 	tristate "Realtek DHC 1619B pin controller driver"
-- 
2.34.1



