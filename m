Return-Path: <linux-kernel+bounces-886953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D170FC36CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FB189C7E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD94336ED7;
	Wed,  5 Nov 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZjcHx9GB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BwzPweUd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC7337B8D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361191; cv=none; b=CxAA3yQtUW5O41cM2XlVwe6zqBvUe/jBcD5TGLB9cGJq4XuPbimrODJ0it90ifGIJEaL8U1yWctDu7gr9LxTAFUEI5OUlyTc4vOsLad4bB9PUQfz07JmXayk71NE5Ox/Zu25t7+YQhjZ5LLr6nvt6BDngqNWrFUn+s3+UuJMIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361191; c=relaxed/simple;
	bh=UQno6js1laBBGRuM1136RGmbQMQqm5whXfqyW43PMB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVMrd0BXK9zMq/WRYVaUQvj359t4Qphy/ia//r0eUWjuO3oqLaGdrGLctoFhfGLv5y/DXfur2STSk6KyAsQRIOwV6zqXM069SxSblah49FrHMw94pyA5FZf4KAXVzsDsMtOkcCQbCBuaeidMuYf2GVu2DcK9ElV5pG+cYFFyzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZjcHx9GB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BwzPweUd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A580W2p3089263
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 16:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	791ljE8ofv4KbxaCgLnX5+k9zZdbkdmJjeOWvmYtNeI=; b=ZjcHx9GBZ5wBJRJb
	JX8EKzvSfTq5vGXRln+sdKdVHTf6ToHZaSCG7chhNxxOXCdA5Grbit2pfIghwIvd
	29unWqabuiJu2QJ5X+ZUEggBb73GbVYwALg8jpQnFg4N0hPmVR6M9arEpCQ2Ta2Y
	VvgwWwbKIAupucglw+VsVenIzYFtdjsva0Bbamq5kMdr09QR/3PcpW9AZL7Yn/A5
	M9FHcgcFprMOjTOrcN5HTb8wlJuJOZtnGmfsLRoSV8ZP6xiE+n7hSbugQUTkf5nZ
	etavAnlI3R54VaWDQLt8OwPRgtZjt/+356Su5HmPUZ848Z9/ald9IJux8C+sc5Fz
	xr3soQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7s5eb2jn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:46:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33baef12edaso116222a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762361188; x=1762965988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=791ljE8ofv4KbxaCgLnX5+k9zZdbkdmJjeOWvmYtNeI=;
        b=BwzPweUdwqm3mgRLa143iX2zfV08T+OAeaox2/mJbSIMnKKnqZUvQTa+SxDXAobadk
         FeCUspvRi+yz35Xd9ATzdLHSo83odFJF+ZAEq/rFqHl9N5amcl4TX8AAqtrhKcfABshI
         jHxVzTQWKzRo72CYjPWTg1CoFp9vIquIK9pKJy5DHUlM5yA51bOjBvEsq6gW2KCcF1Tq
         Yq8UmZ40A0ydygFrfUDJEBIY9LPhMBg0ZUkU1GprNYbdZVsM7zN+bqIygC7SwZnTxn0a
         XS1ltdwPoJYv26YTyLq/+fBa8athtgbe3Xg2OUlD/qeZUFMWx7gCKfwHVgUcA/Ks7VuR
         mdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361188; x=1762965988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=791ljE8ofv4KbxaCgLnX5+k9zZdbkdmJjeOWvmYtNeI=;
        b=b0Ew5Ix/w+ikX3lUD+jK9LDBbLkn6iQmDVUDLUvttOL8ZeIMHcXWg/qbpHMlNufTfZ
         qlms6oHSGn6tkRA4Xb78KljJO31gYXUqUIFf4ff6V8umt5WH+zYWQJV8NCkqO9H4EwKC
         6m1/hgUspAg8OtlujCWsGBe9yhRHtE+8qqJEcIGuv2rWQLkSsGF0fbYgYZ5o7Kj0euXF
         BIikVRbRr/okSxTRfwyWpoB3vSEPCcIWZgqzM8oAqOPD9HC8UZQ7tkhTEsnyKTyUQh7q
         TvCU5og87Vaq1VtngkzujVjze6guf0vEAYmFalW90MfnBuwikwRbdC9HxAeqCAe39ok0
         zYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3CezHxGNeAZoN4XdGOp7vttYT9jwDgHHDeqPbo5B7DstgAiQhj4HzTTEG8SVhD28LaYebggI/CwJi96g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsk1eKd9yO66ZB53bsFt4EVUdbC+meawyY6XzfvRlcjwTdO8q3
	7zpfh98TgZsOYvuh6HnyrbqJaN6fe8KLCIDeEqVXkd8GGXCaMe/BDw7aC0VmEKKVnItR8uTPZi7
	3mQD613Mulo7Viy/Zms++TxcNtYeXSpIPqIcrF8Erm6ixI/P7vKpkmdo7pQOZcg630dE=
X-Gm-Gg: ASbGncuroDGec6D3rDuyspJF6suWoqC0gPvV8ZmHI13xlnR9hhKyIf66TIFHYlRyacH
	Ovow1wEtNsZnA+3W3DsQMOUkzTGzLQSrdS26NtHMIKSRZGJxsiff/C+BoJLbnzkf4MYxfz+Vju+
	Gp7CA4qwQvMg5Vx2DpXOMnJ2fXhFGrbMz3pPED/ubuaQHybrbwzRgAk7+hZkpiUanHRrfGjI0Ro
	Fb0eG7XQ64/yRqEOjbAuTQmIE6EGEYW8kHYNl6Rajb4f5qeDe+R5yV4fFv4QbDjrMoDfif6fvzw
	WrhHPRXerFmy6FJAnuVu92CdKv1n3FH9WxzCB0sHq60Z86GTj3CQ5r/aWh4aw0lRMx1STZeDm8w
	D/fjsUNvkSb555/DDrGd/fdQ=
X-Received: by 2002:a17:90b:2c8b:b0:340:a961:80c5 with SMTP id 98e67ed59e1d1-341a6defed9mr4743916a91.32.1762361187736;
        Wed, 05 Nov 2025 08:46:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErV45t9cw5tYMY+0WjKP4hEQIrl8N8Y/Nqn4TdUVyHIcGvNfAcA385wy9iWWtGX4qk0KmIEg==
X-Received: by 2002:a17:90b:2c8b:b0:340:a961:80c5 with SMTP id 98e67ed59e1d1-341a6defed9mr4743892a91.32.1762361187240;
        Wed, 05 Nov 2025 08:46:27 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm3426249a91.8.2025.11.05.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:46:26 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:15:47 +0530
Subject: [PATCH v7 3/5] arm64: dts: qcom: lemans: Add GPU cooling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251105-a663-gpu-support-v7-3-1bcf7f151125@oss.qualcomm.com>
References: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
In-Reply-To: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361159; l=3334;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=dv8fOd2JCzTjOzv1PtyfPnTYZUgbOREKQ5dEyRmj6Ig=;
 b=2yRxXU1F198LEM8Gl5ffmxyregbyf9QySegDIWZqoS0+y3z8TQLulwYf5Ifre5T/VshOrtyNb
 oxTdks4MnMMA9Rv/1sXm+QTy0UikCaaiFfwJD+gjjp8Q1pFFWZfkUbj
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 5j10_wBVRROSInYWD08vRvv5QnZUJ-CP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyOSBTYWx0ZWRfX2vFli205YbV2
 vM1pT3XsNj04qi7woXppxZAQ5k66ygnCKDSbbG8++6sW4mqihABlJsr+J/4Ds3aNtsQAVMmRfJB
 FioPgi35HAmkWhGdwVo6mLEQfcPnMGGUGLwbBfRUCgqTsZEHEuFjDur660e3vOd1FnxbUtLPhyu
 ju5wcAy3/1ipmkkg3Z+51iL68Y/soeA30AN4RVxxyJIhx5pMD4NQ9x4AuYDXhn+36DowvHkFNld
 /2gIC3nw/d8CuWMzKYz6wOwWyILvbntpmo2w0As6QK0z+aJclkrm9E9l7O5kPc7hVv7xnUKjlRE
 DGdPUSj+jQoqImZ/BeZGvEGAD4FNI9kKkQgqgYWzIALHHZlyR0KEOCCG7ZuwYPDBh2e7Mj1y0JO
 k482uKGkzyjx91Gm9Fp11xGuZdhJbA==
X-Authority-Analysis: v=2.4 cv=OayVzxTY c=1 sm=1 tr=0 ts=690b7f64 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=e3DMr3DmCBmV6l14PKUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5j10_wBVRROSInYWD08vRvv5QnZUJ-CP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050129

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


