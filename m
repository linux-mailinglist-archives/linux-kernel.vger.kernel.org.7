Return-Path: <linux-kernel+bounces-726328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01585B00BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86093B3C20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550B2FD594;
	Thu, 10 Jul 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aiyionpri.me header.i=@aiyionpri.me header.b="CuFP+KHr";
	dkim=permerror (0-bit key) header.d=aiyionpri.me header.i=@aiyionpri.me header.b="zQ4hvJY1"
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371162FCFFC;
	Thu, 10 Jul 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174591; cv=pass; b=XOohHZ5rhGASFB5Js3jynfIQScA/ibVCm6c+cExArbLmiNVIXj1IjwfUEbw5G/pJm6Ie9gWrxMMbjSb6z7I6XgKb0YL+X6TvwVf2R1nOzMM7Z5zj7fK0DpR/P7gKchheJ0IKQigEKfNYx0UMOt8jY6ySntSTZ+FC/ujgdFcpXao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174591; c=relaxed/simple;
	bh=t+LTk94kgoTR6lJqzrcbGjfmfT6df0JsCZ8AIRAZjbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LJWphHmfn3SbB4yAD1Qd0nw46w+QnaA9u/YD0WFpEWBVGqF4hrvvKvbL6u/5evtObzxU3H3gYwW+2atrY9rk2VKcIDjs7fgF3Ln1mdvMJaS63MwhwebNKBFeGIyl2j3FYukhsyxyWf+zH8DenUl52DNsSL0qX2O/z3TtHYLTqGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiyionpri.me; spf=none smtp.mailfrom=aiyionpri.me; dkim=pass (2048-bit key) header.d=aiyionpri.me header.i=@aiyionpri.me header.b=CuFP+KHr; dkim=permerror (0-bit key) header.d=aiyionpri.me header.i=@aiyionpri.me header.b=zQ4hvJY1; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiyionpri.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=aiyionpri.me
ARC-Seal: i=1; a=rsa-sha256; t=1752174566; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GlcinUFybpp74LXlOPbfJq/vIj2yYcvg7v+3jVMMbIf0cy8pc9Hqjm0Wwhb71EZpWe
    kuSkxj0Ttju65YF6oS7/UWPE9puB4VPk1c1tVm2Fa94OaB//FYJqR89zkSGZ8keGnHQE
    I/v5LGISfnVd3ui0UiDPyypvmqszoc9NGYehMsvkeknKVB70+kQWChEuwgbfOVCPuZl6
    QC0KCUCSqVYN1UenRcl8tdP6aBPzwK1WD+v27E++WyVycm+9R7AlJoGCtIce4YaFhJOH
    9APDpngWhGofn+TNBltVz5CqoivhzA1t9rSMK0aJDj+Wf4IoUGlxvT/Dj1FO7sJdPhwt
    ko+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1752174566;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=FnjGVJXcq5/ir418FcqAdHT1NoKLuU/1sfPHApNdJ38=;
    b=OdjcIQ31Q0xmGcSb2GVBg4esTFjFWz0mJ0ZB72gdudckrhBmy2ipelTQDFrrHer0fK
    ouj5+jYYhIu50mjC1b5t1+BqX+9Vm4VNACy/YeThRIGfAJAHzs8Wnyei71DpJTkjpOjS
    WfATTXO62jEfReEOX9GnTrSe+AyfTIHY+Wwnm4tLEkQDkCSWMzvww7/TXRvOOAhd7WEq
    g8aIepbxpiPlp4TlYGUGF8CEvCAVE6hM1m1R5dmnk2QahD1WgJ1ISl5to1OuV63yRfJU
    Qm1YNFHBqINKURmKQFkNH6Nhd0uDGLWR5NrBd0HvHH9NFIMAajNrc/++OQPHt6amUszx
    6CSw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752174566;
    s=strato-dkim-0002; d=aiyionpri.me;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=FnjGVJXcq5/ir418FcqAdHT1NoKLuU/1sfPHApNdJ38=;
    b=CuFP+KHrMnLLrwHbAJPhsTeGFjyWeBQWvuM/dARYAsj09gfQAfOxsBJUntFK6u/8aC
    hTTljWAkWR9lRSNP2kZd1rfv39P7V7Hlin6hSF5I4VwECVapX8He3k0zYir+9+tuc7qt
    oYpGKdfRxlNo2s80c8A33ydxJpsag6aXB/tY4NMOKhnsYGGhz74+/hYYBPWkCmMgJ3/h
    gkv3766BD2KVJzKnBcZ2xQjmrot0F+UeralOcWH8+X0k8F5voXnS94W94tzzE7CwdAhP
    ndYWvJ3iEeIXVUMTUFKMSYu0DEs58dFoMLmfHmdKNPm7u0EfpIhzfUgIQXB9/wQPX2tO
    g/JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752174566;
    s=strato-dkim-0003; d=aiyionpri.me;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=FnjGVJXcq5/ir418FcqAdHT1NoKLuU/1sfPHApNdJ38=;
    b=zQ4hvJY15QtbxtaF4fUOY4PgZ029VZtZ0NPxpMyCDwiJ3jV1xmCBb4TLLx2h5+fZbA
    KZZdhOrF3cc0gSxB8aAQ==
X-RZG-AUTH: ":IWkkdEmxcvCtRDtHUQOu48a0Nfy9hOkbtqpt5cBSoxNQElJG620TYCK8nAkXs7YKQSRsyIcBIbULXaQjCPjUFD1kdMW0"
Received: from aura.ffh.zone
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id 533eb916AJ9Q8xJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 10 Jul 2025 21:09:26 +0200 (CEST)
From: Jan-Niklas Burfeind <kernel@aiyionpri.me>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jan-Niklas Burfeind <kernel@aiyionpri.me>
Subject: [PATCH] platform/x86: dell-lis3lv02d: Add Precision 3551
Date: Thu, 10 Jul 2025 21:09:19 +0200
Message-ID: <20250710190919.37842-1-kernel@aiyionpri.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This marks 0x29 as accelerometer address on Dell Precision 3551.

I followed previous works of Paul Menzel and Hans de Goede to verify it:

$ cd /sys/bus/pci/drivers/i801_smbus/0000\:00\:1f.4

$ ls -d i2c-?
i2c-0

$ sudo modprobe i2c-dev

$ sudo i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x08-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- 29 -- -- -- -- -- --
30: 30 -- -- -- -- 35 UU UU -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

$ echo lis3lv02d 0x29 > sudo tee /sys/bus/i2c/devices/i2c-0/new_device
lis3lv02d 0x29

$ sudo dmesg
[    0.000000] Linux version 6.12.28 (nixbld@localhost) (gcc (GCC) 14.2.1 20250322, GNU ld (GNU Binutils) 2.44) #1-NixOS SMP PREEMPT_DYNAMIC Fri May  9 07:50:53 UTC 2025
[...]
[    0.000000] DMI: Dell Inc. Precision 3551/07YHW8, BIOS 1.18.0 10/03/2022
[...]
[ 3749.077624] lis3lv02d_i2c 0-0029: supply Vdd not found, using dummy regulator
[ 3749.077732] lis3lv02d_i2c 0-0029: supply Vdd_IO not found, using dummy regulator
[ 3749.098674] lis3lv02d: 8 bits 3DC sensor found
[ 3749.182480] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input28
[ 3749.182899] i2c i2c-0: new_device: Instantiated device lis3lv02d at 0x29

Signed-off-by: Jan-Niklas Burfeind <kernel@aiyionpri.me>
---
 drivers/platform/x86/dell/dell-lis3lv02d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-lis3lv02d.c b/drivers/platform/x86/dell/dell-lis3lv02d.c
index 0791118dd6b7..732de5f556f8 100644
--- a/drivers/platform/x86/dell/dell-lis3lv02d.c
+++ b/drivers/platform/x86/dell/dell-lis3lv02d.c
@@ -49,6 +49,7 @@ static const struct dmi_system_id lis3lv02d_devices[] __initconst = {
 	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6330",     0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6430",     0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Precision 3540",     0x29),
+	DELL_LIS3LV02D_DMI_ENTRY("Precision 3551",     0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Precision M6800",    0x29),
 	DELL_LIS3LV02D_DMI_ENTRY("Vostro V131",        0x1d),
 	DELL_LIS3LV02D_DMI_ENTRY("Vostro 5568",        0x29),
-- 
2.49.0


