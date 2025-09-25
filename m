Return-Path: <linux-kernel+bounces-831836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9ACB9DAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CEA3B26B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE92EC0BA;
	Thu, 25 Sep 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtBbMGOI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176402EBDE0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782022; cv=none; b=lSEWUW5qWtNat1Sn9EhwKuGW3as5fggfm1juauizRbIFZnNyeEjuyOS0s+wR2VORG76Is53LuLkR/Vr94Ji1Jt/3b2+RmK5lIIQ/OwZ+MTiqsyDPaLuepEMTDif/h80Zlp+CXUFsBqGgdw6q9fPdE+cS0k+J501hP5OnxYchu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782022; c=relaxed/simple;
	bh=D3joMpRcaeR3gLLXU5PCwDBHjh3jgbSRLlNslB9/hYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmUCX107MaDBBexapPnN9BG19ZDUobw1I3iNl7GyYnE1A6S8PlT/VP5B91L0IPYftrpfTcLuMMXvx+jBBKJ2a9pJ+fNNyj9bgHeedcoXJHAuihDGV4rckV63mQZoYuY7orxoQI/orhTtwtz9ReG+LLjjKe7qolaXfxo6PIFOe9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtBbMGOI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0t4bJ029720
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4p33NgPxej04es67Nsx769+T5sIjjSqFb0zB/Kwm1+U=; b=mtBbMGOIfkJgAr9D
	haLftSO5c95Rgo9Op2MNtfZdUhDI906WbgxGjjP7fSwSyR5aCrv9IzavVGtgvkqo
	C0mhf5jkBKkXDH8H6Sa8rF+baFxfPgdg3vUZw2U/5039TMq1vZiVzrQm/VsgnBC5
	ixkgGm9ZrLTkdq82gRcurIgybL/J5/zrWZjN1CpTGOFJnF5f70b4BuM9Apd60dbx
	g299PER+d7dQZFORsctT7mWeX+/38lTsT8vISzTbZ0ed+fQ0k7rGg5XcucrNTmfC
	mjcOX/JIF50+X+0WZRRzx5HBemKYKnCAQeyOQF/1YCfk2U7NvkHfRjDHriB83iiE
	CxmDnQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpwtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2711a55da20so5190785ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782020; x=1759386820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p33NgPxej04es67Nsx769+T5sIjjSqFb0zB/Kwm1+U=;
        b=Lia2NZFNJn39l80fDDNObiO6tEuHz8StGpFSUf8MxSeZU28iNTTjP5Qa9TRbt9ULRx
         ZyTmGlJnG6IWoogIm9EdoCNPioewwOopNhyRkqCsFcdxhlXjrZX8+m1rMxIMeZChiWE6
         EP3N4oCm0k14FfpT8X9rXlwVHTGEE9W0Rh5yP2mmaBl5sM7AbOl1QJPBhWIUYY/Za4rL
         V/iXLHcynJYSklmc/gqKC/zLjeB8xVVPV64JY2yMDz9KZQ1FSPtnZ7KLhnwzrIG5ZX9q
         uWFF0AHLTN59md0+9bzK/frU23J/6bCnSIg3/ry5MMSE3MRj+MMg98161zPHLvEevCuf
         VDaw==
X-Forwarded-Encrypted: i=1; AJvYcCVr2IHaOdgzLWRTQL298WBBOINUUp05+i4jMW/SMhucacuVNjLGDqXn29PrCIf2ocQk/m90tOzmh5UQk8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFAvtKykLLAYklRfY4Ag/6mEq6qViU5eCKwCl8OeI/qziJ6ic
	zWDFt1GyXpRirSJW82ZapJ4NbIA/BniSc/e1j0Zx2NLSeqJklKWCIeFbjcpPpQ6oB/c6ngGNwzj
	+QHcG53dayNpymd9ghmZ1+XUSEcY4cXcqWL8IUsAMi5g4g5qd0h+RXKttYxgU6+szeTU=
X-Gm-Gg: ASbGnctemr2ehkQIDsyh2Kw2fkDKVuZcNiRodaKvPY5o6eNCYkwAPe4wsPskdcg/0VR
	rDi2WIQbRh/a1P5tc09t+ltsQSkU8d3k07dwGW2za40qmz2YTWj8SvVuEaWgiXaJuffW5h2/drf
	G1tRkx9BJ7giTSW7LiZOg83oEbJJ1yQkayqGda0nTyfa5CT2/+H3pf57VkQrNX/ns8wSop0ZbGK
	jxIYm/ebRE91xH1C6iPBD50E/LFWq6KzGROEEOOMBpuwpQJ7LkBso1KA8WvyUk74+AK6MfrpKzQ
	mMkJOFQN9NQHQkFCLKzoapMZtzMHEPEtXdQ1PD9o8qd5BOojWeUNv6tFCvP6CrVz0YZQ7EWDUSC
	YBWT3EbpKpg+t2e3QHqoz/N4mMmuJuZ2/PJBuSassWH4F3EymymbYlF4ejGMK
X-Received: by 2002:a17:903:37ce:b0:275:6dc5:a288 with SMTP id d9443c01a7336-27ed4a92b0emr22691095ad.45.1758782019558;
        Wed, 24 Sep 2025 23:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERBBtNIkEadVPyIyV0MU16VoZZQXNC0U1MspK5LG8JkNkvmuyDKOHUl6BMSuFkRok5bef9qQ==
X-Received: by 2002:a17:903:37ce:b0:275:6dc5:a288 with SMTP id d9443c01a7336-27ed4a92b0emr22690855ad.45.1758782019144;
        Wed, 24 Sep 2025 23:33:39 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:38 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:14 +0530
Subject: [PATCH 06/24] arm64: dts: qcom: glymur: Enable pdp0 mailbox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-6-24b601bbecc0@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Z-YT4ciG0Mz0NeAMZU8GJOTRBdVDk8jV
X-Proofpoint-GUID: Z-YT4ciG0Mz0NeAMZU8GJOTRBdVDk8jV
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4e244 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nkVSH_9X_D7H38LkyDMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX+Rdh8tSKYlv0
 yFskQU+l9wshGlF7WPd+dGSkzPnk2lHx1w5gPwAwH1yxEpcI0gE37ivMS0Z10fVILqYkOAw6KJj
 NwU2VIg9EGciRfMW7Bir4ykUKMK660LDufCAAIG6dJ5qBPxtt+5Pi1Yvvvk3Fneo7I/GqT1aXuH
 5uPUMTEo4sFzOGgVAjs1vTC3/DPcvJDl5Rz7V2/6sddV6etfhHjyNsb2iG9LrGWG9+XevwNbCmE
 Abbh+ngzukqAeBajh3Mfwxn5tzZZbt9DHcpwEtgJjKBdpbRz8FPMCYi1mr6op8VHUNCkn60QPtu
 vky8gyd31xnv6jVE0C+T6JisBkyTchBjcTJi9PevvPae7fPh1k+tlzQfDyH4xqaExHhxeV8wdc9
 QvXX6uol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Enable pdp0 mailbox node on Glymur SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 66a548400c720474cde8a8b82ee686be507a795f..ae013c64e096b7c90c0aa4cfc50f078a85518acb 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -4065,6 +4065,14 @@ watchdog@17600000 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
+		pdp0_mbox: mailbox@17610000 {
+			compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
+			reg = <0 0x17610000 0 0x8000>, <0 0x19980000 0 0x8000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			qcom,rx-chans = <0x7>;
+		};
+
 		timer@17810000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17810000 0x0 0x1000>;

-- 
2.34.1


