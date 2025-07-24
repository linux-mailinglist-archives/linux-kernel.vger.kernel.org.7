Return-Path: <linux-kernel+bounces-744246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF250B10A11
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156D81889FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726C2D12E4;
	Thu, 24 Jul 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWm3Wxez"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A22D1911
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359833; cv=none; b=Ggse74wfs3wgvjqjGu2756CMOmqszni7JFsxKDkTYKeeS2Usm5AGLX7VxgSgzq65MuM5Za6+Qv0IabrB/ZDx8DFa/pMZzc3vX/END8JhRgg/FsuDROnbdotcWS4AEru6S5/zTbmSnwqdI7Nfa2WdH25IQ9C9UrLuZ1oSPFSxJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359833; c=relaxed/simple;
	bh=t1fsoomQTdKHmSYf4YNAzfz/bTh0dXQlnOCdV3nTZWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMaPcTD/uN2iZ04LFdRDRQ1SJry0GDd4xSpJKYk2QszcMqxQLlPzOEBehg6COaQABdGvjS1ofnx+ufv0wbl5vpeXk/gGJ04YDEJY8oTYQYSloWFUAfsYPbYYgJXCZ7skzsHMJWe70KtLPg85DYfk30ZDO5+iEoWiI9WC6itfcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWm3Wxez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9eQOm015089
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mrBehtJzY/E8cbjcCxObAePzEBB0bFtum/6QBLPRm1Q=; b=SWm3WxeztrB6nlHE
	UG9jowCJc1VqhG6aGoYcxlgib2v3V6v/OTaftCMoH4RJCw/5ZxzteeHerhOJVrZt
	Gb8PCKSrggYl8XNa/uaaBl86DN18bAWEr80Uz7sUgXibbbPfsd7YdcDyauFSJnrm
	wLwK6Opx1jWSSpIPC+kAaTy7jjHevcI8GC9mRDmMsXx/LmxqcmSfbltPKCWSzJC6
	SnXGkX7/l7CLZznaDi07Sj2vFEGkJfGmBrEYJAv0PQgCUxwHx0jav2Z/nUPGULRM
	QMqkblYqtzIoHeKYAloZ7b20/h/A8WD0HqujBS/ckHD4k/87XLE6I9QB5/PeApbp
	PgZU6w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483379ttyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e623a209e0so149630285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359829; x=1753964629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrBehtJzY/E8cbjcCxObAePzEBB0bFtum/6QBLPRm1Q=;
        b=kbA3BBmWDIk4+MFDtJ/7qGFnKHUHv2B8AR92MkNLdWiu+czMM6if3WR5DCqGlCPTEG
         2tN4V+0LgSNiyhGDw7SV+5wbdMd4Hy8QvcAxN0JEk/3x6M4bb24t857KmPQFpTwPFXVs
         6IPwI5Mg4Eodxc5ZRDBPs9hRaGiIOWo+FOq1PcRnh/Rn65jzq5ucoBg98BJd8rK/0Puz
         Wal3gfUf4Y/XFc0Xr6O/EMFhgWzONaCUTt3w5Iv5KkbB57k3N297W86UVdJMmozZNiPZ
         HrWHDKrqL4/teFAzEmp9+9ChP+ROUJspcKLLzmyq5bBa0/vvaya7HdTKLVUdObFFFLTQ
         pSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPWY29aNMXpQwkb9g4S+1T06SnT51Owe2FrsZUzH3M477nv/IdxqhmWIGmU+4jpQHG3+6cl944UD9s8Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPVy0bOyHNPMRX0FlgF/nr+pA90DLENojYfJmcviHzi5tXKUS
	aMgl0kIwWzYeHHQ1GwITdjtjR7pPMTeZ9jS97mk/Ofogb6xOZ/+4kqFErfuWEzJesi4ZBnSZUK6
	BSyERpKlIPqr2Xa/+Hn/JNV9gDXYoBwQbW6HutsSaZ/+m92/MGjQ6Nn4QP7aqH4+/FzzeoLjgYe
	E=
X-Gm-Gg: ASbGncvti+4vZW8WKhZSsrJAD2K9Pvb91tVbfctDupFSNqXAa+DCvgzzBCDq/RXg2nd
	mpgKKSraiFbdl2pu3iph0zVxjUKowHt0Et4FUz6e10Z/0ltWHaMH35JxdwvsxzThmTTJYo6N2tX
	Izuu2dUkBVIiIFwIuOzbKnA/BM40maQ/9tYlrg/JffYk4XLfrc0WKLjyWFRhPuAGnG9gWBZByi6
	ahBnyYt0n61uMhLu0SvjDthh0xblvSpKtvwv7N1IWrr2MTTI65G30nOU54cEIaQJfPhqUXLWVkp
	jcTCktuXEV0CeWsql8ULyV/qP+/gpz0zMbB7LXjihaZkUosA6OBEFoV9YKz3pSxrUpQ1l7PlVjC
	QXaNT8JTyhZ5+MK3CvUc7uMUkBQALS0ay9B39aGRbUkMl6YNlMWOU
X-Received: by 2002:a05:620a:148a:b0:7e6:218e:ff2 with SMTP id af79cd13be357-7e62a1789femr609657585a.20.1753359829115;
        Thu, 24 Jul 2025 05:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsm5NDVfEGrqe2Xi+OqgOl+HBQ8Msm5qkz+/ct4ELlxn4Qw8w8TGfBwCuhKyruOT7ptUncZA==
X-Received: by 2002:a05:620a:148a:b0:7e6:218e:ff2 with SMTP id af79cd13be357-7e62a1789femr609652285a.20.1753359828439;
        Thu, 24 Jul 2025 05:23:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c83978sm327389e87.126.2025.07.24.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:23:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 15:23:40 +0300
Subject: [PATCH 2/5] arm64: dts: qcom: sc8280xp: add empty mdss*_dp*_out
 endpoints
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-move-edp-endpoints-v1-2-6ca569812838@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7509;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=t1fsoomQTdKHmSYf4YNAzfz/bTh0dXQlnOCdV3nTZWw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogiXPmL3Pgb3kEr/G9OsjUqO+tljyHFzYLCTbG
 2dc59s5LUqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIIlzwAKCRCLPIo+Aiko
 1XgLB/9c07xGFrTH9NEkheQDPq08FKWHRYacEDD6QGUhkej42MgsJSX/AfIcWT2xsrxCFdC4Uv6
 7v2AZvYe5P3x8aKUaumyA9TG8g9lNCcSuUALoebGRykM9GcRrTgyNcTkn04p1txhyMjwLaW3ymL
 Obu0oyy7aQyee8rYtm/AqRgUy7S331j8ZdUevBdhR/IbIOFrmySinnkECSI+IMVg7gJLLZrHjuI
 EZ4MejTE6FSXMSvDzwQDj7FwfNLco3EFeo6UinIt8510oFitom2kfz171CAKUZgJi+5OceyOa95
 EW6P72rxt1aVZcvjO81IfP9eptV2pNOOQIQ37q/htds6XVpe
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: I27D-o5TasvXD74h3_M0quFZyT4999k8
X-Authority-Analysis: v=2.4 cv=btxMBFai c=1 sm=1 tr=0 ts=688225d7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Jj94Sfu2rptiHS_jDOAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfXz2H01JedUXct
 qJ5Ue9AP/VM8fOKO4EOzrXDQQkPBqlaLyqRPdMHikd1xWYARI9pNdePrBiZ0/3KM4TF4re50aH4
 5cnpSNghqavyf1YhsVbLbBeuwSO8FP7a7FPeYN4nCNzuU78M9eIUwx4ePdBz4iZ/ZRMf0NEcmMC
 tNZHttJsrOSQSLrAOPmMruSS0sShfidi9BHAW2+vsGcPnE/WkuuXEQ307Rl2QG8zS0nX/h0C/C5
 7OKyNb01FPAvndEujk82BJFU31/vzXTLRVxNUDujsuOJLKu2Atbwn2riWE26LtzLwqwfyKXPO8a
 z09nT7R/6JXgwMZgovSMMrnfml1KVqjZbjjJjae274Elq03nGwwMkHYI2ipa65j+nnXFA5o71dJ
 dvstWEzATOW/osS+geV3gmK4Uz3f1CD4Wzn9e+j5qJNxmTfb8imsYC2DC6k89PxnGcdoOgoD
X-Proofpoint-ORIG-GUID: I27D-o5TasvXD74h3_M0quFZyT4999k8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240093

Follow the example of other DP controllers and also eDP controller on
SC7280 and move all mdss[01]_dp[0123]_out endpoints declaration to the
SoC DTSI. This slightly reduces the boilerplate in the platform DT files
and also reduces the difference between DP and eDP controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           | 78 +++++++---------------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          | 11 +--
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 11 +--
 .../boot/dts/qcom/sc8280xp-microsoft-blackrock.dts | 13 ++--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 18 +++++
 5 files changed, 52 insertions(+), 79 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 2fd1dafe63ce7a4f409d19946b9f10ffe324fba3..d5015ec4b23d00b5a51c81c99ea46f7c57c3fd13 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -35,7 +35,7 @@ dp2-connector {
 
 		port {
 			dp2_connector_in: endpoint {
-				remote-endpoint = <&mdss1_dp0_phy_out>;
+				remote-endpoint = <&mdss1_dp0_out>;
 			};
 		};
 	};
@@ -49,7 +49,7 @@ dp3-connector {
 
 		port {
 			dp3_connector_in: endpoint {
-				remote-endpoint = <&mdss1_dp1_phy_out>;
+				remote-endpoint = <&mdss1_dp1_out>;
 			};
 		};
 	};
@@ -63,7 +63,7 @@ edp0-connector {
 
 		port {
 			edp0_connector_in: endpoint {
-				remote-endpoint = <&mdss0_dp2_phy_out>;
+				remote-endpoint = <&mdss0_dp2_out>;
 			};
 		};
 	};
@@ -77,7 +77,7 @@ edp1-connector {
 
 		port {
 			edp1_connector_in: endpoint {
-				remote-endpoint = <&mdss0_dp3_phy_out>;
+				remote-endpoint = <&mdss0_dp3_out>;
 			};
 		};
 	};
@@ -91,7 +91,7 @@ edp2-connector {
 
 		port {
 			edp2_connector_in: endpoint {
-				remote-endpoint = <&mdss1_dp2_phy_out>;
+				remote-endpoint = <&mdss1_dp2_out>;
 			};
 		};
 	};
@@ -105,7 +105,7 @@ edp3-connector {
 
 		port {
 			edp3_connector_in: endpoint {
-				remote-endpoint = <&mdss1_dp3_phy_out>;
+				remote-endpoint = <&mdss1_dp3_out>;
 			};
 		};
 	};
@@ -364,15 +364,10 @@ &mdss0_dp2 {
 	data-lanes = <0 1 2 3>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss0_dp2_phy_out: endpoint {
-				remote-endpoint = <&edp0_connector_in>;
-			};
-		};
-	};
+&mdss0_dp2_out {
+	remote-endpoint = <&edp0_connector_in>;
 };
 
 &mdss0_dp2_phy {
@@ -386,15 +381,10 @@ &mdss0_dp3 {
 	data-lanes = <0 1 2 3>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss0_dp3_phy_out: endpoint {
-				remote-endpoint = <&edp1_connector_in>;
-			};
-		};
-	};
+&mdss0_dp3_out {
+	remote-endpoint = <&edp1_connector_in>;
 };
 
 &mdss0_dp3_phy {
@@ -412,15 +402,10 @@ &mdss1_dp0 {
 	data-lanes = <0 1 2 3>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss1_dp0_phy_out: endpoint {
-				remote-endpoint = <&dp2_connector_in>;
-			};
-		};
-	};
+&mdss1_dp0_out {
+	remote-endpoint = <&dp2_connector_in>;
 };
 
 &mdss1_dp0_phy {
@@ -434,15 +419,10 @@ &mdss1_dp1 {
 	data-lanes = <0 1 2 3>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss1_dp1_phy_out: endpoint {
-				remote-endpoint = <&dp3_connector_in>;
-			};
-		};
-	};
+&mdss1_dp1_out {
+	remote-endpoint = <&dp3_connector_in>;
 };
 
 &mdss1_dp1_phy {
@@ -456,15 +436,10 @@ &mdss1_dp2 {
 	data-lanes = <0 1 2 3>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss1_dp2_phy_out: endpoint {
-				remote-endpoint = <&edp2_connector_in>;
-			};
-		};
-	};
+&mdss1_dp2_out {
+	remote-endpoint = <&edp2_connector_in>;
 };
 
 &mdss1_dp2_phy {
@@ -478,15 +453,10 @@ &mdss1_dp3 {
 	data-lanes = <0 1 2 3>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss1_dp3_phy_out: endpoint {
-				remote-endpoint = <&edp3_connector_in>;
-			};
-		};
-	};
+&mdss1_dp3_out {
+	remote-endpoint = <&edp3_connector_in>;
 };
 
 &mdss1_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 8e2c02497c05c10a3a5a43a6002467736a3b7f95..bcbd668f562fdfd3558e7138e98ba21987603162 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -548,15 +548,10 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss0_dp3_out: endpoint {
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+&mdss0_dp3_out {
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss0_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index cefecb7a23cf579b1f62ef6fccf9a27a6ea92ac4..0b479e98ba387de8e9d5b2bbaf43e2ed083fb94f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -761,15 +761,10 @@ edp_panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss0_dp3_out: endpoint {
-				remote-endpoint = <&edp_panel_in>;
-			};
-		};
-	};
+&mdss0_dp3_out {
+	remote-endpoint = <&edp_panel_in>;
 };
 
 &mdss0_dp3_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index 812251324002b50f3b48845b6c244f692d42b9b2..29efbef5ef69263e9a59a43e27d158ae8e793ab8 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -63,7 +63,7 @@ dp3_connector: connector {
 
 		port {
 			dp1_connector_in: endpoint {
-				remote-endpoint = <&mdss0_dp2_phy_out>;
+				remote-endpoint = <&mdss0_dp2_out>;
 			};
 		};
 	};
@@ -602,15 +602,10 @@ &mdss0_dp2 {
 	data-lanes = <0 1 2 3>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss0_dp2_phy_out: endpoint {
-				remote-endpoint = <&dp1_connector_in>;
-			};
-		};
-	};
+&mdss0_dp2_out {
+	remote-endpoint = <&dp1_connector_in>;
 };
 
 &mdss0_dp2_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 87555a119d947dca75415675807f7965b2f203ac..421693208af0d5baeaa14ba2bbf29cbbc677e732 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4526,6 +4526,9 @@ mdss0_dp2_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss0_dp2_out: endpoint {
+						};
 					};
 				};
 
@@ -4598,6 +4601,9 @@ mdss0_dp3_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss0_dp3_out: endpoint {
+						};
 					};
 				};
 
@@ -5701,6 +5707,9 @@ mdss1_dp0_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss1_dp0_out: endpoint {
+						};
 					};
 				};
 
@@ -5773,6 +5782,9 @@ mdss1_dp1_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss1_dp1_out: endpoint {
+						};
 					};
 				};
 
@@ -5845,6 +5857,9 @@ mdss1_dp2_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss1_dp2_out: endpoint {
+						};
 					};
 				};
 
@@ -5917,6 +5932,9 @@ mdss1_dp3_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss1_dp3_out: endpoint {
+						};
 					};
 				};
 

-- 
2.39.5


