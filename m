Return-Path: <linux-kernel+bounces-744248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCF8B10A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3107AE18DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0407B2D323D;
	Thu, 24 Jul 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PIOLyWM0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A52D23B2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359836; cv=none; b=YdD5oR8RgYUPo7jVj3Ba05VhmBwpI2YpOwuvy54gI/ZwGGJ4jyvGK5itFPJEUAVCac1ewDduUO7TOibmmf53mUJZH+a5cUQP8esMYXHWz0Fa/7w4NU2bQpyINUw7q8kOsujAEBQtbD481qzaadPD54p94T/SPlKvV6mdh2spYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359836; c=relaxed/simple;
	bh=EuI9/thvtFKL6WfprMG2xleE4paZXk4izMCIVXagJlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbw3wUTokhHKLiclGRPA6SvTKTK/BFZwhjPdWTJQ2R5lg8DXqa21s0VXRT9mXpOaTp5gYCwM5kOkf/z8bgxxcqjJB2FXaoeWQRQLHM19JQNpWKI6ze34iVHaZoqLuOpWKA/CbLYsrrZcMMp34cBZ9OJOsq/MzunIzhD1zthlTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PIOLyWM0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9tGcA001523
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J+QftWaKB/osBaZNDUtVmDx4bWNK+2AnELwzpqQvp6k=; b=PIOLyWM08OTIU3eK
	m+VbXMEhpC5d2R7hWBSueEpv8iENwZOQJvKcgZtnBCB6UOL5NSH5qboGSuOli9xb
	zEi6/B4q/dQkGDGJmFFaII82EAuzGWzgtPPBDlBfEzfx6RTSu5AUVD0YPo1gzZT2
	MXDxGDalAdBTEzRkZzz9DpTaf9FWKPZeNX9+7IHUmxD3l+DJSVqgsOAGYotz/Hbw
	NV2K3EVcoc1vbEdf6zpdD4NRfbi55uKis78yHQKRH9SbgLTVnhl3PY6D4CHe6guh
	ZrCPyqVXnXFgIKspg956nrJhvbNE/vg0CXc0nglHTrMM4vi9kRfBfoumZ2G/YA3u
	fG/RRg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1uf8xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2e237fb4eso166141385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359832; x=1753964632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+QftWaKB/osBaZNDUtVmDx4bWNK+2AnELwzpqQvp6k=;
        b=wL/nKG+BqxluIg0+AHl57PZJOCetL4eMq/QJSWHWjZxFGIeTVvn2VYWht9k5lyP9ng
         kliV41KPpNlDIT4bHhMwU+ssBvuy0O545Y9wxtKgWi9oZ+noi7ClDz7lL2vWeGTYFs8f
         VVyJcnhpN9CKVge0s1er5DM5v2mb07eFaRlhRacze3G0oCClraT43VdVwYgp4l/uPo5T
         m63OZO9P/9B6iKNK9WQs8xOZZZK+QHxZZS/MVigPwuNpqzVFGJxpmK2jYdl64LbU9RAc
         nAkIpGmtdxwxQtVKBHF39iyWUhBNDnJnKOlHMZpMgAm/y61z9U/YKKAblLAfqZsMvFpq
         ZU1A==
X-Forwarded-Encrypted: i=1; AJvYcCWegwSDCmKGfsPQ0IEYurhc420iAFUuq025GhYgeFln8Yr9CkLII+zrM8QKlfq+WXFPSLkOg0HIv37NBTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVRy+RtkQPJpeGbRbFR2Go714w7JS545J1l1/GRyJkGpJtKhQ
	lCtgAM5whfLgdQM+0MqYGk9fE2CEm8uezlRaOV7BFRzfvZHo870LFDPNrYEo5nwl21SMGbUWpPI
	NUIBjxpyk/Dvw5VAoyASEyOqWJCDxQIr7BioBi7KY4ea80LcKRIt6XfYfF+149oohIPWkD87rcF
	8=
X-Gm-Gg: ASbGncslvsuzt2CPUgiBA0P6teokCmIx/bgv99tIpk+QT6wi9KrC7vbJ94vJLxEUej+
	wGA1jcPOIWT4dSDm+wYfx5+jKwIy8FMZmoXtw42t+2YP2ZeRvZVzej+Sv6zKaoETAH3DUfp7poJ
	4EAsUSO5ET9Yxnk5ey0mFH9CRe44ro2ohGqOpqyODXLcwvDvXcYY2TTdoyCk7jrbA39psi5nl9r
	ji1VC3ZFbG5Mk8122kV0RoNpzYEn9jt+1n9QMID+HLW3G3YFuvB4T3ZNi2awrxFI7YNl10oxpeW
	5D/rAgXzLLL+vQO6elXvUXC6MyYXz/u+zlg1wakEQgjMRaKW5pAm5nJoanRU0i8wE0rFMjyqkhT
	2iy8aFmEAX1gvB2sxkU45ZxuQetX+yfP1K9kHv9NVUw2eKNgBTqzq
X-Received: by 2002:a05:620a:728d:b0:7e6:23df:a467 with SMTP id af79cd13be357-7e62a22bd66mr571811885a.59.1753359831914;
        Thu, 24 Jul 2025 05:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhX/aRU/e8mGLa/wKw0MCJ2/FHpqOwn1pgXhyI0nJ7Du+LwzTOE1ZwuEna0eUweCRjiClzIQ==
X-Received: by 2002:a05:620a:728d:b0:7e6:23df:a467 with SMTP id af79cd13be357-7e62a22bd66mr571806985a.59.1753359831259;
        Thu, 24 Jul 2025 05:23:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c83978sm327389e87.126.2025.07.24.05.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:23:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 15:23:42 +0300
Subject: [PATCH 4/5] arm64: dts: qcom: move data-lanes to the DP-out
 endpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-move-edp-endpoints-v1-4-6ca569812838@oss.qualcomm.com>
References: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
In-Reply-To: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4004;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EuI9/thvtFKL6WfprMG2xleE4paZXk4izMCIVXagJlU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogiXQqjw/9P+QxZOgI2x2Aq80U1AOVl18NyHML
 vgb09s441CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIIl0AAKCRCLPIo+Aiko
 1d6fB/sGNQ3ZBGkoSgDeruLZrGpRDK6Ler0mD51dR6/Mpe2zDDa1c6NuGNWArJie57ewC4zo8gx
 iwI21M5dLWc93PQ9hzTd57F4V+XcEpx3bSFQpUp4b20C020J5GdugNVQpWkGrXXAwVUiDaeFaGG
 hUkhWtfBnYEQF7Qp9ByyajsLXZk1wxBN4o40cDmSBQQeSlPNW5QeUcX6E2e437uogsu8k1Axtp0
 f4veaZ0yfkHdwz+67mGqjemT5ldFG7LF/QBcc6nNQjmRXqX/+o41vPmyhowtc1VvueQ7a3QzPg5
 S37Fu9R7Onz3k5kT6PRDpKjR5iizYZ0R3dX437asfsXB3rXO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688225d9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=u74YbJ13YwR1i87rd40A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfX20/LAmEu0VOV
 a8GnGyIE0gFdnzbjLCqU+8Q0tZo5vM6evPxN+bxLPt7nTOruq8sTi075SkfbYRoK/a2ih22/aCC
 714c4KunycOpQ3GCSqHyRzlnanOgJtQHyo87jI0bRe7+EG4BoDn6NRYu2WStJM6A4dRKxNE1ukr
 Pz3Hkoa0UXhaW2QYJhfCMOhuw3etVtZYqM2DFAYfeDLuIizm0NpQg96uGjFJg5NFJxxALda3RhY
 01R7zNIrfuyz1ZtO7/jVYnd+VRZJESmHA9HL5/lQ7oWdmR46kXsC5sqRgVGVTx11bGWDqs9QuRF
 C+yVEVwraFMfajFbI9b9lSkKwLUF8LEPxseFBjBsKA63iFHjhnq9d47wSiZmn2b443OHRyxciCu
 9d+kJfM9UAL5kcfxakSZ9NUQHeNYnb4ni4vz3HCDaXzELKR4EWoQ/WvCXBGDfKAJqbSmrBcN
X-Proofpoint-ORIG-GUID: MVwvUei1OzZiqhuyM-a6cA4U9PZmmqOx
X-Proofpoint-GUID: MVwvUei1OzZiqhuyM-a6cA4U9PZmmqOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240093

Support for the data-lanes declaration in the DP node is deprecated.
Move them to the corresponding endpoint as recommended by the current DP
bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts            | 18 ++++++------------
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts    |  3 +--
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts |  3 +--
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts         |  3 +--
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index d5015ec4b23d00b5a51c81c99ea46f7c57c3fd13..64e59299672cbf316b4eddb978e4583ff34c0299 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -361,12 +361,11 @@ &mdss0 {
 };
 
 &mdss0_dp2 {
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 };
 
 &mdss0_dp2_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&edp0_connector_in>;
 };
 
@@ -378,12 +377,11 @@ &mdss0_dp2_phy {
 };
 
 &mdss0_dp3 {
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 };
 
 &mdss0_dp3_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&edp1_connector_in>;
 };
 
@@ -399,12 +397,11 @@ &mdss1 {
 };
 
 &mdss1_dp0 {
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 };
 
 &mdss1_dp0_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&dp2_connector_in>;
 };
 
@@ -416,12 +413,11 @@ &mdss1_dp0_phy {
 };
 
 &mdss1_dp1 {
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 };
 
 &mdss1_dp1_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&dp3_connector_in>;
 };
 
@@ -433,12 +429,11 @@ &mdss1_dp1_phy {
 };
 
 &mdss1_dp2 {
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 };
 
 &mdss1_dp2_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&edp2_connector_in>;
 };
 
@@ -450,12 +445,11 @@ &mdss1_dp2_phy {
 };
 
 &mdss1_dp3 {
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 };
 
 &mdss1_dp3_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&edp3_connector_in>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index 672ac4c3afa34011eba6a309148978a777e2fbfa..a70396f250f0cc7509128bd49b3c69e0e78cffc4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -438,8 +438,6 @@ &mdss {
 };
 
 &mdss_dp {
-	data-lanes = <0 1>;
-
 	vdda-1p2-supply = <&vreg_l3c_1p2>;
 	vdda-0p9-supply = <&vreg_l4a_0p8>;
 
@@ -447,6 +445,7 @@ &mdss_dp {
 };
 
 &mdss_dp_out {
+	data-lanes = <0 1>;
 	remote-endpoint = <&ec_dp_in>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 93dfb82c36da29cf271a2c0e4e5077f9cc7ac299..08d0784d0cbb899b021198bd85e26f1a93861713 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -436,8 +436,6 @@ &mdss_dp1_out {
 };
 
 &mdss_edp {
-	data-lanes = <0 1 2 3>;
-
 	pinctrl-0 = <&edp_hpd_active>;
 	pinctrl-names = "default";
 
@@ -460,6 +458,7 @@ auo_b140han06_in: endpoint {
 };
 
 &mdss_edp_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&auo_b140han06_in>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index 6808226b04e4e6cab77af1a29376ce06d5dfd14e..93de9fe918ebdadf239832db647b84ac9d5a33f6 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -531,8 +531,6 @@ &mdss_dp1_out {
 };
 
 &mdss_edp {
-	data-lanes = <0 1 2 3>;
-
 	pinctrl-names = "default";
 	pinctrl-0 = <&edp_hpd_active>;
 
@@ -554,6 +552,7 @@ auo_b133han05_in: endpoint {
 };
 
 &mdss_edp_out {
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&auo_b133han05_in>;
 };
 

-- 
2.39.5


