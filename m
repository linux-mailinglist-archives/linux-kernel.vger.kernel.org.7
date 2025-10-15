Return-Path: <linux-kernel+bounces-854317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427ABDE17B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCCC134CBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7B31A07D;
	Wed, 15 Oct 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W5yF6ROD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7E31D371
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525583; cv=none; b=XXjesh0TW5AWG/i2W0QqoLeScH8t28JtJOZ0Kw+dlHIOFyXmtwTorYcn+m+fPv5N4XWSML8JSyfZ4ofVHiCyepig54N5oe89R64q7Q5Ahl/86jPeC3qCiwCXhRwckbT2rFQaqgkvN+EOj2f9yDvZTP494zxkbuLvXA5MzBt3Vac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525583; c=relaxed/simple;
	bh=sTi0mjMgcJhdedOXtNzqmiW6VLMIuc4TNTSQ/qMYOn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWGf6d/M182nu4UgTTuR5m1c9YMpfkamuJGkXRT63Kr18FWacBj4b3+xf2b7vCKHeghpjQgNgsh8QMq5NxxG3xExkAWqL5NZR6pm6O3+9yxzzSAkAa/I2vqlLSgABzei/VLOFMLXAqZ7cf0rf6z4YD9jIE8LMI8yH7XTyG5KFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W5yF6ROD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAntxb016723
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/401FWP9t5m
	7Jf+b/B3IO0Kir0IpsFHNMXaHyzjAR3o=; b=W5yF6ROD2JUbxgY1TbgnljK5qq1
	8ovQ196ISG9kLZLI03Ic/DsnjKQ5OODhw8ii6JMeWasT5HowxG4kJ8VI2HJCJ0AS
	Nh/kGCKWwW8r+1ab5T5HPV4KzaRndfDEcD74Vq79B8jTqDNjhBWmZ5gqF/+oWV55
	uWwVoo77VlvSCloUwywzils+RA9Ti3p+uQS+scGyT1xwCAG4DlFyTRF7lqpCjazt
	WHoMk2x+EJsEIN0HL94c7bak+xvrH/bY12HCJEEzoQklwsw/5yvfhc8titAF1bl0
	GTIfnq8lpcF2xL+Y6kdnXMicwT5sdhDpP/LznfEnFscjsqfQsvCcnGxh+Ow==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt92ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:52:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eeb9730d9so116262365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525578; x=1761130378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/401FWP9t5m7Jf+b/B3IO0Kir0IpsFHNMXaHyzjAR3o=;
        b=UtgYNwyDI7iQDDrSbllFs6BfhKRyrf4xfE0HbXsVNuw0BpSlbPvSFbViL/1KGbNM9u
         E3NraBXCcrBK/diInL7yRDBBn6BxOegrXQj8VoXefMvglJl8ZiVRKWucyPslKjSXg3vc
         TPgAjDeVcvsgNjoJufLFuVEnMSrfXe+3WauRjB0xdYAa0J5ogJnrPb9FvGcxgczeJJlT
         LRTrBHy0sNjHwx9AL0Ixr0RkN7VSUWKSIZcXJP4ZZLaFV5DRwXw2mDcHFaDDtElfSV1M
         lAecINfJChuUkXbnjStO28GqN3qYQa6YsgVt8GnDfyYVky/HK79mkIEKL3ILf2KZQveU
         w3/A==
X-Forwarded-Encrypted: i=1; AJvYcCVwBJRvVU69PRxk8lZi+lHaII/MHJj3/4aHh9+eEk+mUJtbhBHzpAUZwozg5rTPQS+x7BHA8Wr+0K2XmgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ts9r1648zBHIWJjLmpJNVlQ0nTP3XzST1obOnYfq6p8vHsA+
	KRHDJloaUbnjNtdIPaH7wEGdlDTXyQkjnpj6kjCI4Anpy0dsP79s56BDKrCcdB5yyeIhOEtdu9v
	DNXL1Wh5o8h6+xpHQIG+qFKpYzD6X4ecKFY29BlP4jba90yBPFAg2JsWIMlXGqTGDptQ=
X-Gm-Gg: ASbGncuBXgXjPyhtEP3OCPV74D0fFvdYJWXF18SZy8sVHjWNwDzlOm74piYlG5xjwcM
	g/5G/lu7EIYAbyENojQqATKh8HANohBbqK7yMunxOST6eorNz3d7Hz9G82d1VPMbvEn46jWew1W
	i80Dj3Hmr1h68Dm/TYWk5roKxoDbarcQa+MTLPtqTU4pywTrm8PoHkq4WMJZ6t7XqmI7YU1YIAA
	omcWINHog3Y7vVCNgVenOMjaos/C3Vvol4wYH8zb84airOUAYRQSOpgoqW7YnVgbd2PeNPydwbo
	DOsgjY1MhTjQK+9KKuLDELD2+fIeB6KmiKN1CvMGICGQNKr0zkjFUS5oQDdluFB86lZmsbFkkn6
	LPA==
X-Received: by 2002:a17:903:1b0d:b0:27e:ee83:fc80 with SMTP id d9443c01a7336-2902741f56fmr318580865ad.57.1760525578272;
        Wed, 15 Oct 2025 03:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoemfCYSTXrYgT0AV+vF05ax/7/vMsr12lKaTHQmgsRF6rfncvPZRSkFSThvhgQ2qzIDrfYg==
X-Received: by 2002:a17:903:1b0d:b0:27e:ee83:fc80 with SMTP id d9443c01a7336-2902741f56fmr318580595ad.57.1760525577755;
        Wed, 15 Oct 2025 03:52:57 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm193698385ad.49.2025.10.15.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:52:57 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Eric Biggers <ebiggers@kernel.org>, nfraprado@collabora.com,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v7 2/4] arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
Date: Wed, 15 Oct 2025 16:22:29 +0530
Message-Id: <20251015105231.2819727-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
References: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HC7mJWTHcX72bvFm8w69HURR3_81FyRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX+NCKYY/mlMaV
 c6UWm0qMaArziuqSAG6HD4RjsKaiZXLYqVb8+4qBl+Ttb7gwDKyqtMpZdQKumyRrO6xYKw6xQys
 6IDjnHq/CcNy2kH3E/X0sh37fBph/F2mpx1y8453Aleg+rktzfPA/lglMpFN7d0bttXb/LPmTl9
 1Wluo6eiT3kRcNh0ULu/Pg5P7GBUgEWjoi4me4srqGH9W5BSMAW0c0Rg8lo+q9YAWM/nnPza3cW
 y3qWH3qbPrrqVm16zshsoDT5g7nJO0vVTTtWxlA2F9Yuw0QgQGH+gQmjVys1INkfkiSrc4o0Dlr
 cBSST9FMDbhq5pR2iyP3sezIWf+lwiq9rtxrTcazW3FBogfTNRDbvEV0RsVQC5I0cjLEXiLyNMD
 xIcq2/xKHjasbfxoIcq5dMS2SbYkyQ==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ef7d0b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=Tsvuh88POXG944tnl6EA:9 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HC7mJWTHcX72bvFm8w69HURR3_81FyRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

From: Wesley Cheng <quic_wcheng@quicinc.com>

Enable USB support on SM8750 MTP variants.  The current definition will
start the USB controller in peripheral mode by default until
dependencies are added, such as USB role detection.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Melody Olvera <melody.olvera@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f..815651f65214 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1121,6 +1121,30 @@ &uart7 {
 	status = "okay";
 };
 
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
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
+
 /* Pinctrl */
 &lpass_tlmm {
 	spkr_0_sd_n_active: spkr-0-sd-n-active-state {
-- 
2.34.1


