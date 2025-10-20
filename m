Return-Path: <linux-kernel+bounces-860029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C1BEF29C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC8F04EB092
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297AD29BDB3;
	Mon, 20 Oct 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="H2MKM8Wl"
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com [45.254.49.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057A26B75F;
	Mon, 20 Oct 2025 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929989; cv=none; b=QrFjCr7Gh182eSa1Wi7g2IQ7JexoG14MqNfxRbkIh+YYjadtAOI9Xby9PTiqeMsp0asOpUP+hIKrAOHVNnkM0y/C0JcYg5gLSqJmOWEab/d4d2BY+2bU96WTHCrtcGuECRIOlVPtrpVLr9vmqfCnLye/l9v9vt6Zxx8CAgZCw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929989; c=relaxed/simple;
	bh=EhdkYAZpvq92qEuzwBPeEULq8Eb6F4v8ckyLbH1yC70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvUkPM+DzqEE3a45a4ZJenjerhN1FGcEmSJFwsDWj1v9d72dp7nvMhFKCXckbtIyEh3adH3NFBo9vuULdyGmR0wE+BUDQxBqcTHRRRsjhhvBu1svV4Qw1QFm67FT5iMTYmGw1CqZ3FsrOddL5exyz3hqo2+MPSSz8+PPxpY3as8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=H2MKM8Wl; arc=none smtp.client-ip=45.254.49.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2671210c6;
	Mon, 20 Oct 2025 10:37:27 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	sugar.zhang@rock-chips.com,
	zhangqing@rock-chips.com,
	heiko@sntech.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com
Subject: [PATCH v3 1/5] clk: rockchip: Implement rockchip_clk_register_armclk_multi_pll()
Date: Mon, 20 Oct 2025 10:37:20 +0800
Message-Id: <20251020023724.2723372-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020023724.2723372-1-zhangqing@rock-chips.com>
References: <20251020023724.2723372-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ff7a92b303a3kunmd1f16c94462dff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05LGlYaTBgZSEhMQhgfGB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=H2MKM8Wl93Mp1qm0+b4ood61ANFvyIn/QmxL6Yiyzv+43XIhuOZwHLk+occonm91ryETuuCTbK+7ZcN9hLnHcIfecCU/ze3JEcM+EETlaRtrix7gyhY1hXACf6xLF51WlvDBswku7oC9RSzv8VvT+mEFSLQbVDXRhZdnKaJRBoM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Vt1xPRkUMcE8svXTy4dUISsmpUifWdbpaIRSmoEuGbY=;
	h=date:mime-version:subject:message-id:from;

The current path will have an independent PLL(LPLL\BPLL)
exclusively for the CPU to use.
As follows:

            |-\
    --lpll--|  \
            |mux|--[gate]--[div]--clk_core--
    --gpll--|  /
            |-/

The new chip does not have a dedicated PLL for the cpu;
it is distributed nearby from the common PLL.
If there are special frequency requirements that require the
use of pvtpll, explanations will be submitted later.

The clock path of new soc CPU simplified as follows:

    --gpll--|--\
            |   \
            |    \
            |     \
   --v0pll--| mux |--[gate]--[div]--clk_core--
            |     /
            |    /
   --v1pll--|   /
            |--/

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-cpu.c | 165 +++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c     |  24 +++++
 drivers/clk/rockchip/clk.h     |  15 +++
 3 files changed, 204 insertions(+)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index dcc9dcb597ae..6e91a3041a03 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -396,3 +396,168 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 	kfree(cpuclk);
 	return ERR_PTR(ret);
 }
+
+static int rockchip_cpuclk_multi_pll_pre_rate_change(struct rockchip_cpuclk *cpuclk,
+						     struct clk_notifier_data *ndata)
+{
+	unsigned long new_rate = roundup(ndata->new_rate, 1000);
+	const struct rockchip_cpuclk_rate_table *rate;
+	unsigned long flags;
+
+	rate = rockchip_get_cpuclk_settings(cpuclk, new_rate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for cpuclk\n",
+		       __func__, new_rate);
+		return -EINVAL;
+	}
+
+	if (new_rate > ndata->old_rate) {
+		spin_lock_irqsave(cpuclk->lock, flags);
+		rockchip_cpuclk_set_dividers(cpuclk, rate);
+		spin_unlock_irqrestore(cpuclk->lock, flags);
+	}
+
+	return 0;
+}
+
+static int rockchip_cpuclk_multi_pll_post_rate_change(struct rockchip_cpuclk *cpuclk,
+						      struct clk_notifier_data *ndata)
+{
+	unsigned long new_rate = roundup(ndata->new_rate, 1000);
+	const struct rockchip_cpuclk_rate_table *rate;
+	unsigned long flags;
+
+	rate = rockchip_get_cpuclk_settings(cpuclk, new_rate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for cpuclk\n",
+		       __func__, new_rate);
+		return -EINVAL;
+	}
+
+	if (new_rate < ndata->old_rate) {
+		spin_lock_irqsave(cpuclk->lock, flags);
+		rockchip_cpuclk_set_dividers(cpuclk, rate);
+		spin_unlock_irqrestore(cpuclk->lock, flags);
+	}
+
+	return 0;
+}
+
+static int rockchip_cpuclk_multi_pll_notifier_cb(struct notifier_block *nb,
+						 unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct rockchip_cpuclk *cpuclk = to_rockchip_cpuclk_nb(nb);
+	int ret = 0;
+
+	pr_debug("%s: event %lu, old_rate %lu, new_rate: %lu\n",
+		 __func__, event, ndata->old_rate, ndata->new_rate);
+	if (event == PRE_RATE_CHANGE)
+		ret = rockchip_cpuclk_multi_pll_pre_rate_change(cpuclk, ndata);
+	else if (event == POST_RATE_CHANGE)
+		ret = rockchip_cpuclk_multi_pll_post_rate_change(cpuclk, ndata);
+
+	return notifier_from_errno(ret);
+}
+
+struct clk *rockchip_clk_register_cpuclk_multi_pll(const char *name,
+						   const char *const *parent_names,
+						   u8 num_parents, void __iomem *base,
+						   int muxdiv_offset, u8 mux_shift,
+						   u8 mux_width, u8 mux_flags,
+						   int div_offset, u8 div_shift,
+						   u8 div_width, u8 div_flags,
+						   unsigned long flags, spinlock_t *lock,
+						   const struct rockchip_cpuclk_rate_table *rates,
+						   int nrates)
+{
+	struct rockchip_cpuclk *cpuclk;
+	struct clk_hw *hw;
+	struct clk_mux *mux = NULL;
+	struct clk_divider *div = NULL;
+	const struct clk_ops *mux_ops = NULL, *div_ops = NULL;
+	int ret;
+
+	if (num_parents > 1) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+
+		mux->reg = base + muxdiv_offset;
+		mux->shift = mux_shift;
+		mux->mask = BIT(mux_width) - 1;
+		mux->flags = mux_flags;
+		mux->lock = lock;
+		mux_ops = (mux_flags & CLK_MUX_READ_ONLY) ? &clk_mux_ro_ops
+							: &clk_mux_ops;
+	}
+
+	if (div_width > 0) {
+		div = kzalloc(sizeof(*div), GFP_KERNEL);
+		if (!div) {
+			ret = -ENOMEM;
+			goto free_mux;
+		}
+
+		div->flags = div_flags;
+		if (div_offset)
+			div->reg = base + div_offset;
+		else
+			div->reg = base + muxdiv_offset;
+		div->shift = div_shift;
+		div->width = div_width;
+		div->lock = lock;
+		div_ops = (div_flags & CLK_DIVIDER_READ_ONLY)
+						? &clk_divider_ro_ops
+						: &clk_divider_ops;
+	}
+
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux ? &mux->hw : NULL, mux_ops,
+				       div ? &div->hw : NULL, div_ops,
+				       NULL, NULL, flags);
+	if (IS_ERR(hw)) {
+		ret = PTR_ERR(hw);
+		goto free_div;
+	}
+
+	cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
+	if (!cpuclk) {
+		ret = -ENOMEM;
+		goto unregister_clk;
+	}
+
+	cpuclk->reg_base = base;
+	cpuclk->lock = lock;
+	cpuclk->clk_nb.notifier_call = rockchip_cpuclk_multi_pll_notifier_cb;
+	ret = clk_notifier_register(hw->clk, &cpuclk->clk_nb);
+	if (ret) {
+		pr_err("%s: failed to register clock notifier for %s\n",
+		       __func__, name);
+		goto free_cpuclk;
+	}
+
+	if (nrates > 0) {
+		cpuclk->rate_count = nrates;
+		cpuclk->rate_table = kmemdup(rates,
+					     sizeof(*rates) * nrates,
+					     GFP_KERNEL);
+		if (!cpuclk->rate_table) {
+			ret = -ENOMEM;
+			goto free_cpuclk;
+		}
+	}
+
+	return hw->clk;
+
+free_cpuclk:
+	kfree(cpuclk);
+unregister_clk:
+	clk_hw_unregister_composite(hw);
+free_div:
+	kfree(div);
+free_mux:
+	kfree(mux);
+
+	return ERR_PTR(ret);
+}
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 19caf26c991b..2601df3b1066 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -722,6 +722,30 @@ void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 }
 EXPORT_SYMBOL_GPL(rockchip_clk_register_armclk);
 
+void rockchip_clk_register_armclk_multi_pll(struct rockchip_clk_provider *ctx,
+					    struct rockchip_clk_branch *list,
+					    const struct rockchip_cpuclk_rate_table *rates,
+					    int nrates)
+{
+	struct clk *clk;
+
+	clk = rockchip_clk_register_cpuclk_multi_pll(list->name, list->parent_names,
+						     list->num_parents, ctx->reg_base,
+						     list->muxdiv_offset, list->mux_shift,
+						     list->mux_width, list->mux_flags,
+						     list->div_offset, list->div_shift,
+						     list->div_width, list->div_flags,
+						     list->flags, &ctx->lock, rates, nrates);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register clock %s: %ld\n",
+		       __func__, list->name, PTR_ERR(clk));
+		return;
+	}
+
+	rockchip_clk_set_lookup(ctx, clk, list->id);
+}
+EXPORT_SYMBOL_GPL(rockchip_clk_register_armclk_multi_pll);
+
 void rockchip_clk_protect_critical(const char *const clocks[],
 				   int nclocks)
 {
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 7c5e74c7a2e2..23653a942403 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -622,6 +622,17 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 			const struct rockchip_cpuclk_rate_table *rates,
 			int nrates, void __iomem *reg_base, spinlock_t *lock);
 
+struct clk *rockchip_clk_register_cpuclk_multi_pll(const char *name,
+						   const char *const *parent_names,
+						   u8 num_parents, void __iomem *base,
+						   int muxdiv_offset, u8 mux_shift,
+						   u8 mux_width, u8 mux_flags,
+						   int div_offset, u8 div_shift,
+						   u8 div_width, u8 div_flags,
+						   unsigned long flags, spinlock_t *lock,
+						   const struct rockchip_cpuclk_rate_table *rates,
+						   int nrates);
+
 struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg,
@@ -1208,6 +1219,10 @@ void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 			const struct rockchip_cpuclk_reg_data *reg_data,
 			const struct rockchip_cpuclk_rate_table *rates,
 			int nrates);
+void rockchip_clk_register_armclk_multi_pll(struct rockchip_clk_provider *ctx,
+					    struct rockchip_clk_branch *list,
+					    const struct rockchip_cpuclk_rate_table *rates,
+					    int nrates);
 void rockchip_clk_protect_critical(const char *const clocks[], int nclocks);
 void rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
 					unsigned int reg, void (*cb)(void));
-- 
2.34.1


