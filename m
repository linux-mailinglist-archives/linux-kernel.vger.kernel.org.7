Return-Path: <linux-kernel+bounces-864934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB83BFBE55
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6CEE4F33F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F929A9FE;
	Wed, 22 Oct 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GuSgJnhv"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89F2765ED
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137058; cv=none; b=NHdWC5jB6UmbKpKvQLiZ3gb0OIoA6vXUKzKOHLf54DmsdueUWuxAddAsTSI/PIC4c2EzOS591OOtyHdP/a6fe1RvrsX7Jg52bh3xlWjRna7ZdwjC3ESsjo2O7j/pLXDzMM7JRyiWmhqazPse2TtZezLM9wefli49iXnYInruqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137058; c=relaxed/simple;
	bh=XKJx4j95noYtAKBEwKbCQIWnOk8OfcgLrQC7FQqYhYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eodA2C0fp/jwDsAhsYeKEEdfbZULrUeWTIUs7AIssUAg9L1fHZjwWva6DfsEcUCEcoNini//8hm4H7ZK+hiofubzzjknuJ1eq0oVJu9BrBxM24wZEqSBLnE2dQ4hNZu5Dt4XmEbwQS/qHMS9D7Y8uodSM8ikSezW3YkhQDf4/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GuSgJnhv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1345820066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761137054; x=1761741854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1vTyP4Qrfg0RII36IHf9VvPmAKx6N6kqC5x1SFS9lU=;
        b=GuSgJnhvOMk1uLMMcJTLa3OOA91JNl1ZvPe/Esi7ntn+hFHV7F8Pg52Xs5CHE3JO3f
         h4cNyOUHTgWMEP6Vo2PUl9y4mgMI0mIsv493OYtVlpVSTlnc8Dc8ajadZrQFp8+bir+d
         jSNz30rl+sN1wCUYnDq5jLd6+rl+ht6AXJTYxnGekhb7cToPdhlBvt7Nv70vOfelABW1
         hpK7GfJ/XfszYXb/VxnjZ8d81/TBRHsHPS3gpj59JP/xyblvzAZ6mioYWCBouWJXMDGj
         mGABo8h2QzgdXmV0cHKGSOKJSCAFEN5eChDtAO4fmHRyNYQahSehGrAAsBfEn1HNjPD/
         STDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137054; x=1761741854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1vTyP4Qrfg0RII36IHf9VvPmAKx6N6kqC5x1SFS9lU=;
        b=iOqK2UFTKlR1GI0lvXCoBtHTkRsEplOHhAXT3wZvu8CMdfco9AsePpwyiPadOLQFAx
         niSsfwPKPr7TUAFM3/qlRb4JobW5fv+De44kvOQrvlAbAr/9LRml93cxcbOAUbvYDCHq
         XG18NSSPLlkeHER/xciqYPbnieOgVDWRKn6Yeov4Id8Wm/CM5t63TGjuAxfO5JtHdsfk
         ufCcIwxTsqqEPWpLQVA1HgDxzfj6IaSIzTni8zM8rq6Ff92w5z6wYg3gI4UFWr0Q63+d
         SHWcE2X02a1t3ls6aVneRhO1vem6q1011GOBxJTmdUtXrzgt37LphYYrRXpqN+R6jBY3
         TbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsZUrRdG14eZ0TbJLknhzRUlc65cqZ69Yk6T/MNeXOg6eIxfG82Up7+dd5Y4a31VS5bHAy0oVIbyc4OxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKf7lcxtPhWqto8SWnaGo6iRjO13aRsIFalZOWORXRuoOwjhp
	puVaRiIbK9dQJYUYCagP3L3mlLOlHw2m+UTsqpc8CKt8g44Kszb3mAE2ylOTUrZgNyQ=
X-Gm-Gg: ASbGncs1cuQYtcHYqjyIxDN9HKQYG/33BtAOI/5r+emmHFAwzb/R5+QT9DyDhBrllc9
	J10muZGfBY/VwiS5HFSItA+eg6KipYJj94gvKR4WqDO2/k/c3zp9JsARGf9q0EcFBRN1YQLmiIX
	aNzqeJbtE5N8p67XoULRgtYTkleXIVf1ycx1ZS+Mho8DhPYsSVAkYEvduLvk+kkRdenaKdXGQzx
	njQ3TsPkBLeh2VXwf9xopdC48ojdzTPPd8qgoCVoUrWcBdlonvVSgmHtOu9f4jMxJXN3xQ4rDId
	vqO9ax622h9WeZsd8cvEPWVIXMRnHr45Qb9pkz15wYoaCuVLIxSHN6uLoX3SlvAP+iEOxF44Nf+
	xFIXvwCbCnyw3S4wltvTUaBcT4futNujiwijX48guyFJBLkQDGA756pgBXp0ronVd1SySfOuCU3
	TAfdyKgQDAKBPL8FEfJJ29a7yagXZKBk9HqnEPQrXvyE/2bwlL2bg=
X-Google-Smtp-Source: AGHT+IGd94J6cx7QBiHOtB0nhoaMmvnnZX2o0UebxY6JPmlFEUl524Mbppcf/F9K6FXM6cFPNHw1eA==
X-Received: by 2002:a17:906:ee89:b0:b3f:f43d:f81e with SMTP id a640c23a62f3a-b6474b37161mr2720564066b.40.1761137053432;
        Wed, 22 Oct 2025 05:44:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb03671csm1327720066b.38.2025.10.22.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:44:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	geert+renesas@glider.be
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: Fix synchronous external abort on unbind
Date: Wed, 22 Oct 2025 15:43:50 +0300
Message-ID: <20251022124350.4115552-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

A synchronous external abort occurs on the Renesas RZ/G3S SoC if unbind is
executed after the configuration sequence described above:

modprobe usb_f_ecm
modprobe libcomposite
modprobe configfs
cd /sys/kernel/config/usb_gadget
mkdir -p g1
cd g1
echo "0x1d6b" > idVendor
echo "0x0104" > idProduct
mkdir -p strings/0x409
echo "0123456789" > strings/0x409/serialnumber
echo "Renesas." > strings/0x409/manufacturer
echo "Ethernet Gadget" > strings/0x409/product
mkdir -p functions/ecm.usb0
mkdir -p configs/c.1
mkdir -p configs/c.1/strings/0x409
echo "ECM" > configs/c.1/strings/0x409/configuration

if [ ! -L configs/c.1/ecm.usb0 ]; then
        ln -s functions/ecm.usb0 configs/c.1
fi

echo 11e20000.usb > UDC
echo 11e20000.usb > /sys/bus/platform/drivers/renesas_usbhs/unbind

The displayed trace is as follows:

 Internal error: synchronous external abort: 0000000096000010 [#1] SMP
 CPU: 0 UID: 0 PID: 188 Comm: sh Tainted: G M 6.17.0-rc7-next-20250922-00010-g41050493b2bd #55 PREEMPT
 Tainted: [M]=MACHINE_CHECK
 Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
 pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : usbhs_sys_function_pullup+0x10/0x40 [renesas_usbhs]
 lr : usbhsg_update_pullup+0x3c/0x68 [renesas_usbhs]
 sp : ffff8000838b3920
 x29: ffff8000838b3920 x28: ffff00000d585780 x27: 0000000000000000
 x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000c3e3810
 x23: ffff00000d5e5c80 x22: ffff00000d5e5d40 x21: 0000000000000000
 x20: 0000000000000000 x19: ffff00000d5e5c80 x18: 0000000000000020
 x17: 2e30303230316531 x16: 312d7968703a7968 x15: 3d454d414e5f4344
 x14: 000000000000002c x13: 0000000000000000 x12: 0000000000000000
 x11: ffff00000f358f38 x10: ffff00000f358db0 x9 : ffff00000b41f418
 x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
 x5 : 8080808000000000 x4 : 000000004b5ccb9d x3 : 0000000000000000
 x2 : 0000000000000000 x1 : ffff800083790000 x0 : ffff00000d5e5c80
 Call trace:
 usbhs_sys_function_pullup+0x10/0x40 [renesas_usbhs] (P)
 usbhsg_pullup+0x4c/0x7c [renesas_usbhs]
 usb_gadget_disconnect_locked+0x48/0xd4
 gadget_unbind_driver+0x44/0x114
 device_remove+0x4c/0x80
 device_release_driver_internal+0x1c8/0x224
 device_release_driver+0x18/0x24
 bus_remove_device+0xcc/0x10c
 device_del+0x14c/0x404
 usb_del_gadget+0x88/0xc0
 usb_del_gadget_udc+0x18/0x30
 usbhs_mod_gadget_remove+0x24/0x44 [renesas_usbhs]
 usbhs_mod_remove+0x20/0x30 [renesas_usbhs]
 usbhs_remove+0x98/0xdc [renesas_usbhs]
 platform_remove+0x20/0x30
 device_remove+0x4c/0x80
 device_release_driver_internal+0x1c8/0x224
 device_driver_detach+0x18/0x24
 unbind_store+0xb4/0xb8
 drv_attr_store+0x24/0x38
 sysfs_kf_write+0x7c/0x94
 kernfs_fop_write_iter+0x128/0x1b8
 vfs_write+0x2ac/0x350
 ksys_write+0x68/0xfc
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x48/0x110
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0xf0
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c
 Code: 7100003f 1a9f07e1 531c6c22 f9400001 (79400021)
 ---[ end trace 0000000000000000 ]---
 note: sh[188] exited with irqs disabled
 note: sh[188] exited with preempt_count 1

The issue occurs because usbhs_sys_function_pullup(), which accesses the IP
registers, is executed after the USBHS clocks have been disabled. The
problem is reproducible on the Renesas RZ/G3S SoC starting with the
addition of module stop in the clock enable/disable APIs. With module stop
functionality enabled, a bus error is expected if a master accesses a
module whose clock has been stopped and module stop activated.

Disable the IP clocks at the end of remove.

Cc: stable@vger.kernel.org
Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Patch was tested with continuous unbind/bind and the configuration
sequence described above on the devices with the following device trees:

- r8a774a1-hihope-rzg2m-ex.dts
- r8a774b1-hihope-rzg2n-ex.dts
- r8a774e1-hihope-rzg2h-ex.dts
- r9a07g043u11-smarc.dts
- r9a07g044c2-smarc.dts
- r9a07g044l2-smarc.dts
- r9a07g054l2-smarc.dts

 drivers/usb/renesas_usbhs/common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 8f536f2c500f..b8b55d08ac52 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -813,18 +813,18 @@ static void usbhs_remove(struct platform_device *pdev)
 
 	flush_delayed_work(&priv->notify_hotplug_work);
 
-	/* power off */
-	if (!usbhs_get_dparam(priv, runtime_pwctrl))
-		usbhsc_power_ctrl(priv, 0);
-
-	pm_runtime_disable(&pdev->dev);
-
 	usbhs_platform_call(priv, hardware_exit, pdev);
 	usbhsc_clk_put(priv);
 	reset_control_assert(priv->rsts);
 	usbhs_mod_remove(priv);
 	usbhs_fifo_remove(priv);
 	usbhs_pipe_remove(priv);
+
+	/* power off */
+	if (!usbhs_get_dparam(priv, runtime_pwctrl))
+		usbhsc_power_ctrl(priv, 0);
+
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int usbhsc_suspend(struct device *dev)
-- 
2.43.0


