Return-Path: <linux-kernel+bounces-861496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E38BF2E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F3C3AB638
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D6D2C2368;
	Mon, 20 Oct 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="tDqGSyE+"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1E28C860;
	Mon, 20 Oct 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983834; cv=none; b=ebm2WafnfQ/QTG4nSy/wZl9LcvxKbUzj9hHBb2xzVlnaHff5/2phYWv8LU3nUHGWJ5w3uetFd18Ez/jCN4PywxIehaWJafl+SNp9X1jUhftekSfXsd7o7THckNpYcioIBO/x5ahouKN6yD4wVQfYpwJruOBxxLh5f13wobSSS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983834; c=relaxed/simple;
	bh=eUbDMPURrhP9DNsR5OBvdJaNQ3FAZf38xxL0jsa/SXo=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=s3r+qvc1XQ5Ti5zuHJmEDmgwhkvJ/HTg4NmUn5Qtc3yb8+JPJUzHI4FrZLq2i3tuVRHdhZ+PAyina1SSfiF0rniBi5vVdt1woxVFFF2ew459Juc9RIckitEigJ7Sc5+P5Xz0ad5+diVlt6+j5A2nsLgt6SpbPMm41a22Ap6ChNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=tDqGSyE+; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E21C28288084;
	Mon, 20 Oct 2025 13:10:31 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Bd_fnKAO9RhY; Mon, 20 Oct 2025 13:10:31 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1DF7C8288904;
	Mon, 20 Oct 2025 13:10:31 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 1DF7C8288904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760983831; bh=Fy1utL3Q9olsaRKZoig3w/Z4nh+QktLTjEXYbwEyouQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=tDqGSyE+Py36mGEhqeYWKnygMvlz9/brHOAmv0TR5/FAOQ0YdVxUpYYYSeypL6rmP
	 KmAqiapNe8rDCgrhIhKA9CCu0f5QdDE/NVpht3V/TyvYOjAKAraycpu45U30uubR6B
	 w0UmK69earGGi82fq3rc0am6TF45mRwZc1eDqBTI=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pxiVZHTDFFqO; Mon, 20 Oct 2025 13:10:30 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E81BD8288084;
	Mon, 20 Oct 2025 13:10:30 -0500 (CDT)
Date: Mon, 20 Oct 2025 13:10:30 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc: Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v3 0/4] Add drivers for Sony Cronos control CPLD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Index: 2sKQBCK/cFq8bcVeB0FycJRZCrk72g==
Thread-Topic: Add drivers for Sony Cronos control CPLD

Hello all,

This series adds a driver for the multi-function CPLD found on the Sony
Interactive Entertainment Cronos x86 server platform. It provides a
watchdog timer and an LED controller, both of which will depend on the
MFD parent driver implemented in this series. Device tree bindings are
also included.

Thanks,

Changes in v4:
  - Address reviewer concerns

Shawn Anastasio (1):
  dt-bindings: mfd: Add sony,cronos-smc

Timothy Pearson (3):
  mfd: sony-cronos-smc: Add driver for Sony Cronos SMC
  led: sony-cronos-smc: Add RGB LED driver for Sony Cronos SMC
  watchdog: sony-cronos-smc: Add watchdog driver for Sony Cronos SMC

 .../bindings/mfd/sony,cronos-smc.yaml         | 113 ++++++
 MAINTAINERS                                   |   7 +
 drivers/leds/Kconfig                          |  19 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-sony-cronos.c               | 378 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/sony-cronos-smc.c                 | 212 ++++++++++
 drivers/watchdog/Kconfig                      |  17 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/sony-cronos-wdt.c            | 283 +++++++++++++
 include/linux/mfd/sony-cronos.h               |  61 +++
 12 files changed, 1105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml
 create mode 100644 drivers/leds/leds-sony-cronos.c
 create mode 100644 drivers/mfd/sony-cronos-smc.c
 create mode 100644 drivers/watchdog/sony-cronos-wdt.c
 create mode 100644 include/linux/mfd/sony-cronos.h

-- 
2.39.5

