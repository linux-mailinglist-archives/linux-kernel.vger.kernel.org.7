Return-Path: <linux-kernel+bounces-861687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76747BF35B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E49FA350F30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E390E2D7DC1;
	Mon, 20 Oct 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI0FsbUI"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5B29ACE5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991447; cv=none; b=t+658+nG1p5Icgaev92eFisdkeIHu9jTmh9VqwrpVwmwCMIvb908A13sXzJqKzxbUntHfHqszlxEhhLD0zK6oc3jjT245gcvGPZholeU5oP5iUw386xRzNvfUBNKtYlh0Hxl4mfR5cVWzv2itvV6y1TrQgQi+L1J6wR2B0PQfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991447; c=relaxed/simple;
	bh=eir2cELdE6ctxydT2A/YX9aeKQVEZfkkSYcoewgfQYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkBAuM/yFHSpx8zFPMDWKb8OvpyWx+urXuZezKC5HXllNIhK/dyexym5P1hK/FuWPjM3iJ8EniVNsExoze2/JJzDZ1DOhI8rJ24kbe585T3jU0FMHQu797ewaJloZOiJ8Mau79P/EHQj4CXlQm2MwTIye6i+5dB6zI0jG4HcxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI0FsbUI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7810289cd4bso4586786b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760991445; x=1761596245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXI3yOz2/6xxfRvTcNICPRU7XaRQOsBCnm/A8qDs1ro=;
        b=LI0FsbUIR5lqNzvLvL+OOd10gNBZSSLWxu9VYAcR6XkDcw46yo652LUjRhZDbswG73
         /pigvx1tqZ3CGKTsMkULYPdO7keEBlIzOo+ax7OnhFjHeG50AuQvFKYVRZPL9pDxLX8V
         x7xUtKIu+gmagY+spPosHu8t0OjArHV4FFGQHPCnIaH7p8fnabOy+eHeT5ovMi5BXJUj
         ZT2fj+fCJJXSPahOZEWbxEb+zFocOZ2zNuJ4NHzKqH2QPXHAogHy8KkLumkkI64tNya6
         hCUIOD8vBe6Bzj0U3tAYmXgfSCrAtirIqL2hP0ge+J1HqI+mhR9k1zOAtNUcOBfPAA6a
         bLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991445; x=1761596245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXI3yOz2/6xxfRvTcNICPRU7XaRQOsBCnm/A8qDs1ro=;
        b=qJ+Tni2Zvvb3dOZKNjA1LQOK7vl57SDKN7znHnLN95hiVVe5l44U9hFnwciA7XGwn3
         XxdF7CZoFc9AUSlYewOtDjkuWuJlSX32mlPUoPG89WhvQMR+lFCKXzhbNlZQcbUKyCUN
         TTxI1vcNjL4bn/7B58lkGMgyWzZlIpd1PwrAGtncbb87u6ZT2AxgydqsgyaPP5dT1nv6
         tgRWJK+sbBA3hEeqXM3rb/3FrFCjbMbGdfVWUWoa+1iIdLESZ2ODgNoeHpQ0ohvrgUmL
         GmmS1NA4Nl0ld8gEgpZf1nrukwEtORhaMb1JHp4iYaHa4KFXw66Sm/RKSZ50+HjsphoF
         f1lA==
X-Forwarded-Encrypted: i=1; AJvYcCWaYQp/KXkNQHFJfIoUzW+Y87XiX7UpPncV1fOOfb4bShFkzHmlCCI8+EJg+E34R1bfH963Gja1MwrR4Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQjINBjFotCLdtdBwomM9+HllDl02o1goHENgYiTrdaGvbzTp
	S5FCqt8RtDzaE+CLp46YuNpcKFxOs0vEeCtwKSUxSsf+ZKz8l1afzVAG
X-Gm-Gg: ASbGncu7p+K7vRSb3DJHLQ/IGTm0VN78kwkm2K/5AVBEj5VinmipmMbrRQeOh/R0Ea6
	6ZlWW3lQWhfDGtfllQMckFGT4fFwHiutzkz1xCAGpCjPnoaIF8oZsbWLtm+Q3s56c+jVsYMawOv
	LABAiR5qgioqv9rcA7z8URRqduL8qQ1oPioK41TPYrpmKJL5irQAkxwZLlCH4stOWRQ2+rji3jq
	mZaCxjMWolbYhcWhxmGsJK0wmBe4uk83QcKInOrVy8IArZUhCAjnJdRRPPwVNKyeHP2+Lt9RXXz
	ZY3Kzdgl5QMQZYaI4QIxeQxbh+ghvS5soD5wo0ihjmtcW/I/rD5iYFuULMIh7Nr2g8W0nQqOa1A
	yZIp6odGHJLHtdlH6InOU620E3YJ+XTwjhJ5n4QsHwbPBG9hl91kuxe0/jfUdRjle508CkzvyTA
	1EKFFHOq7M06s=
X-Google-Smtp-Source: AGHT+IH2Vu7r+p87tUPq6VF6+nbRh0pDhjMUf60C3OqTCJquCWzcP76GusrxnipnDCr3SE1kNgrVqQ==
X-Received: by 2002:a05:6a00:2e1f:b0:78a:eff2:6c0 with SMTP id d2e1a72fcca58-7a220b1dd00mr16143036b3a.25.1760991444707;
        Mon, 20 Oct 2025 13:17:24 -0700 (PDT)
Received: from pop-os.. ([106.222.200.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm9104263b3a.59.2025.10.20.13.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:17:24 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Frank Zago <frank@zago.net>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] New driver for ams AS5600 Position Sensor
Date: Tue, 21 Oct 2025 01:46:51 +0530
Message-Id: <20251020201653.86181-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the ams AS5600 Position Sensor.

The AS5600 is a Hall-based rotary magnetic position sensor using
planar sensors that convert the magnetic field component perpendicular
to the surface of the chip into a voltage, or a numerical value
available through i2c.

The driver registers the chip as an IIO_ANGL device.
It also exposes the raw registers through debugfs for further configuration.

Datasheet: https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
Co-developed-by: Frank Zago <frank@zago.net> 
Signed-off-by: Frank Zago <frank@zago.net>
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---

This patch is based on the work done by Frank Zago:
v2: https://lore.kernel.org/all/20211225175353.4254-1-frank@zago.net/
v1: https://lore.kernel.org/all/20211216202651.120172-1-frank@zago.net/

I have done the changes suggested by Jonathan Cameron in the follow-ups.

I picked this up because there has been no progress on this since 2021 and
Frank Zago has previously stated he isn't trying to upstream his drivers:
https://lore.kernel.org/all/e052d872-6de2-42f4-8b36-d1e2f8359624@zago.net/

Currently, I have not added support for:
- OUT (PWM)
- PGO (GPIO used for OTP)
- DIR (GPIO used for clockwise/anti-clockwise detection)

I have tested this on a Beaglebone Black with as5600 support compiled as a
kernel module (m) as well as in-kernel (y).

changes since Frank Zago's v2:
- direct register access in debugfs is now raw register access without any
  mappings as suggested by Jonathan Cameron
- added device tree support and bindings
- in as5600_probe(), reading ZPOS and MPOS should be a word not a byte
- removed "Read then write" behavior in as5600_reg_access_write() since
  register access is now raw, reading and manipulating the correct bits and
  writing is now the duty of userspace.
- changed "Datasheet" links to the product page instead of the direct PDF
  since the PDF links are not stable


Aditya Dutt (2):
  dt-bindings: iio: position: Add ams AS5600 Position Sensor
  iio: position: Add support for ams AS5600 angle sensor

 .../bindings/iio/position/ams,as5600.yaml     |  42 ++
 Documentation/iio/as5600.rst                  |  84 ++++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   8 +
 drivers/iio/position/Kconfig                  |  10 +
 drivers/iio/position/Makefile                 |   1 +
 drivers/iio/position/as5600.c                 | 373 ++++++++++++++++++
 7 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
 create mode 100644 Documentation/iio/as5600.rst
 create mode 100644 drivers/iio/position/as5600.c

-- 
2.34.1


