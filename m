Return-Path: <linux-kernel+bounces-810081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A05B5159D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F083A9C82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB93128BF;
	Wed, 10 Sep 2025 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WF5z1w/i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB231B11C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503599; cv=none; b=QtGwIeHBkcvk7Fqi7dSOZuEEJCGmpZNGTuQlM1cickf3P22NI11gyYkbKInEOHDDLyMGCTW0evS/TUb+JcE0daAylkzo1L/kRodLOTkTwJGN9BF5nRFc8U3iJjxT9KOnjLlI5yiSicg8KSZEelaUnCf50IgRDNmMTXfcIGxj8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503599; c=relaxed/simple;
	bh=lvtizlHL6MS7eo9olZSEO8tIpxGFiSCKBoj2b3IlTA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXxpfUZ3skjygl/6Oa8bbOT7HfRjWiunJwB2zgzFfSr+zlqpyLRSXtBbztRI/EKriD9psaya6N0WBVbaFGniryh3YbGKeDiMq3HI4MZx5tHgRgKCHEgg+JbIeu3YCEMfi5zSVN58oSnnLweTgxBL/bB2IqE4oCDxrHlwTuYZbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WF5z1w/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFEFJ031268
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uTuT+xoD9CIqTmF+XCt73ZauYNq2xf3D0o4LX/E4JG4=; b=WF5z1w/imCQRNDQV
	2zRa8DS5c2KZfi1kyN94/IxTDYN+cV4qP0SE8/EqgupTZv89TB35c7CCNwVPy/La
	2DU4vfWz8ijebHnw2wExRXvpsDDKhfUWJh8Hb9BTpweQf4h2BxBS44HVxDqJDWkx
	rxBOyFmPh8C/YoKIv8iR1qX0A8ZhMhtmXGeNFApHYPg+nVzESXwETtDCtOTWiOJx
	rUhFc0mfMOqHRc6U3DO2qxA0ccGRI3C2STLYSuh5Nn+yvxPypKrDUed6eEaDqFN7
	tUqrPLwB/MJdVIRcG6z2a3KI26sIcx0uPT+TWFw+NAPNdPX4FSuQGSyZxgjjWe94
	cFeJGQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t3803mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so13097253a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503596; x=1758108396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTuT+xoD9CIqTmF+XCt73ZauYNq2xf3D0o4LX/E4JG4=;
        b=fGoNNuNW2E03i05BAY5Yce1VbUSAP88jN+NaWvYof2VG8XQeRPvXz6XydwhLue3Lp6
         L/sVMoY9hn6/gRWR1LGJxMFFhFnYF/ltie+OcSYP/fGqAoKW3IWFoOq06Wb6YSbVBJa2
         Gj6e+ynNkNr0eoKg5yQR4wUJjOFIDy+zh07KUfkZzTDaJxYdBRssMSPP7/2NUNoAnm2O
         5/bP2uEeoxTacyaG54HgrwmhzpY1ZHXJi/RGl1rFVSk46xv7fNrFA93WCCNmywirz5JS
         R8DY98OzT6AFmGleZz2VaxVbNUZp9Mho80RyzhCuQq/+P+thd8bxRUP4wbdO4HTGsdEF
         8neQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5SzZjc9onViyCa5bR3XI7SudxBj0fPHsVaPqJt8NSlUpb2oVANCr5AMANWwiPu5OTQS1Z0CcSTKaCzPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhi0xIggoshkiKFOs80a0kzspQ+ZT3jL74sXulnImkFba+5BB
	o4AUwwJXFF4dLuucXeXNv89Rj24L756jiCXfBLpQrPjLR+Nx0wanHw+lKeadk8c6NkFROk1zbHz
	J/voLDsrzbppF0AowT4cb0jjG09D4elckVHthBp62lGoBmVICaQaMSY5D8JVYHEOi05g=
X-Gm-Gg: ASbGncud4nkub58Vw8Lg1gb+pSdUbX7Bmm1OUm4Fnv2y238gGMZgHWBpfQ2K98KiCTg
	1Bd6Qf9Vk68CyRGU5lWHhy0oziIGtm7stPizgymEgNVaTEQ/z+ba150Pjd06b1ud6m/LkoDL91h
	sGpyBfc7MtMKUM7EEh57rYkvx+F872w/OiWEuVBEv1yL4qZOerP5as4Z7rKcmOG0VhtMSPqSWcz
	mwm29CkUVMHHXpGNFWU1rt06FEv+1Exp2aVRGUmYyFMXPcdi1yIZuxBsG862iydtUypHDJbrleO
	TI0yJlx7oqJr88icYs9IVJdAtRog7XtTs7oEjOS6gte3VrSDl5RqlRXn+Lj1sUCR
X-Received: by 2002:a05:6a20:918b:b0:245:ff00:531e with SMTP id adf61e73a8af0-2533e94d135mr23613215637.12.1757503596568;
        Wed, 10 Sep 2025 04:26:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu8n38cqjdfKt9/1s/M/MeQK58nlWTbkHvgUjuxlUJFIC4snQmD4oj/oPkqGgfcrDAzAET9g==
X-Received: by 2002:a05:6a20:918b:b0:245:ff00:531e with SMTP id adf61e73a8af0-2533e94d135mr23613180637.12.1757503596105;
        Wed, 10 Sep 2025 04:26:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7384sm4862260b3a.76.2025.09.10.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:26:35 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 16:55:25 +0530
Subject: [PATCH v6 5/6] arm64: dts: qcom: lemans-evk: Enable Adreno 663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-a663-gpu-support-v6-5-5da15827b249@oss.qualcomm.com>
References: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
In-Reply-To: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757503556; l=802;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=lvtizlHL6MS7eo9olZSEO8tIpxGFiSCKBoj2b3IlTA0=;
 b=JAVAIdqmrnue5/ks+VzoXSDwPNFYkasv5RLMnK3+t3s4vjQQ4iplYXmNDUzqGDU8F4giYFc6Z
 NdvaJx8nFTYCc26y9qynH/pfcd6GTfKURUIPJewQ3LieME0ZjgXcWcW
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: KJRNmgGeOu40Ll7T4tvbwclRmC3mmI2X
X-Proofpoint-GUID: KJRNmgGeOu40Ll7T4tvbwclRmC3mmI2X
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c1606d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX3hCXwHEky19U
 6GOv4hOWr7KcaErvK5RtJz2nEkddNf+u8RM/lYnGfSsNk5NFHQNMwrrgZp3FXDLjkWfsfYwxW+H
 T98zn+CMgA9skhTFy2eO6oonLcrzKJqxn1ylMWy4Jn8PSKwDhN9Fpu4/88TCUAlmwLYHb5xOssN
 pPB+zCS/GU9hIYtYvEKXym+NXVyQ/iUfst0cf/ddiYiaiygkrG2EQsc9MDs+An5PCH2Ck1hKYyf
 93kftX05NcmzzqSb9nNAkkKQLH1ZKqzwsNGD91RmY78h08GjTbF9BUf9xaXAJafXsJq0t3styTl
 EgpQOvIAiahVssdP2I1uq3cjWju1Mob5gcw2g5/adOCNGtgXslQjPmzdUSRL8BIJUYW064+7ooo
 kQx6PGr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Enable GPU for lemans-evk platform and provide path for zap
shader.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 669ac52f4cf6aece72141416068268531fd9f79a..876f43d761870b968e43ea1ecc360b4403f19fef 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -253,6 +253,14 @@ vreg_l8e: ldo8 {
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
 &qupv3_id_1 {
 	status = "okay";
 };

-- 
2.50.1


