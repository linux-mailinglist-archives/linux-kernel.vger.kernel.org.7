Return-Path: <linux-kernel+bounces-853601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33542BDC146
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C0F4F4D40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF530BF53;
	Wed, 15 Oct 2025 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNLSgoLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842492FE586;
	Wed, 15 Oct 2025 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493282; cv=none; b=Jree9VBd20nitu9xtC6ymvx/JCrpXBrxoeOWO086uL3iEHWhOn1kuYFLTl1l+IbxVc43gtn/V6Euw5Mynov6wQHhWUYrrWwRQ/UTZmEDx8PaoQdftedW7RTkmZJxi4B6tdwnJLffoLd+J2bquH7CSIcTleBTXWsD1HZboztlw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493282; c=relaxed/simple;
	bh=GS0YQauLONd3p5WYQTukdWOci8dkHAL5h0CBe+IbjqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udOvt457uPgXBLGZkhQIi6zYOrBlVAy38deHqBsPQZqPaDUB8bwLqjN435weEbaLuCqE4wiJwA6JRRDjGDVPgkyRGnu3i+KZzKyyB5JWSdkxz+k/Thcoyg1qELdnG+/leSwPh8yoa1M8c/TZAUoRFG06WkTBhTCVbm7O6+oKvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNLSgoLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD89C113D0;
	Wed, 15 Oct 2025 01:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760493282;
	bh=GS0YQauLONd3p5WYQTukdWOci8dkHAL5h0CBe+IbjqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GNLSgoLFmE1qKoEEaLnVZVwyuyjAVVbuu/896sG4sKD/p5qBArghbsgv8nYS9+Q0X
	 lX3odzirIzXHGbzt3C6R7Cw2v++fVwznnkx/g7WfZrXUGdjxPHSAAyIi6WB/Ayz+ry
	 sXQbMailopRgwpLhaBvF9n3Gu0Rz2Y+hNdNhRPNkKQBmt4IdcOqoxnlMJ5ArN7wFVD
	 dPr9cD8dV1Gtj/tKoOSYa6d0inQMLnWGmUyGD76Kyp/+ckkwAl//ecEKYxomUexjSe
	 CSwsjn5jpDE219n85NwdudRVmppoFQYt3//XdgUX7BLbrWAwWmqQ2bntmNYQzxnbQN
	 o24rLViqtmPDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E08CCD18E;
	Wed, 15 Oct 2025 01:54:42 +0000 (UTC)
From: Xiangxu Yin via B4 Relay <devnull+xiangxu.yin.oss.qualcomm.com@kernel.org>
Date: Wed, 15 Oct 2025 09:53:19 +0800
Subject: [PATCH v4 2/3] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-add-displayport-support-to-qcs615-devicetree-v4-2-aa2cb8470e9d@oss.qualcomm.com>
References: <20251015-add-displayport-support-to-qcs615-devicetree-v4-0-aa2cb8470e9d@oss.qualcomm.com>
In-Reply-To: <20251015-add-displayport-support-to-qcs615-devicetree-v4-0-aa2cb8470e9d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com, 
 yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com, 
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760493278; l=4674;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=FCeC46MGBCbZzKw6tDNV6y0T6thNWku2Gy7wUdKgq50=;
 b=RQa9VcDbHLUF5irKwNqcYABO75K9ms3QO5oTBVT8vKgnlfmzj1tWxyIGux8FCdoJqSshwCku7
 9VysGTXZ3FhDjt2NsJbwD/yuWfaSUP0HPjGS8VSwmPEooSffWsypzOS
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Endpoint-Received: by B4 Relay for xiangxu.yin@oss.qualcomm.com/20241125
 with auth_id=542
X-Original-From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Reply-To: xiangxu.yin@oss.qualcomm.com

From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>

Introduce DisplayPort controller node and associated QMP USB3-DP PHY
for SM6150 SoC. Add data-lanes property to the DP endpoint and update
clock assignments for proper DP integration.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 113 ++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 6128d8c48f9c0807ac488ddac3b2377678e8f8c3..36a536cef99a095938f3e18a9b5e7825308ca426 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -3717,6 +3718,7 @@ port@0 {
 						reg = <0>;
 
 						dpu_intf0_out: endpoint {
+							remote-endpoint = <&mdss_dp0_in>;
 						};
 					};
 
@@ -3749,6 +3751,87 @@ opp-307200000 {
 				};
 			};
 
+			mdss_dp0: displayport-controller@ae90000 {
+				compatible = "qcom,sm6150-dp", "qcom,sm8150-dp", "qcom,sm8350-dp";
+
+				reg = <0x0 0x0ae90000 0x0 0x200>,
+				      <0x0 0x0ae90200 0x0 0x200>,
+				      <0x0 0x0ae90400 0x0 0x600>,
+				      <0x0 0x0ae90a00 0x0 0x600>,
+				      <0x0 0x0ae91000 0x0 0x600>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <12>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
+				clock-names = "core_iface",
+					      "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface",
+					      "stream_pixel",
+					      "stream_1_pixel";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
+				assigned-clock-parents = <&usb_qmpphy_2 QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>,
+							 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				phys = <&usb_qmpphy_2 QMP_USB43DP_DP_PHY>;
+				phy-names = "dp";
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
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
+						mdss_dp0_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdss_dp0_out: endpoint {
+							data-lanes = <3 2 0 1>;
+						};
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
+				};
+			};
+
 			mdss_dsi0: dsi@ae94000 {
 				compatible = "qcom,sm6150-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x0 0x0ae94000 0x0 0x400>;
@@ -3844,8 +3927,8 @@ dispcc: clock-controller@af00000 {
 				 <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
 				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>,
 				 <0>,
-				 <0>,
-				 <0>;
+				 <&usb_qmpphy_2 QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -4214,6 +4297,32 @@ usb_qmpphy: phy@88e6000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy_2: phy@88e8000 {
+			compatible = "qcom,qcs615-qmp-usb3-dp-phy";
+			reg = <0x0 0x088e8000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_USB2_SEC_PHY_AUX_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+				 <&gcc GCC_AHB2PHY_WEST_CLK>,
+				 <&gcc GCC_USB2_SEC_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "cfg_ahb",
+				      "pipe";
+
+			resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR >,
+				 <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
+			reset-names = "phy_phy",
+				      "dp_phy";
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			qcom,tcsr-reg = <&tcsr 0xbff0 0xb24c>;
+
+			status = "disabled";
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,qcs615-dwc3", "qcom,dwc3";
 			reg = <0x0 0x0a6f8800 0x0 0x400>;

-- 
2.34.1



