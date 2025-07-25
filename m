Return-Path: <linux-kernel+bounces-745575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B3B11BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB36AC2B40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373312E2652;
	Fri, 25 Jul 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CDNvYbQc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1C2DEA8E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438110; cv=none; b=OFQA/n3X2AQJK9vFHo0oWV3pgpDL//tHxYlMriqU4MANXabwN5s+C6K8jAB4MpDBkPl9711XN8Rywws/iKdz/pZfxkPmv8uEHx/tpRKD+Vlplj5FkgVZP2cVP+auQKC2CmgxuwgGhVT31rkGKjs0Cpyzz1yczvLw4inJbrdCnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438110; c=relaxed/simple;
	bh=NKrL4Nj0hmLJqCwJ6NvEZ6ylEwjfPqZkyrHkYIg9VmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0nmnQFBY9lNAArVRoAPpwnWy37UK98d8taLVqYOzB4IqZ1QPAU5Tyut04/vZxoIBsKM9b4NB2h9KddXr2CpYVdfFY6rnH5ReqUXlzbR2BIkdEwxm/SYTjLRCt3cKqc06XRcaye98BuDzhXeFZbYRkCDcYy79U4EuNT9xC/y12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CDNvYbQc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8gCuL024424
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iioHZAmwo6h
	VI3zR7ywnoptK7Vb4ysh42C1NxdoaAPI=; b=CDNvYbQcGhtKLx9YYOO5H3V+Rtq
	c98QbHIIIwjm5AUAo/pudKMnvsbjfahJr6CsPc9XFLGkLU3Q0D1PwwlQS419TWgT
	XopKBIMU5AUrdi4dAc9NpevFtCG7z0sunBbXl60m/ffddRhxSy5JLqw/Mp5VIIGQ
	Wj6UqKq6ZNSmrVyQV51Vr3Be8RXyhF3WqVhL6ZB3n7zWnR9tQH20AJbR9khJNF6f
	hh2ELWVzGXc62FmMsE1lLcdR6r7hI2atoQzfJ3oUaTfUVg+8sOc2rhl8J3VRsd0t
	v1Z27QvGHOmAaQfMZi+T8Xic2qSUeISxAKLfIHgY1/rL+eYvkpIlsBvCq+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2r9p0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23824a9bc29so33719605ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438107; x=1754042907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iioHZAmwo6hVI3zR7ywnoptK7Vb4ysh42C1NxdoaAPI=;
        b=cQqWLmam6wC+M0m/giiPnjPtdWxJs72SuByeYtkr/8xCALkKivxcsET7X2Bl0N28QY
         xXRRoq/G8oy1uegj5PJSirMKOX9kw0y8f2jK982vK74KL5O0V8lPDHCHVkKrpZGeMRUD
         WhuSBqOR5Lxe7REZ8ylqlVsK7Rer6JNZPhd8PmfitTm/a8memKBpqIFzY2cRbey+chlD
         eXkpPrUQYFhX1YesvxWaJPBfRCUjQtjkFgFNgXxWbWGxZTWoR60s+Bd2tb8Th1cP+WTO
         0EEYlvglaiiJEzXrFXsCNPM6XAuS6FTHVVSa8B6fjFjjoF/LogtvBViiCc1nK95A/h/+
         LghQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxBvhxDbIIn1pc23zdyN+bJkg2ZPXA3ja2x0jA6GcXkKSryp30TvmKiFcrwZuxD/kOZqRQBHJPS6B/P5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4X6VdoW/1obiyvsASGsGjb+JvTDW7GWFMRb6NiyVpD3fa2aU
	KV2UQ2FpmFPUGXlCcypKJrMQAMrIiL8pWMqd7APIUYWncn7KKv9owizVC0E/GiH0IDb2H0dBhJR
	w/Ndu9jTBp5RX+iLbBWEKeLgDXhOilzHRX5pOegCC5IyJrt1DYSuDpiJ2gl1Zal4KgBo=
X-Gm-Gg: ASbGncuCBgAIMfubo26hrT6CsECp3laNbquHLFs8lsXBBdEUzIjDiX1sM6Asp96yh/E
	dqc6iXebj4nwxw+Xoq0mAY2OwTHWuRlzEK/vG6RiZkHcJWXV6ehipQrx+z96gwErEYfxO2O9bOX
	Sw3NMXgoQeztL0QRq/LZW4SuFNzqDno1wMT12XjjF29z0T+VwB37YJGgZfr3rtHypqpfPps1Olp
	5nU7NehB1tnL7hzgmFoAnX+cJ2sap06XAGkTw1IzUt8Lr29tWGF9+vVxyRQ+m1SYO26sREE4+5h
	y3jW5mwzPUGRZu3+9LGPEwm2NE1e5aNk3yWHki1sS70Yvn16FOveN5Qxi3XOdywYPmOqstQuz9r
	Oa1fmcOzS2fJYjx/wATA=
X-Received: by 2002:a17:902:e891:b0:236:94ac:cc1a with SMTP id d9443c01a7336-23fb3179530mr21392125ad.27.1753438106759;
        Fri, 25 Jul 2025 03:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYXuxwAizhGCHBsUFAQoY3a/Si1ZEE+tQGtHTUl73AhqAID/L4Somkm1pNUofePJE1ndnHaQ==
X-Received: by 2002:a17:902:e891:b0:236:94ac:cc1a with SMTP id d9443c01a7336-23fb3179530mr21391735ad.27.1753438106353;
        Fri, 25 Jul 2025 03:08:26 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd29dsm33641435ad.176.2025.07.25.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:08:25 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>
Subject: [PATCH v4 03/10] coresight: tmc: add etr_buf_list to store allocated etr_buf
Date: Fri, 25 Jul 2025 18:07:59 +0800
Message-Id: <20250725100806.1157-4-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NfTm13D4 c=1 sm=1 tr=0 ts=6883579b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ORm1qb0EFYpRwVLUulEA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: NR2zia_0B0UYxZWSluYsJEYN3CpjSybr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NSBTYWx0ZWRfXwa8AokiZIWJ4
 EPJC/q/SAtWhyCI7zRmLH2Fk+gHBnSadlaskuSH5BTSJ8K9oDzmdWxAzDaPEKlDiCEtECDj7arg
 X6+hiHbDu0cCjOgZsBMWhaNETw79rtD7BCYNkAvm5WgExb4AVzgxKbvNcn7mPDcgWZXWCGX2Xq+
 qxkTJybw4soDffzqP6XN6Ojf8YBWBA+YxIW3Cd3UwmaXlyA4V7mgCD8jdN1v+hPyJbA+cQV7FAv
 LgGD5slgKA5D8M5GghHCGoGINQ+lds22IJ2yESkOwanwwGbSwGg/7cgjnBiZahyhnI1iQw3JP9N
 KnlfEX6fQibncVyQVPJYDUZ3w41+neyRNHSdohcuLTP0OQffb4nsB/tDoCMF+b2iUxYFpNCpERM
 Leztm9Tr21N3HDuVPJ1n3MjDKYeJzSmCy28D/K/ET5zMVuVuXCc8H12wk/qiOnvb93OQT4dA
X-Proofpoint-GUID: NR2zia_0B0UYxZWSluYsJEYN3CpjSybr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250085

Add a list to store allocated etr_buf.

The byte-cntr functionality requires two etr_buf to receive trace data.
The active etr_buf collects the trace data from source device, while the
byte-cntr reading function accesses the deactivated etr_buf after is
has been filled and synced, transferring data to the userspace.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  |  1 +
 drivers/hwtracing/coresight/coresight-tmc.h   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index 6541a27a018e..52ee5f8efe8c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -208,6 +208,21 @@ struct tmc_resrv_buf {
 	s64		len;
 };
 
+/**
+ * @sysfs_buf:	Allocated sysfs_buf.
+ * @is_free:	Indicates whether the buffer is free to choose.
+ * @reading:	Indicates whether the buffer is reading.
+ * @pos:	Position of the buffer.
+ * @node:	Node in etr_buf_list.
+ */
+struct etr_buf_node {
+	struct etr_buf		*sysfs_buf;
+	bool			is_free;
+	bool			reading;
+	loff_t			pos;
+	struct list_head	node;
+};
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @pclk:	APB clock if present, otherwise NULL
@@ -242,6 +257,8 @@ struct tmc_resrv_buf {
  *		(after crash) by default.
  * @crash_mdata: Reserved memory for storing tmc crash metadata.
  *		 Used by ETR/ETF.
+ * @etr_buf_list: List that is used to manage allocated etr_buf.
+ * @reading_node: Available buffer for byte-cntr reading.
  */
 struct tmc_drvdata {
 	struct clk		*pclk;
@@ -271,6 +288,8 @@ struct tmc_drvdata {
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	crash_mdata;
+	struct list_head        etr_buf_list;
+	struct etr_buf_node     *reading_node;
 };
 
 struct etr_buf_operations {
-- 
2.34.1


