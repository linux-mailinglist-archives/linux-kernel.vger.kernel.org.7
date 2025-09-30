Return-Path: <linux-kernel+bounces-837164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABCBAB96F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1FA3A794A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076229ACF7;
	Tue, 30 Sep 2025 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKszC5nL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28062280309
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211520; cv=none; b=sXIBl5kr3Bxke54Y4DH9TRefGz0gvO3Bp/taIKKv5P83sYgcLz+4KBokWN27S9OOGO/0MccQuliQISRA++GPKz7isskMaKs5uDjh6v2lalJfenJLeV6COsdWs6L+k8EVcd10MZywoUJLeXMF1wcValoPU6NiHPZUqjPiE/QkaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211520; c=relaxed/simple;
	bh=pH7QzqfVd66CUSD6i7hLasiAtJ31uRcCjsRKu6nI+uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOgxh62xANCi+3EM2H37KUqZkOLZD4Vaf6qTZBJp4C9AE3ecYrMsZF7AVu/W/x9BsqnTQjyYsWeOhsOyYvl2eOTOWniVvcJ4ju8h6uWXlcpfkkGo6h6Tf8DNQ3q/7h/PyZwdS8ZweARWzy5Fd2O0buORhw9mEPj+RMhiLOxrbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lKszC5nL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4IE10013512
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Hx2GBX9F7NQ8LRgJrlO3MtzBoxHk2zM9UYRVlbcmb0=; b=lKszC5nLb09MCfFy
	9qAXJATNc91t9z5O/MuQrzYAQKzVp+/ETh9Ycr9nQyCqvTraXNxjiKDJtHN5DVA4
	+8VURNjrpCnDtu6r5iwojX/EfAVmZOBXFO/pg6BjrOnYwTWlrs/1AfvpW2Y5fLQc
	dMiEUiUQ9cVUV5GsDmeVRfNTrvEXpOwzmwUXMfZddzEyzMvhiOmPs6Zgjth7PIRi
	Q8UsR/+X1Zwo7107X7hB+QKZ8YzwctDk5yyVUurjtGjBFSLTAja7EaD4tpiAAqtL
	dT3dgCF87O8G6pmKRvmoA22ke0i/JK7jkXyam2ScMjLbo5H0Z6HfmU1Hgs0Jmi5u
	XBgc7g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a5ysys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaeba9abaso7940065a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211517; x=1759816317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Hx2GBX9F7NQ8LRgJrlO3MtzBoxHk2zM9UYRVlbcmb0=;
        b=VPb/jsHIBQDC+n8de/5jfd4QSGXWHBjUEQu9S4ndwhteOPu4yQs3lrhWrW8c9NOHx6
         RUbKq4lCeUBqxx7uiszP27scAMlfe0r/FuALMW4n7X6C6mBaymIOOU1wuw0w0Au5Q76e
         bg9MzS4UofPnDlftLM6cNYHya08Kx+rJZ6lFLwFORMSDQKt3Fw5CzPkV8vACJpwigSu0
         bvL3ogbWZN6WW25q5++Q3s/au7NzjQBMa2p49Kn32VdD26yZ33C69KLGozeWBKOYlNku
         Kvhv6/mm1eDzF/XDK2Smr5Sc39jtnEaSPfmylbfEtNi6nHEGSzsPKOrPvmdnvsnjsKnQ
         nZVw==
X-Forwarded-Encrypted: i=1; AJvYcCXtDSPTDCmpHrbSceWTi6HzsShgjXNL7RBgHzIrGlccsyfet+UHMq7v/kWu0P20vgbvPKS2Y/yxp7IpBzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHW0j1dvvNPNvd55RSkXVWeYt4KuG3zbjuLcJGh3yKQihAWs21
	7pkZZb0joWdcV+l56DorWEumqymysCc80LJLdJWTA+zl8OtxPnJUTBApjTF6/kgkVUBAGJsovf6
	a9CxN/WxYBkUDYjZwOTPZ3qgLDuTfgQLBQ8q5ehizQsVZTE5OoprrYIbBA5krlgKyhCs=
X-Gm-Gg: ASbGncuZtridbrZJH/yOK5tTXaX6ARZWl2Pcr4lus1FwbqY6UwfL5g/ty8YiCmGhfAJ
	1CjXwkhSilBUxQqgNacZTf5hxdVMORRM6Ka+J+En1rfalLdsAbYHS7+KiKOynZkVJhz7ohA0uzE
	QbwGUmMk/3bPlcU3dV2c3zY7E3wVpMiKqYlTSnZu/bJvQ9WY3inyGPqFxkbCk4Vsvl0Mx7TRvTU
	iM+C4qmjgGJLkW4fy19QzDR5HAwi7Zz4n87RClxpIfu4LoBlwuXky1H7lAKgQ0OUsOy4z5QR+lW
	MDSZTSrXzQnvOpYhtVujwHfcPvTbUsz/OSywtxxfBKedzN6b9cPQvpsXASgo0fVRsJt+jw==
X-Received: by 2002:a17:90b:4acc:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-3342a257424mr20752765a91.4.1759211516697;
        Mon, 29 Sep 2025 22:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtRSNc4DK7E+v2shAPlx5lz31OGXX7JSkA3qfyFJ7DSBwKjBFDVh4Ipo5Nf9B3OBI5+WubwA==
X-Received: by 2002:a17:90b:4acc:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-3342a257424mr20752741a91.4.1759211516271;
        Mon, 29 Sep 2025 22:51:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:51:55 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:22 +0530
Subject: [PATCH 17/17] dt-bindings: display/msm/gmu: Add Adreno 840 GMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-17-73530b0700ed@oss.qualcomm.com>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=1801;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=pH7QzqfVd66CUSD6i7hLasiAtJ31uRcCjsRKu6nI+uU=;
 b=PGjrYLobY/yshGg2rKdYdHx3hBf1rR+pcl0fXzC/zlsE0Q4LT53RJdWXkdzvjlbXr1Lox1Rsg
 V1eBxYAHSsbA85oYuhGvB/V8bDV+FCIysw3mOWm7AUUVLL+RIKg+LcJ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68db6ffe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qH2KftFUxmXysmBszocA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: syPpN79HdFV34rFJ7NThTsTFgfQJKK9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX5NRSwtfuQt7k
 6F8sHChhaChktfJaJ9uh4s39C/QvZpdNg1T3xfYN9J52EF7T0E16419EywAJCx1w3mdljYI+n2X
 bgbpn7pr6uKieVp/FLY+4S4TpXl2YzREGQC7mcLCeJmglYFpV9OaZkC3LYMIXsIMcvYXTSbUMql
 50t8335qZWMwBNv+IAiW9jNlT5p3DxHLbH0vq8yUIcuxkZ/8LRV8L6p65eUXSSSZVj5KLnEOHCG
 dPiI4BAmek6nYUPczE0C6vlK+cfdEi+IfsB6KewOsCGOyMs+8kCU1j5E8PCs6EHOBLMeRvxXcel
 ZEU/onwSJ1c/l62m6wzArupz/XMhgAf6uteqVMHxKauBHUYg62PKQsFfbBoi/Bn63PdUcyAUcgX
 SIsbmnXMMfzlJ+9IBNEzoKiVd4Ft7A==
X-Proofpoint-ORIG-GUID: syPpN79HdFV34rFJ7NThTsTFgfQJKK9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

Document Adreno 840 GMU in the dt-binding specification.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index afc1879357440c137cadeb2d9a74ae8459570a25..2ef8fd7e9f529967e28131e1d71a6a6f455c4390 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -21,7 +21,7 @@ properties:
   compatible:
     oneOf:
       - items:
-          - pattern: '^qcom,adreno-gmu-[67][0-9][0-9]\.[0-9]$'
+          - pattern: '^qcom,adreno-gmu-[6-8][0-9][0-9]\.[0-9]$'
           - const: qcom,adreno-gmu
       - items:
           - pattern: '^qcom,adreno-gmu-x[1-9][0-9][0-9]\.[0-9]$'
@@ -299,6 +299,34 @@ allOf:
       required:
         - qcom,qmp
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-840.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+        reg-names:
+          items:
+            - const: gmu
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+
   - if:
       properties:
         compatible:

-- 
2.51.0


