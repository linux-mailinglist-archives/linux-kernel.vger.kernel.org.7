Return-Path: <linux-kernel+bounces-759712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB97B1E190
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DA23A8CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7D1DED42;
	Fri,  8 Aug 2025 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKZgA/z6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DF2E36E2;
	Fri,  8 Aug 2025 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754629782; cv=none; b=kJja4kzoiwWe8Sl2CCkguuHUxA7fHOi7XMrL4V+GImRUh+ZEl6VfA19z39qJYPcBpvMYZBzlrNr0WH0yN/DGfCztN1PITo4hG6duwPRMLoU7O6fOmlC8kIgYC1USQ3xP2/sgFTy655c6Aw58PNYvZBWCihutL6C7brung8aCJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754629782; c=relaxed/simple;
	bh=a2y6oq32RCdK2rJQj7kda/c55NYWJH3sUNJiUAyzCXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehNAF/h2gOiILDw8IhZP5v75Z+eKlc737qSbzCXnwdlRSXZZl0E9uGEgk0HNCoONXPw9RFFkx0MwNPt+aWiAZPaqDeS8XlVYKgjJ0e+s9fz1d34xATTPV9d5xdajpL5ysfUy1AD0km877OOoZxWmrJT7n8Oi7Hez2b4y97mkP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKZgA/z6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7910123a0so1490058f8f.1;
        Thu, 07 Aug 2025 22:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754629779; x=1755234579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJeRKC2Sbj8HVwSNuMEkUt6TOmddOusn/wpP7GmPtQg=;
        b=XKZgA/z65vZIMyUV0qrjN7ZtWIsYAVCDbVKiUeyG5nA+Vv01ob3K3FY6BzlT1QXErN
         NCIrnchtleBNZhzoQ/Cj6RgA2dMr4sHGDDycMbovgiR9fV+wNYbujllkKjE0JMzFweiI
         4s7PHZrUJ13QjYjNuuxLepxYyY2hDGxh829VnHZdJ7y5qkpitLrNApZHtQUG0p91bW5R
         mIsc7u6C0fnjfLzAkZva2tV4IQ+oZNXhrSkERjwrwMpT+BN/eLdK9yU13Nt2vR+ge/gX
         aXfKVH7NnAb0KbBSgukBX74KbOUmjyUk/FU66nhgDO2e5eyP8ABVKXpm6AFd88h+grV/
         5lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754629779; x=1755234579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJeRKC2Sbj8HVwSNuMEkUt6TOmddOusn/wpP7GmPtQg=;
        b=jJmwbj5XtwLogV1GEHlZcatH6fpGxz3aIdabYsxWvMpemE5ey/CvouFkaWVR76ls2n
         ucWFB/omVifW+5V3xiFPbXVgr1evSDHvyjBwvpcBcBIj+adPYeWsPpbOx9KEodXPb9BH
         qsGMogFIiNyLlfSo13lnaaUBZkqaagFCOAbJGFitMimqSsUe2dTk37z7lNtW7qjmqAP8
         0LpilPrgRY3o97dMWUtmllbk7pagdGzqJwoSSuRElISVMQmHa7DS0YcN5E6DU/t7bidm
         OyZ7y+/PftgjOfgARUgZxeK9f11j6NdImB/RpX/CbUixKy9YmKuv996ML26WZ8tIgidH
         OX+g==
X-Forwarded-Encrypted: i=1; AJvYcCUGDhZrwH/KuZkDidQNUte/5NR5GGQz5t++U9x5rAoJlwU3keSkLf68kQqiXniXer/KLuQnHh8aM8mN@vger.kernel.org, AJvYcCX8qGWgMKxw8Cw1RbuiilCHyCMLTB1wTARct0yGWbcmLRkMSyxAxgaqNV6Wiw5LPOISaIm9gEvWkgrTrpJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrxia6ll3EMg7tkBgVpRcnOKjV4y8fszKaYaikiNGhkrer1ue
	Rgx+ora+d93BQDBCkUE+9nLN5mpP3bYP4DNLlIKfeZLPKGCi08kkHjFq
X-Gm-Gg: ASbGncueP/MRe8Ys1fK7R1xExD8b99XywY36rrheK1xm7MCgbm1SFiR8xDPsKShLy7M
	dDm+ySrAm4pM2i4yYDjpEvw1h9lqhSn4IXXbxLDqRgDSyLu/Wi8EwlOH4VAxnd9z00Q3ijb5Pf1
	H8jJTn6FTpMM91Q/prNeXZ1xqz2iesOMw+Wgt93g7xGfj6JxCY2t1jq9GP1z3xDlSgNIsTLytc8
	5MIBwswlTjzDt+leluU/yD5YW31KvWBfxdEx/NOChPk8bovEJ3XvM22SFgeCx5T0DTtIMhCqLVg
	bygTlOEKTTPlFaZANG2g/nsxw4b6hM/9m5yMyK3SBlUDik+LtQNzgp+H0/z/pugRvqGKkh2R0F7
	CulOFCFt/uwIUrE2Bii9AzQ==
X-Google-Smtp-Source: AGHT+IGwelafdCRl6SiKeVuK/HuvzHQhpk9K8nX49sic8+ZNkOUUXoXMzaot61MhFyk5x8qVia2ILg==
X-Received: by 2002:a05:6000:4029:b0:3b7:7d96:e24a with SMTP id ffacd0b85a97d-3b900b7b057mr1168474f8f.35.1754629778868;
        Thu, 07 Aug 2025 22:09:38 -0700 (PDT)
Received: from masalkhi.. ([61.8.128.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0683045sm19686172f8f.41.2025.08.07.22.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 22:09:38 -0700 (PDT)
From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To: abd.masalkhi@gmail.com
Cc: arnd@arndb.de,
	christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	robh@kernel.org
Subject: Re: [PATCH v7 3/3] ABI: sysfs: add documentation for ST M24LR EEPROM and control interface
Date: Fri,  8 Aug 2025 05:01:59 +0000
Message-ID: <20250808050159.36405-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717063934.5083-4-abd.masalkhi@gmail.com>
References: <20250717063934.5083-4-abd.masalkhi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Gentle ping.

On Thu, Jul 17, 2025 at 06:39 +0000, Abd-Alrhman Masalkhi wrote:
> Add sysfs ABI documentation for the STMicroelectronics M24LR device,
> covering both the control interface (e.g., unlock, password update, UID,
> total sectors, and SSS entries) and EEPROM access via the nvmem subsystem.
>
> Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> ---
> Changes in v7:
>  - No changes
>  - Link to v6: https://lore.kernel.org/all/20250706105311.395162-4-abd.masalkhi@gmail.com/
>
> Changes in v6:
>  - No changes
>  - Link to v5: https://lore.kernel.org/all/20250704123914.11216-4-abd.masalkhi@gmail.com/
>
> Changes in v5:
>  - Fix dates and update targeted kernel version.
>  - Link to v4: https://lore.kernel.org/lkml/20250608182714.3359441-4-abd.masalkhi@gmail.com/
>
> Changes in v4:
>  - Replaced 'sss<N>' entries with a single binary 'sss' attribute
>  - Added 'total_sectors' attribute to report the number of valid SSS bytes
>  - removed 'mem_size' attribute
>  - Fix dates and update targeted kernel version.
>  - Link to v3: https://lore.kernel.org/lkml/20250606120631.3140054-4-abd.masalkhi@gmail.com/
>
> Changes in v3:
>  - Updated sysfs entry paths to use <busnum>-<primary-addr> to reflect the
>    control address.
>  - Link to v2: https://lore.kernel.org/lkml/20250601153022.2027919-4-abd.masalkhi@gmail.com/
>
> Changes in v2:
>  - Added initial sysfs ABI documentation.
> ---
>  .../ABI/testing/sysfs-bus-i2c-devices-m24lr   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr b/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
> new file mode 100644
> index 000000000000..7c51ce8d38ba
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
> @@ -0,0 +1,100 @@
> +What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/unlock
> +Date:           2025-07-04
> +KernelVersion:  6.17
> +Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> +Description:
> +                Write-only attribute used to present a password and unlock
> +                access to protected areas of the M24LR chip, including
> +                configuration registers such as the Sector Security Status
> +                (SSS) bytes. A valid password must be written to enable write
> +                access to these regions via the I2C interface.
> +
> +                Format:
> +                  - Hexadecimal string representing a 32-bit (4-byte) password
> +                  - Accepts 1 to 8 hex digits (e.g., "c", "1F", "a1b2c3d4")
> +                  - No "0x" prefix, whitespace, or trailing newline
> +                  - Case-insensitive
> +
> +                Behavior:
> +                  - If the password matches the internal stored value,
> +                    access to protected memory/configuration is granted
> +                  - If the password does not match the internally stored value,
> +                    it will fail silently
> +
> +What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/new_pass
> +Date:           2025-07-04
> +KernelVersion:  6.17
> +Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> +Description:
> +                Write-only attribute used to update the password required to
> +                unlock the M24LR chip.
> +
> +                Format:
> +                  - Hexadecimal string representing a new 32-bit password
> +                  - Accepts 1 to 8 hex digits (e.g., "1A", "ffff", "c0ffee00")
> +                  - No "0x" prefix, whitespace, or trailing newline
> +                  - Case-insensitive
> +
> +                Behavior:
> +                  - Overwrites the current password stored in the I2C password
> +                    register
> +                  - Requires the device to be unlocked before changing the
> +                    password
> +                  - If the device is locked, the write silently fails
> +
> +What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/uid
> +Date:           2025-07-04
> +KernelVersion:  6.17
> +Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> +Description:
> +                Read-only attribute that exposes the 8-byte unique identifier
> +                programmed into the M24LR chip at the factory.
> +
> +                Format:
> +                  - Lowercase hexadecimal string representing a 64-bit value
> +                  - 1 to 16 hex digits (e.g., "e00204f12345678")
> +                  - No "0x" prefix
> +                  - Includes a trailing newline
> +
> +What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/total_sectors
> +Date:           2025-07-04
> +KernelVersion:  6.17
> +Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> +Description:
> +                Read-only attribute that exposes the total number of EEPROM
> +                sectors available in the M24LR chip.
> +
> +                Format:
> +                  - 1 to 2 hex digits (e.g. "F")
> +                  - No "0x" prefix
> +                  - Includes a trailing newline
> +
> +                Notes:
> +                  - Value is encoded by the chip and corresponds to the EEPROM
> +                    size (e.g., 3 = 4 kbit for M24LR04E-R)
> +
> +What:           /sys/bus/i2c/devices/<busnum>-<primary-addr>/sss
> +Date:           2025-07-04
> +KernelVersion:  6.17
> +Contact:        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> +Description:
> +                Read/write binary attribute representing the Sector Security
> +                Status (SSS) bytes for all EEPROM sectors in STMicroelectronics
> +                M24LR chips.
> +
> +                Each EEPROM sector has one SSS byte, which controls I2C and
> +                RF access through protection bits and optional password
> +                authentication.
> +
> +                Format:
> +                  - The file contains one byte per EEPROM sector
> +                  - Byte at offset N corresponds to sector N
> +                  - Binary access only; use tools like dd, Python, or C that
> +                    support byte-level I/O and offset control.
> +
> +                Notes:
> +                  - The number of valid bytes in this file is equal to the
> +                    value exposed by 'total_sectors' file
> +                  - Write access requires prior password authentication in
> +                    I2C mode
> +                  - Refer to the M24LR datasheet for full SSS bit layout
> -- 
> 2.43.0
>

-- 
Best Regards,
Abd-Alrhman

