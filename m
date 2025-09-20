Return-Path: <linux-kernel+bounces-825860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A2B8CF8E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907111B20C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B172247291;
	Sat, 20 Sep 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CrZQRQWb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A21257834
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397334; cv=none; b=RpIyk2ut3cKCetm5vnJ6HkHhH/X53b3AX8Th2VHUpZ4OywcCqgMsHCW2UOOSeziaB3jZFekRGt/i6ID99JjsWPuEGwq6wnLJb80HsPSTccKtbONkc54Mz7qpAQtuBlD7Qc/e+ZVJ8RMfNGmHKuByyR4uQ0pKtPK30Eff/rYL/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397334; c=relaxed/simple;
	bh=DCAkrbeg7VSOARVBAGpw8sAUXiiiJgS/ed13HN0++XM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b55pSgpNMcJmX4YLox/pgYbdhzpg3Ooo9O0KhKY29dJyG9svAVp+ujpsYPXiavRJZdeb9akZTsoYxwItboeut1R22jw9Tv09mgPUyxqZlqHHuHxCadZJxeT0QNctFqIlt1iLhpyhAQCGAwQ5yw18jTtWJH0AdiTBE6brYsjMdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CrZQRQWb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K4laPM014982
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pj/BgSYMd+ehlZUcqfWm3Wt8Oa5dIWUJg+URzA82Bvg=; b=CrZQRQWbXR2sQRlC
	csTrAc+Tzb6WSJ3rjHVRv7uyrD+36/b+H+btmfjeISwA17IgiOZW08+FdmT7uShc
	6GtGEg/UWjY9wzg1eVFiczQLA/8fTBgwSkoVz3fywdekKxfyYy1pP0r5uciSjD9L
	D1+Amgvq16FmaSkssngU93CUI/E0ObW+dObh0qcLlWUNNHOZFA63PKg+8xuHUnUX
	b86CkFCMcddxBleBGiI+R7LJZOBgl3AFHAlMOm8fgj+WZbFZTr0oXIChyn3C0KHv
	IJPK8Q6mEfukgON6MGbfUe/dpnPbrz3NYMqaNaqEoExhK12fCbUR0VjLDobP8TfE
	+TUP4g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8s2h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so2764799a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397331; x=1759002131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj/BgSYMd+ehlZUcqfWm3Wt8Oa5dIWUJg+URzA82Bvg=;
        b=HWyeuZVCcvGirMCP3AERUAjfY05id1uSpzyEEsEGY/rjSfp2LttOUf1D0kxyzssSWd
         X5mWqP2WZF04vUfKMvlsJOTr/af2Dw3lBzPnEd5YtotKi8tw5EZw9bHJk0tsbzSCFRYc
         MWjpv9dViT0f9yEY4HWq7A911a+GQEzqXlmBuxqXbKLN9iipwc+03Nr11x2AKTjXuG85
         h4OZXccNH1ATilxgoHcg7f9E8WjE952uhfbyAdjhZOesYQ35EhDcLgz1B6+aLNo1GrZQ
         DSUS5l7ys8F5AmZvIZ+bDYDMW/rB2lEiwgsNXaCJPncCv96qAUOyq52z1hatWQXF8VsH
         P99g==
X-Forwarded-Encrypted: i=1; AJvYcCUva7mzZ3UO+agTYY2EUI/p665UqduIAckyaWUM8XclrtrxU8lMSYaihkbWfIe56NCWbrFOp5BqVt8bLHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEcBQFOsZpvgd7/bMO1YHmVzqDQ6+hkJ6gldTc03izlSmKauO
	O9PFZsOhuZSE3DkdlUHn3eHbUXW1IAFi+aLa8Zi4jzxblLZ5pxp2why8Krr8BiwgoiNZLppjnRm
	FtFtk30KqYRxVy5PoU3jtOakPSd6KikhwekLlRz3AnnO3FiurE999Qdj3vvuDjl+cPrk=
X-Gm-Gg: ASbGnctQE2rqIhCt6PP+VekS2EDaH1piKS/2rAeOvAGe8duFsHkneV7yQjPOGsww1Gh
	/tYw+U5Z2J+tMa2zQ88hdtyO0ZMbN6LU2wQ8dEsEP1c/LfCQbaMyJr6Lwn3KZJWo//k1SjpAjsI
	/4Ib/FBxcxtRPxn28lmuad718YqV2uv3MYA784Ghb/Xb3/nGsstRcfM0XoqjbdHI4o1uSAx3mBN
	8pCXSpaGTtDmnkX1GkmwsJ51Yp1lcUTmVeYu9YdwWAPsAugl8gx9is8ah9sh0H2q3svkJrRNHvw
	3GzU1+evt0LBpjKQN9LY1wXqm63uRa/MRg+y2zjKEaAI+t3FhPBsL0VHWqd1JR4tItA=
X-Received: by 2002:a17:90b:3b4b:b0:32e:ef4:bc7c with SMTP id 98e67ed59e1d1-330983417ecmr9161428a91.24.1758397331306;
        Sat, 20 Sep 2025 12:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsXPhiZq+EnDOg32hHLi7TdPyUKuwR5jLj1GKkzUdXiT9NbgRKwTNf6HFkUYmTR+lRrHf8JA==
X-Received: by 2002:a17:90b:3b4b:b0:32e:ef4:bc7c with SMTP id 98e67ed59e1d1-330983417ecmr9161407a91.24.1758397330886;
        Sat, 20 Sep 2025 12:42:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm143767b3a.34.2025.09.20.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:42:10 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 01:11:05 +0530
Subject: [PATCH v3 07/12] firmware: qcom_scm: Simplify
 qcom_scm_pas_init_image()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-kvm_rproc_pas-v3-7-458f09647920@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758397299; l=2836;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=DCAkrbeg7VSOARVBAGpw8sAUXiiiJgS/ed13HN0++XM=;
 b=wTfDa8mkr3aCDv3ZpWTIWkrvMPhc4CtFWvMjvpe8YLkmi0MJc4R0WKbF0utzZjAspuKJ+brAX
 3HLYGJKKA/YCUzB2wjTKsWmAeD3dl9qnSlnl0O8VzRgPEizaKs2Sg6u
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68cf0394 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=2f531HYpvKpQLZPe_fYA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KZxmbtt1-0o-tWNKqjmJ8h8GiGyp8430
X-Proofpoint-GUID: KZxmbtt1-0o-tWNKqjmJ8h8GiGyp8430
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfX5hbr2gLeBaLv
 dLZkAjYJW9ir7jgVNrvEwOO7WMTXFiMZXcYTlXTLHfclZknQDhN+1o+2VzfznLQv+IgxRhIYGK0
 6Yq9qXOvqoroDLQmkyMjactlCsKmRU6PQLa66feH++aAtRFKJitdsBwL/hEAWXF7EI74r3knR7E
 FCy2qbWOPnqNvCg0sJ5xOegU2GH7NFQNayBh2uzUYgfQtIzlisyykQqHi68y1Sb3NJiq+ddeOxM
 kAW9jcVWJUdw9iF3jgAnDO7DkRXgJUe4m2cXl2lHFwcMjCheNTLI2IIZCBklIlU9/ER4Cu2YyNc
 0omHFymIiKfYnQVYX1iiqumZYI4ftSOPTmJXjegx0IZgr/Ni/2v4dhrb+srdKVMeYhIr76yBuV4
 7k/nJszm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043

Simplify qcom_scm_pas_init_image() by making the memory
allocation, copy and free work in a separate function
than the actual SMC call.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 58 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 7a86b27ea666..022529778f84 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -611,6 +611,37 @@ void qcom_scm_pas_ctx_destroy(struct qcom_scm_pas_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_destroy);
 
+static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *metadata,
+				     size_t size, struct qcom_scm_res *res)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
+		.args[0] = pas_id,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	int ret;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		goto disable_clk;
+
+	desc.args[1] = mdata_phys;
+
+	ret = qcom_scm_call(__scm->dev, &desc, res);
+	qcom_scm_bw_disable();
+
+disable_clk:
+	qcom_scm_clk_disable();
+
+	return ret;
+}
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
@@ -632,17 +663,10 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_ctx *ctx)
 {
 	struct qcom_scm_pas_metadata *mdt_ctx;
+	struct qcom_scm_res res;
 	dma_addr_t mdata_phys;
 	void *mdata_buf;
 	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
-		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
-		.args[0] = pas_id,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
 
 	/*
 	 * During the scm call memory protection will be enabled for the meta
@@ -663,23 +687,7 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 
 	memcpy(mdata_buf, metadata, size);
 
-	ret = qcom_scm_clk_enable();
-	if (ret)
-		goto out;
-
-	ret = qcom_scm_bw_enable();
-	if (ret)
-		goto disable_clk;
-
-	desc.args[1] = mdata_phys;
-
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
-	qcom_scm_bw_disable();
-
-disable_clk:
-	qcom_scm_clk_disable();
-
-out:
+	ret = __qcom_scm_pas_init_image(pas_id, mdata_phys, mdata_buf, size, &res);
 	if (ret < 0 || !ctx) {
 		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
 	} else if (ctx && ctx->metadata) {

-- 
2.50.1


