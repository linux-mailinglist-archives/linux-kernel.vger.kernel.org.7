Return-Path: <linux-kernel+bounces-887014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7532C370EB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56FAE503C04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4E338912;
	Wed,  5 Nov 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvCFJefH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFVx9Kew"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEF328B6A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362723; cv=none; b=gX4dGmzAE0yl58tPVGwq/pPUyMPGwf3VGcWIlzzI0FfwLsqCdw8/p4+eJoKGmDEH0+vB6bXiqtlh4it8avNadFwzLZZA81GJgAXueIyq/o0gjfTg2y/OR5wxxZLtC1mimvGyxAMpGV67GP9HlpMnmggZa3DHlyneU22rVxSCADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362723; c=relaxed/simple;
	bh=UQno6js1laBBGRuM1136RGmbQMQqm5whXfqyW43PMB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNaL1agaUHgsNy8+VrQRJXKD5oa8nWExQErk2MNZK5LMQ6jYu+yXtPo+8GNNdko4XeOrZqd/Z390+HLLlDgwqz6E/MpyApQtQly+x0MAfcAzRSqhT8CqdAkT/4cBUAW7H3cLMIbYw8eJL8MVsLm7vNixgQU7LW8G6eMgiyARPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TvCFJefH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CFVx9Kew; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5H31cX3090853
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	791ljE8ofv4KbxaCgLnX5+k9zZdbkdmJjeOWvmYtNeI=; b=TvCFJefHSbB5LraM
	7j8yrZefkmefvf7qVaqzagyWMP54pHfGAxCBe4JUbqlvJTK1+kuWtowv0s0gYnvh
	Wpm2j1icNps2RVFLVX4M1tf79/PMnd7bgr9nhzE02+4ItIDcAJg8uw2j8vG+TZ6s
	sttKNU941dMkFLOur6DbgJWYfbGMBbVrGAoUkLDI+A1uHKoGRFom8DLZNgXDG2N7
	5GZAqs15h8cAs4OGQzCTqKzfkn8BLIPvZwo+Kro2ujkBMNkdmfavZhFPBGLBkAyR
	TePXVTNPNzHt0nUIvWAgeYRB0Vne+dokdNatnWB9w/hnWL3JW8kQgo+vvW4pZw48
	8mjVdQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7s5eb5eu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:12:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-286a252bfbfso1699805ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762362719; x=1762967519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=791ljE8ofv4KbxaCgLnX5+k9zZdbkdmJjeOWvmYtNeI=;
        b=CFVx9KewCmnKk2UpongnYVHUhzG+BXtiunCaNFcDsa7lnPmK8pWn2AQD2+GiuZ0K2Z
         /pXQQ1T1FIhG9ubFGL7Ilk4FcfoW3lD65octAKxFo3K8CDO1fSxrwTTotJRSH9Kk2WIN
         Bk9zNTLGaE7KroArwbbqiiZLVaMsIYF0QGwrEggNZ+xtVDJmvACV+tOSnXohJ2v/w3PP
         S3A1pjAWrDDbTpq/doIRQHKXvRMAAk0sQhBezEMqU1AJfw8fdYX1yNesrtITlu4PN1cc
         OM5JnNn9ELVp1VZsfVBaHIbhgOWUsW235s3f+Y5ZFREE7UKxxhe92+JyJOuV9NtykSR6
         kB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362719; x=1762967519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=791ljE8ofv4KbxaCgLnX5+k9zZdbkdmJjeOWvmYtNeI=;
        b=AEE6pv5d1CVgxtQOOg5APmyD9WxR6Kym8GUbsV1F/EaRCQKq5r2eRhxJgQ2GraQQz4
         PPYzCUvV/RB1yU9cWGeA3sv77BBAfQ+mY9ULsyPyqCqcuzaqhAn/cn9J/S/PE8Tk/gDz
         A9I3oQsdc1GH7u6Q6yFkcV10AzFs7RNwxSPavC+rriEJoTc1Nbu+uKcxNeyncXuVbxlr
         Sxmxk0uErAQ+2fHKGSFj08EVzQOETnEI/3zZbs5w/j9RldgzmF/witnSbDcrVC5r2P0M
         RSyxVGTr+G11SJyOMOTZWFsHEJk97Ab0GgY8qVlvpH8t08irDyF6E1aNLYPwZ403OYL6
         9pRw==
X-Forwarded-Encrypted: i=1; AJvYcCVoNzVOXQp2HNwG9FZzq+vFWF3mWoNvkqoD2MoXKacYbFTAr86XXNpuf2QzNhEVmuMa//IA9271J7Deeo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBW06w35U1kwkSITP1jVv5CJNU3Z4Ku5/ZzmJH4JcEMcQ4DICW
	4Y77ZvqScTdS3iqfstntQcwMFFLWQV6DnkifYXaU35qaSUO2lh2V1puMvNF3PMQBgbIRlnvU+tN
	Vf2CK0X5EGlI8BbZt93dGhFxJDu2KgL4Q3dzHMKD7RXpkNCxrpv8A3qWhrFOYwO6riiQ=
X-Gm-Gg: ASbGncvIDQmcV+fnrGxznDxojlx9ba4HijYftwALOYVZObsgjxFLPlEWoiyaQzVZEqf
	+zY/LEeLuzDW4zROboJpVJjRnnq3LKl4aGfZJTuq95JuaQJ9bpNihcfVcI0iOUovC7044yMbPH/
	pejHOx0rm27lRW2CQIrUADUpAvca0DZ5xmduIjF+Z2ndY9qRZWbjsMuJibrjLrZ6Lo4Nf6MOIh9
	+e3hvqQzBjt5cVGwz6rB8Q6OnKnOdP3JwGZjl+ZMzYMj9MIr3qNRelkyYIkdJjX4c+dadeOMJM2
	+SgQLPzaPuFBGjA20U1ZyenFwNVWt9RfBlwyYMWw3v44Rx9fWjTs+P0dsQKgJtuct0YoDTnYH6g
	LDydGpHC3I0MCQ3KcQAMreTo=
X-Received: by 2002:a17:903:944:b0:295:7f1d:b034 with SMTP id d9443c01a7336-2962ad82751mr47925125ad.4.1762362719277;
        Wed, 05 Nov 2025 09:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7vx6gRi3vnn4VoDJjmVj/WM+UJYf70Y+veIY5RUPDoORE/IhuQFEYI/vOAmVMsKNxs0eOpg==
X-Received: by 2002:a17:903:944:b0:295:7f1d:b034 with SMTP id d9443c01a7336-2962ad82751mr47924565ad.4.1762362718677;
        Wed, 05 Nov 2025 09:11:58 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm813955ad.43.2025.11.05.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:11:58 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:41:33 +0530
Subject: [PATCH v8 2/4] arm64: dts: qcom: lemans: Add GPU cooling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251105-a663-gpu-support-v8-2-62a7aaa551e3@oss.qualcomm.com>
References: <20251105-a663-gpu-support-v8-0-62a7aaa551e3@oss.qualcomm.com>
In-Reply-To: <20251105-a663-gpu-support-v8-0-62a7aaa551e3@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762362697; l=3334;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=dv8fOd2JCzTjOzv1PtyfPnTYZUgbOREKQ5dEyRmj6Ig=;
 b=DoDXbN6jLUIZNAoa25vhI/IM9EWA9bQQ16qz3CoxDpGRSpqJRLyXqvCVt8BGN683j6Zo0Ghqo
 c2QpoSz2/+zD04sjTQ/uxjzaSXmnBTES5ddxYfRo/kZzIDgstrsfWot
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: S1jlPIkLYcmNY9IvT3syDn6W7guScfLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX3JZ9evXNawhj
 mE9SnU9cYsGitXLSUjgxPNW/MbVC0Y2hzu+GMLiaC1sxb7x+QFAvT9Nitl3vXzVaFPUYYi04DYi
 i9GksCDyQQMA2x6sGC1SSO3Yvsk5e5kNIk9T7WU+m/jLvJLVxI+7AvtUZiiUhBWU59juwvSPx+s
 1ozNG7nP6fKNvJYenrwZKC4QApFhUGxthuIu6sskU1b0UemtY6F2AefCfGRUDKn5a8uc0KW+O6Q
 N20+uo9GAPpBqBZdiZwwQ0hxL3tgfKBBjGRd0ik3Srrkqvd5UiLIqi/D4qzptma9eOdL9J6cIWS
 d7RDnlzJ375pgJ0GwXNYYL2JDVBQjYSZi3Bt0vdtzWfUQrKeemh8kqt88ndOtgeoctRL4BL6RnF
 ahsQUXAG1irEjoyhPEaCtbqVfJ5FCw==
X-Authority-Analysis: v=2.4 cv=OayVzxTY c=1 sm=1 tr=0 ts=690b8560 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=e3DMr3DmCBmV6l14PKUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: S1jlPIkLYcmNY9IvT3syDn6W7guScfLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050134

From: Gaurav Kohli <quic_gkohli@quicinc.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures.

Set up GPU cooling by throttling the GPU speed
when reaching 105°C.

Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 55 ++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 883f9e0ab45c98b9e128f3fa141d625431d89831..14d9f31e7086dd337c658cdb3989a4fd1c83092b 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -21,6 +21,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -7514,8 +7515,15 @@ gpuss-0-thermal {
 
 			thermal-sensors = <&tsens0 5>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpuss0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -7534,8 +7542,15 @@ gpuss-1-thermal {
 
 			thermal-sensors = <&tsens0 6>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpuss1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -7554,8 +7569,15 @@ gpuss-2-thermal {
 
 			thermal-sensors = <&tsens0 7>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpuss2_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -7744,8 +7766,15 @@ gpuss-3-thermal {
 
 			thermal-sensors = <&tsens1 5>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss3_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpuss3_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -7764,8 +7793,15 @@ gpuss-4-thermal {
 
 			thermal-sensors = <&tsens1 6>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss4_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpuss4_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -7784,8 +7820,15 @@ gpuss-5-thermal {
 
 			thermal-sensors = <&tsens1 7>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss5_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpuss5_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";

-- 
2.51.0


