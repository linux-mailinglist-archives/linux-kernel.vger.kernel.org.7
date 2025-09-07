Return-Path: <linux-kernel+bounces-804619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1206B47A82
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4FB1656EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382B248F7C;
	Sun,  7 Sep 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUu5aT/P"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7C14AD2D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757241605; cv=none; b=LOjCkgNBaT0k1jAVxAYnqiFqi2HPwv7VtWuVrQiW5dc4AV2qChAjZi3UuPg5Uikqo66S8epYZBQwcXmvxv7o3yNAH1BpkpFQ+qoAAvC4JguAM/S649GRKcercGGijzJpeaefGSfRXjMFp2uYzOpfuITshmuS3UR1mF9fXcqIpkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757241605; c=relaxed/simple;
	bh=7CFTmx++Dd80EZuI1OcKTIhaNf3eyWl3d0K7gYlZDK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ORzD47N6apomW1rWcjfdVVSosZJ+Co4n5ew1XVfUC8yugT8DXinXNra12lPUckjVPzPK4jUFP4mR03NKl27gOO5Hw4gEmUadZign/IntV0L6TdfAW+gYam3Vh49R4Tfe7Um5qRTcXAR1hu38VKGXek0tCo9kDKM3WGyfxMHjFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUu5aT/P; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b04679375f6so607563466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757241602; x=1757846402; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3LJIB5Snq1vZY/Q040eWmBwtzfFBv+xqjnbErdhstc=;
        b=UUu5aT/P4c4T3JPgbeSv6cmQGIJ+a+ZqcaAH0AXXF8HMDqKxWy/QxA1TO/tjkhYt3t
         GJSIpUJAE2atFQ+vcPq72Rwmy38M/uuTATvqRnz6OYZvMXgHdc3KfvhkZG7LrfpOwGgs
         WZyr2GGYRc6HGqxehmJHbP6xmiquWAAHh1ZMy8haClfAw6wQ9TyIUTZJVud/4k5AFGn+
         oYEIlysaX+uersPchnEJAMrHmgB2Tc/bBcrrec9DSYmWcFpqUfnFQcdZ7v5KGXUgd4DA
         9aAaywEY6e3KFssb9/wBbvJ9XJz/p2BIOIV80NxhYpK93jJ7aQVi5elkeID977yNXJqG
         kxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757241602; x=1757846402;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3LJIB5Snq1vZY/Q040eWmBwtzfFBv+xqjnbErdhstc=;
        b=B5J1jXOYYO4dQ91tW3WbIj5b8sIB/5dTBke4JL3jF7Jojq2ZtD0BQgr0WwzpT1TrAe
         P6Znzd6q1lrWRhUpprfhi5f8EkUzwl/mHVBZOJEKUHYLSDSwt6BVNg2tRmdq4P+ClLLW
         MGqf3/3DAmoJcy8ocJG/AGf8W3xOX9MZrPwJd2AGljCMcqPhsT3oV+uWL8EpKNRxSzaW
         ss/4pbyIF6LI5Vne275PFm+CRvvIs2jEVI6i16YiLSCaSxof26ncOzuHbkGfA9dPAMf+
         vXnUvygtAdkppj2gPct9etsl46LZROLs2FOz3fN3n3NWEMZpkjYkteQP8ICWb1i4A3cH
         NPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBILM8NZbJND0Hdpn2KYp0VuV0yQZIK9Jo8MNf2HQGO8Sr/sUmena05WepHACTmMAghGmpoSOiWrI6AUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FvOGK8pKshnHSUkVkMBy+cBhujCddT4sgSeaRiSP28DY+H2A
	4RgMhfOsl1UNtXUURdhJQSPnNOxh73HCWDyKmvjvOwM57t7uWu/nw6Wx07Bi5Q==
X-Gm-Gg: ASbGncsSiebhfVILqEQsXDibQGN88cLRimB6TH4awgLZRni+lWlaEl/yxRAKnLs+A5D
	7npWpe3hAqBUAaWE7j8aLNbmOJ+OpDKMtRIY7hTDuVBDWG28bV2m7S2Idp4JSoZq/npLBM4YY+O
	kA63UZqC88z5gUabfbs5iRnzjc/VmqMS7ISnNNN4oaG3+HLuTVKWgpIEurtgn66ed4A1zOfDLvR
	Zy31QsnwoRr+C9sqvn6MgWqYxIzLfIy3x/kJJ3utYFPtcDUWWu8lNDrpdJvJ4Y+NO6l6Sc52D4Y
	vHZsP9bryrHtSdQUol2druxiq29BOoxC06Vwy+nx4fukfDNRx4vIjk5qojIBGYhat9FhnjIDeF1
	81EQDxn2r1TLho9JhdatL3FoaGb7eDns=
X-Google-Smtp-Source: AGHT+IHe7xBO7kxbuh0iGFyqnbmApltWfGvZJTN7GUa9kkB+g9wgVZm/JLSQGuAlQLssnmRyc9jaHQ==
X-Received: by 2002:a17:907:3d11:b0:b04:522c:e113 with SMTP id a640c23a62f3a-b04b167f105mr457986166b.53.1757241601535;
        Sun, 07 Sep 2025 03:40:01 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b046d420e02sm1026558866b.39.2025.09.07.03.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 03:40:01 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sun, 07 Sep 2025 13:39:56 +0300
Subject: [PATCH v2] mfd: max77705: rework interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-max77705-fix_interrupt_handling-v2-1-79b86662f983@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPtgvWgC/42NQQqDMBBFryKzbkoS0cSuvEcREZ3qgEaZpMEi3
 r2pJ+jyfT7vHeCRCT08sgMYI3laXQJ9y6CfOjeioCExaKkLaXMllm43xshCvGhvyQVkfm+hTd9
 hJjcKaW3VI5ZVXg6QLBtjel6FZ5N4Ih9W/lzBqH7r/+6ohBImR2msVBoLVY9LR/O9XxdozvP8A
 n4Un8zOAAAA
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757241600; l=3585;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=7CFTmx++Dd80EZuI1OcKTIhaNf3eyWl3d0K7gYlZDK0=;
 b=OUno2zIWfyLTpX8WImdN2lMfVOEqVtrZCZMwA+KPT8sIC8j71sHoAHVv2wC5Sy3073w88EJmx
 B9vRgbA5NomDLco9Td7A1dpTX48L/n4MuVEYNLP/Czr2D9t3l93PaJq
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Current implementation describes only MFD's own topsys interrupts.
However, max77705 has a register which indicates interrupt source, i.e.
it acts as an interrupt controller. There's 4 interrupt sources in
max77705: topsys, charger, fuelgauge, usb type-c manager.

Setup max77705 MFD parent as an interrupt controller. Delete topsys
interrupts because currently unused.

Fixes: c8d50f029748 ("mfd: Add new driver for MAX77705 PMIC")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Max77705 has a register, which indicates, who is triggering irq. There
may be 4 irq sources in max77705: charger, fuelgauge, usb type-c
manager ic, and so-called 'topsys'. Hence, max77705 mfd parent device is
an interrupt controller. This series implements interrupt controller in
max77705 mfd.
---
Changes in v2:
- remove unused interrupt declarations
- Link to v1: https://lore.kernel.org/r/20250831-max77705-fix_interrupt_handling-v1-1-73e078012e51@gmail.com
---
Changes to v2:
- delete topsys interrupts declarations
---
 drivers/mfd/max77705.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
index 6b263bacb8c2..423709d31925 100644
--- a/drivers/mfd/max77705.c
+++ b/drivers/mfd/max77705.c
@@ -61,21 +61,21 @@ static const struct regmap_config max77705_regmap_config = {
 	.max_register = MAX77705_PMIC_REG_USBC_RESET,
 };
 
-static const struct regmap_irq max77705_topsys_irqs[] = {
-	{ .mask = MAX77705_SYSTEM_IRQ_BSTEN_INT, },
-	{ .mask = MAX77705_SYSTEM_IRQ_SYSUVLO_INT, },
-	{ .mask = MAX77705_SYSTEM_IRQ_SYSOVLO_INT, },
-	{ .mask = MAX77705_SYSTEM_IRQ_TSHDN_INT, },
-	{ .mask = MAX77705_SYSTEM_IRQ_TM_INT, },
+static const struct regmap_irq max77705_irqs[] = {
+	{ .mask = MAX77705_SRC_IRQ_CHG, },
+	{ .mask = MAX77705_SRC_IRQ_TOP, },
+	{ .mask = MAX77705_SRC_IRQ_FG, },
+	{ .mask = MAX77705_SRC_IRQ_USBC, },
 };
 
-static const struct regmap_irq_chip max77705_topsys_irq_chip = {
-	.name		= "max77705-topsys",
-	.status_base	= MAX77705_PMIC_REG_SYSTEM_INT,
-	.mask_base	= MAX77705_PMIC_REG_SYSTEM_INT_MASK,
+static const struct regmap_irq_chip max77705_irq_chip = {
+	.name		= "max77705",
+	.status_base	= MAX77705_PMIC_REG_INTSRC,
+	.ack_base	= MAX77705_PMIC_REG_INTSRC,
+	.mask_base	= MAX77705_PMIC_REG_INTSRC_MASK,
 	.num_regs	= 1,
-	.irqs		= max77705_topsys_irqs,
-	.num_irqs	= ARRAY_SIZE(max77705_topsys_irqs),
+	.irqs		= max77705_irqs,
+	.num_irqs	= ARRAY_SIZE(max77705_irqs),
 };
 
 static int max77705_i2c_probe(struct i2c_client *i2c)
@@ -111,18 +111,11 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
 	ret = devm_regmap_add_irq_chip(dev, max77705->regmap,
 					i2c->irq,
 					IRQF_ONESHOT | IRQF_SHARED, 0,
-					&max77705_topsys_irq_chip,
+					&max77705_irq_chip,
 					&irq_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add IRQ chip\n");
 
-	/* Unmask interrupts from all blocks in interrupt source register */
-	ret = regmap_update_bits(max77705->regmap,
-				 MAX77705_PMIC_REG_INTSRC_MASK,
-				 MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX77705_SRC_IRQ_ALL);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Could not unmask interrupts in INTSRC\n");
-
 	domain = regmap_irq_get_domain(irq_data);
 
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,

---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250831-max77705-fix_interrupt_handling-0889cee6936d

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


