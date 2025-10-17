Return-Path: <linux-kernel+bounces-857089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1CBE5E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E8274F163C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DD21B9D2;
	Fri, 17 Oct 2025 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gx+j0mSd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD819E99F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661040; cv=none; b=BZdfxsMH263KmASum5FmOpBBvtKGTbshrj0fpj+pAOUHKfpn0/Lnqnegx7VecLH0dyLhb6A0qVPbCI8jiNXZZKfPrG2SQb7ab1qok636k9sF5qwg6VnQOfuvgRp6URaCC5gbEpwWcgNwjxQqgwjzoYK3qFgnIZRnl3jgv/grtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661040; c=relaxed/simple;
	bh=5hM3y6cna0ixKs77V59yacjoC4eomSveY+2fA2Kl2TY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGGirMmEbjZU7ScrxEbP0EvwrhVnsE2w0doCfhUUr60N8764LKg1kxQbcTBscSDtVpGAAU0tZdUFgOsHxfZH67SsnZbqqdSw9i5/2AbMvf0DEn4aNpMRGDgeqVhsF3QGtLdkS4AHkn6yCbiJNLWcMf44Nlx7acCek2BRT58X/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gx+j0mSd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLbvx022391
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=oKGF+83l4Kq
	SVQrFOlbLJspJHtMRAO6JREgm1hfKmrs=; b=Gx+j0mSdqlKXPuREooZ8U037p+x
	zhGevibx2xisununmxuU7zte0a2wfq3W1/RQQjXZtO6egoWvjXY/Qdef3IB6t622
	Xs1fhOsyIEk7i1xdS9gYQhUa44dZO/Zl4xZgBInjUVVX0DK4Wd22jLPvXBwvqBgx
	G94G0azbBgDhJSMrw9yL4myoOCEACjlcDHzfh6yS4y1ES0YgO6vads49donOFuXx
	K6nLBotw5zSQwlN+zHfme07rbb/PwQzSCHalovjVYHCKQhjpS/kVrP1Kmv6jMePg
	xHT3Dbbbd5mSGfI2A3xudYBSaddSepJ7+F9qbFa2A5K/5foOhIChBBhPl8g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtf7er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:38 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780f9cc532bso1551069b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760661037; x=1761265837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKGF+83l4KqSVQrFOlbLJspJHtMRAO6JREgm1hfKmrs=;
        b=U7ylGruWnxxZokF6AcwP4+8lmGsILnpuarYUx4LB5c8fEU63+cq8u7vpIdjxTW+bh3
         8KLUGnx39Vi7Z/3c/ulZLlcHNK4itKE8s/GyrD2VOVnal7O24ny/dKx4c6EymT9fkHSf
         jnpJh/c7z8VM8/vepgmZKyGfckUPEdYcdIu9cg9F/eiO+utfgFk2UTkECsvlfd826zNu
         4JYvtob/Dq7p2ATp4exxQVOT1eeCmnOxzcj88dW+4W4EtU1uiVEUWXoRt4kcP+uDLIBU
         BONjO6SEujZLEToDitMyFLsRHCVg/QnmJie7Mw9CF4v6uRI4mxF2p5ZdYMp0Zwn20svH
         zMNw==
X-Forwarded-Encrypted: i=1; AJvYcCWUX8Ha08N6CRU2qse3REIklv2icDSuPZDSHwO44nPjeJCqTWv4qqSUZvewDOoMbPwmsmPK+P+zvsGeKgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8zTkBQc5Cf9Cn3k8nB6Z9mkaSlEwUXZRC8bKcTbPXTyXID8q
	AR/zGZNssV0mPOguaefXFPxjHaoA9m8J5GRjNAHa5MwvJA3LRsfKpZhrmiHsp1jfi3F56/lxxYF
	5SVvFekIrZr+sa0cQU7WAIDGWouqNj+vjj84noktov82R/fEZEowiEcCsaJX1UxVdjaxW7GQINm
	s=
X-Gm-Gg: ASbGncszX4odwE+vxEF4Lu1L1w+ijeRN17gHkxLWgPs6vAgzil/xyURZPhWef2pNoHu
	IsgfSB9PkhPdkexo5tud5CSrQH0gSziD4qlOyrYnT00Gp3oe/qgPFvOkqEydXgwRlgObPGH09Kt
	AhcLhvLirGBPPtnptzAD+PANI4nQh6r1L2/ZGAgfJlmimhPxihwEDvT5qteUFxPIQExEyCza7JC
	wnCKzwM/n4HHv2jZNyGLtDoiL5rXhju+JKY/flbKMOhMK52PkpU1SiSePC2ejBY3WpGfxXejV6f
	dJhuZrkA016ZYRZCalvtrnlFTmbIDiHuK8LHjpp1FNSpVxbwSgNfqpXk18ZETrXWbD7rjSC+Gvq
	2Zq8xAe5T5W3fZx49gDFi/9RlxkTWUAz1To5p3J9NPRMfG1xcROoy/Q1B6rLz0g==
X-Received: by 2002:a05:6a00:2191:b0:776:19f6:5d2f with SMTP id d2e1a72fcca58-7a21fa132abmr2200181b3a.11.1760661036911;
        Thu, 16 Oct 2025 17:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn6IsRhGZ4xlP3bS88lEKXjX8HQPq/koua6rjTeilXyVx3cCXfQkxF8B5J04SOKq0JCLYU9g==
X-Received: by 2002:a05:6a00:2191:b0:776:19f6:5d2f with SMTP id d2e1a72fcca58-7a21fa132abmr2200147b3a.11.1760661036405;
        Thu, 16 Oct 2025 17:30:36 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm23613050b3a.40.2025.10.16.17.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 17:30:35 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: soc: qcom: qcom,pmic-glink: Add Kaanapali and Glymur compatibles
Date: Thu, 16 Oct 2025 17:30:31 -0700
Message-Id: <20251017003033.268567-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017003033.268567-1-anjelique.melendez@oss.qualcomm.com>
References: <20251017003033.268567-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kFVIhGCDfIRFlk9ALQ-r220dDXuaYoC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX7f6OftigBDS8
 LY1ImEXytTWQNo2TRgXVg/KxJoPv+i1UcaeYgFnx5We4DvSoYJirpmftaeLBNLtA/ec+ceDhwPr
 UOZ0VJDBvEW7e4V3WpUYByfAunRmBd4pvN52EzQqj64iu7Ym1cKF9dqonFhIYrASY5CkiltQ4Do
 CfLqlPMUpg50XfzR4H3cr3N++af+3jeyHbJiK5/jxLY9TJjyt1quoMZr/f1TiCwkN6wkLvodldY
 UPvSc74uOCxjeK4o/87GexkzJR9z82sRLPKrYJs8mx2lkMvFxOcsiIlQtT1/rzsO/lnYqn1t1cX
 eszreTOD0COzbs2rNXIUttr6GbqmyTP0qxrDPmG57A22axw4R5glau6efGHSXtY2Ot/qrElutC+
 B+WfAOai+Qc2uveJGjsXstFsM/anFQ==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f18e2e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ygjGbgp8loThTX2QW0cA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: kFVIhGCDfIRFlk9ALQ-r220dDXuaYoC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

Document the Kaanapali and Glymur compatibles used to describe the PMIC
glink on each platform. The Glymur compatible uses Kaanapali as
fallback.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 7085bf88afab..42b5a5d811d0 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -37,12 +37,19 @@ properties:
           - const: qcom,pmic-glink
       - items:
           - enum:
+              - qcom,kaanapali-pmic-glink
               - qcom,milos-pmic-glink
               - qcom,sm8650-pmic-glink
               - qcom,sm8750-pmic-glink
               - qcom,x1e80100-pmic-glink
           - const: qcom,sm8550-pmic-glink
           - const: qcom,pmic-glink
+      - items:
+          - enum:
+              - qcom,glymur-pmic-glink
+          - const: qcom,kaanapali-pmic-glink
+          - const: qcom,sm8550-pmic-glink
+          - const: qcom,pmic-glink
 
   '#address-cells':
     const: 1
-- 
2.34.1


