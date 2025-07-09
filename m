Return-Path: <linux-kernel+bounces-724138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9D4AFEF14
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544697AD2FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB0222560;
	Wed,  9 Jul 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxZrs6iH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB522126D;
	Wed,  9 Jul 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079717; cv=none; b=uOEBZw9SRVjsErla8NF0HWE3S1TuoSapThMIPN9WJz/MrCyK70UOpzHtqTvCZI+SRft0Kq1YMLED+2tOd7093RAVHHuhrHxuedD28+6LS82/+6+rVcTSoJbx0so+f3teJcm3HPto2X6UeYgPQVyfM+m7/AIhWaG9BY9d+ivqGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079717; c=relaxed/simple;
	bh=+Wvy0QrkFM8ErtW89wfN/miq+b9qUtW4KmImpNXWJhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M34EVJ6eJDKQtp0Btdfc4PGhNWtEm2CiNbRihv0W/86zQye46yeMuVwzeb0/QSlrBS7OKigIWe5zCToffkkVywpfxjXq/926sYKcRXwWAKeS4ecdTMjsInaP7qf00qVm6rM7Nqas+8kS6rtQ/McHxOJ0z3vMvdhBIPMLFwYaarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxZrs6iH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so130937f8f.3;
        Wed, 09 Jul 2025 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752079714; x=1752684514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrGZs5jWjyapgQrtbVwuPUJPiUwVTg3fG34Q6ZFAHDI=;
        b=mxZrs6iHMBsnaaRAoDlABQwn40HnvZlLFSJTkeRxdPWg9cg1mo0Oyi4DvhNCAsg6Hp
         67TNk9i3EoVN+LMGyT23CyU5MNhttw0paP5Qov50Y3UN2R7882h9jglUmBuN/6qxWA4B
         /2mwOrfj52OnYVtHmMPqY1rmhNmQDwigERVPk9rV5Vrf5ao2C1bMoyP8HOSMuPDgqoxm
         6Ze5LmJddQSND6PorKkph2a1s/+XD2Crf4YbW/ij0C0YT7aIHQMyGirQRKlp+CCGFg2V
         09cT9cWqewAt/75j9jvsA+eb2SuGlPNtk2UobN48MhPZLef4+51Y++DivR4+ZcR+vmYP
         ijaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752079714; x=1752684514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrGZs5jWjyapgQrtbVwuPUJPiUwVTg3fG34Q6ZFAHDI=;
        b=vbWrFtUU3uLS/AdPUNJJdmkIWYYkDKNxzvZ9YDDF82p+nkW+rg1K5Xhf1KHMrdFqgM
         KOVSt99QlWtb1oS3xB9gDiHeCiSpl0KFR5ksA9/5MnjNAqbG3lnKFwpYRK3CGIE516l0
         dmF1g+gK/IPtKzaeEtp6nVUXwAf4PCh+O9AbIv3qz+sqpjLhEzP3RBjEmpmdKUN2YMk5
         gu8uQ3wCw1U+XOQzEYGHLJeroU2RISe6mXf2rH+IhncWtKCKRnORM+n0EZEaAJiigUVJ
         ryaxnc8sgcOba37Az7nX4axzoiiA/dn4o5U3BEjvNGjF+wrmGtvFKisGCxe7xFgR2F0N
         h6xw==
X-Forwarded-Encrypted: i=1; AJvYcCV6aq7YTpmHc93guBXWNYuY9p/mM6JaStCSqGeTd3MbTsSUbctCQBXhkuYdWah7ZSBzipfdGrjfYEdw0K0x@vger.kernel.org, AJvYcCW93P54vWP5HnjWNMUPmDJhJDSgaX6qtXWoNs8kdQYPWkreplkCIwyDczSogL/YhAmpkyp8EM8fkoA4@vger.kernel.org, AJvYcCXMQkKjBZnjRUf2HPU8AiTki70TAPp+3vhDq60a7FCU9th1Bk5G3DIWjX2rqKxCJsLo9fEeI1lKPep5DmI=@vger.kernel.org, AJvYcCXsONBqC1HO1PGLATxU4PZrXeLL7jj3Kxyv+AwNxO+IygU7GACuq1Ax3+3JOkqlqzi1LozxZHcpZFHh@vger.kernel.org
X-Gm-Message-State: AOJu0YxTR9rEkQmQHUF39FUeCjFEfpIZ3UNte+H1w54CBpUDsNJ94EGZ
	5GITbbSK8nybL8YLR07tTCLq1DlOrycZj5ArctMwQdpsfGWFaB48ETtX
X-Gm-Gg: ASbGncvPrVOKtbbJlPYMugW402gR++RwaQcievIO0AeLnzk4MkQfROjR8REXU1+tgvJ
	Re/yP243vwU5/x/LD4HJBXi88xizlrUFFUZ8Ck8g22RjVjB9X7Vms5rHOpy/BIqKlJ3o/40Fdla
	SPFSJvIFLa7Vz6wPBmjH8/nNkTHQSAyFDfa2Z2w5z0rU/ErIW0IQxYleYPpWpGFpFSKvJ8eV+PC
	VIEWJfr+eeoSebpnJjFyFNSkP4ipqcPlNHF3A6orxKuxQoxdNoJK4RB4cMGO8G7m/T40gmTzZOB
	kMOPSiVUnId/YEwAtCRtUuDH+PvfG+8URL7YTWkXwwhQ9yj1HC+wljK+lvIR/f4a5LPXDsuQeiQ
	TSv9IDzkveFXVruexaXOGpZ/WMxg6APT1jkCvsFvtXzPKh/X5abqA7wW3tcVc0mk=
X-Google-Smtp-Source: AGHT+IEzaqO8Nmpouw1+Ozmi1CRBtI2s9NwQTa8vQJC8qBTSYiAuFxWE8+OIWLluNqhSGzTxv88RUg==
X-Received: by 2002:a05:6000:4712:b0:3b4:9721:2b13 with SMTP id ffacd0b85a97d-3b5e450988cmr2784345f8f.14.1752079713892;
        Wed, 09 Jul 2025 09:48:33 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2e00-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2e00::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50df125sm30634915e9.19.2025.07.09.09.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:48:32 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH v3 0/3] hwmon: add Microchip EMC2101 driver
Date: Wed,  9 Jul 2025 18:48:26 +0200
Message-Id: <20250709164829.3072944-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Microchip EMC2101 is a SMBus 2.0 fan controller with temperature
monitoring.

It supports up to 1 fan, 1 internal temperature sensor, 1 external
temperature sensor and an 8 entry look up table to create a
programmable temperature response.

v3: multiple improvements:
 - rst: drop emc2101-r (same chip, loads config from EEPROM).
 - dt: fix errors, remove patternProperties and drop emc2101-r.
 - Switch to regmap-i2c.
 - Use regmap fields.
 - Add Power Management support.
 - Demote dev_info() to dev_dbg().
 - Remove "emc2101-r" i2c_device_id.
 - Remove "microchip,emc2101-r" of_device_id.
 - Properly implement standby mode.
 - Use milliseconds instead of millihertz for update_interval.
 - Drop mutex except for FAN_LUT_DISABLE and TEMP_EXT_CRIT_UNLOCK.
 - Fix u16 fraction temperature conversions.
 - Other code cleanups and refactors.

v2: multiple improvements:
 - add emc2101.rst to index.rst.
 - add missing documentation properties.
 - Remove FAN_RPM_MIN definition.
 - Rename FAN_FALSE_READ to FAN_MIN_READ.
 - pwm_auto_point_temp_hyst_store(): simplify function.
 - emc2101_fan_min_read(): add missing FAN_MIN_READ condition.
 - emc2101_fan_min_write(): fix tach_count calculation.
 - emc2101_init(): fix REG_TACH_MIN value.

Álvaro Fernández Rojas (3):
  docs: hwmon: add emc2101.rst to docs
  dt-bindings: hwmon: Add Microchip EMC2101 support
  drivers: hwmon: add EMC2101 driver

 .../bindings/hwmon/microchip,emc2101.yaml     |   59 +
 Documentation/hwmon/emc2101.rst               |   61 +
 Documentation/hwmon/index.rst                 |    1 +
 drivers/hwmon/Kconfig                         |   11 +
 drivers/hwmon/Makefile                        |    1 +
 drivers/hwmon/emc2101.c                       | 2176 +++++++++++++++++
 6 files changed, 2309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2101.yaml
 create mode 100644 Documentation/hwmon/emc2101.rst
 create mode 100644 drivers/hwmon/emc2101.c

-- 
2.39.5


