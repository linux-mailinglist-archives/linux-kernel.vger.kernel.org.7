Return-Path: <linux-kernel+bounces-831462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A718FB9CBBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A32317DF88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1F82C11EB;
	Wed, 24 Sep 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YT5/si8K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84529E0E7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758221; cv=none; b=M0kYRQZVsINBY3T/HDk/8zZNfERTxxaHQgI5OeRI1Dp04H8HlwjHuYsIRU3zQpr7oW9Rz0HaVbx8JIMUrxzCnwsyJTAol12h+XTSuC5GcY7hSmrmVrpV0Q3Q37FB6I02JcxXYcPUtgyvw/uhfyIluDaA4QpaoGi+4a0dwAUXiqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758221; c=relaxed/simple;
	bh=KD1EikTTBqRd00DRUm6azbYoSdAWJCoveXe8AIbfrJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lq7hUhyQv+3xU/0zmhQd5+oXkIuo6oUoTSLSSFnXttsv1JoBDJ0rJLGVO2nWsasPnuFv0gjOxIgrXzriPpYgK/VUbG73+nQkBBo6fP1XVb4/cgAGrfIFFdGYtr3LnKUwHFSUK2rdXzQnM2JblPYChmCJ83m3v6YPwCelw+ojxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YT5/si8K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD4ca3028199
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	isKEQzfxss1sYjk64yoM6hVVlanKUUPiN0aW5OP9ozA=; b=YT5/si8KhXNMZX2T
	aHs1Jv20X4rPpSuqJFJQf1wRMpf7N5oYFWcKaga1VLr4NskpsTnN7trpywqJyUeQ
	bO1R5lWKu4yUaGpnMtQKRswLPX27qqvAOFW3iy48VNvpO0I6DCFGrp8EsW/bfDx5
	UeOgnTNtuaeMshMVREFEMq+tR7f5ug23iKFmvELINIwf5WWaNHsrJZ9/Is/qS3sm
	IfC1XSdYRRrtdRZWNUFqeS8NMkMpYgH1JbbFLZ+wTrhpWyla7tGtIGEOQ0oYfQVE
	fNeyaxSHVp9k1hi9irhTDhXoAnuSLBLUqpcOrZ0f69tl+K+5Sew38MFgAzsBKmN9
	z4E2Ow==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxes6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:56:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6ee6so3555315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758217; x=1759363017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isKEQzfxss1sYjk64yoM6hVVlanKUUPiN0aW5OP9ozA=;
        b=P2UY0kVm8ZE3vENNiKscL6O2E7196x099DCVZrCeZxhGQQJvvH5/YNNu4Wtz3JcXpJ
         pETE4Qrtd3P7VmjTGwc3ICpvPRxARlGFo53C0YDAAuxRzQ2X16dz5PsV1Aa+7AViJmFe
         VFUpu1LTAHqONM0z6U3AJ73k7EsvA71OdWhU+aELZlc2G8RrdDudCB8W33IdtPTkqQKP
         o5iBkqqhJBM1HzXqKk0OmKsx3koePiSLEjjlTqw5EXghZeH70P4LP5B1HLwKTgwQnzYU
         aU44ZAFZpFso3N92apJVvZz1jyh46+xeyiFRy9NifneZcxueloswClzc11B1Fq8ptuKD
         /Mbg==
X-Forwarded-Encrypted: i=1; AJvYcCUCQ+ghiogNHXsAorz/2xwkefiR+mTALhwTbIMpzKcdmcSONXSrctEHHHWDyzxMYcOb4w/RWoWmMCQ2i9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXe5AeFTiDxLz7ddatsdgq4k4xeegHfSTj16gfwFRn7g1Ld6j
	2QQBrSdHU4zcdIu6sTMa+HFhHiwUkSRnFuN4F0yBodIrrK1ZtEUDil7wCaD637q9hqtZCQ8gLun
	XeypmAsdamvAG8wItxiSD1I7hLa9xIP5AxVLMa7MAoXyvF++jdaB8LIPnMIElRE3T24U=
X-Gm-Gg: ASbGncuiwiiWNo3D1346xq9Yd0zjYFRSW5ZXeOBWd/QC/lb6z6HRs6PznEi+krhcmLe
	5w8zS2j91LO78qEEUnwahWTr7m7m2EjVPTFn4BNO6v2aSz21XkouXRZ4QO58yVLrAYC/Mo3j0uL
	USlb29OSmjp/A6Kwx5DwVW4xiwEIjxtLtavoqynplkRBTcSzahBNFIqoOqHL/SCqJZecms7vZes
	uH/S6+HWy19dZLAx2Q1tb7kutch3NF4OD8wr0OioLvNBJtP5Nj4rVQWI4OXJTQyeRqC/Hd9j6r0
	sq84FGinGxlRdeKgkKhh5bp/fDXe5hCsJ9H7NYK6I9cYICUauxmgZR8+e0MgDH3nrMlolADVbAv
	DVOwRPCXpwM3CTbM=
X-Received: by 2002:a17:903:1a43:b0:269:8072:5be7 with SMTP id d9443c01a7336-27ed4ab368fmr13745345ad.56.1758758217260;
        Wed, 24 Sep 2025 16:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFehxrPaJqcD0zoFcP93jMpuoqnmCDC66PekYT5ca6v2kR3j20bFF+ZvrXw83kR+NSWs2aNaA==
X-Received: by 2002:a17:903:1a43:b0:269:8072:5be7 with SMTP id d9443c01a7336-27ed4ab368fmr13745185ad.56.1758758216782;
        Wed, 24 Sep 2025 16:56:56 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6881fd6sm4557185ad.87.2025.09.24.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:56:56 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:56:43 -0700
Subject: [PATCH 2/9] dt-bindings: clock: sm8450-camcc: Remove sc8280xp
 camcc to from sm8450 camcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
In-Reply-To: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758212; l=1045;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=7G7QgavjnI2PuDqM9mUeILw47Kp6A2VPBmjnh3LL6As=;
 b=Omu47EnR+bgkxUUTbhFMWZbUJ6KHgo0C4uuRJDAgZ109au6Ey0JVTAUiJWM1osKJ5naM/Fl1e
 xl9N1vYgizlCbxAb3FevdwA+lT6Pr52Ad+E6Yhe12SYq+lpZg9pSYPq
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d4854a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2bVdrMdO9wEKqzfnleYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 0fsJ_ckaC1T8yrtC42_JkObCu9AnFwfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfXxhUisTicxhfc
 dZ0/FVmwqfa71Ab7ERomvUiMjA3idlTlIsIa0WuRbfYKmJUJqAO3XnvpeRcWyfzCrgnJkItzIGT
 890RGtsTYxZXJmXe33Q+PsBRETWhT4KhXak63XQCiI2vN51ym3zHQyl4/Nc1272XtTst8TZVAaM
 q0ZEuWDqM7ZQHuiAt6btCR11bilFMtsn56ANtDz6/4SXVuh08pPNNMWNLdu/P6a3n6zGmu39GBg
 8oIv5DDUnCT6E9V5DzIzOz8zzYVYXH3RGlKUydkQIF1cZtHNmzLF3PApg9bKWnPUp6vs1EGQgph
 Hi+qIGal59643OO6ofOQ1tff/nKnjvmNaBOzqSJpdd49fXQ/Fqju3xZGSrQpRjgctJvtP7SPX2J
 7z4nOAq0
X-Proofpoint-GUID: 0fsJ_ckaC1T8yrtC42_JkObCu9AnFwfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Taniya Das <taniya.das@oss.qualcomm.com>

SC8280XP camcc only requires the MMCX power domain, unlike SM8450 camcc
which now supports both MMCX and MXC power domains. Hence move SC8280XP
camcc from SM8450.

Fixes: 842fa7482915 ("dt-bindings: clock: qcom,sm8450-camcc: Move sc8280xp camcc to sa8775p camcc")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index c1e06f39431e..dbfcc399f10b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -63,7 +63,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,sc8280xp-camcc
               - qcom,sm8450-camcc
               - qcom,sm8550-camcc
     then:

-- 
2.25.1


