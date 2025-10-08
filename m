Return-Path: <linux-kernel+bounces-845821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4445BBC6395
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26EBE4EE1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60742C0F67;
	Wed,  8 Oct 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrTYU9gM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817122C08BB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946293; cv=none; b=TFQKroBGyXq/7eniXmUEajvzF3pf8z/BzSj5ixG1xev4iYpENbp6XH6PJw9aAVfdNyv7QEB9akP960d1RmqQNpSp17kPQ+oHzPohucKqw9II27D5qG8keR1Pc50vkXjfCmWEmhHmDswEfWxtyaGW1R/RnfkUbifOREym5VCWAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946293; c=relaxed/simple;
	bh=RwbCoddsvhqFNIlVCzJxf3Z4gIZGCQR3H9/+B5Bcmqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HE+V2LArfdD40nyI1l3INHt+iowGODO5z2sqqSRoEkVl0safKDDX57FB/KwnjBZ9zEJ4NXlGB89jeOSJyDLsADjeY6rzG5M2vqbJTvurMqkJjIeqwgXqUF1zRpQQXklN0nZ8xUe53VlG5sEUsqfPn317dCkVIa17RgneHgdBUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrTYU9gM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HAagX025399
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 17:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lkXBb6Qn3Fp
	d39i3QFA9/nCHMSToieZ6LJfRkx2X6fU=; b=UrTYU9gMwhzoCZ0leukHxOSXnlD
	+N+JtvPzPyw3LUMV/AWQnfIocKToaqxsPNMHkWjmKoypks3x3+QbBXVBDylArxNa
	L8o09pWj4pU+fBC0pZRBUqeqEwynZtL5fOePtd+vFzUG8pTX+YqKafjWK7I3H22a
	iHNK2pjlSfZCnIfzsHIHlJtstXFqp2uzhZO1mgfIcNjbKQXNVKSA+dFncUwJaoHe
	zj/bmJ350SKPT7modw7R/O7+OnhmQtADAeZpKckVRe0cTf7ytC5IlBLMNJsQFpEj
	WWeZQ7GzyqNv8dH0TzUXUeXgSOoO9okoc7HyJk/hi1oql4PgEJ93OKaTTVg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j04u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 17:58:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so20720a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759946291; x=1760551091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkXBb6Qn3Fpd39i3QFA9/nCHMSToieZ6LJfRkx2X6fU=;
        b=OVZDNmAE6z6XmFuJG7D2o/Bqd6QfvNyANxZjyYFcLURISKjoXgMlic3upibHMBYHUH
         tsckyYZsXtIoaqr7+5SQDmr38q0UzsM6MRaGq/v4J19C2j/J6+JTaoJCpG/7zrxSIVHN
         qXJ2opJghsqjyXnHtgH8LhaxcU993uXuzEEcSH24A6m8xaec+ESx5fp9ydKEq4PT2sv/
         t8qoBFrbpS1FDgZYha/X7Mb4OVQ34i9cK9efKsB/x7IICOJErVjYSzNo/Ma5STnL8hgD
         ++TsvdWA/toiPvX5icnrLsYhGMpa19sn37tTBAE3Z9FiNV/gV4EqK7Dpbetz5OkJL3ic
         zMEw==
X-Forwarded-Encrypted: i=1; AJvYcCVjLih0CGwbn47DEPO8RtgmAGsBCAnT+x685AwX5OEFyyeHfMS3wY7GYlLoOHWhqmpYYCp5R7YWZUgLlHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGQVLHiCr9tb9O4d4YmMz0tpTqAK0z6TA44qeC9YaxWuGDUJT
	VhFHsqzhj6iI2+a5aStKJe1c4ND2h3YfsDKocVmDgTm4u0BJJ130/S9d3qn4e18btM1intUADKf
	NEbIOA3ujuV/iSSkiN0RSTKQAMsr7awO7UKQw+52cdYH9uzvwaBQaQi1mzwDOLLC/mQM=
X-Gm-Gg: ASbGncucB7PDwb6BEGwnO9+PNQpeQb1EHQWWGP/is+j2QhdUvqYT8Z5DleZkDR6BNDZ
	88m2iu5S3kK5nAdkXtNwDpn8NWB9CP6XRc3Ic0Wsuj8s/xWaddpfmA34Vn5bfa7gZ5T5L85crNd
	u6aTaZC1MRli2lVG6ClnI5HNN8KUUzV80pN9GgDt5Tow6LFZ//5TYvw41sSkzLsXLXmRTlgl+29
	II3pN9+21zLfklhnpb0u4HuszdaS7psFzzGD2HCSwN6Dk8Uel4Idk5eKAaxnE2xI+d9nJh7Wwuj
	wPjaDWStxtrisfmiO2gAdkfy+1Deo/hg1nNZ2q6bPMe9UouvT+WynNTMU9rN/93MblMqIjqWKgh
	Y9HlY6Bw=
X-Received: by 2002:a17:90b:3b4d:b0:329:f630:6c3 with SMTP id 98e67ed59e1d1-33b513757fcmr6324289a91.20.1759946290554;
        Wed, 08 Oct 2025 10:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZfxPRPNsG1loVsGvZmZ7cdfpqeKee74VvwcmYy9NZBEdDSgHq7Srl1DuZFX9pBYhri/nv2A==
X-Received: by 2002:a17:90b:3b4d:b0:329:f630:6c3 with SMTP id 98e67ed59e1d1-33b513757fcmr6324262a91.20.1759946290123;
        Wed, 08 Oct 2025 10:58:10 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f51b5sm1275726a91.7.2025.10.08.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:58:09 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
Date: Wed,  8 Oct 2025 23:27:49 +0530
Message-Id: <20251008175750.1770454-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
References: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Hb_M-RzZMesCxhp8ULnYEU632Hei8gHz
X-Proofpoint-ORIG-GUID: Hb_M-RzZMesCxhp8ULnYEU632Hei8gHz
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e6a633 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=UO34u3PHWDRxg_ly3EkA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9iT2JqvMIGWb
 dNUobniFShjzskZcWtnXbrzj9npi4ekTs22LZrWKwovGiZoJAAFQLpA5mWHhbSSHboJJFKUX+0t
 X8bH5cWMZwiKQh8iMkAz07lkOu87Iiywpr3BbDrAiIz0M1vKqyk8SufgQNdJN01HoD4w4CPfg19
 FaTXktDspYmHhPthqhn9L49/tKdiVpW4qgylI0xDfOHosFeQkMeD5McajgEjKfUiPB57a9sk4UY
 0MLHJqNtsOiH8bRdsws65HOmDF5Ptj9PLlrPBClCSJGE8xpSoR4JP+iy390ZLXaEwCrNAYzzk3I
 hF0Pg8RkVeWL6fJVMT8dqP7umpe8sawkFeBkdVNX0XIqMPExUiiSBWplmxkLBSgFjFQ6P691uIr
 e1FvV10eWf3Wem1LTtSoLoUMl3kMqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Update the bindings to support reading ID state and VBUS, as per the
HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
VBUS must be at VSafe0V before re-enabling VBUS.

Add id-gpios property to describe the input gpio for USB ID pin and vbus-
supply property to describe the regulator for USB VBUS.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
index bec1c8047bc0..c869eece39a7 100644
--- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
@@ -25,6 +25,19 @@ properties:
   interrupts:
     maxItems: 1
 
+  id-gpios:
+    description:
+      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
+      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
+      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
+      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
+
+    maxItems: 1
+
+  vbus-supply:
+    description: A phandle to the regulator for USB VBUS if needed when host
+      mode or dual role mode is supported.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     description: OF graph bindings (specified in bindings/graph.txt) that model
-- 
2.34.1


