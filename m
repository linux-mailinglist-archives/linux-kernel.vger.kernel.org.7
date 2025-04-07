Return-Path: <linux-kernel+bounces-592025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A79A7E837
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A838317652B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33504216E2B;
	Mon,  7 Apr 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4QKsCnN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54D1F8BC6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046932; cv=none; b=ma4h73x3y7mSNwgYNJDvmlwRQARw8LmOp3MlZAKtDzG3se1tTqEIv+ejiDUdGFA1uuCF9ZYPJAi8mYKDhhefqY40UUWH0jMAQ1AjQ5oVLbRzaXXNhlWvTYxkcFr/hr/yssunu0Rurj8lpRCZrO5VcdPEa+ZkIZDAr6SZBCSUn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046932; c=relaxed/simple;
	bh=wsHHJZqntazBpATd7YuS+J2IlhAOuKOpdFMOBcPiE/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SutIvdnWgSDvlbsPLo+zWmzKy+lMkt0pD8u9DRX++eED1xg5bO4oKfFGDQ8p5rD0/W5VjXDYbhNPxn7gipCdAxHW1KdoPcGvRe7802xPTb5APKDAAh1SRsJ6AXyc3X/Zoaj9/4hSComeEdB9KXQRFem5NFJuKmT5qEhjpLkM+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4QKsCnN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bFO8XTLN8X6PR8VKPvsVUaoldbdxYBtD0THNWLQS6Mk=;
	b=Z4QKsCnN5J3q36dDjPfozoHxWiOfEqnQ9EJ3Xwoi5+ykrNaKEDC3Zq02HgTApl4Xlv2ENO
	hI6TDwkSySRYabQGWwGHMrX3xnWrIrMo8MSuMG+K5cjNn2cA0EDl52IgfdQc93gTQl3270
	92/tLTYru3Uu1ZX1OODh+9DucQ2LnGM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-Thv6vA51MdGQe-uhtfgtTA-1; Mon,
 07 Apr 2025 13:28:46 -0400
X-MC-Unique: Thv6vA51MdGQe-uhtfgtTA-1
X-Mimecast-MFC-AGG-ID: Thv6vA51MdGQe-uhtfgtTA_1744046924
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 979BE180034D;
	Mon,  7 Apr 2025 17:28:43 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A186180A803;
	Mon,  7 Apr 2025 17:28:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 00/28] Add Microchip ZL3073x support
Date: Mon,  7 Apr 2025 19:28:27 +0200
Message-ID: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series adds support for Microchip Azurite DPLL/PTP/SyncE chip
family. These chips provide DPLL and PTP functionality, so the series
adds the common MFD driver that provides an access to the bus that can
be either I2C or SPI. The second part of the series is DPLL driver that
covers DPLL functionality. The PTP support will be added by separate
series as well as flashing capability.

All functionality was tested by myself and by Prathosh Satish on
Microchip EDS2 development board with ZL30732 DPLL chip connected over
I2C bus.

Patch breakdown
===============
Patch 1 - Basic support for I2C, SPI and regmap
Patch 2 - Devlink registration
Patches 3-4 - Helpers for accessing device registers
Patches 5-6 - Component versions reporting via devlink dev info
Patches 7-8 - Helpers for accessing register mailboxes
Patch 9 - Clock ID generation for DPLL driver
Patch 10 - Export strnchrnul function for modules
           (used by next patch)
Patch 11 - Support for MFG config initialization file
Patch 12 - Fetch invariant register values used by DPLL and later by
           PTP driver
Patch 13 - Basic DPLL driver with required only functionality
Patch 14 - Registration of DPLL sub-devices by MFD driver
Patch 15 - Device tree bindings for DPLL device and pin
Patch 16 - Device tree bindings for ZL3073x device
Patch 17 - Read DPLL device types from firmware (DT,ACPI...)
Patch 18 - Read basic pin properties from firmware
Patch 19 - Implementation of input pin selection for DPLL in manual mode
Patch 20 - Implementation of getting/setting priority for input pins
Patch 21 - Implementation of input pin state setting for DPLL in auto mode
Patch 22 - Implementation of getting/setting frequency for input pins
Patch 23 - Implementation of getting/setting frequency for output pins
Patch 24 - Read pin supported frequencies from firmware
Patch 25 - Implementation of getting phase offset from input pins
Patch 26 - Implementation of getting/setting phase adjust for both
           pin types
Patch 27 - Implementation of getting/setting embedded sync frequency
           for both pin types
Patch 28 - Implementation of getting fractional frequency offset for
           input pins

Ivan Vecera (28):
  mfd: Add Microchip ZL3073x support
  mfd: zl3073x: Register itself as devlink device
  mfd: zl3073x: Add register access helpers
  mfd: zl3073x: Add macros for device registers access
  mfd: zl3073x: Add components versions register defs
  mfd: zl3073x: Implement devlink device info
  mfd: zl3073x: Add macro to wait for register value bits to be cleared
  mfd: zl3073x: Add functions to work with register mailboxes
  mfd: zl3073x: Add clock_id field
  lib: Allow modules to use strnchrnul
  mfd: zl3073x: Load mfg file into HW if it is present
  mfd: zl3073x: Fetch invariants during probe
  dpll: Add Microchip ZL3073x DPLL driver
  mfd: zl3073x: Register DPLL sub-device during init
  dt-bindings: dpll: Add device tree bindings for DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  dpll: zl3073x: Read DPLL types from firmware
  dpll: zl3073x: Read optional pin properties from firmware
  dpll: zl3073x: Implement input pin selection in manual mode
  dpll: zl3073x: Add support to get/set priority on input pins
  dpll: zl3073x: Implement input pin state setting in automatic mode
  dpll: zl3073x: Add support to get/set frequency on input pins
  dpll: zl3073x: Add support to get/set frequency on output pins
  dpll: zl3073x: Read pin supported frequencies from firmware
  dpll: zl3073x: Add support to get phase offset on input pins
  dpll: zl3073x: Add support to get/set phase adjust on pins
  dpll: zl3073x: Add support to get/set esync on pins
  dpll: zl3073x: Add support to get fractional frequency offset on input
    pins

 .../devicetree/bindings/dpll/dpll-device.yaml |   84 +
 .../devicetree/bindings/dpll/dpll-pin.yaml    |   43 +
 .../bindings/dpll/microchip,zl3073x.yaml      |   74 +
 MAINTAINERS                                   |   12 +
 drivers/dpll/Kconfig                          |   16 +
 drivers/dpll/Makefile                         |    2 +
 drivers/dpll/dpll_zl3073x.c                   | 2768 +++++++++++++++++
 drivers/mfd/Kconfig                           |   33 +
 drivers/mfd/Makefile                          |    5 +
 drivers/mfd/zl3073x-core.c                    |  840 +++++
 drivers/mfd/zl3073x-i2c.c                     |   71 +
 drivers/mfd/zl3073x-spi.c                     |   72 +
 drivers/mfd/zl3073x.h                         |   13 +
 include/linux/mfd/zl3073x.h                   |  335 ++
 lib/string.c                                  |    1 +
 15 files changed, 4369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
 create mode 100644 drivers/dpll/dpll_zl3073x.c
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h

-- 
2.48.1


