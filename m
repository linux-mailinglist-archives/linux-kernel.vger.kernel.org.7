Return-Path: <linux-kernel+bounces-840566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC03BB4B12
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB47164E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B6275860;
	Thu,  2 Oct 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKcz0PIY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F842701C4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425959; cv=none; b=rP9rEH1brrD0SFPMYkFKtZ36BxGuJFNcqZSFsmrVogbwL/M/efVAWnlojNpXDmR2dIfRRszft8k0ExvUuPYEoFwfSTeHNrU4oxCaaMl0DKe2msEAgfdc6V3zRhMBiXzerUa7EiiXzR143q7XlPr1C4yvRGWtTYnDsA4/43yHtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425959; c=relaxed/simple;
	bh=RwbCoddsvhqFNIlVCzJxf3Z4gIZGCQR3H9/+B5Bcmqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=no7Sp1cBs+sdQ/W8vQMnW0sfaq7SSNtVv8NNNT4fhTKyZ9suq9XXZZk45a/LXqJLEYmA7HfBRYeXkogyLUKnhlwFY4G8WaR8dh+KWyeN+WtesxcX2T5gA+JiZOn5IKDajfFy9Ln9tUUlOSZZOwcHghWnoEcsijWeLs9FA2W2+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cKcz0PIY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929aN3p023589
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 17:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lkXBb6Qn3Fp
	d39i3QFA9/nCHMSToieZ6LJfRkx2X6fU=; b=cKcz0PIY397I+UiGgwq0i2pKg0w
	0cxZv1HcNxe4OWYw7zh0D6pOIJieQRD5SOg5C5begmrFIcFy1yH4vTvVv8TfM6Zs
	Z3N4Q+EyI5mD3ZvigNGtikL0qm8LZJ/yepmtuR0HIcgqLHAn8a1Y9FjgUdYx3yoU
	t2NZUCv0u6QGsv8XcNBTQX3Evgn1JZV3UzDwMgR+XogYrTVQMoDkJO0QHeESKKgQ
	1mFXURXtfg1perbjxEUmFfnPKWWtNubWzm5bkDaMWADR5YxrUginh3ExWM+A50jL
	j8CPWBqjBXYRKybf5CvFneuGhDu5yzUgAYcX5i24txY9ajrpoMU22/3uVvA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a68h4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:25:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78108268ea3so2310839b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425954; x=1760030754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkXBb6Qn3Fpd39i3QFA9/nCHMSToieZ6LJfRkx2X6fU=;
        b=wIL+PQI6pp9olJWaikSXtcPe/BY5wZdJWFmihVGqM2JiSFDA+tQEQZLp+Pehd7byeH
         yH5qhJr1B/J5ycUkntsFxjkh4V+PIEoP82sYasAghjYKeqwIkGWQDau9Oyugg9VUsTu+
         JAL7/u89rLat38oYRaOHWTCRA1U4eohuzPHkdU8kf+P6qluCmuJ0sr9/xeFJP7a67eFj
         C4LHWKT4GOrvC8CYrl6DpaB8ZPSnyddHrR0KWelkrepS/fX6StJbU3/JUV+2PsnmFRGj
         UTVl3urJBJfng1FnfgsLiSgEpn6TKWNzmqOYaujhFy9g1obDQ2iH2M4jU1KatLRABEI+
         1uHw==
X-Forwarded-Encrypted: i=1; AJvYcCXQJbsaYSMiWviSUf0rGbqd3c2S6xMgc8iW4h4ebegRSP4ro880kcHY2hXUH7d1NoewYZZjewTpVo4qiMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfmm3/mi8gwo/i9qMwssgdKMxjDVAi1oeeBkiTfp+vPEDHLTXk
	H+XEjlnSdgHXSsTdCotugd/tsA2E3dYGLDolm0yFmcCWTynB3BH3n/e1/ptBu4B22wa/IztLcna
	X9BgOsiaVnFfyLwemDvUWcTDOHiDSRa7hxRnVEVocJpyF+cm7LGSQlLgukzEq5ijWHYo=
X-Gm-Gg: ASbGncvzP1Vzj+gSTnvinryh78GWYQ7GKcO6Ctzg1BofWdUvVAkJkYM9lZEcjPy9+bL
	x+NhHO+FlQDjBzYY4BEhFTfqIE7+DDxodemsVMqiaGwh1iIupcyrrEhcLw4Oqp0vtBdc8GACvvS
	OYn983yfkfXZUO0Iv+5iIB2+2rCXvZrCK4w78VBv9qQoORE7jl4iiDmmsDVdlW27LCQ1Z9j5FQf
	mWB20GR/SskZAfjcbziuV9iasaeBnsmGIhEAFOtWvRstvAz6PrhHXfQb0L0mUcGMO1m6LrPLG2Y
	VbDzkVs3Ah6mBoR6TgmJ/X4PxZXZftL96XMuGZWn1YnL7hwU/FBIhAquT50ZM+b74y+LZsuZMlM
	jf0bb6W4=
X-Received: by 2002:a05:6a20:7d9e:b0:243:78a:82cc with SMTP id adf61e73a8af0-32b61d9e0b3mr278969637.25.1759425953835;
        Thu, 02 Oct 2025 10:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWExLSIWzbs+KwqVHiI050o0naTRJriHcJSbvWTXSI/V99qkoY2m4Mo76h/bhlOiZHgo0Ihg==
X-Received: by 2002:a05:6a20:7d9e:b0:243:78a:82cc with SMTP id adf61e73a8af0-32b61d9e0b3mr278946637.25.1759425953373;
        Thu, 02 Oct 2025 10:25:53 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f5b6e9sm2387423a12.40.2025.10.02.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:25:53 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
Date: Thu,  2 Oct 2025 22:55:38 +0530
Message-Id: <20251002172539.586538-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com>
References: <20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68deb5a3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=UO34u3PHWDRxg_ly3EkA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Wz8fwXtLVfsAB29ZvLJCfhzCA9HAYZLn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX82Dwh1tbLnOY
 x55utlKo6HJNxNpBNP0T8bqfJTTYhztlQaH0kv6KxFwy3RTNwucHZcKajKfeM/bu0l/I2drXEmr
 DWnZaqBnqGr97/jVfIaxXG6iSrByEn99NUApxlkOsN+OVWBTp3dgKHc3OqEvs74sVE0svCF/QpJ
 I3Vgx1fjFABi3hiqm3uuoD1OGmUX80OnFFrGCOW37oITSarh590T2Gs9V6oWStOSrXBQez5kTqE
 ECrqA8LVefUQ2vT6ywDeOVRoZ3KEG2UBLjaojDR9wTPltjTyb1j7UfqR9VSsai76D/j1tPEzEka
 sN6+QZ5r4MGtwBa5LF6SB5SHcALaT3MSu30TWrwqL1pqRmCT4rzG+tPccQWjV0pVwJih+awPnFX
 ho/4m2TiHCB4hV/UX7VZxTTKkPJBJw==
X-Proofpoint-ORIG-GUID: Wz8fwXtLVfsAB29ZvLJCfhzCA9HAYZLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

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


