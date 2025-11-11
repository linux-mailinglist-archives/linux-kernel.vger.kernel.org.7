Return-Path: <linux-kernel+bounces-894856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 611EDC4C3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F40C334F6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503CA2C2377;
	Tue, 11 Nov 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UdZNw8Dn"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375B20297E;
	Tue, 11 Nov 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848411; cv=none; b=QsZuimPDBUqIhHfpgRhLTXieTz8NZMPR2iV2NY1y1Fjp+tOsCZkzcXIjw/PYTnEdypxZPbeVkHwdR+zJ9fOcIHZAUTgLrEpgIt85nrGlBpLoMQwOKEO/WWac2e2LKXsBdLgYX/UVJslozj46hU34Jele9gBGg3kcDTuQsQl2SX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848411; c=relaxed/simple;
	bh=ERDWDlrCR1OFZ3SFli4MLVKe8rnfVOHEyUysk2j8pFQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KuIK/Ynv8Oj73WPkFL1sM8yU9MOJptsZlgZefDJu9PjtB9zMqbPyh2QDT/I16eOoD/+0mqxHzFlZMaEeVw7xGUxEQpVOctJRaJGSprn7l04cgLZX51mV0aWkqpx/S0cnoAJEnKpZ8ocGL3CS/a9Lww0EwF76r5myxQd2MdtwdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UdZNw8Dn; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=x5D65oP2rnABI4e
	/qjWVaN+fcPwB+ZS72UKyNTmB/gU=; b=UdZNw8DnZqLL3Xxgy4CL8PDmEEbGzif
	z6Bnk04rHTe1RDJVyPZ27PSpbuGBrVyNE4NxiHpvbCTmRFoRjvyxJxkgTAZrFtwU
	QAHtAqjPav0w5MBvA2TyrPPa1L383MvEI7YqF5wsNGnA4NjXwhzDp6FcyEWk3pjl
	eSfbLtV734MI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S2;
	Tue, 11 Nov 2025 16:06:01 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: christophe.jaillet@wanadoo.fr,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wenliang202407@163.com
Subject: [PATCH 0/8] (hwmon):(ina3221) Various improvement and add support for SQ52210
Date: Tue, 11 Nov 2025 03:05:38 -0500
Message-Id: <20251111080546.32421-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1rJrWkJr45Gr4UuFW8Xrb_yoW8Cw4Dpa
	9ak3s0gw1vqF1xZayakFs7Wry5KFWfZrW2kryUG3yIvr45Gas2gw48Ka4Ut34UAr1xtryD
	Zay2ywn8uan7CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU-VyxUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbCvwq0iGkS7mpXaAAA3J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for SQ52210 to the ina3221 driver. The datasheet depends on 
https://us1.silergy.com/cloud/index/uniqid/6912826d13b9c.html or
https://www.silergy.com/cloud/index/uniqid/6912826d13b9c.html
The password is 7IUCLe.

- SQ52210 is forward compatible with INA3221 and add alert register to
  implement four additional alert function.

- Add support for SQ52210, add current registers, power registers, and
  registers related to alerts.

- Add support for alert-type.

- The LSB for current and power can be pre-calculated for data read/write
  operations. The current LSB is determined by the calibration value and
  shunt resistor value, with the calibration value fixed within the driver.
  The power LSB can be derived from the current LSB.

- SQ52210 adds current, power, and alert-limit sensors, with read/write
  functions modified to accommodate these new changes.

- SQ52210 adds power attribute to report power data, and implements
  read/write functions for this purpose.

- Modify the read/write functions for current attributes.
  SQ52210 can directly use its internal current registers to compare
  with alert values for implementing curr_lcrit functionality.

Wenliang Yan (8):
  dt-binding:ti,ina3221:Add SQ52210
  hwmon:(ina3221)Add support for SQ52210
  hwmon:(ina3221)Support alert-type
  hwmon:(ina3221)Pre-calculate current and power LSB
  hwmon:(ina3221)Introduce power attribute and other characteristics of
    other attribute
  hwmon:(ina3221)Modify read/write functions for 'in' attribute
  hwmon:(ina3221)Support read/write functions for 'power' attribute
  hwmon:(ina3221)Support read/write functions for current_lcrict
    attribute

 .../devicetree/bindings/hwmon/ti,ina3221.yaml |  16 +-
 Documentation/hwmon/ina3221.rst               |  24 +
 drivers/hwmon/ina3221.c                       | 516 +++++++++++++++++-
 3 files changed, 541 insertions(+), 15 deletions(-)

-- 
2.17.1


