Return-Path: <linux-kernel+bounces-666286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791FAAC74A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 01:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258C73A4456
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 23:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760DE26A1D8;
	Wed, 28 May 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JB7ChYUE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E7269882
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476238; cv=none; b=Tbf6QEKq07VIXgH9q7y2stY/rdfrJsy7bBR6U9AbR6c0gQPNeIyjhm2uWEOKAR5Kg9Qdc/yoh/wG9OVBmSbilpqLoGvFeNbpLgDjQ6UKQ2Na82ZgaOVj6yE4Zo20S7FRd7GZ29qMrW8QtgwAfq7pPx5fCRZLNwD4H9ahSVe0u9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476238; c=relaxed/simple;
	bh=8v1ySg90qhs2Ci8euvekTcww2bNrJTupV5iQQzU4mZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhUhxZJGJxB+qZm+4B2jLdgWax9hJXbJAUUG0XEqaEhADLMBoDV9BbgUR+/U0Acqif1Jj+jwdtsL3rURnQlfWPRW+DD9aOL7fS9Sv61zihNKu/5zkOtvBTq258Wfn+mYBvzpWQaBZNZvMKoHTiEw/UsIa2qI9A+HQ0Yu9003Jic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JB7ChYUE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SJd4ok012264
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 23:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=y0RVDEtXb+Z
	rYxOoACHkU/Phrk6vZh40R6HRQfHaDh8=; b=JB7ChYUEFyIPpPsAgc4AiVcV989
	n+HIZ7nzwVHo3QbG7I8bqDtgtq1ZGwLqS0hn4EoYt34daIXjVPcanR32HT/P9AvI
	J4GGe5z/uJSnytpUbXFAf1vPXLOJdAwu+wzW3YJmnenzlJDglMY3DC+UGbWkSCUQ
	4H9iQFq2n17g6h94qbBThsdHTxf32QQZnlaXSx10oVAkLGGkUsuWW9s3Q50jNueT
	yAgg++vUsmOABf/cIoKekeoEioLcQpHMu49MncrlQCxkGUaniC1E6/yYb4u/lvDO
	pL1AvQfs/EpxRLIogPI/Q1FLPCOHuw1mGnsSNHLkipt5V+yBX+HeRp5p9EA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691ecc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 23:50:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b26e0fee459so233535a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 16:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476235; x=1749081035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0RVDEtXb+ZrYxOoACHkU/Phrk6vZh40R6HRQfHaDh8=;
        b=vepD1Hx4G6jN9AiE7aoNpjKi+iIMDScdXvFUmP7qNihaw918v7q8PM4A5Ur7tNjFPh
         gkyUVwVP7fL7ynEwaGoFhgPoVWI3YEZZiEwm6JBRimgiVUZ2mF44v6LMprf/RJoZSiWi
         VMcG2TyRNqjLX7NU1xhsV8CTI173eKQMiY1FGTQKOrhxvLbxZxkOYxgCux9TPA3wfObd
         XVTgiuIFYtVdLPQss8+gabhkdkeXp5G49/vBL1QhmLWhszN5t2MrPG3XOcAOXvVAyMtT
         ChKWPbY9OlFPJQ+CBIgq1j9NVHUktneSuKPdVcZ5v3FUyqVBJsiySuYi0TPWNIOtUNL5
         o39w==
X-Forwarded-Encrypted: i=1; AJvYcCVsqxYpSDOjuD3sRW4Mnelg43pcwSn7kg0vNujyym7NwTzcZAn2iMWlFfiOlTu4GEj1y7ufWKnPHmY72Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+y0ZLOGE6FYN+kLQOC6MQ8CEoJG3OuIC2kqLxIESl9BPvmIu9
	SPM4hQ4tS2Qugv5HWbt/ui5HnVSuC8RfVmEqsfa18F15m6i8bn8pRQZaZ6h9Os/ytLIME5l9gEA
	drUQowcPK4NeYaaOD6BYRzUStSWqtys8mh1b2QtmHGwVuNRBEre6d5JhXbZVISFgjoUc=
X-Gm-Gg: ASbGncvl+hxzOkBabYHEXslwYc8Ds6NwYAD8wlEy8wZJyLCGKCCIa3pHnR8D/5CDzcp
	dD4jaf8olqsQQU+muDuQBDs+aht3Caxbqu4McsxQNQRvS/yIC5zeOlWOf8qfL3FH2xKqaPuRpb5
	Px8o4Fu0TKPejZ5FAcicY8voM6HX4JMvy1h+1YEnDwRBwG9+YCRpIo2d4u6FfowYQp8PD8yDRUq
	CTfByuuxR8Swqd4zjkckLoYAQC5NsgLrPzvQwFkBr1fvvOPZc6/hpMK+uNmQO71l/qBffQStE8z
	rzNUYdBN7mxkGxTUOMxxzYb4oHMmMHwtlQ7Rk/hJZCRATA746q/ut/G5DJ+040efwaTgKYie2Vw
	=
X-Received: by 2002:a17:902:dac2:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-234f679b0d0mr20127965ad.2.1748476234922;
        Wed, 28 May 2025 16:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVGGwbaP+bXYuE+VhpU8ZZGwIMgpkGumJEEhl9hEC2czJXopxUpdBvYdh5gDPywonZvYc0dQ==
X-Received: by 2002:a17:902:dac2:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-234f679b0d0mr20127745ad.2.1748476234523;
        Wed, 28 May 2025 16:50:34 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3506sm1403445ad.156.2025.05.28.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:50:33 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v4 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC peripherals
Date: Wed, 28 May 2025 16:50:25 -0700
Message-Id: <20250528235026.4171109-5-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
References: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6837a14b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=4OMqYXV_ruVW7JoEK48A:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: daZGluirUH1Y7PDTNZ8euarGonZSb7kg
X-Proofpoint-ORIG-GUID: daZGluirUH1Y7PDTNZ8euarGonZSb7kg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDIxMCBTYWx0ZWRfX5phOHP0iIiE8
 mx46yTmAGmnZzDxxhlyIlQH+TDhxXDD2p93V4j14TDR6fhHzAMlh/zK6zKG6+8DC/GAN+PvRM2W
 kMXmd7xikw2ITPT3f4ZSBuY4ZgKdDPKhAXE8FzOs1ZW++zjArfrvFEH9h9gcXGHIOG9WsnVz0UH
 D/aGwrg+wgrqly4TFqF3US80iYKgtGsRs6Fs123uSfPcwoAhdMiRjDASsa4S33DlBGMtcW/cuOy
 may3fHNo62BWfiKxcZVKXSfjXEjKYvI7WZ6QffXL39EasgopZryt6qY2pGAN8DPmZ1qmEOHc8v6
 M7osldDl8l4+1vZ0U6LjetMGPmLVF6+iWyWuFiT8T3oCtr3UeB1CT2RPtnuXxLSHy+D3Sj4t06E
 zZC7NmJGc7IfeuWi+g1Tq9HVarbHFyNtggCtZZps8gnzD3COsHH6E34wMi5tKovNwKuvfjxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280210

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
revision 2.  This revision utilizes individual temp DAC registers
to set the threshold temperature for over-temperature stages 1 (warning),
2 (system shutdown), and 3 (emergency shutdown) instead of a single
register to specify a set of thresholds.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 59a25f02a278..29ec6445fc21 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -26,6 +26,11 @@
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 
+/* TEMP_DAC_STGx registers are only present for TEMP_GEN2 v2.0 */
+#define QPNP_TM_REG_TEMP_DAC_STG1	0x47
+#define QPNP_TM_REG_TEMP_DAC_STG2	0x48
+#define QPNP_TM_REG_TEMP_DAC_STG3	0x49
+
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
 #define QPNP_TM_SUBTYPE_GEN2		0x09
@@ -65,6 +70,25 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 
 #define TEMP_STAGE_HYSTERESIS		2000
 
+/*
+ * For TEMP_GEN2 v2.0, TEMP_DAC_STG1/2/3 registers are used to set the threshold
+ * for each stage independently.
+ * TEMP_DAC_STG* = 0 --> 80 C
+ * Each 8 step increase in TEMP_DAC_STG* value corresponds to 5 C (5000 mC).
+ */
+#define TEMP_DAC_MIN			80000
+#define TEMP_DAC_SCALE_NUM		8
+#define TEMP_DAC_SCALE_DEN		5000
+
+#define TEMP_DAC_TEMP_TO_REG(temp) \
+	(((temp) - TEMP_DAC_MIN) * TEMP_DAC_SCALE_NUM / TEMP_DAC_SCALE_DEN)
+#define TEMP_DAC_REG_TO_TEMP(reg) \
+	(TEMP_DAC_MIN + (reg) * TEMP_DAC_SCALE_DEN / TEMP_DAC_SCALE_NUM)
+
+static const long temp_dac_max[STAGE_COUNT] = {
+	119375, 159375, 159375
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -73,6 +97,7 @@ struct qpnp_tm_chip;
 struct spmi_temp_alarm_data {
 	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
+	int (*setup)(struct qpnp_tm_chip *chip);
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
 	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
@@ -87,6 +112,7 @@ struct qpnp_tm_chip {
 	unsigned int			thresh;
 	unsigned int			stage;
 	unsigned int			base;
+	unsigned int			ntrips;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
@@ -304,6 +330,54 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
 
+static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
+{
+	int ret, temp_cfg;
+	u8 reg;
+
+	WARN_ON(!mutex_is_locked(&chip->lock));
+
+	if (trip < 0 || trip >= STAGE_COUNT) {
+		dev_err(chip->dev, "invalid TEMP_DAC trip = %d\n", trip);
+		return -EINVAL;
+	} else if (temp < TEMP_DAC_MIN || temp > temp_dac_max[trip]) {
+		dev_err(chip->dev, "invalid TEMP_DAC temp = %d\n", temp);
+		return -EINVAL;
+	}
+
+	reg = TEMP_DAC_TEMP_TO_REG(temp);
+	temp_cfg = TEMP_DAC_REG_TO_TEMP(reg);
+
+	ret = qpnp_tm_write(chip, QPNP_TM_REG_TEMP_DAC_STG1 + trip, reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "TEMP_DAC_STG write failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	chip->temp_thresh_map[trip] = temp_cfg;
+
+	return 0;
+}
+
+static int qpnp_tm_gen2_rev2_set_trip_temp(struct thermal_zone_device *tz,
+					   const struct thermal_trip *trip, int temp)
+{
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
+	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, trip_index, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
+	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
+};
+
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
@@ -328,6 +402,60 @@ static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
 	return ret;
 }
 
+/* Configure TEMP_DAC registers based on DT thermal_zone trips */
+static int qpnp_tm_gen2_rev2_configure_trip_temps_cb(struct thermal_trip *trip, void *data)
+{
+	struct qpnp_tm_chip *chip = data;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	trip->priv = THERMAL_INT_TO_TRIP_PRIV(chip->ntrips);
+	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, chip->ntrips, trip->temperature);
+	chip->ntrips++;
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int qpnp_tm_gen2_rev2_configure_trip_temps(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+
+	ret = thermal_zone_for_each_trip(chip->tz_dev,
+					 qpnp_tm_gen2_rev2_configure_trip_temps_cb, chip);
+	if (ret < 0)
+		return ret;
+
+	/* Verify that trips are strictly increasing. */
+	for (i = 1; i < STAGE_COUNT; i++) {
+		if (chip->temp_thresh_map[i] <= chip->temp_thresh_map[i - 1]) {
+			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
+				i, chip->temp_thresh_map[i], i - 1,
+				chip->temp_thresh_map[i - 1]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_DAC stage threshold temperatures */
+static int qpnp_tm_gen2_rev2_setup(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+	u8 reg = 0;
+
+	for (i = 0; i < STAGE_COUNT; i++) {
+		ret = qpnp_tm_read(chip, QPNP_TM_REG_TEMP_DAC_STG1 + i, &reg);
+		if (ret < 0)
+			return ret;
+
+		chip->temp_thresh_map[i] = TEMP_DAC_REG_TO_TEMP(reg);
+	}
+
+	return 0;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
 	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
@@ -349,6 +477,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
+	.ops = &qpnp_tm_gen2_rev2_sensor_ops,
+	.setup = qpnp_tm_gen2_rev2_setup,
+	.configure_trip_temps = qpnp_tm_gen2_rev2_configure_trip_temps,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -467,6 +602,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	chip->subtype = subtype;
 	if (subtype == QPNP_TM_SUBTYPE_GEN1)
 		chip->data = &spmi_temp_alarm_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
+		chip->data = &spmi_temp_alarm_gen2_rev2_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
@@ -491,6 +628,9 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (chip->data->setup)
+		chip->data->setup(chip);
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.34.1


