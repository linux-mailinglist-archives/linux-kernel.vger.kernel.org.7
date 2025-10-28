Return-Path: <linux-kernel+bounces-874681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D587BC16D95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E2C94F7549
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC24354ACC;
	Tue, 28 Oct 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFAnUJSh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ox6MNUtg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE46350A0D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685214; cv=none; b=XjbccaJGlLR37IcdPmSXXuZNYrF/iiKLZvhvR/U4O+xZDME5/Tq/SRi39nkeVfdWmpXK/4uYsYp+9WzpPyLDTVjq03ZWLPGAerSl8wuAbI1p/kIi5IBjKr6e0pAcyay7Fbd6ho1sCzIh7JP0jxvbBl55aYcbtNGwas23FsAnWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685214; c=relaxed/simple;
	bh=CwYtSL3ydaPjZtAAIaViNMdmrzUpICYZyoSsjpUWKZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSDQPjjT6i+fUxLAHvZqUNq0Nz2g7YLo7k8Hf5gnhXf3s7LqiHJ0qlhK0+bS3ssXOmnLk94trz6ss1ApLH7AEqo0aHjw5SLne9eFWOb0sYWz9/fa8vDYBP1nS7pR3m+KnuOUnqmo0MXyy3XA64W+e8P/r/Wgv2m2M09TPtsemUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFAnUJSh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ox6MNUtg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlH0H2615908
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKJZs4WeO9wG/g/LdylOAbfrDrIQHhIXPp1U//b927M=; b=jFAnUJShYJnGsEEa
	ZpgdiUuqUuGqIMOhyp6BgGWMzuh8CqG4qPdTE8qgSD9/2AzFtQfrJHcgp5TsjLFJ
	TwZ0BYLHnmZSqRhAXIdIFH1ua1uK/pUg44kSAtDMfPjiygGL8YhjpKCUzjv9kdJ5
	bRoihPK8MGvewxN4HAdJXMXbUaHv06zHEjdQGmIbJuLqtEscEVIwA/0YKXWovvBN
	wnMy9sfaPAuiWF5UUM5p4cnAgszwm/kJxGauuqodMaSCBNiewgIMjKJOjjA1eXCy
	FB0uCIEN1UMxdUurVme8DWDPbI17+QyAIIOi8PyU24HYB8QekPqTprnkxBF8OTx0
	1iTxHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0g58u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf2adbd3bso23070301cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761685210; x=1762290010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKJZs4WeO9wG/g/LdylOAbfrDrIQHhIXPp1U//b927M=;
        b=Ox6MNUtgrAnIvKLoBZey+24otVKem66hyuLLj+NHTaEjPnSok81SnlCvHfQpSIoDMP
         Chw019kXP8+U5vcpSYfVB8cEEtCw/5e1LtfitY8Ce520EDnqoiTtYd8WlYVCNv6ZuXC/
         5Kt9A/q/BXJnpGDhQMi4zhk/hG74F6xKMfqmM7NuYloFhomGC3zlG6zKEeQD9OHyw8tN
         g2KNp6aex20WGRXbGqxALen//lw28269WIl5Kl8EYGPNIzUgWRhiQ3TBLMPvFx9eeDoE
         LUr7S4a1ney5TfkDA8vkkS4AEuJ6N6UxRPpK7Dn2xKr2Bpe2OUfK7ghoaCsLtkHsNoZT
         OlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685210; x=1762290010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKJZs4WeO9wG/g/LdylOAbfrDrIQHhIXPp1U//b927M=;
        b=UjQacu88Sk4xs4PzgVnglEZzc0Aj1Xn7NtiFL1rZtMdNHoWNl4pKqoLgO8kHPvihzd
         cVh81vIMErlqUwjMJmGtb0XQQAascfHZijInuLQZ7RXeXm1JVL5BjXqUncEsrYX8b8IY
         HBj9R/i9WzRKN8EjuG326fCGldx6goL34S+pjqmFX4eTuYl0Q4ckXcsQBSYBXsoQJuM8
         Gk6VrF6YUEhcGtPn8O61FIrUd89z6zTWg24flw9Y4cKPE5VkRmN4URxR0kaQLE+uXdKC
         N5ydtdg5lb4eCeCJPbqR4Ntwgz+DKmGVomuSf3Ghvv9/Ks0thOzDrx0tmdrU5nmsZzjt
         cbxg==
X-Forwarded-Encrypted: i=1; AJvYcCWAELYOZ5kCiYIYd4ZI1NTSqKqYV/+WZJ4Ihx4cEs+48wabkCETX1ypQKmamTfnqTVtA2gDFMNj5C3Zc0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LdLhzciZkKQGOU0JaigotJR5/vD6H6QudsvhN1D+V5PQ9V0l
	PnPuciYewlNRo2WdhRyf7dUt5PPVK68lEWtbp4aRohdjsR6HWoXYCw368nIwFZSQqyowY2ZUAij
	JWyKuotOCegWNg5PBrfA95T2qTEOR5VWTWUDvGJLqrvmuSnUJ8s8Za4bazrHqD4MpR+o=
X-Gm-Gg: ASbGnctvnjRii52aO9gG02yLVhLy+EYj+96N4/08FoLDwz452XMGq5xWxpNExn8UZEY
	OoHUOnNw24A+ptjKnCAY54XBEdlADNxid2f/xvzLc9NtisF4TtU5m+K+QrFYuzNwQlk2PNYg769
	OSimq0EleqKrzK4p7BsVteekw7YZVMO1v2Lg2KYuVo4MqjxzRSXBPhwe6c0nLcNmSuhVPBQuvgY
	ToryDwMhiapKvsl53J7mZzx8QQKMBSsuEwrCXe0nTlgBqo5FuvaIS85z7IQz9H2RIPUslIgQvIR
	ZMH2WmlF9xMywvHqFBYC0n05zzHi1ByW+oA7tjwsiuJmIFTvkqUZIaHQSeSBdK5qkp9S5I7ve12
	eBcf36HCOuL9ieltnQOJdW7ohskkMdpPe0Duum0aOrCKU5398FuSdnWBzh0nl7SRMwi+PvrZImD
	xeBVGldkgdWoqI
X-Received: by 2002:ac8:570b:0:b0:4e8:9920:be58 with SMTP id d75a77b69052e-4ed15a3c027mr8115981cf.0.1761685209860;
        Tue, 28 Oct 2025 14:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYsTaZ2jdJMiMfGuRq3YefyAWHJmT6QsE8Ud6CA7utk+BwEHqJQK55j+Vy7cSqUKHznLRDeg==
X-Received: by 2002:ac8:570b:0:b0:4e8:9920:be58 with SMTP id d75a77b69052e-4ed15a3c027mr8115591cf.0.1761685209384;
        Tue, 28 Oct 2025 14:00:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f861f5sm3283594e87.107.2025.10.28.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:00:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 23:00:02 +0200
Subject: [PATCH 3/7] arm64: dts: qcom: sc8180x: create common zap-shader
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-zap-shader-v1-3-7eccb823b986@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CwYtSL3ydaPjZtAAIaViNMdmrzUpICYZyoSsjpUWKZk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAS7T12d55mqeVo5ywuIYzsFgdFy3gAjM9XMyp
 yF8OjughTOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQEu0wAKCRCLPIo+Aiko
 1eyKB/oDtn9PWtRtn06HR3BUcJVXCT7j1t/JPU0CXkfcW1A28McDCX+/LYtZ+MZUwG6BvQo0Rk2
 jKv4+78nJJ7CZxo+MtgKhDq/cGulzzRhAKfMa2FWFitCIIN8Hr6s9A2MnGaNT8jLHxVgnb+JU3/
 R3Oc2zmEsIM3CBKc/9ir/aeBHn3n1LLrkIHc2q5/J1r4oxPBIVTwJYEgkmcTGoDEcSSCwtCfaxo
 iEDV1GzF8STQvkZadiqLPjTqdziPn5EmtbIF2iLI3fAjBPXiI4qLDWkuXqkD68oTYwWkoGgw7Aj
 rvIOob9UirhmOGqbm+L/2lPfwFYvu+IoUeorw1ugqBDW+xBb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=69012eda cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=IGUcv2A_Vedk0hkw8VMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Ic46D_saBYp7qogEdQwUASsUFcYlgubH
X-Proofpoint-ORIG-GUID: Ic46D_saBYp7qogEdQwUASsUFcYlgubH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3NiBTYWx0ZWRfXw2ojtrYvz+b1
 ZrNrcrrzk4+i9nO0BmLctkYjeAjy2pFlawSgu29bKhIKJE+o4GrT0Hf2fq9Bxujw8jtwOBsTWyE
 xjIyDkwOA9vjg3631OZ6BgAzJMA5izxDFAWKpmiSclUWD2Wn0pkLvtn/Nn6CMb5Y+ptldmk0s7v
 os8yPvVWn1izT5LBcrkCk1rqLqEzR+I4cWi/pI71+VyRPSq55RDbQ+sf7jXjKpvMs6cyTep045o
 6t/XMwLFc/VmzIgU+i0CxL7OffQs0BA6R8t/kzM/K1Z7WN+RhvsYYg/ykAprF/WyyecUw6+wEFO
 zhmhvZNJB87FaRSjH1ACZUksvgEImGG9fpMVbI6lFULQiFWwjbetkvismYe1erAGM4v5kaHv1hF
 9G7/7X6Cwue8lwL+AUxCBjz5VzXNMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280176

In order to reduce duplication, move common GPU memory configuration
from individual board files to sc8180x.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 6 ------
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts         | 3 ++-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi               | 9 +++++++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 08d0784d0cbb899b021198bd85e26f1a93861713..625a155a584ae4ca14c6f373ef21b773ea7311cb 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -151,11 +151,6 @@ adsp_mem: adsp-region@90800000 {
 			no-map;
 		};
 
-		gpu_mem: gpu-region@98715000 {
-			reg = <0x0 0x98715000 0x0 0x2000>;
-			no-map;
-		};
-
 		cdsp_mem: cdsp-region@98900000 {
 			reg = <0x0 0x98900000 0x0 0x1400000>;
 			no-map;
@@ -357,7 +352,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sc8180x/LENOVO/82AK/qcdxkmsuc8180.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index 93de9fe918ebdadf239832db647b84ac9d5a33f6..069953dcad378448800d45e14931efe1fe1a69fc 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -14,6 +14,8 @@
 #include "sc8180x.dtsi"
 #include "sc8180x-pmics.dtsi"
 
+/delete-node/ &gpu_mem;
+
 / {
 	model = "Qualcomm SC8180x Primus";
 	compatible = "qcom,sc8180x-primus", "qcom,sc8180x";
@@ -444,7 +446,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index e3143a4a41c948cf4ddbf4b137a1323366566fdc..42ab76d52ae21c39d5855e20e11f9cb2319f3afa 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -646,6 +646,11 @@ reserved@89b00000 {
 			no-map;
 		};
 
+		gpu_mem: memory@98715000 {
+			reg = <0x0 0x98715000 0x0 0x2000>;
+			no-map;
+		};
+
 		reserved@9d400000 {
 			reg = <0x0 0x9d400000 0x0 0x1000000>;
 			no-map;
@@ -2274,6 +2279,10 @@ gpu: gpu@2c00000 {
 
 			status = "disabled";
 
+			zap-shader {
+				memory-region = <&gpu_mem>;
+			};
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.47.3


