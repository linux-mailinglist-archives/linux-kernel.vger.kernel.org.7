Return-Path: <linux-kernel+bounces-858509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF570BEB024
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42FB735F867
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72225A34F;
	Fri, 17 Oct 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OwzT3dgM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A43016EA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720966; cv=none; b=BDwTQP34FXBX8Vh5cOnyWH9X3ykC6AAMijUHTJr/tiLynChSjv2RjkKEeM5dBzRzN7F12Nxj3RGk0eFqP0GOuPab5WC2tI1vl4TZj+UvMYJeKImrYSBCtTw6It0hr18sGhGfp3oyioVa87BPQzwNKLy0A9tFjKA+N8qbQcoijCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720966; c=relaxed/simple;
	bh=DKmlAsIPsxKb+UGLtLz6RJbuB/etyMXqxhU+LUte0fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnt22c96G9EXIpd1C8LtQbZdT3cRTbgcnK/pjOHX/4irV3OPACP7epJ/wwwTENBOuSiH2bxBCe+XtcwdF3Z4lyALlqhFRhuUrOcYD4j3fObxIN5M+jyBRJP7/HF0NutAd1UFAwB4IJvWDeJxTAdfIyZU0WisILD3lwlPK3/BrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OwzT3dgM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8IoD4002701
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	63hqcsOArDpXHsB1zZ0JWMY/vZLAfDdRjASdl3K+gzE=; b=OwzT3dgMYIBGJkgP
	ryQIdBp+caDt5nzx3XIkgHp1hCfFQwl1kfS3JAr3L3XlVOhkjZStgvJ9I4WFTLq3
	MrUzDzYx5q0Sf26VCE02q+ed5hNPIWeX2nx0XX6lLfLOtbwpK/qRSWxVgmtBfDUF
	rHdLZUxXeqYv2ecVyaMs3WVzaekwkaPc385sL4JLHTUsam8raUD53oF3jCiDjWK1
	hDRlJvSmOUDNyC+ApOgFn36kAODfgt4ZwXIHEhLGUUekGV+Cs4KUSl9KaDSbPWGk
	juAleLdbXDSqd/5mUVJwpxyr46+lwjynr0qcMCODXG4yj5Wl8LTJlJ+1id8oP7ZO
	7Xi4gA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8n36t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909daa65f2so25529195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720963; x=1761325763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63hqcsOArDpXHsB1zZ0JWMY/vZLAfDdRjASdl3K+gzE=;
        b=lwZlwAQ7ukevTbu/w6X2Ve7Qv+g58D+1s8mG3uCtNWBLmNKStigyCauKpgnpGubCev
         TbD/6y7jOiUSJEBvTX5AJGuguRqU85j8/iUm8rOVIt+e1NuckCbIBRkZQ+IOf8+onCFE
         vmynvRTqGBM1qAV5Lfp9ws6SnVslZ3rANPYqgPVR6pzIbe4vPOmhW6nzsJtajy134w5I
         bZLj78A+fbOWoVXD/HvyiJKfVn4IOejBlCqusdzqG67ZflP8Rho+K8Rm4gsZ1lwxa/7Y
         4rfgYtGP9nUfDGkYN5Q+yA+yCHQhiEzNR20mia0tX/o81XBo+VgoknfchfoohHCR4X+I
         F3/g==
X-Forwarded-Encrypted: i=1; AJvYcCVWwSjEoKwYm0rmR2L729G1iZ7S7RPF0xsOkh2obA/pMJaSMJVJAqUsjcV3y4yZUYaBDFL/2ssnh9B99FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZEr25mUE57vynokCKY/LmDTb93qiDcBPevrH6P870nSElXlB
	rCCkplWF42838z8sUmfXtDNjWPzDbvotUoI6TXzf8nq0mAUIiRSyZv9T08PL03OYhw9Ti4L+CND
	lnn3o4mr/GxQgFvEUejhpuUb73j5VXooR2KAYq2rZPgxI2zf7zmZOncDIXiu+2DntPHw=
X-Gm-Gg: ASbGncsiGkRm/4roSbVMqL5XvrqqDVMntUSkVS0Cs3TeDoavaCRaYrN/6aQZc1As5k9
	MDIYpBwqjz9ZGALPrUfONL7yZA9zEk/etXCsh11XOXz+PPiPhbVe3MtGr1EBMVGA6rkYlyiwiS7
	pxDps8Ugddm/7vVRZn3JcSJwOhfemSvHGfzZ3fTeO2QXLLP64uT9xMzU53IaLcjWk9q0uJHl70N
	NIpN6wBtzfIPI3m8o0SYbm5SVwlEuq9jyXcOzg+Uxw/hfD2cij8neFzzQk36xJ/gFNzDgel3hmy
	eZJhMM5nR5Lau2XMMTNejY7hSwlqVqxW4OKWUg6gVcjyIkZFZIRBfA3/sUh1H4oFEk07nTLD2B7
	eA22RvsCqWU/4POHbvMINzfY=
X-Received: by 2002:a17:903:18a:b0:271:fa2d:534c with SMTP id d9443c01a7336-290c73ffa25mr53353455ad.22.1760720962520;
        Fri, 17 Oct 2025 10:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB96UCLwEK3jUShTQzV0gUnk3hW5K3A/BrffKQ/0gKgmFt7/wcKFMWQ893/dLgxL2buboOqw==
X-Received: by 2002:a17:903:18a:b0:271:fa2d:534c with SMTP id d9443c01a7336-290c73ffa25mr53352965ad.22.1760720962044;
        Fri, 17 Oct 2025 10:09:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471febc6sm173625ad.86.2025.10.17.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:09:21 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 22:38:32 +0530
Subject: [PATCH 4/6] arm64: dts: qcom: qcs615: add the GPU SMMU node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-qcs615-spin-2-v1-4-0baa44f80905@oss.qualcomm.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
In-Reply-To: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Qingqing Zhou <quic_qqzhou@quicinc.com>,
        Jie Zhang <quic_jiezh@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760720932; l=1765;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=5mbhq+gWS8F7DvY1Msh9SObG+ekXua8QpbuDfASaubg=;
 b=yY3kyUZ+SDP38eprTVxszruPd/GBMnCdvG3qN4R2sdzMWA96T4wUw4IkFr/sYy0WJkwQXVthq
 NP4NVlnlLygBIS75BYf5huDjqCUnykEwnPihfxWH0sC9BJg17NyTa70
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: IejB1PkkO_tDA_nCFnsS_Sd0VHg8Bx6B
X-Proofpoint-ORIG-GUID: IejB1PkkO_tDA_nCFnsS_Sd0VHg8Bx6B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX4zEaAcTCFFNW
 Cqz+tIoYNPcmDZTzYj4qZuwj4KpiQ6SOYJhka9iDPwj4uqLD1YFokbhlZtixwv7KRZSgo/jwXKh
 JX/FqknHgdQABM6QpByIXS3mFsqSziC/6/k6eANrkWcOx4yL4Y+J/hUQBK+pknbKW1exAAwmrqU
 Z5+K+UbyYxJiNG3i12J80OQF+zBF7hG5taf8FMXizgs+iLkNiRX1WtjVPsMQpCNMnEWotJrHG7S
 CMyFa+jEg4OjUu4pMmQMe5LD5DHnfFAuj88q+PXi3htPAAXhv2DlqFvo4+1LMeiURNYgZU2zrCA
 dZAJMiMFLrgE+ocWik8HnSRCz8dmu8B68+7L841SFz95JELGYJ5s1AfpPVddU1C3NGq0Ilt5/bm
 HIlcxUSBqWlC/cWOtrf0rlb7dLt33Q==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f27843 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Qd8OTwLUrmNk7h6opE0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

From: Qingqing Zhou <quic_qqzhou@quicinc.com>

Add the Adreno GPU SMMU node for QCS615 platform.

Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 3d2a1cb02b628a5db7ca14bea784429be5a020f9..e62b062c543657b6fd8f9aba7ad595855d8134d6 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -1700,6 +1700,33 @@ gpucc: clock-controller@5090000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@50a0000 {
+			compatible = "qcom,qcs615-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x50a0000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			dma-coherent;
+
+			power-domains = <&gpucc CX_GDSC>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+			clock-names = "mem",
+				      "hlos",
+				      "iface";
+
+			interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x06002000 0x0 0x1000>,

-- 
2.51.0


