Return-Path: <linux-kernel+bounces-862103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E2BF4714
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A222188651C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685372EAD13;
	Tue, 21 Oct 2025 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7vRCAm6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D242E6CBF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015586; cv=none; b=XcPrpxmcW+W6fqfWBq1KCNR3/bVNtoXaM4GfHoH1EQs3gob+f/NoeXEt+2GoZFw6/EG4diUCC7jshBE6Qjd8UeavBSrbB+zlAdYr74o14qG+ir/4UEDXir/hOZMm9gpXKbhmYKfoEZW+DXooF8tV5KgAN97xgsBWmj/PsdVD7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015586; c=relaxed/simple;
	bh=8dkpLhswVLviTgeKqNG+UrFnp73bVBkDxmQj4X+Bnkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRxFzQa0CG+P4ykMil0MsHgVi13NxeHDVf/Wt8kNOFU7GQ6YCUD8RKnKBSuH853XUFFufc4PgpiEOrOF0rKmI3sy+7VMhOzoauGHpS0T7+UAsDmx/V2PzcSHfsOUdi5VT7nZ8T7J1/xLIGd9Nj0r1xLlRAcQn5Sdxl6jV8RzLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7vRCAm6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0pfO026879
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q2KZUH63v1Z
	8gu1t2jNlUjejQ4cQ+t1iEooXe+pEjmg=; b=b7vRCAm6vc+JZHzuyHA37icbPxN
	octSjv9TS4jn/91ehA8YQPIkZ4Udi8jFapcPHWcJpY6mzsocg4r+PXRBqBAP2abf
	gTv5JFUg8Olv4kGt/JdhQaIzd0ap0PY9arR5FmUUHJ98blhvlUsCkLRoUH82S6i+
	3oB9nIsKFQIAyIqxux2MhiJmO5ylneRRQBWZ7cTzjx/d0IOUw6T0pQ2ft+xg0HVb
	0NDV1zw8Dqrzr9MAtmIiFqSfrktpCatxDtAgFnQmgYYy/Zj6ZvD1/O9d/945OJ8n
	ztNmoDiKQCrKZsXJaJeSp0Klad9SLqs8xiUsKR/CfOb8Re6TztHYHwtGhzg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pf4j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b650a3e0efcso4127495a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015582; x=1761620382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2KZUH63v1Z8gu1t2jNlUjejQ4cQ+t1iEooXe+pEjmg=;
        b=TdhE3zolyxeHu5ecWS82NFbfTdVxZE5DgMiwnP13Ohu13pxXHIK7wM+OgcpYvqv83Z
         1xrmzupTMbf7KLIkskNR8nA0tMTd72A35W2OzBBlp1DlgC7HGxJKOqCz0+uXVcssQ+52
         T3ATgzZ4EkbeLHrMUIeG5kMzjQQtPApcuFye+wCSkxTdRFshr96ENnNQA369IQYDGCHR
         LKVhu5UwfgLUXms3epaxnXV5Ndh/N+rqtW0RV1VJPx85fGGmkb2cbi8N+Ohb/Yf74zhx
         hDp/bVB6rAdjgx7TYQVCzTnnXzNf8Dj5uri9z9xmnpgl9Ac42f/0TdVllg+/17iTrby+
         2qkA==
X-Forwarded-Encrypted: i=1; AJvYcCWeKtDNrOHkDOv4qe/MnER3ZZx6DtkpdiVJx68GrIlQI+6ghFZnTk04wOwQ1xzO4fzy9VkhHVenFCSRQu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySIQC+4a8AFFuCI74MaUYzxQcQYsJNnp/QdKbmA7/Cbe9QlNQT
	HG75FMwwu4iwItEhqFA9aB3WMAYineUo8ENFNQKOsxlD9z2L3DmbftFi2sAydcSHv2sqlYMao4+
	4xL/38x1DBrV8Sdk639rzXbRRZq+2SJt9PNtC/nvUPuJDCHzhRAZDRzTTPnk/l7rO/To=
X-Gm-Gg: ASbGncsThbnJQAmXKNGLnjBAi5mckqtrjKRaJt8muje07YAwXXHo8sZNDMWuoFTdmWO
	UlEMmOx+RNcDQUersszABMvCUJsHLCsQYYNF0oeOohQf16xKwlxmRquBNAUCZTjksP/Q601zbvh
	PR0cAW8TraiIfk8lhUwzssZbsFgNzeBGgUUtgJpc18lpPTYTkYq/aE6imOf7987BOwRjidC4J0Q
	vxSjEc9FAdWwoCF3wI27tTU/uLlxqD0SgKiC7OGNF4lefmOHPvJ5B8WIIrk2PVqtYuO2cyskKz/
	7xXsK/nTo4lfQD7uqNq3tqFIugMgJ2XiOxIpTWho8P3QcOBTvDhsvCZBnF2zvFBUr+f1diXBLKR
	y4RkPvsD1RYyxe5sEA1DdktxVSuclybv8dKBW81AUTKfspARzkmmd8Q==
X-Received: by 2002:a05:6300:497:20b0:334:b29e:f446 with SMTP id adf61e73a8af0-334b29ef982mr12607075637.0.1761015581823;
        Mon, 20 Oct 2025 19:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0jcVn0s+dyUWucjh1b0Aarnd0rcpt32mcd9fvHDrPCKI2EP2xhQcn0BCYnp6dEz622/jaig==
X-Received: by 2002:a05:6300:497:20b0:334:b29e:f446 with SMTP id adf61e73a8af0-334b29ef982mr12607054637.0.1761015581397;
        Mon, 20 Oct 2025 19:59:41 -0700 (PDT)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8855787a12.10.2025.10.20.19.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 19:59:41 -0700 (PDT)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [RESEND RFC PATCH 7/7] qcom-tgu: Add reset node to initialize
Date: Mon, 20 Oct 2025 19:59:09 -0700
Message-Id: <20251021025909.3627254-8-songwei.chai@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX72heVYsPuMQq
 w6tlWinNelRAprF7EawH6LGvSMXVP5u44L2S2/9ykvKrT7ewVLNFbE26YfsuSskHuu6f6PNmjDb
 xMphoaR4QkTAtdOpSrqLQTmvBCGgVujFgm4s930cb/bmzbUO/grm2o7a5hvFJCmaVEjy22mpI3P
 uDDcAUqNP5jFSUBSQTGvAI+BLd1uTuvCrrHEtgAbiiUzz5DK9rLR074pvDjGDloJZGutA55BdXn
 gCeuU4udLgvVq6V38brBsaQ/jsmarQr+2l1+Bo6hIE5dc47Ws9nP19/nwCrcFWSEXI5JHfV5Kw0
 WTXlpabBkAv+nuo5dxEr3JHeNSzpSvY3401osK+HK7+iqC5sohxEj5U+RQLz+Kk+OR2JFbQIBPp
 LzZw/PHcsEA+chgnNm/mEkcfrX6f5A==
X-Proofpoint-GUID: lsZxODvz7wIPjhF4F7-dWMngyoctj2Nl
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f6f71f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=IgPCHI2mAnvcCQI4J_AA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: lsZxODvz7wIPjhF4F7-dWMngyoctj2Nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Add reset node to initialize the value of
priority/condition_decode/condition_select/timer/counter nodes.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tgu   |  7 ++
 drivers/hwtracing/qcom/tgu.c                  | 75 +++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
index a57bf9783641..c9e12b298b23 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
@@ -42,3 +42,10 @@ KernelVersion	6.18
 Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
 Description:
 		(RW) Set/Get the counter value with specific step for TGU.
+
+What:		/sys/bus/coresight/devices/<tgu-name>/reset_tgu
+Date:		October 2025
+KernelVersion	6.18
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Songwei Chai <songwei.chai@oss.qualcomm.com>
+Description:
+		(Write) Write 1 to reset the dataset for TGU.
diff --git a/drivers/hwtracing/qcom/tgu.c b/drivers/hwtracing/qcom/tgu.c
index c4ae1f27d9ff..9bef9d8b4690 100644
--- a/drivers/hwtracing/qcom/tgu.c
+++ b/drivers/hwtracing/qcom/tgu.c
@@ -434,6 +434,80 @@ static ssize_t enable_tgu_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(enable_tgu);
 
+/* reset_tgu_store - Reset Trace and Gating Unit (TGU) configuration. */
+static ssize_t reset_tgu_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t size)
+{
+	unsigned long value;
+	struct tgu_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	int i, j, ret;
+
+	if (kstrtoul(buf, 0, &value) || value == 0)
+		return -EINVAL;
+
+	if (!drvdata->enable) {
+		ret = pm_runtime_get_sync(drvdata->dev);
+		if (ret < 0) {
+			pm_runtime_put(drvdata->dev);
+			return ret;
+		}
+	}
+
+	spin_lock(&drvdata->spinlock);
+	CS_UNLOCK(drvdata->base);
+
+	writel(0, drvdata->base + TGU_CONTROL);
+
+	if (drvdata->value_table->priority)
+		memset(drvdata->value_table->priority, 0,
+			    MAX_PRIORITY * drvdata->max_step *
+				drvdata->max_reg * sizeof(unsigned int));
+
+	if (drvdata->value_table->condition_decode)
+		memset(drvdata->value_table->condition_decode, 0,
+			    drvdata->max_condition_decode * drvdata->max_step *
+				sizeof(unsigned int));
+
+		/* Initialize all condition registers to NOT(value=0x1000000) */
+	for (i = 0; i < drvdata->max_step; i++) {
+		for (j = 0; j < drvdata->max_condition_decode; j++) {
+			drvdata->value_table
+			->condition_decode[calculate_array_location(
+			drvdata, i, TGU_CONDITION_DECODE, j)] =
+			0x1000000;
+		}
+	}
+
+	if (drvdata->value_table->condition_select)
+		memset(drvdata->value_table->condition_select, 0,
+				drvdata->max_condition_select * drvdata->max_step *
+				sizeof(unsigned int));
+
+	if (drvdata->value_table->timer)
+		memset(drvdata->value_table->timer, 0,
+			    (drvdata->max_step) *
+				(drvdata->max_timer) *
+				sizeof(unsigned int));
+
+	if (drvdata->value_table->counter)
+		memset(drvdata->value_table->counter, 0,
+			    (drvdata->max_step) *
+				(drvdata->max_counter) *
+				sizeof(unsigned int));
+
+	dev_dbg(dev, "Coresight-TGU reset complete\n");
+
+	CS_LOCK(drvdata->base);
+
+	drvdata->enable = false;
+	spin_unlock(&drvdata->spinlock);
+	pm_runtime_put(drvdata->dev);
+
+	return size;
+}
+static DEVICE_ATTR_WO(reset_tgu);
+
 static const struct coresight_ops_helper tgu_helper_ops = {
 	.enable = tgu_enable,
 	.disable = tgu_disable,
@@ -445,6 +519,7 @@ static const struct coresight_ops tgu_ops = {
 
 static struct attribute *tgu_common_attrs[] = {
 	&dev_attr_enable_tgu.attr,
+	&dev_attr_reset_tgu.attr,
 	NULL,
 };
 


