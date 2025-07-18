Return-Path: <linux-kernel+bounces-736153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF75B09974
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACFF7BA650
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2784F17C21C;
	Fri, 18 Jul 2025 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="k48/V8Mg"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17EB10957;
	Fri, 18 Jul 2025 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803757; cv=none; b=m9ZqVNhh1HL/9WZVV1QdBgKtCzJgvGuZ3LlQ0WmC55UtUCFlW4AbJTRl6hcEPpow1aKZcCUG1pOPhrwGptDUEbDvzcj+s7JfS6SOBlVekFPUM81hY/M26bKC9r7thhCqbKUozrWplY+lZljzHwY0X16YTLT0tHYAb4PlFgLxfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803757; c=relaxed/simple;
	bh=JDy3E0JN5dd0GPffhhr1oP/S8lv12yqDSoT6aQ/giFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rMNFnsv/PbmBgNT2MLfuiS1vjy8EnnEbUZZwm5NyBdii3IWLYnO1/naOUDqQexMM8cPX7vYIwFzStxwq7wnTt8molnRPYnCc8h9u5QWeV4mePTWWV8k6Sof5WaH3VRqDgniutnlY0O2MpUB2tCxS2UrWFZ05AHIkfsOGea/qdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=k48/V8Mg; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1752803661;
	bh=a5yImOZoAeaS6+XJ5xIwpdg4W/wLhp09klXCkZwtPr0=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=k48/V8MgwoltW0eWzir0vkM+YDJwDaVu4GogKpCyeW3BQfXKwkmTb75sbxETW93UZ
	 0xgqnqy1l9+alAz5KGxwNFmI8MBs385LQ8X2AQf+5kwSAG1zSPtT0ikdGjAnGn3kTi
	 O1TngdN7fboajiW8qi2NXUiYNoEzgAqYwnCFM0os=
X-QQ-mid: zesmtpgz6t1752803660tf665d0d4
X-QQ-Originating-IP: ZqUfy45mc6463vdx3EyXgdS0UaUDnR53VYqsGdJkz08=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 09:54:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17711268207114143815
EX-QQ-RecipientCnt: 8
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 18 Jul 2025 09:54:05 +0800
Subject: [PATCH] clk: spacemit: fix sspax_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIADypeWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3WxD3eScbN1Mo2LdVBMjc6M0wzRLQ9MkJaCGgqLUtMwKsGHRsbW
 1AFcYTSVcAAAA
X-Change-ID: 20250717-k1-clk-i2s-e4272f1f915b
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752803658; l=4703;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=JDy3E0JN5dd0GPffhhr1oP/S8lv12yqDSoT6aQ/giFw=;
 b=57hwE0m9xhVxAYVNlo2uMrF6ZQTQrOIYUBWdFmqrCj7Tk2Zv37ZJXdCz/Qs+sBskdwnfyUKvS
 mOMVclbTQdwDXD9jzXIOgszOlD/o3IiIqgEiMjkKKCOh4nNSwlXyRAB
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NQmxuwnI8u+8kOicQpWEbXIHEGQi2z9Jl98+iCu3Mf5TjWCSM2+y+3mJ
	v/zua4m14zkuCCORis8ipEgH/pSLTbGMoN/GuXkQhEz3lgktapXXhfoUQQ6QbfcnDW6zhxG
	O9c0FD15+bOj4NgsPJkWYgI0dB2r/LazemNapMfPbfkkB8uH/N/VT4RafCFLaOu+Z3yWWy9
	wrb+c88e8R++R5UmptxDVubUn15rEcWZp8GuNN/VTIwU4YUUE4k2NtRIJxhy1V3Sib+tJE4
	YYiOu70n4+90k3fr4evIm84w4kkYa0uAY5hrTdwEoe/4vGCBkkCR27D8F1qBVIL9GW17b2C
	TOEXsm+UB9LUzh2m1yH9HfmAp+DUCHgm9Nt2+kMPGtTPgtSdf+oLqWrXLdtGuez3W8RgdJG
	4lm/BJ3aVm3i1KnuSIVcHX56n+YVNpYRdaBDNow0dr2xwPn1RFb9J6yWJrxKWUVN2wtkuHn
	nwVjcYEdysEHk02EYiUek/kWImMNbJCahzc03WpMDRIWiw+kX6q+YKwyAlgKA4jodYFhowp
	zP7cNwpJW8QfOwtGQYG6a5Zjqoir/KAUjBP5+7GHQxgl5Pw2rjKeQfv6SMcw98u96ZyT/Qw
	7x4ZhnVj4Sg7ZK5bxK2K2cj3B1993Nx5Mb+o3IyvUQ/yw2mM1vRe36rWXOj+u8Ql+NsFyHv
	aAj06nG6sJrVA2JD12iD+wxpZUq4uiM2M6MOonW3mfgNj0Gbdd2EYPuRewGqrCMxvr4BGjR
	Al/96h4gQrTp3dThPY3bOLf5m3y6pofZdUFS/p9ZUm6BajRbWPVrUyyAqrYQTQ/xv91DK8n
	Wg/cwjdMdffULyp+u7B/PFO+A7Mq9/dOHEX9C0IguXPqJ21AAxFAwcgqJIzhTnl+E5WFpui
	2tyXDf1eKjRdVS5VM5CKFPFsgOjjHl0G8cJ/2Pf8YacGUthAuC0TmrpWn4VTt7tS2fDLfdr
	6/bMUllJuaNxkB/CgXXC9qgrnJqIhYhPtdKx7Lw2XeXpTcEQEVQW6Q9/ax8gTtIEP7Ueeki
	T5ANGZ7ha67uUVqKFcUgBOjo0IkXeALcMIOEbzWRtmA9lFKzU9nMo5dQ2eScfiXbo0bDaKr
	AFVHanKJdOy/vF+u1xZVLqd+fUMXqWBU4NNyFUKqmU/GtCwyDtWtTA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

In the SpacemiT public document, when the FNCLKSEL field of
the APBC_SSPAX_CLK_RST register is 7 (3'b111),
which is a reserved value. And BIT3 of the same register is
a reserved bit.

But the document is wrong, the actual situation is:
when FNCLKSEL is 7 (3'b111), and the purpose of bit 3 is
if to select i2s_bclk as the parent clock.

And only when FNCLKSEL is 7 (3'b111), The bit 3 is not a reserved bit.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c  |  4 ++--
 drivers/clk/spacemit/ccu_mix.c | 29 +++++++++++++++++++++++++++++
 drivers/clk/spacemit/ccu_mix.h | 14 ++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index cdde37a0523537c2f436e481ae8d6ec5a581b87e..0e22f6fb2c45b68ab20a9b1563a1a6dec1a7e16c 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -359,8 +359,8 @@ static const struct clk_parent_data sspa_parents[] = {
 	CCU_PARENT_HW(pll1_d3072_0p8),
 	CCU_PARENT_HW(i2s_bclk),
 };
-CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
-CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_SSPA_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
+CCU_SSPA_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
 CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
 CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
 CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..bfc65fc00df67299523eb5d1d2ed479c61fc6141 100644
--- a/drivers/clk/spacemit/ccu_mix.c
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -191,6 +191,25 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
 	return ccu_mix_trigger_fc(hw);
 }
 
+static int ccu_mux_set_sspa_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_mux_config *mux = &mix->mux;
+	u32 mask, val;
+
+	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+	val = index << mux->shift;
+
+	if (index == 7) {
+		mask |= BIT(3);
+		val |= BIT(3);
+	}
+
+	ccu_update(&mix->common, ctrl, mask, val);
+
+	return ccu_mix_trigger_fc(hw);
+}
+
 const struct clk_ops spacemit_ccu_gate_ops = {
 	.disable	= ccu_gate_disable,
 	.enable		= ccu_gate_enable,
@@ -235,6 +254,16 @@ const struct clk_ops spacemit_ccu_mux_gate_ops = {
 	.set_parent	= ccu_mux_set_parent,
 };
 
+const struct clk_ops spacemit_ccu_sspa_mux_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+
+	.determine_rate = ccu_mix_determine_rate,
+	.get_parent	= ccu_mux_get_parent,
+	.set_parent	= ccu_mux_set_sspa_parent,
+};
+
 const struct clk_ops spacemit_ccu_div_gate_ops = {
 	.disable	= ccu_gate_disable,
 	.enable		= ccu_gate_enable,
diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
index 51d19f5d6aacb7203d1eddf96047cf3174533601..7753446386353bf849787ed4ec7c85c298238ab5 100644
--- a/drivers/clk/spacemit/ccu_mix.h
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -124,6 +124,19 @@ static struct ccu_mix _name = {							\
 	}									\
 }
 
+#define CCU_SSPA_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl,			\
+				     _shift, _width, _mask_gate, _flags)	\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.mux	= CCU_MUX_INIT(_shift, _width),					\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
+				       spacemit_ccu_sspa_mux_gate_ops,		\
+				       _flags),					\
+	}									\
+}
+
 #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
 			    _mask_gate,	_flags)					\
 static struct ccu_mix _name = {							\
@@ -213,6 +226,7 @@ extern const struct clk_ops spacemit_ccu_div_ops;
 extern const struct clk_ops spacemit_ccu_factor_gate_ops;
 extern const struct clk_ops spacemit_ccu_div_gate_ops;
 extern const struct clk_ops spacemit_ccu_mux_gate_ops;
+extern const struct clk_ops spacemit_ccu_sspa_mux_gate_ops;
 extern const struct clk_ops spacemit_ccu_mux_div_ops;
 extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
 #endif /* _CCU_DIV_H_ */

---
base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
change-id: 20250717-k1-clk-i2s-e4272f1f915b

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


