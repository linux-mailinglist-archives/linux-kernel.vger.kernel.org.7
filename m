Return-Path: <linux-kernel+bounces-794385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262E6B3E0F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805BD16A5F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8A31062C;
	Mon,  1 Sep 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD+5LdoM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D6311C2E;
	Mon,  1 Sep 2025 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724727; cv=none; b=FzAKvLkqvxN7WsKHCLxUn5YY27Giu+gCPv4xF5zLc8YK5Uj5OoZAskNijoXYOmA379twANR4MY3psrJidXA8Ti1EIEP6KCeNizi0+QH7B7TRghRuFRWkIQ1ZvvD7YmXGizp7ZHiO+9SWbPyUVdAQInIX/Gk1bVhpq2p7IpTomVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724727; c=relaxed/simple;
	bh=hltaoT0wHq0zJriPTv7PTiClhkzuYwM2fBILZAlFmOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfjyrMCX0hahajnkLskMH1hEsIdsodPRO461FzHwhSaQNLanyV+qJD24E4ZLdvFGznT2RPDp/MrNDIoqgqIONjVtekl0sSisKUdxZa30NOaNDihNlZaO0HP04tgI+N6piNSpv2hXBP1iREEnA49R8QgaNkPW4Tn97s+lc0Y5B2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD+5LdoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9C9C4CEF0;
	Mon,  1 Sep 2025 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724727;
	bh=hltaoT0wHq0zJriPTv7PTiClhkzuYwM2fBILZAlFmOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aD+5LdoM1vve65IH5c/dywswPevCwan9JhyDcWvUx3TWvN1j4Ntwx6hYSgTnhhdaG
	 NXfvLvDEWpD2i4w/NMK0y66V+xMpQRxSpEL4MJ43Ey1efPlSxc5Wv1V5Kou+ugVVzE
	 t23FZvWtGoIqNI27bVUyxd1q6XPmggRPuX1dHLzDDIyJzwAb5CeZvs7G5HPay8oLeI
	 j/MyATL5RR5RHJlZZ2kpTW0FWFTWqcezvQfc9QUfy02bwgxoPFONyGr+paazcncUdc
	 T8iDRtCdSQIuR2Z2/p504UOgANVr/PK8A5pJe52Cg3K6AtzRD0ZntPgl7nHSyoX9s3
	 Tv9aP9KnsqP6Q==
From: Conor Dooley <conor@kernel.org>
To: sboyd@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
Subject: [PATCH v4 8/9] clk: divider, gate: create regmap-backed copies of gate and divider clocks
Date: Mon,  1 Sep 2025 12:04:20 +0100
Message-ID: <20250901-yearling-reconcile-99d06fe7868e@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901-rigid-sacrifice-0039c6e6234e@spud>
References: <20250901-rigid-sacrifice-0039c6e6234e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22552; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jp0d/OaS25+xc66p1eI+T/kHwdJaF8ouagpJQ63N2gs=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlba9cxGHdVqWu3OTiqR36U91se4vq7J+ZUxfW/F3zE2 ZI6xO93lLIwiHExyIopsiTe7muRWv/HZYdzz1uYOaxMYEO4OAVgIku+M/yvdauW9a7+EiAk9P3u dEavZlmTvT4R62M/2Z+vOxgT/+gII8O+6X95RTKPl66bo9j5WcOkzZ3XZseXnEY3/xgzqZXH+Fg A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Implement regmap-backed copies of gate and divider clocks by replacing
the iomem pointer to the clock registers with a regmap and offset
within.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v4:
- increase map_offset to a u32
- use a single Kconfig option for both divider and gate regmap
  implementations
---
 drivers/clk/Kconfig              |   4 +
 drivers/clk/Makefile             |   2 +
 drivers/clk/clk-divider-regmap.c | 271 +++++++++++++++++++++++++++++++
 drivers/clk/clk-gate-regmap.c    | 254 +++++++++++++++++++++++++++++
 include/linux/clk-provider.h     | 119 ++++++++++++++
 5 files changed, 650 insertions(+)
 create mode 100644 drivers/clk/clk-divider-regmap.c
 create mode 100644 drivers/clk/clk-gate-regmap.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc1..3490b6fe6b9b2 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -33,6 +33,10 @@ menuconfig COMMON_CLK
 
 if COMMON_CLK
 
+config COMMON_CLK_REGMAP
+	bool
+	select REGMAP
+
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 18ed29cfdc113..b93b9e3e5fc07 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -21,11 +21,13 @@ clk-test-y			:= clk_test.o \
 				   kunit_clk_hw_get_dev_of_node.dtbo.o \
 				   kunit_clk_parent_data_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
+obj-$(CONFIG_COMMON_CLK_REGMAP)	+= clk-divider-regmap.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
 obj-$(CONFIG_CLK_FIXED_RATE_KUNIT_TEST)	+= clk-fixed-rate-test.o
 clk-fixed-rate-test-y		:= clk-fixed-rate_test.o kunit_clk_fixed_rate_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
+obj-$(CONFIG_COMMON_CLK_REGMAP)	+= clk-gate-regmap.o
 obj-$(CONFIG_CLK_GATE_KUNIT_TEST) += clk-gate_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
diff --git a/drivers/clk/clk-divider-regmap.c b/drivers/clk/clk-divider-regmap.c
new file mode 100644
index 0000000000000..e2f9489ad9ef9
--- /dev/null
+++ b/drivers/clk/clk-divider-regmap.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+
+static inline u32 clk_div_regmap_readl(struct clk_divider_regmap *divider)
+{
+	u32 val;
+
+	regmap_read(divider->regmap, divider->map_offset, &val);
+
+	return val;
+}
+
+static inline void clk_div_regmap_writel(struct clk_divider_regmap *divider, u32 val)
+{
+	regmap_write(divider->regmap, divider->map_offset, val);
+
+}
+
+static unsigned long clk_divider_regmap_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+	unsigned int val;
+
+	val = clk_div_regmap_readl(divider) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
+static long clk_divider_regmap_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val = clk_div_regmap_readl(divider) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+
+		return divider_ro_round_rate(hw, rate, prate, divider->table,
+					     divider->width, divider->flags,
+					     val);
+	}
+
+	return divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+}
+
+static int clk_divider_regmap_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val = clk_div_regmap_readl(divider) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+
+		return divider_ro_determine_rate(hw, req, divider->table,
+						 divider->width,
+						 divider->flags, val);
+	}
+
+	return divider_determine_rate(hw, req, divider->table, divider->width,
+				      divider->flags);
+}
+
+static int clk_divider_regmap_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_divider_regmap *divider = to_clk_divider_regmap(hw);
+	int value;
+	unsigned long flags = 0;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+		val = clk_div_mask(divider->width) << (divider->shift + 16);
+	} else {
+		val = clk_div_regmap_readl(divider);
+		val &= ~(clk_div_mask(divider->width) << divider->shift);
+	}
+	val |= (u32)value << divider->shift;
+	clk_div_regmap_writel(divider, val);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+const struct clk_ops clk_divider_regmap_ops = {
+	.recalc_rate = clk_divider_regmap_recalc_rate,
+	.round_rate = clk_divider_regmap_round_rate,
+	.determine_rate = clk_divider_regmap_determine_rate,
+	.set_rate = clk_divider_regmap_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_divider_regmap_ops);
+
+const struct clk_ops clk_divider_regmap_ro_ops = {
+	.recalc_rate = clk_divider_regmap_recalc_rate,
+	.round_rate = clk_divider_regmap_round_rate,
+	.determine_rate = clk_divider_regmap_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_divider_regmap_ro_ops);
+
+struct clk_hw *__clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u32 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	struct clk_divider_regmap *div;
+	struct clk_hw *hw;
+	struct clk_init_data init = {};
+	int ret;
+
+	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
+		if (width + shift > 16) {
+			pr_warn("divider value exceeds LOWORD field\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
+		init.ops = &clk_divider_regmap_ro_ops;
+	else
+		init.ops = &clk_divider_regmap_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.parent_data = parent_data;
+	if (parent_name || parent_hw || parent_data)
+		init.num_parents = 1;
+	else
+		init.num_parents = 0;
+
+	/* struct clk_divider assignments */
+	div->regmap = regmap;
+	div->map_offset = map_offset;
+	div->shift = shift;
+	div->width = width;
+	div->flags = clk_divider_flags;
+	div->lock = lock;
+	div->hw.init = &init;
+	div->table = table;
+
+	/* register the clock */
+	hw = &div->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(div);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__clk_hw_register_divider_regmap);
+
+struct clk *clk_register_divider_regmap_table(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	struct clk_hw *hw;
+
+	hw =  __clk_hw_register_divider_regmap(dev, NULL, name, parent_name, NULL,
+					       NULL, flags, regmap, map_offset,
+					       shift, width, clk_divider_flags,
+					       table, lock);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
+EXPORT_SYMBOL_GPL(clk_register_divider_regmap_table);
+
+void clk_unregister_divider_regmap(struct clk *clk)
+{
+	struct clk_divider_regmap *div;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	div = to_clk_divider_regmap(hw);
+
+	clk_unregister(clk);
+	kfree(div);
+}
+EXPORT_SYMBOL_GPL(clk_unregister_divider_regmap);
+
+/**
+ * clk_hw_unregister_divider_regmap - unregister a clk divider
+ * @hw: hardware-specific clock data to unregister
+ */
+void clk_hw_unregister_divider_regmap(struct clk_hw *hw)
+{
+	struct clk_divider_regmap *div;
+
+	div = to_clk_divider_regmap(hw);
+
+	clk_hw_unregister(hw);
+	kfree(div);
+}
+EXPORT_SYMBOL_GPL(clk_hw_unregister_divider_regmap);
+
+static void devm_clk_hw_release_divider_regmap(struct device *dev, void *res)
+{
+	clk_hw_unregister_divider_regmap(*(struct clk_hw **)res);
+}
+
+struct clk_hw *__devm_clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u32 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_divider_regmap, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_divider_regmap(dev, np, name, parent_name, parent_hw,
+					      parent_data, flags, regmap, map_offset,
+					      shift, width, clk_divider_flags, table,
+					      lock);
+
+	if (!IS_ERR(hw)) {
+		*ptr = hw;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__devm_clk_hw_register_divider_regmap);
diff --git a/drivers/clk/clk-gate-regmap.c b/drivers/clk/clk-gate-regmap.c
new file mode 100644
index 0000000000000..54105738909c7
--- /dev/null
+++ b/drivers/clk/clk-gate-regmap.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+/**
+ * DOC: basic gatable clock which can gate and ungate its output
+ *
+ * Traits of this clock:
+ * prepare - clk_(un)prepare only ensures parent is (un)prepared
+ * enable - clk_enable and clk_disable are functional & control gating
+ * rate - inherits rate from parent.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+static inline u32 clk_gate_regmap_readl(struct clk_gate_regmap *gate)
+{
+	u32 val;
+
+	regmap_read(gate->map, gate->map_offset, &val);
+
+	return val;
+}
+
+static inline void clk_gate_regmap_writel(struct clk_gate_regmap *gate, u32 val)
+{
+	regmap_write(gate->map, gate->map_offset, val);
+
+}
+
+/*
+ * It works on following logic:
+ *
+ * For enabling clock, enable = 1
+ *	set2dis = 1	-> clear bit	-> set = 0
+ *	set2dis = 0	-> set bit	-> set = 1
+ *
+ * For disabling clock, enable = 0
+ *	set2dis = 1	-> set bit	-> set = 1
+ *	set2dis = 0	-> clear bit	-> set = 0
+ *
+ * So, result is always: enable xor set2dis.
+ */
+static void clk_gate_regmap_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_gate_regmap *gate = to_clk_gate_regmap(hw);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	unsigned long flags;
+	u32 reg;
+
+	set ^= enable;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+	else
+		__acquire(gate->lock);
+
+	if (gate->flags & CLK_GATE_HIWORD_MASK) {
+		reg = BIT(gate->bit_idx + 16);
+		if (set)
+			reg |= BIT(gate->bit_idx);
+	} else {
+		reg = clk_gate_regmap_readl(gate);
+
+		if (set)
+			reg |= BIT(gate->bit_idx);
+		else
+			reg &= ~BIT(gate->bit_idx);
+	}
+
+	clk_gate_regmap_writel(gate, reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+	else
+		__release(gate->lock);
+}
+
+static int clk_gate_regmap_enable(struct clk_hw *hw)
+{
+	clk_gate_regmap_endisable(hw, 1);
+
+	return 0;
+}
+
+static void clk_gate_regmap_disable(struct clk_hw *hw)
+{
+	clk_gate_regmap_endisable(hw, 0);
+}
+
+int clk_gate_regmap_is_enabled(struct clk_hw *hw)
+{
+	u32 reg;
+	struct clk_gate_regmap *gate = to_clk_gate_regmap(hw);
+
+	reg = clk_gate_regmap_readl(gate);
+
+	/* if a set bit disables this clk, flip it before masking */
+	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= BIT(gate->bit_idx);
+
+	reg &= BIT(gate->bit_idx);
+
+	return reg ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(clk_gate_regmap_is_enabled);
+
+const struct clk_ops clk_gate_regmap_ops = {
+	.enable = clk_gate_regmap_enable,
+	.disable = clk_gate_regmap_disable,
+	.is_enabled = clk_gate_regmap_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_gate_regmap_ops);
+
+struct clk_hw *__clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		struct regmap *map, u32 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_gate_regmap *gate;
+	struct clk_hw *hw;
+	struct clk_init_data init = {};
+	int ret = -EINVAL;
+
+	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
+		if (bit_idx > 15) {
+			pr_err("gate bit exceeds LOWORD field\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/* allocate the gate */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_gate_regmap_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.parent_data = parent_data;
+	if (parent_name || parent_hw || parent_data)
+		init.num_parents = 1;
+	else
+		init.num_parents = 0;
+
+	/* struct clk_gate_regmap assignments */
+	gate->map = map;
+	gate->map_offset = map_offset;
+	gate->bit_idx = bit_idx;
+	gate->flags = clk_gate_flags;
+	gate->lock = lock;
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	if (dev || !np)
+		ret = clk_hw_register(dev, hw);
+	else if (np)
+		ret = of_clk_hw_register(np, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+
+}
+EXPORT_SYMBOL_GPL(__clk_hw_register_gate_regmap);
+
+struct clk *clk_register_gate_regmap(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags, struct regmap *map,
+		u32 map_offset, u8 bit_idx, u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_hw *hw;
+
+	hw = __clk_hw_register_gate_regmap(dev, NULL, name, parent_name, NULL,
+					   NULL, flags, map, map_offset, bit_idx,
+					   clk_gate_flags, lock);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
+EXPORT_SYMBOL_GPL(clk_register_gate_regmap);
+
+void clk_unregister_gate_regmap(struct clk *clk)
+{
+	struct clk_gate_regmap *gate;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	gate = to_clk_gate_regmap(hw);
+
+	clk_unregister(clk);
+	kfree(gate);
+}
+EXPORT_SYMBOL_GPL(clk_unregister_gate_regmap);
+
+void clk_hw_unregister_gate_regmap(struct clk_hw *hw)
+{
+	struct clk_gate_regmap *gate;
+
+	gate = to_clk_gate_regmap(hw);
+
+	clk_hw_unregister(hw);
+	kfree(gate);
+}
+EXPORT_SYMBOL_GPL(clk_hw_unregister_gate_regmap);
+
+static void devm_clk_hw_release_gate_regmap(struct device *dev, void *res)
+{
+	clk_hw_unregister_gate_regmap(*(struct clk_hw **)res);
+}
+
+struct clk_hw *__devm_clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags, struct regmap *map,
+		u32 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_gate_regmap, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_gate_regmap(dev, np, name, parent_name, parent_hw,
+					   parent_data, flags, map, map_offset,
+					   bit_idx, clk_gate_flags, lock);
+
+	if (!IS_ERR(hw)) {
+		*ptr = hw;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__devm_clk_hw_register_gate_regmap);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a471294..0d9ef5c8bf960 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -8,6 +8,7 @@
 
 #include <linux/of.h>
 #include <linux/of_clk.h>
+#include <linux/regmap.h>
 
 /*
  * flags used across common struct clk.  these flags should only affect the
@@ -538,6 +539,37 @@ struct clk_gate {
 #define CLK_GATE_BIG_ENDIAN		BIT(2)
 
 extern const struct clk_ops clk_gate_ops;
+
+#ifdef CONFIG_COMMON_CLK_REGMAP
+/**
+ * struct clk_gate_regmap - gating clock via regmap
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @map:	regmap controlling gate
+ * @map_offset:	register offset within the regmap controlling gate
+ * @bit_idx:	single bit controlling gate
+ * @flags:	hardware-specific flags
+ * @lock:	register lock
+ *
+ * Clock which can gate its output.  Implements .enable & .disable
+ *
+ * Flags:
+ * See clk_gate
+ */
+struct clk_gate_regmap {
+	struct clk_hw hw;
+	struct regmap	*map;
+	u32		map_offset;
+	u8		bit_idx;
+	u8		flags;
+	spinlock_t	*lock;
+};
+
+#define to_clk_gate_regmap(_hw) container_of(_hw, struct clk_gate_regmap, hw)
+
+extern const struct clk_ops clk_gate_regmap_ops;
+#endif
+
 struct clk_hw *__clk_hw_register_gate(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
@@ -663,6 +695,31 @@ void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
 int clk_gate_is_enabled(struct clk_hw *hw);
 
+#ifdef CONFIG_COMMON_CLK_REGMAP
+struct clk_hw *__clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		struct regmap *map, u32 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+struct clk_hw *__devm_clk_hw_register_gate_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		struct regmap *map, u32 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+struct clk *clk_register_gate_regmap(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *map, u32 map_offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+
+void clk_unregister_gate_regmap(struct clk *clk);
+void clk_hw_unregister_gate_regmap(struct clk_hw *hw);
+int clk_gate_regmap_is_enabled(struct clk_hw *hw);
+#endif
+
 struct clk_div_table {
 	unsigned int	val;
 	unsigned int	div;
@@ -736,6 +793,41 @@ struct clk_divider {
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
 
+#ifdef CONFIG_COMMON_CLK_REGMAP
+/**
+ * struct clk_divider_regmap - adjustable divider clock via regmap
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @map:	regmap containing the divider
+ * @map_offset:	register offset within the regmap containing the divider
+ * @shift:	shift to the divider bit field
+ * @width:	width of the divider bit field
+ * @table:	array of value/divider pairs, last entry should have div = 0
+ * @lock:	register lock
+ *
+ * Clock with an adjustable divider affecting its output frequency.  Implements
+ * .recalc_rate, .set_rate and .round_rate
+ *
+ * @flags:
+ * See clk_divider
+ */
+struct clk_divider_regmap {
+	struct clk_hw	hw;
+	struct regmap	*regmap;
+	u32		map_offset;
+	u8		shift;
+	u8		width;
+	u8		flags;
+	const struct clk_div_table	*table;
+	spinlock_t	*lock;
+};
+
+#define to_clk_divider_regmap(_hw) container_of(_hw, struct clk_divider_regmap, hw)
+
+extern const struct clk_ops clk_divider_regmap_ops;
+extern const struct clk_ops clk_divider_regmap_ro_ops;
+#endif
+
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 		unsigned int val, const struct clk_div_table *table,
 		unsigned long flags, unsigned long width);
@@ -972,6 +1064,33 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 void clk_unregister_divider(struct clk *clk);
 void clk_hw_unregister_divider(struct clk_hw *hw);
 
+#ifdef CONFIG_COMMON_CLK_REGMAP
+struct clk_hw *__clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u32 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
+
+struct clk_hw *__devm_clk_hw_register_divider_regmap(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		struct regmap *regmap, u32 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
+
+struct clk *clk_register_divider_regmap_table(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 map_offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
+
+void clk_unregister_divider_regmap(struct clk *clk);
+void clk_hw_unregister_divider_regmap(struct clk_hw *hw);
+#endif
+
 /**
  * struct clk_mux - multiplexer clock
  *
-- 
2.47.2


