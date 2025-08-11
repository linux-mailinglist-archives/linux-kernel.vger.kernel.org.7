Return-Path: <linux-kernel+bounces-762749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5244CB20A90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB4E176634
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38962DEA89;
	Mon, 11 Aug 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="aEvimXYB"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB92DEA65;
	Mon, 11 Aug 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919684; cv=none; b=UvOiOhkPC7gtlCykVffvv6djb0/KWmHg1WmQt0x5Hs7IUU6l47QXTcd+KcOhMQDGkXdRfnDz+7P1Qu5UK3WAd35jiM7JHrCnaytLNoIwnVpXpsnhD6I6s/C9KpV4IuflRzPD48z/QoGvgn60tOrWjOwFdzoYRmxxWu6FreFAKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919684; c=relaxed/simple;
	bh=EwKVSE+xlhWtppMsIC0wFkFKY+Ek8JZOdL9HhV7w8qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GckKHJozwF7prupTMLpDQFG9Kr2AmcAlYfVG75MWQ9RwSSd0v56PfEB0/8QG3/oViXsr8sW29is15wzA5rZYDXPA+ZUIwFTDBuet99iE7X+TWnd+NWMmhPBA3Zyr+4QOeb9K3MexTjmHP2sS0BPChl+Pnyhb8mHCwn1CAD5WfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=aEvimXYB; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754919651;
	bh=+0D/xtSyclY9YeXodV2ESPW/VNymBxUPSTcmaRsZFQk=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=aEvimXYBDVAIGQEN0suPUyWajG4qfbA8gdJE38xMKDyvL4iFKDVLO6tJcNWNl00Nv
	 L6pI44rcHWpjWWhbRqfPqN7+6l7tLb7WJ5KDA79BwqsYsEH7F68lHzcWZLZ6u2MlZg
	 X+QTxn3/7tGfXTdTg1PvzaRh7uDX5eO+m9J6vQ7o=
X-QQ-mid: zesmtpip3t1754919646t750cf849
X-QQ-Originating-IP: 1I4WHGqpVJrS9nwcYnSEwg1mh0FiNErlU+HTTj7t5Cs=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 21:40:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5142891819712798634
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 11 Aug 2025 21:40:34 +0800
Subject: [PATCH v5 2/2] clk: spacemit: fix sspax_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-k1-clk-i2s-v5-2-ebadd06e1e91@linux.spacemit.com>
References: <20250811-k1-clk-i2s-v5-0-ebadd06e1e91@linux.spacemit.com>
In-Reply-To: <20250811-k1-clk-i2s-v5-0-ebadd06e1e91@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yao Zi <ziyao@disroot.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754919637; l=3086;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=EwKVSE+xlhWtppMsIC0wFkFKY+Ek8JZOdL9HhV7w8qQ=;
 b=26/O+mjSBSWiF1/RhGR5NKfnNd1X96Hv85kfc7sUe88X6jtIL1refAZMItUiZxCo6aDVLlSi8
 mDIipJ33GBXBecTM/a5QKi/6ALjLFFRctjm69TMpYQYR2DNm7YZuZgs
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: M3ziZXKDk+iOPR+UgAZS/ckQSVE4v9nl/JPC8zEsfbnTtjMwLHy39RAC
	pVmDjmw8o3e7md3OP8UmTaqQyjofjBJfSiIEUjOtYadf09egDFtQKqT6aDHu1FPskBVZfq7
	RZhX6qZVnJn8lzaFFh2GBICXT6JcdKb/sRZyT7JVYRyUExzybUemcfug3AB9aWlVe0vveoU
	BdaMktQAHEhKQ0TDsokCfE3jNkzbqpx9BU85gU/c8cwX77qp8pGaiBTF5olGnEskwqaoUZk
	cbd4N23qL3ccCt3rwN4bjdXDMRSkFlpRMVoASQuJiBj9mPhp7tQrAttZ2OgoZQinskpVCSc
	RHcwRgTF8VAJDpBF6N0Zd6bO5eEBp27lGG6MxgINondghvF8tkRqsrmWKtZSgsNQMe31js0
	+6bSbSwMrWL38PcJHifjyYFU5hC4y5tXZ9NVN4kv2P7aL53ZNDduOzCmmi8wdhDVEQGhUqY
	zeTN1ua1gdegaEYP/VkM/WrLECpCI5XMU8XATxPkzfi5eBOI7WWPEFRkrRU23/9oUMh+cNr
	5aR8noBFFeQp7DLYQKYjfFM2msxKarhgWdQUBMn2gUYbbkBURC1SAiLPIAqwDnFeCIj2a93
	0sL/iFu2OklYJ+A+oQxnQroTcwyF/nAJtXL/0jcfVj7375z4abcziaZlQqe8kMfblwlMQhh
	qkwR+gsb8k4+q+0VuPwK+7WkbvS2UeyySISRjyvvaoH7UH4iLVGXEOtSsYWM/Z3v0bbrXQu
	WktxgQJ/FefgwprTmrbetEe/6CmU+4RvSG3caAmWPFyenJBzaDcy1y/Onl+SVAExhaEz+aj
	6yZYqX3kh5GJ+2sVsBZoUxfwQ6WYT/9ISY4Mik+TfsAgfpkAYnq4bGvR0BvVoWY2FFKNY7y
	hkDN+EWNxbwyb3bMgEYDS/ChqD48Gm76kyuowrc9NIuHWMcAF5IoLIo1ScaRGjRoz6kG74s
	5Zqi4RmiMel8xqWJJTbtmagAgfsX63pgOzdMcU0o0COeta/H2FRaZp3wAxuhnmLYL7md5bj
	QOOs8UqD5mekwRBNL4DhAGPGC1xcME0p+vef3nO+/e0s7+I/wyMhc8p+irWf08dSfMfdjHc
	g==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hardware Requirement:

BIT[3] of this register must be set if need to select i2s_bclk as
SSPA parent clock, to solve this, introduces a new SSPAx_I2S_BCLK
clock as the virtual gate clock.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Suggested-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Haylen Chu <heylenay@4d2.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717afa60eefab7bda88f9a13b857650..62cdba516a29f960e15e04642470f55e3d85bfad 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -247,7 +247,14 @@ CCU_GATE_DEFINE(aib_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_AIB_CLK_RST, BIT(1),
 
 CCU_GATE_DEFINE(onewire_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_ONEWIRE_CLK_RST, BIT(1), 0);
 
-static const struct clk_parent_data sspa_parents[] = {
+/*
+ * When i2s_bclk is selected as the parent clock of sspa,
+ * the hardware requires bit3 to be set
+ */
+CCU_GATE_DEFINE(sspa0_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA0_CLK_RST, BIT(3), 0);
+CCU_GATE_DEFINE(sspa1_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA1_CLK_RST, BIT(3), 0);
+
+static const struct clk_parent_data sspa0_parents[] = {
 	CCU_PARENT_HW(pll1_d384_6p4),
 	CCU_PARENT_HW(pll1_d192_12p8),
 	CCU_PARENT_HW(pll1_d96_25p6),
@@ -255,10 +262,22 @@ static const struct clk_parent_data sspa_parents[] = {
 	CCU_PARENT_HW(pll1_d768_3p2),
 	CCU_PARENT_HW(pll1_d1536_1p6),
 	CCU_PARENT_HW(pll1_d3072_0p8),
-	CCU_PARENT_HW(i2s_bclk),
+	CCU_PARENT_HW(sspa0_i2s_bclk),
 };
-CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
-CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(sspa0_clk, sspa0_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
+
+static const struct clk_parent_data sspa1_parents[] = {
+	CCU_PARENT_HW(pll1_d384_6p4),
+	CCU_PARENT_HW(pll1_d192_12p8),
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(pll1_d48_51p2),
+	CCU_PARENT_HW(pll1_d768_3p2),
+	CCU_PARENT_HW(pll1_d1536_1p6),
+	CCU_PARENT_HW(pll1_d3072_0p8),
+	CCU_PARENT_HW(sspa1_i2s_bclk),
+};
+CCU_MUX_GATE_DEFINE(sspa1_clk, sspa1_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
+
 CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
 CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
 CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
@@ -865,6 +884,8 @@ static struct clk_hw *k1_ccu_apbc_hws[] = {
 	[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
 	[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
 	[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
+	[CLK_SSPA0_I2S_BCLK]	= &sspa0_i2s_bclk.common.hw,
+	[CLK_SSPA1_I2S_BCLK]	= &sspa1_i2s_bclk.common.hw,
 };
 
 static const struct spacemit_ccu_data k1_ccu_apbc_data = {

-- 
2.50.1


