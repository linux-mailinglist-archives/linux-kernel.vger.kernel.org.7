Return-Path: <linux-kernel+bounces-796326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07BB3FFDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439185E2561
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A22FDC4C;
	Tue,  2 Sep 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AQmGgcJ5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EF2FB63B;
	Tue,  2 Sep 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814223; cv=none; b=Nq30TNEMnol6891lzBU4YOPQZI1NS5iVSxkV5gM0i+vSFQctoBR/bizFEe/HNe9sIgEPyBLCLg7LBq2YNk2Lk4AwrRv+oa/ihryVU4M5ximkTJz+WEahAVGlW02rKYUpmXO2PNNYY0b5+nbvOvOIOF99lPAJW2MnrDLR9XpdNf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814223; c=relaxed/simple;
	bh=glTRrjp+/FRRCOkugN8uzqNZNuDKxREHCpq1x3UrJZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3uP//hwB/2u3d6WmvHYXUOC9RG5Qw4vUDGJbBFVn2Q8YzPYS+nwph+j0uowB6MQkIQet1OVXNQHTkzQF4qP9B2jq7pu0D5+/LXxcIG0e78X69oVTJhBtqtUr6845co0Vw1Mqd8YYL4/PV2ezJlbCRsT+C5AKLXczhqVUjlG41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AQmGgcJ5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814219;
	bh=glTRrjp+/FRRCOkugN8uzqNZNuDKxREHCpq1x3UrJZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AQmGgcJ5OOFlFQaJRgmACxdfmi8b9gVoTJ/MWVpv9KiABrtqkRc3qvFtMm+SG1lbu
	 b6nToApUYjRqVi/CJJxR3Dz56lCqH3uD2Eq4XMNPgTm3DXrvpciAhV+9GviWN6OsD3
	 7qZpLR2SXcY6EcKGk6kL8OHD7XlivGyDgC80Tz2PCPOl/POzWDrl4nPq1qICJHrqwx
	 R3qwaQSuQz/GhQzKgb7ypo1v7zyOIoq6grlCWl3qoZMZ6MzMz5NG1AkxFbizEO7xd9
	 g4KG3idQ/RaR6cOsT4aMWCCzGZLmlaHRBqVFVu1mHBBZLp9j+5I2FHb2z2FpsKK0FU
	 IunMFL6WIFVzA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3D8AC17E1333;
	Tue,  2 Sep 2025 13:56:59 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:26 +0300
Subject: [PATCH 04/17] usb: vhci-hcd: Consistently use blank lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-4-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
index 8b8012440f66f97c34ffc39d1a927b74f035ac91..59478e8f6c97ac4dad0aaa887df3d169c13aee27 100644
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
@@ -789,7 +800,6 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 			ret =  -EINVAL;
 			goto no_need_xmit;
 		}
-
 	}
 
 out:
@@ -810,6 +820,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		usb_hcd_giveback_urb(hcd, urb, urb->status);
 		local_irq_enable();
 	}
+
 	return ret;
 }
 
@@ -1200,12 +1211,14 @@ static int vhci_start(struct usb_hcd *hcd)
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
 
@@ -1267,10 +1280,12 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
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
@@ -1343,6 +1358,7 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 		pr_err("create primary hcd failed\n");
 		return -ENOMEM;
 	}
+
 	hcd_hs->has_tt = 1;
 
 	/*
@@ -1458,6 +1474,7 @@ static int vhci_hcd_resume(struct platform_device *pdev)
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;
+
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	usb_hcd_poll_rh_status(hcd);
 
@@ -1489,6 +1506,7 @@ static void del_platform_devices(void)
 		platform_device_unregister(vhcis[i].pdev);
 		vhcis[i].pdev = NULL;
 	}
+
 	sysfs_remove_link(&platform_bus.kobj, driver_name);
 }
 

-- 
2.51.0


