Return-Path: <linux-kernel+bounces-804981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED164B48292
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249091899045
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F911F582A;
	Mon,  8 Sep 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtBaDUs5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24AF1E5B60;
	Mon,  8 Sep 2025 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298352; cv=none; b=LcE4f467T+y2IV81lKRoV523MBL94jvlylr6B03a7HOWhx5CyfG29hbcI8NV8FeFwDSHQY3vX3AgfDY3tFsVxjlmCx9lWU1y5+gazn0d+El0Cr1VN2Df9kSTgTut3kAwDUQaPQYe2sVflNcDt940ngkkj2DdjnFkB1TB7+Tp3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298352; c=relaxed/simple;
	bh=tfPgZAPdEI9DpPkO0F1JRnB4BEUZvB2btkMx4MQFueQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrKW0++OOXMb+SM69HKejmMWMBN4i1trMbSc5nVcT5bPfDNtRYApfMlEMiSWibLe0Yqe2gnqi3ImSyQWK+aOnjcJvWJOX/mNlCKu61RUFyamenIKxAbBOqaJ/UyLciKVWy3fqhQsjuHzSu9k2ToP09cyPs5HdQGxpiVAasTaj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtBaDUs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65977C4CEF5;
	Mon,  8 Sep 2025 02:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757298352;
	bh=tfPgZAPdEI9DpPkO0F1JRnB4BEUZvB2btkMx4MQFueQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PtBaDUs5Y5bM1pW4GyW3sBrpQXAfpr8QRJm2aaE8297jiN6c+ncERpPWjvXmULuqP
	 Rd7GoVUh8EBCu1sXY0HhNLOtf/oRFPuitfP0KKAEZWKLL3Ne2ECXsj4gTtfQJfw8/r
	 TrRJACa1RhJgx0H7Kcn0b2DvBwhMx/HJbCjuaETk1ZYsVNQDBSMOVGzqGF05AumOX9
	 DssKFVkjfb5K1Sg4YqJ59hBIBzl+ATSvoP5FhebBG42o6lgpmvC1mwmqg6Qhpadv20
	 2k0kHW2G1Ngmv5720ec2+byyNqpz+rizD8juBIahFFVt8GA+qajKlNtnJREIJh/kAV
	 CkxfCEK4qrlKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59544CAC581;
	Mon,  8 Sep 2025 02:25:52 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Mon, 08 Sep 2025 10:25:45 +0800
Subject: [PATCH v9 2/2] hwmon: document: add gpd-fan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250908-gpd_fan-v9-2-7b4506c03953@uniontech.com>
References: <20250908-gpd_fan-v9-0-7b4506c03953@uniontech.com>
In-Reply-To: <20250908-gpd_fan-v9-0-7b4506c03953@uniontech.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 Jun Zhan <zhanjun@uniontech.com>, Cheng Nie <niecheng1@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757298351; l=3651;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=XJBaOZygIlHycO8BeXsmyRPcKndp0Zqqqn5Kg3pQ5T0=;
 b=qBznmcyRfPSdCHkxXtonLTap0YL4ULYMFkQDkYxMLZhjamDoZ9QXBldXz6xHA3arpPvGK1xSX
 Gbsr08fBfS2BszBtqwTCWyNyKAx73VpRpBLWVnACwP8/9RbKK4qHYFs
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Add GPD fan driver document

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 Documentation/hwmon/gpd-fan.rst | 78 +++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst   |  1 +
 MAINTAINERS                     |  1 +
 3 files changed, 80 insertions(+)

diff --git a/Documentation/hwmon/gpd-fan.rst b/Documentation/hwmon/gpd-fan.rst
new file mode 100644
index 0000000000000000000000000000000000000000..0b56b70e6264ddccaa4d84b326841c8f63b43a39
--- /dev/null
+++ b/Documentation/hwmon/gpd-fan.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver gpd-fan
+=========================
+
+Author:
+    - Cryolitia PukNgae <cryolitia@uniontech.com>
+
+Description
+------------
+
+Handheld devices from Shenzhen GPD Technology Co., Ltd. provide fan readings
+and fan control through their embedded controllers.
+
+Supported devices
+-----------------
+
+Currently the driver supports the following handhelds:
+
+ - GPD Win Mini (7840U)
+ - GPD Win Mini (8840U)
+ - GPD Win Mini (HX370)
+ - GPD Pocket 4
+ - GPD Duo
+ - GPD Win Max 2 (6800U)
+ - GPD Win Max 2 2023 (7840U)
+ - GPD Win Max 2 2024 (8840U)
+ - GPD Win Max 2 2025 (HX370)
+ - GPD Win 4 (6800U)
+ - GPD Win 4 (7840U)
+
+Module parameters
+-----------------
+
+gpd_fan_board
+  Force specific which module quirk should be used.
+  Use it like "gpd_fan_board=wm2".
+
+   - wm2
+       - GPD Win 4 (7840U)
+       - GPD Win Max 2 (6800U)
+       - GPD Win Max 2 2023 (7840U)
+       - GPD Win Max 2 2024 (8840U)
+       - GPD Win Max 2 2025 (HX370)
+   - win4
+       - GPD Win 4 (6800U)
+   - win_mini
+       - GPD Win Mini (7840U)
+       - GPD Win Mini (8840U)
+       - GPD Win Mini (HX370)
+       - GPD Pocket 4
+       - GPD Duo
+
+Sysfs entries
+-------------
+
+The following attributes are supported:
+
+fan1_input
+  Read Only. Reads current fan RPM.
+
+pwm1_enable
+  Read/Write. Enable manual fan control. Write "0" to disable control and run
+  at full speed. Write "1" to set to manual, write "2" to let the EC control
+  decide fan speed. Read this attribute to see current status.
+
+  NB：In consideration of the safety of the device, when setting to manual mode,
+  the pwm speed will be set to the maximum value (255) by default. You can set
+  a different value by writing pwm1 later.
+
+pwm1
+  Read/Write. Read this attribute to see current duty cycle in the range
+  [0-255]. When pwm1_enable is set to "1" (manual) write any value in the
+  range [0-255] to set fan speed.
+
+  NB: Many boards (except listed under wm2 above) don't support reading the
+  current pwm value in auto mode. That will just return EOPNOTSUPP. In manual
+  mode it will always return the real value.
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index d292a86ac5da902cad02c1965c90f5de530489df..ce4419f064e1368740387af70af38a85cadd952d 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -82,6 +82,7 @@ Hardware Monitoring Kernel Drivers
    gigabyte_waterforce
    gsc-hwmon
    gl518sm
+   gpd-fan
    gxp-fan-ctrl
    hih6130
    hp-wmi-sensors
diff --git a/MAINTAINERS b/MAINTAINERS
index 14a616be5ff08aaeee52436dff54a86c4a81e5fb..0b6ae95c2007f0737bc4a4e1f2bac52f71628f78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10425,6 +10425,7 @@ GPD FAN DRIVER
 M:	Cryolitia PukNgae <cryolitia@uniontech.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
+F:	Documentation/hwmon/gpd-fan.rst
 F:	drivers/hwmon/gpd-fan.c
 
 GPD POCKET FAN DRIVER

-- 
2.51.0



