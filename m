Return-Path: <linux-kernel+bounces-720912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C7AAFC205
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8B74A551E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A75219E93;
	Tue,  8 Jul 2025 05:29:28 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F080215F42;
	Tue,  8 Jul 2025 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751952568; cv=none; b=j8qKVkNQuaiiafYAVuAsVLFxGxFUGtW+6Q42Z/mXnzi3fHyb2NZ9M6tOyILso7BLJ+kqh8eXr3V/2YesZv7i2rcbwGVuW+qbIyHj9adQZOIhbUZ3IfAnBIw0MkOzlBUaM/lgM5n9yhhju3uAe6PEV2ABKqqFlNUdX8LwHooU3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751952568; c=relaxed/simple;
	bh=ZfNIW+dEU9A4qiFfoTh0tuGvFleoESVgwS/t3H0ZnaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFQVFbEWQ0GxZGwT+PphBHLU4GGzOuDxmNtky/Khsqa80XnNRxXw+wrPY09fsujXz+NgQKozqYckXfvdHxaj3yH43YjF5tlmRVPu1bc4bviOqmAuxtZUEL/8hkX/gdsZ02g4qPAnxUlZ20IhiACkqMPnnIj25/a4jIUJraFq2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 13:29:09 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 8 Jul 2025 13:29:09 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, "Rom
 Lemarchand" <romlem@google.com>, William Kennington <wak@google.com>, "Yuxiao
 Zhang" <yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 1/3] dt-bindings: clock: ast2700: modify soc0/1 clock define
Date: Tue, 8 Jul 2025 13:29:07 +0800
Message-ID: <20250708052909.4145983-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

-add SOC0_CLK_AHBMUX:
add SOC0_CLK_AHBMUX for ahb clock source divide.
mpll->
      ahb_mux -> div_table -> clk_ahb
hpll->

-new add clock:
 SOC0_CLK_MPHYSRC: UFS MPHY clock source.
 SOC0_CLK_U2PHY_REFCLKSRC: USB2.0 phy clock reference source.
 SOC1_CLK_I3C: I3C clock source.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/aspeed,ast2700-scu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h b/include/dt-bindings/clock/aspeed,ast2700-scu.h
index 63021af3caf5..bacf712e8e04 100644
--- a/include/dt-bindings/clock/aspeed,ast2700-scu.h
+++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
@@ -68,6 +68,9 @@
 #define SCU0_CLK_GATE_UFSCLK	53
 #define SCU0_CLK_GATE_EMMCCLK	54
 #define SCU0_CLK_GATE_RVAS1CLK	55
+#define SCU0_CLK_U2PHY_REFCLKSRC 56
+#define SCU0_CLK_AHBMUX			57
+#define SCU0_CLK_MPHYSRC		58
 
 /* SOC1 clk */
 #define SCU1_CLKIN		0
@@ -159,5 +162,6 @@
 #define SCU1_CLK_GATE_PORTCUSB2CLK	84
 #define SCU1_CLK_GATE_PORTDUSB2CLK	85
 #define SCU1_CLK_GATE_LTPI1TXCLK	86
+#define SCU1_CLK_I3C				87
 
 #endif
-- 
2.34.1


