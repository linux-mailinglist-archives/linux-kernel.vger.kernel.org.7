Return-Path: <linux-kernel+bounces-726585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99121B00EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA751CA808A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A722C3254;
	Thu, 10 Jul 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARYWwwME"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512472BF015
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187564; cv=none; b=F0ZL72OH/sLoR7tDgKvHiENWxv9mqpIH2eTo/FBLxSrc1QCcYReCDQisHTcFTC3URqJT4qoZwNtsPbOCbQWdevYQHdjrdBe0p4nNeiGeSCSePhhnY6hWldOoRAmnQ1Zl9LJPc6Rs/HfBdeeUFDdT7HnCQx+CJihTZJmwBBfmlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187564; c=relaxed/simple;
	bh=lPBv04A+toV8WZOdRHfbvwf4kD8BRLqfW18tqoQF3iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ViwEUPKDI0MKYyLFXaq/Hi/7biRL+VzhaOxuexofcgF4ZWUYhbhNGr0TmpfYpchxDFMbDlpIvSQGGdkgtQicfqiRB5whgvtPbJuwyFyR/7P0eBvHEb8tCzLDvHunpjt0MkJqRNuMah/lhWdVv1ZdIJLda1lPm0E/9IvdTqvmWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARYWwwME; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJQrkr032490
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DB4i8v/AasE
	lbiDrSbyFxUSNsJIeniLxoLg5G/ldTFo=; b=ARYWwwMEGdc57S9AnI05VQtDY3m
	2jkEke/lAjRH0szbS7lZYyzskCnS8rN1zW6Pz4P/BHGwxnuS7ieUYS/n0iw4Gl08
	/T0F+hjh3OzhQTJQ+RV+CXi7/zkreIkRyE3AfKfCY8vuqeJfGhhVCRUGx7RtBaV7
	xmdc/JgKJmf1AwIYMndcJaWhHGaZL0D0uVgUSQe9he2uoCyJwm30LC+mPS2BBVsu
	BYVdYN6WG483/D4G1XpsfwZOdPbbNtGVD7hYjwTxtGNOE+65d57QB/syYeIiuVak
	LsSzWIRNLc5wv/x2Lu1r/xk0qX9cMU/KQHFjqh6tyBYznr5eUJeo+6Y54LQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b17hvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:46:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23692793178so13227525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187561; x=1752792361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DB4i8v/AasElbiDrSbyFxUSNsJIeniLxoLg5G/ldTFo=;
        b=DftUw4D3vqyKQV+n2YXHjLe+1ltBWm+ZKOf09hkll7YJNnDKN2PwoJCmIGYuHzDcIb
         XZuXtAKJqsB8VRygdiktibSH4hJjrbMCqsesYKJzUSk45X/cVm4u3pWEQdPoGIfLpYWS
         Gha4z0tWu094oN7nR+W+ZRRagqY5Gc28QSWOaayKoNQsfrjhC0Fq9NvamP8i2TrRkg9s
         gxUAAT5ScsNu6g5kpKKhnMbiDVjfdpw9XfH1mYP/GR7zM+xaO1beeFYa7jkdL8rx8l2C
         QyQzYCnng5rx5b9pNdbT0wA4lAh15zv+64Pps0iisLfZm51RVmbzT2izx6TC+rIEYIKT
         s3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVwljqt/6qv3/zt6hfVz2W9rLxhqKYEN8qjBGuSQU9aJa9XQcew9uPNW3h05BYv9dOqc/TQDGep0/Qx4zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTLfDtlUzFjjny3W9PMu09++5Nlp4Sxeo5f2ZPc8Dc5ilMAKq6
	BOcocw+hSFUsqkdP7C5mGfBABRVBc1v45LcIrXHg4riuAvvE7YWFdxp2vHBek1+GcVshymn127o
	0l/LrIv6oMK9CutJQ31S+lvAnf7NejQ9vFy6LAC2dtXLzSkaqeDmL6HVNKHZUv8AnME4=
X-Gm-Gg: ASbGncviOOl0zTcGxoIboLQm0wK1TZWFBRhp1Ehpr79YP3Dp04fIrQdKLkFNH3BB9g/
	IaFR0nko5MVS5dLOM24DkBBEfNymT7ZirO/zblQAM1Qk7ukoNx06qwmk6p1eHEEA3c3J1+sUu8N
	nGcv3rlclPjOe1SnRmFP+puNyTBf7nZNVEU1dEdjjFsFig1BOsPLE+jzUv8jsNfGCSvWJLIViAG
	TmB4guTP4zj+D9HK/wlywwRwBCC3Ya7BmQt6CqRPKcOCWgOsuj2n2ewlWSdRlIhZutzfY9WELms
	UyYHGuK2sIxTCYOBI1nSZaKgYcSRB/E4Hxa0OzfZWoz+EkHOUuwX8wJZFbFqW0mmfZsHUVcQ3Z6
	nQN9pf6+GOp4ko9y+kOH96XwSeP0=
X-Received: by 2002:a17:902:d586:b0:234:909b:3da9 with SMTP id d9443c01a7336-23dede860e5mr13179515ad.27.1752187561321;
        Thu, 10 Jul 2025 15:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGsHHH3QEMr3onM8+s+jPWCUGCCRaJbbIUFVY5SnFyVHssHV5KFq/OmOLdd94659u73tp7w==
X-Received: by 2002:a17:902:d586:b0:234:909b:3da9 with SMTP id d9443c01a7336-23dede860e5mr13179315ad.27.1752187560911;
        Thu, 10 Jul 2025 15:46:00 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:46:00 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 3/5] thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp Alarm subtypes
Date: Thu, 10 Jul 2025 15:45:53 -0700
Message-Id: <20250710224555.3047790-4-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
References: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=687042aa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EDJ0a-WMmjN7NLPDzUkA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfX6xnbzCc3qubA
 8C6irDRIn1TxqbSEC9uncEl1kGl+bmkKJE/obof2bro1lsx3RuiYqDfcUonxmzVuTED2xqtHSvC
 5MAk8Dg8Hu+IeP79iNqPNpmLWZtu4VKvxlK/CV+wKKGnKF/FgQp4Eh8qpTowzcjPHZbXEW/PSZf
 H5cfDmrVnQWbvNfphikjFxgrNE6eVZIcc3TPSZ0qmBkdZkQ9Gpm5xrKRSc+EOLmsYlj5JprvWQw
 qcAckLoieMbizInWCWeeK/6o0CXGNso6Mq0qUsmsfV540zhNqasMBTmK6C1XAIfOI+dK7QwCWMO
 YP7grqzEbnyd8YvMlrCV819g0ci55oiLOuKKgp1qkSSPUi+cLYOkjx2XBb0zgsXIE+zFs5OIUpX
 r59edhynLlFR8jDoYx6HTqwUWQGKNXdlwtSiG16KoLYUa6ZopmLUt+BK3n+S7esGfTyXxlhL
X-Proofpoint-GUID: PkcYwzzLDeftFq391nzBck8z6WhMoY_G
X-Proofpoint-ORIG-GUID: PkcYwzzLDeftFq391nzBck8z6WhMoY_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100191

In preparation to support newer temp alarm subtypes, add the "ops",
"sync_thresholds" and "configure_trip_temps" references to
spmi_temp_alarm_data. This will allow for each Temp Alarm subtype to define
its own thermal_zone_device_ops and properly initialize and configure
thermal trip temperature.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 92 ++++++++++++++-------
 1 file changed, 64 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 607838162c7d..c8e4db585d2b 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -77,8 +77,11 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 struct qpnp_tm_chip;
 
 struct spmi_temp_alarm_data {
+	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
+	int (*sync_thresholds)(struct qpnp_tm_chip *chip);
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
+	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
 
 struct qpnp_tm_chip {
@@ -316,64 +319,95 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Read the hardware default stage threshold temperatures */
+static int qpnp_tm_sync_thresholds(struct qpnp_tm_chip *chip)
+{
+	u8 reg, threshold;
+	int ret;
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, &reg);
+	if (ret < 0)
+		return ret;
+
+	threshold = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
+	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
+		sizeof(chip->temp_thresh_map));
+
+	return ret;
+}
+
+static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
+{
+	int crit_temp, ret;
+
+	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
+	if (ret)
+		crit_temp = THERMAL_TEMP_INVALID;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.sync_thresholds = qpnp_tm_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen1_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.sync_thresholds = qpnp_tm_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen2_v1,
+	.sync_thresholds = qpnp_tm_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
 /*
  * This function initializes the internal temp value based on only the
- * current thermal stage and threshold. Setup threshold control and
- * disable shutdown override.
+ * current thermal stage and threshold.
  */
-static int qpnp_tm_init(struct qpnp_tm_chip *chip)
+static int qpnp_tm_threshold_init(struct qpnp_tm_chip *chip)
 {
-	int crit_temp;
-	u8 threshold;
 	int ret;
-	u8 reg;
 
-	mutex_lock(&chip->lock);
-
-	ret = qpnp_tm_read(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, &reg);
+	ret = chip->data->sync_thresholds(chip);
 	if (ret < 0)
-		goto out;
-
-	threshold = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
-		sizeof(chip->temp_thresh_map));
-
-	chip->temp = DEFAULT_TEMP;
+		return ret;
 
 	ret = chip->data->get_temp_stage(chip);
 	if (ret < 0)
-		goto out;
+		return ret;
 	chip->stage = ret;
+	chip->temp = DEFAULT_TEMP;
 
 	if (chip->stage)
 		chip->temp = qpnp_tm_decode_temp(chip, chip->stage);
 
-	mutex_unlock(&chip->lock);
-
-	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
-	if (ret)
-		crit_temp = THERMAL_TEMP_INVALID;
+	return ret;
+}
 
-	mutex_lock(&chip->lock);
+/* This function initializes threshold control and disables shutdown override. */
+static int qpnp_tm_init(struct qpnp_tm_chip *chip)
+{
+	int ret;
+	u8 reg;
 
-	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+	ret = chip->data->configure_trip_temps(chip);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/* Enable the thermal alarm PMIC module in always-on mode. */
 	reg = ALARM_CTRL_FORCE_ENABLE;
@@ -381,8 +415,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 
 	chip->initialized = true;
 
-out:
-	mutex_unlock(&chip->lock);
 	return ret;
 }
 
@@ -481,13 +513,17 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = qpnp_tm_threshold_init(chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "threshold init failed\n");
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
 	 * before the hardware initialization is completed.
 	 */
 	chip->tz_dev = devm_thermal_of_zone_register(
-		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
+		&pdev->dev, 0, chip, chip->data->ops);
 	if (IS_ERR(chip->tz_dev))
 		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
 				     "failed to register sensor\n");
-- 
2.34.1


