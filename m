Return-Path: <linux-kernel+bounces-872023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB816C0F243
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79204465268
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D83128A1;
	Mon, 27 Oct 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="X/Vmirg8"
Received: from smtp115.iad3a.emailsrvr.com (smtp115.iad3a.emailsrvr.com [173.203.187.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0E31282A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580009; cv=none; b=hcUCDL8Fvmwt0fc8ObvYgxLo5AcKJzxntEQm0arVqDxCWfhJaI98zGCn4HQXaU9dTZ3yk/W2BLCfEeeIpeFt2BaywFRBDCbhJ50QlLx7BjqNTR2z0ig/2Fy9h8obSeznDcL7cb2yqvJu6ux71jMlah1PSw7f3/6QbSl6wctFoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580009; c=relaxed/simple;
	bh=wT8QQC9kkxlb+EzqUvWMeWLHuQDPUieQqNBrMIRatXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm2miEYUNofKA0nYvISVcDhMpSrGC6bgz+uQc2MTqIeZrqy1l480EfnIE6cpww4Pxi83BMEu4aC1gFn1J5agdZYTSwg9wGZlc7nJBV9nXVTN3W2InmKSqU9BdHj4wAKHFS07UT6jCS/4q2F96R3MI9xZwytZ/ulQuC/mMXywSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=X/Vmirg8; arc=none smtp.client-ip=173.203.187.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761579482;
	bh=wT8QQC9kkxlb+EzqUvWMeWLHuQDPUieQqNBrMIRatXQ=;
	h=From:To:Subject:Date:From;
	b=X/Vmirg8srKlv7wC37tXcTQDwZBPcu14HvFJKrlWXWtI2ZFRWavPYy1rpwLHKDUIA
	 274uNDqD8y2xoilC36jpnWK1McNkLtTBUrNGo0cBmzJhhX2nftgarLJs8dPZsIUKxw
	 uzI1dpV6/5UsAyoJf981e+5pzc3FLu7pEJhDCSrQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 923812538C;
	Mon, 27 Oct 2025 11:38:01 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 2/2] comedi: comedi_bond: Check for loops when bonding devices
Date: Mon, 27 Oct 2025 15:25:03 +0000
Message-ID: <20251027153748.4569-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027153748.4569-1-abbotti@mev.co.uk>
References: <20251027153748.4569-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 91387a8e-76e7-4b89-824f-f1251498570e-3-1

The "comedi_bond" driver allows a composite COMEDI device to be built up
from the subdevices of other COMEDI devices, although it currently only
supports digital I/O subdevices.  Although it checks that it is not
trying to bind to itself, it is possible to end up with a cycle of
"comedi_bond" devices bound to each other.  For example:

1. Configure /dev/comedi0 to use some COMEDI hardware device with
   digital I/O subdevices, but not a "comedi_bond" device.
2. Configure /dev/comedi1 as a "comedi_bond" device bound to
   /dev/comedi0.
3. Unconfigure /dev/comedi0 and reconfigure it as a "comedi_bond" device
   bound to /dev/comedi1.

Now we have /dev/comedi0 and /dev/comedi1 bound in a cycle.  When an
operation is performed on the digital I/O subdevice of /dev/comedi0 for
example, it will try and perform the operation on /dev/comedi1, which
will try and perform the operation on /dev/comedi0.  The task will end
up deadlocked trying to lock /dev/comedi0's mutex which it has already
locked.

I discovered that possibility while investigating fix sysbot crash
https://syzkaller.appspot.com/bug?extid=4a6138c17a47937dcea1 ("possible
deadlock in comedi_do_insn"), but I think that report may be a false
positive.

To avoid that, replace the calls to `comedi_open()` and `comedi_close()`
in "kcomedilib" with calls to `comedi_open_from()` and
`comedi_close_from()`.  These take an extra parameter that indicates the
COMEDI minor device number from which the open or close is being
performed.  `comedi_open_from()` will refuse to open the device if doing
so would result in a cycle.  The cycle detection depends on the extra
parameter having the correct value for this device and also for existing
devices in the chain.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/comedi_bond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
index 78c39fa84177..30650fa36fff 100644
--- a/drivers/comedi/drivers/comedi_bond.c
+++ b/drivers/comedi/drivers/comedi_bond.c
@@ -205,7 +205,7 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 		snprintf(file, sizeof(file), "/dev/comedi%d", minor);
 		file[sizeof(file) - 1] = 0;
 
-		d = comedi_open(file);
+		d = comedi_open_from(file, dev->minor);
 
 		if (!d) {
 			dev_err(dev->class_dev,
@@ -326,7 +326,7 @@ static void bonding_detach(struct comedi_device *dev)
 			if (!bdev)
 				continue;
 			if (!test_and_set_bit(bdev->minor, devs_closed))
-				comedi_close(bdev->dev);
+				comedi_close_from(bdev->dev, dev->minor);
 			kfree(bdev);
 		}
 		kfree(devpriv->devs);
-- 
2.51.0


