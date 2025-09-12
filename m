Return-Path: <linux-kernel+bounces-813750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B42B54A47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A6587247
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2D92FD1DA;
	Fri, 12 Sep 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBgbfLUo"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831A2FE57C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674063; cv=none; b=gGBvor7BFSay360MyGihHMZsomTj2m2aSMfhu7ogEKjC1nV/1p09NXPUrH/EMuwUsZ5rgzOc6Z334E7bjDojeqDH/ei2BDJahkZgz/CtVhqIymNXBMK9t+mStUkT9Jp8JbpcOQnX1p8fveihQ3Aw8a/yQoLpEENFrGJW1//TeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674063; c=relaxed/simple;
	bh=FLVOM1yiYyuAFtJIVpam2KGFjLS7vml22aG5VkRxxpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hodLgAeBtQCkKKHiHafK5go7cjxO1O8ZMWvvAPwGFxM47DJbWLUdSPOGmi9BePaFYGFszviDI19WxgC1QH3IQz8lsSIdz058qtUO0+5GGgPjN+VHh2EFdZKIrNdEco2ZjLyc8YHpzyDZk7WHjp40CkKeve5lYRF/fay/aMEnwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBgbfLUo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3db9641b725so1489291f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674059; x=1758278859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOFjcyob18/q6ECu1uYjWXtT3k120lD6uL6jj6365H0=;
        b=kBgbfLUonxox/sKmbToMx1NBuoJbRMJveK5mp/chObYYlOJLCHWmFEKIgVfWkUYnT8
         DhQqb5Y0gonYGr4mc9uKyNhp9tuSFTABh/Trt9qNShBM1EyhbnTChdltjVNcOn+vfXaa
         MNE6vwEHE/1IgAnLsKdXrdT6gF8+un+aSf92MEsc81Y/shIKN8G+rS6rrAQ5CdoTiN5g
         nX3DNthPHtxBsMuMksjxjwTqo4hxj6R4Yz1e4eGgkTZ1mdQORqiSSD8WqBULJWDl4ZBa
         RgCohY7o6ucSsZ3lA3XG8TLgsBNwxKKR8HT8eOTNxp/fHkWxjRykeK+q2DsEC+PVE7mE
         zNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674059; x=1758278859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOFjcyob18/q6ECu1uYjWXtT3k120lD6uL6jj6365H0=;
        b=j0YF2TXR7sgcOPTRToDKQpuUt4yWAajPjl8cnjIFOROvjgxEj9qBvkCfi90A/zMVkS
         ucHs3nhPZYY0XnAn6NbtDwH9dQ78749hNxVC4al8PU/0nULSXbT3/xqhJ+nOu1inUNaJ
         sTVuCW27tYpJs7vEXRQFVED+fbZB5zp1Qo6YXVQdZgBna/3jB29rPWbqW4oahoeKf52H
         OTewT8PCVQgc8f+d+Ui0GZ8Yd5HJvWEDdrTzuHzAPCQyP/cMv2BnfZMAcAL2DMile5l0
         Wp9UR8o4wR0dy+mZMfaB/jYtEqRfjBl6Khu1vHJ61hmcoFbt0V7Tb0IX9oyk38pDC6W4
         qUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXE9otLAF0FKKMhAIklLo15ZKRXWGkoC/PSa8SjwuBSEGJXJ4+UiBn3duGNHP+lfsyWCDMsh9FuwSUkl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaV0ZqaNv1hnXheTOWsYDpvuFei2pzGMYaAt0pazfw7th75hDs
	5ESwruiOatuodKouWikZn1aF6ymLEWyn3632TFRcouMbZC83CgdIrkEK
X-Gm-Gg: ASbGnctCI2vYkS4hJNtAyS0SS0CqelNXSNoZeH3LROO0u58ligAeCUDWprmFxr1v32C
	JrtlKTKTiUGlEETpSodAsHOikKNMl7qOkGsmnbZN+ZwZSAO6JLBlzYP4qh+DWA6qd/r2R1t/cB7
	vdtGn6Xup5ig6Pk9m91M2/ufmSDR69Z1SdXQsaGWRccISYiXN0Ozv2nr2+qFJd3yCD8IgrTq9Yu
	6mCxDWAJvOzd9Oy4ooxkMO5ho2aKFol/Y4MtqMPgnawStQYV6NIcI/UK6FA/jTnhAtns+T0Ddai
	HehVhuCH6TRsFid/FDgKpQAy4ABA5gRlJ2tVZB3JHTS/jT+eV2+/54C0dxZIlw8d5Q2zWyh9oy0
	qxkgVvjm7ZBQl0Aash5abrsL3/mAJO2SRqnvDTqfcValeqkocIoCB/3kpBru8uPVm+EQgG0FBk8
	pKLg==
X-Google-Smtp-Source: AGHT+IG+MQ3VtX94CzZfBzHv/ax7NYQ5GX85/Fpluu2HaIVgidvgyUMgFKd0uhvvk9hwI25G0f/Uvw==
X-Received: by 2002:a05:6000:18a4:b0:3e4:f194:288f with SMTP id ffacd0b85a97d-3e765a56cf5mr2172263f8f.62.1757674058849;
        Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 6/7] can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 12 Sep 2025 11:47:24 +0100
Message-ID: <20250912104733.173281-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the Renesas R-Car CAN-FD driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotations from its suspend and resume callbacks, and
reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag.
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index f0dfab177b98..a0c16a95808c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2255,18 +2255,18 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	rcar_canfd_global_deinit(gpriv, true);
 }
 
-static int __maybe_unused rcar_canfd_suspend(struct device *dev)
+static int rcar_canfd_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int __maybe_unused rcar_canfd_resume(struct device *dev)
+static int rcar_canfd_resume(struct device *dev)
 {
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
-			 rcar_canfd_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
+				rcar_canfd_resume);
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
@@ -2283,7 +2283,7 @@ static struct platform_driver rcar_canfd_driver = {
 	.driver = {
 		.name = RCANFD_DRV_NAME,
 		.of_match_table = of_match_ptr(rcar_canfd_of_table),
-		.pm = &rcar_canfd_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_canfd_pm_ops),
 	},
 	.probe = rcar_canfd_probe,
 	.remove = rcar_canfd_remove,
-- 
2.43.0


