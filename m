Return-Path: <linux-kernel+bounces-874679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EF7C16D74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57D244F3458
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73867350D68;
	Tue, 28 Oct 2025 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bOhALAsD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/ZaxSTW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6308350A22
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685211; cv=none; b=oiNuJDsXmR9/MzZjMbEflebc9iuapadoVXygUt7aK+HZV/U21wwARkJXJvbKSucNrV5bUeeJNlWiSoJYATNcQDEpdkT+kB2O6s1n3SOqaU3GQsEVzDK08i/KBQEf71BzhLqamzvDNmow1npRhC/OYXI3P3irb/W5J7qarCB6GuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685211; c=relaxed/simple;
	bh=ngFuqL8e6vn7AeTmEciPRYus7VIaj3l4wQX40ezMA04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmkevY2vzTR7h50JdKBjVt3pRxLWozCrJZ6SF+9UD7xwXmRv4hxXs3HJR9IyG8+orxgC8FofTjwgs2Qh7vo9GCdYc5Oa03/XwxWfbVdLgbIoFS/JUdprIvYTOo03si7TiB+2RuQpRWJ+MlMmII9dws9f691WyxdiyYdLVIvaoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bOhALAsD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/ZaxSTW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJllFA2524097
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aOiNxLQmP8RoIKFStjGNuJ1SrPaHoJhdU4dMQ0leeQ8=; b=bOhALAsDQwhakDi9
	EZDpAj8U+U8ax2igbc3RGTyoxD4T0c046t0Trq+w/xWHraqQ0i0U9dMoHxLVYBou
	PSmUMUkjD8B3dY0N7fDQ9w31Bg0lYP2xXt3IIe+jSyew7u2SLAbQ/u6pCDwIHO+g
	pCgXSbYghX3vLbnBkuwbD0ty7ZJuK54G4e1K0kRJSIzYyY4c2I3xL8wEVS+jhX80
	ygSzdZqynnr2Z1g9k6vpPBRFvLiVhbiqfbFpriwDinAw8WvafwN0fp4PUfP0t2/M
	cWBJteWaBmQ9GfHR8BeVgLkKJnvea4CPFm8fk/rzv91ggEpnDQLtSB8bFBRsglVi
	DgTDjg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1r5tk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e88ddf3cd0so175293801cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761685208; x=1762290008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOiNxLQmP8RoIKFStjGNuJ1SrPaHoJhdU4dMQ0leeQ8=;
        b=Z/ZaxSTW2i54IHDl0YN7s9T+B0FoRYX4d71imw3ZzfHXYK/d/pJ/v4vFElXB4lI6UU
         U7NyRTfT8neUpjCSqWxdF2GySqsIXsJzxOTQ3WFIpUK8X3xcSMQM/eoJWlMn7FIuQpm/
         ZFAPH/78Gvxmq6JJKnV3YThwdpWoBR/Qz2BGEj7PGp2EsVTjhEXAIiIK3FKsj2E2j7T1
         qWMLaXs+nStxp8qr6eWvSx0IwK4rwSjyJKprbrt6ou0doy3b1KoFkzjnN49n+z6t4YMW
         Nlbyw//MHHreNZr3ZoGTeQ1mESZ8yghasb0BGRp7GcJgSCEX05OGpFvHhLS7L9xcKl9F
         xBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685208; x=1762290008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOiNxLQmP8RoIKFStjGNuJ1SrPaHoJhdU4dMQ0leeQ8=;
        b=rlv39EIb4Owf7lo7votxfxpV8sUWV2Uy5GxIL6arSyPfQiO5j5hdIeSaJg7q3Gvxoa
         qo1lytj2hmf6WHSxw9i579k9ZLMD26rd0YjPnJ6k1VPyNzZDCtVq71kkzIFsBKkuGZ5b
         koqU1ll3hFJ4giAxsQcs32qupHbZ65f/hspci/bL0Pvek/y4EmQ52iL558cjma9IoaVK
         Xc7ACbdQ+9NHlc5+pahB9m229QlzZFFeuu2MmnJvBYYpENKRZ+Jyf5SRJjGMiq6r6cRp
         9KFoQbU2bjZHSZ3nudh97t4SOmfirV9/K4ywIrvQB/FbDnEj29h+MfMRiBTWIdT7rTWY
         wthA==
X-Forwarded-Encrypted: i=1; AJvYcCXkiTqDeF85PB11NnjvgA2jxwu2DEIzBXs2jPWGoNeTmgodLVVPI6aJimDHFy2Ls5UmwtI/Rmo0i14cCd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5EdDQXEQcp8Zzc8bbz8fLK9QS1nO9EsM1mKCt+eH3L/l9IhN
	HFlQSgFZVtFg/1nfo7QOzkdBEO3JKy0hb2nXhJ8AwOQ91nMph6smnBBSCU+bAyVMnfTc24k2Ond
	dvXIrvtcdzRsyP1AlPzwaBayBhE42Ag680SKlOunIjVhJS8MLNn9ewJ5xnibRtpuus4s=
X-Gm-Gg: ASbGncs19S7J4563sSzd1o93MMBwVB4XwsJO95gLylr/04jKKjfZEXZbCoY+yIx3HII
	uCVr+eGsLIdZPHYgknzeR0YGOZXqRHEkddDU2l5C/X0020CDUze/fBm7GGgGP9jpB1MyHRE21u1
	qVHIe2IztxOa8B0e/GsupUSVsToxU1evF7au8NAjr0qBhB/FlNMnw5F6DZ/MvhB8WJoRBTQPg76
	0Bzps7dE6/4PGIBq8/iYS92+YqUj+J+oepA67ohWzHnNTC+UThZxqH3HfxLf1uEmtmpIA/G9I5D
	66TIVuJg65ZpNEjWKHB+7lbtFFMeQN2ierxx58tJqRr/IcJDxs0cibJbSet3gMe11c+s0ZPg7vo
	nCjdCjV5ZaW2lAvIxEytbDqkYYn2ToozxfEb8MNq0ZG8OImUFKn5v1B4OZxxiEEggFpENYNZxdF
	1bOTyU8t7sZfYS
X-Received: by 2002:a05:622a:11c8:b0:4e8:9c45:de4b with SMTP id d75a77b69052e-4ed15c88d01mr10638431cf.44.1761685207741;
        Tue, 28 Oct 2025 14:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlnuhRA+a2bwubA2labJ4tMSfpNg2VOPqsfAoc82W5MiPjYfnN4MLZt+qYb2juROwA9rbEFA==
X-Received: by 2002:a05:622a:11c8:b0:4e8:9c45:de4b with SMTP id d75a77b69052e-4ed15c88d01mr10637891cf.44.1761685207269;
        Tue, 28 Oct 2025 14:00:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f861f5sm3283594e87.107.2025.10.28.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:00:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 23:00:00 +0200
Subject: [PATCH 1/7] arm64: dts: qcom: sdm670: create common zap-shader
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-zap-shader-v1-1-7eccb823b986@oss.qualcomm.com>
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ngFuqL8e6vn7AeTmEciPRYus7VIaj3l4wQX40ezMA04=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAS7StKy5BloAfwDT3vMyJtx0pNXwptmkf9FT6
 ZqABp785xGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQEu0gAKCRCLPIo+Aiko
 1cTfB/9WEbl4yKd7GmpkNHWAo0vRfwuV/5D3e7GAwwsXoYEPJHfBLWWuxcGY+TzG7rB6zhG5pBc
 9kuTXLC7AkDG1rAO7vjZzi2jKXEjNa+xphnJB+6OnAzkGAxBFm2IDsLY54TBoA4UfG3J+9RmQEE
 cMRnT1//qL9+B3HpetBvAUjoqp1e4Mbb7G17vID73K4ibzPt35IxnCvmXRVO9SLtOxMvlLTwzfG
 3Aoxoo+sWYVG6vrvwLw2ECeI/yE6/EH+ChFgt8bslDgkqfaGpQ/1SKs/oyix+tGgnB7hz1yTOiD
 9DyW0vp2lH5Eyi9YPTCvbBoGxUitSGukfnLhuSkjFMnvkp1P
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: h_-XLZAIHc9kAt2WVhwyGxjkjWr1fFWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3NiBTYWx0ZWRfX8djva4C/WKXr
 fxTwZuveHKDNEXxat+DVOVHCOg9FEMb3c6HUuU4LGfssvZQg75s3t84GG+XYbb84+A5LwWifU+7
 kOeZvJErJLbSLMkSpTq+wNo5wnt/GpeXkLvIu7iGffDNxcjkneYcZZJ0BcHCC6ActaS4TA+pZ+n
 gptjM0wrPwUbWn7ZtBciTgm4lBD1zRF4cIaDPiGgh0hpR6gLO1QsMIIEBAfBgcQnSeneemxMeSF
 pNgPW96x3vl3s0Vg2XYz4xOmDQcZUkof7RiPfpQy3PK0D+34gDZeCcPBxDvuI9hI9bbCN5Rg23s
 N6r1j3uleq1JITe2+HIveD3k0hf4NLDCPI3RnG2hhpnktfAbXTJQr7OrRbWcfX0W74kD1iUrgUb
 Y0RrAghMjkIm/DfY/sPOOr7OimOwNg==
X-Proofpoint-ORIG-GUID: h_-XLZAIHc9kAt2WVhwyGxjkjWr1fFWn
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=69012ed8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OJPj2qZnrzgMreAcce0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280176

In order to reduce duplication, move common GPU memory configuration
from individual board files to sdm670.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts | 1 -
 arch/arm64/boot/dts/qcom/sdm670.dtsi             | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
index d01422844fbfdec6b4944378a16d9458a4c00bba..760f21f19ca472d620ab1a0703de6e0d69237b55 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
@@ -406,7 +406,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm670/sargo/a615_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index c3264a31bccf25fca9eae7fa7734ff43c9db410a..57a3ffedc432b08aa7d7918c9bd0f9714dbb3951 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1382,6 +1382,10 @@ gpu: gpu@5000000 {
 
 			status = "disabled";
 
+			zap-shader {
+				memory-region = <&gpu_mem>;
+			};
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.47.3


