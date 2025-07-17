Return-Path: <linux-kernel+bounces-734714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0028AB0852B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C0C582B76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01231217F36;
	Thu, 17 Jul 2025 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiGG2Thk"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF732165E9;
	Thu, 17 Jul 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734403; cv=none; b=TrG+k0YDt3NrELhovZd7RMWmUifkork2cCv+QZ8J6XNUA/8PgZ1r79valwNAh1e+RH+NyF51SsYcjAqZA5iFeRHiOLYDys9duij2+lnNT9CQQr9crsVIiWR9eiRuLjQrc9DbwOrri6V5oSSzBG1sAjYCbHBEWofriP3mLgxzhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734403; c=relaxed/simple;
	bh=FOwrYap0C+Q2bAfyx3Lcq1/wS68YKniFGAb8KpHxR3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLProzzKsVRcz8+B27VHi//6MNnsAteXl9AvWABiAAM3uNEh1F7wzmmLA/yJoMZyLIkKHANtB6NoiUKwG7emQx3gC44uVj6LaCFDG4UEz/bFxpFECugDgNXigFc3wH4Izhvu03SMfBIXnZEzPMudpWHCk0HDL+EXTlfFh1sDDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiGG2Thk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a575a988f9so345834f8f.0;
        Wed, 16 Jul 2025 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752734400; x=1753339200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvH5ieIqn/N7rU9c7tBVXf0IRbi6URCwXZn/t6FgS3g=;
        b=DiGG2Thkwxjlj2Saa6UIDGC1c9uf0GeUfIb77iSit2iHaKWHKyXR7PiRfyX/8126nu
         mWQDwXxRLZrTK/P8m26anN4iWFZjuz+QFVquDbYAowQ0HEqMzGsyxzGe2LEryqrUy9hy
         P3qJao5gsOiKcLMnH34HEoX+FruLoJp1IQY5znLLHXM14OVZDx+r7Vd0lt3mIsZuivVe
         4PXFg+5l/fqR+O8zAo89upmwEM8L+NAFRWUqB4g9dcZTN22LQkZ4cECTiciDPVc/LhE+
         Btz/tkuS8XE4+aIx5M626HjeaKOa55tXICIMs5dl6BLmRpGsGDoZLDSRuWeHngkXl390
         LMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752734400; x=1753339200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvH5ieIqn/N7rU9c7tBVXf0IRbi6URCwXZn/t6FgS3g=;
        b=mOCfgccuYa0Sy8RmFy4MuorjcsrHYB7xplIJhNHevfuAMnacBl20VFCf2ryjpmOMgi
         BdyvbVzYq5DF5jk2E+I142lXpMhbQc1jbnEvQwHui3KpeF/JvCk3q6NdI5wH0/0DIOo2
         S4uP1XOyEZ5KKEnVPXEtM9MsnkWcQYqGuP4OkUzRCCz9+utNWTp6AMAwvEtI0DJBXH5f
         R3MXGAAVjzNBfu5fGZyAI7x3q+/sJHbcavEUQh0FcQLqZD+9iuRWm7vHf3YTjUzMbnX6
         ehlascJH0xVsASUEz44M48WwBaxpf4+UK6gUvszyaSokcGpti+UHXbmx45dYWHcLfJcF
         JwPg==
X-Forwarded-Encrypted: i=1; AJvYcCUmZguA/nMgjjnLTE34qjTRcDjTederhL3w5mp7nXhniV31tltu4ffyevwtvmVcxACyuMhDFL76j+jnoB3f@vger.kernel.org, AJvYcCXlWmbTY6mjsaxfCVC6HWaXr6NhFGfZTB6yhGKnndyIotU33mpOlJfvLS8HinCqjUfNS/I85zU66xNo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2S1wP4d7VZsT4bLDvVe1yvyMhNJ83UQXBBLMO+9W1mv+yf2nj
	VEogQoAaxOY8l4qbZOSXep1YVFAoT/e8tq/KNT55Yk98cEhY4AB+zJEb
X-Gm-Gg: ASbGncvgzZVdnMqDAsOFtYbrm4biVPn4yUlMK2QiiwAvErmbfGKx3P2JSEhANX6prlZ
	j5Uf85o33rbPGhczIA+YyAuI+OvyEUvjbiW1/gk6PxLYdFcKXDA95vYOySAifPwRxUvKsyeehYO
	+HdGEncMlW27AnJzFmYfQNZms3tS4NoBqFMBBe6yo/JSoK7B1Q+4cvxx2F/QoO8qSbIgsZrGTld
	aGFRqg2lyH2RUD/MDwcadmzTZp8j/0YzS51RPyUlVzd6/PWstKjcrrXynNBgGE+iP2PGg8gH897
	xS+rjs+w16AiE1aAO3JiSrU9SgVPNj0d7TnFFO2LzIxCu8yylGi7IzQGHpsd9Zravc3lIjMveBZ
	A/EchOUT6nZm3bqjP80oU
X-Google-Smtp-Source: AGHT+IF1uATJf1jyKEvf7QGwbOx+zIJyxueFdmMaVN9Y3KPZPvUpsaRr2blcRCoyHEnIlkswFsXO+Q==
X-Received: by 2002:adf:cc0c:0:b0:3b4:4790:8415 with SMTP id ffacd0b85a97d-3b60dd8d9a9mr4003927f8f.48.1752734399464;
        Wed, 16 Jul 2025 23:39:59 -0700 (PDT)
Received: from masalkhi.. ([61.8.129.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e135sm20039788f8f.72.2025.07.16.23.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:39:59 -0700 (PDT)
From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: conor+dt@kernel.org,
	luoyifan@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	abd.masalkhi@gmail.com
Subject: [PATCH v7 0/3] Add support for STMicroelectronics M24LR EEPROM/NFC chips
Date: Thu, 17 Jul 2025 06:39:31 +0000
Message-ID: <20250717063934.5083-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the STMicroelectronics M24LR series
RFID/NFC EEPROM devices. These chips expose two I2C addresses: the primary
one provides access to system control and configuration registers, while
the secondary address is used for EEPROM access.

The driver implements both functionalities:
 - A sysfs-based interface for the control and system parameter registers.
 - EEPROM access via the nvmem subsystem using a secondary I2C dummy
   client.

Tested on: M24LR04E-R using Yocto on Raspberry Pi 4

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>

Abd-Alrhman Masalkhi (3):
  dt-bindings: eeprom: Add ST M24LR support
  eeprom: add driver for ST M24LR series RFID/NFC EEPROM chips
  ABI: sysfs: add documentation for ST M24LR EEPROM and control
    interface

 .../ABI/testing/sysfs-bus-i2c-devices-m24lr   | 100 +++
 .../devicetree/bindings/eeprom/st,m24lr.yaml  |  52 ++
 drivers/misc/eeprom/Kconfig                   |  18 +
 drivers/misc/eeprom/Makefile                  |   1 +
 drivers/misc/eeprom/m24lr.c                   | 606 ++++++++++++++++++
 5 files changed, 777 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
 create mode 100644 Documentation/devicetree/bindings/eeprom/st,m24lr.yaml
 create mode 100644 drivers/misc/eeprom/m24lr.c

-- 
2.43.0


