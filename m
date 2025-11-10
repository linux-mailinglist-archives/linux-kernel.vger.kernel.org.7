Return-Path: <linux-kernel+bounces-893710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E771C48372
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E75C4F2E76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3F330B33;
	Mon, 10 Nov 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FgXgnG+V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJPvMEC9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36907330312
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792861; cv=none; b=Ki9SxXVKbWRTAurvzQ/abzA0KOLq0V49JOFijAry5BjkQUhWvcbpjGmjA7Aojdyt8jaxTCwBz78qmOL3OlBRCBMWfIH9gHSE8wGtEo1VorupVsZ90eMzWDITUEtVkIpGYrKPIeeE1Cm32HMVDIMsH+hF9DHHRjHSJVRh4/1b6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792861; c=relaxed/simple;
	bh=NgXP4H+ytjNcrx+o8ALLRhAZOLvOHraz88+cU8xEoFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhDAsKAGWNIXeF/Ts0fUoePVXKMzg8H5Ky5Oc7LL6Ue5TVdmsn0rXxyXA/gVTmy5oP2PX+uQG7NY/mB5RUJnEkpj/cFS+OYUn28UKIUVHBzdWSK2WNndOJIY20fvirJoOs+crO5rLprtix7iELkk2c60M3urR4UD1Ad0fB4Ez54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FgXgnG+V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJPvMEC9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFlT3u1809147
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EKz5Fgcl8FFI+imxbIKOoJpuYhVpSnaRPpvrLUXLF5M=; b=FgXgnG+VzrNfD9Uu
	xxzWXTo+ysFP0KjKvm6Xc6apvKNGStrOzzMefelUuFcVtLxfr9PvT2dWIMPgxqaQ
	U4WcLBlhpmt68iEvng1m3nv7vfD4oz5HDLg9+cpyQATHFvM0ajH2IO8+pwYiBU8x
	shlQcv95904PwuvG5m441HI0euahNHLueZfwxhCgqrQF419Z4gS44D+GqEJ/kTNQ
	5ytx/8zFy3+4p+u/DseLySE5IHJuWqivxKA5QZFSEAD1WzDwBCshHpkd635YbuV1
	XW0a8phzd6Qtmims2BEq0F08BhNRXIY4f1kznhbGaHXewKtIcl32Rcm7sD6cASrW
	+qu/4Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1jm5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3439fe6229aso1555478a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792859; x=1763397659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKz5Fgcl8FFI+imxbIKOoJpuYhVpSnaRPpvrLUXLF5M=;
        b=AJPvMEC97HJ/YwSeT0HWnUuIThjxTjpoaWe/LPXoEeO5CtIFlgBBGYT/KceZ5otTy8
         wNqq5Ufvyn+ISPjRdI984IyQckAcb0+P6tpQCg2LmGXKhpv4bGTGVRhZ/+gt4ILCnfSO
         ncqVhfFgm3lPzqlhriFoHIXU+L2ekt3GI19P91w2wv7kay323arkVCeouao7Gd++erq6
         SogpPl/PC4eCsP5PvwWqrBFxePpnD75clpbPj0Dtr7L02ZEARTD46DFoAH5rz5s/exUT
         8936v3WwJP3DOvjMiK7hQy42SWbKiWbCdUwgtEua4T0O9T/rpnwEMLEqXnv/7uNtMrKr
         4A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792859; x=1763397659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EKz5Fgcl8FFI+imxbIKOoJpuYhVpSnaRPpvrLUXLF5M=;
        b=dQU55CkMqs6hCcwQvpNNG6/oAXvgKDE7LYUOaD+Yib/SYpLHIXkR8E6SGFL5UkLKKo
         OQ4hu8lqcSve8nPBnkk6Wlyl1vktvZGKxtbpaxfZsiSUw/wXzJGqQpRiRHwa88mKbTjN
         9aw15euBGTqCtG+46wyE/T+fzIs1e7LKgShwGcQmik0uMGhf8Xe8jELvh69XZtq2ae+N
         pl1EP2IaUg/AcYJUex9sGIjeIZrYi5EIZl+Z570zmTPrT2hQ/r53gv5oC53aPNRRRmth
         UbxXcIqPebrRsEkQhjsQDXIzvwYn1wOy8FFnFHjBI+ZzQ6YqPRARVPdwn+m/717qywyG
         UryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVboe3iJGx0060Z+rzok9GGBOG4tOei/5QWQMOBKJsZVSBimAlv8FxRstgo1Q9ENN8mAuR/vpoiIX+cqyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKzBnLokK4yuCp5K5YR+DwbbK1eioEzF6FXivcXkVF8MoGK2w
	nC5pLsoUr9lDSQTV2M6/WEqlj6kESuXD13qvPW+6MoGp629AOngSaSoLDcDT4tgllpCZDMdWUke
	DxsIokFvnO7o2L5DKT7SETmSOzzLds8cFmLdnNVUO3tZub1Rx9XG/zH52KdpP9LUVZFo=
X-Gm-Gg: ASbGncvZzxkfpzQ7Ry8aRBsmga+ccl+Rex91TS+/MBZPT7NRzBvrfrtmeJWmSsDbOiP
	XDHp+l9tLGK6/3k2YnC8gyZd/4p+DmEHSSnlJkGkX4S6Fn+s4Lzy4xaVirKOLmSd1kiYxBhe8Nq
	N8TupVY0xAaqY0xBgpM0nx4vrdU8QYJduiSHd3ppyVPwc5yAZudMTR4TRIWPqHWHAButzcMeupI
	SP/J7fEy8+gec4pCeSlgtgkc54dA8Q4TKecPyU4+3r1qFmTiurZm0hoPIc20QEPDtlrLDECGpaQ
	nK+qeJJXpzIqTi+hoQ+y6prCcQZM7o6fP9SOISTg2XCDLtWhkoclrSZoajudc7QYRiJGxYLhxRl
	Lh96+voz3KGpuiqneQhhDVh4=
X-Received: by 2002:a17:90b:584f:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-343bf0dd563mr21174a91.5.1762792858794;
        Mon, 10 Nov 2025 08:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsAhzrL6dTTOmOA8ktM0ipxOyHiZ+nRx48w6MNOFL+Ma4SpEDRNwXEivWpIkv/T67KRQIZmQ==
X-Received: by 2002:a17:90b:584f:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-343bf0dd563mr21137a91.5.1762792858269;
        Mon, 10 Nov 2025 08:40:58 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:57 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:27 +0530
Subject: [PATCH v2 21/21] dt-bindings: arm-smmu: Add Glymur GPU SMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-21-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=866;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=NgXP4H+ytjNcrx+o8ALLRhAZOLvOHraz88+cU8xEoFc=;
 b=P3JYEELDaQNqYHCNPT773ZPurLRY8irSH7D1ka8EbWy70v55a6s41XQrylNdFsIAiMGUQAHcM
 5oLMZZUY5xHBkdCRkIlYhXjOp0JiK+QgZQn+OMA4B0khnaxj4bei+c3
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX93bSGXrNeuAA
 d/LV7giO9nwWCby86crh2tvby8CeHcBiYhbXHQdAccyKD2Y4nNAaAkpa4jnSkkRz+R3qqvmP3BK
 ZYQwOACEk5K4StCsc2dZf9mhP2cL0S5eOZamRkv6+wuI8xGjBiWO/bVdw1ULvrbBlpVazsxitBU
 mfrmZ9gdL0iokqrGvTvvahZ/8C8ry6CAjX4g5ehTDsWjPcuNukBojq6xE9aE5hfA2c10zSgHhq+
 9ph9x71bjXSZC6IjHS469snbuImS3eDZSQKL0VjnDO7rscz3AlfWH85O0M/u8l+DqWb2oQ7wY2D
 E5fqsExIJ/fY1MPh0iuA7+S1LnoV8Dn1N321PkTbkrhm95ZditQImcFh+IyBcwrZbtIzaymot8k
 mF1FCI2E1dS3varO2jCY3zBHDRz39g==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6912159b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-Mh53b5kj-Vf1dIxLVYA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: dNM7i2i-gI27T6d5R51FYPeBpJhXi-_n
X-Proofpoint-GUID: dNM7i2i-gI27T6d5R51FYPeBpJhXi-_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Update the devicetree bindings to support the gpu smmu present in
the Glymur chipset.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 14a9624e3819..cdbd23b5c08c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -91,6 +91,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,glymur-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500

-- 
2.51.0


