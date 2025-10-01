Return-Path: <linux-kernel+bounces-839162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB709BB0F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EF83A5565
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AC26059E;
	Wed,  1 Oct 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NrvEnoNZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D125D527
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330820; cv=none; b=els1wMunm4AM/Hp3vFF7AWlOqSB9kVqWcfFMJltdIuPegB1vegSIxZB3eM/waIM1Qkqs9yATmphUDqXnS2zlYexrAiO5nNiPlg2pD41F/z8/o4dGJXoUBvMHg9l5qYs0gnNzecGbEsCuR9IRA9LXQ1Kx+HZFR2GOS/j8gjppx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330820; c=relaxed/simple;
	bh=rrOC8v605BCDBPVmayK2iE30qmCNfSK7T+Vnosdb5Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coHnosb5pzAvDcBgqyr4fom6aK/Ajhl/bH1E2mFB5XarcnICE+mShWEJ04tnnXTihX07cCKfSD+X03rYMXO03MaWpxazVzNb28pNp3cR+GHpXMuFH7aCoo4jhdNTA3VAHGvx+4WYJkU1GDBZKoVsUwR3iP0AJJ5yg4SWRsZ/+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NrvEnoNZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5919mpUd016878
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 15:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=98Gzg36v+XGldnSVXhb1o5X/kk59eIv9iOf
	72j0wzB0=; b=NrvEnoNZCxX8fSW/28D4O18iLRakaQcQL+cDxGPzfAsw0tgjV85
	WPrkpdMZg9UE/PbJ/CEo61AxQ1dLCfQfvdqJ6PFVGev+Ngr9Em8mZQ33dpWzbkgj
	ogJ5Wn16E/NDDjA7NEdRdvMITNcmhNNDCpsjDjw8GNPveS1S5rZG+obRDwcLLkM3
	v1UuFgCD0n4BOkMirCWJC3gH0XZs1e5jP/FWS21NAyWdfrFXQOVt8S3H8iTk66Iw
	BIc5yVTECXPZzxQ0xU10GKPk0Q+LRvPUgIHKFupokL4mq4HDq44IvjmaOL/5SrPR
	sX4ybhaRwRzGcRE/PyNPQuFkAswL10XX5Uw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hmp9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:00:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dfe8dafd18so157912271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759330814; x=1759935614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98Gzg36v+XGldnSVXhb1o5X/kk59eIv9iOf72j0wzB0=;
        b=Hz7XVS4mmGvcZhrVKhiJwJk9I7KywXHm+i9kfxZREkt59cZgt4FVm7e/yA43M6j6km
         fD33yJ4sqUW0hysUmUXM7k+rBUsa9plvoOdVeW7Gf897xuWCAgpXfUnLMqx3PX+9Itew
         a1Pjit7RwTMZcmksp94DZQ0t4jaUAJ2rCVyrUOIyHM8qSZIDPMwce/jOiu0q19k1iIi3
         liFW0kpluTsfefAsqH9uyEJoIEaef+g3Y+aa9JJL5Hvfgymo68la7UfW3mAFXPOakYYv
         uFH8kmgbdygIGiuo36Kr+fSGjRBTw2LPU+UpBSf/Yqc//O8Met9c6QT/rJ6GXTrYUBUj
         2yFw==
X-Forwarded-Encrypted: i=1; AJvYcCXUEfZSUTsqd3jWbmSvcxZsBeloz20iBIaKa9tgWBan3RBb5VjHzuQv2IDUoJ1hazqDeqx9bognYL4f3Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+IFgYVbFBxTJPfntsSmVaMhyaR2s204VwpT0YfNvsLpSbrVc
	ZjVtGKMBIpfVm9icJP0m5+7bQB36UkdJuXyN5LOgAR9neEA3LBj1L5y2U4OHUlr0denlvMFIbvQ
	wXesxW23YVksze1fxogHyHPg4Mk9XYyfaYHH/XDjXax6wuInpjb2UhJ7MBcmkOBF0Ou0=
X-Gm-Gg: ASbGncskEIFjr930d/KlVzNL9CWATKvxa+bT1X5hvg4g1Q8ehP3V7lWyfCAks8ztNXU
	ulBfPV4APuvT9I4i4NeBpAt2YsRLipZ8eHTVdu2ZyG1QcyaxHicV6fxLt5eFxkfobbXXQv3KREf
	OXCwitQhCAwV9yQlaeOnYTTgG2U5L5fgNcOTjqu2S7y76tFa6MpvBkxIFuIMunCaFG1N3OxS6kU
	JtJMfwqy1dUM4/a/WqPelG/F7dzqsloEir12XRpdbqmNmNNMcscJ4MmQKvP2UxqH2qU+sZM4p9A
	4IBntlE/7uOo18kDPJdnNzTPbIDEeayTlpu3NhhkDwlIgQQiE+HtseWdkIk=
X-Received: by 2002:a05:622a:309:b0:4d6:acc6:752f with SMTP id d75a77b69052e-4e41de7315amr42569121cf.69.1759330813001;
        Wed, 01 Oct 2025 08:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx571d49HxGU0B/X9+gUUZRIikwYyAXb9VNnJW/EZEvrFqfK5Fk227camoyVPoXwaLVq76mQ==
X-Received: by 2002:a05:622a:309:b0:4d6:acc6:752f with SMTP id d75a77b69052e-4e41de7315amr42568091cf.69.1759330812235;
        Wed, 01 Oct 2025 08:00:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b69bc0bsm37147955e9.3.2025.10.01.08.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:00:11 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, robh@kernel.org
Cc: krzk+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: slimbus: fix warning from example
Date: Wed,  1 Oct 2025 16:00:02 +0100
Message-ID: <20251001150003.417472-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX3pHN4Uu8JQfv
 addz8cZjU0jQ/TMbcV5X6U0opN+OFdeJM3/pyQy+RwKrLb/Z6qR+vtpF/MKUUgKYLUJ7MBlbegB
 Qt34dEB7aXXOjJD7B6UrmbEZ10DPRqXxHQ66UJigsaGaKH45YNcZkQBoE+/+SFdB6jLwrlBEBkZ
 rMjQ5Qx+LIAgqceH4DWEDXRQYfmlOd1RF+Ka3gGeZpDK8/nHWmH08+6THBCUkGoO4ySylHqhbHI
 q9lbXUKpm10a6uI96po/lOBDTY8thdf+BlHoH4wtmp+f71hlU72vrwvMgbvu+fBWoYZJz6Litqz
 at2VzJaY5+RfWFeq6YvZMd1thcG3aQZgpQpJF65JZvF+1og6Rg13HiWweOD58D6x19k3+mDQaW5
 iCxgNf2tRsN+aRFyKwrk4nqhSotWSA==
X-Proofpoint-GUID: gjkJRvSuD76imt39jpGGf56QQRVwDRVh
X-Proofpoint-ORIG-GUID: gjkJRvSuD76imt39jpGGf56QQRVwDRVh
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dd4201 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=f5vYYIzMdUIQFJOv_x4A:9 a=kacYvNCVWA4VmyqE58fU:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

Fix below warnings generated dt_bindings_check for examples in the
bindings.

Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
slim@28080000 (qcom,slim-ngd-v1.5.0): 'audio-codec@1,0' does not match
any of the regexes: '^pinctrl-[0-9]+$', '^slim@[0-9a-f]+$'
        from schema $id:
http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
slim@28080000 (qcom,slim-ngd-v1.5.0): #address-cells: 1 was expected
        from schema $id:
http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
slim@28080000 (qcom,slim-ngd-v1.5.0): 'dmas' is a required property
        from schema $id:
http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
slim@28080000 (qcom,slim-ngd-v1.5.0): 'dma-names' is a required
property
        from schema $id:
http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#


Fixes: 7cbba32a2d62 ("slimbus: qcom: remove unused qcom controller driver")
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../devicetree/bindings/slimbus/slimbus.yaml     | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/slimbus/slimbus.yaml b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
index 89017d9cda10..5a941610ce4e 100644
--- a/Documentation/devicetree/bindings/slimbus/slimbus.yaml
+++ b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
@@ -75,16 +75,22 @@ examples:
         #size-cells = <1>;
         ranges;
 
-        slim@28080000 {
+        controller@28080000 {
             compatible = "qcom,slim-ngd-v1.5.0";
             reg = <0x091c0000 0x2c000>;
             interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-            #address-cells = <2>;
+            dmas = <&slimbam 3>, <&slimbam 4>;
+            dma-names = "rx", "tx";
+            #address-cells = <1>;
             #size-cells = <0>;
-
-            audio-codec@1,0 {
+            slim@1 {
+              reg = <1>;
+              #address-cells = <2>;
+              #size-cells = <0>;
+              codec@1,0 {
                 compatible = "slim217,1a0";
                 reg = <1 0>;
+              };
             };
+          };
         };
-    };
-- 
2.51.0


