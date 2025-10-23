Return-Path: <linux-kernel+bounces-867787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5446C037F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8187B4E8448
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7C2C15AE;
	Thu, 23 Oct 2025 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlcTtOgf"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93566286D5D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253682; cv=none; b=rfBKdnxVrJXJ25LQzYMvdpsiB/hXGI2YKIgv+aTezUMp01PAYJ5xHnWCcUnwbOayU2o4xPTzLyxp5caSHMWRbsHTLzacqtm0OmrXwZADWUTk+y1gb51vonQ2DmYKKj7Y5as65DoY877e1n3kVuk37NoDckzZZ+Tq2gXLmfz9aEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253682; c=relaxed/simple;
	bh=fcyAIRG+dgZ03Oba/2dpM7V9lNNGOfWjo3IjttQjkpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=der17xkY62QJTAOBwu4EgRj7jfM3VIIgdggZgWLN+F5pUaLPQpR8FF3UTZSCUz5jJ+ICTBYMH1UOTiVTWyJ6XwJelgp5PFfdq/ubxpTfGQGAmusR+LU5b6wm0jDfR0+W8+B3fghZvHtusE8bpe3ku065FzIfe36XgS+XMJnbWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlcTtOgf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1387952b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253679; x=1761858479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzpeIbw6BSNHhoq4s0zh4pWGEO2OMapZHrQAySwDiLA=;
        b=TlcTtOgfnQuyqq6skO/2IHU4wwL6thzTxuvGMsILOxm36+y95LL5nBQtxGsxx2ChCR
         bUpL2sGmJvwOeFz7ll5Ehbs+0kRSbLJviqYlQRh83ZjfWw63t7P8T9NJyHwBlfauMq3u
         ZIWv3bCdX4GDJfadpDUvxvxLKlKddyPsbLhDJU5p8uqXXoEMAERSjrGa6p5K09vp8gUf
         TfGYJb7o2Sa9f48l80BDE/6n0jGbCsY8JQ/A1iu7//Fw1xVaGDVEqvM+iSWviFKgwJE6
         bZ4fJp74b70/cbO1SkKcDgqIew8bPH8c/PUEiqZ2mn3UI9gOvpBZhp96isqSBIMsfh3U
         pvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253679; x=1761858479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzpeIbw6BSNHhoq4s0zh4pWGEO2OMapZHrQAySwDiLA=;
        b=bjyUb5VyN6Pg4Dnq4/jg4LyM+xWo+MTDKJkaMJ09Dol5LCd/oDQpzsZfAu0UuSI+Hf
         bF26sLrzQU+0gLKhqjvcMewSq7H3fhbiOxQC5QV9gxxnIMxmV53QvfEtYv7GgooHko+5
         sfTSTFjEfynXrpyWnBwrV7gUyLdzFYQcLBQvGtofhd0JFLWH6z1+LmOn7SMsqHfnw2zR
         d2JX090decm99SwbkaWI2Altbw1sCcF3VF6kHLLcQ5KgEriFFzlufxZUfIb69/hvXRbK
         bHD/YEwrEvomqVpZxaDHQcVumO5BPS79sh0bPpfBIq5jFY0vw+/zLHaMg3jQuzAh5XYX
         NWcA==
X-Forwarded-Encrypted: i=1; AJvYcCV1CUUB9x3XZpyl3+9eZ69WlmzuMjvTSlrfkfowfE/QMyaorH8jCTZuc/MVSPRvquuyPqZm7rslT4ioXSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygjSx9Py2A6Rj7fO2YDtPJu7FwklClYTySwZ+SB8plIk8bNhHq
	ANhjewqEZCjrkTzbqWThPpsp7aDnUvSjuB2MYeAuKPNFVB/f5cmLwMcw
X-Gm-Gg: ASbGncsDA7+XY430nSh6oFW3FZSMu4Jd1dtsCsT3cJKlJsW5j9aSpJy3OIde3yxHlms
	S0BNDluOuzMlBJUwX2klvctAi0rXHhdQfsC8pywab2/cazXp2Nbc7qFGacWeY/HRZLT81e4liug
	1ZX9AKNTE8SPbWRQD4AJ2jQOgEsRRBKNms0dcSWTT0LhFspaeDBFrMCNrInlLOfJA3ezFJR/RSN
	L1jI8qG/WnuekphV0TX2zE1sZpLHWVWJENF2D50FQ9lhvZ+1hrnRZ5SZYcAKpb4qlu07KYkGf1r
	P4p5dmhUZY3YIK1cDTjxT0pXg4I9pv0lqhlgHUaXd9yOe0OWM68CT6/lCMJmbq8p6u3vfG5BiG/
	3k8PhWvHO/fWDfDX+g4lZ4jlXI8ba3RvfUV1Vzpp2Va7Yi9/5bz+1d60yb5OOtr4K5uRiw0PttW
	ZlTXzLOCFEEMgxAgSaMYQ=
X-Google-Smtp-Source: AGHT+IGw5U9qHAm+G9+MHF38/9bWKPFLlpYC8MlAMkWqeOESX1Tzbl/n7rOnG89OOjPz5VAdF2WApg==
X-Received: by 2002:a05:6a21:32a4:b0:263:4717:559 with SMTP id adf61e73a8af0-33db40e0684mr365224637.20.1761253678756;
        Thu, 23 Oct 2025 14:07:58 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb2fcasm3461246b3a.58.2025.10.23.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:07:57 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/3] clk: renesas: r9a09g056: Add clock and reset entries for ISP
Date: Thu, 23 Oct 2025 22:07:24 +0100
Message-ID: <20251023210724.666476-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023210724.666476-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251023210724.666476-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add entries detailing the clocks and resets for the ISP in the
RZ/V2N SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index 9c536f7706ff..e4a6dfd2bec9 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -53,6 +53,7 @@ enum clk_ids {
 	CLK_PLLDTY_DIV16,
 	CLK_PLLVDO_CRU0,
 	CLK_PLLVDO_CRU1,
+	CLK_PLLVDO_ISP,
 	CLK_PLLETH_DIV_250_FIX,
 	CLK_PLLETH_DIV_125_FIX,
 	CLK_CSDIV_PLLETH_GBE0,
@@ -186,6 +187,7 @@ static const struct cpg_core_clk r9a09g056_core_clks[] __initconst = {
 
 	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dtable_2_4),
 	DEF_DDIV(".pllvdo_cru1", CLK_PLLVDO_CRU1, CLK_PLLVDO, CDDIV4_DIVCTL0, dtable_2_4),
+	DEF_DDIV(".pllvdo_isp",  CLK_PLLVDO_ISP,  CLK_PLLVDO, CDDIV2_DIVCTL3, dtable_2_64),
 
 	DEF_FIXED(".plleth_250_fix", CLK_PLLETH_DIV_250_FIX, CLK_PLLETH, 1, 4),
 	DEF_FIXED(".plleth_125_fix", CLK_PLLETH_DIV_125_FIX, CLK_PLLETH_DIV_250_FIX, 1, 2),
@@ -359,6 +361,14 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 						BUS_MSTOP(9, BIT(5))),
 	DEF_MOD("cru_1_pclk",			CLK_PLLDTY_DIV16, 13, 7, 6, 23,
 						BUS_MSTOP(9, BIT(5))),
+	DEF_MOD("isp_0_reg_aclk",		CLK_PLLDTY_ACPU_DIV2, 14, 2, 7, 2,
+						BUS_MSTOP(9, BIT(8))),
+	DEF_MOD("isp_0_pclk",			CLK_PLLDTY_DIV16, 14, 3, 7, 3,
+						BUS_MSTOP(9, BIT(8))),
+	DEF_MOD("isp_0_vin_aclk",		CLK_PLLDTY_ACPU_DIV2, 14, 4, 7, 4,
+						BUS_MSTOP(9, BIT(9))),
+	DEF_MOD("isp_0_isp_sclk",		CLK_PLLVDO_ISP, 14, 5, 7, 5,
+						BUS_MSTOP(9, BIT(9))),
 	DEF_MOD("dsi_0_pclk",			CLK_PLLDTY_DIV16, 14, 8, 7, 8,
 						BUS_MSTOP(9, BIT(14) | BIT(15))),
 	DEF_MOD("dsi_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 14, 9, 7, 9,
@@ -427,6 +437,10 @@ static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(12, 8, 5, 25),		/* CRU_1_PRESETN */
 	DEF_RST(12, 9, 5, 26),		/* CRU_1_ARESETN */
 	DEF_RST(12, 10, 5, 27),		/* CRU_1_S_RESETN */
+	DEF_RST(13, 1, 6, 2),		/* ISP_0_VIN_ARESETN */
+	DEF_RST(13, 2, 6, 3),		/* ISP_0_REG_ARESETN */
+	DEF_RST(13, 3, 6, 4),		/* ISP_0_ISP_SRESETN */
+	DEF_RST(13, 4, 6, 5),		/* ISP_0_PRESETN */
 	DEF_RST(13, 7, 6, 8),		/* DSI_0_PRESETN */
 	DEF_RST(13, 8, 6, 9),		/* DSI_0_ARESETN */
 	DEF_RST(13, 12, 6, 13),		/* LCDC_0_RESET_N */
-- 
2.43.0


