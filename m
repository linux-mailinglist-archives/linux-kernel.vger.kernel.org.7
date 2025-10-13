Return-Path: <linux-kernel+bounces-850305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF8BD274C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABBC189BEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CF2FFDD6;
	Mon, 13 Oct 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EzFmC7Jk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151762FF15A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349862; cv=none; b=Jv2udTY7UujT4uLl0m5KHq4XvfN3YpWHoWAKvWj6hjctD6mDuELTTHvzbvEK6j7D17xoTEEmL/GDdOsAfoJxac1n4KHYYTxoCBMMiEzPUZjTNrTT2n3Yw1UEasoF/XtL4W4b+vp/T8zqQKjUJk9kixgOK/izFcDmDORuCwm3b58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349862; c=relaxed/simple;
	bh=YDMPLpDHZzxufhKY3pUfh7AmMazlGytDUcCpJKo4orc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKjJUjZyGY7lY6JpZRifzbwuDacdzDE8pc5SeAaTxOuWQE6lP/mdAbdhd5a3d898FYnQkJpVDv14c3tmEA7fyS0AUhsC3OiHLsRNWfC1haZMdSDvEYg58Ah26N/nzW8t2o8vJlNzlE6zf+YGuxnhO6aBNITjj3QC9ha9ULXyU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EzFmC7Jk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nYS1029679
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w4HFDfAUy/D7959GditzeNh9D7CWq+9RRUqsoHUE3ks=; b=EzFmC7Jk1vQuv9At
	XRxmDy4EyEqpMmUdNQuZneJwQ1J2B3rJYray/yZeOAWH9sSbNTeBX/8zig28CoRD
	DB1LR+o5wSoHhbzoW7A6lT7NZn8KR+VwJlaOEqO1ucUHz7tVy5as6ZaVWlanJoU3
	/6QI2aUYF9gvv1fCzvhC6jTtmcw8oV8ErkpGHRHlF8H1qYlnccomOlv/0c32ZLwM
	zV7vo8V816TtUdhdiXZbI+UOe65Gn+Htyk7wYX6nTNWguIsnRyH6WYOxphjDJx4Y
	cF+1rbFRp6XVj5t9OW6lWmTbPmZNwbgV4Rvjls/rwOOQJL2Z6W1abV9YVZri8O0h
	I2xkEA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5c5tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78105c10afdso6958092b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349858; x=1760954658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4HFDfAUy/D7959GditzeNh9D7CWq+9RRUqsoHUE3ks=;
        b=VOcLhh8VeKDSGOBkOCdp030ZN2Bo7z/SqR9+1QHifNTTDVfuYoNvOcnLD1wBNvGmAq
         0x1ZzRcWxxN9TX22oKJ7hSezVc8r+jZK+c3lkj0xo0+Khkd7ek12ed+c5ybKwWRHPPqS
         hCaAUzdCRjNP49N7PTtFbcx6RG7B+VJy1dPEUg0ZpM4Dne6QdgRpz6WOruzQjwmMnk4O
         yJWN9RoUTff3G/e2pQt6482aH6j9giVtBjJsiy+gmYyzHZdViYKQo60CunF8jXlVHg2z
         Yuk5bL92F8Wn8RH7KG0pmHLpfb+khf9omkWJpNYf2Z8M2HnAdyIo4gouqsexwR6S3CUe
         FY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLPecHEdIXxveIyPXmgojSxhNEye8BhdhYzKK6HzB7CRa32r48AaY8Qy7+W9a/oip290yKS7IpxF25TaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbdhiyBDWp1nAKSMBdWhaE89KVaDjpsHErJ+rgpZibKpfxUh1
	jMo1jOvSaw/xNIWp6Zk0Mv9Dl1i59CUAoCRZ6iVN4vRxieCcJf8W4IQ4vwE4xHU1SDubW8IW9yw
	+DJHzjImfZLZeU4gJDbxiFw58JPeOnF1bcgMXYPumu0kbJ7PevhUV7cvNHlmVpMdzMJc=
X-Gm-Gg: ASbGncuIvV4TscviuPMYEZ3FXukD0w0GGLkEQwwLbskUEBtPWqN+QW0SaHmUcOuT1wW
	9iZw6tBQblomcPAHD/iUBH1YSsXu2KV7DbYtkNZkegHPQUt9G8QyM00qfUB/u/tP3qz305aNg+3
	XVatLgaw9wIvX4b2SwY79du1XxVuXx7ttbPJ2BaBuuPdq2wSpoh57HHWbT7/L1UyEZ+ZgTbXx7B
	au1VjiHAlJI58JhZFmqanfssJI+qAioV59MebCU3Ve2TOv9cf1HBZ03k2uzZufG0kRMptBVPq0d
	Q8CKS8Nao8JDH/RDlYYnlVGJlAfa6rQpCiJ9sJ7EOx9cUID+lIWFkJ0d6mRIjarxhbs=
X-Received: by 2002:a05:6a00:4f88:b0:781:1b91:8e34 with SMTP id d2e1a72fcca58-7938772d557mr26761137b3a.28.1760349858126;
        Mon, 13 Oct 2025 03:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX7SuPfaWBoBU1c61TDEE7y27KtJet+JBArrhJO0Y4AjsUqNpZKgNRIqFb8ueVqfS34JpgEw==
X-Received: by 2002:a05:6a00:4f88:b0:781:1b91:8e34 with SMTP id d2e1a72fcca58-7938772d557mr26761083b3a.28.1760349857606;
        Mon, 13 Oct 2025 03:04:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:17 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:13 +0530
Subject: [PATCH v5 09/13] firmware: qcom_scm: Add SHM bridge handling for
 PAS when running without QHEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-9-d609ed766061@oss.qualcomm.com>
References: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
In-Reply-To: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=3703;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=YDMPLpDHZzxufhKY3pUfh7AmMazlGytDUcCpJKo4orc=;
 b=aVCuv8HAN0gr7ZbEhd8LnvFa8JOylRRseCLxS6oLGwXqCZtbX9K/hXTP66B0nOyINvm8CUJgp
 /xDEu1o/NeyC1ursXhuyK5/uvbeX33M2i5A20NenEYUimaT+4/FM0zX
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: KbfaStrAup_kFDqRZ9v4SxkQPASRDY1R
X-Proofpoint-ORIG-GUID: KbfaStrAup_kFDqRZ9v4SxkQPASRDY1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfXy12YX4WdOacX
 xAKNN08sWY2vVpPrVN72VNa+b2VUdnXHd4QxvvCeaDcdtSZYKvZ0pmrqItEmtB4yUw8VfhsFe5F
 n2f2JYvWKVPUbSp69N3TH54lpNyWu186AeWnGspIXbN/ER6YJjqIiMhg+wVK3K7jkFNgSrHtm6t
 2TgtXBPO+DLz9JIWl58Ab4KvX/4TG0L6v6pjHfFYn27qD2M/fdchcLKPTUXJVaPQr92XhdQZKk8
 JvZ+G8285eQQZOzcGo9/IzVOcp6GMJem+dWw71BihgI+Wtqj76Z44yv7r9I/EBi/Y6Ua7jgEEEg
 hcQqDDIKS1Tf4FHT4OGKeORukAB5gRP/MAuXl+V+Bj1qjU8Y20eCA7sPqQ7Bj+UKvzbJ1IWQuiH
 O4EtD5G62U9aBBUTWupkROZpPv5W5g==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68eccea4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=foeKZLzp1bqqI__vITkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

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
index eb79fceda92b..c545f7114237 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -622,6 +622,35 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *me
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
@@ -648,6 +677,9 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	void *mdata_buf;
 	int ret;
 
+	if (ctx && ctx->has_iommu)
+		return qcom_scm_pas_prep_and_init_image(ctx, metadata, size);
+
 	/*
 	 * During the scm call memory protection will be enabled for the meta
 	 * data blob, so make sure it's physically contiguous, 4K aligned and
@@ -673,7 +705,7 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	} else if (ctx && ctx->metadata) {
 		mdt_ctx = ctx->metadata;
 		mdt_ctx->ptr = mdata_buf;
-		mdt_ctx->phys = mdata_phys;
+		mdt_ctx->addr.dma_addr = mdata_phys;
 		mdt_ctx->size = size;
 	}
 
@@ -693,9 +725,15 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
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
index e1de3cf73451..583490bcd38b 100644
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


