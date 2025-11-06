Return-Path: <linux-kernel+bounces-888763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D610C3BD81
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFF2188D81C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC833F8C0;
	Thu,  6 Nov 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="B9mreEv8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA03324B0C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440115; cv=none; b=OKAxXfKYCIG/srcg8OGojYGdpbRjHFNKEkv1qHBBAn4qQW2qqgecXTKmgbIlcxFPHU6G45889XDAfKchw5NPDbz4cPEZQXQ2xKSFFFbi+LuDqLIMimKX5545eiT0ZHeqdv+vkdA79AGARv/JwC15Ca+y+6BUE2SDkLPJL/VaE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440115; c=relaxed/simple;
	bh=nMZ4yTau9IX/RJqS/sKxKzs5iuDiWutFuc3LDB4T/ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGYsLbmAzfyocoPoIDfkxU0o0zo2InBQolxEU69lZ7VZrOZDQ2cHY8pkjdT8DIvxcfJmg8N+kFRfhAhKO4bRmck+wqvbqBPLX+piU/Vi0TQKKj3yr5f3+aJeJrESv4Yf27LsrvqPIiuRWkan73uAPoi0ocflxIEEdW+jjISxrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=B9mreEv8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso678520f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762440112; x=1763044912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLvBreGMwkIXqaZtfvc2Qx+LalMucsk2m3rxCN5bCz4=;
        b=B9mreEv8th95ZjUKHXGnmBhYMZiL2JAgIdnEYUQJs0wrH2+MAaGMpoF9YHxthwzHLV
         JWx3elomFWenBdhe7/5qw1q3uOlB1cev6EkFoDgJmUBgyekaWMKT3w8g7s5emqDnsXX0
         k9ZL3ivRvK1/LzHqBGFlGhHI6wmIrmrfTv07Uhz5L27yXZEmzW76AtfFJ8DMViOFDEss
         Q2TLJuxHDyjRQZ8bFMI7pdk74lzXhw3l7h5Fl/Ofo7jXNjUxsoAHet4z00Y5A4k6zbHE
         ZjJiaq0qk5CpWAZf7N4E9MIEIZvrLGdUt53rTDriPIh6Sfe9n3M7KHa4c+yEhse2jH1T
         k3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440112; x=1763044912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLvBreGMwkIXqaZtfvc2Qx+LalMucsk2m3rxCN5bCz4=;
        b=R2rR0PumxmFSXR6qjZxy0pSSiyZ060lDe+qNrWh6pmiNoHraOT65uJATkckJeNgZOd
         wr2CHxODM3PSal39A3Y8byXrwm3NgbEL0WRJ2Es0I2q7vhprJhENNVRXJ7t0dzc1YyNo
         oY7WA3Neyg7nHNEH2OvpkfLBVmKruheBXqBZfV6iLdEqlDj8JCYv5vd05wE5LGWGMkBG
         8k2hLd+hpzjY5yhrUoPbrtrgxJSEcDmW5x4T4TrOeRXPpS4c/6I3IkNNLCymQc0hlHbH
         uk2Oqwsh3HT5WRw6lF8HdcthyeFILC4meuYJbfiDmZd/6pZgisvyjZnJjEdfS+Ox/AUs
         1BXg==
X-Forwarded-Encrypted: i=1; AJvYcCUvfVe/KrSDwSoYDzjMH7350OUyE5amsgj/0sc2eMhYQVSL6HHmbJJU5THabNxSlo9T3Y+ZDeDPyEpLsss=@vger.kernel.org
X-Gm-Message-State: AOJu0YywthuUqipIMOa18loY9rU8FgyRUZn+aOMePSNIaxKHB7ZarcZu
	claNqIoJu0cFq7t6sl0LEP9n1FXKp6XKqp2SNjVrEVyrsPH41YwpccEWmKWUM06Jgbc=
X-Gm-Gg: ASbGncv4F3KGPA1cGThM7vDVreIglOtzd2Z1m/OTSfaTQUT7aLvNOjQtQllTTPsLfQV
	8BS5fMn+FmWZ+01Ws5PHZ1eMkRlQnY1V6+XL6V17EfzrbRNv6F7zVX53g6v0RQ2cs1IXHEn9XZc
	Dpzy6hY02PnspsnbMO7RtvGBeWw0YygTO3mp7WVs1Z4iTUhiarys2wZGUz4lTl7eP0gRDHPMDRH
	N/T6A0qXwskUbZW9vWGmzPIlIsMf3sQvJDtmrMkPi5JQc0yuRP64k5YGHajmt27JgReweeAQKBJ
	BTyBshXPWAYV0aiEI7lT8ceWLCNnpf86WiGMAwIm8dpnBzBImHtpD/6+A389tM1werNueXMDNlO
	ozNwfT8CRo2PInMWIMaO8hSsWw2cZtxeo5zqGVLSSQ732UHw6t+uDh8DwttwGPWbg3jY6Z7yF8O
	9YwAY7bjHlQY+B/v1A4wwSkdGmetUDDw==
X-Google-Smtp-Source: AGHT+IEQIEtoq2huqYNM973Pi0C7dV27dTRh+KYLOlZZJrYRyqy5q0MDFqLHXSPi+tcIpGgwQC9bug==
X-Received: by 2002:a05:6000:184e:b0:429:bc68:6c95 with SMTP id ffacd0b85a97d-429e330ab3dmr6769606f8f.47.1762440111989;
        Thu, 06 Nov 2025 06:41:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb42a2aasm5369892f8f.21.2025.11.06.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:41:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] phy: renesas: rcar-gen3-usb2: Add suspend/resume support
Date: Thu,  6 Nov 2025 16:41:48 +0200
Message-ID: <20251106144148.3051962-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S supports a power saving mode where power to most of the
SoC components is turned off. The USB PHY is among these components.
Because of this the settings applied in driver probe need to be executed
also on resume path. On suspend path only reset signal need to be asserted.
Add suspend/resume support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

This patch is built on top of patches 1/7, 2/7 at [1]

[1] https://lore.kernel.org/all/20251023135810.1688415-2-claudiu.beznea.uj@bp.renesas.com

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 66 +++++++++++++++++-------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index a38ead7c8055..3c063e4dea41 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -132,6 +132,7 @@ struct rcar_gen3_chan {
 	struct device *dev;	/* platform_device's device */
 	const struct rcar_gen3_phy_drv_data *phy_data;
 	struct extcon_dev *extcon;
+	struct reset_control *rstc;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
 	struct work_struct work;
@@ -778,35 +779,24 @@ static void rcar_gen3_reset_assert(void *data)
 static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 {
 	struct device *dev = channel->dev;
-	struct reset_control *rstc;
 	int ret;
 	u32 val;
 
-	rstc = devm_reset_control_array_get_shared(dev);
-	if (IS_ERR(rstc))
-		return PTR_ERR(rstc);
+	if (!channel->phy_data->init_bus)
+		return 0;
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(rstc);
-	if (ret)
-		goto rpm_put;
-
-	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert, rstc);
-	if (ret)
-		goto rpm_put;
-
 	val = readl(channel->base + USB2_AHB_BUS_CTR);
 	val &= ~USB2_AHB_BUS_CTR_MBL_MASK;
 	val |= USB2_AHB_BUS_CTR_MBL_INCR4;
 	writel(val, channel->base + USB2_AHB_BUS_CTR);
 
-rpm_put:
 	pm_runtime_put(dev);
 
-	return ret;
+	return 0;
 }
 
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
@@ -846,6 +836,18 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		}
 	}
 
+	channel->rstc = devm_reset_control_array_get_optional_shared(dev);
+	if (IS_ERR(channel->rstc))
+		return PTR_ERR(channel->rstc);
+
+	ret = reset_control_deassert(channel->rstc);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert, channel->rstc);
+	if (ret)
+		return ret;
+
 	/*
 	 * devm_phy_create() will call pm_runtime_enable(&phy->dev);
 	 * And then, phy-core will manage runtime pm for this device.
@@ -861,11 +863,9 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, channel);
 	channel->dev = dev;
 
-	if (channel->phy_data->init_bus) {
-		ret = rcar_gen3_phy_usb2_init_bus(channel);
-		if (ret)
-			goto error;
-	}
+	ret = rcar_gen3_phy_usb2_init_bus(channel);
+	if (ret)
+		goto error;
 
 	spin_lock_init(&channel->lock);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
@@ -936,10 +936,38 @@ static void rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 };
 
+static int rcar_gen3_phy_usb2_suspend(struct device *dev)
+{
+	struct rcar_gen3_chan *channel = dev_get_drvdata(dev);
+
+	return reset_control_assert(channel->rstc);
+}
+
+static int rcar_gen3_phy_usb2_resume(struct device *dev)
+{
+	struct rcar_gen3_chan *channel = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(channel->rstc);
+	if (ret)
+		return ret;
+
+	ret = rcar_gen3_phy_usb2_init_bus(channel);
+	if (ret)
+		reset_control_assert(channel->rstc);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_gen3_phy_usb2_pm_ops,
+				rcar_gen3_phy_usb2_suspend,
+				rcar_gen3_phy_usb2_resume);
+
 static struct platform_driver rcar_gen3_phy_usb2_driver = {
 	.driver = {
 		.name		= "phy_rcar_gen3_usb2",
 		.of_match_table	= rcar_gen3_phy_usb2_match_table,
+		.pm		= pm_ptr(&rcar_gen3_phy_usb2_pm_ops),
 	},
 	.probe	= rcar_gen3_phy_usb2_probe,
 	.remove = rcar_gen3_phy_usb2_remove,
-- 
2.43.0


