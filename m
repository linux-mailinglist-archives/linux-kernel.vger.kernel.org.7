Return-Path: <linux-kernel+bounces-831805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE132B9D972
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84252E07C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869392E9EA3;
	Thu, 25 Sep 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="COysLxYm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6A2E8E12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781747; cv=none; b=I6IftYnDmABqu/SCgv0wVHxDZaTjSDgvwkasdYHRbv0PRgr2+CnaQiPE94YYy2xv/VBqye0arrrMXTadLvLTtkLJ4JTqSRzfNGTJvN9UjW83mqgE1Sn+QnB++n152w5Slp46UcPkSHH0Mw5SVMmwC7Ven4MwJtrIQ3GhyD1zK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781747; c=relaxed/simple;
	bh=k8/lUZ8NmYXRm+gPL26YcHRuOfJFQtIkV32n92nOAuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laePZfKm2hr5OP7gYn+aQgWop944heQsrV3k7kUCFuS+jTfELEmEJC8ROGr2ovaMolpbtbIZ4BZZADpzMu8qjSw6fx+Af5RemSOjuIfLWjDrPdqgj15x8GrXmFzsukR7+a1ZK4XR7aj0aj/AfhOnil1GCSre/vTD0s54A8Kj+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=COysLxYm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P17fgE023441
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h8U5iWeRpBsKn7Vy1xPhS5J0u1ez7iSlyb86KM671Vc=; b=COysLxYmhYklZXc2
	eLSXD6x4eTeu+FvaLeNM7Nrtolx27yUsu586tTeyk2p1S1AQWk2mbyIwIT4isWFO
	LPENEkAxkos/abIoSXQTnX0UtXt6HAuQ3+qeNql4Uar9Wv/ADZXS0nj+wBkIrCMc
	RWdpSYSphyNAE/PnH8a3qiAeP4HcNxyTA3VmsfzBF8g5ZhXYqGux5hMP4/LAWVm3
	Tr668enfVR9l2frkjH3OYSnkAIw8q6nd56sSm1u2FgyEthZ/JuUrZgfaoihMGbdF
	4erhl36u5O4hRa3Ll06kzHy96gR60vb40lqcLIH6pv4pJwByHi7xk6DUwrSXhNxo
	th4dJg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaejxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4f86568434so443969a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781744; x=1759386544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8U5iWeRpBsKn7Vy1xPhS5J0u1ez7iSlyb86KM671Vc=;
        b=tszEpFWsAv7p0iQ66pLhpffybrnC4KBwjMMgKpNDgE7NqrgN6p06P0NnSz8AkbsuK8
         8VvvXQjnCaGIRvH1MXr1UjJhZsFYcdhJVeLl85Ofn4VPbXfqo4RdVrzaeBX5w5HIIGo5
         oM2FbbK1MGbeSDZNs/vc6qYoywzmKRLEcEKtiuBIOYkkPyGXVpBGpjy0lbgD5zSYbES4
         1C6hB6F+5LLVOkNmvS2SvySISgihUzii9eno/c2qYZogbPYGjcNiYvRmmWZhDtej0oGu
         kdUjtFkxn0nmkTBxcuKf+Y1IFWE/sEyYohfNZVa/zP/R6DbTMLbPylEYoqLKDAglh5V3
         JG7w==
X-Forwarded-Encrypted: i=1; AJvYcCV2NUEs7/UVG1kLdctNkJCWHbgkAhi9/Sl48dEjEl3lZf6kyIG0jhVfL/DGqOgDNwDx6YecZPwX6ehiHjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAu6++FVxI0SofdTGsu5hhC0jbqvZ3LyshnlWNZGhyh9XK1/q
	VUvxJm4XGe+aiM2Eh9pfHCci0x5ivXWLqymSGPn6zMoG2Er2L8Bh5HhVCSFQ5FZ2sllCBudqZOW
	tYYSRN/FyJxwvxL/JXRNv5meeZPlP04hg/73Z72Eft3ye157msk0x+Ol223twLL0icms=
X-Gm-Gg: ASbGncsbI5qIRQucdtU5Bz6az8gkGhdFud7opQ08cGOibIjIgXUeZnj93DwqwHPGdm4
	u5ouTjRdpJDmZLbFw4wOupqF+ullHMIntMeYQ400UOQ2Vh9yXFINvB8jg2tUUkhmhZ6/hm5OZ94
	/XdJGvHLrwvvOO52YMtrV4VI5t1xZ42UyLD0H0b6OiMHrfAlrd1bPs2kQJJip2f9x93IotuFOxL
	H2OkrJuJe2wohZLWfkH8TGXqc2v72B63ORm5Q4dstmtigFZpSYb+Qm1adjnXDfOYJfuVuz3WtBz
	jn7UBJ5lrJyOJdEOEETQzI2wRclbkndzRiOP5ih8h5bcpQhJdxDNCe1lpCUoeMYpDZ2xvSfZFMb
	5G2R4GTLsA5yQ9CH/5RH/WYWmF2kAl+YbU79rDCz+g2dWVRy1Z3M3GSaPXiTx
X-Received: by 2002:a05:6a20:94c7:b0:2d5:e559:d241 with SMTP id adf61e73a8af0-2e7bfc1d5cdmr2697628637.7.1758781744128;
        Wed, 24 Sep 2025 23:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZAruWImABltoZcRW5GQJY+tZ23nZD6YVmViHSjk2kahcGDCXA3GvIIW/CdRaNG8TLNnMveQ==
X-Received: by 2002:a05:6a20:94c7:b0:2d5:e559:d241 with SMTP id adf61e73a8af0-2e7bfc1d5cdmr2697610637.7.1758781743704;
        Wed, 24 Sep 2025 23:29:03 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:03 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:08 +0530
Subject: [PATCH v2 02/24] arm64: defconfig: Enable Glymur configs for boot
 to shell
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-2-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: UANCoe6B4xaY7ZGiTEaaAbsqM0eU8orz
X-Proofpoint-ORIG-GUID: UANCoe6B4xaY7ZGiTEaaAbsqM0eU8orz
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d4e131 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=aiTWul_IyTFgGyK2hVEA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX6V1rmjoIGCb1
 a+/acmdFDMjV7/ekSqyChcWsP2X+CWpaD/2eCv6F+59eoJpCldpVdNxK3QS+AI5anE03loXsEPD
 yoIwoX+PEaUTz0PIjwx2RIHVLvkvlPrt1NExxP0kB0+Bx3Ur43HUud4YxoIpIhpAV/qUgyn5qx8
 /6GbH5FoPr6ZD34jUv/mSJq5wZb6tPxSpwFeqOrDfQL0YszRYU9iBEvxMh8+MUSC8lNdLDdRDzD
 dugkYJu/fiaUn2vjw0baR9Z5/4akO6jQtOBtOFd6vmgXGLUzaDb3j4rKESJjexdtQhPzwU8QdSp
 Fs4xuykZ7GUDHGtY6geo6HYb5rsylRr/A1efkzhdwuuER207+zpv/FH3qbPPH15Tbn4koikE2Qc
 t93Tv0uT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

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


