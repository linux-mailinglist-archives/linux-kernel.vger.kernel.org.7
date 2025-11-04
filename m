Return-Path: <linux-kernel+bounces-884153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22FAC2F78E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89E3189C728
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D102DC333;
	Tue,  4 Nov 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VA7oZLuz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gNNKOrRb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9E2DE717
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238538; cv=none; b=qqjTIebMRlNimtstBxxeeSeQsTlywgKkw5Z5bL3n+3XfFu+1O40hetG0KSHiNMrvp/Wt6shUKLpbydbQFpcVZCv+UdGIH39Soy8D5fucWFDGneN7n3XWQY8xlSbAibUNkLf1bzZ9bJQXIvU9x8k+IoTCPtl7JDu42ix5ouEWT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238538; c=relaxed/simple;
	bh=vslqyGJFWhpfP/T7XvjzYnbN+A24mohE9IB9l+H05OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hP1PRaS7kZC2Y1hLkMZMOlA0HEJbIkP2yPSr60rZos8VoAiO0StXraeRsJmXpSA2T8W7vGYikleUUnPj5rl3DiIABZiTVdaBKxw8Pj/AhFXjQeFZbemFgEWoZPNgVMD5VpoKD4ocGmEUDnEjOv0w6namrqvSrSd4uu/PAhV+cJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VA7oZLuz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gNNKOrRb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42dc263693721
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 06:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bbd3Fjqeg6F
	hpJk2EoIH6nHcgANJ1GbWgbyJwHGpts0=; b=VA7oZLuzhWGkqZam/DnjNgc94Qr
	Sb6G0iXxgOFqfxv6cppbJF6TeReJCHTCylU8GP7Hx9rzfouGGLi/ExjipWvuga5p
	5Ba5qysv2Q6L5UsTfgwRq25P2oYFRU6JM7F8STe3nwcJc5HVaJRhy7imu9hnzXv9
	7pCcCdW4fV4xxuPbpKQGaoJCtlQl8ARI/QnghmOs9BarjGG1rINWc2FLXFmcWZNG
	8t40pyhxyVwOx7hYmANQXlmbrx0Qx7zVKkpnilgmdrXDOK89mwqvHeZsJ3pE5fRU
	R+K7LMkjxN8Q+xP84bic84IlLklE6kBmT+L0MA/u5B2mjdTA2BjMCWaN2XQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b2w19-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:42:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340bb1bf12aso3673857a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762238534; x=1762843334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbd3Fjqeg6FhpJk2EoIH6nHcgANJ1GbWgbyJwHGpts0=;
        b=gNNKOrRbVVHxWNSQCt1wV8a2XcsysjlyVNXsklfDeH6YNqOcs5WXxochXCoHGNEPp6
         hrHm5sXTogrYolrdqIbBRqNPXYQIHYhrJxc+N2Fe8GnKU/kR1whba83rxauGoMCyr3HM
         VtHdNbQ1CFSR+ZEfJz8cxVpAoOdjGTrstP6wM0une5KE2GFzmZld7Ey1m0EoIQH2DHz3
         mGvDMhtIJGyW7MQjAbE1rAXfYt0+kQCrir16Bc7JjXjdiM3klO3OMYllFVkMtSVHUfND
         TbptM9SPf1fxcI6IBrA1k01TM5MGLIE22QWoekR4o6YjZwb1YV1l49D5D+Ae/lpFSLSU
         TLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238534; x=1762843334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbd3Fjqeg6FhpJk2EoIH6nHcgANJ1GbWgbyJwHGpts0=;
        b=g1VJLFTaw2iW6fpS4OEqPrAPQwxZd0s4vnqlcidb0YOy3HgcdwrXNOtuVHyz6nAbZu
         ySdt39ekXV3Rx6vZPJd/YteOnMvI7XHrJbbaMEwzY8Fa0Zboxp/yLKvX151car21LcQi
         HF9NiGOcxWewFk78J+gyvWQd6vowUoMJVCnVv6I95nz0Gxne5g6IkNf+Ff4xqJyxto1G
         ubZk+gajeiDZotYXG4wSTX5LmvQthsRfNcyiN16jdP/Pdo9WV2r8GgHr8fqwZ44LHRlE
         /A6v+/GlWvySq1RPzxpZ7Xkpa/9rDaQZrXT7Tg1Wve3CVc8wKFxEem9NPkKV1TqNy7dg
         w9mg==
X-Forwarded-Encrypted: i=1; AJvYcCVqURWQtZwsbUVqnsohQUd2fOIoaeMCEcueW7BNHBu86yEwoZfYc+TTAaeTZK5/ayuXKP2Xl+VwWpDZzLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0qI0+w36mqiGLb20sH6Acl+VBoGiN4L/pFW9qcFzYB9HVNTe
	i5xm6y1A5NFvXKPSyk9pV66+eJAMgXTvRSvn1cqoqHiHNr1xvPrYPxbff3M45iWD7u599+ZieG4
	PH5UQscpkkdF58Ovd1rypV67iB0l+YCuPlGOi9sci25AZBqEKOuy6qWvSTiRevhFm/9A=
X-Gm-Gg: ASbGnct4FTTqSwhQYiN3QMbGXIHvDc+QPMiJErHIoE14EMfZmNLOV2vS9JyekllnBPc
	UbJNBmBUg8bXGTEND+ilR7NJoTLoN9XrM9Va68JmKwI58wqjBx7siK4Qt2wAmUPEXhildr8QOE9
	oEh4zUr2bNv3YGyuulYrZwV+EVhqZccQ9VNP7xXZnA79ty5Nwjl6OyzzfK54CiJN0fEZ3k/QwNz
	3j2zpGsTVYA6LjPKrnRw8zHPSaYVVX73aDuoWMteu8Dsg3cvQKOGHZI+bDF+0tXfihDHYHA7im0
	Isewebm+uA3BcrVI4L/lyNy5zSAR9ebb69O3O1gm4NlgjrrvuMIl6BRucpyMobazPlUOqNWsi04
	WyaEsPbsjDeUddYwb4+Yv4beyWaJKtB71IosqS+EMMOgXZRQImHDgQw==
X-Received: by 2002:a17:90b:5848:b0:341:8adc:76d2 with SMTP id 98e67ed59e1d1-3418adc7765mr251531a91.16.1762238534047;
        Mon, 03 Nov 2025 22:42:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6sSYtfbLBc86bYgqNUAClmKWaCExVw97Eip3syklGYgOLhRwrRYtXvwz8JaO+ckR6bGmZQQ==
X-Received: by 2002:a17:90b:5848:b0:341:8adc:76d2 with SMTP id 98e67ed59e1d1-3418adc7765mr251491a91.16.1762238533490;
        Mon, 03 Nov 2025 22:42:13 -0800 (PST)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a0780dsm3294791a91.16.2025.11.03.22.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 22:42:13 -0800 (PST)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v7 4/7] qcom-tgu: Add TGU decode support
Date: Mon,  3 Nov 2025 22:40:40 -0800
Message-Id: <20251104064043.88972-5-songwei.chai@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA1MyBTYWx0ZWRfX0A8IwrWAXcx9
 UJ0Dd2tqCO4cgltlqDKSSGdbih5YUk+u1B5nQ03JbYyscJ6u+DvG4sIMxW8jtAv9ybry/7ekTYF
 Lt8QVsIvtv956IiubnqtY7msuEX3DQPUdI4xdyUsL62BInsbEC1ZPrp0NMF84SiUfY4zsJ7+nYA
 nfA1e2kenTzXpJIM+YFseTIZies0TZ3uvr648/4dyxTDpEe2LxBaDlvWx2JL1kJ80NfsdH1+sT3
 VVoju8eye8bW4x2RCUqeZfybTZCGTpK6XXRW36qr/0X9QCGRG2hZKMDx6FP0ldVQQNXscixXiv2
 c5mJ2CMERiZ0vQ/66gqsymzkH8zYygvfr/HoE0jLOz9lsL6RLV2EsaH6Rwq5/swADlBi7vh8+me
 2ZZ1rakUCEJJnGQU7rRJkvZT/lu7bA==
X-Proofpoint-GUID: TYI91Yy7PWRbSQxJqNZxq3LD-JD2NjNU
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6909a047 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DXd_79bSlwW_W-LZS_AA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: TYI91Yy7PWRbSQxJqNZxq3LD-JD2NjNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040053

Decoding is when all the potential pieces for creating a trigger
are brought together for a given step. Example - there may be a
counter keeping track of some occurrences and a priority-group that
is being used to detect a pattern on the sense inputs. These 2
inputs to condition_decode must be programmed, for a given step,
to establish the condition for the trigger, or movement to another
steps.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tgu   |   7 +
 drivers/hwtracing/qcom/tgu.c                  | 153 ++++++++++++++++--
 drivers/hwtracing/qcom/tgu.h                  |  27 ++++
 3 files changed, 173 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
index 082fddac9ff0..e4058b950a9c 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
@@ -14,3 +14,10 @@ KernelVersion	6.18
 Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
 Description:
 		(RW) Set/Get the sensed signal with specific step and priority for TGU.
+
+What:		/sys/bus/coresight/devices/<tgu-name>/step[0:7]_condition_decode/reg[0:3]
+Date:		November 2025
+KernelVersion	6.18
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
+Description:
+		(RW) Set/Get the decode mode with specific step for TGU.
diff --git a/drivers/hwtracing/qcom/tgu.c b/drivers/hwtracing/qcom/tgu.c
index a1ad8d97e9d2..b4ff41cf0a11 100644
--- a/drivers/hwtracing/qcom/tgu.c
+++ b/drivers/hwtracing/qcom/tgu.c
@@ -21,8 +21,36 @@ static int calculate_array_location(struct tgu_drvdata *drvdata,
 				   int step_index, int operation_index,
 				   int reg_index)
 {
-	return operation_index * (drvdata->max_step) * (drvdata->max_reg) +
-		step_index * (drvdata->max_reg) + reg_index;
+	int ret = -EINVAL;
+
+	switch (operation_index) {
+	case TGU_PRIORITY0:
+	case TGU_PRIORITY1:
+	case TGU_PRIORITY2:
+	case TGU_PRIORITY3:
+		ret = operation_index * (drvdata->max_step) *
+			(drvdata->max_reg) +
+			step_index * (drvdata->max_reg) + reg_index;
+		break;
+	case TGU_CONDITION_DECODE:
+		ret = step_index * (drvdata->max_condition_decode) +
+			reg_index;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int check_array_location(struct tgu_drvdata *drvdata, int step,
+				int ops, int reg)
+{
+	int result = calculate_array_location(drvdata, step, ops, reg);
+
+	if (result == -EINVAL)
+		dev_err(&drvdata->csdev->dev, "%s - Fail\n", __func__);
+
+	return result;
 }
 
 static ssize_t tgu_dataset_show(struct device *dev,
@@ -37,8 +65,26 @@ static ssize_t tgu_dataset_show(struct device *dev,
 					 tgu_attr->operation_index,
 					 tgu_attr->reg_num);
 
-	return sysfs_emit(buf, "0x%x\n",
-			  drvdata->value_table->priority[index]);
+	index = check_array_location(drvdata, tgu_attr->step_index,
+			     tgu_attr->operation_index, tgu_attr->reg_num);
+
+	if (index == -EINVAL)
+		return -EINVAL;
+
+	switch (tgu_attr->operation_index) {
+	case TGU_PRIORITY0:
+	case TGU_PRIORITY1:
+	case TGU_PRIORITY2:
+	case TGU_PRIORITY3:
+		return sysfs_emit(buf, "0x%x\n",
+				  drvdata->value_table->priority[index]);
+	case TGU_CONDITION_DECODE:
+		return sysfs_emit(buf, "0x%x\n",
+				  drvdata->value_table->condition_decode[index]);
+	default:
+		break;
+	}
+	return -EINVAL;
 }
 
 static ssize_t tgu_dataset_store(struct device *dev,
@@ -46,6 +92,7 @@ static ssize_t tgu_dataset_store(struct device *dev,
 				 const char *buf, size_t size)
 {
 	int index;
+	int ret = -EINVAL;
 	unsigned long val;
 
 	struct tgu_drvdata *tgu_drvdata = dev_get_drvdata(dev->parent);
@@ -53,15 +100,32 @@ static ssize_t tgu_dataset_store(struct device *dev,
 		container_of(attr, struct tgu_attribute, attr);
 
 	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+		return ret;
 
 	guard(spinlock)(&tgu_drvdata->lock);
-	index = calculate_array_location(tgu_drvdata, tgu_attr->step_index,
+	index = check_array_location(tgu_drvdata, tgu_attr->step_index,
 					 tgu_attr->operation_index,
 					 tgu_attr->reg_num);
 
-	tgu_drvdata->value_table->priority[index] = val;
-	return size;
+	if (index == -EINVAL)
+		return ret;
+
+	switch (tgu_attr->operation_index) {
+	case TGU_PRIORITY0:
+	case TGU_PRIORITY1:
+	case TGU_PRIORITY2:
+	case TGU_PRIORITY3:
+		tgu_drvdata->value_table->priority[index] = val;
+		ret = size;
+		break;
+	case TGU_CONDITION_DECODE:
+		tgu_drvdata->value_table->condition_decode[index] = val;
+		ret = size;
+		break;
+	default:
+		break;
+	}
+	return ret;
 }
 
 static umode_t tgu_node_visible(struct kobject *kobject,
@@ -78,13 +142,27 @@ static umode_t tgu_node_visible(struct kobject *kobject,
 		container_of(dev_attr, struct tgu_attribute, attr);
 
 	if (tgu_attr->step_index < drvdata->max_step) {
-		ret = (tgu_attr->reg_num < drvdata->max_reg) ?
-			attr->mode : 0;
+		switch (tgu_attr->operation_index) {
+		case TGU_PRIORITY0:
+		case TGU_PRIORITY1:
+		case TGU_PRIORITY2:
+		case TGU_PRIORITY3:
+			ret = (tgu_attr->reg_num < drvdata->max_reg) ?
+				attr->mode : 0;
+			break;
+		case TGU_CONDITION_DECODE:
+			ret = (tgu_attr->reg_num <
+				drvdata->max_condition_decode) ?
+				attr->mode : 0;
+			break;
+		default:
+			break;
+		}
 	}
 	return ret;
 }
 
-static void tgu_write_all_hw_regs(struct tgu_drvdata *drvdata)
+static ssize_t tgu_write_all_hw_regs(struct tgu_drvdata *drvdata)
 {
 	int i, j, k, index;
 
@@ -92,8 +170,10 @@ static void tgu_write_all_hw_regs(struct tgu_drvdata *drvdata)
 	for (i = 0; i < drvdata->max_step; i++) {
 		for (j = 0; j < MAX_PRIORITY; j++) {
 			for (k = 0; k < drvdata->max_reg; k++) {
-				index = calculate_array_location(
+				index = check_array_location(
 							drvdata, i, j, k);
+				if (index == -EINVAL)
+					goto exit;
 
 				writel(drvdata->value_table->priority[index],
 					drvdata->base +
@@ -101,9 +181,23 @@ static void tgu_write_all_hw_regs(struct tgu_drvdata *drvdata)
 			}
 		}
 	}
+
+	for (i = 0; i < drvdata->max_step; i++) {
+		for (j = 0; j < drvdata->max_condition_decode; j++) {
+			index = check_array_location(drvdata, i,
+						TGU_CONDITION_DECODE, j);
+			if (index == -EINVAL)
+				goto exit;
+
+			writel(drvdata->value_table->condition_decode[index],
+				drvdata->base + CONDITION_DECODE_STEP(i, j));
+		}
+	}
 	/* Enable TGU to program the triggers */
 	writel(1, drvdata->base + TGU_CONTROL);
+exit:
 	CS_LOCK(drvdata->base);
+	return index >= 0 ? 0 : -EINVAL;
 }
 
 static void tgu_set_reg_number(struct tgu_drvdata *drvdata)
@@ -131,19 +225,32 @@ static void tgu_set_steps(struct tgu_drvdata *drvdata)
 	drvdata->max_step = TGU_DEVID_STEPS(devid);
 }
 
+static void tgu_set_conditions(struct tgu_drvdata *drvdata)
+{
+	u32 devid;
+
+	devid = readl(drvdata->base + CORESIGHT_DEVID);
+	drvdata->max_condition_decode = TGU_DEVID_CONDITIONS(devid);
+}
+
 static int tgu_enable(struct coresight_device *csdev, enum cs_mode mode,
 		      void *data)
 {
+	int ret = 0;
 	struct tgu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	guard(spinlock)(&drvdata->lock);
 	if (drvdata->enable)
 		return -EBUSY;
 
-	tgu_write_all_hw_regs(drvdata);
+	ret = tgu_write_all_hw_regs(drvdata);
+
+	if (ret == -EINVAL)
+		goto exit;
 	drvdata->enable = true;
 
-	return 0;
+exit:
+	return ret;
 }
 
 static int tgu_disable(struct coresight_device *csdev, void *data)
@@ -260,6 +367,14 @@ static const struct attribute_group *tgu_attr_groups[] = {
 	PRIORITY_ATTRIBUTE_GROUP_INIT(7, 1),
 	PRIORITY_ATTRIBUTE_GROUP_INIT(7, 2),
 	PRIORITY_ATTRIBUTE_GROUP_INIT(7, 3),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(0),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(1),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(2),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(3),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(4),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(5),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(6),
+	CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(7),
 	NULL,
 };
 
@@ -296,6 +411,7 @@ static int tgu_probe(struct amba_device *adev, const struct amba_id *id)
 
 	tgu_set_reg_number(drvdata);
 	tgu_set_steps(drvdata);
+	tgu_set_conditions(drvdata);
 
 	drvdata->value_table =
 		devm_kzalloc(dev, sizeof(*drvdata->value_table), GFP_KERNEL);
@@ -311,6 +427,15 @@ static int tgu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata->value_table->priority)
 		return -ENOMEM;
 
+	drvdata->value_table->condition_decode = devm_kzalloc(
+		dev,
+		drvdata->max_condition_decode * drvdata->max_step *
+			sizeof(*(drvdata->value_table->condition_decode)),
+		GFP_KERNEL);
+
+	if (!drvdata->value_table->condition_decode)
+		return -ENOMEM;
+
 	drvdata->enable = false;
 	desc.type = CORESIGHT_DEV_TYPE_HELPER;
 	desc.pdata = adev->dev.platform_data;
diff --git a/drivers/hwtracing/qcom/tgu.h b/drivers/hwtracing/qcom/tgu.h
index 444804e52337..cac5efeee1e9 100644
--- a/drivers/hwtracing/qcom/tgu.h
+++ b/drivers/hwtracing/qcom/tgu.h
@@ -11,6 +11,7 @@
 
 #define TGU_DEVID_SENSE_INPUT(devid_val) ((int) BMVAL(devid_val, 10, 17))
 #define TGU_DEVID_STEPS(devid_val) ((int)BMVAL(devid_val, 3, 6))
+#define TGU_DEVID_CONDITIONS(devid_val) ((int)BMVAL(devid_val, 0, 2))
 #define NUMBER_BITS_EACH_SIGNAL 4
 #define LENGTH_REGISTER 32
 
@@ -44,6 +45,7 @@
  */
 #define STEP_OFFSET 0x1D8
 #define PRIORITY_START_OFFSET 0x0074
+#define CONDITION_DECODE_OFFSET 0x0050
 #define PRIORITY_OFFSET 0x60
 #define REG_OFFSET 0x4
 
@@ -52,6 +54,9 @@
 	(PRIORITY_START_OFFSET + PRIORITY_OFFSET * priority +\
 	 REG_OFFSET * reg + STEP_OFFSET * step)
 
+#define CONDITION_DECODE_STEP(step, decode) \
+	(CONDITION_DECODE_OFFSET + REG_OFFSET * decode + STEP_OFFSET * step)
+
 #define tgu_dataset_rw(name, step_index, type, reg_num)                  \
 	(&((struct tgu_attribute[]){ {                                   \
 		__ATTR(name, 0644, tgu_dataset_show, tgu_dataset_store), \
@@ -64,6 +69,9 @@
 	tgu_dataset_rw(reg##reg_num, step_index, TGU_PRIORITY##priority, \
 			reg_num)
 
+#define STEP_DECODE(step_index, reg_num) \
+	tgu_dataset_rw(reg##reg_num, step_index, TGU_CONDITION_DECODE, reg_num)
+
 #define STEP_PRIORITY_LIST(step_index, priority)  \
 	{STEP_PRIORITY(step_index, 0, priority),  \
 	 STEP_PRIORITY(step_index, 1, priority),  \
@@ -86,6 +94,14 @@
 	 NULL                   \
 	}
 
+#define STEP_DECODE_LIST(n) \
+	{STEP_DECODE(n, 0), \
+	 STEP_DECODE(n, 1), \
+	 STEP_DECODE(n, 2), \
+	 STEP_DECODE(n, 3), \
+	 NULL		    \
+	}
+
 #define PRIORITY_ATTRIBUTE_GROUP_INIT(step, priority)\
 	(&(const struct attribute_group){\
 		.attrs = (struct attribute*[])STEP_PRIORITY_LIST(step, priority),\
@@ -93,11 +109,19 @@
 		.name = "step" #step "_priority" #priority \
 	})
 
+#define CONDITION_DECODE_ATTRIBUTE_GROUP_INIT(step)\
+	(&(const struct attribute_group){\
+		.attrs = (struct attribute*[])STEP_DECODE_LIST(step),\
+		.is_visible = tgu_node_visible,\
+		.name = "step" #step "_condition_decode" \
+	})
+
 enum operation_index {
 	TGU_PRIORITY0,
 	TGU_PRIORITY1,
 	TGU_PRIORITY2,
 	TGU_PRIORITY3,
+	TGU_CONDITION_DECODE,
 };
 
 /* Maximum priority that TGU supports */
@@ -112,6 +136,7 @@ struct tgu_attribute {
 
 struct value_table {
 	unsigned int *priority;
+	unsigned int *condition_decode;
 };
 
 /**
@@ -124,6 +149,7 @@ struct value_table {
  * @value_table: Store given value based on relevant parameters.
  * @max_reg: Maximum number of registers
  * @max_step: Maximum step size
+ * @max_condition_decode: Maximum number of condition_decode
  *
  * This structure defines the data associated with a TGU device,
  * including its base address, device pointers, clock, spinlock for
@@ -139,6 +165,7 @@ struct tgu_drvdata {
 	struct value_table *value_table;
 	int max_reg;
 	int max_step;
+	int max_condition_decode;
 };
 
 #endif
-- 
2.34.1


