Return-Path: <linux-kernel+bounces-870304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E803C0A6C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD01897FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15023EA8B;
	Sun, 26 Oct 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPiFeNti"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C671F0E26
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761479091; cv=none; b=tOzVb31g/oMX1QSCG9tfxkBr9ah8OjCzuzkhwO+Xvf/v3Oi3STtdcJrv/+GmaNlBVghUTNq+YWPpbApU2+TIL8nfVaynmmtiB23NlIl9y5DoTZ8eL07NzNjVay/1NU0ewVykDmdE7SkXfjsmutTk5sGVKf4AClbrYLB20olNY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761479091; c=relaxed/simple;
	bh=QSzyaYQYOlY/Fh0HrjVoPCv8LLLkAAYkkHgdG5KLGLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3+fVb1O5wdhDul2sK81TOKSVpmYSQTBsxqahtNO5YBiJy/4cSV3fZGCth6SeA/0tXHG7bsw6O/dA+C88tMwz34EM06JiTd1ZZSuONehhYV2pVnua91dyVeyN2U1BPWqRlcqnTL0Yz860fDzgyTkX0TSgG0JbKTrevjGh1pnOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPiFeNti; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so21271675e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761479086; x=1762083886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTs+2WA2dXIobsZBWKKKP2LpgP+B0kR7P+R3v1lLYLk=;
        b=UPiFeNtiUutDW35ojo8XECoxPJWFJbYH36YDlXfWboRbMfVm4jpPicyQxmacR13A1Q
         ABFoVz7Rugm6X5iTcAw+UQVLZjBj0BRdEmZcWw7/ORPgebymPrGDh+QzSA7RVrJxY16A
         /TWj6MbyTnqWGYotLn55m+koNNfwtMcUV1MMXpqtTB1TXD62ALyOYe1Qpux+ZU+qcxJG
         /aY9buUy5n8MvnA/bHKdLWs1LQ4deoPi9FmQh2L3z4DmF4OPKG3/u1/XBsb5vH6jaMXZ
         agaf3wRtpkELrbI4RcB/iWprTLuJcJ6LQ3YS+mfGD77eSCsx+qwrcU6Pk3ykDDOWjS2h
         PW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761479086; x=1762083886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTs+2WA2dXIobsZBWKKKP2LpgP+B0kR7P+R3v1lLYLk=;
        b=HgAUBW4Vpq6vFjc03Z7LU4OBaaYtsHr8O0A06AjM6wMTND+9kWYZRTYaIFx5WoTar1
         Ipg7tQvwhOBIgzR0EkQv98H6cw/7JVdQvmI/aqHDHo2S37ASlA4FJ1ByBo9ar/z+1azk
         oXR3hIZZAZWSGWElPGsVk7x0qBzDWByYA9Zn0UxA2RkKdCEbgayyM9eAkLPAO4uQ+rap
         PZolS4J4xLubjEoRn0pW5V2TkEV0NDuGzGQs2Kh96SgIx5zrW3Hc5s4oDQH5P559JaWq
         5F+Xco8a9Zp2qqsvWsQzsBc+s/GBWy9ePxTx5bZCNU52A0BwK2F33KpricilVEZ1TroD
         Hfmw==
X-Forwarded-Encrypted: i=1; AJvYcCWWPkQeiMz2ad/0PAjFwpsB71f0DBlzuUPhoojjaguf9EV+nQNiOtBU7cM5YRa2DFvt4HONP+ZkUr+I98E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfmq7YOV5n/HW/k9No6DQt0tqmrnL5G/99019ejP8N6t3WTLS
	NR2KqAyeN3nutRSHHY1HIAjOL5DHVqgxeN/nPdp4GVoNdgxS0+p8sKE1
X-Gm-Gg: ASbGncuf/TDsQeJIo9Z3Au3WxdgUbfv6aDsf+h6JZSZliu2t/PkiHFv+BGb5XxVW6hF
	DsWzJDZbhokchMpd4Yoe7JlQ37QRVsEeFTMad5DqN8GDoyQIdX4eUHX5W0+0i61Bf22YubcRQ8x
	PYhnih+uANAXgDcZMy8tdf50/Y0vh8VmdWN6yzjfms2eqwnA8MMfOf18ztMFnCdvmlyOiAGd73P
	afUbY9IrpWtv/kVi8XhRe1mRz2qhm8TmxUTuV7LpGnBjzQefI+OpVZRug+2ALo+mZnQ1Atdjm23
	jOiLe6jzWJ3J4rbrjqIsqKYgFfWwF4/oRPKkU6JQR9WrLiP39pAgEidC1TOjw1qRuIX1q7NDIkZ
	AVyxBpIL7bXKuxY3MmAR9QMtZMKSspd6RwvE/kTZKtnbqktnrTMDIuaPfPGYkDtZHh8ctT7qbFR
	TieplnYM3StRXh1NhtdMO9wlkTl0A=
X-Google-Smtp-Source: AGHT+IHsUPCv0yYA/lmzLCKcqn20aOcA4RQAApNwtY3rRlQ7LIcTN5Wnns3ahwh+m6FhXo34ywpCCA==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr252101815e9.25.1761479086309;
        Sun, 26 Oct 2025 04:44:46 -0700 (PDT)
Received: from localhost.localdomain ([39.46.217.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb55asm8361469f8f.17.2025.10.26.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:44:45 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: kernel@esmil.dk,
	hal.feng@starfivetech.com,
	linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alitariq45892@gmail.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v3] pinctrl: starfive: use dynamic GPIO base allocation
Date: Sun, 26 Oct 2025 11:42:40 +0000
Message-ID: <20251026114241.53248-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JH7110 pinctrl driver currently sets a static GPIO base number from
platform data:

  sfp->gc.base = info->gc_base;

Static base assignment is deprecated and results in the following warning:

  gpio gpiochip0: Static allocation of GPIO base is deprecated,
  use dynamic allocation.

Set `sfp->gc.base = -1` to let the GPIO core dynamically allocate
the base number. This removes the warning and aligns the driver
with current GPIO guidelines.

Since the GPIO base is now allocated dynamically, remove `gc_base` field in
`struct jh7110_pinctrl_soc_info` and the associated `JH7110_SYS_GC_BASE`
and `JH7110_AON_GC_BASE` constants as they are no longer used anywhere
in the driver.

Tested on VisionFive 2 (JH7110 SoC).

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
Changes in v3:
- Add Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
- Clarify commit message wording for readability

Changes in v2:
- Remove unused gc_base field from struct jh7110_pinctrl_soc_info
- Drop unused JH7110_SYS_GC_BASE and JH7110_AON_GC_BASE defines
- Remove .gc_base assignments from jh7110_sys_pinctrl_info and jh7110_aon_pinctrl_info
- No functional change otherwise
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c | 2 --
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c | 2 --
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c     | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h     | 1 -
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
index cf42e204cbf0..3433b3c91692 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
@@ -29,7 +29,6 @@
 #include "pinctrl-starfive-jh7110.h"
 
 #define JH7110_AON_NGPIO		4
-#define JH7110_AON_GC_BASE		64
 
 #define JH7110_AON_REGS_NUM		37
 
@@ -138,7 +137,6 @@ static const struct jh7110_pinctrl_soc_info jh7110_aon_pinctrl_info = {
 	.pins		= jh7110_aon_pins,
 	.npins		= ARRAY_SIZE(jh7110_aon_pins),
 	.ngpios		= JH7110_AON_NGPIO,
-	.gc_base	= JH7110_AON_GC_BASE,
 	.dout_reg_base	= JH7110_AON_DOUT,
 	.dout_mask	= GENMASK(3, 0),
 	.doen_reg_base	= JH7110_AON_DOEN,
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
index 03c2ad808d61..9b67063a0b0b 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
@@ -29,7 +29,6 @@
 #include "pinctrl-starfive-jh7110.h"
 
 #define JH7110_SYS_NGPIO		64
-#define JH7110_SYS_GC_BASE		0
 
 #define JH7110_SYS_REGS_NUM		174
 
@@ -410,7 +409,6 @@ static const struct jh7110_pinctrl_soc_info jh7110_sys_pinctrl_info = {
 	.pins		= jh7110_sys_pins,
 	.npins		= ARRAY_SIZE(jh7110_sys_pins),
 	.ngpios		= JH7110_SYS_NGPIO,
-	.gc_base	= JH7110_SYS_GC_BASE,
 	.dout_reg_base	= JH7110_SYS_DOUT,
 	.dout_mask	= GENMASK(6, 0),
 	.doen_reg_base	= JH7110_SYS_DOEN,
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 05e3af75b09f..eb5cf8c067d1 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -938,7 +938,7 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 	sfp->gc.set = jh7110_gpio_set;
 	sfp->gc.set_config = jh7110_gpio_set_config;
 	sfp->gc.add_pin_ranges = jh7110_gpio_add_pin_ranges;
-	sfp->gc.base = info->gc_base;
+	sfp->gc.base = -1;
 	sfp->gc.ngpio = info->ngpios;
 
 	jh7110_irq_chip.name = sfp->gc.label;
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
index a33d0d4e1382..2da2d6858008 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
@@ -38,7 +38,6 @@ struct jh7110_pinctrl_soc_info {
 	const struct pinctrl_pin_desc *pins;
 	unsigned int npins;
 	unsigned int ngpios;
-	unsigned int gc_base;
 
 	/* gpio dout/doen/din/gpioinput register */
 	unsigned int dout_reg_base;
-- 
2.43.0


