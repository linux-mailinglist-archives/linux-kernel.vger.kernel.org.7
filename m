Return-Path: <linux-kernel+bounces-831536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB015B9CF11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FCA328053
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0412DCC05;
	Thu, 25 Sep 2025 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkMLuuqs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8362DC342
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761562; cv=none; b=qaJPkFH/RJpdL/ttGx4L8WgGGIndfyD1jYRYL62kD5B8LtszunNkzZpccjYPlLUFxJ8wEiehbeYAgFCNpykWGE/SjRf1GpAjgFYsz/TKYkjScAf89Vtq9HM6ySqe5pqnjbY3eZsYZxnTMCspktIRf+A3+eV+WJ80KpCNpF8H9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761562; c=relaxed/simple;
	bh=y84fa6fvuCZpJxjEsWR6XfroWoXIZOXTyVARiLBoUh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AEwL34B1hiDWV5mHC3jVJbcDPIY6MSPj3b0dPo5H5jgtyIIlBI1W9rprAKvnj+x0ez3FCkJu4C+KdOW+UI/yq4d3iMH9NAAormeyNhQFbsLbDYENVD3QLpWOu0VAkb0L68IHKWloVvVGUP3ui/Ij6nYeknDGC7DQgq6VIFSkOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkMLuuqs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONHgOt027912
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g6hGIMMv3wb
	uPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=; b=QkMLuuqsFM29KbrDAK/a+azVlvh
	YnT80zPogffOPos/f7UhMCxbu8q8dg6fw2va0FA4lDlJNTygR1GmoLIiI/gNjYAU
	RRyFkrHEm8JmqfN7RBUHDFT/R2c26xLpD1lGNmAsdM5gQZ+LTCSGl4ZbrktblIAl
	hlbaNy2aPmXqx0lf3jd22IyFnuSzga2dTFEn8vxDFp5SrllI6T/IMrSAAGRr7d0L
	wgFo9Ynh0Yyd6zU6jBtGT5qLUFawM9jb7Tm5RA957Io1oPcRulDaxeKdj+O3iKHu
	iqzoBu69UWqPxV/xIRGnyEjVTQNpW+RAFi/AsEbSnS1Nsv+o/DCXkvThaPw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxjnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so640544a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761558; x=1759366358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6hGIMMv3wbuPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=;
        b=NYplGrKLbMsNF2Ar+TZd7mRF5gvEErkbCdAmOJ8XOESm5m+7cqXlwJDeFeYwwJmv49
         Ow9/EeGopXeCfFLjFaMykTRX0K60Blj+5cYd7AUWSEBOMsao1NMAlQLXyz9sgz0StAqB
         1LXZ7qaSa7MlMNNN7wy/E+Sd1zf9lsgX7ZJD+a8n1+PCZfB2vz4LuowBTACdhRfKd/2G
         hS5hKECszpr/Qn4tLNHszzvdCB2KlxKcJ9wil5wkmbZqa5sBQtLp8WwW3C9REd62sy1L
         P/Ls7/YXun9/2dI7bBhyX1I6JjmjoB5U6+EoVuugrBVwSx5QNzo9xHQQGvo6MQ9Wcj+9
         2vmA==
X-Forwarded-Encrypted: i=1; AJvYcCX56v721SoFoWOzf8hJXP6eNTgJHeucwpb4vQIsychVaTX+ex5G7kevX/SoY64zyYsaXgcKshfLjMmTbRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4f8TzXJPvbQWSwXE27nh7Mx9qfwrAAYOv1s4pCKTI3k1cRU0
	wCIY1HMUCzu2U/blVyxYiMfuhl1C3D6JCwz9BtAbfvdcI+qUuojbpADNbuxw7kTFoNeLWefMV6S
	Gb0VTXi9affVv7CbAHxZhVq/XBYA3zsnmeea7SQE9lPWqywHFPOCrB//Tivw1oma9DeI=
X-Gm-Gg: ASbGnctE0HN89MwYvXEuBSbAWWauCUL2qwTp2R1SNYtFnVYEY56gvKScBfB1iJgTg4X
	ojBVwFt+8o4HKs6lzHeiLd+B6cOtGIqGoDeniDy4Vsnr5OsTH1AOTzTGCwAe88wWc9Jg+bmOdwI
	CWkKFAkm6JCReMoQmjXK+QT4Dl4ONxR9q0y6BCbIfF4dvDf+LEm7Njm3+vd130haVI5X8LpnvVI
	CglsL0mJc3ekCn9S2BYTRzV7JK6PVxGC/CPs/2QShcz3/rhZVAdZvelrb4WtkdChFgHWME05hcN
	fC5vyrvb/AHtbF9GekHcywtyi9fvNACIlgi77NYXKYYVk3G8Pf3dkdK+eSBzaHoh1LkioXOFSVS
	27N9qLXe7mY0UMt6b
X-Received: by 2002:a17:902:e84f:b0:26a:8171:dafa with SMTP id d9443c01a7336-27ed49df04amr17503545ad.21.1758761558241;
        Wed, 24 Sep 2025 17:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvOp7wNsS51SpI6EOA2HUs8VBQEy/ZyUwfDL4ym4Id0/ZhPRPzk6mTrQR2czfWa7itiQZ0Q==
X-Received: by 2002:a17:902:e84f:b0:26a:8171:dafa with SMTP id d9443c01a7336-27ed49df04amr17503285ad.21.1758761557758;
        Wed, 24 Sep 2025 17:52:37 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac27d4sm5238105ad.135.2025.09.24.17.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:52:37 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v2 04/10] dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
Date: Wed, 24 Sep 2025 17:52:22 -0700
Message-Id: <20250925005228.4035927-5-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d49257 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JYTQWVwI1XGucIoeipMA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: T2dn-sfnYXSm76Y_Pu4hue6FdjLDsRMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX4MB9E/R4BG74
 mVgZtTZez1hQczQ+Ae+5RHaPfn5LVllky+Wa9ZVcMtrwI1dwApouSux5JvqPbQYw1O3aCe9erig
 9VHXKNyQC4OHOJgACbaEKWt5Bf7vfiqqFyOdkVrukKwkrVydS2ik1eeVKSMtXkAPp6f9hDvU9qA
 bXx+RHsaKRvutigcAy79iyA2Qx6FuTL78N0r8llVeUhfuyFyLPkGFRowyag5smOdKz/dET5VlwR
 r9gipMT63oLElPKRxURfw1SfYXoYKtVCDF13tXdL7RpE6V28GtxhPqUeKBHG93iuCBm6Wq/6atm
 22XLhfzrI9w4eqm+YsQbw1ehJdQygBBqPl08xWfPf2HARnd6IwpLa63FoJ2wTUHa4GoRVMjFgeG
 X1exms2r
X-Proofpoint-GUID: T2dn-sfnYXSm76Y_Pu4hue6FdjLDsRMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Introduce the compatible definition for Glymur QCOM SNPS DWC3.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/usb/qcom,snps-dwc3.yaml          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..eaa0067ee313 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -24,6 +24,8 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-dwc3
+          - qcom,glymur-dwc3-mp
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
           - qcom,ipq5332-dwc3
@@ -386,6 +388,28 @@ allOf:
             - const: mock_utmi
             - const: xo
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-dwc3
+              - qcom,glymur-dwc3-mp
+
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: noc_aggr_north
+            - const: noc_aggr_south
+
   - if:
       properties:
         compatible:
@@ -455,6 +479,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-dwc3
               - qcom,milos-dwc3
               - qcom,x1e80100-dwc3
     then:
@@ -518,6 +543,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-dwc3-mp
               - qcom,sc8180x-dwc3-mp
               - qcom,x1e80100-dwc3-mp
     then:

