Return-Path: <linux-kernel+bounces-756632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D69B1B710
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DBE624D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281632797AC;
	Tue,  5 Aug 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HKx0Bbu5"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2C277C9C;
	Tue,  5 Aug 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406279; cv=none; b=bAT4Q++uCTQyCiMrhqCSFwwXCYEnPVn8JOiEi+faS1TSkGdFw6pVsTFR5ZiVJbpKB8VFokr7EYQueLFpJVLIFQLsfnxRD4rFOnm1iXONMWxf2/CpSABMo+BTZ5QBaTyaV6At+JzFWklD6RpU02X8XTF2QGSDjh561RmsYWYfSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406279; c=relaxed/simple;
	bh=SphuyDnE/+01mJhTz5T8pC+wNRaE5hxsq4Cc5z+u9o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUCZd0Q2HJBLehLgy+5eddlFYsJF/wkTeU4iI4x8bDe1DYbahd8cWu+P9YRtt2fG2UO152EAcpxE5OWf81QCOOWhlLgblwAM5t7kcnEAGNEqaTYjHU3ZuocinVPESTgyPMsxBjy0NLm0q55AfdCAtJCkLAlEPoDSK4IFsXnM1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HKx0Bbu5; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CD1FE2005C;
	Tue,  5 Aug 2025 17:04:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i43S4mpMmekB; Tue,  5 Aug 2025 17:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754406275; bh=SphuyDnE/+01mJhTz5T8pC+wNRaE5hxsq4Cc5z+u9o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HKx0Bbu54z4vR89xil1TDVVqesJ2Z5gYbMaxsbFWG4rFsWm/E4GhtExhIK7mHa2kd
	 tfLowNJ+m3P+5IUVTmdYBDEtpUzLqcoTIh5tHw+qSDkh1j7W2g1r6gQwGtRasxsKCY
	 oAMU/oYFyN7udbOCN0fWdti7IIjDrICvORK1phteYKrUYlGhjf0cV6JeEH3KXnPhNw
	 GfeYlzvy81wMQSHdCx8rHSv/jpwuxZwwZ3PbXjS6sHFSu/Ip8M4iJ/c6SQEfNnQa3q
	 G/4uTirf5FEUde7sK4q2twFrcFQMGorG1EVywAY9M7bGlr8YJBVFwET57q+dQUO0Nj
	 2YCO4nsq4BBTw==
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
Subject: [PATCH v3 4/8] clk: loongson2: Allow zero divisors for dividers
Date: Tue,  5 Aug 2025 15:01:43 +0000
Message-ID: <20250805150147.25909-5-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-1-ziyao@disroot.org>
References: <20250805150147.25909-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loongson 2K0300 and 2K0500 ship divider clocks which allows zero
divisors, in which case the divider acts the same as one is specified.

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


