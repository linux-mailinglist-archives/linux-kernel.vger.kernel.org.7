Return-Path: <linux-kernel+bounces-864282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0CBFA644
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB26485433
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA272F39A0;
	Wed, 22 Oct 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe99KiEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CA2D5927;
	Wed, 22 Oct 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116342; cv=none; b=XvxpGi4TKxR25kULslz97GeGurpUTMLcbhuJzZbVcztK+x9VxRoLkI9l2TysqEr9jkdDLTJdf/59Qjnh6o6zGpmYDusmee4L0d64DILSj1DvTA+5FAtN0Pgp3sFWJDAbk3YQrned7QnNLZRAF4woJJ3yQVmBnMQA6mf3sYWJJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116342; c=relaxed/simple;
	bh=I4YsZlslKVYM5XtiEfLCXEYzAjKsoHF2XlksQ5hG6dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uz8sCEccbpALBUYyro16xOB2ziDS5LinD8c4CfCS7+W1R//mgfTiOksW6pLo4TqyFWljWXMkVaOads3Fs8/3H5rdvIwtE433F9SkBaIDptJQPzjpAf86dnMBTI8RvFXhJJpofWDRCeohzTFzjilpXEjp53XOdEqwiWMVldDFRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe99KiEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6470DC4CEF7;
	Wed, 22 Oct 2025 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761116342;
	bh=I4YsZlslKVYM5XtiEfLCXEYzAjKsoHF2XlksQ5hG6dU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qe99KiEXbnPS1IW1G/xMz5aP8btVwmr6YKYISN4AXPzR/TrJkaa7rmexGv2Fyhwa+
	 kyIo81o3EuHgTgNEr0tm3u2lmA/8tEWlWkN5qSSkoyVL1Se0cLkjeIiMMZ1KYhPLmG
	 flxLks8isTfKjeJ0mOYaR+4FoDcZadaPAjZiYF3S/9ekuSeZyiRV9DLJqrjKKcobTA
	 vZJLV4b2I7UE02lmtrDRwb1OTr+49aj93ZG+nIFSAUUkCKx6KW4FRRmhkLRAsZGNFE
	 z0lD8bAts0WBhozTaIq4LySgHtY1Nh9kA836I+l5F2+3aIUFUhbkpxW77odBi4L+3e
	 3MMV51s72fxbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BECCD1AB;
	Wed, 22 Oct 2025 06:59:02 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Wed, 22 Oct 2025 14:58:51 +0800
Subject: [PATCH 1/3] clk: amlogic: Fix out-of-range PLL frequency setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-optimize_pll_driver-v1-1-a275722fb6f4@amlogic.com>
References: <20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com>
In-Reply-To: <20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761116340; l=799;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=p+FnM7SXXWR/Lro1GSMYPZJ+As5vPrIAECBCtFZ7G6Q=;
 b=ClxCqKi3/e4IxKUNaE1WjlZyjocex3l4YrnDTktPBAF0iswWL7CnwzsCJbhDHBjEFrE9p0UnJ
 zF2arI+2lxbBlJNKWfslLsxbjOT66SAmuN6iu1Uxvl9WexL9e5nkpts
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
index 1ea6579a760f..b07e1eb19d12 100644
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



