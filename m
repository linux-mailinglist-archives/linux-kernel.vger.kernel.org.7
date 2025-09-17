Return-Path: <linux-kernel+bounces-819911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A66B7D5B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C3F527C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942752F6590;
	Wed, 17 Sep 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q88Bzkzq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1782F3C3A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077980; cv=none; b=gNTR4xWTkNdLZpONlH8JGkHy3OXVKczT0OGgxcxyUZUWA1nIAqYWqDOVyU9kpBo3gUbgcRQJ6Md7M29AhjHGL6SSvVCcaHkWHQorQaSm1fRRE/WSWBIdYmTlnmQXP5blz0cO6j4Wa+TfaCY6Z5yLZQzrc+1lL60gk2M4ivPZ9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077980; c=relaxed/simple;
	bh=lX+aFOuo0M+5Z4gsdoy2HlRedwm0x/VuIHnlk7IpHjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5ckaA2/bRCp30GNoS4v7mwR4BouPgfR3lIsFNqg0Y3OTNMWj2oy1vg4+KmnW0LEdqlaUAOhaBK7mHAVFOwlsg8mLZHIHxBPVLaw81aA3scnLSFQxy0CtJLFG2bwrGgrZdBl7x/03FiqlTwlJSGC/6MsRLrJayI0U09dCl/Byd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q88Bzkzq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLaIqw020971
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J73DgcNzpD45nknt9+JgUGgYXRHaFEjWhkJ1fzz24p8=; b=Q88Bzkzqwp7IMcJX
	ilG4VV9V49lr7mKxhHTX+NX1xXcqtKa1sWCglhUgwOdyEBpj2KaUXZDm4Eo4RVlx
	Nlr6N0aXwngvF02DvFUDb0aE+cZ/duyqvuRELYpOuGFN8JP1OO+9M8HS4Vo167ia
	uJZyqkzYpTpdEEASPM1W/XdhKIrjmfGrNEYh2+M4pvcG97ILWhOmMkAGlwYGLQty
	vWoQEORoSqlcue/H7N+I8FTwcmsVUDwk8fkenHS0ZEOuLulicAXwCHOAZm3NHQg9
	CR8AlWDTy11f4YuVeWalFeH6mqtqcOUNDlq4zvRa3OaGCH8we8RUdpI3WTxGWCAE
	99FW8A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxygnq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:59:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32e43b0f038so2508834a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077978; x=1758682778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J73DgcNzpD45nknt9+JgUGgYXRHaFEjWhkJ1fzz24p8=;
        b=uZ+ASGx37DBhz/aY3fFmzFxXxuuiHBJDfNLinTdauCECkjPbd6pVugBL3o5wzUI0Vl
         GrG4iMdhvtxKOrS3WmhMZOJas/V4yPaXALFbD1o9gU3IniVfcG0xA3bV1rI7E933Bg7T
         yCB4JOYeCYYgmV3314x+6/yyd0iYJewGbyGecQLjBKs/2EDDUkYrEtKU2pqLjMWhizld
         S/xyzYVqaGytOX1W7+1T2Eu/ZkF9jYe0bxG641oZYbYDloz9xw8x/Aq161+3Gv47o/Eq
         b76nrXjG6p53ufFHk4UkUqtkj2nlAy7xBbp94KFcKS/p3JKxl5Y7ZcBRMbRaCpSIId4B
         lRvA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Xakf9uD+C9o7Bay8/txF1eynnrGW5HNjfMalzAgNO3IQitVE442YGCMllERjjYnVE3fa2uIANiI1FGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwoSJSrFcGbds3pFs1t1QelL3/au0uVK58ZzlZvkrG7y9YNghc
	3YQgjHCKgYaPssXFlJf9aIAWX3ZgblNb38TSzoqB4vrY1muBHppqnx81cJZt6Qh5GhPlRBx2Yz5
	VGD7FG3jZ6cZWyISlvX0lwf4hG6rfk9AIcgwxCsLfIE0MviOX5w9JViAxZiSFA8SPMQg7ZlX1Cn
	dbhw==
X-Gm-Gg: ASbGncv9PA2Vy5Ja1QTkqVFZJx/LNYHT6fWnxTRknjs7stw+iouLEmplCyt7Podm2Q6
	Ht58HuLfeLmsrbmJzhF+voJPr3tDx8NRBI7mU6PQhz1/dziGa5oDaIZLP9QGW/P/9MfMMkxxiIX
	NytNZjcZPBVYSv5DZWGWXbJTwqa4MaFM07NERwA6YbaICKkQAjt47SjsM5e9TJ5Vv7QFOdoVvxR
	H6A8g7y/begrexwhDOjmjVxWPKDOIy9EmiGTqv0Yi2wtSvGXuhiHFQ69gN32thFIgBahaLZObdO
	XiNVd7+0En6K31wNCwdDokdjjwyzW/9ZbMXd58XDLE+cf8yo5aYBV3OrJ3mdJz1vA7a5w2yEcTi
	52Sk5jvlQwYUMW+jndjKLJOqWSOZl9i5phA==
X-Received: by 2002:a17:90b:1dc8:b0:32e:7270:94aa with SMTP id 98e67ed59e1d1-32ee3f757dbmr833806a91.19.1758077977639;
        Tue, 16 Sep 2025 19:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnGbBYLI1VpGLROJJo5/lrnKLENDGfIKa2deKoELg1rKbDBWlsEcJHbnT0N5W8AIChaXTnWA==
X-Received: by 2002:a17:90b:1dc8:b0:32e:7270:94aa with SMTP id 98e67ed59e1d1-32ee3f757dbmr833782a91.19.1758077977209;
        Tue, 16 Sep 2025 19:59:37 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b45d1sm15481872a12.5.2025.09.16.19.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 19:59:36 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 10:58:58 +0800
Subject: [PATCH v12 1/3] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-hamoa_initial-v12-1-4ed39d17dfc5@oss.qualcomm.com>
References: <20250917-hamoa_initial-v12-0-4ed39d17dfc5@oss.qualcomm.com>
In-Reply-To: <20250917-hamoa_initial-v12-0-4ed39d17dfc5@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758077969; l=1177;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=lX+aFOuo0M+5Z4gsdoy2HlRedwm0x/VuIHnlk7IpHjg=;
 b=+pQXXFOjg5w6p1p3IIjDsyVsLw/aLhJ2D+s9uwo3/k0wCLTG3E+gEY3FZg017G+YSmIlSdbPk
 To9CCqcmlE1AhvHo/BfAa3KridvQZGLJ0JXH3eJl1aLYYW/f3pMHWxv
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68ca241a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2p1CTdZv-0axJWCf8bs6k8XRxBoGxXEw
X-Proofpoint-ORIG-GUID: 2p1CTdZv-0axJWCf8bs6k8XRxBoGxXEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3GWHQ3QeU9pG
 LNft17VSmRQ69icl2sHBCIephesgICpNRd0lGvu4pCnTkdRVZ9T7fmwP/Mp3PtUIWtNJblUgI2o
 cfzuyXesa0YOWG53gCuP6eaFYkhXdPFHN86ehmjzWki5kaNnbUh72nRdF+FcS9D9X0Cjf+Sh/ks
 2djsvPm+mhZVo1w/VSzWOt97YEO5m6z4tiP6+rSZFljYVGuy7LCEn5BfuqmNnshaKV6x/SgIqTl
 8JFC9jPTe4rSUs+0rB/lu+ysTWqkT/+sAZTUe7gz88c99gO9IFfH6TKgf+id86GyX4Sz960CeTP
 L8Ygbsshp1eaBaKt0JWpUSF+mlalCti3NqmRskrsOH2HFvEtUDHlb2JkzZVmpF4OnsuikpUi5R2
 g7KNW1cR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Document the device tree binding for the HAMOA-IOT-EVK board, which uses
the Qualcomm X1E80100 SoC.

The EVK consists of a carrier board and a modular System-on-Module (SoM).
The SoM integrates the SoC, PMICs, and essential GPIOs, while the EVK
carrier board provides additional peripherals such as UART and USB
interfaces.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0a3222d6f368..349f526df35e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1074,6 +1074,12 @@ properties:
               - qcom,x1e80100-qcp
           - const: qcom,x1e80100
 
+      - items:
+          - enum:
+              - qcom,hamoa-iot-evk
+          - const: qcom,hamoa-iot-som
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,zenbook-a14-ux3407qa

-- 
2.34.1


