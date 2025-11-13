Return-Path: <linux-kernel+bounces-899148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AB0C56E92
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49978345112
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4DA33970D;
	Thu, 13 Nov 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmzgqgUC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VC7cIgTE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1D33507B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030209; cv=none; b=G5N7/K7uKmfQCihPrY1NVTOtYDscSKreJdfMMueL7EkHyXENZyk/KolX0anQir70iCRMsAmoWPxpMD5pb7Jx47M/F3XJc2ldMr75hOsejxxCnOI9uvXYTNipm0/VurkQs21OeL9/XpENesClwPeo6FUEYzzR+SwIUGkDx8eh5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030209; c=relaxed/simple;
	bh=K5AD4MS8Ep7hajHBXS/zPrrGUHN+ZQvv9zBkPOPyBR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhey6rqKXfj2pfN1LYw7pT0Seka76LewHRp9LkacBcPpo++LgKONuiMdH5K9avVMICGd8/pAkSMDKOTot1IjLQtaaRBy6OE9fvpEyZLi6UABDKcpw4IKnP4IWtMrLKADQmNqiniJ/Q8rMUYEpcEEF2yiD9UcizWIvQ65PwUvS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmzgqgUC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VC7cIgTE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8tb5D3114164
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tz5oxegOpV9wqnYLDAnAOnc8hojI0YEC3J8gLErT30E=; b=jmzgqgUCEN06FNi8
	B8Xl1nSluHMbE0KDMEqndrTTmdrAW4/dn+EOmZN0cM7XlhkNRgl2+/HEQ2fhjD4F
	4O3rgE0G4g216+lkGWgkaomYyiA4LLYa03uXJHGFh046cO296dFhJPsstWYK/k18
	LEif5bUVaLCygcEQf4TpH3qiZLvCElzb7X8FN17ZtyLCJO3rqjkeUYz1Ycz4SNIY
	/JsEyyDTgG9w4MgZFgAQ4N4+SqPZPlXdChPVrUqI/0XDPoVdY8VGiiKJdYXDpe28
	mFI5M7PFKpxBBcSdoAEpx5MtFxx5Fxu+WBYO/1gN+Al22NTQufs6LeP3dgqFoxQI
	nkARFw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw4bg1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso636663b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763030207; x=1763635007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tz5oxegOpV9wqnYLDAnAOnc8hojI0YEC3J8gLErT30E=;
        b=VC7cIgTEheNrzhVz4m9F6g2Is2vzMDKGpOq5jAhruSr21dNpbdrE+TxY86Qfm0Er8G
         bmFnwxb6K9qTYqPItV4ndAYdUev+yyNwEbPHZUrhQJgT2rg2vpOgbRYUEYBUop7Y+guE
         gGPsJAqQVNsWR/GeiLP+pi1tluS58NO4H4WAev2OFhZdw9yQ1jKTnEaEr3dIdmrEn9vC
         BoWD04DPpu3Se8wNlXgftAr/7AqcunSAdwj2Qg4im4xalIlFl7czImlEdx/TZFyE5v0J
         q05+m/kvdQI8ceyJarnqYmD2VGTZ/pausg3eu4YYDEw9X3Z89t2Hd9LywKKuj5O/nfmL
         0V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030207; x=1763635007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tz5oxegOpV9wqnYLDAnAOnc8hojI0YEC3J8gLErT30E=;
        b=v9zcDcyT8LSCVu1fyJYTxe/y0rtU7292HWQM6vdOdu4+pizJGLa4QM0TPIfT88N1Hf
         bEK0H0SI/5uKqT+vSdjHyFChZVIb0IXxaH5YYz4oHSg1BKmhgIJM7WI7MWUpNia9wNTG
         hp38j1E3igjEa5433jCOMU1YBF/u8cavIcRgZYM/Udnk+QBDcyMgL7Nf3Vm49G/67jL3
         c/NmaUF4NzZPbMVSLKwv1PdLO1RIDSuRjeZ+MXryoN4mHUdstPDJyB/fFes4URebNG7+
         O9IJNiYtvtXNBpSVwr2TIpa9asD9v2E8SNBoGrrepDSP9o+62kKplegTif1uVxHgERsT
         0uFg==
X-Forwarded-Encrypted: i=1; AJvYcCVIrtNu07s9PqkpssY6a0mwePVSJ7OA2GQdNR6t0ACJvXZsQtBRsjCShGpvKvARFcFU71SKIpPiVJiyg1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJr0Ay+gJwsNQCf9A4yZxwGSKXbNykP894B7gKZatDNcS9VxkF
	xdnD3jsRQe6rEWeYe2YPrAZvpZtaM2X7NKBVyfHGZfflK7SEPcr5CTktUYzYoQUM3S6/3zyBGNi
	4oXEej24Gnoxz5GKBFLAAhPzMWVSRjp8kiVTYRRk7yHuuCtX+DbBV6q8WGqrkdA5mZS0=
X-Gm-Gg: ASbGncuwBTIKSCvafCpleEt+0vYjguyXtR+mQbWis4/Wk4Z9LfEo4x+Y+UDJxu9CW/t
	hlgeJBSmIOTkihCMGLSLTULTJ9GNHKyaoPdveKwop4EdfzpZbO8B/6futUVQMfy+PQ6AdJcgFhm
	hnyx0jQHwSo/aBtgb6tqw95mvwyjtjCSXNRoNbdFVOrxxAY/rQ9k4/z9i3bV/vEKZEC+ld12uRg
	xJ200LL2KECT8qrGeXhQAb7I567BafMrfOgX/qeuo62SiR3y5WgJVevOKowaelBZ5zVxzayL1NI
	L5eXc8GXIzOrIhQMt54VPvrzFekibT1N0oUvoxi3LteLdIzttTbl0gJsEbhX2zx0Brhts2BR00D
	Q5Ih1FW7cpSiN32rsiEDaRAm0Qg==
X-Received: by 2002:a05:6a00:2287:b0:7a2:6c61:23fc with SMTP id d2e1a72fcca58-7b7a2b92da3mr6960949b3a.10.1763030206458;
        Thu, 13 Nov 2025 02:36:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/WKDiCM2UOrMWgSAoR7ZDfPT2yc3wUHejCPKn29YFtjPwMnE39+X/wjvHSar2LPQwCJgk6Q==
X-Received: by 2002:a05:6a00:2287:b0:7a2:6c61:23fc with SMTP id d2e1a72fcca58-7b7a2b92da3mr6960914b3a.10.1763030205815;
        Thu, 13 Nov 2025 02:36:45 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm1886922b3a.22.2025.11.13.02.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:36:45 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 16:06:00 +0530
Subject: [PATCH v7 10/14] firmware: qcom_scm: Add SHM bridge handling for
 PAS when running without QHEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-kvm-rproc-v7-v7-10-df4910b7c20a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763030164; l=2476;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=K5AD4MS8Ep7hajHBXS/zPrrGUHN+ZQvv9zBkPOPyBR8=;
 b=IcKOznaNl4sz1EXhicKw1RV3lBUoHCmqELDUGl1+01BWVW4upKK+HhJDoP5jg4MW90VBsLxDU
 47EjUoTpFQyDsyatel4b7984Ae4UX8LRTKu1Z0oDcWzfQ3Q9mhUYsn+
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: 6lATmqVxQRCguRshpu3M89xM61I-0wvU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3OCBTYWx0ZWRfXydJJNQtDkgxi
 QLtvAWgYz5ArmqKNjXk+7fpm06AzK927OM24WxULm0o00O2GDQCheV4GKJvcmMMVrKcnXG2OUgv
 7lcfn6GW05m5qrwSPOv/HaYIdRyFTokV9ttL7uDtFPPTYOXJDP+26i+J4Fbao2/m0kT2xF5Q4v4
 w6KZjPEe2WICoqP8BwM1Oj1dZi4ONOsTBl6UNc2q7FI7dcLTlbQsBS8AjlOi82R2bgcSHHxHcw/
 qf/YGD/vtjY6g2Zz82cKTcOHrSPecg9f3PIz811JWRyFNpXPK/veQZICD5SO8AN98EgE3uolUGd
 2zGvmo4+NzmtAnzGxGK7F8y4n8OcR2mECW9ZfbJzYu98MnjDBja+wz3dKlLVnDeV9yng5oyuhAp
 0JcWGmiBR2mLPEbQCd6f+EZqPOqEEw==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=6915b4bf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=08WIqK_J-xaQODWVIAIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 6lATmqVxQRCguRshpu3M89xM61I-0wvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130078

On SoCs running with a non-Gunyah-based hypervisor, Linux must take
responsibility for creating the SHM bridge both for metadata (before
calling qcom_scm_pas_init_image()) and for remoteproc memory (before
calling qcom_scm_pas_auth_and_reset()). We have taken care the things
required for qcom_scm_pas_auth_and_reset().

Lets put these awareness of above conditions into
qcom_scm_pas_init_image() and qcom_scm_pas_metadata_release().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 1d8a2c537c44..cab4723eb33d 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -621,6 +621,30 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *me
 	return ret;
 }
 
+static int qcom_scm_pas_prep_and_init_image(struct qcom_scm_pas_context *ctx,
+					    const void *metadata, size_t size)
+{
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
+	if (ret < 0)
+		qcom_tzmem_free(mdata_buf);
+	else
+		ctx->ptr = mdata_buf;
+
+	return ret ? : res.result[0];
+}
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
@@ -646,6 +670,9 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	void *mdata_buf;
 	int ret;
 
+	if (ctx && ctx->has_iommu)
+		return qcom_scm_pas_prep_and_init_image(ctx, metadata, size);
+
 	/*
 	 * During the scm call memory protection will be enabled for the meta
 	 * data blob, so make sure it's physically contiguous, 4K aligned and
@@ -687,7 +714,10 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
 	if (!ctx->ptr)
 		return;
 
-	dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
+	if (ctx->has_iommu)
+		qcom_tzmem_free(ctx->ptr);
+	else
+		dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
 
 	ctx->ptr = NULL;
 }

-- 
2.50.1


