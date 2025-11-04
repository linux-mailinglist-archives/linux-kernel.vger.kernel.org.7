Return-Path: <linux-kernel+bounces-884221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C36BC2FA97
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248683ABF48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA1530C639;
	Tue,  4 Nov 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fPltCVYY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fsuk6wdr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B930C602
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241789; cv=none; b=C0VWIg0RNb36KVAnW5s0qBG89pwRe3Yz3ZVxFF7XAGyDqIVhlpbSn4TpS8jAxQgjXc8xrzlRxyrWU5IiIhzGoFH/GNi0/EhhyfEj62t/IuxAKClfTptndiL/lz3Im9SzU/NByQ/wyC1RV6T6wlKYe/oSOFA9iapjnAYVgle1Z+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241789; c=relaxed/simple;
	bh=rmozCYG/Ljsh7GMxYF8mDZZkLJE6jlmjxWPOEdA8pAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXcZKfkG+jVXpXLM07XgtWwom7ppHtMOClHpzv4FvePElTJLslisr90FPyQyLzxypyW3HuZPemRWU83QjAfw480f0aQbOW+FeGaRTeXXa3ho1C84zjW2St68l03FYC5DPh84sj/9AAH8OmvwM3cqVipNd5gG/SRmKh8LobYsoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fPltCVYY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fsuk6wdr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43P6tw905295
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Qkl41O9bWIzcRWMGMULQ4Tz0JkXETLeZtykrnuB7Cs=; b=fPltCVYYx7KHgHuI
	KcIXtu/xL06sVM+Ttm9YkKsbgBnOonaluJL1y62qGuG/xDvG/hBACiXM7z4cKs3H
	aKvGwswg01HrrCbnNoQofNrlHilPoNuW14ZZOCg5fmsncNSFdcjorMNxJxMVPGbe
	axCMRkMnQWqEdastXgfqO5+1t1zos5gRVEUtO6ITERuB1E7nQJBPUPMhMvjYnwXM
	XmuMfu7/dYxMynHeUX26DT+BOzUOiCva/wrA9L/22r6JmSVjMSep+0M6xIsZU7HX
	RHa3mcICtSlB/MFhlOHZPttMoCic9641o9da+AT+Cr4BP/SbJM4MLaN1x2T1qSHH
	rAoLMw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a79jjrkp1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b95d06db747so2197968a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241785; x=1762846585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Qkl41O9bWIzcRWMGMULQ4Tz0JkXETLeZtykrnuB7Cs=;
        b=Fsuk6wdreaEU1gk/Mw7BzftpGMLaIYZXSi+wwBcvTs7AM3jK/FK63cW1FAxMIp17Fg
         A7pbvB4tFKosZ5p0oTGamFbzwEuu18iyhBuLBJn1XHOyelgPeQK9qI0R3/mhnAsB5NCM
         pSFdngBauT0znkoNw0Kt6UDu6AcIB8HQHJ16HjA03CvNc5OnIMXle1FruUqyTyhOJxTJ
         01iFlWt7NMi34mfPdDUStOWXFoJQznNicXzPtNdwSqFMl7NjUrYSYL3XqDuRAIOYx+0O
         WUchsohIg68gvxwb1C0vuv+3XL9ItT+A+px8i7oCFUibmcKuwDeyrZdpKdYmLtI6sk6l
         lZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241785; x=1762846585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qkl41O9bWIzcRWMGMULQ4Tz0JkXETLeZtykrnuB7Cs=;
        b=UMOZcYGFgQyda2kqf/AJK/c6QRLgDCxStQ7jtT5ona+izG0EfUaf2343ZaypMpm7ti
         UZi99tlX32cWZoI8vENYYVqb66YmahSZo4ToJXIhQ8mak6Y8RajFxCL9E0A630F7VKXr
         WJ4LbZHj/u4DKLk09RFrnLvhpvYvT5AyueTxVnF25DKXCEvcZVBUKXOu7WiMiHV8NQLm
         VOdBq8fDuTMudzPNsILj4IoCH/bEftqCGloOzgjY9EmqLA6TY1FMEKniM1T7ZTVpKyAQ
         RLeGyBIljoNajNu0HYhV7Du1gLsWr26rBS8dQJ0SOUaJyf8d1LqSNmVaMwC+hBoQBlIQ
         Yyjg==
X-Forwarded-Encrypted: i=1; AJvYcCURredW7FwSYqxIfF22/IxstotDiL021bAuJnSRlhr34zuKO4NR3nkqFK0N9RQn/fsAlYWjuGszZn1GV2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPJsJyCKS1urGugnqviI84z7rQ44U4ADSQ+XQz49GzFU+9+vt
	NhGssgo1OMggPoBInTfxtMQd58QnOTYMKMtwKKOlfESSG7fj0mkoJ5eEkXxFqJXESgXnSJCWHxV
	NIQcM8MvCiqpLbkbiQMGchpRz2PKkJ8oF+vZbuKTd9N97kgP1fXfktG0kqaZMVuCA4vI=
X-Gm-Gg: ASbGncv0blinw4drnLzGijCqUQVl44Tf+nmOch/DRicbLap7F0e6w85PZpmKIvidJZV
	+4qwUMSNlszjo+15iRXGQ4jfoqocrxIq74xs+xn/S3Gu43xvAjY966YEpuVYyKZyMURyIXtwMlq
	tYEkW+3r1rCWZvJE2wrLXtG0GS3fVj7nC9rwHR7q6ptihWWaqjQ/LDCs+S/kH5kGvoVVZkfGUjH
	VQEEP3LyOVLblHLq0+/mRDYRPoNNuqneQPJnVvicKRnBBIhryRQu/3k0a56QGwN+cZEzTBC7Xu5
	wgOelp+mF1gQVOolQCVcCl65NIfw8v+Rr9Dbb7jXz47uBWr+oMmDzqJpDwIZSNP4OwzKikcXKi+
	BXtFN42XILtOSzsUO0XIHXn2NXw==
X-Received: by 2002:a17:90b:3fc3:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-34171851b38mr2755158a91.3.1762241785014;
        Mon, 03 Nov 2025 23:36:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrWhNz/5lskpuFXtezZ31p252KcTwTvxSVuYrLyKHiTLuk29MoKj9eV/9jO7V6f926JNJ16w==
X-Received: by 2002:a17:90b:3fc3:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-34171851b38mr2755146a91.3.1762241784284;
        Mon, 03 Nov 2025 23:36:24 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:23 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:44 +0530
Subject: [PATCH v6 04/14] firmware: qcom_scm: Introduce PAS context
 initialization helper function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-4-7017b0adc24e@oss.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=4074;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=rmozCYG/Ljsh7GMxYF8mDZZkLJE6jlmjxWPOEdA8pAM=;
 b=oOYzziovTwf6Ughn9dTJjh36FrBQQ3aU98ekJTlAytEDzcwSaVT42Kg9NHMFnRam5HFDUiO2K
 t2dV/5qGkInBjN8dwqinAKUETXkbfspfCL6NXI7MLNAdK1f9F60idO1
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: Hjqr10N2O_IMkuVwx3sH39skqLV5cKBo
X-Proofpoint-ORIG-GUID: Hjqr10N2O_IMkuVwx3sH39skqLV5cKBo
X-Authority-Analysis: v=2.4 cv=TuPrRTXh c=1 sm=1 tr=0 ts=6909acfa cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FtZ2CgB1kwCBZN0VdloA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfX5ylM1/zd+DlJ
 yGyahuf5jsPvPT9IEeeqwbyvMJIq56NOaAh7EFPRrDiwN8DipkGDIbZR6rBpeVbi/UY5Nsocl0f
 vfKHQ6eRJWBvqvyBR4WcX0plJM9wfS1f7V1ypSXY5qfS6AbNGtCl/tLaXWrP5w4gOj/cfUJq3aA
 /WQi8cAJbKRDkWwv0qs3akbeLSEbgQaFVJ8tCPivXQvzt+WhrI+vSOQnG4MucdnJwyneQiUclWO
 Tx9+TMuphHixk+eXuFgCKvTUwplVKHZCmsEry8u0INRf1ertYOt3HO8bA8+YM68iK4DtDPrX0BP
 QLqj/NNj3GU1Df2zkuTd+5qCrKGKjXLA1PAq2wAmHBX6/IHwD8M7ABeTOcHOUnyFbz0Aox72lPB
 EQMifHGwsIqgr/2GYRZd9gXDtOaD/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040061

When the Peripheral Authentication Service (PAS) method runs on a SoC
where Linux operates at EL2 (i.e., without the Gunyah hypervisor), the
reset sequences are handled by TrustZone. In such cases, Linux must
perform additional steps before invoking PAS SMC calls, such as creating
a SHM bridge. Therefore, PAS SMC calls require awareness and handling of
these additional steps when Linux runs at EL2.

To support this, there is a need for a data structure that can be
initialized prior to invoking any SMC or MDT functions. This structure
allows those functions to determine whether they are operating in the
presence or absence of the Gunyah hypervisor and behave accordingly.

Currently, remoteproc and non-remoteproc subsystems use different
variants of the MDT loader helper API, primarily due to differences in
metadata context handling. Remoteproc subsystems retain the metadata
context until authentication and reset are completed, while
non-remoteproc subsystems (e.g., video, graphics, IPA, etc.) do not
retain the metadata context and can free it within the
qcom_scm_pas_init() call by passing a NULL context parameter and due to
these differences, it is not possible to extend metadata context
handling to support remoteproc and non remoteproc subsystem use PAS
operations, when Linux operates at EL2.

Add PAS context data structure and initialization helper function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 36 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 0a0c48fca7cf..5a525dbd0a2e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -558,6 +558,42 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
+/**
+ * devm_qcom_scm_pas_context_init() - Initialize peripheral authentication service
+ *				      context for a given peripheral
+ *
+ * PAS context is device-resource managed, so the caller does not need
+ * to worry about freeing the context memory.
+ *
+ * @dev:	  PAS firmware device
+ * @pas_id:	  peripheral authentication service id
+ * @mem_phys:	  Subsystem reserve memory start address
+ * @mem_size:	  Subsystem reserve memory size
+ *
+ * Upon successful, returns the PAS context or ERR_PTR() of the error otherwise.
+ */
+void *devm_qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+				     size_t mem_size)
+{
+	struct qcom_scm_pas_context *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->pas_id = pas_id;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+
+	ctx->metadata = devm_kzalloc(dev, sizeof(*ctx->metadata), GFP_KERNEL);
+	if (!ctx->metadata)
+		return ERR_PTR(-ENOMEM);
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a13f703b16cd..f574fdf88eaa 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,6 +72,16 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
+struct qcom_scm_pas_context {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	struct qcom_scm_pas_metadata *metadata;
+};
+
+void *devm_qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+				     size_t mem_size);
 int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);

-- 
2.50.1


