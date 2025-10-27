Return-Path: <linux-kernel+bounces-870975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20541C0C20B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD453B538E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229242DECB2;
	Mon, 27 Oct 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DBBJsi2T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10372DEA80
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550078; cv=none; b=lIzlr99nlIIzDtL+2z/mHW/GqI+dgGfbiAutmAcbIMexK1HSMfh8jPIn15JWY8Xwa7KUJT5OZYs57N6u57kvrGXZqtRxGEiOjexRLeQ061xeWDNHbr/vaY2ZCiGM/gil7fnSiQ58Z40TRK4G6u3wPklN/bOGL+LqmRsQtTsbemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550078; c=relaxed/simple;
	bh=6LDCzDAorQ1rdxr458tviaygajHjm49tspDBIZwnE5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4a6ZYBYyCYo71FOqMbrhcRow7tir4OpfZfKC16hHj5yA7W9L7TAbTR1BX7o9LrvSiV1U2ccQvyIXamfnP5uS+dq1TG0e6ry5Q1idDTIY+SGPr3S7YcpzlcCBVM8ARLAhw25tia7QhVM7ii0k05j5bk0tdR3NCACHlXd+BPd7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DBBJsi2T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QJtDpq721608
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pfNn+iLNbzS
	vPfiCGkJrd9fqTPoz6zfOgZ+31wHMCWk=; b=DBBJsi2TGTXUrBQ5CwsJV+wNIMd
	uSWiWGc1eCVFIOBbQqzesBMaytLxQxHznZv8sLEH7HSNda3VPi9JkyV3UGuSxfXS
	vBJzoy7APDS93ot4L69ND/yHLCBiqXQCxki2WIQq2vGww9CuHCxtJGxZC87FBr9T
	tUe2y+gy2/RB4XRqBaa+zubXaXT+IYKO9M+Y4e5r+mceF7zFnkSijTPWYQK9GFDd
	hEMmBb2R3uaCHpHfRCV+O7m/sdbi9CGQyn5XilVVZDLav7JzPLajyXUI6/1NeeER
	dWNrGiDzRe6lzZuV8q/+jJf+l7gRTDp04uzT1W2bnAYCsXiAYX3/KsGep8Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nkakqp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:27:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909daa65f2so62361595ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550075; x=1762154875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfNn+iLNbzSvPfiCGkJrd9fqTPoz6zfOgZ+31wHMCWk=;
        b=WGhcZWim0oVHvUwYTXMugcdxeFRIaFgWyYpq/GMknhi8e7VV7ZbRs6Vxu3xd5FSe7/
         yCCtwZ32JSJhnQEEjNW1cSrjtZoiT0Es3bZTIYcPjwrvQIC3JSUQDqcOA5s5v0uo5ToN
         trf+ABaQuh6RLHDdwyFXJRIXA8OPLvd5FXNy3l74ziX/0FnvyPsFusNBOC87godC4NkX
         uNHXGewhNW8wPJJqmwuxmdsLd0PAQHbe0y71IvqtK76s0jTq9qaa8+Cio4zhyYKhoYg+
         T2TrAeRCXH1zoiMEZIkponQTxSI1VC14j+kdl3EWilQkMDGDo6azYamUW8NM5kduhlda
         p2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXyKJJv9lSSPVztLC1Jsx3KPH8WFT53b2dAmlodImBuA/GxnTtWerUU4kjAFu+p1o5WCa3/uA/zqfwmMEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFowgJvwzZZtqEVCRpOUiOHqJR1esM4QWhHCiXqYaHzNkpegS
	ebg6hBneoOVgKLdbZCTDBE37OuArCKNY/h26MZCaafZ0dieHIvPgzxD7nwXEpoN2XZaS1XVw5Br
	/YFdwudlhfWVLESNaip9vVqXHs7427gRrE4QMVb4GqZXR8HWDv8cZlkqlA4FFHb+XpeI=
X-Gm-Gg: ASbGncs/GcEnSqNRTUGs5+PBimPplFEM1zXzaGaGPnnBp76Amx2DL/BmU8PYPTwE32x
	+3ryq8A/LrxZbCC4zJk62jeygrQzujpUhTKa74v8kvYuOjpxo5LpoL9FbjK+q5/rceomCsjFCAz
	9RnkWfocvNu/jbKRRt217EbJ28eWcO3oxZCquK/FDNXWyovzTNDc/DI7y/mpD58tDi6qRS1IhEY
	ILgvSOWzGjkFVTxCGJzTiBbZJ+k3yAvnRZhW+5azb0HTaBw7IGmhToH+1K7U4wwzetw/7utkbyR
	QGERMqRLHT90QyHeUDa2A0VwgdIXtCWoiEugGiWc2yh5cP5ENmVoxDH7/z7nXSzEYc6SA9LlezD
	ciPY/BAO0KRXtw6KKTuYSC3VTvL0N9mX1vXGJ
X-Received: by 2002:a17:902:db01:b0:24b:1585:6350 with SMTP id d9443c01a7336-29489de58e7mr139709445ad.11.1761550074731;
        Mon, 27 Oct 2025 00:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErnim/Iv6lmBiXWwurCecPduLwzutGfUUJGbDO9Z4q0f0NCLEl+9OKHSIGj8rm5p2/pK/hmg==
X-Received: by 2002:a17:902:db01:b0:24b:1585:6350 with SMTP id d9443c01a7336-29489de58e7mr139709215ad.11.1761550074235;
        Mon, 27 Oct 2025 00:27:54 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e45a4csm70710965ad.108.2025.10.27.00.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 00:27:53 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
Date: Mon, 27 Oct 2025 12:57:40 +0530
Message-Id: <20251027072741.1050177-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=68ff1efb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=UO34u3PHWDRxg_ly3EkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Cgyp1KCpiyxK6gAJuHots0xbIQ2IJsKz
X-Proofpoint-GUID: Cgyp1KCpiyxK6gAJuHots0xbIQ2IJsKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2OCBTYWx0ZWRfXxRm3KwQMN9ZD
 +G9hdASS5z1Q+ht+vTrunhA6YlHFgYFynqm6050U+dmvLAxqQXuJpqkHFsrN5BTU2X8ZuNIuSWy
 GLcNi5zbw2CAQAjxQ2EB5toHIN4ybMFgAlkq1bQu+0r2EiBc3/9bBCKp+NnUWGCFukh4tqihCo6
 V5G5m7tF0XVyplyRbnnndi3jM0NNMSwvX+FbomZ4XjLe2gWRNoRtWDGRC42Xge1VyD8QCdYsHwR
 TyILUP5dDBXWlU1MGXMIb4di5CY6vffvJrCrADHs3k8vJ03kFnQuF8A2ZF5BjIXOy2+b6qxK4aS
 rgZhaKRiREcNPbKwuEor8iH2U9srI0tjU9OMoN3TuQKRPzAd4x+v2XghPBy6Y9KIDm0H+snPDfR
 l0cpogmlDvxFhfslBTkxYD+/+Civ7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270068

Update the bindings to support reading ID state and VBUS, as per the
HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
VBUS must be at VSafe0V before re-enabling VBUS.

Add id-gpios property to describe the input gpio for USB ID pin.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
index bec1c8047bc0..06099e93c6c3 100644
--- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
@@ -25,6 +25,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  id-gpios:
+    description:
+      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
+      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
+      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
+      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
+    maxItems: 1
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     description: OF graph bindings (specified in bindings/graph.txt) that model
-- 
2.34.1


