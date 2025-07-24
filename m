Return-Path: <linux-kernel+bounces-743581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACEDB10077
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D5C581FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB58214811;
	Thu, 24 Jul 2025 06:22:56 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297E2066CE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338175; cv=none; b=E/Y81d6UFg/4lfGIPMVGMO2yv+3AzFzQmHb7Q5TYZHJjjH2B+k9Rk5ixy/cUMylddKb7v+WruzA5CnfUTyL5gQ30QDEXUtrtsPpwa9xJ1W0u0sU/XGiolMl4LMv80T1yA0XVVrKYiqCxx7FoZ9ZgYH8Yu7Vsfmm5nYOS2G4n1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338175; c=relaxed/simple;
	bh=IcEd3WkrPF84aiN5M5DUjh072ks6nViG+PxhPryZJE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2WV+iUQXmRJlC0eC3C9Rc66hZzQ+8SBKfg3HwRbvCGRK+gb6MRWiP0gEqdF1FzyPP3AQMCfSpXny9UoTUGpEHhTb1e4J8q1bEiGCCp4/MJ3kWBxNqluR/m/P3QbXIIqj1gkkAZhOCbkAT7mZMsYsAsi8bzpVyIYK0FmFeyePxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1753337382-086e23295512400001-xx1T2L
Received: from ZXBJMBX03.zhaoxin.com (ZXBJMBX03.zhaoxin.com [10.29.252.7]) by mx1.zhaoxin.com with ESMTP id BRh9SVAz6OnGwVGE (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 24 Jul 2025 14:09:42 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 24 Jul
 2025 14:09:41 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f]) by
 ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f%7]) with mapi id
 15.01.2507.044; Thu, 24 Jul 2025 14:09:41 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from L440.Zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 24 Jul
 2025 12:40:12 +0800
From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
To: <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <WeitaoWang@zhaoxin.com>, <wwt8723@163.com>, <CobeChen@zhaoxin.com>
Subject: [PATCH] usb:xhci:Fix slot_id resource race conflict
Date: Thu, 24 Jul 2025 20:40:12 +0800
X-ASG-Orig-Subj: [PATCH] usb:xhci:Fix slot_id resource race conflict
Message-ID: <20250724124012.296934-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 7/24/2025 2:09:40 PM
X-Barracuda-Connect: ZXBJMBX03.zhaoxin.com[10.29.252.7]
X-Barracuda-Start-Time: 1753337382
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5683
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.144738
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

In such a scenario, device-A with slot_id equal to 1 is disconnecting
while device-B is enumerating, device-B will fail to enumerate in the
follow sequence.

1.[device-A] send disable slot command
2.[device-B] send enable slot command
3.[device-A] disable slot command completed and wakeup waiting thread
4.[device-B] enable slot command completed with slot_id equal to 1 and
wakeup waiting thread
5.[device-B] driver check this slot_id was used by someone(device-A) in
xhci_alloc_virt_device, this device fails to enumerate as this conflict
6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device

To fix drivers slot_id resources conflict, let the xhci_free_virt_device
function call in the interrupt handler when disable slot command success.

Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and hos=
t runtime suspend")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/host/xhci-hub.c  |  5 +++--
 drivers/usb/host/xhci-ring.c |  7 +++++--
 drivers/usb/host/xhci.c      | 29 ++++++++++++++++++++++-------
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 92bb84f8132a..fd8a64aa5779 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -705,10 +705,11 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci=
,
 			continue;
=20
 		retval =3D xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
-		if (retval)
+		if (retval) {
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n=
",
 				 i, retval);
+			xhci_free_virt_device(xhci, i);
+		}
 	}
 	spin_lock_irqsave(&xhci->lock, *flags);
 	/* Put all ports to the Disable state by clear PP */
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 94c9c9271658..93dc28399c3c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1589,7 +1589,8 @@ static void xhci_handle_cmd_enable_slot(int slot_id, =
struct xhci_command *comman
 		command->slot_id =3D 0;
 }
=20
-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_i=
d)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_i=
d,
+					u32 cmd_comp_code)
 {
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
@@ -1604,6 +1605,8 @@ static void xhci_handle_cmd_disable_slot(struct xhci_=
hcd *xhci, int slot_id)
 	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
 		/* Delete default control endpoint resources */
 		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code =3D=3D COMP_SUCCESS)
+		xhci_free_virt_device(xhci, slot_id);
 }
=20
 static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id)
@@ -1853,7 +1856,7 @@ static void handle_cmd_completion(struct xhci_hcd *xh=
ci,
 		xhci_handle_cmd_enable_slot(slot_id, cmd, cmd_comp_code);
 		break;
 	case TRB_DISABLE_SLOT:
-		xhci_handle_cmd_disable_slot(xhci, slot_id);
+		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
 		break;
 	case TRB_CONFIG_EP:
 		if (!cmd->completion)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 8a819e853288..4d219418f9e1 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3931,13 +3931,14 @@ static int xhci_discover_or_reset_device(struct usb=
_hcd *hcd,
 		 * the USB device has been reset.
 		 */
 		ret =3D xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
 		if (!ret) {
 			ret =3D xhci_alloc_dev(hcd, udev);
 			if (ret =3D=3D 1)
 				ret =3D 0;
 			else
 				ret =3D -EINVAL;
+		} else {
+			xhci_free_virt_device(xhci, udev->slot_id);
 		}
 		return ret;
 	}
@@ -4085,10 +4086,11 @@ static void xhci_free_dev(struct usb_hcd *hcd, stru=
ct usb_device *udev)
 	for (i =3D 0; i < 31; i++)
 		virt_dev->eps[i].ep_state &=3D ~EP_STOP_CMD_PENDING;
 	virt_dev->udev =3D NULL;
-	xhci_disable_slot(xhci, udev->slot_id);
+	ret =3D xhci_disable_slot(xhci, udev->slot_id);
=20
 	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	if (ret)
+		xhci_free_virt_device(xhci, udev->slot_id);
 	spin_unlock_irqrestore(&xhci->lock, flags);
=20
 }
@@ -4128,9 +4130,20 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slo=
t_id)
=20
 	wait_for_completion(command->completion);
=20
-	if (command->status !=3D COMP_SUCCESS)
+	if (command->status !=3D COMP_SUCCESS) {
 		xhci_warn(xhci, "Unsuccessful disable slot %u command, status %d\n",
 			  slot_id, command->status);
+		switch (command->status) {
+		case COMP_COMMAND_ABORTED:
+		case COMP_COMMAND_RING_STOPPED:
+			xhci_warn(xhci, "Timeout while waiting for disable slot command\n");
+			ret =3D -ETIME;
+			break;
+		default:
+			ret =3D -EINVAL;
+			break;
+		}
+	}
=20
 	xhci_free_command(xhci, command);
=20
@@ -4243,8 +4256,9 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_de=
vice *udev)
 	return 1;
=20
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	ret =3D xhci_disable_slot(xhci, udev->slot_id);
+	if (ret)
+		xhci_free_virt_device(xhci, udev->slot_id);
=20
 	return 0;
 }
@@ -4381,10 +4395,11 @@ static int xhci_setup_device(struct usb_hcd *hcd, s=
truct usb_device *udev,
=20
 		mutex_unlock(&xhci->mutex);
 		ret =3D xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
 		if (!ret) {
 			if (xhci_alloc_dev(hcd, udev) =3D=3D 1)
 				xhci_setup_addressable_virt_dev(xhci, udev);
+		} else {
+			xhci_free_virt_device(xhci, udev->slot_id);
 		}
 		kfree(command->completion);
 		kfree(command);
--=20
2.32.0


