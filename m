Return-Path: <linux-kernel+bounces-831832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DBB9DA8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74FD17D83C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E682EB873;
	Thu, 25 Sep 2025 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L2Ya2sVo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484842EB5B3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782009; cv=none; b=R7eedgdJkpumv9g33sUeoJ5R5Tv4te7NC7b5LJvSgwU8wSEy5xaPGHCHvlCVx2DaqPIW873OuaBtgcGmH44QaZidphDxA4GHWKMvqF+F0ognv4XUOSKAhtTxMHipvQQFDFvrTt3U7RtQ1jWvMoFUBQahVQqHCRlq1HRM4Jl7vEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782009; c=relaxed/simple;
	bh=k8/lUZ8NmYXRm+gPL26YcHRuOfJFQtIkV32n92nOAuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmUB/k2AsKIvPy3aTm56QPREFkzJ5VL/Bf36d5rbQltG9Y2YsfLXWppURllZYJ5lxm8Q7Kde+Gg6y0xbKccb5kPDJNJAk5JcijAs4eMHHrLT76i7i87fETZsjkydxuXdbIFsnPsSVuJlRJMGl0nF6ExXLRJazKtXRx9YwDmMAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L2Ya2sVo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0rXuj025092
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h8U5iWeRpBsKn7Vy1xPhS5J0u1ez7iSlyb86KM671Vc=; b=L2Ya2sVoVmF4z2U4
	Q5Y6WlPnXriSAeElhX+f+cTlLEMPMX7IgYIKosN5DvnKi7drIRvK2X6cqCVrKZnR
	I5/+fzvTNXyXIEeUICxg3HtgWbP+S9GSBvaqOBOb2nJpozVfsaT9pI4GtuwBSnDG
	1vr2M7NDVo9I0ve23imjBZIZS0GeSyNdEC+HRpAzcLUBNOAJbN5id/qMPG8KVUmG
	jOPAdYRxU5UtTCsBWo2pHjU8ADyoQigx0woLYZJVCE/ptSNekeo/vEeooZzGWFYR
	PEiwo/Fm0MUCvkQguf/iEtAOpsnRAgYfmjgl4burhzKbi8B4/VF+2EwyALaWZi9J
	On4SqQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeybwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269af520712so8185625ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782007; x=1759386807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8U5iWeRpBsKn7Vy1xPhS5J0u1ez7iSlyb86KM671Vc=;
        b=gsohOPlEDVNeXZdndfvzWzCAkpReoIY+A3yElUKl7OWUYzR9oGWSefcJZmtAg23yGG
         KXa3RiRUvPFq4B/tfPy6NHKvAGnDZqdE4EaihCAHdm/dVZrILMZFsmxbyx6ProMgBPk6
         Iz7V/yrcPeN2g91x1zFehJIjVRzdrsW6q6Y1H78Pw9USoHgvOz1Kw6qiLOOeyDD5j3w8
         RUT4Z8Yfl1TiA6WTrH6ln7EFqZhcSFd/EspKReQWpFuhlLjoDTjeEI6va21MIA+1cCJO
         4wHA504lLfE9zbey5ADGZYQx+eszEex+1IVnW6OpQr5yZxlf5L/g9G+ycFCGOnPVFTrH
         kksg==
X-Forwarded-Encrypted: i=1; AJvYcCUc/yPfcQZZb6H/vpSVDvy3A9UGVLyXI/a9Mq+bQ5WFQkc1N/l7RjdX73uWJVbrrhge4EuUeA1ly7qMl68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxysHFVH7rCmZoPISX/58ZpvRRgyEePLgJjgDCsDa9Shy3Sd82E
	PoUTuYdyEFOTcEwjjZGrSW7xJax4Zu7Ed1X7adI3PHENzJAYo9Hhl9fVx9WVoMN1rFar1wX7oka
	mlZWpMQqOLd0OAgsw/Ij5nYCPsAVsgmG+27SB262GFs5uKtfFaOxD110JOMQNI1CLrH8=
X-Gm-Gg: ASbGncuCl2rZm4DO76DMe5+LaWfahCGiyJQn3CsU7OM4loRyt5cZJ+0pM4y6xlCORT8
	jHV2oVcEL2OYIRe05YULyFRDWnW3i3sakjEhotp8YuZj8BVH/AfMGkiHTPZUU/ytN3Erhiy0JAL
	zf+bv1kZc8HwWCFGWWvMqE5hlwjzkZgMRv88yt2p6Zkaj4aDjv5u2yACyP9bDoDbN+BtsImAXRn
	IxuHZtOCrXsLK6vfmmSsAlKgheMpPadyGmkecmrjmBSbmzdRcYkxJce2ut/bLVQl2IuDRzw7JvH
	jGd4y/ptJxGljbfwVoJQkjCSCL5pOa4/7vhhmLhcRUQrsTyCygJWppWFveze+pjoVV9RD7DVWv7
	cmQxOWQJsLafoRLLsJQlwRCo1r8k4LbBNc4iECeEwFGgu0NuUJbxLZ3vdUvML
X-Received: by 2002:a17:902:ecce:b0:267:87be:505e with SMTP id d9443c01a7336-27ed4a3748cmr24613045ad.23.1758782006782;
        Wed, 24 Sep 2025 23:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbxr43vagnMchkFIiO6iZNE0uvuLG3/tVyJKTSBHe556k0oxn1FxmN9aKvZFXfNnooXpBU0A==
X-Received: by 2002:a17:902:ecce:b0:267:87be:505e with SMTP id d9443c01a7336-27ed4a3748cmr24612705ad.23.1758782006364;
        Wed, 24 Sep 2025 23:33:26 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:26 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:10 +0530
Subject: [PATCH 02/24] arm64: defconfig: Enable Glymur configs for boot to
 shell
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-2-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: CnnKcafRGOGPxvncsWiJ1yCRH8uSuMc7
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d4e237 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=aiTWul_IyTFgGyK2hVEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXyAUl5F1CxK/S
 ljvsIblQfOz7dTtbC0PVh0DshdyL4mMompHeuFAhXQIwjMeifJGvq5zAPcOnJicHnMqc317Bqfd
 Ruri1jXxJG1oxywEmlSBTrAT5SFZODZ3yKKf/2tMe8GokbQY9Fj484EEeWZz04AtdXzlhMI3e2I
 u4ntce0Daaw6JgB5lUleaBzQLPHTglOFwCZDySJ/9DiSGgMkdcbamBwfwJamE2R2YazIcS/wMKZ
 SNT2nnV36pXWV33UOFa2KkfEnG7qTY4LfsS55ciI8GBLQRo8O8DkxNh4Ln9bLTc0mt6/tvm1zg1
 tIHAboYm5GV++tqsFlkv6JrUcB7skgPgWpSk/i5VxcKNd1wk+oL7uptv+0+rIHByBPwjVDswzwL
 yKutmITi
X-Proofpoint-ORIG-GUID: CnnKcafRGOGPxvncsWiJ1yCRH8uSuMc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

The serial engine must be properly setup before kernel reaches
"init",so UART driver and its dependencies needs to be built in.
Enable its dependency clocks,interconnect and pinctrl as built-in
to boot Glymur CRD board to UART console with full USB support.

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..9dfec01d347b57b4eae1621a69dc06bb8ecbdff1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -616,6 +616,7 @@ CONFIG_PINCTRL_IMX8ULP=y
 CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
+CONFIG_PINCTRL_GLYMUR=y
 CONFIG_PINCTRL_IPQ5018=y
 CONFIG_PINCTRL_IPQ5332=y
 CONFIG_PINCTRL_IPQ5424=y
@@ -1363,6 +1364,9 @@ CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
 CONFIG_COMMON_CLK_MT8192_VDECSYS=y
 CONFIG_COMMON_CLK_MT8192_VENCSYS=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_CLK_GLYMUR_DISPCC=y
+CONFIG_CLK_GLYMUR_GCC=y
+CONFIG_CLK_GLYMUR_TCSRCC=y
 CONFIG_CLK_X1E80100_CAMCC=m
 CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y
@@ -1641,6 +1645,7 @@ CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_QCOM_QUSB2=m
 CONFIG_PHY_QCOM_EUSB2_REPEATER=m
 CONFIG_PHY_QCOM_M31_USB=m
+CONFIG_PHY_QCOM_M31_EUSB=m
 CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m
@@ -1718,6 +1723,7 @@ CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_IMX8MP=y
 CONFIG_INTERCONNECT_QCOM=y
+CONFIG_INTERCONNECT_QCOM_GLYMUR=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=y
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m

-- 
2.34.1


