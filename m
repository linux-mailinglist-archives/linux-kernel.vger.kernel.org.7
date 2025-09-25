Return-Path: <linux-kernel+bounces-831848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E5B9DB19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474A87A73E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC762FABEE;
	Thu, 25 Sep 2025 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0yzl+HM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C362F9DAC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782057; cv=none; b=BSIscLDWVHQud5yg53wm8fj6lvOXWgOwZK8I3ybXmFWx86LOJ1UZX+AhWSZZwkaOkXI2beufQae4sf4bJGyR7tGk+Fvwh0lKoF+JP8ZIYagzO06jYVk/hgXcCMP4XXVons0dAwwMd8v/hENbm/ppnRx2eJvjCo18h7tnE5Pqtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782057; c=relaxed/simple;
	bh=E3B3ByaBtuMatGnp2Pcxduj29OzySduOTeUAJyaDEsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNpTQ1WLTUXZ8yiWACkOoqtttXkix+qD24vfz3FXZsIuJJQmmehlwIv8S9596crj0GsDFnBXtjPOcWeSNZqmEsw/6SUPUn/szPtEuPyR4mDjH+FErwp0lx9uMjJ08oJryi+uX3Nny7MZWXlU6qbixndD8nIqCqydKf6K0lS/7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0yzl+HM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1000n019923
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GcCj/e9tgK8s4kiIpVDjeJ1bIplDWEorF8EPo+A1CcA=; b=L0yzl+HMC5givkPa
	/QcVoLS57VY32cGX91AKDGfP6VG+vN1he5Q+tvXOjMpRGyF5J0ELf8En6QKylDgy
	Lz0IpocL5qPvg5DbdCTRSXKL7aLW8DIMrosSySSTjR+LVFDWoYS2eIpqt2cbrHl5
	zfHwzPmop3YKlx9qcZzN8oqXhk4Me4lJ3o7+bTDndbmWsSf3ViQx3g8OelmLxDII
	IcZ343Cu52WLYUniprLkYLyAbBijgZsTnTERImdrQSviBKlvZqegOECmEGE1zUbh
	qnpm2rvT8jb7Yt7Z8WMRsB094pM4lDInKURtUW2dDZVX0zns5sOibrKdPsZkWp1c
	XzvX5w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe08y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2445806b18aso6720455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782054; x=1759386854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcCj/e9tgK8s4kiIpVDjeJ1bIplDWEorF8EPo+A1CcA=;
        b=OQGRsrED9DdMhF8A3mJbOLMaEJtGVZ9xVrUywddtMv+OatNz0f06TMwsSjk6UElafJ
         mbykrPQettHAZCJ3PuUsy7QjTVV4g7Rm9e6pVmY+Alz06pkmB+Z/XSe5thEnjNf7xGie
         qex4Mtkh4ZNPF5z2x8M4aC6eZj6K6aRBm07kDCSUOWm0knE+3GQrkH4X269mXZmatPuS
         mjCAQLBp3XJiSkotGhoL7nDiKTeFQH/xJWXIY5amZ7njBnM2beJuXMDOPM5yPPipDOmA
         9oebmKenTXeNuq5NutAcZX6q7wmO9p7gU2+sxHrkZC9ETBCUC+DqoZIAao6GKvgDA7xH
         oolA==
X-Forwarded-Encrypted: i=1; AJvYcCVwzcRsDE6oeb5L9rLPrK8jMlBdXU+ksEm3Iv5Dzs5FMon3AjPZhqscCDpZg/W+oNPPxmxiIIx7e0gWVxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytjzj0MqwFf43PdrwTDeZEgwju9kMKLlazCdeJzCBUrxZxUzxi
	9M+DJM+X1Yclfk2PToovCjBN7E4IIXUivRsMcLYBUp7JYJvXZBBELAdWm366/qbuFxCjJ1Dyw1J
	PmD/dlgWAM02a5IBA0OsukeRIQIPXQ5f0uoVA/8rfIWU9vYeqNMzlHfQWq80LLK/D5ds=
X-Gm-Gg: ASbGncskjGn4z+xTh0X2zSBI30CbTEQhaLC3BVhUDSres5IASPJ8HsN/ohtqRugDHWZ
	1N131aw9MiDyWLVLCWfmm6AOojd6dNxay86JOT0LE1x79zEdId2+iKORaZHsgVdyvy4TfqJqNE9
	6DYab2OTjZxVpv+jFkMryqNyWIGAZEIG0btRUhTmwzP7tD4GZp1Dmd7fAE+KUUg5IKgyAb7sBEX
	viKvnq3QdBnDtkjWd2RIZwgxHMGMgtBozb9+8y6ySeGAHFBpu++vcf2j2DcmUYFAXo1fUeBFgHJ
	arRIGa5t9PJf4h8i2IycSgsOP0mjsXj7JcC2yYDDwXgWQfync+BRFHT4mVId2tnfa9qHRZlNxAx
	8O9iILZbpgWL9AdIDVbYtUUVqnx3787RfxFOxoCGYirB4BDQTgnyFPJBO6EJM
X-Received: by 2002:a17:902:c94f:b0:24c:7b94:2f87 with SMTP id d9443c01a7336-27ed49d0885mr26649255ad.14.1758782054497;
        Wed, 24 Sep 2025 23:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUFPSqP6cvwwCq5peM3jwv6x/ZxYdMlwDMExGKphwKYahwrK3QF28j9pS1kOEgdaF4UmDIyQ==
X-Received: by 2002:a17:902:c94f:b0:24c:7b94:2f87 with SMTP id d9443c01a7336-27ed49d0885mr26648955ad.14.1758782054066;
        Wed, 24 Sep 2025 23:34:14 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:13 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:25 +0530
Subject: [PATCH 17/24] arm64: dts: qcom: glymur-crd: Avoid RTC probe
 failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-17-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: fvUs_2xTnpM1tYdxRsRYmvLC5rKih8zc
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4e267 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=zkxicyaTBexjGtpFqaYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: fvUs_2xTnpM1tYdxRsRYmvLC5rKih8zc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXwbASqrSQViVF
 P/1HMxugh4Ty5pGqO56eRYHdLze9LAcNcvWD96cdHySYhBawO2t2kcy2vF8PvAdO2lteKZ3X9CC
 lW/uI5jZ5K3ZkW82amosy6SwSoccBm4SimgaqpVath/jEvfN0NYO48+qS9ZBo28C0QuNTMdd9nO
 hCyzHDtYI9ON1MD1xr+seP7+jPWlsNIG3PJ5v8NjYlfQL5bI1LG2k0lQz/+bX84zuVxjVAu9oRp
 vbuHSLvLQcinz8aFmzGtO3fCo9dGPjonk/HTmHjnEnKwguC8mUQNhfaUqtDPFnIvvfnHYE1c+rs
 tEu/yOoxxQb9vCJ42vnU21fx/l05uiMf0nXuSa/YvuQqTXpNzT0DdfZWXrXYM4edho7Jhm/+bYC
 fBF3JWW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

On Glymur boards, the RTC alarm interrupts are routed to SOCCP
subsystems and are not available to APPS. This can cause the
RTC probe failure as the RTC IRQ registration will fail in
probe.

Fix this issue by adding `no-alarm` property in the RTC DT
node. This will skip the RTC alarm irq registration and
the RTC probe will return success.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index d6003ae515e37049fdf17d6b604b974dc8e9fbbc..b04c0ed28468620673237fffb4013adacc7ef7ba 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -429,3 +429,7 @@ vreg_l4h_e0_1p2: ldo4 {
 		};
 	};
 };
+
+&pmk8850_rtc {
+	no-alarm;
+};

-- 
2.34.1


