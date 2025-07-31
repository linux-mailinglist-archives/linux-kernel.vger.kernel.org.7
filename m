Return-Path: <linux-kernel+bounces-752250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A1EB172FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0B31AA8818
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A32D29CD;
	Thu, 31 Jul 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SSCotUKJ"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B412B2D322F;
	Thu, 31 Jul 2025 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971295; cv=none; b=U6utcqL8UwUyFLdG7CI3UnQCetMqdrfzMKk1tiC/XlEgFyARR4JCIlYf28f44y5b6nOxvpfTY+16tYBWOQobQBwKrXZu1M4BmUhdnMRjuQ4N0PRAJW9B3Y0nlxyjm1FwHmcKCpxhTKXKTe/b+il/9wnIBILyM6u1shMfA9pJisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971295; c=relaxed/simple;
	bh=uvU3LuSqoqO9vOKX5HTH0ipYicugJ67Oj+k5+VRnS3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsAiNM39M3+lQcD5ZknI8H2xFzxRBmkbguViQhiqa697LXjc0U3e7cHK1kFQMrl/fxDAB4ypQALWL0EJ+XItoKVZH4Xy/KPj0VHusheRi2n6+Jq9jnOP9SjL2cIOqHvpUSJxqa3E98b+Kln5W6TfSf+ZjzKyk2t3ehzXty6o6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SSCotUKJ; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753971268;
	bh=kwpHZPpXI0p0rDKtDHDqYa7tblu6wTfxnrUTp9ZaScY=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=SSCotUKJLPPva8adFBu0Z5rD2glTvDyv0Yjt8+dI5hk7yeOJAuPk3qH9zRQWUSDLa
	 8AI0XZhTYUA17UVd3afU/tr/AXkhpCsamuIOIZDSFNSMbY963Y0yW+SM1RBsB6RREJ
	 r29036m5DxO4b2Ui0/1AkapEwBT/CXPGWhHbBnh8=
X-QQ-mid: zesmtpip2t1753971263tce60f3fd
X-QQ-Originating-IP: gnNPd1aSkP2AdkgB8BLPeffI5/XcgeNT52Y3+ZsaTQ8=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 31 Jul 2025 22:14:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9338058772431844133
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 31 Jul 2025 22:14:07 +0800
Subject: [PATCH RESEND v3 2/2] clk: spacemit: fix sspax_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-k1-clk-i2s-v3-2-2f655ddb0c6f@linux.spacemit.com>
References: <20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com>
In-Reply-To: <20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753971252; l=2875;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=uvU3LuSqoqO9vOKX5HTH0ipYicugJ67Oj+k5+VRnS3M=;
 b=Hs6I00fFkfEOYEfv/6jaE3m7Rz5lshC/OlJ0gChrnQaIqc3WnAp49ascaBRDqReYBhqqqx7nO
 qOW46P5t3BbDHV/QbytBEZAkcd7U4/2bwss/iRzYr7bGKtOcc4amtuM
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MfF/DIeB9vRmdHzQ/l2xx0UHz/aWNPR3UrF4ohieCVJ8DUSjwE8QQxYm
	7/h1i96kgy1EA42Vp4yxnQhsdP3tUT5sknmrYYcL7Y4Z002QJf1AKRjDDM2gXxq9xpuSP2M
	Zme9uMlu9KBcJ7v/bF8cOD61asf5J5rEvjsFqiHX/PeU6xneTQcfoI3pM83wRENnn4x7XX4
	8XjfcGra2la/7eDoloIi8TnjkhHpNdBNgaRMByFEIPLwnbQaqoPABYofNjdlUcqstPmJJNE
	rwTTLWY9HM5ZhUP//TbsY+f7F8hSxm0MVLrxHnR13hEBjiUVAsjCJqxwlCivs0UOhtkZ7T5
	/NENdqaNUkKt8vY/n8GexmY4caaOF1079YXIQFdzQZeHqY+E6tQ3QA3Y8aaZHX07ASNjdrf
	Hzx4ZEINw9UTbpulgiyQpSatB3Jf+3fUk4BhVXSSecYqV+0ITYTG2z+YlIMrnc76EW9tWhe
	QO14HFSl62yrSoSgurL6fhSPm4qfrQkhzPC16Sh4KNirfZTGGRZaAhulFep1ABMUpUCsUMA
	Bl22ZWshCSGDtnp7BAjaydQUg9uA2VyP4KiZuKlOry89tkfwlZNFQhElhKBzkAzG+R5r1hb
	g6OuttsL27dvMyliRB2WOt/iot/jk3XDMHC40U1dqVQyW7fcF+TDOHVTX4qAxovD/omSqmE
	iZ5K2o6G6/YlMxN5CxUNwdCEwQgQDrMIhlT12pZPvIOokl80udf4vU9kL48E8jREDctI/zq
	kJKNCtXf5hbz1RorStMTFaF3lNA2dMi95glchFVO4er8StSrEXbJRfD1yUP1z7pNMy2Zz0u
	KayuYWPXC8u0nNLktNQJyXlK1vGXukagC43l/Zpjjv6zhADYm5xeyjmXnq9EP0SF7iI+l9Q
	J3wadkNQrhGOW39RYUDYHQ24clASM+awjE/3NMkp71tkiMI4E7BA8UglKjWhrFUIvd3GZeB
	pyuuC/gMlMoYZNYMbYHAMcorvOQY4GzErfnHw5p3eTKHzx8PWQrvn/XyodgOusDpq9hFmZx
	bpRQ1cTXxatRDcSY8Lw6NE0T2LiA0g1zewDZS9UNSQ1orMHt7mys402+pKRI6G6HHGlmzrf
	v4QRVBmFwotVp3JURZwJcH+l5cCNvTfOPA/StOS9ok3KsyM8hhKZ8FrsjZ4M6AQKFAliTHH
	LeCc
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hardware Requirement:
When FNCLKSEL in APBC_SSPAX_CLK_RST is set to 7 (3'b111),
BIT3 must be set to 1 for the SSPAx parent clock to be I2S_BCLK.

This patch introduces SSPAx_I2S_BCLK as a virtual gate to enable BIT3.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Suggested-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/spacemit/ccu-k1.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index cdde37a0523537c2f436e481ae8d6ec5a581b87e..24a561499a7c11b6a661c026f0bd2fac28fe7b04 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -349,7 +349,10 @@ CCU_GATE_DEFINE(aib_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_AIB_CLK_RST, BIT(1),
 
 CCU_GATE_DEFINE(onewire_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_ONEWIRE_CLK_RST, BIT(1), 0);
 
-static const struct clk_parent_data sspa_parents[] = {
+CCU_GATE_DEFINE(sspa0_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA0_CLK_RST, BIT(3), 0);
+CCU_GATE_DEFINE(sspa1_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA1_CLK_RST, BIT(3), 0);
+
+static const struct clk_parent_data sspa0_parents[] = {
 	CCU_PARENT_HW(pll1_d384_6p4),
 	CCU_PARENT_HW(pll1_d192_12p8),
 	CCU_PARENT_HW(pll1_d96_25p6),
@@ -357,10 +360,22 @@ static const struct clk_parent_data sspa_parents[] = {
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
@@ -965,6 +980,8 @@ static struct clk_hw *k1_ccu_apbc_hws[] = {
 	[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
 	[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
 	[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
+	[CLK_SSPA0_I2S_BCLK]	= &sspa0_i2s_bclk.common.hw,
+	[CLK_SSPA1_I2S_BCLK]	= &sspa1_i2s_bclk.common.hw,
 };
 
 static const struct spacemit_ccu_data k1_ccu_apbc_data = {

-- 
2.50.0


