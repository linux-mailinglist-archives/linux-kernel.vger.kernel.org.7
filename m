Return-Path: <linux-kernel+bounces-862102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE5BF470E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 907063517CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB072ECD2E;
	Tue, 21 Oct 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kuJWota4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216EA2D73B1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015585; cv=none; b=MGlmRr6FDC5GpxArA/VLNQ+30ikBrA+YjIjGpiCy6Qv+QkHN2I/sZ49sUD1eL1sYlflax3Fyc/UNCRDZRZGqjRoY46i11B05AynhQ10tq6VeEvogGrZValcGTG0PAB1tXWQoB+IjDiA5FMFNmjGxooGeWW0PnJ3wXXll6HGupIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015585; c=relaxed/simple;
	bh=V1XfqCC6nbnD0O82nSGZMLcuwnInkivDaUiYdzceWBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHzEt3eGj1ey0FbSHA4nh3ZFDSadk5ZxaSe/TFmAD2S7kPxPzVbD6rZ21kdkHY4qmfI1eGqAbjcg6mpq+M5PfjJPpGqI0xLVqQsKT7bK3fKVfMy17qcgoER1vWBh0kFJBGa5wYfvqXAcWoCuMFsVCpmciWYAD7m5Rz4PawyU/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kuJWota4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0rO7029835
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i0f90fRdL4s
	TyW659ehVZ/1JvYs/o2P+R8QMO8174W4=; b=kuJWota41QM7uCo9alSHKkeivfI
	i4Ftwy22wFuUFQI12LdwoSRA985a5udSY7fxv6P7ZfjZoljd8lGUzZLuXX4FwpWk
	XjRrgYrFheWapB1U8VYuRN7m1SziiHUY++9qTDADQvmJc3frondYpxmBxmWKG8J1
	RGwZ1YZpTVJG/QUtiBB81/Cz1awy4yyIl72R2XDXGFIRC6eLImqa3nWFdBXVyPKC
	9tCiwYVPlws3dq/EWc5cEUviw75h6lP+BqNUTAo8YJLZE4HpyADw1b+BBVyKiEE1
	Pa7911vtZi+qDcbWzWbBq1cIGDhZzyTXoprXyCYz14wGdHEk1Bp2oVZrdWQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdxwht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781269a9049so8797488b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015580; x=1761620380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0f90fRdL4sTyW659ehVZ/1JvYs/o2P+R8QMO8174W4=;
        b=JGVw2TuNcwXQNg4Vhxe3SWkyAH0+oMCcEGHwijDw1vhp+ujgpbFMtwqJWWal0ugGyG
         Bvg67zt4IIfdVJyp1XC5htGTthiK2WsG67RTU0rAq6ImaDmEl5rkiZckaZBPoCOYwLKm
         oOyfFbsth0zrxMvs0K/lJKBWeWxAN+/K+0fLa9mIGnugoxGla9TrhN/T7BaaYUxi+9qG
         GBnnR8+0L3km3W7JzT46n+7iAW+yM4xaXW9j39ITXckMTViKTnwbwZ8sOT7kJeJ2JI6Q
         dgF8NeSDMkuletQxt08ZCYSdBjr9zHC671NNDOUWi/SZKOVYLvAyCSlj3dhp/zkA/NZc
         S1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVSStD5DVHzA64W4e+jK8kyPR3Ct8YMSi31ni3OkM3whTQlPuaE1j45AkGKxJp5BpwEN7ORP46e3xHZt4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHSEPzZSjQzMncB08CJcwVkFjtVSVC9U+9Cvha0eV1Rvknfvu
	zprNpRnEVsMIW2l7KzIwOr/wVB5QrI9AYBZfUV705YY+44fKWsnKuuoU+t8TW2C4qzWqsROEnUi
	/fZFC0iQOI/SRA1GHklOCS8UM2mOs2NqOk+ZlKthZUsgGCmNMH8M7vtnu9W+ezr3jC3o=
X-Gm-Gg: ASbGncuyWg8zXmU5/XKFHqNA+B0phKeqLa7O646PmSXrrUv9pZhyI3AzHT3Jv8skqnC
	4N2kZp4nGPLHijGl06iVMV3QTB+kP2N93q1Qv+jU/4NEHAaKhM24fzKTwQeTRpntAgfSv7qNKBa
	yHpkd64sDUSLZkdMELK+/s6mqvAx60q76IxWSid5OEbD+e7O0UYQ9OIUCggQCCyUghuS9opNSv6
	Xs0UWn4rjuTm1X8p92r00rALnggDnt0Xyq3WQWjpaxFtjwy3hoyoEK+iaM3Fj36D89jm44DK4c2
	UxmVBS6PIHM5pGLCwfbcNCdvjOLHzDTo+8xwGeIgLfYAbafEqtvCJJPRJtAHoMYdEWFQ2s2YHEA
	IZQEpTnJ6p9sFDMiooqgNAyZYkYMVsdESKgOpSpQp8emNouISM+0B/w==
X-Received: by 2002:a05:6a20:939d:b0:334:a198:e5ce with SMTP id adf61e73a8af0-334a850c06cmr21104874637.26.1761015579829;
        Mon, 20 Oct 2025 19:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW9nTuJj0l/PTXheeSMyHEdq1V6Ei8rJHP+3c5fROBnrYtEj7XzZjpP9AK+FplzBXQgQ5h5w==
X-Received: by 2002:a05:6a20:939d:b0:334:a198:e5ce with SMTP id adf61e73a8af0-334a850c06cmr21104843637.26.1761015579338;
        Mon, 20 Oct 2025 19:59:39 -0700 (PDT)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8855787a12.10.2025.10.20.19.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 19:59:38 -0700 (PDT)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [RESEND RFC PATCH 6/7] qcom-tgu: Add timer/counter functionality for TGU
Date: Mon, 20 Oct 2025 19:59:08 -0700
Message-Id: <20251021025909.3627254-7-songwei.chai@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021025909.3627254-1-songwei.chai@oss.qualcomm.com>
References: <20251021025909.3627254-1-songwei.chai@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX+nwOqHDQcsb5
 eg67rxBOPDENoKoxnBQAYc5Xpt+pZF07uUtgmIDIbOes5IfNfzRytSj7whWZOtxpOEn9/05zJO2
 RAeshUEOI3mu9F9FnieWeP1rHaFaldFJEye6n19gtz7jTe9v3qTjkdHfi4iZsuOAOSfNvATSUf6
 ICKhso2egQKdCV2nL/mnUwN82WRd7oYK1DLYXlL8lrTknfNYw4j0E3QnwfZ9UeWXgmuz35Y+936
 F/vJ+mcF2NDo3Up5dEJ/cMGfkQG70+295t/1UH5h+Z+Z/zI59I9ZX6rLHdmUbB8QA58Sg0xlOyz
 IolQBA6uxZKOYJvPoVGjVmDsluMQD5rZgjfIeIoS9p6JVwPeqzwkzMQTuvtAteAUSNkrwxvpXYB
 v67+3aTeAjtfUzkUmm6i2tqsxpgu/w==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f6f71d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=SSzAInQm-58vTIUOy48A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: ZUMqDlYXX96G70kJVpG_DDZ9LhaMlmgU
X-Proofpoint-ORIG-GUID: ZUMqDlYXX96G70kJVpG_DDZ9LhaMlmgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Add counter and timer node for each step which could be
programed if they are to be utilized in trigger event/sequence.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tgu   |  14 ++
 drivers/hwtracing/qcom/tgu.c                  | 120 ++++++++++++++++++
 drivers/hwtracing/qcom/tgu.h                  |  54 ++++++++
 3 files changed, 188 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
index ea05b1b3301d..a57bf9783641 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
@@ -28,3 +28,17 @@ KernelVersion	6.18
 Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
 Description:
 		(RW) Set/Get the next action with specific step for TGU.
+
+What:		/sys/bus/coresight/devices/<tgu-name>/step[0:7]_timer/reg[0:1]
+Date:		October 2025
+KernelVersion	6.18
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
+Description:
+		(RW) Set/Get the timer value with specific step for TGU.
+
+What:		/sys/bus/coresight/devices/<tgu-name>/step[0:7]_counter/reg[0:1]
+Date:		October 2025
+KernelVersion	6.18
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
+Description:
+		(RW) Set/Get the counter value with specific step for TGU.
diff --git a/drivers/hwtracing/qcom/tgu.c b/drivers/hwtracing/qcom/tgu.c
index ccb1144e7562..c4ae1f27d9ff 100644
--- a/drivers/hwtracing/qcom/tgu.c
+++ b/drivers/hwtracing/qcom/tgu.c
@@ -40,6 +40,12 @@ static int calculate_array_location(struct tgu_drvdata *drvdata,
 		ret = step_index * (drvdata->max_condition_select) +
 			reg_index;
 		break;
+	case TGU_COUNTER:
+		ret = step_index * (drvdata->max_counter) + reg_index;
+		break;
+	case TGU_TIMER:
+		ret = step_index * (drvdata->max_timer) + reg_index;
+		break;
 	default:
 		break;
 	}
@@ -88,6 +94,12 @@ static ssize_t tgu_dataset_show(struct device *dev,
 	case TGU_CONDITION_SELECT:
 		return sysfs_emit(buf, "0x%x\n",
 				  drvdata->value_table->condition_select[index]);
+	case TGU_TIMER:
+		return sysfs_emit(buf, "0x%x\n",
+				  drvdata->value_table->timer[index]);
+	case TGU_COUNTER:
+		return sysfs_emit(buf, "0x%x\n",
+				  drvdata->value_table->counter[index]);
 	default:
 		break;
 	}
@@ -133,6 +145,14 @@ static ssize_t tgu_dataset_store(struct device *dev,
 		tgu_drvdata->value_table->condition_select[index] = val;
 		ret = size;
 		break;
+	case TGU_TIMER:
+		tgu_drvdata->value_table->timer[index] = val;
+		ret = size;
+		break;
+	case TGU_COUNTER:
+		tgu_drvdata->value_table->counter[index] = val;
+		ret = size;
+		break;
 	default:
 		break;
 	}
@@ -175,6 +195,22 @@ static umode_t tgu_node_visible(struct kobject *kobject,
 				drvdata->max_condition_select) ?
 				attr->mode : 0;
 			break;
+		case TGU_COUNTER:
+			if (drvdata->max_counter == 0)
+				ret = SYSFS_GROUP_INVISIBLE;
+			else
+				ret = (tgu_attr->reg_num <
+					drvdata->max_counter) ?
+					attr->mode : 0;
+			break;
+		case TGU_TIMER:
+			if (drvdata->max_timer == 0)
+				ret = SYSFS_GROUP_INVISIBLE;
+			else
+				ret = (tgu_attr->reg_num <
+					drvdata->max_timer) ?
+					attr->mode : 0;
+			break;
 		default:
 			break;
 		}
@@ -226,6 +262,30 @@ static ssize_t tgu_write_all_hw_regs(struct tgu_drvdata *drvdata)
 				drvdata->base + CONDITION_SELECT_STEP(i, j));
 		}
 	}
+
+	for (i = 0; i < drvdata->max_step; i++) {
+		for (j = 0; j < drvdata->max_timer; j++) {
+			index = check_array_location(drvdata, i, TGU_TIMER, j);
+
+			if (index == -EINVAL)
+				goto exit;
+
+			writel(drvdata->value_table->timer[index],
+				drvdata->base + TIMER_COMPARE_STEP(i, j));
+		}
+	}
+
+	for (i = 0; i < drvdata->max_step; i++) {
+		for (j = 0; j < drvdata->max_counter; j++) {
+			index = check_array_location(drvdata, i, TGU_COUNTER, j);
+
+			if (index == -EINVAL)
+				goto exit;
+
+			writel(drvdata->value_table->counter[index],
+				drvdata->base + COUNTER_COMPARE_STEP(i, j));
+		}
+	}
 	/* Enable TGU to program the triggers */
 	writel(1, drvdata->base + TGU_CONTROL);
 exit:
@@ -268,6 +328,31 @@ static void tgu_set_conditions(struct tgu_drvdata *drvdata)
 	drvdata->max_condition_select = TGU_DEVID_CONDITIONS(devid) + 1;
 }
 
+static void tgu_set_timer_counter(struct tgu_drvdata *drvdata)
+{
+	int num_timers, num_counters;
+	u32 devid2;
+
+	devid2 = readl(drvdata->base + CORESIGHT_DEVID2);
+
+	if (TGU_DEVID2_TIMER0(devid2) && TGU_DEVID2_TIMER1(devid2))
+		num_timers = 2;
+	else if (TGU_DEVID2_TIMER0(devid2) || TGU_DEVID2_TIMER1(devid2))
+		num_timers = 1;
+	else
+		num_timers = 0;
+
+	if (TGU_DEVID2_COUNTER0(devid2) && TGU_DEVID2_COUNTER1(devid2))
+		num_counters = 2;
+	else if (TGU_DEVID2_COUNTER0(devid2) || TGU_DEVID2_COUNTER1(devid2))
+		num_counters = 1;
+	else
+		num_counters = 0;
+
+	drvdata->max_timer = num_timers;
+	drvdata->max_counter = num_counters;
+}
+
 static int tgu_enable(struct coresight_device *csdev, enum cs_mode mode,
 		      void *data)
 {
@@ -418,6 +503,22 @@ static const struct attribute_group *tgu_attr_groups[] = {
 	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(5),
 	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(6),
 	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(7),
+	TIMER_ATTRIBUTE_GROUP_INIT(0),
+	TIMER_ATTRIBUTE_GROUP_INIT(1),
+	TIMER_ATTRIBUTE_GROUP_INIT(2),
+	TIMER_ATTRIBUTE_GROUP_INIT(3),
+	TIMER_ATTRIBUTE_GROUP_INIT(4),
+	TIMER_ATTRIBUTE_GROUP_INIT(5),
+	TIMER_ATTRIBUTE_GROUP_INIT(6),
+	TIMER_ATTRIBUTE_GROUP_INIT(7),
+	COUNTER_ATTRIBUTE_GROUP_INIT(0),
+	COUNTER_ATTRIBUTE_GROUP_INIT(1),
+	COUNTER_ATTRIBUTE_GROUP_INIT(2),
+	COUNTER_ATTRIBUTE_GROUP_INIT(3),
+	COUNTER_ATTRIBUTE_GROUP_INIT(4),
+	COUNTER_ATTRIBUTE_GROUP_INIT(5),
+	COUNTER_ATTRIBUTE_GROUP_INIT(6),
+	COUNTER_ATTRIBUTE_GROUP_INIT(7),
 	NULL,
 };
 
@@ -455,6 +556,7 @@ static int tgu_probe(struct amba_device *adev, const struct amba_id *id)
 	tgu_set_reg_number(drvdata);
 	tgu_set_steps(drvdata);
 	tgu_set_conditions(drvdata);
+	tgu_set_timer_counter(drvdata);
 
 	drvdata->value_table =
 		devm_kzalloc(dev, sizeof(*drvdata->value_table), GFP_KERNEL);
@@ -488,6 +590,24 @@ static int tgu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata->value_table->condition_select)
 		return -ENOMEM;
 
+	drvdata->value_table->timer = devm_kzalloc(
+		dev,
+		drvdata->max_step * drvdata->max_timer *
+			sizeof(*(drvdata->value_table->timer)),
+		GFP_KERNEL);
+
+	if (!drvdata->value_table->timer)
+		return -ENOMEM;
+
+	drvdata->value_table->counter = devm_kzalloc(
+		dev,
+		drvdata->max_step * drvdata->max_counter *
+			sizeof(*(drvdata->value_table->counter)),
+		GFP_KERNEL);
+
+	if (!drvdata->value_table->counter)
+		return -ENOMEM;
+
 	drvdata->enable = false;
 	desc.type = CORESIGHT_DEV_TYPE_HELPER;
 	desc.pdata = adev->dev.platform_data;
diff --git a/drivers/hwtracing/qcom/tgu.h b/drivers/hwtracing/qcom/tgu.h
index ced10b3daaa2..eee821035c9f 100644
--- a/drivers/hwtracing/qcom/tgu.h
+++ b/drivers/hwtracing/qcom/tgu.h
@@ -8,10 +8,16 @@
 
 /* Register addresses */
 #define TGU_CONTROL 0x0000
+#define CORESIGHT_DEVID2       0xfc0
 
 #define TGU_DEVID_SENSE_INPUT(devid_val) ((int) BMVAL(devid_val, 10, 17))
 #define TGU_DEVID_STEPS(devid_val) ((int)BMVAL(devid_val, 3, 6))
 #define TGU_DEVID_CONDITIONS(devid_val) ((int)BMVAL(devid_val, 0, 2))
+#define TGU_DEVID2_TIMER0(devid_val) ((int)BMVAL(devid_val, 18, 23))
+#define TGU_DEVID2_TIMER1(devid_val) ((int)BMVAL(devid_val, 13, 17))
+#define TGU_DEVID2_COUNTER0(devid_val) ((int)BMVAL(devid_val, 6, 11))
+#define TGU_DEVID2_COUNTER1(devid_val) ((int)BMVAL(devid_val, 0, 5))
+
 #define NUMBER_BITS_EACH_SIGNAL 4
 #define LENGTH_REGISTER 32
 
@@ -47,6 +53,8 @@
 #define PRIORITY_START_OFFSET 0x0074
 #define CONDITION_DECODE_OFFSET 0x0050
 #define CONDITION_SELECT_OFFSET 0x0060
+#define TIMER_START_OFFSET 0x0040
+#define COUNTER_START_OFFSET 0x0048
 #define PRIORITY_OFFSET 0x60
 #define REG_OFFSET 0x4
 
@@ -58,6 +66,12 @@
 #define CONDITION_DECODE_STEP(step, decode) \
 	(CONDITION_DECODE_OFFSET + REG_OFFSET * decode + STEP_OFFSET * step)
 
+#define TIMER_COMPARE_STEP(step, timer) \
+	(TIMER_START_OFFSET + REG_OFFSET * timer + STEP_OFFSET * step)
+
+#define COUNTER_COMPARE_STEP(step, counter) \
+	(COUNTER_START_OFFSET + REG_OFFSET * counter + STEP_OFFSET * step)
+
 #define CONDITION_SELECT_STEP(step, select) \
 	(CONDITION_SELECT_OFFSET + REG_OFFSET * select + STEP_OFFSET * step)
 
@@ -79,6 +93,12 @@
 #define STEP_SELECT(step_index, reg_num) \
 	tgu_dataset_rw(reg##reg_num, step_index, TGU_CONDITION_SELECT, reg_num)
 
+#define STEP_TIMER(step_index, reg_num) \
+	tgu_dataset_rw(reg##reg_num, step_index, TGU_TIMER, reg_num)
+
+#define STEP_COUNTER(step_index, reg_num) \
+	tgu_dataset_rw(reg##reg_num, step_index, TGU_COUNTER, reg_num)
+
 #define STEP_PRIORITY_LIST(step_index, priority)  \
 	{STEP_PRIORITY(step_index, 0, priority),  \
 	 STEP_PRIORITY(step_index, 1, priority),  \
@@ -118,6 +138,18 @@
 	 NULL		    \
 	}
 
+#define STEP_TIMER_LIST(n) \
+	{STEP_TIMER(n, 0), \
+	 STEP_TIMER(n, 1), \
+	 NULL              \
+	}
+
+#define STEP_COUNTER_LIST(n) \
+	{STEP_COUNTER(n, 0), \
+	 STEP_COUNTER(n, 1), \
+	 NULL                \
+	}
+
 #define PRIORITY_ATTRIBUTE_GROUP_INIT(step, priority)\
 	(&(const struct attribute_group){\
 		.attrs = (struct attribute*[])STEP_PRIORITY_LIST(step, priority),\
@@ -139,6 +171,20 @@
 		.name = "step" #step "_condition_select" \
 	})
 
+#define TIMER_ATTRIBUTE_GROUP_INIT(step)\
+	(&(const struct attribute_group){\
+		.attrs = (struct attribute*[])STEP_TIMER_LIST(step),\
+		.is_visible = tgu_node_visible,\
+		.name = "step" #step "_timer" \
+	})
+
+#define COUNTER_ATTRIBUTE_GROUP_INIT(step)\
+	(&(const struct attribute_group){\
+		.attrs = (struct attribute*[])STEP_COUNTER_LIST(step),\
+		.is_visible = tgu_node_visible,\
+		.name = "step" #step "_counter" \
+	})
+
 enum operation_index {
 	TGU_PRIORITY0,
 	TGU_PRIORITY1,
@@ -146,6 +192,8 @@ enum operation_index {
 	TGU_PRIORITY3,
 	TGU_CONDITION_DECODE,
 	TGU_CONDITION_SELECT,
+	TGU_TIMER,
+	TGU_COUNTER
 };
 
 /* Maximum priority that TGU supports */
@@ -162,6 +210,8 @@ struct value_table {
 	unsigned int *priority;
 	unsigned int *condition_decode;
 	unsigned int *condition_select;
+	unsigned int *timer;
+	unsigned int *counter;
 };
 
 /**
@@ -176,6 +226,8 @@ struct value_table {
  * @max_step: Maximum step size
  * @max_condition_decode: Maximum number of condition_decode
  * @max_condition_select: Maximum number of condition_select
+ * @max_timer: Maximum number of timers
+ * @max_counter: Maximum number of counters
  *
  * This structure defines the data associated with a TGU device,
  * including its base address, device pointers, clock, spinlock for
@@ -193,6 +245,8 @@ struct tgu_drvdata {
 	int max_step;
 	int max_condition_decode;
 	int max_condition_select;
+	int max_timer;
+	int max_counter;
 };
 
 #endif


