Return-Path: <linux-kernel+bounces-764331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD49B221B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE9723ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84A2E5B0F;
	Tue, 12 Aug 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DiRcSEIu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2A2E9EB4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987889; cv=none; b=ZUZj0owKKTK8Y6oaJnbHYXZFTY1J7ve5HwffcTh2WuG74FO1JV8gAR5PuCaDNqswlPRx/6CuRQV+eUdfg3YFIRdq/NB6nlTRTXx6VltD3vXtbYIfQsmDQ0r/4zqgHzICDfnBEoBTW2UUp9OkBHD4YFk+SK/8nzaHYB0l3xwn3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987889; c=relaxed/simple;
	bh=7JykDjPK767tZ43BdVcJfvn/WRbg093jCfiuGDNITBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFbYAcxEd9wmPeZAZ5L76LvaTLL7z+FNG/tzhjnKdCTBpF3UA5rdWJsIrugv+IVNztlDCt+zx9c2KMA7kWqUs/xHoGMoZVhRtpsMONSZsi3ChJvyOWWKP4OBvu+cUdhVBUnuVDR7oDgXMyRVf7CfXJgql/Hb6U+GlnCnp+MDp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DiRcSEIu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5Womk029132
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QoeGXn7mj0x
	vk3qJvFMf762jOqVA+60Yk/pH1LCpYf8=; b=DiRcSEIu5ZeVNAdfJ9HHI2UerKH
	cSazn6xFCA9NF0XLgr9RRTL6uzxLFS3YWYC+1FtZ6qLYG9VQ0T3nQ9AM7BtHYLoh
	Jlvs6gZ4QkAekdwkX8QMCWIi6LLRDs8PQmgYgYyscOIa5imMbDysuvk7HELCJg4i
	CFaD4NhrOY4UkfAeVuqZBDw1OaR6ieWvjOjIKGDFYtbLMo3kFUK6x6loIMLYPXaJ
	m1SIGzlhSwPyDIKBSEP/hDtIUlyYQdQ7x78PhGg+4z9N2I9DVquK+8BDBgVxQB0Y
	HS0x3omCUhcKJTpX3iFhd4Hrntt1KlO97PZAF+dvlUdPcYjsADQ5r6tpA8A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sqkg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so5071481a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987886; x=1755592686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoeGXn7mj0xvk3qJvFMf762jOqVA+60Yk/pH1LCpYf8=;
        b=YEyQ6JfNojnOPip7SKE3Fqjjkj1B8dIISbBtWA2OGGlP0pEvWOB92xczbtYQWpUYq3
         pmiQnKRv5QhNXytzvZXOtEfog+0F7dKY9NHB7dmq+FjYRKmnIrBNYvZhV/8VMNp05Egj
         RzErB9QwSd7E9Wcz0rynYYF+clEKSf4AV95gRwUrO/BibDMTZRmpN+mRzhRi3LxUoVpw
         hWFegbpTV7aD36hDtox5JTaX0BAE3fzCAXRz6Y5bBUtL0xMiPSzTM2UPtrRvjrzkOj7J
         QINYwQjbIw8MoHHiDciIuwQ/B/I5pDTGaRs2s6TuPbeL8q/H3aaq/Dbl0NHo3q+qvG1k
         QJVw==
X-Forwarded-Encrypted: i=1; AJvYcCV7YWia9aYFN/PUAOd6Yb38tHnwVkiBbRx1qkuwjp2z+N8RyfsB7DKI6kUhO/OlrIqnDmEBJ9yAeVM062A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAUI+CVpuD5lAny2vl/1LtoC1SHQh6TYWrbmWZ/c02bDV5Ome
	3qzWsXj9wBPV15Oo3VewALzj7X+4NkXCZtJzJnSODFsz7pXWLPGcW/rkL7ADr32xZxpkQdN/6U+
	J2xjRlUFrrGLXEbFn/jbrc+9diiJIN4AQvh1xaUkgxSBpOynJs4FySAz/sNSpUJoiHrE=
X-Gm-Gg: ASbGncsY9J7dSZZ5s/aXi0roMTKy+HESff3jddW3Bj+0hXUkU0D/LfAMX9Gp8O5g8rP
	7ljmk5Ausq+33oHS3ZGaK0jr5MYJPV0Dd9V7/sdnFypJACkcZN2tMFrx63TARGIBn9Ho4VvdHVI
	1tcxpNVbYQPxg7FKJbSgXXiShHybpCduanarx5gDmCVwIcPJlEylSVSo30ynn7e3tEA4RQbN1Or
	7zOQCGTY77kb12DnKUFwzwVDRG1Q1GSWhxe+G/Z+ZV5FMkCHz11CNtRfDHr8GPOrWGAfGHusiBs
	jDddTloU9FNY1Lcjfi1wCU2FJ4sk0eck5wH4AEoGe5ihpjIDECdeHodHJKgbZ3B6iXz6ehPePU6
	7/6rVnn/TzdQfTbPkikQ=
X-Received: by 2002:a17:902:cec1:b0:23f:f39b:eae4 with SMTP id d9443c01a7336-242fc32a4b4mr39002685ad.9.1754987885741;
        Tue, 12 Aug 2025 01:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET9VO5P4ZRdMO2sMpbOqfeJjlpt9JwuEh8ou9XqceDwgQAmb4qLnq4jupgSMl0CJgtynW4yg==
X-Received: by 2002:a17:902:cec1:b0:23f:f39b:eae4 with SMTP id d9443c01a7336-242fc32a4b4mr39002355ad.9.1754987885263;
        Tue, 12 Aug 2025 01:38:05 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:38:04 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 5/9] coresight: tmc: Introduce sysfs_read_ops to wrap sysfs read operations
Date: Tue, 12 Aug 2025 16:37:27 +0800
Message-Id: <20250812083731.549-6-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
References: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689afd6e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1hiE41pZ4Zj50arX-_gA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6GglqSUCTuzHjOKxejU4ZhvhtpNX4tgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXwg62K/FvP7NV
 OUQ/suw+umE4D9CtDosXUYALtf/tn2TTegotU5akUCU04CRcmiWBE2zesKx5RnjEAbxNoq9FQu5
 AqZCmN4t8NJDAYlp62yI0ckzYTm09SXppwQoqvcYSgl4zi4Lbm818yvCG//iMGRLlZmLxDIcvEr
 B0twIU377Fpg4cNBwCf2X8xZyeyaYHAVkW1blRQE8U1sHb2hGC8Xz82S1llaSc36sHRPLVMOwB9
 vAD+1z2jj1WaTm+pX8QepQBWMT5lnEmkiS8OltEn1rnD2CwNYsbCkvrJAlHrwbjQRPOaTdHBVCC
 k+huMwSGMnXMUZiSe2Sv81IwNNgZ8ZTTHAPsoppMFiumAzeIdaJLWmsMu4DJn4gBTnIB8HC+uJH
 OnkYT4FN
X-Proofpoint-GUID: 6GglqSUCTuzHjOKxejU4ZhvhtpNX4tgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

Introduce sysfs_read_ops as a wrapper, wrap sysfs read operations, for reading
trace data from the TMC buffer.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 50 +++++++++----------
 drivers/hwtracing/coresight/coresight-tmc.h   | 18 +++++++
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 4d249af93097..23c8e903a474 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -232,17 +232,10 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
 
-	switch (drvdata->config_type) {
-	case TMC_CONFIG_TYPE_ETB:
-	case TMC_CONFIG_TYPE_ETF:
-		ret = tmc_read_prepare_etb(drvdata);
-		break;
-	case TMC_CONFIG_TYPE_ETR:
-		ret = tmc_read_prepare_etr(drvdata);
-		break;
-	default:
+	if (drvdata->read_ops)
+		ret = drvdata->read_ops->read_prepare(drvdata);
+	else
 		ret = -EINVAL;
-	}
 
 	if (!ret)
 		dev_dbg(&drvdata->csdev->dev, "TMC read start\n");
@@ -254,17 +247,10 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
 
-	switch (drvdata->config_type) {
-	case TMC_CONFIG_TYPE_ETB:
-	case TMC_CONFIG_TYPE_ETF:
-		ret = tmc_read_unprepare_etb(drvdata);
-		break;
-	case TMC_CONFIG_TYPE_ETR:
-		ret = tmc_read_unprepare_etr(drvdata);
-		break;
-	default:
+	if (drvdata->read_ops)
+		ret = drvdata->read_ops->read_unprepare(drvdata);
+	else
 		ret = -EINVAL;
-	}
 
 	if (!ret)
 		dev_dbg(&drvdata->csdev->dev, "TMC read end\n");
@@ -291,13 +277,8 @@ static int tmc_open(struct inode *inode, struct file *file)
 static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
 				   char **bufpp)
 {
-	switch (drvdata->config_type) {
-	case TMC_CONFIG_TYPE_ETB:
-	case TMC_CONFIG_TYPE_ETF:
-		return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
-	case TMC_CONFIG_TYPE_ETR:
-		return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
-	}
+	if (drvdata->read_ops)
+		return drvdata->read_ops->get_trace_data(drvdata, pos, len, bufpp);
 
 	return -EINVAL;
 }
@@ -769,6 +750,18 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
 			"Valid crash tracedata found\n");
 }
 
+static const struct sysfs_read_ops tmc_etb_sysfs_read_ops = {
+	.read_prepare	= tmc_read_prepare_etb,
+	.read_unprepare	= tmc_read_unprepare_etb,
+	.get_trace_data	= tmc_etb_get_sysfs_trace,
+};
+
+static const struct sysfs_read_ops tmc_etr_sysfs_read_ops = {
+	.read_prepare	= tmc_read_prepare_etr,
+	.read_unprepare	= tmc_read_unprepare_etr,
+	.get_trace_data	= tmc_etr_get_sysfs_trace,
+};
+
 static int __tmc_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
@@ -818,6 +811,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etb_cs_ops;
 		dev_list = &etb_devs;
+		drvdata->read_ops = &tmc_etb_sysfs_read_ops;
 		break;
 	case TMC_CONFIG_TYPE_ETR:
 		desc.groups = coresight_etr_groups;
@@ -831,6 +825,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
 		INIT_LIST_HEAD(&drvdata->etr_buf_list);
+		drvdata->read_ops = &tmc_etr_sysfs_read_ops;
 		break;
 	case TMC_CONFIG_TYPE_ETF:
 		desc.groups = coresight_etf_groups;
@@ -839,6 +834,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
 		desc.ops = &tmc_etf_cs_ops;
 		dev_list = &etf_devs;
+		drvdata->read_ops = &tmc_etb_sysfs_read_ops;
 		break;
 	default:
 		pr_err("%s: Unsupported TMC config\n", desc.name);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index ca0cba860d5f..cf1b4e8ba80f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -221,6 +221,9 @@ struct etr_buf_node {
 	struct list_head	node;
 };
 
+
+struct sysfs_read_ops;
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @pclk:	APB clock if present, otherwise NULL
@@ -257,6 +260,7 @@ struct etr_buf_node {
  *		 Used by ETR/ETF.
  * @etr_buf_list: List that is used to manage allocated etr_buf.
  * @reading_node: Available buffer for byte-cntr reading.
+ * @tmc_read_ops: Read operations for TMC device.
  */
 struct tmc_drvdata {
 	struct clk		*pclk;
@@ -288,6 +292,20 @@ struct tmc_drvdata {
 	struct tmc_resrv_buf	crash_mdata;
 	struct list_head        etr_buf_list;
 	struct etr_buf_node     *reading_node;
+	const struct sysfs_read_ops	*read_ops;
+};
+
+/**
+ * struct sysfs_read_ops - read operations for TMC and its helper devices
+ * @read_prepare:	prepare operation.
+ * @read_unprepare:	unprepare operation.
+ * @get_trace_data:	read operation.
+ */
+struct sysfs_read_ops {
+	int (*read_prepare)(struct tmc_drvdata *drvdata);
+	int (*read_unprepare)(struct tmc_drvdata *drvdata);
+	ssize_t (*get_trace_data)(struct tmc_drvdata *drvdata, loff_t pos,
+				  size_t len, char **bufpp);
 };
 
 struct etr_buf_operations {
-- 
2.34.1


