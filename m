Return-Path: <linux-kernel+bounces-844537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE2BC227A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B13C849B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335EB2E8DFE;
	Tue,  7 Oct 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dtmCsg7f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660A2E8B96
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855767; cv=none; b=Mi0ghRY0J5ItKPw631uKNtp6pPrBAAvdi0qo78qk38B18HAld8bKPVqv3jHFibMf97iSrJtOoyfDIC1zYPynPmga0WscRBCmZhtDMMejjUTX9PYF7pqQEJHE57AfKZ0hG23NBTov8R2h6F9v+70ypEvXEAwgDS0AzriWsIxUvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855767; c=relaxed/simple;
	bh=rtvm3+Ddz+f+13iqQLmokYM0aY2hnbKT1DANmSnuV5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sX3X8GbzBaNV6GbPzDoIxqPA19r6rs0WBNDbsbQljU6b25/74RXwISBp1Td+o8+MWttuRLgeutJu7FTCP8vnIWBPTlE+UDQ9xpkIGkA15/1iT8EeI89dRPwcam9LBrvoehng3iYCi2+dvXAX6F4kAEN0DLwZY2cNYRVYoCXffjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dtmCsg7f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ETBHO006747
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 16:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8vz/gQycZaJGjMl9k5XINZTrvGlzn+yuEewtwO6TWbs=; b=dtmCsg7fSfjFgkQd
	UXtfi1xrMZ5guMgvCplU3IKnrZArKHUsCheu613rt1qXw0UZD4GhO5LvpNOsMs0w
	R0MRuyxmp5gS2O38CBElaxCnd0rFDLzT6Aa6GRXvldm3e2G8CTPMzzC8m1avh+hR
	n98752jLo8UnmTAuQxdFBQ6FFR13Hg4OpGfoPUE95C0PH0q260CvgvCN5bXP2RIo
	XIunRjdGRCl4WxMkjmJN/+Wx9ZbVLAntN0LXzcZaT3aa4U55+11X7LB06qiY3P/2
	OEnIrxAX02Ejy/oun0qxwJ8yNZkDVjKcijlcgjYG7UWKz2T9BxFid+X+6cM0juXi
	9HSJKw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1qvyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:49:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b552f91033cso7547496a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855763; x=1760460563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vz/gQycZaJGjMl9k5XINZTrvGlzn+yuEewtwO6TWbs=;
        b=xFqJCe9nlj7UHleYA9n+DJsQzUMEKKDL2SuzMEKGUkfO+Vrr5t0wZVIceMNIgVPH9X
         xuANvy4xZRzM7KFMC3Ewch6Gs1jfaIXnIEnki6RFuCAom+LKT6NZ1E5nCod+vgQYnC+W
         h1fK9qga01MkYscC2j3991o0bwMlVROpWKzvXvc2V1z8SzJTEu7VxhUqcEHeuLH6XAUV
         tUsHIaMWnAi6/BNrc5BnPhQyIeAKFeIWvk9qYe/Li/NaAT6wduIJNmWv2prwUv0EK7pF
         hzPwLKJkVQE3/qnPzgLP9FypO1IOVe9WhFKFd9eM63FfRLLt6RK6mHkr5lJlOzgibtGm
         ZmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIp4QoNvEA2DPQWUdfEr/hBLWetRnc4k5kXFg/7maiSjSaQLaV10AJxxFsr3L1/LyUSChsqCSoN0/Ge88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWMf64CrcGihmdSfYtcLbwZ9bcc9v00xwktJF+gS6RQXlhS3P
	eCHaZ4XRq21DUkgraEwimn9BWh1fGDAvylEhJdfExBVXgURsHVmDQlPaCAskQEK52mZOfKCFxMw
	j0c3mfqOhI9ZXkGvYQe4qyLxKhbrjCKYG8KlRM4LIMoZdJhZSdqZ+qoYlxSnUngKNiWY=
X-Gm-Gg: ASbGncvBWvPYVFTtAnEFUznhoMIGYTrSymvOK0kH/MlPI3qlM8BlUIsJbKuno3vtoZA
	vjfa/XxxHoBcdpnJhg6HBKqKbMKKLJtky+qnP6d8CuK0mAb9teXmxEp3wGOoXRKkp7ubPF8uolj
	VexeD+GfO0ZDqCYPRwVshXdkSi7GvH+vM60p6IRpk/gC/TRDR+rumRTvHHKkNkUh/M7I/Mm9/W0
	8Vx8JNBzSFrCfxl11fXn3VygpuqFZuhzIZ21KHuZ+mocv0GrzwoUVu9icpcb9wq7U1UNGwrUai9
	Q+1K7IcCcZ1gHOfBgtPZpqc3j0Vu0CtQYwnjmCdcLmy/ly41bvo6W2IzUNP2/1bbkauzIzLq
X-Received: by 2002:a17:902:e80c:b0:278:9051:8e9c with SMTP id d9443c01a7336-290272e3cf0mr6648665ad.42.1759855763363;
        Tue, 07 Oct 2025 09:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe++5qn3pIgVX278WDIBcX0wBGoL4i1UDfu9v6PrUb4F29UsE5m3tnu7RYbxhCHhFZyfDpSg==
X-Received: by 2002:a17:902:e80c:b0:278:9051:8e9c with SMTP id d9443c01a7336-290272e3cf0mr6647835ad.42.1759855762443;
        Tue, 07 Oct 2025 09:49:22 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261e2sm171990825ad.38.2025.10.07.09.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:49:22 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 07 Oct 2025 22:18:47 +0530
Subject: [PATCH v4 02/12] firmware: qcom_scm: Rename peripheral as pas_id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-kvm_rprocv4_next-20251007-v4-2-de841623af3c@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759855751; l=6055;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=rtvm3+Ddz+f+13iqQLmokYM0aY2hnbKT1DANmSnuV5Q=;
 b=9cqur5rxpvIdWpcbqloYpmrcwgRDwCVOS5FxJLvhusp5tTZ2qWovDEgiIL0wXOKuuGfODkCdx
 nq6poSWiT/XAtEGhI0+Ok5MhGUwmNpgALCiPDIp0Ref48ALX3E7pihW
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: Nx3Vt4YKYbBUfd8Kv09IPROtT7uRZ34X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX9N/0wBHxngf9
 IDRO8WUkAUatLmkG+9ICFbXrHFD4npZ2EqD4zYFH9CjZETygGzKpzVRKBnJDsmnHdtG9ZiXHVpi
 jhMLwD4g0j/7MKSmaH2YmDEfFcgGvu5MLWMYoHf3wNWPRuFWm+xGV2ZumDIXMmLiUkRMCFLTUKT
 +2UKW/Hz3Pb2WKhcN7Jhz8oX6UfzhQlnjGjAjtECwPMDokz/VWHtUNSQdhsisVnwie0yzPJFJn6
 BBdYCa7S53srZmAFOTq5y5VZCrrFftWfqb3WpqF0XQdw3QYuwG7mSokfrDWUdb7G+qaiOcrx4vb
 dXakVGB5UGqJrv8x1SHVQ5FZQTLklFzJhFcHMHiYd6gGubN4xId2YIJkav1JjIgVGJhgc5Fb8kh
 reoKH+AqVeepq3umwrVbRp7d8nI5YA==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e54494 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=bcWw3dkznkfw-y6_B5AA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Nx3Vt4YKYbBUfd8Kv09IPROtT7uRZ34X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

Peripheral and pas_id refers to unique id for a subsystem and used only
when peripheral authentication service from secure world is utilized.

Lets rename peripheral to pas_id to reflect closer to its meaning.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 30 +++++++++++++++---------------
 include/linux/firmware/qcom/qcom_scm.h | 10 +++++-----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e777b7cb9b12..3379607eaf94 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -562,7 +562,7 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
  *			       metadata
- * @peripheral: peripheral id
+ * @pas_id:	peripheral authentication service id
  * @metadata:	pointer to memory containing ELF header, program header table
  *		and optional blob of data used for authenticating the metadata
  *		and the rest of the firmware
@@ -575,7 +575,7 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
  * track the metadata allocation, this needs to be released by invoking
  * qcom_scm_pas_metadata_release() by the caller.
  */
-int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
+int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx)
 {
 	dma_addr_t mdata_phys;
@@ -585,7 +585,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
 		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
@@ -658,20 +658,20 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
 /**
  * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
  *			      for firmware loading
- * @peripheral:	peripheral id
+ * @pas_id:	peripheral authentication service id
  * @addr:	start address of memory area to prepare
  * @size:	size of the memory area to prepare
  *
  * Returns 0 on success.
  */
-int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
+int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_MEM_SETUP,
 		.arginfo = QCOM_SCM_ARGS(3),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.args[1] = addr,
 		.args[2] = size,
 		.owner = ARM_SMCCC_OWNER_SIP,
@@ -699,18 +699,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
 /**
  * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
  *				   and reset the remote processor
- * @peripheral:	peripheral id
+ * @pas_id:	peripheral authentication service id
  *
  * Return 0 on success.
  */
-int qcom_scm_pas_auth_and_reset(u32 peripheral)
+int qcom_scm_pas_auth_and_reset(u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
 		.arginfo = QCOM_SCM_ARGS(1),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
@@ -735,18 +735,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
 
 /**
  * qcom_scm_pas_shutdown() - Shut down the remote processor
- * @peripheral: peripheral id
+ * @pas_id:	peripheral authentication service id
  *
  * Returns 0 on success.
  */
-int qcom_scm_pas_shutdown(u32 peripheral)
+int qcom_scm_pas_shutdown(u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_SHUTDOWN,
 		.arginfo = QCOM_SCM_ARGS(1),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
@@ -772,18 +772,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
 /**
  * qcom_scm_pas_supported() - Check if the peripheral authentication service is
  *			      available for the given peripherial
- * @peripheral:	peripheral id
+ * @pas_id:	peripheral authentication service id
  *
  * Returns true if PAS is supported for this peripheral, otherwise false.
  */
-bool qcom_scm_pas_supported(u32 peripheral)
+bool qcom_scm_pas_supported(u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_IS_SUPPORTED,
 		.arginfo = QCOM_SCM_ARGS(1),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a55ca771286b..a13f703b16cd 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,13 +72,13 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
-int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
+int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
-int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size);
-int qcom_scm_pas_auth_and_reset(u32 peripheral);
-int qcom_scm_pas_shutdown(u32 peripheral);
-bool qcom_scm_pas_supported(u32 peripheral);
+int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
+int qcom_scm_pas_auth_and_reset(u32 pas_id);
+int qcom_scm_pas_shutdown(u32 pas_id);
+bool qcom_scm_pas_supported(u32 pas_id);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);

-- 
2.50.1


