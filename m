Return-Path: <linux-kernel+bounces-797855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00ABB4164D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5C161A34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B002DE718;
	Wed,  3 Sep 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyOczDZP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1672DE70B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884047; cv=none; b=kmIbXcoMtLkQibnFcsih7ldd+ljSVSNnXBoQOB6JyQpx2hxTKCnrDX1UswM86Pj9gSGypzxNIn7Cbs9vdERQQNFXN8DBmvVRGpYQnB6i48CFVDovK1yLpJi1aJQotbaQSQdQgcb+WBg0QoMKNNYVhaPtKvkudsVXXieAwk/tems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884047; c=relaxed/simple;
	bh=jF9d575p0CJgp4rHhiLU1CfFzq2UthJSlEdkim4Fnnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBSzJxBB3vpeqmnAQbb0zn7hE0gpDTwokfEnz59zk3bv6QgpxD9Yqa4R7HXuerO4GEduTq0Hsd6AgQ4amYfoZx/pk+ZUEbus287K0hQObNsLvKYnjYDGN7qCC6VzmnAacKraWBCtWDRyGG9VepU669AT5uR5VR66KSEBkGSGMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oyOczDZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58322T8I019738
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 07:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sNOAegK5RZAaDE+/8oSO0sUGuuiN9cbKJbWju8HXrOA=; b=oyOczDZPCkqMxGh+
	UXnPsciiheK5On/uHeMaIQqtvIipUcOg8L6Sekz2+RAs+yQWeDWyFzNvfvlNGGG7
	zy6RjX+jr4f1bqyoaCa9XWzhN9k7O/QnpV+qnL8B/TMjI5wMRmBH03i9fMJfaEbh
	6ex4n4wEP8AyCGnFvsJM1NV9FaHzeqnFIyBiDjAAs1WnbuvPRBRKn78sJ1NGDYbg
	nVE3XWmNVImh04qBPgbjrzhD6z3gUnlUeFd+OCE9Q7kp89hp46WX9YWPPyjVvsjK
	Ii3cOE5hDl9MymeTesisu2ta28w6c9Ja8RRvbYxMbhgyNXfG8g4nys/uZURuNPTN
	Cm28tw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw02n3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:20:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7725c995dd0so2724747b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884044; x=1757488844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNOAegK5RZAaDE+/8oSO0sUGuuiN9cbKJbWju8HXrOA=;
        b=b/MFQoZUMa5sIpJ0UkQS1UDtiNHuoE6L2nK+xt5xwbrvS+nEVXyb53TVLTB6bibwZp
         nYIyW6+1sb3xSNBk/g7/FnxHlh64Nfyv6486ClQt+w99W5E63kSHuqmNGDiv8sWwZStW
         hoEJujW13oGAkA9XxPBsIrjE2y6p8RdwzWrVfQpauNTWbhpx84fwPwpDBaNUWa4wIt/R
         F3PvwLPtGrTpXhoLBECS3CAwnKfaB8O8UjKAEETLKSYSwoOh0gcrUDLsV5nlPWeDcnJQ
         f465exfVgnM0Smb5NeEoQ4UYSx4L5xtrXF634PxsGeRAKx4O/zweqpzWXRNnXc97I2Cq
         FaTA==
X-Forwarded-Encrypted: i=1; AJvYcCW0uh2uHzNLeltAhYz1I2quCzN32ciVaUfkDVvt23+RfRuxUSQfhCmSKuTPUdJ6ui8gq/6/kX0t8EzthXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuabzHaTJaOgxx0T0FdE0CowBfBTVTq8o+l9PJBrpIpQNPScm3
	AkPtbNlpWxud+vbouPXJ/vuc9ma6n3ohYJpod5c0P1QmfMBwIsUs6dAOQeHqosRNqz/lN4tqxZ1
	RgtTu7tepExDYU1YJ2Rdu7u0EeIjn7Rr01JBfexYpRRp9mxCO/v9d0aOabyDqIupR0tA=
X-Gm-Gg: ASbGncvLIuA83IJy0Zo/6MtjjAubQdoCh7MH1+NWN31qhpKK2xXWrkMlOIm9Ys1IFRB
	MXNLldrS6dW35mkD6oIGD3wCP7UpIEtPLiXGfk3p/EeuB8TFIsTkEFkbNE9Kk+eguiCXucTpGr8
	KhGJQvvyGPWFKfsX3cGpJzC0nv6ZzE5TtCJnf5mXDPZEpjtHFnx8aFIKJz8a2yNLfkvo1mF+G8M
	RBm0cMbF5QnDueSFt9EnE52oIfvygrvoxMwxniCISimp/2QQf0F75rkm8IIlIr/3xaiaEJLIJ6k
	jdHOHL0EFULdiEOOVBE45FUvUtNbOvU2HLRt+xMZdmaBBLqYT67zvhyUftvFAI6I
X-Received: by 2002:a05:6a00:390c:b0:770:fd32:f365 with SMTP id d2e1a72fcca58-7723e38a3e1mr17895780b3a.25.1756884043911;
        Wed, 03 Sep 2025 00:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRoQDPRGyxgvIYbUjcgck6/XvM9wRa3NDYhFbn7RxwJ/4HNb57QPKMIkyegrDJbK2DGorniQ==
X-Received: by 2002:a05:6a00:390c:b0:770:fd32:f365 with SMTP id d2e1a72fcca58-7723e38a3e1mr17895747b3a.25.1756884043467;
        Wed, 03 Sep 2025 00:20:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm15816191b3a.30.2025.09.03.00.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:20:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 12:49:56 +0530
Subject: [PATCH v5 5/5] arm64: dts: qcom: qcs8300-ride: Enable Adreno 623
 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-a623-gpu-support-v5-5-5398585e2981@oss.qualcomm.com>
References: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
In-Reply-To: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Gaurav Kohli <quic_gkohli@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756884002; l=881;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=0A3WcrkpO6FZwh7gc5vhciObZkq6tlMdmmT7IsLC38U=;
 b=rTUl43YD2qv7+1bHzFpljeux3g04J8jUOBYTxEXptNSUGXRIDHOIu5Pvke32lwwqsxjK05HpP
 ZTLwS2TsLC7DmB40MlfOM2R0Mf43RMtj1u4TbxTldl5q0PyVToGbx+m
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: IeeLNhfdr5vDx6HJlRu7zTHVMU6Dkw-F
X-Proofpoint-ORIG-GUID: IeeLNhfdr5vDx6HJlRu7zTHVMU6Dkw-F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX07WHbs10BhoT
 zVs/7ZP6wrvHisZxlQs5CDHj9/fPvnoz5eF8Bqh0GFVg6+hfrZgr6Jju3KO66Ttvn6LX9Zhfzas
 WIm1P9NM0Y+PZQhbwbV6zOeer8eji9zMjDx9hlrk/iw2JNA3lge6wGk6E2+UWSZolv/XXa+P0k+
 zEVcJd221miBUvmwOqQJF2pa/lTGFzS3ShUaeRrqV7gPbXKD7AZ2IBVBX+xKECd1xTQCBF4dCEJ
 yDSDTe8KtqwA/pMdG1VsEkdKux9BqpIkMOoceYiPJaZOre5cCHq+uS1V7vG1Q3hkvwHP3r4AJhU
 dD159vnClRV9sN/FYsTi+NSp6VaJQL7Rwddwe8ABHLJwRlM1C1Lfx+7OwmweMTyddjPZ8ADyd1Y
 4RE+azKS
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b7ec4d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=VSJZfRLmIhO-6U2h3l8A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

From: Jie Zhang <quic_jiezh@quicinc.com>

Enable GPU for qcs8300-ride platform and provide path for zap
shader.

Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 8c166ead912c589c01d2bc7d13fa1b6892f6252b..c1f4993ee3bff54bba516a3b652e13f730b6353c 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -295,6 +295,14 @@ queue3 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/qcs8300/a623_zap.mbn";
+};
+
 &pmm8650au_1_gpios {
 	usb2_en: usb2-en-state {
 		pins = "gpio7";

-- 
2.50.1


