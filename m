Return-Path: <linux-kernel+bounces-864131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D579FBF9FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27E319C8A83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76EF2DC344;
	Wed, 22 Oct 2025 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="EccNWSt6"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A842D838A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108437; cv=none; b=K9QH9ssbxp7nJbdRiP3cZ28zLVctV5nhsDfAYDk2EUWDmgfbNAKpRHHcfaGb1XMKgoGAYNIC6eiuUgxXwCZbxOcm+y0Qi06jKKhT3JXGcTQCzSD+e0FYbcTqlLgEovuVmDHec+/nIu1ClW2V37dqA4A4JJDko15c/mqMGz8zDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108437; c=relaxed/simple;
	bh=UeMi8wOq8P2oR2c8IuVTIvVV1TkHI2TplJ7c1V27Jf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riV8ovD4Weps+obnL4IDBsxNCSvytmny6Hir1V0eB8xDIxaodFSkhhr8sfAix/hz+AXuEyuquaO6H45Xq/Ruhttl+y7DI/laDjT4vbG6Y/6JCo1YnE2GF1l6b/caF4YrIQlgt977Kdp2XaE5sWN6Nxng/08cVDYXDMn0sVOqlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=EccNWSt6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27ee41e074dso75717985ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761108434; x=1761713234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmWpCjFNbINea3PWCqs9KAgYy8c0pAQxFWiD4F9OBQY=;
        b=EccNWSt6rR/AkhLRrRuYlWV4EgNbfzXGQiIvknZzTIxcZmDSuZcZRmsMPlpysFoZBk
         41ST4640h514xJP+IPqcrCwZyhhrkqd8W7pTlMjjj4sMU2Yr0Yrjf4g8+Xs4rPD660cy
         P2cuNmQl5fYNrHuHtXiGjbx1iduZPJgh4Z8ZTJgk+jyyuFaQUf5l+Az6xhhGBqNdIqzk
         ttGO51NfXXAozuqnpDkm7OUUknh2u8EZ8TcaRjUg/XixQ/BPX5gX9tpNYAOU6Si97T2u
         IiAvsyQYSrZ3rT4maOoHVJMzrXwqsgI3lEq4su6kIYyb2BnvyHyjWGKicSd7d85I/6/7
         rxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108434; x=1761713234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmWpCjFNbINea3PWCqs9KAgYy8c0pAQxFWiD4F9OBQY=;
        b=KP7lolVC55/AEChXtQ3nH10L2Ag/hsQbEjI9egc0wD1CAiuo8FJXsYw04PvdiQ1Qm6
         gbtlaszXTfLbLCEQjD5cV2e2TFZ5mh46R9zxNLjN24BLj5kPvBdX7I5DXutks9WuZ+qo
         9CH1VdfzTL2a+N2OScqcBt5pq52bVGNQoxEOYpav/6lsqsPLZMfLD3xipHM4nBupaYLX
         uTGHkthFH4chpYGfgDsm5AggwMuI8G3yxUTdILjdXeCcYpPTpDZ1spqRbic96wl05EV4
         q8CuJomcXgN3kuCTlqmB6tZe6Bd1UflO8qW/8nrDhtJQ7ehlx04KfPPmXZsmR9SKEirl
         CiLA==
X-Forwarded-Encrypted: i=1; AJvYcCUcMHaAbwv1eZKyH0/EVXfHTHzUTHDHyW2dBrrDrl3B1oekwZRnKnPFoFMstwF77LTceN07Y6GUAAoIaL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QqpYJyscdNgwgA9H2qY2yfYLU2sfYc4cSel/wHtjhzR8m2mX
	KSXuKXqpqkYhs/OT9HiLBeK9bbCFiALZY2t+CQ1JLi8CD77M0pqr0Nm7GEpX7MLI1F0=
X-Gm-Gg: ASbGncvra7L6I0zPnpRO29m4v95I1FbLJkiBfNwB/LIAaNWKAYtZMkpQQE4ATxVgepH
	Y1jV+CYU0rL9ffuEk+lhoLn5r5o+xj0sW3pipbEE1JU9F+hNY4jDN+sKCJjS9AblTh+OiokH1PX
	nBerU9r/IJ+dBEGNFDVRVTKjy9mFuVU3tjG+YRJOdFo8Q2YtSDrlo/KplPeqFrUHoQ8NT9aAHRm
	c567q3CjNMJy3Gkb4gOrYuobvsWTdBp3bBb1v44EfBkE/rysipyO3ehBusETPhhEB8LiHxPSsrU
	PnKnHFBQ+EtgIn27lMAKiFRD0BS06CfJwLNvUA9DotvUrk0H3AliwwLEzQx/tjIKgXloRuS2yzL
	MOr7MobfMlxCPXKc+kuNCjKmGKCBlLZ1jEMQx8bnc4W/gn2BJB2IWLsC1y5+++LtJXjLbdKO/WW
	KjI0n9kHQtnzU1cGw=
X-Google-Smtp-Source: AGHT+IGQMINIDphenVyGBthc7D66TfZYg33GMQZDeFMiv4qZwcZZxv+fFMJb6PBNUzYeckgkRMS22A==
X-Received: by 2002:a17:902:dad0:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-290ca12180emr248707485ad.37.1761108434628;
        Tue, 21 Oct 2025 21:47:14 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:8004:e310:f3d:dd0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dd9d6sm1257413a91.7.2025.10.21.21.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:47:14 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 4/5] Documentation/hwmon: Add TSC1641 driver documentation
Date: Tue, 21 Oct 2025 21:47:07 -0700
Message-ID: <20251022044708.314287-5-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022044708.314287-1-igor@reznichenko.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hwmon documentation for the TSC1641 driver. This includes
description and the sysfs attributes.

Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 Documentation/hwmon/index.rst   |  1 +
 Documentation/hwmon/tsc1641.rst | 73 +++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/hwmon/tsc1641.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 51a5bdf75b08..4fb9f91f83b3 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -253,6 +253,7 @@ Hardware Monitoring Kernel Drivers
    tps40422
    tps53679
    tps546d24
+   tsc1641
    twl4030-madc-hwmon
    ucd9000
    ucd9200
diff --git a/Documentation/hwmon/tsc1641.rst b/Documentation/hwmon/tsc1641.rst
new file mode 100644
index 000000000000..a93d1e72c70e
--- /dev/null
+++ b/Documentation/hwmon/tsc1641.rst
@@ -0,0 +1,73 @@
+Kernel driver tsc1641
+=====================
+
+Supported chips:
+
+  * ST TSC1641
+
+    Prefix: 'tsc1641'
+
+    Addresses scanned: -
+
+    Datasheet:
+	https://www.st.com/resource/en/datasheet/tsc1641.pdf
+
+Author:
+	- Igor Reznichenko <igor@reznichenko.net>
+
+
+Description
+-----------
+
+The TSC1641 is a high-precision current, voltage, power, and temperature
+monitoring analog front-end (AFE). It monitors current into a shunt resistor and load
+voltage up to 60 V in a synchronized way. Digital bus interface is I2C/SMbus.
+The TSC1641 allows the assertion of several alerts regarding the voltage, current,
+power and temperature.
+
+Sysfs entries
+-------------
+
+==================== =======================================================
+in0_input            bus voltage (mV)
+in0_crit             bus voltage crit alarm limit (mV)
+in0_crit_alarm       bus voltage crit alarm limit exceeded
+in0_lcrit            bus voltage low-crit alarm limit (mV)
+in0_lcrit_alarm      bus voltage low-crit alarm limit exceeded
+
+curr1_input          current measurement (mA)
+curr1_crit           current crit alarm limit (mA)
+curr1_crit_alarm     current crit alarm limit exceeded
+curr1_lcrit          current low-crit alarm limit (mA)
+curr1_lcrit_alarm    current low-crit alarm limit exceeded
+
+power1_input         power measurement (uW)
+power1_crit          power crit alarm limit (uW)
+power1_crit_alarm    power crit alarm limit exceeded
+
+shunt_resistor       shunt resistor value (uOhms)
+shunt_voltage_uvolts shunt voltage raw measurement (uV)
+
+temp1_input          temperature measurement (mdegC)
+temp1_crit           temperature crit alarm limit (mdegC)
+temp1_crit_alarm     temperature crit alarm limit exceeded
+
+update_interval      data conversion time (1 - 33ms), longer conversion time corresponds
+                     to higher effective resolution in bits
+==================== =======================================================
+
+General Remarks
+---------------
+
+The TSC1641 driver requires the value of the external shunt resistor to
+correctly compute current and power measurements. The resistor value, in
+micro-ohms, should be provided either through the device tree property
+"shunt-resistor" or via the writable sysfs attribute "shunt_resistor".
+Please refer to the Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
+for bindings if the device tree is used.
+
+If the shunt resistor value is not specified in the device tree, the driver
+initializes it to 0 uOhm by default. In this state, current and power
+measurements will read as zero and are considered invalid. To enable these
+measurements, users must configure the correct shunt resistor value at
+runtime by writing to the "shunt_resistor" sysfs attribute.
-- 
2.43.0


