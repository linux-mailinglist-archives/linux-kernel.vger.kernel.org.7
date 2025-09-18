Return-Path: <linux-kernel+bounces-771126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE8B2832C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AC33B48DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F76292917;
	Fri, 15 Aug 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jaGRIs3S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF419F12D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272773; cv=none; b=i+hjyixYusioSQgzgz/FSBEadfdpddzAT2LTAKo/VM3KYdbF7VUtbvDoTcTpJV0kwCC5CpWc/rgHwPUuLOuxt68QXB9kRBN7RBbXflkwxFKKJLje3lHwV422UYKZJw6XFCKe4AbpGfp+ml6jSzEkIugnKe9T9W9Nkh49Dni5HN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272773; c=relaxed/simple;
	bh=AdyPZspn9jpl/n4EThew4HeSZsm3OTTzCIE9ywRTBiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jnSoiq7BrFsxERbsQQwqboC6WTQhtB13EcFEXKsVjbJU5ogCTZ3fqWMyWEfCpYIvWOxQor3cOI7Q0BHIgfi/Fm1lr2pVp0RWsAr92bznXA+V1k/0cKjlmjw7faqoDZiSe4K26dds6EgH2PCOizsC3epFORFOrTOn17OND4lTV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jaGRIs3S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJ2HQ018247
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JeU8hefHW3uk9caYXaFowl
	+wyNewewpbgOtBogE/RUo=; b=jaGRIs3StWainalYBGQhXbQmmoy3H5Gjf9751c
	UM0V0J0KV6mi8FvYH49NFW6/bx5LQCYiKsU2BVZ7l5OHc3asNn462JVTB3/xHMYC
	1e9YQR/7VOBUSFqqqvaytJpkfnlExWApMjlEOU9WfI4zOZQf6Ifof80IppZIUVSI
	q8rDwqa8WPXhFGOLbUypxo09Qp7uws9JqeYMW+muoDTX5OXJerHI2EqtjYGOn5WX
	HTRZZk1O1R38ZXAjQksuZOriHKxburiyEZYn1+CYKFF2jHt77r0WHvC6/IAEUZCw
	3EnxkTmla2g7CeHAeKX3vWO+NkdEBm+Vt8C2lFj19AW6tPIQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxhn9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:46:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a8b32a6e3so41019806d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272768; x=1755877568;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeU8hefHW3uk9caYXaFowl+wyNewewpbgOtBogE/RUo=;
        b=ppFrY4y2jlRY+xyj1tJMOMlIHed+Jk5w03KLqF1VbqcdutawnXIWiEpwrSzUk4taJn
         bMh0wwhaRFSlMuEhW0+qgbl81/Guh/gx4br1S8USEWZD4bkRw98WKjV7Zd55xtU/R/RV
         GUyO+ak/F/JXqndU/XOnj/ocXVxxuRrCLgqExBmCRj5T51DaHoTRTaNDmwOa7xKKTQsz
         nm4IUTDqe77pAJLFqbCcsBOGkD/iL/L1AsTAL0L3P1/j/QmslRW5AVqdTP2kjJWHaYXJ
         2r94VLiIItV/wB4hNhGKEI7hrJQTz2OxGM8UjNJvNkA8CQdsE/paOeX+eLnM6tDt940+
         63Jw==
X-Forwarded-Encrypted: i=1; AJvYcCW1p3XRmoyMSKUNn8mu8xecCZp8gDlldJSb5qRzxpZ7mOQ7yoN0MMrUfqyf/OKo16c/xw2LGYhw9TeKQ50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTDU1WAzcm6ukilX0Jth58SxhGbTrHrUYinKOJvq5VqsQnmSp
	/M0A6NxcvMBUNaTk92+wHxRLaUvRiBMxVLiVGPZR4ZQ8Jy+ERbCP+2FF+XmmQ/7tF21NRkiwWxa
	fP3Sj0BvVtgxB+n5zPeh19qgeaN4jJ3X1PWTSOURTy3Ypr9Xfjg7nB0pFRbV2gQ7/TFI=
X-Gm-Gg: ASbGnctDtryQjmJaU3OEURYtquWItN4KSr2O+NnIzVy6HUbAOpxzVN9WHhD/uJNGx7X
	A0oDXjjpUZgS6P2k23fUlPILuWWV982Avxd4m0lUyzlDlZB5+nzm8OpYROtZte/PiH+bwZOYeKF
	mJiv7XppLux4/Iu4he0Du2D1tbctVmKcxwXJ6DJEjuGvZ9z9fq0dt/5HIb+mjQNxaKWKCqBF0/w
	qIBTYVCTTruJ9gT1tMef0aymskVMyeeNsplGRNu7UHf6djQpfrvgYky0za60cROHc8BLOWQl1r5
	s533lRRlZJ1wg2I03SRtH6WFS+mbWf6PIOwJX6iG2QluQCJJbtnQI0isgoC1y0sS46ymtAhSWL2
	nD4kqzUsdzNEoSvfn5BBD39C8n4gtbA+5sbmUV1PlsYuIKpElzjJZ
X-Received: by 2002:a05:6214:528a:b0:707:7090:5400 with SMTP id 6a1803df08f44-70ba7ae85bfmr28039796d6.17.1755272768439;
        Fri, 15 Aug 2025 08:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRYLaK7tDeymqSjMuecb9APSDwBwGnwNEXCRuRxqk2zC0HT2M9Xfu1AiO5sN8hjfEaAL8SQQ==
X-Received: by 2002:a05:6214:528a:b0:707:7090:5400 with SMTP id 6a1803df08f44-70ba7ae85bfmr28039266d6.17.1755272767838;
        Fri, 15 Aug 2025 08:46:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef368eb8sm346967e87.59.2025.08.15.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:46:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 18:46:04 +0300
Subject: [PATCH v2] arm64: dts: qcom: use DT label for DSI outputs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-msm-dsi-outs-v2-1-3662704e833f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADtWn2gC/1WOzQqDMBCEX0X23FgTtf6c+h7FQ9S1BhpTs1Es4
 rs3ai9lYWGG2W92BUKrkKAMVrA4K1Jm8EJcAmh6OTyRqdZrEJFIo0wkTJNmLSlmJkesbXMsbln
 NMc7Bn7wtdmo5cI/q1BbHyVPdaUItCVljtFauDAZc3FVLcmhhj/eKnLGf45mZH/lfb/rfO3PmJ
 08i3tVF16Tx3RCF4yRfOzr0C6pt275biPvb3gAAAA==
X-Change-ID: 20250724-msm-dsi-outs-dd8e967b1e38
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9101;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AdyPZspn9jpl/n4EThew4HeSZsm3OTTzCIE9ywRTBiw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBon1Y9Ydl8N2on6D7hVo6GoM1ZpeVTOw9tpy+tr
 6A/n9MM6GmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ9WPQAKCRCLPIo+Aiko
 1VQoB/931zHPkfIzBRvpcX9t5//9EnKXMe9w/9YWLSm0ctKWGDwgbrZ42g4pEwKa+lfB3RrfRzY
 Yoblcr3loQC0tcu1lx0rVMn//6HSunKBUjgdrCJlXHtQKiuksRyGqBbyD1wzGXeSwHd6WM9xbm0
 Xa1Zfj14xD08MjF+cQxVSRhm9Xql1xwq8Oc8pL4wf4OzOXOWMaEMGAM4hoaYUQ7aO1oih4RlQ0r
 TNedGA4uAXddzbZBuyH+gcIKy0wWsCwsWKZcK6upBPm3OUD8DDqcFSFdV/XpA8+Th2JMykOTfei
 RcYv23FsFFyn12l02mqC6VMOThgZ3m2YX3+2P5ldD8JBUyKk
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXwRiAUNebxUGB
 8g88jfSjPNHzI3ewwWTu4sGhDnZtAoTyWkrBzpiYniAeUtk9YiGtLkICkQAdOP3DRg+3Yq5OdN5
 l/kHBUy9zGcFxI+xr2Cz+Nv5bPuZ0ci/5QJhSAAnqeoPhdwhVJrZXllA/JC4lSG/9jBqHFzjB66
 xyDP5Wh84rH9j5g6+QurC19Af+kRi4Jg+t9klNkngtnbyU79hqnXNLe31vB1yb6P5kN18ihn99V
 1dSP90SyLzM6Pgz7QtENvxtwxYBDnmfPqvEuZphEQCb62alEp9svhCWY0YYixbRa75n1NscvLt+
 LdYgmCnT5v2hqX+DSbbGdlqgQyiq0+qhR21R8YgxU5bCrz2HqvWFpNszoDI9vucK6/aCM3CccaT
 ATN3MGr0
X-Proofpoint-GUID: 15IX9hNoimK4yx44eNEED9Kug9aJ3XtL
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689f5642 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EQR83U5SduvbdnQy2FAA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 15IX9hNoimK4yx44eNEED9Kug9aJ3XtL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

Instead of keeping a copy of the DT tree going down to the DSI output
endpoint use the label to reference it directly, making DTs less
error-prone.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Rebased on top of linux-next, solving the conflict.
- Link to v1: https://lore.kernel.org/r/20250725-msm-dsi-outs-v1-1-18401fb9fc53@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           | 12 ++++------
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            | 12 ++++------
 .../dts/qcom/sc7180-trogdor-quackingstick.dtsi     | 12 ++++------
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 12 ++++------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         | 24 +++++++-------------
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 26 ++++++++--------------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 12 ++++------
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            | 24 +++++++-------------
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 12 ++++------
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     | 15 +++----------
 10 files changed, 52 insertions(+), 109 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 33ecbc81997c5ecb5606c7555adefd1a53634b80..d99448a0732d9d165be1b5a1b1e15b2424b98b55 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -725,15 +725,11 @@ &mdss_dsi0 {
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
 #endif
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 0146fb0036d44893237520aae5449931f17f1cc2..19cf419cf531f353f17b83b89ec57dac697d5134 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -323,15 +323,11 @@ panel0_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&panel0_in>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index ff8996b4de4e1e66a0f2aac0180233640602caf3..4bea97e4246e160bbd4497551a15a9abe50167e3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -90,15 +90,11 @@ panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&panel_in>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &sdhc_2 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 17908c93652011d69a2d04b980f45f6732f16977..6078308694ac2085b7958704335dd81dc7109e27 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -148,15 +148,11 @@ panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&panel_in>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &pm6150_adc {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 3ec2c7864f1ebb596f1ac2644de58d2f7a2b6faa..8abf3e909502f3c3b82c0ca3d7509fdaf23d882c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -534,15 +534,11 @@ &mdss_dsi0 {
 
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
@@ -560,15 +556,11 @@ &mdss_dsi1 {
 				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_b>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi1_out {
+	remote-endpoint = <&lt9611_b>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi1_phy {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index a98756e8b965fe7aa475271f72c0b73b20fbceaa..63d2993536ade229a84da16e811e8bc83c46bd15 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -445,15 +445,6 @@ &mdss_dsi0 {
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&truly_in_0>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
-
 	panel@0 {
 		compatible = "truly,nt35597-2K-display";
 		reg = <0>;
@@ -483,6 +474,11 @@ truly_in_1: endpoint {
 	};
 };
 
+&mdss_dsi0_out {
+	remote-endpoint = <&truly_in_0>;
+	data-lanes = <0 1 2 3>;
+};
+
 &mdss_dsi0_phy {
 	status = "okay";
 	vdds-supply = <&vdda_mipi_dsi0_pll>;
@@ -497,15 +493,11 @@ &mdss_dsi1 {
 	/* DSI1 is slave, so use DSI0 clocks */
 	assigned-clock-parents = <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
 				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&truly_in_1>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi1_out {
+	remote-endpoint = <&truly_in_1>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi1_phy {
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 480192c86fb7c6981011923ef619b83b7460c78f..90efbb7e3799b9aa75ac4df84fe0006d470ae131 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -598,15 +598,11 @@ &mdss {
 &mdss_dsi0 {
 	status = "okay";
 	vdda-supply = <&vreg_l26a_1p2>;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&sn65dsi86_in_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&sn65dsi86_in_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index e1e294f0f462ac824bffe96615b36ddcd8996d80..0339a572f34d01633ebf09e473d6fdff9005682d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -478,15 +478,11 @@ &mdss_dsi0 {
 
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
@@ -504,15 +500,11 @@ &mdss_dsi1 {
 				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_b>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi1_out {
+	remote-endpoint = <&lt9611_b>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi1_phy {
diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index f9de0e49fa249af52cb3cbdfdabb394815ce82d3..24a8c91e9f70f40247fde6eb63aa5ce58e258139 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -385,15 +385,11 @@ &cdsp {
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l6b_1p2>;
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy  {
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
index cb102535838def8c9a354675545d4f4c988ccd0d..5a594d7311a71f6c5a106683c1b7376f8978cc8b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
@@ -60,19 +60,10 @@ panel0_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@1 {
-			reg = <1>;
-
-			mdss_dsi0_out: endpoint {
-				remote-endpoint = <&panel0_in>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
 };
 
 &spi4 {

---
base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
change-id: 20250724-msm-dsi-outs-dd8e967b1e38

Best regards,
-- 
With best wishes
Dmitry


