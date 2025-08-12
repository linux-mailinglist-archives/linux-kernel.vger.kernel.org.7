Return-Path: <linux-kernel+bounces-764994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A10B229E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEFA6E05D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB644287508;
	Tue, 12 Aug 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K0rib+nv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021A2874E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007024; cv=none; b=cQc8Z/iLWt4KUzGfWswVslPvfuHVcTKMPGSuWUDEfCwBdNsZbB8bdoyKJLElCngpJl0FZKdtTIgG9ma2i7yM+JQ3Il8fIi8ivf71nPF6oZ5lcBeVfz5hK6mm+lD7LasWznNYJVh5mXMzOOyVb7HrCpwHiMXdCYuUMr/rz9pc1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007024; c=relaxed/simple;
	bh=x+vJsdB5UbWnDVZfy6kpse5FbjcsZdmkhpaMMIlOSS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsQ5UN9w3l5q0PhM8XvjHl0aGIHdm/WYd+ZJ186CCDHuIb4jPfKRbMMoJJ+Bz5JNWZO/AL5wQA/5Jj6RJd/8SeapmD47D76AF/zG3UiuRQTi2qrtVMF4LdZyyDlznD9jnEyu9zS60CPJXYey3kRNcQ4Ymok9b5iax+pjVQL8jzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K0rib+nv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvkvq029567
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZQ8+tiX7M0E6mUEBR+uWjNOhJ1OIH6kHczo6fKhd1q0=; b=K0rib+nv07uua6VW
	nuXfD0F5HGud5JLVQGV4eLODA20goezDAju+rxuI+/FHMRt5vPu814Qu+FhA4hrT
	KeORaKJ59xgpBhLRIGpVD1VYMuvstOccBvIBF63Jvc2A2XMflxB7fSpuYuoyoPig
	fq2pbWDvFiTzQAN2qBZs/eilUVhs5S8Y+W67DqwJwOalIDAOlEs8zt525rOkOr0G
	cY28WjtXPTzi6XmVzFU9rPWmqd/42IJKWIjbyZV7i1KNkhDg2udOH0MkehdOyCpV
	KMYfdThQ41noldqwqjlfHQzmCtHT6t2cmv1Iwb5c3pJNKn8ekPBAj3n4PnMbGTPq
	JvUdBg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g8an5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:57:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3928ad6176so4665629a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755007021; x=1755611821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ8+tiX7M0E6mUEBR+uWjNOhJ1OIH6kHczo6fKhd1q0=;
        b=cvA2Siz5GW1qYP4WxtvgDpPaz6ZIKZLjiJN56je+/q8wvtXvSfiDCYyPU40n70x5UV
         7yPZP83yHKFKZj+Yc6NYd7jxAULwIkKIU7C+tV2cWIqYS7GHEyDa+NsVk35d0yYdfPlG
         kCIPtGCrD0BuK2P8yAi4yZnJa7tdpj4nHOJed6wa7j8/YeFcpisvJb+U6dfuKwTu5dz1
         25uAlJ/UAV/AEVwkjsV7sL7a2/LrXx3VkN6i8K5vhmsbDDj8FySQ941ArOa1PYTbMMlA
         l8710r17Qs47a3yT1gUrVmiq7L0Y/ZYwgqoD7AEnKzKChzd0MOywlEn0ZJ3HMnIk70Gm
         yvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWACzOXJeNlw43UjMd7MO3NMounPhU3bVelamXiOk7a/n4fJ4iwqVUA8+Rs8fwVWcMCGllEsmRBtpj2cYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOklyq3e+RTTSpZzv5/IEgofFwPqv8OzkE7W2tx5PVEx6J0RU
	tGUW9BJComQ9p1YmurcqHKkb2QzqbxAyyFNtgQ2n+oFjAdXmaYlaAvq7BQuPnPlqYbxFr90KetU
	PmffK8FyeDdD4Ry9N6sm5g5DrnwHi4o42v6ZSDfIDdh9JqrVkjrkCdTlTuBODkbhar5CXf2wAWI
	0=
X-Gm-Gg: ASbGncud18/WxvggQy3FPRiKBfdfWP5zbkegwpqkc9cPeR/NjCTVHK9iP5UciuU7g9K
	AT+KwZUdP3TAZaNDCEZw3hXfLr4SUDKVbNraKqVuwPF+T/B9Qnan0vxCtssmv1k4xLtHrIm89/4
	SQocGXFyBni/Du2uJSHns272r6GX16zxElOFSW0UsHi7qxbucEk4wy0LVqzglWqOsCDR51WHWGC
	p3/zXLiwwRz91alBanGcpXLnkmvrx7ZNlWQErJVl9Euo4PHAJtLFDtuCN0wH2OBOz9OODYXFNqk
	E1h61ErVQA4Mu3gcmwQC7iFFBHF1vJBZdsicuiRd2Es9BHfMBQvrnt9U74I7W8LFWdY94KhVaaQ
	=
X-Received: by 2002:a17:902:f786:b0:243:43a:fa2b with SMTP id d9443c01a7336-243043afee2mr24964845ad.56.1755007020866;
        Tue, 12 Aug 2025 06:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Ll1cwqHkzp4WWLM0KEdu6MBHiByEt78BDHl1i8byC65D++79kI5HRM3rx5blTvOTvRZLdQ==
X-Received: by 2002:a17:902:f786:b0:243:43a:fa2b with SMTP id d9443c01a7336-243043afee2mr24964415ad.56.1755007020412;
        Tue, 12 Aug 2025 06:57:00 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24302e028dcsm16703265ad.91.2025.08.12.06.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:57:00 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 19:26:44 +0530
Subject: [PATCH v2 1/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document SC7280 PCIe0 phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-sc7280-v2-1-814e36121af0@oss.qualcomm.com>
References: <20250812-sc7280-v2-0-814e36121af0@oss.qualcomm.com>
In-Reply-To: <20250812-sc7280-v2-0-814e36121af0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755007012; l=4032;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=x+vJsdB5UbWnDVZfy6kpse5FbjcsZdmkhpaMMIlOSS0=;
 b=fWhFHgoWQEMAvJ1DN8osk233BTcVPVYyvwBmN6wSuJ/meEyBZHsLk/RFvE/UF0PrIJD76vLP8
 qzTKCqQL7FiB9k/qQ+lM7BF+G1+jXOrrdT7wkLTE54Lpbb1P9GSDCUl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b482e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dTY-U6FrE7cCJ7g73hYA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfXymbAhGG0BeQb
 kaBcF237IHDTqrMS+ow+XSkIjWWFPm6/YAM29g3KOLXso4Oc00qHtO2Why2EqPaZgd83AxgQs9G
 WbEH59hRjzlnLhM0Q8eyDw7Q2K0dwpvrE8Qr2g8uBDRCJInvrwe79S6bRMhoyrpLdzL46VVJn2T
 v47c+VHkuVy933dq78M444lhxsdo0uyWCMTVwv1YpSNO2MjAjL1aYZ1fah9xbzPXDzGXwJOOZiP
 CuT+lYKc1oSPr8oM3ul7OuhEeOZGj09dq6xPVQUPlsGfxrtOMqu9ac3OFTK5sbntPllY8I1yBUI
 vRPBHLf3Anv+bbD2M5GPEzTAWpAK4woARlnyEjfyBECDGwF77Pc6YQ3SwXqDQtH5fjdQZQt0E5n
 vZQRTK29
X-Proofpoint-GUID: 9xgCytKMeB4CCyibUpozMPpL6d37V_ax
X-Proofpoint-ORIG-GUID: 9xgCytKMeB4CCyibUpozMPpL6d37V_ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

SC7280 PCIe0 PHY is functionally compatible with the SM8250 Gen3 x1 PCIe
PHY. To reflect this compatibility, update the binding schema to include
qcom,sc7280-qmp-gen3x1-pcie-phy using enum within a oneOf block, while
retaining qcom,sm8250-qmp-gen3x1-pcie-phy as a const.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 69 ++++++++++++----------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index a1ae8c7988c891a11f6872e58d25e9d04abb41ce..1e08e26892f7b769b75bb905377d30a301e6631c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -15,38 +15,43 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,qcs615-qmp-gen3x1-pcie-phy
-      - qcom,qcs8300-qmp-gen4x2-pcie-phy
-      - qcom,sa8775p-qmp-gen4x2-pcie-phy
-      - qcom,sa8775p-qmp-gen4x4-pcie-phy
-      - qcom,sar2130p-qmp-gen3x2-pcie-phy
-      - qcom,sc8180x-qmp-pcie-phy
-      - qcom,sc8280xp-qmp-gen3x1-pcie-phy
-      - qcom,sc8280xp-qmp-gen3x2-pcie-phy
-      - qcom,sc8280xp-qmp-gen3x4-pcie-phy
-      - qcom,sdm845-qhp-pcie-phy
-      - qcom,sdm845-qmp-pcie-phy
-      - qcom,sdx55-qmp-pcie-phy
-      - qcom,sdx65-qmp-gen4x2-pcie-phy
-      - qcom,sm8150-qmp-gen3x1-pcie-phy
-      - qcom,sm8150-qmp-gen3x2-pcie-phy
-      - qcom,sm8250-qmp-gen3x1-pcie-phy
-      - qcom,sm8250-qmp-gen3x2-pcie-phy
-      - qcom,sm8250-qmp-modem-pcie-phy
-      - qcom,sm8350-qmp-gen3x1-pcie-phy
-      - qcom,sm8350-qmp-gen3x2-pcie-phy
-      - qcom,sm8450-qmp-gen3x1-pcie-phy
-      - qcom,sm8450-qmp-gen4x2-pcie-phy
-      - qcom,sm8550-qmp-gen3x2-pcie-phy
-      - qcom,sm8550-qmp-gen4x2-pcie-phy
-      - qcom,sm8650-qmp-gen3x2-pcie-phy
-      - qcom,sm8650-qmp-gen4x2-pcie-phy
-      - qcom,x1e80100-qmp-gen3x2-pcie-phy
-      - qcom,x1e80100-qmp-gen4x2-pcie-phy
-      - qcom,x1e80100-qmp-gen4x4-pcie-phy
-      - qcom,x1e80100-qmp-gen4x8-pcie-phy
-      - qcom,x1p42100-qmp-gen4x4-pcie-phy
+    oneOf:
+      - items:
+          - const: qcom,sc7280-qmp-gen3x1-pcie-phy
+          - const: qcom,sm8250-qmp-gen3x1-pcie-phy
+      - items:
+          - enum:
+              - qcom,qcs615-qmp-gen3x1-pcie-phy
+              - qcom,qcs8300-qmp-gen4x2-pcie-phy
+              - qcom,sa8775p-qmp-gen4x2-pcie-phy
+              - qcom,sa8775p-qmp-gen4x4-pcie-phy
+              - qcom,sar2130p-qmp-gen3x2-pcie-phy
+              - qcom,sc8180x-qmp-pcie-phy
+              - qcom,sc8280xp-qmp-gen3x1-pcie-phy
+              - qcom,sc8280xp-qmp-gen3x2-pcie-phy
+              - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+              - qcom,sdm845-qhp-pcie-phy
+              - qcom,sdm845-qmp-pcie-phy
+              - qcom,sdx55-qmp-pcie-phy
+              - qcom,sdx65-qmp-gen4x2-pcie-phy
+              - qcom,sm8150-qmp-gen3x1-pcie-phy
+              - qcom,sm8150-qmp-gen3x2-pcie-phy
+              - qcom,sm8250-qmp-gen3x1-pcie-phy
+              - qcom,sm8250-qmp-gen3x2-pcie-phy
+              - qcom,sm8250-qmp-modem-pcie-phy
+              - qcom,sm8350-qmp-gen3x1-pcie-phy
+              - qcom,sm8350-qmp-gen3x2-pcie-phy
+              - qcom,sm8450-qmp-gen3x1-pcie-phy
+              - qcom,sm8450-qmp-gen4x2-pcie-phy
+              - qcom,sm8550-qmp-gen3x2-pcie-phy
+              - qcom,sm8550-qmp-gen4x2-pcie-phy
+              - qcom,sm8650-qmp-gen3x2-pcie-phy
+              - qcom,sm8650-qmp-gen4x2-pcie-phy
+              - qcom,x1e80100-qmp-gen3x2-pcie-phy
+              - qcom,x1e80100-qmp-gen4x2-pcie-phy
+              - qcom,x1e80100-qmp-gen4x4-pcie-phy
+              - qcom,x1e80100-qmp-gen4x8-pcie-phy
+              - qcom,x1p42100-qmp-gen4x4-pcie-phy
 
   reg:
     minItems: 1

-- 
2.34.1


