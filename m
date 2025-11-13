Return-Path: <linux-kernel+bounces-899142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35ACC56E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA313B0ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C1335090;
	Thu, 13 Nov 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RIghybrT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyRNGeNo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A9330327
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030188; cv=none; b=eMQKW99rPbSoxhKT7/HzgaWtjCKIlwoQcoPjP84E4TPS7JxmwbOjut6mKAJQ/0VVNiBhHZAhFz2xtlUMK0tT3u9F2xOgLh3Ql+Zlbb0l8/lmoSz5m9mkCMRHMMAAZPOTZshFsgA4+KM/Tc2kVqXbhImt9RD72MDKU0PeXB4PiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030188; c=relaxed/simple;
	bh=VVCR+ENypbBKO+M86kQWm+8VtQ4AQkNx4S2dX6qeqes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyA6aFsbmBBJGXnCxYtoBa2eLiEhoEZsa04JcpRxBmXG/dGP6cUd00SpT6fX4cO9uL3ekY9LsYkFXRJcLPzr4wBz1ZVJLt9JT/+m8V43IEB2pnycKxz5SNb281XuDsYYGzE+GYfZ9zZFgxdH/aPvsP/ZmqXD78XTuCxGJv6sLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RIghybrT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyRNGeNo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADAHHDf4097082
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rR/0l88aDcNP0Dih5MxWezK9voyuEZTIWNeSppsdn8s=; b=RIghybrTaMxsMxOM
	8olBtVdmtx7ZA1obXqx1uNdIAVICziDnOmdDRlylNJCcG98c5eQtdDQ7nabMYchn
	pp6R4Z9BW0glPdCggwGfGczeHZKGMV/ofJu/vroAe1EpTJ+Ety4eKKos/WxDGyes
	kyO35EaxHkTONd7qsyOVDVtJbw9q1Y7XFuW/EAVLBc5gtc0yN9ei1SXWSZJh4ftR
	rLC+XRquKEjDk2fP3k2pq3n7WwjFz9DBuP1bCzpi/CPCp2/NnagbGgKH66zLTxWZ
	0npXC21vHCOU+U8WSaFMDbqxASzFhzy4VX+q102etLsihCVb/rUPA8Kq5XxMsQwF
	bQ0jbw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4addetr1q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so586001a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763030184; x=1763634984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rR/0l88aDcNP0Dih5MxWezK9voyuEZTIWNeSppsdn8s=;
        b=AyRNGeNo0DJWwKdxR+jDZdokI0Ym2rk+BTGy4u2gC3BqggP5kz5hiW11J846rgJmst
         TI32YIAPM3LlWr6XM7h6zXugh7mreVaspmUEZ7GpAvT3i19ZJ3pdzI6sDGeC0mkPl0rQ
         rio6aOaYXsM9a81/K1ItuEHnD67PJ1JHZjX1xZ1dvzh6ITttjHmUfP6jugQJ7BumVj07
         UsGdGk+8M/8KNSbtESXl6USa4vZ+zKJ5JZvSqqPtTDYPuYLSnQHHNEzPKu6fF6XSb94n
         GT+2wj9yXSwXBpbfS4i0bqwcsETxDG8394BDFfdz4AH0AXPwzEPcWoBxCRBKgrITc3K1
         /06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030184; x=1763634984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rR/0l88aDcNP0Dih5MxWezK9voyuEZTIWNeSppsdn8s=;
        b=vRHXZaE6csxjo5+kTTj8MubgFDsVSUbqprn85v7X+YGujDM89ZQrA48PkTral2fUt6
         3XbtIi7jpRcSGiWZ13YX1/ioq069tJ3WZuHG0jnfETjEJUOberxJ18rU95aegh8+YVQ1
         gojircceQLFKkDltPmzenrwiFnO0gkM+cwpp3lbXMkhXtqBD1IXOpfiEQJaeDvNf0twZ
         PsEtFmqLzkHIpct01QqKhFsVbS1B7iiMV5XVzp0eHFgM+rmdWD9KkNhreXSmS3rzh48P
         YmaJIds2nUeVdZ99+JFUCku1eMckU3p0BKQl/mY2j3gtaNHumD9X19CQoRFZI6/ali+X
         /LzA==
X-Forwarded-Encrypted: i=1; AJvYcCVmGJil5+aDJRCKLuyHjSTrbEvShOK1EoxK/Y6ZX/dvCQBbuqzJAIxgLJt07HR1cvo20+jc3CQa28+E12w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZ/6pY6UpNwvquKnq9i7J6u3jgOPqPji3ONSqHy9m2s1+R3VC
	0n0/BK467QRiI2mGhdYHGpzuHqf2QXlM9/0XI8akRMkAfFLc32Yt0MJb7QcKJ3LOe3ewsoNl00x
	gz5KF74LAE4KW8H2VsmPIDAa9JNLWngHns3hjF0n8jzWYx8Ii913xEg7vH7I214roMWs=
X-Gm-Gg: ASbGncvmHvLex978aCeS8NZjjangUkH2EGKAhD1PVSSCs+q4fs1oUy6sV0EogVbAyuq
	Yf4pGpLcaf5eZSg3dH0Qa0BJy4G8jd1kwfdro+ZIKKPF7VeDrO+kBONWB+dg3wuRD7H6AWUt+4D
	HPXrGuNTVdsaKRq5CY/iemFb0POdkBvCuItMMTASGz0KtEtCkcr5EoiIhuVRan0fc7ZEprT7zB9
	w43tFA+FHZgoXgZTjS9kxF6l1wPC3svBaM/JSjO3w3Wst08D4qwMT8yodMqGQlyJWJsmBh+KU5d
	vOr570hAHUclzH0v1lcErBg2jCojZeeU9A6G/wxHj17+1DiRKpoo6Dc8OOe/w5Ns8LmaWnB7R6y
	Lw63BtFUH7HaYByPfNqOLIUOJXg==
X-Received: by 2002:a05:6a20:94ca:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-3590c216599mr9041040637.55.1763030183817;
        Thu, 13 Nov 2025 02:36:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE/WGRXIgdKDakNktZ0qm+S+LvqAvui3zQTOhtcocikgATOeehZpZplyPg0+JiJJmaF0kF3w==
X-Received: by 2002:a05:6a20:94ca:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-3590c216599mr9040998637.55.1763030183216;
        Thu, 13 Nov 2025 02:36:23 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm1886922b3a.22.2025.11.13.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:36:22 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 16:05:54 +0530
Subject: [PATCH v7 04/14] firmware: qcom_scm: Introduce PAS context
 initialization helper function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-kvm-rproc-v7-v7-4-df4910b7c20a@oss.qualcomm.com>
References: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
In-Reply-To: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763030164; l=3953;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=VVCR+ENypbBKO+M86kQWm+8VtQ4AQkNx4S2dX6qeqes=;
 b=cC/tf3rnrqqWy8CWtId4ou3nEUEHC8IlJxTfvNaPOg8RIyscvS9Fvgv9tVY7E5Fju0KRnigbR
 5bXSF8CNs9WDvnIx0/VvU7goRrOcp9Ll3rVlFqfpZMy/rwk9QMTf4L0
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: ndUAD6FkEpccf_ddr0q2EEOIvdFtfuCK
X-Proofpoint-ORIG-GUID: ndUAD6FkEpccf_ddr0q2EEOIvdFtfuCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3OCBTYWx0ZWRfX4YEQQC1Oj8rR
 VQMfv2843N0KYrnQzCgm78fR87AsfXYmbbkNYoIz++Oq7W4fKLyqPJlbQGNE8jnSxxhyIfAGe1a
 JM+OSoDm/cyCyowtdIWFGefJFRaPB8dOWbhRVRzqk1F+EFeCRfRS2Ea/c+/TQGrvk40NFSoGMyt
 036+Hu5xruj9uPPrukLp5uWZ1LsalCu10QtFJ+BvqU+zmop7CDvBwSkUgJgupJMaymeO+lCZ2zP
 OeU24ENUciIOOJALT1YxebxXc3UpaAlAQOGpOEgZJtUdbetCMDRys5tr22e6CTW33/onYUGDAFS
 XNqV3wIpLEXUSldzDysEgu90YNqKvHgLEkk8L5Bwh3xAxlj+Apq9fFxYKVSUzpTeqTt8chmJTTM
 vqgDIxPrvMtcZL2RQ0g+j5ynK0e5Bw==
X-Authority-Analysis: v=2.4 cv=QZNrf8bv c=1 sm=1 tr=0 ts=6915b4a9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FtZ2CgB1kwCBZN0VdloA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130078

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
 drivers/firmware/qcom/qcom_scm.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h | 12 ++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 0a0c48fca7cf..e4eb7f3ab7a5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -558,6 +558,38 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
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
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a13f703b16cd..dd07dce7833a 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,6 +72,18 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
+struct qcom_scm_pas_context {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	void *ptr;
+	dma_addr_t phys;
+	ssize_t size;
+};
+
+void *devm_qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+				     size_t mem_size);
 int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);

-- 
2.50.1


