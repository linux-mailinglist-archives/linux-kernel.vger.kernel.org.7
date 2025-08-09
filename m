Return-Path: <linux-kernel+bounces-761026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CEAB1F35A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B6E18C6463
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFD27F4CE;
	Sat,  9 Aug 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nMbhVHQh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B832797BD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728444; cv=none; b=rE2tSTE4MZ5VpIVnPxtGWlwE9E7qKkdtNyLEnjjpSmBdUuktYsuis/M8Lx615ZZi1lgMGoY6xFJbNOEbaEWZBPlew9mqNVoX/uaBHRAKv1NGSr/Qsn0ZndOlBq+4ot36qsH8J5BdliMQAtUrFgE2TaefNB6i/xYfqkkECHsbdqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728444; c=relaxed/simple;
	bh=d48/C5oLUka5zAtODxq9StYs/l7s2f/Mtt/RsfxEURo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ommz5MQByH+s8NE/Z0bvENiVFNH7tTOhLxj7DIaXg9KDQhSQQVTJN6gplcEMeXqbFYkUdnhHfkJ+Z68piqvjBzPtx5ZjN7mmQZRIcD9NNFZo/s9ntFcBTYG18CSPx+y7A9q0f1UOYbwj36Zbm6lBOVNFYawJhfxrAhjHkB4OsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nMbhVHQh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793V7SP002617
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 08:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyXYRLJzDKBZ11ZVF0ZtjEW2r8lFG8npoaFqtCmnxaw=; b=nMbhVHQhq8jI5CRp
	7yUt+mqcmsSLef65JrnmWBNO7DIIe/iXwpsU2bd7plPrO051N3wO1Fy4g1Y9i237
	V16xl/4kmgtbX4XZu/dhXavIt6WvbQirQ4/tMXuIjlMb5IHGUUZg8uSnOI+M3fec
	OT/9rjC1sfDbC93NmggK2905T0GnLhcfHK0ESMCSTfWHafIcLdCIx8gJiLFjOb4Q
	ogfOms8YUwjJCVs+fp4TJ0x5JNrQiFAdSSyP/pKj96CIufCxkDWvlKI1g2PIiVWX
	RCz41py0D8qwXDDocQO3oog/7OoDDpjNWMbZ8ejnksDNlqIT6PNh8GQoUsLwQhap
	5KUVPg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sgetv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:34:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af210c5cf3so110713921cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 01:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754728440; x=1755333240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyXYRLJzDKBZ11ZVF0ZtjEW2r8lFG8npoaFqtCmnxaw=;
        b=kNWWo+PxzYRIOdbxkBc79z/o/Tg0ECwYnnzUpKxVwJoZeB/3Ji1DzagQxdw3N481/H
         33j3e5oBskB/S2BT8wQyX4S1Ks6fVm9UInMf7CmMkoSxIS2qAUaZ8c1wfRd5Tc9fEzqk
         S9vaEIAnKH3Iq4Kch5fWkU6G25ZzeGY2hlecHfKBBeUxWdawfbkrEOWHy4B54YaOBRJx
         jhjCc0ouqfoKTVJkBXrYXfRIZsaeFja4q92oHXBTqnJ+pgnb+iPieg8nAgV1RA5DJcYa
         1YL5Pz0v50fq04eNsm/17S9MJoe7vi2hoMeaysV0MfuR4+5oD/oaUwFI/fUVn7zbmO3O
         CvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI7ML3ZI2/Jrus5pANdtLmFeoIRcVn6+LUMFoKI0JBAKiQt2RLU9N/ai9N9W15OEirGRMQllLbn7J0YuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9m8RFe8nHuQ2rC+oaOI0QzIOpj1q7gNHWbiN8UTR2CQdHAob0
	v9Fy30Joojq2qve0X6k8jO7jCcprvtWi9q7ASSkKKNKxw9Tnd8ieFwmCf98fQwkNUYK9xQRED2v
	XqJm9ZhBN/1q9rsKoYhVYvgl4nlk+B9BT+fd5KppIM6D8VTAETjih0lW7r1MI36BnGnY=
X-Gm-Gg: ASbGnct5HEvx0jMZ4exnzu+Mw0tyOClsAqPGfIyXsEKC3u0LBFaCqgEkfYWfmZplI+C
	qF1OdHh1Ap2jT/qZFOzkbsAJ0pHNunLp2+SuRmfJ2AYB5EH/ak2+mREKAH5XdNlx9t6c81AvYSf
	0/V2TFcz6tbyx3mfAdE5VqvU7zJG2rUdGI2QFQ75xT41vEHogBdby6DKteSHALN+pUwoD76R/gw
	rtmdMpcSD8Tn64jYkBNiHK98rsOW2H7SS+84OoLZl+f6Y33PzN+Vri+RdJy2UNRrf66Wg/27jhp
	SEr7zghZeC2jgRFwKG2gkecwq1h0mTgHxQsJIzZ35FJDbmoSs8D7YrUyq7E2aSfHnHomNXEicGp
	UwiYefD4vcpYdwwun4feIwNr+zCZ/3a+movK9PQ/PvvUKu0b4yfLo
X-Received: by 2002:ac8:574c:0:b0:4b0:7b0a:2a48 with SMTP id d75a77b69052e-4b0aee54906mr100495881cf.56.1754728440501;
        Sat, 09 Aug 2025 01:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/NnXSPgAnPNiZQ/pbt34Ubwax9v+///1C+g1FSm/0KIGAfDfUO5MlDxi/4Fchku48X0j1A==
X-Received: by 2002:ac8:574c:0:b0:4b0:7b0a:2a48 with SMTP id d75a77b69052e-4b0aee54906mr100495691cf.56.1754728440012;
        Sat, 09 Aug 2025 01:34:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99078sm3268166e87.102.2025.08.09.01.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:33:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 11:33:52 +0300
Subject: [PATCH v4 1/6] dt-bindings: display/msm: dp-controller: allow eDP
 for SA8775P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-dp_mst_bindings-v4-1-bb316e638284@oss.qualcomm.com>
References: <20250809-dp_mst_bindings-v4-0-bb316e638284@oss.qualcomm.com>
In-Reply-To: <20250809-dp_mst_bindings-v4-0-bb316e638284@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBolwfzl5BuaDrbT6HWXVPwy0irjYqtk03FHP9tH
 ozEaGP1IfSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJcH8wAKCRCLPIo+Aiko
 1YtGB/wO+YGdbSiT/sAaWpH4F7MPaKpOP6u5ombiMKD1jY1fO0NYnKDviwkkqiOPLWRRVrFEmRE
 +Piqxk9P0ZAslUYqub7LSouPvPX/tZFgd6fScO2IF3Qcco4tmLdBxCgmKpWqtqmy4ALY2aYg63G
 nytaNqcw0Cdz2zBz0VNm8bwKZofITv0fyMcJrfQghHBzITnRW74DTBJgWg89tHY69TMRzRzsRMT
 B29nt87RjXF9BbuWLzKdKogbhVGl2xrE2xk/jhUcPYtH/heblHz74nSPSAnC70RJ8Vi5BInpJzy
 ScdtcH3nxrSSZEXrJ48+NCv0THnInCInWC8xqVYPfO3t+0kP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689707f9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iBDq5nSyD7x731avtJAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: JzLbFd-GayjOQtzRXsSKcvqbdywl-nnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX2TY6Gg1DRqKv
 0tneeHWywGEeDQN4sM3Rhwm6u/kCJGs1qsLtD0J2AMVrDhhov3KF7M3zU4p/Db+TacvNm/xqbja
 rPj8rlSDUaLNfzBv1/JfhrpJIueNGL7GpNVfUdhXYl41hRdD/TPpSDfwpAAVozHMw15OBeOQ/1c
 nQYPq+Qo2Uj8FuoAgVvQ80ytmYKSn8JwFV1Gj0RAcuKNMZG0COQ6HC9WN7Hc1dm5nyNCVVL4Y4/
 vIiXvt5EU2ZOsEkySJWkPk1HOeWKmxRbs+YlL5g2yaF2REpqaj4dWi8aKOA6hiQQrp3nwS51M0+
 BNDaxfR8HLGzkk2SNGvJ8Gyrtv3WzVzzXZZDnrAyNYQULGD74kiv9z15br7e4ctTgPHCZRWgtOa
 1mQeBYuj
X-Proofpoint-GUID: JzLbFd-GayjOQtzRXsSKcvqbdywl-nnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

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


