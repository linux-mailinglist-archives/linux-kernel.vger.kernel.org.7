Return-Path: <linux-kernel+bounces-889373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735ADC3D6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E331C1894865
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5932FFDCC;
	Thu,  6 Nov 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5afhiqQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T5xoyMUG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A912FDC24
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462255; cv=none; b=H4ibWMy0igRpOSfY1mDH0o7JE3pNY6wrwFFjqoTHkGMJB5sfJxV9rw5bMggsVbYB4JJVXi3BobVjXTvlYN/Jzku8zrQtc5nyyTNeOXK0KtNRPk1Pzd+CtanVMReyAPaNgF912HXfuuhLHjaoppZJwjqDsPtX8W71knrOUORCmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462255; c=relaxed/simple;
	bh=xp9zIS5nSoZqfWGYaCyjPXGPqBeAS2dsdQqgSk356KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axIQp9M9cwZelnncWqoYbhLneoNnm74m0STp3/Pqep/uNxnDQk29qEkto+SptTsDvg4P8h+6RQjK4YsrmjXmB5bPRkOajP8lXHUQDt9L0FAUydFenlJt2s95YqRs8dMvVpf2A3Z2Dg7L3ZpGOn3yT/UB85oDUaJ7c5uRxXl62Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5afhiqQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T5xoyMUG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6HVtdg528560
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 20:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JklyLBd5/oUcZvJnNYponAzGu3rNKVXLQXM2TLGaevg=; b=a5afhiqQiCsQ8dfr
	Mp8Y0fH7NKI8RRysFaLS8x1IMAJ/DnP1PJsuxRxk8Z8vFcpHyO66aMkD8zpv1I+g
	cywA51ht9ioWKBeetftcVui+txV9onEwFoNmLIqJzaRv5JyFoOo9OqNK1EYd90Gd
	xo39Mlp2XObBhp1aaBOAHexJ6mt8acpMnHnAG3kQClRZsrag45v9lX9YRC23MPFd
	15RCEUgMbSpoQoNhMB+/bwREyH7b4RrkuXbFOvJ3qYhFeV0CD0LgrYeNVs/QWIgm
	TdU65WFV+H51ibt31fCPjGw8IrTxxpXToHa9OBq2ALClv4iDE4Vt69CIgdHC5gTn
	Cqxnbw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a905hrj6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:50:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2958a134514so566825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762462253; x=1763067053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JklyLBd5/oUcZvJnNYponAzGu3rNKVXLQXM2TLGaevg=;
        b=T5xoyMUGKreMawCSS1ZxXJw6vWcrbd03T3RUtzSgnqyNorhTeaorrH74/s5BI8HgHX
         TlNhJn3uWxGnl++jWj8/szHf/PBwhLrNOSbp+DjO/ovpcz+/8vy+nwQQOVGLqqsWoAV9
         LzhOo9pfTFVWrIOz8ZM6C7RS3IepnoQfzhPC/AgKL8NGJsRdVZ/dEFdPxZySru2ZymeU
         3gAN0rgMR+X1cR12jieJ/ZJ+gNi8UL6ApMJ+8wGWiBFvTIrCJGcx6IIb2pP63lU6+OGV
         LLJJwQw7WDFR0FsxAxC+4Di4hHGheXH5wPMzTaCcxD2mgwjSqPh2DpCtsSJWApV8796o
         q/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462253; x=1763067053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JklyLBd5/oUcZvJnNYponAzGu3rNKVXLQXM2TLGaevg=;
        b=u5fCgfG/8gTnRsEbxig9YzwsNNfvKpvS1EOxYADBcoutiV1bWy128OmszuiNMPRp5q
         Da0sVUN9BSAHblo9XMRBgz23WC3edSR8I1yJveYjrj4PX4en4E9ZhmLiqyzb7UflLfAG
         5MxQd+kuZ1FlYk3gYJdLavhffW5uxuiYCWhMPVO+YVWkjYu1wWDl78AfIkrZ7Cy91ne+
         qwR9wpS8oAkpxudgcEPDyoGvcz3kP/KbRtiUQjjfFTgL0jtErSpnPJfmIjw/02mPHyJg
         JyMe83IaG+t3x8WirZhJYlbzHZClNU/ud1QvQAX/EHOQlRkqWwxBcv1ti7xJYmMuHyMO
         8cMw==
X-Forwarded-Encrypted: i=1; AJvYcCWmet5MSJSRrFP1wxNMNKn5/euFN+twBtLVpYe8IzgKmqlZ58YFYUojShK5yWOOExTJkBk1MRln3AcRiv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KPLJM55CBOOKfnzekJPb3nmhgmU5mGGjMYnAFptZNYDlxF3L
	6RZYrKYrb5PldoFYxHTfXpA3lvaxs5pcdcAVIWxLSohESpB0Z48hkHbj2/DrXoklAKfplbZeM7H
	j4Wh3nmiBPnsBvevoYM88mXlAa710cXgjy8gYEc0p/31SU7zYYHTWoORTdk00doG3RRk=
X-Gm-Gg: ASbGncu+UR1RtveeK3s0aS3eEeMROvxR5qQxGs16XMykNeBTAA6F1mALnxMFCyYyfom
	FeoskVi1wfKAnEujld7ZfT0N5z7I9AO4F1oB1zS/vCLi2DQ59SXPm3HdebLpaEZoIdd2aJ1yM0Z
	FW4ZK/Yn9+7ms03D6PX2yeas5Gy9qXaNxXKfLZxIB2pzadFV9/RnxsF7p2J33uco326fkjQtWJm
	ilRjo6gphOPpna4++NaijOVo5GhfF3J3gv8MsuxH+Q9KBjnD1m7J4nIwdAuAZLLCkI/JmY0SnF/
	99B8ubMUZDnMaiibPEIqqxQ9gl+qCXqwPns6riqji1FB3SPK3+EeDHiNI9mADu7iUuBlgtlgIA0
	1QYNkTvDuK+CKStg4GO397Aw=
X-Received: by 2002:a17:902:e786:b0:295:24ab:fb06 with SMTP id d9443c01a7336-297c0403118mr9270895ad.22.1762462252565;
        Thu, 06 Nov 2025 12:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/5GGH8BRhaWtLEiTr4/i8IAaR0hxcNwnqgPpCZlj8O61OUi6laH3I2DVn0q8vR+8Qikezhw==
X-Received: by 2002:a17:902:e786:b0:295:24ab:fb06 with SMTP id d9443c01a7336-297c0403118mr9270625ad.22.1762462252069;
        Thu, 06 Nov 2025 12:50:52 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm37408815ad.50.2025.11.06.12.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 12:50:51 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 02:20:09 +0530
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm6150: add the GPU SMMU node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-qcs615-spin-2-v2-4-a2d7c4fbf6e6@oss.qualcomm.com>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
In-Reply-To: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Qingqing Zhou <quic_qqzhou@quicinc.com>,
        Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762462219; l=1700;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=jCpex1VaC1U4tzmGxxXkz708+oeE3vay/zj95FdtjfY=;
 b=zZhrunbbfOSaWlJXSQ/bRKMJIZYhHCqaCsTuyaWawpGpxSEo06tbWbI22J7d+o5CvfmfGlLZM
 MgBazqbn/JrA5e/9cbSm2KfOwLUJI57ISZbbPw+jn+9T6JZ1PGou7bf
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDE2OSBTYWx0ZWRfX0Ea/whcf7OmY
 L1ML4w21la4RBEYF/1lJYr9cYxtOmRXfAfQCGCVJAE/j08ykvgeVJDxzi50M+TAXifZgGCahVTk
 KfpH1I/Ka7g9wywDUN/dyqRmyKp7YQ82jhTpBmzjzqpQNOJHZZaTmgvH3TLc3LysVQKOIfzVkU2
 jfLb6Ghr422/iSF7yx9wZimaHioDhCx0r9VyY0P9GQEPtrRYOxA246oqUeMj0b/PPRKNcz9f81u
 1Rp4fvFgRWzUyLonVt+gim6vXP2EsFsu7TBPD5AFaprianZqxndoBK58NBo34FHOsQfmwfkoS9Y
 j/GrWOApHSMaUyq2fUStZ/qNZsN2gj9VRFeFB4mPgR9Rt6NZaipoylveje0oEdLVrShAjr/eWrM
 Ss7xYcB6XeioS0QiXb6KZWi1gdPlwg==
X-Proofpoint-GUID: JYRnTrzjKNxpIM3kp3v4BFtSm8oeme9V
X-Authority-Analysis: v=2.4 cv=GMAF0+NK c=1 sm=1 tr=0 ts=690d0a2d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Qd8OTwLUrmNk7h6opE0A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JYRnTrzjKNxpIM3kp3v4BFtSm8oeme9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060169

From: Qingqing Zhou <quic_qqzhou@quicinc.com>

Add the Adreno GPU SMMU node for QCS615 platform.

Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index d1dbfa3bd81c..efb753ba1747 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1839,6 +1839,31 @@ gpucc: clock-controller@5090000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@50a0000 {
+			compatible = "qcom,qcs615-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x50a0000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+			clock-names = "mem",
+				      "hlos",
+				      "iface";
+			power-domains = <&gpucc CX_GDSC>;
+			dma-coherent;
+		};
+
 		stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x06002000 0x0 0x1000>,

-- 
2.51.0


