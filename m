Return-Path: <linux-kernel+bounces-880532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A94C26041
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3477E1B2336C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DE2EF67F;
	Fri, 31 Oct 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lUL0wYkI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB72EA755;
	Fri, 31 Oct 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926401; cv=none; b=h1EZyFQDkvCW1XCGxdKp3/w8L4G8v34w2q4sc0CNQj+Z4eU+j7VWEpqR4Qp5wueNd93GTtT7zmpOBQ+d+scO1H8UbxCOUn3fAD3Mo9DjNpSrQn9UduEHJGMt13O9zIklI5676vo+d70J251ADGOZQHwwdwwDSmtGh5UvyLcsId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926401; c=relaxed/simple;
	bh=3boLe7S/msdCDepatPxk5c6zd5CigeY1BeRnHG0ZroA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJkg/fq93BEM/tPpeHlqu9XnStyq+4lndr6MjYM7kFvqJE4dEJz2tx7oP3V29sAx/b+yWxIooCDgtBPpdy3+FT82LYVgVYC8tLBxTzYhuRjkKLMOkoQk73ZEH7uoS1ceXfMl9NwdWUSo2UAYJLzs7zndsi/gIZgZmWIt5SbLjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lUL0wYkI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761926399; x=1793462399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3boLe7S/msdCDepatPxk5c6zd5CigeY1BeRnHG0ZroA=;
  b=lUL0wYkI4UPdA/Oej7hsQF17Mzw0URyF2BtQU6nnf+q26lwMDaYu+sg9
   4aI+xly046N3sbPbIHcAeah3FDnaFGotSEFyhZFdWoaZteryJu25xVCu/
   iqI6pfGMQ2q8RODJN0A3LxFfqG3Nl11cEhbCWUkpziRcvePaAVL718qQu
   IHsqTMjpY53ZqKDWksWOzBU85IzPPhc9EPTA0ddQBVHl7uQ2iwkkszZ8A
   V9TjUM8cqh8PUdAq6T6EEiVVdMCouuGytHl5G/p6ChWIq8SCbN2v/4YrZ
   If2GcNl83ZDC17uoY4VLxK6Zrxs0WwYPOkddD1+T5itVgWNWztn1VEzDx
   A==;
X-CSE-ConnectionGUID: ayNLcR6iTHi9ENC+SNMWtg==
X-CSE-MsgGUID: h7DPRQoQQNCcmBhyMV5sVw==
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="54846316"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2025 08:59:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 31 Oct 2025 08:59:27 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 31 Oct 2025 08:59:24 -0700
From: <victor.duicu@microchip.com>
To: <linux@roeck-us.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <corbet@lwn.net>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v1 0/2] add support in hwmon for MCP998X
Date: Fri, 31 Oct 2025 17:58:29 +0200
Message-ID: <20251031155831.42763-1-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

Add support in hwmon for Microchip MCP998X/33 and MCP998XD/33D
Multichannel Automotive Temperature Monitor Family.

The chips in the family have different numbers of external channels,
ranging from 1 (MCP9982) to 4 channels (MCP9985).
Reading diodes in anti-parallel connection is supported by MCP9984/85/33
and MCP9984D/85D/33D. Dedicated hardware shutdown circuitry is present
only in MCP998XD and MCP9933D.

The driver was tested on MCP9984 and MCP9985.
The driver supports reading temperature channels and setting
the update interval.

Differences related to previous patch:
v1:
- initial version for review.
  This is a continuation of the IIO driver:
  https://lore.kernel.org/all/20250930133131.13797-1-victor.duicu@microchip.com/

Victor Duicu (2):
  dt-bindings: hwmon: add support for MCP998X
  hwmon: add support for MCP998X

 .../bindings/hwmon/microchip,mcp9982.yaml     | 192 +++++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/mcp9982.rst               |  94 +++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/mcp9982.c                       | 756 ++++++++++++++++++
 7 files changed, 1062 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
 create mode 100644 Documentation/hwmon/mcp9982.rst
 create mode 100644 drivers/hwmon/mcp9982.c


base-commit: 59420a56a457761d5d1110c3fd2fe9c5de0993c1
-- 
2.48.1


