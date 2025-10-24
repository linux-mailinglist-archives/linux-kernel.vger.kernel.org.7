Return-Path: <linux-kernel+bounces-869374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8AC07BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89015400304
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A334B424;
	Fri, 24 Oct 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3Q96RL3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329F348861
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329938; cv=none; b=t4CVZZj3BSkV1kMsLgflHGB4ZKHZoF2vv8DEs6XqxpTxAwTzuofn0IU+zBgMsjLfVWX8dUL3lo6ovJkWZgZvBCdGVW45VC9RXArPdazhpXewsKpoPHCRfSKo/dI6YWIgm2LyNjdYoHosmkx35o0af+KlnB/pdNsQI7ucZ6VFdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329938; c=relaxed/simple;
	bh=6LDCzDAorQ1rdxr458tviaygajHjm49tspDBIZwnE5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYinALKOJSTWliA2VfHpBqmB7Y9NNcQn9lEHVmpRqoPfWQL8ntsAefLPIJHzagIXVfDlP1GJjC5ehmJyKzMzD/zr4tIWClkJQFy/UwtcP2FexGM2wkzaXrTn5UvXcI562X2DXV/jsAvRJShbNTo8HVtIzDdEcw64Hh7sfPo1s5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3Q96RL3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9Ihp028820
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pfNn+iLNbzS
	vPfiCGkJrd9fqTPoz6zfOgZ+31wHMCWk=; b=U3Q96RL3t7dGVLwFclEVlwj2lz/
	k+v8zwf1oiDCekiNHf5bY5vK3+HHWLsmQaOiT3s2e1sKph3pFRcPNijXvOmkyldc
	8EKraDbGOHPVc4o6b54UyMKfMU10dxpWepK5ubrTQEg7iLOM8TzCK60k0pEMtfEM
	OUlxglspG/h1iNQuVgJg6RRbt41r9FGqRfcjBsRC5bin1FHDHcDGvh8cBDi8DXKz
	W7aJNJlczEfC5Jr8yyp3XToDVQfkiGZ8xyR5liJ9ABmKmyprqH4bC9WA09wEDvn8
	K9mQ6d4YOIUMzwrM1TeZGxcg+cfMNJju8lKeltlFdW98e81C6dk+mNYlotA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8cv79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:18:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ce25bea3eso1692636a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329934; x=1761934734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfNn+iLNbzSvPfiCGkJrd9fqTPoz6zfOgZ+31wHMCWk=;
        b=AaHQO7auXpd7sqBtuh/Jv8i24D5XWNvABHbiFXaMi/DSAJt+vOc2x2aDrM8pLwy0mA
         teNNpNz0RSeF4HY9fgtP0I4jbc3g+JRxq0IZGLfaKOgyTNd+j2b3wifMkOF72++undKf
         ZL4wqhnYQ2tW/FAkpIEhy5SKvLKmXsAyZ0kXNb68uGZAi7nSj7H//TPwz/lFx3dtHpTR
         X10av++y7NKZhyUcNP9wBjmZq6/OUg9EGdxhKhJK6RfbDQY2XPbsu0y7miCGAWls0lls
         ZNuzi1Bir4zosX/fEV4gTQDFOO7m/Kp064NmM3v8pMVBRYSb+Q0vhoWU+IiCYVBXecKy
         B4iA==
X-Forwarded-Encrypted: i=1; AJvYcCUrkk7P6iq/CeeWqn72+YpHftsmAMeeMORcVRx+YbZWc220bbtO3AppujKAG4LxVkNwGWSDbs+e0u32Snw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87UkiesVVkeBONKfLbVqv0slNsT6aONWzkww6MtyoClhNLjnQ
	rbJAlZ+yrAK1w/8/qK4hgfBqwubi3AfgnZDDVnbw98fUxztnivM709P1C2uZHb0DxXuVNZqWdIJ
	OMWVKYm0jmGRynnBdzxcHRkQUddjw8XQ7fzSmMzGAvkMx5jNmDWrhuR5206myzKmgsqQ=
X-Gm-Gg: ASbGnctxBRkWTZAm9qwVc0R85SBI8JtGI2GiGSaasL0b6+lAKXXLDLA1sHyp87dNybl
	JsLMmfjhZ3wiTNOXvs1un/RNLWRbRUAqSXsv1Vum83c8qp5b+muH4u8pqTVrpn04vNUo8d1Vywe
	Zy1Q+upUxAD2Hqq77hGnTSt4ltp/YLGVFCxdpFk6KBDxb7MlJNL0vr5wQKLxmUtuKltRI+qeTze
	BwTIggd1enoCFCd+fZn5UJ3HuJrc/6RttwEQ1jtvRJI18CoAvA7P2Huaq1pLp/0l5EiMCPROPO0
	daCGiqu7+9+Pj9bvzeq+4Z4AvT9oYDaOl5ZM3Hf78R38nlUSW09P8gnyjWpUrtADrRdoDWGiG4M
	u97FyKMVKJGzfjCcD8groLXWw43e0gNiYVbgP
X-Received: by 2002:a17:903:2305:b0:290:ab25:2986 with SMTP id d9443c01a7336-2948ba3e9b3mr47364215ad.48.1761329934101;
        Fri, 24 Oct 2025 11:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELcCDpHEgvvYzQ0bQxFdSUCPv3oQqtjRlEyx2hfO6qfAnTDcaIuKb/rUMuhz6fYiteMAdjEw==
X-Received: by 2002:a17:903:2305:b0:290:ab25:2986 with SMTP id d9443c01a7336-2948ba3e9b3mr47363965ad.48.1761329933695;
        Fri, 24 Oct 2025 11:18:53 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfd0405sm62398045ad.66.2025.10.24.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:18:53 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
Date: Fri, 24 Oct 2025 23:48:31 +0530
Message-Id: <20251024181832.2744502-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
References: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXwtn62aNpLj5U
 4r95OJw0qsIk/5UvmcY5DtVl5L6cdarisVmc1KsbaZx5F/UTQlFGHjlxascMoZFW0Tfc8WxFb4s
 3r82Q3BtI6hzO2jn5P8d93Z0miam9Pyclgh1xmllo+tYDhWqFlWf/XDk5dKfkGWz4mU8Wsos97T
 XXbM0o7/YIuibxD1pX/EGBfyWyn9HJ9W6BOaiGDEtVk86363p2lfRHnpZwRDgZjMuVoknMoYP42
 TjjMQB5IvNNy6D0weQIxC+03R41lJWCJUvI6+Gts8zYffI35gsbajd9VO+UAw4FOpTmYlV8tH3S
 68cAPPNpNiw+GsEf6NfRdOv2wscOyJjN1FHrTODPfMbhlf2jaLHsMy1+wl5xNXJJuuAPZAN4sb2
 tVhknupM31iCzLj6HWs9SLiRQNj9MQ==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fbc30f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=UO34u3PHWDRxg_ly3EkA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: xzIOTToWIqx6UXQcQ_QtaRaA4FVlp26i
X-Proofpoint-ORIG-GUID: xzIOTToWIqx6UXQcQ_QtaRaA4FVlp26i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

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


