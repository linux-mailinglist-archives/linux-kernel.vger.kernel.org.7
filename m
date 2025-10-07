Return-Path: <linux-kernel+bounces-844543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F10BC22DC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 411C54F7971
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A00D2EA473;
	Tue,  7 Oct 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CqyvaS5I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32592EA46F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855789; cv=none; b=KRKv12yl0ITmJECrE1KjBhiIfk0fpIYkcY9tyNR27zBlWfD+vvKi/pMIbSwjim1BiolbO5KThDcThMoUa4atAGk6/42kX5VSf2h+8YWnTr0OxUc/Z/MZoINjKyrIMCLN0VzDEnmupLB0BAs+gGL2UvnnA7w3lv1K4zkekGKu0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855789; c=relaxed/simple;
	bh=oWTaYDIHWxGCuXUjmnVaLEeHiedaBpOucW5kwkMTyCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyrYLfpDskQ5R+tXbng/h/zejZC1i5/HGNe7YKJbRAPPX+c3ewKtEdXCC0r9gIAKSgYmd1t+kcCZFd7R1YcH/KMTIl6XyIL8NcSFGySyFhrSU5DA2CikUyFGqdfYYXmhbgxD+naFFHsNO6+1ovPZ6+48fziA2yBUJzXjMaMEZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CqyvaS5I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ET605026205
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 16:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aUu8WD7nX9eVSZCgmTq1YC/wSP3aZ4PdQ0Bix6GmPyA=; b=CqyvaS5IgONkJHBp
	3l1eKRpOmym+YRhToqJaSRIaiHES7SMkxxavqwqi3i/sfgZEykSyL7agnRGAkdRN
	hVP6/qzYyPg/bZk6uqJaSkP3Vy+c2g9OvVhHmqXBH+XYBZkbD17OqzGN2/xS6hSb
	bJeMEqFIs/VwpTB6XJRKgDpOdi5Q/xY07GQkOjXUwbm8QYN3tqse1uFT0QufJT5M
	2TAdHfRTkS4jQq+Tgv2BQJR7A9H89cC9ipDXh9q/UvERh3Wddb7/QkXbezhgV+Ee
	G610oiAaW0s7ZbMacWoQCJcBF3AgsGfOvr6InfQFw9jkEXlrCdRpJGRtkbSP7m51
	HGULzA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy6yx1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:49:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27356178876so42442445ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855785; x=1760460585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUu8WD7nX9eVSZCgmTq1YC/wSP3aZ4PdQ0Bix6GmPyA=;
        b=ht89uz2BToLUK9HPgCd4a9jjDoYxpgdaB3hKzFHJaQTUOhSSC7WOiCLqlYLAMWSTqe
         +nzQRmsZkOvCkL1H1EAOXsHnuRi14VDkk1ai5KyFCpW7PgkqUOaq+iEkprDblWviUGfC
         43UHru7WwcyIy5M/eQLfM07/RvOxIuBbB6fFtDcRlY36Lxso8JbFyFchjjBAYlyWIIqQ
         d5KFYyN+RWWyfu9cTm2nS0RaWOeHMbXtLaxTisS0TNR7Sji53UZVRqzvF+BP4HH0Apb3
         1nw0mw3IivziSXocRb5qTViM6wY3yfNb7+TTKyGlF2BfVWGqYBxJR4T5Rny5uX+HaCPt
         c/lw==
X-Forwarded-Encrypted: i=1; AJvYcCW33Uay2ON9iS0SxKMnT18n1M8FTlsjoXXkcJRtbwgfFwjSQ9x3CkqjllCHGANnCf6Qc9vntBVdgDqgVCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzAIR9l9eXKZVmLC+Yd7PkF4mq9XlY9qzkUT1U79cDLkq20xd
	ZaEkKuNL7XnbS8UUf5cAFFRIss6yZoBgRpNgxbCZpptzVn0jzqddnx5/bHTWOYU5z753I998NPN
	Jo5/kokGw2txad+iuE5lhc5gb2Lv2Nz1PkjvFWK7v128MUiKPWWVHkbM3AgmCRfnbpw0=
X-Gm-Gg: ASbGncvbwy9B+EQkCMesoY7SNoQx9AJAmKsFAkWd3eRFTuYcyQ84jrVJu0ZbDJ1NfnY
	kMWgHDtIqpc9ltqmbplEPrAObLGy2j/Lpj1qTECdRhdDjtxLBoDUMghKBLsCMzNp7pJsTWz8Z6T
	Wu3bfWBaCHOkglK6Eu4JMX2tmLDcn7tdOONuMwuT6YFUjhRL0iYNx023gzBSRhCnkuHCUyNFxgY
	XyxwxnO7vEU9sFEp91irnYo5HHO6AMvanzglUI06gwRj0SyqnL4JXhnKOYk9SFB94maLZX5bt0B
	IjBu7SYjrofKSx3iNE3A6E/PPZFkA/7cvR1U0xu9ZffcPaTOXfKeEL3w5CxsyHO0JVCF6nM8
X-Received: by 2002:a17:903:fa6:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-29027356614mr5087415ad.12.1759855785149;
        Tue, 07 Oct 2025 09:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Ybw6YVfYOiF7s+0txo+89nrsnawRu9WwH/ew3lNckv8aZ72hikTmzhHBXHd65gi8Et7gOw==
X-Received: by 2002:a17:903:fa6:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-29027356614mr5086995ad.12.1759855784572;
        Tue, 07 Oct 2025 09:49:44 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261e2sm171990825ad.38.2025.10.07.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:49:44 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 07 Oct 2025 22:18:53 +0530
Subject: [PATCH v4 08/12] firmware: qcom_scm: Add SHM bridge handling for
 PAS when running without QHEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-kvm_rprocv4_next-20251007-v4-8-de841623af3c@oss.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
In-Reply-To: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759855751; l=3703;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=oWTaYDIHWxGCuXUjmnVaLEeHiedaBpOucW5kwkMTyCw=;
 b=nOUmGRDSIg/vR9mIJSpZ4kZ6unVX4GkzMpWq93BUsBl7mCtWgBmbnjUwMFEWkJQCGWJ5MiXFY
 UW6PFwU1PYRDFsDptXHZH4fI8oAkCQSilXJjpWQ2hmwGQafrOStxf2e
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e544aa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=foeKZLzp1bqqI__vITkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: OwYMfmuMuzBwMJbT9zdchCdbK8M1pZ8l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX03k/BU/wRzKz
 1/tSyEgPR0F1Y2Q1Fi/R13wmu+dsq/0TewGYXtY/BUcO4vTldkTCYSVAqSQS3O245/8VQYyqifM
 kh/dxV0xniz3XKI/u+f22vItP133Izlo48ES+SmVEwBCiGHU0trWbTd31UdBLIRr+nYdhGI8xSQ
 Fpkz1wwJv2j3Z8RXHiA1bxHG4ybs3sxUSoilZAQ3lWOJLfO8VrDYX0qB3wjvhAXmVW648HvnvB3
 6Xx7cZVEEnGVleKS/GeSlI8gkxdcU7oCBHspXBu/GWc3gfxtC8R/hgR1UmGvqbbP7djFNlY8+0i
 GGOfNKSLiqSKI/ojPRdb+YNpHKxFAizdrNqm6VzBfbu21oJZril2ojRsO0Lv/sdKsDPdQDOgV5R
 9WIpWm8OlirdNijyQH8sulTkJ/hmdA==
X-Proofpoint-ORIG-GUID: OwYMfmuMuzBwMJbT9zdchCdbK8M1pZ8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On SoCs running with a non-Gunyah-based hypervisor, Linux must take
responsibility for creating the SHM bridge both for metadata (before
calling qcom_scm_pas_init_image()) and for remoteproc memory (before
calling qcom_scm_pas_auth_and_reset()). We have taken care the things
required for qcom_scm_pas_auth_and_reset().

Lets put these awareness of above conditions into
qcom_scm_pas_init_image() and qcom_scm_pas_metadata_release().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 44 +++++++++++++++++++++++++++++++---
 include/linux/firmware/qcom/qcom_scm.h |  5 +++-
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index b8626897c8a7..75811ba64c8f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -643,6 +643,35 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *me
 	return ret;
 }
 
+static int qcom_scm_pas_prep_and_init_image(struct qcom_scm_pas_context *ctx,
+					    const void *metadata, size_t size)
+{
+	struct qcom_scm_pas_metadata *mdt_ctx;
+	struct qcom_scm_res res;
+	phys_addr_t mdata_phys;
+	void *mdata_buf;
+	int ret;
+
+	mdt_ctx = ctx->metadata;
+	mdata_buf = qcom_tzmem_alloc(__scm->mempool, size, GFP_KERNEL);
+	if (!mdata_buf)
+		return -ENOMEM;
+
+	memcpy(mdata_buf, metadata, size);
+	mdata_phys = qcom_tzmem_to_phys(mdata_buf);
+
+	ret = __qcom_scm_pas_init_image(ctx->pas_id, mdata_phys, mdata_buf, size, &res);
+	if (ret < 0 || !mdt_ctx) {
+		qcom_tzmem_free(mdata_buf);
+	} else if (mdt_ctx) {
+		mdt_ctx->ptr = mdata_buf;
+		mdt_ctx->addr.phys_addr = mdata_phys;
+		mdt_ctx->size = size;
+	}
+
+	return ret ? : res.result[0];
+}
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
@@ -669,6 +698,9 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	void *mdata_buf;
 	int ret;
 
+	if (ctx && ctx->has_iommu)
+		return qcom_scm_pas_prep_and_init_image(ctx, metadata, size);
+
 	/*
 	 * During the scm call memory protection will be enabled for the meta
 	 * data blob, so make sure it's physically contiguous, 4K aligned and
@@ -694,7 +726,7 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	} else if (ctx && ctx->metadata) {
 		mdt_ctx = ctx->metadata;
 		mdt_ctx->ptr = mdata_buf;
-		mdt_ctx->phys = mdata_phys;
+		mdt_ctx->addr.dma_addr = mdata_phys;
 		mdt_ctx->size = size;
 	}
 
@@ -714,9 +746,15 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
 	if (!mdt_ctx->ptr)
 		return;
 
-	dma_free_coherent(__scm->dev, mdt_ctx->size, mdt_ctx->ptr, mdt_ctx->phys);
+	if (ctx->has_iommu) {
+		qcom_tzmem_free(mdt_ctx->ptr);
+		mdt_ctx->addr.phys_addr = 0;
+	} else {
+		dma_free_coherent(__scm->dev, mdt_ctx->size, mdt_ctx->ptr,
+				  mdt_ctx->addr.dma_addr);
+		mdt_ctx->addr.dma_addr = 0;
+	}
 	mdt_ctx->ptr = NULL;
-	mdt_ctx->phys = 0;
 	mdt_ctx->size = 0;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index d6e7a6c9583d..edb2cccee9af 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -68,7 +68,10 @@ int qcom_scm_set_remote_state(u32 state, u32 id);
 
 struct qcom_scm_pas_metadata {
 	void *ptr;
-	dma_addr_t phys;
+	union {
+		dma_addr_t dma_addr;
+		phys_addr_t phys_addr;
+	} addr;
 	ssize_t size;
 };
 

-- 
2.50.1


