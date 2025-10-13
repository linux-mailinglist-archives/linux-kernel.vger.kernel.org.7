Return-Path: <linux-kernel+bounces-849975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95836BD1840
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F16F34EB53C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AFF2DF139;
	Mon, 13 Oct 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PBfz9rxQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B642DF134
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334593; cv=none; b=hxTTAeVyKitdFmSxmQaQDc6Y7rwDzQS1lXApH6dGtcqJl0I1k/6H5ahtWVp43kkCmukDELPU745eIPJ7bY4kfFUq2cnkL0pAB22ek6uJxlMhf/Qpa+QDY7RnVrh7XiagWZV35oLPv40YqWyhI5FKq0CNJYKfDsydsfJ+7HZsxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334593; c=relaxed/simple;
	bh=10r2p+lUL97SjjNd6VbYPMcgBU6TACiRJ4ZXQMgPz68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1ZnodK8eXnHudxDQ2GmOFtsy84hSfDAQ191CqorWm6mEdtVBE2lJchA+lHaNfQJJTS/b98RQHSij0wa4Mru0FsF8BlwWTKL1RM9NXtFCpM/DsMRYzmvH2Rgs1yPEpNkevPBy060boDXny0CPdw53asjiqhnkIDd2rSxqtSlkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PBfz9rxQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nJE6011079
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZkIN+ISyGlutvlt2NEMKQZoAZi5qldb0Whjc6pZ8WQI=; b=PBfz9rxQhMARe9AE
	PRXXEVnwj4yGngiyLZl702p6ChexFz/KHXt1Y1R/iY1sT9a70+Xe8DgnAZpmgpxM
	gUhy5JCaMgdY7JU/IQMaO0JMQ1PzBXwjOg8LzvueH9G8eEAX9wVSdkQXEdTjhBCA
	pzcsfwrAcp5J92yt5lf6MxmUu3lyoW56R+sdEdmnHdxUXUyfJdLhM3Ep5hpDVhTt
	3gmQ6B+2IIH27GP0RfSMt31TmLKzDBWN6Hka2Uhkw8swljhWzcU60Ay6cLELKBhe
	sgOOc3c3df7KcRYWP2Tj0JDhhb8Lsi1qq+WUKX7znP/rZgoESqkwZGrcSLOa+7EM
	jo6jLA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0buasn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso6679964b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334590; x=1760939390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkIN+ISyGlutvlt2NEMKQZoAZi5qldb0Whjc6pZ8WQI=;
        b=lJrP/iltqnWxi2xyOazs88geXcD3k4/NPr9uao3UlzaZkWl4iPlUzXWZti4TQuy+cA
         mWdsq1qh8RRcgldMJZIyAQSeiaGzLVV3h+CWKjT9hD2GHpAheF6ocUZQiJG2vsmD/DPz
         Gf/FolcASyBU+8yF//o00nPtl4pHfh8hzxREFWi/eZ44og/xk0XdpKCCjWrK0NYD3u3v
         DWTL1iYTqvVH1b00b8dkYsDiPxj9a0Olqrl2a/mgPc41UZ97ylnT2yAI77ciksC72+sb
         I/XcZIYIMZTKkWuaG7hf0Farg3gAKGTx9zX9+DB3GYeUirGqcei8O9r2ureKwCn1f6VM
         9QoA==
X-Forwarded-Encrypted: i=1; AJvYcCVNXzCTGEeupCEQV/q0bxJs/kUAzm7ENyKg3cJLmid3Ij823vJM5y9YgvM9hxqK9Ulk1eNegifl4Zh4cd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7FOReZr2yvSTK3KfA0+w2BG8ViMXh/fFH6I3FFxn5b7yZHa5
	KqEu7+LBTaMl6Jq30O9APsAfRtlrE4GSgrQi9I1UdRoNoBzzd631DK2+bXLrRs5/X7syI+Q1QmP
	kF+4XFVzxisjI2L42s/4E7NE+8pqSePGqU96gigC7RGEfdBx/aHaKRC66JRgPtv9a7iE=
X-Gm-Gg: ASbGnctDyT4M3Db56G+9a6gClm2NhT3Xr6/mueHSNXVPpEM9b0+pyvL93+Zjw58v549
	3Ik/u+JH/ooxMWfsSvFYqrvqTzpkF2mwfo52EUwbhalTlO1U5EBfDvVAVYOlxzPoSzNT9vN+DLu
	edgNkfL4M2Ib1YHTp2D0Ytoi4W1ERKzqSzGBJZFKG1Gbcn0/pgc0vE4WUmxGZguB8Yw9ZsPep7A
	U3u3EVPeWyrc9QC1zWbWVz5UiS/8YRzLg6QHAl0G/QP82Z1dIh5fL7H725hXG955+55TDhgCXNJ
	ylL7SOVgA8t/AdsTJ5L89Y5B0bQvKQpuwx7D5paCHH5B0nMV+ECdhbkRcL8+PGSsZA5skGXwegK
	5dYknz+kX7UKza5qcvhjeaT4gObE=
X-Received: by 2002:a05:6a20:6a22:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-32da8462b6dmr28772866637.52.1760334590550;
        Sun, 12 Oct 2025 22:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpP68ZqK4+UvkVBHdSzmeGF1Q2trMe/iCV1+fn9Hztu2xKfyuF9v7sHWahUZiBVWhJ28yWUw==
X-Received: by 2002:a05:6a20:6a22:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-32da8462b6dmr28772837637.52.1760334590084;
        Sun, 12 Oct 2025 22:49:50 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm10129898b3a.59.2025.10.12.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:49:49 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 13:49:12 +0800
Subject: [PATCH v7 3/9] coresight: tmc: add etr_buf_list to store allocated
 etr_buf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-enable-byte-cntr-for-ctcu-v7-3-e1e8f41e15dd@oss.qualcomm.com>
References: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
In-Reply-To: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760334567; l=2504;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=10r2p+lUL97SjjNd6VbYPMcgBU6TACiRJ4ZXQMgPz68=;
 b=TcfJD9lvwCRECpc6GFuMsYv32seaGMY2B/UhPBYTmToKLZom7XEaBYDRDh6Oo98VP5iFlZQys
 MAO+62B9l+dDTdIP8xxlRXOFmJccz3DCs+swKYykjJLZHlcVSPwBdzt
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: DdGTlsRi1uQiOWUbODQeWhdyq_5OqqYj
X-Proofpoint-ORIG-GUID: DdGTlsRi1uQiOWUbODQeWhdyq_5OqqYj
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ec92ff cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=KKaT4joegMVsfAxsIjQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX3xKo9iMpbylk
 SSXkEizFR5z3/5q8VCENHCxkaWLZVwhTwI7sKyaLa9fptCzoAbQv7/mdHw8QDjW9ynaWOOq2VFh
 XKPOSF39H4CMLh+MC3/z+CxDQEpnlu5qbtATSd9uS9ImEm+y8ptEkNoO27d1vHc4gmHRz+WrFSI
 RlNWRDiWUPgGPv+WtI0NvbRe17P8yACH9eOwL6at7x3wc+L6mF9eqnGNay+yQr4bAjXkFNSRLyr
 6JMSkdXDbmTHJVzvgoEoCQTFur5zvCIhw9lvYEt29wtivKLNoCLPrTiNM5rmRnrxmsElI71jHlU
 04c/VOjNNbMbG2GACyGcjyjkonjrFLx2kJpaG0EECg44ZcJkc99azZCxkQuh7CoPg1QGtMJMUmN
 Tv8Car4QDZr5+xwMeN2yPFs5OH36gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

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
index 36599c431be6..1ea255ffa67c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -840,6 +840,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		idr_init(&drvdata->idr);
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
+		INIT_LIST_HEAD(&drvdata->etr_buf_list);
 		break;
 	case TMC_CONFIG_TYPE_ETF:
 		desc.groups = coresight_etf_groups;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index cbb4ba439158..3a6484998530 100644
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
  * @atclk:	optional clock for the core parts of the TMC.
@@ -243,6 +256,8 @@ struct tmc_resrv_buf {
  *		(after crash) by default.
  * @crash_mdata: Reserved memory for storing tmc crash metadata.
  *		 Used by ETR/ETF.
+ * @etr_buf_list: List that is used to manage allocated etr_buf.
+ * @reading_node: Available buffer_node for byte-cntr reading.
  */
 struct tmc_drvdata {
 	struct clk		*atclk;
@@ -273,6 +288,8 @@ struct tmc_drvdata {
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	crash_mdata;
+	struct list_head        etr_buf_list;
+	struct etr_buf_node     *reading_node;
 };
 
 struct etr_buf_operations {

-- 
2.34.1


