Return-Path: <linux-kernel+bounces-850303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12790BD274F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B73C4F0737
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6A2FE56C;
	Mon, 13 Oct 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTAn6d+a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BB2FFDCA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349855; cv=none; b=ESfFajDr93sqixZdstwZgELFdhisOXUDD9BhDKETSc0Ex0KFOVeqzci8TnhKGqEnIbVpge8MGkfFZaHiuEyFhXPVxO2ttBYWpCFI7LLzpgFHeAF9nl4O/DxSMNrvaxr8xZJcx9cFtS2zMPjAUbkcQENuYdcuyOs0/dq//L5cw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349855; c=relaxed/simple;
	bh=8hZm30CWvb7JLW+d0khgV1UhhQZmzpIiZ5CwI+qm9/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwyGo0U1husYcqx1UL3XmMrrgGfwLloMb5mYqkpknmoCPgqUPIVTDIXCrQhkQMX8YhBy5AfK7THKeu8zDju8dI8rRmOUHKbTHF3Jw/wZi5uFT50QyHoqQMHId8JcBzyn0hw2OBo/ChkoMNdAaTPyUPLpChrWpZJEbupj2PfJzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iTAn6d+a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n7PX024173
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bn92h9RApZSfqikarJGJdkgvCyYOoKZC0dM4YRCgEQI=; b=iTAn6d+a7JxB4Jq8
	a1/LlCuzuVZft7hCDhSYYQ+COLTT3C8u6I4RvHfJCevpLl3F0zW5rnEjJ6E1JIxq
	KRjsMiNQkCqZrDHvAICwbS4UcNDBe8coppD54iibRG3hEWi/T7AePvM1dZK7SApB
	cP9KTS6tBF+9v+mGteTmu81apaY9qM2A0vBRjvQGYw2a2E/5feaIyjjoveIcnN/F
	Iu/9JnJTPRRNH5JO+6dT45C6a3uVJh+fiZcAUjpTk5k4QN9EIkYUmAwVcqHwHO96
	dkAqMWAL3/xeY9Jr+KfcwdS7oEtZwQ19MHcqt383WRNbUfZYJdDvDxfxeqrpFMQe
	TmrPXg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa846g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so7445791a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349851; x=1760954651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn92h9RApZSfqikarJGJdkgvCyYOoKZC0dM4YRCgEQI=;
        b=Bwyu4t3QgU72EFacQ8TJvIhmdd5nNE3tGUsio7bFucXdTBdXNTbze7kAoMnMfAnhQ/
         91qJZLREZMkURmyhYNGXX1KB3INw7Fho61suN15w6smWpm/yVvtvA8hRrijYvA7W9t0c
         qdh5ha5TGtQOJvibOWdgEuOQSAKTxFwZ54pMz8lWXPIzNFM4GCXLenzb7uHaXFZuZveg
         4e2wp1tjwQJtttLrCS3Z+pSLy6XkU83mUI6e+ny8C31QZjF0E6STkMUrxeqEmIE6er1u
         DRfzjXyoWpv3U2lVA6LqL4a4IhmkdWuoPbDLAhd4voqUzNzinse4jX0DosK/iIAGuzY9
         dwlA==
X-Forwarded-Encrypted: i=1; AJvYcCUGIgyKmT/BxNEo47mkISqYHlTb9ZVHyltZY/yvrpbBAk3FwpD3OPtlauvH5mioobL2rp6gtd82M9u4s6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGaX3I+g1p2D0ea+5rNUPMx9+SMcOOoZTT46H4vo3l9R+OB0G/
	138t+6XwIuV7YOia8TnLAGJh60jONU+2njv72Ri8MZe5ihOyA/1lnqw1o+oSk/Un5vmhjrF5ug1
	/ImlNshRcTyQ3iexYaoqxSSvnqsOkPvC67TxIRXUmSpCCPMGeCOQIskvkf+uDdDbvoqE=
X-Gm-Gg: ASbGnctIoWC+eDqXE74345RBx+GHC/IyirrV47QvP3p21cENUoOYUJHkdwGwNzBBq7t
	8xxMnkoKXH+8SkHy4cTGJhcOofyr0zpL7vXKSEwWM69BQ4IautFDKuPnRQ4ragy45ocM2j80gmu
	Xvba8oN7pPyLy5pdmwgT1kZjLAPvuDFnMGiEv9OJitoxygKLeEA2AvyL8uqTrKglnZOMxP9FnmV
	CcCZrTW8Dqhp4tRdCJ2HSKvqCVovG60IfA5Z1s/k5rbAQHvj2CPzaUCYEtpFhOUz8+WqhJOXpiu
	QOYSAz4m4C3OuXKEEqdvaQxRwoj56Td7dfmOodA6kN+sZtl3qTifxTQKdWmP/lidDmY=
X-Received: by 2002:a05:6a20:9146:b0:2dd:5de9:537d with SMTP id adf61e73a8af0-32da7f1d974mr26039421637.0.1760349850566;
        Mon, 13 Oct 2025 03:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkepsAd/sFmmzOQMnmuosORBwE0j45YLn3MYyiStu4O0jdvLq1kf45fEz/ncS3MkAY05DfHQ==
X-Received: by 2002:a05:6a20:9146:b0:2dd:5de9:537d with SMTP id adf61e73a8af0-32da7f1d974mr26039370637.0.1760349849911;
        Mon, 13 Oct 2025 03:04:09 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:09 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:11 +0530
Subject: [PATCH v5 07/13] firmware: qcom_scm: Add a prep version of
 auth_and_reset function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-7-d609ed766061@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=4507;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=8hZm30CWvb7JLW+d0khgV1UhhQZmzpIiZ5CwI+qm9/8=;
 b=N85JGHOHG8LetyCjmUjV3FsTNYA/tv+mBZg0IQn7R0FYSTAHR31+Z7owFVcYXIrgd0alVgb6g
 Zn26aw8i5bSDHq0uuvCKt9IysJ/RKm+3sjjUuWF1CxO903ylwPBrYWE
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: kzUA1PV595al1qj7wLnwRjVuhGRrYWlN
X-Proofpoint-ORIG-GUID: kzUA1PV595al1qj7wLnwRjVuhGRrYWlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX5XP/yu2B7yf6
 e06yLbFbHxHnJQydKpYj4MQ/2VPUE9WYWjPtNvYJLVBbrA9qF6g8YGmemu7CaPb+HAIzd2bL9PU
 aO7DhM5kGLUR4f0jJUk/SOoaW7xWCUSASnDyfQ7MI7quwOcEByXCSFGBSitllwO/WGP+4iGYGOv
 3inGhDZOGq659jRXFmSaO6j2Bv3mmyLDkr9IUXVU713OwNBlLCqjCuPqZBu5qOxicqMBu55NOhi
 Lrvr83KWbqb0OhpONuG/tsK9b5Jo5UkhHF17QUvUwJdyTF2pKUIGYkYLcpqh/eac6Hbra2E7ihi
 iz6qljxaTjuFncKYfwHAH2er1dC7I2aougc1ZASC0ytF8Ml2PPHZkzC8eYR5uk6r+Vy9eHgM0gB
 JcSw5kwSadEPJ841shRtjT339rsrbg==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ecce9c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=XGel9bHSJmg9pP0w-tEA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

For memory passed to TrustZone (TZ), it must either be part of a pool
registered with TZ or explicitly registered via SHMbridge SMC calls.
When Gunyah hypervisor is present, PAS SMC calls from Linux running at
EL1 are trapped by Gunyah running @ EL2, which handles SHMbridge
creation for both metadata and remoteproc carveout memory before
invoking the calls to TZ.

On SoCs running with a non-Gunyah-based hypervisor, Linux must take
responsibility for creating the SHM bridge before invoking PAS SMC
calls. For the auth_and_reset() call, the remoteproc carveout memory
must first be registered with TZ via a SHMbridge SMC call and once
authentication and reset are complete, the SHMbridge memory can be
deregistered.

Introduce qcom_scm_pas_prepare_and_auth_reset(), which sets up the SHM
bridge over the remoteproc carveout memory when Linux operates at EL2.
This behavior is indicated by a new field added to the PAS context data
structure. The function then invokes the auth_and_reset SMC call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 48 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index b11a21797d46..a66e782fdb68 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -770,6 +770,54 @@ int qcom_scm_pas_auth_and_reset(u32 pas_id)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
 
+/**
+ * qcom_scm_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
+ *					   remote processor
+ *
+ * @ctx:	Context saved during call to qcom_scm_pas_context_init()
+ *
+ * This function performs the necessary steps to prepare a PAS subsystem,
+ * authenticate it using the provided metadata, and initiate a reset sequence.
+ *
+ * It should be used when Linux is in control setting up the IOMMU hardware
+ * for remote subsystem during secure firmware loading processes. The preparation
+ * step sets up a shmbridge over the firmware memory before TrustZone accesses the
+ * firmware memory region for authentication. The authentication step verifies
+ * the integrity and authenticity of the firmware or configuration using secure
+ * metadata. Finally, the reset step ensures the subsystem starts in a clean and
+ * sane state.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
+{
+	u64 handle;
+	int ret;
+
+	if (!ctx->has_iommu)
+		return qcom_scm_pas_auth_and_reset(ctx->pas_id);
+
+	/*
+	 * When Linux running @ EL1, Gunyah hypervisor running @ EL2 traps the
+	 * auth_and_reset call and create an shmbridge on the remote subsystem
+	 * memory region and then invokes a call to TrustZone to authenticate.
+	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
+	 * subsequently call TrustZone for authenticate and reset.
+	 */
+	ret = qcom_tzmem_shm_bridge_create(ctx->mem_phys, ctx->mem_size, &handle);
+	if (ret) {
+		dev_err(__scm->dev, "Failed to create shmbridge for PAS ID (%u): %d\n",
+			ctx->pas_id, ret);
+		return ret;
+	}
+
+	ret = qcom_scm_pas_auth_and_reset(ctx->pas_id);
+	qcom_tzmem_shm_bridge_delete(handle);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_prepare_and_auth_reset);
+
 /**
  * qcom_scm_pas_shutdown() - Shut down the remote processor
  * @pas_id:	peripheral authentication service id
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 7c58d26ede24..e1de3cf73451 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -78,6 +78,7 @@ struct qcom_scm_pas_context {
 	phys_addr_t mem_phys;
 	size_t mem_size;
 	struct qcom_scm_pas_metadata *metadata;
+	bool has_iommu;
 };
 
 void *qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
@@ -89,6 +90,7 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
 int qcom_scm_pas_auth_and_reset(u32 pas_id);
 int qcom_scm_pas_shutdown(u32 pas_id);
 bool qcom_scm_pas_supported(u32 pas_id);
+int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);

-- 
2.50.1


