Return-Path: <linux-kernel+bounces-761040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE5B1F39E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3189F3A92CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796C280A2C;
	Sat,  9 Aug 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HETUexZq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F827FD75
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754730990; cv=none; b=SHk/aF6L7AgyCoU1eoHbKbR7VIXSc72mP2h109NMhaCU9S97Cick8lQ04Odo7KrbmRCNasquyHqJTnaeR1IevI+aUEkNAbmjAdYX00s+Qqg/Uh1MK4RZqF+K6gUQ7rJfhjkpj89H2cZcHp2DHH77LfIONSTda//xx17tz3umBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754730990; c=relaxed/simple;
	bh=cH9mFD81gjvWgXR9gnN/Va1aF7qgFbqJRVc2CfvcnWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQdcl65hORB6+Wlg4EmGlxvklcYwjMcu1CAdxBEB47LqI2WT/zUPOEb54GA+q4JKXpnFX0Pivak84AkESAqz9Cb3x9XANmVEqhxyKgz6pvDH07kXFC61GRF5TcwyTdEKfB67z+AO0ASt9I13BPqlHITNZPgMQgOzMyqqk8pMklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HETUexZq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793Z3fO012611
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 09:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cxfuy14u1nD4xI/i3c1nKgU2lIEUsDht3WPVHTU7Mno=; b=HETUexZqTVdDOGRP
	RWasJYih7V6A+xvow361DxvLJY+SHqeJbak02pkjsA+kJQtjdMd/18Vgb9uIY4Eb
	TM2viu6jTQEBxrNvN43BLhzGYkq814eQ28TKkQpwhsQvEY2X9M7zw5b1kAqPRWez
	HqNeh+Nd1/8ZSG0EMyHNVNWNV4B7IeGww0yVR4u+VKsfQcg+J7tmEeSaGnPyn2ZY
	NyO7WfeAy9v0eYEA6rI+6QijwHiemy7vPKJFco94VLx2rN93ZffGF6z5Z4x93GKd
	ecNsesXKjUHtln0854kKQyiEfyvLVRuSUh7yV7S4Fd76x+A+tGjiEAXWIfX2A4sE
	2cXlLA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj40cqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:16:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b08431923dso67865251cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754730987; x=1755335787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxfuy14u1nD4xI/i3c1nKgU2lIEUsDht3WPVHTU7Mno=;
        b=VqlNlBNcpd3hmwIKm5s1wJ0x1zNcfJwkluUZJlZu1Uedv71AsdXF7atSMQ85Gcq8wT
         k8/QsnEtRXmFc4fVnEj59UO3iYfcacCHpPQ/GZdgCPNb1v+IYeEKKGzhHCgzZbesMv3J
         ozlf3tUs+D47MYBpWUjlZjS8nEFknGjWP3O8Rtn+HrjVlbwLVnud1AwWM0vk56xQqwdp
         Ns2sfZcnb05vqU5QyDToowTeW4ANfh4+GItLbpVfCz+lDRiVdNmsY3jsGVKwre9t+Lvd
         MwulKPY01F/kOiBkMENMzDYJc1tpgFHiD+O3H0RWpQC7qz0Pb+hU+/A/Vo3PoTIdjM5d
         fYhw==
X-Forwarded-Encrypted: i=1; AJvYcCWkW+w2Pjpxo5Q7pJ3KwZtcmQxhAFY7krFjyoHXqnxnNuDzqNjttuEhz5Z8STb3Sr1PS3nV53DW0xxbMcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PV0vr8ku0n65Eqpgdhp8S9/AybxarrSOR3aXbD4/5CIUr7tu
	HM14BGYXmk1bLTBjBDpetkUVAjZVJVFkMi0/dQ97B4zWHQLGtJKR1vBelhhKOIA9XRDray0viRg
	VleF0u1BpJEXg/wmF82dsRS+eivoccdGJ/3q77N2wgiuJDEop+peAXELo8NIIjZEbqQc=
X-Gm-Gg: ASbGncs3UZu6vXuXXJ1PxH+BxWXU6aj4Mv9vlt9PgWT4rrRBpfx5IMYyaNdKU0hmN5v
	9/8m7am5O0kqQO4BLKm3KApGmwr3PAVAnTsXJUmvX6kQ1Ak5fBlkZx1EUJyWIZG8FRk41uoV8dP
	IDRRtyv0IvUQphlGPVyzRCLiBsLxtin8h2ebUKvixTyK05uCDHitT3zCmzu1Fxzt7DPerlTmyEg
	E258pU5ohF7lmhtAmmPireMw0v7SFKmjHqRaOVhgHNZN8yaRiJGsH+l2y+P6o4uhhmL4wuuNOcT
	z0gWd6V8LBbA6feBJUmiFIn6h/SdOKe/IU28zIJewrA0E/KKnZC7p4sPwVkc9NJf9GehMYwgjEG
	r4aX7CKTJdzvFPFHVN+zWJ34h1MY2oGNr9jaPkIC4rN1aaQ1a5lZ7
X-Received: by 2002:ac8:570f:0:b0:4b0:6c7c:a955 with SMTP id d75a77b69052e-4b0aedc899emr75036311cf.35.1754730987354;
        Sat, 09 Aug 2025 02:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZvWtm4YlKcaL23W+nUW97ef++KL1gDtBq38oi2j2iC9f5MjRqW8FMjd3aynm+3WxWfkZZ6w==
X-Received: by 2002:ac8:570f:0:b0:4b0:6c7c:a955 with SMTP id d75a77b69052e-4b0aedc899emr75035961cf.35.1754730986918;
        Sat, 09 Aug 2025 02:16:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm3361989e87.30.2025.08.09.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:16:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 12:16:16 +0300
Subject: [PATCH v5 2/6] dt-bindings: display/msm: qcom,x1e80100-mdss:
 correct DP addresses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-dp_mst_bindings-v5-2-b185fe574f38@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NXtQ3bomvI5JzHf8G2204y7/eJt5cmkeL6NKDMpr9gg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBolxHiy8bk2eyMWBCLg7kj5oWCwhIy6ZQzsXJ5v
 Fg6f80aQbGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJcR4gAKCRCLPIo+Aiko
 1a9RCACZtDdNaFddD3qCGcB/weJbCYH+yRFlmWQ7lGHxAxSSQjfDYujPMeEaA4yIbucYI0Y4Oup
 NuNyAcq9AMWwDBUYJRiY6KKLIUTrd5tlAT9LV7qF+jAUot8QnbFw8sT3XTJFmaiNx0luXWSVfcj
 tF0NCenZp1Mr3dYPKq7kmLPkDSJb5UJItb11+ZKvjP5ibrZkOUQxKiiUpd7YUyk8vGTQiufx932
 SWyQrYNKRXzcas23G902tyZ5HlLxaM1+CJEWGOake5tBi/fbHlL/z+bl5roh/U3XeP3Fo+ufB/K
 uh9QGEy32Ll4xc1qcDI7fJGvkcynbeIW3T+iKj54CGRaUVh6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX+owC02HZqUhj
 Ml6QoWpwZuH9CZHxGgBczo7BYz+GCpGAQDXQ/nfG8ZOKe3GIT/cEwMk1Pnk69V8BpaPNCbXyONW
 HUa4k/LYUdbuAR5JbAUuJQSkw6/Aap1fRzC3X2E6bScLbp2S3SEW0Yc8yxoe4HObLCuoyb0hrKJ
 TXC1QWCguSnYe3JW2Jx8/TxByLyM3OJqEOaCo+7SKoJWcv/znZBWdTUQVtVp6cupnt3tltAMosU
 B8jwKgb2MXD8lxdJrUA2uzUKpBjESxpwI3YlVKTBtTlsFPip++xZp2ibBuV4xJT5iZbUJNE+gT5
 YiVOWuG6iGw4zLT3qtcev0LJUN1RmAcIera6Hr550zGhq0zXS9NilqRC+wvD61TIxX6enouhcYb
 uKgzlZ2a
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689711ec cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=fvGZ3mk3BhhUN7shqj8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: szbT__amn7mBS_pIbc494ExAeM2tlg8e
X-Proofpoint-GUID: szbT__amn7mBS_pIbc494ExAeM2tlg8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Fix c&p error and correct example to use 32-bit addressing (as the rest
of the example DT does) instead of 64-bit (as the platform does).  It
got unnoticed before since DP controller node wasn't validated against
DT schema because of the missing compatible.

Fixes: 81de267367d4 ("dt-bindings: display/msm: Document MDSS on X1E80100")
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
index 3b01a0e473332c331be36f7983fb8012652a8412..e35230a864379c195600ff67820d6a39b6f73ef4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -170,11 +170,11 @@ examples:
 
         displayport-controller@ae90000 {
             compatible = "qcom,x1e80100-dp";
-            reg = <0 0xae90000 0 0x200>,
-                  <0 0xae90200 0 0x200>,
-                  <0 0xae90400 0 0x600>,
-                  <0 0xae91000 0 0x400>,
-                  <0 0xae91400 0 0x400>;
+            reg = <0xae90000 0x200>,
+                  <0xae90200 0x200>,
+                  <0xae90400 0x600>,
+                  <0xae91000 0x400>,
+                  <0xae91400 0x400>;
 
             interrupt-parent = <&mdss>;
             interrupts = <12>;

-- 
2.39.5


