Return-Path: <linux-kernel+bounces-874075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774EEC1574A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5890D42326D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A9341645;
	Tue, 28 Oct 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pFzvOHuh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E534166C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665230; cv=none; b=T4O8v8qLr5hELUCkGNzHhBrAa/bj7EJrTz0DAGEK9XUfIe4JUZAbYrRLCOz2Vb2sxuz7v4tULjXFOrcSYSL7t4zC5rpUOwT98ZoKqKjCLNatjnhrzb7luzh4Jt4JcZTBoAUbOxQRAiaW9R4WPkHUPKNuF7LCok+0MKaQSzMeFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665230; c=relaxed/simple;
	bh=HIse2/6LjXjNvqZLf8SY4sWJTdhbA7cCdS1xQrYMFgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRXxRPOAMm3YMySPWvmTpfqwRwlHuPmLI3iMh85dOFii64+Nys5JJ1/3u+2leMuHxKJC591utmQnXpbD68cqOJpyqNVRuXN5gq4q/nXeHS1xgkCgJyTtbvPOv2Us93y7b4Ph750V5Yww+V1uGQ3rUN0actjaG6XBPt9nM3+pnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pFzvOHuh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEoH4p1916398
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SgQcI6nkUnBLoLSFlYf5nq81TfhQzj6LqBeVf4PPgVk=; b=pFzvOHuh4nCGHeWN
	/GU7fuhzd72e7qhZ0GRl2PfyS1MvWyuzvWKsVs7NTplKuxYIZgbPWlzZFXNpfwPn
	n3gVhWsWzrZbRmgiIShuRgD0WoFNUTUigMC3QQxAfulytvvnm4MmKOKGpPKCd6wJ
	seNnKMS4KWXJr+oJUwjXzqb+rqasuWGSNo72QTY5qrfw2+CthmxaTZYdO8W1IWUq
	MQOKfSfX4+Fr2pIvuy57fbAcPv4jaixzDDDASfM3bJa8AuSwaiI1Lbm9i8yx37uq
	sBhtfhYVp8Jszvgnd6lPnW/jkZWxSvCDGqZCdqiM0UmA/2TIb5g7I1tsPIg7Qs6T
	vOIFQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2g2ftxdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290c2d13a01so45444295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665227; x=1762270027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgQcI6nkUnBLoLSFlYf5nq81TfhQzj6LqBeVf4PPgVk=;
        b=pJyMOqAWzs6T3RddkgFZiWz64+NKfUg9kmk+IXWOlcl0p3Km4gRH0Ptu8iXOJLg9+P
         ihfj6WP3BcU6h0P7Z1fOCa1EXWa/ywTFwPtJdWRu83s5z0pQCM2e7vdvVe+gVfOeq8Wk
         daQp+7S7eTiJAebUCa82O/8jB/Ki9FMn4ty294b8Up+Q/8HkjkB5TwDPKCUfQF3w9FQP
         ErZzgT53VGO8EkiMbDdzUJufeJ4Mp0WOV8N4iusRrEPKEjz4DCzd9ZOxnHjFX3a3k01R
         USGwPfT4dyj9g58Ve+a9epn24Gx233iyCcSVgGe5Myuro4xV/3cFxRcoL0ZoiadMLL94
         F7sA==
X-Forwarded-Encrypted: i=1; AJvYcCXYT7NRKGJD4AurMAFu8QL3kWVHFt2FoYuhvwnhu3rBDAHdUHVGFUp8YL1P3yws3NdmLVBIp7So//5V0no=@vger.kernel.org
X-Gm-Message-State: AOJu0YySDSkBcjMQzfMpvThk2AI9M/PGG+fWnRnNuBavEITFc4Ki4Ufz
	Sm4b6tQTa4ZEUDOi2R9HSEkmoMbuVvdGkp3vp9idgzv+cN2yz9awYvj9gVZOYHVlbwBfCyzLriD
	pN2ppPm/ZLJ642VQsmCu0BFnWN65OEBxFfTYmYABG/8FUrB49MECB/tg0eqTzeL32PPE=
X-Gm-Gg: ASbGnct1nWDmarEKZzU4ygyKLYyZ8zEVECiDmElhUqF26DwOIPAzjBTudo46SIWTkX+
	musextLE25GZFiu9EvWD+qXUe4mkc4P94XzICFg/wBBcj18M1NuOtCZWqaA9fRGhZGVNwkAZ2e4
	+Y6NES6b1i8S3t0I9DhuXgvc9D/MDlWFoPj6AOnMuR+vkAQv8D0838xNI8UYfk/G5tLf+awHWTA
	EX9WMUpPM4YPQm8t4YODIYWM2tJ4onrPyWMZWSOfVNrMbli2fq78R78lw3gxp0nX/wFS2NdrM9r
	8iZN0hnwIxMus1eSDd+72n3mLX2PDdoa1SuPQg6zC5xDsdEX144YIO3OQaPjevTXSKqVjtKgyyJ
	WqUg24LSOj8+s1flTm/djaVhbG1hcg0dNPnk=
X-Received: by 2002:a17:903:1c8:b0:267:8049:7c87 with SMTP id d9443c01a7336-294cc70eccbmr43094345ad.14.1761665227294;
        Tue, 28 Oct 2025 08:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr3oiAmNZooz/nfH0CRpP85CU5ciJ7wKCzEgD0BM8YcfRozU3AQY5O8zEhnyFkgZ8zfF4Sig==
X-Received: by 2002:a17:903:1c8:b0:267:8049:7c87 with SMTP id d9443c01a7336-294cc70eccbmr43093825ad.14.1761665226706;
        Tue, 28 Oct 2025 08:27:06 -0700 (PDT)
Received: from hu-vvalluru-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4113fsm119490755ad.90.2025.10.28.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:27:06 -0700 (PDT)
From: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 20:56:49 +0530
Subject: [PATCH 1/2] dt-bindings: dp-connector: describe enable gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-enable-gpio-dp-connector-v1-1-2babdf1d2289@oss.qualcomm.com>
References: <20251028-enable-gpio-dp-connector-v1-0-2babdf1d2289@oss.qualcomm.com>
In-Reply-To: <20251028-enable-gpio-dp-connector-v1-0-2babdf1d2289@oss.qualcomm.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761665215; l=951;
 i=venkata.valluru@oss.qualcomm.com; s=20251028; h=from:subject:message-id;
 bh=HIse2/6LjXjNvqZLf8SY4sWJTdhbA7cCdS1xQrYMFgU=;
 b=q0dbkVCREQhWewqq8/EKUDSgVvCuBEABQSzKjyuiLuCHJTRuASfPE1UfYiG3XGad8+8c19CTg
 CG2gaZhBbFlA8k1HaBK2J9OLlFQ1dZyrE3JE7nzag9kJemdz+dLXLc2
X-Developer-Key: i=venkata.valluru@oss.qualcomm.com; a=ed25519;
 pk=KEpJdy7/I8HDmNSf6B83x+sFHUNr+mjMNJ2qe4G/zXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEzMCBTYWx0ZWRfX40wcErkJr5ml
 zr+pp6IrLLly849f2LoaNh+v9RP7Fj7m4cdBFi93wEKMtHlVD+/W+RWzdAfTGjaUkT04xR4L4ry
 DK+AA3zueZRsiFyd7U5BkrJZ/NEirQG3YIYGKMKnEaxIOATXBU6PxXSWl3pyhUjLnnxmsuDveeF
 GeJikG3+QcIS70maKV6fx6HS5Wtlf7ct/BLFxd+zGTaC+tLB8XBXzckNCoNbD0toMnTjRYTB/dW
 VumkaZeGv6Mi0uDIqJt7dKs8NZTMzmf2K3+6Kw9iRXg98FhMl+aNq154payGoP5lCruBBjc1b8L
 7bTeYHsBiPv4cMgv4ATa2+dHF1RMU3Nry7yRngMKRtvuTm4T/ESeFti4gkba1zZkyDEO/D+uPZO
 FDWVqTdDt1MQLHYwuq3ZYzGIBmCS4g==
X-Proofpoint-ORIG-GUID: yYkfUTkXooLjKb0J-ao3XJMwogQM1RnC
X-Proofpoint-GUID: yYkfUTkXooLjKb0J-ao3XJMwogQM1RnC
X-Authority-Analysis: v=2.4 cv=FIMWBuos c=1 sm=1 tr=0 ts=6900e0cc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=PexBTdYITyibd1_YPJUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280130

In some cases, dp-connector need a gpio for
connector to be enabled. Currently, there is no such
entry so, add enable-gpios for such cases.

Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/connector/dp-connector.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/connector/dp-connector.yaml b/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
index 1f2b449dc910..e703b19b7168 100644
--- a/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
+++ b/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
@@ -20,6 +20,10 @@ properties:
       - full-size
       - mini
 
+  enable-gpios:
+    description: A GPIO line connected to enable connector
+    maxItems: 1
+
   hpd-gpios:
     description: A GPIO line connected to HPD
     maxItems: 1

-- 
2.34.1


