Return-Path: <linux-kernel+bounces-837127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92806BAB731
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04A91925A72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541926D4EF;
	Tue, 30 Sep 2025 05:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JoFiEYep"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40926980E;
	Tue, 30 Sep 2025 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759208588; cv=none; b=bsL2YxVAVf4XfRyWdUl1w+7/afu5ZW3kQ/Kw7gtQaLQrFTrtolyRQ9V2U+Em2CeYluNfe7bHoREai4bk2TGvOzgmNUdGP1IuRza91hK7LHxZozAyze2m7a9wXQozcWWHMKyP3m8b6fAaBY3eXpnV3S77gXZRbWEMKMu+bzixOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759208588; c=relaxed/simple;
	bh=kwmFn6/yoz6PQm83SQd8AldT1eBNl3JcTBZ4c0muq0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bge3sIo69SAqIT/wqhMpWQp1P3gQVnJQwRvMUDFkL+jEen1Iw89+wiDWC7G+2aqHTw1N5oIEvS32G5+FHbtDgbCUw59nigOM9d+PePRgykVJAiUoh9fk1mrONK9J7l2QMy4qa/dJBFP/QBoWCRi30iZait/Nqi2Tm9A9SKliSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JoFiEYep; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U2NRUJ000984;
	Tue, 30 Sep 2025 01:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cDQqA
	Cq5sMXHa+dUB741yhKXZr+FjyNpn7s4zCg2qP8=; b=JoFiEYep/F63XsYScxqse
	BHJQuMywWjzgOY32ECxj4Nh+liTTbZ/PrQOC4ePtaJ68/avs4HZXecbuTzJ6kodn
	U4fPpRiTUyRZzO8yvk8V67i+K++We5XgX3qFuRwTFYIYeHLq0r+hd1eqmokq16bF
	wGuCnbSNECWJ4CW3n1E/ywPiJDz9OHyeCe+BHNJCMvAZrS5g4aK9tXlR0nDdGzv7
	36Gvc2nSBx63yvSiUNusCdQv5YhkWtmT/DIpF6TTmUaEJxa2eP0gLGKs6BQpb2+S
	cfDGb4DcsT5yPSkm0c3UezDwno1oWn/xsAC2L24D+0OqqnBcUAWKs14QDOIpUgJE
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1pdeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:02:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58U52odR050880
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 01:02:50 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 01:02:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 01:02:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 01:02:49 -0400
Received: from [10.0.2.15] (MDONATO-T01.ad.analog.com [10.117.223.49] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58U52YIR032686;
	Tue, 30 Sep 2025 01:02:44 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 30 Sep 2025 13:02:20 +0800
Subject: [PATCH 1/2] dt-bindings: hwmon: pmbus: add max17616
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250930-upstream-max17616-v1-1-1525a85f126c@analog.com>
References: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
In-Reply-To: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
        Guenter Roeck
	<linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759208553; l=2634;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=kwmFn6/yoz6PQm83SQd8AldT1eBNl3JcTBZ4c0muq0Y=;
 b=DqbP00Y111V3tcZx0xkuBN5AnEaSCVAAjvg4uDJPAVt/PKDBtL6LLJcEVLnBu6+By+Kv3U+1A
 t3pTk8nT1zcCtZwC/9Fob5kIH+aqK46NsATOmMDIGJwqUsptmmzVFTQ
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SYmSuSCg3q_D7f6RVuPlBXKTVUtxjo7o
X-Proofpoint-GUID: SYmSuSCg3q_D7f6RVuPlBXKTVUtxjo7o
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68db647b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=4i-kALol0hWjxpoBZl4A:9 a=QEXdDO2ut3YA:10
 a=Q1iX6AfhfpQA:10 a=N8EekOp1JHsA:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfXw8gashBo9FLX
 9+h50yEXTyBxVKy6htRV4ceLtHyfcfB4Xa19ZeJCZdhCWoQ7RZ4WVMW9i8sujiyZ2teMPRWu8K2
 WJYRJh8iEVqn6Hjv9qy0d29WJlsTsZl4o/nWKFoAXh2gJ9Pqd/nmFzpwTWOnEQtXAFfGveaBb+f
 LflynoRfuUZPCYk05w7Vcqodj/HKsKcTze6WL21fccK7tW0h/J9MuJMTeTYp9GeB+14r9cHh5H1
 Gj7BidJC80eTsGSXAmtF7wT+00ZZihBXYEQGIMQle/2+OVJsCmsP8kEOLLQmAJ+yNsZ6tNJAy8Q
 pTMakbqvC/Ua1DzDTrA28wkUxzIFrQSSOU3gQhMIG6f3QHGgBLEQpu+9Rnkfs6AjHHLw1hxPgNw
 9NG736pxdCwbFtUGEeo/XhutYwlPow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

Add device tree documentation for MAX17616/MAX17616A current-limiter
with overvoltage/surge, undervoltage, reverse polarity, loss of ground
protection with PMBus interface.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/hwmon/pmbus/adi,max17616.yaml         | 48 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4680d354af0ef706bbd90d2546f5f25149654b6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/pmbus/adi,max17616.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX17616/MAX17616A Current-Limiter with PMBus Interface
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+  The MAX17616/MAX17616A is a 3V to 80V, 7A current-limiter with overvoltage,
+  surge, undervoltage, reverse polarity, and loss of ground protection. It allows
+  monitoring of input/output voltage, output current and temperature through the
+  PMBus serial interface.
+  Datasheet:
+    https://www.analog.com/en/products/max17616.html
+
+properties:
+  compatible:
+    const: adi,max17616
+
+  reg:
+    maxItems: 1
+
+  vcc-supply: true
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@16 {
+            compatible = "adi,max17616";
+            reg = <0x16>;
+            vcc-supply = <&vcc>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e314837eaa4168a66b9077dd8293433a378abe5..89d35faf93c9d2e984b73f5c09d09044ee6eddb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14917,6 +14917,13 @@ S:	Maintained
 F:	Documentation/hwmon/max15301.rst
 F:	drivers/hwmon/pmbus/max15301.c
 
+MAX17616 HARDWARE MONITOR DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
+
 MAX2175 SDR TUNER DRIVER
 M:	Ramesh Shanmugasundaram <rashanmu@gmail.com>
 L:	linux-media@vger.kernel.org

-- 
2.34.1


