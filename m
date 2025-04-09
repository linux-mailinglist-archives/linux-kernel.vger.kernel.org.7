Return-Path: <linux-kernel+bounces-596191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA2A82880
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 16:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1284E6991
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5533EA;
	Wed,  9 Apr 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ/nWoTW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B482641DA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209787; cv=none; b=ZPrW/P04XodigIymG20fWnJ+uOqC5HyTrj7F/PSqi+NOknPmQSVmcBDzy9mEPzMBx3y81wdMdzjhS8s3oFtR66tg2/hcvU0JZIzip7CqlFLKFM6i6onQt7FG/Ol0m+5HXLhdKdok7JPcyiJCTARQxqJL9+IXJwMKaP456er6Qiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209787; c=relaxed/simple;
	bh=aaP/ZmhMA2e1CuR+RjpRYAYYPQoXceMvCmFfQKpGc5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYEoY1mT3SCXWFPCo6WZ3O3tpRak8z3e9ae+DbLXXuHVunBSIGjzmlAtKHM7VsOXZOxNMJ/K3aJ4gMwB9DDwao0TOLXxo2SuhZgnpRXLtdYtEIQTJ/6BceRERlOyLPLJpXZ5pGvRI3GZTbthQSCpwEIWs+cnBQ7TT68OKmhOK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJ/nWoTW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tm/9bMFZUUUglFawzhJO3DuQlm1zW+QSMce9mPjIXOE=;
	b=QJ/nWoTWwqIF7iVrY/TiNaEmnKwFT5id724w1oeCBKmuV+uDTj3lpKE9HwbPgZgEgX1EkC
	EFuca0U5xZ20sBnLd77/jmiZ6rO0LuOx/t2Pk7ngb4jIK+Pik8Tpoxk/QPEpJ2XHCY070R
	f3xwVj1IOFhmslXNZGCcjNKIsU+6u8E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-22UgsBo8OleGuodDR5OP6Q-1; Wed,
 09 Apr 2025 10:43:00 -0400
X-MC-Unique: 22UgsBo8OleGuodDR5OP6Q-1
X-Mimecast-MFC-AGG-ID: 22UgsBo8OleGuodDR5OP6Q_1744209778
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40E48195608B;
	Wed,  9 Apr 2025 14:42:57 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1857E1801747;
	Wed,  9 Apr 2025 14:42:51 +0000 (UTC)
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
Subject: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
Date: Wed,  9 Apr 2025 16:42:36 +0200
Message-ID: <20250409144250.206590-1-ivecera@redhat.com>
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

The next series will bring the DPLL driver that will covers DPLL
functionality. And another ones will bring PTP driver and flashing
capability via devlink.

Testing was done by myself and by Prathosh Satish on Microchip EDS2
development board with ZL30732 DPLL chip connected over I2C bus.

Patch breakdown
===============
Patch 1 - Common DT schema for DPLL device and pin
Patch 3 - Basic support for I2C, SPI and regmap
Patch 4 - Devlink registration
Patches 5-6 - Helpers for accessing device registers
Patches 7-8 - Component versions reporting via devlink dev info
Patches 9-10 - Helpers for accessing register mailboxes
Patch 11 - Clock ID generation for DPLL driver
Patch 12 - Export strnchrnul function for modules
           (used by next patch)
Patch 13 - Support for MFG config initialization file
Patch 14 - Fetch invariant register values used by DPLL and later by
           PTP driver

Ivan Vecera (14):
  dt-bindings: dpll: Add device tree bindings for DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
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

 .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
 .../devicetree/bindings/dpll/dpll-pin.yaml    |  44 +
 .../bindings/dpll/microchip,zl3073x-i2c.yaml  |  74 ++
 .../bindings/dpll/microchip,zl3073x-spi.yaml  |  77 ++
 MAINTAINERS                                   |  11 +
 drivers/mfd/Kconfig                           |  32 +
 drivers/mfd/Makefile                          |   5 +
 drivers/mfd/zl3073x-core.c                    | 883 ++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c                     |  59 ++
 drivers/mfd/zl3073x-spi.c                     |  59 ++
 drivers/mfd/zl3073x.h                         |  14 +
 include/linux/mfd/zl3073x.h                   | 363 +++++++
 lib/string.c                                  |   1 +
 13 files changed, 1698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h

-- 
2.48.1


