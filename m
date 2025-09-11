Return-Path: <linux-kernel+bounces-812628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5422DB53AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF79564797
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C53680BB;
	Thu, 11 Sep 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2J++6Ob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AD3629B3;
	Thu, 11 Sep 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612835; cv=none; b=Imhql+6B2VM0cndauVE0bxyD4yMsEezEmJ5xyy9G4ikY3mwDbkVYOLkzKXal90sShsl8lJj82VPQiAwDt6S/YMY/o1h2i2WNmNXOCS3d7tEZYVnaHn+b396TRZCm9bJxbfKaG/yagJgM7Mr7phTfbs90NA88ICnoczzDSA2nVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612835; c=relaxed/simple;
	bh=1ZGcBxhR574KIHzPTRucl3u543FWRbkCW4Ao9ObAk1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJ/sVzhMQeCOiZqUOv88kUjj8R39BFezmhs+m6wRLVmcMzzHpapQ17rM1s/mQk2OY2+m/CGq6cqc6yfFQX1ckOW53tbc+mJw82pyljed5HLSrMzwccJS1xU+WijwBdenKJ6/cY0cUPs4/Nr3dKr42Ebeel6JZfKLUmJPaqbUEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2J++6Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52A2C4AF0C;
	Thu, 11 Sep 2025 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612835;
	bh=1ZGcBxhR574KIHzPTRucl3u543FWRbkCW4Ao9ObAk1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2J++6ObT+/bFDQ28j5g6wlsxqMCaur8L7DjvJqCzgBwC6+uusKH7LTfD2NtlJj0n
	 W/A/v0Bp3yX9pIMzVTkPgsPGCrkWHTu22zxh8EeHKai/TDNsZwp5GzGS0GpX+lm5GS
	 CMY2pRnHv21ccTJqlK7l2fMrLdklCqugP+qtxucZLR6Gf8g3+dvvH/+ZW84R8qoi0H
	 BRbqznKQH2GaQ03OFf1Jwa7aEmSwYHHvXsmYNUVRdsV5SUIJ6mZi+svyEYhDdGtS/6
	 flH+GhAei8XQ9+jGf2OK+Xwkx41OsSU5NyYkWAkTqu6NrpVzCiJWPeyTR9C1aO0ldK
	 qdGWVVJmbxt8Q==
Received: by wens.tw (Postfix, from userid 1000)
	id E8C225FEE9; Fri, 12 Sep 2025 01:47:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] clk: sunxi-ng: div: support power-of-two dividers
Date: Fri, 12 Sep 2025 01:47:07 +0800
Message-Id: <20250911174710.3149589-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Some clocks (for timers) on the A523 are mux-divider-gate types
with the divider being values of power-of-two.

Add a macro for these types of clocks so that we can use the divider
types instead of the M-P types without an M divider.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_div.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 90d49ee8e0cc..be00b3277e97 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -274,6 +274,24 @@ struct ccu_div {
 	SUNXI_CCU_M_HWS_WITH_GATE(_struct, _name, _parent, _reg,	\
 				  _mshift, _mwidth, 0, _flags)
 
+#define SUNXI_CCU_P_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				       _mshift, _mwidth,		\
+				       _muxshift, _muxwidth,		\
+				       _gate, _flags)			\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV_FLAGS(_mshift, _mwidth,	\
+					       CLK_DIVIDER_POWER_OF_TWO), \
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
+								   _parents, \
+								   &ccu_div_ops, \
+								   _flags), \
+		},							\
+	}
+
 static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.39.5


