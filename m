Return-Path: <linux-kernel+bounces-746427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85901B12693
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D29189A852
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153E26B2A3;
	Fri, 25 Jul 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NEuanHl/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE325F784;
	Fri, 25 Jul 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481306; cv=none; b=YAIJkFi9W3ZEX20xJ+SdojzJ+3YwOUP+LNOBrlbEAjWOTnmACdOVRZWpgUrq8m0w+og5ib8s3oWNMii7UZpyr5C/uPkb26Vy2HqslgQ5jDvj6+tzFsK68j7SSWFKfMz7YjFzbSrpPpxBnyZosm0cNITKQTkU8fbLshzOW3MAK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481306; c=relaxed/simple;
	bh=ceeGJ8INo1YLVGOsGFHsCuJY/T33PhKEQyNnPbdXE+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJulv27c1x5E9PN0bVdXh41kZXmsgAEvPgtlkJzZx1sVFxUCKGPGKb9/YqR078r1r4sGCnGUEcK+et5ztwqc3K4qNgYoJKvV2m7X2XucW4ZwPaCKAVRw/HsKR9AXvrwCvDWjmspGmRBfSNv5pRnrVLSz+ITDqWJ78+UK19SoPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NEuanHl/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481302;
	bh=ceeGJ8INo1YLVGOsGFHsCuJY/T33PhKEQyNnPbdXE+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NEuanHl/mPfJX+/h8vzEldp5fihgJyOQknUUvaDnv/4aLTZ9mgP0tUzhbyAwiWQk+
	 C0fgQbkslnPSxwisUw6kGqTKJ0fdn1PLm8xPgYMx7lME43qu2Lmt5Q6S3xxMmGyU5N
	 WHLUoi8W3fviuTmXuIMXHHOYOlvYoJkB9OKVzH60wntT/dPuv6nktTfSgn56X/N/uN
	 VTbvUgC9+neAQ12s8mIO4ZnT5/8ImKplRYfKit5nBPFcTVP1pmWPvT+mwXzTJlABqZ
	 5644Q1GZkfVJ/MX+GWW72srYbE5pL7/MHz6RGROVP0gCLOCtUq9Ef0fFygBlCBeEu0
	 8wHNn6Kuy9o+w==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 85F2A17E1324;
	Sat, 26 Jul 2025 00:08:22 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:07 +0300
Subject: [PATCH v2 05/18] usb: vhci-hcd: Consistently use blank lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-5-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add blank lines where it helps improve code readability and drop those
which are really not required, as indicated by checkpatch:

  CHECK: Blank lines aren't necessary after an open brace '{'
  CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index cace9bbbd528602703869cf955f93b311fddd045..c739107a3e0411ba2e8227ea6db46802b4882177 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -145,6 +145,7 @@ static void dump_port_status_diff(u32 prev_status, u32 new_status, bool usb3)
 			if (bit == 1) /* USB_PORT_STAT_CONNECTION */
 				pr_debug(" %c%s\n", change, "USB_PORT_STAT_SPEED_5GBPS");
 		}
+
 		bit <<= 1;
 		i++;
 	}
@@ -267,7 +268,6 @@ static struct {
 	struct usb_bos_descriptor bos;
 	struct usb_ss_cap_descriptor ss_cap;
 } __packed usb3_bos_desc = {
-
 	.bos = {
 		.bLength		= USB_DT_BOS_SIZE,
 		.bDescriptorType	= USB_DT_BOS,
@@ -306,6 +306,7 @@ static inline void hub_descriptor(struct usb_hub_descriptor *desc)
 						HUB_CHAR_COMMON_OCPM);
 	desc->bNbrPorts = VHCI_HC_PORTS;
 	BUILD_BUG_ON(VHCI_HC_PORTS > USB_MAXCHILDREN);
+
 	width = desc->bNbrPorts / 8 + 1;
 	desc->bDescLength = USB_DT_HUB_NONVAR_SIZE + 2 * width;
 	memset(&desc->u.hs.DeviceRemovable[0], 0, width);
@@ -371,6 +372,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			pr_err("invalid port number %d\n", wIndex);
 			goto error;
 		}
+
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed >= HCD_USB3) {
@@ -398,6 +400,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					  wValue);
 			if (wValue >= 32)
 				goto error;
+
 			vhci_hcd->port_status[rhport] &= ~(1 << wValue);
 			break;
 		}
@@ -410,6 +413,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			pr_err("Wrong hub descriptor type for USB 3.0 roothub.\n");
 			goto error;
 		}
+
 		if (hcd->speed >= HCD_USB3)
 			ss_hub_descriptor((struct usb_hub_descriptor *) buf);
 		else
@@ -506,6 +510,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				       "supported for USB 2.0 roothub\n");
 				goto error;
 			}
+
 			/*
 			 * Since this is dummy we don't have an actual link so
 			 * there is nothing to do for the SET_LINK_STATE cmd
@@ -545,6 +550,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			if (hcd->speed >= HCD_USB3)
 				vhci_hcd->port_status[rhport] |= USB_SS_PORT_STAT_POWER;
 			else
@@ -556,6 +562,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed < HCD_USB3) {
 				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
@@ -569,6 +576,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			/* if it's already enabled, disable */
 			if (hcd->speed >= HCD_USB3) {
 				vhci_hcd->port_status[rhport] = 0;
@@ -592,8 +600,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			if (wValue >= 32)
 				goto error;
+
 			if (hcd->speed >= HCD_USB3) {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_SS_PORT_STAT_POWER) != 0) {
@@ -722,6 +732,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		spin_unlock_irqrestore(&vhci->lock, flags);
 		return -ENODEV;
 	}
+
 	spin_unlock(&vdev->ud.lock);
 
 	ret = usb_hcd_link_urb_to_ep(hcd, urb);
@@ -811,7 +822,6 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 			ret =  -EINVAL;
 			goto no_need_xmit;
 		}
-
 	}
 
 out:
@@ -832,6 +842,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		usb_hcd_giveback_urb(hcd, urb, urb->status);
 		local_irq_enable();
 	}
+
 	return ret;
 }
 
@@ -1222,12 +1233,14 @@ static int vhci_start(struct usb_hcd *hcd)
 			dev_err(hcd_dev(hcd), "init attr group failed, err = %d\n", err);
 			return err;
 		}
+
 		err = sysfs_create_group(&hcd_dev(hcd)->kobj, &vhci_attr_group);
 		if (err) {
 			dev_err(hcd_dev(hcd), "create sysfs files failed, err = %d\n", err);
 			vhci_finish_attr_group();
 			return err;
 		}
+
 		pr_info("created sysfs %s\n", hcd_name(hcd));
 	}
 
@@ -1289,10 +1302,12 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
 
 	spin_lock_irqsave(&vhci->lock, flags);
+
 	if (!HCD_HW_ACCESSIBLE(hcd))
 		rc = -ESHUTDOWN;
 	else
 		hcd->state = HC_STATE_RUNNING;
+
 	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return rc;
@@ -1365,6 +1380,7 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 		pr_err("create primary hcd failed\n");
 		return -ENOMEM;
 	}
+
 	hcd_hs->has_tt = 1;
 
 	/*
@@ -1480,6 +1496,7 @@ static int vhci_hcd_resume(struct platform_device *pdev)
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;
+
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	usb_hcd_poll_rh_status(hcd);
 
@@ -1511,6 +1528,7 @@ static void del_platform_devices(void)
 		platform_device_unregister(vhcis[i].pdev);
 		vhcis[i].pdev = NULL;
 	}
+
 	sysfs_remove_link(&platform_bus.kobj, driver_name);
 }
 

-- 
2.50.0


