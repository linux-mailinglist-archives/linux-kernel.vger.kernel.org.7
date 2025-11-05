Return-Path: <linux-kernel+bounces-887018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E1AC36FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B01B342010
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952D33C52A;
	Wed,  5 Nov 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDp2Vvcc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IcatfDzd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9A26E6F9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362737; cv=none; b=MBPLCW4+q/Sr4sCerKjwLj7vvhUNjoj8mNXfBg5D+G3haCAglMSF4r3Rx/QNn4BIIrj3JWGw4c0KUJFWsEv76hZtyZxgpmp3dYj6gT7NmUQ6TFHg3GybtoOkWsEqHptVmXM5Fyo8fQ9ivq1LIK62IhBwbBZfC9XwfVG2DdKER9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362737; c=relaxed/simple;
	bh=ya263B/ZSqT4MVjFdASA/QB9AUBc/m4QKS8TyGIHwqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unRSRZ5gp8ltrWDCY24GFPoF1ZZJVsXwEeKH06DaMGE/C8r6Bndr9azRTVyc/uQbnV+9sRvP76G7baGkYOvxFHzc4ROHB5bQLEr1njIpi5Stq3INJ/P9Fc68glC5imBfAK00ZX+baecUWrveFFJ+EB1hIcNOWLHtr0Y+x28SjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDp2Vvcc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IcatfDzd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5H6Gos1542497
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Js4xfc8+ozAN4gatGrEl/M6dM+koKQCIKD1ockMt0Kk=; b=FDp2Vvcc5kkhMu1x
	kf+ZCCrdvjVFJ6zIQVALqwYHAcCxlZJ739V2v6S5i7Ole7c5Wm5WQarbdZTPp4qJ
	Xaohmz+Y5q3rWUQhdapN2BmHa7+F0eockQ8mxHS5YOcAMfV8MFlS7Yxy2ol9uKTl
	7/e3z4M/6y3mwIexaqlsiD2efdW17toS+qnjDHixvqBaLCcndf0z7iAyR5w/xI49
	l3f2DLmoBKPiQPGbyW1SiQOgejroc2mHh9lOGmDtbNNjcvpeZN9evY5rFoxHCCc9
	/E8kpYm+tMyNefzo60SmbDIytDPNkuYBNQumO8w1wLjnv8bJ/8IZYt11Qo0UQuCK
	tqLiVg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8apgr0q0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:12:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956a694b47so884475ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762362733; x=1762967533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js4xfc8+ozAN4gatGrEl/M6dM+koKQCIKD1ockMt0Kk=;
        b=IcatfDzduOUZFaGx/uc/fqVpErdDpeTyRg5LcNAeGHWcF+i0pqVskNUtnBLBjp+PLr
         19IPwconizR513bcRdaw+X5u7vLUSAvNapAjvSQRT8Z+0DsOhNvn2PYJEIzZn+SrICuY
         ROnUL4nA5Cje03+o2t2GLHtvNGBz9VuHXJN/X6j3Nd1Wwgzl4xJna8kWSpuiNnKCEjUy
         t6aPvt38N/ctPToWj2+6G6sobzOtMJmP4lIDTxnqO0IxMm5y9GGtF+nP/NUhYvX6y2Si
         9O24QEu34CdmV+8hT/vff1oT17ptfSYeR31H+eqQSpaCd1+1Gke/RsYe1/88dijTo3e9
         gzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362733; x=1762967533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js4xfc8+ozAN4gatGrEl/M6dM+koKQCIKD1ockMt0Kk=;
        b=SxNW4SVRDRZ5xqArVUzwdI4clh2xqTlEKzOfNAP37msgD6WhVQePhhugly55T7djJw
         bpCJSsmCAH2ExdBkYz6Ihc9CiO9LfumVVnxonkXO2uzsBOWiHtgK0Z+dOt/roU1gRqAn
         PrgcR8e/4yZEsrI/ami30GWlDWZeFM9OAQzhbwrgoYVISwFxmKfgvKIkZCRJ2vZF8OZf
         Vgzdg4ul1NXrN5PIPOcVYJezsxV9m3TG39x+PqXHyaECNkZo5Sa4wYmGuznvgASPDMwQ
         6TwySGf51LLU12q5VUCZEAKZsMuNAfsSUxhfFgLUJGf40JnMQL/1ppRGtVRwfCFMMWyc
         +aGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ksoSrYW3u/zMETqBKgA4uFXcs4Nrq86q0qljymHgMQDNF6k5AO5qMPgWX0zdtWV7OOxnYcJ9zFk+bAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLk0aZnGSfN4WznyGg/KzoG0pllZdRYX0pzrtBahUwIIvyq1c
	boVNZh3aYUbT2xJNGnZ9y3YjFcZQ6vlKpa5pCqFNGAD2cXCZC/VrAN/69Dfgu7eSiuyDEvNzyKP
	u9kqZqlcqpfNLcaVibvAzLJ0WqOWkxlJiSJyNi3W43VSxhICncJ4mr+1giV0u5KrmkKE=
X-Gm-Gg: ASbGncsz5sQ99vM4N+DEwF7WAGUHVxjIR3dmVFaXOleyWFL9fionhXf1/2Cv8h7EyZs
	Ny59gf1O8H+4O90/eg2cbrbyPekEb6mtkH0ZcUNV4kRjIWjxmCjYCEk/SMDB2xd9Hf87ER0ssDL
	XDE/Kz39r2ZKKUfra2/RN31Ro5Dbz1EaB6JHOoJ9MJU81UAjEOhRdEiQJlmha5MgV42VXqW/b08
	aUNLkV0hl0ry5THzP/L0ej1YekryQBYAHTykLbqA9PO7XdE5rWUo3qU3xyH0dUzmFcDbehNvTSv
	nAo1Cfa6FtHwQ0cFfU2ZbRjCWsbIEvijUNpfVQ/5cqk5JjszffvtVNGNjqCW3vSn3o4j9qlvIrr
	T4n8xobwIsWp//4E/qIH5blk=
X-Received: by 2002:a17:902:f609:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-2962adb413bmr44339255ad.12.1762362732598;
        Wed, 05 Nov 2025 09:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuEDjsIFDrY2gegEIb7NYgjqogYlaMPvPO8F5SsTXlPwaMngvCVHdiskWFWbz25o5v+MPfZA==
X-Received: by 2002:a17:902:f609:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-2962adb413bmr44338975ad.12.1762362732090;
        Wed, 05 Nov 2025 09:12:12 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm813955ad.43.2025.11.05.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:12:11 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:41:35 +0530
Subject: [PATCH v8 4/4] arm64: dts: qcom: qcs9100-ride: Enable Adreno 663
 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-a663-gpu-support-v8-4-62a7aaa551e3@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762362697; l=879;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ya263B/ZSqT4MVjFdASA/QB9AUBc/m4QKS8TyGIHwqI=;
 b=IAZEIZIGmwKj0WtzWs0RoGHvuDSjQGmW4oW6OqfFnAKUQc+91elEGHBsnIoEEKB68amq7aAIr
 I0L2SKafqXXCjmeD8fC0tQrFvKPIk1XB/cwyo5KsIqVzxklYv9BZXUr
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX2Q9rF8vQ7r3R
 k5pSe+pMkYIHvvlf3sfi9O+YWRdia2hfZgnfhwUdbYunw3GuKoHBlm/FSXAxW74m5lHsPZpDBXv
 atHJRbECI8lu60YdNCKh8wCiqsNbkeerztrTC5ZuHA24psx7Ry+5e9NCr1iwj/qV1hQu3kxYMWy
 TzhkXSubLJSwznJp+uft34Kzq9KOTzB9VPCOVaMljL+yPWczdCfpZOiMri59YbJsU99PQ0qFTXI
 /DhzztXf9wbQIK++jkZVlPJ1N+xq77MohBXWCfr8Ev5S+RnmeUGCc380Tk+8Da0K24w8fqTnLpw
 ufPz56ivnIWwtkUa/G/q1CrNaW0rHWj/5tc1IJ4JslJCX5X8Li5A3Yyc5Os+E9E09sFu2AKpuV0
 kcFTKV+FJoPv2+/RNjBbSB0oABqGkQ==
X-Authority-Analysis: v=2.4 cv=LoCfC3dc c=1 sm=1 tr=0 ts=690b856d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: m81hokpE1Xd9xzATU5O0OScdOXEoVKhM
X-Proofpoint-ORIG-GUID: m81hokpE1Xd9xzATU5O0OScdOXEoVKhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050134

Enable GPU on both qcs9100-ride platforms and provide the path
for zap shader.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
index c69aa2f41ce29f9f841cc6e6651a8efc38690e19..8fb7d1fc6d563288288d24eb5d8288e7748f2c16 100644
--- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
@@ -436,6 +436,14 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sa8775p/a663_zap.mbn";
+};
+
 &i2c11 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.51.0


