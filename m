Return-Path: <linux-kernel+bounces-793073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CFB3CDE0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E73188F212
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECB12D46AC;
	Sat, 30 Aug 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow9x2nSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE32C3266;
	Sat, 30 Aug 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573760; cv=none; b=rJJxs9dKtwZXcX8IHbnFLJGib3PjkSNRLnmP2hZw+AOaFV8S6TOC0y3b4r+MbEzyk1euVlBL6Dzs6POGwEpM8z4Uh0a6iXck4pjzlM0hvFzmXpVnDBLPYcmtCvwP9EBF3t0ECmUZ/jtouBmUne+jfJuSxz3dOYziEsHubmuDlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573760; c=relaxed/simple;
	bh=5a6AXZ9/TQJt7kA1cVIkch5wEdFuJBLXnhAS02YEYgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1PLyxL2Wyzu7ZbH5WIeOTzTe2iSTdWxY15WBusAhswQzAKowV0SH78JGBHWufbKNbSQAkGw3SIfcefq89XpTe7lgB63mFPrtZ6AVOoGtzx2NuUH8VlShaxppfX1RQb6DhHcM5l11Nb5gIRnfijX5ALpYza8xe8Wegi5DlzB0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow9x2nSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE33C4CEF8;
	Sat, 30 Aug 2025 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573759;
	bh=5a6AXZ9/TQJt7kA1cVIkch5wEdFuJBLXnhAS02YEYgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ow9x2nSICfTEAI30gtt2nKSajoSKBK5H5SZ3GptNsb6EHxzDAUoltjLG08m4OIkUa
	 dt0MBFONHJxNYlJ0WW/KfuljhDlt+TtVGLYrTIRziCAOa8I4PzITRNTh1xQzUW1ozv
	 m72l7hSS7KRHBpeRq6Xx1lR/j4NQMnC0nX+ODD9WSssbDCDwz9LUiKDnTWIu1sTePA
	 wMTlEMAsHKod0zVP2SvruxdzuGGIYfWSKs9Rr+C8G0MhYDMq6ZU0YUb6Xkd7BLvPVf
	 ao0otQvDv6PUUyDIOxLjAU9FDzHOB6wPergBEDDxWL1DX1HBnKXNahS8JIpZk+g5Zl
	 0e3dS9SEkhYdQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 5604D5FE30; Sun, 31 Aug 2025 01:09:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] clk: sunxi-ng: mp: Fix dual-divider clock rate readback
Date: Sun, 31 Aug 2025 01:08:56 +0800
Message-Id: <20250830170901.1996227-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830170901.1996227-1-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

When dual-divider clock support was introduced, the P divider offset was
left out of the .recalc_rate readback function. This causes the clock
rate to become bogus or even zero (possibly due to the P divider being
1, leading to a divide-by-zero).

Fix this by incorporating the P divider offset into the calculation.

Fixes: 45717804b75e ("clk: sunxi-ng: mp: introduce dual-divider clock")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 354c981943b6..4221b1888b38 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -185,7 +185,7 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
 	p &= (1 << cmp->p.width) - 1;
 
 	if (cmp->common.features & CCU_FEATURE_DUAL_DIV)
-		rate = (parent_rate / p) / m;
+		rate = (parent_rate / (p + cmp->p.offset)) / m;
 	else
 		rate = (parent_rate >> p) / m;
 
-- 
2.39.5


