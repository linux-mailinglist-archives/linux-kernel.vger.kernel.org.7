Return-Path: <linux-kernel+bounces-897474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04872C535FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F734A7878
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3400A34B1A4;
	Wed, 12 Nov 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JB97MKGv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LlaL2ZGq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEA351FAC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958918; cv=none; b=LXzyfLo5a/g+9lLhLWnhkrQlvA36mhIVAAK4mHdLJ9l71TPUH6nC+togaHik+55XC4lTW2egAzE7ryScDXqPuLsGABpvhhYFNYyhFiwZVaFdOH9j4ZW7L+r5Id87n4k6t/hsBQL3n6Z2MJJijLIJwr4eGNYubJNITwLcAribrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958918; c=relaxed/simple;
	bh=Qs4er2hr/+T56uOBc6ouWcD8kx6jWka+YYpKp1dnXMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AzKnIrjgOieAN93ZOQjZEt2reXWkf+wUMkexuZCtfiUbNxdPrqgcKXlHCR2I7tLQCBFAM20lyliTaC7FRBlR74WxIDykVcI/3HkPGhsF7Ru6IOgnA7SrwfsQu40Iq+vpdRVbC9a4pPjOaJ+9L2jhvq3KYnRVG5gneS5Rp/TFu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JB97MKGv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LlaL2ZGq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9gjCG1109249
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+NRoHwCSxaMf980uG4MgVlLpp2Qeo3tytVe/hv/KALI=; b=JB97MKGvC0iOpBBD
	3ILVda37QLgeEc6+sV97Uak7qRVY2bo72Nvh1+9GDnHSaObX6o/d0inkq28MAi2H
	m3eVfYbVKrroCGVMhbc+vvlZUlYsbU2IpvZA2Y9Jl7njidv7Q91/cuowkU+iTGI7
	1nmc7W7QiLjqAGyEy1ExS+M4zot2OowRvoY6OMM4DoFbviTXgY7V1ODwZuffQPRH
	3DCyjWAjORGBpo7UwfKSxRLCXkKDAim9Ye/UpI1FYRJzbfbXiGNKaYky5/K5ORp8
	o6FokVr0TH8dv+W1S2Bkl5VPq/VHwazDtTo4FX2woQJWS/57L+h16jULebn+kLox
	egQlFQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqum0u8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so708002b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762958915; x=1763563715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NRoHwCSxaMf980uG4MgVlLpp2Qeo3tytVe/hv/KALI=;
        b=LlaL2ZGqbCBpC+TucFv5Aickalg8LH7q7i1RFG+K3CiAMMxReiHuFMH1ORwoae6qM6
         CaLz7HAura6+VM3WrwilQRyw1mWdlYe4V+iFvW83PJym/Igqj9T9SdtiS9PqNNJIzbsb
         bnakHP4HGdGjnx/HyXNIgjpM7ei3+dKdFrct/3eBLroTU0dHxlXC9Kw8HVKirUwkb77o
         ZZS4OD2xTSFILSpAS29I5nebvrOhlv9qzbNqu9CFU/bXroe7qqwqOAXqWxMXTeqK8xQB
         1uGbNWemPnBIjq5UujGxhSNmDchAAIz/aHClMA+JV3sPNNV01mtmMvrnvCA684jCn12s
         o05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958915; x=1763563715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+NRoHwCSxaMf980uG4MgVlLpp2Qeo3tytVe/hv/KALI=;
        b=VaMyhJmXO5cVij1IcEx3DKhRe5wN0V+UfMVr1gJODWulPEszWaoRxAJjI9xW7aWbBm
         I9vggqxQnV0dQrZPuhOFz0YB76VlCPSdYD8cKHWvkah+WT9z3jeIAjK+eaTIDttq4n4g
         EMGCk5c/4rHo4aWqM/TJiaZe3S98/uYsJmULaQzZ7S1YffeH3TG4Xbhq0LhEXlUxQ8SO
         T8H+UGIM6VyWvgZrSybZckZW+OXDyJa757Emunt5xV3yQuk9EylyZtcBXfO172kzpVr4
         cG5OVnFkbEG93uwNtfnWW4OEdYzaPuhkjXarZUnBeNROGstopCLIYtn1vErrYGqzPPxy
         JZCg==
X-Forwarded-Encrypted: i=1; AJvYcCVwuQ+VaOwFTOEInSdjCbWt8ppkLXPpjKjpA0v44uvRqKwNKC290iWP8m/9UDVQAga5s1WUpLR6Q86OixM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPBepFXJa3F9jAquQ+rCP3l4KJzD/HOftYv/s56X5SSpfcQGN
	Fz9Hl6plRdgMq6XhkzUW07/xEt/mjKU4TqJ2M9PqezXD62cuiNmftLWN7nmG0iLbH2WJC5k2Uzn
	zTtafT4eJO30B0r5u56WdzkL2vViutVqNjLQrCPSLT//2OaedTYfB0MmgUy4jSBHYHBo=
X-Gm-Gg: ASbGncsMFec39od4zpa4fryLpVarjuFgoFCX8h4sNK0TumPx0RYtPOI0CMdaGwSrMVe
	Xs6bSnWl05ECiMARhTKMbJNV7a1f1Kf2o7/FiVmlyBKOSEwbBgui0M4wdIixgoM2PeKz6Yheen7
	4cfvsP9fwRZ+ks+JtGkKwO0lm00oCwUDlihdEH/0qAQzZ7R10nsIN4bDbw8lAYi+80YZQ62I0V7
	jKveMN2iPe1klsigSeQH4ewHShOJJdvs7jt3xUMVCF/TTCnO63mIQcESviMpczoiZ2Eu5/V710r
	DehvWl4CyMm6MvA20xSKnrZTkc2Rg7OBSoeL4eaoanviq1NOtsR0jLPxCRVjBLBFx4ZVgm+bzXf
	KGgmLl5wmweGfQJieFNVEzg4uaXVwcQripARyfXc=
X-Received: by 2002:a05:6a00:1acb:b0:772:3b9d:70fb with SMTP id d2e1a72fcca58-7b7a55b730fmr3983191b3a.31.1762958914730;
        Wed, 12 Nov 2025 06:48:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsQcNoH8/Bz9doC4REuyQm72O0ucf8zwpssH1d3yrMPbsIFu0id9YEE/3pxyTUQrIJDttbiQ==
X-Received: by 2002:a05:6a00:1acb:b0:772:3b9d:70fb with SMTP id d2e1a72fcca58-7b7a55b730fmr3983150b3a.31.1762958914219;
        Wed, 12 Nov 2025 06:48:34 -0800 (PST)
Received: from hu-botlagun-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17b0c4sm19098234b3a.48.2025.11.12.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:48:33 -0800 (PST)
From: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 20:18:12 +0530
Subject: [PATCH 2/2] arm64: configs: Update defconfig for DSI-LVDS bridge
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-2-6eab844ec3ac@oss.qualcomm.com>
References: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-0-6eab844ec3ac@oss.qualcomm.com>
In-Reply-To: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-0-6eab844ec3ac@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762958903; l=686;
 i=venkata.botlagunta@oss.qualcomm.com; s=20251110; h=from:subject:message-id;
 bh=Qs4er2hr/+T56uOBc6ouWcD8kx6jWka+YYpKp1dnXMs=;
 b=aTdkTjo5QskKOjMfq1dM452l2jeNPiuGe0xeEWvCVwTSXwYvFKzW+TFpbO19OpUOc9NkFOXC8
 0mXQXfuxYPZADWOiyl8uYspS+af95+CZrpSMKKN/7mKbX2p/qzPWbHR
X-Developer-Key: i=venkata.botlagunta@oss.qualcomm.com; a=ed25519;
 pk=/SnYBwlkTzDCLnHFgEY0qFwPgKIV+aQWRbc3naiLzrk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX2L+ORrUEbmno
 NXbgh4BtDET9WjIA3hKsk5ZIg9HZAdkPwj5enSpXrHkGYNkCZHUnL6jooK1N4TzupRIhdBUUZCf
 zcRdClpWoIKIoU/jOV0sc/UuYSiEh6NrCnXaPWkFOA1h87qkw6oITPns6ULrw1uKKk+VvikDNcG
 hnBwi81QYDW0NA5PaoFKHCXIzEUNeOKt70INe4GptZb0ArPvHAx6ymxvh5TVyG29tfURfzE22Gx
 re/DpGZv1XebjIINcFj3GrgyUvE2pXGGRaFppQSL2XPrvYFTc22knEFIeiU2uRTesj3i32P1JzQ
 539qBk4eQRm09aNE9m7Sr/TRUR81TViGlchov0pEPuzpD6H0iVwSe4ep5OLBPAQY3OPzeClCHCU
 pxbllEHckbTAjR9EKcvNru4dqG5LOg==
X-Proofpoint-GUID: ZeqW0FYYzSlQEs9detgYX_VSylgayLe9
X-Proofpoint-ORIG-GUID: ZeqW0FYYzSlQEs9detgYX_VSylgayLe9
X-Authority-Analysis: v=2.4 cv=KeTfcAYD c=1 sm=1 tr=0 ts=69149e43 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=75P26NDa4d-1MZpC9DUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120119

Enable LT9211c bridge driver.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 00d15233a72b..1d35af618159 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -959,6 +959,7 @@ CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_FSL_LDB=m
 CONFIG_DRM_ITE_IT6263=m
 CONFIG_DRM_LONTIUM_LT8912B=m
+CONFIG_DRM_LONTIUM_LT9211C=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m
 CONFIG_DRM_ITE_IT66121=m

-- 
2.34.1


