Return-Path: <linux-kernel+bounces-837434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F505BAC528
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A091754E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BB2FB991;
	Tue, 30 Sep 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbowOD04"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8F2F656F;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225052; cv=none; b=So7K6LRtRfF/jQw2PVgGFlFq+T/mM0xROonfJmOewGYF0YOWCd6nd+4ikXN3GMc8lZfflQGE19MM1NLW8+CnIB+zCNaVow5DvyHgwpvn169vXWUlapZSYLpk2Ww3yqAy/p4S+xNGBccqpXPnhJRoep5a5TvfrXKQmz4yzuFKDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225052; c=relaxed/simple;
	bh=YxnyBmHxHXzYw9b8hnimJetb+1Ax5l5URVrr4n8BLuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sULXMzBBXbJ5BZmgtCruKQ8OStMZYGWWI7koOKuI1P8Cs9yLjyP9F1RpAURzjZZHQa00PJic9NkiWgMdvf1RtJJCVicX2/OmYWOtoLSKNnpUevqSlU3AfDRigP6ts043wU475ZtE7ThttSd6NLmNyuApQlOzJIY0MZJa69AAInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbowOD04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98B3FC2BCAF;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225051;
	bh=YxnyBmHxHXzYw9b8hnimJetb+1Ax5l5URVrr4n8BLuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nbowOD043XUfT4f0Yxlyoo5OVZnB40eqlO5t0xPQxBSSD9JI7WyKAUgg3Q8OfWhw5
	 RL6MIcbXGMn+URG1vzBPntmntV7sXXl6IbzkuhO8LnmJzt9vdTVv6dVgOQmZkcGWz3
	 HkmGGkBwypfBdybroOOoeFnkeg0fUwYQUi8Or6c2d8xc+Djo3M4H52l+RxDKZKFbcN
	 U9UZ6eKq1HDUc8r3kAD5Th0ozB2gGSCcLNxYFAcVW8U7D4LrTfDFLSJhGwKbChaxDk
	 DdS21jjICCK6FLPJdR56svsHekatDhrJAzw/ycwQEEw7zjiCFCcQhn8r5Yeh3k7QpH
	 wwyPZ8KAlP92g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50CCCA46F;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:19 +0800
Subject: [PATCH 06/19] clk: amlogic: Fix out-of-range PLL frequency setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-6-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=799;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=N/UanqAAstFKaIoQ6E9vlI4RDukLeWAnvo1MhrWVBkQ=;
 b=NIGYgjmhjY3pQ4TkcHp0Hu/MXYaxJFmjLqUACPK6UAcYyXgxSZv9INdR2f7JW4NPfchtH+Zg6
 xq0i+9MDrAkDlwweTsVFFpVntkLGXyDpWktoIks9BoSUXNbAlLfgsdA
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

meson_clk_get_pll_range_index incorrectly determines the maximum value
of 'm'.

Fixes: 8eed1db1adec6 ("clk: meson: pll: update driver for the g12a")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index c1e4c5710015..602c93aba3cc 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -191,7 +191,7 @@ static int meson_clk_get_pll_range_index(unsigned long rate,
 	*m = meson_clk_get_pll_range_m(rate, parent_rate, *n, pll);
 
 	/* the pre-divider gives a multiplier too big - stop */
-	if (*m >= (1 << pll->m.width))
+	if (*m > pll->range->max)
 		return -EINVAL;
 
 	return 0;

-- 
2.42.0



