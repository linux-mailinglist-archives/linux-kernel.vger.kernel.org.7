Return-Path: <linux-kernel+bounces-800288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0BB435D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105431C262CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B82C21DE;
	Thu,  4 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvcJpCfa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B3258EED;
	Thu,  4 Sep 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974822; cv=none; b=WW/WBFBWW1GKSdPyZ8Y2OckFwEG0EHvzXBp4uWFFPfCCkg7gnbN9U31kORdw7IAzVMX2SXKBx34edXzoFpHc1a3AIDdnSexZwqe0aB08BMIVF17O05fHMSrJuWm/TY6SkDPmEkz+bwz+D7KfM4iE1kkcLATpP5nDotZOhQd3JYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974822; c=relaxed/simple;
	bh=xa1DNZh9ZS1PCU6W7gGSjK02tfE2cD6nLJfB1gnM5PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F//xhcGbRSygO1r5b5P+r7go5eVmPgtJEHTyny4vSz8XmCU8/GbEbysQNWtfXfycEPzOaEKwA047TOtDaGcyE0EeDIjAX/Jogsz6gyXSG7B6KYqkG/62L5iA2qfiQugeBcaSdiZtgr4fWK2woDQYxQuPFmstkGLNjxs4Z+wB0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvcJpCfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A241C4CEF1;
	Thu,  4 Sep 2025 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756974822;
	bh=xa1DNZh9ZS1PCU6W7gGSjK02tfE2cD6nLJfB1gnM5PI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KvcJpCfaYNNRQilKjRoW3jmSHmV1Hdzliu1dOsOKNFM/kLnu50KyyaeainO4Y30YA
	 vF36WCYkLTQ28JFaYmdlz/RLZaUGjnlLvXSWskHpIH2Iq58rUxec4DvSulajP1m8ab
	 DVH/tu5wdQKxfFO4wV/jbTHWXdakAyMa9LrGbRdFhQ5KISjF5wi2lfkvYtgMCTYPXv
	 /LE/tnBbIXV/ehjdYe1e+OBXbOCqmAUlNFwgirX4xpdRAjTiu7O/sAjJZ2Emb4n1a6
	 y6D/To8UOpafcZlNRfFe6RPIVsbobMO71liDE2FvZ5FGhUBaZINZa+HhWysnCP97dp
	 rZLAR/dg8q3+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E072CA1013;
	Thu,  4 Sep 2025 08:33:42 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 04 Sep 2025 16:33:42 +0800
Subject: [PATCH v8 2/2] hwmon: document: add gpd-fan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250904-gpd_fan-v8-2-0752584f16da@uniontech.com>
References: <20250904-gpd_fan-v8-0-0752584f16da@uniontech.com>
In-Reply-To: <20250904-gpd_fan-v8-0-0752584f16da@uniontech.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 Jun Zhan <zhanjun@uniontech.com>, Cheng Nie <niecheng1@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756974821; l=3706;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=LpIT/dc1H9CoyCcFgvvZK2Mbndl3sEjj5NTpoDZaSng=;
 b=TpLbyysrkvlDAZXFVN6a6xnwrd6Zu4nmp7QsMEFNb5HGs1gGOag1kgmrf3SPXcFnEawtpaNMO
 cQK2ULzM/6GCL1cNYWBcBk+JPbNglTf1Um3479E+i6sDvBYzWxX+TnX
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
 Documentation/hwmon/gpd-fan.rst | 79 +++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst   |  1 +
 MAINTAINERS                     |  1 +
 3 files changed, 81 insertions(+)

diff --git a/Documentation/hwmon/gpd-fan.rst b/Documentation/hwmon/gpd-fan.rst
new file mode 100644
index 0000000000000000000000000000000000000000..a8541049d680beef93c5f7623de77e759242ffac
--- /dev/null
+++ b/Documentation/hwmon/gpd-fan.rst
@@ -0,0 +1,79 @@
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
+  current pwm value in auto mode. That will just return 255 as default on
+  those boards, or a previously written value. In manual mode it will always
+  return the real value.
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



