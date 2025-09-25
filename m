Return-Path: <linux-kernel+bounces-831520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A76B9CE24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592441BC521D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84F1A5B9E;
	Thu, 25 Sep 2025 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ScMDx0NO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222119F40B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759644; cv=none; b=SLWThL8el0Y2IOhcdx59Ce2qEgcuPvmmFuO+RCiYKKR+H4D9QEtrBjrO0zXqwduviL49AGxJ33MCNm1P0Gyy4FTRTlF6NVEs//uW6s0yhiMS4Rdpv409S+o9/yT53XgNsi6KhrMEsHfCIuOuNMhcBIX530oJE20kMcRw1VtR4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759644; c=relaxed/simple;
	bh=Vzfs1LFFHiEdWORr77vIh2SKYYdoMh/m5AROS8rGlOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H1LQqgSj0M+771b97bWDNh41vMKuseJbBLiPZhvu8xl9ep0sW5a3w8bsBY7oaQGnu1B8UvnJKex0866IiAT9AmQZOcDzoBXCTZIi5Tk59J9t0uKSoRD5WsGjhP8N776FaEwYOKLaYPzPRrWDA7d1MdmYHX0o2jaySYkrkTdhBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ScMDx0NO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONHgN3027912
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SRwI25fTueoRl7qygb8baE/cMAE47EtTbSA
	vuT0E+/g=; b=ScMDx0NOAQFKWHw2nHLMv3URVQ/y8V03PU1enZD+vdz1oIAdot9
	Qf41y+YQWug4hnJgyF4NuyRlNCl5JwQvRiZMvqVRHAfRzaLWCSauMamVXMayd/do
	1n3vfKDU6SaYOdBGOeKudzQ6Ubcc6NKhXQnqFCGE/lH79YEnmFguAYPlz9DVjQAD
	cdNYYiBu4+/G3kxX6fW3whgFiJxWZsgxQ5N2b2kF2mesQwbi8k7oc9Bu2D+VfH25
	2azjRWQO8koO85WJBmTHLXrl4myTrdg6K/3QsZkr4n2hhqAQibq+S/4PK7Wy2Mlr
	QDm230Rgfny3tBDV1hWajJsFlV8Zp8iPgdg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxgja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:20:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55118e2d01so245721a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759641; x=1759364441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRwI25fTueoRl7qygb8baE/cMAE47EtTbSAvuT0E+/g=;
        b=rv52YeGGmhD7WhtJDP+gIYaegL+kv4WT35kuENNPGwjvOxJ7HkxkoDTATC4qe5leqc
         CS5kdT0YQyAPXCFLqOVR8ayXkBHAk9R8lgMc2uUQUPLNLV3CUGjg8rfh3vkjwz0N9DSl
         h+B/TKsy7/qX4YbN3sGz07yQAMiuOmp/eZ8ml4flm4S3eWXINgH1ZZm5BplrtFFzfeEy
         oWA/4TG2TgmwaG94O7o7fdG1PC63jmdlIEknDzKtJdcFmksAAcI6+9VN55JUA10RsIIG
         cDxnYPVgrVV5E1PFXjflROr7DKA+BLQBSQYL4jiUOAyL/zMcGLrWetjQsUKK3IpyNItI
         GRGg==
X-Gm-Message-State: AOJu0YyiO/y9HWK2RjXFxAbiDeYInOMXw5gQAHu3xny2/LO2n4JTFkcw
	2EP/x0SnLfZ9L38FbHW5s/JD7/BrV/97PfYLgBjqiiBMJgnMwgeFLQbF/ar6lqOKw6BZ+adfXA5
	w501I2/vkru22nDM1T5vZ78lSkJ2RWJiFG17LeqabSG6zCp4eTKQrwi2+sC5HdL4W0PI=
X-Gm-Gg: ASbGnctMrq6i1DoDmPffub0mxDvjagbGiGKTM20RpygLFFTbywKWo5qWzUoFGvwK/tH
	/PfPn4rmAmGdC4ORNWqVQPNZU07GJSFOBbhkW3vn49fmksBuMWNU6XLEHeqEYYXyil4WVrLSMuG
	SCFiY8OpsOJlrTDf/ZN1CQeWS/l1SDi8COS4JuOm2D8krSP5PvPnmAzJA9N5iorQacuRJWt37Y+
	BnxUO1nSclVp29DWj2i0hp1CjxrWsNuG5uoL2O+9UrXtkxbZDhyAkEWQsg9GtqJkQSuhQo66vxo
	7Pc7uaFsyCpCOo18A99VtekUocvcQRE1B49Slykx09OVrljIyArCkdJVT4v4S2n0Mtz16oX19Aj
	jJtb/PEfH9DtQR4EorMe9XXPSvGve842MPDn2Qc3HOLNeo4W+A9FlZL4=
X-Received: by 2002:a17:902:da89:b0:267:f7bc:673c with SMTP id d9443c01a7336-27ed4ab0972mr14591555ad.44.1758759640789;
        Wed, 24 Sep 2025 17:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEogoEQohZMX5Lzntajc5fLs0ei/8RmKQ+VYDghSleW2B2SrVgQJCo7h3MdCRBt+jNzWkvEIQ==
X-Received: by 2002:a17:902:da89:b0:267:f7bc:673c with SMTP id d9443c01a7336-27ed4ab0972mr14591355ad.44.1758759640309;
        Wed, 24 Sep 2025 17:20:40 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm4740155ad.112.2025.09.24.17.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:20:39 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        jingyi.wang@oss.qualcomm.com, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: remoteproc: qcom,pas: Document SoCCP PAS for Glymur
Date: Thu, 25 Sep 2025 05:50:34 +0530
Message-Id: <20250925002034.856692-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d48ada cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=y6Zk4y2S2ODVn_eFbNIA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: g22WxbTq3C9XaHR9aeJEowMJjdrC0KrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX3dH0+W3ReR7c
 PXnbBv1cNgkxFVt8fCyKIhPMYibl3WzbWNvUVLfifGoKTqpR7XXy6/PB19UVwepg0+yEOP86GYl
 D06ot/lKKTosIcsZE6RSxYDjvLMa7Mzk3xmlGwKY5Pw6ODBRCFiTu6jIUJfcIvOUwBiYj7FV15A
 N2+SWbeFKD1DTb6fwESAxdripizzRqfI57jjEjOnPO6RTXCmMdkKb2Hn8DyTuUBeJOLcLMK31hx
 3WFhyLOrPuD+sG2Qy62PoLgZkmcFktXAzyJ7bLfQRXBsp5JkiLFX0jsun/bRAsBhYFDH5cFWW3S
 sz2NER1E7mCgNVjcfPwDeTaHjqUtnKEisiCnGdzWWkKd0Slj4bgxx6mfmf/KscuZobykUzfKTpi
 5FvvP/cN
X-Proofpoint-GUID: g22WxbTq3C9XaHR9aeJEowMJjdrC0KrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Document compatible for Qualcomm Glymur SoC SoCCP (SoC Control Processor)
PAS which is fully compatible with Kaanapali.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

Dependencies:
[1] Add initial remoteproc support for Kaanapali SoC
https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t

This patch depends on patch 4/5 of ^^ series

[2] Add support for remoteproc early attach
https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t

 .../bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml
index 79f678f5f7d9..8089e0869ed2 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml
@@ -17,8 +17,13 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,kaanapali-soccp-pas
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-soccp-pas
+          - const: qcom,kaanapali-soccp-pas
+      - enum:
+          - qcom,kaanapali-soccp-pas
 
   reg:
     maxItems: 1
-- 
2.34.1


