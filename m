Return-Path: <linux-kernel+bounces-764329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469DEB221A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BFA6E2BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9852E92D5;
	Tue, 12 Aug 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZT3lTJhA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF252E542E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987879; cv=none; b=H3HGzESdnds2Yky72FH2u+W9F10zqo/QZxm/a7fJQkjzOVwLi4Xqs3FOCT4wUNyEMccZjR5a/lFiVi1be8LpXmaAJ8wwV8K6tZnoDwMxkx2JyMRoD6mfD86HfR6/05YoJK8zWBgfy44stzj/HbDsviwSY4Qja97oTqJNuRgjxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987879; c=relaxed/simple;
	bh=XGiX4Gfca5hhkZ5WBB5kzoN3+KaO9zxGm+JxwB+Qnqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlFbggGsCASMQIpUeTXuJ+RSgJFkRErMY3d2aMJZXqmEyuGlKUVuw8TlRtPKQz4klCS8c6IFFrBBcG2wc8p266NF2y2WFy3d5CnZvuR29cgiY+x9KVyjhWweyrtUHnS1LPLlkLe4B2k/HzVOQFlgJS/xe1Qke9jU4YJ850/xkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZT3lTJhA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5Y7ld022400
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x1IUpmlclQ0
	9bHbCcAYuy6OSpZ8BPA7QouFBaqx7SR4=; b=ZT3lTJhAaIKaH4BVqDqRNS0xXEX
	lFUrMOzmBpNorqpYX2q4LRTIkcj6NzzoQ7sOVX+5ivF3sbaqGs38RgNEGw1H3p/+
	B+8WvrCrl92OGiCbcQRtTFf7cYZhz+xep2u7r8np4k8WNgiXgw9S1DA+Jjsgt9fj
	U0OGPBw2NkkcXfCrk/dXpNE9grpf9NMmmNUp5hHpRzRHLHjUXSs+4+yXG0P4W0mv
	YGcGvtzTSRmuibOfd3HSzc3plNTDAtlKB37weNjHMsAoRcqyPs7gWAJrreyTwihh
	3w4BCtOtPKiQwiszSen6ATR7NNIrKLdfSlqHl/o2NCSiRS3jzFYZicuOedQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vja8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-240607653f4so46415775ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987875; x=1755592675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1IUpmlclQ09bHbCcAYuy6OSpZ8BPA7QouFBaqx7SR4=;
        b=bZw11jyjOn7By67E4JH7MHPnEVD5YGd/ez2u5D36QnHs60/gY3/aTZosgObJ1mdGdD
         vc3zpaZjJLFQ8tEQhcolDECRJHl5mMoVB1vQGjGiEwwkte6PKGEVF6E+E7fImuWGgmjo
         aigHWU9EVIgyDIXay52pWlutJCEjLTboZxVDfK3EqwNvObb6YfeKGgGijfX9n14QTluN
         uuu6W7r1qpSZtjCdJwpjy24Pg4Tt2/sPfHxVgW0zOqNIKxgmc0HQK2lktc17pMPP0nU7
         fkUXrAu1mWThscdtJeDqg12EJBePSUryoCu1TWQlHFdoFt8vkR76RTBb+E1yLp9UuPON
         mnlw==
X-Forwarded-Encrypted: i=1; AJvYcCWIYjhlM6OwtUkRJMCvqjxpc2+fhyqrk+wcndcmf3y+YXRpR555wDjBAB6KPzd6kj4N6EbR6457Pw4eNDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqdu/pDQ+FBi9ko8tziUPFNmc9j/dImgsyeQyAj1eE7NEf34CM
	/vZ1dee121M3XEdQ5bwJKfw5x5fR0R+q5NqDG6r8Few1cuzqFBIFpgyhrTThb0sIFFHsqI8MYr9
	Obgm2zSbcD1FJkIbxrIolLuz6eBYbGKk+qhwTgKnHTaFZd/SbSpQXLCLQQ3tcjSJPFTA=
X-Gm-Gg: ASbGnctUYs99ZzCKLwNUJWQOFpZ6Y8N5xoR9uL11NIuaKKoFjm+cvI9BnqeN+30wAwf
	/tTX+QKPU8zI5z3hYTUraA+osSNzQONOtk82Tf8WgYmPpXbqYe8+9NJKhMB4BdNlncH6H/2lb+X
	RrgSaVK4ZNedpCh9JHFE7bLNG+fe4GnaRUL2v1Jo4zVZ4DjEvwKe9PVOG5IkB1MKIg6sMKpsW0K
	ZigafrKb3modlBY8jNXuKcIPR2mVEKQZj8pKXcHNkwLNaIez9JdwhW+S8sAVD3edDzFGAQp6TW7
	KfZmX7PtwnLHTzXgG+2UgNkWQaYzY6Zy8WSNH3LVwn/pHOHj+s0nHjE4iA2OgmkZ7ClDqk/5uB4
	n9unYyOd3uTsewJnqRyE=
X-Received: by 2002:a17:903:1a0f:b0:23f:c005:eab0 with SMTP id d9443c01a7336-242c22085e0mr247517365ad.40.1754987875211;
        Tue, 12 Aug 2025 01:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSyTwItp4AzURKgkqbIXylqMcchbdJF5mW3fYQFHbXyc1v7LKgkg38a0UoXB11ZfsFFDrQmQ==
X-Received: by 2002:a17:903:1a0f:b0:23f:c005:eab0 with SMTP id d9443c01a7336-242c22085e0mr247517015ad.40.1754987874696;
        Tue, 12 Aug 2025 01:37:54 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:37:54 -0700 (PDT)
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
Subject: [PATCH v5 3/9] coresight: tmc: add etr_buf_list to store allocated etr_buf
Date: Tue, 12 Aug 2025 16:37:25 +0800
Message-Id: <20250812083731.549-4-jie.gan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXzvqTp7lagft2
 R8VZRcUtLUInSmP2qg9e2NN/ytJdcyUE42D6MN5KHkvUnmyTUekTEiam3Muz9GTbcD2CqzSM1Hn
 3F77z0zp+qyL249Ufgv97zX0BpG3Uy2Zu9LxBWPAIssHxEdy2F7Nvh6pNkVFFRFW5nrqX9QbRdf
 1GxAMtaqEo/TJNBsjr18+fft9Nr1Hnwm44PsupEvqueB8IYR8GsN+h8OoCUKti/1c/yCYLAcVSk
 T5lrW7WKHUFTYuQXSse0vMXC/XGkHu6p0iAYwwam8ILxgbB8Lf7LEakQ1oSMMBCQUTyAOYJpdiW
 GvdsskhnGhemLoZv8fclSsoPLfFBB/FUNJhDcGTT8AXG108yvmhv8oehJ+F7MqgQqd/HWLj0LMB
 uSECrVMS
X-Proofpoint-GUID: JhOal27o16z5CtJXRzGUafSr6QpKa5ea
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689afd64 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=JdrPKQqGaJHjzi2MttEA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: JhOal27o16z5CtJXRzGUafSr6QpKa5ea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

Add a list to store allocated etr_buf.

The byte-cntr functionality requires two etr_buf to receive trace data.
The active etr_buf collects the trace data from source device, while the
byte-cntr reading function accesses the deactivated etr_buf after is
has been filled and synced, transferring data to the userspace.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c    |  1 +
 drivers/hwtracing/coresight/coresight-tmc.h     | 17 +++++++++++++++++
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


