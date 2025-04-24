Return-Path: <linux-kernel+bounces-618738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2965A9B2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 17:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253ED4A0919
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6627FD51;
	Thu, 24 Apr 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HD/HSWlj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69478267391
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509659; cv=none; b=hUGNjDQxmdj/h3VqfzXE5jzxsiyKWy250Npr+ASEDhkf4r26ajc28uXFHyuXlru25mXY/rIOt37IK/frMe93KZHzxn3PF9qn6ElIwBSDCi9WHTuQ9Zkd3nWUAnlrnfhnZYwO8Vn7TztI+hgrielDgXFn8lpzinDsosTGa39OkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509659; c=relaxed/simple;
	bh=+K1+hSqZMGMgnvGbysJZENgSxEPnVTnWFTQBWhIn0mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFAuFM0ZQ5Xl9aKuo6tjsuGczMsrkGoqwpMWd3Moiirpkh8xgLWVCg9EbO14UnpKazqLV/HKhyw6oIDXoT2n5SBdcVMUHXclG/3E7Wd7+l14PJpaHDcRAq5lZD52o2f26fRCUG81iI2QxLtwOHRPn96RhIN+5Zpy6X16QwI/5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HD/HSWlj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745509655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pCCw2y7rjOMwmvyc3bwQQjYfg0gQzRevmgfAdbV2Kig=;
	b=HD/HSWljwGcxNYIhqnlEKHq0sFu1TwMcnlO1j2U1iXjm5Srstqu9alMAK+zoEgKxxBk8Mh
	Z15tLfRc1OG5Tj9KqdqlnUWghNcABl74qlGuaaHcAP9uhEGSbJ5/5gpuNR0FQdWJ0l8LLq
	7baqxtOQKgCaUdp/CnNQIb9jSlu/Bdc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-P70tYrKkNhKAYvLWYrsYrA-1; Thu,
 24 Apr 2025 11:47:31 -0400
X-MC-Unique: P70tYrKkNhKAYvLWYrsYrA-1
X-Mimecast-MFC-AGG-ID: P70tYrKkNhKAYvLWYrsYrA_1745509649
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B97C91800374;
	Thu, 24 Apr 2025 15:47:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70DD719560A3;
	Thu, 24 Apr 2025 15:47:23 +0000 (UTC)
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
Subject: [PATCH net-next v4 0/8] Add Microchip ZL3073x support (part 1)
Date: Thu, 24 Apr 2025 17:47:14 +0200
Message-ID: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
provides DPLL and PTP functionality. This series bring first part
that adds the common MFD driver that provides an access to the bus
that can be either I2C or SPI.

The next part of the series is bringing the DPLL driver that will
covers DPLL functionality. Another series will bring PTP driver and
flashing capability via devlink in the MFD driver will follow soon.

Testing was done by myself and by Prathosh Satish on Microchip EDS2
development board with ZL30732 DPLL chip connected over I2C bus.

Patch breakdown
===============
Patch 1 - Common DT schema for DPLL device and pin
Patch 2 - DT bindings for microchip,zl3073* devices
Patch 3 - Basic support for I2C, SPI and regmap configuration
Patch 4 - Devlink device registration and info
Patch 5 - Helpers for reading and writing register mailboxes
Patch 6 - Fetch invariant register values used by DPLL/PTP sub-drivers
Patch 7 - Clock ID generation for DPLL driver
Patch 8 - Register/create DPLL device cells

---
v3->v4:
* fixed shortcomings in DT patches
* completely reworked register access
* removed a need to manage locking during mailbox accesses by callers
* regcache switched to maple
* dev_err_probe() in probe path
* static mfd cells during sub-devices registration

v1->v3:
* dropped macros for generating register access functions
* register access functions are provided in <linux/mfd/zl3073x_regs.h>
* fixed DT descriptions and compatible wildcard usage
* reworked regmap locking
  - regmap uses implicit locking
  - mailbox registers are additionally protected by extra mutex
* fixed regmap virtual address range
* added regmap rbtree cache (only for page selector now)
* dropped patches for exporting strnchrnul and for supporting mfg file
  this will be maybe added later

Ivan Vecera (8):
  dt-bindings: dpll: Add DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  mfd: Add Microchip ZL3073x support
  mfd: zl3073x: Add support for devlink device info
  mfd: zl3073x: Add functions to work with register mailboxes
  mfd: zl3073x: Fetch invariants during probe
  mfd: zl3073x: Add clock_id field
  mfd: zl3073x: Register DPLL sub-device during init

 .../devicetree/bindings/dpll/dpll-device.yaml |   76 ++
 .../devicetree/bindings/dpll/dpll-pin.yaml    |   45 +
 .../bindings/dpll/microchip,zl30731.yaml      |  115 ++
 MAINTAINERS                                   |   11 +
 drivers/mfd/Kconfig                           |   32 +
 drivers/mfd/Makefile                          |    5 +
 drivers/mfd/zl3073x-core.c                    | 1011 +++++++++++++++++
 drivers/mfd/zl3073x-i2c.c                     |   68 ++
 drivers/mfd/zl3073x-regs.h                    |  155 +++
 drivers/mfd/zl3073x-spi.c                     |   68 ++
 drivers/mfd/zl3073x.h                         |   31 +
 include/linux/mfd/zl3073x.h                   |  308 +++++
 12 files changed, 1925 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-regs.h
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h

-- 
2.49.0


