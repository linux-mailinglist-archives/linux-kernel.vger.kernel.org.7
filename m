Return-Path: <linux-kernel+bounces-798923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1003B424BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF6D18859C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C161313E2D;
	Wed,  3 Sep 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZbIdZoT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE2324B1B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912457; cv=none; b=bbdQ4ws8xvSwF2BftVuTWF6s2pi2U1bykpqPXhwHtYHTRYa+1x1S/vet/x16dEqc29fGntwIqW5fLni1MhXYIeyM+106F97Db+owNa37yPI/gOzqjc7sMNHmNq789Bk8btN5kXhUQbPPjnXKvBODOJU9COkv+oDYLduw98dBbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912457; c=relaxed/simple;
	bh=hnoUdf3rjdcAoYIydQYt2dYzr9CFPXyNlJHvaQr+eBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krO4/o6spZPjjvN514qwSdusJfSt/sdMEJySqyauaz3eSO156UeMHksAfhfv2a2B0wpHdhvECIaGKLilvlI7D/W9eBFFw9PyLa/vmptpx9SrjZwIXu5ydh/v1QNKZXjY60DjGUqffRlOK0a7Lp2W6kmuezPpby/l2CMSeG8njbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UZbIdZoT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxA7p005586
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1zT+isCAMKH
	XxYTivUJqw6qOIGYD24cgm8f1bNsXLvk=; b=UZbIdZoTQNn0J0ph8e3tzsZNG47
	pqtPRdGcKMNn8Yc+SsMgDnO4TqW+xeqvZrB6hBUD8rLAOhaPOVBCLwVWZaw8YaUu
	RyPaSQbHCJZv6UH4uflkc5JziDBRcmXUIw2Tn0Ou7oPo74VS5b24Cvy8npfK98oO
	Qxw+nTvxV6f4fFz0PuQ5fRON5CtZvsCTfYWoAzEaQM3d3gM9bUtg+HV65Afkonl2
	qQ/W4lA0rqULiRuMY7LvXiPYRmwpQ89EyFJ5D+iDMHVwV3IGfGXnUWW+zlFYaxwj
	xjr1wBduuckUHQhrF1Ns45WgpSYSZ+wbl5z6T9C26VjRb3JWWuRnGa/icew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjm3a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:14:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24a9de13b7eso771835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912453; x=1757517253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zT+isCAMKHXxYTivUJqw6qOIGYD24cgm8f1bNsXLvk=;
        b=ooVJN0s1vudKQZosntot39wm8zm4XpzzW0NwZxYK3ic5R8xZZjU+xUEhGwMeipYRoa
         eD7Amhb/ZxPmOyRYcgr/S+G105GqVsJRl2PXSE2Q4VgrKz9KdVEIM91d1Ay/p0H1dQvI
         5LvLpeR1WgForEdALgO7UZdh0U6GR8Qtfk2WVTp9BijLUR9hU3T/08YENROSquGEOM0b
         XrI9CEx+33I/Cycc+TsX/mB88DUYfPMxVZHCdH8uMTeLDge4ytJ7Wk/SCbwMBN50isDJ
         S8I/GJRj9WF7+Oi94kW1Rj5ItL/hOuT6o8irqS/3jn0mrdlAqePC8r2x1/lkh+qCJRtO
         LgfA==
X-Forwarded-Encrypted: i=1; AJvYcCUUA1iW+3RBBaIpUFtkpJX6+E78ulCJKjIBscJ3ScYms70ZfZ6kzxOURwSE8Q5n9jvAPUXcPnblXyYb6Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ConFN1iT1ReQ1LOegFKMdTYlIed/uL8jEI2jkJbFXjksNlPQ
	WGMCAWULIoH1AGpvV1JAyks9Xxn8DlHaJaqnrlFTK/d3AW+W5iOjM6qxVxnhEMcp7sQ10I1+3Ok
	tBRcuixTRy23Zfsx4+XpQ6dO+oAzKIdGHMeIixXwaQ6W+JRO8TapX1KNQekYGTea7aPo=
X-Gm-Gg: ASbGncs+cfIDw/IxEF3AI3AIOaz/WZu9Xzfi/blZKNa88VA/Nx+Zr/7AAF41eFrQFUO
	1PhjsclVTHlXtYIIn0dSr+qZSs2WhbDAnZVZ3dygf2Px1977cYNPSWCpEFHBELnU8ttPClbhsUJ
	ylbTB5Lt6+SjDb/Uq0UPnxDy39wotVQSG5l3ckbS4vDXfLmddaTPVxhFPzYfLMJ6o1BzxBABSY2
	lXa4Orfci2ifB5xfDmYOz/TlflFDYm3gxzoyVwn3DaouQI84RCIWKC8gH9akW/y2N8fWpsScs1V
	e+Df4yDBoL1RWm7+GVdZoX01TVS/LoFgUjMpYjylaOYtLiYrMtsAwFLYFMGVU+oN9SbceCvmMxV
	j
X-Received: by 2002:a17:902:e94f:b0:24b:1589:5054 with SMTP id d9443c01a7336-24b15895984mr77983895ad.23.1756912453105;
        Wed, 03 Sep 2025 08:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOVc9HbfT1Od4ND0ksWQhGbUiXjtl0OlMXb+jVj3sT9uXnWRuDf/D9PyMVC06mYe04GhUEVA==
X-Received: by 2002:a17:902:e94f:b0:24b:1589:5054 with SMTP id d9443c01a7336-24b15895984mr77982655ad.23.1756912451454;
        Wed, 03 Sep 2025 08:14:11 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:14:11 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v9 4/8] arm64: dts: qcom: qcs6490-audioreach: Enable LPASS macros clock settings for audioreach
Date: Wed,  3 Sep 2025 20:43:33 +0530
Message-Id: <20250903151337.1037246-5-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b85b46 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Ri8MtJ_oCAYdBNTneTsA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cxhnQ_CdCIc6dNXNFk4ew088yI7-Tr1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX9pYmuAsUrqYw
 kBqQ2Ufsrhxv2rg+NN0bBn64hVxTwOV8uyOiAS9BSZQn4hgJtgf0Pr9uftgpdxm6aNhyHybACI6
 VgT3KZoZKs8AVBOVokhOcXlWFc13ueqC1jp/56i+JD8jiawWzxaC8B8PoUoRlmf18a8tc/oeDaZ
 fPocjkGxDR6bwPu06MKq24DoOSTsbLiKyK6pDYwk6RJqkWVowYjoiTXaSFaNVQLR/DUp0j2tedw
 9zqr7JyQT4ruj0I8qiAW45STj93D4Fe/Hb5iAAcHTzciR8/eRNcsXg/z4y3io+qCrfANF3GbXMr
 jN6JdCm3ZTJF/y665x4QJqf48SjPB+YZUssLmnaX0oVliwMtkI/8Wlm6//fiaavKs0lXTh8Ts78
 YiizI7to
X-Proofpoint-ORIG-GUID: cxhnQ_CdCIc6dNXNFk4ew088yI7-Tr1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Enable LPASS macros (WSA, VA, RX, TX) and the lpass_tlmm clock required
for audioreach functionality. In audioreach solution mclk, npl, and fsgen
clocks are managed via the Q6PRM. On SC7280-based boards, the TX CORE
clock is used to drive both RX and WSA audio paths following as per
hardware design.

Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../boot/dts/qcom/qcs6490-audioreach.dtsi     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi b/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi
index 980499fb3c35..bdf4b6c3fc6d 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi
@@ -10,6 +10,67 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 
+&lpass_rx_macro {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&lpass_va_macro>;
+	clock-names = "mclk",
+		      "npl",
+		      "macro",
+		      "dcodec",
+		      "fsgen";
+};
+
+&lpass_tlmm {
+	clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+	clock-names = "core",
+		      "audio";
+};
+
+&lpass_tx_macro {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&lpass_va_macro>;
+	clock-names = "mclk",
+		      "npl",
+		      "macro",
+		      "dcodec",
+		      "fsgen";
+};
+
+&lpass_va_macro {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	clocks = <&q6prmcc LPASS_CLK_ID_VA_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+	clock-names = "mclk",
+		      "macro",
+		      "dcodec";
+};
+
+&lpass_wsa_macro {
+	clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+		 <&lpass_va_macro>;
+	clock-names = "mclk",
+		      "npl",
+		      "macro",
+		      "dcodec",
+		      "fsgen";
+};
+
 &remoteproc_adsp_glink {
 	/delete-node/ apr;
 
-- 
2.34.1


