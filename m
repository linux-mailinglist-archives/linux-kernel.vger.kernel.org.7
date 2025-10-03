Return-Path: <linux-kernel+bounces-840931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A18BB5C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1B8B4E76D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92800281530;
	Fri,  3 Oct 2025 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXwuQV4C"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062127B336
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455659; cv=none; b=T0jUo8aElhI7s8jD9UvEYgwf9iTqVxojQeC9gGghUeIJB13o5L+AyuFl8sIvxsWMyXzITZOgyGh6uRlxc+aoMD9vADekjR0p/uGo73HJ9J1b5A03Gtxu+Dwk8qAVA43Dy/e2JPT3rTzCFbvNIHzQCx7eVAUwyWZ5vDoa98xW6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455659; c=relaxed/simple;
	bh=xUaGR4WoabITYgK3+xJFRn+e0Uq1vlAyOWZJhB35IMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mW8fnYI5yzxJgMfDNuVvXuOVq7RGCaeCdh9a0xGRbda9g3gMKtjz/i51t9dU1elDPrA6c+D84pPL1mbSCqIU+Lo3Zmox8G80xeHW1IEVUXdssxuqEjniIQucqj12iu4xe1NJYAYsVaNUJxvekS049R1kgDzHb0Vbp1tXJwk8J9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXwuQV4C; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so1109488f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759455652; x=1760060452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWoIa0y9v6+gweKWrBOLXJwKYjleY3G/Bq8+yOF4xdI=;
        b=jXwuQV4CL1Urar4uRKNYG1mJ1rv2LTtpcS9LhSOYVGy5CPfclH83MYVkvCDoBnomej
         i5m9T6LBUyDlQWbtvuCAOH+o99qXJN3yRijGm6YrGHqiXy8Pw9/a6ZB6SlBZ2RD72vZa
         y9fno7b9/JkFL9F2km9BxI+F6YlIwGy7y4/TeuLG+yG/DYZh3XAAeI9Prl43f1n6BZEm
         30g2aQOhT4J4QJFEMsXf0sGx0ysdJGJYPvgzUdUO9g+c/yVaPfZ50eo2/IaEywhHdMxh
         dE5MxErC8boUAGk6Qdi04WH9BzSXrWz7XDQzEu2H/yE8aJKjlNr1FhiFng2GhZll3bTW
         dCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759455652; x=1760060452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWoIa0y9v6+gweKWrBOLXJwKYjleY3G/Bq8+yOF4xdI=;
        b=ZW/Gep5MZUUvy4ZUVyR89+viosvYLsUBiXXo+VpHHcebEbuF2NHuIxbBfq4yBE2967
         Pw8ntgb4Q0XZvP5aLNCZ0eL7Wl+bdEeRBVKwCy3XM8eQTdoooF0TWPfC9ME/LgIBHEb2
         p+dhRu9scrcbEiw7wYf89In68DMVqd/9TSOZUH3ABTROYLrOH75EDqdD1ery7+y/1GhX
         tMghdEeTcIuBsOeJWRD8fEd6cr7sPYZVrGtulbWZfKeXYmeBsgkidKEVLZDw1ZeFcoIp
         iYKNwK29uW2NG6/FKZu+7GMqcmt7LV13n7n9cQb03qHQb/UKA7RPEVTfnIu5euBaccn9
         znxA==
X-Forwarded-Encrypted: i=1; AJvYcCV7MKHGRF4GzVO4eeszmCiT6AVEqhGKx2azZPo9DtYolhwiOVbZuzrUpwMEifFixlaQKCE8/SGfUqNwABY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMnqbT2zGnz1rsIrWpeSFlA7nGYd91u6WMmLgbWYOuJs3mPrz9
	9LlrdyW8ylGxUlrcha/l6ek2CzCyjYTw+L43e5p8amDWreTxgPQ9eYIv
X-Gm-Gg: ASbGnct/dSerZ3vLlytVIxg/uw8vl8Oo+BwEUIA4/fay891YCMdSS6M1hydqA3r8lyN
	MIkIPn+noIzf4Zl19pm/4NbI5IRPY0AdNdDQkufp7GL/LDzc/suQjM0Z/Xow/kc/2ZLUfyHRzcE
	WVAsL1DqGLwJm+muE/wcGlwA3SBW1MJJ8ntFn99ZEiumN3PHYFh4aM3PXTX68RnvZ7qgBIRMhbR
	XjPlopB8/10s1iCglyovZsVtRHDbTSEy9U7kd7FCrVDlpzC5vAdtB/idDW9JrsxPdtAo9Y9HqbJ
	ZwjfJNLDj0dVqhMsvsuFBVJf/ZzLciEfmHSpoksJgAx3btWTV92d+v5GsQIgdL19vKFLLDuZAQb
	w9F1fLEyCZgMBBqmDoZMZp9lRAYoAecDG2W4gq+teXQ==
X-Google-Smtp-Source: AGHT+IH5P4hHd3rDkULQwta1dCV/KcbG1IBpN7aEKqZ8F0Lkd/eZ3lu+K7BMNcGxH958CEVhBsYo1A==
X-Received: by 2002:a05:6000:288d:b0:3e5:190b:b04e with SMTP id ffacd0b85a97d-425671763d6mr545186f8f.37.1759455651622;
        Thu, 02 Oct 2025 18:40:51 -0700 (PDT)
Received: from desktop ([2a01:e0a:3fd:be60:6c8e:6cca:78e:dc8e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0392sm5814715f8f.42.2025.10.02.18.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:40:51 -0700 (PDT)
From: lespink <lespinks9@gmail.com>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lespink <lespinks9@gmail.com>
Subject: [PATCH] Signed-off-by: lespink <lespinks9@gmail.com> Bluetooth: btusb: Add support for Mercusys MA530 (2c4e:0115)
Date: Fri,  3 Oct 2025 03:40:49 +0200
Message-ID: <20251003014049.3055848-1-lespinks9@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Realtek-based Mercusys MA530 Bluetooth 5.3 USB dongle
which was previously unrecognized by the kernel and thus non-functional.

The device is identified as USB ID 2c4e:0115 and shows up with no
manufacturer string and product "Mercusys MA530 Adapter".

The following is the relevant output from /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=05 Dev#= 10 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c4e ProdID=0115 Rev= 2.00
S:  Manufacturer=
S:  Product=Mercusys MA530 Adapter
S:  SerialNumber=30169DA2555D
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
...

The kernel dmesg log shows the firmware loading sequence works fine:

[  +0.002087] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b
[  +0.001000] Bluetooth: hci0: RTL: rom_version status=0 version=1
[  +0.000009] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[  +0.002938] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
[  +0.000242] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
[  +0.148802] Bluetooth: hci0: RTL: fw version 0xdfc6d922

Signed-off-by: lespink <lespinks9@gmail.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..2c6dace7f0b1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -605,6 +605,10 @@ static const struct usb_device_id quirks_table[] = {
 	  .driver_info = BTUSB_MEDIATEK |
 			 BTUSB_WIDEBAND_SPEECH },
 
+    /* Mercusys MA530 Adapter */
+    { USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+                             BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional MediaTek MT7615E Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
 
-- 
2.51.0


