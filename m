Return-Path: <linux-kernel+bounces-688008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E6ADAC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571577A4906
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51663275104;
	Mon, 16 Jun 2025 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zQfKLUlk"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDA2749CD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067163; cv=none; b=CgniQ1+4b1otmHWZFalUKFNDO+SrsK1hAAGEQ52J68c3/QMrjCHm5lqzYu5bMl1ImTYGLmrRdfsIuFHWGEbuUVYbF9loFuo7ArzX5YOqiF0yUaN2CLwXJ4oKXf4iSS964ylCDpJ58AxosNtWxARF8fW8QuCnr3Ync40u2YjFPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067163; c=relaxed/simple;
	bh=6T1KeQBp4rmWNlU1Qma86j+ASrbxg9OQGXA7EMGSZJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLKqL08rGvE0elLyxe1lfxHYq0KApPkdsj33uLNl1+DTtX6aUbTyWUxsRFULAK53OUQEktkizGd34JksVW631pfd+Yl6DrxYeMNGBt03PLeNzFuiC/IP/2W85WeCTkHXbGyrvMshqXgrnD65zb1hJKBhTMJiGHvYKUDvt5vIoMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zQfKLUlk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2bb25105so736794766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750067159; x=1750671959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fypXrdQ7WoRwh8UJszw0sll00HUPmzGyG59Nh8kl2GM=;
        b=zQfKLUlkNN5DKj4gBxt1uNYPDobGy/4yMCPFn26fE6qrX4uB7U3yxuAJo1XocZhwCL
         jilixlh0a7Nr8qs4Nky+l8n013H/IN2pF+X1YQ1lrsiuF5My4pwxH/V14/Pk2YVbBU2c
         v1B5usjlVeNc8RGfyQ/gyovhj5/7dUC/1hnPS0IvaS438cMBfUJNdGmbGcGN/JPVd6iv
         vG8wHT6ynsso+T0l2L1C/8ogtkdeSJg0GaeDFWWKkKWr+gk3/LrzWl7RbLs6TlbKPhWP
         PTtrW1y+dWdgVSlydb8Jk6oirJpSzg18/0eF4QS5/ECnUNNNPaH1GK3uYix3LKJ3cU7p
         bYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067159; x=1750671959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fypXrdQ7WoRwh8UJszw0sll00HUPmzGyG59Nh8kl2GM=;
        b=CspGzujQJLStAryUjfmm8gRlupecigMK/Gg1vUJVjoZYGbxgijI1kMhSlUvYfmhG8g
         cZ5AV/SoPdHBZo2sG4n1eoVJsJ9gAiV2nMuZdXfWRKYvWtldz6ScsejJ2ZVCBnQryViY
         hXqHF/qo05hmCAZAJaBfVVSma4KAtkKOwcYqxxIOhZxPJmTC4vUykRiQ+huBy/CvPh/U
         uW01X1KqflU/PRBpjBshe+7soOpYEngH1Nmpyd8tGGGTbXFEv89X4jIHRMnCDSiOHKLK
         0btAABmiDw9Gx0YxwaTLtEK35RJNbaBH1odJmcLdexB2WIt1pOZC+SP8dpsr1pQc1i4F
         LuoA==
X-Forwarded-Encrypted: i=1; AJvYcCWhAL4LGuMTFjVEzFmU+vkXLjLCi3Ko0X4oQ6RzCGUCa1dDrxsceCTekvmkHuSd7LVTwsDjmolqy9xrtao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuogR/WJ49n76z+XZKivv4nzrBm7lURy4M/f8AugRAmi6++bf
	I/W6VsPbYr7tEye3CTsWyohKQi9/zyr1Kojtbjf+lS2p4Lfb1k6JlKV6P0ucPdyyIcQ=
X-Gm-Gg: ASbGncttKrpK6YfPhaO4ZsFb3ABq8IcxUBfwX6tWnRdTg/GXPdLSYFhMacOomdPoQzr
	S0MlXlA/9BaQZ2uQEcE1AmWLhm81WjVYFTQ3/4cZAV4SSZviEDh11gTrNlH1Zq3avlwMiAL/3or
	5KpDC2HyCbsDJUurK0ea7aKHwoP6zI16jY7uhtPOBtLLrmTpL3SBiAqbymLXLoiAGbn7Sm+rtdg
	34qKbiryw7m028sXqjJkdSo+bRp7+TdankkbecAWEjDshCjboGpt90QoFdOZg/E5l3w/eoZ6YSt
	fKCfhHtvCC5MJVsBVc12LcSqoRSX7//Y01DrdUgKUGAz/P303eVb6hyKpvB4HjEvqoDlaMVIbE3
	y7f6E4Ym4FGMGgE+1Vah98htUPVt3fiu8
X-Google-Smtp-Source: AGHT+IH9yV+hi/QlJGsqmSHikLojP9cUsj2hSbxVbBPox1DLoeCzVp+CeeeJmxb2GiJh3vMM1AVqZA==
X-Received: by 2002:a17:907:3f87:b0:ad8:9f50:d8c1 with SMTP id a640c23a62f3a-adfad416340mr869336566b.31.1750067158741;
        Mon, 16 Jun 2025 02:45:58 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c0421sm613375666b.46.2025.06.16.02.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 02:45:58 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 16 Jun 2025 11:45:12 +0200
Subject: [PATCH 2/2] phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-out
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-eusb2-repeater-tuning-v1-2-9457ff0fbf75@fairphone.com>
References: <20250616-eusb2-repeater-tuning-v1-0-9457ff0fbf75@fairphone.com>
In-Reply-To: <20250616-eusb2-repeater-tuning-v1-0-9457ff0fbf75@fairphone.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750067155; l=4908;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=6T1KeQBp4rmWNlU1Qma86j+ASrbxg9OQGXA7EMGSZJk=;
 b=rSPmTAxMUHhEb664e4u0Vys8cvPW4tmbyb/rV6Zv+yEfeN+6fhIgjJlGo3IOUtIJSOPFY43+M
 9wib0mmb16hCx5gSBR+CP/KR5UxeDUTgSInZD0AujDEsaLY7hZnJydV
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Zeroing out registers does not happen in the downstream kernel, and will
"tune" the repeater in surely unexpected ways since most registers don't
have a reset value of 0x0.

Stop doing that and instead just set the registers that are in the init
sequence (though long term I don't think there's actually PMIC-specific
init sequences, there's board specific tuning, but that's a story for
another day).

Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 63 +++++++++++++-------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 6bd1b3c75c779d2db2744703262e132cc439f76e..a246c897fedb2edfd376ac5fdc0423607f8c562b 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -61,8 +61,13 @@ enum eusb2_reg_layout {
 	LAYOUT_SIZE,
 };
 
+struct eusb2_repeater_init_tbl_reg {
+	u8 reg;
+	u8 value;
+};
+
 struct eusb2_repeater_cfg {
-	const u32 *init_tbl;
+	const struct eusb2_repeater_init_tbl_reg *init_tbl;
 	int init_tbl_num;
 	const char * const *vreg_list;
 	int num_vregs;
@@ -82,16 +87,16 @@ static const char * const pm8550b_vreg_l[] = {
 	"vdd18", "vdd3",
 };
 
-static const u32 pm8550b_init_tbl[NUM_TUNE_FIELDS] = {
-	[TUNE_IUSB2] = 0x8,
-	[TUNE_SQUELCH_U] = 0x3,
-	[TUNE_USB2_PREEM] = 0x5,
+static const struct eusb2_repeater_init_tbl_reg pm8550b_init_tbl[] = {
+	{ TUNE_IUSB2, 0x8 },
+	{ TUNE_SQUELCH_U, 0x3 },
+	{ TUNE_USB2_PREEM, 0x5 },
 };
 
-static const u32 smb2360_init_tbl[NUM_TUNE_FIELDS] = {
-	[TUNE_IUSB2] = 0x5,
-	[TUNE_SQUELCH_U] = 0x3,
-	[TUNE_USB2_PREEM] = 0x2,
+static const struct eusb2_repeater_init_tbl_reg smb2360_init_tbl[] = {
+	{ TUNE_IUSB2, 0x5 },
+	{ TUNE_SQUELCH_U, 0x3 },
+	{ TUNE_USB2_PREEM, 0x2 },
 };
 
 static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
@@ -129,17 +134,10 @@ static int eusb2_repeater_init(struct phy *phy)
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct device_node *np = rptr->dev->of_node;
 	struct regmap *regmap = rptr->regmap;
-	const u32 *init_tbl = rptr->cfg->init_tbl;
-	u8 tune_usb2_preem = init_tbl[TUNE_USB2_PREEM];
-	u8 tune_hsdisc = init_tbl[TUNE_HSDISC];
-	u8 tune_iusb2 = init_tbl[TUNE_IUSB2];
 	u32 base = rptr->base;
-	u32 val;
+	u32 poll_val;
 	int ret;
-
-	of_property_read_u8(np, "qcom,tune-usb2-amplitude", &tune_iusb2);
-	of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &tune_hsdisc);
-	of_property_read_u8(np, "qcom,tune-usb2-preem", &tune_usb2_preem);
+	u8 val;
 
 	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
 	if (ret)
@@ -147,21 +145,24 @@ static int eusb2_repeater_init(struct phy *phy)
 
 	regmap_write(regmap, base + EUSB2_EN_CTL1, EUSB2_RPTR_EN);
 
-	regmap_write(regmap, base + EUSB2_TUNE_EUSB_HS_COMP_CUR, init_tbl[TUNE_EUSB_HS_COMP_CUR]);
-	regmap_write(regmap, base + EUSB2_TUNE_EUSB_EQU, init_tbl[TUNE_EUSB_EQU]);
-	regmap_write(regmap, base + EUSB2_TUNE_EUSB_SLEW, init_tbl[TUNE_EUSB_SLEW]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_HS_COMP_CUR, init_tbl[TUNE_USB2_HS_COMP_CUR]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_EQU, init_tbl[TUNE_USB2_EQU]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_SLEW, init_tbl[TUNE_USB2_SLEW]);
-	regmap_write(regmap, base + EUSB2_TUNE_SQUELCH_U, init_tbl[TUNE_SQUELCH_U]);
-	regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, init_tbl[TUNE_RES_FSDIF]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_CROSSOVER, init_tbl[TUNE_USB2_CROSSOVER]);
+	/* Write registers from init table */
+	for (int i = 0; i < rptr->cfg->init_tbl_num; i++)
+		regmap_write(regmap, base + rptr->cfg->init_tbl[i].reg,
+			     rptr->cfg->init_tbl[i].value);
 
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, tune_usb2_preem);
-	regmap_write(regmap, base + EUSB2_TUNE_HSDISC, tune_hsdisc);
-	regmap_write(regmap, base + EUSB2_TUNE_IUSB2, tune_iusb2);
+	/* Override registers from devicetree values */
+	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
+		regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, val);
 
-	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, val, val & RPTR_OK, 10, 5);
+	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &val))
+		regmap_write(regmap, base + EUSB2_TUNE_HSDISC, val);
+
+	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
+		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
+
+	/* Wait for status OK */
+	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, poll_val,
+				       poll_val & RPTR_OK, 10, 5);
 	if (ret)
 		dev_err(rptr->dev, "initialization timed-out\n");
 

-- 
2.49.0


