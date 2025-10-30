Return-Path: <linux-kernel+bounces-878170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D4C1FEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A14EB92E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50631579B;
	Thu, 30 Oct 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+c0wQjG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA472F1FC5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825914; cv=none; b=DPfUSYrgyBxzyV/fiw+rvuwfL4yrwrU3W0ljMLA1rd7rkF6HjNOwbFFni110ISJrrTsSG82IZV+t3PKy2O990NnaFHxePaIQ1vQwYplQo0R4URzgapwrFkOQ+hiy2L1/Q8Veupl6cyS5mSO3OVHFDpZ9rAGeYaF6hRopyEhgm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825914; c=relaxed/simple;
	bh=Nnmy/nhRXy1Jb2EolZDFX082PZeZ22LYX0yNSq8ROCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cu3iCzEL+byHQ4s3OQuSuEYtu/JZI1enNl+wEn8Gb1mbw8916Bma+6Vn6TDXXWAMAVOjHcQf22rGTK+WFQfhp8yTWKkkH9EOfYeDX5VVuAYmoREcSI3WVCUAUSSx4xs7kAabeaDnvkm7QnXOj+BHlOlL8aTGpcom/tQsM0MUMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+c0wQjG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-474975af41dso7193825e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825910; x=1762430710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCpWVCeFoXMs1/EyJIuFGqtdg2vmYZ9/7tM7s70z/qU=;
        b=H+c0wQjGAMRqI3BM58JSCWRYsnmL6RELy9aBlGdO+v9a2eUJku4z08/XkbAGVY26j+
         8JVFUQ7Z9qOncEzCGwXN/tYAv0vhW28YkqFGNBwbqBYmlpo+3UNIxlEFn95diBkGnKfU
         IjmIFasmTsktL++A+MamH8kynWkPEu4Orp6colEwN10japUSkzvYYXyq4WHk1hQABosL
         4ZU7dgNI6kxuUVjsTPm2qwLOMtCPBteJ7/gIH1Z9AbXtHBaoqPkagiPgfPni2BjycveW
         8KwFFJxfNeToyWvhJa9IMSj2tUQ2xzRkKum1OJg20BBfdN/SkJBPWTewzBKLkZeCwn2e
         49vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825910; x=1762430710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCpWVCeFoXMs1/EyJIuFGqtdg2vmYZ9/7tM7s70z/qU=;
        b=lypr/B2F357AmFUex5/MlqWH3nMD7i4XXQn1PxMtTP0joTg99oBYD5f3RTa9lDVSEI
         a8bIjYz9RsZCVyfyvx9mejPWuAMeK0kP3XHCJjP2DYKoxUZql2JhpKdUw38DiQYsvtpz
         fXK8lY95DtLZfebUdelYyG+DjIVlOAN0nkyWSR1JCSzaJ5A/8yvn2CFyw5RQ0025RooG
         ci49vDlUgFT2nR+V5+CKYQq46+xp7YCzoFE7d1dBw1PjMY3bReJ8XBVBbnNx0h07NM6y
         rRWnWBV2mAbYBQcoDgUwl7sLEY+Prf3Ea5+I49l7tj3urjS8Q2q0k88QwZygxcih03Fx
         /ygA==
X-Forwarded-Encrypted: i=1; AJvYcCWszwdTGGmq7ZL2s7LNI6uQ6ltaWRZXec9Ha/5t4TfOUjKrOJJcpzDAfFj6WBhFRP6J4WVNiQIcekFtiP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtTYjJykeXPWX+pIyNSYMEaVbZ6Lvsc6ORi2CHG1p4W7ag00o
	y1H1HRBXlBc6PnKZKTOY3AKsiExNWpZ+wEKrvVcxhUBmQpWMI0VIFgbH
X-Gm-Gg: ASbGncuGPewugDLXFVwoec0qoVavqtAiKOAug1sR/gN8NTz/qLkscA+c3cfn3q7Rfm0
	WhJjh2zZ8xK3cwV3uNjIYah4sVA8D7IzmJSdVfUmL0WD9zGQnl3YG+KyFinhFZwxEhoHRJIaYbc
	5rUYonujB1eCFk5AV7H9stbrrFz8yDdp77SVnaX6yyMWbocm3U0znDUDK8/EBhQLQgkg4rlMpL6
	arNn3wwc4SxWDP1fmuZ71PPdb+ylifoCnPVFrsrStIl9ReT+8IoU91iaZ5y6rRisXH10YQPXcYW
	xqiSDxwGTlbDQUtvMcHqcGGMCkLttpzH1lqIvXMjmcacyr6m8llP0UV2bjBwHxms+e4Y/MDhfsQ
	cilluI5QALfpsOQ6A1UW0/+h0BNBCcIer3Ehw98/12wILROrW0Lg2Yh7bUvtXwiBLVe5H8FvxIt
	+K1wNfspolVo63qaRAsd9bLLbHLH39wuCiHbztMa+cLoHYjfpcpXJh2AzZfajF
X-Google-Smtp-Source: AGHT+IFu0rRxNzi3BvOKL1lXRDq2cHd03YnzoBoOPePE4rUTNG1zrE1V3xFacaBHpTSekptbKXeGkw==
X-Received: by 2002:a05:600d:6355:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-47728c12b10mr14305245e9.7.1761825910183;
        Thu, 30 Oct 2025 05:05:10 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca569sm31018677f8f.12.2025.10.30.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:05:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Tranh Ha <tranh.ha.xb@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L SoCs
Date: Thu, 30 Oct 2025 12:05:04 +0000
Message-ID: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
applies to all SoCs except the RZ/G2L family of SoCs. As per RZ/G2L
hardware manual "Figure 28.16 CAN Setting Procedure after the MCU is
Reset" CAN mode needs to be set before channel reset. Add the
mode_before_ch_rst variable to struct rcar_canfd_hw_info to handle
this difference.

The above commit also breaks CANFD functionality on RZ/G3E. Adapt this
change to RZ/G3E, as well as it works ok by following the initialisation
sequence of RZ/G2L.

Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 49ab65274b51..1724fa5dace6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -444,6 +444,7 @@ struct rcar_canfd_hw_info {
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
+	unsigned mode_before_ch_rst:1;	/* Has set mode before channel reset */
 };
 
 /* Channel priv data */
@@ -615,6 +616,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.mode_before_ch_rst = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -632,6 +634,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.mode_before_ch_rst = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -649,6 +652,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.mode_before_ch_rst = 1,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -666,6 +670,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 0,
+	.mode_before_ch_rst = 1,
 };
 
 /* Helper functions */
@@ -806,6 +811,10 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
+	/* RZ/G2L SoC needs setting the mode before channel reset */
+	if (gpriv->info->mode_before_ch_rst)
+		rcar_canfd_set_mode(gpriv);
+
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -826,7 +835,8 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	}
 
 	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
+	if (!gpriv->info->mode_before_ch_rst)
+		rcar_canfd_set_mode(gpriv);
 
 	return 0;
 }
-- 
2.43.0


