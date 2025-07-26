Return-Path: <linux-kernel+bounces-746868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FDB12C41
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B912D17BFA9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82349288C14;
	Sat, 26 Jul 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC7lL29A"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81835215F7C;
	Sat, 26 Jul 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562448; cv=none; b=Eo41XhCphdmSKHTEk4r/nMTHB9b6NLrGOhy8IpVJLalIGyB4vcWb/7CCSfp83usRGYhEkC3vsrG9o1a40J+kWAlRuN8eX5RXnO9UvcSPNIwgN0ZAA1RPx3BgwErsS1HlvA7TbwlVRYkadxm/w4aJdyg/Jfz1Ad7nYr78tyt10lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562448; c=relaxed/simple;
	bh=4sQvqkSNj9EcALbqeibJH59m7bZxRihaYqqbJNO4wDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZfi3fSOQz8DVNDI+jcyUqnCLPu6c09jTAOYx3l1cmxSv7LV2RYYXL02HDgwLTZ6T7ETPE1/vwwDLZx29biFlHHsVTwoQvtKzQdK+sHLau71kDsr3bgFNmL1BETlkMMmHnMulUIoaPiSfvl99G/r2pBJGiSOVSJFLEZ0cRXytmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC7lL29A; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31eb40b050bso190472a91.0;
        Sat, 26 Jul 2025 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753562446; x=1754167246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1chmdF+mBFRkEW9NI3UNLkfUDe05EZUqqnUY28WTaA=;
        b=AC7lL29ATOpRyh+vOqLZs9wp7ToGzBYg3PhQkXh54cqAsmWC1SUEBSnTW3z/PLK7Vu
         ikw4uWuwGGojX95U+MnNUMiZhIjEuzhinc7BO9ZBjqf7p8GNcN5aX445HrhGjT2aKHgb
         iOLu7r69Q0oiZ1ZUoL4LjoysuIM9Q8EVM1NQdxHAqEV2YMNKZcDVHz5xkjo39Fxcx/em
         GHf1/1DHgpIh3Ca9fJoBM2a0u71R4wEFYO2tNe91riRpOZL0iTN6vp/MatEak2YPLRk/
         8AQBZG1RXr+ppckxuth6DXXu44CpKqEuCDHygaS9Fr6POVoiQLFreYwDSwjPqCXWRwPA
         YB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562446; x=1754167246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1chmdF+mBFRkEW9NI3UNLkfUDe05EZUqqnUY28WTaA=;
        b=rV96wO8zqfhXoUWXvSOlaxRwU8k78UBYP/3yfnDvtk2m3hPyu1ktfMWKIjbpdnlN+Y
         +b3VNBTXeBrzM5yJH1k1RjU2ljlMp9+3J+6ylLuX4c14vRR9RP/nZGHiwmBKMVCSTSmq
         0jUQXcvdy7obMdjq/Fehbx4lSXq5Op/wJLg7FS13BdH7gHTmBMhXfkaWT0OYHixpAByD
         /p8Md25vR1gD+N9nkUYIRRme6mB1wz9L45e2glnhkzrr+IBvzmud5XzmAzI4fdBnrZfz
         ygdIZMJNq1etXfDdB91/JbsoAi8fd49c2X4NW7wGmys0h3DT/gLnkMp+M/0pA8k/V/un
         X9sw==
X-Forwarded-Encrypted: i=1; AJvYcCUCusarIw2EwL+zaF4CnEK0MXnaWfusqaiSc6/SDIsb1VvgGfDt6XdVwfGv1wR2Dk+FJ/YDtsOV36NLd9B0@vger.kernel.org, AJvYcCXWUJP3zZYpT9Gt872EKlEmfuOcX8I4jW/ifc/dmtHRSTNyQyI0FjwjWEP10EY4mMaFirFttBXHBpnlSX7j+kk4G0/iJA==@vger.kernel.org, AJvYcCXYqQMwLcQmILLs4kXfN6PwQmAgaGS8vE4ZHdeBQhe+diWGedLCZQ31fb6iqMFOAAVxRJHnhQuzC9XLKGw=@vger.kernel.org, AJvYcCXod0HcXvGaL4y1tOiKWvxUmchNPOcyundklO9nhrH0pk6pRuJOskqPW6lUuoix9dH1ly4tCTeVeSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4J/iRoyCxFDzcGoq+ZNL8II8y+aInZfJmDSPY7WQT7CigEae3
	mIUldN0WzAu7ajNTKLWp7SHyqmGpM0PmoQ+G/XHIegfOQ2ft3iJu0Y8b
X-Gm-Gg: ASbGncvSB4pZUO2cetO8SAPn7N+tlk3BSqfCPIDKoMq6d/EVXmxrmTFj7cBU4TOBiMb
	WEP2nWB2aPeMbAr1Dv0XCw2jyQFE5zppBaQYg2d+pkLxWcO0q5PV3rLKfQAwLsMBLDnUeU4xGy3
	UfTNMdyApC1ysBAm1o8B8WRKeNf8kZEX6wtVkXsk65nyA4JaDlIW3cd9PwxTasyrBbjYW0RCR3N
	5GLqVArx4ApGBhTrsaV8m96oMcI4aaicuMBvTKXekbB8ayWozkvnBNWbvifkQbKpRomBsOD3tyC
	qlEeg/RhqmXvjB0KNyFDCn6d3w0LjnHnDrGba2rCWw6+9S+khJ77K8SpFWeM5AmGbCar2CUpziN
	9IaqIBItJ8eyonZC2Ej9ZT7vCOxvjLSwdO3xwmqH0ysxIjlkkzTAkTeZ4fzVFAKVJf0heeU2sHu
	rdrw==
X-Google-Smtp-Source: AGHT+IFDl2rhJ5qgEr5kzeZJjKkrinQy/7xmnewKm+qdH/4/J8yfC7ROGz8jQHx1zm3jOgwIgwD3vA==
X-Received: by 2002:a17:90b:1c07:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-31e779fcf83mr8870021a91.27.1753562446347;
        Sat, 26 Jul 2025 13:40:46 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8ea37b21sm1905640a91.22.2025.07.26.13.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 13:40:46 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	David Box <david.e.box@linux.intel.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 0/4] Add AYN EC Platform Driver
Date: Sat, 26 Jul 2025 13:40:37 -0700
Message-ID: <20250726204041.516440-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds platform driver for AYN Loki and Tectoy Zeenix handheld devices.
Tectoy devices are rebranded AYN devices with minor modifications to the
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
v3:
- Include suggestions from David Box.
- Fix Tactoy/Toctoy > Tectoy typos.
- Change Ayn > AYN.
- Remove .driver_data in dmi table, add .ident to all DMI entries, and remove ayn_model
  enum.
v2:
https://lore.kernel.org/platform-driver-x86/20250726033841.7474-1-derekjohn.clark@gmail.com/
v1:
https://lore.kernel.org/platform-driver-x86/20250725004533.63537-1-derekjohn.clark@gmail.com/
Derek J. Clark (4):
  platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
  platform/x86: (ayn-ec) Add Temperature Sensors
  platform/x86: (ayn-ec) Add RGB Interface
  platform/x86: (ayn-ec) Add AYN EC Platform Documentation

 .../ABI/testing/sysfs-platform-ayn-ec         |  59 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  15 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/ayn-ec.c                 | 889 ++++++++++++++++++
 5 files changed, 973 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayn-ec
 create mode 100644 drivers/platform/x86/ayn-ec.c

-- 
2.50.1


