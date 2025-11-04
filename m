Return-Path: <linux-kernel+bounces-884154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A248C2F791
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31EA44E89E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42082D8DB8;
	Tue,  4 Nov 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGSQHLI2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K9lTHiKF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D72DF130
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238540; cv=none; b=Xup/xDtZUNOQxdKUd/fjy5XKbeYIL5x+gxFKpp9a2Eb2sfRAXinWh9SBGZQmH7ipoaTfZTgX0WQs+epzXGf7o5QvxvNL4009Yncw4GQf5HKcSytQZuYyF+ajjH0ja6sv/RVL6YlvQ616wMYDHMG4OAF90nVvphSaRIdPJ99yNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238540; c=relaxed/simple;
	bh=8MECySq9f2yYRo/KHR/AYSi/cE92xfhMQrQQpM9o+N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBcYfxiF05t1ET0FwJrEsrEUbdTkJDDwwQHKviu/Lw6nLvFJcey/TZGaHLOF+SNXvTcGpkqLKgz4e480vSNnPS1+Zo645A3tLL4deQClcXEhbTP1MUa3CWjiXv+7PS5ClR47VBqQOD05ycLF/sh4MU1KPFLOackHsVU6E9sFlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGSQHLI2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K9lTHiKF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42rqUc3693365
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 06:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6C+1a3faEq3
	osYqqD/ZZ/4ihi2dgZCB7lp1aXLGvTjA=; b=kGSQHLI2RCSvkzD437aCsDIyb6E
	D5ZlBYQggQsULBtnCiS1DGAm/jHoLovuJrzfA7pOXZXAVxxx2/a9cSSlPZn5Nq7W
	SWPY8y9m1AfexUtrkkb7N+KoUDROG9jdSiGhSTB1nLEWP6dxxmzLjeJF3p+Nsd5R
	YNAHpTjox0YkS5H/Tbuk0+8Hx763xdCpLH0IfyWMs4qmotd7lyGMZWR2SWySw9Uk
	TjOzIvPxSFfh7V7xUowgJpIRWw96DZDwMaoDG+xzY+l5VlHq3ZTncXR+kKAebFJT
	nQYJrlH6EC3WNF5gBf+02iIyyxkDE/VVZ6/GR8c7hWeaXONV3W2M42tcALw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b2w1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:42:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b9a72a43e42so1939307a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762238536; x=1762843336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C+1a3faEq3osYqqD/ZZ/4ihi2dgZCB7lp1aXLGvTjA=;
        b=K9lTHiKFSFx1UlQDD01KqRnT3KNu7XUdBEONUbb6uyR5v4m8HqVGG+8ltZ8vJGC5n2
         6mtbUehMET7MM1a6zIWJFmP1hbGt5QL9On89jzZoNp+Ph6Pi4eqoJjXDM8Ew/5+dfaAj
         KX0qVhN5IWoVy5kHMcQpQIf+MVbZNJNGpZQxyVYKeeWQ/LNljSFShg4TuBib696yGgiy
         8P/FfYM6h3Wg/Rz4DE6S4EJX8aDzJhK3RL/nEfkxEerN5vrg5FHsIgRbLdDahNnsGoMY
         KC9feZ75qxfXNfKFxvsHFY/bmwkOgOt6qJFoaLM6i1GCY1mqI8Ijg+nCgx5q7EpX6Oam
         P+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238536; x=1762843336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C+1a3faEq3osYqqD/ZZ/4ihi2dgZCB7lp1aXLGvTjA=;
        b=rTbTa3YK89yI62A7twT0Yuu56xdYjc1VwzSmh8jP6Xqe6y+D80UZrNSCJx6vMf1rHq
         BhUGHBtKu6KD0FNWWaXQrOpDN/ZGNY1Myll2gl/tYZ48hp3whc94r4QM1deP/PSl+zMq
         L8z9M+arN7IybXcx4PY1pxEMIPCp/YLQgNZmb0TQx3ImFy6a1hDkvxgAcxUdjOadz4bA
         7p2XRWBvHRJeOoINFVN887oaVZKMkZf2PZYqALuFSmPrLC7DC3p+DCfMqFccahFyHkej
         jasV6BBEeZJN9c+3lOBAmR0dgGQgAy78A0jj07l0QhRhB/1PC9Xbvk//NEc8HgSr26/3
         nEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCJahUSLig/jVaML69xRMEndrR3Z40Hj6oW/xhfQL3hGeLSaxidkcwDGTC+kLUMLoB/CS57Xx2GBkBZUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtU0V6nYZG1CtivcyC5SsQ9okxuIZq4VfezegA151k1vJrJPpJ
	3RH0x7oLdVU+u1+JsZW7KG3+VkcZIWwqnFgG7UvDfAepRkb28ts9ft6QW/+4pwkFN5fVl+gVwgO
	vivSV9A9hjBExjyoj03eTlHl4kqDuGCC7IS6mEt9l6uTBSyTncwOfLRwOSU1lLEiq0Ng=
X-Gm-Gg: ASbGncuWyVgWqexWxEwCD8Mmq5f1pmDMt3qVaY8CNk6p7mevi1Y8tZb7Uw0+YAqysV3
	Q07EaBmHz0+hkwEIiHe2n+qU58IALQbvzGbzZdJ1aHoz+JR8lr6IUuvu8sludU+sHz6Xdtfdbzk
	L9tHgPUn8HULFdtVzQPqWlODNlo0bqkOomyf/YNXSGsiX2RYm8eQASv+C0JdoiYpROV0AeY+E3l
	32mTQO8V185ieVcrUf0vMEs4CPVeLt3VzrW/e3e+pIrqkcM4tPoD8Pw1gqUdW42F9dt5hLEkc6f
	NZG5gxheU4zKLmzjU9EjOZhJw7UYdwCO9nzZ77B43otVas3TKG7egjtweJ2koz+nqryJRJswscX
	+FWr6biK6Uh76egifPnx/zZKE0vGukoXWPJdDeyHEc5jSSb33sd8I7Q==
X-Received: by 2002:a17:90b:4e88:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-340e521be37mr11422572a91.5.1762238536152;
        Mon, 03 Nov 2025 22:42:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+yTs2IjF434SBO3J45O3ZS9RHFoYqC8TMkPeVf99bWdNxFdWwJ/Uq7razsOVym9oFtwPUow==
X-Received: by 2002:a17:90b:4e88:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-340e521be37mr11422545a91.5.1762238535597;
        Mon, 03 Nov 2025 22:42:15 -0800 (PST)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a0780dsm3294791a91.16.2025.11.03.22.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 22:42:14 -0800 (PST)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v7 5/7] qcom-tgu: Add support to configure next action
Date: Mon,  3 Nov 2025 22:40:41 -0800
Message-Id: <20251104064043.88972-6-songwei.chai@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104064043.88972-1-songwei.chai@oss.qualcomm.com>
References: <20251104064043.88972-1-songwei.chai@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA1MyBTYWx0ZWRfX+zPKiqYnlDCR
 CLE36HnkgWeSSSxbr84kSBwt5JU9+KR6B+rPjQB4YcLj4zy9j6ecRJ5WYNbwNTbOd9gnsk2dpHu
 Mxm9+A89uGOiVa71GQn40enG1nNZq/EVR6K426twMdD/VIywh3l5w4stNI31X5nNI8fchdmXNWd
 0UMCRjBEN5N5iqzZotSYoplzJpCNPO+yLNeVL2j/KcPJSYEID3tQ8iiR2vPanH34tqr5CGM1PTb
 Jrjzq6yYAJcnf37zQO2OLer04ld86Kksi8mYyeI4bn3RY2lA1/yF+JZnEKEJaD4b/VANsmGS/nx
 Ynhz8ki7x1zBs2E7W//qXo0+uHEiNWfNzsXu0I07mSbAYibLCqu2QwEttN2DjryGos1943ImHJ5
 rb1zlk8XGUu119tUyQ1PYo5FKqkPXw==
X-Proofpoint-GUID: FeycBnKXaER2O-jeMRZUz8Rt3jntAlcd
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6909a049 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xi9iTe-FYOb_EUe3slkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: FeycBnKXaER2O-jeMRZUz8Rt3jntAlcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040053

Add "select" node for each step to determine if another step is taken,
trigger(s) are generated, counters/timers incremented/decremented, etc.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tgu   |  7 +++
 drivers/hwtracing/qcom/tgu.c                  | 52 +++++++++++++++++++
 drivers/hwtracing/qcom/tgu.h                  | 27 ++++++++++
 3 files changed, 86 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
index e4058b950a9c..00615a7c66c5 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
@@ -21,3 +21,10 @@ KernelVersion	6.18
 Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
 Description:
 		(RW) Set/Get the decode mode with specific step for TGU.
+
+What:		/sys/bus/coresight/devices/<tgu-name>/step[0:7]_condition_select/reg[0:3]
+Date:		November 2025
+KernelVersion	6.18
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
+Description:
+		(RW) Set/Get the next action with specific step for TGU.
diff --git a/drivers/hwtracing/qcom/tgu.c b/drivers/hwtracing/qcom/tgu.c
index b4ff41cf0a11..98721891251a 100644
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
index cac5efeee1e9..5056ec81fdae 100644
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
-- 
2.34.1


