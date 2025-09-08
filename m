Return-Path: <linux-kernel+bounces-804958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76A1B48262
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD71179434
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F381FF61E;
	Mon,  8 Sep 2025 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+pWz4pJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907A20468E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296964; cv=none; b=cJ7NEgWqgu1n4GNeDHiygTx2WYCFdx+YA2gWkDtYSIDQvkGTqEjPJtTpanyHM30SodxQ8T6tosUDa/ZCM/ps7WI2YxPXK23nokGKT6AMxNJeLyffsOD/3N112AlemWCxNGZB6aKbkjBuMRHJ9AfIBmq4kcZJVT2lXT/3hcWGmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296964; c=relaxed/simple;
	bh=J8gJ/mYXIto4Pqb6SCiL46R3ybLriqfOejLtEnfdnig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzYuPHmXHSUmsK0msV9qnCFeOUIEK2Uif1R9ZTkx6LCReg1EH3jX0+EyrZs6+OBsXidHERPrUDG+686CiwUZlaK9U7yhHjRoeBAdx5KBBUYNnWh+tvVk9G5eao/7AtCs0qtkSsUSdhty3R2Em98uC2xc8/NYS/BJVvVyb2ew/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+pWz4pJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NkE5n000692
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 02:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ge78CRxNCocviT/6Co2pp0hTuCE9iUxm3FJF2+Bl2q0=; b=L+pWz4pJd9z19SHc
	QhZdQRRR/SitNNd1Bq80X7zjU+54Y/LdnCenKR9GmGnIgN638ZU/qyWU6zjjo3ix
	5Hb25F7SbixhEWHOY40xokMsmUl2IcIn/AtljbAogEM93GPxIAsq+ycfQcAPvqmk
	DzMI84D55YAWFmRlBYOEcrR++BJLNPbgKap8W+LuJwC8Ggt7Dm4poxsefz7BKvdV
	NKBOmsi+q3lRJsovq3Y+w4BcBNHmG7QGv99QRAnNoKyeFPfx9VbJ72GKTSo4h9U8
	Xb3vWPHR/YhrtLd3dlXL4DM1phRUI/lqmZwJQLq+GNBysyd2NA623p4dAdhuACLm
	LXfSgQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws30hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c949fc524so3050480a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296961; x=1757901761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge78CRxNCocviT/6Co2pp0hTuCE9iUxm3FJF2+Bl2q0=;
        b=XIeRRyIf8cbcJdTIRt4HluOmqt7lH3IyRHj6573WcmWV2OlA8b5eU9EQ3D4v90hKMc
         Is36K+lAqXIeJTRLMuK5I9MDDTHc5211qiQLRz37Ji7mz/pl/nH6zW89Z8qEXODQMe8Q
         89o76LI5Sb5UZiIAD1qZm1ZIDS0plJk9EX6AHlsF85k/gd9JV1A9fgltoE2I7wkDPKid
         blIXSBjfkBkosTwpzlsxHK+ASrnHfGo7yvyzlm9+j9qqYxh2l1Jc5x/oI0ZA8gTgwcJm
         FGtvxlosaTppi3zE26l8oBfERlX2yEH0p0QA3ZGzgv5Tam+B03mRyS7ncv2uSo5481TK
         Y8vA==
X-Forwarded-Encrypted: i=1; AJvYcCXAhTEoW2YdWhURkuBTQpVnz1PtcvbTmP1bKhsX8nI8DVND2e+5esRTehORgmNjX90C8gMk65AyWHn2g8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPQ/b7cjyWPElPxn7Oh67X4doLsdfQwD4F41nrJP6oIbbddEb
	A8XGH+C5NN5TG0oQ5OoQgQ12ayeXlBlz6/8nyOkhLJUAzTvVBnbUfH8wk0Ja3o2KCA0QTxJBf8i
	6zTcDjLWSxsfkL7ZpwdWzu2FAlTxCzaxzMWpNiHG/4+S8AcxOOe19Hh42Oo+yeSq34aI=
X-Gm-Gg: ASbGncs3W9/UEpO5ILuSWZmJ9kqMoaX8G2fHiYWz7JH9+Ug82WOIq1YDzZXQ1Np5yZU
	62IJ16NnaHxAFun82uPsBzQ2uqzRS96wjytoBijwsEvtcW7D1QJ/BLO2j16WaRPyD+Q41NTt9im
	QqgH6VrFxfIaqQ+uP8AHt7PZW3cwYi+vi2X/qNed4zNvhTu9r6DFxnXSjiKyp1OtGM4F3RKYoUP
	Z2xTUtUniw3El0ytiKiBmGYUD8hVMKxD/icr4Y/CwJ4brPzr+BkJOFZIC409lk0gqqTjUGvcu2o
	dcyufGogalCkfoDvJze18E6CN/rsgyKJ6017tHPFtpm8gyWPMETaUDEfbKBzVjcL7DfStcAOPzJ
	hoOHob6aR/+m3GL8TF31sBQAPzIQ=
X-Received: by 2002:a05:6a20:7f84:b0:246:291:f62f with SMTP id adf61e73a8af0-25345d2ce0fmr8120750637.49.1757296961153;
        Sun, 07 Sep 2025 19:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmxlgXwobw+6sYCcX7nSaiEH9SoZom4Tkgi5DROFCRYnQhezoOJA+JdGnUlTuZvEyeQEn/Eg==
X-Received: by 2002:a05:6a20:7f84:b0:246:291:f62f with SMTP id adf61e73a8af0-25345d2ce0fmr8120706637.49.1757296960626;
        Sun, 07 Sep 2025 19:02:40 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm24285076b3a.4.2025.09.07.19.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:02:40 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 10:01:55 +0800
Subject: [PATCH v6 3/9] coresight: tmc: add etr_buf_list to store allocated
 etr_buf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-enable-byte-cntr-for-tmc-v6-3-1db9e621441a@oss.qualcomm.com>
References: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
In-Reply-To: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757296940; l=2488;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=J8gJ/mYXIto4Pqb6SCiL46R3ybLriqfOejLtEnfdnig=;
 b=7C7yn707Lsimdprw0DZkaDMCHAqIYdRQAOXnK0GeVx7h8jA1BavXgvNmroqj+Ox8oukZ3q3IE
 b4gs6HH1T8nDbUL+jeKB7WQNVjNywsynjftCQ/HYJnMCIIOvMK2M6Wu
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Proofpoint-ORIG-GUID: I7eBLWNyRTa3fks2Y_Uyk651JCVtnwwh
X-Proofpoint-GUID: I7eBLWNyRTa3fks2Y_Uyk651JCVtnwwh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX1QD6DU+WjEJZ
 mrxFnba45OHRq9y3qVZSCYq5kX0/vYERINoUX2c0dVgvhh3OarvS+9ZhJiVD3zh4Lqt7/W+wT/c
 qc2YBhwK+FBc9Mhj9oshsv3Nxl4A91Hm7WlQdkgbjOJ2I95nTpVnTM0AyAMq69OdPFf8VX4XIRJ
 tss2o9I9121z/z0JVTbJD9Bc/irmU8Py1U2SCmwZXMscCHPEgikzKN3wch9T6JEa8E6/RiqvtcI
 I3KoSkamSbmCcrjQlTVMJD35AN6Zlyb59/ZYVWm2b6/oRPcJVE5UP2dFeyl70/4V15YhFrh5amn
 0D7LxlBMS7jJyj+IJkbCIPNZOi+bqtYx6nfRoR97rYgrAONhHYhMHcZqAX4+/i7tkOxgQYtxG29
 kn17YDA+
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be3942 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKaT4joegMVsfAxsIjQA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Add a list to store allocated etr_buf.

The byte-cntr functionality requires two etr_buf to receive trace data.
The active etr_buf collects the trace data from source device, while the
byte-cntr reading function accesses the deactivated etr_buf after is
has been filled and synced, transferring data to the userspace.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-core.c |  1 +
 drivers/hwtracing/coresight/coresight-tmc.h      | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index be964656be93..4d249af93097 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -830,6 +830,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		idr_init(&drvdata->idr);
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
+		INIT_LIST_HEAD(&drvdata->etr_buf_list);
 		break;
 	case TMC_CONFIG_TYPE_ETF:
 		desc.groups = coresight_etf_groups;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6541a27a018e..292e25d82b62 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -208,6 +208,19 @@ struct tmc_resrv_buf {
 	s64		len;
 };
 
+/**
+ * @sysfs_buf:	Allocated sysfs_buf.
+ * @is_free:	Indicates whether the buffer is free to choose.
+ * @pos:	Position of the buffer.
+ * @node:	Node in etr_buf_list.
+ */
+struct etr_buf_node {
+	struct etr_buf		*sysfs_buf;
+	bool			is_free;
+	loff_t			pos;
+	struct list_head	node;
+};
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @pclk:	APB clock if present, otherwise NULL
@@ -242,6 +255,8 @@ struct tmc_resrv_buf {
  *		(after crash) by default.
  * @crash_mdata: Reserved memory for storing tmc crash metadata.
  *		 Used by ETR/ETF.
+ * @etr_buf_list: List that is used to manage allocated etr_buf.
+ * @reading_node: Available buffer for byte-cntr reading.
  */
 struct tmc_drvdata {
 	struct clk		*pclk;
@@ -271,6 +286,8 @@ struct tmc_drvdata {
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	crash_mdata;
+	struct list_head        etr_buf_list;
+	struct etr_buf_node     *reading_node;
 };
 
 struct etr_buf_operations {

-- 
2.34.1


