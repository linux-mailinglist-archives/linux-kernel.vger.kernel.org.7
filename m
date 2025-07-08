Return-Path: <linux-kernel+bounces-720921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9DAAFC221
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707CC4A6931
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0EF21B905;
	Tue,  8 Jul 2025 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4B6HOIs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25C219A71
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953165; cv=none; b=QUE73sn/F3gtxLFY75nbX2+zcEGeUna1n4Z9OlajoEGtZUJtyawMqU4pjWavw+gEoFOl3h1xfmcdODK/ZIufbk7p0dvb+/IyHGlNulv7nNwD3M7qXTsZ8rgvxkh+j93A3vDjqviJ+COuPW01c1uD/OPLJpJndTw6XRhho9WLiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953165; c=relaxed/simple;
	bh=ewtixLILXuUupT8S9ur7sLgsTuEmEKzJsaSwPqBRb2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxaAYq65sN1Njuym2UFckvM6+DzKNoaJ/j+Y9wcuk5RUCVnW1UeM03wGe91f1Bm1UgXt76m7OmV4uN5agHzYQ0MD/jTjHTR5N89F5Ef8YFbPcWA1f4/K7fsYNkltNdnIA7f4iw/dYzbQJXMVbKwn/ykm4Hf0pwS+lX0VZ5jjeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4B6HOIs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5683bUrq028657
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 05:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B/BoOaHH6Emeq/T4ksmjVoIEvoJ1Vn+kDUShTxoxkB8=; b=T4B6HOIs/8WCkLdA
	/4OylXRb1MauNiOcwAVK2B8P/ulkBk0ka5chvxM1iSsqqPDGlYmAe6jEMjyufLzP
	Bqj+Xw79Cm+8vTqOgc9rzHPNdPagzj5qMPGOCGt2hV6UrpZ8/Z7kOG+78QRgHHEQ
	OVUFC40mhT2Vy0cz3hze/Yt3G6d66h/QdKrVTRHu+HACXbWKuDwxhT/ZIjlLr3jp
	UX1jIRdT7wfOd2p/KRsx16IoJ7o8WIlgFDdRk4HNUtB08SB5HgTotPM7yd6t+dJc
	Aemakdnfb1uiRSwtSbmkAuF7gRcgulxpC04hwo0ciUY+3jaEksh9ILgqNRlvD+6K
	uWCxOw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq2wa4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:39:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso6099519b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751953161; x=1752557961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/BoOaHH6Emeq/T4ksmjVoIEvoJ1Vn+kDUShTxoxkB8=;
        b=hQOupQ6wF0P95fLuGW/pRm0g7UCWxTeCcheBTnSASIPhqoW8gvRim8PraC24pLD4Fe
         M1RysWC97FA0CllI+7UknytvisZuhbkkzULm93FJrnod2SsQmny2KTcpnEQ0BGti/wP+
         v9xVLhnO1xaSyONwCvIymn0dPO9HSF0k/T0gkD1ZfB1utNZEmsPpBQpm546bDGChmc8u
         63/th+a78TbXHsavUUhydSNxXeAwvQm3tmFHyr0L8u7A8ec7jT+A5FjKO8cP1AzBCuGc
         dQVm8i0mRTqpIJkoyIQ4tXQv9ji7pzQgFemz6Pa5996N7Uof8hw9SMvwaCduttGjSTZO
         GwUg==
X-Forwarded-Encrypted: i=1; AJvYcCWrPmCbLOt453v91KvDix78LsXaZjFsnvunBKoijip9WaxMaxAAm2oDJQaH/LRy3/IqegS6I2URWi9X0oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/J1etROIoTZ5ZGJLj010mKWaScUdh3dTPgjesjrhoRGEHkbE1
	VCmrmARc0uiDq8TT5HfpimiOCeqgHSp6OjCZE+ytoMwk1AnikcknhFeXlWCZTDyhKMESVWl+EeI
	LW8eGYMbOMTA2K5QrzQXHK38x0mJYjBpej4njTOYt4Lzf6c+NVulSpV0aT19haPxesek=
X-Gm-Gg: ASbGncv3oP7jlakJlf8+nauKWSkH+1lO/sBx7Kz8vQuvM0gvESqWboh4/zGoHbADfJ4
	myn5AZ0n1jLru8wEoCN27NUPgmY+T8BiRC8IvVZdNNXdl72V1oLgUp2Tx+30936AglgB/QrL3SI
	Q/N8K/YE+DGFWWhm78cdl3SFF7gx26e42mqRafOyGjvnqj4yVzWauPgeGs4kTOYIxhfwNq3sapu
	4MUpS+tVZjvYs56NYYyBZgX85A5VnfGtV1gogtReznSlNka/aR2UMMB9MLQjqCOb5yDbIJr/bch
	IsMylBAw14pTQifaQMeGY4UQM6ysLvmHGCdU72hy8EM7uxPOrm81pI0dkC+0/EckPMw5w5C8rbz
	KS0pralHV2p1VgL6Q8YQCidJJb8QZAkUb2cz7CPuwaDGj0Y3j4EqYoHmn3Q==
X-Received: by 2002:a05:6a21:a49:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-2260cff1094mr20982779637.42.1751953161261;
        Mon, 07 Jul 2025 22:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwNp3gv2H7sK8hVMcolto0PcXk8SmW0HJiiXfXI2O9DCyoF+Cd65tPz2eI6jDh33/5C9l0dw==
X-Received: by 2002:a05:6a21:a49:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-2260cff1094mr20982754637.42.1751953160889;
        Mon, 07 Jul 2025 22:39:20 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450db7sm10531829a12.4.2025.07.07.22.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:39:20 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 11:09:11 +0530
Subject: [PATCH v2 1/6] dt-bindings: sram: qcom,imem: Document Qualcomm IPQ
 SoC's IMEM compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imem-v2-1-692eb92b228e@oss.qualcomm.com>
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751953154; l=1045;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=ewtixLILXuUupT8S9ur7sLgsTuEmEKzJsaSwPqBRb2A=;
 b=mm7xEE3lnmbKcAUwof5hB3G0oArKrGSN92xulB+4LAZb41z0zBshZtBD3rCvZRLgtCXsw7h1U
 +OnUYOZEFzgCPabTRQOfSJngn9QuLIQ+aby1s4l5Iy8GZxI4VPgSwlV
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0MyBTYWx0ZWRfX7MxXFr6l9aTb
 c6yWL7zobG3E0XQe7sKoQdLRxTjvrdpjEZa0q1rABXDopb/BKmno8lyifzuaCV1ONki31LN2Fm/
 nXIXHx7MkFeXLz52+NIlctXscxe3NDaVejwNXD46PgXj6L61XdU/oM3/xMPQufVmda3+E97xLjv
 CHiTdnxlH36OnPCd2A0wBi5Zc2lDDgjuvFZpJ9LedYD19Igz5kW1NHWv37K0E2m/Wizs/cP8eEb
 kvE3pL4yJLJSX5affsNO8GIzKPrMnOWMz19bjONbsXcSLxIDj943tUaqphq7i/MWr8NFyg/4+r+
 9teCQQDmAsbGm4KZg3CfJfHmvo4K+jay2o33wEa1GtJpcr/TZLKEzw7SJR2lBmtqeWFiaa4elpn
 8MCBlXQUaLydcq7jM0GVFGDH64QxMG6/x8PUM/EKRCWx3ccDHLDQCyS7Q+LraVazamj16nXh
X-Proofpoint-ORIG-GUID: 0eeg_s6g8xyr6vpVTs3eKkizDsyG7QgE
X-Proofpoint-GUID: 0eeg_s6g8xyr6vpVTs3eKkizDsyG7QgE
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686caf0a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=YX5-feIjXtt2TVtCS1UA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=871 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080043

IMEM is present in the Qualcomm's IPQ SoCs as well. Document the same.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- added the entries in the sorted order (Krzysztof)
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 72d35e30c439ccf4901d937f838fe7c7a81f33b1..7286014e698f99184c1d6871f9a012c25c9147f6 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -18,6 +18,11 @@ properties:
     items:
       - enum:
           - qcom,apq8064-imem
+          - qcom,ipq5018-imem
+          - qcom,ipq5332-imem
+          - qcom,ipq6018-imem
+          - qcom,ipq8074-imem
+          - qcom,ipq9574-imem
           - qcom,msm8226-imem
           - qcom,msm8974-imem
           - qcom,msm8976-imem

-- 
2.34.1


