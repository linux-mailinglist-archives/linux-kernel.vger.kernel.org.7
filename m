Return-Path: <linux-kernel+bounces-893706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBBBC481B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2751188C504
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97A2874E6;
	Mon, 10 Nov 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BkyHWAyJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+JRRJ3r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908CC31AF3C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792838; cv=none; b=VV/Gb4pTJ1L2jaIy257VdSm34U+/koQIPl5u0rzfeBWq239+67clSrk5m5cCAiu0zU7lZ2448GU/xGSt7eC1Flv1QEsmLMU3TuBci3y+zxd4mlJ2VT0sLAAO5rCda0OlGdI+nd/tgW0GDRrxAi8SzutFqlRgmb0jrP8Lmmd0rVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792838; c=relaxed/simple;
	bh=G2l2DvQ06Sbowus5yA4dZFnVkOMl0ih94brxKuiwNUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZqnsW6OQpdj8A0HPVc7y97P2EvVr0dOFh9TLRBh0M+WkpXkMD8XR3j6qc80LOv65+ojNJHq+M7BTid4Jn50UKeia7i3KI5O+K22zWrX18SJD4ohQ5843OJ6yyePKQ15IB3hqGqBXBZGvrNU94nhf9mcE8yHdWFRT05emOveSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BkyHWAyJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+JRRJ3r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFiw621809228
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tB9D/fdcmRiky3PhS+srVAJo4/Iv4jc0qDMbbq5Kk+Q=; b=BkyHWAyJEbEj1Kf7
	5qUO9kdpU6Q/9UbvpvsTyHJ39ZOeI2MRNpXnJaQUXsm5g9sVIg75ajCTwI3RChyC
	sYOfyBwNRjbFV+GiZo1TNoEuwP0pxYtPZk71L85dTL4NOoVD3eMf2kVsTkcsuoY/
	n+eZijX6DcMj+LmlINZaeDdMPdkFn3NocFqjGldaKuVSBKh5MgUsUU/UPnGS58Cj
	aSHqLKMdDner/Iu+JnY0wkKz6Q9Abb29pE2Sr5uXN0e6f0nQn+7q/M46YxpxBpBE
	0PXXJE86u8oR9CBACBe82+DgM3FM6YdDDx+MTRkL57pui6mYaevlv3g9v9gjctG0
	yLP97g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1jm4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3438744f11bso2025724a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792835; x=1763397635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tB9D/fdcmRiky3PhS+srVAJo4/Iv4jc0qDMbbq5Kk+Q=;
        b=j+JRRJ3rx5TK63mly045wemGrbpLMKpnc6eQkyAuyG/YNvOtnT2zx91qsm5AVzb9u8
         buF1zHVxH3XO3HuIR8CJrtLBS7XID+E1A1KDPBD5CbYkiabGEPeNXwb2ud7kn8JqB8LA
         rTIDbnFxbPFs9Dlx1GMUowy5SqOVkaMyWuByqnUyp8koUsKMqB63NM0rQrJ0ctAr2fg6
         bM9ZEOU80HOoRkvhjA6NLTKIKrlTlXu0WVt5wh9qFej8XgoHaxgGGbuqrDB9bkkY1Q1O
         0vOJTckJKzq3GBZXjengdkXRXBSsAQvvTFNIBoCjutbMD4vuBylZ8GSoKhYGgOMDHjCo
         PRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792835; x=1763397635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tB9D/fdcmRiky3PhS+srVAJo4/Iv4jc0qDMbbq5Kk+Q=;
        b=s1m0iOoz3hxohrfz/OFkZxYl9E/+njEfVnpaQvZQcUQ11oqF5Qp1huU1xRTBmTNIL1
         aj7cpZRsEZYuJOTjao8k6iSsXe0YsaEG2xEBew5VPJNtfCea5KyU/oKuuGUrWD+wrfv5
         bZPjNXXsv5uNYy5NOXXtCsaZUjNLKYFlA2E9lwx/KWdXjiPNCjoOG9jX5kmS5z3374ck
         W29PDNaMCp7Mz1fzTccayBeqdeivS98xzBj++pQ/tkaYc/Oz915FIyPHDA092+ww/+qq
         yuJvQKgCePaJtEXxdn6WAFh5rNfInzNx/AM5tMRa4fJnH/MSDEUAYgCAheDAn41DmuVx
         3jSg==
X-Forwarded-Encrypted: i=1; AJvYcCVykuG/wwi3XHYocWJy2h2pyDkCpl95BTNSugOSUWMjz0Ztgi9SLJ5aICWCzVwA+tlVQTMlAEyq44rB108=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDAOiEBJkO5xzR522P6cKr8bHBBLC2AhHerIu0I4+ECLk0woHH
	9515k3+eDyCTduG+O0go4hsB1tuWOBjK4aV9s1GQNa91GIr2YrKPX8HspFliznd3KBwwz66Y8i1
	JjgokwRpiz0tP0ouuuDJLg/W4AaOL7mJalPB/VSuUn+lfRDnAwUZ+fIaQCKzbcIU6+5E=
X-Gm-Gg: ASbGncucrvjJ4AXDNQfqykiNAkItr5w7LKTDvWLI36A7cETBdfQ1l/SahzPrGN4DSfZ
	uwKl1MMJtOpzFatjGmb6xSNmY1j6uRzZGpXlXFCANojfKbT4Bi5wy7CZ84F0T0N6f4tIv00Q/t6
	sWsBr/zOpEgD0u5UzS7caomXSHraqnHTfn38kMLA/OhJl6tZO7MH8ZpWYpBPbG5K0bpNkSFa84m
	c8duNzQ/xyRYrazTJD2JNq4wtdQbkNKY7nKETdP7gYnaRqumEPGL3gVcM2/XbkHLWkLKfXoOuxQ
	CWxR2Fas41+e2QRXWzQAhDXAplRi38Pd1Iqj7RjMk6fJX1Yl0PQwywg0AgvUmkkhP2QjGzv93q8
	mwM70zUyCtKEt7YPQKSlmzas=
X-Received: by 2002:a17:90a:7786:b0:343:87b1:27a with SMTP id 98e67ed59e1d1-34387b10381mr5172068a91.10.1762792835072;
        Mon, 10 Nov 2025 08:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWFnJwABxwEcbzLA4NNn8jcaHApPxbRaToXFtfQE+N3nOzqp3Zff9UTtgGElCKztEpfLbq5A==
X-Received: by 2002:a17:90a:7786:b0:343:87b1:27a with SMTP id 98e67ed59e1d1-34387b10381mr5172042a91.10.1762792834452;
        Mon, 10 Nov 2025 08:40:34 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:34 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:24 +0530
Subject: [PATCH v2 18/21] dt-bindings: arm-smmu: Add Kaanapali GPU SMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-18-bef18acd5e94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=916;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=G2l2DvQ06Sbowus5yA4dZFnVkOMl0ih94brxKuiwNUI=;
 b=i58PaWIJhvP983kaIcMBq4mEfOd2Dd/WK27M8EkgEPM8e2wRt8CP0MDcNjfuquTO36mYLtIal
 +hsVHf9IYi5DvmUiLKDu5icK9arFAWOyRczHm6SeqUfsEgpnR1BfIU8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX7Yuywyb/iyLA
 7/rA55b0Q4c2a5/dEYY6bYaw8Tb2kR+h5q754PLaJ+MidQXKp064e9y3gO5lyK1vSQaFb1rI0qG
 MmJ4Wf5/14hrdS//fyT04vhz9Cti8HzzLNURSJLzRq1+S71pLVg7Zz+8a5wAa+EWGbodeutJbOh
 41Mte6lITVi9uicB9ykr2u5O9dma4Mh497pevOsamvubaPxK+hrSKKKw1GDh7/LMpps09Q7Qd1B
 9eNJiT0AIcLRW6hqLrWoNHZdohJ2dsGl/DUe0p/Eui37SEp41h17X6d2lvlw4t4uTFbwwkQtrXp
 ZwFPO/QvuApIH7kEFDY5xqE20R3lCROC0d4trg5tOjMC/fZXdv3HX26bMG4rcGaW5TpT/Ou4nXw
 oWK4y/EGFM5oV9qq0bApKPfV8NIeyQ==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=69121583 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mFHhPm7ftKKhVARBLukA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: vknwbq_-CJnyiYsicvQk9-uHn1QdsYJx
X-Proofpoint-GUID: vknwbq_-CJnyiYsicvQk9-uHn1QdsYJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Update the devicetree bindings to support the gpu smmu present in
the Kaanapali chipset.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 59bbd20992c9..14a9624e3819 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -91,6 +91,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500

-- 
2.51.0


