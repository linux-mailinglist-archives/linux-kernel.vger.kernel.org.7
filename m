Return-Path: <linux-kernel+bounces-736070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD4B097EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B0F1683E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AFC28A1F5;
	Thu, 17 Jul 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oQtlk4kB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99C2877D5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794946; cv=none; b=dmXwcl76UNqWQEvgXMp4fqEaBbt2AJrlXzazzaaxIRVbctVzytwcZzmBoNVwd1W/HAySBV9lq4AvnV2VSRl41LQsyOLbl8LHjrbqkUfXbc0BejM6mylHqLr+Q2hoHEg77fqwz6ySIYSVLk7HzUJFF4qkdKueOboI2oCR1oYqTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794946; c=relaxed/simple;
	bh=Eo6Wy62P8HtW0Q4HjhWR3xKbDOiW9UUfKZH66pv4erc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PIRzVHFMGqHiBwzZ2ej8nW4wFauMX+i18ENXPdTChKmF7oslOXxhGQ0BWqUzyBIOyRZkTDzOZmRaDOQZ9BB46vTV0GWhAg8b9FxX98aJ6nJVEQaOA77kRfqRqLRh5JSz0rGpB1QetwQYFKbSZJZ1hnZY+H1NfbD6K4WyvVeehfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oQtlk4kB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HNRmbC016003
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zqRkb8pF/4h+k9xswu+5inCNM8xsKadkBjRwCpuViJE=; b=oQtlk4kBJQ0aihxv
	xh42kodOq25sbdL1T1mZNZqu9wsVpfgD171TmFhaNcdHu2Xf8Lr9Kz+T/p8JToor
	07x1UsLKQL0sUDN115UOnjEUEfFxnTH9JLqHphUu17pdCP8Inqzb9grzvdovseZQ
	UusvDY/CdAlpIoXoyZO+BbrkqDMqtrkGI0SLlYJK2oA7+hnWX2VAHmuiqRuiiejl
	d9CHA7fB0Iy0lnp9H5QuJi+rT38hI4tsGq8QZr6whhBpfA9k2ioryZokHXP4+kdF
	m1BNcbSFUvaWlpWV2hTFNT9sqShYv9Hn3Pdur6XlN8kzj833Tc5hwLbz6W0qhB3N
	xs35oA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyvekv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:29:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23dc7d3e708so9983425ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794942; x=1753399742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqRkb8pF/4h+k9xswu+5inCNM8xsKadkBjRwCpuViJE=;
        b=uZHxwTQn/nd0FjGVFIC+ex9idM9NQaEBXvPgXSCSLqITWAFaMAaF/RQor6W2cQweO4
         mCVx+SDSrR7E1yxpsaZyzy+KcKCqse4oUdz8HQ+TrQHeKbx501u7SsZegIdmRb6xJRiO
         PlXdaxF5SCXB1hO2qjDI5xZXu5xQxT5SxRgtWkxDbMNf+uNhX0EqaX2Yfp9gTBAsEvgN
         NYQ+MwMRbHrjiYW5VK07NlSxNhl5ffRB1D7zIb+D7TTIM6okBmAV+ZZHm4Fnl/1QKFFL
         euLzHv1g9FZOzhl+TGN9DGtryENC8arPxxDMDVL12FNVQbKPq9ZoBRRFVC6zwxGGM+xz
         Qhmg==
X-Forwarded-Encrypted: i=1; AJvYcCUYmaxbwcmyETqrsAFkUf9+06jHqzJbJt5LV0MHrTgImTdaBu+rKuMx9V7Xl2CXRZIxwhmigGNZfQUbpMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWblc74sh1Ew0lMbVlJR0FmKpMFOEw1KmwApkFeP7hpLmDc6Hs
	Z4F/Rl6qYaSkXfaQJd1cGAvrGA3tI3i+5+O6CHeq5ElKp/6qXRCUYrfW8d9G/ltJWt3Gsy1r0cI
	UxBxaUI9lK9WSwwJQFOGGuesIx6r7vcbKlO8VroS7VFhH2zP+xlcTq80ezlz858gLLQE=
X-Gm-Gg: ASbGncsxt3UwxZip42a7FW4YbC6hnbSQRm1vJz0+KfrJTBpCQHq1IMpJfO5M4RJGbC3
	1HqMtLFPq6At3or8gMHUtXPhd45wiWehr3vHY8YsvNfFpMQybLue7YqqmKwS595tVElPAXu/ZqA
	9AZB5PD+0Mn/l+IEINcgEopLRvTeomhKlhUjswEZH8pyvtRscNy+/gfoRb6H+BpZVqIHBxCe73u
	9biF/XEmGZE7cToDlHSs/Th1IQsehnlNvLcTeZq+TwWZ2fcMpeC+NEuicxyrYGyPu5+IbCyaUIG
	el/g2upsS42S51wKzsNrJmRp1SeUjfWkaXfvP+tMeiSxkLPLp97RLVm/NKni9qqJDL7WeNNpjWj
	DTWsIlgGNGbrBEXFEUeNOJNTZ
X-Received: by 2002:a17:903:1112:b0:23d:dcba:a467 with SMTP id d9443c01a7336-23e25684a8bmr117785455ad.4.1752794942000;
        Thu, 17 Jul 2025 16:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0nTY4fHu+xGa9A7Ojqymgaxywl1w1RLs8FHRSfQgN+a5MpPoK+jiWB+Km6ZaQJrJ7dCKNlw==
X-Received: by 2002:a17:903:1112:b0:23d:dcba:a467 with SMTP id d9443c01a7336-23e25684a8bmr117785155ad.4.1752794941419;
        Thu, 17 Jul 2025 16:29:01 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3cb7sm2002195ad.17.2025.07.17.16.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:29:00 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 16:28:47 -0700
Subject: [PATCH v3 5/5] arm64: dts: qcom: Add MST pixel streams for
 displayport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-dp_mst_bindings-v3-5-72ce08285703@oss.qualcomm.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
In-Reply-To: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752794927; l=26884;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=Eo6Wy62P8HtW0Q4HjhWR3xKbDOiW9UUfKZH66pv4erc=;
 b=J7086Q2E1oZhhsTkVGHCxkYRAp51smmyKiw2239g5+4gsg4jvR8VUm8FdNlIHzx+bfEs+7Dmi
 DRBkmYPYQvIAFePSFwq62FVbLNn56oaEM8ZpDgfW2ejtTmtx7+8tqEy
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-ORIG-GUID: q_Xz1oQo33SX8OHmsNv4VFyOe9VUQjtJ
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6879873f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=M642VWYP8yQGdStLr8gA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDIwNiBTYWx0ZWRfX3UeiGDjBMomE
 WDDAC6CBaoU5cpWHTqNErrDstp+q4SsgUKCfdKSc7rY8KkFqiMhpCcM/PR0qIo+TKs/Mzt3yC67
 9/Bi/5MTthu7fCVReKlBcT1rJYtudeKuJ/bCA3LSJR5Dbsnav7SqNrT8SLHg87D5+lMbxdDac76
 IygKjadoUZuuGDPMo1wVkKHq59pzGK75Q63cCJLuBqyVH3y10BVfiliQ5L6LKky4IOtdneXD20a
 xFS/u91HMooDL20uGMCKbob2WpEpqtkuaTiJZS8pb6JaatXlxsgyIxi+PEoIECa9XBgzI7HlVq5
 P4JWDOpt4UjRAqBiE00VPR6wXi6pgfcC2N9gB6KtMz/XugoJqkegmkZwMiGU3vvOkIZBv4I4DBz
 s4KUmoS48tp5lBbeZ7NO7DawcJa3o/gB71kMTPcH4pfHVCyUkJEsTwcYxgkh2OVf0GMfVZNS
X-Proofpoint-GUID: q_Xz1oQo33SX8OHmsNv4VFyOe9VUQjtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=514
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170206

The following chipsets support 2 total pixel streams:
  - sa8775p (on mdss_dp1)
  - sc8180x
  - sc8280xp (mdss_dp0-2 only)
  - sm8150
  - sm8350
  - sm8450
  - sm8650
  - x1e80100

The following chipset also supports 4 total pixel streams:
  - sa8775p (mdss_dp0 only)

Add the appropriate amount of pixel stream clocks for their respective
displayport-controllers.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi  | 34 ++++++++++++----
 arch/arm64/boot/dts/qcom/sar2130p.dtsi | 10 +++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi   | 10 +++--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi  | 20 +++++++---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 72 +++++++++++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8150.dtsi   | 10 +++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi   | 10 +++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 10 +++--
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 10 +++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 10 +++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi   | 10 +++--
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 30 +++++++++-----
 12 files changed, 167 insertions(+), 69 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 45f536633f64..2c85eb2fc79a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4237,15 +4237,28 @@ mdss0_dp0: displayport-controller@af54000 {
 					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK>,
+					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK>,
+					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel",
+					      "stream_2_pixel",
+					      "stream_3_pixel";
 				assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
-				assigned-clock-parents = <&mdss0_dp0_phy 0>, <&mdss0_dp0_phy 1>;
+						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>,
+						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK_SRC>,
+						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK_SRC>;
+				assigned-clock-parents = <&mdss0_dp0_phy 0>,
+							 <&mdss0_dp0_phy 1>,
+							 <&mdss0_dp0_phy 1>,
+							 <&mdss0_dp0_phy 1>,
+							 <&mdss0_dp0_phy 1>;
 				phys = <&mdss0_dp0_phy>;
 				phy-names = "dp";
 
@@ -4316,15 +4329,20 @@ mdss0_dp1: displayport-controller@af5c000 {
 					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_AUX_CLK>,
 					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_CLK>,
 					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
-					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
+					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_CLK>,
+					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 				assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
-						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
-				assigned-clock-parents = <&mdss0_dp1_phy 0>, <&mdss0_dp1_phy 1>;
+						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>,
+						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC>;
+				assigned-clock-parents = <&mdss0_dp1_phy 0>,
+							 <&mdss0_dp1_phy 1>,
+							 <&mdss0_dp1_phy 1>;
 				phys = <&mdss0_dp1_phy>;
 				phy-names = "dp";
 
diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
index b0e342810ae7..96090a948ade 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
@@ -2139,16 +2139,20 @@ mdss_dp0: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index b1cc3bc1aec8..48b6a17dcea0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5012,15 +5012,19 @@ mdss_dp: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
 				clock-names = "core_iface",
 						"core_aux",
 						"ctrl_link",
 						"ctrl_link_iface",
-						"stream_pixel";
+						"stream_pixel",
+						"stream_1_pixel";
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
 				phy-names = "dp";
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index b84e47a461a0..ca188c7f1f26 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3233,16 +3233,20 @@ mdss_dp0: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_prim_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_prim_qmpphy QMP_USB43DP_DP_PHY>;
@@ -3311,16 +3315,20 @@ mdss_dp1: displayport-controller@ae98000 {
 					 <&dispcc DISP_CC_MDSS_DP_AUX1_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK1_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK1_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>;
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK1_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_sec_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_sec_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 87555a119d94..11ea2fa0b853 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4338,15 +4338,19 @@ mdss0_dp0: displayport-controller@ae90000 {
 					 <&dispcc0 DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
 				clock-names = "core_iface", "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+						  <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_0_qmpphy QMP_USB43DP_DP_PHY>;
@@ -4417,14 +4421,18 @@ mdss0_dp1: displayport-controller@ae98000 {
 					 <&dispcc0 DISP_CC_MDSS_DPTX1_AUX_CLK>,
 					 <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_CLK>,
 					 <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
-					 <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
+					 <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL1_CLK>;
 				clock-names = "core_iface", "core_aux",
 					      "ctrl_link",
-					      "ctrl_link_iface", "stream_pixel";
+					      "ctrl_link_iface", "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
-						  <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
+						  <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>,
+						  <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
@@ -4494,10 +4502,12 @@ mdss0_dp2: displayport-controller@ae9a000 {
 					 <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
 					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK>,
 					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
-					 <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
+					 <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL1_CLK>;
 				clock-names = "core_iface", "core_aux",
 					      "ctrl_link",
-					      "ctrl_link_iface", "stream_pixel";
+					      "ctrl_link_iface", "stream_pixel",
+					      "stream_1_pixel";
 				interrupt-parent = <&mdss0>;
 				interrupts = <14>;
 				phys = <&mdss0_dp2_phy>;
@@ -4505,8 +4515,11 @@ mdss0_dp2: displayport-controller@ae9a000 {
 				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
-						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
-				assigned-clock-parents = <&mdss0_dp2_phy 0>, <&mdss0_dp2_phy 1>;
+						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>,
+						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC>;
+				assigned-clock-parents = <&mdss0_dp2_phy 0>,
+							 <&mdss0_dp2_phy 1>,
+							 <&mdss0_dp2_phy 1>;
 				operating-points-v2 = <&mdss0_dp2_opp_table>;
 
 				#sound-dai-cells = <0>;
@@ -5669,10 +5682,12 @@ mdss1_dp0: displayport-controller@22090000 {
 					 <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
 				clock-names = "core_iface", "core_aux",
 					      "ctrl_link",
-					      "ctrl_link_iface", "stream_pixel";
+					      "ctrl_link_iface", "stream_pixel",
+					      "stream_1_pixel";
 				interrupt-parent = <&mdss1>;
 				interrupts = <12>;
 				phys = <&mdss1_dp0_phy>;
@@ -5680,8 +5695,11 @@ mdss1_dp0: displayport-controller@22090000 {
 				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
-				assigned-clock-parents = <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>;
+						  <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
+				assigned-clock-parents = <&mdss1_dp0_phy 0>,
+							 <&mdss1_dp0_phy 1>,
+							 <&mdss1_dp0_phy 1>;
 				operating-points-v2 = <&mdss1_dp0_opp_table>;
 
 				#sound-dai-cells = <0>;
@@ -5741,10 +5759,12 @@ mdss1_dp1: displayport-controller@22098000 {
 					 <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
 					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK>,
 					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
-					 <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
+					 <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL1_CLK>;
 				clock-names = "core_iface", "core_aux",
 					      "ctrl_link",
-					      "ctrl_link_iface", "stream_pixel";
+					      "ctrl_link_iface", "stream_pixel",
+					      "stream_1_pixel";
 				interrupt-parent = <&mdss1>;
 				interrupts = <13>;
 				phys = <&mdss1_dp1_phy>;
@@ -5752,8 +5772,11 @@ mdss1_dp1: displayport-controller@22098000 {
 				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
-						  <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
-				assigned-clock-parents = <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>;
+						  <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>,
+						  <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC>;
+				assigned-clock-parents = <&mdss1_dp1_phy 0>,
+							 <&mdss1_dp1_phy 1>,
+							 <&mdss1_dp1_phy 1>;
 				operating-points-v2 = <&mdss1_dp1_opp_table>;
 
 				#sound-dai-cells = <0>;
@@ -5813,10 +5836,12 @@ mdss1_dp2: displayport-controller@2209a000 {
 					 <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
 					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK>,
 					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
-					 <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
+					 <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL1_CLK>;
 				clock-names = "core_iface", "core_aux",
 					      "ctrl_link",
-					      "ctrl_link_iface", "stream_pixel";
+					      "ctrl_link_iface", "stream_pixel",
+					      "stream_1_pixel";
 				interrupt-parent = <&mdss1>;
 				interrupts = <14>;
 				phys = <&mdss1_dp2_phy>;
@@ -5824,8 +5849,11 @@ mdss1_dp2: displayport-controller@2209a000 {
 				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
-						  <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
-				assigned-clock-parents = <&mdss1_dp2_phy 0>, <&mdss1_dp2_phy 1>;
+						  <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>,
+						  <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC>;
+				assigned-clock-parents = <&mdss1_dp2_phy 0>,
+							 <&mdss1_dp2_phy 1>,
+							 <&mdss1_dp2_phy 1>;
 				operating-points-v2 = <&mdss1_dp2_opp_table>;
 
 				#sound-dai-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cdb47359c4c8..3a21a2e2c04d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3894,16 +3894,20 @@ mdss_dp: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index f0d18fd37aaf..fc7c610c15d2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4774,16 +4774,20 @@ mdss_dp: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 971c828a7555..6a930292edd3 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2872,16 +2872,20 @@ mdss_dp: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 54c6d0fdb2af..b0680ef30c1f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3431,16 +3431,20 @@ mdss_dp0: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 71a7e3b57ece..226c457338d9 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3545,16 +3545,20 @@ mdss_dp0: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 495ea9bfd008..72c63afe9029 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5388,16 +5388,20 @@ mdss_dp0: displayport-controller@af54000 {
 					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				operating-points-v2 = <&dp_opp_table>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a8eb4c5fe99f..e86b6cb20096 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5306,16 +5306,20 @@ mdss_dp0: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				operating-points-v2 = <&mdss_dp0_opp_table>;
@@ -5389,16 +5393,20 @@ mdss_dp1: displayport-controller@ae98000 {
 					 <&dispcc DISP_CC_MDSS_DPTX1_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX1_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
+					 <&dispcc DISP_CC_MDSS_DPTX1_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX1_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_ss1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				operating-points-v2 = <&mdss_dp1_opp_table>;
@@ -5472,16 +5480,20 @@ mdss_dp2: displayport-controller@ae9a000 {
 					 <&dispcc DISP_CC_MDSS_DPTX2_AUX_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX2_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
-					 <&dispcc DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
+					 <&dispcc DISP_CC_MDSS_DPTX2_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX2_PIXEL1_CLK>;
 				clock-names = "core_iface",
 					      "core_aux",
 					      "ctrl_link",
 					      "ctrl_link_iface",
-					      "stream_pixel";
+					      "stream_pixel",
+					      "stream_1_pixel";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
-						  <&dispcc DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
+						  <&dispcc DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC>;
 				assigned-clock-parents = <&usb_1_ss2_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				operating-points-v2 = <&mdss_dp2_opp_table>;

-- 
2.50.1


