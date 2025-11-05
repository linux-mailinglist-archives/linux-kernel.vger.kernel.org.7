Return-Path: <linux-kernel+bounces-886956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9BCC370D8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AA2681DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243533E34E;
	Wed,  5 Nov 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/tK9eKu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LDZXS1UY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD833859E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361205; cv=none; b=FALf3wAlzrrJLOzr/Hv3zedmz4mac7qY3c++jQYo7INL83N7qmc/DDNFymm5KVawDLrPXVat+5TgHOslaFPq5LTcVYEqbmXjZ7jp812oNGBCur6samU4wYjAXjhPzfIivgeJNAjp5ONDBsBD0v4i66YzY7IjH0D6P2xV1x90C3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361205; c=relaxed/simple;
	bh=ya263B/ZSqT4MVjFdASA/QB9AUBc/m4QKS8TyGIHwqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYi3779kMJ+bIit6yjgetiOSOrxh7C2G3elGhS6HNRNyIl5yHiK9xgpLIaf2QNG2XZ/lLf2I8hdi4cxB+R3R9yoMtrZGTCRREYCeFoAMxa8ABLXZ2JPBpp8Jd9zIC5g7FE21iKPB7ETfPT0d/l28ZWKglLIdsXIhSohoFim+NTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/tK9eKu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LDZXS1UY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5DVkh33913782
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 16:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Js4xfc8+ozAN4gatGrEl/M6dM+koKQCIKD1ockMt0Kk=; b=B/tK9eKudBTYKxsy
	GSJZazGbThxCm0WBUyndiev8r4z8jhWTP6pW/IYl9tjJfGSmqnqnrC4k47IXzLXl
	+qDshDQgToQnMCynZBISGfRPxSD2uk6HT3k74Sg7afo3L3xNpnh6QWoKyywu6bXS
	5eOXUnMRsIaGHJvoiYeWCsioEgID57sVhjJa4vBj2FJiNmYb4CSyW4wsymx/EFxy
	5GqdKKpGEH6N8XfqqlN1LRcP1TF0lWgXH0IVu3CtezCclvXytndKe0Q5O6DimzBx
	NaOGNCDGD00BUWdOoSFX/z4tVcp5K5u7jL7dhHNbv6rpsdanuHKkGc4mpjOroNWN
	ok3T8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7y37a0k1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:46:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34176460924so62233a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762361202; x=1762966002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js4xfc8+ozAN4gatGrEl/M6dM+koKQCIKD1ockMt0Kk=;
        b=LDZXS1UYx5dTTJwqrpcBnvEXMxkUXDdSAHe7o7l8en6vr8J7EnbMk3nZMeQq9uD3Zy
         i2PvI43JkETF+yb/Dblosm52nwdhfUjRW8X0uK2fftv98BA+nFDZGrxe/BiIpbl/3ItX
         ETGTxpMaaXRFf479dJveoAf4aVeINz/XEpH0ttGUBK+xhlK49HhdIBHH0rvxjyfcWokG
         jungL29jkHLlU2y9JhV/oUasPe2vXIoiqmus2S7tv48GlFX2oe/TX7X8HXQ9SmjCUY3u
         NwQmoWhAfFJc+rGih61aj72nA89YYbRG9iE6k8bTpJMujxJNYPlc8IghBkb3hngv0QWM
         11/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361202; x=1762966002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js4xfc8+ozAN4gatGrEl/M6dM+koKQCIKD1ockMt0Kk=;
        b=sPalSKeFp+IwBLFys9dVTc741doi0dn12GOII8DfcsS+owUexAfPFyhf0J7njnj30p
         0csRkv3d5Nr5+YUm+J9U3WR5iMPXx4c67FRh3dJ20uX7UZeUDYHUmzW5vy0Zp4eVg9uv
         BmK8YcEpOa8grUsCZMbZtbUSoN/h9SkQHqiQU7F8dBvpck46bfxfGQqo5BUxHV4Kua7G
         T8TC7ux1KApvt1oSWg3xCMlpnETmwXQgQF7GDtfWFt2ijLqhSB9QZWzilSTISEJYnqoB
         4dzftDdTUhIrne0w7AXLTT+5z69lrZcyBD8ZS7QTOOI/6fAiOBzqloiqS5ukgomRd6NQ
         WKTA==
X-Forwarded-Encrypted: i=1; AJvYcCVkK6+/DcatowPY001lVUAfYh7RkhL0F936dFkvNF4N8mEgcTzDQPukEoh3LfPAfzd79EmbajJxSRAqC4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3TgPDs5egk2q+XV2/tTb278myOCZIvmoC4IiAi+bk9zuCqg2
	AfMLGQUbtADg+jzFPhaCzvLn6ZpofkgCMW2RuVvRi6LEdJvqAx14qHLtRw011UQxr+4HAp5cRPu
	h4V+rCK/31UXX5ZbT1nMsbIt/3EQnLL+IMg6xfwKP5kUH6tuVh3rZDMFS/ccUeG48G7Y=
X-Gm-Gg: ASbGnctzTlPMDgyLr4R36Aua/ZT/PyDMPNae25lQirf1+bO3cgkx2jgQnkh092wOLtj
	Ob3lELbEC+MmoRWlmkrY/qW5WvYbdju4Y/haz7HiTlcS1eS/Zw6WQKlQdratM89uWdZ/wiM3WZi
	/FxWn+BzoYUCzi3j3PZWEHtTHR6N7a4pCln/QiqvWuyiPSyYdvsI5q35XdVuQfMXkuu54VDVrvJ
	XWww6Yl3aKdxw/UmsRo3d51uJVSJkyNyAqCn07mOSoK+cfsdD++1kVvkoke3vhqv88vE9BZgWiN
	v9hCvnj3LGYsp03c8Q7N+FcuQ0FptkymKfgA45U/jzK1Dd0L6TQX9w4Dz6AvAbpGW1L+uNiVMt4
	gjTXtt83lMSCPJ0y/gMr4qec=
X-Received: by 2002:a17:90b:4c4e:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-341a6c1e216mr4653691a91.3.1762361201667;
        Wed, 05 Nov 2025 08:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPMHWdFNyWZRvVuGCjzCiFHWvN7Lxhr/hcgMjghCYGwwHQXJqqOAm/zVy06oneEFZN1o9qQA==
X-Received: by 2002:a17:90b:4c4e:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-341a6c1e216mr4653661a91.3.1762361201169;
        Wed, 05 Nov 2025 08:46:41 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm3426249a91.8.2025.11.05.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:46:40 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:15:49 +0530
Subject: [PATCH v7 5/5] arm64: dts: qcom: qcs9100-ride: Enable Adreno 663
 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-a663-gpu-support-v7-5-1bcf7f151125@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361159; l=879;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ya263B/ZSqT4MVjFdASA/QB9AUBc/m4QKS8TyGIHwqI=;
 b=llOeky1gtFuawhG9bs+RtN9AJEm5cGH54p+7rKBb4K2jSRLfFXnSsDFNa7H/0GucTQiOl1U8O
 TqCKRb3pmwlBVep2hTZjSzoGPxup8rkI0zoDUg+2wlrR6CpvDwnbTIg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 5cuVW97hXcGsNfFtv2eGD2QawT-w-ntG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyOSBTYWx0ZWRfXz7IoQNlBrwC6
 MATW9lU+g/+FSYBdDwyVS9tl3gZRTXeGL1L0Dv+BwKcao9kS25OilKTaD5Br6R5MXMcEV0N4AUD
 nS0p9VA633a+n0KIvw1yv3J9bmQYn3P1lcdJjix95uU+Qp7qOaXRdJQOTpuqZdnOHcqEafvIB8v
 7FnHafpgW/PLqegZzkWqYCpI5R0vNVaMACrdP5fF0xHLUDe2ZamEa+mm9/ywCgPuDEb15hg6TPj
 /hEYx618HKOauHaP0k0euDG8ABY7vfg6Zq85gwps/16Aox1H8niGlcztV58YfRgociUO0vuCJ/F
 b5dQSMwTMQPXNd2596rKWlQ1JCzW0CFOOwrGVr7oDekRYqfAwPuIc+03E67ohvoqnPuyCBpzVJQ
 TdS9jNJODMHgHmv5CrOwH7GltWxONA==
X-Proofpoint-ORIG-GUID: 5cuVW97hXcGsNfFtv2eGD2QawT-w-ntG
X-Authority-Analysis: v=2.4 cv=Ev3fbCcA c=1 sm=1 tr=0 ts=690b7f72 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050129

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


