Return-Path: <linux-kernel+bounces-722821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4542AFDF67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF703B7D18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F726B2A9;
	Wed,  9 Jul 2025 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SnaXe8NN"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D3433A4;
	Wed,  9 Jul 2025 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039865; cv=none; b=XmDw8Kv3tLa6t96eX9STQ10t/q7a2xE3ygwVpkh7YUCMOeRLLMMnodNKERff5zpblWRvm8X4Ox6TlYXZqmthDYdjot2E1KxzywTzd2SEHB+5O8G192nb/cp/ezoAqxLp0C2f223dH0TUHcbQJbSNxJ8ijS4TzBRtFjkQLhzF8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039865; c=relaxed/simple;
	bh=8l3zUE8MCFmxbc9oBbozzhc1z+lF1J8N31qJGH2KJf4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=p3ka2tLXzY61gttf5xPTMCsAMwn74VVOt61SnkSlsC4u3RRNW+PtwXSLHYwccw4FYV48JsrR7b2bkGR0120/CQ3xLQM2FRqOGXmg9U20B/w7lTl78TCcJp5FlYnshlt1ijISZ4Hofd5ssvBJP3Vx/GOfY17AiIeM/wx/s9SImh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SnaXe8NN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5694R55S003688;
	Wed, 9 Jul 2025 01:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dS5yEJ68ql/rKcDXFK5BDHKmWAX
	vXtDoVkublI+1lqA=; b=SnaXe8NN5L3kRMwmDkJFyY078AWke8cv963xtcDTfbK
	ecsEIDvQEk5pHJwDSWUPjP/sfw/8iP6X6xfSA2heXyUj9966ed/rIZ9BN6h3sqCz
	Ks3ZZeiEaYGgB/4XC3TCEgWNU76fgzm2z0GYyqZudx+2Ut6rn/cCq6Sg3PJwUn32
	jlmof+dGMybTRWOygNnJtEircXci9vo7acpwpjoC5nHcgug1RyVnfzrWW/VrCvoj
	8tFwlU86udcCvobAqEr7DM/ZMyAnFQVpQu++dAJ/xP1Ile9NXwAm4axwKcM8d5aH
	toBaQVwjBRk4M6kU+OF4+F7JkXuXe2smhVPT8fAGvSw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47r7truq2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 01:43:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5695hnrN013733
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Jul 2025 01:43:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:43:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:43:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 01:43:48 -0400
Received: from CENCARNA-L02.ad.analog.com (CENCARNA-L02.ad.analog.com [10.117.222.48])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5695hQ2g024058;
	Wed, 9 Jul 2025 01:43:29 -0400
From: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Subject: [PATCH v5 0/3] Add support for ADP1051/ADP1055 and
 LTP8800-1A/-2/-4A
Date: Wed, 9 Jul 2025 13:43:24 +0800
Message-ID: <20250709-adp1051-v5-0-539254692252@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHwBbmgC/2WOQQ6CMBBFr2K6tmQGKagr72FYDO0ANdqSFomGc
 HcLG01cvmTm/TeLyMFyFOfdLAJPNlrvEqj9TuieXMfSmsQih1xBBZUkMyAolA1BA1SaY96SSNd
 D4Na+NtO1TtwG/5BjH5i+/5gXqLAqygzxABKlZhOsvj3jaB1n7DQFRzolXMjR3XeZ9o9V3ts4+
 vDeKie1TvwHTUqCPAEClmD42FS/jnpZlg9Wk+xu7AAAAA==
X-Change-ID: 20250707-adp1051-ba0b0a6d82fa
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752039806; l=1933;
 i=cedricjustine.encarnacion@analog.com; s=20250707;
 h=from:subject:message-id; bh=8l3zUE8MCFmxbc9oBbozzhc1z+lF1J8N31qJGH2KJf4=;
 b=vgDV1TJq6Zo2V4bjicaH3DLowfnR1HFm3wi7trCr9U28srBLWqB+h1BqbrClbwjJ1lwKS1ExK
 FnQ/7cXFnoADBbdVGmr8g7oirmLQuQrJKOp9Dx8WZWh2B46Cg0smGRq
X-Developer-Key: i=cedricjustine.encarnacion@analog.com; a=ed25519;
 pk=YAch4cyWjsctl/d3LfcMhkS/GNaUfXHkd658Mw3k5Kg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: DHHRn8tHh_25GgFtVuKUyeQfp_T9lNxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfX3GvUj11yT+ha
 4Ju97Hs+ZB0v49RRfdg/p54vLMDZ6lrB8jmQtKHm4foigMsqUBQaWGshr/k0qAEJkDO+ul/Bp0h
 c+7pdr/OLLys70QPmPhm5hFznSywz7/jaFRH4vHvjUiLEHhzzlt+9y/z4dJk8aPxuVbZZ9eJ4Vj
 /kNUjzg5qjzWal21gQ7DSPvDHKvvq6mh9ODvE3p7mKLCah+ccmYm+8VAdvgoIJoc+EcdTlbsdGC
 nF8lyYSmntxPtjc9qXbMTin71rsR3vQ35K7PKFwmCQUucV5XS4R8KRhHLFHPG41QyUJCr+lzfb3
 WEf3fV1xvPBq6iIwbHdQ2AzRazygjNLEm63h8zplwvO35/cWphFxVweFOhjuasDxAH7wSS1vnJW
 YPguee80THeoTQ1m8UdSDF4nMPm1gBa8q5AvZD8KDDxnqErXLisPAg7SOqABMMzRmOsj7rUw
X-Proofpoint-GUID: DHHRn8tHh_25GgFtVuKUyeQfp_T9lNxS
X-Authority-Analysis: v=2.4 cv=S8fZwJsP c=1 sm=1 tr=0 ts=686e0196 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=ysQVOfK15idl-Fc0VSAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=881 clxscore=1011 suspectscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090049

This patch is a continuation of this series:

Link: https://lore.kernel.org/20241120035826.3920-1-cedricjustine.encarnacion@analog.com

which is a combined series from two original patch series for each of the
above family of devices. Both LTP8800 and ADP1051/55 have similar set of
registers. The series was v2 of one and v3 of another. Hence, as suggested,
this patch proceeds to v4 which succeeds the highest.

v5:
  * Typecast i2c_get_match_data to struct pmbus_driver_info pointer.
    This should remove kernel test robot warning about discarded const
    qualifier. Typecast is needed since pmbus_do_probe accepts non-const
    arguments.
  * Added missing inner trailing spaces. Also address kernel test robot
    warning.

- Link to v4: https://lore.kernel.org/all/20250124151746.1130-1-cedricjustine.encarnacion@analog.com/

v4:
  * Removed stray change.
  * Removed wildcards. Used the device names instead.
  * Separate patch for adding regulator support.
  * Removed const keyword from pmbus_driver_info at probe.
  * Added doc entries for LTP8800 in adp1050.rst.

base-commit: a41a9728941f7406a8035d0f19f45f8f3cf65b03
---
Cedric Encarnacion (3):
      dt-bindings: hwmon: (pmbus/adp1050): Add adp1051, adp1055 and ltp8800
      hwmon: (pmbus/adp1050): Add support for adp1051, adp1055 and ltp8800
      hwmon: (pmbus/adp1050): Add regulator support for ltp8800

 .../bindings/hwmon/pmbus/adi,adp1050.yaml          | 15 ++++-
 Documentation/hwmon/adp1050.rst                    | 71 +++++++++++++++++++--
 drivers/hwmon/pmbus/Kconfig                        |  9 +++
 drivers/hwmon/pmbus/adp1050.c                      | 72 +++++++++++++++++++++-
 4 files changed, 156 insertions(+), 11 deletions(-)
---
base-commit: a41a9728941f7406a8035d0f19f45f8f3cf65b03
change-id: 20250707-adp1051-ba0b0a6d82fa

Best regards,
-- 
Cedric Encarnacion <cedricjustine.encarnacion@analog.com>


