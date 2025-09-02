Return-Path: <linux-kernel+bounces-796703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A28B4061A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420D11B24664
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998F9307482;
	Tue,  2 Sep 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o9MOadRl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456E3019C2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821666; cv=none; b=qHTva1MWbO1mNNDePb9hopx6i66FTaAICimfIO0HYo3r67/kt2sfk2bhnNf2OiHrzOPvqtQwYkZtSB5fo6j/gWqlr3s18KExTlUl9axH5Nz/LzHk56dACMIH66osLJFcWjE8LMGXBt8iGfung4uOit7PIJHEhuNXJOdXsoMry9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821666; c=relaxed/simple;
	bh=LA4VFOt3FgY4aF9ZxXhKK2bEkPtHjpqcJQqusSBl6Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DS1XT9Qjd+U+KbAo26uZ3MUGLVLWSqBp9g1q3TiOA4yzODdMEfPsvat57UfqDVuOMSvkP1KDim52JYAJ3DGWWHSXh/5GzfyNvZWUeWvwa7lR5j8r/xLlRiCa5hgVYOpiUb/OA/6tBZ0/lZsp32V9LZiIEkpIAHFY1rJLB+Iocq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o9MOadRl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5829xL1i030613
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4nUrsZtpHAT
	W+DRnY4OX8R5uwVqSv0TAiSweK0q80FA=; b=o9MOadRlWdllZshToc6EHL7ZNdM
	vsBYKb73KcInqDN61sc0lKCayFIbMYuMaA+AAEbbrduhGdH0jFVHVw6ukHdB4qVH
	buX5P1t9iw0qiyuXtd6a0Xdw6YF4xComRCnJ5WrgWkWR6wXMdw6ufi4iALNm8GEy
	X1EFASyQcyQHrUP9UffC1lSZ9o2JeMEIRGZvb3Ysbyxz2NeMTFj0FejaSA6evpP6
	UIBZDSF7uC50TV4HlVF6u4RgsOYn7rKHtLdSFsk0/rqtrIf3gVZQAn9nBNEjS1rB
	iosP8x8mwq2NbyRqcralEABgpR8EPCdbWXr/Uqn4losO8FmXeQ2eVIhnZcg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8r08t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:01:03 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54499b68d0fso420157e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821663; x=1757426463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nUrsZtpHATW+DRnY4OX8R5uwVqSv0TAiSweK0q80FA=;
        b=rwDziBaPqPzDqbHIf0VhlEkbFvPy9hLanKqCPATbzG8bvTgQL3f3sLUmKhnhpQcoN4
         PT3xuXY+GgXAHfivuMRhomBavk/Id96SCyZQJvAT9CGpP4FljZxSEw0nKofr8bz00H20
         DQv/CHtbmxCAuCZI3gt33lS3sOhU8x7xhlqn01bawQ3FM+8/pfGQeMC3qvfLaVfl/L0N
         O8uo7IyFxBWVbKpjLqkyDml6wwvFie7c0vxa0OeAtErK1S7oiFBidqcCoLYORC+UVSNS
         D3jz4TPPpV+L9ONk1UYDQGhCq6H/2Zh38lacJiexeRFauw6BHmFw1ypzS1j/k2fc/Ftk
         2/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWE9WcIWYwMK020G5msh0N3RQtfLj0dYBW2900rVmA7lmYFzTwNDkGcViZtpiuXeSYYDvmKvEbe7Ed5ylo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNgfgIvjsOtEoEwhcGWDJdzfpgcuctLnic/FP3bSDgPkl2yai
	oPlzyqYbu2MKYCVqqeHroNXqA3XmchSY7abFpGhRKk4oS2YNtF0xqYjeBpS3PD4Sh7vw3vB8MrA
	tnhKnbWWLvVxzD/+HvWbQYHvrtg+pZhebYnU+le/q88+0Km3jwq6m4MLJZXtScyeJ5fM=
X-Gm-Gg: ASbGncvLJwW9W9l7lrfQOoUXoL0nRGCdIlKWjtoSEVyFLsZiCUZCEy1eyJpy/pmROY5
	1vAkgKaNJSlexhCTuOcBXPq/UAgKzeiNQ4+SZ16dWFkqAxcNr95CwRv1HvT23EUFWLojdFIdi3T
	kKjOQZLA8LvXUR/8EPrDybZY5HClUXHppinF3vJ7uBmpinLxEKA+nvXPFw2duedHEfl7mycoent
	HQui6wNI0WdZF/OQrbYmpXtL/MYEGTXbSwP/YrI+h0d3XJSwLqZo6sz36Q6yGRqE7uwF0zEky1k
	3jrkSkzMwEmzBcnJBRuyv5y+MVT0ZFCnD3UpwGke0HkDWnPnjliazQ==
X-Received: by 2002:a05:6122:8c1d:b0:541:7a56:4c74 with SMTP id 71dfb90a1353d-544a0306e0cmr3436139e0c.13.1756821662586;
        Tue, 02 Sep 2025 07:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLTYZ/QDb/Ck1fRw3jrSUnp8sbm+lDs1zmyvi4RAl2+EBFuGiMi5sraBYIysTI+XWrBOe6ww==
X-Received: by 2002:a05:6122:8c1d:b0:541:7a56:4c74 with SMTP id 71dfb90a1353d-544a0306e0cmr3435884e0c.13.1756821660065;
        Tue, 02 Sep 2025 07:01:00 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm14381196f8f.40.2025.09.02.07.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:00:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org
Cc: conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 4/6] ASoC: dt-bindings: qcom: Add Glymur LPASS wsa and va macro codecs
Date: Tue,  2 Sep 2025 15:00:42 +0100
Message-ID: <20250902140044.54508-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AX0K7cmwdLulmKxtDiVDTHI7sEbUJBPk
X-Proofpoint-GUID: AX0K7cmwdLulmKxtDiVDTHI7sEbUJBPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX+DhO0cHnzxiQ
 nA1/OX3WdzllxMbXmJfU0ujbU7PV/q9fSK2vDLfIHYj55i3k5l/dMrpIo97s71g5sb8FonwLllb
 7Ze3yiAmJUESTUREyQjtZxTnaBxvNl+TxyjeyONyC/XpQ39TfNXklak46Ngtpvlar/poyUdAFEH
 a1ZVZCKfT++UESHDW85rUjlTI8Own+WAQw4pl0/Njj0MbfZPdSuz8a3QABGB5SmywPv8WbEQ98J
 oE0auOgmtHJghOEbl7l6xkKjyRphtv7IVBQg2aDbtfUqXpV/zK9O2fmB6FUQZgEHsL1Xp041Vbu
 og8oFIK+eqHtedL5NWX4EyJfJ373w92bjQ6YhSE7BGlo9Ekqs/o3p3nXCNFWZaezJtfGLIu6su9
 TJ+Zj0Qr
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6f89f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ZPdVxaYzjB_9TeNNi-QA:9
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Document compatibles for Qualcomm Glymur SoC macro digital codecs
(VA and WSA), compatible with previous generation (SM8550 and SM8650).

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml | 1 +
 .../devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index dd549db6c841..2e8c26d89b00 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -20,6 +20,7 @@ properties:
           - qcom,sc8280xp-lpass-va-macro
       - items:
           - enum:
+              - qcom,glymur-lpass-va-macro
               - qcom,sm8650-lpass-va-macro
               - qcom,sm8750-lpass-va-macro
               - qcom,x1e80100-lpass-va-macro
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
index 9082e363c709..b6f5ba5d1320 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -20,6 +20,7 @@ properties:
           - qcom,sc8280xp-lpass-wsa-macro
       - items:
           - enum:
+              - qcom,glymur-lpass-wsa-macro
               - qcom,sm8650-lpass-wsa-macro
               - qcom,sm8750-lpass-wsa-macro
               - qcom,x1e80100-lpass-wsa-macro
-- 
2.50.0


