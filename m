Return-Path: <linux-kernel+bounces-825856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583DDB8CF55
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A69E1B207F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86B24DD01;
	Sat, 20 Sep 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fRSqHBRr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41001248F73
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397318; cv=none; b=QSWIetGNKBFAQQU8k1y8WPiQ5b8rfSyFi4T8ddtAuv6guXHPAxLzMTLfoO00XoRmFW6sP0XyKCtD6SXV3FqorDlGOuHDqePwefJPAQzgh4YTrybY5EOl8saHLOmFSDLBF35J3VEZ8fq3bW0M6a3E0QyDHQGbqg7XidcSz3dWPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397318; c=relaxed/simple;
	bh=3KgyjXRwRT0BZpOK2ZGsUpjbWGpx9hKg5Vj5ua5WIZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEmk4usmIZQOGmL6BwSlNuETqYkrdsOItzrDYAPg3QA2dpA0a5umzf2IRXmj48OVpYS4jNvmkrGcRxETgy8oioPzG9r3l15X+44HJfvlB1GNZO7+793lmNGKAuk5CkUrGXTT/2tSzi414wuD5Wz8UBMlBkJGfHJeBpcN0OCCOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fRSqHBRr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FWCa019280
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	McnlfO8jRhsps7LRs1tZ8ulX+YiW5w0YVixmNKrFdbM=; b=fRSqHBRrGusloyhj
	cUCpI+neP6dFXX6eavHGzm392c/dmQY5tiTZdt3ABNnzjr0Nix2gt5RVkVQbQopb
	i5BNnGMQiKjteVPix2UU3bRn5DLaplRd9ZvL0U/8zEAvrpVZT5LRxTatZmvPu2se
	Tp9OrKnlgaQFz3mOFB7IR272HSUY0+cKivEFV1al346IrDzppQ0DbnA+c7x+E86K
	KYyzp/cFefB2zwf57gwBncMG1ryRIAr4ESyvzCuVJ518Z2fhVTriGCZi24RbLZYH
	Tjxd1IeZcLgu2TphQqjcrUlzo3srROPYiViNBgwE5dg2gBuefF1VZaVIcRDS4w9N
	PEfDZA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyehed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:41:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77d20efe2d5so4284987b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397316; x=1759002116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McnlfO8jRhsps7LRs1tZ8ulX+YiW5w0YVixmNKrFdbM=;
        b=I4JkVIt0JIDCsOzXxRVr+Hp0ZkfPJrYRBXmgE09iV1cQr1N7R7UC/Qx94y6AKauKNe
         sR61lBSxMoLQyoNKtTXDp32aJ6Wf8kFgGkaPz+oykzYwPXPlGkcxFUK1JjzGwKe0zCP2
         vIszXjrMNdB/pmzh2Ctw8gQPhl8Dkh5KtbG8GU0CcciLdkJI4X9qfIfcm07oXT6L9eC4
         nXQK50ueByk8j17paXZjbPll8OX5Dju+0bDhY3Awc/xYvq1LpII/uXpcOvWcH/dunYs7
         oa358Jy1+2MnPLgVcYT4KnNUBoTqYYx+Va1URKNmV1n1x/0+vD0jV0bJpZ2XT/5v5zvy
         yNdg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Mgtnr3jOx+t7oIzWhAN0wo8LYlVExR4mc/XneGQ39QIzCKBPVv/S55n5OFSc8hdv8B2IVZ2dM1PMmN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HURcJ7o3CWvBPkglQBZ8LspJfxijUf+5tIV1xM1g2P8YC5VU
	9H42Shrfc+ZpIS2Rgl6ACm7QJ01+VYvYzEAFjoaebtoj0raBLgLxC/7quCexhaLTMWgA4RpC9WD
	sbDxzsDza4/UtrbzTgRQfV7w9D0NRX5F0Iwmhvet67ROeQZYD9QRndWUBH0pd2IC9DrI=
X-Gm-Gg: ASbGncv2VyNVzJb06xWPc0b327+yGuCT44h/0NffhBm1/WjxceRzJlPC68jvw1Oe/Z+
	knAysGCt4jC1YuV7r3UgRlD617apzpC7PbhmSyUz8bBZyVnMgZTX6z4/yqQj2obIClsTWEq3fFn
	puSA6JEatVcdxrP5P6u5n4+xRWQoZ/F3XajVGK71s+THlg26XrxcYLrLLbDhm6bzdFTQeJZms//
	wwAjnxgATCxEjyWBzDC+QbQPBLRPryurxXZz3zKW4nupXPUZ1/p/G+KbEBPqr58FgVuEdlwnKKg
	EXaUYE7YfWzjreojwtuAcVz7qk2lyBWM2TIJHOogq6jCZ1lo7/IzVt/fTPhdlq/vaaE=
X-Received: by 2002:a05:6a00:39a3:b0:770:73ed:e6e8 with SMTP id d2e1a72fcca58-77e4eabb491mr8403452b3a.22.1758397315702;
        Sat, 20 Sep 2025 12:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqFpXp+tQNpf6lNmCxbEKSFzL9Gp5AmkkEhhm5zAukFjTYb67e1DuHAs/eB3e4Z2Nu978rMQ==
X-Received: by 2002:a05:6a00:39a3:b0:770:73ed:e6e8 with SMTP id d2e1a72fcca58-77e4eabb491mr8403431b3a.22.1758397315270;
        Sat, 20 Sep 2025 12:41:55 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm143767b3a.34.2025.09.20.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:41:55 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 01:11:01 +0530
Subject: [PATCH v3 03/12] firmware: qcom_scm: Introduce PAS context
 initialization and destroy helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-kvm_rproc_pas-v3-3-458f09647920@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758397299; l=4240;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=3KgyjXRwRT0BZpOK2ZGsUpjbWGpx9hKg5Vj5ua5WIZU=;
 b=ot7silLD6yPh2qRLGAMTThGDAx+ugIsgiHp90QsHoP1/BP/cfWDdli+MGKwI7bXztXef67ejG
 AhtR0NQmwXkDyxO0RdMrVH1Y0LB/d13tTmQPnxwcbRfb9r6FqRwWKP5
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: gl1jdbE7xj3W29tuijt2XxDMBGxr19jM
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68cf0384 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=puzVXGv8aC7m67-pkSgA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXzKQrDXYPjyOI
 zJg6gNzfiKLj3+BYoSLAWiOk+rJx4CHwT2RwB+FBKuh47GllBO0VUPCWuxGeyr/dXdMny9ABsLV
 uL4chJdG0UXLXnbPK+S4cxnUTyFtU4iwGlY+HnM8fm3YP2UuQnEEFnKQwAXowSqtd+hGhWpxozb
 /7kQnBA4XBXu0j1a27hQ9vfuj6McVSSfkHB+rePxDl6VlL3Jtl/5mp6XqPWK0CAZRfaLeThgR+O
 4rMWo2fnJl/+0zVdUDDiMU9D+xD02PDq4WHp2nMCwPt72osqW1j1/Pm8BiAaVcdFmnthiWdVeW8
 VUH3x7WbKJP/3qxBr17m6/8VLwy3SGzXBj5M9/NPiS3++7Pq+HhdMfNcCWCTnmfDPsHhCLNIqzm
 qJntnGZN
X-Proofpoint-ORIG-GUID: gl1jdbE7xj3W29tuijt2XxDMBGxr19jM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

When Secure Peripheral Authentication Service (PAS) method runs on a
SoC where Linux runs at EL2 (Gunyah absence) where reset sequences
move to EL3 and Linux need to do some extra stuff before calling PAS
SMC calls like creating SHMbridge. So, PAS SMC call need awareness and
need handling of things required when Linux run at EL2.

Currently, remoteproc and non-remoteproc subsystems use different
variants of the MDT loader helper API, primarily due to the handling of
the metadata context. Remoteproc subsystems retain metadata context
until authentication and reset is done, while non-remoteproc subsystems
(e.g., video, graphics, ipa etc.) do not need to retain it and can free
the context right inside qcom_scm_pas_init() call based on passed context
parameter as NULL.

So, in an attempt to unify the metadata API process for both remoteproc
and non-remoteproc subsystems and to make the SMC helper function
cleaner whether SoC running with Gunyah presence or absence by introducing
a dedicated PAS context initialization and destroy function. Context
initialization beforehand would help all SMC function to carry it and do
the right thing whether SoC is running with Gunyah presence or absence.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 53 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h | 11 +++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 3379607eaf94..1c6b4c6f5513 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -558,6 +558,59 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
+/**
+ * qcom_scm_pas_ctx_init() - Initialize peripheral authentication service
+ *			     context for a given peripheral and it can be
+ *			     destroyed with qcom_scm_pas_ctx_destroy() to
+ *			     release the context
+ *
+ * @dev:	  PAS firmware device
+ * @pas_id:	  peripheral authentication service id
+ * @mem_phys:	  Subsystem reserve memory start address
+ * @mem_size:	  Subsystem reserve memory size
+ *
+ * Upon successful, returns the PAS context or ERR_PTR() of the error otherwise.
+ */
+void *qcom_scm_pas_ctx_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+			    size_t mem_size)
+{
+	struct qcom_scm_pas_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->pas_id = pas_id;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+
+	ctx->metadata = kzalloc(sizeof(*ctx->metadata), GFP_KERNEL);
+	if (!ctx->metadata) {
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
+
+/**
+ * qcom_scm_pas_ctx_destroy() - release PAS context
+ * @ctx:	PAS context
+ */
+void qcom_scm_pas_ctx_destroy(struct qcom_scm_pas_ctx *ctx)
+{
+	kfree(ctx->metadata);
+	ctx->metadata = NULL;
+	ctx->dev = NULL;
+	ctx->pas_id = 0;
+	ctx->mem_phys = 0;
+	ctx->mem_size = 0;
+	kfree(ctx);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_destroy);
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a13f703b16cd..e3e9e9e9077f 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,6 +72,17 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
+struct qcom_scm_pas_ctx {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	struct qcom_scm_pas_metadata *metadata;
+};
+
+void *qcom_scm_pas_ctx_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+			    size_t mem_size);
+void qcom_scm_pas_ctx_destroy(struct qcom_scm_pas_ctx *ctx);
 int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);

-- 
2.50.1


