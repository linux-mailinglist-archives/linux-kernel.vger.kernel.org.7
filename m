Return-Path: <linux-kernel+bounces-734717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C04B08530
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56427582B03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C4021B199;
	Thu, 17 Jul 2025 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIdxpIGb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8221ADA3;
	Thu, 17 Jul 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734421; cv=none; b=YQAZdHQz6veVMiaDTA5dhCSRrP9J4OjEyzc63EU044oZoL09nS77BijQnkmHRAIAycKSGfdh/THy/Ayw9rFHG4Etk1lpZfuxfPZD0Nl6awpQ2U0lE8T48re0rliEh4qy+SxkA4ZV+gcJVpQcXoWxr7w/D4dA3+6FQKP9mD6DVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734421; c=relaxed/simple;
	bh=pYrbxrLqmoUrHduPsSanPer8fFDOTDbOp3egOIFMJsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omWOa+zpjXCUbue+S2BGtFcm6D6++npVSLktQfDoSEP/A9nFJY6/LzuiuiL1hGiIarh9s1f1LO8C2IF6id4kw08PoNgHuUcGW908tdHcaBLgBt6fnSgL5/c4YTsx90hGwcq6Rx2JxfRgrV55CHcqxbYG48tU+4l3WsL2bDBaXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIdxpIGb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-454ac069223so11714275e9.1;
        Wed, 16 Jul 2025 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752734415; x=1753339215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go8yLTcsDmTII8LthCvCpUJJtbyrgxm7vT0+k9RIkZ0=;
        b=IIdxpIGbN0qkiWQKMlYqLb5Z8uHD9ke6WcdkoBOB58mr0JtA9zPZalmyGqOgS7PbSn
         lGGhfUfb69iXVAnJveqoCbpnQ6QjFBhROJWHJEuKvvlZ38EIGrCcb2AcsXl4yTa9xDZR
         jwz7Nh8EnFbrifKf8uKisH0LjAG62Jh5Z+w0NYgV9QToumryOQ6Xk3YF0ZanZQCO/owO
         gTQ5aRlyyviy+Us6Ayr9twzRafc4wkLI+qXyyfaOc1ZGfoqc0YBLe4R745dUineqY3ff
         Nh7q/5GXUTFSitnbafjdGoiNf0kZG0sMuJrdd/g8T0Zlyi05wOxceM79/kKO9A+3KzBx
         Vztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752734415; x=1753339215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go8yLTcsDmTII8LthCvCpUJJtbyrgxm7vT0+k9RIkZ0=;
        b=xVLyZ2gGINCMZfp42tQB6vBlpfRRtwLqo5TRytOSWfBLcOm9LMVc+AkYMcWoa0XglU
         Y2gdpTUuVbhNh/MylBYiaUZFGEQdg5KDvZlMXJ+6RIVj23QqYJ05kQyKAlYe/xjBjQgJ
         mNvVmWsaFpcxiNk+D3CbEV4ItK+tuz6MHFaPiU9/MvdrAQD2bxyoQMf3NXorre8TmVB+
         830Q9WVjS9lmISUqrcv0OUxejGGg3DGvLuOd7ztVi21YWs4Rmj7ojoUy5fB0OrjvIDLo
         Lqd0Kg+LTu46wbIvqCgl1d2QNGVjZGjVMw0PRC1S7RGPz2bIRKdhw/tjOq5N8deb0yrw
         HAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCViDaK5uRJMPMCCnHtuViYyBaet9q+3QhsOWWaCNQUTS5Mq4EbXgfIRLpslkEk6we/Jwra08IQHhB7F@vger.kernel.org, AJvYcCX2inD7jnvwqJvvlCpoMN1UNyaobTkR7XmQZSmSFNxVN41nwCg2/OqEVwCIpOPmz9ySoVU4QJ4qhbWPTY8J@vger.kernel.org
X-Gm-Message-State: AOJu0YyIzFUt6A+tcsyJqG3+Q3fSxhOU1KSRUL2g6Gn/FUVjJVRkpQZQ
	wvLxxD6zUzSapQ4TLGZOMVGXyuGFaiZIiojh1uLxgbZKqdcBlNTPPaEBn8mZwQ==
X-Gm-Gg: ASbGncvEGy3flEbaquAsXlzRRxoe0cJwgfFjwiSQMYPIoIrbkDYJ3LEfEsCn6WNKOsx
	Uu7iDT3sgK31i9vgiD/Pv/D3yXdQxhev77sDcVfwfsGTXaix6lG2cAL4N140SFejN9PTUBbrjlW
	214xVQ2voguBcTXNKsuc28BZ5mCClcntEE/4h7biuKSKSdYxvVlV1mLRxMYmPRI7FfmwM8gSKv5
	JMrmzw3MdOjEdqh1ynZdFMCZrztD7UwoHAXCBg9a9Uadm28D2KqMMPOEVbKa8mWfeyNUiFcUcnC
	siDfdUGWe8B2+bkjpHMw6L5Bz6DcQil8tpNbYtuq7oAeuMwuykByb5zjJrGB+oEsoxY/EVpEXbb
	+kWItYoFs5sRW/yreqJ4B
X-Google-Smtp-Source: AGHT+IG4nI6HXz7bhIE+dI5lv+NPhFBQFa/i/ICLIEM8yv5RpkJebZpRWfZ4FHOTecBXBDfy9uAqGA==
X-Received: by 2002:a05:6000:438a:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3b613ad5ec1mr1491008f8f.24.1752734414917;
        Wed, 16 Jul 2025 23:40:14 -0700 (PDT)
Received: from masalkhi.. ([61.8.129.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e135sm20039788f8f.72.2025.07.16.23.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:40:13 -0700 (PDT)
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
Subject: [PATCH v7 3/3] ABI: sysfs: add documentation for ST M24LR EEPROM and control interface
Date: Thu, 17 Jul 2025 06:39:34 +0000
Message-ID: <20250717063934.5083-4-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717063934.5083-1-abd.masalkhi@gmail.com>
References: <20250717063934.5083-1-abd.masalkhi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs ABI documentation for the STMicroelectronics M24LR device,
covering both the control interface (e.g., unlock, password update, UID,
total sectors, and SSS entries) and EEPROM access via the nvmem subsystem.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
Changes in v7:
 - No changes
 - Link to v6: https://lore.kernel.org/all/20250706105311.395162-4-abd.masalkhi@gmail.com/

Changes in v6:
 - No changes
 - Link to v5: https://lore.kernel.org/all/20250704123914.11216-4-abd.masalkhi@gmail.com/

Changes in v5:
 - Fix dates and update targeted kernel version.
 - Link to v4: https://lore.kernel.org/lkml/20250608182714.3359441-4-abd.masalkhi@gmail.com/

Changes in v4:
 - Replaced 'sss<N>' entries with a single binary 'sss' attribute
 - Added 'total_sectors' attribute to report the number of valid SSS bytes
 - removed 'mem_size' attribute
 - Fix dates and update targeted kernel version.
 - Link to v3: https://lore.kernel.org/lkml/20250606120631.3140054-4-abd.masalkhi@gmail.com/

Changes in v3:
 - Updated sysfs entry paths to use <busnum>-<primary-addr> to reflect the
   control address.
 - Link to v2: https://lore.kernel.org/lkml/20250601153022.2027919-4-abd.masalkhi@gmail.com/

Changes in v2:
 - Added initial sysfs ABI documentation.
---
 .../ABI/testing/sysfs-bus-i2c-devices-m24lr   | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr b/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
new file mode 100644
index 000000000000..7c51ce8d38ba
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
@@ -0,0 +1,100 @@
+What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/unlock
+Date:           2025-07-04
+KernelVersion:  6.17
+Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
+Description:
+                Write-only attribute used to present a password and unlock
+                access to protected areas of the M24LR chip, including
+                configuration registers such as the Sector Security Status
+                (SSS) bytes. A valid password must be written to enable write
+                access to these regions via the I2C interface.
+
+                Format:
+                  - Hexadecimal string representing a 32-bit (4-byte) password
+                  - Accepts 1 to 8 hex digits (e.g., "c", "1F", "a1b2c3d4")
+                  - No "0x" prefix, whitespace, or trailing newline
+                  - Case-insensitive
+
+                Behavior:
+                  - If the password matches the internal stored value,
+                    access to protected memory/configuration is granted
+                  - If the password does not match the internally stored value,
+                    it will fail silently
+
+What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/new_pass
+Date:           2025-07-04
+KernelVersion:  6.17
+Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
+Description:
+                Write-only attribute used to update the password required to
+                unlock the M24LR chip.
+
+                Format:
+                  - Hexadecimal string representing a new 32-bit password
+                  - Accepts 1 to 8 hex digits (e.g., "1A", "ffff", "c0ffee00")
+                  - No "0x" prefix, whitespace, or trailing newline
+                  - Case-insensitive
+
+                Behavior:
+                  - Overwrites the current password stored in the I2C password
+                    register
+                  - Requires the device to be unlocked before changing the
+                    password
+                  - If the device is locked, the write silently fails
+
+What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/uid
+Date:           2025-07-04
+KernelVersion:  6.17
+Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
+Description:
+                Read-only attribute that exposes the 8-byte unique identifier
+                programmed into the M24LR chip at the factory.
+
+                Format:
+                  - Lowercase hexadecimal string representing a 64-bit value
+                  - 1 to 16 hex digits (e.g., "e00204f12345678")
+                  - No "0x" prefix
+                  - Includes a trailing newline
+
+What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/total_sectors
+Date:           2025-07-04
+KernelVersion:  6.17
+Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
+Description:
+                Read-only attribute that exposes the total number of EEPROM
+                sectors available in the M24LR chip.
+
+                Format:
+                  - 1 to 2 hex digits (e.g. "F")
+                  - No "0x" prefix
+                  - Includes a trailing newline
+
+                Notes:
+                  - Value is encoded by the chip and corresponds to the EEPROM
+                    size (e.g., 3 = 4 kbit for M24LR04E-R)
+
+What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/sss
+Date:           2025-07-04
+KernelVersion:  6.17
+Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
+Description:
+                Read/write binary attribute representing the Sector Security
+                Status (SSS) bytes for all EEPROM sectors in STMicroelectronics
+                M24LR chips.
+
+                Each EEPROM sector has one SSS byte, which controls I2C and
+                RF access through protection bits and optional password
+                authentication.
+
+                Format:
+                  - The file contains one byte per EEPROM sector
+                  - Byte at offset N corresponds to sector N
+                  - Binary access only; use tools like dd, Python, or C that
+                    support byte-level I/O and offset control.
+
+                Notes:
+                  - The number of valid bytes in this file is equal to the
+                    value exposed by 'total_sectors' file
+                  - Write access requires prior password authentication in
+                    I2C mode
+                  - Refer to the M24LR datasheet for full SSS bit layout
-- 
2.43.0


