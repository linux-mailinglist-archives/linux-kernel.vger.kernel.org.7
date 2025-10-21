Return-Path: <linux-kernel+bounces-862101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D6BF46FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEF318C5D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA72D5A13;
	Tue, 21 Oct 2025 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jkNBMhmG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861E2D23B9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015583; cv=none; b=WyLePp8ybGdKZ7nZPrtDsP1oTt/KbQwAdtuB8ht9TqMy9asiraoUA7DfQGCsmR8HTR5LLZEN5LhK1nYQquq3PX2uL2nWV2Zdbn2rbAvo3QkFUNd6gwcV8xOEhRMdQF18SkV4kaYwr1YI4Ar5PvzCdd/iXyGBQFdJ1sN3GAaom/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015583; c=relaxed/simple;
	bh=t2uVYh/HzkReb7Ne11GHihtlx7yqNuzMvoH0yKsSjjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnhMXAhSN/LO63R/oDleM2hgR1271KTwrAXJaaKU951A+e+WSxfkmaXVrwnsBo78gJf1u1LvaKo2yDvn1cbcbO/gkSaj9Kq08hA8AT+eENhhFn6l6QwUs0XyVDWWtLDZBZzl+9gOt2YNwCIqL61cujjWhCxImSqJyqTVegs7pSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jkNBMhmG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0rO6029835
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=61wqR+p6AOf
	wOPpxfJOD/8OkOXPQFLfK0xcBfQVi6rk=; b=jkNBMhmG7h1AWI8VcIbt+UjKcSt
	b+9cRwYa3OyNWmLfA4/gYQr0W3S41bUW6D2/EwgUYZ7EJr9oMzaxhv13wU655X4J
	eZLr2i/lnMLwRqiAZypgWJ5hUCvD1qfrw1WXUHsrNUMqnFbqLARUcC2bArBGG/Nd
	ob250C/JNcrJyS+Kr6jO94ZEY50smI3QtJDVLMozKBLU5oV00gVybzYt+2a4HF6j
	6WOYATq/CTQv9/yFY9+kZPR0X8fP53MQd+zngiEiErKUQtmYDmrdkteoKMULWjIa
	VUzrXhS9eQToqK/MYxs72LRTZAVunL9rm01Z3aYjQYh/RypkAl0Lgaa1L9w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdxwhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so3825298a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015578; x=1761620378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61wqR+p6AOfwOPpxfJOD/8OkOXPQFLfK0xcBfQVi6rk=;
        b=g1hIXqZdUVKasHXFGohguycmgcnZMZE1AvXnlt5O8VXnv3MLTL/H0KNXSF5DlJlNEA
         8ROEiIZNpQ725rfb342evUdLobJs2botOgYOrNqb2o+UFmWh2UycuEYt6APcAr3hNMsF
         aMbDX93vC1JDzTTnykonR8SuClUgdO3SMqluw/pmvlgbz+oesELwRtZ+1m6NTc9gVEh7
         VfbQOmiGbIcvkxGBkN+a4qO3J2ph2TF1J/NTqlvkqJvdiMK4Zw/MKgz1Mts95NCYG7Aq
         kF80ybp5185teJlSFp0+07nLaT9jFdH74TigO5XoEVLzUscV7npMJvNdrLtXGEbwxeu7
         0beQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJVr7f+QTlm9d22vPASyP2hxpMka6oBKJUsUE03EGlhCcC6OjkyV2mdZA0XDFvL8LttVp4vg+/8vvz/Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4wCmoNRwfwHYVG4TwZykzwx2DZ7SXFeEspFtDOYu7rUUVCC6
	4QCug/jhRTsCqPoXALEbk0pkF5YUBGJko/5dWtFBUnpjoh1o1aXSMoTFe7DkE9NEHZKQeVBm1dE
	PFN+LvU2Xl1WjMaExkFZxa7c0R+R0vAis35uTHhLP1pHG9HK4SkURh07w8d+5enObL0w=
X-Gm-Gg: ASbGncvVPRhf7S0f/eh4YK260RKdDdjhjQRdNm/zchlUrtEbFK5Gr84iDW9UMgak8kK
	q/zYDQ/0rXVzhGEIA+MXSvQEa5094JdeeLCG62Jk2k0/FwE/FKDvhxFPGrlrbKHusvu0obN7mVZ
	zvZIJe+pTN1X8jeCsMBO550TM9U6RmByDzx2QpCQkzSQC6ciprzLcM+Ku0dds7IHJQ0yOjsrZ2H
	XUWP7taDbH7dvYOm8FM2EMaQCpbe7y7ZJ4SK2bQWXxGsM9Wc6rG1zYh5i+d3/d1OKgIpkVUfS4m
	hBALLDLo+8Rt6a8xXVhTZAuyPV8ldUQ2AaETLEOW7qjq00+g1GBg8Aw5Zn9qvkhfJClEuWN/nSf
	XxRgoq21N8mowHodSFZaRm8qKBnaSn27XbmOKXUSjMc8kEEsxDa6fig==
X-Received: by 2002:a05:6a20:9745:b0:2f6:cabe:a7c5 with SMTP id adf61e73a8af0-334a86077fcmr15736799637.34.1761015577856;
        Mon, 20 Oct 2025 19:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiNfzPG3qZGj1HFVjWDlXG/d9MdQ0tchsr8s3lng+hGtxhzM1REOOHFZIDmvzHWszSIh4qwQ==
X-Received: by 2002:a05:6a20:9745:b0:2f6:cabe:a7c5 with SMTP id adf61e73a8af0-334a86077fcmr15736784637.34.1761015577402;
        Mon, 20 Oct 2025 19:59:37 -0700 (PDT)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8855787a12.10.2025.10.20.19.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 19:59:37 -0700 (PDT)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [RESEND RFC PATCH 5/7] qcom-tgu: Add support to configure next action
Date: Mon, 20 Oct 2025 19:59:07 -0700
Message-Id: <20251021025909.3627254-6-songwei.chai@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfXxy8exK/h4mj2
 dj/YEe3Oz/tkkIMoitOjIVmijBB2Ntp7fpWiflPecwrmrvF1YFevqRsmyQU3e+OR1TS0McWBrW+
 bZfP4ru+ZuR2oYG4mOtTW6Dq97TGg+zzF4WklTvwl0+rl1SI1QNc1Hz7/mkMnnPTXzSMkjiUMp6
 wE8cJp1ru01hm/ewGF8OUxI201WW+9KvRlf1Lk+JkvduwwS9SKur01+X/VcwamHZwMxEroxgZUA
 Q3f5RgmhBAAdra9qNlR6+YoIGvZyZgjm1YQyrx5Nbi9j8LluHju99WHKKOvvSByLHHrhGNSf9aa
 liYCSxbW0/J1D3/2+95YWgWlwTekF8I6rZiBlNa/gPkuzKAlQtIQtrx1tz3oNg8pPcr/6qQF5HF
 2jY03NT8j/mcQHdf4CmrU8NPg+N9vA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f6f71b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=xi9iTe-FYOb_EUe3slkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 8tB0IeVJJ_gHjEj-oODUm_5-1SmdfEfi
X-Proofpoint-ORIG-GUID: 8tB0IeVJJ_gHjEj-oODUm_5-1SmdfEfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Add "select" node for each step to determine if another step is taken,
trigger(s) are generated, counters/timers incremented/decremented, etc.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tgu   |  7 +++
 drivers/hwtracing/qcom/tgu.c                  | 52 +++++++++++++++++++
 drivers/hwtracing/qcom/tgu.h                  | 27 ++++++++++
 3 files changed, 86 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
index 5034df7d52a4..ea05b1b3301d 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
@@ -21,3 +21,10 @@ KernelVersion	6.18
 Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
 Description:
 		(RW) Set/Get the decode mode with specific step for TGU.
+
+What:		/sys/bus/coresight/devices/<tgu-name>/step[0:7]_condition_select/reg[0:3]
+Date:		October 2025
+KernelVersion	6.18
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
+Description:
+		(RW) Set/Get the next action with specific step for TGU.
diff --git a/drivers/hwtracing/qcom/tgu.c b/drivers/hwtracing/qcom/tgu.c
index 70675e19176b..ccb1144e7562 100644
--- a/drivers/hwtracing/qcom/tgu.c
+++ b/drivers/hwtracing/qcom/tgu.c
@@ -36,6 +36,10 @@ static int calculate_array_location(struct tgu_drvdata *drvdata,
 		ret = step_index * (drvdata->max_condition_decode) +
 			reg_index;
 		break;
+	case TGU_CONDITION_SELECT:
+		ret = step_index * (drvdata->max_condition_select) +
+			reg_index;
+		break;
 	default:
 		break;
 	}
@@ -81,6 +85,9 @@ static ssize_t tgu_dataset_show(struct device *dev,
 	case TGU_CONDITION_DECODE:
 		return sysfs_emit(buf, "0x%x\n",
 				  drvdata->value_table->condition_decode[index]);
+	case TGU_CONDITION_SELECT:
+		return sysfs_emit(buf, "0x%x\n",
+				  drvdata->value_table->condition_select[index]);
 	default:
 		break;
 	}
@@ -122,6 +129,10 @@ static ssize_t tgu_dataset_store(struct device *dev,
 		tgu_drvdata->value_table->condition_decode[index] = val;
 		ret = size;
 		break;
+	case TGU_CONDITION_SELECT:
+		tgu_drvdata->value_table->condition_select[index] = val;
+		ret = size;
+		break;
 	default:
 		break;
 	}
@@ -155,6 +166,15 @@ static umode_t tgu_node_visible(struct kobject *kobject,
 				drvdata->max_condition_decode) ?
 				attr->mode : 0;
 			break;
+		case TGU_CONDITION_SELECT:
+		/* 'default' register is at the end of 'select' region */
+			if (tgu_attr->reg_num ==
+			    drvdata->max_condition_select - 1)
+				attr->name = "default";
+			ret = (tgu_attr->reg_num <
+				drvdata->max_condition_select) ?
+				attr->mode : 0;
+			break;
 		default:
 			break;
 		}
@@ -193,6 +213,19 @@ static ssize_t tgu_write_all_hw_regs(struct tgu_drvdata *drvdata)
 				drvdata->base + CONDITION_DECODE_STEP(i, j));
 		}
 	}
+
+	for (i = 0; i < drvdata->max_step; i++) {
+		for (j = 0; j < drvdata->max_condition_select; j++) {
+			index = check_array_location(drvdata, i,
+						TGU_CONDITION_SELECT, j);
+
+			if (index == -EINVAL)
+				goto exit;
+
+			writel(drvdata->value_table->condition_select[index],
+				drvdata->base + CONDITION_SELECT_STEP(i, j));
+		}
+	}
 	/* Enable TGU to program the triggers */
 	writel(1, drvdata->base + TGU_CONTROL);
 exit:
@@ -231,6 +264,8 @@ static void tgu_set_conditions(struct tgu_drvdata *drvdata)
 
 	devid = readl(drvdata->base + CORESIGHT_DEVID);
 	drvdata->max_condition_decode = TGU_DEVID_CONDITIONS(devid);
+	/* select region has an additional 'default' register */
+	drvdata->max_condition_select = TGU_DEVID_CONDITIONS(devid) + 1;
 }
 
 static int tgu_enable(struct coresight_device *csdev, enum cs_mode mode,
@@ -375,6 +410,14 @@ static const struct attribute_group *tgu_attr_groups[] = {
 	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(5),
 	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(6),
 	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(7),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(0),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(1),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(2),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(3),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(4),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(5),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(6),
+	CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(7),
 	NULL,
 };
 
@@ -436,6 +479,15 @@ static int tgu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata->value_table->condition_decode)
 		return -ENOMEM;
 
+	drvdata->value_table->condition_select = devm_kzalloc(
+		dev,
+		drvdata->max_condition_select * drvdata->max_step *
+			sizeof(*(drvdata->value_table->condition_select)),
+		GFP_KERNEL);
+
+	if (!drvdata->value_table->condition_select)
+		return -ENOMEM;
+
 	drvdata->enable = false;
 	desc.type = CORESIGHT_DEV_TYPE_HELPER;
 	desc.pdata = adev->dev.platform_data;
diff --git a/drivers/hwtracing/qcom/tgu.h b/drivers/hwtracing/qcom/tgu.h
index 3974d8e6ab04..ced10b3daaa2 100644
--- a/drivers/hwtracing/qcom/tgu.h
+++ b/drivers/hwtracing/qcom/tgu.h
@@ -46,6 +46,7 @@
 #define STEP_OFFSET 0x1D8
 #define PRIORITY_START_OFFSET 0x0074
 #define CONDITION_DECODE_OFFSET 0x0050
+#define CONDITION_SELECT_OFFSET 0x0060
 #define PRIORITY_OFFSET 0x60
 #define REG_OFFSET 0x4
 
@@ -57,6 +58,9 @@
 #define CONDITION_DECODE_STEP(step, decode) \
 	(CONDITION_DECODE_OFFSET + REG_OFFSET * decode + STEP_OFFSET * step)
 
+#define CONDITION_SELECT_STEP(step, select) \
+	(CONDITION_SELECT_OFFSET + REG_OFFSET * select + STEP_OFFSET * step)
+
 #define tgu_dataset_rw(name, step_index, type, reg_num)                  \
 	(&((struct tgu_attribute[]){ {                                   \
 		__ATTR(name, 0644, tgu_dataset_show, tgu_dataset_store), \
@@ -72,6 +76,9 @@
 #define STEP_DECODE(step_index, reg_num) \
 	tgu_dataset_rw(reg##reg_num, step_index, TGU_CONDITION_DECODE, reg_num)
 
+#define STEP_SELECT(step_index, reg_num) \
+	tgu_dataset_rw(reg##reg_num, step_index, TGU_CONDITION_SELECT, reg_num)
+
 #define STEP_PRIORITY_LIST(step_index, priority)  \
 	{STEP_PRIORITY(step_index, 0, priority),  \
 	 STEP_PRIORITY(step_index, 1, priority),  \
@@ -102,6 +109,15 @@
 	 NULL		    \
 	}
 
+#define STEP_SELECT_LIST(n) \
+	{STEP_SELECT(n, 0), \
+	 STEP_SELECT(n, 1), \
+	 STEP_SELECT(n, 2), \
+	 STEP_SELECT(n, 3), \
+	 STEP_SELECT(n, 4), \
+	 NULL		    \
+	}
+
 #define PRIORITY_ATTRIBUTE_GROUP_INIT(step, priority)\
 	(&(const struct attribute_group){\
 		.attrs = (struct attribute*[])STEP_PRIORITY_LIST(step, priority),\
@@ -116,12 +132,20 @@
 		.name = "step" #step "_condition_decode" \
 	})
 
+#define CONDITION_SELECT_ATTRIBUTE_GROUP_INIT(step)\
+	(&(const struct attribute_group){\
+		.attrs = (struct attribute*[])STEP_SELECT_LIST(step),\
+		.is_visible = tgu_node_visible,\
+		.name = "step" #step "_condition_select" \
+	})
+
 enum operation_index {
 	TGU_PRIORITY0,
 	TGU_PRIORITY1,
 	TGU_PRIORITY2,
 	TGU_PRIORITY3,
 	TGU_CONDITION_DECODE,
+	TGU_CONDITION_SELECT,
 };
 
 /* Maximum priority that TGU supports */
@@ -137,6 +161,7 @@ struct tgu_attribute {
 struct value_table {
 	unsigned int *priority;
 	unsigned int *condition_decode;
+	unsigned int *condition_select;
 };
 
 /**
@@ -150,6 +175,7 @@ struct value_table {
  * @max_reg: Maximum number of registers
  * @max_step: Maximum step size
  * @max_condition_decode: Maximum number of condition_decode
+ * @max_condition_select: Maximum number of condition_select
  *
  * This structure defines the data associated with a TGU device,
  * including its base address, device pointers, clock, spinlock for
@@ -166,6 +192,7 @@ struct tgu_drvdata {
 	int max_reg;
 	int max_step;
 	int max_condition_decode;
+	int max_condition_select;
 };
 
 #endif


