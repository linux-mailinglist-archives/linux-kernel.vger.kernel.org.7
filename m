Return-Path: <linux-kernel+bounces-874682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A59C16D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A77D4FBD90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E32D9498;
	Tue, 28 Oct 2025 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jb4lnCP2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYbl6qo6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB6351FD5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685216; cv=none; b=dJXfkoB0/t25buda+Vv7SfXoSQMvfyC2qtXKEhuoyfEEDT7cX99HZWBVe74+J8VXF/ZjBnKQjbaquOjHlfS+599LqZnS4h8B2Va5t4WwxtZn5BdahueI4KMwRwqJBfNvEF7XlBimJYjeoXyeIE0uHJXoEbd9wRWYXBpv6vAUlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685216; c=relaxed/simple;
	bh=EsmtIGGogp83Wk5re8Qo1ymE2FtIHHnW81gg07LjkxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndGC9QbA77UDA7LUaWCjYNtjcGjWqYYBVZEsmAa4rX7mRNh5w6VRu75Ulq15uQlek+Xtl/j3a8oAGmswVZ+5hZdJsqfLIcBIBcuGHlKXJihbRx4gaFoHeUUwLcI6bJFvXLQ5iVFZoAXCHXdapX++RyLZXqCKnZZsdQ3uHk4lEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jb4lnCP2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JYbl6qo6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlUQs2525419
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VziEZZGKxOa0Rm1W6uu/3kIDvdp59RTq7ZhYSMj/7Y0=; b=jb4lnCP2QE+Dj1sk
	8w+zQB+pHI1fUeKzl4nAhMsGlHQ6qMSBQzkVzFK+sb5KRfqSVJ/w/esWQSBhhJUF
	loVt/ICWM8joT8KbgrAVzfO4ygUCuJ1+L77RfycRYNzCdHPd2ttc4feNmkxBQYlx
	Ks4rJBFBojTNKnXql3Ng6B28ol+TQ+aQe1Dc9M+erhCUS+99kDnSizA7vn7wbqz/
	v5mkQfqRanaZV0EB2X0nArtAlws/25iVAvD9QjJ4PpYxzJ/u+5UFiTWxfnjWw+Bs
	MBdaksDVuFDBnNVCKi58E4ErJcr7IdJuZ62NED0m4/PdFuuF1QD5fAcLyj4lxqnC
	E3aygw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a3r5uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8a387d01bso289373071cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761685213; x=1762290013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VziEZZGKxOa0Rm1W6uu/3kIDvdp59RTq7ZhYSMj/7Y0=;
        b=JYbl6qo6UUG6sekcwmSnXudptfbsJXls6kKec4GdBiCThuH46aHhwDUDGTh94MhNg9
         kIQjE97o3LfzVTl/mtE4iCLfI9pMtfMuRTbjxjcXSJZNlyWOPC0v0WHOZZN8JtGdi37x
         VUtNoVqrVNk0/gGEjBzyhH6xJyibXgcF6L9p39Vh+nB2T/bqjDvPhH7Jq3y1aNjg6xeC
         yekd2MdgX4hlXFDb4Z3JIuxIRaJlKbsoTJK0PzlzHhLLNdGUB1rW7Is3/7kdN4MCXbV7
         JSt9ImHgslX9QRsp24YYnyjltnnvET2/0aiX7Di21pmYByjnP8yaWrhYzYE12sXX/nKk
         m9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685213; x=1762290013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VziEZZGKxOa0Rm1W6uu/3kIDvdp59RTq7ZhYSMj/7Y0=;
        b=GjkFJAVfp+cP6ZEz8s4h/ZzNrDt8yTcrWfWSXdIGjILuENGZFRUQbEr7xQh95lXxdE
         6I7IHnwL734yTfFdv1ahTQ8u+J/ho8AEeCQoIInuimtXggGICfqpB8FfRYV8atu0kSeX
         BcdX17GSTyy2Qu9WudMEZxI2qP2UYB3UNKeC0kIMNTltlmJDUy+VR7fU+9MQlaQBTsJu
         yVtYXEOtbvkQ82JlOaQ4ID/upP8i5uDJZv13q71QHh7jFOq0Iy5qCjNLm0JAPc+124KC
         d/BHDMjeZf9aT1dK1PH8Dw+DMYoST4KAnaErRZaYP1pHUH4PINsDIG4EoI3IIXug6kxp
         3CWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxHdfMrD4vNoI06KlPu+1+tiwBGkjYiSM2qXLhYpdxXBaIAF8IZvohVTmn6tEzCGc3Uur2eDvIE53doyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7iquc0yyaUKz8UyYhf1da6Xe1s8J6t9LSxAk/ALC2KvVtFU3
	AqwW7q1z7nGyHlAMgXKeGejUW2539r37q8f5qYO7ZexoKraFVA5GJa8cHeUgMykjhPKNcg342rb
	2Yzq6VL4I1bDUMzHll9rPg+HiUHTW/WxVHo4j6hJtJ//pIGrp//tbzBeKceG+QafQ/yg=
X-Gm-Gg: ASbGncsOQFx68V8P7f/XZSsk9ifPYSZisVYudxlJ2hX9AKww5ePhsqSbxszmkjusfI9
	GCrDpBdBM9joL7UQQgGFMbIflo6hFxEgeksXCoim370qY/yvj2YhuzCE0/KOLv7oUph6BOb7pUf
	Sw2bU51foRroF1fnh1JrQGA9WNKZK8lSLUb9/ebt/UJLRuvguVLeROfk2/0RQ/iXVCoIt3KUfw3
	rVqJl3+hjcNZ1sTWgygwDN6940nijswuVr93OHPTvC4g8nNP/oKoaKFmHT68qKtaxQLzpdtMIzp
	Pgy+K94OJ/80dxQOKDt7/fBFJukkKwPedN1n/9wEDDcth25/hTja0/tZxobHlfOI7LoqgvN8yXQ
	3xaIgS10oVjqER72wjfXvddadNPi8uIl/hT5ahCdp2AX3dj9rDhXOMGmtZSwqNj0R6UZx1Ns9ff
	2wNns+YjjGq99s
X-Received: by 2002:a05:622a:145:b0:4e8:b559:7b90 with SMTP id d75a77b69052e-4ed15c2be04mr8766321cf.68.1761685211109;
        Tue, 28 Oct 2025 14:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp4D699l/ScHj7pfWPbaPFKoz3mBy5SEBiI9F++8ubrl1KHnuXbAI3V3Z9L/DoSu4ZDbRHlQ==
X-Received: by 2002:a05:622a:145:b0:4e8:b559:7b90 with SMTP id d75a77b69052e-4ed15c2be04mr8765751cf.68.1761685210484;
        Tue, 28 Oct 2025 14:00:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f861f5sm3283594e87.107.2025.10.28.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:00:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 23:00:03 +0200
Subject: [PATCH 4/7] arm64: dts: qcom: sc8280xp: create common zap-shader
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-zap-shader-v1-4-7eccb823b986@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6085;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EsmtIGGogp83Wk5re8Qo1ymE2FtIHHnW81gg07LjkxE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAS7T+HSRF/+ghtiyTHIQaLfnd0SxBR4GSWkMp
 mM+P/YmLlOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQEu0wAKCRCLPIo+Aiko
 1R6XB/9dAt3BGICXtu+OkJl+yIc4PbcgFV24nXy89BncoNanCMevExzEIR3UvR6SySBSije3zi/
 nuTbuPCN7FSHaLsrcFrnKLzMU7wy+osvL2gfgZ8nia40bjzGQW5+vmybQ5c5EgletwAPYyehtXg
 pQTxoNYbJ6N2HIguojwSL2t5CNSheSSN8Fk+HyuvyJUajX6ohTjNB9jm0Yml/9aCSqlC6vz1rPW
 MsSN3+b40z1xto6TvAgQQ9hBjIk7GqyIXe2d+pBgM4cnvoUJ1OGDgHYBPp/+0dHDGqGtSZdf6NX
 n+lxG2ReX1DrOIs2IzRmVJGUnVxWvhIthvYkkkaJ+sYoyoaf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: MKKmc0M-G9THgFbOu47LenVIaFdQQ2Xe
X-Authority-Analysis: v=2.4 cv=HM3O14tv c=1 sm=1 tr=0 ts=69012edd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=B_G8A1FuJYmnm4XSS68A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3NiBTYWx0ZWRfX0pTKX5BuyOQF
 +UHjBCoXkhgFAVeDGglx/BM62HNNbGc8nnkTM72xuViApagOEvP3BerAZVc7k2dyF+O2CFt2i1n
 dtHxzOHC/fxFkash6JIzZHmF+ngXhthcA2/VUhmvyDYBM+o2XtHvtJ8tojtuSjx7QVlCyuwAWOj
 dzi2AVfLiEPQEzelv/ptbLmy/EXB6f6Mk8X7w+Om0kvBJ6tR0Vg0eFyJikeUas54PcNOnn+RAb7
 OTECi83awF/yXEAYUT40Xk2HERV8400BlATY3/EVVQK05uLl/WTcytFgJJPTdiJHJIxLTjku02b
 +c0O+tVmTdM4g0Buj7Z19QegWLZhgANZCjFw2aYDvHoC9i4I02NtsHnThEH+erdFAtZUpYUxLA5
 ZBZb0QBJPStNHkHrCU3UDtIwmHGEoQ==
X-Proofpoint-GUID: MKKmc0M-G9THgFbOu47LenVIaFdQQ2Xe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280176

In order to reduce duplication, mMove common GPU memory configuration
from individual board files to sc8280xp.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts                   | 8 --------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 6 ------
 arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts       | 6 ------
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 ------
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts     | 6 ------
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts  | 6 ------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     | 9 +++++++++
 7 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 64e59299672cbf316b4eddb978e4583ff34c0299..524d44cbae740577e010f156308a715962db1a36 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -149,13 +149,6 @@ regulator-usb5-vbus {
 		enable-active-high;
 		regulator-always-on;
 	};
-
-	reserved-memory {
-		gpu_mem: gpu-mem@8bf00000 {
-			reg = <0 0x8bf00000 0 0x2000>;
-			no-map;
-		};
-	};
 };
 
 &apps_rsc {
@@ -347,7 +340,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sa8295p/a690_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 490e970c54a24203ab297dfabed7e21c2be244e9..858f71737d93fd8591ba42eb363748ac51699d63 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -225,11 +225,6 @@ vreg_wwan: regulator-wwan {
 	};
 
 	reserved-memory {
-		gpu_mem: gpu-mem@8bf00000 {
-			reg = <0 0x8bf00000 0 0x2000>;
-			no-map;
-		};
-
 		linux,cma {
 			compatible = "shared-dma-pool";
 			size = <0x0 0x8000000>;
@@ -511,7 +506,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sc8280xp/qcdxkmsuc8280.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 0374251d33291fc5804c9be0dc649ccea1c1c0e0..69d0d6c12e58653f8cb56cb7d383ad9d64699d18 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
@@ -158,11 +158,6 @@ vreg_wlan: regulator-wlan {
 	};
 
 	reserved-memory {
-		gpu_mem: gpu-mem@8bf00000 {
-			reg = <0 0x8bf00000 0 0x2000>;
-			no-map;
-		};
-
 		linux,cma {
 			compatible = "shared-dma-pool";
 			size = <0x0 0x8000000>;
@@ -602,7 +597,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sc8280xp/HUAWEI/gaokun3/qcdxkmsuc8280.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 637430719e6d7d3c0eeb4abf2b80eea1f8289530..87bb42d9cc327a1d1811f15605a369dc8760557d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -283,11 +283,6 @@ vreg_wwan: regulator-wwan {
 	};
 
 	reserved-memory {
-		gpu_mem: gpu-mem@8bf00000 {
-			reg = <0 0x8bf00000 0 0x2000>;
-			no-map;
-		};
-
 		linux,cma {
 			compatible = "shared-dma-pool";
 			size = <0x0 0x8000000>;
@@ -724,7 +719,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index aeed3ef152eba0fff13f8fc150f32974bffbe8e8..ea50e370f69837ec9412efc17e2a41034b0736fd 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -186,11 +186,6 @@ vreg_wwan: regulator-wwan {
 	};
 
 	reserved-memory {
-		gpu_mem: gpu-mem@8bf00000 {
-			reg = <0 0x8bf00000 0 0x2000>;
-			no-map;
-		};
-
 		linux,cma {
 			compatible = "shared-dma-pool";
 			size = <0x0 0x8000000>;
@@ -464,7 +459,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sc8280xp/MICROSOFT/SurfacePro9/qcdxkmsuc8280.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index a40dccd70dfda873fb963b71e39617a2025b86db..48b60f6186fc1d69178902f2cc3bee324144202c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -227,11 +227,6 @@ vreg_wwan: regulator-wwan {
 	};
 
 	reserved-memory {
-		gpu_mem: gpu-mem@8bf00000 {
-			reg = <0 0x8bf00000 0 0x2000>;
-			no-map;
-		};
-
 		linux,cma {
 			compatible = "shared-dma-pool";
 			size = <0x0 0x8000000>;
@@ -581,7 +576,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sc8280xp/microsoft/blackrock/qcdxkmsuc8280.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 7b89d3d422ea62012daeb423e457a20e84eeb0b5..b7044b9d656e4991e737f7008a7cf8f0619dd115 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -691,6 +691,11 @@ reserved-region@85b00000 {
 			no-map;
 		};
 
+		pil_gpu_mem: gpu-mem@8bf00000 {
+			reg = <0 0x8bf00000 0 0x2000>;
+			no-map;
+		};
+
 		pil_adsp_mem: adsp-region@86c00000 {
 			reg = <0 0x86c00000 0 0x2000000>;
 			no-map;
@@ -3366,6 +3371,10 @@ gpu: gpu@3d00000 {
 
 			status = "disabled";
 
+			zap-shader {
+				memory-region = <&pil_gpu_mem>;
+			};
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.47.3


