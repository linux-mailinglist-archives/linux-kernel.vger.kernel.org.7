Return-Path: <linux-kernel+bounces-798406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D21B41D73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080C93AF191
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144BD2FE051;
	Wed,  3 Sep 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxCJeCLU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724A2FC860
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900086; cv=none; b=OHPBhNNf6R7HH3pJrZMqJtLkSATOcXsL3F8RUJ7zpfyWiEvsKdhMemikJ6o1PFeDQNsWmCIC1KJkLej7zPvIrx4nopuKSVb2npbw1nNsvTLFYLgRaFeWa2pZOIT6DFK1C5vwS8p6iUe3MoI6fwIyKpIL6/YV5bj71U0eILc1QFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900086; c=relaxed/simple;
	bh=U4bFtZO0E9TeGNoTH9Kmx02xb2M+/AGciIvKZhwUtdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIXBAZDsrM5vgz6CE3QAD6kFERcYza6o4k//uKtZDMzaBjGSRSU8V9yPckpM+Xm91DbXsn7o+61E7DwcZArLj8rh+iPRrHGDyOshQH9RmDxv5rSUaonE97XHQP3QCIRK78YI73+xPZGOLNChqoMcfzi5HSnfGP9ker7lIlvNzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxCJeCLU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Ba6ZN024967
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l5sTpxPlVJZPGNjAHXGJXVpCmBn2OyKsJ9VZWcA4w3Y=; b=GxCJeCLUryk+Ez/M
	+FaAtmESC25n4QKWAL3o0Beq1H82ecSZY79sKj1p0lEO7WP8e8qDvoqp1QmeqSLj
	s8rsfi2LK6rOtWP7Xxyc5Nc5iPb0fZhLyn19UONASu5z5gcyhw37txYw7hf5bBun
	9Rm9xHTgP9BMcEhIYHrJPhXLM1kY9uwkiGVWxgiTCMFnIb0LVrJnLCEVeR6pfUJy
	iX57aOnjb7TIWqpd+rRtf8t/+wfkrN0zGG/zbcj/5vOer9Oup0ODbeUlsHLxwnam
	zDnMN7WyudayOV5cNJ5/NMp+zxjHs2Wkj/fM86HHIeJMhh+9YLIwW1eOD1NnPK9C
	SorNlg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj012h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:48:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77264a9408cso4197958b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900083; x=1757504883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5sTpxPlVJZPGNjAHXGJXVpCmBn2OyKsJ9VZWcA4w3Y=;
        b=mFBCUKIqP40vvGKXH3MSP6KJWnG8fWdhGom5CO9QswsSsAwEXwCJIiUPQa1cAAgCLm
         x+VjDG6F54F7r9M9ayCMwh+i3nPPsygaSW2em+GvIqRElBEa36LliYhNFPpxuKVSGhLL
         GfQiC5II3CfBy7DFUvV0Gu/O5VD+Bls2QrCpgDcALUL4LnaDzIUx9glialwViM5GEh5w
         YxRvpVAWo3FFw57pqkWnNruXzeagapIbXLPQgqy59UDE3UsSMlhP+ZHkX7OD1PrA+DCD
         pS9IU4D4F79qizftQnYTSfHuHMec27uoU7RTFvTtFehy7DWhGl6lBS5Ls64UFrA/nPRU
         mx/w==
X-Forwarded-Encrypted: i=1; AJvYcCX1VYGfvGtPLTTPqMEhjaGl7SL+M8t5ifuCJ4/g6UObWqFsAlF7vG7iCN+7YeoczDTpYhb9ZYsxu6EU2IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggBV2lG4uDXe8uTxV9QfJuOZYedU/BQz3/40AJZzYefjtiaoe
	R2hrBXnywaFwghPs2ffCvLv9NWUROWq7VQ1oJppSD4SH5oOJABImVMFICG2rDwwcVKY7Xr5jhZL
	hruPsywqBV5Odbxfzop8pBW8mXFHjnc8JNRDZsq5vQC6rGmnDjzWslp8GdF3gBjUWvHM=
X-Gm-Gg: ASbGncudJkDc51bNxDpbciZHmxl4eCAWbLK8t8HUZJf4iv00psP53YzP5G/Q5PErwR4
	CP/wx7m8KRLAcxzapojFNti2cSYBnRZ78lagiNa4hnPLOY+CUrbbH3o15yNF+2D/0WN+RQP0XIZ
	MxhdKAhUZVdceSoCwYvi6YTm/g7jGQQuyUMnLeYKIRHmIMxIGgHR58eYcdDspRr7M1ElKOpyoHq
	bSVMa1Q0Auvb0VYguns2/0h6fihEoH+dH2IH3/pgC9PJKuc+6HY/J+xwTLGe3T0IM+p09oPRRhy
	hL3YUKLtn2bn1Mimgft2RWCk1NJ813fYX9N5W+QohOMpYf/YyxtwGV33kxg8UEkDwo4f
X-Received: by 2002:a05:6a20:3d05:b0:245:fdeb:d264 with SMTP id adf61e73a8af0-245fdebd5c5mr6770445637.12.1756900083372;
        Wed, 03 Sep 2025 04:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT5R/fwIha9CqTYkCtjjav55lL8IiszB8UTmLgYdfAKYo+Y5s7OAw4iY9nbcK2D1m3WK8x7A==
X-Received: by 2002:a05:6a20:3d05:b0:245:fdeb:d264 with SMTP id adf61e73a8af0-245fdebd5c5mr6770405637.12.1756900082871;
        Wed, 03 Sep 2025 04:48:02 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:02 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:07 +0530
Subject: [PATCH v2 06/13] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=2445;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=78aSxSIhSUzc3QmRgVmlUMy8mC77lvAghgjYiBLJezw=;
 b=GTZ2OxSdn8fy671mmP5pAi50chKwgNE2tGq9zqFIKw7Fwtalq57McSVOpo1nsRpM0NLmw6nhn
 eEFxy3T560TBz/k2kl02P5OjwdE975Afe9BjY5bOoqgnxv4F8+2ypaN
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXwrGtNaeUE3qc
 izDY0xx6Gqf3wEwpwqqzP1/e2qkZAd63S2W0Y9eUR64PsM94N+Q+HnZUojNiKC6pF8ZeHpKsT6O
 wLwoyu08ssWaFd7SAgZPpzFC4SXTB9thjVoed+n9YycUWmhIsHEaH2Ftp86Edkf+YCTX4ZYLCOk
 E74DS0Co/MaSxzx+TI1xOSpJQTGOd3PvRbrneUfdA85fgfJITqDe2HkzM2B1l2ubyOG3AGki05F
 wrZKG/d48iaB+kR6If9FBv8EFix53hAFjv+vDg87Y1U68F3DBmD/do1eNKPu+P5hEZIam9fEoO8
 /cyuY280Eh5U8k18NaEAzqnWmcvAddIqBT7MGAGzYeN6A22A6AXMkEMGRl6AutgrTC/XGUX08qP
 io7m3fdt
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b82af4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=iLH7TPAinAFjDZn0xZgA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -mUo6il9-y9m8o-6R87Zw5tMIPshXKu_
X-Proofpoint-ORIG-GUID: -mUo6il9-y9m8o-6R87Zw5tMIPshXKu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>

Enable PCIe0 and PCIe1 along with the respective phy-nodes.

PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
attaches while PCIe1 routes to a standard PCIe x4 expansion slot.

Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 196c5ee0dd34..7528fa1c661a 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -379,6 +379,40 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -395,6 +429,54 @@ &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-pins {
+			pins = "gpio3";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio5";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

-- 
2.51.0


