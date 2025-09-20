Return-Path: <linux-kernel+bounces-825861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C2B8CF9D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E3E1B20D32
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821EC248F66;
	Sat, 20 Sep 2025 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1n6KilZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFC259CA3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397339; cv=none; b=jsCu1brxYqdZhApx+9v4rkgZT3rSWrGFoYQlJ7B8IaSg1mXoCoHATn+80rRuktTR1GRB52re/MlgmhLCH9nDpDBrL3PtiEKTvrFUJl20/0Le/tWoEBp+DHBAzwNvKn4Zm5d+hmcGoFJykWf25/V83sbBW6bOAw1EZi4rwmt/Cf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397339; c=relaxed/simple;
	bh=mBK4xWLjc9TvI3NeWK+E9cswJ+S05RkyGn/yLnOBu0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKiKwEdI6ypjdshLh/I8qRRL/mZB9bInluaC+Sqj27MgaHexGy+v7+ywHTWNbEkOfMsTDMR7dr2Zb14f0sjBZvwS0hUOU6+ZxI662+8mwGiRR7GR14XYR3UUTjsPF5j09Y1kD4xdjifUcf8wf56hdABslm+wgOfU2MY+HS/3kxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K1n6KilZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KEdJXf011572
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	krWOjnzkrbH0g6vYLA5+TbCnPOx5zLg6rDU2gNyS5OE=; b=K1n6KilZMmzWEgTT
	NwAoCJ3phSjsYv744K4nTRkvuxf4IaWMRYjEqKibkzmD3GYI61NaPDvppqjU+HEX
	nmOr3dL5QCRfQ773iKQZNwtXisS5qweBSeiDK9T41FOzc2+NIKzPC6/Cu/gVqb4J
	PKupKrGSoeWOxgEdtu7wjPjU8qSUbVAc3HYhGlb3daw/tUMrn31IByxnC0FZsSce
	z9E/3mjyj7+riHpHwwo2EjlJkriq5Hc+In6VuogMJQ636LVtPTLxaRw6bhPM4uEM
	svG4hVpskv1ldw3sAPK9tCN4vzq0AI+e033ZU+gXg4ToIXOxbSNFKp/zh4FJe8yF
	SXNySw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0s89g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77ecac44d33so1315311b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397335; x=1759002135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krWOjnzkrbH0g6vYLA5+TbCnPOx5zLg6rDU2gNyS5OE=;
        b=PcPj1Yirad25XDn/G1jOg8vRici2OHfV4TebuioHQ/Ao4Ms60B0RbvMd50EYaUjZux
         005IfI4j/6/Pfi4T0g8t1ri+FPWGyUPj1WDNw/2HrXs6UsAhWKHP1YPqnh6wqG+foVqm
         mkwX1pkdQuM2Q+Qc+Vthfx3frxBDOfePVy1tvA4FUsLxswaIY8zQNiSHGJxXSZmWIMeW
         5LQFUy2Q/it1Lmb54tCsECKcR/3Ha0j3nObqEsgnv4AB/0OgQozwmjlD5OQzwbwA9qzm
         okEuSBospX/7Qv+xCUhybqLB60WZXMsErwk9zZf4nbqsApZLAZKteTHjVojqmrCTZf2d
         ci0g==
X-Forwarded-Encrypted: i=1; AJvYcCUWJoumLEvuEzK8yH7Axz9D6EbbSufVzDhKs4rAlapR0OfaTLWEBDxYobk3BnR9q6i6h06J+rfYwbcBZ1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlqgVTsQiQ3TO7MlgdXpbJKmHUdcP7gexBcEjn4CrZSfZu2va
	9QRCYBbYnAAOhUAb1ufxIPJED/NLTPOJT8vlS9+rOXBOWsMaN+0pcAaFWPipTnh13Q9RzmuzOz+
	XxMhPbWwDpNQkakrrSSdArFckrOfpqFUshlbF42vdd4pKCgqLFl9gsnpCDD+TCUyXmVA=
X-Gm-Gg: ASbGnctQCN5Cnycx2aLRbTGIfBrp0FXw/iXZWG3vSdSDbsQAxAQNU1P8xYcqLFOnLXu
	QzerMxkG9OUNsLZwgY/QpLyCU0MV1H5xNLqWfX22Jt4+WPsMZtnlWr/giaSxmlH5XEKNHHls4ni
	vF1z2gkFSUR0em0/mieVFPZZuVioOPIj2DxLX5eY62b5rdRUBDJ0NwA0YJKD2BfyGga40Ibg066
	dfZm/UxUih/zSp1dgjAO9G3OJtCIan/MZmtG3UwN8NO8b8c95Um58aTwCXTdWLAdG3ezDaWYXo5
	A0B+gZ/vFa8/XS5PL3dlCTE+w6Zb2lXKxRlH6oY9X8OG5+qV+YuP2VbT++CRFHvQy6M=
X-Received: by 2002:a05:6a00:1887:b0:77f:1a7e:7bc0 with SMTP id d2e1a72fcca58-77f1a7e85b8mr3754464b3a.31.1758397335133;
        Sat, 20 Sep 2025 12:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV35Jn9czRic6iek7gBq+/mlLZBS+H4J2dQxank8bmcsZ9RqYi8lJrTvOkhjVCMIyNxrsldg==
X-Received: by 2002:a05:6a00:1887:b0:77f:1a7e:7bc0 with SMTP id d2e1a72fcca58-77f1a7e85b8mr3754440b3a.31.1758397334649;
        Sat, 20 Sep 2025 12:42:14 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm143767b3a.34.2025.09.20.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:42:14 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 01:11:06 +0530
Subject: [PATCH v3 08/12] firmware: qcom_scm: Add shmbridge support to
 pas_init/release function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-kvm_rproc_pas-v3-8-458f09647920@oss.qualcomm.com>
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
In-Reply-To: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758397299; l=4327;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=mBK4xWLjc9TvI3NeWK+E9cswJ+S05RkyGn/yLnOBu0k=;
 b=z06YF6QW6ueOYS8siinVNpmEvicINaR6G79VHDCfpn2owna8zBLYNRBMIE21hyFult04e4oit
 p+BH6vHPaBiAjNIgbzwS5c8rBWh5+cfg4BVR/e26XZQu1rhsS+DaaLj
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: kSs8SkECOVSqjXVFYca0GuuLe2Rkto-r
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68cf0398 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=PUsy4RtU_kHwXTlAi2MA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX1yHhVNIAWBc2
 sbXQErlMekeQA1qEcZv9IlwHN3uEwozXKdUbxzz6pbo/DeYLoyj3L0HKpltbrNaPaSmh6KYhwVd
 oAl6lZeDJPZvqi6zNRBGY/7p6Mnp6ghAMcnlljKarX6OtuV0t9vx59TNV9JCMk0SdQn1zGLYmYj
 w+L6xLFOAMV38ro9V+r8Fdzx0/hgb2myCiKMzCr6dq11pZR8dSJsiCb/cwuVGNiE8SPRghPX7cm
 j+BwgRUh/TsWwWNFhyJY/l1NatpJou/xQG7Uk39VOV4w4vo3Eh6lv3wevE4EpOOOCehmSbbFYeB
 6XmDoIPq2RdGUjBroqDT0KEcfeZBiNFbcI+oKBzB4cCSkUNQgNu5KrK5hjm3yPyQKBumQxAcYKm
 qd3YCYMs
X-Proofpoint-ORIG-GUID: kSs8SkECOVSqjXVFYca0GuuLe2Rkto-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

For memory passed to Qualcomm TrustZone, it must either be part of a
pool registered with TZ or be directly registered via SHMbridge SMC
calls. When QHEE is present, PAS SMC calls from Linux running at EL1 are
trapped by QHEE (running at EL2), which then creates or retrieves memory
from the SHM bridge for both metadata and remoteproc carveout memory
before passing them to TZ. However, when the SoC runs with a
non-QHEE-based hypervisor, Linux must create the SHM bridge for both
metadata (before it is passed to TZ in qcom_scm_pas_init_image()) and
for remoteproc memory (before the call is made to TZ in
qcom_scm_pas_auth_and_reset()).

When QHEE is present, it takes care of programming firmware stream
and mapping resources for a remote processor which Linux need to take
care on its absence. Remote processor driver should appropriately set
ctx->has_iommu to let PAS SMC function to know and creating shmbridge
for the call to work

Lets put this awareness into qcom_scm_pas_init_image() and
qcom_scm_pas_metadata_release().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 46 +++++++++++++++++++++++++++++++---
 include/linux/firmware/qcom/qcom_scm.h |  5 +++-
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 022529778f84..6376a58a059c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -642,6 +642,35 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *me
 	return ret;
 }
 
+static int qcom_scm_pas_prep_and_init_image(struct qcom_scm_pas_ctx *ctx,
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
@@ -668,6 +697,11 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	void *mdata_buf;
 	int ret;
 
+	if (ctx && ctx->has_iommu) {
+		ret = qcom_scm_pas_prep_and_init_image(ctx, metadata, size);
+		return ret;
+	}
+
 	/*
 	 * During the scm call memory protection will be enabled for the meta
 	 * data blob, so make sure it's physically contiguous, 4K aligned and
@@ -693,7 +727,7 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	} else if (ctx && ctx->metadata) {
 		mdt_ctx = ctx->metadata;
 		mdt_ctx->ptr = mdata_buf;
-		mdt_ctx->phys = mdata_phys;
+		mdt_ctx->addr.dma_addr = mdata_phys;
 		mdt_ctx->size = size;
 	}
 
@@ -713,9 +747,15 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_ctx *ctx)
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
index 1774584ff5e3..2fd42493d07c 100644
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


