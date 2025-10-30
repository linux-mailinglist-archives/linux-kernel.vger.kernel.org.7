Return-Path: <linux-kernel+bounces-877552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D61C1E68F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDF63BE734
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF02632E13E;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d91xdU3D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843932C94A;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801858; cv=none; b=htGg8+DVB873HcSQ7F+pd8GM9Lwkr4OWYuWFX7M+Of7tSA1Gxoa27eSlDAv8q2sIP2byH8qgCcEQH848xGAcp/8gjfFpWypEfZHODAc1wI9ICPLGs9kpuTAGy7g0AO2cvkE5CZXXbwRgNH9q/osxAoTCJ4tWPtpX9C7dX89/e7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801858; c=relaxed/simple;
	bh=5tLSRE6BInQejsiPR/fc5RiDlVZ9iOn8Or4TkaTc/g4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=httRM+SjbE9pMKNf5waiFPZ55C6F0jQj8sO4QhiWMBJabg8axvmpXCwC1RMrT05JrsEPZKHRqeNPg6vYEDtoL96uv0Wh74zEIyrAYJGXUV/Zyl3QjkaUKQmboX+6cMDlHqwcEYIg+v+EouHD31MqSPJ16VCkGiBvTlyZ3uvVMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d91xdU3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4D78C4CEFF;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761801857;
	bh=5tLSRE6BInQejsiPR/fc5RiDlVZ9iOn8Or4TkaTc/g4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d91xdU3DbJl+qQa6lgSQtM7avaR4NNy5V/BBKTRM7wJ+HAfoxiT8FRJTX63UPixo1
	 AJFPG8ySkx0ZyRFxWRRXEbyG1SbzTXHnG+eRluzSORyzg/u/MN4tousMEBE1uNEIGO
	 fsWmpwSrtd4YoejlXGH5+fGOPz42aara+mOHhVrTFrMT2m5yhlVevAPQFW53tHWriK
	 S/DSuVjw1oDxtzGp0BiREnjg9KKiV78RRYc9KYGbcvdDhdBBl89GuHNoCMWsAOw7B0
	 OrTDqQo3r6XJPKOvys5HzBP5VjGlBbAqPMhYGZVKMhiERNLgFa4V58oqDQa3cbVOIR
	 oaazgjXuWGsTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE23CCF9EA;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 30 Oct 2025 13:24:11 +0800
Subject: [PATCH v2 1/5] clk: amlogic: Fix out-of-range PLL frequency
 setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-optimize_pll_driver-v2-1-37273f5b25ab@amlogic.com>
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
In-Reply-To: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>, da@libre.computer
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761801855; l=991;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=6onhzW3ODDG4bFoHZLKVZ14BJkN4o2IaabjNVGrsFP0=;
 b=1KGZg2CEt0fhJufxEmdvITvTntwRDyum3Rdl62EXQsiDSKUog/TKBEitbhD1QajWng+8BLt18
 T+rrPWVi0uQBAvwQMD9AjZ6uyKVd2rP99mLY1neIEaParGQ9LNvQWUW
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



