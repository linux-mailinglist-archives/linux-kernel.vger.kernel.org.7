Return-Path: <linux-kernel+bounces-842350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5503EBB98FC
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03981895293
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE928D8DF;
	Sun,  5 Oct 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QECSqFm1"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3528D8DB
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759678485; cv=none; b=UyiE2VmG0Cq9zYI9M0iGiZqIZOwZbm8lkVdvVuNPjAY5WolcNX4XLzZmes5g1YmKYjWA6tEsYcgPvc7wa8HbeJ2Jlri4XR0gAfX5VXqWwVFJdBGb5CaaA5uTf2SiYGO3CoHLr/wovmhk7y2mjvWKlVzRaG/3oIq4srRA4QDBdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759678485; c=relaxed/simple;
	bh=98caJkQZ0MiAzC2fQEY27b92eOKFqM0zqIcXCKa8xZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNsjA+w/LIAAFZvn44JCq+cp2X8lRmV+owe+d5SB0NcFLfaD9/2W0nszY3Gd0qRQ8WR27tXKspucsXHshnA7GZfK0QFDqy47A26U5smXeJTrLgd0ah8lVWkALs0rMoxJ2dQ8dRpozeuobEa7+TG7I+vbna+aCC0FiRbeAvGiN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QECSqFm1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27edcbcd158so51955775ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759678483; x=1760283283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X6o/MRuCTc+0p6F+rhXe+4gejxskim5+wROeJzq1wc=;
        b=QECSqFm1VriYQk9c4gdRFpoXTZrIpcg0XT0Ho+gFVzfeDvVJCdvDP3drUdRBwMQHMX
         C7iZxGnt9UgpNnwbUnjv9IsJwyGo44Y8A0k4zFXSayf582/buLa/9kwCB9I5HPZkzwHH
         Ybr9y2UQ+H2jNf9LNVdbeavqVjrEVJmW3TFe0rWZ+HhwNr8iQLaeWmVfWnUpE0Y0CtN/
         2fbdxiE5awu2BIPYJY3A2UW9RB4MzTmNltt7I+d6NNe1yHYyqIjYFQNfEFlQEAQV3bl1
         hLqZPwjuJc2BJCg40lSMJmVop0dIhlPSvpiEPu6uRpMbisHfMl4HJg7+JvcaDowF5j+F
         KV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759678483; x=1760283283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X6o/MRuCTc+0p6F+rhXe+4gejxskim5+wROeJzq1wc=;
        b=kd+gGQ9mlf2mAGk85dUrJYeZjnF80gbFW7mZXBV/dmIHRoM6KO6aqj3UMoCqZWtAWT
         WhYOlgw41Ijf0ZCLQtIKGkE87jDZOHMTl91I1X1m64UfTAC8QA7UEt+Wn8gcfkjFAj2W
         pT9K8QYqYYB0laB0xQG5vuvlrYyEsS+i+zxhK4Af0EczJDUSRgw/cI62Pzb4SivEqLSW
         eKy2rYUk2gPTGBTnHSi8oIKiEEWhzqonuSivCXbe8jVmPaXXXWVcK1LlyZsU9dTMpQF9
         1UUrQza4Ojc4P0dPPxtmk5ol5qrCXmE3yuvqf/g37/h1wdAHnLgdCEcXfl1UGnjKEMBP
         6Wcw==
X-Forwarded-Encrypted: i=1; AJvYcCWD9z9hTRFLWOXulUv0aFfMahIe5EhgUXNlP/U5JInexphre5VSBP1dCPp/mCu3R4Hn9ZGy+HBrPQZuIlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQb4hRc1yvC6gyNOuye/MLk3wKVSukZNHCMd9jcDvlEfQXoIQ
	ST+6Ivz1IvSiF0nMT51lIWcBjYZKfamRtTAoO94wwN8qw11qyr65FsXw
X-Gm-Gg: ASbGncvh/yFtOP3cFMMyHfaljQPunG+sYnXqv6nZXBnwFDUHQNCEsdIfHcP7GQaeF1h
	gtzlEny4/qaV39FsauuITLtpSM2xM0xFliGUP6mSb/ZZbPgtdVXNw1sCWAjbSEk6JeodXI+ToZQ
	MnSZz3pXkTYSfTLg1R3AK81pWgbptRV6lJUsfGs1b0P4gIT6GonVf87RVNqqTzJfiDU7p0bXKSr
	gXWb4JVmPgliKef6BVyvvB8kIGGNvtSmxeqy0M/HmcHw8jEdzvindICy5ETt/mGkvO7xbotcwEO
	TatoOcNWIfhDsZpqOwJuYpFP775SY1L4CEqVJP5LDEQSVt5J0HZsxE1skJBdJV9MogLHhTs4qTT
	nz5vKbEG7+q0MxzhCPF7OzHGlN9Nn5WQRgt3lko5snkcIkPgWBKvlWLdxRgOFjXlVRg==
X-Google-Smtp-Source: AGHT+IGOOTrBzPFcXT/L1Z9eJjafTeBHYh5acgbfBjUTIl/XV5J6IgoIQc+d+NUDca8jIPHpHj7Nlw==
X-Received: by 2002:a17:902:ce88:b0:28d:18d3:46cb with SMTP id d9443c01a7336-28e9a54660fmr118836165ad.20.1759678483159;
        Sun, 05 Oct 2025 08:34:43 -0700 (PDT)
Received: from DESKTOP-P76LG1N.lan ([58.187.66.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d9csm105555965ad.2.2025.10.05.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 08:34:42 -0700 (PDT)
From: Nam Tran <trannamatk@gmail.com>
To: lee@kernel.org
Cc: pavel@kernel.org,
	gregkh@linuxfoundation.org,
	rdunlap@infradead.org,
	christophe.jaillet@wanadoo.fr,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nam Tran <trannamatk@gmail.com>
Subject: [PATCH v15 3/3] docs: leds: Document TI LP5812 LED driver
Date: Sun,  5 Oct 2025 22:33:37 +0700
Message-Id: <20251005153337.94025-4-trannamatk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251005153337.94025-1-trannamatk@gmail.com>
References: <20251005153337.94025-1-trannamatk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver provides sysfs interfaces to control and configure the
LP5812 device and its LED channels.

The documetation describes the chip's capabilities, sysfs interface,
and usage examples.

Signed-off-by: Nam Tran <trannamatk@gmail.com>
---
 Documentation/leds/index.rst       |  1 +
 Documentation/leds/leds-lp5812.rst | 50 ++++++++++++++++++++++++++++++
 MAINTAINERS                        |  1 +
 3 files changed, 52 insertions(+)
 create mode 100644 Documentation/leds/leds-lp5812.rst

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 76fae171039c..bebf44004278 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,6 +25,7 @@ LEDs
    leds-lp5523
    leds-lp5562
    leds-lp55xx
+   leds-lp5812
    leds-mlxcpld
    leds-mt6370-rgb
    leds-sc27xx
diff --git a/Documentation/leds/leds-lp5812.rst b/Documentation/leds/leds-lp5812.rst
new file mode 100644
index 000000000000..4c22d9a79d14
--- /dev/null
+++ b/Documentation/leds/leds-lp5812.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Kernel driver for lp5812
+========================
+
+* TI/National Semiconductor LP5812 LED Driver
+* Datasheet: https://www.ti.com/product/LP5812#tech-docs
+
+Authors: Jared Zhou <jared-zhou@ti.com>
+
+Description
+===========
+
+The LP5812 is a 4x3 matrix LED driver with support for both manual and
+autonomous animation control. This driver provides sysfs interfaces to
+control and configure the LP5812 device and its LED channels.
+
+Sysfs Interface
+===============
+
+This driver uses the standard multicolor LED class interfaces defined
+in `Documentation/ABI/testing/sysfs-class-led-multicolor`.
+
+Each LP5812 LED output appears under ``/sys/class/leds/`` with its
+assigned label (for example ``LED_A``).
+
+The following attributes are exposed:
+  - multi_intensity: Per-channel RGB intensity control.
+  - brightness: Standard brightness control (0-255)
+
+Autonomous Control Modes
+========================
+
+The driver also supports autonomous control through pattern configuration
+(e.g., direct, tcmscan, or mixscan modes) defined in the device tree.
+When configured, the LP5812 can generate transitions and color effects
+without CPU intervention.
+
+Refer to the device tree binding document for valid mode strings and
+configuration examples.
+
+Example Usage
+=============
+
+To control LED_A::
+    # Set RGB intensity (R=50, G=50, B=50)
+    echo 50 50 50 > /sys/class/leds/LED_A/multi_intensity
+    # Set overall brightness to maximum
+    echo 255 > /sys/class/leds/LED_A/brightness
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a3808d8d624..4d625dabde72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25388,6 +25388,7 @@ M:	Nam Tran <trannamatk@gmail.com>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/leds/ti,lp5812.yaml
+F:	Documentation/leds/leds-lp5812.rst
 F:	drivers/leds/rgb/Kconfig
 F:	drivers/leds/rgb/Makefile
 F:	drivers/leds/rgb/leds-lp5812.c
-- 
2.25.1


