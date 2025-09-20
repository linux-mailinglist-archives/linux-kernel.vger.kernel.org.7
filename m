Return-Path: <linux-kernel+bounces-825846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B1B8CEF7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4753A92EE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B931329B;
	Sat, 20 Sep 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOVJJPho"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B82ED85D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393761; cv=none; b=a4uCDVMHWDxgq5aQ00oJn0yKT9pkyb96aiEFGb8gfu7YoHmfuvJjpW+MmJBZkgUj3FZKXHFB0gqJ6zRgawVP/1qPpyiJ8pmWkDiphG3Vooc841OaJQSwHtwboCMz+w5CbkQxU1gM2PHWGhJjVovj6zVAjhuzxxUrLFacNLNBJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393761; c=relaxed/simple;
	bh=b4iQcdrS7bm3TOzXBHQmSBJ0/wI6ZrKBIZ5i97t6ofk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z9hH9BmcNejklNy1ZZMLKU/rw5bIFQnHsUAyTrOEr2ir4aR4SmsRdF54Zg/H0laXBv7LV3dpKbLL812YmCs2X5xqYrDK5Go9cPOlSd6JaG2SmS/ig2BsnGRYLgrdu439oNTKjudkLzrUC9nLej7cWCjbJdRyEtPn5AutoaDRYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOVJJPho; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0787fdb137so475687566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758393758; x=1758998558; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NxDiyVE+IXDojhyIwx6QVVRuh9HJm0jkyes3N1YF5g=;
        b=hOVJJPhoXtHEqBlOzohdnEewrGKMxEaA0ElMLZEKRrDKE0DY5yQkuRFN86zUZ2L1vX
         /KS1xB3zgn1a8g9lowk1Sf66kFakKcJoSevEfgvw2JbQ6cmggW3/85bPU5R0RUZsOql3
         4LfxDgnqpYr00KJZHAxCAZJ4Rap2BdM+kUkEWF5G9bKizRuJ7v0tcnYMACo5UhccT6uF
         USCUqsHsq1tWMHa5FzD7mZUJQxHjPNnphRNuIsrxDU6f5s1bAZxfLar3TIBL2fr/hOjw
         94PEXO0KojBJO+ZbqGa7Xiwme+B5sXI71pUslrv7opCkBNigGZxiB5Qj9E/J93QIwSDV
         t6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758393758; x=1758998558;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NxDiyVE+IXDojhyIwx6QVVRuh9HJm0jkyes3N1YF5g=;
        b=XrjyHhz7ZJn82vh8/fOMcUN9rh2APLU87KLRyAOR+qvLBJA5H2YwOuBBb8DEunU493
         6CtIIz08wI+K03AlRhR9USZCottp1gI7Ub0TlWnPGxlZ8dyJrkmRfZXT9zY2riVm++OI
         YUWFVn0BNp4GFBWajthf7kfuLb9yOUaHgP5NlBZ3RBGHhUxD1luE7YS+H03mZTHXBFa0
         t2iW7dqEhhB1NQQjRy5ZkKDomSMJRc+KAsN/7MnWRmaV2DnHSSpTtKADtHzet9PuMHE4
         kyHun4Rp9K8XLopEa1gTr/93hGDs6VtPbjR8Oxi7zQWvQotEwvUnvGsaLHq0tjF7BmOB
         78aA==
X-Forwarded-Encrypted: i=1; AJvYcCWIdUvi82/LRWDetxuW7FQxnHlccYZ95hgU22HxRsuffggcOmQVLaw1lcnrwzqf5BL5kSKD0VtAcut83mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIocmOUJmxLwMGEut7TthOM9MWcMH7XakQQ8+v2K9RqhIYYVK
	jEOIfdXeJ9aXBq6p7Tk8j62VHHaoESgEZQOWCGh/0Kk0dHIpCVL3ILzC
X-Gm-Gg: ASbGncsjkyk2+2D1b0bCphN3R3cgl+sBmHJgq7VpCUNwXWpIVEWUMjkzRxH7Cw2q2Mc
	IUt9YybV+sFUNspS6ttHkNoYKlaFzmC1mb4mJr4f6wo0BK6tbQ94U2cw/hiSs3K2VppV66UfQ80
	SdT49Reh9866jis1YmaQZH0lzEI6IXwMcXWRhAvqs3+mIvZRE606Rkeex8NvqcEuI1CdO5RNfHz
	53Xgssw0K0bruigkAOAehQUhsJknjhx6r9hY1mBaSUDmj1BGsOvcZ9tSm2nwXoqerWT33J5v14u
	OENQrZ6S/cnpG82CuL70hbmPD7xLbJpbFsWU+zOcY8BAHeDNNzED4urZiHkxr+FcrMSrCJHnoVl
	925OMx3UK9+EJhYJoJEs4
X-Google-Smtp-Source: AGHT+IEDshzckFycO+xGiBprkDL29YK8gjf/GJZWTM+8ZZ+6pf0FVfnBi6fgSJbnhEqUg3RN7Tmd1w==
X-Received: by 2002:a05:6402:208a:b0:61d:3bca:f2fc with SMTP id 4fb4d7f45d1cf-62fc0a6d1d4mr6191583a12.31.1758393757754;
        Sat, 20 Sep 2025 11:42:37 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f28511sm5539942a12.40.2025.09.20.11.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 11:42:37 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 20 Sep 2025 21:42:30 +0300
Subject: [PATCH v5] power: supply: max77705_charger: implement aicl feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-max77705_77976_charger_improvement-v5-1-aab0aef82cc4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJX1zmgC/5XOy07EIBQG4FeZsBaHa6GufA9jGqCHlqQ3oeKYS
 d9d6kJH3dTlfy5f/itKEAMk9HC6ogg5pDBPJci7E3K9mTrAoS0ZMcIk0Zzg0VyUUkQ2StWqasp
 R7CA2YVzinGGEacXAvaDKemNkhQpkTQJso5lcv1NWnNNq4suwguun8xf4mqxrlvmtaC0MIUN83
 7+XCD5cPis+PZfch7TOZbU3znSf/qtcpphgKNvWct8Kzh670YTh3s0j2vnMvsma1IdIVkijW+a
 tEYrK+jfJb0hKD5G8kFwywitdecP+kOKW1IdIUUhKwZV77YX+QW7b9gFhWkGUCwIAAA==
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758393754; l=5616;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=b4iQcdrS7bm3TOzXBHQmSBJ0/wI6ZrKBIZ5i97t6ofk=;
 b=FIXsJuOL1CplmG6WJS4MaQinVdV1vH9A+L2lK01rvFi7eqtjgdRpS8iri/mtISyg+srvm8Dpx
 xCyfi3qzOjtCkkhsRBwC/cGPY3diO+rQ6cF1XIk7PUzstno5gT1Yodn
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Adaptive input current allows charger to reduce it's current
consumption, when source is not able to provide enough power.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
This series consists of:
- max77705: interrupt handling fix
- max77705: make input current limit and charge current limit properties
  writable
- max77705: add adaptive input current limit feature
- max77705: switch to regfields
- max77705: refactoring
- max77976: change property for current charge limit value
---
Changes in v5:
- rebase on latest linux-next, dropping already applied patches
- optimize code to drop is_aicl_irq_disabled variable
- Link to v4: https://lore.kernel.org/r/20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com

Changes in v4:
- fix commit message
- use IRQF_TRIGGER_NONE, because non physical irqs
- minor rename refactoring
- rebase on latest linux-next
- patch reorder: put fixes patch first
- aicl feature cleanup
- Link to v3: https://lore.kernel.org/r/20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com

Changes in v3:
- move interrupt request before interrupt handler work initialization
- Link to v2: https://lore.kernel.org/r/20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com

Changes in v2:
- fix charger register protection unlock
- Link to v1: https://lore.kernel.org/r/20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com
---
Changes in v5:
- add _MS suffix to AICL_WORK_DELAY
- optimize code to drop is_aicl_irq_disabled variable

Changes in v4:
- fix intendation
- use IRQF_TRIGGER_NONE, because this is not physical irq
- use dev_err_probe instead of pr_err
- remove excessive chgin irq request
- remove pr_infos
---
 drivers/power/supply/max77705_charger.c | 55 +++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h  |  4 +++
 2 files changed, 59 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index b1a227bf72e2..ff1663b414f5 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -40,6 +40,18 @@ static enum power_supply_property max77705_charger_props[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
+static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
+{
+	struct max77705_charger_data *chg = irq_drv_data;
+
+	disable_irq(chg->aicl_irq);
+
+	queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY_MS));
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 {
 	struct max77705_charger_data *chg = irq_drv_data;
@@ -445,6 +457,33 @@ static const struct power_supply_desc max77705_charger_psy_desc = {
 	.set_property = max77705_set_property,
 };
 
+static void max77705_aicl_isr_work(struct work_struct *work)
+{
+	unsigned int regval, irq_status;
+	int err;
+	struct max77705_charger_data *chg =
+		container_of(work, struct max77705_charger_data, aicl_work.work);
+
+	regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);
+
+	if (!(irq_status & BIT(MAX77705_AICL_I))) {
+		err = regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], &regval);
+		if (err < 0)
+			return;
+
+		regval--;
+
+		err = regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM], regval);
+		if (err < 0)
+			return;
+
+		queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY_MS));
+	} else {
+		enable_irq(chg->aicl_irq);
+	}
+}
+
 static void max77705_chgin_isr_work(struct work_struct *work)
 {
 	struct max77705_charger_data *chg =
@@ -617,6 +656,12 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	ret = devm_delayed_work_autocancel(dev, &chg->aicl_work, max77705_aicl_isr_work);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+		goto destroy_wq;
+	}
+
 	ret = max77705_charger_initialize(chg);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to initialize charger IC\n");
@@ -632,6 +677,16 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	chg->aicl_irq = regmap_irq_get_virq(irq_data, MAX77705_AICL_I);
+	ret = devm_request_threaded_irq(dev, chg->aicl_irq,
+					NULL, max77705_aicl_irq,
+					IRQF_TRIGGER_NONE,
+					"aicl-irq", chg);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to Request aicl IRQ\n");
+		goto destroy_wq;
+	}
+
 	ret = max77705_charger_enable(chg);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to enable charge\n");
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index 6653abfdf747..031c1dc2485d 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -123,6 +123,8 @@
 #define MAX77705_DISABLE_SKIP		1
 #define MAX77705_AUTO_SKIP		0
 
+#define AICL_WORK_DELAY_MS		100
+
 /* uA */
 #define MAX77705_CURRENT_CHGIN_STEP	25000
 #define MAX77705_CURRENT_CHG_STEP	50000
@@ -185,7 +187,9 @@ struct max77705_charger_data {
 	struct power_supply_battery_info *bat_info;
 	struct workqueue_struct *wqueue;
 	struct work_struct	chgin_work;
+	struct delayed_work	aicl_work;
 	struct power_supply	*psy_chg;
+	int			aicl_irq;
 };
 
 #endif /* __MAX77705_CHARGER_H */

---
base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


