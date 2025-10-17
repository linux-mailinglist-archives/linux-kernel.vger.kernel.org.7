Return-Path: <linux-kernel+bounces-858507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB2BEB015
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4162135F6C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D262FF676;
	Fri, 17 Oct 2025 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJD1oggI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0F2FFF84
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720954; cv=none; b=d+BHjGKMiqoPUraGvOMwyXRHoAvvN77d5bs7gRgdaykk07gU1OYGLCO26qEe1LdXiwK96ZZ7z8hR3F719l1Tunh+hPBeZo4n/Osi/2DtUn5fr22YN9+dSVHgvrc7E3j289I7UNyuMetpzI2yfveBMGAgR5iIXfvIabrTKnbvvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720954; c=relaxed/simple;
	bh=fmPSoBFxIBBtZG+qNKbc/Y8PFtIvsIl44u/5OiNM0QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ittrxsAYjooW5dQAFZLq2oWvml96fGdqKiQ3+lfvQb7ele5s31914GLA9ZXBWoBAi3tgAgS2wnBNoF6uC01Mrq6rnM1duijunT/SJ6jhRHJpmxJVzlE+C9GJILaoRodAD7VvcAf+zBhhNcRZ9N3YA2eiRG8x6FJ/YlZicOM8nMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJD1oggI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HG5cqQ022338
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UwTH7o+4XBoJuJ+aQB1pooKD/6ls1YBf76KMTkN2sOs=; b=oJD1oggIDfiJdUlw
	ZUGUmGGn0/6uhJcBvn6tQqGPgLU3+WG9F4WabqSjp707++CaZ2bRZ6SV28uro0Kn
	+GgSYfUSmPzUI1AQ/BkS9vNuhSqgnF8+VO3THPtAbnM6YR5MFFmTEjxzphbxgvia
	rEn0BPPHpXfFD7/P+tgZB4E5g1EjT170Ff56riYG/IvLKe29oa7BqJQ+0F71youe
	UXQ21AuGbr1k2M5R8h64fhuCNhTgz5KwRS/YvXsVWeq1/6SulQA6FgCLQIx4cHXo
	GE2k0YRrB3ZhdNpYDXk5AY7sg5G173LR1RETrWH/NYXcPG5Nqls4rygaK1mbvGJZ
	2oFdNg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtj2hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26985173d8eso47733625ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720951; x=1761325751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwTH7o+4XBoJuJ+aQB1pooKD/6ls1YBf76KMTkN2sOs=;
        b=qQT0UsWxf4X0ytj12opOigKgwh2W8Y1zmg1au7U+CdJ9syzcJyWuwbETfsCC3Pm8Z7
         RN/oYQDNm3IKblW507tEqypu5WRGl+DgqsHE21yTyrIHbnng5lw0jQiKCh6pP/jhjHjb
         ywHQyzbVgb8If5iXYISElyinOUbaZi5ruRFLpicZi90wAkRvFW/TB9HH1n7pYrAlHWxU
         zaty8wcx+1WqKU2x5aMN4yktM2Rz8G5pQ8vibyhKbJI1Cne/M13WqZjScWnn9/V5ILCi
         aq017nTB8PxNdBQlez3FIM40c+xRMAYsocOmCPvAVDnUWVwMPX7YfZvcIwJH/UlOuv5c
         6LCw==
X-Forwarded-Encrypted: i=1; AJvYcCX0s3bLS+nT2jWYN+09B9JXNGH/gJd7S6TJNuygjW8ZcD0FjS9s4o2W8q5jw3NjtvgRXVZfgAokAbINEpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBm5w95sW+oZEHAh3ZV1MmQpZNvsXvi5J1RKHR2jCtaaAVQcq6
	W8FO1F4OPHHkNGN87Wbt2m/K8aMAETrU0trCI0N2ADPkfy6WvvMB+vS0NaH19ZTVNOQ1zb/qB1h
	AY07GTu3sfKUgL3LxdZZTi/7tUQKS975OSmd16SRUDxmrfdB3y3oQ9msb4VGns0pzg6Q=
X-Gm-Gg: ASbGncttc/I6Agp4r93nsyHlblDPnN5aoFt9fTpWMG2BGdN8e5TsstsVC1p0OWuE0jB
	/ZG+Ogby1ywmz2+lDyOmFGpUqgmGmjiyaGBsOcSHuDx8chiVmhOei2m0/ORiE1jh5hasBirYDhy
	G7/tiNSuMelXLzknXbZj2DcC7HCrqVxZCXK/+DdI8oW3dMTdvsPeDpcXnR0zlCoT+16qyfJAu0I
	I1gIDWhAsPxINTdY1vNFukMqVKTlVRN1TKKsUApkYIrNZ1DfTNIAIQV84u/7rEWWMszBRLGia+Y
	b0R/0uE8TAShlD22aIKhHD6RkIBOqPAiwFSpQ4tG8vDrwWLi7MaEtjwb0ZzDWEe/cnmyn+Ng2n1
	d5/6rqjsVnctpjmOsUoBxdck=
X-Received: by 2002:a17:902:f681:b0:290:d0fb:55c0 with SMTP id d9443c01a7336-290d0fb5971mr49334915ad.43.1760720950666;
        Fri, 17 Oct 2025 10:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUb9LP/n6zFrwXHJ8I2abuL4JVKUjA/SfniRPodA4FW/70lC1MQrLHyQxLVOJP9P+uu32WNA==
X-Received: by 2002:a17:902:f681:b0:290:d0fb:55c0 with SMTP id d9443c01a7336-290d0fb5971mr49334455ad.43.1760720950092;
        Fri, 17 Oct 2025 10:09:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471febc6sm173625ad.86.2025.10.17.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:09:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 22:38:30 +0530
Subject: [PATCH 2/6] dt-bindings: display/msm: gpu: Document A612 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-qcs615-spin-2-v1-2-0baa44f80905@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760720932; l=1760;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=fmPSoBFxIBBtZG+qNKbc/Y8PFtIvsIl44u/5OiNM0QY=;
 b=CidJC+6YIpgBHlxxquE8ugzG/PB+2dG02+F9rIWT64xQPn2fehu/vq/ntaaWTpRbuC8YK5AY4
 skKJ5CEpX/tDAlo3rsnQMXCvQj8m3Cqg//pKnlIS2RWohnlapiyEozV
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: ecC6TqbXczmNXO1XpbkWgIgUP4oGHHJ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX61uxMMeQnGCi
 9WJNbIt+j4bmwQ6GAqeHWi+wConqhIY+lvymAd3fdqptIECZlg4JVCP5WAK/6p6vY+pIk8klgQp
 oJ3J5TGEW5TdMUax/vcNaycry5uk1PinJcZclOY2WZlJhaWKph7rQXpUwxXTdSedRnS1SyWXFX0
 0vZyu0J7AySWL6RPmvQO1M2ilYnBAZhnDIqzXnS/PlmQdlPs7R5QAgfC7ReSIiYVzLfSOpi2oaj
 yA7mY8WDem5tXhv3vPDS7dDuSdhlfIE2ud4UX1yAL4ak3OZCf2jJQJdXuxyuL5siPxDOjfCyceN
 MWAPARb4jh83NJyn7OjwZRqw+B6eXPwhRZlS3dpSa58SUeyL7x1iMCpTDcyOq0bFlsa6mUGdB+Q
 scG/MOeVjyaF+9W8VNquH3z62ZfoVA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f27838 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SkoZtctDx9gcCqASqUMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ecC6TqbXczmNXO1XpbkWgIgUP4oGHHJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

A612 GPU has a new IP called RGMU (Reduced Graphics Management Unit)
which replaces GMU. But it doesn't do clock or voltage scaling. So we
need the gpu core clock in the GPU node along with the power domain to
do clock and voltage scaling from the kernel. Update the bindings to
describe this GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gpu.yaml       | 31 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 3696b083e353031a496a1f299d8f373270ca562d..efc529e82bc198e7c3c89a5eecb6f929960a8de9 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -45,11 +45,11 @@ properties:
           - const: amd,imageon
 
   clocks:
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   clock-names:
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   reg:
@@ -388,6 +388,33 @@ allOf:
       required:
         - clocks
         - clock-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-612.0
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+
+        clock-names:
+          items:
+            - const: core
+              description: GPU Core clock
+
+        reg-names:
+          minItems: 1
+          items:
+            - const: kgsl_3d0_reg_memory
+            - const: cx_dbgc
+
+      required:
+        - clocks
+        - clock-names
+
     else:
       if:
         properties:

-- 
2.51.0


