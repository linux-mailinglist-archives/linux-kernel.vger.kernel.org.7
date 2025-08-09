Return-Path: <linux-kernel+bounces-761039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD51B1F39A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EE91C22303
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A0F242D78;
	Sat,  9 Aug 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fn5mIsbW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380E27FB2E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754730989; cv=none; b=Dmm57OaDRdjNjEK5JUSxnbvEmNPpCdXLRhC9mei9ji7vt04IuiqCEVqXTIieCjGWiSB0ZgD6lR1ZmE6cEJBMlFORYTdQyuV14wnDLMfLLz+f1YzpzSaSubOtokbgv3XH30O7yE+oyCr1I0XZ+iFaHqYr5LOAq3fdHYNvokbRggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754730989; c=relaxed/simple;
	bh=d48/C5oLUka5zAtODxq9StYs/l7s2f/Mtt/RsfxEURo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D81IJY6c76nkbprbfbojmiEH/CMV41vbq3gq2WD/+Avt6WKR5BrW7nTlLvcByR+NKmqDWkIgPltnGSyUzNF60Hs2uUrgoXDVuZBwflOcfiGM+EnrvbSb0aFmODz8sr6yWpcXYOOa1upj+/W0M3lKR8biSxRBWu9V6+3n+xgkjaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fn5mIsbW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793ULOO003015
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 09:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyXYRLJzDKBZ11ZVF0ZtjEW2r8lFG8npoaFqtCmnxaw=; b=fn5mIsbWRWgBpZsO
	OKqATLLR+TyK436b2ljC/4Azo3Ti+ij5pua8ZG7WMIft2ansSCoFgE0uVohJjzfi
	tldH5aIp6V+tnFu9mX5+m+9MVAcPzVkgsLiyG7NOUyYYDtSNiekF9x8vR4ua4tcV
	KXxnvq6X18BySJH6+OWKzI847owOFkOg0fuY0ocnF+Kdk9HPwclLNv8rVfEAJe+V
	sNkDFRMZtOMTw2ew9szwV867tB5tddd8B142lSYiIqknENzWi8b/26Bv0UPiO+G6
	cRj4P/mcRyfywwVIf2P0tddrLFg2ak5zg9IjhFH//f9MMS7D3IVckZMJlKyTGLOR
	QATNxw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dwb70fp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:16:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b067bc2884so30155611cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754730986; x=1755335786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyXYRLJzDKBZ11ZVF0ZtjEW2r8lFG8npoaFqtCmnxaw=;
        b=huoPJNvOAn41gxWotDtbGvmaiSKkDWbEcsCf/Ga/AxGVdsCF3pkPjKK2viNFeffV89
         bU/rokoV6aO6iEOpzKNLmHgvPeYD9J9hUyhBRHfWBUcXUQGIjSM/vpS7oxpz/ndQaTAT
         1WhI9NBO7IjlzeqwKpPZ5ycFPZg/I6ZCpipRujOzDSjhq6uuRfoloJTWh3dIpTRVIRvS
         DsCB1++cVs1253qba7E4QEBrTeEkgezbzOu0r96Eq5mrbouz0LKMhpYs6FdLJ6AenyA1
         xPhzR3bogfCKCUNc25PXGEKUp7OE4rQ2iAfos91znPQexX17lBFasThT70++HsIFoQG4
         bvPw==
X-Forwarded-Encrypted: i=1; AJvYcCUzL6hdkpCHoIQjV4IpV0FVhs2XnpYjXmZ8ZPPRgQQB00i9Y38pK7ACKicXYMW2QUAu7JFSeBHNqnC/E1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHty6eguosEdVOsV/i5hQnHzyIUadYlX51I9EbHWopDIr/h1ez
	GmdZnzO++7gG/5KB61r+pgqPKunUW97HqOpuZvdAWGmfVNbJxTKHpGqoevj68yH6PoLhEWbuDiD
	nBa07IbsdhFEtjhasVrAj9b6Mqs4rGw3BB+9VXgwUmw69j3GvF3mq/iSrnN1ZPx4f6Dw=
X-Gm-Gg: ASbGncv2p/Oo75Dq9o89ZFcza/Dde/gtjdNs1As4XUaIlJdUcT/aC6V3WeqlvZD+VME
	PhrghqCB8jsIKGN5xJYGGy3X+++siZrZABv8leLn7H6wCrrE+VgHdCjuao/2rVH3XFljS+60E5B
	ExPtOYDaLegGQ3c1SAcl0K4g23JiDtPTCnrqzZ2VaGGIsI6KEdVw1Bquw50TNXoRu8cBPXfJDjA
	WdllGKkfv/YKieNnVeYK+tkopzklRS7yog77pgB270xDlj8Vfl2bF3knXjUfH0H5IZbG130msmk
	rxzhYLnxX1Ydx3ZqQP138cFC90JqwbHrwIL6V3xUKe9vR5zLITfohDp40jx0vnzlaM368zh/gzl
	EXEpLAapq6hfHuOxUIzwDGbUr0V3Q9Ab8in8btV1tkDXrHXSsWicB
X-Received: by 2002:a05:622a:5a0d:b0:4af:21e5:3e7d with SMTP id d75a77b69052e-4b0aedd7c35mr96176531cf.38.1754730985800;
        Sat, 09 Aug 2025 02:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbn+j3VRJGx8/ht60WZkPpDMpeHGZ9tFQkrI4f2soZwGGzxl43DRhjFw07MRX4FV4PJWf9Dw==
X-Received: by 2002:a05:622a:5a0d:b0:4af:21e5:3e7d with SMTP id d75a77b69052e-4b0aedd7c35mr96176301cf.38.1754730985409;
        Sat, 09 Aug 2025 02:16:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm3361989e87.30.2025.08.09.02.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:16:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 12:16:15 +0300
Subject: [PATCH v5 1/6] dt-bindings: display/msm: dp-controller: allow eDP
 for SA8775P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-dp_mst_bindings-v5-1-b185fe574f38@oss.qualcomm.com>
References: <20250809-dp_mst_bindings-v5-0-b185fe574f38@oss.qualcomm.com>
In-Reply-To: <20250809-dp_mst_bindings-v5-0-b185fe574f38@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=d48/C5oLUka5zAtODxq9StYs/l7s2f/Mtt/RsfxEURo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBolxHip3RY4bSc97JuF5htWVTzp4BE/6CgqBmbf
 WBSRHZgOw2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJcR4gAKCRCLPIo+Aiko
 1eVWCACl+QuJRQmjzmthSRPrrgvGLOXJ0Wa0bo/mvMwIgh5UXfoECTWXn9ZzRLyWrYMD+XY8A7o
 AGCR5SPempa60En1FGWeFtbIaMFOGlIhQopFJyiTT4TahDDXRQDILESmOiwsII+RNPJP3di5he7
 PhDCM2QtLByA2/sORcyeoOuVro0Kt5f7q810eEVE93KCtIx3HR+LKc0/mY5XvvQIAYYDz7qjH49
 vzqc82tcSqCFl044wQAg/459esVRX2YaOsFp0PY7eton9lIvTxxw2c8rIZYY4XFI1kijb8xQ6/V
 ZjEEiZ8EfsTji9pv6/+ZQ8SYBB/+Ln9zhkYXj6it7Oefv+LH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=K6oiHzWI c=1 sm=1 tr=0 ts=689711ea cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iBDq5nSyD7x731avtJAA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: MiSVWiNCAj_Xt5uLrCyXHbVNarZvFvvC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxMyBTYWx0ZWRfX6YxZWdOQG++1
 mcAq51f1Qo8dVtq5plaPErWwmxSM7QyVpvzAmi0yvXbShUJn6DcNFwKdI0n+h4/wMdy1g3sMGYV
 umNvlMETAQhWx4JWv782h+W7ofBkh1xsYdrxEYQ1o/uvaABjufxL7WhNTYy/1qnwx/YUqboQfav
 89urpXaKX/J7rU1uyd+cAKQvK5CtW8zSnjih72vndRlMbAnHY7mgnPaCKEdqhgTlYPvxvczuZnn
 TvJcKMZ5VYttpK8U1C23rI1rg4LQ3Kna4IgcQ/XXVeQ30kc7f00h62SPIl4y+3SfdNv0tip9kdd
 T2NOVzmJRYrso7ETTfQfZzOm16klBgV21laUzktRtlEZOMfWDQOLu1F8WKtgI3biSv8BLKctrfu
 HUEBDICM
X-Proofpoint-ORIG-GUID: MiSVWiNCAj_Xt5uLrCyXHbVNarZvFvvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090013

On Qualcomm SA8775P the DP controller might be driving either a
DisplayPort or a eDP sink (depending on the PHY that is tied to the
controller). Reflect that in the schema.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml        | 25 ++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 9923b065323bbab99de5079b674a0317f3074373..aed3bafa67e3c24d2a876acd29660378b367603a 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -174,12 +174,25 @@ allOf:
       properties:
         "#sound-dai-cells": false
     else:
-      properties:
-        aux-bus: false
-        reg:
-          minItems: 5
-      required:
-        - "#sound-dai-cells"
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,sa8775p-dp
+      then:
+        oneOf:
+          - required:
+              - aux-bus
+          - required:
+              - "#sound-dai-cells"
+      else:
+        properties:
+          aux-bus: false
+          reg:
+            minItems: 5
+        required:
+          - "#sound-dai-cells"
 
 additionalProperties: false
 

-- 
2.39.5


