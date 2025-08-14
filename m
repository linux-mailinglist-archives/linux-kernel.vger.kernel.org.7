Return-Path: <linux-kernel+bounces-768138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51922B25D80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289B6882B17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7D270EBF;
	Thu, 14 Aug 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUgQ4Ivr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BE27054C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156483; cv=none; b=A47AfwAheoKf0t5lavJQ6ADCav7D0lMUF0bLTX+RpfrY3lLvR1GBjooxg3XbKgxebvGysTGulNA0gdJt8ObcFcovvm6f76m+Hymk2v7idHbBq9wCbnM4NrYQFR84FQ92T9VJtCCe9HyhhASOzOqcUKXbTpAHpF1a4XbIdxhlDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156483; c=relaxed/simple;
	bh=JKE8XeEWQuVBdJspgbbvbXt9TNiZ5M05CMuElgrBmxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlObgmk0MeCnJf0IDm9AUznKRES9i+mwQUJgdmkuDNpr8nkmHkUIN93Rkulw62iSOwanmbgJO4GfwCNhs0vDijP39z9Fndj14EYPJJ+96VCl95VbIjp04YU4jrzkH27b/1fanNvxIV94YZijztJx9MBk/nfBBaxVw8ThyhjMOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUgQ4Ivr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNM9Yu012828
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+aXJU651HYPWpuqmg2nJipq77ZAjPoPawcKtHFM/+w=; b=bUgQ4IvrDXTjlciV
	43sq0fH7Sch5k8/kuq4zSsxxBmnb5TZethLFMDfDE0ahXaa1GkXLsoNGvIUnnEeU
	sAs7NFtbVwIKKA3vNDt4OoEnnzR1mgH0DpXFtxCb7F4Oawv5CqZmrXhXpraMeIvJ
	a/IpWA64bLCV+hknshH6NhxLccN4/691t2CcKDr7wUdjww/M3ZmIx3/wDbEIu0Pc
	HvFc8GX811UcFa1Opg/GJjdRlI13rkY6O9b/Nafa6Hc+XcKKZ2okQnC1i+IBEaFc
	entvm9yN8WpU41JscY+xax5W6nxrGRxMDALTqrlRXbp5cXWC4iTqHfLpgLcdxRto
	AqUr0g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxcwve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:28:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445812598bso15115865ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156479; x=1755761279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+aXJU651HYPWpuqmg2nJipq77ZAjPoPawcKtHFM/+w=;
        b=pouJqopxByojHoCung+NSFaDdg+ueYFu17UkJ9R/rI6XTU9PSik4a2gRtaNDMvRp6R
         gJ2T5VmUYFVBrOEGDMpgwO9LJMU20qNvWhE65ZL2zGfNwWiTQ4RO0ck2kqeb3xsEdLxB
         a2rY881u4ELLKQNaOX0SYjSvbedkrxjweTtD3jHyUK4CWXE14RD8t502554agze0u/P7
         GaHgWD3a6o0X9qXEWALJkUx88spaJ6zvJmw5piMAUwJJj2L9vxm0nIgkyksBd3mrmhgS
         hWcEJ3MfMz/fMhXLCQ7VWUiPIG1F3g+2tlwz1CuqmXNUFa0KUHB1NiPca7OhyrDKcMmv
         yfQw==
X-Forwarded-Encrypted: i=1; AJvYcCWlOY6oVjjVxFOZjYq4yHAqjSEcBfwZxxdp+y9vle4/oMdOVuvK1GrFBYhHDjRkbzeHHOS4qZCqRhxFhe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVKhZjhwt7wxvFbua0cJLaBrFM32PeQeaouos8LM4WR3aHxpi
	h2I7sm2Dp5sNtfByPFdeud9aSZ6wvbcC3vgbGDbgSuBdO+ETfUp+2L0NMjfAGLMS0iDK6K7Lm/g
	qzdmSKsyqeK09JGQFNevWS94eu8T4OU9/wwz0RitEOu7Ity71fv3z7j//m+hPE7iktTBRvwrwL4
	yMcQ==
X-Gm-Gg: ASbGncvnXL/CXY6p34sVEvti8ztbfeo/5On/4C3VzJ5AXLH1cNgg3ELTZIiM4c4OPt3
	99+3EbkSXJhEttVvf1DD02+cipOK7C2mRF+sXRbPdFpYuCg1mw0+iPyQq5oaOk/2ekh4YOQyk06
	xY7IyRRn8J/EdYgMvvv3wO2M1LGXo/rJk+mYCW4SGBbQif02L9fy4wEEifdDxOBRU883gBjHL9U
	OCFUeDk6XGtB+2wnguywOz2KyAyrX+VG8sN1+RgTD+y+smfwSu7HhSJN4D0AE0gXVAofJlWa9Nf
	E89+qfnWF+SAI0pJl+hoOHp/exc3dB1eqraAQ0kW+eR+cWpP2/fFXU88JFIfOZfx8of/svZPo5b
	GaH4VDBzU9wR+N8iJq96/BF9TVAYBNwHpVQ==
X-Received: by 2002:a17:902:f78c:b0:234:d679:72e9 with SMTP id d9443c01a7336-244584b44e9mr27812635ad.12.1755156479481;
        Thu, 14 Aug 2025 00:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6pRhGLFcPGP8aOyg99NqkjVLCBppmn4RqtM8WYm5//M26hmWOmdLYptNmAgIsnvx89M8FqQ==
X-Received: by 2002:a17:902:f78c:b0:234:d679:72e9 with SMTP id d9443c01a7336-244584b44e9mr27812275ad.12.1755156479023;
        Thu, 14 Aug 2025 00:27:59 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232f8c8e4bsm535458a91.2.2025.08.14.00.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:27:58 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 15:27:28 +0800
Subject: [PATCH v5 1/3] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-hamoa_initial-v5-1-817a9c6e8d47@oss.qualcomm.com>
References: <20250814-hamoa_initial-v5-0-817a9c6e8d47@oss.qualcomm.com>
In-Reply-To: <20250814-hamoa_initial-v5-0-817a9c6e8d47@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755156471; l=1233;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=JKE8XeEWQuVBdJspgbbvbXt9TNiZ5M05CMuElgrBmxc=;
 b=5WuxaS3gE8ZTN7Xc4Hi7Xh/J9zRwtSs5MpD6NKLboTRCJdnznNe/G4xBrpU5cD4pq1HTxjVJb
 rXrTK3k/6sKBiFQ2CetL4gZo4DwyEqoaT5IGjpu0YnaaxDYqLt+RhsD
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXwR6evecUIFUC
 kidS674QwBfOimFbtZEFej/3aJOy5KsLbNL1+2HJE8i0vQfhxkm3UTz/AKXETe3pccGjMZWqxbr
 DZ29uMyyY5UMoeuV5TEjOv1cw5Age2GQvE2RG956MD931pL7uUwPQRsXkUb09fLBJ0es3mEYXTq
 RulnkPJXNLrmH07jGbIQp03Odj4hMoMlWzXAwp+mIuS/xNr5OMzJnIFxXSfCXVszc8eFlnwb00Z
 HeoVW9pdaKDAJs6xpJtpGsDETZfOZ378QdRGBA239iyCPsefgB3Kukc/8fjHvBZb0X3Os81i35z
 1tb0UMk0bZ4mDFYHzbFMBVm1dGaJVfKEwEHOupcIkeZaQaz0IP4/+GBjbOrrZfG6M+u1RqpofPE
 emmRnAq0
X-Proofpoint-GUID: vwMW2kCWYwpHj_TeIbOzsogeAHLzBJ_L
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689d9001 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vwMW2kCWYwpHj_TeIbOzsogeAHLzBJ_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

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
index 55e5eb75af8905c93e6604d54d516585f70a8e29..6b6503181ad6f2e4932a52d86a54c77e7fbbac9e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1069,6 +1069,12 @@ properties:
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


