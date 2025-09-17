Return-Path: <linux-kernel+bounces-821508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D806FB816ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E272581B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2D329DB99;
	Wed, 17 Sep 2025 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="QnwPvJgQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sI+FMK6y"
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006D4A04;
	Wed, 17 Sep 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136258; cv=none; b=luQJ84HZ1m9/0S63HdfvW9QT+ZvRwuUBXk1G9rfXFRWab78JYYG8XPKFIrYV3thWZccoPyP4qUOEMnyTtwD2S76DKZ1ZQzyJsQ6A8Nc5r4TNucXl+kI328ZuxUO2SLnf3UbBly6M9ZuxjVf6qCi/QrII0TUiNOhuDOkgd5BiMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136258; c=relaxed/simple;
	bh=cvre8E18jeT6sBsn7mM9lLOpUG2V4cHMviqd0cUZ/Go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=huhuWhYirdWQdQ3xDd0UGncfJktR3HpZIEafFo007VzIvVgvPN4oJqDeIA2r58EplV5M3Mt+X2E5QpqWTm9+ck5eJmnNy6+v5t+djbzPyPiJAnptrzGqEj0c5rqa5w9aES09qBUGs8mRD88GeVdZ42CAxGt0XYheY+fLwGAx6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=QnwPvJgQ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sI+FMK6y; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758136208; bh=jUDJNUGPMmGoGJReBhLdS9j
	gZvs7HFmg75694Psa0N4=; b=QnwPvJgQgQEIjFUJ092WX+5VnetTc9mO2+VyZg01XYt/TScUWP
	21vTdQsTv5Q9rtzwXYKBf/80zpphW2EulMDX2I5E70xIfHFzmYikvzSgn2Cwilk4plokXRKV5Sa
	nL2cT9WsKXTeW0O+VPJ0wup8nPAQFP+LmH7nnI0nGbUZtKBqH0cUXkG+D3QfI0N2sPnMo6eAlP/
	YVr+73UyuHMepSNeSvppQsrmGuiwOmHDw9TXPwUhzsO9Vxli1mcWiLj7WTzV4PXpXcBnstLdOBX
	1W53fgYrdkMsVHKYyTDMWj0nK1tO6yYDNC0K2+sHKvzQQo5NfN+wWLPlK7TM59Hoh7w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758136208; bh=jUDJNUGPMmGoGJReBhLdS9j
	gZvs7HFmg75694Psa0N4=; b=sI+FMK6yfNuHDv87ZLFSarK00xCSPeOjs/99JSwJ53Q458pgXA
	XvCvnPw1of16KuDvpsg8rP6fbXCSEUU2QEDA==;
From: Nickolay Goppen <setotau@mainlining.org>
Date: Wed, 17 Sep 2025 22:10:01 +0300
Subject: [PATCH] platform/x86: dell-lis3lv02d: Add Latitude E6530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-dell-lis3lv02d-latitude-e6530-v1-1-8a6dec4e51e9@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAIgHy2gC/x3MSwqEMAwA0KtI1gZq669eRWZR2swYCCptFUG8+
 xSXb/NuSBSZEkzVDZFOTrytBU1dgV/c+iPkUAxa6U7ZZsBAIiicjJxKBxSXOR+BkPrOKBy8Ga3
 3rh2tgXLskb58vf/8eZ4/uGE/7m8AAAA=
X-Change-ID: 20250917-dell-lis3lv02d-latitude-e6530-7c389cca4893
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nickolay Goppen <setotau@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758136207; l=2859;
 i=setotau@mainlining.org; s=20250815; h=from:subject:message-id;
 bh=cvre8E18jeT6sBsn7mM9lLOpUG2V4cHMviqd0cUZ/Go=;
 b=5KwfJvyXXPUxxbHp8fEkCAufC3hdm0JeHRGtVBxrLGkx+o6ftF8JLYczSt3ibJMoSWqXAr4G7
 +dygItdCGAaAuVu8Z4sDiYpL6WZy8+odkb91rIbuP9It+xgEiGNBggw
X-Developer-Key: i=setotau@mainlining.org; a=ed25519;
 pk=Og7YO6LfW+M2QfcJfjaUaXc8oOr5zoK8+4AtX5ICr4o=

Add 0x29 as the accelerometer address for the Dell Latitude E6530 to
lis3lv02d_devices[].

The address was verified as below:

    $ cd /sys/bus/pci/drivers/i801_smbus/0000:00:1f.3
    $ ls -d i2c-*
    i2c-20
    $ sudo modprobe i2c-dev
    $ sudo i2cdetect 20
    WARNING! This program can confuse your I2C bus, cause data loss and worse!
    I will probe file /dev/i2c-20.
    I will probe address range 0x08-0x77.
    Continue? [Y/n] Y
         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
    00:                         08 -- -- -- -- -- -- --
    10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    20: -- -- -- -- -- -- -- -- -- UU -- 2b -- -- -- --
    30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
    50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
    60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
    70: -- -- -- -- -- -- -- --
    $ cat /proc/cmdline
    BOOT_IMAGE=/vmlinuz-linux-cachyos-bore root=UUID=<redacted> rw loglevel=3 quiet dell_lis3lv02d.probe_i2c_addr=1
    $ sudo dmesg
    [    0.000000] Linux version 6.16.6-2-cachyos-bore (linux-cachyos-bore@cachyos) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Thu, 11 Sep 2025 16:01:12 +0000
    […]
    [    0.000000] DMI: Dell Inc. Latitude E6530/07Y85M, BIOS A22 11/30/2018
    […]
    [    5.166442] i2c i2c-20: Probing for lis3lv02d on address 0x29
    [    5.167854] i2c i2c-20: Detected lis3lv02d on address 0x29, please report this upstream to platform-driver-x86@vger.kernel.org so that a quirk can be added

Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
---
Add 0x29 as the accelerometer address for the Dell Latitude E6530 to
lis3lv02d_devices[].
---
 drivers/platform/x86/dell/dell-lis3lv02d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-lis3lv02d.c b/drivers/platform/x86/dell/dell-lis3lv02d.c
index 732de5f556f83b4f91fbf174986331c02c2a5c79..77905a9ddde9dd5d44a3193d053fb3d4e319ceb8 100644
--- a/drivers/platform/x86/dell/dell-lis3lv02d.c
+++ b/drivers/platform/x86/dell/dell-lis3lv02d.c
@@ -48,6 +48,7 @@ static const struct dmi_system_id lis3lv02d_devices[] __initconst = {
 	DELL_LIS3LV02D_DMI_ENTRY("Latitude 5500",      0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6330",     0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6430",     0x29),
+	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6530",     0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Precision 3540",     0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Precision 3551",     0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Precision M6800",    0x29),

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250917-dell-lis3lv02d-latitude-e6530-7c389cca4893

Best regards,
-- 
Nickolay Goppen <setotau@mainlining.org>


