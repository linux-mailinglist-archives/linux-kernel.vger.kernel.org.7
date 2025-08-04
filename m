Return-Path: <linux-kernel+bounces-754725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94752B19B78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BF71774B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE2922B5B8;
	Mon,  4 Aug 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMhmlB2d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAC7DA6D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288243; cv=none; b=AolUbiTw8By/uyl7WGc0Qiine6AnCTenAiXO/dKv4mEIw1gLEWFopiIZ+eF8XqTTP1tDXrTSYS2F6m/QcA3HyrocJ+zFXMvqwVwiADkq0aCEYssPK5fj0k3BVTAzpRk3F2CQ7ZL4gCe8SJjxnWZh6Ko/7SsUk4bLwc0+N67t/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288243; c=relaxed/simple;
	bh=Ul1dVZpeOTw7qaiph5ZpTsDcTs9gmOxaff1msl2kru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNEsqX+Aoz6IsWm2iJ3mi1BBTjBMc71sjGlSU6ZrjSmqeZMCZlTOEkzj1FUslFiKnhCo9Z6CDi6svgnLoZ7bJvBVNJR2OFd5qsT5i8SejtG4H+hrj3WyU2ZX2SbkwhZ5raWc11+igK1m98N7908REJ7rVtPojVvO/no6IhZwCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMhmlB2d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MYKen022407
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 06:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rRAvA28iaBx
	d6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=; b=TMhmlB2d4RpZRRgxT6qcgLlR/jo
	XcnDWU8pBCeAPHCuZPZmm8Nmo0omDOLkkWsxKKD4ffauOpRG41AR8BdfHNCg4l1s
	LejBL8vCxw8gYarCR7mWjzkMjlNVdsnXEMORQFPTAkPFi9cCs5LHIyeTDkK+lxvb
	tftfuqd8GWEWYSPyXRhu04tdwZAPoja14hySckw+NrQh1HQvHt8/PQqIzCfaZVmu
	wozRckjGYGxVcT+bQRjhZvxutoGGR1nfTQRtJbAGAq4NB3iuinrlCRX6cHfRP4mE
	B6AvJCgkg9uiJtCArJozswQgNLPkHM6uNjVz7k1Hx6CNJ2kKx+m5c5Cr8ig==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke1rvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:17:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2403e4c82dbso23725615ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754288240; x=1754893040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRAvA28iaBxd6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=;
        b=OuvcDNvjZaML9l13j0zf0BfA9VLkNKd404+248AfQqmPNYl/jqB44yTUhyIIYW58Mc
         S4jjyzeOpqtE9THoWp6pgRFbMaG8gXuTbB9yxjMayyawRerzrlqF/9Alm8lm1Er7qaXT
         MH/ucLIBnt3bkLjTE4gL2wpLQWwi0c9WiUZeSIDM/yNUBiVPTTpKys0wsZO843SBE8wV
         VxcT1TEu0b86Cu76JANeTNpNCfUAGWRPP45a0QeJSyp5lbJ9L8spMNs7CSJxeP2eHQpN
         E/9HtNWSEErzMM4mlbwn1TxnaoWwGLNxAU7NrvxDdlF+Qs24yhOLuiYFb8VIbb4LC5aa
         ajSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW26K3BVerAqYCxWZ9StfgSVx7RlL3BxPYc9fZ97MwE+SK5VQPWEhnO/09WPF1bJopP6NLREEdKE5U5Lf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5jsTRjObAdmDnVsCd7t+UL9L4hr6jEHslfXE/gcfXl+88umM
	6Q+qE5o8stC8kyYC1A0DFMCE+UimOlpsTAVX3nzpmY3Yz3YBkI1unXnkInv08b+Z3lvJNXnUsBM
	CogDLo/JV/uiX1RnJaOafTmITFn4/25+ImkXrbvz/0SPkDLtwg42hSTxMDEfMezkTKPc=
X-Gm-Gg: ASbGncuYLHK4GJeK9y7XY7/U33IfoAU/viXToggdAi9lLwId0JGDDMUT/OYBue9qTNU
	QyNpB7Q0ZBATiPSZJfh4Z9NbfciSkQBDUjkSPdl8/dR7x43FCHe//go8IcrjHfR56WslsVKJ7uC
	pfr1wOr4ySpT5IdTHv5whkPZZp2twN53NBNOghgXqdmZZ0UYeS4O71CHTTF5HQxu1bY517fBAFy
	4+qy0nhh+uwAGFYvTwSSRm6xk6gUXOPjEN3VSqXCByCYnkkHtYdD7/eIzM2O+hag+5ckswn5OtX
	aL36QahzGPmUyuzeyYAoBlGPo+x0nGGemm9top4EhLj21ljVuik/PW5KA/IeuNvsRnbGWNbIbJT
	wJ/k=
X-Received: by 2002:a17:902:c9cd:b0:240:11cd:8502 with SMTP id d9443c01a7336-24246f6d417mr66434445ad.13.1754288239974;
        Sun, 03 Aug 2025 23:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYPsjILhMmkQQ5MzhT7odrk4V2L30VI99GVEotMyVKKWKnUCGcF2rjuDKjD5PhVgLM20IrGw==
X-Received: by 2002:a17:902:c9cd:b0:240:11cd:8502 with SMTP id d9443c01a7336-24246f6d417mr66434175ad.13.1754288239532;
        Sun, 03 Aug 2025 23:17:19 -0700 (PDT)
Received: from a3fd830d25f9.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f08sm99786785ad.103.2025.08.03.23.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:17:19 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 1/2] dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
Date: Mon,  4 Aug 2025 06:15:35 +0000
Message-ID: <20250804061536.110-2-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q0eJJ5Oemfn1GS2-mH8isUdGrIZ5umQM
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=68905070 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bpSexm00WYn9fMQEYZEA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzMSBTYWx0ZWRfXyr9FcZhmGnwq
 j1hCZhIKUw7J0Eab3j/WAgJ6udkbiszwNA9/t+WvtimK9IH4eNdb8Z71e6ELwoV2UZ3Q6l0u882
 Y5wtj/9DVrbVfMfHOM8YajehNDpComo670aMRAggcKl1KxsjauisYe31+jLSqAUa7euwL2lrDHf
 atplCAVNeXEgc88GF0FnLb+6ugVWWgMyiO9+i2TVJ+XLwmLqwGop8MXVVjTrWTdXClj2EYJK9JM
 f5eeR7ZxSa26vbfi5dCgJtTLRoxuRD5ZveXDgPC2s+ZClnGjc0sGG6shtV3unjKKwgQflf3+SAa
 pERF75y2KMYX4S/dIDjhEdP8Et9LZKM0FAkqNhDSDakTs4EyaWrzng6SSTKeFRkKaIaSy+7SR4o
 pRdsnIA0zqmdkaNxDbsR1cO2/1NKLzZgWMknzxhVuSaehRreOEkA+UDe7WcakQSVbPVt8yhV
X-Proofpoint-GUID: Q0eJJ5Oemfn1GS2-mH8isUdGrIZ5umQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040031

Add Operation State Manager (OSM) L3 interconnect provider binding for
QCS615 SoC. As the OSM hardware in QCS615 and SM8150 are same,
added a family-level compatible for SM8150 SoC. This shared fallback
compatible allows grouping of SoCs with similar hardware, reducing
the need to explicitly list each variant in the driver match table.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index ab5a921c3495..4b9b98fbe8f2 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -41,6 +41,11 @@ properties:
               - qcom,qcs8300-epss-l3
           - const: qcom,sa8775p-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,qcs615-osm-l3
+          - const: qcom,sm8150-osm-l3
+          - const: qcom,osm-l3
 
   reg:
     maxItems: 1
-- 
2.43.0


