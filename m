Return-Path: <linux-kernel+bounces-850153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1CBD213E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A5E24EE49C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B322F90D4;
	Mon, 13 Oct 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cwZvIsb1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F72F99AA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344503; cv=none; b=Qdqcv9hq48aMRCbC5IKFxPWg506QPYqTfxxJeE0CdWpy80ZCQuxfi01Ihb4ZOuYAlyc3Og2iN8sFZe7X8rzUHS0e7JPPxWu03A33TZLPnHJ17cgwiBvVqqUOokeANHbaO9bYWoSWpyBzdzke54vFdGGWsx0+D/7rr30LmkW7ocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344503; c=relaxed/simple;
	bh=r4zZxBjBVbvbXcB/D+W+e8OqRwsnVB6d/ZIuYC3/AKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eth8p5fGxfjymbUSq2jhY1O57FxCP/bOLPZg4Ql1BNvssvmPk8UBDz5YfQ5lvpMUTvBwuVHC8sLr9V+Ea/Sl5gw8axRUbC5mbo9025WrZJZoOGSTK1b3Ztzc3+wjyZMkFe4V/BhlfWYhmsNcEx425HCrEsuhzMBoofBknIO+93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cwZvIsb1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4qjDH023372
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/v17OB+uu1Bptl8Y2P1tJ6IR6+Du0yDfzTF368Kpd3Y=; b=cwZvIsb1Ltph8lOE
	d0A2CwHMpOI3JuTDPnAx76N7szM/7QdgVFn8Ors3a5cCA15ie71Y9lDPlctLq4it
	xL4mA6W3/IsepDeHjUAfy+NX7ollrM160wW8z3nZVvUNY4cXA+OXEribCRIMn5Qg
	d1Tv8K5AnOIdfl73PCo0gIP8gXcRngde43KiKnQ8Ul+2f4YRmnbcoq9A70m75X/9
	e1bMgiWKuyP9/w56K9+5w5yDKWxkZDtKJDpqnAQljHUMfS91VZVVj3VgHqP2T2wh
	w+Jh0qo9ZNIppMpEGK1ecBEmyLChcNwZbkhABAuCnjwzkhIPW4s8o0JXFjifaPqU
	JR8u1g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt0mw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so7547696b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344500; x=1760949300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v17OB+uu1Bptl8Y2P1tJ6IR6+Du0yDfzTF368Kpd3Y=;
        b=r0itROAo51NBgjvYK/TxMQ7jbpI2TtQ2prlhLp/n6570UJ47NjoRgd/l7O6GS5dCU2
         62227JFZzHkMasL0evtVocC95t32KctoUg/DicjQBNlxKbQ+WcCwwmRNXOOG2A6BiMXm
         7sip7NmFsvy5wQGCCKUrLdxiKTUZEB+FfYdbUsnhUeB+d55q1ZUaOtfNv1l9E1lyFmND
         cjxdRVqQqzF+orRQz7TToAPGWppnon8c1eStObnb0hhZYDI3BISn0oDDyWwcxtvGhjGy
         xTVPzyrpe55kd0DFtqkUMlpxjrgcfVCdpNv2ZOQyhYS9bgATBCUBZ0Lm1wHXKVIU5DRj
         N2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNdIDl1UvWJyMQ9exabC7TecIulesqjMLkHpdWJb3TYJAVwlFuUeWUGZnX2ysr7hOl3b5/+JbZ29E7Esg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Zd6pTM3aps+iVbY/8M0qZJsR8NfNMiJS900NvU71W9q1jn2z
	sefTwS9shE7tPCsJrjigy3+WGGXozJWoRUKPN0moILmDu0m5MuSiuU9UwcDkWIuTX40NM2VKJrl
	bEMQWm1pp5CS4A19+bzC/VsecsFTKlli1ouURSmVL49R73ljjQz7rehoFtItCwRda5AU=
X-Gm-Gg: ASbGncsYypA6q/01YGt+w268kBp54G647FiiUcy6MaaBY6v8HNjeotzQkRT1CKQFdOn
	cEALgeWOHMNbyLeJC32bg20SmTBipUp7moUGKwaCAsM8YOZEDyipHDWuvyWZaC6gPayxe6RQ5KK
	Ugt2Ul8zMq0Id4v7VoFeMpCkXb2XXKa6UPhMdJIWpjY1leH20hVhJPxqZXS5tavBCs1A1x+BYjj
	gX8iFN3UCdvHB7I93LQ/qoeTnJnk+NEFx2cTq38NU9bApXt5Vj6z3QyTnZXr4/oJegybFTbUzNa
	4vW6cnKMrseyZMeBbEX3miVgcy6UDrJuYNKf7iQEfF2NMQTzoe3KyUpBi7jufGVmyIUSF9BU3bc
	E68goauxFr8pn3iTw1W8dYqTnDbY=
X-Received: by 2002:a05:6a00:1491:b0:780:ed4f:e191 with SMTP id d2e1a72fcca58-79387c18f99mr19637417b3a.23.1760344499586;
        Mon, 13 Oct 2025 01:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVDtAXNThQkixGUJDdp47AfSNM9/enQpQjoVqt6LA/SlAQ4k1D/FSKnPcCgyCzCcNttw9ZcQ==
X-Received: by 2002:a05:6a00:1491:b0:780:ed4f:e191 with SMTP id d2e1a72fcca58-79387c18f99mr19637391b3a.23.1760344499070;
        Mon, 13 Oct 2025 01:34:59 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09a87asm10773251b3a.46.2025.10.13.01.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:34:58 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:34:37 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: add CTCU device for QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-enable-ctcu-for-qcs8300-v3-1-611e6e0d3085@oss.qualcomm.com>
References: <20251013-enable-ctcu-for-qcs8300-v3-0-611e6e0d3085@oss.qualcomm.com>
In-Reply-To: <20251013-enable-ctcu-for-qcs8300-v3-0-611e6e0d3085@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760344488; l=1067;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=r4zZxBjBVbvbXcB/D+W+e8OqRwsnVB6d/ZIuYC3/AKQ=;
 b=dTgAM397o822o2LVX3GSqKbj5db3ONamkKk+GoeX0PpDepoq2UzHAhdTaORBIkUNKIoPx6vZS
 u82cSjdu39TCQ5kHevAPZqxjciakCRPd3G9iR+fmc/gk3d7gxOdREiQ
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: XPJrvb7e0MSBHoj3vq9giTqB7OO1YGHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX0+6dVkGjJYzJ
 LNwz4Rhe3w6OeeD8A8leXLwq04PLcEdI42VfJWTOH4UIhgdbrXUeP8apLh1KQ4xU8BZBjexnEAP
 Q75YuLMaBo0tobZN2wk0c2GDmQhAhbsEvPwKjxP9EjSb4xrwYKvZNyw5YzS/ZHbJ5pqHWoiOai7
 NQV8DxSeEiA8zv+htiyUi23HGWk5Zz8falzBmLhHPWmhZv5Y1lMLbJTYxin+J7kj9hP1uHDnEt4
 HJfj+LcNPYW1fRNIhA9cmn6qNLot18Fzb4ibKYqTXl2p6J88z/JxBVMGSVJTMtH1cf+NmDU+4lR
 Y6Fi5MbBmbcSJD/LacBoDkObWvGgaopZV37yMU5iSVfBKCFzYac0nT0bCEmg1xCtOPujZ+pxaQk
 s1lQCkrBnjpuj67bbdWJJjK5XKy/0g==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ecb9b4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Y4MeR5hM20t4b5WVKNQA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: XPJrvb7e0MSBHoj3vq9giTqB7OO1YGHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

The CTCU device for QCS8300 shares the same configurations as SA8775p. Add
a fallback to enable the CTCU for QCS8300 to utilize the compitable of the
SA8775p.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
index c969c16c21ef..460f38ddbd73 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
@@ -26,8 +26,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,sa8775p-ctcu
+    oneOf:
+      - items:
+          - enum:
+              - qcom,qcs8300-ctcu
+          - const: qcom,sa8775p-ctcu
+      - enum:
+          - qcom,sa8775p-ctcu
 
   reg:
     maxItems: 1

-- 
2.34.1


