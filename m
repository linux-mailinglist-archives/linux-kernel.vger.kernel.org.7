Return-Path: <linux-kernel+bounces-758510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71087B1D018
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EF918C43F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CD3FB31;
	Thu,  7 Aug 2025 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ospKx1Jv"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BA17A2EA;
	Thu,  7 Aug 2025 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754530274; cv=none; b=D75g/FhFJUSoFJRzPWUckJppksUOfmEgc4tloe9D884nQL9avyU7tPWrsWHpuEHxEe3AOev0p7sGelM4aJw//eZHoUdd3ZCskSZgh1znT0usr0QhwO0HnnGQW0rpDWNEMkoMhJXr3E/AzaW/cWeVzoJegT/SXY2IlbgxjBk2aVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754530274; c=relaxed/simple;
	bh=sxGnfSSFz+QDwg50EXWstYMedLLmqKm28v9mT9MsQQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCuWCFA9C8EAEDlsQd/nGonUrd09/YfQMRfl/zYtaAVew+VHRL9Iw1hew2OeZFmNSU2KPo9xizjPSi9Ed5wOoSyIVsivKd3OW/U0Ka5+Od5swog8WHi21/nZ9MKxSmWbAsbUzpM+S/Ga/d55yiUPg7PfZvoFB6aUZ4CmSQhk1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ospKx1Jv; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754530218;
	bh=iu88a8ay7VG2RXEtKM0gyJ25kHT+aTDCXwwaMilECgs=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=ospKx1JvFchuu1v0OOBB5cntvdj44pPeeEFayP8p5UNWqe/9f7JiSgBJg4cNYgMam
	 Mo6rntEXtT3tAmLrMNU1xWodHkVvd4sbL+OjYSLxBGa+ht9STACG3SYJKB1Eo+0z+P
	 usMeCPBgDtM5aZYNhK8OB8/zUyDbLYHTPZFLE6jo=
X-QQ-mid: esmtpsz19t1754530216t1fe22e97
X-QQ-Originating-IP: XufVyFBFlZPw5gqLYgT9DkQ/sMxsFpvomT926UJMoXo=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 09:30:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11800184382334055400
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 07 Aug 2025 09:30:10 +0800
Subject: [PATCH 1/2] dt-bindings: clock: spacemit: introduce i2s pre-clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-k1-clk-i2s-generation-v1-1-7dc25eb4e4d3@linux.spacemit.com>
References: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
In-Reply-To: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754530210; l=1005;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=sxGnfSSFz+QDwg50EXWstYMedLLmqKm28v9mT9MsQQQ=;
 b=c1WOPEprEFuqX1JuniBPzz1BLPQLK7s+QSaEugX2PSJ5Y4cTmYrzwo7Ci+k3rDHuMf1xlYrpe
 Jwb3/qeiY+tCfgtzx7K2OAYGp3FBvXZJ4RuOEsXF/dzUQIWTBF3SpqF
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mfm8HKGnOlI92RkV1m9AeUnXPV4O3FJ3PiHC0qsdtcuZNsl1anctGK8c
	98dj0xNS/Dl6tOtmbTNB6vynzqMJwRLbVXj7DIX4uKErRK0Y/n9GJTYwBJ07BLBh9yaEliy
	B9AvYLCjd6yU8pEoYF3R19OFXR0LTqdKy5O0P8bso/Z0oScv8rlehqrSqx8EggqIpawwYfL
	l/n/cMdTDGm045bnTD3kSUzCqukhOEceFUAcr7ci7WZBjP+L8Za29OdrC6jdPUVW9xsZ6hi
	9UHRJdLflfl5vo2RhrZ59Ax2GEATw4NoLgBXDsmQIfCtti2t9eYfaIrH8NAe1zrDeA78JnR
	x37D8dn9N2WvNzX+biS+6J+ClhqqerK22LULm2cvH2Pi9L5M1O0N7Ds2UA/4kcCgUAQSwUO
	b5DboQ+c/sqgbBGoqkUifcNyybhw8ltP3QfG9MJHf76RCs1NmnWmI6+8pGPUuDcLelH1U+Y
	CjaASy3vynaicB6n8HNnXgLDWuChyxI6rMer40gcDwZtIqxS2vMOZ4n+QjzkfKDafpbr1nt
	2TUXW5inMozAf72iMQWNPosPlyTEcG+yXiSpSYdzPjjG/n3tspyfHhbhTRIC+2M9f6Yp21U
	xaxMXn7hOmHczCYegEHdHG/B5rpfuqkw7iREEIOaT7lf1VJmHe2hR0DE4XBtRxGyoQvYblL
	eMAaSfe0w7i45Vla99RlLVEdoCD+YzhUVbMy76q7XlVf6X8PS1PxFLT3ccphqy/YEQa2tww
	hYmIUfCU8dC3ABr9DCbrzdqjZV3GPZ9Zsp6z1VRdW695J4QzS376lGEn3Hnv57q6Bju43Rw
	koBUEH3xrGEOCxflaA+x9hP9CX5PkDfY+QqlC2UdPR//moAWQ4WNP3UW0Wt7a3mXpUdUwty
	V/qN6RsMEPovRTYhIhZNNJw2xJCsa5Io/KdXqB0OpRryAUkeIiyiZSsPgZA9oM3eVKfztPW
	H3G8fnkKoszmfy4bNgQn2VVrobHHhVDdLo8b2DKoMgNdpJMXDJJ8eQrdGHGhoA2DgImvfNL
	XkTrNwLQUMk0zlWkbLHpKZ1zWnVNZr/64zXX6oxlyCGk0sbiqRcnJ99dF3UUrk8leVXt7Rn
	a7ddoS6md2JVnU8XgOUfLFf8zK//aCaCd7+jEkK1NmUmFgvushjgzA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Previously, the K1 clock driver did not include the parent clocks of
the I2S sysclk.

This patch adds their definitions to allow proper registration
in the driver and usage in the device tree.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/clock/spacemit,k1-syscon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
index 2714c3fe66cd5b49e12c8b20689f5b01da36b774..524268246fedd3f1238320f35244baf32354fbd2 100644
--- a/include/dt-bindings/clock/spacemit,k1-syscon.h
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -77,6 +77,9 @@
 #define CLK_I2S_BCLK		30
 #define CLK_APB			31
 #define CLK_WDT_BUS		32
+#define CLK_I2S_153P6		33
+#define CLK_I2S_153P6_BASE	34
+#define CLK_I2S_SYSCLK_SRC	35
 
 /* MPMU resets */
 #define RESET_WDT		0

-- 
2.50.1


