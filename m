Return-Path: <linux-kernel+bounces-722822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35863AFDF68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744CA582D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524026B2B3;
	Wed,  9 Jul 2025 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pjFXtt3V"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292E1F0E55;
	Wed,  9 Jul 2025 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039866; cv=none; b=UeEy7AjSUhD6kB8oqJDPGUMAgOM5vVMHjp/YC6Zvlt9YQtAlCH80HMqt7n7lcCLVyEG29HG2D5OkYKTFj6wHGIsRVtbgkOpy/8lP3HfvdM5Ul1Osr8kC+LyXNP8zywtgs6UC2/wpFq0nPD9olxqjxVJlHHxCAZgBRNBvITD/tjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039866; c=relaxed/simple;
	bh=+en811F95DsLSgBrQ+DNcrAUw2uUB7H4tVLtuoQXBrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oaty6JNCxzg6wypgl69m/om1zzQr0m0x+vnFx+KFJ/yGmlSFQmMBllNTKKk5ag7oJyan2igBABl4Y0UMlSpiPo+et7yIIKGmBt/znloVbGj+5d/5UZ7csVRTmcbUm7yJ+dDHRVdpMzkKYjgiZ5RegJ/XYaid9bRJIs/wMoVPCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pjFXtt3V; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5694R55U003688;
	Wed, 9 Jul 2025 01:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ShldH
	MjPVI2DPydp/HVsvbZg60irpEADiuu9P/gbsP0=; b=pjFXtt3VbirD2LCTpOmN9
	ofkoaCdYQOm0g+nP6fC7kna8VPJVxg3ebg+HmoFUFJful/N5pdmX9XfX2mnWczLg
	M/6EOaNEW31iBA0zxxK0EBX/XdpyTiI2lP4FXtderMEbDidQ8PV2DrZ7Gu+4oLqp
	apA6urFm2MnL3lqnTaXkzTJyn1vA2kcMzcW1ZwT3yH+m7GOMf3BsvrGbKHzkKJaf
	Vxyx4SftixWxlH79zEhf312+0oMrZzYEg4+V6Jdt7sWQM70p2kSSzWZacuIDISIj
	wHBvj7Ill03t3OE567DVzKn4KCaJd6ed8RHaP7u5Bd0LDpNjOOSRDn4dZlMSV8Uf
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47r7truq31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 01:43:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5695hr7F013736
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Jul 2025 01:43:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:43:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:43:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 01:43:52 -0400
Received: from CENCARNA-L02.ad.analog.com (CENCARNA-L02.ad.analog.com [10.117.222.48])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5695hQ2h024058;
	Wed, 9 Jul 2025 01:43:45 -0400
From: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Date: Wed, 9 Jul 2025 13:43:25 +0800
Subject: [PATCH v5 1/3] dt-bindings: hwmon: (pmbus/adp1050): Add adp1051,
 adp1055 and ltp8800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-adp1051-v5-1-539254692252@analog.com>
References: <20250709-adp1051-v5-0-539254692252@analog.com>
In-Reply-To: <20250709-adp1051-v5-0-539254692252@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Delphine CC Chiu
	<Delphine_CC_Chiu@Wiwynn.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Radu Sabau <radu.sabau@analog.com>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Cedric Encarnacion
	<cedricjustine.encarnacion@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752039806; l=2063;
 i=cedricjustine.encarnacion@analog.com; s=20250707;
 h=from:subject:message-id; bh=+en811F95DsLSgBrQ+DNcrAUw2uUB7H4tVLtuoQXBrw=;
 b=kLqq80Eok8HZRhd8LgV6J19653DC8D/MozNLFoiEjRPhy7TVAEFdOFpQoeFNUxv+mzV89q4BI
 IYWmK6FWBdKAXhpTvCz4kme6NXwHUfwAMg7GP6HJaVLu8HLpCkn+B/Y
X-Developer-Key: i=cedricjustine.encarnacion@analog.com; a=ed25519;
 pk=YAch4cyWjsctl/d3LfcMhkS/GNaUfXHkd658Mw3k5Kg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Ti2khRAnZBDH_ZdnzIs6jMY6U9TXh4BU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfX6ZmUAKSAFeYf
 MLc8Ea7abBMhgyfyoV8sGHofc5rWarKWWvMGhOh3qxL8H5YKfPldYAbdrYxTPKRsPusKFGKo7WN
 mBJdicw1OsCRk5ZhJN8c1AIe6xp53neklB8JmwScxA+MendDaDmc1CNxsOHEwk8ntYRMAHod0Ej
 QjQKa1zHiQR0Oh8NrIZuVxUV42KXbwbeM2c1Tonu8b/EZWWVSCaThn5GQ3A5FAq6m7hj3UV/ljo
 vdwIBYbhy5TQEsuJOwxLryJ2/kAbCj+C5Rw78UgO4A2WUqYBJg19lGJin5HT5l7vh1KuVEvkHye
 iyAELe0W6H2fSt5C2RQ+1ZG6h/6PVNXqg7nOyRqMoUCB5q1ofGw7V9L6rffY6JmDtuNLU+JTKi+
 dy4tbzPV+v4YXsJFCd8G3DM6/EC1SHR4XSq6nqja1aU8x8y4BKbAuS96HPB51mxlEo0t1bSF
X-Proofpoint-GUID: Ti2khRAnZBDH_ZdnzIs6jMY6U9TXh4BU
X-Authority-Analysis: v=2.4 cv=S8fZwJsP c=1 sm=1 tr=0 ts=686e019a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=uQMaZb2Ekduhlv2r4KIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PwgeYa5mr90A:10 a=-j3HJ--FoLwA:10 a=0pc8XKQv7_MA:10 a=ldT6tfO6ZOEA:10
 a=rpuT49WTWGEA:10 a=pLgm-7I7DJwA:10 a=i2LhTzLHGUUA:10 a=FDgeob9-QqcA:10
 a=Rx2Yj5WbVoQA:10 a=D0ly3Cs6lx4A:10 a=tq-JCwlE-CAA:10 a=5n0-O_bcIHYA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090049

Add support for adp1051, adp1055, and ltp8800.
    ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
    ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
    LTP8800-1A/-2/-4A: 150A/135A/200A DC/DC µModule Regulator

Co-developed-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Signed-off-by: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml      | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
index 10c2204bc3df3eaa98881085247ad2ff87f96645..af75300939429975e7151be943e976e265c45f02 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
@@ -10,16 +10,27 @@ maintainers:
   - Radu Sabau <radu.sabau@analog.com>
 
 description: |
-   The ADP1050 is used to monitor system voltages, currents and temperatures.
+   The ADP1050 and similar devices are used to monitor system voltages,
+   currents, power, and temperatures.
+
    Through the PMBus interface, the ADP1050 targets isolated power supplies
    and has four individual monitors for input/output voltage, input current
    and temperature.
    Datasheet:
      https://www.analog.com/en/products/adp1050.html
+     https://www.analog.com/en/products/adp1051.html
+     https://www.analog.com/en/products/adp1055.html
+     https://www.analog.com/en/products/ltp8800-1a.html
+     https://www.analog.com/en/products/ltp8800-2.html
+     https://www.analog.com/en/products/ltp8800-4a.html
 
 properties:
   compatible:
-    const: adi,adp1050
+    enum:
+      - adi,adp1050
+      - adi,adp1051
+      - adi,adp1055
+      - adi,ltp8800
 
   reg:
     maxItems: 1

-- 
2.39.5


