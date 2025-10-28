Return-Path: <linux-kernel+bounces-874683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C378C16D98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1861888A64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC772D97BA;
	Tue, 28 Oct 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrTLILI7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctwHs//X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA22351FB9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685217; cv=none; b=ZUkOyEglkk6EgRr93msME32TqRRI7TnWxied0/kdoS+3hDSQj1B0L27MmATDHsVLHXtWK098qg8blEIGRuHJ6Afpgx+Uoc/+xM2rKFVZpEBlTqDZm270TMDfC1n3oJlhw4Lmg4Jbx+xMMH2z7xN0rXHqjhJKvfyZvmKQoZj0CWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685217; c=relaxed/simple;
	bh=gNbzf2MPr+aBgX3mmP29VAz6QE1K5U58z9DMT83UfZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kr5T1XK8+h9knHnZ/7vMcecYE2rdWPtCxKMKpi/OVfiLKRTknWBHO683rFajlnqjtBGOQG6fSrfvmf4ju2O3XBVjgmCccMEitIlJomoXKSkaAjAyRzs5gTM7FIDk1G1HSD90oOchwgQuObqFu/O1EDJ4SD3FJiv7X10F/70lqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XrTLILI7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ctwHs//X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlOS92554348
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NKcHfkgTZdnk410USJtHf5FZ+SnDF1WbC9y8f6X/XPg=; b=XrTLILI7wBZXwYgi
	/VUy+r5luFriKFS+e+4cQ8pTV+tGAnO7yKU4ukk/2pVBqF5f10jTXeNzUB8/R3x0
	TW7RTjeX79b/tWP7ufCXGFdLhFVDQFyQVChErGwD/uc+JnvQVX76J+paa64Q3kTK
	17gDhrojUA3KdLBaBqWDVK9I0jEvJ8uRZ9G4E1SjxIQbi8WbB88OZ1+msbnZiy7Q
	mo8+EzNDdbQgF1mRAhIzx1mTbb9ttjAHe+IVUSpvYlFh/71XXmsohFAu1YAJF4Wb
	bpjJzxSku4C4y0BT9lm32vayYEm6plvf6lMS55hMbUStOKgtKlqG4hIdBkVG4JvI
	Sq+p6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a105uv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8bb155690so85749811cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761685214; x=1762290014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKcHfkgTZdnk410USJtHf5FZ+SnDF1WbC9y8f6X/XPg=;
        b=ctwHs//XcU2M2zplzGQ0Pt+6LIkVVVKvn6myPh9cvtE8k73SXMQorcOH78CSowqQkS
         CXgcEl/Klwvry0NJlMSAhnAcXDm7IrP35vFFmNCNu2PTimKt3apiE+CRs/0mEmQCtMN8
         a/INANXWoVoABYw+Ujv44wV51uedkVUWDsgy2dWhFFyJztAr2zZwlpu1aURtwkaGtZMJ
         fMuRxcTq9hP+lSMoc4+I8N35GrbAErU7xMRVQYCDVDML5mazASbu/sWpW60zlMWVH0+p
         LwQPNmbQosH1q+eo0YBM4rShuVLA60qSQEOoHIVqrZo+AkyZI/IS62m4WzJ8DJPdgxGk
         djlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685214; x=1762290014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKcHfkgTZdnk410USJtHf5FZ+SnDF1WbC9y8f6X/XPg=;
        b=LlxPtmiKzbSMGKJpJ/a1879E/4BZkeeg08J0JKj26/fYy+RqbHgd2E2smDU+H3mZqV
         ANOClFr4DhDyCAm5FrxG9pT49qQ4V+c2D30BC3uHF3/G4EDjOgZPSEIbp/gt5qRLT9w/
         xlnjaWxhS7guLf1BOXT1HyhCn7bGILEcUah2CbD6eD9Zc5nOBWG9XOXlzdAMrAmBNlkO
         KTzYzv2V242fPMZpHKhRhNGwPFFOblqBuEZUS/axlKf7zlpDIw0ERv/BgvFkZ1QdXpZv
         KcuyMALUwi/cf65O2X+XQp0f2HEs42ENqOKUiwb5hAbSc0xlWSYIG6OJb2jtsoFZlDbW
         BUDA==
X-Forwarded-Encrypted: i=1; AJvYcCWxIRu8aR07OAc1EsZltANFI9A+RlMr6N046n9ymlI8VvJ+50P8Wb1blSSfCjzuZ9bIEBHitbRu08joyq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNbSr6l+KqQ6bFjeAtLPWhgBjrAnn7JUZPx/jgvetAt4GhhZf
	hhK/xF+7HAmArAkFnXHO3DXu8JChZyWaiugYlhC+7+UJQo0++i49ldyAZRDsd03zH0XrX6VViRR
	45m0jTFeUAIxwdG2qcVxuYuu4uXNrRsbEX8TZzTh/F/SdcGSMuVzNuMYMU8hO7LU6YCqTg0xXDN
	M=
X-Gm-Gg: ASbGncvVTR7nbT43N53Kn602/72vnLejlSOnifMVHlu4TSbtu8mivEF4zlLRPaZQ2x/
	juZuIwWqM5zZ1DxvzXfhqy7PcQCX2lKWH845OFYl4Lr0UK+iYpj/cnMIwIM6y+O3bBSKAb/0Gpc
	VBn/FVJbhoF2Wm5HmfKCJ1PWWVh0H18T1/OM8Gpy29F50y0czaKCNA0OKDq2cWBJ/c7lB2VQe8L
	nLKgD+A+Mjt32CAN90UrKi1BgQJs0jZR6YCn6B3yWSAzLbGQVQG+7GAcjvEgMsxjpkGtZGjbtsR
	9xeahRMUXdItnOExkjzrzu92hg4hl21nfNBF0hhTXFDrZuN6xotR5Xn7d1D9K/XVnlO01qO7xcX
	ok52gL4GpaY6j60v8pW04PF8SoFhtKwFalwJ88fFgPDgcnsLXJS2TwUM3HLl8qYmfOgLz8dz4zJ
	spqSmC0D6Wj/rc
X-Received: by 2002:a05:622a:5598:b0:4ec:f2a4:f27e with SMTP id d75a77b69052e-4ed15beb88fmr9739731cf.51.1761685213469;
        Tue, 28 Oct 2025 14:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyhDF1HpOlX9VCBQo9hbkONm73nZjFChvahYmFfx/awPnktOZQYzI1cLFrJPwZv59XTkjbw==
X-Received: by 2002:a05:622a:5598:b0:4ec:f2a4:f27e with SMTP id d75a77b69052e-4ed15beb88fmr9739241cf.51.1761685212937;
        Tue, 28 Oct 2025 14:00:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f861f5sm3283594e87.107.2025.10.28.14.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:00:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 23:00:04 +0200
Subject: [PATCH 5/7] arm64: dts: qcom: sm8250: drop duplicate memory-region
 defs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-zap-shader-v1-5-7eccb823b986@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gNbzf2MPr+aBgX3mmP29VAz6QE1K5U58z9DMT83UfZU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQyaj3hVehcPyJpo1Uub8BnF/dqbm568JPpN3eal50If06
 +X/wtI7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjARlkr2v4Ii2UtOCN0VXWDM
 eOi/WEtrvdUFQRF7TcXtvU4R0y0Dr7IZNsuz9/H93+Ja7740tHlu1YOpMkzVXP7y+pf/3hFo1Ih
 jO7vN4ujJbIGIWgPdkn5Ju9VPddwSX+zcc6NTNTJQkf3mQn8L4ex8H/1W23yxm1q3dm04zNH8uS
 frb35q0xLWg1qCMZp6uXXX7jBZGdz8ssP2Z37iqoM/mUyloh+UfpqldsRVxlDn+O4zB37sEsh54
 9xcfXxr1eGPlz3Zyv/4zI4qn/lD59ndi3NeTc1oU7py8+nzDWYbPNsWO34zt987OTNU7jr3PcMt
 EaZN1eZ/bPOv/VHcb19aMd99U+PN6QXhSz+lG5dsTqwGAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3NiBTYWx0ZWRfX8QS+wJV7gZFW
 MQh9o5XogocANqwy+CHV8URXNZpokE3riJkMCZcc21/QJ7/dQ3nmWWC1Czf/3p7GVFtYu84CUKx
 gIBRujQB2YByBaonebc79o12J2JeQVX20s9paUdklBVqZKXBGrPs8jaaoOGsLAqWlsqjuw4sWmw
 POe9gfkBYGfXK0oCbmV7jszmUqKfNZaYVMDH9KEHOrMt86yaFeI8QqeamTQfy0P7nXEj8JpHyFc
 PB2V42QY6DOB5oAhf+jTGvthPNe7woBCthSjju1qFpcqXO50xooSarygg5peTw3MsWlkP5x+1oa
 lll7OBKJ2DzEx3Zv7Zi2qZu2/8CqTLz7+EuGZ+ckTym0GUBYHLxgpNzIDDg+GnAOI1gEDDkMxep
 iKQGXBi3PXvbSWhlZNMYz9w7n8ahBg==
X-Proofpoint-ORIG-GUID: CnT0sAxlG8zJdUBe09EeA_4Ld1ciVgNl
X-Authority-Analysis: v=2.4 cv=EKULElZC c=1 sm=1 tr=0 ts=69012edf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-YGnug1cYvQUASFw60IA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: CnT0sAxlG8zJdUBe09EeA_4Ld1ciVgNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280176

The base file, sm8250.dtsi, alread includes memory-region under the
GPU's zap-shader node. Drop duplicates from the individual board files.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                 | 1 -
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts                  | 1 -
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts          | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index d99448a0732d9d165be1b5a1b1e15b2424b98b55..964e33b6e74aee9582d8eba32f976c6998d36c68 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -596,7 +596,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sm8250/a650_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 7f592bd3024868c6ab4c9c61051d3f2cf5707a1a..5c40d4e869d354870828629238d6e14364f438aa 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -486,7 +486,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sm8250/a650_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 465fd6e954a347acf15ef3199afd8d1a198f95e8..6c9bb993dc2a3d12b1c7972128e2a2f64fa8dfab 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -556,7 +556,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sm8250/xiaomi/elish/a650_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
index 4ad24974c09f9bb75cc24e55bd4869b52a39ac7c..12565ad87890fea1cc6c25cc161072d75b793c1d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
@@ -426,7 +426,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sm8250/xiaomi/pipa/a650_zap.mbn";
 	};
 };

-- 
2.47.3


