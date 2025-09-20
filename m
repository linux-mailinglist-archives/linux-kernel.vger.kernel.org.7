Return-Path: <linux-kernel+bounces-825712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D406B8C92A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571C0582DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563EB2F363F;
	Sat, 20 Sep 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFag8S1d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABE224AE0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758375211; cv=none; b=bA5VOakgfIHfh8HDjXU+O1EUY+UTUC1Ah0PYk8nauNpdo/Ov9AmbHrognTqxBjiCDG89lELYwpMKhoWuGZ84IxH1yF/L4Luh3HQ4EMc1znQ6RD1ON1K6JOt61oohIMSHMheR9YyhgUGbiWI4tNj8F7pNVUM5S87ZqkSxIoQFlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758375211; c=relaxed/simple;
	bh=F9TNTcJ72Xy2VjV6mYwy+LXLtuaD1jREw8ipqjoUmO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RCcVKLXaLNiZwhuDjAZqaGtj0SlJvgIoGgS9Qvu+HL2txV49ROL/dgkGi6V4BCcpUBOOTLLnB82CGs6AxkxrpsRJ2cmITRVbrwJfm/Q/HGG9Ox1mbXg12gvlftBvtrJYVyAa+L2cc9YwlvGQTHIk6/XaFW9T4MELti7XUxTrN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFag8S1d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KCvWHG025838
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wQKOe8P2vr8uFWPix5zvIsvn3idrR/hD0KQ
	7uhrpj7c=; b=PFag8S1dtcbglqAqrkRrP2bzkibX+1yi0racELwU338xbW54JmB
	7J2aR93BTbKfFwm45AihfH0RSd/h7AYy0O4YTIHGjRxHMdwxO26dkqllIL/SSrKq
	H9+rvLV9IJBsw/yrAYLX9SQVrqTvsMNMcJBsRk/WIIEsPdPBFYQSVh7YNNAyf0im
	8mPvSa0iEkOmie7v01cLklRAO3VgJ5RtBRb/73K7i5haLl7FYbl0B815QpwE+2AN
	QO0VNUQ1gPt2cUp+4S9vLZuxo23cvjRM1o5qdtATUK/Q8Uf5MiwANb2/k6d5xOCx
	5q3p/ygq7Qt3S3Fdop0Z93KaEK8LXrxorrA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0rt2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:33:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce13aso56888535ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 06:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758375207; x=1758980007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQKOe8P2vr8uFWPix5zvIsvn3idrR/hD0KQ7uhrpj7c=;
        b=JtCDB6ubC6OE9AzLnFhYVBA8THpuMpAge2U1OagKVgPn2hi/qqXSP1OWguL1iG5C/R
         bFTk0i3p2O5v0DPq4kXe/e1We1jR3X1Jx0K2vqUSe+2mP2Fz3IpEFnZFgh9XpjFRgfSS
         LiYneV/3Di6JDZgu+mNTv3Wu/9I7Ooec0Rh/+KqL2oQkTiVlATC42pJRBscQ7ADzDFRc
         JV9MFc5PpCsUDGqWa/NurAGthFzNw6IscCr/Mcj+B7RbQE+1ojHAjBXC8vscBCVy+inV
         3TQ1ZANzqKP+QghaXEN/v5ChvaOdhCwtORxCdaSy6lRNP0E7ZmwfHITLYRvDgLekvulK
         SPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg/2eqTFY3aye431zLGDo3+YqH7mvXwsnG+MBw6WS6NnLcV8+W/Zk0Qu3gM5VLxohsMcTYsHC69z2rTmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV69xU7hHUvLwaiXF5QvNed6k9+kfV1GzvfKojlOKbIT8ohfl4
	ACGRqx9cgsRnqK8MEKffwIKK/eDTW0IzBy1eoQ8Pz7V4l6VRbfFKVfjJhns0YvpRK9gYTQd7R4y
	hoG2Rvn85vFdc9vfqqv5B4SQGMdk6IMQ0m3BzeUmAb/gxicBqFnQ3bvF+by6YSaKqSJQ=
X-Gm-Gg: ASbGncuvmFFFav6+pWjIet4BIh/h3K9KuCqMhS9l/CmeIegE5CdzlsE0GxFRl1GFSnz
	JTFXH8+Z1LnP+1EomKg3p/+N93VsiJAcTwxKOBvOQqpPBCkzNSCWfe3K2/AflLE7IkLqFAS8K6L
	L8nZEJUpz4U63W+BSkS96dZekYC5thHj9pBNcx5W7tUQap2nQMMIjkfe53DKafB3TenQZMjMlU9
	uGO/TO7O/bINKL0/oM1xaXwGGesoratjgy7DaHGZnv1JOYged5pN2tmuZ5Xctr+tP4ldFx3p8Nq
	MCHvqczkTn4dvc/DoxmVitZgY5txz3KiN/ePzFNJhi7t75gCjlVgQF6k6qBmfY+GmnY/cH3IWVR
	wD38wau0xuKp4yNUfYriOYDNUE67eKx+e9RvH2tadiP5snGiPII3mw2eaxvGg
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id d9443c01a7336-269ba447e48mr101206485ad.17.1758375206963;
        Sat, 20 Sep 2025 06:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESKYfIbIXZygaF2oDpOFzQL0vr9vZbzkA5zah17knkO7iUUouvAhI2R+Ga4XBlOwc7OXlIyA==
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id d9443c01a7336-269ba447e48mr101206145ad.17.1758375206492;
        Sat, 20 Sep 2025 06:33:26 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32fbb96f3afsm5375009a91.3.2025.09.20.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 06:33:25 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Document the glymur GPI DMA engine
Date: Sat, 20 Sep 2025 19:03:05 +0530
Message-Id: <20250920133305.412974-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XBCyp0WhqwZDFRNNmVTxe4fSVBwCFgpm
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68cead28 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HaAzngDW_a_fOyBJVOMA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX3RWrMqsjTB1V
 DDNOP8y0ZDEThZDEweJMCYMBrzKjQExXQYc6hgHs3pXwk/d1+sl6zEqkZIidzusyfEiDba+oiaG
 ho2OWn+OpyQe5RCAtU8wOpxDU1bSEjIBNef7MAeFhq5qYtwOO9hv0OrhLgKAMME/+IxN8n6B1aZ
 7c0Cn+2cKm5NLw6mibxEQox8PBJQARK37EtVq88ywb/jXAbhzOaaWkGmJHUMNfAC5QKSjf5B4qk
 S7NP1XpY5Wte/ZJLFmZwFxqP/Oh47YC87n/Yihiv9P5XQQHXYEBTU460VC2Xk1ZxrvlidaysBiW
 0MWae6qDGtsaqRzBoxTrLV6sYmpdPwCAdg2yZtPFD/CogF3/mlMA++1zdcBnsipadItp0GmWTRi
 ZQ79ZFa0
X-Proofpoint-ORIG-GUID: XBCyp0WhqwZDFRNNmVTxe4fSVBwCFgpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

Document the GPI DMA engine on the Glymur.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index bbe4da2a1105..d595edae4f44 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,glymur-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma
-- 
2.34.1


