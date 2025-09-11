Return-Path: <linux-kernel+bounces-812650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D324BB53AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791325A7677
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA736CC9F;
	Thu, 11 Sep 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAoTfLtF"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51436C068
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613448; cv=none; b=n9x2TIMaTLbyeohrSYF14axjQwU2YuMBHB9ANWU1SwM9Bp+nk/Ir08zX18qSk4lDh71Fzm+x4rU3HfT/4YXqI+U/X+dCKlHUFRZlQ4fr4WErlSHFKKWGIeVmmPvDHXIyM2xzindIdeuCTHMsEf43PdsebyqiL2Sot1Y4YfuqVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613448; c=relaxed/simple;
	bh=KN+pE4h11vlgMVCFVyty9w4n7joSzAuWRjWGP99v1fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IU2xkk6AZfqevWVdfNSOEl2OU3y7AJc8gZyXK4ksscM7q3rdHBBUKxVQBmVWEXlRZl9nHm+s1J5fVeLa4trGq1wqsgfiVIAbkP5QseGfcXhCd9Zh/H/YRNH1ztIeItgamRy9C3hCVBBOhHUofa3FsQloTBXTaDDPpvVKaHDZhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAoTfLtF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04770a25f2so143868366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613445; x=1758218245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzjo6MWwCNOQylCqR1hNpsDJ1s02PoW9fHOpS6lKCv8=;
        b=YAoTfLtFBANkcau+b7T57NKB+LKYITnWcUi6wxpsXYDTXtZimiZIbX+3DrL5RPYWVL
         kYnCNGz5CkGuDv4F43h3WHlWg5szJBPg5Ui8uubeh5vMVptc7gK8DlEi6s3FzEN+buzB
         AoOhFddxI8NxTSEczj7AOKYN+Giq0kDzwIWjUi9lPiiMQcUIE7lGcxLXPK803pAWa6XM
         1OLyE6xOYYaPHbOkf8d/0O1EW64Bu1OR72Cw/3SW+gM4t295+2Qq6KDmwsC4gFLKoeJl
         ZD7O4Fw9NE99mLkohkX/mtS+gl0Sst8GdqqJDW1TjVvUIRIf+PMhDZ8vTm5usylxaVEE
         WPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613445; x=1758218245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzjo6MWwCNOQylCqR1hNpsDJ1s02PoW9fHOpS6lKCv8=;
        b=Rj8UMW5f2xA8MAKUj99saooEFSIdQTyryns3jaHMNWVRIo2r5J5XNrehSIdFDcQ5We
         ej5sWyEQ982JPve4EbmYPVGIy8GzabXv5szUE6wiPipIt6KuSf7hwOTdhJJNIZ6oclxw
         CzlEiu4D/a2TB99lV6PrU/yrogIISlCJxRJLs1cFf0RVVrJ+AbIZoQCqf+EM7FPDpIbM
         cQewx19F2Cj92Mza8QJVP8BX+50+07xujuebPalYAmCxKxldanBecn/aSK0TYg+j6gbN
         WCvJuHxnPeAJTZQectnmJzP2T+w1y7fSUSmgN6Xd+2O1qgBY+v/ldraDEALQ20JoQDe2
         9OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo9m4cLn+Y1lMQSATYr2EHydM9LkZ1urTYF/hqFy9bM1ktmPO7doav11WPV9fAv0l+CVVGQ7DTZyUTyDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvn+oOirgef03aEyMbxUcBD80ZvvYMvYWqo1PwjC5tbin68qd
	sSYRNt1Qpfgis4OnQkVF8LEZwYPCzr0Ie9Svbg0dMBeSgzwwbIn1LDqo
X-Gm-Gg: ASbGnctnB0Sn+KjKGxoAm4NFlSg3QLJ0Ob7erViC34v9eofdJJuFJEW/crHZUv49NMW
	0Pi6LpRwBtiNQguW7v/xBIp7rxMgNwdHaZX+Mk3X25qvU7xGEEFBQVWh5c6TWqwVGqNbn/eE/r9
	yOO5nStJJM8guK9mfn+YoVC7EktuiVhNzIZnRu1g5bXz5fYAeBS54rdQ9KZELWENPFvjlzy4vpL
	AChEJUmW5lRVEgb6WrhIRRi2dWRz4VrooH98G+T/Q9+AWGguq5nn6m7oibHJgnkWv+jlxq/GEPW
	D+Sr3MtE4UM7c1uoxMFVYpFCwd8OqBZq01L4NouBJ4R4pVz/gLSr97RGEYFjgnR+AvaHXJ2UAKc
	KAQxjZ/L1CGmJaM/zlzsT40iO/oMa6FU=
X-Google-Smtp-Source: AGHT+IHi5/SUGJH0BgMRqINq8+nyl3PJ+DnoKOlrkkk7UHR9uuNELGc4iw3MJ9DIkZGl++SZKxmtMQ==
X-Received: by 2002:a17:907:60d4:b0:b04:27de:12ec with SMTP id a640c23a62f3a-b07c354e8b1mr3692166b.4.1757613444498;
        Thu, 11 Sep 2025 10:57:24 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:24 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:16 +0300
Subject: [PATCH v3 8/9] power: supply: max77705_charger: implement aicl
 feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-8-35203686fa29@gmail.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613434; l=4655;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=KN+pE4h11vlgMVCFVyty9w4n7joSzAuWRjWGP99v1fE=;
 b=ZTQjbFQfryjNwsFFGkl25VcOQJ0oJnVKR+34ealXy7C7JddwIBDMZP7VqLQyx7YgPFLk+i4Cr
 IVtofBcFpflDZoSuHIdujRVXQqsskeEWaEQFob7djugU977e8wyeHmQ
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Adaptive input current allows charger to reduce it's current
consumption, when source is not able to provide enough power.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 70 +++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h  |  5 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 940cf3bf6d1a..a943efc67546 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -40,6 +40,16 @@ static enum power_supply_property max77705_charger_props[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
+static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
+{
+	struct max77705_charger_data *chg = irq_drv_data;
+
+	queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY));
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 {
 	struct max77705_charger_data *chg = irq_drv_data;
@@ -445,6 +455,40 @@ static const struct power_supply_desc max77705_charger_psy_desc = {
 	.set_property		= max77705_set_property,
 };
 
+static void max77705_aicl_isr_work(struct work_struct *work)
+{
+	unsigned int regval, irq_status;
+	int err;
+	struct max77705_charger_data *chg =
+		container_of(work, struct max77705_charger_data, aicl_work.work);
+
+	regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);
+	if (!chg->is_aicl_irq_disabled) {
+		disable_irq(chg->aicl_irq);
+		chg->is_aicl_irq_disabled = true;
+	}
+
+	if (!(irq_status & BIT(MAX77705_AICL_I))) {
+		err = regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], &regval);
+		if (err < 0)
+			return;
+
+		regval--;
+
+		pr_info("aicl call. regval: %d\n", regval);
+		err = regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM], regval);
+		if (err < 0)
+			return;
+
+		queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY));
+	} else {
+		pr_info("aicl finish\n");
+		enable_irq(chg->aicl_irq);
+		chg->is_aicl_irq_disabled = false;
+	}
+}
+
 static void max77705_chgin_isr_work(struct work_struct *work)
 {
 	struct max77705_charger_data *chg =
@@ -607,6 +651,16 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add irq chip\n");
 
+	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_CHGIN_I),
+				 NULL, max77705_chgin_irq,
+				 IRQF_TRIGGER_HIGH,
+	"chgin-irq", chg);
+	if (ret) {
+		pr_err("%s: Failed to Request IRQ (%d)\n", __func__, ret);
+		return ret;
+	}
+
+
 	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
 	if (!chg->wqueue)
 		return dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");
@@ -617,6 +671,12 @@ static int max77705_charger_probe(struct i2c_client *i2c)
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
@@ -632,6 +692,16 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	chg->aicl_irq = regmap_irq_get_virq(irq_data, MAX77705_AICL_I);
+	ret = devm_request_threaded_irq(dev, chg->aicl_irq,
+				 NULL, max77705_aicl_irq,
+				 IRQF_TRIGGER_HIGH,
+	"aicl-irq", chg);
+	if (ret) {
+		pr_err("%s: Failed to Request IRQ (%d)\n", __func__, ret);
+		goto destroy_wq;
+	}
+
 	ret = max77705_charger_enable(chg);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to enable charge\n");
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index 6653abfdf747..92fef95e4ac4 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -123,6 +123,8 @@
 #define MAX77705_DISABLE_SKIP		1
 #define MAX77705_AUTO_SKIP		0
 
+#define AICL_WORK_DELAY		100
+
 /* uA */
 #define MAX77705_CURRENT_CHGIN_STEP	25000
 #define MAX77705_CURRENT_CHG_STEP	50000
@@ -185,7 +187,10 @@ struct max77705_charger_data {
 	struct power_supply_battery_info *bat_info;
 	struct workqueue_struct *wqueue;
 	struct work_struct	chgin_work;
+	struct delayed_work	aicl_work;
 	struct power_supply	*psy_chg;
+	int			is_aicl_irq_disabled;
+	int			aicl_irq;
 };
 
 #endif /* __MAX77705_CHARGER_H */

-- 
2.39.5


