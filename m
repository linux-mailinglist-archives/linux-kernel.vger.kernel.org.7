Return-Path: <linux-kernel+bounces-862099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E4BF46E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117BD422A07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9132877E6;
	Tue, 21 Oct 2025 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/UfJueM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302D287516
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015578; cv=none; b=uNUuLeC8zAx8O8r0N8WwhSf1Mc0WtIlvtuFNwGzs/DY/t2zz2g5lditAOrp7Txpg9rufOn0igbIndS5Hps5R8UxCE6/GxpF5w6avngowYU9B/s8TvQQsFsywjlm+Q33/WdeI1K5h0H7kjEiX1H8cX2/65eqyup25WAy0/uhujnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015578; c=relaxed/simple;
	bh=LByvCX210L0JhQeAVC7gohgiHojoIa3IWqboGTTg6wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2m3FMJuGwGhl1jeBZPmsKrU5A+4weSQO41Jzktsj0v/Y9f/JYhtsG0J4ehsYUikRByERCmdK2S0s+//Zs/P9oqGGVfaUV3AKERlj/sM0pwPrReaB6KxWgHZo/R4YYPB0rr9tk4nwdxfHDUxYezRsnFp4yevtLV9sngGeO7B43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/UfJueM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL1aK8028420
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qPAq/neyr4/
	Ko0/bGMBJ1uCw3OG6Ub6pMYqV1wQCYRc=; b=O/UfJueMPnFQodT85eyX2OQXSRV
	5CmqexfIHg9tr3rD9KF9xEQWfa+ZIUFPytHLc8gCct4OMUWQDpE9Ys+TBkPOA7Xs
	JYaVAGZA0zyumvRR4RYGhmxpBfmkeCupaX+fpiT7kib1TpPgjKXlYMDLjPo/8tbN
	Q5hQd810RxNpehWII+BjCfLsZIe9VC+MNW5V5Slyok/US5Ch0s+HwEpI7LNfJ8Tj
	iQkwheZv560M86Se8IV9RQQQ+FgsP1aSkC7VaNV0Xn2syytED1xtdqM3+N+VWcWZ
	GTfxZXcTjPJREfDkIpL488GyUq7WNBT9w0isGudq9LLeT1Di2NnHEL8UpGw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pf4h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso2740897a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015574; x=1761620374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPAq/neyr4/Ko0/bGMBJ1uCw3OG6Ub6pMYqV1wQCYRc=;
        b=shnHPOB97RETHwhqwWxpuyg0kxLaNmsoxvBfoP4xXzwbU9qZ/HWCBDb607Ju0elG+E
         XPsX3z7740zsyWG/Ze7HBVVCCGjZULaRonGixk0ZeUlOuP4j7WQJBDFOoZlbkNahdDXz
         AWyQZUeyJtfgAWzkGu/Stn/cNeftCwyMtG5cuiNLHEvrTcpIm3ACcuK8P9ttvj5fUWrw
         5S18F9cweXehkVY8U7LfHTgSVUN4/6dqC8vPa734Ab9XxE7qNr/mjaN5bJG2UraTp3nQ
         sWglLO5FjUTTocMDU1k997i1DsRP0hsIHWv2TkWKRCNQZUHZ1k5PAMuUZqANcYpTvt6g
         +1+g==
X-Forwarded-Encrypted: i=1; AJvYcCVDLDcNVJcMzBR1/woJt3p+ltxC8FvamgFKKRI9gzL98lXwiPQmrayrhlxohW5I3ANzwK0lp6F14li2rtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+GHIv2OMIYjvr7zhIq+e68zb6YEtLbIEqX1pHo9SyUX/jyLz
	9EyiK8osXbwfl4R6HYLf/0hvouokox4Ll9cautAMAjZftE4KxQyLf+XM9LxpUgUmpbtabC80tNG
	n3TY6vnEgnbo/ynGwuvQIYZYqQC4XOfBpU7mTpaLiFidYwrOhKHbfICuQyZHKe6B6zQs=
X-Gm-Gg: ASbGncv51GhTEg0ik1yMlKv5OPugmqBoio2Mt6B9iJHnOmd5gXW+njD4sXigtew5JMS
	rGnXC9phdvyeyxcs6PnsuMKZTjBux9dCo2DpdNpA1mxWDfGSmP+Ip2c80l6zk7P6g3JNrE//KHp
	9Dp/S7ErleSIGndbCSGJTJ+g9sZY+JXK85zH4GZ/c4Ul3ES3nQoHyaSQPlf5iBPie55RRO+eEal
	tB3PJtTU2bWdpAzPXrUp8S/HRGiThffnocaWrw7Z2TMpwIXHDpauohhMH2EsUuM0ifR0FsMceWH
	gxMVGck4qcsSn5gQMoRp32NNl75emImhsTyWFax3i3LXQ2r3tfyvkUTmFj0rA6CWZDJXDntyGmf
	84kxjf50cN9TCItQoFU8LLV/yohKWCQX5xr3TS/5gEvpLmOfALhp+bw==
X-Received: by 2002:a05:6a20:e212:b0:334:a681:38a3 with SMTP id adf61e73a8af0-334a8542a1dmr17884420637.13.1761015574044;
        Mon, 20 Oct 2025 19:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3EcPcp/wC9MhSUdq/VHFIYPE/knM1Jgqugv7PdPP0IPKEtRNXA4mPj3DKd9hfGBNj1VfGWg==
X-Received: by 2002:a05:6a20:e212:b0:334:a681:38a3 with SMTP id adf61e73a8af0-334a8542a1dmr17884393637.13.1761015573495;
        Mon, 20 Oct 2025 19:59:33 -0700 (PDT)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8855787a12.10.2025.10.20.19.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 19:59:33 -0700 (PDT)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [RESEND RFC PATCH 3/7] qcom-tgu: Add signal priority support
Date: Mon, 20 Oct 2025 19:59:05 -0700
Message-Id: <20251021025909.3627254-4-songwei.chai@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX2lVjcav7xRs4
 3f7ROX72DLAeYkg7UbldYf1x855HHVVrFxxv27F2zyZUfA6DWo09OQGUwOq4BZmcgtk1b3E9sCd
 Rutpc+/MtJz3DTIx3Z0LNoGTqe4fc4j/2u/f3ddRjdh6yccu3r1CWJaw48HZDiuNKV8dy3S7kXV
 U/z78LvJEAwLd3Vmj+z9Vx1doq5y0WwdaE/7Olr30rQbpaJgRDxND9W2gBeQ42TaP29PPJTkFka
 AYnzSVcGAlm4/hs26fjK2eE4CYb4DjokzmYIUMUrGWm7/WUOBT89mvKa1ur0tjxDS5HuLG8KXZM
 i+Br2Ib1ZBBHbFi7/qEEi0cOKwcGUR574SogcrKM1oqNu5uYtNdiQF0lVaUbWd85MqlYqTfqNiJ
 gTt6ENMP3XzcPACTKOTDpO20oOcEnQ==
X-Proofpoint-GUID: Z074n_SEJ1snu7kO3aBewZuYHjv1JWT4
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f6f717 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=HMmvC-cB1bDe2h_eLOYA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Z074n_SEJ1snu7kO3aBewZuYHjv1JWT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Like circuit of a Logic analyzer, in TGU, the requirement could be
configured in each step and the trigger will be created once the
requirements are met. Add priority functionality here to sort the
signals into different priorities. The signal which is wanted could
be configured in each step's priority node, the larger number means
the higher priority and the signal with higher priority will be sensed
more preferentially.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tgu   |   7 +
 drivers/hwtracing/qcom/tgu.c                  | 155 ++++++++++++++++++
 drivers/hwtracing/qcom/tgu.h                  | 111 +++++++++++++
 3 files changed, 273 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
index 353961e7b61c..960c1de90fb6 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
@@ -7,3 +7,10 @@ Description:
 		Accepts only one of the 2 values -  0 or 1.
 		0 : disable TGU.
 		1 : enable TGU.
+
+What:		/sys/bus/coresight/devices/<tgu-name>/step[0:7]_priority[0:3]/reg[0:17]
+Date:		October 2025
+KernelVersion	6.18
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
+Description:
+		(RW) Set/Get the sensed signal with specific step and priority for TGU.
diff --git a/drivers/hwtracing/qcom/tgu.c b/drivers/hwtracing/qcom/tgu.c
index 0d3c62f2d5e6..3e40bb2fde57 100644
--- a/drivers/hwtracing/qcom/tgu.c
+++ b/drivers/hwtracing/qcom/tgu.c
@@ -17,14 +17,120 @@
 
 DEFINE_CORESIGHT_DEVLIST(tgu_devs, "tgu");
 
+static int calculate_array_location(struct tgu_drvdata *drvdata,
+				   int step_index, int operation_index,
+				   int reg_index)
+{
+	return operation_index * (drvdata->max_step) * (drvdata->max_reg) +
+		step_index * (drvdata->max_reg) + reg_index;
+}
+
+static ssize_t tgu_dataset_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int index;
+	struct tgu_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct tgu_attribute *tgu_attr =
+			container_of(attr, struct tgu_attribute, attr);
+
+	index = calculate_array_location(drvdata, tgu_attr->step_index,
+					 tgu_attr->operation_index,
+					 tgu_attr->reg_num);
+
+	return sysfs_emit(buf, "0x%x\n",
+			  drvdata->value_table->priority[index]);
+}
+
+static ssize_t tgu_dataset_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	int index;
+	unsigned long val;
+
+	struct tgu_drvdata *tgu_drvdata = dev_get_drvdata(dev->parent);
+	struct tgu_attribute *tgu_attr =
+		container_of(attr, struct tgu_attribute, attr);
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	guard(spinlock)(&tgu_drvdata->spinlock);
+	index = calculate_array_location(tgu_drvdata, tgu_attr->step_index,
+					 tgu_attr->operation_index,
+					 tgu_attr->reg_num);
+
+	tgu_drvdata->value_table->priority[index] = val;
+	return size;
+}
+
+static umode_t tgu_node_visible(struct kobject *kobject,
+				struct attribute *attr,
+				int n)
+{
+	struct device *dev = kobj_to_dev(kobject);
+	struct tgu_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	int ret = SYSFS_GROUP_INVISIBLE;
+
+	struct device_attribute *dev_attr =
+		container_of(attr, struct device_attribute, attr);
+	struct tgu_attribute *tgu_attr =
+		container_of(dev_attr, struct tgu_attribute, attr);
+
+	if (tgu_attr->step_index < drvdata->max_step) {
+		ret = (tgu_attr->reg_num < drvdata->max_reg) ?
+			attr->mode : 0;
+	}
+	return ret;
+}
+
 static void tgu_write_all_hw_regs(struct tgu_drvdata *drvdata)
 {
+	int i, j, k, index;
+
 	CS_UNLOCK(drvdata->base);
+	for (i = 0; i < drvdata->max_step; i++) {
+		for (j = 0; j < MAX_PRIORITY; j++) {
+			for (k = 0; k < drvdata->max_reg; k++) {
+				index = calculate_array_location(
+							drvdata, i, j, k);
+
+				writel(drvdata->value_table->priority[index],
+					drvdata->base +
+					PRIORITY_REG_STEP(i, j, k));
+			}
+		}
+	}
 	/* Enable TGU to program the triggers */
 	writel(1, drvdata->base + TGU_CONTROL);
 	CS_LOCK(drvdata->base);
 }
 
+static void tgu_set_reg_number(struct tgu_drvdata *drvdata)
+{
+	int num_sense_input;
+	int num_reg;
+	u32 devid;
+
+	devid = readl(drvdata->base + CORESIGHT_DEVID);
+
+	num_sense_input = TGU_DEVID_SENSE_INPUT(devid);
+	if (((num_sense_input * NUMBER_BITS_EACH_SIGNAL) % LENGTH_REGISTER) == 0)
+		num_reg = (num_sense_input * NUMBER_BITS_EACH_SIGNAL) / LENGTH_REGISTER;
+	else
+		num_reg = ((num_sense_input * NUMBER_BITS_EACH_SIGNAL) / LENGTH_REGISTER) + 1;
+	drvdata->max_reg = num_reg;
+}
+
+static void tgu_set_steps(struct tgu_drvdata *drvdata)
+{
+	u32 devid;
+
+	devid = readl(drvdata->base + CORESIGHT_DEVID);
+
+	drvdata->max_step = TGU_DEVID_STEPS(devid);
+}
+
 static int tgu_enable(struct coresight_device *csdev, enum cs_mode mode,
 		      void *data)
 {
@@ -122,6 +228,38 @@ static const struct attribute_group tgu_common_grp = {
 
 static const struct attribute_group *tgu_attr_groups[] = {
 	&tgu_common_grp,
+	PRIORITY_ATTRIBUTE_GROUP_INIT(0, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(0, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(0, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(0, 3),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(1, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(1, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(1, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(1, 3),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(2, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(2, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(2, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(2, 3),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(3, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(3, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(3, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(3, 3),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(4, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(4, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(4, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(4, 3),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(5, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(5, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(5, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(5, 3),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(6, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(6, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(6, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(6, 3),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(7, 0),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(7, 1),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(7, 2),
+	PRIORITY_ATTRIBUTE_GROUP_INIT(7, 3),
 	NULL,
 };
 
@@ -156,6 +294,23 @@ static int tgu_probe(struct amba_device *adev, const struct amba_id *id)
 
 	spin_lock_init(&drvdata->spinlock);
 
+	tgu_set_reg_number(drvdata);
+	tgu_set_steps(drvdata);
+
+	drvdata->value_table =
+		devm_kzalloc(dev, sizeof(*drvdata->value_table), GFP_KERNEL);
+	if (!drvdata->value_table)
+		return -ENOMEM;
+
+	drvdata->value_table->priority = devm_kzalloc(
+		dev,
+		MAX_PRIORITY * drvdata->max_reg * drvdata->max_step *
+			sizeof(*(drvdata->value_table->priority)),
+		GFP_KERNEL);
+
+	if (!drvdata->value_table->priority)
+		return -ENOMEM;
+
 	drvdata->enable = false;
 	desc.type = CORESIGHT_DEV_TYPE_HELPER;
 	desc.pdata = adev->dev.platform_data;
diff --git a/drivers/hwtracing/qcom/tgu.h b/drivers/hwtracing/qcom/tgu.h
index b60ac0f3bda1..9c2326a3a261 100644
--- a/drivers/hwtracing/qcom/tgu.h
+++ b/drivers/hwtracing/qcom/tgu.h
@@ -9,6 +9,111 @@
 /* Register addresses */
 #define TGU_CONTROL 0x0000
 
+#define TGU_DEVID_SENSE_INPUT(devid_val) ((int) BMVAL(devid_val, 10, 17))
+#define TGU_DEVID_STEPS(devid_val) ((int)BMVAL(devid_val, 3, 6))
+#define NUMBER_BITS_EACH_SIGNAL 4
+#define LENGTH_REGISTER 32
+
+/*
+ *  TGU configuration space                              Step configuration
+ *  offset table                                         space layout
+ * x-------------------------x$                          x-------------x$
+ * |                         |$                          |             |$
+ * |                         |                           |   reserve   |$
+ * |                         |                           |             |$
+ * |coresight management     |                           |-------------|base+n*0x1D8+0x1F4$
+ * |     registe             |                     |---> |prioroty[3]  |$
+ * |                         |                     |     |-------------|base+n*0x1D8+0x194$
+ * |                         |                     |     |prioroty[2]  |$
+ * |-------------------------|                     |     |-------------|base+n*0x1D8+0x134$
+ * |                         |                     |     |prioroty[1]  |$
+ * |         step[7]         |                     |     |-------------|base+n*0x1D8+0xD4$
+ * |-------------------------|->base+0x40+7*0x1D8  |     |prioroty[0]  |$
+ * |                         |                     |     |-------------|base+n*0x1D8+0x74$
+ * |         ...             |                     |     |  condition  |$
+ * |                         |                     |     |   select    |$
+ * |-------------------------|->base+0x40+1*0x1D8  |     |-------------|base+n*0x1D8+0x60$
+ * |                         |                     |     |  condition  |$
+ * |         step[0]         |-------------------->      |   decode    |$
+ * |-------------------------|-> base+0x40               |-------------|base+n*0x1D8+0x50$
+ * |                         |                           |             |$
+ * | Control and status space|                           |Timer/Counter|$
+ * |        space            |                           |             |$
+ * x-------------------------x->base                     x-------------x base+n*0x1D8+0x40$
+ *
+ */
+#define STEP_OFFSET 0x1D8
+#define PRIORITY_START_OFFSET 0x0074
+#define PRIORITY_OFFSET 0x60
+#define REG_OFFSET 0x4
+
+/* Calculate compare step addresses */
+#define PRIORITY_REG_STEP(step, priority, reg)\
+	(PRIORITY_START_OFFSET + PRIORITY_OFFSET * priority +\
+	 REG_OFFSET * reg + STEP_OFFSET * step)
+
+#define tgu_dataset_rw(name, step_index, type, reg_num)                  \
+	(&((struct tgu_attribute[]){ {                                   \
+		__ATTR(name, 0644, tgu_dataset_show, tgu_dataset_store), \
+		step_index,                                              \
+		type,                                                    \
+		reg_num,                                                 \
+	} })[0].attr.attr)
+
+#define STEP_PRIORITY(step_index, reg_num, priority)                     \
+	tgu_dataset_rw(reg##reg_num, step_index, TGU_PRIORITY##priority, \
+			reg_num)
+
+#define STEP_PRIORITY_LIST(step_index, priority)  \
+	{STEP_PRIORITY(step_index, 0, priority),  \
+	 STEP_PRIORITY(step_index, 1, priority),  \
+	 STEP_PRIORITY(step_index, 2, priority),  \
+	 STEP_PRIORITY(step_index, 3, priority),  \
+	 STEP_PRIORITY(step_index, 4, priority),  \
+	 STEP_PRIORITY(step_index, 5, priority),  \
+	 STEP_PRIORITY(step_index, 6, priority),  \
+	 STEP_PRIORITY(step_index, 7, priority),  \
+	 STEP_PRIORITY(step_index, 8, priority),  \
+	 STEP_PRIORITY(step_index, 9, priority),  \
+	 STEP_PRIORITY(step_index, 10, priority), \
+	 STEP_PRIORITY(step_index, 11, priority), \
+	 STEP_PRIORITY(step_index, 12, priority), \
+	 STEP_PRIORITY(step_index, 13, priority), \
+	 STEP_PRIORITY(step_index, 14, priority), \
+	 STEP_PRIORITY(step_index, 15, priority), \
+	 STEP_PRIORITY(step_index, 16, priority), \
+	 STEP_PRIORITY(step_index, 17, priority), \
+	 NULL                   \
+	}
+
+#define PRIORITY_ATTRIBUTE_GROUP_INIT(step, priority)\
+	(&(const struct attribute_group){\
+		.attrs = (struct attribute*[])STEP_PRIORITY_LIST(step, priority),\
+		.is_visible = tgu_node_visible,\
+		.name = "step" #step "_priority" #priority \
+	})
+
+enum operation_index {
+	TGU_PRIORITY0,
+	TGU_PRIORITY1,
+	TGU_PRIORITY2,
+	TGU_PRIORITY3,
+};
+
+/* Maximum priority that TGU supports */
+#define MAX_PRIORITY 4
+
+struct tgu_attribute {
+	struct device_attribute attr;
+	u32 step_index;
+	enum operation_index operation_index;
+	u32 reg_num;
+};
+
+struct value_table {
+	unsigned int *priority;
+};
+
 /**
  * struct tgu_drvdata - Data structure for a TGU (Trigger Generator Unit)
  * @base: Memory-mapped base address of the TGU device
@@ -16,6 +121,9 @@
  * @csdev: Pointer to the associated coresight device
  * @spinlock: Spinlock for handling concurrent access
  * @enable: Flag indicating whether the TGU device is enabled
+ * @value_table: Store given value based on relevant parameters.
+ * @max_reg: Maximum number of registers
+ * @max_step: Maximum step size
  *
  * This structure defines the data associated with a TGU device,
  * including its base address, device pointers, clock, spinlock for
@@ -28,6 +136,9 @@ struct tgu_drvdata {
 	struct coresight_device *csdev;
 	spinlock_t spinlock;
 	bool enable;
+	struct value_table *value_table;
+	int max_reg;
+	int max_step;
 };
 
 #endif


