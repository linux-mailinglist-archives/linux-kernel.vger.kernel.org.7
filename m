Return-Path: <linux-kernel+bounces-746598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD5B128C0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB3AA5B30
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277781EFF92;
	Sat, 26 Jul 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA3lbjSp"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B734FBF6;
	Sat, 26 Jul 2025 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753501127; cv=none; b=FCIaSivBMlwTlfodnh3d4gy0G8uSUbvZg0GV23wtRPdbXee6MAjpSx1cH121YFexarBbsy07/CMyrxzyYrSnAEdAnRn6XdBJYMWXmxniX9nLs5Y8E+5tPEa/t5WYUKfXQ/C/JNTtVvtlwV3YVpMl9nLbeFZa/NW1SjUSE+hSyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753501127; c=relaxed/simple;
	bh=qRvtZwNhP4p+SR4y5WxEk/ywS7gGmoQP8IK//Q2npro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IYrsIlH0E74WZ5TnkYY3bP3kfndPSJso4H5l2PCvlWO9VkJgRB1brIILg59avP8h90BBmuYQhlhXhLid0qMkQv65zTcIp31aYC94ktZx7iWw2KO043VbdSZ1zS6DrJn6rkvHfC4B4yLjZJy5JFBpD6trdOPftcxZCXMHVIVXuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA3lbjSp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso2227055a91.2;
        Fri, 25 Jul 2025 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753501125; x=1754105925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Il5e9mDlMCv0IQUFSJTULOpS+fbb3WCVY2Xz/KLOLC8=;
        b=fA3lbjSpGAkFGZjAnwvDzhPydV/EX1DZHJUwVCIh5alnPHQI1Tv1M323cUe7SydJ2Q
         cqXV4LZdmW5OaDpNRzLAIYAEnEL3EPcAmLZGA9F4L0vIcvfWb5N3e/wG5mJGrWd2yE0R
         rZqgs525lS9Ip1BUJg/f5L7JHQgTDXV2IViAdteaHg9k6O+/fy/g8BPQBsY09+zcWejX
         zxDV4sR6VYtXpTYLWddsdu3H4LIhOLj88g0RyvvXNEt7VyiB5eYFb2La133RlUwho003
         SCORtQMoJ9qcj+mUXCBPQ000epZfXiqRE1MyhlFKMuQU7xTVAs0v2B7phvwp8CSndAhR
         Rqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753501125; x=1754105925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il5e9mDlMCv0IQUFSJTULOpS+fbb3WCVY2Xz/KLOLC8=;
        b=smXhWFatqE/upUtbhAIa/PBftE7ugM+z+BMA2cO6DAHfs/Dr7wdNAKnxPv0XAjcrHd
         WJ1vUy245f0aHIQ4Fyjav1oKMDDU6rROFsIB8fQe4o8kxsJ2vfo9mM2Q0gwwaLc0SYtI
         2oeROdTB5J5NNfYryI3AuQf2HXjqksdEXOPUoOk4G7yXHu2KAnKZklPcWq7j0qE+6BGe
         A6a3PuU6eqhioLlLSSeLPrLLZaP/+7hSfxT1RUws8U/4axxnEY8Ll2pyo4IlLUXNEch7
         YOYK5haAq5rRh9cFZ8+/bPhGhPAinuMPhnU/sZm/GmLkDxu+DAdw0sJ/rMgWZekz5df/
         jbKw==
X-Forwarded-Encrypted: i=1; AJvYcCUOhGVhUIyd4e5kmDC4N9oKAUFFEPpfbd8eyYdgVPcEcGNnqpT/pjr2TZuQr9JSF73fwRzMb0i3tn4=@vger.kernel.org, AJvYcCVRQJm43Gf4C4yvSNmp+FCC4ao+ko8HqEWnPzmcU82oOYXnDYip3OOKvPG/fGWXCM9MK/AsmaFSzS0qX8Kq@vger.kernel.org, AJvYcCVhIvenXvrSjp/UmSRIK73bf6AN+bJWueCi7SLzr2eHfuiifOihG7TB8cAvoSSNNyV/kUoJHP9g9YlVP7I=@vger.kernel.org, AJvYcCWp2OSVmfcBuHtXBCS4i2VPkkCJKwTWFOXtHtkN+0FqckVIvMEVa+kSQWNUnPLN2xjJLgbeM+WXQHnhJ9LUI5SdkwbtfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAmsW9GuvdXUv8pL2AUmqrj8xbITUzW77hPZpm14Swn/VX1FQ
	Zy7VJwIZnmYrj3iJX5/u4viCnroEkKOr1Oh85mlrJKwMWk9S6HBAWS8A
X-Gm-Gg: ASbGnctKV1B57Z9JjHbQ2z1ZaND92Nfg29adVOfUxlYmwb2ytEPo2BQU7CbSNq539zq
	Cw+RnaUZR17RD+Okry48i2y12x+zn+94B2PHzyYGu7EI+rWOyDIzi2UCiEli6M/OzSbVh3OQ9lh
	VmUpTyUq0w3/cQiKIXBMSaJPytDrgZMLaTUvB+qVUy86MjR5M5KwR6VO5EA0p5XlLwhngFFDoDT
	xcVBkxH9EyzIzSerFhYLnelQnAnt/uk5S6aS9sjt9/SnwV6OrdRMFj6XeU375m2urvvv1Vc7xy0
	aUUVabYRJzZRt4usLHYmvAlfWKAPFCd640uHGyf7/q3N4heyLCG5rv/JryZe9NVQdAPW0vF1xWD
	IfB/pdsy9XwJnETdffIwvWSJL57ZDSRgNaqvJ4jhvW5D33PSwMicFuAqIEYDzXF0uyjPEtl85vx
	DE+0k0VSQIs3s4
X-Google-Smtp-Source: AGHT+IEQlCYkQpDnNocDdpQGVddZquxM201R9JZA11JoqSKgBNHCuD4uHLDtOlIZBPV5hvgdU00b4A==
X-Received: by 2002:a17:90b:5848:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-31e778f1a6fmr6816376a91.19.1753501125298;
        Fri, 25 Jul 2025 20:38:45 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832f8942sm779204a91.4.2025.07.25.20.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 20:38:44 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/4] Add Ayn EC Platform Driver
Date: Fri, 25 Jul 2025 20:38:37 -0700
Message-ID: <20250726033841.7474-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds platform driver for Ayn Loki and Tactoy Zeenix handheld devices.
Tactoy devices are rebranded Ayn devices with minor modifications to the
DMI. The device EC has multiple features implemented by this driver,
including a PWN fan with manual and EC controlled automatic modes as
well as a user deviced fan curve mode, temperature sensors, and chassis
RGB control.

This driver implements PWN fan and temperature control via a hwmon
interface, and an RGB chassis interface via a multicolor LED class
device. I attempted to break the driver up into four logical patches.
Patch 1 adds PWM fan control via a hwmon interface. Patch 2 expands the
hwmon interface by adding the temperature sensors. Patch 3 adds the
chassis RGB interface through the leds subsystem. Patch 4 adds ABI
documentation for the sysfs entries that aren't provided by the standard
interfaces, but are needed to fully control the device.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v2:
- Fix nits from Alok Tiwari.
v1:
https://lore.kernel.org/platform-driver-x86/C7073C0E-3D58-41C3-99B7-A0A5EE448700@gmail.com/T/#mb795b8f5e5ff3c5b88fdd62bd6c97eab404fbc4e
Derek J. Clark (4):
  platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
  platform/x86: (ayn-ec) Add Temperature Sensors
  platform/x86: (ayn-ec) Add RGB Interface
  platform/x86: (ayn-ec) Add Ayn EC Platform Documentation

 .../ABI/testing/sysfs-platform-ayn-ec         |  59 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  14 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/ayn-ec.c                 | 965 ++++++++++++++++++
 5 files changed, 1048 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayn-ec
 create mode 100644 drivers/platform/x86/ayn-ec.c

-- 
2.50.1


