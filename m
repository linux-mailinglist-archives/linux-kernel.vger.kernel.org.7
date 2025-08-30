Return-Path: <linux-kernel+bounces-793081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5800B3CDEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B58D1897FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6AE2D876F;
	Sat, 30 Aug 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vI83iiQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BF2D7813;
	Sat, 30 Aug 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573763; cv=none; b=tyZux9xXh6dkF8379UQbaKiEl/JSxA27UzV2cbqsgpaDmCi6/Hdoq72ufAF7dP8mi4vbcxwuzM7cSogK+Q7pjoV0L6LCjEiptu4ujA5n04snBG5x4l9yml33d3U+zNUT8SZrX8+7MDf1HFrqXp4rzCfCJ0D+Y2CtN7rBdR4DFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573763; c=relaxed/simple;
	bh=1ZGcBxhR574KIHzPTRucl3u543FWRbkCW4Ao9ObAk1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7buuW43kBVwpfo0oXBsoqfrigBOe/lAey7/yAWHZYlIa+/WrC6ur7/iIwkcjUo+pU0ri4Ry+2YjwuA8FHDHOVhd8TFdn3W19sOcxWRngalt0OtY56+njuERmH5P9IfypJu+x2dEn6ydUbGNGHqbpyOb+mCdhYytnn/BzyoS8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vI83iiQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B991C4CEEB;
	Sat, 30 Aug 2025 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573762;
	bh=1ZGcBxhR574KIHzPTRucl3u543FWRbkCW4Ao9ObAk1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vI83iiQZBW4XV+q5tHTOwmQ1UKfYiLXsk0MMtdOuCQ9ZbneFFI3fw89x+rrjWm42X
	 QxJVdB+b/kND+DX3O/zobvZZ6DgTCvc5nqw7dRXvYknALf8gHzwb8b0KDAM9oRbXp8
	 DTM8frvOfBj+awY3OsDoQZjOJeQDbnTxXIpbco6C3SrQtYEcAsNXwzLiVIQHV6VcWl
	 B3qDoc+ODPjbq/o6YT4lG+uj2LNChj9BCdBR5I8IZPHNT4BFZpC2vEUPdZyrHGX2/h
	 vgJ23Gx71wOtQK5AphGRUjaFMkE9RjX0/eztrdX79rkAD9Y4RHtXX8nE6c8o4lHtvc
	 rNCtz6f+mL0TQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 6AA495FDD4; Sun, 31 Aug 2025 01:09:17 +0800 (CST)
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
Subject: [PATCH 5/8] clk: sunxi-ng: div: support power-of-two dividers
Date: Sun, 31 Aug 2025 01:08:58 +0800
Message-Id: <20250830170901.1996227-6-wens@kernel.org>
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


