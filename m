Return-Path: <linux-kernel+bounces-840025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4FEBB35C0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18CF1892433
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15B2FFDCC;
	Thu,  2 Oct 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6C5zS08"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6B2FE57F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395191; cv=none; b=egW1hKzxiDe97Z6M2CaEE1mCjeVbAUBGayvAiJqP789Y8uOHxnTkBwtNc7iwn+je3fqtLpNsGed+DNy3ST4AeUS2Xm1uBwzF7NbG/SNO/O7Vd4sLFs9bhFHbiGxL8KPJ8YqAjq1rdoIUERbCe13WEYygmI/WvcD3cIBAbq4f2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395191; c=relaxed/simple;
	bh=uC/+ZsvsvyQJAsa3f1YZ1SlG+IQTK89rfp7MY4WalD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW3oVPoTZ6VceeXYeEWzn+QX/x3Vh8S2NXFpqHMln7RrrSFG50L5RSWj/GxnFZuNuWrpIkf1ERoICIOpKIL3ev6PFAWN/wIki/z97ozM6xWnp4ScJTRII/t/uTwd+4XF8x3mCNgmPY707EXfCpeG3yQwxZOCjTiypHSA5c/Nu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6C5zS08; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5925kJpT007888
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 08:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BHDP8acxmTfrTc74mGbEFI0EKFoMUUkCRGJ8p0QKX4A=; b=g6C5zS08/lBWHPyT
	Xsre7COafcPH38dV0jjf/Eu3biHSK3ceZBg3yKyjXGzZyBaDpvrC8FtIvEBqdBMb
	UJkX2hnmK0IFC+cnr0wBvaO4JZ3IZEfkNL5zl98pl4KGVY3dN4Yisp5dcWQByhwr
	0S5qG/e1J0q28uvrO06WsJBX2vcQuTyCzAyiYngI4CF/PRjLDmv2qNp2iCEzfr8R
	1eflE77CsRElCGslWf+YORDOg42hvE+Rskf8u4uiRZceuDGA1Uj4W0hzDxdayqCd
	d717hCrgxkxAZUF7L/BVW7qB7OmTGvx2mPtwv7lTX8eqnyYR0RIaC4ARXfxd8x8o
	2VbFUA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49hkhh0e3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:53:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4df80d0d4aaso34156251cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395188; x=1759999988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHDP8acxmTfrTc74mGbEFI0EKFoMUUkCRGJ8p0QKX4A=;
        b=BouaMAKkF+oUzaTWj4FP34/OgiAzmnpsHygBd1yWToUzJkFT3eQQfr6Xuwql+5LslH
         ICVDoW+lrQbQFWYGZGo6BjuZRB9wh54Bmu2vkzCtAHtl8sVYS7Rh24XhVUKHNNeLiXV+
         hGZUDmunzIOWKs5yDZ6sci2nSnvCTisDFR/KJ8PyOuDm7ngT5+5Ux4gzODbADvDvsD78
         gh5Susr/JW+L2Y8SY7wxN7ckmJUfHbhBGjDw+ZBAWvhYdUCcaMhjYxEoQwBfLBEcOi8T
         WhP1migSi+nn73TQytJ5yS0Wh7J/XyPlNAU58q/xE121q+VtL7D7u7l9d7FoslQrs4jU
         f/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX0kuc/b7RPVAAiANB73PSMW3Jpbq3WMI1DAaUySCtiwf3nk/Ylu7RtuJ4VUwui5rf9bi0gQBulj+YEOCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBsE7pGl+FSyIlhDnX4W6CIhNrJ4gaZV04x/53a68WCMmwK7VK
	hUE9OUXoJX0lobuHj+3rjLvI68XcjRQCGOZZYqxnkKIjBVcMVk8dieaydKp4SpxoBaKextafOq6
	Iukpdi4MuFBPwOPKy1qQ0HDqEhStJdf1PP4c1pUU4Bg2ab9e6LDW36RSs8vQLMtZn5jI=
X-Gm-Gg: ASbGncuOWKaR863vGGp7d+Kr2na2MzmZC5eQazUtH6ayYA/5qFC4mG5ssF0Vh701+zw
	bE3kd+mNwo7DH8vbnQwxGJeh7jWqC59Nc/HXfMkigGiCQev2jfDfzRfH2piVLm2cq5goKXX5/tX
	HwhwXBF/bbIL40M3rAzvoI1g5ytDqqa6pkFddxI1dHNPbItT4hl5ZV+DJog9UHQ7QnyQ5IcRpFA
	ySAibFbZPQjzWwz6hjW/9xKwPdQfzl/wXVpvb5mjqMYyoPIgkeuVhmLvAtLPO5oUcutz+yJD7HP
	kGVjslc0N4NYaIoHfkW0y89Se68IxdEkAJLa1J7/FkO2UkLcF4W6H9KM16ToZ2Zbi/3hOoMyNgR
	luFjVIqoT+04t1Z+Q3cMeZzqWPs3PFOvJpmq4j6P2XEUuGCVwVH1jb24fhQ==
X-Received: by 2002:a05:622a:2507:b0:4b3:2dc:8b84 with SMTP id d75a77b69052e-4e41e72fe8dmr85907911cf.47.1759395187534;
        Thu, 02 Oct 2025 01:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaMDSbQXT/X5ft+mztpjyq4k0xqItpkqVhNpbUiMPK3YK4uqfrfHN/vZGFwSso7xrqXEKnFg==
X-Received: by 2002:a05:622a:2507:b0:4b3:2dc:8b84 with SMTP id d75a77b69052e-4e41e72fe8dmr85907681cf.47.1759395186973;
        Thu, 02 Oct 2025 01:53:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba3124bbsm5207351fa.27.2025.10.02.01.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:53:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 02 Oct 2025 11:53:01 +0300
Subject: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uC/+ZsvsvyQJAsa3f1YZ1SlG+IQTK89rfp7MY4WalD0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo3j1sfG2EgDuJQwjqi7G+27lREBjPBYAO2A2jU
 6SVN+meemOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaN49bAAKCRCLPIo+Aiko
 1aLJB/0S8lLBTmGEQl6m62L6x48MDBiCoDpduHypZB2Z7eVJNEJeB1lQKvwio3a3n5ACKyqKpEE
 h7pdqDX7kUaMYu8npni1m6pYUlEYKwVZKZOvJuXrRvi97uWmGFA3gOdpZyuvPLmWl+tVdR9o+QM
 ssTn+co0VP6AkqWdGR2FjV6JNCUfRaQrlJhBPZB48xImF/S4VFsRKJmzTR9dJALNTCEn1mLy5nS
 frBIqx60IY8gPWvRFwwrGdnvGw7sGDwkEoecy0UkS0nfAOD5MQJqjnvFRbWRHLrsfr+/RnhO8U7
 wBRpOVXLqc4um+5T7pRJ4WpxpJFIZPbuTDSoVKfSsXoi+Vay
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: X4WLgexVhPOnMmnIYbKhT5wGO_vyUUbB
X-Authority-Analysis: v=2.4 cv=cILtc1eN c=1 sm=1 tr=0 ts=68de3d74 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CwT6ynrRfNtyUp4jFLEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0NyBTYWx0ZWRfX4ILOz51/0KEO
 W0Ap2fjAymOwJvOAkNeMuaF/7Ap7dnnwudZK01SaFVqtd1XtMyVt1GfmS/4oZuyiFNyuxPZzi7k
 jdC/SFTQMozrjleY6Woa/WrfcW+qbZzzLT0T12qXxseiZgPsXxiToEDUoa0v1fk/uXt1ieRb8YI
 f7rclGhXgyTHLzH5FbpLxOM0EIbEIS/EjXqjlT+VHP9FVbGelIO0x5TGXD14jAGkFoi9ePPVFV6
 UGqAGpFB5B0Ktpb539I1P1eTaxK/+0XF/t638iVcGOjPkr+YUMVwcNyE2iDBw4yen+JWdAHrtu8
 6+ZvKiYGeOtJPjGlRH/zEj9bBcjeNXu58Vbt9F9VFV/tsy6J8pr7zMi6LyqR0Q5iS0z8BOxsUv/
 5TVMLwAg2XFluPbbr7im9xn3qiTODA==
X-Proofpoint-ORIG-GUID: X4WLgexVhPOnMmnIYbKhT5wGO_vyUUbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020047

Add the missing interconnects to the USB2 host. The Fixes tag points to
the commit which broke probing of the USB host on that platform.

Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---
Note: without the previous patch applying this one can result in the
kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
applying them through the same tree in order to make sure that the tree
is not broken (or using an immutable tag for the icc commit).
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c75b522f6eba66afeb71be5d81624183641bde71..33608b1d7d060b0a614357929eb3404bab46ecb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3496,6 +3496,9 @@ usb2: usb@76f8800 {
 					  <&gcc GCC_USB20_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <60000000>;
 
+			interconnects = <&pnoc MASTER_USB_HS &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &pnoc SLAVE_USB_HS>;
+			interconnect-names = "usb-ddr", "apps-usb";
 			power-domains = <&gcc USB30_GDSC>;
 			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";

-- 
2.47.3


