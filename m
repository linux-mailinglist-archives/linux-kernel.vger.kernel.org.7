Return-Path: <linux-kernel+bounces-892796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2FAC45D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB05E188F4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5F302CA3;
	Mon, 10 Nov 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+SJX6aV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RnuqgJ8w"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E1301010
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769470; cv=none; b=ckkW6Vg/NHbsfdvu2I7AmlnWPgdZh0j1FZ58PdjzZrobZGDOGCbp7dRs2WvbJv9MA1aM+99k9o+a+a1D7b6AyajpKhF99B+cQgZCg5VdYZsMPOH08I0VTtRjyyHycl5ZKMI1TzlFMzfs/BJZFeEFLRFWVNwjTep2l7VQq1GOsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769470; c=relaxed/simple;
	bh=2WR4DjVqzWLaipfohKrAz6ozR28pmkslqPBu5RhQgXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fp2nGxovosP1oQstlBnRdTXmrSRb5p2DAcuxZ7SlOUgwjhLMD+TmrFVnyMkTYeoVxDWb/yncXhRT2/s4NFxAsQ2bgIq5t3mbl5N+3efg+1WyfErX2uRxkUJ9XRQaggT0h05caL8mtenaA+oSllIfjoRK9TXzrN41CZKUfTIQNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+SJX6aV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RnuqgJ8w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SLbP2407319
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kkJRZx/9fd+
	C31qggYZ67ZVb5QG9K9z0NjsxhLqSeck=; b=l+SJX6aVXFGrA33RIPukpfdCMGt
	lCqxHG+MSetzSt/q8JPXBn+hh5bEQrVWSVNziOdRrUViULSKkRBCu3JWEwfoMW6/
	eLV2hvx0n99ulUSGFV2ST+EC+2vpAkdWFywCtQ0JbKQRgksD5lEEgmcz81zFb9e7
	o0PozdaOKuSFBgoJZ/9Y9+dv1kIkUzYDZiH/o0Z1rEYptstPIR75SDZULltTXvp2
	uWLWJvPNrkXRribGwu0DzJQZKZLJAZHy1AZEcEN8j/o0ZF5IybZmBBEv614EowEL
	NFl1LJlRkMlTcg8w/gFP8Vo+KhwYISlipn73kFFBR619yomipdYQkxwpWPA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd8q6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:11:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297e66542afso47097385ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762769465; x=1763374265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkJRZx/9fd+C31qggYZ67ZVb5QG9K9z0NjsxhLqSeck=;
        b=RnuqgJ8wb8YtVt7MDQVrpK2evx+sYsgT8JgTLPvnOBp/zqna9LT12E4sRc1xRzMhyt
         Sfah6Yq03AqULYP9+Bn1B+/hCCF3w6Lsqq4Tjtbirys9p7HIuKGMV6/ERAZV39zwYyvV
         ISryKa/RGmtZbQthsO1FZeDowUj0FJXu2oz5Cih4jfKCGrVoR7OVnALx7qti1mT+iecX
         8hoXhyYaqNSd4LN+QcJ2ZF22n7dJzAIioC/wPyUpQ5Bu03yo4J5LxrlHRByGqogjSFPe
         UUxDkqD3bDXrlVDz36ojQIMgcIt0V4i013E0n2p9p63QPlEsWoqjcx7qkZ4vyPh3Doje
         x5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769465; x=1763374265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkJRZx/9fd+C31qggYZ67ZVb5QG9K9z0NjsxhLqSeck=;
        b=rYL0EIts8G7xW3/O0qq1WGH7oH7YoKapbdH4FR7EKI8cL1d1nKk5sVrHNkBCUUm5op
         SRLY5Y/tJn25/xlJ9NhYFUIPdQkb2Jnw7+TFGYDHLp5Vf6/GnjVrsyoZj5emML39XNfj
         oJ6eDJTE+WKYvvlTl8VDDTsWrAtNY+XgjJIA5yuq9vSHN9Jlq+Y7uLtVGFYvLfB2hrAF
         IIhMHsewPfxfQotZz+fVWjfYXorM3piqWMRnA1UoXm8RPstTGj45wM38E5j6z5jzI2KH
         IRmuFrrqSMo47puvcdILKz1CvVjKjZ+CwfN4vbUMeDPV4g4syTb7bHWAiMgBR4giPkTT
         LD8w==
X-Forwarded-Encrypted: i=1; AJvYcCUjv8EWQcb1QZh5pW1w9sa5M4vhL1c287OZZpPvMkVMRyTYQWWpqdzN7vCHZpJKZ/bWQ++pvGwavgyyDl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyue7qnVYRWbxjUIi2K3GRh4Qr8FTGT0BtfUQGAGlItw06tgEfc
	uF4sDreBhx8fVdzrOPVp2VjuRzRDI1Ap74uYM3nHx7w7qmCo8Bm+E5hbN0NTcfBn888SRgdEAw2
	UDNvwUkDVmbECPapvMErQ9NAkpXnjnOCGU6ugxch3dYI3+i2cwbQgq9iMMz29FhNf1TY=
X-Gm-Gg: ASbGnctTJnwKSFeLzKyv2fTYFdHXYoQ98igbHfUkZOsvSPNWoQdr4n3weL1Bnrm2u10
	kZZf4knqfye8A/A+WPuKsOONkeMXQVvo/XRd0EjwZS+s++Z/xShxzFB4WMtP0xZzAFxDSW13Z8Y
	s6nHjvcJxonRSYcbY1EGqoSS/7wQiMBjNknNlFFdV98enXjb4Ln4QYH/R4oonA07cWFcm9lhNc4
	vAkgzVIkAU9toIUiYG1QOLi8GiQUVYYCGnoIF7VKiWLYKFJxowBF7dtJeobT/vVyOFkXMUS51NC
	f1spVyTF+SYDxwU99ZyU0vAP5MgnsIVF9t5bi1TZyPuvGyEj+vW9IA5LiZfzT5cnsGQ/P4PBHLx
	xrFoHQILtIrAwB6J0Vm+pAu8yjub0ewhD
X-Received: by 2002:a17:903:3850:b0:297:c889:ba2b with SMTP id d9443c01a7336-297e56d90edmr98518195ad.33.1762769465267;
        Mon, 10 Nov 2025 02:11:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2alIHlrUF/ZT5w1aO63skR9wFfyTa+slzPpROyleCSAlu8xHT0/ebsHdOdwu2mfVfSlNY3A==
X-Received: by 2002:a17:903:3850:b0:297:c889:ba2b with SMTP id d9443c01a7336-297e56d90edmr98517825ad.33.1762769464693;
        Mon, 10 Nov 2025 02:11:04 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297f2d9c971sm60180395ad.55.2025.11.10.02.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:11:04 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        krzk@kernel.org, bryan.odonoghue@linaro.org,
        jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v1 1/4] arm64: dts: qcom: qrb2210-rb1: Fix UART3 wakeup IRQ storm
Date: Mon, 10 Nov 2025 15:40:40 +0530
Message-Id: <20251110101043.2108414-2-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110101043.2108414-1-praveen.talari@oss.qualcomm.com>
References: <20251110101043.2108414-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oanEyjbqOt4rcuDhqxOXUUQBy5p-FYp7
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911ba3a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KS-gEAZ6-5rkY-btKooA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: oanEyjbqOt4rcuDhqxOXUUQBy5p-FYp7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA4OSBTYWx0ZWRfX/mHso85UHVUW
 bUoCTxHFRC1v6AgiJtb8y+ddTwI8DHqE7OvjiGhEDMZw4jclOZIvPKTYMvG2atuRTkHcbccJjtf
 b58gKg/qhpmIY2/ce73lae4H5BIWXrqlAGKScwwB2/nN2c13m+0aEoh+wcAcKYhzlXPV4vCyFIu
 9H14gPU/SXcSfL8eq/7qtkUHYe77WVOVruVpc6jMOIPhcVGlv2Oow1RaSj6ZdG+cl3oL62e9ljP
 GzEWWMbFPySz+6WbkqOApWEudUdkyLS61ovmo8G8Cz0uL1ASM5qhyMWGyftNqDwe9pYv/sWAex3
 L7wB+1nKSANJnMHheGYDRyAhwIAFTlo8d4+mtsrPxunqnOERitwXFOtSRTfZzDJD2o01B1No5Ny
 ykouRk8JE6KPIko51zWfXOlSOwnBiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100089

For BT use cases, pins are configured with pull-up state in sleep state
to avoid noise. If IRQ type is configured as level high and the GPIO line
is also in a high state, it causes continuous interrupt assertions leading
to an IRQ storm when wakeup irq enables at system suspend/runtime suspend.

Switching to edge-triggered interrupt (IRQ_TYPE_EDGE_FALLING) resolves
this by only triggering on state transitions (high-to-low) rather than
maintaining sensitivity to the static level state, effectively preventing
the continuous interrupt condition and eliminating the wakeup IRQ storm.

Fixes: 9380e0a1d449 ("arm64: dts: qcom: qrb2210-rb1: add Bluetooth support")
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index e0e362b140ad..1b9ca957a94b 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -704,7 +704,7 @@ key_volp_n: key-volp-n-state {
 &uart3 {
 	/delete-property/ interrupts;
 	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
+			      <&tlmm 11 IRQ_TYPE_EDGE_FALLING>;
 	pinctrl-0 = <&uart3_default>;
 	pinctrl-1 = <&uart3_sleep>;
 	pinctrl-names = "default", "sleep";
-- 
2.34.1


