Return-Path: <linux-kernel+bounces-884227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 343BBC2FAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2F24F9621
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269C30EF86;
	Tue,  4 Nov 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wzo05kZz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qqjl9cL8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026F30E843
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241810; cv=none; b=uEAL1Ciy9fHPPISY+eCc70biubMM3JdycxQjJbFWKQKhnxj0sTEIhjy/ZTAhLVJvDFZRwLGBO2Q/9cfzQUPWGCFZhYDnEyiSDyRdnnJIEgm40pjl0f+dsdEKA5nYP3Q2ibevQ2xlDJDkqWb7zAoiwmxDRLj4Cc1a+pJr9FdXSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241810; c=relaxed/simple;
	bh=jHKanraOrHEA4wVchAje3yOn5cqKuVeh1+NXKfMc8NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uO1HSCFexVuER9Q8Q5kxAULRiTJ/JF76iosSsfVdTr3LqLXt7AeJRn7NqLqwUKLsozX+3L5vDOwAUkwhYYXlCM+HfvosVrvgBmA1a30xkNKsIBbW34fXwveAWqPVZOpNTcvy1IMgjp1pnkNPW79z7eFyfjjim/BAGOKDPsfcRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wzo05kZz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qqjl9cL8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A434hwY3616705
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HeYU+B3c3Q+vTu3kdwO0nN56OnhgVZNR+2+kSV51GUw=; b=Wzo05kZzmTnI2+T8
	t5lax0FDgDvSLdKuFTkLC4RmndHp/FsEkLv3g9GJVRnRWi9vTZitYsI3t1dobbhU
	wZCuc9m3j/pBR2qKeYT7rpoMRD3EtezupynesTVUP7/ii1xbOvyQCc0D4nBXtTiz
	NkXugQ8insiUgCq/hBLLOTSllylMVMcv2FgIDxoVgGE0hdZJN/JSCY1YR4tGyY0W
	H3KUBLX6JiuRyuEUc52ZCQSZOs5mJU++iuz4Os3TSsERbOCd0PKUGnbQ0mNV/3CE
	/YZHmiL5FGeQkQ8NW/Q7uOBuAKBihwM+EvO0a01vYdeEhKrGgVIWZYI+xmQNRTBo
	qYG3zQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fht2yc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so9948917a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241807; x=1762846607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeYU+B3c3Q+vTu3kdwO0nN56OnhgVZNR+2+kSV51GUw=;
        b=Qqjl9cL8JK3NGIE1ilKJySal3ZG/+uNgqgGv+r3dmyiTRa4beZ+6MQ9JpgbxFVspeM
         s96dqOzhWMVNWXNzxT3ORl77Mpl4VyvbCK/ZGGIj3rf/UIFiTgmP2hFQt+UtHx4EjzEH
         xtyQj9P3WOHUno1d2jODyAq8MRyvN9uFZr9VoERoXOREvH6il8BFPNCEaWxcjCkdzvGM
         C3Fe4b3KKb07uIDz0Ql2ByQcOPcjOR/ckXgQkpF1IpBDi+SP5x8blWZbNc+D72FZ5DxU
         QOcGtZi+YPljvGqTMMhJWOKDjHoufK/csQknG6VRxgX1zgX1ngmlF9XepdlcN0qLmHPU
         bpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241807; x=1762846607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeYU+B3c3Q+vTu3kdwO0nN56OnhgVZNR+2+kSV51GUw=;
        b=mlH60LzQlQN241A+Cq7TwYtMHAduMgawV0gZaczDG1QH6+OGe6L+rIVRQQY6RGbo44
         u7xKABPYj/CueizcUOrPYChFbsBxziBFwug6nSGKi8ejsq1DeK3u/ui9zEv1JqyZ33U8
         2iSgDFhEbuC5qJ+4DBTIpMftU+qnCn9Eo+oD5OUxo8lGxx+Zw5VWQiWGtNZVVMkZvBd7
         WkKg1mQ0f8xfrD6bxa2D7Xt1ABC07CyPpoiozQ2qg2siHY0AiczcP7kcZo+FLyPArzpI
         mAb4D/mywRCEYik97WIDOf3gi2V0YoVhTxP+yBejME84UATd8OL5l/YOGrWZNtezFAfu
         mxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUla8DBpH/Xd2aQw2zHOjESNsiKh97KPXRBaSXzf+rUNqYTlXPdaldHrD65qMUh3mwFwMJ4n9ddl8EOM2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaileKnrQZQ4Z1fD67oxNi+wI7Vqfd6ZUjnLOQT+W7iZHBj5FS
	EE5mLGhooumi2iSWRU7PCFXQzdaayOaIrOlY3rKt+110sQgE9+mi0lr6qOkFM0XpwxULWj0QzbV
	lmQDhZNCKNFkbs937CZ4IlKu8h2Yg3oqeV99XGqxO2WQzHssbgzOQKBhnZyG5cQrk+w/8dd5ezC
	I=
X-Gm-Gg: ASbGncvP3jwf5JO7vHq3xPBnvR+3hDHexoLVAsYdYwAN7XsEcpVyBSJNU4ln/Q+8T1L
	kpSHDfxWb4PvrisApfDeiGRVIo4cMIpW9mskr1M8UjoH3F3+0BzMUct0Yj/bMC9F201oFsfyYIN
	7qBfNu8lwF2fIBSSP3lXhhd+FSmCtRQCy7K9zmnjDdNBorTbdoTZnG8SkBjIKVAV+naE1jFI2pO
	4CZpoPnXePSvP6Z1UIfiWUPC2ZA9ttAVORXJTsjuKEp/0ILG/SV73sJqRWHI66knwyQaYIUgtmG
	erZCim+yEUHdyIMqceoTK+DGEoT1u5RNaKFPuS28yi6nDw9LOEDX9CSn81O4ixRc4M6OQdH4JTW
	v4cFjFHaD1KVRNrWIUlV0ogGduA==
X-Received: by 2002:a17:902:d4c4:b0:295:9db1:ff32 with SMTP id d9443c01a7336-2959db2085amr109034235ad.48.1762241807218;
        Mon, 03 Nov 2025 23:36:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpfEAN1PLytB3qEo/p/sLyJSXLV9KSQt6TqyGBqMolto056kpsAwVModwBzcd4TQPHOTiYog==
X-Received: by 2002:a17:902:d4c4:b0:295:9db1:ff32 with SMTP id d9443c01a7336-2959db2085amr109033925ad.48.1762241806615;
        Mon, 03 Nov 2025 23:36:46 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:46 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:50 +0530
Subject: [PATCH v6 10/14] firmware: qcom_scm: Add SHM bridge handling for
 PAS when running without QHEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-10-7017b0adc24e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=2601;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=jHKanraOrHEA4wVchAje3yOn5cqKuVeh1+NXKfMc8NM=;
 b=fdvnZ530B5W8QH0VYExztLyTq/xmlM9pRXL2DXQMcol6tCs+zK86Y9+d3dS/Nf5PR5x0xEuGt
 mLjGZT2lBhQC+RLOL6O5uutQinWdojKunlS+iKFt53e0PWU+3aiGhVb
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfX3v9o6RY1T2nG
 HV4u61/QnO8vQBdeXA82Qnt/QQATgdV+cvtGlbZ7qiyisacnh93ktFgp2XIPF31j4cbaCc3usl7
 NqFCz3gxLU00rZ08TMJm5WOneEJZaxsbb9GY2pH12pKZFDmFI3nYLc9B2kiVNKXqWLRiViTy/KU
 /mQskeZLjLs2O6oWYx3SmO5zi8Jo5eiVW0vJpZulSCZgRhMR/ACFXiL3Sb5zyHIiZcQvn6O4ldw
 zTn7464mrzf8NgDyIbBF4/moX4rWXX8ZIqjZondIGlVNIg7Hk5eXznL7MJyJbzoT6Efhx8vWXaB
 HzSSyjvnHn8j6JFyk6KCTWfPrDH8FZvnnSP9k8tBIyBcxfaG1v061Xj+1qGXXUe+X9sqqNRYEF4
 /3WQXOfETorVKFf9t83i3mFZ+70XhA==
X-Proofpoint-ORIG-GUID: TUYb1RTi0mfyaXLS7ABuHG5NKpM8kACu
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=6909ad10 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=08WIqK_J-xaQODWVIAIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: TUYb1RTi0mfyaXLS7ABuHG5NKpM8kACu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040061

On SoCs running with a non-Gunyah-based hypervisor, Linux must take
responsibility for creating the SHM bridge both for metadata (before
calling qcom_scm_pas_init_image()) and for remoteproc memory (before
calling qcom_scm_pas_auth_and_reset()). We have taken care the things
required for qcom_scm_pas_auth_and_reset().

Lets put these awareness of above conditions into
qcom_scm_pas_init_image() and qcom_scm_pas_metadata_release().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index aabdef295492..9d3e45ec73ac 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -625,6 +625,33 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *me
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
+	mdata_buf = qcom_tzmem_alloc(__scm->mempool, size, GFP_KERNEL);
+	if (!mdata_buf)
+		return -ENOMEM;
+
+	memcpy(mdata_buf, metadata, size);
+	mdata_phys = qcom_tzmem_to_phys(mdata_buf);
+
+	ret = __qcom_scm_pas_init_image(ctx->pas_id, mdata_phys, mdata_buf, size, &res);
+	if (ret < 0) {
+		qcom_tzmem_free(mdata_buf);
+	} else {
+		mdt_ctx = ctx->metadata;
+		mdt_ctx->ptr = mdata_buf;
+	}
+
+	return ret ? : res.result[0];
+}
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
@@ -651,6 +678,9 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	void *mdata_buf;
 	int ret;
 
+	if (ctx && ctx->has_iommu)
+		return qcom_scm_pas_prep_and_init_image(ctx, metadata, size);
+
 	/*
 	 * During the scm call memory protection will be enabled for the meta
 	 * data blob, so make sure it's physically contiguous, 4K aligned and
@@ -696,7 +726,10 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
 	if (!mdt_ctx->ptr)
 		return;
 
-	dma_free_coherent(__scm->dev, mdt_ctx->size, mdt_ctx->ptr, mdt_ctx->phys);
+	if (ctx->has_iommu)
+		qcom_tzmem_free(mdt_ctx->ptr);
+	else
+		dma_free_coherent(__scm->dev, mdt_ctx->size, mdt_ctx->ptr, mdt_ctx->phys);
 
 	mdt_ctx->ptr = NULL;
 }

-- 
2.50.1


