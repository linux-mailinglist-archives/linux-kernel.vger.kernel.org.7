Return-Path: <linux-kernel+bounces-738438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC0B0B84C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D377A2852
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE04221F1C;
	Sun, 20 Jul 2025 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOj0nVoU"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37963595E;
	Sun, 20 Jul 2025 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045741; cv=none; b=je2fOENv3ME57FaP3Cn16Hivl0F5aFFNHrMguwstyLrOCuUW4O254N4w1N1/MeBPv4u9S+LyqlqzAuwcZkRJCtBsRZvBSc9+lYD/dS4HcwwXMJgZ/by5WwISdgGotP/YhIWlNMHvjaY7Vav12IYuFDIQVguVPssW8fafhJuvStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045741; c=relaxed/simple;
	bh=3YyaHadaYQ9QGWQ/6YQpAZlT1JPPS49UsN1VwPYG6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMbJK/5bwg4r/Mg2RbBrtCDqjLyVuKbo/Gdfsrw3+7D13ZUYYoCwFFOF03SyCfKxKvK3XCQncZM8e8Jj9dBcmfYQ3/U8cM3BalpuAFgMaj7KL+d+UyM4F84Qzj/07v48HWiDrwmNbG1/uc3+SsLwLRGslehcfpXhpKJrYZnCQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOj0nVoU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso6587771a12.2;
        Sun, 20 Jul 2025 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753045738; x=1753650538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0TOoMF8RbvR0T32mWJ/zIZV4e9ontZrGLG4u2/MjTOY=;
        b=fOj0nVoU3c0D8Jz9mh6xS3L50hfGJDUykKz7FMkFBnVJXqfDTrB4xK4ZxhjxNHvnag
         iH9yttb8RXkB7uPlnYPtrnSO0Zx8q1mhNWASrSXRU2CrZkGyikFNQte5YPbiofuXeCgQ
         x/llWG6tT3AXCqlk1J+5wbqD5xbj7R23GI5aAz1yeedFSxbTXuL63GSUKScORAvSB/Rm
         lrN49Tv3Ch3yiFdoFTts7H+C8KpU8crGRPl0uNEeRYKfurtTjTnWUwQwJLDebOfWAT1i
         JdH9BDWrqi3YbI2anfqDFQQ3S7JkT2SF4vYunEWLNgwxwiJCK6l/eeGaD3HTAHu2OhLf
         h9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753045738; x=1753650538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TOoMF8RbvR0T32mWJ/zIZV4e9ontZrGLG4u2/MjTOY=;
        b=cPlf6kxi1vP7bmiqAwhlkO2NbdrVRUQWtzpCz6BUju1osDzqvHlcITVx1KIPnisOxo
         DGWVDKAhNsbm235wVhCPIXeUjoLvfSgrKDcvKk++oa6rX25pZ+r0MClRk4suWTO4xg12
         ov2ntEG52ApZJrxylJp/vvc54/FFdErEy3tBHf8+5v88WMqfdfDQRERdeSWJyvkB1rzQ
         UAgvb6gJlZItA8qlsbk5dTd8FgadXk+NfN+7E1+tF6z6beawmd2JdbZCH1/QROWKcN63
         Vc1/4ymLbdL5vH47fPge6ep9ThYm9bkY2QF7rs9MAt4r/UYufUE+XcSanrl39Q4Mc2hP
         kuvw==
X-Forwarded-Encrypted: i=1; AJvYcCWAi9l2Zp1XgL91J2FW6c6Y3GJzrvoR2M/dMAwtNgXz6vSEJ8K84U3DmUjyTATQIbx0p2GKLso8VFvnrGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwqfCZ6RHWxm6Dua3PXLIaVOKi3pp3NBvy3nPvnLTyLG+GyEg
	hmCDDCz+z4UGt8kooYGbuna3A3mxIXp96NkiG3CjaiVS9ahnTe1a6Lwo1TRfRZXA
X-Gm-Gg: ASbGncvjMQzK/igMU5mBTKDgOFD1ZKzBXXCJPegzMFSOdphlUtOvMYJsAWjekeEy55X
	GWtmA+Jj3z+KIHXx+/u1QwDFpFk9FqGpgHMcXqPd1JZ9NmqxHFsgixlWOejsCsgMaqK4MbuVCLy
	p/UsVCu+Jlx763BEpqOBgOOs1i9Z1auM0deQnqJc1lwsvpdGMN6Jgd8InIXDkQ6Vu6vOXIEnUWv
	tNu/BIvmF2tjSf8uxzVWr91IpPsf8q1FpdMWxDD4eK+38x+YWAV1g551Q03J4ckcqzHEyRAwAFr
	LcY3HOJB6FjLLelm+PE1OQ5JmGGDK1ZEbHLmoFcgik9OSk8fzQdAc+A6hGB2Oluko58zx6JIH06
	41tB+6BsOWYJHXxnbJALrInBQPIa6xNlmtgFmfkHScoxDTIxsxR4fZFr39CcSECvtQsmEF/XBYa
	T3
X-Google-Smtp-Source: AGHT+IHtbETpKbsgLT5W1SF5UsP85+81MzUA6+deNrynboG7g6Cvqc0eivuSVjRihU5CPPVCOi9iDg==
X-Received: by 2002:a05:6402:2341:b0:607:e3ec:f8ea with SMTP id 4fb4d7f45d1cf-6128591955amr16371634a12.6.1753045737723;
        Sun, 20 Jul 2025 14:08:57 -0700 (PDT)
Received: from asterix.home (host-80-116-76-192.pool80116.interbusiness.it. [80.116.76.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c903fd6esm4413441a12.45.2025.07.20.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 14:08:57 -0700 (PDT)
From: Marco Tormento <mtormento80@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Tormento <mtormento80@gmail.com>
Subject: [PATCH] USB: hub: Move typec deattach before children disconnections in usb_disconnect()
Date: Sun, 20 Jul 2025 23:08:47 +0200
Message-ID: <20250720210847.30998-1-mtormento80@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a Thinkpad T480s, it has 2 USB typec ports one of which is part of
the thunderbolt connector. On the thunderbolt typec port I plug a BenQ
EX3501R external monitor that has an integrated USB hub with a couple of
HID devices connected to it. On the other typec port I plug an Apple
Macbook USB-C power brick.

Steps to reproduce the issue this patch is supposed to fix:
- plug the power brick into typec port
- plug the monitor into the other typec port (thunderbolt)
- unplug the monitor
- unplug the power brick: get a warning stack trace saying "kernfs: can not
  remove 'typec', no directory" in typec_unregister_partner()
- plug the power brick again
- plug the monitor again
- unplug the monitor
- plug the monitor again: get a warning stack trace saying "sysfs: cannot
  create duplicate filename
  '/devices/platform/USBC000:00/typec/port0/port0-partner/3-1'" in
  typec_partner_link_device() called by typec_partner_attach()

From that point on if you do the following steps a couple of times you get
a kernel oops with a general protection fault in
typec_unregister_partner(), system becomes unstable and a restart is
required:
- unplug the monitor
- unplug the power brick
- plug the power brick
- plug the monitor
- unplug the monitor
- unplug the power brick

If I plug the power brick to thunderbolt and the monitor to the other typec
port none of the above happens.

I tracked down the issue to the following logic:
- power brick is plugged in
- monitor is plugged in
- when I unplug the monitor in usb_disconnect() hub_disconnect_children()
  calls usb_disconnect() recursively, and this results in
  connector_unbind() invoked on all connectors, which resets
  port_dev->connector to NULL on the ports
- typec_deattach() is called for each device that has a parent, which in
  turn should fire typec_partner_deattach()
- port_dev->connector is NULL though, so typec_partner_deattach() is not
  called and port->usb2_dev is not set to NULL even though the hub device
  is actually gone

Now if I plug the monitor again:
- since the type_partner_deattach() was not invoked before, some links are
  still there and typec_partner_link_device() complains

If I unplug the power brick instead:
- ucsi_handle_connector_change() is invoked and typec_unregister_partner()
  is executed, port->usb2_dev is not NULL so we try to unlink the device
  from the partner with typec_partner_unlink_device(), but 'typec'
  directory doesn't exist anymore so it fails in the sysfs_remove_link()
  call

The reason why at some point kernel oops when I unplug the power brick a
final time is this: in typec_unregister_partner() when
typec_partner_unlink_device() is called port->usb2_dev->kobj ref count is
zero (the device is gone already), so when accessing usb_dev->kobj fields
it's just a matter of time and memory will be overwritten with something
else, which will cause access to protected memory and an oops.

In order to fix the above I tried moving the code that handles typec
deattachment from the parent before all the disconnections, this way
typec_partner_deattach() is invoked for the partner, port->usb2_dev is
cleared and typec_unregister_partner() is happy.

Note
It's still not clear to me why the hub device of the monitor is linked with
the typec port partner of the power brick in /sys/class/typec. The
thunderbolt controller surely has something to do with it, since it doesn't
happen if the monitor is plugged into the standard typec port instead, but
I haven't fully understood why it happens yet: maybe this is the actual
bug?
e.g.
Plug the power brick:
- /sys/class/typec/port0-partner appears
Plug the monitor:
- /sys/class/typec/port1-partner appears
- /sys/class/typec/port0-partner/3-1 appears, which is the monitor hub
If I plug the monitor first and then the power brick
/sys/class/typec/port0-partner/3-1 doesn't show up.

Disclaimer
I just started looking at kernel code for the first time a week ago, so all
of the above might be spectacularly wrong or a better way to fix the issue
might exist. Initially I did a quick fix that was just checking
port->usb2_dev->kobj ref count in typec_partner_unlink_device() and bailing
out if it was zero, but then I decided to dig deeper just for fun.
This patch has solved my problem, I'm running it on laptop since last week
without any issue, but it might have side-effects I'm not aware of.
I really hope I'm not wasting your time, thanks for all the great work you
do on the Linux kernel!

Signed-off-by: Marco Tormento <mtormento80@gmail.com>
---
 drivers/usb/core/hub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 256fe8c86828..dfe4ba192faf 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2334,16 +2334,6 @@ void usb_disconnect(struct usb_device **pdev)
 
 	usb_lock_device(udev);
 
-	hub_disconnect_children(udev);
-
-	/* deallocate hcd/hardware state ... nuking all pending urbs and
-	 * cleaning up all state associated with the current configuration
-	 * so that the hardware is now fully quiesced.
-	 */
-	dev_dbg(&udev->dev, "unregistering device\n");
-	usb_disable_device(udev, 0);
-	usb_hcd_synchronize_unlinks(udev);
-
 	if (udev->parent) {
 		port1 = udev->portnum;
 		hub = usb_hub_to_struct_hub(udev->parent);
@@ -2362,6 +2352,16 @@ void usb_disconnect(struct usb_device **pdev)
 		typec_deattach(port_dev->connector, &udev->dev);
 	}
 
+	hub_disconnect_children(udev);
+
+	/* deallocate hcd/hardware state ... nuking all pending urbs and
+	 * cleaning up all state associated with the current configuration
+	 * so that the hardware is now fully quiesced.
+	 */
+	dev_dbg(&udev->dev, "unregistering device\n");
+	usb_disable_device(udev, 0);
+	usb_hcd_synchronize_unlinks(udev);
+
 	usb_remove_ep_devs(&udev->ep0);
 	usb_unlock_device(udev);
 
-- 
2.50.1


