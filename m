Return-Path: <linux-kernel+bounces-732196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07BB0634D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E3F3B3099
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8982223A9A5;
	Tue, 15 Jul 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ktMHxG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D823D2AC;
	Tue, 15 Jul 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594169; cv=none; b=GufgwztjWnRjFxcXEyJO5byRii4t6oZJUX2Kwk2yJzicWRzHgSMDB9erBlinxY/cVLVDHEQ+tc9vOiRwwWrzeRb8HR43cmhVrHKU9GqFVW+ycnG2EN6P2O/Wbr5Q2EhGkzVJiV47BnKfNqYxGpStuDpNQVjM4XNisWn11shXRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594169; c=relaxed/simple;
	bh=8o3WPYKLGRMofzBv9SknGozYOkgo8KRrHrvrsAuFKK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxRGYEfdH2k8t45Y985rT+LdV8Jks+TPoNO/k1lmEeDuNoWiYo7Ppevpx2jkINcW9A4VcXi/MAg2xW3q6jsMcKZY2r5aOYC1CCkdTxFq1I81rNMh18sAV8hMeXDQIUy3YgSr5vKEQFjcEqc9p28khyoTxrQ2PljPwg7gB2sFuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5ktMHxG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4555f89b236so41299095e9.1;
        Tue, 15 Jul 2025 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752594165; x=1753198965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08CkNm8+NW5r4ePpah12rsPBQosIDVXWebXIBzZjZuI=;
        b=H5ktMHxGOQjShKc5vd+ljrZYwkA8vht40R+ssv/Qvf52rodqjheKnefn3Ieaq/8HOa
         TPUmWTGXov396PINJXZQnsIoAarfPmmh8CLlMtuzVOyN5pNptIKX54xqb9hSLSk0eazp
         1ZcKRI3/Z+L2kC8aD86f1D2I6w8X+Hy61OhKqm0d460YQIUgczIfzGfhwjkjvUDACYYt
         CxtzXxn55hWNUP9seMG3fXtGyVTfihDhEPB4cn2kdwUxkMsgTLHfaJkMfu7RkQ18fLAi
         bbkdGb2wabUrrRmgiTdMNT61MEmsjIPYazq6jZUV2Pei+GHtU0fP/tNmkr5PZmhKAmec
         oy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594165; x=1753198965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08CkNm8+NW5r4ePpah12rsPBQosIDVXWebXIBzZjZuI=;
        b=pGGhNhjOdrZSQXi6jOqf9SGGdkOHWgFj1c2NjEJGY6xydjLwnqH5usNKcnASRIwsBw
         gUAIRvq/poI854e8x44AwVkZLFq3oYULzcFA0qyDAPhnYCKHejj/8BOBwPd+gjMNgT6M
         ZpvMgpJusGdc/SenIn1Z13gS69tuyXc2XpK9QjSHeh8X0mPwPTQzTqvnON2LGdJMKOjM
         uhW2z2rgYhV0Mol0/8T0eE5EAzTbubhMWJ2CLQi6fxhPvpajarNrP9axOQva/CIi/iwC
         tYxZQnZyq+2lLnnr6592sDEzIYBJg0jEPFf+xg5Fz4dmj8n1oKwOK45HiHw/sISzVW4p
         t+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT9hAiXZgiCw4LUh/wEQ49rK+WSF09QlSBP6p8+yCPfrDKIfL2ed9x5Y6UD0Y3bY6D6W4ewpGR6NA5@vger.kernel.org, AJvYcCUdSY0lyJVN2fiF+T7ge8yFjnAsqv1QP0mwAwUXhj2QwMiGOpfrtaw3FBpcBJYCHp7SNSFJ9aamazdv4vJQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzAslll2gWI07SPM/LxUt3IFfUqNkbsqqLti1JPB4zPg6H1Bk
	6vhS0Utbca5rC4/p38VGTauuA7z/vNwoWsMEd0azbqkGe67MCBn1lyAb
X-Gm-Gg: ASbGnctJvWu9HPZ4KLcUNTbwWn865A8DN/6OqszDGbTSH5KyEQGSg578HqBpKQdQZET
	HRxThKj/aIDM+NWJVRTF4iyV/CDJQ3Xf1f9pM+baizPZvBqkpMvzbLkFOUUhGy90EdYweqBJlmY
	RzVYDQan0JlMq8ZlDKlyQTO5a3B9tXRsSUcr3MOjVYxGfl9wuxy5Pw+uJqLlhQJ8QM9UtInJxE0
	u4OLEWh21poEaYwnkOzLrGnQTduGCOjeRRteisG40TVIrjYWB8vUGdHZJVE+SthiGX9fhODyytG
	CnoyThK3Wu/nvF9NsaYGdHTzPeaB7LS+eAaldYnf7gyYsxfMThwmqH7XaJtAu8nD2tT71vMwfQC
	RUmhdv2i2HwXxGsEJ6KR5
X-Google-Smtp-Source: AGHT+IFAZ66LZcp0qhAxpAC5M7UsPjI7txHAUiPPnPd2t9T6LDEIrhfshzo5IMZ/oZ3DBhYPFA6JRA==
X-Received: by 2002:a05:600c:6304:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-454ec2639bdmr172155165e9.15.1752594164736;
        Tue, 15 Jul 2025 08:42:44 -0700 (PDT)
Received: from masalkhi.. ([61.8.131.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45614aeba29sm79619745e9.11.2025.07.15.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:42:44 -0700 (PDT)
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
Subject: Re: [PATCH v6 3/3] ABI: sysfs: add documentation for ST M24LR EEPROM and control interface
Date: Tue, 15 Jul 2025 15:42:42 +0000
Message-ID: <20250715154242.1171-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250706105311.395162-4-abd.masalkhi@gmail.com>
References: <20250706105311.395162-4-abd.masalkhi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Gentle ping.

Best regards,
Abd-Alrhman Masalkhi

On Sun, 6 Jul 2025 10:53:11 +0000, Abd-Alrhman Masalkhi wrote:
> Add sysfs ABI documentation for the STMicroelectronics M24LR device,
> covering both the control interface (e.g., unlock, password update, UID,
> total sectors, and SSS entries) and EEPROM access via the nvmem subsystem.
> 
> Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> ---
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
> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr > b/Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
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

