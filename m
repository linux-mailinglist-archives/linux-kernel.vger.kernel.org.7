Return-Path: <linux-kernel+bounces-867085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96198C01900
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD363A2997
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E8D312819;
	Thu, 23 Oct 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="gziZoPtz"
Received: from smtp125.iad3a.emailsrvr.com (smtp125.iad3a.emailsrvr.com [173.203.187.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45F306B0F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227508; cv=none; b=XqnVxgy9/Udy7YI9QElXSWdV8xHE59JHW0uTAHWeqJY3DQiiyHgZjzamDH31qdw8+ui17uZjinOFmadSnRlfXSyQqF/xzZn4BGC6Wq6wYn5X0UxCSazt/qOxm1KsqLjOpZtqKON1E8jGvCOnvwl76VSCHGG0mGWbl5NtUs1M8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227508; c=relaxed/simple;
	bh=XILaLIegSngfIqbfNaHC1yDvb8hEb3tmdMPdUcUiW38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEOWriA7U79yptnf47NKw0Mf5CwuXdfxBVoawfgI7ShvtideBXngvY1RhZ6f/8hDF2ZZkfhOIoFyDD8Vf4ntd8D+Rm5I91zfqZYsIxD2Ig/THkO6oL4pZyt12R8h9wkDTU9rmSa/7CVMzoCsvGrBAuEk4SSgHGq8xaTAYxVyTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=gziZoPtz; arc=none smtp.client-ip=173.203.187.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761222718;
	bh=XILaLIegSngfIqbfNaHC1yDvb8hEb3tmdMPdUcUiW38=;
	h=From:To:Subject:Date:From;
	b=gziZoPtzHTOBVnHxJIdjdOT1y0oUjyUtXN23+V4+kvjuhfTeD9FGOtcjREtyeZhBx
	 8fIDPr5To2KZ0RWH21TtiYdY4EwaND99io0O+TY1x7Qbrf9TS8+Dw41Vqyqiriu1xE
	 y5RJwP57twRyJysAwGZD5+0VwUsw0zbiEc+An3MA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6DBA4512D;
	Thu, 23 Oct 2025 08:31:57 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Hillf Danton <hdanton@sina.com>,
	lvc-project@linuxtesting.org,
	syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com
Subject: [PATCH] comedi: c6xdigio: Fix invalid PNP driver unregistration
Date: Thu, 23 Oct 2025 13:31:41 +0100
Message-ID: <20251023123141.6537-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 82a09067-b6b3-4c4f-b20b-beea8168f563-1-1

The Comedi low-level driver "c6xdigio" seems to be for a parallel port
connected device.  When the Comedi core calls the driver's Comedi
"attach" handler `c6xdigio_attach()` to configure a Comedi to use this
driver, it tries to enable the parallel port PNP resources by
registering a PNP driver with `pnp_register_driver()`, but ignores the
return value.  (The `struct pnp_driver` it uses has only the `name` and
`id_table` members filled in.)  The driver's Comedi "detach" handler
`c6xdigio_detach()` unconditionally unregisters the PNP driver with
`pnp_unregister_driver()`.

It is possible for `c6xdigio_attach()` to return an error before it
calls `pnp_register_driver()` and it is possible for the call to
`pnp_register_driver()` to return an error (that is ignored).  In both
cases, the driver should not be calling `pnp_unregister_driver()` as it
does in `c6xdigio_detach()`.  (Note that `c6xdigio_detach()` will be
called by the Comedi core if `c6xdigio_attach()` returns an error, or if
the Comedi core decides to detach the Comedi device from the driver for
some other reason.)

The unconditional call to `pnp_unregister_driver()` without a previous
successful call to `pnp_register_driver()` will cause
`driver_unregister()` to issue a warning "Unexpected driver
unregister!".  This was detected by Syzbot [1].

Also, the PNP driver registration and unregistration should be done at
module init and exit time, respectively, not when attaching or detaching
Comedi devices to the driver.  (There might be more than one Comedi
device being attached to the driver, although that is unlikely.)

Change the driver to do the PNP driver registration at module init time,
and the unregistration at module exit time.  Since `c6xdigio_detach()`
now only calls `comedi_legacy_detach()`, remove the function and change
the Comedi driver "detach" handler to `comedi_legacy_detach`.

-------------------------------------------
[1] Syzbot sample crash report:
Unexpected driver unregister!
WARNING: CPU: 0 PID: 5970 at drivers/base/driver.c:273 driver_unregister drivers/base/driver.c:273 [inline]
WARNING: CPU: 0 PID: 5970 at drivers/base/driver.c:273 driver_unregister+0x90/0xb0 drivers/base/driver.c:270
Modules linked in:
CPU: 0 UID: 0 PID: 5970 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:driver_unregister drivers/base/driver.c:273 [inline]
RIP: 0010:driver_unregister+0x90/0xb0 drivers/base/driver.c:270
Code: 48 89 ef e8 c2 e6 82 fc 48 89 df e8 3a 93 ff ff 5b 5d e9 c3 6d d9 fb e8 be 6d d9 fb 90 48 c7 c7 e0 f8 1f 8c e8 51 a2 97 fb 90 <0f> 0b 90 90 5b 5d e9 a5 6d d9 fb e8 e0 f4 41 fc eb 94 e8 d9 f4 41
RSP: 0018:ffffc9000373f9a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8ff24720 RCX: ffffffff817b6ee8
RDX: ffff88807c932480 RSI: ffffffff817b6ef5 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8ff24660
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88814cca0000
FS:  000055556dab1500(0000) GS:ffff8881249d9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f77f285cd0 CR3: 000000007d871000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 comedi_device_detach_locked+0x12f/0xa50 drivers/comedi/drivers.c:207
 comedi_device_detach+0x67/0xb0 drivers/comedi/drivers.c:215
 comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1011
 do_devconfig_ioctl+0x1b1/0x710 drivers/comedi/comedi_fops.c:872
 comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc05798eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf8184238 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc057be5fa0 RCX: 00007fc05798eec9
RDX: 0000200000000080 RSI: 0000000040946400 RDI: 0000000000000003
RBP: 00007fc057a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc057be5fa0 R14: 00007fc057be5fa0 R15: 0000000000000003
 </TASK>
-------------------------------------------

Reported-by: syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6616bba359cec7a1def1
Fixes: 2c89e159cd2f ("Staging: comedi: add c6xdigio driver")
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/c6xdigio.c | 46 +++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
index 14b90d1c64dc..8a38d97d463b 100644
--- a/drivers/comedi/drivers/c6xdigio.c
+++ b/drivers/comedi/drivers/c6xdigio.c
@@ -249,9 +249,6 @@ static int c6xdigio_attach(struct comedi_device *dev,
 	if (ret)
 		return ret;
 
-	/*  Make sure that PnP ports get activated */
-	pnp_register_driver(&c6xdigio_pnp_driver);
-
 	s = &dev->subdevices[0];
 	/* pwm output subdevice */
 	s->type		= COMEDI_SUBD_PWM;
@@ -278,19 +275,46 @@ static int c6xdigio_attach(struct comedi_device *dev,
 	return 0;
 }
 
-static void c6xdigio_detach(struct comedi_device *dev)
-{
-	comedi_legacy_detach(dev);
-	pnp_unregister_driver(&c6xdigio_pnp_driver);
-}
-
 static struct comedi_driver c6xdigio_driver = {
 	.driver_name	= "c6xdigio",
 	.module		= THIS_MODULE,
 	.attach		= c6xdigio_attach,
-	.detach		= c6xdigio_detach,
+	.detach		= comedi_legacy_detach,
 };
-module_comedi_driver(c6xdigio_driver);
+
+static bool c6xdigio_pnp_registered = false;
+
+static int __init c6xdigio_module_init(void)
+{
+	int ret;
+
+	ret = comedi_driver_register(&c6xdigio_driver);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_PNP)) {
+		/*  Try to activate the PnP ports */
+		ret = pnp_register_driver(&c6xdigio_pnp_driver);
+		if (ret) {
+			pr_warn("failed to register pnp driver - err %d\n",
+				ret);
+			ret = 0;	/* ignore the error. */
+		} else {
+			c6xdigio_pnp_registered = true;
+		}
+	}
+
+	return 0;
+}
+module_init(c6xdigio_module_init);
+
+static void __exit c6xdigio_module_exit(void)
+{
+	if (c6xdigio_pnp_registered)
+		pnp_unregister_driver(&c6xdigio_pnp_driver);
+	comedi_driver_unregister(&c6xdigio_driver);
+}
+module_exit(c6xdigio_module_exit);
 
 MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for the C6x_DIGIO DSP daughter card");
-- 
2.51.0


