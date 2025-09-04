Return-Path: <linux-kernel+bounces-800208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C206B43489
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41971C80FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF902BE622;
	Thu,  4 Sep 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oqUBqmAb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAC2BD029
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972156; cv=none; b=W/FCuDZXtPzkF2FMLZ2JeQkm6xeSKwjN8RX4/0klvPnj/TXXYt8kBX2JFuBV6qUto/gaXYgN9z2jUH0Q8n8UcGFAmSUU5vAlMRq1FLTBwsg1P/XfHDW/WWpFUiv/g3QJHWAGjnG6BXB6OyCAfGGfb3jcDJcLJUJR85CbGMZc8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972156; c=relaxed/simple;
	bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BcNqxabImDAFSrBzQuaNrz7ZC3X3LALiF5Qp/fEFmYjW8ookHwW/qzXo0dE1uNIZ4Dan9UufExD4EQnJ3u0rVKFbkxT3wuQVOX82PpxgYLmQHW9v4+NSVD+dm2VK4++V0DPqdR0F0kCGBmcephkpiqx7HxEWu/LXcCxMah+eGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oqUBqmAb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58416Cpe003430
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 07:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=; b=oqUBqmAbYvjzY4to
	H2OaZVo+EJMQndkcmMiujq+3+/CLy2NJGNqn6FHALGy2eF7m7mxCxL2KpHxO4v0O
	mmEpQmoD8lbvV5yZSlQeRAvpOX0ANDwjSI917fMlntMczD8plpW1LqL5Z/BL9PEt
	9WCyirBTkuycr8/1gnQhgE87quDrjy8qa4X73Dzq5ZK5e1bM7WaL9X6fc5/3k+D7
	wW1RfoqKcLXBlvH5aTIj7pV5GMB1V7dhx+g4+RSecFcsQ9e+FE4+NwLbHnvFTu6E
	wx/zy8PZDb0fSQq/Le/T0AOTQMuZ0Xywo0Oo71jdXK7lUMKkQOoJ7rhEfFxVF2JC
	V0WOrg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8xjg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:49:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24c9304b7bcso8876135ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756972153; x=1757576953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=;
        b=VxRDGl3LM5X92/Y95x3RI3DAhH/FQ6m1s6ilQJVXnnZs212oEK6OUPeXUVVf+9/myd
         5/CT8WwQsA/rjlufUL64pkYyG++QGJSG1axRoyQt7VrfPuUo8ROVrVY/2iakAJ/oDv09
         ynzI3JY02TtAqZcnHQm+RKRxfLzId2nJsPZSS6dxggoQ72JZ0Xk/8Szlb8jsVUqqq4NV
         8F03YAA1aeNoZ3dOWiLd84r5zagaJ8Vf2pwkMF9kbVwrlabhJxQ1t0n/LniWJqgo0sli
         SKOn8E2UeVC0nlr93qfaVGTdI6gRnQ3EEzqOxid8CI5U9Y5HD2TIWq5D9Va+eph4oOjW
         wRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxPXC3CPvWUGgq4bP/rGMC4p1odx03m1pW7QakRE0qfamDIL4zbh1bhlsdkS/ItSwSLclnsctMVeblabg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1Mcvj8tcpu0E73M8KgARtQrg/tvT4NnK0Ew6uy0S/d4iNu6G
	duiNBgOkcFNuKXKk8H85VeUfYdC4lyt0MmPy1xqfPYO7KtvFuNAKUygaNeEPcAxPyL0R9nWRmLK
	7LVmppfl/N5JCkTNAD9QjfWVBdKIzvpztFzqrPoF1Hi8g7CEsEPMeowouTmPpZT2svTc=
X-Gm-Gg: ASbGnctx2JSRvyHh9YMMPnoQlPOd4n2n1VXpsoNrNSO6GrUqihRQB2lgCqtuNfaXIm4
	d0kyIf8BoSFs7IBMleTuAAezaoGSA3gxB8hA0HThbIZn7uiSgKrcoIMHY4ahwj+/R0qGM7PAwpQ
	tjR13zp9sYvF1+GQim0Sbs2yHMqga/vlJF+QOLNU2gTiFn3e1qW3gdoUdbqjPeyK3AJJeYyMWI0
	RTm2cYahI6yqPasfOXwKtakQsJo0+4Izx9DDQ6a4q90/KUNopeRqdt1SfFX4WLjCN4wipVaw4Rs
	UaOXwqp1MzLg0Q+WxTRCa3Lg/pqmSSCwxI/XQTZspe/itq9Dfghf+orWPV9Bb5T4HbXP9cWOU5C
	zQerdTkmpC0tE73JCao5SWCWTe/6jv4fXxg==
X-Received: by 2002:a17:903:32c8:b0:24c:cf7e:e48b with SMTP id d9443c01a7336-24ccf7eea02mr8148955ad.8.1756972152663;
        Thu, 04 Sep 2025 00:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9jqm8hZ7eobJ5rdqP6nJIGu6TDdPi9+/1PLXXMoBnIiAyw8MT+BFKlnVFqVwgqYqg5L730A==
X-Received: by 2002:a17:903:32c8:b0:24c:cf7e:e48b with SMTP id d9443c01a7336-24ccf7eea02mr8148675ad.8.1756972152159;
        Thu, 04 Sep 2025 00:49:12 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065ad5b7sm182194525ad.128.2025.09.04.00.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:49:11 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 15:48:32 +0800
Subject: [PATCH v9 1/3] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-hamoa_initial-v9-1-d73213fa7542@oss.qualcomm.com>
References: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
In-Reply-To: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756972145; l=1177;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
 b=nB8ww9lydz16Dn9sA/bZEdlI6JTzeEpOBjUEVVYuf44iAhXRqM6bDu0lK4udhiiNRjoQf+uc2
 TrZXfNKMu4UB0hela9f7a0at2+faIbpCh2kg28udj7IBHHlBI8o90bE
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: 1aOHzW4-866qzcsAAv5kB5ePbHlD0xo1
X-Proofpoint-GUID: 1aOHzW4-866qzcsAAv5kB5ePbHlD0xo1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX2hP4HQK+zj+V
 fAI8fyTyigHJHDZk8B1eyLnd2dpzK3HqkgqZ8mQcNO6O+1L4fscWDCDXSpeRJInTkg9WYMq22Oe
 /cf5+4KcaDQWGyZX4aQPdpa6BtpgMn4CQmORoHYEO5sUzsKupXnBVygTPMsQ6BrC1N2PZA2Yaay
 dAzZ72N4WKMqssil91La7rmwP/sjKKlRqI7y3NZipPsfaehfE/8BhZTvccT/9hGSEkf1nW8JQ58
 aU8M4j3YrbIW9/JLUWaXCEtakIr6V63xeB8b9OPw5hYglCv4hyQvXlIOwMOEqJ0gqWVJbxTOTjX
 CDon1/DTYJJZW+JH4XKcugZ7cscD66HarwlXfg4+SDuGezg+gXTb5lu5UlT9OQyP6BzR926oY9c
 3PDRmBhc
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b9447a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

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
index 55e5eb75af89..6b6503181ad6 100644
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


