Return-Path: <linux-kernel+bounces-823346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CBB86297
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299767E314E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1EC31B10E;
	Thu, 18 Sep 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muTFnNk/"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DD31355D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215224; cv=none; b=AaXL4DkdbqY9CXKzdY73Zh1PksqaKbm/l9VmDmy1V/Aq9hSRK1kmdFhCf1gPZpGtIg+T5n1E4XDZsYcTmHzg2sxJS+0m7pQrVd6ztwIzbiv0Jw57wAc94PEsNkFF9BrqzujaxX9h2EsPtw204wkNkxOPOu2CggfS/3IwZiNmvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215224; c=relaxed/simple;
	bh=2j0Z44ZuInJmH1epmNVJSQbicoshH78O9ODW3KemRu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwSNVGwhebVsB1aubZaiayQ8DJfCgLUbKrDPSIl/vzRvRI1mVH3h5YISsSTaWWY7qb31iEhRKxLW9fk+6bOtzzlF+AB+FLoeFYUBK8imTElWd/RlV3oeeiF1+C603irCrqaWyvopn7dMlUqbUPsjzucjC6wA7C6GKsWSHD6OtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muTFnNk/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b2391596dcfso74817166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215220; x=1758820020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZREYZDUdZq758mUlZEILRmYEno001nFmKaO1knNtmM=;
        b=muTFnNk/MpactNhA1EPArSVisW/N6U+I8D+xDUXzDoqWaGC5HFvfJhnoR16CSvIl2r
         5RQRT7wqz207htV38pGr7s12YBue2Ow3oy8+LSrXbxbP1a+wAtdJ8PINawLuDCE6zeiS
         hP8Vf8tk9cBr5ChduAIX/1f3b/WGOnsQGd/1EOAhu+sqJGiRntdYVKEO+osSNKsxL6yb
         KN+UX3X8ZOFm3XNZqFMta3zIya3rzm3PHdiGf0q7ZDgYhi1JTSQj1a193902IT3CWXvk
         jDVREoCoNloiNDsFi8v23qdBUeybZSVZi2OIDl/UW52JNu9xPHHGdMBLQF9At6/Gga2S
         sxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215220; x=1758820020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZREYZDUdZq758mUlZEILRmYEno001nFmKaO1knNtmM=;
        b=JJmhjDK9dTcsa0qviXdQ/8Je3Nvtn+9adYPqVsaylp9buRqoJHEhzKTEo9gIvQZ43w
         wK4ZSZ/Hfu8LldL7a33nMWZTE4uHa9jriBUw7NFwFwQr8WYTUEbZtOC0oQG4z95OU+9O
         rsN3FyJgaKe2Cy+VDtUcGn+PWXwYzZYBs4GtwxBznRpaTOeFBX7xYD3FrYv15zUBzQQd
         1FLYJA8p8J2G195UbZT2QnQoKxXWSiQBoBaV3h+5ABCAnO8GpE2WEf87ekV/+3kxanku
         n8pCSSPb0x2bDLsiXU6Q/HMMPvGHLGRVGzLTMS5gWL8z4sL6Ttf5VZ3nGWevss0CuvJx
         WwYw==
X-Forwarded-Encrypted: i=1; AJvYcCVWt09Rgd7RlXJKlHoHjHUkc3ADtOxTXOjdBGnHtsEfx4xKFqlPn3dTmN9iQLOZ9CrpNYmP5AG5dPppCqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhmRQHjUrXJ1Olen4MRmQCY2zE1wRxUjgEn7Zqeapp4i4Jqzv
	QlPeOc2VSas3TckhMweDga/BKxDX51/8Im8WlmCIus+DmmP5SC9UArmc
X-Gm-Gg: ASbGncvrVIG64ZbUlfZXM+Bj26HqLxQGueXfMk5MqW+b5DWv4wJ2Laol4cBb2gPAPps
	qx7s7+riLk4fnaE4MI7AT86B559e9/TT+U3C0v0jfQDdl2VJ6bKnw+T/4QgOLW10bKChpXViuwC
	EqH6ZERoiX2n77sLyNzCG9hT8q77fmIDDvnrNWQFOh+yQpTKJTXcLnA5iCb6p8sYDEEXT1QB2iF
	Kv+TnBjBJ0MyfMqKYx5Tz2Iou44eG4FHuuBceP4BL45WCj7zo2Q/x4QTZTrvgktnRPfRaTEZCMP
	7lVzJXKbE/PbXZuwMjY4ndVI7dsT7FZmyjmlGV+Hu8/Xds/fBNp/juN1oQzL+1j+snnxYYQ3ND5
	fBiGOxJhjHWBx6nqp+cTMKdY3d8XXW4tq72o/UKQ=
X-Google-Smtp-Source: AGHT+IHJaYAosIIgzo9wihFAu8HxJKZvFancA9c5JtlSdI6Jj/MWkdQceshUZ3VqvRkTQp7YqCTWJw==
X-Received: by 2002:a17:907:3f28:b0:b04:82bc:1dd2 with SMTP id a640c23a62f3a-b1bb25530d3mr752928366b.29.1758215219623;
        Thu, 18 Sep 2025 10:06:59 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:59 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:53 +0300
Subject: [PATCH v4 9/9] power: supply: max77705_charger: implement aicl
 feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-9-11ec9188f489@gmail.com>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=4185;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=2j0Z44ZuInJmH1epmNVJSQbicoshH78O9ODW3KemRu4=;
 b=fmL6X3MR1TCWT473mDn6c2k63zhOYbh49PlNdB88/4vGEAtaqPJdKBuUG2pnz3aeETzSKTiYc
 5G6bBnTQoaXBvtthLBVnVVi7aOPLjv8HMlCXQ+T+1F0NDsO4xrSdQxz
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Adaptive input current allows charger to reduce it's current
consumption, when source is not able to provide enough power.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v4:
- fix intendation
- use IRQF_TRIGGER_NONE, because this is not physical irq
- use dev_err_probe instead of pr_err
- remove excessive chgin irq request
- remove pr_infos
---
 drivers/power/supply/max77705_charger.c | 58 +++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h  |  5 +++
 2 files changed, 63 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 8032dfa0c9a2..168a67819a51 100644
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
@@ -445,6 +455,38 @@ static const struct power_supply_desc max77705_charger_psy_desc = {
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
+		err = regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM], regval);
+		if (err < 0)
+			return;
+
+		queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY));
+	} else {
+		enable_irq(chg->aicl_irq);
+		chg->is_aicl_irq_disabled = false;
+	}
+}
+
 static void max77705_chgin_isr_work(struct work_struct *work)
 {
 	struct max77705_charger_data *chg =
@@ -617,6 +659,12 @@ static int max77705_charger_probe(struct i2c_client *i2c)
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
@@ -632,6 +680,16 @@ static int max77705_charger_probe(struct i2c_client *i2c)
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


