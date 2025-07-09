Return-Path: <linux-kernel+bounces-724139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DABA1AFEF25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA6B1882EC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0F224898;
	Wed,  9 Jul 2025 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNm8gdbL"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E16221FDE;
	Wed,  9 Jul 2025 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079719; cv=none; b=ED/hXz2kUeCJJT+0ElzUl06YVqGputsH4jPvJvMb/nCd9N5icGqO2eh01NQ8yvA/8l8flnQvA8cNwey/vFdVt/5TREQIGqAGyTDOscxEia5w02ARW9rAYzfGBaV1LzzQK2DmwbpiUMUcxEAkmucDbYTjtOcDk9pYiKuCJfqmQ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079719; c=relaxed/simple;
	bh=4B3ke6gHsIh+dcBfkcHV8Tx4Nx1vxSrvf5z8cq2y0Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ns4HX5GJqkfWJV/+GpWbxt33b1acM5RjMcp4mxGTCAJJ8G5O3w0l6auzcRQGsz07nip1YXT5fnbzaZvkHusQxW5FuqVWPhslhbU0JnFDnd68prvdLs3feC+X8xHuanLEGPPOrep21lFSq9UNmQiQ0lUayIr7F07KD3omLJ6O2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNm8gdbL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so603855e9.3;
        Wed, 09 Jul 2025 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752079716; x=1752684516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM1sQgyzQVuS7DSOaoE99H993YRDLfxU8AAzZJx9mZI=;
        b=VNm8gdbL3bNCG6UpcaCqA2MZJReZMVU6MTg6LM3xGoFVoYeToIT5JMhTa9KR/V1AjV
         qIiLgToiq+rZTdeNDs4JnbrEmgEP63av+o3OQChs64pXpXRyvPZi9KykqltbNkfleVgV
         dbQsd0ZYMypxjkOosBDTJDX3ru5xzPqEa55zayBMkqMHq7RVwDWISOx4VU4Qc0b7tyXc
         i1rz2Beq1XWlTF348CyogLon2Tm6QvxofkIIeT15pT+M//rgtnKiR/FsSeYO4Vzb3XLN
         zmb/x+0uXlI7Glk50RSVF3WwXZ8pvH/RiM0+0VQeiT6VK1Y8QD7T3sUxkHmULRUkQCbq
         fS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752079716; x=1752684516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM1sQgyzQVuS7DSOaoE99H993YRDLfxU8AAzZJx9mZI=;
        b=CSXIOiJaHO+2t9fl6xJ/IFDo6q8pKpvH836NIbgUfKv8IYISbeXkEk/mCILX3yYJnW
         c/sT1YhaUPQxsiJLz/EM5mtnjZlgU719wAa0RhkcioZoDHpTVgj0EdE+/KyiGfgfUTrx
         5ffGxDhw710NxpRmas6pyUkvF7wtCN7kkBxYxVVQtg+ouOP9VV3Cn2XoYn6G8hC3McgI
         2A4Siqx/82s1VkbKMf5bS/7KWMkosA0jxyOxuG1lvoN8/8jnSKeA0GAd828wsf7lP8OV
         38GXeEQKmBvwd28Cpau7CR0CKkTreLUZ9z17yzI4/Fg8XXVUgaJmZW/6gI9L7LNyYBaD
         tYPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6HcvkaVIMh3PxHOnR0lgt0g3j9PNVYl4ywcHfDjTMwHIjn3sJpb5U12ei1jhc+VI/wKI1Jmreczgk@vger.kernel.org, AJvYcCUByUUJSbgm2+92+nOQIIb7XD2UQotOLjkucwKREoBf8a8Dirs52NjHZcx1DyQKYZP1ptQs5swZyo8f@vger.kernel.org, AJvYcCUksHXBFt/PrGFIjpErA9V+QHbY16C/MaLNbioa58uttijlgpS5GmZyRuNcX86o1+Xi14p6C2K8EXa+f0I=@vger.kernel.org, AJvYcCX9f/r0l4UFpoyz32KBAjcuYXn7z1qFVuUrtW3m3mHT1EbXMBHQkf61VlLXZX3jILfo24Ul9BTVeqdeWvSt@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHt5q3HLFPR9NtNbGZBJyEgrXwnDEDtfipfc3DBebkN51e76e
	5K6MWJGS3/R2JD2ksDdkmeunqe+S/tbyB6gH/670J5RYzJvo7Kk/fTZE
X-Gm-Gg: ASbGncvWWSqZjvP1SZhZ4ZtQElTDfYA/T+zA4q/AdEHA00fTTM5k5uDIECu+vmyCjvP
	OTgTvuFEeWXzsJqCGoVlQQzbQfGC9SoUJDC3vsT3DVqQYoQN+SCd//IL7SAd+r8cAHiskCdNTqE
	yto85yc5qUmrsS0SNAU95FfHzJHPeZPTSviva+4PzDfg/xXw5huk/byuvJDzeWa++ysO7eMC9XF
	08A8PFG9OVOiCtcvvPDbVZr8Hx503EOPlk590J0G3WeEF4srfPwf1Ur+EF+j1+5m0WBMx3DKpS1
	tyZqjlIywAqedt5Kdk4qCzvCprU7vx5YXlxZN1g45HkIwfvzdlYg8M22Kis9L+ijkqPrj7shy0D
	3kJAntTAtHlWU0fI8CWTJAiAkLbytXQATO9Q0U1l7eyT3cuRVpXaR+YdwCLUY7JI=
X-Google-Smtp-Source: AGHT+IEu+HMu6WZv/81rFvILzebsCFW6MqzVp/YWaGe5xSfgMvDm9s0bhVMfD4+35uTgph3vOVk62Q==
X-Received: by 2002:a05:600c:1e0d:b0:453:483b:626c with SMTP id 5b1f17b1804b1-454d53bda78mr28493545e9.23.1752079715939;
        Wed, 09 Jul 2025 09:48:35 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2e00-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2e00::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50df125sm30634915e9.19.2025.07.09.09.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:48:34 -0700 (PDT)
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
Subject: [PATCH v3 1/3] docs: hwmon: add emc2101.rst to docs
Date: Wed,  9 Jul 2025 18:48:27 +0200
Message-Id: <20250709164829.3072944-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709164829.3072944-1-noltari@gmail.com>
References: <20250709164829.3072944-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description of emc2101 driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 Documentation/hwmon/emc2101.rst | 61 +++++++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst   |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/hwmon/emc2101.rst

 v3: drop emc2101-r (same chip, loads config from EEPROM).

 v2: add emc2101 to index.rst

diff --git a/Documentation/hwmon/emc2101.rst b/Documentation/hwmon/emc2101.rst
new file mode 100644
index 000000000000..3a8d61fc9de3
--- /dev/null
+++ b/Documentation/hwmon/emc2101.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver emc2101
+=====================
+
+Supported chips:
+   Microchip EMC2101
+
+   Addresses scanned: I2C 0x4c
+
+   Prefix: 'emc2101'
+
+   Datasheet: Publicly available at the Microchip website :
+      https://www.microchip.com/en-us/product/EMC2101
+
+Description:
+------------
+This driver implements support for Microchip EMC2101 RPM-based PWM Fan Controller.
+The EMC2101 Fan Controller supports up to 1 controlled PWM fan based on an
+external temperature diode.
+Fan rotation speed is reported in RPM.
+The driver supports the eight entries temperature look up table to automatically
+adjust the fan speed.
+
+The driver provides the following sysfs interfaces in hwmon subsystem:
+
+========================= == ===================================================
+fan1_div                  RW file for fan target duty cycle divider (0..255)
+fan1_input                RO file for TACH1 input (in RPM)
+fan1_min                  RW file for TACH1 min RPM
+fan1_min_alarm            RO file for TACH1 min RPM alarm indication
+fan1_spin_up_abort        RW file for fan spin up abort on low RPM
+fan1_spin_up_power        RW file for fan spin up power (in percentage)
+fan1_spin_up_time         RW file for fan spin up time (in ms)
+fan1_standby              RW file for fan standby mode
+pwm1                      RW file for fan target duty cycle (0..63)
+pwm1_auto_channels_temp   RW file for fan temperature sensor (external, force)
+pwm1_auto_point[1-8]_pwm  RW files for look up table fan speed
+pwm1_auto_point[1-8]_temp RW files for look up table temperature
+pwm1_auto_point_temp_hyst RW file for look up table temperature hysteresis
+pwm1_enable               RW file for fan config (manual, look up table)
+pwm1_freq                 RW file for fan target frequency
+pwm1_mode                 RW file for pwm mode (DAC, PWM)
+pwm1_polarity_invert      RW file for fan polarity inversion
+temp[1-3]_label           RO files for temperature labels
+temp1_input               RO file for internal temperature
+temp1_max                 RW file for max internal temperature
+temp1_max_alarm           RO file for max internal temperature alarm indication
+temp2_crit                RW file for crit external temperature
+temp2_crit_alarm          RO file for crit external temperature alarm indication
+temp2_crit_hyst           RW file for crit external temperature hysteresis
+temp2_fault               RO file for external temperature failure indication
+temp2_input               RO file for external temperature
+temp2_max                 RW file for max external temperature
+temp2_max_alarm           RO file for max external temperature alarm indication
+temp2_min                 RW file for min external temperature
+temp2_min_alarm           RO file for min external temperature alarm indication
+temp2_type                RW file for external temperature type (CPU, 2N3904)
+temp3                     RW file for forced temperature
+update_interval           RW file for temperature sensor update interval
+========================= == ===================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index b45bfb4ebf30..c068462764d0 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -69,6 +69,7 @@ Hardware Monitoring Kernel Drivers
    ds1621
    ds620
    emc1403
+   emc2101
    emc2103
    emc2305
    emc6w201
-- 
2.39.5


