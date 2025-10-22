Return-Path: <linux-kernel+bounces-864516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7DFBFAF31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F449188BE38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA8C3115B0;
	Wed, 22 Oct 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UkARakR8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952C30DEB1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122478; cv=none; b=FJM86K5dN71DjTB8MjUWXYsitqIZCg7ssL0+6PCOkqVLFPPPsTXsflYfQNNnpyA6NRNLIvp1ZxvDJrSkAsJ9gC2DG728BLUNq7aDHI1M1Bmqpp8ga7iSQ45mvyLitWu5oXM5cORHKQe9ZyIFgPxr6GF6kE3fgJ46y3LXgQVXAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122478; c=relaxed/simple;
	bh=2JxH3SAb5I5RjNeUkzq/LydH+ScowPF8cKoijPFvtTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t67il+JvAqyQQrANw2bSse8W5MZxrp1JchT7zqnB1TOiTJN7mej0elymNCo7UfaBjTUekm4/N/diZP8LofjqFm+rz7AILjrzzviE7Cg+bgYDSiHh5mMdmVfPlIVD8wnYp/GpXvMggPxZnxg/GexuTBptA/7aKNd/rN4eaESDN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UkARakR8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2tFcW004435
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IuNGrA3HI88
	okECNz5zskMA9+Az9f8glbFMv0KeN/Q8=; b=UkARakR8tLWgecWTopmsXfRqyOU
	AcRX/Ii9pn4SZ9LUbavx/4lNSMV84T3jZbxGGaErt1JMZ4UlZnLekxqGb6oP/8Vd
	960c4V/ccXkkAc3/M86tAZHklAvNlCz11e0M0Rxxtk4eCmS1GGq5V7CmdEShkExL
	pJ9y75Q3DcMRYoOs4x2Dcs8hvyVSpra4SFbyVpgvPXbs+TrcQfbiXVosHN1DFYJf
	gCw+5MLZXcttb12pqgELkjbSygfl4Idc8WRIzQut3KbNYQr6l9u6t+ki437shSK6
	W4vxlFFgsl7jess4TFtauGElCrEDxL8I6rb+AEE5DbFHw9ONap+lShzhryQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfkvgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78105c10afdso6198257b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122475; x=1761727275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuNGrA3HI88okECNz5zskMA9+Az9f8glbFMv0KeN/Q8=;
        b=gEUaKzS4jmFRJu56obW1UNcb+sECYnQvLnfeFKi20zIX1+acflpbYwP2VjprU8FV6R
         Fc9qV/BR2mcS1AgbV7kNDbsrgSx+cGXb1D7vfZ9LF3LA9h2iajYw9CAlF0EYH7Hv8qRS
         srZeFxwXVBSmAS9qZwHCU8zHpxkqwMEs7mpY4WG9dyYUaaISWU+xwqHWMH1V9NVDZS/Y
         9USaeQVwZlUHHAtQIarVJTlPoxhPoTZcotI2T1qSMjfHjSAwcQke90WgW4rMizZdKAUz
         6OYUY5/lTcWoPBZ3YStp6FE4ILb4mHQo1zvceRX0OOs+zLUGyvu8kZPOjgZs0rHhRcN8
         ZAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoO6lZyvoTCB8uQXD3Rwebg6tV0lPeSux3uTK2Hr/iQMMfSTji2Ttfxq7mTiJKDPDj2N0GXlm04wPvaIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqCAqWbFraIKpk9/Ps67y/kypIEeZqLrO4eO2TIkqHMUbkfOu
	kSZfLNCuWxSRIuM1A4QFfQL+4GENwrew2SXiVAJNKreKoYWrlcvIQ8yVWCmjtdTjfTXPQLv0kCN
	senK8OGvS2aFPyM6XF5RDBhx9gVw1mOEKQCW/+XAFkRYh991XSqFrilkMJ/fOOe3cAZ4=
X-Gm-Gg: ASbGncuHhwliyMdGY4C8vtQuBP52GwV4Hkijibh8NlMX5x7VZtcZHGqR4d96n6AkQ/a
	jxl0Z+HBOhCPyjjM6/P2aeHu2JCFlsayau1ck7lqCM0P6bFcjDFIX40OZuICviX+xFHIW88wVE6
	2mm6KdXbnqJ5V/PueWyK3QHC8ehggkYHbgiVjxzS8wcfs8nIkhFgUG4pCzfHeyfmU91xTx392F3
	kEnhWbC4uLZyYzMFGIInXHV44ejZ0t3hGEJxifvBRBtNUi1uGRSLTiRQuJ56rzs7IPXESgm6EmT
	XbM6uXsCc+7mt4GwukDLcCyteJBLmgm13iyf0l7Et+zXaIv+zA0RGUkIyllb9dVrW+xpWFrvgfP
	UkP8n1oqt1em5g9v/O6WEcpJ2dOHE2sOm/KCL
X-Received: by 2002:a05:6a00:194b:b0:77f:2978:30b0 with SMTP id d2e1a72fcca58-7a220a3c2afmr23140923b3a.11.1761122474852;
        Wed, 22 Oct 2025 01:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnN1IY8wPgEpyEoCxS69d9eQBE5ErlRJaTLWYhusdXNBpDrH+C0lMN/8Q1OGqBvJrvECdv0A==
X-Received: by 2002:a05:6a00:194b:b0:77f:2978:30b0 with SMTP id d2e1a72fcca58-7a220a3c2afmr23140899b3a.11.1761122474409;
        Wed, 22 Oct 2025 01:41:14 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25e9be9f3sm3740317b3a.71.2025.10.22.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:41:14 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v8 3/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 QRD platform
Date: Wed, 22 Oct 2025 14:10:52 +0530
Message-Id: <20251022084052.218043-4-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com>
References: <20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wZAT58iEawcf4_dc7EZearrfcWxySiE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX7CEUCQhsbRpM
 mfN+8e6dIa9kNicnybRRXF8Y5riOAP1NEdawZiTgAycsFU3d4oR+vR9TzaWOHhqw6ByUq/DqoSO
 HUBUKjmsRphzvDPBYIqenEvTfNExsVcv3KS85VK8B78RKQnd10W01F+XRkDUqXvqzvl/Ei9fXlo
 9WMSLJmemogEASpS34dw+sEl5H2PICwG/Mu12M9kKOYpU2gPh7NC6ic5LgrbimpVLQBcMU5dR20
 k8ObPV7jXdzySAJOnnVqd3WqOBIAKl3llgjLV+o0TyIYneROcG5P6d7YIGsSBKqltm5xwBlqw9Y
 6L7TYKn2IKfWO+l3gJskI1wDm85zsHVly9mMMr6GbqNtW82v/67z567J7NyG5veHodW1kk5kK/b
 m0V2dgsn5qGk+QPFNnCUATBnU8XK0w==
X-Proofpoint-GUID: wZAT58iEawcf4_dc7EZearrfcWxySiE9
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f898ab cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=EoOMd-xwxZjzz6zYUw0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Enable USB support on SM8750 QRD variant.  The current definition
will start the USB controller in peripheral mode by default until
dependencies are added, such as USB role detection.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
[Krishna: Flattened usb node QRD DTS]
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..fc5d12bb41a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -1054,3 +1054,25 @@ &ufs_mem_hc {
 
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


