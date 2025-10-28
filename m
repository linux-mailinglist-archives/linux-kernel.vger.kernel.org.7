Return-Path: <linux-kernel+bounces-874684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB8C16DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D19884FFA98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067292DA753;
	Tue, 28 Oct 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfdmuA3+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b/ikvQuI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAB2BDC13
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685218; cv=none; b=PhnUHoasec4IaB1aPwm5kVPNr4UKirQrKAqe/437Jt84Mk04Oosv1X5Rg7zjvAhLH/SFQf9nD/NY+Z2efgf8ncajGuKd58X8stlrKUH7ZYqdZSYtvK6kg11s54s96AoO3GoQsoe0WM17wPVPhm+P8/zRaWd0jAuMxyFU/hCSwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685218; c=relaxed/simple;
	bh=XZlVanBK07YsrrAgPlVUCFnWnH1kW6H3soUn83IKxhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URY++LkK36soZQc5/sNvxHNa+i6fOoQgi34LY9q/mWJ40NnA4ATntLm2HawQyeBNa91XgMLp+icFsKPtT7WhU/NEZraH9Gwc+ywwk02VYZTTsD4r9e4/7216xMgPxbbjSW+tQYGErHcCq7biMy9SdZN7uXwekcS67Ftvs8tZGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfdmuA3+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b/ikvQuI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlWdJ2616495
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ztnEZ8z8mQZFEmEJLlZF9ukU00RhQZ/xEw/G6uwQnzQ=; b=BfdmuA3+YsIOLaKZ
	OEmDBEtxZIim0jIMIePePy4rTHY/Tejh99PDKqn5z5Yl6keatB5yoTnu9F2uahRL
	DJHFIvUABnWHIWc+fuHrGM/IhniABjKTD0s7ml76WbyXGVJp4N6bvXi7INJ44xyI
	OOfyZSsqZt/6KoYoCz9ELUwOrNAVSRsNMRG0w8CKlrik7HRquMj5CM/Et2EKPARG
	FJbIT0oica6WY+NVk3QHrw6oexwJ7W+Yppa0yGrTlFlQGPnKXubFb5Lk3TmoTfPY
	DsWlzJhnWHkPt7hf27Z2Zqejf41g7DNX00u62gL6lqR+NiswBrOksJ0LGYXOgHT1
	VbHOzA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0g593-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e892f776d0so291423811cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761685215; x=1762290015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztnEZ8z8mQZFEmEJLlZF9ukU00RhQZ/xEw/G6uwQnzQ=;
        b=b/ikvQuItpK8l9qQocARbG+pDR9D74rWXX4iMDPeE+iLSm5GP1BOuYWVaAAbPLKxLE
         VbAZeRUorKb/ZbYdDZbL646sCmY2aLaDCLCvGY2zVjnXCFBDKITCQ7vbcM/EawSR+Kk+
         WqCQCZA7VImjfGESkV6cbpwkneznwtnHo4o23eKXI+9LdFc424IJ5rNrRPnBnWc+9n7z
         NlEo1wOTF+CGtreTmF78MMl+7Qr3UoYBchgGO5qqgffAt+KMOP3UbHPgcPWlk69K9Wf7
         6lDgPInTnJMO9so0v/s7mTOhGdnJVucUaT+BcEVUAsVpWyBgHvjh7pll9wSVG/ySTeUl
         5TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685215; x=1762290015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztnEZ8z8mQZFEmEJLlZF9ukU00RhQZ/xEw/G6uwQnzQ=;
        b=OlXRncSMTz1CaOjJUW0hA0crfr0wIbg6g/i7Zq53IRCIcpMWtieQANjPgLArn54Es9
         XrCS0wk6sEr4cizU+J/LMAM8NYfV7CrZjivG6PB7OQPvMwjuJr5nmUAhPCLN8E/Q2TRY
         PTMXq3M5pOKNcsZ43O0LO601ntVho9OxXVQVzdHznYRzo3MqaBmfk3b2KEPFLkoyT/OI
         VIqpWcebsxt7j+Q1figaYBuU9CUH+WoncG13Fo/NiFolmPVvUbUluEZWfvLXKGiuwBme
         W8VkB9VomI8siQoTLp3+XfNaiOAOFM0QU8jjltxy/drXFhBTbWUXluHE8czPZZbQ7+gU
         HKLA==
X-Forwarded-Encrypted: i=1; AJvYcCWaHHYkRc61PV3wi/H+rXYekCJyZneLnCZcBWUW9ltuWZlncqGE2S1Gzz7Gn6Yhs296B7bgSWOCDYQPgUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Pc9Imy/gQfoHMuqPeSECJmimRZJB8qXzlSu60uvp1I/FdrII
	KdPAQYxEL8VzmxR0Dy+rAt2Fpt3WAqzNNTRqXo/GACSfSwX4sErNgskoTi9eDRfCZ0XY2BAZbzx
	KjjS4mL7j+nF6yuujmsms+An1bcqrsG5pez4Ea1Baovh4Rqcmh88V7KEveAdkEkke1PQ=
X-Gm-Gg: ASbGnctvXHprG9WdTJXEUCAl1NoE+9EV4v5WKgvJBGX4dZEWvQvP/YVZbbfoTGgJqKt
	K5HXg3owYpCI211HTdKJCygqp0PEP2InavsZ+tW4+IVhq0tOPD4VXGb7DDOZE0bwx306y+hR3l1
	Tyjb7rHcI90UWCsx8cG1yxlwtSbrC8P9nkl39Gh504cAluQnO/C7goOjz5Njwoxeyp8wgAxjI1/
	WlSXC1OmSaZTrvdVL+kXMOUN2t9auxfi2fAnvlzSUiG4QbbYU7hRanIQok1eloLXknpHImXs9ma
	dW0SPe+ZOP74hHSnHU0GZ5eKSiPBNM9LK753TDqTSM9RqNcOlY7uDQl+Ho1ky75FtkyjZRgYH74
	Ab42j6mxZQ/4nFvSRzYH9sDfCoshn+qBsX/VePjVpx1gb+QkVL+cOkYduYzqzzM6qRVaqnRaGxE
	5uI/CVFC0HGskU
X-Received: by 2002:a05:622a:8f:b0:4d0:ac40:fab8 with SMTP id d75a77b69052e-4ed15b4947emr9504421cf.7.1761685214656;
        Tue, 28 Oct 2025 14:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy+ynRMizh5efdzduRYMgWEH8/HKBtFtnCd4b/KaFwqqay4ojtNyQT3m1WxgtDSScIZivIIg==
X-Received: by 2002:a05:622a:8f:b0:4d0:ac40:fab8 with SMTP id d75a77b69052e-4ed15b4947emr9503721cf.7.1761685214025;
        Tue, 28 Oct 2025 14:00:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f861f5sm3283594e87.107.2025.10.28.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:00:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 23:00:05 +0200
Subject: [PATCH 6/7] arm64: dts: qcom: sc7180: add gpu_zap_shader label
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-zap-shader-v1-6-7eccb823b986@oss.qualcomm.com>
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3687;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XZlVanBK07YsrrAgPlVUCFnWnH1kW6H3soUn83IKxhE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAS7UDIYbGe3XDxCxNrS0zAq0+gWjg/uMGzAzs
 718A9UAk0SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQEu1AAKCRCLPIo+Aiko
 1dNoCACg08F4nyNGtHTbnJoxhvSiUhjUDQ0LUe3n5iTPGjsYsXTNaeCOJ/E7hTnBAOHPV4vKWhS
 RBW1luOf3MdIBXy5wc3lHHRKtIcvtlvg//F4+2jy+dMCezDZeeG4UtXamw+kyxpRUNajTLQnMwm
 M8L2J6LIkT9B/sTeA5W7CFyeWnovb/Cd2mcq9CUPTYil63meHsFSbNEapS89kVMNbjW8Wmfsxtt
 O6Ofy4KUcbnLdvy5RJqbRhG4JQFQ87yMiLKpiOOhjvAOcYBxwmKgMAiV2azLGS1+EtCUVrdNwTO
 KJYHJ5KcyhFUtdSyMcZ5e7gLfWHYkyXJ2JyVbIidiLjjCqay
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=69012edf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bRHBWdnJZKEDweV1ddAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: YMsNzv_215Mtz7poIE_y0PdUL3_An0Sk
X-Proofpoint-ORIG-GUID: YMsNzv_215Mtz7poIE_y0PdUL3_An0Sk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3NiBTYWx0ZWRfXxMi6panMBqWC
 t84yiknppf+XAW7jZPRl/hIRZ1yBnIEjWLfWh9NvI0XiqNu3/1E6uD2qaSTMg6RyfT9e9uBhK7X
 ++8J8n4us5dtWmGKlN23WOpEnRaK7CsaXNyhnCwnlky92YfxQNExYDa4Sha38yRBiguoCXSppIf
 MkrX4nAA5HxkVOhr4gIzuryC08SJp9x1OP7r+/0ck6AcQM7gR8zD2ewzekPnIKR/p633LiZTI8d
 6iuRoHBx6Q7qvcz9K46uIFxd08cwgPJiGEGQKEwxVp85/6/a9+YShYHzknk2EItpHC1NMsm8m73
 R/m4SJgd4gC3fsDCKCBcLIehQOGwATZNevfEnyoumqTnUUz/VsIVDGVoq0oTXPxaegOWC+v3NS6
 zZLVhbqJtwOatikp3pVL2Y56dg+TTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280176

Patching existing DT nodes based on full path is error prone and
generally not recommended. Add a generic zap-shader subnode to the GPU
node on SC7180, delete it on trogdor and IDP, two platforms which don't
use ZAP and patch it with the firmware-name on all other platforms by
using the label.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 9 ++++-----
 arch/arm64/boot/dts/qcom/sc7180-el2.dtso         | 6 ++----
 arch/arm64/boot/dts/qcom/sc7180-idp.dts          | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi     | 1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi             | 4 ++++
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index ad342d8b7508c543984f166300bea04b6d7de88f..1514da636269826ce3e87d8c23aad0e37430f57d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -31,7 +31,7 @@ chosen {
 	};
 
 	reserved-memory {
-		zap_mem: zap-shader@80840000 {
+		gpu_mem: zap-shader@80840000 {
 			reg = <0x0 0x80840000 0 0x2000>;
 			no-map;
 		};
@@ -426,11 +426,10 @@ panel_in_edp: endpoint {
 
 &gpu {
 	status = "okay";
+};
 
-	zap-shader {
-		memory-region = <&zap_mem>;
-		firmware-name = "qcom/sc7180/acer/aspire1/qcdxkmsuc7180.mbn";
-	};
+&gpu_zap_shader {
+	firmware-name = "qcom/sc7180/acer/aspire1/qcdxkmsuc7180.mbn";
 };
 
 &mdss {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-el2.dtso b/arch/arm64/boot/dts/qcom/sc7180-el2.dtso
index 49a98676ca4db270ecb55e8f801d0800ef9e4def..6e8da59597b657cf15c68c3a12ab56213979950b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-el2.dtso
+++ b/arch/arm64/boot/dts/qcom/sc7180-el2.dtso
@@ -8,10 +8,8 @@
 /plugin/;
 
 /* We can't and don't need to use zap shader in EL2 as linux can zap the gpu on it's own. */
-&gpu {
-	zap-shader {
-		status = "disabled";
-	};
+&gpu_zap_shader {
+	status = "disabled";
 };
 
 /* Venus can be used in EL2 if booted similarly to ChromeOS devices. */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 19cf419cf531f353f17b83b89ec57dac697d5134..0bce3eefca2e9b14310390f49616873689894ae3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -39,6 +39,7 @@ chosen {
  *
  */
 
+/delete-node/ &gpu_zap_shader;
 /delete-node/ &hyp_mem;
 /delete-node/ &xbl_mem;
 /delete-node/ &aop_mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 74ab321d3333cf8fdca45c7cde2fcd9d34b264b2..b398f69917f0e1eb7f2b1b0a6cb582ecb0c7c5c9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -41,6 +41,7 @@ charger-crit {
  * required by the board dts.
  */
 
+/delete-node/ &gpu_zap_shader;
 /delete-node/ &hyp_mem;
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &xbl_mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a47182994c564e036dba25c772454320dc41cc7c..45b9864e3304b2c0331a27109f7918c327cee5c2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2185,6 +2185,10 @@ gpu: gpu@5000000 {
 			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
 			interconnect-names = "gfx-mem";
 
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_mem>;
+			};
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.47.3


