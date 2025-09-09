Return-Path: <linux-kernel+bounces-808724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B49B50403
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831671695B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D8F32C33D;
	Tue,  9 Sep 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLqacjB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929E33471C;
	Tue,  9 Sep 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437792; cv=none; b=FYegB0x6UB8mCpp5BQc8lvkO9jxya0AA4W0s1UoA6K0urSBmzkzmp0LQPHdJItCZMbhlEVX41Qx+hHAL6dqaaexd6OXDe39KNhsQ8ZVzAQz1rduCh3EjC3AtzYc/VsdoF7j46NAZkQG4wl7Pic7NOaFiszOZv/BeZD2PBaS7Zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437792; c=relaxed/simple;
	bh=mTZCk0YysupG4SdzVgITyMExGpzb1FzxUWWrQIt6Ems=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NRdeJGZt4CJaw8v7om7QwbpAHWL8U7rUFQ730haj5p5b7xbS17Lu1G7hqzgTWNE8IRraVIUHfzy7oc66ORzaLY1ANorMG0VD4OuVm71eviS5PFMRusXQIBD5ffH16dhjhfEyDdhCcVNVY51TcWUux7g4A0I52K47h/H/6v5DCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLqacjB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E981C4CEF4;
	Tue,  9 Sep 2025 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437791;
	bh=mTZCk0YysupG4SdzVgITyMExGpzb1FzxUWWrQIt6Ems=;
	h=From:To:Cc:Subject:Date:From;
	b=fLqacjB/h0fG+akp9RST3Ff6Luym6SCgdiy7wjkfyuN98O3vrwCZaW/rLjH6rRvb8
	 ywSA+nWhQxsDkO1BVXDOVGeCncv2id+7aGjJZ3/KY6TL0ODioV8UtraKBpYaF8kmpO
	 0pezqDLCZxc3w4tr/38lhzD7PY5JjaZ2Q529Wa7V5NKUg8p1iz9nkCy+HW87GhHKhu
	 4F1kJCSHuLj+AeUcoq4qdQ9hC4KCvDfxT5UjeTEObe6V0Y6QtJi9I7SK3pjEYt1Pq/
	 ogn08k779XKvwra9EKgWjcnXnJs+3dVZhIa/LOAKm5+p4AEiKS0pGd919l0a0Byqs6
	 pRRlDd+6yNnCg==
Received: by wens.tw (Postfix, from userid 1000)
	id 8146B5FD80; Wed, 10 Sep 2025 01:09:48 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: sun6i-rtc: Add A523 specifics
Date: Wed, 10 Sep 2025 01:09:47 +0800
Message-Id: <20250909170947.2221611-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The A523's RTC block is backward compatible with the R329's, but it also
has a calibration function for its internal oscillator, which would
allow it to provide a clock rate closer to the desired 32.768 KHz. This
is useful on the Radxa Cubie A5E, which does not have an external 32.768
KHz crystal.

Add new compatible-specific data for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 0536e880b80f..f6bfeba009e8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -325,6 +325,13 @@ static const struct sun6i_rtc_match_data sun50i_r329_rtc_ccu_data = {
 	.osc32k_fanout_nparents	= ARRAY_SIZE(sun50i_r329_osc32k_fanout_parents),
 };
 
+static const struct sun6i_rtc_match_data sun55i_a523_rtc_ccu_data = {
+	.have_ext_osc32k	= true,
+	.have_iosc_calibration	= true,
+	.osc32k_fanout_parents	= sun50i_r329_osc32k_fanout_parents,
+	.osc32k_fanout_nparents	= ARRAY_SIZE(sun50i_r329_osc32k_fanout_parents),
+};
+
 static const struct of_device_id sun6i_rtc_ccu_match[] = {
 	{
 		.compatible	= "allwinner,sun50i-h616-rtc",
@@ -334,6 +341,10 @@ static const struct of_device_id sun6i_rtc_ccu_match[] = {
 		.compatible	= "allwinner,sun50i-r329-rtc",
 		.data		= &sun50i_r329_rtc_ccu_data,
 	},
+	{
+		.compatible	= "allwinner,sun55i-a523-rtc",
+		.data		= &sun55i_a523_rtc_ccu_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_ccu_match);
-- 
2.39.5


