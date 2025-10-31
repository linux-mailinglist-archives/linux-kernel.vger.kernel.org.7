Return-Path: <linux-kernel+bounces-879685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE974C23C05
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AD864F5DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1FA337BB0;
	Fri, 31 Oct 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxXPJYx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011D3358B3;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898232; cv=none; b=U2th3ydRsnWB1CgXIpfRWTyt06y+YDr94uFsdMP+Yh1sVqBSFxRceziSqVIdO4ATP0cB4nsaIN+vDCAhcPA2d1F4uSTROiQ46njUZl0E/P0ZRCn9rkdKHnydtnkwGmAaD30WblJEsMGNFChDr78bltn1Zyq6Sd8O4GWiKpufBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898232; c=relaxed/simple;
	bh=5tLSRE6BInQejsiPR/fc5RiDlVZ9iOn8Or4TkaTc/g4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSvC0nBYkpNTs9qbe4zZ9Z8qJ3HKQY8ZlRI2BWsOr7GidYi7OL5LpyACOttH+czr/QAUe+GpEBZ0Roxv+ILcnoG0EQ2/o617C4ya7dZjM9dBQEW+9tqCvoRGt3xM1HY2pzpNff+8YxtajGnxkaWvNwR2yRnpn7uCLNFs43i1+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxXPJYx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6D74C4CEF8;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898231;
	bh=5tLSRE6BInQejsiPR/fc5RiDlVZ9iOn8Or4TkaTc/g4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VxXPJYx5ExMJP2rAbhU4KIO8npVjh6DbnR2J6BRPtkKWcYGt9MmiqrDMZLVKjz+gS
	 VVGTho99vx4Ak2zm0QIou05MCrjuMm4p0ECVsYS4MdpGLnR/xBCFYucgEwO4Qv99fv
	 O9Y9aRIKvUxODjPwdU/RKNfmAOOL8SLMrBCrygOeDB4rhpxvro+5x0JJNW19yYWyqZ
	 +cYK4u0ZdJBc7f92wjyC9oeY1xs161fYawAzN0EMiyDcyr5ThUKEIr4Gh0TdTtWbpA
	 JTihv25gg1Jx61Fl/K47Jnc31oduDUl+zQa10nHeDIX1QLDofzw+evX9w9sNvhuKRA
	 t/SqoC0Kja9Ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53CECCF9FF;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 31 Oct 2025 16:10:08 +0800
Subject: [PATCH v3 1/4] clk: amlogic: Fix out-of-range PLL frequency
 setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-optimize_pll_driver-v3-1-92f3b2f36a83@amlogic.com>
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
In-Reply-To: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761898227; l=991;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=6onhzW3ODDG4bFoHZLKVZ14BJkN4o2IaabjNVGrsFP0=;
 b=y7Jqs7z4QNs/tnWA3pjqpJDu6y8SCyMGOt9v1jYNHZ6CEi+bTOQkabAxtRF0VzG2xjZecfXcr
 Ey9zrxitmMGAFOuk4W44evTpq2JS4qNTWd0Jzg04fNoUjRao6J2tWaX
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

If the calculated 'm' falls into the range:

    pll->range->max < m < (1 << pll->m.width)

Here an incorrect 'm' value could be obtained, so an additional
condition is added to ensure that the calculated 'm' stays within a
valid range.

Fixes: 8eed1db1adec6 ("clk: meson: pll: update driver for the g12a")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 1ea6579a760f..629f6af18ea1 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -191,7 +191,7 @@ static int meson_clk_get_pll_range_index(unsigned long rate,
 	*m = meson_clk_get_pll_range_m(rate, parent_rate, *n, pll);
 
 	/* the pre-divider gives a multiplier too big - stop */
-	if (*m >= (1 << pll->m.width))
+	if (*m > pll->range->max || *m >= (1 << pll->m.width))
 		return -EINVAL;
 
 	return 0;

-- 
2.42.0



