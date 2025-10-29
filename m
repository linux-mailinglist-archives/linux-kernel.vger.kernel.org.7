Return-Path: <linux-kernel+bounces-876598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAEEC1C0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 696885E41DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1537434F465;
	Wed, 29 Oct 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vukrHudz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6960347BC1;
	Wed, 29 Oct 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753082; cv=none; b=InkozMtFg8UrEz8XIZQz0GRhIKg8COMJFtnZbetJ9eD2SP22RZM0g96Ngj8saSHlH58o8clJWYb7DNL2RrZfe7IW9t8A/bZNmHqx08N1UWTOdq4X1ZIDWujWqF9I1MaFI1BTGcB8ilK+BbO4GfR1N/9lV0cNOZdOfeD4NrNJzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753082; c=relaxed/simple;
	bh=VkIEbYbO2lmvSO+zYN2/qpg6TLG1lIbwcMUuFUY0hRI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=iOy1Vm/S0HpPTshPxfAAqKlQp+iuE/Th2Rg/Ei8nZL5IUZ3zOBKkpNvOYqWq3Moieh5EhBOPWWo2k9KwD62+i4pBpPKXHcI6B1xNtBn1TY0OOMUjCKBvtMVH+BVt7SqP6zvPqmbOYZojPRy5DendQjl4/VkAN7aHnGnXQ1Zms+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vukrHudz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761753081; x=1793289081;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=VkIEbYbO2lmvSO+zYN2/qpg6TLG1lIbwcMUuFUY0hRI=;
  b=vukrHudzvHEzV86q0hHPFgi/4NgmvKvSjqtIOK5pri13hHVbAjNp9lPo
   iOYveKdhkOvNUDVAYG9JWr6HV+DZGgRAcoHSwnFgCrJKB2WjiIh4aOo4b
   eKmVkqvzkSvDfsSb8C13MbK5q/PE+LIL+rOXB/Lskmu2lWuGEj05Rijke
   16Ws7sZLFvrUZr4hzEyobFMmK87gwLUPiaNS5ktdmTvUlOS3j4QLPx0RM
   b8mf14efJBMp2Mc/rnl8mQSX7ZBv1m0rx9wZpZ2WrqkyJjfa378PDZ9t4
   CFhOmheE5e8+45K4Zi5Q2XEVF5sDqA/HQhmx61Yu+k1SNQYMv/GyNaebu
   Q==;
X-CSE-ConnectionGUID: YUlZdbPOTGGodPHj5Yz7YQ==
X-CSE-MsgGUID: ljkyKKKiSUiZTexeIdMnRw==
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="48421760"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2025 08:51:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 08:51:09 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 29 Oct 2025 08:51:07 -0700
From: Marius Cristea <marius.cristea@microchip.com>
Subject: [PATCH 0/2] Add support for Microchip EMC1812
Date: Wed, 29 Oct 2025 17:50:57 +0200
Message-ID: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOE3AmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMj3Yzy+Nz8PN3U3GRDC0Mj3TTDJAsDMxML8xRDAyWgpoKi1LTMCrC
 B0bG1tQDmTPZ+YAAAAA==
X-Change-ID: 20251002-hw_mon-emc1812-f1b806487d10
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Marius Cristea
	<marius.cristea@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=marius.cristea@microchip.com; h=from:subject:message-id;
 bh=VkIEbYbO2lmvSO+zYN2/qpg6TLG1lIbwcMUuFUY0hRI=;
 b=owGbwMvMwCW2tbSTZa7u0x2Mp9WSGDKZzF8FP5upyn+27sHWnCl/mEKenPg1N/HlZZek8xrpU
 eozTt062lHKwiDGxSArpsiy4q2fWtXaD5eVxDJ1YOawMoEMYeDiFICJrNnDyLDVLaMy2kFco8+C
 88yPn/ymh33zjojfP3DLJp/X56Ft3BJGhvuebupWVt7s3wL3Ffod/PMgw2jq8cnuPr1vbi9v3Nv
 ExwsA
X-Developer-Key: i=marius.cristea@microchip.com; a=openpgp;
 fpr=E32F8D4396E72E463E8CCD91446DE0ABD9140C3E

This is the hwmon driver for EMC1812/13/14/15/33 multichannel Low-Voltage
Remote Diode Sensor Family. The chips in the family have one internal
and different numbers of external channels, ranging from 1 (EMC1812) to
4 channels (EMC1815).
Reading diodes in anti-parallel connection is supported by EMC1814, EMC1815
and EMC1833.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
Marius Cristea (2):
      dt-bindings: hwmon: temperature: add support for EMC1812
      hwmon: temperature: add support for EMC1812

 .../bindings/hwmon/microchip,emc1812.yaml          | 176 ++++
 Documentation/hwmon/emc1812.rst                    |  68 ++
 MAINTAINERS                                        |   8 +
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/emc1812.c                            | 967 +++++++++++++++++++++
 6 files changed, 1231 insertions(+)
---
base-commit: d2b2fea3503e5e12b2e28784152937e48bcca6ff
change-id: 20251002-hw_mon-emc1812-f1b806487d10

Best regards,
-- 
Marius Cristea <marius.cristea@microchip.com>


