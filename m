Return-Path: <linux-kernel+bounces-607622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF2DA908A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52F51655D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45611209F53;
	Wed, 16 Apr 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biSTG3Xz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81045336D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820520; cv=none; b=MbX5wXxa03ka/5KLjqcBvA+aaX0JkGfC/EZMgKfnx3sg2WrPp6ZOEJ3E7EEHPEQXVpHcRcrsXrHczqawG1ir0KphNoyxzWmmMJYZZj05tYaXo1znfQ5hxrx03+t1639pI47yrpH4OuDWsmhmMrAsaLdSsFvxy7bMTuIbXJoLHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820520; c=relaxed/simple;
	bh=5/w4MKEHC28jIWdGqfAyKCZ3+d4rZmueIB1qcLirGOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQ9IiwrVteLfQQZi8Z45BX+JjUCp6oLW6k0ybV+IL5foE2GFsWRn3li/Oonawyoxru0GWjFd3brTAVeWkS8n4OZHJXFejzJ4wtRS7y/0p9X4rWXFV+FcCOKBp4OCAZrcfCoN4GX+0+qLTAJF5zcyqSVnrrMkJMzSp8sYDy6eBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biSTG3Xz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744820517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=46pvO5bo7cRFjcpTxq8cD32SjPKm2nm97fut9e9I2Sw=;
	b=biSTG3XzqokjofSYaTwbq/J3T3krbQMMixbIXpA2yJ4ekiwNocxjUpwtfbt3CwA1m43oYS
	yKvtNKREHgolX7mY3NWHSX+9rdfA6cFNRanm2bh1ee79oEhuLxZcVVcn5eq9VtI2afBXBj
	+Ajx28L17jtf+XRk413kgeJp8HuaGjI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-N18t3VnvOQeihfOlrx5alQ-1; Wed,
 16 Apr 2025 12:21:53 -0400
X-MC-Unique: N18t3VnvOQeihfOlrx5alQ-1
X-Mimecast-MFC-AGG-ID: N18t3VnvOQeihfOlrx5alQ_1744820511
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92E5C1800446;
	Wed, 16 Apr 2025 16:21:50 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E0D8180094C;
	Wed, 16 Apr 2025 16:21:45 +0000 (UTC)
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
Subject: [PATCH v3 net-next 00/10] Add Microchip ZL3073x support (part 1)
Date: Wed, 16 Apr 2025 18:21:36 +0200
Message-ID: <20250416162144.670760-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Patch 6 - Clock ID generation for DPLL driver
Patch 7 - Fetch invariant register values used by DPLL/PTP sub-drivers
Patch 8 - Register/create DPLL device cells

---
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

Ivan Vecera (10):
  dt-bindings: dpll: Add device tree bindings for DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  mfd: Add Microchip ZL3073x support
  mfd: zl3073x: Add support for devlink device info
  mfd: zl3073x: Add functions to work with register mailboxes
  mfd: zl3073x: Add clock_id field
  lib: Allow modules to use strnchrnul
  mfd: zl3073x: Load mfg file into HW if it is present
  mfd: zl3073x: Fetch invariants during probe
  mfd: zl3073x: Register DPLL sub-device during init

 .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
 .../devicetree/bindings/dpll/dpll-pin.yaml    |  44 +
 .../bindings/dpll/microchip,zl30731.yaml      | 115 +++
 MAINTAINERS                                   |  11 +
 drivers/mfd/Kconfig                           |  32 +
 drivers/mfd/Makefile                          |   5 +
 drivers/mfd/zl3073x-core.c                    | 899 ++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c                     |  70 ++
 drivers/mfd/zl3073x-spi.c                     |  70 ++
 drivers/mfd/zl3073x.h                         |  31 +
 include/linux/mfd/zl3073x.h                   | 225 +++++
 include/linux/mfd/zl3073x_regs.h              | 593 ++++++++++++
 lib/string.c                                  |   1 +
 13 files changed, 2172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x_regs.h

-- 
2.48.1


