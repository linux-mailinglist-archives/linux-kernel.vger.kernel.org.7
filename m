Return-Path: <linux-kernel+bounces-796396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC5B40046
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A822204606
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E22459F7;
	Tue,  2 Sep 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kydl/mlD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F601A9F88;
	Tue,  2 Sep 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815360; cv=none; b=P/Rz63AujfdfQ/ypOC8Vt0RPSQwbyXWE7lKCu6Vu1n5wtxkcGmI1cGurb7vdnxz3C0Tl6/wI9qyF45360eL7PShOXY/oHm90NyuJ3TT2Mb81oETFa/5BOYQt4wMX73idjTgg/IonQAGAWD1dLpvReh2YHumB+NKYKU9ZfTTjaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815360; c=relaxed/simple;
	bh=wcgX/ND25g46C+3//qVJGQeuiEX4k18tJpZkfsw3LzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YBOv/hy9wTDuUXiDHToHHFhQIAerKbP3+o6VjT1KCQL/PmdhVjiaLPM9XNdk1zC/pwnP86Lauu9wwGTbjVfaeVxqcKaLhmmt7lhOqhJVBRC2Vxv9pBhrKbnbiwP7AtN+4M8coXjttfrUD+7Qf0yi8Q/+gRuSGqxSZQTpNaFsZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kydl/mlD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756815356;
	bh=wcgX/ND25g46C+3//qVJGQeuiEX4k18tJpZkfsw3LzA=;
	h=From:Date:Subject:To:Cc:From;
	b=kydl/mlDHGjU3q9Ui0EeiX3+eXd/aIkSsiytK3TKiV4h95c6L7cG/uM87flEsLXC4
	 aaxQJQ+cvYnhoaisiZERVO7tJ2yF3J/twQV1k8hv/Gg1qhTjhBa3c+6kS9lFwASOkq
	 XQT0Yl+wXg5Sy4WWupNPDa3HQtRFssu+NfQz9DfhYjHHRlPu0CdrrwdiLqzGDHfawq
	 Gmww8VNg16zybXVMKOtS+glItvleaeEDOpZWv4YUzd8a2dljNaB1Uc+xpevUw5Z37t
	 lDAFQW3zYSRAj7R/DRJXBhCMTPW3/TZ/6nNBpASWoA0XgBa673i+ZOGrduPf78zXMm
	 1FimqLdXCieGA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 069C417E12A2;
	Tue,  2 Sep 2025 14:15:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 15:15:46 +0300
Subject: [PATCH v3] usb: vhci-hcd: Prevent suspending virtually attached
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-suspend-fix-v3-1-864e4e833559@collabora.com>
X-B4-Tracking: v=1; b=H4sIAPHftmgC/3XNQQrCMBCF4atI1o5MR9NaV95DXKST1ARqUxINS
 undTQuCiC7/B/PNKKIJzkRxWI0imOSi832O7Xol2Kr+YsDp3IKQJFbFDpJlB5Y1xHscTK+hdQ+
 odCOZJEustcinQzB5XtjTObd18ebDc/mSinl9g9VvMBWAQA0iskZZSzqy7zrV+KA27K9iRhN9Q
 FT+gShDxb6mstStbpX6hqZpegHJgtV+BQEAAA==
X-Change-ID: 20250714-vhci-hcd-suspend-fix-7db5c25c509d
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The VHCI platform driver aims to forbid entering system suspend when at
least one of the virtual USB ports are bound to an active USB/IP
connection.

However, in some cases, the detection logic doesn't work reliably, i.e.
when all devices attached to the virtual root hub have been already
suspended, leading to a broken suspend state, with unrecoverable resume.

Ensure the virtually attached devices do not enter suspend by setting
the syscore PM flag.  Note this is currently limited to the client side
only, since the server side doesn't implement system suspend prevention.

Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
The USB/IP Virtual Host Controller (VHCI) platform driver is expected to
prevent entering system suspend when at least one remote device is
attached to the virtual USB root hub.

However, in some cases, the detection logic for active USB/IP
connections doesn't seem to work reliably, e.g. when all devices
attached to the virtual hub have been already suspended.  This will
normally lead to a broken suspend state, with unrecoverable resume.

The first patch of the series provides a workaround to ensure the
virtually attached devices do not enter suspend.  Note this is currently
limited to the client side (vhci_hcd) only, since the server side
(usbip_host) doesn't implement system suspend prevention.

IMPORTANT:

Please note commit aa7a9275ab81 ("PM: sleep: Suspend async parents after
suspending children") from v6.16-rc1 introduced a regression which
breaks the suspend cancellation and hangs the system.

A fix [1] has been already provided, which also landed soon after in
v6.16-rc7 under commit ebd6884167ea ("PM: sleep: Update power.completion
for all devices on errors").

[1] https://lore.kernel.org/all/6191258.lOV4Wx5bFT@rjwysocki.net/
---
Changes in v3:
- Moved all driver cleanup patches to a separate series:
  https://lore.kernel.org/all/20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com/
- Replaced FIXME with NOTE in the new comment block, as it refers to a
  potential cleanup of redundant code rather than addressing a
  functional issue
- Rebased remaining patch onto next-20250902
- Link to v2: https://lore.kernel.org/r/20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com

Changes in v2:
- Updated cover letter to indicate the PM core fix has landed in
  v6.16-rc7
- Also made it clear that the patch fixing up suspend prevention only
  applies to the client side (vhci_hcd), since the server side
  (usbip_host) doesn't implement this functionality
- Documented the usage of dev_pm_syscore_device() in vhci_urb_enqueue()
- Reworked most of the cleanup patches according to the feedback
  received from Greg
- Link to v1: https://lore.kernel.org/r/20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com
---
 drivers/usb/usbip/vhci_hcd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index e70fba9f55d6a0edf3c5fde56a614dd3799406a1..0d6c10a8490c0b3fdbebbc98c856a6c0c9b477cf 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -765,6 +765,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 				 ctrlreq->wValue, vdev->rhport);
 
 			vdev->udev = usb_get_dev(urb->dev);
+			/*
+			 * NOTE: A similar operation has been done via
+			 * USB_REQ_GET_DESCRIPTOR handler below, which is
+			 * supposed to always precede USB_REQ_SET_ADDRESS.
+			 *
+			 * It's not entirely clear if operating on a different
+			 * usb_device instance here is a real possibility,
+			 * otherwise this call and vdev->udev assignment above
+			 * should be dropped.
+			 */
+			dev_pm_syscore_device(&vdev->udev->dev, true);
 			usb_put_dev(old);
 
 			spin_lock(&vdev->ud.lock);
@@ -785,6 +796,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
 			vdev->udev = usb_get_dev(urb->dev);
+			/*
+			 * Set syscore PM flag for the virtually attached
+			 * devices to ensure they will not enter suspend on
+			 * the client side.
+			 *
+			 * Note this doesn't have any impact on the physical
+			 * devices attached to the host system on the server
+			 * side, hence there is no need to undo the operation
+			 * on disconnect.
+			 */
+			dev_pm_syscore_device(&vdev->udev->dev, true);
 			usb_put_dev(old);
 			goto out;
 

---
base-commit: 3db46a82d467bd23d9ebc473d872a865785299d8
change-id: 20250714-vhci-hcd-suspend-fix-7db5c25c509d


