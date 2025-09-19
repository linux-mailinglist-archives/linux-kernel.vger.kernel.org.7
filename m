Return-Path: <linux-kernel+bounces-824714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DACB89F92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B535916BBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC6311598;
	Fri, 19 Sep 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bH6+Isni"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36A314B72;
	Fri, 19 Sep 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292119; cv=none; b=F46qfK2qIHkTWp9KBF4Q6xCD++Yg80h2NM5oL73sI4M/WDiQlafszbFWur0kt3TDPhaNSdZ66N9aukFCSxhZXh1ZQ5TPrDvooIif1riFRjSfJ8sDy5ZIrP1ag5IKhLxC+HpXNG4Tr9HhoO4MvaR6oflvjIt49jFDx2aoTZY6xKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292119; c=relaxed/simple;
	bh=Y3RUvEleICamic1h3jwv0FpTcfcTlZFisBVgwNksYhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+fH5otofsKGcm1Rqjf3wmZYQzreQ59Ygy+Fzde0iZl8LcbCONTFYTr4p1We2w9XftD7OVHB+J72EVMRKBCJccUPgJHOO59o2zj/Ks91UXjMF6zJTrRP2nuK/5aowoygx/tdLBMaW3ccpuow93W/xYyLB+1X+Cglw2Enu4SgYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bH6+Isni; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AEECB25D0C;
	Fri, 19 Sep 2025 16:28:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9o14jLHSxmyC; Fri, 19 Sep 2025 16:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758292115; bh=Y3RUvEleICamic1h3jwv0FpTcfcTlZFisBVgwNksYhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bH6+Isni55SWXplpfjf+SwaM99R7vyC2kP9tfxGjvfzIvxcbgGGFg5NTqbn5FpPJx
	 un+lVX6VK0p5u3Wbvgu41QypQqIH+ChBLeIZtF9FPJ9sQoq5OXWulPwhc3jxb1vp87
	 zQehbABX7hp/ynRq7tu5SZK+BJ2kWgyMaWp64gQJhtRPJAHgI7vu7U9FABl/wIuHPh
	 TCDpmBQyvvAXNMcWAxCALGQnoNuxLUNqbbr2PC4AqE9380nESkPWIMKBxAFKJ7Fg7d
	 LLX/X9CzTheq+fFPXTmyjta9pK8oe1YhIzorB5PNLJRBtFunzLJbDPszrxmWZGOvXW
	 HOH4H9A9d59zQ==
From: Yao Zi <ziyao@disroot.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4 4/8] clk: loongson2: Allow zero divisors for dividers
Date: Fri, 19 Sep 2025 14:26:45 +0000
Message-ID: <20250919142649.58859-5-ziyao@disroot.org>
In-Reply-To: <20250919142649.58859-1-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LS2K0300 and LS2K0500 ship divider clocks which allows zero divisors,
in which case the divider acts the same as one is specified.

Let's pass CLK_DIVIDER_ALLOW_ZERO when registering divider clocks to
prepare for future introduction of these clocks.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/clk-loongson2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index bba97270376c..7a916c7d2718 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -361,7 +361,8 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 							  p->parent_name, 0,
 							  clp->base + p->reg_offset,
 							  p->div_shift, p->div_width,
-							  CLK_DIVIDER_ONE_BASED,
+							  CLK_DIVIDER_ONE_BASED |
+							  CLK_DIVIDER_ALLOW_ZERO,
 							  &clp->clk_lock);
 			break;
 		case CLK_TYPE_GATE:
-- 
2.50.1


