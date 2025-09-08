Return-Path: <linux-kernel+bounces-804961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7FB4826B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F47A3BDE76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6D1E5711;
	Mon,  8 Sep 2025 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBgy8uzS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCC21FF23
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296974; cv=none; b=EpUdztDr/LTSRmLH/d4fUra8+fhw+hc0ECIlliMQzQbFeaS3anljSpjgKbcpRxbKaYXSebZgrXH3fVQ4Hps+HEx8+2XtznGaoVTmUSvICGa2yt9sd0X8BfBLSH2M9WceVc/M8gvzYj+w8dqfkTBmNR52IGjCqlR6zkQQhEeP6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296974; c=relaxed/simple;
	bh=efcn2pGR7DhIQb6j4jLLIyFVfTFZcmgjLIdsqmZwPTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1VLrFejTAqpGssWAmT5SeeKvviXmypaaCdd6/Y/k5yXZ0y9iaidcbQtPiPUIFLKt0kzQFyCvVH+BF6ozmSJQUA4n2rbNcHXzETe0x2U+0yG8y8H4euVK6GUF/N3Wtp0gn8HRs/o+MyBCXvsvzryqqKRPDxs4CVkE8tUII/tR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aBgy8uzS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Kgx1L009936
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 02:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ciCcBoLZ6vDv+TtHrBJb+8BvkHMHrZMZRLwC/8eQ4dc=; b=aBgy8uzSx3tVcJNz
	DI9U2ZFT+XRXXF4iVD6/Hp6EZ+xcmwfyXF5kaiFqIEufJgsbF2cMLFy7MVak8q23
	MXWOt4r8JZSJx8m44VAXRL1LJ8nM1bm7oVnVm4vGhjDMGJ+buX81owPSrH1fVw0Y
	atUapjEkiJJ9wi9VL9vj8S5NJnWxnyJLb4FoZXPomR7vPGCDehjZmB+nylttPypC
	yE2EmkYY7zwuEUCi/I9dyr999chNWXXtqnWD2lAloXpbImUeINR3Xr1enEtVnenf
	qsBlLFdQ4xahXG+aPT53OBdncC9t3tYgdsXwki6jfD9Y6RoKlEYoxBF85sc4BoYb
	ovFavA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d63aw6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7722ef6c864so3568806b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296971; x=1757901771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciCcBoLZ6vDv+TtHrBJb+8BvkHMHrZMZRLwC/8eQ4dc=;
        b=gqxfTZekaJjx/iKGVjXa+Yskep6XrN7wQua4pdZc5hNlLhpM0o5zDMhWLfZTWEJeI9
         z20hvQMBlK1sDkVUlIuMbgpKPwCpQctyoOIw71YgG/XMbBisLG++/OOO8IOu6NmCtrbB
         X3kcIXJVrqjxwxiUZ3UdMctsNr7LsERmb0DRXhUTA8QYh5FSsQ5zu1ipfCp/wk7+i9fz
         IijVXqtSORXgq1oYWV5MtNo7lYlB+Z3OFUdv4jZacBFL8Cne4GecTkeJt3TNNw6AHnnC
         7/BafPPuTNwaQoQBrzUrgKJYTjSSShjs6KqLTvlplGFPtJE7BxveXo/Fo93OPG7wbs8o
         COHA==
X-Forwarded-Encrypted: i=1; AJvYcCUyYfgVzwEDyWc1/RsNdbuebWnjavBpYgQBbwva4Z3WF0xeegbUC/G1tgmh0NICiQxGhFVU0fyeofdpeqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkoFJAMw/q70sek5zS0kk4AEiE+AB53PUIiptFq8CGMzMh53GR
	uCCoQCZJA0HsT+JdXrzOLsXPMmWGYVEPWoJhfmubVjIlJ35PVsX9novFHaFsiz0aGDVuOHjHA8K
	BypxAmAAtCC1/A27Iba/eDr/mxOVBon6edkGx5SZTvkDimqJWv6iaAKPPKGkzlwufPcA=
X-Gm-Gg: ASbGncsdMliiseRz+w35aEjgKT5jgAtEQ0KkD9TGoPmiIVSe0M0KZ2c0X4ymYSnJ8PA
	GoiOdjLn5ZXELaFC233C0TyyinC0bFsleCP1C5PMzYs/rFmEmBftZWEQI/ZZXsB4cSFsHQXpkJa
	TcPFMsUr8ensCaBSsHRbjRkRBDKaEcxhvrLH+IoQ3Cs+0MNUx8pATe6f6e+pnCMHiSn9NPqOycN
	2tjOV4zv192AKtEvTQrhYdJtzFocdrMz7MJYRibaXVGQX6YuO3cB4SWbD0C7xUzZAGPOhatwnnh
	OGc3DwtvCl/ZN9LjUtNbjl0xoLjtzGH4V59Vf2VT+D+ycyd2N8q8SCXeKtONubYgU5AVe/S/E/k
	J5XdFh9JhU4HpmKiFxlF3MNaciAM=
X-Received: by 2002:a05:6a00:ccc:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7742dd10e6emr7059988b3a.7.1757296971384;
        Sun, 07 Sep 2025 19:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF55dM66GjpWnblDpjAxuh8YqP1+Axkhg/f9PaksW/NF4gH/HYMDtmgowRZrezFrh3z+domAA==
X-Received: by 2002:a05:6a00:ccc:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7742dd10e6emr7059949b3a.7.1757296970893;
        Sun, 07 Sep 2025 19:02:50 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm24285076b3a.4.2025.09.07.19.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:02:50 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 10:01:57 +0800
Subject: [PATCH v6 5/9] coresight: tmc: Introduce sysfs_read_ops to wrap
 sysfs read operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-enable-byte-cntr-for-tmc-v6-5-1db9e621441a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757296940; l=5438;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=efcn2pGR7DhIQb6j4jLLIyFVfTFZcmgjLIdsqmZwPTI=;
 b=niM3vIXOD0hUklEx1yhlcCSHtANh2U5WvJkHiZPqWcGrENm7iywUqgrqpS2QcO0taNH5+6GFd
 WPY3ofXERfZA+eN18PT1p2hc61C7JeySTZYf8Fp+/vVCENPPHOno4a1
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyOSBTYWx0ZWRfXyXiCFXpbUiwk
 XQYKmjCEhiVP6UOpW6Wn7wdAKfQdPORfQLmUC+F1MrxgTdcTpc8dptMGsz7/FOBaa6jJaw8QHpy
 rNv3GcD060Xj36YAVKSAgxRdSigsgV+j1wIWwK2dewNHfbOZmMSJCAj8XB7iRf0TplNqWyhBe3W
 AcsfI+FOgvpEwo8BSM3sJeAqHB2vyroMMUX25bec2NcKZQYzs49TFE7jfuR7vzgCu1WWXMpoSAv
 T26DaJTmFyLmeL07hW8LzlsUJFfdMwnYUgxj6c96FSXpIuARjvvGoie3h+htiHBY54vUIKYAKrK
 vgPh4no6a8gplwM2/ctAuz30gn9Fg7zsIkngk7ar1NfkACwXY3ZWdGldM34gsd39PemD1YwnJ7n
 1VUK/Pnf
X-Proofpoint-GUID: inxOfLry1IFWbcC9E7OrDZlyd2Z91_vv
X-Proofpoint-ORIG-GUID: inxOfLry1IFWbcC9E7OrDZlyd2Z91_vv
X-Authority-Analysis: v=2.4 cv=DYgXqutW c=1 sm=1 tr=0 ts=68be394c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=JzqEjpkVlBH90HjAhVoA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060029

Introduce sysfs_read_ops as a wrapper, wrap sysfs read operations, for reading
trace data from the TMC buffer.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-core.c | 50 +++++++++++-------------
 drivers/hwtracing/coresight/coresight-tmc.h      | 18 +++++++++
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 4d249af93097..ccb177d953b9 100644
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
+	if (drvdata->sysfs_ops)
+		ret = drvdata->sysfs_ops->read_prepare(drvdata);
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
+	if (drvdata->sysfs_ops)
+		ret = drvdata->sysfs_ops->read_unprepare(drvdata);
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
+	if (drvdata->sysfs_ops)
+		return drvdata->sysfs_ops->get_trace_data(drvdata, pos, len, bufpp);
 
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
+		drvdata->sysfs_ops = &tmc_etb_sysfs_read_ops;
 		break;
 	case TMC_CONFIG_TYPE_ETR:
 		desc.groups = coresight_etr_groups;
@@ -831,6 +825,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
 		INIT_LIST_HEAD(&drvdata->etr_buf_list);
+		drvdata->sysfs_ops = &tmc_etr_sysfs_read_ops;
 		break;
 	case TMC_CONFIG_TYPE_ETF:
 		desc.groups = coresight_etf_groups;
@@ -839,6 +834,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
 		desc.ops = &tmc_etf_cs_ops;
 		dev_list = &etf_devs;
+		drvdata->sysfs_ops = &tmc_etb_sysfs_read_ops;
 		break;
 	default:
 		pr_err("%s: Unsupported TMC config\n", desc.name);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index ca0cba860d5f..0d0a547cb042 100644
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
+ * @sysfs_ops:	Read operations for sysfs mode.
  */
 struct tmc_drvdata {
 	struct clk		*pclk;
@@ -288,6 +292,20 @@ struct tmc_drvdata {
 	struct tmc_resrv_buf	crash_mdata;
 	struct list_head        etr_buf_list;
 	struct etr_buf_node     *reading_node;
+	const struct sysfs_read_ops	*sysfs_ops;
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


