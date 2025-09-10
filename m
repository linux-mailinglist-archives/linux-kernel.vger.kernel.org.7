Return-Path: <linux-kernel+bounces-810323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD7B518C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EC71C85FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F97322761;
	Wed, 10 Sep 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JKnkXOhM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA2322522
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513009; cv=none; b=dta96X951QtCfwrtjyx7Lv8l4b2PjroGUbl+54YWPkK/BNw6SOdXApWydCGdqIzrip0JabEC3L0wm3b/OZBU3skAccVBLIDKA6zwrnlQ32sTmILobvXloNdh733Wz6ygRKALjWWrDDjXTLX1MpK/13cLdM4C8X8o4SdWW5VYfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513009; c=relaxed/simple;
	bh=xnkO2/ugdWW1AEEoC5uQKPmEa+cWP3HwT2TacT+rR48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCZk5S0e5KPWSqIG1goR3R/S3iuhKe6Wxx0yze9e0cyDg8+cQ4xas+ltkMRBD2YX29SZHl4oQy7hFo2TSWO3x9GGZJfCzUS8oX1qUosmcBeagTD/IVktCtvVKe0mFvCWzfQYyZX1NwfRDQ6bK2bT/eaB0tAl8iU6qf/T9IC/kXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JKnkXOhM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de1f2cdeeso24142735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757513005; x=1758117805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkyh4Dhlw28CLMdRTkOh/1iBArvWo9DTQbXvmwtecM0=;
        b=JKnkXOhMNnxwxIP9nKcLBcZNkcvPvEGLHKwtu+ZYCERoXYtI9a8Y9RR/7J/ApWKrd6
         zMxmF9DyXp0XyNVXrvUSVapRBF7Uxw82daTbYvdh/DoGdEgVVrn1ITIZlPNULTizWGGO
         GF+Ru7H44rVh7Fvch/OpeOgk5yIE+m7jcrxWbXcZZklOdDcnkVbkzsr9t+W7p/eVWdDQ
         MUy3CRPO+UazZWwy/CgwJRqVKlMYgmyMrll0GOrO8OhQtNLTYPQp15Mh2cdIVazHbLzM
         MWo1Ioe+vOm+yoRL+lzqdaWNH0wBw7uFObJGjpCPGHA5ezQW1M0SkRxKp7PsQdt/7B9E
         AF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513005; x=1758117805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkyh4Dhlw28CLMdRTkOh/1iBArvWo9DTQbXvmwtecM0=;
        b=XBNH113fkpVMHgxsk2/ohJt/KUkZwqrIQ+5mRrQOKLnSnV/lEqY4kN9ITk4N+s37q4
         hjVOFpS7y5/H6Go0YhzrQjn0hvDS08Lj4a5RH2IDE07Lh0doItp15Cb9jJIEW554+zIG
         llSaGpSgD68elKSEspnYab5XgJJXoc77AhRmj5rQHLmGt1HOhp4U/o+n8CpXhPv0LGpi
         Biadl9XoFxzNSj/LnLT4/wIfIoZUr3oedyN2SGXFANdt25BKkoRy4pdBNJdAfRqvNyzu
         CIh4Ev390bqL8ZqH47VY2X1izmWuRG8UGZgz9xmK7K32GTdu5hKHTUVEZFbkBP+cF4ny
         TyMA==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZCc9aactkycf0uYdhXp3+Yw48VXGxaIzLIpqb12DvVIkNFYGy+IPw3162TqGWsnL1IoOut3tqwY0KDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZRKvsAWYvhvfpgBYrzPmyKZP3ayb1fcmoGKsAoLKI4U2W8l9
	9+jo4crCutu4TdOGOtJteCD1Bbe5Dx89581gkczYySGzkU9i6qKVeWWbDWYyAGJ7718=
X-Gm-Gg: ASbGnct/V9umRo4qDh29TEjFbvPhODL5AlzaSW2pyOI50ropDd3JqsBCBNRlf5OZFiV
	RBBuYpgp5BYmCkdHIntinHHPz+tr99hl4/wR1qdF1uQnwgpOIZPFP4tA1M+9NtN2cWgItkrLhsy
	f2Rq7/MdCP8pccqb1kF/1d7LtT45fkaI0lelBFjoCjipYvWm6JOvCkaprFC2Rmai/zEV/zrIfrJ
	KsFrO7w7uWD5M3K2gbUOdtZWSTsUy3pt/LVfsCICof8iJryBlD+thc3DQa+PTs6lngUWWQuUZcG
	FDe2GHGJEOjq7dyMG+dSqCkzll9eqCJcURU+AQdhurm79O/rp/3nWQ1/6cFAke2tGD/wv/Ylnwt
	haEbiMcRfiB7keiFWtW7TGBVbKCt+71HuisxVRq++N+i6TTDUXs3G
X-Google-Smtp-Source: AGHT+IFSs4+XILv/ozu1ePkTUArRSwLZOgfXjnuMdSXTBp3f8FpU0Yp9uKqcu+HOub89ber0vORyLw==
X-Received: by 2002:a05:600c:19c8:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-45ddde866c8mr148790095e9.5.1757513005134;
        Wed, 10 Sep 2025 07:03:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm29523875e9.0.2025.09.10.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:03:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 2/7] phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()
Date: Wed, 10 Sep 2025 17:03:00 +0300
Message-ID: <20250910140305.541961-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If an error occurs after the reset_control_deassert(),
reset_control_assert() must be called, as already done in the remove
function.

Use devm_add_action_or_reset() to add the missing call and simplify the
.remove() function accordingly.

While at it, drop struct rcar_gen3_chan::rstc as it is not used aymore.

Fixes: 4eae16375357 ("phy: renesas: rcar-gen3-usb2: Add support to initialize the bus")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[claudiu.beznea: removed "struct reset_control *rstc = data;" from
 rcar_gen3_reset_assert(), dropped struct rcar_gen3_chan::rstc]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- dropped struct rcar_gen3_chan::rstc; updated the patch description
  to reflect it
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- none; this patch is new; re-spinned the Christophe's work at
  https://lore.kernel.org/all/TYCPR01MB113329930BA5E2149C9BE2A1986672@TYCPR01MB11332.jpnprd01.prod.outlook.com/


 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 3f6b480e1092..a38ead7c8055 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -134,7 +134,6 @@ struct rcar_gen3_chan {
 	struct extcon_dev *extcon;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
-	struct reset_control *rstc;
 	struct work_struct work;
 	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
@@ -771,21 +770,31 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
 	return candidate;
 }
 
+static void rcar_gen3_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 {
 	struct device *dev = channel->dev;
+	struct reset_control *rstc;
 	int ret;
 	u32 val;
 
-	channel->rstc = devm_reset_control_array_get_shared(dev);
-	if (IS_ERR(channel->rstc))
-		return PTR_ERR(channel->rstc);
+	rstc = devm_reset_control_array_get_shared(dev);
+	if (IS_ERR(rstc))
+		return PTR_ERR(rstc);
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(channel->rstc);
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		goto rpm_put;
+
+	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert, rstc);
 	if (ret)
 		goto rpm_put;
 
@@ -924,7 +933,6 @@ static void rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
-	reset_control_assert(channel->rstc);
 	pm_runtime_disable(&pdev->dev);
 };
 
-- 
2.43.0


