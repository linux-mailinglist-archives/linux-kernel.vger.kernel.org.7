Return-Path: <linux-kernel+bounces-849779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BAFBD0DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDDA1890F14
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A56231827;
	Sun, 12 Oct 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqEUk2/A"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2578F54
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313133; cv=none; b=AlGpX2PWZP0mc+zd9TTrcQDvrEII/soTg09tXPlySOnqN1dtBhbfLHm7ikrPyITFhgpAMYEBxMoeZzd3ufNW5+VUOhdfPwOOrFvqRFh/Zx/G0MpErL9i2DVM+zVcoyA1SS2zHTiIrS+fgk2dLhnaBOSCRRVd5xqMSuTASW1FTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313133; c=relaxed/simple;
	bh=meZgRIRgGz4kT6BLLs0o6i52wiB4LpglawytCW2OZGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGKsWSA+MC+JIlZhy5AMlrOszdfazTwRmS8gPufG4o3UqLzGd6xPRt7Gr/NUIFnwX0b7aupQpYZLr0gyfz7IhBWJpdelWO5ERpfLePowFU6cNVeGHpX3QxB20MWLjoA2BN+Rq9OG5K4w9kkptr5LdNrAITbIGOGLohWfxKRe8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqEUk2/A; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27c369f8986so33305525ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760313131; x=1760917931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MA/CbTkvaa4YBWZa6ClbOJLv6rpKecbHiMNcj6ecb0w=;
        b=mqEUk2/AuEB6gNEDWzWvUFkf87Zhbnhpy0jYwml3apu6MSjqaMooNAJKRyfcur7+VH
         yactych9irKWM2xMcaldbj6ocESp+WNhG3NLqt8rc2W0/mWh6Jz6UL3Y+Wc5n/2xIW58
         CVtSQoveql93xMLY/IyBDyzJ45Cq1ECV9QcmcwHseuRaZ8gaF6MGBhUiRReGJ1I1Rv6I
         YwECY6UEIfT1Cf7eYQcMaJ8K/PWWu5cC4a617zpT9FmKv8CPA2H+WtxMARbRMC7q/+BT
         tfVAhkB83pBOq8nxdiI7rzSHvJvqX1F0ohjRNDeAK5e4ZWn25R+1CopHuyszxGxK0HRC
         eFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760313131; x=1760917931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA/CbTkvaa4YBWZa6ClbOJLv6rpKecbHiMNcj6ecb0w=;
        b=lG1m7APpB1TaZnAuf87IyoGUkZowRNuVfRVJ3Ek12liqPKsbupes81gm9svZE2sgaD
         JPjGDWpY0fkM8kY7YmO4AxSZ5BIweUGj7CxR5N8zIhnwbCA/KtcoeIBxNp01bt2bPJxj
         7P5DtqR4/U4f6DZN3tg9IoT6ASOR6Dim4+dc8ta3Y/46uuPcbO2fzKLbVZCj/d9jjchD
         sCRIv6GYU8U0c5EFnPkbC1qQzvZKugHJWZwW1WoNPwypDY+e7OeoiPFCkZdJ3dDa9e+Z
         PNKk79nU3EzvxewKO19dmQH7K4Wo/AIpVAvHSnm5HI4on8GfKcPZ10EoaksgPSGfuyDc
         Hgjw==
X-Forwarded-Encrypted: i=1; AJvYcCX95+gx9bdlBvBUZTwvfDoBtzOnDYi+Vomx/BRJsmq1uqJwOmkmZf48hs+nmX3Exg289CGjC/3uDZK6qQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4sHygAEmBXHLHBAptmoqeta53dHhaXkiWzzEDUoLyCIPfBmC
	KDq/WgA2X5Hq7aQ2OUHiWqJt/BK9jAmMtLbQBFvGvB7JUsdE3e0W8nJs
X-Gm-Gg: ASbGnctRCywRj2T1V8+VbS4OIdoshx4NYyzJrdSeALHIIMPmTGYpBQeixM5CNigJfRW
	qe/F+goaT7GRGbfe5pvmrNC2NN8OvyVkeINWbfTqnszXAQlq3xwyr/gZCjdP/Nv4R+jtbi4g76I
	Cm/T1cSETujwYHMZZmrxpM6MudkMzn6FfrVcCMq9quZaJcPRxyz2wTMKY9hYiTHYjFRMYBwJMer
	mDw9zivsd8nHUE2fOpN77CX4tWvKJfH5pYKKoYVdp/ojd26K2HIFSLWYUDz19W4AHPdlmnjansn
	AUf5ZQzF1reFohohNNAqZ3mG6pRorf7HUik9IrjOS6hAJci5gYf4cm+pcGgzu+7DH75Z/DC+fom
	8d3d+m14rD067qho224pQYuEO4h7QanuC9yApFekbHPxGt4sSSKcu
X-Google-Smtp-Source: AGHT+IHV3IN7oxo5m4JFeu31RH0eXwkx56/6n6hqO9lCyu5p7QOagyZjRIlPKlg22PYDzOg2LNf42Q==
X-Received: by 2002:a17:902:b18f:b0:269:6052:3536 with SMTP id d9443c01a7336-290273ffc80mr169583425ad.45.1760313131089;
        Sun, 12 Oct 2025 16:52:11 -0700 (PDT)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea083sm116576985ad.24.2025.10.12.16.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 16:52:10 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: alex@digriz.org.uk
Cc: andrew@lunn.ch,
	sebastian.hesselbarth@gmail.com,
	gregory.clement@bootlin.com,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] arm: mach-orion5x: ts78xx: simplify support configuration with table
Date: Sun, 12 Oct 2025 16:51:47 -0700
Message-ID: <20251012235147.325532-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace switch statement based configuration with a lookup table approach.
The table is iterated through matching the correct configuration instead of
setting the configuration on a case by case basis.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 arch/arm/mach-orion5x/ts78xx-fpga.h  |  7 ++++
 arch/arm/mach-orion5x/ts78xx-setup.c | 60 +++++++++++++++-------------
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/ts78xx-fpga.h
index 2f4fe3ca5c1a..e35c63382b4c 100644
--- a/arch/arm/mach-orion5x/ts78xx-fpga.h
+++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
@@ -40,3 +40,10 @@ struct ts78xx_fpga_data {
 
 	struct fpga_devices	supports;
 };
+
+struct ts78xx_fpga_support_config {
+	u32 id;
+	bool rtc_present;
+	bool nand_present;
+	bool rng_present;
+};
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index af810e7ccd79..cd8e15cf6a13 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -325,6 +325,18 @@ static void ts78xx_ts_rng_unload(void)
 /*****************************************************************************
  * FPGA 'hotplug' support code
  ****************************************************************************/
+static const struct ts78xx_fpga_support_config ts78xx_fpga_support_table[] = {
+	{ TS7800_REV_1, 1, 1, 1 },
+	{ TS7800_REV_2, 1, 1, 1 },
+	{ TS7800_REV_3, 1, 1, 1 },
+	{ TS7800_REV_4, 1, 1, 1 },
+	{ TS7800_REV_5, 1, 1, 1 },
+	{ TS7800_REV_6, 1, 1, 1 },
+	{ TS7800_REV_7, 1, 1, 1 },
+	{ TS7800_REV_8, 1, 1, 1 },
+	{ TS7800_REV_9, 1, 1, 1 },
+};
+
 static void ts78xx_fpga_devices_zero_init(void)
 {
 	ts78xx_fpga.supports.ts_rtc.init = 0;
@@ -334,36 +346,30 @@ static void ts78xx_fpga_devices_zero_init(void)
 
 static void ts78xx_fpga_supports(void)
 {
-	/* TODO: put this 'table' into ts78xx-fpga.h */
-	switch (ts78xx_fpga.id) {
-	case TS7800_REV_1:
-	case TS7800_REV_2:
-	case TS7800_REV_3:
-	case TS7800_REV_4:
-	case TS7800_REV_5:
-	case TS7800_REV_6:
-	case TS7800_REV_7:
-	case TS7800_REV_8:
-	case TS7800_REV_9:
+	const struct ts78xx_fpga_support_config *cfg = NULL;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ts78xx_fpga_support_table); i++) {
+		if (ts78xx_fpga_support_table[i].id == ts78xx_fpga.id) {
+			cfg = &ts78xx_fpga_support_table[i];
+			break;
+		}
+	}
+
+	if (cfg) {
+		ts78xx_fpga.supports.ts_rtc.present = cfg->rtc_present;
+		ts78xx_fpga.supports.ts_nand.present = cfg->nand_present;
+		ts78xx_fpga.supports.ts_rng.present = cfg->rng_present;
+	} else if (((ts78xx_fpga.id >> 8) & 0xffffff) == TS7800_FPGA_MAGIC) {
+		pr_warn("unrecognised FPGA revision 0x%.2x\n",
+			ts78xx_fpga.id & 0xff);
 		ts78xx_fpga.supports.ts_rtc.present = 1;
 		ts78xx_fpga.supports.ts_nand.present = 1;
 		ts78xx_fpga.supports.ts_rng.present = 1;
-		break;
-	default:
-		/* enable devices if magic matches */
-		switch ((ts78xx_fpga.id >> 8) & 0xffffff) {
-		case TS7800_FPGA_MAGIC:
-			pr_warn("unrecognised FPGA revision 0x%.2x\n",
-				ts78xx_fpga.id & 0xff);
-			ts78xx_fpga.supports.ts_rtc.present = 1;
-			ts78xx_fpga.supports.ts_nand.present = 1;
-			ts78xx_fpga.supports.ts_rng.present = 1;
-			break;
-		default:
-			ts78xx_fpga.supports.ts_rtc.present = 0;
-			ts78xx_fpga.supports.ts_nand.present = 0;
-			ts78xx_fpga.supports.ts_rng.present = 0;
-		}
+	} else {
+		ts78xx_fpga.supports.ts_rtc.present = 0;
+		ts78xx_fpga.supports.ts_nand.present = 0;
+		ts78xx_fpga.supports.ts_rng.present = 0;
 	}
 }
 
-- 
2.51.0


