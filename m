Return-Path: <linux-kernel+bounces-761032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7F6B1F36E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD9E1884412
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DFC227563;
	Sat,  9 Aug 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aK8mAb7w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5C22172D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728619; cv=none; b=msUD8+mEBmeBGQWAN+jA2070MtpQwe/wmVq+FKKjv4Hyo1+g14H++wBGbXi6O90iCaHZEH/snPDqDlFaSidahdL8aoQMmVGEzsHizSi5mZrmosyynZbMaWiz1ymbvfHffU4VWE+xnIw+okiscy71IbvkCVVU682ofFBc52a5BAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728619; c=relaxed/simple;
	bh=KmUlDlykqRmfS/c3OkAxh7AJ+0CRPOU7eFP0ludcvrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E+kOkhwM0jx+6wCMd50N3rEGdzb6xNT2BsfZm76Gk36sMz6nWjpbbPznv3a3T2HgV6KnlypTftVQ/18zN3Gi5RYDUjefTGDU0bteMPdLeB6DrUQ78F9EAXonwvnjSswz4cDTl9t9fJrMLQ2ykDfAoRFz5P6UH/PkkOv+rCDCBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aK8mAb7w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5796U5uO010000
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 08:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Vbhk6QCT3EVReeZaEWJCjX
	Dtjty/QxM/QqF3JsKZ/bQ=; b=aK8mAb7wHR5CDudbNk+2qoh4ORGcuSpp7chNfB
	6++T8nTbtFwp61xD+vH4dam9eveMkdL/wdrfiu4W5YiQHRFYEpKGs4UoM+yLMSvL
	EC+Hpbiz43YJ+AqR4FJPLA5uRTECXQZsAjwPJbF0SikwJ3jXa31WqoOsZ5UztfeM
	T70FEGLOcgEOgWfh7eRTDHv/tuyq2NHiKScvNzd85nOGWNIi47eFHzUORm3qtysE
	JFyEgxqX+wXktzaKCD10gWUrzhu3CdS5MldCCYNjdak24e4JzU3/V+m/7g9vUx01
	l07HrL5srnGtmENYNAPKTJD1Vc5QHcPcboGk8jKHA17Od8qA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6raxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:36:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06228c36aso38590561cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 01:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754728617; x=1755333417;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vbhk6QCT3EVReeZaEWJCjXDtjty/QxM/QqF3JsKZ/bQ=;
        b=oRH/5PXsA04d/6AzM9HYlAiniuor8pbb/YybtkJlAod9zU9f5+Z3tPEB/m/Ea/QnhC
         uyy/is4Tmk6LpMqfuug/+oK8xYxC3lIubJ/0kHPUcMf3ABxk8DobEj5IMEkqU7KsauDh
         Cwxe5ow29V23/En/S6pHO83zK7N+jrk3NCnBptmDY452VbbQN0v7M69MqlFBzkFTmdKE
         a7F3P8y4iI7oPfsnTXFMQpPwUmxCWnE3P8OUkKf3et17H20RKOnYVm40EcOp8Qtp0MxI
         FWpGwfflFOiazygK5UtwKbBPKX8fSw3Ux1cNCnX/JxiaPrz4F+kyGEkuO6ecajKV6lTg
         66PA==
X-Forwarded-Encrypted: i=1; AJvYcCWP/uHpZ3rI80R8z5aZOpQ4fp4vM8Z2ex6NnbouipHwwQfjvcAQdpNLs3Okm/wb860loB/Ro5167nrmOFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1b3gV8Wg/PAMXJ0yz1d5CN28DGOP/WZiW64P3wasJv/t2bca
	cJJkPxEoCYVgj83JVpB1xSXmLKmAVskkYJeGRRRaLhZAhsEIWl/G89znF/YIgTDuA+EquHiEmvO
	Txh+Wg3D6sXGB0mZI6y/vsn2rpQ11mBEXhi82wYwOMBLoZxl98SLDetc0xdXgse0sUtU=
X-Gm-Gg: ASbGncvbuX3B8P1TCVouOOOSEjQAV1zkVojWC+OaUI6QJgptg4dWbQRdaiY9zAEPJEB
	4BMzVkTbLsF00S0uuvTuiyrSpTGzL7Ty3UYciwE7Fqc2c7yFJoudCR/JUiqYMRSjQkEKELnJmb3
	+8iTEml39g+t+sURXMrxn6InBcfkMJgtwBEP6PUfcXZ801QY6lsZVOEz2UiCFEDFkd838+zDlzD
	WY+8PN2Vw4yl+44Qfm3DV51n6bfdrhnlbJlwsIFlNtE/NpmkuZN6SK1y1dg1t57iwGK9fccXuDD
	o8vGHv3xkzYuMT8IQFcx7Vu06HHNxZdEp8T1MDbExE1KZSspeaOY2oQw0d0dPQqanXIgUxf2Ewo
	pb7zTjUEQ3rNCqDYjRA06TQYCTxXSN7pd7EptDirdQ4EzPIr4sOMT
X-Received: by 2002:a05:622a:2446:b0:4b0:7ecf:beda with SMTP id d75a77b69052e-4b0aed0bff1mr90397821cf.9.1754728616703;
        Sat, 09 Aug 2025 01:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH37kRnw8/1Yvy8Ct0TseBki1Zc9SOjiU5tdXrLe87OhkeI9dMLexzVEv+ZZeRaP96/LWT6Gw==
X-Received: by 2002:a05:622a:2446:b0:4b0:7ecf:beda with SMTP id d75a77b69052e-4b0aed0bff1mr90397511cf.9.1754728616224;
        Sat, 09 Aug 2025 01:36:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88db2214sm3239974e87.177.2025.08.09.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:36:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 11:36:54 +0300
Subject: [PATCH] dt-bindings: display/msm: qcom,mdp5: drop lut clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-msm8976-no-lut-v1-1-f5479d110297@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKUIl2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNL3dziXAtLczPdvHzdnNISXZMkU0MDg6TktCRjUyWgpoKi1LTMCrC
 B0bG1tQBoHPxKYAAAAA==
X-Change-ID: 20250809-msm8976-no-lut-4b5100bcfb35
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=KmUlDlykqRmfS/c3OkAxh7AJ+0CRPOU7eFP0ludcvrM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8Z0jmVKKiy51Y/+3+p5PqP0fs3XmjAmj0vMF8rL7+qbz
 9pwz+dNJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmwt7I/lc0OcDbbM3ekOis
 iwVbqiwWv17z0pxlS2uU0aXM3CsaynEnRPmeb52nF5CvlMBhGOc+92HM1YO1LOrxojddP8zyZRP
 5zHk2sFz3352j1zasC+o/syEq5We3aOYH9cKSCU+5LnV0ae26m/r1Gp/4Djul+zKnijef6Xt56U
 BCzOwJJuueexW0nir2Csl1MQuQFDc93Nt8nmch890Sh4OmlWwWQi1Mu9cw/jBfKjb7y7H57yfPU
 sqwC7/WWmZYwnjp8IHpC+c92KXH2Tox8bggZ5zCYpZnis0HXAqSLhYf+8J2KyHWfnnvXYu/b1s6
 ZO/0Gr+xMvVSfXdl4dTAhx+mz1JO/wa0sWVamsGVsr2yAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX3ZHyNmnnI3gi
 gxnGlZ24WAGmj1176nTYtYHOIjiqT5zXEAxuyyQV7uMwQVjzOyT5vA0gpCHfyfmIIiY6mPrLOaE
 ty4964gThOt8VkMn1BBlKKTgvJXvUfhfKy/40Pmdcehs0hA8B/LCpC3G1tiG+HfzxodzO23Jb4k
 8XqBcRz4IbV7C3yHrdR5CSQjSxKWy2ou3Y9IqkCn65U04IO+o5yIZlzSSYOS4DE2+pCOWizsr9y
 L9+1X2/N/zoRj/tKsLB1qGJxqk2P8u8I+5AVxgDnmOzooL+0MkCcfZXAMFLayVEFmSm6xM5Jlo5
 TMvGbGtHSlOXXXwizg4sJ4nftNtId3KikOyNdxkzex2v9xxHTCL9RIoz4+k+5mUHKa2geXAi4Sa
 v5+95Hnt
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=689708a9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=-Y5st2MN6ViVPFRs--AA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: va8aHksLNfwlymNjvt4teJk57azPhTjl
X-Proofpoint-ORIG-GUID: va8aHksLNfwlymNjvt4teJk57azPhTjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028

None of MDP5 platforms have a LUT clock on the display-controller, it
was added by the mistake. Drop it, fixing DT warnings on MSM8976 /
MSM8956 platforms. Technically it's an ABI break, but no other platforms
are affected.

Fixes: 385c8ac763b3 ("dt-bindings: display/msm: convert MDP5 schema to YAML format")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
index e153f8d26e7aaec64656570bbec700794651c10f..2735c78b0b67af8c004350f40ca9700c563b75f8 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
@@ -60,7 +60,6 @@ properties:
           - const: bus
           - const: core
           - const: vsync
-          - const: lut
           - const: tbu
           - const: tbu_rt
         # MSM8996 has additional iommu clock

---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250809-msm8976-no-lut-4b5100bcfb35

Best regards,
-- 
With best wishes
Dmitry


