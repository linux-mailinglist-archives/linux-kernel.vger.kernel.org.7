Return-Path: <linux-kernel+bounces-744247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 482CAB10A13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA91890048
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA1A2D3212;
	Thu, 24 Jul 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4iEZaLu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAF2D1F68
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359834; cv=none; b=BfOH9VSZfLjz9bTtFhIjptEI0iLZkJQz+bifHYUfQ6hqgbj6BeRcnWY9my8Sg0C8VOCbpNTAUWgHMzA78/1koy6oUmOUvxos08XgjSegbqQBdrrzOB50aLsrj9ZzPmkL3vBcqFYOCoxKbsY2d8q5nZVy+l3usjnFmlz3dCpxpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359834; c=relaxed/simple;
	bh=tkkxGCtXqUN9jHSe8Lo6gt1lUveya4/PYHetGQknvuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qF/NCTAsbjQYJ/g4DVca2szBZdgzzIGOyOhqqSUU2matBe75okeM2x/ySfj+JQflKSHzwBaHIgQgcVmLuNKF1dSBNzFT7HqXHTAJtdLKuD3YUWgzaGX6KTIuIYLqf2P7gXX1YdyzXHa8iEj/3YrotbG+JvV0Ap5Nqmlnw6Nnf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4iEZaLu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9sfBP001509
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RuBUl9EXju5WMUQ/phxrmZHwY8w6ZJkr4i2QUGI+mmk=; b=j4iEZaLu4YI+/NbI
	iBjODkiVmqYWCTRcDwVyjnMsqIKPmxOQNCHBSPobEw0KGcR2od7rHnjuIAv7jMG7
	0l5+R8Zp4+dA6bJBtegcJRlyxliicIf8uHQyiWu1ZQnk7ZhvnvDoSy8Cn6WqRRy2
	ob26tPMI2zcS3YqvFvUz64fttUTrgIC8/L1QuXT/P8yvDKob+i9eGtZZ0rUkPqHU
	kPYJ5IDwq/sEQEaWa0XPCIfZ4g0F8vdFY87P98bKGI5RCgjbqLITzGSfs08eV2zv
	mWGx8x9PhHiWRj5FNb8fI7jU1I7irl5ug8gzIL1+EBKFo9DH1zLW2DEnNKoSsgiw
	E5mHCQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1uf8xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:52 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fe182a48acso36977766d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359831; x=1753964631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuBUl9EXju5WMUQ/phxrmZHwY8w6ZJkr4i2QUGI+mmk=;
        b=Nbq+cd/jvDuS2KVtnhN9IIU1uezEerPV/ToCMflbmuMoBL+montkZF7iwI8v++OhmQ
         J35DjmgSC+fZ+Gxg2XSkEWak+WiceAdWaFhBasQaWhpXEB5N26TGIS1tumWOqoB++SaV
         bE/FdkO4quoBYjtwN83UJrFionY2G/frUT8BLQgyioIPCE/KPHX/vXXbXa7azWlzGHri
         68eY+t440C6nQhaJzddZo3hMc/toqdkzZJAgUEErVFL0pi23CXTWMmu6xnqysalgaCk6
         dutXRBWNwJg4I+S0hXFmfJuikVQxRN7UjSij4rDIxVQweeIYrWh7IHJhA1619a2BQKSC
         cK/A==
X-Forwarded-Encrypted: i=1; AJvYcCXY7wJPeeBMdCxjO1t7zFOjsCLmNUTq52Owq11/W/RB53djnFZvLqG2SQYnQknZHNXD2IE5v1Dl/TRFHvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhE/qckZYuxz0Bm8gN1pXM8s2AHBqg06H+83vhmPI1j+4kvgX
	cFIDawkpHvziwz+5r8t+rijs6E3A/NtOpd2pPQyIW6AZPqDlxxLYezh4pC4DTC7bClhPcmHM2DK
	a8fkAQAmeT6OVwLJ5g4MXzAKgreWr+umJ3/nBbqYn4bHFPqnjH/cHbYORa57hsJ/a/AyQUAazl+
	E=
X-Gm-Gg: ASbGncukHNOi18CYcxNPZ3Wwsw0TvPdYM1MDDBCkpvgCEsOX/kV2WbpexIfjGNCMngo
	Rl9pt+PjK+NsoFUCXcIhp+tvMoJNBu4te7MOjKPXAmN0VOsQFMsz+k2U+clL42y1s2HVqtBujUI
	R6LYnU0VG0/5wi71Zyq3N80+gc40OU68It2Qk3rjEJoAJPzWMuYvwZrNF/u+qJJcXAT39frUP2+
	3XTtz+Z9vLkEIzJpmjpWach1C1VUV9RutAskssmnTCFjkCAFTNzdxlqyf5PKwjaLOqYGHIvGyXE
	YAVs1ssTVWeMRR7dmMF1jMIbOjuZzJEg1Co2VOKp88DEBB5+u4R4WR32z8+XnLgMSAUdcN4pm2+
	lvkAzV1cE4Be7htUW4emc9O5PmWNS9VhxsVy5eZ4ge723tTf7SHXb
X-Received: by 2002:ad4:5aac:0:b0:704:7e76:20ff with SMTP id 6a1803df08f44-70713a922c7mr19279956d6.3.1753359830498;
        Thu, 24 Jul 2025 05:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL5gGCKbWB9GVvJZT/yncSY7XvuHxtP4QRZbKdYL/b/N3++0grti3Tj/wDaHm7EvT9BRn89A==
X-Received: by 2002:ad4:5aac:0:b0:704:7e76:20ff with SMTP id 6a1803df08f44-70713a922c7mr19279216d6.3.1753359829718;
        Thu, 24 Jul 2025 05:23:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c83978sm327389e87.126.2025.07.24.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:23:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 15:23:41 +0300
Subject: [PATCH 3/5] arm64: dts: qcom: x1e80100: add empty mdss_dp3_out
 endpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-move-edp-endpoints-v1-3-6ca569812838@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9297;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=tkkxGCtXqUN9jHSe8Lo6gt1lUveya4/PYHetGQknvuE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogiXP4O5H8lpnSET0UnrKEnCuMv14dDRdhW8tL
 cfXjCDyIm6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIIlzwAKCRCLPIo+Aiko
 1Y7ECAClFvByO+bluap2srPvlu5LeijsUFYEuP7Y8f07sasL5Rq1rZda//XLZfK+Jd217wy0o0j
 gGHMl1xfRdTdWOIhji/PmD9uX2KN+0dTZkpbQpPEp5VI+Pe3YbtKiTLjkPuKDNAkgLIEHjLsuAt
 n+ORudPdlDhB+XZwFOaltzdAZnipmBgea3j4RA2tYjC/QhMRFdzMXa3wgsyE1fLKkdSh5zw2Amc
 Kw0QyYUvlAgALGktya8EnqIawBxhNhLAbAEUL480rp5zClkCFiFaTPlGVXBeuku/6seTP1dxVVq
 TWVVsg+Tdnsn/hFdjAB7rXqYF7LLOy6D1ASpZk4yNXP1+dW4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688225d8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=IZfRD8-qDeMAbltk5doA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfX9YXfJqUeUa/5
 BSRc/jaNQaJpY5WX8+fI78TqrTPXBakY/05DWMdEdMxba4VLSdU/dOYLHD7ah+lczf5+ToK3YkQ
 4hhtTulp39gl1sf2xO2YfmZI425MyhnMaSR9ML+fWiPqDFUG/JC4F6Lri/BHVfFZUf4AsbMtls4
 wcLo5JxJGE93L4Nu0hA8HKBvP+TKcRFziDQzgAir94urOxtiQQFRutLQ2R3rYGR4L5wUNmGKFwy
 lK7D1cKAaaeqzVP5CSKcvhJBHlelzHccWC7+/KUnZnC5IKsIaVr6Ft1W/IgVOy79OSAOIJhSLDZ
 toX2C6H4qGOivNjNIauK24mASe66J3ZNNstCrP/xtbAv4M/14FUt+eQ4Y180Ia20GkEReHL84jh
 ONTEnn37EPr0wVUiGHFzcdHKoHUz+jD7azphIeprtdd+3Hw7FjqV4UwulRTb774WE/H1SxjE
X-Proofpoint-ORIG-GUID: Al2odNz0F25G129ouR-0duj5VY1AIqm4
X-Proofpoint-GUID: Al2odNz0F25G129ouR-0duj5VY1AIqm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=976 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240093

Follow the example of other DP controllers and also eDP controller on
SC7280 and move mdss_dp3_out endpoint declaration to the SoC
DTSI. This slightly reduces the boilerplate in the platform DT files and
also reduces the difference between DP and eDP controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi        | 16 +++++-----------
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                     | 15 +++++----------
 .../boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi     | 16 +++++-----------
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts  | 16 +++++-----------
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts    | 16 +++++-----------
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts    | 16 +++++-----------
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 16 +++++-----------
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi | 16 +++++-----------
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                | 15 +++++----------
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                   |  3 +++
 10 files changed, 48 insertions(+), 97 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
index c771fd1d8029b567dca349f2b0f2013f736c2b9f..16d045cf64c08c02c420787e000f4f45cfc2c6ff 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
@@ -1019,19 +1019,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index c9f0d505267081af66b0973fe6c1e33832a2c86b..be391e9321296782eceb4321c4618c6438d2b1f7 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -1168,18 +1168,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index ac1dddf27da30e6a9f7e1d1ecbd5192bf2d0671e..713b40365ccbc3f2408a5c66769b0c6543e1fa95 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -1022,19 +1022,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 71b2cc6c392fef9edd19477e4aab6e28699e1eb7..62eba17cdc87c088ca471b4cbf5b44af06400fe4 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -611,19 +611,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index fd00d1bf12e165e9ffa0848ba93110348de9a9dd..6b27067f0be66b5c41fa681ff3b4f535100bdf59 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -918,19 +918,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index 8d2a9b7f4730783bbaa81e488a0e99cc195a195f..f9ce2a63767c151192b0618ee2154e8d97316c1b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -1060,19 +1060,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index d02f8d4f7baf0a8e7c1bb95cd4a84ffe24ba8ef1..71becfc5e6f649299b05b0b93cf74b81dea9fa57 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -1104,19 +1104,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 0fd8516580b2679ee425438cb73fd4078cb20581..27dd5e4e9939124360544ee9c59900ebb01f3f49 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -981,19 +981,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 4dfba835af6a064dbc5ad65671cb8a6e4df79758..4c4e8bb154733f3262a4f1b0da5140d6e4d2d872 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -887,18 +887,13 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss_dp3_out: endpoint {
-				data-lanes = <0 1 2 3>;
-				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..9f1908ff0fe1958b52b2fe870d74ee0e480faec8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5597,6 +5597,9 @@ mdss_dp3_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss_dp3_out: endpoint {
+						};
 					};
 				};
 

-- 
2.39.5


