Return-Path: <linux-kernel+bounces-744245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C10B10A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9EC5878FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB02D1929;
	Thu, 24 Jul 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6kQY+1P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACC2D12E2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359831; cv=none; b=nIoQmsaV7hTBT8GvY47HTgT8Sy8tRlwBU53PNSNYfqxgjLZqR+vdCqm6ZChsyOYKQ4tIKTmf7JzkRRrb+PqtCsnd2JfWmEn9MVNsxk6iEvndVuVbdhIp/IurzSKMisYOpbHknA0VJZhTw5CQY9mxgFFwcMvOPPru92AGD41geqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359831; c=relaxed/simple;
	bh=+7rEG6UwgGoj08G6XXaFlle4SfuqxrvgXVm/l79VTRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZNzgweQbLqUO4rYOVWJidi1SxSvvNuICNhlhcUGgHBPz2PTfZuS0qSZCY6GsU1Sc25vuCseSaoGjJvREUww3yh6AdgRy41t6U28ZfoB4hOOV6S2xqO66O2e0MU58O8KWkT2fR36t86Y/FM43CJe72WL3r+fInZm24dF0WtIToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6kQY+1P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6dHI9026719
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	twHj3hJ8GTn50gjWaxuTb32l3vii74RiC0GWRYRxMUc=; b=L6kQY+1PUTjA7QKz
	eVCwj7zt3AhIVjxEmvs8ry61NtiOxyxnZhLiY6Cxbgntj47edJvG61J1l1urNh2Q
	SmtTOqm3op9KFxHGOBmIrJSJPOj+GbnwepTbuurp6SrdsAy9rYWcV1K/kC++BoOs
	z0WZ1HBBc8lQDPECuX9jQoS185sfvK5PlZM8bO4cDx8KyM6rFFldlxbp9PvlloWA
	KoaHNDVyzJQaHyVJbl3PSZ9a1noRMDF66m5h70w5PcP3RnicqFDxrHs7R88aHD+c
	7OlZFJVjoZOWQPWbtfoW33oorkuW13JNjwE0MVFsuYKZ0XW21RIj9hWdrC9MAoSQ
	QRTeOA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483frk10dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb50d92061so14948266d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359828; x=1753964628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twHj3hJ8GTn50gjWaxuTb32l3vii74RiC0GWRYRxMUc=;
        b=gNSm2ltH2fah9/jDA4M/mFKI9fnT3eiyetcipcPULd6LChNXJb3XN7XVzMZiCD1LLw
         a9aajMT3C4JqVyQ2ZFR1F5dE+q5bLjrePC0Fj9HMIxbYOqhKh/l+FAiRwPnHVttKUmyc
         +/40/10whbWiP63praa8bFBwSV0nOueklywJbkzlPX5rmrpnrSsth3FG03llZLu8j1Id
         JtVmkJMkpMO8uz8iKefvun5vb6Ec7z9EwnO8GVjgn5TXkrMXRzy017axiLh6h3/6eyCI
         mcoSpljPLLVoT942ppth3GIbnhQjeS97pdWFoEXs/yxPQbnNPPdaz5yG+ipsPbgxqTwe
         Vdcg==
X-Forwarded-Encrypted: i=1; AJvYcCVlkwS8lSfnzdKO129mouLrOv+GlxfrkhIWqTPUTpDqPwHmAHZI5tFrtfzkESxorrzs5iB0uaPrkd/vSpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylURq91iJMykBqulJASJkaPuyikY1Va2BZYDPjbi7Yl5pQ9Hi
	V3jt1Sq3086a7MaI6Fl/GO9yAHFE28qQB1TrmFsOEOlmQKUXUpjJhHmJabIoSxP4H8Eljh26kL1
	tQ8ScHY0+KhmPSuxwFvsaMY9JC7rUlqa5GDtqZgm350CAp3iGdOAGoIxmAPtokeEdJyOUu4piOb
	k=
X-Gm-Gg: ASbGncsJnlIqS2JSYkPPNFvC9v4Vl2RcOCwaGfntAjInVv7kiTZKxpLhA7j9h45P6e5
	u0e5Drvz46Rf/yDWSMVd+ivyqmpII+Gsb12NvxAf35OVbtjoNidrceE+qa6ie7V8u0pVZkN4QRo
	gPtqzQixP4ZafYyzp1JLXtCiIoFX3rpix4VyU/jUOZYtegOzHP8iuXZdGXYIJPMzlsG/U/CBOG2
	jVZe5tzxCwNXVp0qsCM0CRgzDYZLAJIpG//Bfoii2mhRAH9/lhL89qZnGe91yGH0NO77R5bnqLE
	fK6NcjLQyGWJbmQ9YN86NmejxlGOSBH9gk6Aa2bvRDZa8T1WyfKDuvfQNPskFY1wOiGVOeOlg00
	uWkgRIvUIsu4WgmeQcY7bhIM97VHT1gTKX3xdLxyJZSLXJRnlWlMR
X-Received: by 2002:a05:6214:621:b0:702:d60c:94ac with SMTP id 6a1803df08f44-7070080eaf7mr93207116d6.26.1753359827536;
        Thu, 24 Jul 2025 05:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkCdyHb9V+pyKXFjrF91p0v9TsggYPAMYQ7hbjzvsiDiI9avw3WDHHwX1mfH7YY3+YdfYEbQ==
X-Received: by 2002:a05:6214:621:b0:702:d60c:94ac with SMTP id 6a1803df08f44-7070080eaf7mr93206596d6.26.1753359827055;
        Thu, 24 Jul 2025 05:23:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c83978sm327389e87.126.2025.07.24.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:23:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 15:23:39 +0300
Subject: [PATCH 1/5] arm64: dts: qcom: sc8180x: add empty mdss_edp_out
 endpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-move-edp-endpoints-v1-1-6ca569812838@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2381;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+7rEG6UwgGoj08G6XXaFlle4SfuqxrvgXVm/l79VTRE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogiXPmbYSpDlExmSoAWI40hmvkb+nZA7BVq5q1
 jr6bFXC/JyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIIlzwAKCRCLPIo+Aiko
 1XEuB/4hyrDFczpUrl/2zzWulOYlrdL1EmbB7YWFEKFW3bXtU7d5G3aNyZmjQkrhnuknqnailEM
 B+pLI7mzxsWZ3/Y1r51Ak2NHX/PpKjNvXtTEcr8GFsL5m8jxWBwawsMlbz60buquIpNEY0WMq7+
 ZnRKSBE+qZtc7jszrkjnxwfM4HTHdVQfcDfgDMUd4XOq8b1b6pkCpO4M15lhtBAR7wQ50AcuWlv
 Wc+WcCzPFE1AWFIl2nzPxIG+lBE6YvT5v0Ao0e8gzQP1KAn1nU8v3in5IVNovHbI01mWx2VSJNY
 x/Hm+XqWCkFhVvCYv5RcCwsDSvk8mKBBR6qJ94fY/tuChrBh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfX6zRybcLOp3lP
 +mpZIYby7iCak/n39j4dasDmrwAEaqNBnNI+CqnRNAYVDM59DI9SLOdusyuQoiDbjeRpMAsKeDl
 WUn9qgS7hDh/R7B+7Ku9DEk3z1ZVmJq8ZTeTQSd/pQAyaaTuWPkemBvKqkIICrSKDA3so2mO1Ez
 ex/wVVkVpgTn8lcMsdGFOEj3KCARvKJQ65I0MBakSlUpeShsOA9+SXgpqdgHPM7KM2M6R9VPNRE
 f7/xDVoksDhhF/fuGYQ8QmXuFKeOiOdmP/qum7yk/Z9ui4Be2Xx8y/2BzFf2jGSccT/OgbefUFb
 +AJsPFj0pxj4h0/myFEAQUOtn8w9GALr3vOjVOOTIMuxI3hn3k1/oKKiVdB12gZzpAtojb69Xot
 tGTSOzPfegDleKL9RZWmhoh+3buPZDAVXGTPqBrG2GCTyO9Q9ClujsKbvGJr6yGfBkzv5jbA
X-Proofpoint-GUID: 5IvR6eeaDCuCXapvmGIVRAnDlf4SNs1s
X-Authority-Analysis: v=2.4 cv=WbsMa1hX c=1 sm=1 tr=0 ts=688225d5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=MmYJe5HxGHPvegliBMUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 5IvR6eeaDCuCXapvmGIVRAnDlf4SNs1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=886 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240093

Follow the example of other DP controllers and also eDP controller on
SC7280 and move mdss_edp_out endpoint declaration to the SoC DTSI. This
slightly reduces the boilerplate in the platform DT files and also
reduces the difference between DP and eDP controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 11 +++--------
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts         | 11 +++--------
 arch/arm64/boot/dts/qcom/sc8180x.dtsi               |  7 +++++++
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 21c2d25a294506de41f6e8b7197be85c02d03568..93dfb82c36da29cf271a2c0e4e5077f9cc7ac299 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -457,15 +457,10 @@ auo_b140han06_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss_edp_out: endpoint {
-				remote-endpoint = <&auo_b140han06_in>;
-			};
-		};
-	};
+&mdss_edp_out {
+	remote-endpoint = <&auo_b140han06_in>;
 };
 
 &pcie3 {
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index 7a4bd6955470338dd9c7a628c9f9a01de8b480ac..6808226b04e4e6cab77af1a29376ce06d5dfd14e 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -551,15 +551,10 @@ auo_b133han05_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-			mdss_edp_out: endpoint {
-				remote-endpoint = <&auo_b133han05_in>;
-			};
-		};
-	};
+&mdss_edp_out {
+	remote-endpoint = <&auo_b133han05_in>;
 };
 
 &pcie1 {
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index f4f1d6a11960c69055d001a34e893e696ae5ce77..836ac94551478fd728b1229616bbc6494cee336f 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3423,6 +3423,13 @@ edp_in: endpoint {
 							remote-endpoint = <&dpu_intf5_out>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_edp_out: endpoint {
+						};
+					};
 				};
 
 				edp_opp_table: opp-table {

-- 
2.39.5


