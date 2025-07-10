Return-Path: <linux-kernel+bounces-726583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C7B00EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AC01CA7FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D44202F7B;
	Thu, 10 Jul 2025 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K3pkjYIp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F829ACED
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187562; cv=none; b=mEdFmg/2omyUfpuokZKJg/9un9649251ZJB/XteffmVPFvrc4SZh5CLOgM0iS8ZHxos/B9aJtLiA5I7/XtCOHhzzs2NuZcYUjwk5uVIjvQuJ5b1VW38sy9y2mRWF8p7WfiK9tcJiMkC60zu5Ke8eFtGYW2oSZ45uhvGkezOj+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187562; c=relaxed/simple;
	bh=/G3yjvmAIVn8+g+OKZB3AzxtfHQGlX8eD13Fl1ZcDVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwqDUAWEQPwyC7ojjjH17SQ9Wh35+3o5IzHW32/ONTRySkVbXN6ft8nFoMLqaQQh1e2V5zBbTaLiopj1bLSzLPx+5wRSjFZppXgd5kkmCqXWGK24dmzUPjCtGGVQzDfuY4zsCQZM5ooIj8CXwRYF2J/jzaimMd2PckxoWfG2O0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K3pkjYIp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJRYBS031478
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2+Bx4W9mabN
	GnGAOk9vdoVwnLh7nIUmtj3EmkWbgNNA=; b=K3pkjYIp8d8+u3U3e5+oWQz9k2R
	WuffzfWkg/YGs7d8nMG3sen+wNdeOFZbN+t6M5WIK3SvrXN87ACzusn5YOyftgUQ
	hbWfhCiqKiELxgQ8uvtiiNJNS6eWy0w5m3v7YxInF66r31RFiKQt/7iJ0O2d3JYr
	KCz1RE51UpO7/276rrHBDnPel2p61UpWnad5Q2F10NXWPi4Z89NO0U7wMnBYJRMU
	K1h1AMzRHRbX88JQOx5U6PyiumCVFvCFVfdaLtqMqZKLW0/unYucI1ZNQ6cZ0HaY
	Y2Kql93yF67mfBJDj9W9ss/GpLfj5x+JfLETi+6yafhdtC+F4e8FA2Ipvbw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf30fhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:45:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2349fe994a9so12957735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187559; x=1752792359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+Bx4W9mabNGnGAOk9vdoVwnLh7nIUmtj3EmkWbgNNA=;
        b=ULv4JDOcfJP7i1zmG0PHWV0J9QvvUT9si2Yi7z49YiJRhDf7MJL1RkTvaS9UCYEyFC
         MA0WRF7ksfH3Xd0lVHe40hMH3iY88EHWuDaPk0U2i3+gr03I077RP+1A+f9j+JYvCiaG
         K7zS70Mo/6WUswX49Prj13bfP0gtvTiIGeYAPV5m+yIvmlINtdYVqwtexCmY/EjVhmJ4
         r+BQJtaa5INdsN6zsGWaWyUtIYOC4MVLcE1nkCnEm8OPw6gqKQX29f0UNfRrbS4VgAwA
         47VnpnOzMXIAe/gcLaZCypntoWd2vzmxefUQUsXjmy4d8DPGFr2vFrfYK5xa+o53WZmE
         UWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVvY4O7SyZqlBKx8VqGK51lkYQxOZco61pgNd1rQJDwjen9wPVzM07D3GtzOIkONK4PMUtcpBsRV9mTR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFgEOCpW/Ndu42FLdaCqUOppWEfULcv2LO5eQXfTbtjs+lzdo
	DBinzJ7VR6AWFethhfFcyAXfDxy+EXIdl8DWLOtHQqp+vFD5QBKzPNJXcbB2LQnHzmDnlM82oLF
	xJl34VLQLsLsQmd4yg2k9Q8twyAoll6n9m6uo9gqBFDMFp3h3O3GoXARp42vxN4bG9wM=
X-Gm-Gg: ASbGncuj5/RgN83XjOX8xqJKswTnmmneqot8AepIirZZY6XRUTtp2oNEqAOYUABejWh
	SZpU45xZD4fJCXLJcxNuIx+FCLTLZHtFBnj23sUc+5TzYdZTYWN2votqnT+o3mxCAgWc9xUBilS
	Nustojh7XYD0/jMsUh32ZxrOuSUMSAWkq1dGYbvJDtm89aVqpyBWdDULshpZ1Tbetua2/5N/ZDt
	9qxNEwqadMaVhofexJMdrxgLgpf8XG2GYD4JHtm6CsxOSmVb/aST1/vwgSS99ZZ+xdAq2YYXruS
	quAw2+wQBBBzwpQuGAfTO31ypJ3ZIhgtDPqgX7wcLEjUCYofjgngK+5yuldFU38B1GW70ssnQEC
	j7WHaZiTkXqKbNFgthqx4gRonjMU=
X-Received: by 2002:a17:903:b8e:b0:237:ec18:ead7 with SMTP id d9443c01a7336-23dee27d2f0mr12009245ad.24.1752187558561;
        Thu, 10 Jul 2025 15:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+kL17WYIoYYBJY3WzQsljLuG5yOgF0j4V2/C1bfca3Lxbq/ar9/HqaY2SNZCXXYtPSrSpiA==
X-Received: by 2002:a17:903:b8e:b0:237:ec18:ead7 with SMTP id d9443c01a7336-23dee27d2f0mr12008945ad.24.1752187558101;
        Thu, 10 Jul 2025 15:45:58 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:45:57 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date: Thu, 10 Jul 2025 15:45:51 -0700
Message-Id: <20250710224555.3047790-2-anjelique.melendez@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfXzrmpsll4NuF1
 NwkeipieOVzYCv7BlFkgt63alv3IC+8opzRMW3gfP+TpXbV0G17VfdxKMTPycFrT7nFkEgOGMFk
 Qnp+fhl0ToGpwtfESf2jaMT87jDsPEfrjC0HVtPqH+J59tZSglojq3lzc6akv5K9AbH/ZD8jqlZ
 FuMyYVvhQfnM6MGICItxpvxNZoC1QgfE0I7xyj94WXHZLtN3y3wG1VI+B+OemJqPWFJ9MV9awbT
 RNcSVRZYpHxtaJmLyXYNJDXhySBablwt0xL5D8T9/q1GpRbCti6xuwfJJGHjJsgiEViNtosV5Au
 YPd2+0IrOjOi4Y9MbOu5Xng/vo4eEhuGLvVBPxLlMPEns/p4DcOTb3TUZj2pbwD5YPv4m+DN7O3
 73LWohqS19b0ymjMHN1fRuqm8sa+AYqmfL/6iDZb+s8B2pRgGntvBGFiO+2haZDBoov5ccsw
X-Proofpoint-GUID: R18P7Vd8B95mTiFtN8_UPZVMFZCxPBEE
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=687042a7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=2ebS6B6wQDVqfW-kuUgA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: R18P7Vd8B95mTiFtN8_UPZVMFZCxPBEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100191

From: David Collins <david.collins@oss.qualcomm.com>

Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature stage 2
automatic PMIC partial shutdown. This will ensure that in the event of
reaching the hotter stage 3 over-temperature threshold, repeated faults
will be avoided during the automatic PMIC hardware full shutdown.
Modify the stage 2 shutdown control logic to ensure that stage 2
shutdown is enabled on all affected PMICs. Read the digital major
and minor revision registers to identify these PMICs.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 43 ++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index a81e7d6e865f..4b91cc13ce34 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bitops.h>
@@ -16,6 +17,7 @@
 
 #include "../thermal_hwmon.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -31,7 +33,7 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
+#define SHUTDOWN_CTRL1_OVERRIDE_STAGE2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
 #define SHUTDOWN_CTRL1_RATE_25HZ	BIT(3)
@@ -78,6 +80,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_stage2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -220,13 +223,13 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 {
 	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
 	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
-	bool disable_s2_shutdown = false;
+	bool disable_stage2_shutdown = false;
 	u8 reg;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
 	/*
-	 * Default: S2 and S3 shutdown enabled, thresholds at
+	 * Default: Stage 2 and Stage 3 shutdown enabled, thresholds at
 	 * lowest threshold set, monitoring at 25Hz
 	 */
 	reg = SHUTDOWN_CTRL1_RATE_25HZ;
@@ -241,12 +244,12 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 		chip->thresh = THRESH_MAX -
 			((stage2_threshold_max - temp) /
 			 TEMP_THRESH_STEP);
-		disable_s2_shutdown = true;
+		disable_stage2_shutdown = true;
 	} else {
 		chip->thresh = THRESH_MAX;
 
 		if (chip->adc)
-			disable_s2_shutdown = true;
+			disable_stage2_shutdown = true;
 		else
 			dev_warn(chip->dev,
 				 "No ADC is configured and critical temperature %d mC is above the maximum stage 2 threshold of %ld mC! Configuring stage 2 shutdown at %ld mC.\n",
@@ -255,8 +258,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
-		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
@@ -350,8 +353,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
-	u32 res;
+	u8 type, subtype, dig_major, dig_minor;
+	u32 res, dig_revision;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -402,6 +405,11 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not read dig_major\n");
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read dig_minor\n");
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
@@ -415,6 +423,23 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	else
 		chip->temp_map = &temp_map_gen1;
 
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
+		dig_revision = (dig_major << 8) | dig_minor;
+		/*
+		 * Check if stage 2 automatic partial shutdown must remain
+		 * enabled to avoid potential repeated faults upon reaching
+		 * over-temperature stage 3.
+		 */
+		switch (dig_revision) {
+		case 0x0001:
+		case 0x0002:
+		case 0x0100:
+		case 0x0101:
+			chip->require_stage2_shutdown = true;
+			break;
+		}
+	}
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.34.1


