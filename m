Return-Path: <linux-kernel+bounces-748145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80676B13D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1C01617C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414226CE3E;
	Mon, 28 Jul 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/Hu61MM"
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2626B76D;
	Mon, 28 Jul 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712456; cv=none; b=BvtHHyO/E67jr4NO9MDyeZCYBzdLFJh4KSWDV6F/MGmTgfMaH28OthCIJVMd4NY6jcED5kW1fFTlnLnnq8bUxFI5XdDAUauXDREDo12l2njX6sKS1LI1YNkUc9kTfuv9k+MpOo8j9PlZracT46giUXG0sDjqvdddPwZZ74gmB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712456; c=relaxed/simple;
	bh=uvU3LuSqoqO9vOKX5HTH0ipYicugJ67Oj+k5+VRnS3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCo+Ybj0SRRglHGLzxoi/bJE7CGmnq+UytEf6NcEbq3ybzDSxPAay2+m1AgIgAIhVXkunEKMre4EoYqI+c6U2vClsPPxeXRwiVMCbRTIdXxVkfMEexMcU0OQlJ+AH+5RhM61U2QPPqS5dcbSH2SEc//CyTOAVJQDoZgiITF7fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/Hu61MM; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4ab814c4f2dso83011621cf.1;
        Mon, 28 Jul 2025 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712453; x=1754317253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwpHZPpXI0p0rDKtDHDqYa7tblu6wTfxnrUTp9ZaScY=;
        b=k/Hu61MMI9agfrqaSiefVSRV84PtIw6wDjxMRBzKu7lTmozF3TUfUlEUj6/V7v3Bz8
         mH4j0a4m+msOvWvtvz40qWpl6WVl5QLIeWO50Z6ppO0bZjKv7bldySoB7z8zbrI+EfSr
         b5A0cqYTOPe1tbu9F0tFiDxxXWrVgi9bq1UGCZXA8CWKkxkA8wmpgkcf6AoZhh6IMlOJ
         B93kLa3gNgeUcQugOQoQhJNkRp+FSv0U4tdUuxr0ZVKyRDPyubYcmOlIiOoCfgCWq3oQ
         R9ggTfX+ltqd9Z9SsW3CaOGnjfVsltH4d//sjSKiC9N7G4gQqlB7/LWNpXr4PBbb/P6T
         rKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712453; x=1754317253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwpHZPpXI0p0rDKtDHDqYa7tblu6wTfxnrUTp9ZaScY=;
        b=rm1HRBMSIZywuotiaYm1QCB7n9sofbsR3GDLN1TvpliCaLZuI8rAWTqt/vgFnhsU7/
         6Pyd9boeWeu7nhGgbwx5zmJQjhf1+BQpWC9CUVsn1N4CD0Ii3qNpv2GICYpblomdFU38
         Lc9uyWc4F4CLP0zmulb3dAq1mlVt5y7N+Cl7uK1uVS3A/T5czHn5TkY8YaMBtv/zcklk
         wRW+ozUPxjBbmsKSnkQOV1QmCTp4KgOJwVNoNmtvXBWFuo1wShXKDRxkbiLkk0qSb3V9
         nSOnnY08dourq+n3dv+Kki79GDIKj6ZF5cCN5lzfPfJ0JB+9YsdqcuKadN9exhKsug0z
         2ZQA==
X-Forwarded-Encrypted: i=1; AJvYcCVLNOouWXYcQGDVVIwjfDFMlJUIjWZrgPpMU7HMyhSK3arvSuDqiix2wHpfrSl2eV5Hy3KJpP5iGamWoeW6@vger.kernel.org, AJvYcCXWkgd70PIA/2TRGKQr37PM+07gOm7KaZYjydE8L227eabKIuGP03d9tF3VbmLht9hbRKfOzGKVBUd/@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmkPdYRviQjulztNtE/W6gkOCUicBGCj7Mv9qA2TGDfdrV7hG
	0RB4VrZkemXqUawPWzidxL1VqPDEdr+limIZBHD14jQrpPpwlLF4NEGHdZnx2vbCWTiwMw==
X-Gm-Gg: ASbGncuyGYhWsWVmbLpXN5eADRbfrkyDZ9o6j9hSwjIXsj92wTSCEJFvUUu9U5LMpaW
	etd7JHJi+iOtqWThpIjRkMCNCqtt/KnRnCe019tNqkGQeoOk2krZ35Msa2owdN4veoPyb57DPv9
	XiKrU5YHhvin2RcGoiXwSsRJTc0G0vuBYPrHm7IT5So99TtCyF8BDA1nK4URDSsMg1QICxvl1IG
	Rm+uF0ShXGY9kGOr6TSy3FtwyiAv3lpef8XQ3XK9ARF7fEEXPwAvSDuXhoOEQalkdmPPeaYA1mE
	SaMGmfU4l+pdx+wwSJHHc5wZQ+7xW0u7D5qbHwB9F/yFhkmn7g293cchy4vmB4+RW71u4ff6VLu
	uLi/J3yZJ93x+JAdJ+MxsK1ac5TFy/zCP
X-Google-Smtp-Source: AGHT+IGNkNTYdf6BLasYK8+uoS65PqFGHaWC/DpiGuyNp2KNVMbN6+x1bh6pNoVy9S9XOmC8dksPIw==
X-Received: by 2002:a05:6a00:1a8c:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-76332b4ffe8mr20182948b3a.8.1753712440665;
        Mon, 28 Jul 2025 07:20:40 -0700 (PDT)
Received: from localhost ([2408:8256:2284:4127:de49:6dc9:a446:157a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-768faf4bb9asm893691b3a.132.2025.07.28.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:20:40 -0700 (PDT)
From: Troy Mitchell <troymitchell988@gmail.com>
X-Google-Original-From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 28 Jul 2025 22:20:16 +0800
Subject: [PATCH v3 2/2] clk: spacemit: fix sspax_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-k1-clk-i2s-v3-2-5d7579f02227@linux.spacemit.com>
References: <20250728-k1-clk-i2s-v3-0-5d7579f02227@linux.spacemit.com>
In-Reply-To: <20250728-k1-clk-i2s-v3-0-5d7579f02227@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753712415; l=2875;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=uvU3LuSqoqO9vOKX5HTH0ipYicugJ67Oj+k5+VRnS3M=;
 b=RwJKdnLixQKy07JYdGH7iFd0nnjBb6RbhYTaUrhC1Qraje6WyuilaOhHmgkWSnYvZDzbRCoeZ
 d8+uAlhTgKBAJoi9L54Y7Y3XNDmjaIt5i8vUIYspoyyyo0431qObHps
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=

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


