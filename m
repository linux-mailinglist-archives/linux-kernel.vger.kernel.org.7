Return-Path: <linux-kernel+bounces-811929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A79B5303D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE63A0881
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD13176EF;
	Thu, 11 Sep 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwRPrjMO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A931CA5D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589865; cv=none; b=jCeFViI6+Z1cGnVNvxrelArSYcs1oFs+LpSKfkcOuiHRddkFeTgFHKTlNmcxot0a6g19ZBVe0/F2spA6mx0XR4FuYuz3sYrO7GXwysPlcTMcAqOnOIMztiiRMPOa7ON1ApFYAt310KSn0nVs59/qZVB93TT1MXYzD08lW7aT2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589865; c=relaxed/simple;
	bh=fxALVBYM7qYW96U/dSw79twk6v0y6XKjhtJ/F/CsPC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCXBZquoFgqcyWrJk4zJTfcu0+cr9Dq+kW4yC/N3AajSviPj+YwORB3aQcgYRZBdADlwnBXSVP4Sd7wIw3d0AVV2hhbQi8kMDGNswTXVfe3AEHuha6hGX51p3dFYvlcIxt0zUz8Jc/nG0uuJwGxEPdQsF8aBB9yHk8DtAE0ROHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwRPrjMO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAtnes006978
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IzFssouc9mamtc9gsC/kHechOIc88AvDywUnbNXgus0=; b=hwRPrjMObMo9ewQ2
	bZ2FRPfklMfCBgxcNDuAMvSOQJEL3OMOZlMu22wXiTQ/Pz0gaSk3KdaFtYdjMPjn
	BM+kYpzsBf2pGeklKaqK8OVdsf38EDkH9ghLHcrgiNadZ5msZEtjFvKhP/Y6vk/Z
	25J3im2pggNKTRSiUHvsM6VM+4tTDeLzfhoqOks0xJZNWMvoaBadFD8oDGSjXNpt
	dcBA8rPJ6whZC+LXskg3pisw/6FUnvUrP2OfcGTD+DmObqhRGbzbluS17JGj2xEt
	vGXGHkkUX0/hbwcBLd/elrGPvcW7DSu7SNfaRPtCYcpIftlluAxDOeKhdW20MWnf
	az7yxg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2bexd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25c2a4c20a2so7345735ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589861; x=1758194661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzFssouc9mamtc9gsC/kHechOIc88AvDywUnbNXgus0=;
        b=lKbANjMW9iuvizRN2z4mIKxMabg1X6fWjFGG6Dm8MSlu3l5WsDPJqgOmy4mSuzvnAc
         +5pp2Fw6K1uIXGyJbcZzFtjAe6TzEb1U7xZDNUvoE5shZjrCtU5jD4IYbXQHoHS90n7R
         nF+PFiFKkZXgBvGnK26dSVw43y9im2mGR4vajEOjemTSLFXbzsLHtbRFFj0ayuUzCzPA
         dKGwFnSd/ID8LweTZIZA5yoSFyIZti3Fufr4u98CXY1Fpp3uT/ZEo+S6TTSPyRAYlibo
         vU+n/rfiBSW0e2gFhFVXizkJXs3fLBuNeBmFtQDDuTd8UX+DYYUCx/TABUkbOECqt9R3
         W4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHEN5BILHGAMRaiYKXYLFI9cgc056rPDchPN30Tg9p0pw2uJpWxm+psU72g6IKcl5YjNP7BlYGXj0esog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vO0EeW00Plgc1Nm9FdGVNh1rglOzFuqTbWZWZyBUroC3ENNL
	z1L0N/huY9Fo0q0XhDD01/kFAGCJOBDSBQfnRy9arGvF1p9oxAlNK8s0y7ZLo23ofRxHGJiJL9x
	lWGz18ZRCEZjHPHNhItotNEqFQJub0E45531boLR67tGnwEeFpNzOkDoq6KKQB1et8hc=
X-Gm-Gg: ASbGncvaPGBo/8AWFA0h32IUN7gL1HfTQ9o6kQuif+znGlTRdR924lMIEuEnj5aHHc+
	7grq6S25Zii4lgDVQLUSgj90F3rv5ikdQ1hUVp/d4z6FjaGyEAbsS1qgPeV1FWgpIL1qsVmbzxm
	gffhrFJHeCNlqIjQ/P8b1pSV/HjYE/uLEUygxpjYOVAy1LF0xF99eET4JYCrQggv642s7MAIFNs
	ep6jerlr2htVx6fBPBE8/cHtueCqFUuP02hpVda4mNfOyOg6802/9aorRQkhShYnuoOc2UubSXm
	PJguz8lg9fRCDl5WbhY3tGzypZOIhjLFaYGlfzfUmerbdrCjDCU7gUbVsBGdGlTr3FQAdLN/0jO
	kkam2NavQxAV/dpcoUUjPH94oYrtUshOo
X-Received: by 2002:a17:902:e886:b0:25c:a9a0:ea60 with SMTP id d9443c01a7336-25ca9a0ee09mr5664985ad.42.1757589860746;
        Thu, 11 Sep 2025 04:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGwhy+ThWRQzuFVTo3tgTP57p2T1jMEsKjOoHNoY7Em1lQydlaLgExlKlN33CpwQLV12SmqA==
X-Received: by 2002:a17:902:e886:b0:25c:a9a0:ea60 with SMTP id d9443c01a7336-25ca9a0ee09mr5664645ad.42.1757589860248;
        Thu, 11 Sep 2025 04:24:20 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b17sm17005365ad.40.2025.09.11.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:24:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 19:24:01 +0800
Subject: [PATCH v12 1/5] dt-bindings: display/msm: Document the DPU for
 QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcs8300_mdss-v12-1-5f7d076e2b81@oss.qualcomm.com>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
In-Reply-To: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757589847; l=1242;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=fxALVBYM7qYW96U/dSw79twk6v0y6XKjhtJ/F/CsPC8=;
 b=5XItcEhzZr/Ql1Cbibe/YCArxvl6ARnxlQ2S6RUK1cWoBIjKyauD+Eq+u4y6FKJtpzjf/gEjm
 RCFyyfO50tzC4Yl+qv/XfFLb8u3DpagmsLf0DbQDSM/if3MSmoeMw5X
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c2b166 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=0ru3Ub4c0dYyKLRCKckA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8XdsZWYoh_2I045dhsMvG-gkZAVlVCRa
X-Proofpoint-GUID: 8XdsZWYoh_2I045dhsMvG-gkZAVlVCRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX1lesvz7GCLE6
 TSafiQhNyH4IZhoLOtN87Vy9NwwdYLGdhNA6PNN1VTsSUT5rS92rARcoIX745HD7cJnktKmyf0L
 FhaJLzoG0t3rgUxfbJ6cdeW0Sq/NfPyJ5+BpcvsklCw0fYkYbj6Nly6P4RV9SieZbUxhRA906cK
 CtI6TjPhcm5eWXKJUCHjPYAf3wF65cglc/hayskiclM632iEAGXw5DIuvtEbOPgwVzmUNpsnBWq
 6fs3bR3hZcKrbpP071MCSt4AaqIQKXmNJt5rdaXxhY5zMiNtxClAw5XqcMXVn7HabmiBHtKX9Kj
 kj0YFFZRoyc6gMsie2t+6anfbi9RN7wcq/sTGKZGDr4OFmjoMkykwLIC7s2sBO0bPmWukmst72N
 TBbIV5S1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

Document the DPU for Qualcomm QCS8300 platform. It use the same DPU
hardware with SA8775P and reuse it's driver.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 0a46120dd868..d9b980a89722 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -13,11 +13,16 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    enum:
-      - qcom,sa8775p-dpu
-      - qcom,sm8650-dpu
-      - qcom,sm8750-dpu
-      - qcom,x1e80100-dpu
+    oneOf:
+      - enum:
+          - qcom,sa8775p-dpu
+          - qcom,sm8650-dpu
+          - qcom,sm8750-dpu
+          - qcom,x1e80100-dpu
+      - items:
+          - enum:
+              - qcom,qcs8300-dpu
+          - const: qcom,sa8775p-dpu
 
   reg:
     items:

-- 
2.43.0


