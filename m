Return-Path: <linux-kernel+bounces-850304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B007EBD273D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CAC189BE41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B2E2FFDF4;
	Mon, 13 Oct 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gk3QdRKH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059C2FFDD6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349858; cv=none; b=KaDHG0fveMF1PjE8ZYQ50RpsQNwDOGTCuV5G1tfjKizA099WQpmGlXnvFEn5OSgu6J0+j967n2B7Y4/9X2Y5FGYz/t1TiiFyaRFzA1fYWfL5kMHe4NXxtjdlATIQN7KZEiKA6nb/HlFMAGZlxvbXNk5isZm08DGWDuCZV6aIOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349858; c=relaxed/simple;
	bh=mx+8fFZ5SgEiJcGilO58BFpsLap7iEGUEYxIj4lgzR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZExgrjTXaC5xGj8A482eBiDxZ8iS9C9nL/VEWPk0bcZfnchBe5ifWG/RT2ofRemQ9RIeIqAkuNa+MTi4f4U+r2v5qr1n/IGT7MKTjDIuqmgZ0k2gzPqGAvve8dllAvGV7tdQEkZXeSRKFVFKZF5/MxMTggroly1TdKc5ZTKTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gk3QdRKH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DA4E0X000377
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SznCyvMyhwcUfIited6dpYaRgv3z3E+TYRFZM//iF9I=; b=gk3QdRKHFZ14GSLL
	2By4+Z6e8qupS5+7wwH/3TYoxJZ0IO4VQ+EWd+VTyxIXwQzIid/5hCIcm7GFFShm
	qbMeboyZ1yNR1LJSM8X9thSTwo0ENhG6Ec3BnaEXloNQezYKtQC6RKqlQtV1a9c8
	xsiy0qCgMmMVNlQ2CPYr2DGuWJVtaX3fOJRPC+6h73Ab+z4J6SBqTADw0Dmw5BVU
	Mcff7k3AURART9qDsFHgCPi3ciqu+0sQ4nI3PqMGER6Ph5wfGwrj1X452agW4nkQ
	pjLG/zXKVLsCf2zb1zVVU7tV3Dak9aPKqkhrD8GW+SAss12DSW/7cOxIUdWMTppZ
	oATpdA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qferv6cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810912fc31so6989055b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349855; x=1760954655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SznCyvMyhwcUfIited6dpYaRgv3z3E+TYRFZM//iF9I=;
        b=xJYWx+lZcMDSzg6vUao6D6sZ6l67+Qbu34T86uFimRKM2f3CCoMLA4/Ng1454gbMPf
         V2PEgauusCUmXpyvw9pbyyrwFaT8wlWJ7dLGUu5RfogEJcH09q8NL4/jUT4Kf9kB4snc
         eBrEw8V220VrnMDtCeuVjyKwtlBGqZMnHEOfVwAmOCwbyLIMuEC1bzp3C78nPMGnaioZ
         8IEK4umBWoOOGJ7LRs1qhqX9V9xk9lYjeSO+TajPx9DQiEFn1pvS5R9yem6iYQWvWamu
         HqR+uIZFHM1ugCQAlcU6WGKSGKFB7xJIq67OjBObn8PtNKszFu3CSWWgDFtTE3ZikE3e
         NJQw==
X-Forwarded-Encrypted: i=1; AJvYcCVKGgFMqaNbMyYZVv+ZJU7Ctw/8PEh2pPWDJKMkeFPNljAzcZHnl37IrkRhUChRLnTnI6ZhnvNlJr38GGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UR1yuzT73vHQKLQSvUNp6hzvIM9AU0zMa8kiQtb9KuwgTaBo
	G8uYQENEuRJIotpsmHtzbtqwG7owkD7RJ+28hHxG/4EKvva9D8vSfLU97lwXc/kWYxii4cIM2dK
	RhxH84KlliqXmHgVogFNVP1ePL6O5Mz12DmoTU+gXrfRsAEgeja1bPLzkKj7h71Juj5M=
X-Gm-Gg: ASbGncumDrYevnPS+T59xXjo6oKAQzJdesUmTbByjN4TR2/z6Ignr07r8IW8VGfAdNQ
	3UW9Wt26nQlfrJteHeCFt8ntv83ARVwt62WLy75a26SOKE1CvoZo3Ev0lWyU6i08fwINwnECGZY
	W5Gh70m6TUkez02D0AzJlv+b03XCztxYhi7gtJ8KoEw3yOQMOAFDw31ncjZutjBkJsSQTQtk4ww
	HkOrd83Zo4633Qkir6fzgBzxhneJU4zBrj9DS7xqzGIz5EQztvG2nIftXs9MOcQTmLkrF//2iWr
	ZOuPzTRb/XcPj8LAvo1EUDBUO0aHcudoy8cm6CmtH99tXjx7M7/s+sb6SeRxvtF4H5Q=
X-Received: by 2002:a05:6a00:198c:b0:781:1b5a:959b with SMTP id d2e1a72fcca58-79387ff6c75mr23603117b3a.30.1760349854468;
        Mon, 13 Oct 2025 03:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpSRuZwIFsrr+kG3rfjyzZVQNlapZ69eTdIIxj3WusVLk9bzE0CEM/IEmM0jCUHWQCfztNag==
X-Received: by 2002:a05:6a00:198c:b0:781:1b5a:959b with SMTP id d2e1a72fcca58-79387ff6c75mr23603064b3a.30.1760349853786;
        Mon, 13 Oct 2025 03:04:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:13 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:12 +0530
Subject: [PATCH v5 08/13] firmware: qcom_scm: Simplify
 qcom_scm_pas_init_image()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-8-d609ed766061@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=2873;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=mx+8fFZ5SgEiJcGilO58BFpsLap7iEGUEYxIj4lgzR4=;
 b=Omeioh9ujJZWgFZl1SDaFa+qeBQNnmegvgIdH256J8zjHcP025NXBjJnWK3xT5+HbMmdK8Q11
 sSA6MMmp8gKAyLi0bFIsrrvxo18GWsfOzCxXoI4rS9NyOml24nkEGDg
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ecce9f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=fj9IEy4R_8UuhkAraiMA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rFx2Q8qgRALOFRvCVI79Yv5hrfS7baCX
X-Proofpoint-ORIG-GUID: rFx2Q8qgRALOFRvCVI79Yv5hrfS7baCX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8imRlQJ1ms2K
 jMDjSZe8VGY099aQAbJ34nVKXNDY7nTXhF8x3Mep93Yazh+qGjzZjrmTCoG8QbuidpsLR/Amf5S
 7clDuPufSL6m87MWn1/6Var6ne99cvuEvF7sCz/JYikAE253jZOna5c+wdBTa2AmUBhw9nkP4qG
 KRfB1jycaLIP1e12NYedoMv8ltl/y9vzl6FRGxlczMjcJfiOmATFsspv4z7dRkLhyZ39XWnlaQt
 JZE6OF0sBB9QYYuUp1S0Zy/w9Wc1EP+PHtM5gUTs91EqIvCPsiW2Pw9LUAB+St0Y18bK7jF2FFm
 bGFnHWZ9L0JJLlYYQH7fIIuJLkvXeo/RC+wFGwakpaiWFhJK05fbTCM+uYeiXUDzoCvIxHGAS9G
 hDFNJIN3QUgy0kZBTx0ZbIXOGbBzdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Simplify qcom_scm_pas_init_image() by making the memory allocation,
copy and free operations done in a separate function than the actual
SMC call.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 58 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index a66e782fdb68..eb79fceda92b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -591,6 +591,37 @@ void *qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_context_init);
 
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
@@ -612,17 +643,10 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_context *ctx)
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
@@ -643,23 +667,7 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 
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


