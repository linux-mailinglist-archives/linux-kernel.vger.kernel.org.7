Return-Path: <linux-kernel+bounces-869081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2CC06E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413D34033F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B73254A0;
	Fri, 24 Oct 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7f4EIpg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC9326D6E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318943; cv=none; b=WVHixrQwvZSM6BVJuI1afrQDjlzNy5nGR1biZug/1ypXkPSwhm3iyXoKDNcfFrTSCgj5F+zzDdJF54uTMPPrqc8gb/8DvISuklVx2JrXgItiCQihRb2Cu7QHC3EWPKqQV40pndjwmEnTgQsWJh/KMznjSbkTBGBsNWi6FEva4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318943; c=relaxed/simple;
	bh=5o5hDOxA4Yp8K49Lg3lxh6UkxH6v40/Ib24lPYIdsmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFFT0T2MWeL2q3DE9Z6QMhTOQkOBaGglXOSUw03Ll2FdEViDLTk6zOLMMMRQYJDDT6PgB+L53XPz0Acq7EFhcxQodxVGHKO2j7DOdBww4tlvylTody5/PmD8ObimvHfGmcwuF9EBlj+VuA9K0xu3suuQ8oFKzzF+6zSLDvS1/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7f4EIpg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OCS9EC003822
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DULY3y5QWFb
	buzttMloR/r7jjQtgaUlnw+flRU8/TqU=; b=X7f4EIpgac1W0emtFVkGZ6yKtWa
	GxvukXZJRD3g9kHZSutDAshXCKuDNLCHhi5l98qsRJfd6AcQ8UUVXBXWpvx9AU1I
	bZc+LrYRnQTwVnP1Koko+Wcq3pQ/xnw7fHR/ayZgjuR584Hzj301mO7AiG52HQXU
	gVcUAw1i7X3YJ/or6zE4ENb/OfdRSoy0SAwQ4usbJtWBviDR+iPfqGSHlDM1kcUu
	EhCOLXecair/YSlABLiBHkdkXWwL4wZN67ySXfU+BVsrXRlVSHZFrrScRsXuFi+l
	HR8iwQqWhOnzkQDrX+leEYuYTTGsvDe+NittUMBjNL8xGhRplnK+hrn5VNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jcavm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290e4fade70so19411905ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318939; x=1761923739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DULY3y5QWFbbuzttMloR/r7jjQtgaUlnw+flRU8/TqU=;
        b=umPcbf0QrG6TVdhR+lxv96cKXyqUndwZ03N9AsfkIKoFVMvGTIxZtm1xqPvjC98tQ3
         2Ks7Dp1DEqimFDGYNSHHt6hD28itmWitTEQbRI1z75t9MmAJMWhu3Ax/qqtcML2kSay1
         es3CnClmXt8LDbCiHwt/y5x48AQjWgq9KxKG+p04oz3ESLw6NoDJixrKtzOn/+fjHdg7
         WbI9fVu8Utv4BtbvE/VzFfewKncRzaYbHIm6lr5n+1qExXQQ2+t65U4QpelkG2iFFD7e
         FNdSQGxZy5Ldtjf4UWa3ZuesOa2Uk6Un2JIDGaYefoT+8GNAzO1AMRtZpTTlkCF8nmeJ
         9Zcw==
X-Forwarded-Encrypted: i=1; AJvYcCX4OGWVrnA91UYh0KvvZjbw43HgAPFm82F7Iyq2YzcRLzZP0LJuz7gK0BgnbpgTpChtBIq/B9wOtv/HMEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvvy3/8nZm5J1ixzHX9/FucVzpox13ROOVHBRqxZXPVpmgGmqC
	FnKewCGKQbjAAYdLFTzt491zL/FfGpHUHh35DaJ1ByxNQDvspDW01sqh2M2yy+8VY6TkbkbKpAz
	WWQBosrOT69AQ9+Awj2kbZGDLS0pgf8WLur6gkGMMn1jjqbFzb4S4PTFt4S7x95w9VvA=
X-Gm-Gg: ASbGncsiJOTaaBifUfQNVYoj8IKT+v0+XZBQpfywqiyAgVqV4yBrrMn10cquuX9IORY
	9JvJhza6DAhSPqfM1GZx/SxVYOuzCNM6FCGa8HEsI7ROcNZaPqpvcjEP0RYCn6Z0KEtRGLTBv25
	tyLcCskqHJVgUodAAA6gzPhNGL9NXbaxK6Nwg5zTGtOM7GAIskU96QS2vu5X5pzMwIRLegTp3hT
	4n36zRPEAo7JmUUoZ3rP26AhO8XvBePGfrkn1nkhFCB7fi58IzVxlgd+fWpqXSLojeqN2/gk4Mb
	xx4nG8gmN50MkPFXHX3eZ2/FzgR4yKwK7Cq74KRT/vqRKQImdhjt5honSfeaoirefCwrEflBNFe
	Jp8YAqncFASI8aCVLub+v78W5BilA9o15UTRK
X-Received: by 2002:a17:902:c412:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2948b9758e0mr35477005ad.17.1761318939234;
        Fri, 24 Oct 2025 08:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOhhLeRPIpbvSGbAb8PXAfIp8vVVRLOl1brxlt9G+sp70FlC7RwLctSAzSv96eTW2RqVZ0Nw==
X-Received: by 2002:a17:902:c412:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2948b9758e0mr35476525ad.17.1761318938766;
        Fri, 24 Oct 2025 08:15:38 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddddc34sm58758885ad.20.2025.10.24.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:15:38 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v9 2/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
Date: Fri, 24 Oct 2025 20:45:20 +0530
Message-Id: <20251024151521.2365845-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX2ehDcEPBpIYY
 YzyktUGB3997aFpEu9zlI+5mwrhxNy+W2gELfhQUT/75DEgThtpIjoAOSv932XMlqmBmnvffm0P
 YZZFNcpxt22/z6Hhnny8bttFcoJGv7cyItbjd3ZoWmrtijf1pZnAjNdDXhnk6Q2FN9Ux/p8V7jt
 H+PtdKJhT3C8q+9Ltzs13z776XU/ftHLa0lcgtnEXQl1y3kQw+MRpLLIaq//u8Wv6r4FLccjSjF
 mRnj8IBxRTlJKoRZP/jj8S6xRzZzACzCQHJ5oayRZDHH2+qTSYJwxdC5patbf1jvsMqSTzq8cnj
 5OVS2/65u8yySWmWBYCmudnmRwbOf9YB6S+2x9PRwXokFm+9R/ODths0poT/2VMxiitFnDxwQ8Q
 tlb0YFD6Hge7n412MHnf2iC15V2NNQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fb981c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Tsvuh88POXG944tnl6EA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: cVi5oVa2ps5YtGotGZIS4I1qhAgCvu5P
X-Proofpoint-ORIG-GUID: cVi5oVa2ps5YtGotGZIS4I1qhAgCvu5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Enable USB support on SM8750 MTP variants.  The current definition will
start the USB controller in peripheral mode by default until
dependencies are added, such as USB role detection.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
[Konrad: Provided diff to flatten USB node on MTP]
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f..1b526d96fba8 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1200,3 +1200,25 @@ &ufs_mem_hc {
 
 	status = "okay";
 };
+
+&usb_1 {
+	dr_mode = "peripheral";
+
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l2d_0p88>;
+	vdda12-supply = <&vreg_l3g_1p2>;
+
+	phys = <&pmih0108_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3g_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p88>;
+
+	status = "okay";
+};
-- 
2.34.1


