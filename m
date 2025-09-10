Return-Path: <linux-kernel+bounces-810083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED6B515A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346631727CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FE2318152;
	Wed, 10 Sep 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxhn8LaC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E01317706
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503606; cv=none; b=VA80egFcyNRXsWwxIfadESSfKm7FHYgCklyx7mutSGbB60fw5ZTBw0vkX5avk4NOuZqRZHECafr8vSV0knXcFKIzDemx0XwShHE0xDi3N0k51SvLFaWkHnSJ+KUCcCbqa8FRTGvewM06L1iMMIFoOOAknWJUEGmkweD4Tv295AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503606; c=relaxed/simple;
	bh=9bfHDTw8kTerdOD9ddHzM0+SjSgjN/43Tp5eBUWS4yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DivNKgnS0fP/KtCZ4ZSjZHTYM9oTMrV4N/gbroXr5FkOWx44R854FCm7/qNBsd7r4ptDMChN/IPGOPuQawpnCpGXmCm/wwJEkTs3RwBIIsElcim/aJFjhuyJS4mAa1+v5hQHutbLjZjlmHt8aKmvB8R4nWbieZVzBleEKZ1EtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxhn8LaC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFFJE012527
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	itWnLUDQYz9rGMnzsBXBwWW0Rd78skgWmOLQTl9Qpc8=; b=nxhn8LaCEa3bDh7F
	fdAiO6mG+7bKEh3PMZQrDeC5ekneoK7d47r11mgCzXfvqBkOzUfBRSODtaIoHtEo
	yBmBDoHV02+lIuySvUlCm/vuNFwoMnP1/2a2DOKEPrr1g2D7HT/vLEi+LWM2TW2d
	vxHHOXM4d+uu8Ir5h0n21omr5DvW/f/4Ty03vQFfkMDsGa52qOH7131PQ0lTvlYj
	hVVE/fkCM2U6iYK+BF19DOOO3Wnydkpc7vb43Xco8SuF4M4pec4lMs9CVzUdr0Py
	nlo3oZ8iz0jVEkt02xoufBC5EpD6gr7qliSdKBkVVF9V5Nzm2eRtIFUrukqFwI22
	lt67nQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsbsnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724688833bso7092625b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503603; x=1758108403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itWnLUDQYz9rGMnzsBXBwWW0Rd78skgWmOLQTl9Qpc8=;
        b=ip949+Zze7NmniRcshErUEkdFt/e0PzFvjwZhA0jDng0mSLJYMb5Ng5+842LGHYCaX
         Y9hJMG+nRHqJixmdP8z5ErqJN6RaJhGpCLqpCV+qvykNwCDNIrD9Yy89b5J6KlQUI0N8
         bYwf/EutiWKs7i0iIL+rvmHHozIYrWr0VLAeVpW0x943Os2oZKtiG0djNnzHkccO1fge
         7fHZYyTVMi83dw3N2Ce9tnmbzEwVn6IxXA0oV3msOswJ6QCTCk2VDn6Dqydni75bH3S3
         LqjmDovX4CKLXG+5VhQhJz9bqFkjJkJEH/7t5F8ZT5Ll3I7CghZcZ7ycmaOGdCtpigbO
         vPtw==
X-Forwarded-Encrypted: i=1; AJvYcCUo0uMeRymP+43/LwWcbDeEiXJYfFzXussJIy0KJuZH6ci5x4MoE/8BOTnX9LP62lJBlBTCLhjLWJjbLkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2E/7xoDU88GnhWCFmR5P6ufOUWb6vgJeGgq5kGq88zvOKW9K
	Q9BF0SIiszDHTxifNT3Vm4TSGI5E+TOSzOcdKAr6L4HqOOucNM1o0jWzdg1OYTzI9xpaj2dMgLK
	ox/Mrf8fkDL9BXS1FT8ZHY88jDMnnbxM6FAJ9ehJ2xBIRwlYXu6ynG2mBX94a3NC4Ngo=
X-Gm-Gg: ASbGncukkKzHD7vnjK4HxLJX+lKxdniPnvHjPNRl9XWY+a7tDPLu8dPPTqcYsmoJmjb
	KYPCWe5y1r3Ldpz5m6NttK/loMveqvDdgPHqTAF3WpIO31qR6gSB5PSNI1mJlmPByS3+v46YfbH
	tcbg13GOOIsJj3tk/6k4rogupeebK3Tk33cjanG4+1Aw4I3fDuKb657OraASEFGcQ3QboIJAfyO
	516h1U1hmdXukRHuXAcE2vLPoN2EDOADjT93PESXg48bB+1hNOEhtZ5gfcpQO9qKQN1a/Bn3Fxs
	uhyQKu5mZWHzSvhrI1l5fMmdz1hr2zrr2L3bobJVGNh6avZgTEAlkNfdcPj+Arc4
X-Received: by 2002:a05:6a00:1acb:b0:772:43a9:d587 with SMTP id d2e1a72fcca58-7742ddf13cfmr15993636b3a.20.1757503603003;
        Wed, 10 Sep 2025 04:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfTJXsij5hahDr1ImNYphI7GxV4OZZqm++kxMfUWKVSn/3R0ZehMj0Y8qLLTvIRj+LObzBYA==
X-Received: by 2002:a05:6a00:1acb:b0:772:43a9:d587 with SMTP id d2e1a72fcca58-7742ddf13cfmr15993609b3a.20.1757503602566;
        Wed, 10 Sep 2025 04:26:42 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7384sm4862260b3a.76.2025.09.10.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:26:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 16:55:26 +0530
Subject: [PATCH v6 6/6] arm64: dts: qcom: qcs9100-ride: Enable Adreno 663
 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-a663-gpu-support-v6-6-5da15827b249@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757503556; l=879;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=9bfHDTw8kTerdOD9ddHzM0+SjSgjN/43Tp5eBUWS4yw=;
 b=XpUaKnoeyZk7w/FeU47t7sSg+CjlI3AMryk4mP+ujUW3bZO9QGZth0AXHtgh0Dlc6Hh2YTBlu
 mzbgNxKo85aDvADCC/lnhgr7fWtCz/LRvs6TZLlVAMNXi2DK4XDF7hw
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 6RAfZ3nzcvADFQ8sRhvIiAjuRe1IuHFZ
X-Proofpoint-GUID: 6RAfZ3nzcvADFQ8sRhvIiAjuRe1IuHFZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX/swt9iCITeiT
 TeBVQpQpuaSttcuxiIaonW/WvesdGvFUhKd33mI5ehxaN48Uc50j652BW0MKA4oyxS/pAZ700DE
 mGI8y9pRGRGGGqKQMom3N8fbEW76SSE5VzA9DKddSWggBD3bvPdcz5cyFSXEN5DO4h9KCAKdKbS
 TPcna66adBePxpdoaQSS0xs/QuMN57RsJc9Eb2znuUWnYDp7HaYYlSuHMkb/vJFBm1l1QCqaZAS
 J0Cqh1PfJPKKzlHqz6E2GzShy6zgtjFh/MomL7Kw2EHm66Spq8db2qMXphF63NjKym2msQCt56x
 SC7Qf50mRcHkQ48U53gxqq4d7QZlPkyraYb2XWNEZg/Hc4VnWhejVjwfcjEbiTwph3+3V1khGyx
 ywF72PW/
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c16073 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Enable GPU on both qcs9100-ride platforms and provide the path
for zap shader.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
index 25e756c141606fbe0876ed48a54809b372650903..e9540cbff78ee44d6d92de10464c660a05a68db9 100644
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
2.50.1


