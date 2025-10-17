Return-Path: <linux-kernel+bounces-857263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F989BE65AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8419A7A43
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28C30C37C;
	Fri, 17 Oct 2025 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kjOnHFId"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768C10F2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760677386; cv=none; b=PyJNub1WDhzi9JXezcmO5JUJVanq9nkmTnCrDkhJXrK3y9g0ofTSkEuBsl+07mHshI+3Br27BL3D6PZK1hn+P3DFMYo8latidnAB/Y/wA3htRROt5acT/S/E0iGnam+0d+CrQwDUkNuTKtyILM83xQjwocU5abfpgCDd+XItuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760677386; c=relaxed/simple;
	bh=fQ+8SkOvlcoyl3hn94wEpoeG3i9B3kxg+mTOn4oSv6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XNJwa1zPpOYgbJ16ryOOIByfjGh6BkVH9wq9LN8r9nIxlwqyf0gtZjVv1xTF9Sc2CprgJ3QeN7e1OcNhZas9PY98Ji8Q2hmvVGl6Km8lVfRNKC20G87gqauj0LrG5wbb1Vy1VNKHBUpzS7HXjBzjSjSvkEsBy4JigcDao9VzP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kjOnHFId; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLRDe016181
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fUiCoy4q0GKnexrafIN6QKMtaP84SBwz3xh
	i+xbnZ+U=; b=kjOnHFIdfbib5/2VqTP7F6Q5RK48uSpeFF4zY8x8rub8AgWhh8L
	3IhAvMUlEytxitZDnWBe/96zrwUjDv7Xu7S6fs8ksACxcuDjJo1bsV8yVDEI0t0F
	iEZL2q7Y4PJBWzkyPx5JhMw5kvN6so8t43ma0+51utjsE4Wz0UpBTsmKw53DqSfk
	LrRGnXeFV9LMFcjk4Wapk4RftC4Sg+1uGL4yr4RvCFULCgifWLNOpnea7Wrqgwv2
	1ic05jbc05NMZbIXF/3BFAhMHpnJd07uolKu9vbYE9KsVanGSZOU0ILXf//J1I/E
	0YjeIsVbA0MyeQlnR2ly8rswvcMYz/8azwg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5u20a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:03:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909a67aed4so15829535ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760677382; x=1761282182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUiCoy4q0GKnexrafIN6QKMtaP84SBwz3xhi+xbnZ+U=;
        b=VIcWPvIWz7xKT8TvlnZLlmnvAupkd27VoNBkqOOK2jnX5qy2aRcPL8wLMd/yeaHBKW
         frOjgwnV/Wruk7Je1AlYHkbPIbycYA1fjD8m9d96WG4YtgFMbNgiCFYCa1PgITuZV/KF
         +hwRtzoMERnT2u0RJXeFj34rCt7/wzy+huYmEKsOJEcvcNl2BsMWgUki8oK21HWX/2ri
         wEUHbV0YCDUlBCiOqCEAJeDvXe1wniCKdCjOrdtXEvMPY5yLRLL5L7rXI8muOgozVuDb
         x/77qkLZpDIsTxhwf65Bl9c0xB+qes/DpE70mBds5DJ7D/VEGSpm3SwRCSECzMvK2UiQ
         1/qg==
X-Forwarded-Encrypted: i=1; AJvYcCW54oNWgNhex76WK9YOECwGMaaWvkBXbvTnyw1vLHQhsM0de8Irh2JiJRLQSAuEvCno8FFl2phCY8cv9Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LFq/DHocBcg0rew8TS1mSRzP5gAHJusjHuWFqlIvCCWhZDF3
	A4rwDBvRXFtcPdWakyjIWzhAde2R0XfewxJ6lWE2PVft/yjs4W5r2dA7KQDGedt6ggTOsfkQJh+
	iY2ZkglYJSdLH+TsF5FuHq8mlKnWNyW3q0IElVtCEySGhXSBpWnW4RWupUEYIzguI0DY=
X-Gm-Gg: ASbGncvNhpBNoFsQNEOLALS7vfHSLcAek9vCP3BAELGWdncdYDsoFXDGUYRSRUJnNpC
	xrqcjg/lSP0mv/5T90jvd9Anci2Vybkx4wnqidBz9h4Ic9IfF5P971m8qdGKYkN6+5UdxXSXoDf
	j4pbwV0UW6izHUWt1JwAHxTEaoUjegsiTAGH/BJq54vxcS6oEz02IGM8tI41ADNrsQ8b2XjzKB8
	BDjbDNL8UxetzadhHIRJK4wnWzOD0QgYgR+5PEg9i3j1YZHJstOK2+nOodggV75A3zXOPCruSR6
	4eJhePYGg0+fW3AMJe2c4r4/mInZNnslydpjCvKkfXU6gqarmf9y2hi24Y242oigjrfhUOH6C3x
	GfOV44CR+MGmuoi45/azN8cJ4PrO1
X-Received: by 2002:a17:902:ce07:b0:24b:270e:56d4 with SMTP id d9443c01a7336-290c66da794mr34740495ad.4.1760677382194;
        Thu, 16 Oct 2025 22:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFETcirbfNHKtKmLD4YuAozg7cIfcNgDOVz+Tr5CELIua6KxwYN18BR8lnJRJggZ0jymK5Kiw==
X-Received: by 2002:a17:902:ce07:b0:24b:270e:56d4 with SMTP id d9443c01a7336-290c66da794mr34740055ad.4.1760677381719;
        Thu, 16 Oct 2025 22:03:01 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afde9dsm49089585ad.116.2025.10.16.22.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 22:03:01 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.kohli@oss.qualcomm.com
Subject: [PATCH] arm64: dts: qcom: lemans-evk: Enable AMC6821 fan controller
Date: Fri, 17 Oct 2025 10:32:56 +0530
Message-Id: <20251017050256.987660-1-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B3eVUnDk5hmCB5q9TKYY1Xx656mW6HNe
X-Proofpoint-ORIG-GUID: B3eVUnDk5hmCB5q9TKYY1Xx656mW6HNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX0CY+4ZnrYI6e
 GkVzXotumoKyBKpT5brK3AXLlqlaTVGU1F9O4XEDmx8ifYcvHuXhyrW/YlWzUVgpVtXszwTJ6Ha
 Wq3ZzbhPnfzs4y9dekbhnr/0Z4w4YyV6+ZuBO3vfpfzh8LoEwzX0qUUIZV6Q20sVX3yJGLuFvfe
 ssd4hr93J5qopv0Fs759j5ztUL7+9wgPiWXkUHZLyqJLITXsUtnhKRtiatdByvBvG5J1Cz5WBcP
 pkcjprNA/pFPc2AShi9jMu796yyN1FytzJl1SOLefA6/unqqWiwTi/HfUl5r92CXMzg2LHrgTnJ
 Cd494zM0bcJ8JMk996AiqDuLp/TSQQc+D6DDwHkpWm5XDYQKdtjP3lllXelm1Du6AKIsdOfLCAJ
 HjkmLIzOi4AOQ2yzU5/gav1HMcLzaQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f1ce07 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=7r9TfH97x59IMh4ffdIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

Enable AMC6821 fan controller for lemans-evk platform and
configure pwm polarity as inverted.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f4457..9bc3e6d4c9af 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -501,6 +502,20 @@ mac_addr0: mac-addr@0 {
 	};
 };
 
+&i2c19 {
+	status = "okay";
+
+	fan_controller: fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+		#pwm-cells = <2>;
+
+		fan {
+			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
+		};
+	};
+};
+
 &iris {
 	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
 
@@ -587,6 +602,11 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&qup_i2c19_default {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.34.1


