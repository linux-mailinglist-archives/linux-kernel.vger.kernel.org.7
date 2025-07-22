Return-Path: <linux-kernel+bounces-740392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28EB0D3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AC4167DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265C2E49A7;
	Tue, 22 Jul 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Bhjer5d0"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6ED2E425A;
	Tue, 22 Jul 2025 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169853; cv=none; b=LJGhu2Dub1ATjmMIABnotWJKM3VKxpKm3hOwCGZ+qDGflvEoZpea+Q/aCBc0kY7/Fst0J64dvoBiCiHOUE7JQTtHld2+ro49KVNNiDCtBPyAfTjtXwyRRAHhCwjHDWI2nCk/SsRw2C/FuRxkfjZ21JUpNwC9fGST8vTLNCaaQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169853; c=relaxed/simple;
	bh=mh8kXUN6Mr5mFWd7+ckjj2inOSEDYAbx/F4sl0Cobz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJcPU3OHjc5td2Y0hMD7L0N8vqhe8qgyjqg2RpO233OHu/0JGaaMW1m1ah64QDrUBrt70dRSvm9itBt0p7hQGR+xw/NGET6Hf+78ZbMVctEAADwk9S9f0X1/Ta7ZYml1DlqLJZ+Zjp1tISxXAH12DYh/Ck2SoeuOq2tSStpTPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Bhjer5d0; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753169832;
	bh=U/IeCJBKYW1Wm6ZiUsTtlOZr4Se61tE+GVaKJQJHMuQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=Bhjer5d0vRwbYbMLbKlu6skkvcoD/CKZ5NLo+6T50OuzUc+PBqOQxlZy74hbjqiOK
	 F+uATijYSz6lbi6sWFPHtNGC3S/iD9wqVn0tfXwhz23W+9nv26olvF8gnMcU1+mzb7
	 DC+c2gNqblEHp7OfKfZAKqwlw54+tHAIZBJLZmac=
X-QQ-mid: esmtpsz18t1753169826taac6f3b8
X-QQ-Originating-IP: oZcVhibqva3zbqveutq/trZ1Ic0hqyjny9OSGk6T3xE=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:37:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8049329439976532994
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 22 Jul 2025 15:36:30 +0800
Subject: [PATCH v2 1/2] clk: spacemit: fix sspax_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-k1-clk-i2s-v2-1-2f8edfe3dab4@linux.spacemit.com>
References: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
In-Reply-To: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753169819; l=2972;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=mh8kXUN6Mr5mFWd7+ckjj2inOSEDYAbx/F4sl0Cobz4=;
 b=u3k9A0c5VudprDeGutHEbdky0Y1M0CkiBqO+KAIgTgZH/3pBaY0jP3qOQgvzqzv9cpVobH3sC
 FED+3WKOFBEBPu0fEgUkt3v4gDSNYkvkmjEe/BxXSmC82H1esdyBHUv
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N5d6a+Duil0ycZN1uFmASCLmKDVeL4kz8M2wrxvmsaDgzwui5jgfCSxt
	2NXNG1PavfPc3+/Sqt3vpbncvHK+laJ6Plmxzsg8I8X+OHG4FsexnQ0aOXOY4uD+Qd4TRSu
	CZceY4T8XeIuMZtp8O/yhNDd8PaKQoNC7YhfoAYLbvzQ98rB5/C4mx2oY43ZSASGuZSBLoP
	RB06ZF6fk8WeBo6pEzBr9FRiXyWoEKq5zLAwbdEkM23GrzqAfSBWMX+lp31RSVIxz5PNpEc
	ff5YpoAi+Rhmsuqu4nPh4g6/jCD0Bmw3Wa/g9eoV7zzmR0KjJimmz/tG0sCmo4UondBaihk
	P4lqmKHu7eB+ZSGD9i68WiViB65zZDflh58tgN0x+Omtj4IuvH4sQT6pxeKnsP58AZn2yKu
	d0gOzXVH4AGNliNDn1dgnQ2POGKLMeE8MUhcT9KPewagnEmCVOVTb2khnX0iEDpOUJzM2SX
	nhBivfYGLgqxrZOBZDcdrvVv4x+/2D8QtqVAg7qcKgI8a2ZkAj1xjfETe03sqCPC25YqSm4
	KfyhrfOEKVQEVcroZnR05bnUIWrMSt2D2mqhHuz9Rm/RCv4dU+J6dTrMDl1jUEoAzDsHbse
	u+uI478YKzVy5jksPeLrzzEmBYWvvoNe43ZmBVB8UNKZ1jC5h9FMG0LvqKhe9XHMwKBx98D
	loXU4NWO3/RVpNSzaMAK+blpCBMGzv8LX/1i5HQeHYcWE1DDbFYAWOeVfrYKnhxF06EF2/9
	hyH/NwfoHUDSeqffAjff/bjaKJ3n5NaxfAZq9KQSMezz0IFDBy87NBe/GJR3QJPklidbxjY
	4VxKOgstPapM3+fuKG5BAbKB64/s9Q6XJIaNZ2LUAkmeljTdijct6IywHs0VjH92tIS1sbW
	dg54/0xdLXTkDREP5au8N0+ZodT44muKTXXYd9gP9FLZKeghUUvc4gqGNQjdvkUTtJtaZ5s
	4t5pEZ9sD4r3aL2LzDY59RuyxIEb20HuJcPBDKzAIxzkgiXJn363dt1p4rxsi1zWWsfYGj1
	dEjCAHEZhzcZHjtjujLI+w46rqBHHd51gbJf51jZuTfFFFNCO/XYLev9gpTo+nq31cLfmjx
	g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hardware Requirement:
When FNCLKSEL in APBC_SSPAX_CLK_RST is set to 7 (3'b111),
BIT3 must be set to 1 for the SSPAx parent clock to be I2S_BCLK.

This patch introduces SSPAx_I2S_BCLK as a dummy gate to enable BIT3.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Suggested-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/spacemit/ccu-k1.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index cdde37a0523537c2f436e481ae8d6ec5a581b87e..3b1a861729c6e7ef64bd42b975688058610d8c1c 100644
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
@@ -909,6 +924,8 @@ static struct clk_hw *k1_ccu_apbc_hws[] = {
 	[CLK_TIMERS2]		= &timers2_clk.common.hw,
 	[CLK_AIB]		= &aib_clk.common.hw,
 	[CLK_ONEWIRE]		= &onewire_clk.common.hw,
+	[CLK_SSPA0_I2S_BCLK]	= &sspa0_i2s_bclk.common.hw,
+	[CLK_SSPA1_I2S_BCLK]	= &sspa1_i2s_bclk.common.hw,
 	[CLK_SSPA0]		= &sspa0_clk.common.hw,
 	[CLK_SSPA1]		= &sspa1_clk.common.hw,
 	[CLK_DRO]		= &dro_clk.common.hw,

-- 
2.50.1


