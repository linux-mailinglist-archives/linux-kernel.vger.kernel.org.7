Return-Path: <linux-kernel+bounces-798405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37655B41D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051C17B2E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F492FDC5D;
	Wed,  3 Sep 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aHMtxU5f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1E2FE051
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900083; cv=none; b=Y6N18i1gkgydGlJORI/uqxPKOI0ZdaurkjjhUadWZQBn0vo6U8yMGHptGOcWq1WkJse9GHYr1s5ErzdumVbuifNP2G4FJ3uFtSG9x9zmswum6ibriYoSuXlqc3kl4HPQxUi807wVn2cWczZrHBvJRSnetZo/xEB3AWv/qL7gjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900083; c=relaxed/simple;
	bh=wdoGSAgGZMAmaK8tU1XxpqdGvDf4YgSCTZ1IvUnFg9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpHi7OtZa8ELS43I4TilQMDS/0ubZMlZi5QAnBnlt6CKchxmi8gcgEEbn+0aaWuyvJK3XMv6NMm3uBeMaR+qajmvekwCRpzbFJ85qRDpJtuqk+tehFJL12aif1dOVf7niRKruOMvo98aXzi5+rrefyhDkAjG8/ySRawjP6IZ5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aHMtxU5f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEvf6001984
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWI9iycidWz9x65mS5Iihs700rJi1nYbUsileo1tpTw=; b=aHMtxU5ff7aY68oY
	xlQRXBncUnmMhqDC3Ljv6CkNYTKYSo8ulqmH2N6EwD1lBa7fQFyPEfzN8/IMCGQ3
	CIHFKQCam8kiVJ0b3KUFNcnzx3NHQGLwDuwdhDknoivfDOqkX0bxQ/8JNBGJc2qt
	CVUTugE7AUkKoVZZzKN06C0nHSMPod1ZjFAYnIBXtSoTWI/kuZcpIH3LLq6MjOQx
	OuZW8X0T8ystoX0bcHJz9OFg9VzL2574Aqs3FTPmzv9XTZ22alXKoP/1bSsK4m9u
	hrUNhWT1rrs0em0dJV1Qn9GUP3VO+lscmQCMgwxX/QlSX5kxhhKoUe3yWtWxcPx7
	Z1oWmg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03j10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:48:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so3880159a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900079; x=1757504879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWI9iycidWz9x65mS5Iihs700rJi1nYbUsileo1tpTw=;
        b=kfQLFwhx//AUelUbQIFluG/Io86geOQ5Q3XSx3AN4adbzugjpKMGIpZ+WD+EnwxDr7
         V/dgOEKOHU6S27mhfSo4NgsBX6BvlMTgXufsdInfGJdAeyMUxa7hQxzyV04ByZkgz3m+
         iAjA0/l6WHmY6xsXhNdHdzrFisbhZOai/YS7OGAf0aEb/pw1mffq0NaTfl5jcFq41eXY
         VUE2Mzdm4WUEmhkLRBG0ZgPs6nNq6NgOAxLlkce9jeGWKvCfPkeaCFF3xbdmXYwyYWUc
         Ri1ouYUMwebXs9HqXvM1ab5oJhAJPL5DwPDtKwCv8Xx9W3V4czH8BJ8Dhuck1bwCU2Zo
         lQhg==
X-Forwarded-Encrypted: i=1; AJvYcCXoFTqggMsaHdF6c8z2yTAJLP8wV/0bnxh58SmfuRz8MkGYMsNekKYLcm7Oddhd0EoBwOWlKyRpkJLnRl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9pZjmMrzVC3xLw2WEAIQbcrIANeZAzqL+Jfza4QWuj8OiTBO
	9oyjAkegJPGNzIsis9IqqjQezdMwPLvtoyfllgoHrIE9jlNDNm3NX6C0VICbiCtelVh+21uROjx
	xGI3NLuiXaDo5V6OIx6NYRcRseSlmUmCrqeBl1gHK/+2NRCIWYnix0qK2tv0cIIjDkpQ=
X-Gm-Gg: ASbGnctfXCX02UZTPU3YZJP+pDLz2U/QoBnPaG8Ol3+FyyKL6tFg30xsuw1n07SqWNs
	jUblO+eLSAuRcF+UJwb0Yl+J7CRa15tznSV9mGrpqu1O2NIZMklQKbHjXnSxKZ2gDkN8qCouMkO
	XZ68PeVnFpZ88fuZu9fkjBqJYPo3Ik0I0OO6Qj21nmOc7ZVwLjGY3L4mb4r/EjmQUeTowDT6uQH
	pBZIVB8QXNeNl0M3h1+DEL75MuwOMZGFKbZHh3ufPpzk6GPUhKshvU2MLUK2GHCpcfxO0iF4q1r
	q773VABdSuVYbrMdtUTi1Ht3PUxT7zUhWMN4Id+vDmRXnSe2YB4g2bdRI/uYjU3nFy0N
X-Received: by 2002:a05:6a20:1592:b0:243:b38b:eb99 with SMTP id adf61e73a8af0-243d6dfed84mr21286108637.16.1756900079027;
        Wed, 03 Sep 2025 04:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELv+J0huqr7i25bQr2YLgBlxEYaArp9gDC5zEKP1AaY9QJtkx2cJuebcKDmtTbXjmvqHsQGQ==
X-Received: by 2002:a05:6a20:1592:b0:243:b38b:eb99 with SMTP id adf61e73a8af0-243d6dfed84mr21286072637.16.1756900078540;
        Wed, 03 Sep 2025 04:47:58 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:58 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:06 +0530
Subject: [PATCH v2 05/13] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1145;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=wsLLJGJFupGV6CzZCYaiHCkslrVWQAlmf3KCPEuSGPs=;
 b=cVeVijLP9GWIcOH9Mn5Rb8GJlF8iOXX4RdCeMH5UUSFfrnFcJ95gmfiJcAimJiLws62ZSAjJf
 z3U7sfxYS00C0b+JZPfAvLyWuwyJhlQAr35iJbQbgejNLu2a/6P89UU
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: fLOEJLZY1XakPqwpihLpQshtpBLV1DsK
X-Proofpoint-ORIG-GUID: fLOEJLZY1XakPqwpihLpQshtpBLV1DsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX78ksFG3W1TdO
 AAoiHPQEN3rXisIxoRpjaDkzNhGWi9aSaefyluPmAG/jIdlr3Jkwe00tGsG3eNBLs9xy94HqfVQ
 6eE6Ac7SWIzzgwk14N8bGWHI9h7Ln0mLOoP8BRp6pGZLrfN7qPuNsFYX6RmMFQNqmBRXck++tXb
 j/wy16kLSD8uvcX0rp3CKmiqSmAfS5330aHhgz6LnxFcDeUK3oZfCLM9mveemI/D/nE+tNhld5G
 1HdDPfgToamWbV+LFkx8CwAZa9KoTUhkjewzWSytn+vtC9Y/IQKy1xZA2ORiGm+R5OlFqX3nm4w
 6HDoq7sEg3u4vC4AmdiERJgMjjyWZL2Xnnk7SPMtiId7SZf22YL1hqnI8ckUiS/JEGpP/lvSuoT
 83txy9e0
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b82af0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=c2l2xIwVH5VXVvV4u9AA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
DMA and peripheral communication on the Lemans EVK platform.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c60629c3369e..196c5ee0dd34 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &i2c18 {
 	status = "okay";
 
@@ -367,10 +379,18 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


