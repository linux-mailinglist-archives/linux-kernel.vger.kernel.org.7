Return-Path: <linux-kernel+bounces-831839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E566BB9DAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D0D7A1833
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3E42ED87F;
	Thu, 25 Sep 2025 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EShHlFp5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E222ED14B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782030; cv=none; b=D7zwzlWyFseiGELqFTR0YAG6s3O08sCBRwsTxbm5WoSwwhV2WzmthmLwGJFTIsRzRm+lh+4/DbzF9QeLMegbf+wW5MBd9nRs+s3EYJN0LIQR1L3g0ySnoIAqwXIUQ1KJpl+3K/rKEnA01YAo0vPsUaINzqncKc2CxfXSHr6uLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782030; c=relaxed/simple;
	bh=gQJ2ZTluSPl0btbHY5JBZLmKAc79qMYc1ayPNK0oRzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJtux4yH3UQ3Xs5yESQl3wHYaxqanVSLvBMdW4Xt10w1D+AYoB/TuqggwH4lnVsJq5eKXLEbGTX8p98WRkCL+t8p/CFg8s673oYOjS1xEcmnkLag3qzlq5kbQRjlKfqrcu2YbwS9bAHi7XV7U3kqRmt7mP1jiAqTlTI8xyA2s8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EShHlFp5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4a776026648
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yYpcbaYMx/nDHjUz0/6uYp++ThN6Ho8R/IOjzK2L/PI=; b=EShHlFp5jJGjED7Y
	nIe1GUeLSr66Av2HpOrqTqt7tlkRtNpbsMUkxqm8SIdHKIVzNC2MQDCPtuwE/I7J
	rkFjvnZT9bjxGR0pUDYoBW4voeLxYzvAzA88rkk/UCm0VTakg+MQUyZV/d1AfnKa
	ewbyLcTaAJJ6g+SRRAhZH4WvvgK2Kmf1aZbR8kKX3DJs0NQwXiDOLalswjOXI0OQ
	zRoCCa440n+sqid5Xfk3wfWjm2kTiqhSeY7OzmNkXuRhLSFF7+WIB8Fu6qdTX4JU
	r2scOQVVOjKiCFYK/heIFl7CS+aYTyfywfDsemYuaKSmYa3HwCUk8Vg348iQuGjt
	UyZkiw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup08ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458345f5dso8652035ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782026; x=1759386826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYpcbaYMx/nDHjUz0/6uYp++ThN6Ho8R/IOjzK2L/PI=;
        b=M2/dovsad4eOxdFe7ixNYFAKgU1Ok2Ym1/vh1Lzck7rEzZ9jh/4kEJvSnk8Vy8PW8z
         dxTJQhxlSYe7HhyTrNv0PgTH4IZaYpkTs2CcE2qq9/eR/0OSIJA5kHADf2FP03Q1c8pC
         9R0qS54GVRTthoLepwMLJWamFvJtdHkSqQZPqzrOyRvav/zeDDtF2j3fnOYBDL4AyEl3
         ZIQNyiV+Wv6TLYqGTnfKGRgj3Zv9VWOI5/b6uJ1LXKJxulq7OI+Hg5fNvBaoQFJgn2gt
         +f67dKXb9NnyNX1epILVW4uG0N8z7NuCAjjW4a4oQJm+yt1c8YYB/ZVSGev5U0isDp3F
         fRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkcg9gauhjpz1WpasWkl4/PB40Q/MUKq0esP/r6hKeCicccoAYv1R4fRo776EwP1wZ3cnMOCX/4nMRUtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDS0VC+9IgQws6+JIeJXag8V5C2LiRdyoW+N/PHu0XW9iaDkG
	zwTXvPucTB0h9tNC01AuvK5CdQVfWnEuikI+Swosu2Z77HFY/NU0opMa41qQj6ExHBQoqjeVq1q
	uoYJcsCw6VJ1Mgkz16AjFTFPHwZCohXl2lE8QGd2nvS/GgFxr5LX7iiN5YJXaJb8FKyg=
X-Gm-Gg: ASbGnctWYDvWPa81Kgn/4FLdeP7Ad1IqNolLudr9IZA2zhLWobLC0QYmZN3uXc6u2r6
	eNs1F4kvaagvIVC7b7TPONLDHq6EWDPvs8php7h3mpXp/ZtOL43Hs9fWInWPliyvLlZ8VPLknfD
	xx0Ml4N1as4Qmw0D/XFE44aDdtoLn2g2tif+ReTVBP2ug77A7PI7nhTis8nECybNWk++dD3PVsO
	+UPgFus8h2RoAHBCWUoCBX6yvz2QvjD7X8hqmWYJqhEivwopgM3gmmhUT5vxCh58+FQv8KMvMM1
	ErK+/vdE0kJnTDVCWAEnyp5n/bRmb4b7iMfzHvAAvlboxjgVqj59Kffhj7URxm83G4xBRqRfPjw
	lsLy/Yfmm5MSf3FrZw1fR4yzfVLQMN5WtEp0ppK2yubjmNzEeq1BgPSRi7hQv
X-Received: by 2002:a17:902:c402:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-27ed49df693mr26537875ad.8.1758782026197;
        Wed, 24 Sep 2025 23:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvM2LDyqLNvkc0nxyhLAA1mDrXFQTQu+3sbzXmRSdxmhazBOlTMhhgZ3KJl7wIoNnhs0bfvg==
X-Received: by 2002:a17:902:c402:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-27ed49df693mr26537605ad.8.1758782025732;
        Wed, 24 Sep 2025 23:33:45 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:45 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:16 +0530
Subject: [PATCH 08/24] arm64: dts: qcom: glymur: Enable ipcc and aoss nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-8-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d4e24b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=f5wZDNqicMbGYsbpI58A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX6Yc7xSEjCf+i
 7EGpsO2aiVqQ/rO5qiYCoS0G1UngKjRrL1hbWSecUn6YZEEc6fzbgYxHQFE4yI17uxfElaqf/KQ
 7NSVuFYpkGSXR8W5J3hzZa9D+AiSXwSIumyHzJXYNmFphGXGP8kC74SovZcitxB7kiE/VEDrGau
 No4FDM0fh+xdVTwlqh/5+2aBE++bs+rYnMQ+Dp1Ksco3A/Nxtfz8iWPvCcEo8kVysnfk6vQkJGJ
 eH3GDxcFsatyrMEGh8Lo2Mh800tqQrdLf8/BfYCtkIQUTiu4uEZYk/IgYV9NTz3Zsuzz/IVMu2D
 AePQ7eSnNp4SCHXQwI0hS2ycMnG8Fnny45VNfBtZDVhvZakbMgcgItOq3RpsSeqOuXY3ELt2zB1
 M9FxGU68
X-Proofpoint-GUID: vZfN_daF0xoRzZNbViSqTvRJo47bPzeN
X-Proofpoint-ORIG-GUID: vZfN_daF0xoRzZNbViSqTvRJo47bPzeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Enable ipcc and aoss nodes on Glmyur SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index d924b4778fd37af8fe7b0bceca466dee73269481..2632ef381687c2392f8fad0294901e33887ac4d3 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -2536,6 +2537,17 @@ hsc_noc: interconnect@2000000 {
 			#interconnect-cells = <2>;
 		};
 
+		ipcc: mailbox@3e04000{
+			compatible = "qcom,glymur-ipcc", "qcom,ipcc";
+			reg = <0 0x03e04000 0 0x1000>;
+
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			#mbox-cells = <2>;
+		};
+
 		lpass_lpiaon_noc: interconnect@7400000 {
 			compatible = "qcom,glymur-lpass-lpiaon-noc";
 			reg = <0x0 0x07400000 0x0 0x19080>;
@@ -2572,6 +2584,17 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: power-management@c300000 {
+			compatible = "qcom,glymur-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0 0x0c300000 0 0x400>;
+			interrupt-parent = <&ipcc>;
+			interrupts-extended = <&ipcc GLYMUR_MPROC_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc GLYMUR_MPROC_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+		};
+
 		sram@c30f000 {
 			compatible = "qcom,rpmh-stats";
 			reg = <0x0 0x0c30f000 0x0 0x400>;

-- 
2.34.1


