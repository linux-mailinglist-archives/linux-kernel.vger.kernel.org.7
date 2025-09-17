Return-Path: <linux-kernel+bounces-820024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967AB7C9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB362A3C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E562820DB;
	Wed, 17 Sep 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ig8wXLza"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09241274643
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089452; cv=none; b=bUq1mtzdTc6UqQgy2Yyemm+U0GoSBTbXPmfheTcEwC//bkbSjU/muSzTToJH4VGDaLljlhdc+qW7XmskZYM4mLwiLYU+N+ie46n4ylu8TCG22Lq3NLu6NL4eax33ew7iwrzVSZbCVatZ28Xhq1XQTnMFMCRwgNhhs1PDNLRHGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089452; c=relaxed/simple;
	bh=Kkg/GKsI73JtujV9o9Ex+mdY2GnrHNV6KM2jGJNJiy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNnx9ugpwsYumBBodPO6P7eT6lTEi9MV6bORP6t+j9Cico8DANiIfao+eYa1MybQ488wDZuv1CbzNeWbyamR/sN/ASuRsutkPzVrBa/ay/khXGF3QkYKzndYlpMW1/QDny1r/5fbA/fW5y4RcyoIQOh7gyhDt3TGYfv5kUAxb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ig8wXLza; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H5QX8G015984
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rvL8gsjF0NQhyrnke9VytDO52UyQO27XD1oEzPQwTYg=; b=Ig8wXLzafAXoU23h
	oZYH2xfQqDnRltP8MUiUcoInuC76feTZc0atr9FwzcvklzNCtQ+07l418GAFYJaj
	yyD+3+G8k+128BNd6fIc3GCj/J3w2tpMKHw8WwmFQgYYUwb2lIxueUJfRSHLNDAa
	2mP3Koyv9Bmb0Vo2qBTc6+1J6nNTga2DtSD7SV+s7aBFRbg1wXD7CD9Yd8zYCLMH
	QrdvoJUWtc5KNEjvL9mbZp2RFy4nRsJ8nQ7cOB6gp2iH/nSS8yK1bRHstQQ32bed
	vf1b+qaa3LNBiaP9QZUh822LqWxU2cLE1OszKIy3F7bFjxkJWL77MDdv1v86go4a
	gvwjiQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwh4xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:10:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54d1ae6fb3so2120331a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089448; x=1758694248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvL8gsjF0NQhyrnke9VytDO52UyQO27XD1oEzPQwTYg=;
        b=EVACg3lvd85HpfJYF0ReHrVsBWMsXg5rfhoQxvL5e8RS7YqO4Bt5/IgjHNEBO3Vfvf
         6gTSgDQqTdi/SZnh92qIJHJHTEpN/GfoOEALXitdGFVHy2zSnuSIrZwHKtCimibm/mb4
         KAh5dZ1RYY/h8AFwJY8hsBPz4iRTXq69/jy5hDuoRriviivPSRzjoZ3MMqzIKnBMkiYk
         Sp0xMC9qA1B2O/QfxTw0ukkq2tsrkVMeUL1+bJ0x44GrEZ/HkdhBlf3uiB9HFUT1QglA
         /OuKIlH2Q+RGGP6OBdPshzHYB1CN3UM2mKUcoiUJ4CaFbIzb6pao7/xJ3C88XUJzyTl1
         eHrA==
X-Forwarded-Encrypted: i=1; AJvYcCX2EVuhDTLPmEWVRgu8ygmDZCXA98B9nKSVhSkIy8pc1UqXbmtD+CT5TyzfWOz+GYlP75FY5dsTPIzNhBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzNfOeCWqxUr2Jt6HKyzqgKaMBHEYjHRc3h+0R53t25mQH/L4
	D/o+rRNiIKKdX/LZl3reU204fPssD4K8d7bFaclO6y4xkp/Dra+bCgD5vgt3ce1vSYAl5+9V1JK
	f8UOpQ4duczi7hJt6lrMgZveXFSripssnBCRSYaqRz6phzM2PpNtgXkAx1EfBcxwxF5G6HpWO5Y
	lI9w==
X-Gm-Gg: ASbGncvvJuvTpEDd9oaBDIfkMjMF9nz4Nc34LRPi+efe/zEP1wT8qL8S1tMA+oFZnS3
	2RqSJ9Eb606coKu2hajz3B05YzT8mM6MEs51f71U8cX97nXvTDxZ5/EpKHvYzY6nmA0hFzjl9oM
	wjaE0quxM9ypmWapdEYESVW7txszAblihroNZ5WYWR2tv2tFiPL0EC+Y2kuVzOw10jQkqemd+8y
	TGVA7RQx6DgTiGvY/ZO9BvNCc1FTnlXPswEei1CMIxC47Cqsa9tpJ+2D1sLAaI6/ZBtYJEKp0Nj
	PEb2Fnpp64H3I5hSYpRKEQCeVMaQTVnLS43v77c6NzMRx8n0iam79+FsZAcN8Z4yILgz1jU=
X-Received: by 2002:a05:6a20:3c8e:b0:263:28c2:c8d5 with SMTP id adf61e73a8af0-27a93e9d8cdmr1249123637.20.1758089448153;
        Tue, 16 Sep 2025 23:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs8ZachTg3BkDFSvR11G4dblvbAtjW6x1kkmspnctKOfc8ilnPg8SO50PD9/HIwtjBYBXVVw==
X-Received: by 2002:a05:6a20:3c8e:b0:263:28c2:c8d5 with SMTP id adf61e73a8af0-27a93e9d8cdmr1249096637.20.1758089447671;
        Tue, 16 Sep 2025 23:10:47 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1917dsm17966812b3a.52.2025.09.16.23.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:10:47 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 14:09:47 +0800
Subject: [PATCH v6 1/2] arm64: dts: qcom: qcs8300: add display dt nodes for
 MDSS, DPU, DisplayPort and eDP PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-dts_qcs8300-v6-1-5c862aa80f64@oss.qualcomm.com>
References: <20250917-dts_qcs8300-v6-0-5c862aa80f64@oss.qualcomm.com>
In-Reply-To: <20250917-dts_qcs8300-v6-0-5c862aa80f64@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yongxing Mou <quic_yongmou@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758089439; l=7280;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=Kkg/GKsI73JtujV9o9Ex+mdY2GnrHNV6KM2jGJNJiy4=;
 b=b033+ZSHpiQbpSkicXpcKRdNcpkjxGBzyYMUoLB11YjuBtIGVr6bs4UFffqT/CCNfCdcQznwT
 u84rDE5uQ44DmiX56ojXh1iNad5sOD21GfIj3IziRY0zTFvmvWxMyj2
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=do/bC0g4 c=1 sm=1 tr=0 ts=68ca50e9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AJW_lgGcPnFSnOaGF9sA:9
 a=7_yHfcTcWLYK4HMk:21 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: aejtqmHwgd80LQjKhE67VvqB2t7oG-9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3etyBPYeZr7E
 y1f1KOR9UScpr2F4JZEm5xqbLO/lghBnFwpqM2Y7j1+SXy/ftAFr42QsbD/2NZJ1iOg0e3KZtgo
 uPMj50xhRIUnKy/LD6PyxMlKRu0hgWP9laF/OfoWLvALQ979VD3o8+jvm0RpNzWCp9HA1d3GR5M
 xhaaDJMY45mJ9M0GnA6YiSIMh3LPkXzKg+4DTfl93Jx3ogvThGj9MSqez5Qerbz3L3jjnM+AH/4
 wCAioxjSrnTXcjvIh+u0Y9C8eZB/xLxjr95XtqfNQQQJdtwb3/ExzzxE3YwbKXdJZSM/RtUDOYT
 s1lt5B5kOvKThgcCcz5DD3g1mqjdKMa5MeMY0Q1f46+lZFIHTbRLzr0eAPfu9peuFm8S8ST43OG
 mFPA2iT2
X-Proofpoint-ORIG-GUID: aejtqmHwgd80LQjKhE67VvqB2t7oG-9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Add devicetree changes to enable MDSS display-subsystem,
display-controller(DPU), DisplayPort controller and eDP PHY for
Qualcomm QCS8300 platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 220 +++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 8afd77a2d737e0db4b7206ab57a1e93c255fc2c5..85e9200a64e0d24189880da39eaf6176bc0699ba 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -4694,6 +4694,222 @@ camcc: clock-controller@ade0000 {
 			#power-domain-cells = <1>;
 		};
 
+		mdss: display-subsystem@ae00000 {
+			compatible = "qcom,qcs8300-mdss";
+			reg = <0x0 0x0ae00000 0x0 0x1000>;
+			reg-names = "mdss";
+
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&dispcc MDSS_DISP_CC_MDSS_MDP_CLK>;
+
+			resets = <&dispcc MDSS_DISP_CC_MDSS_CORE_BCR>;
+
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&mmss_noc MASTER_MDP1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem",
+					     "mdp1-mem",
+					     "cpu-cfg";
+
+			power-domains = <&dispcc MDSS_DISP_CC_MDSS_CORE_GDSC>;
+
+			iommus = <&apps_smmu 0x1000 0x402>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible = "qcom,qcs8300-dpu", "qcom,sa8775p-dpu";
+				reg = <0x0 0x0ae01000 0x0 0x8f000>,
+				      <0x0 0x0aeb0000 0x0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				interrupts-extended = <&mdss 0>;
+
+				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "nrt_bus",
+					      "iface",
+					      "lut",
+					      "core",
+					      "vsync";
+
+				assigned-clocks = <&dispcc MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&mdss_dp0_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-375000000 {
+						opp-hz = /bits/ 64 <375000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-500000000 {
+						opp-hz = /bits/ 64 <500000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+
+					opp-575000000 {
+						opp-hz = /bits/ 64 <575000000>;
+						required-opps = <&rpmhpd_opp_turbo>;
+					};
+
+					opp-650000000 {
+						opp-hz = /bits/ 64 <650000000>;
+						required-opps = <&rpmhpd_opp_turbo_l1>;
+					};
+				};
+			};
+
+			mdss_dp0_phy: phy@aec2a00 {
+				compatible = "qcom,qcs8300-edp-phy", "qcom,sa8775p-edp-phy";
+
+				reg = <0x0 0x0aec2a00 0x0 0x19c>,
+				      <0x0 0x0aec2200 0x0 0xec>,
+				      <0x0 0x0aec2600 0x0 0xec>,
+				      <0x0 0x0aec2000 0x0 0x1c8>;
+
+				clocks = <&dispcc MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>;
+				clock-names = "aux",
+					      "cfg_ahb";
+
+				power-domains = <&rpmhpd RPMHPD_MX>;
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				status = "disabled";
+			};
+
+			mdss_dp0: displayport-controller@af54000 {
+				compatible = "qcom,qcs8300-dp", "qcom,sa8775p-dp";
+
+				reg = <0x0 0x0af54000 0x0 0x200>,
+				      <0x0 0x0af54200 0x0 0x200>,
+				      <0x0 0x0af55000 0x0 0xc00>,
+				      <0x0 0x0af56000 0x0 0x09c>,
+				      <0x0 0x0af57000 0x0 0x09c>,
+				      <0x0 0x0af58000 0x0 0x09c>,
+				      <0x0 0x0af59000 0x0 0x09c>,
+				      <0x0 0x0af5a000 0x0 0x23c>,
+				      <0x0 0x0af5b000 0x0 0x23c>;
+
+				interrupts-extended = <&mdss 12>;
+
+				clocks = <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK>,
+					 <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK>;
+				clock-names = "core_iface",
+					      "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface",
+					      "stream_pixel",
+					      "stream_1_pixel",
+					      "stream_2_pixel",
+					      "stream_3_pixel";
+				assigned-clocks = <&dispcc MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>,
+						  <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK_SRC>,
+						  <&dispcc MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dp0_phy 0>,
+							 <&mdss_dp0_phy 1>,
+							 <&mdss_dp0_phy 1>,
+							 <&mdss_dp0_phy 1>,
+							 <&mdss_dp0_phy 1>;
+				phys = <&mdss_dp0_phy>;
+				phy-names = "dp";
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_dp0_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dp0_out: endpoint { };
+					};
+				};
+
+				dp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sa8775p-dispcc0";
 			reg = <0x0 0x0af00000 0x0 0x20000>;
@@ -4701,7 +4917,9 @@ dispcc: clock-controller@af00000 {
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>,
-				 <0>, <0>, <0>, <0>,
+				 <&mdss_dp0_phy 0>,
+				 <&mdss_dp0_phy 1>,
+				 <0>, <0>,
 				 <0>, <0>, <0>, <0>;
 			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			#clock-cells = <1>;

-- 
2.34.1


