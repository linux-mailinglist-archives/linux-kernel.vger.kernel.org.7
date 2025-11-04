Return-Path: <linux-kernel+bounces-884675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D333C30C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6218F426260
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929102EBDC8;
	Tue,  4 Nov 2025 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/sNhBN3"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9E2E9EA0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255981; cv=none; b=iOqf0YWxCtUPFiywpqpdYWPQsSUnPLsVGR/eoOW1JFGvcdCXYQHqcgWzspjMSGzL1gfbGxyECrjW7jI9d+Au4zgHFcCJUYB7d+EJ3a0DQiUMREx5iCnA08O0y+S2lmghyub0kgGufSzysHkhPqzZiJNlQZ9ohO4hhvBzHNhIRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255981; c=relaxed/simple;
	bh=awdUCLb638duOsloxz8F9nYD6abSXejtgV2z/HFImZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOpTfPfuXzrjd9ZCkZwWhMQQeFgRElkOtv1xUMd32DRvnnMJub9NwHm1qCladu0He/NKXDPxJY2JGMYBY+KbK7zsxsLeLdAV7lSkPyrDTh0KafaLQM+vdGTUup9cBW9LeXR4lIzdT469s1BkIAJJNFUJh3Tiii5nTKQCrKO5PbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/sNhBN3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso430038a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255977; x=1762860777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d+YJijRpL8w9LCQNHN0V7As8Dqz/jO5NzA/qgZx3ko=;
        b=H/sNhBN3h34oAQdiKJH13bFNujfVrrLS8qHwGdsExgP/WlO+RrJesTIzvC9aL6Dfdl
         YpDFvsoMGIxiQ6KKw3QD4QgH77refqTaKD6KGh4ov14fHhec0GvOmWLwmL3/d/UGbhZV
         h1Sgo2P2JxGiKJpxh9dSKV7S4ZgwRv41Z4na8H3clerS7EePZCSyDRLzEaSNMiwUYS6C
         ipRMNMMDVHYIXnRnXFTsBVe7U78AK6x32kcbH53TzS3eU+/p1j5VODJnGIYv9SmRoNje
         koCwwNV46hLVXxjt+OpdX+JVb3C0oAJov+uFP4nta+BPVODKcNSVeurp/ExI9K1h3AMi
         L0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255977; x=1762860777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3d+YJijRpL8w9LCQNHN0V7As8Dqz/jO5NzA/qgZx3ko=;
        b=r3Rhqwrg8voc89D6kOSg6ZG+4X+6n9hINxOBuABvCXiJMfNSs6v8ZnUsVzh48X6HK7
         OK18GBh50kGgjKQ3UxuvjWdySC7fYfeB5S7pyENHkAlRk7pBp8lnUHi6zS+PKixGTY7y
         cr4dSY/F2ORWtd9Z6z1PB8CXlLmVfEAfysGobRptPZ6inS6edwknozdBev2NLeQGdF3/
         s8KB7c7hxACEKBF6KX94d8rSDbaOE4g41M1TPQif/t5wvVDkUlvdz6WaH52RfUC0M2u+
         BoqwRlLOQUEhxoWj9D47PxvXfGkvouwGCBE/zXNAJlq0TeARUEPJuUBtX/mn53PsMBXH
         mVeg==
X-Forwarded-Encrypted: i=1; AJvYcCWl6TC6z7hA06ZvF1YIhW250p9Hn9EgXsRo8Y4SZ5VN2UpdL/rMThlaTEdLMP9NuES9w8EYWtEtLYfJuK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwxDHItXNRBCNE/Uz+scWXLpCZu4cck1Z7eOn6x9FYoTL0oNg
	relVKE+w2Q+O4ELrt3deKKTLYXK7d6rJuvE3p6kEhlrwNJsn3YVMj3FM
X-Gm-Gg: ASbGncsBIxF+eLci2o/Ml7ypJmYMh9lfjJE0aieJuypu3YCOKCqaf4LMXs9cgJy6IGO
	NQ5/2p4+XOyZiR9AEkVRgevnNTKUi966ajVXtNUL0+kmaoY8y2G0TAtOZS6YwAyg6ykmdJ4Cps7
	gEskwuRiJ9QtCQx+KEEsYajP8lKGXPEgiGfA6mbx1NHOJtZwBYw4EcYNI/8KuIsW56NPM2fv12s
	WnDWpX8ZzeYxxI2PVx5uFm9w6apIicT0PBrwxcWo4mEDO2zWSpkbp5L7va4Nlw1xNscx0UB3ZIs
	c+L+6PQ0K+pt64koUMyULOw5Hy3Uw3CHY5o0RlRnOCzDqlo8Ti90CZKTlZ1un/GB58076SMoywo
	ldOWt0ODLBHIR0RwogpSHTfY1W802Ga0i9NB9DAW718UPJ3Sxg2d6reGSC656eY5PQ/EnqRqZ9l
	uISy+Sc0Lt6sB+iQ6LnZIRD7Bqh8NmZ2hksO6udovEnInFS9aYCFqDGnDoRaXZdA==
X-Google-Smtp-Source: AGHT+IHJelObIKzSQ1BbonnrHT1wYm4ffG4m1pg0tzoVEBs/baKPVWM3+Ur8xp6eb6w940PKIGOAWg==
X-Received: by 2002:a17:906:730a:b0:b41:b0c4:e74c with SMTP id a640c23a62f3a-b70704b27d3mr1745393866b.33.1762255977438;
        Tue, 04 Nov 2025 03:32:57 -0800 (PST)
Received: from jale-pg.. ([2a02:2a40:17ee:2900:8627:17a2:2166:4084])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72404470e9sm182469766b.70.2025.11.04.03.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:32:56 -0800 (PST)
From: Jakub Lecki <lec.jakub@gmail.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Lecki <lec.jakub@gmail.com>
Subject: [PATCH 2/3] usbip: Convert CONFIG_USBIP_VHCI_HC_PORTS to a module parameter.
Date: Tue,  4 Nov 2025 12:32:47 +0100
Message-ID: <20251104113248.223594-3-lec.jakub@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104113248.223594-1-lec.jakub@gmail.com>
References: <20251104113248.223594-1-lec.jakub@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In workflows involving a greater number of remote
USB/IP devices, the default number of available virtual ports may be
insufficient, forcing user to recompile the module with greater number
of configured virtual host controllers and/or number of ports.

Allow a user to configure the number of ports per USB/IP virtual host
controller via a new 'hc_ports' module parameter to simplify the usage
of this module.

- Remove the USBIP_VHCI_HC_PORTS Kconfig option and replace it with a
  module parameter.
- Fix the omitted BUILD_BUG_ON check for the upper limit of
  'vhci_hc_ports' when switching from USB_MAXCHILDREN to
  USB_SS_MAXPORTS.
- Resize related arrays to match VHCI_MAX_HC_PORTS = USB_SS_MAXPORTS to
  support a dynamically configurable number of ports.
- Trim the value of the configured 'hc_ports' parameter if it
  exceeds bounds, and emit a warning.

Signed-off-by: Jakub Lecki <lec.jakub@gmail.com>
---
 drivers/usb/usbip/Kconfig      | 10 --------
 drivers/usb/usbip/vhci.h       | 22 ++++++++---------
 drivers/usb/usbip/vhci_hcd.c   | 43 +++++++++++++++++++++++-----------
 drivers/usb/usbip/vhci_sysfs.c | 18 +++++++-------
 4 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/usbip/Kconfig b/drivers/usb/usbip/Kconfig
index bdcb6f4fdbec..e178867fb5ef 100644
--- a/drivers/usb/usbip/Kconfig
+++ b/drivers/usb/usbip/Kconfig
@@ -28,16 +28,6 @@ config USBIP_VHCI_HCD
 	  To compile this driver as a module, choose M here: the
 	  module will be called vhci-hcd.
 
-config USBIP_VHCI_HC_PORTS
-	int "Number of ports per USB/IP virtual host controller"
-	range 1 15
-	default 8
-	depends on USBIP_VHCI_HCD
-	help
-	  To increase number of ports available for USB/IP virtual
-	  host controller driver, this defines number of ports per
-	  USB/IP virtual host controller.
-
 config USBIP_HOST
 	tristate "Host driver"
 	depends on USBIP_CORE && USB
diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
index 30b8540e0b49..2772d923a8cb 100644
--- a/drivers/usb/usbip/vhci.h
+++ b/drivers/usb/usbip/vhci.h
@@ -72,15 +72,9 @@ enum hub_speed {
 	HUB_SPEED_SUPER,
 };
 
-/* Number of supported ports. Value has an upperbound of USB_MAXCHILDREN */
-#ifdef CONFIG_USBIP_VHCI_HC_PORTS
-#define VHCI_HC_PORTS CONFIG_USBIP_VHCI_HC_PORTS
-#else
-#define VHCI_HC_PORTS 8
-#endif
-
-/* Each VHCI has 2 hubs (USB2 and USB3), each has VHCI_HC_PORTS ports */
-#define VHCI_PORTS	(VHCI_HC_PORTS*2)
+/* Number of supported ports. Value has an upperbound of USB_SS_MAXPORTS */
+#define VHCI_DEFAULT_HC_PORTS 8
+#define VHCI_MAX_HC_PORTS USB_SS_MAXPORTS
 
 #define VHCI_DEFAULT_NR_HCS 1
 #define VHCI_MAX_NR_HCS 128
@@ -100,7 +94,7 @@ struct vhci {
 struct vhci_hcd {
 	struct vhci *vhci;
 
-	u32 port_status[VHCI_HC_PORTS];
+	u32 port_status[VHCI_MAX_HC_PORTS];
 
 	unsigned resuming:1;
 	unsigned long re_timeout;
@@ -112,13 +106,17 @@ struct vhci_hcd {
 	 * wIndex shows the port number and begins from 1.
 	 * But, the index of this array begins from 0.
 	 */
-	struct vhci_device vdev[VHCI_HC_PORTS];
+	struct vhci_device vdev[VHCI_MAX_HC_PORTS];
 };
 
 extern unsigned int vhci_num_controllers;
+extern unsigned int vhci_hc_ports;
 extern struct vhci *vhcis;
 extern struct attribute_group vhci_attr_group;
 
+/* Each VHCI has 2 hubs (USB2 and USB3), each has vhci_hc_ports ports */
+#define VHCI_PORTS	(vhci_hc_ports * 2)
+
 /* vhci_hcd.c */
 void rh_port_connect(struct vhci_device *vdev, enum usb_device_speed speed);
 
@@ -135,7 +133,7 @@ int vhci_tx_loop(void *data);
 
 static inline __u32 port_to_rhport(__u32 port)
 {
-	return port % VHCI_HC_PORTS;
+	return port % vhci_hc_ports;
 }
 
 static inline int port_to_pdev_nr(__u32 port)
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 93c3fa3e1c53..1989a6f59107 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -51,6 +51,12 @@ MODULE_PARM_DESC(num_controllers, "Number of USB/IP virtual host controllers (ra
 		 __MODULE_STRING(VHCI_MAX_NR_HCS) ", default: "
 		 __MODULE_STRING(VHCI_DEFAULT_NR_HCS) ")");
 
+unsigned int vhci_hc_ports = VHCI_DEFAULT_HC_PORTS;
+module_param_named(hc_ports, vhci_hc_ports, uint, 0444);
+MODULE_PARM_DESC(hc_ports, "Number of ports per USB/IP virtual host controller (range: 1-"
+		 __MODULE_STRING(VHCI_MAX_HC_PORTS) ", default: "
+		 __MODULE_STRING(VHCI_DEFAULT_HC_PORTS) ")");
+
 struct vhci *vhcis;
 
 static const char * const bit_desc[] = {
@@ -236,7 +242,7 @@ static int vhci_hub_status(struct usb_hcd *hcd, char *buf)
 {
 	struct vhci_hcd	*vhci_hcd = hcd_to_vhci_hcd(hcd);
 	struct vhci *vhci = vhci_hcd->vhci;
-	int		retval = DIV_ROUND_UP(VHCI_HC_PORTS + 1, 8);
+	int		retval = DIV_ROUND_UP(vhci_hc_ports + 1, 8);
 	int		rhport;
 	int		changed = 0;
 	unsigned long	flags;
@@ -250,7 +256,7 @@ static int vhci_hub_status(struct usb_hcd *hcd, char *buf)
 	}
 
 	/* check pseudo status register for each port */
-	for (rhport = 0; rhport < VHCI_HC_PORTS; rhport++) {
+	for (rhport = 0; rhport < vhci_hc_ports; rhport++) {
 		if ((vhci_hcd->port_status[rhport] & PORT_C_MASK)) {
 			/* The status of a port has been changed, */
 			usbip_dbg_vhci_rh("port %d status changed\n", rhport);
@@ -297,7 +303,7 @@ ss_hub_descriptor(struct usb_hub_descriptor *desc)
 	desc->bDescLength = 12;
 	desc->wHubCharacteristics = cpu_to_le16(
 		HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_COMMON_OCPM);
-	desc->bNbrPorts = VHCI_HC_PORTS;
+	desc->bNbrPorts = vhci_hc_ports;
 	desc->u.ss.bHubHdrDecLat = 0x04; /* Worst case: 0.4 micro sec*/
 	desc->u.ss.DeviceRemovable = 0xffff;
 }
@@ -311,8 +317,7 @@ static inline void hub_descriptor(struct usb_hub_descriptor *desc)
 	desc->wHubCharacteristics = cpu_to_le16(
 		HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_COMMON_OCPM);
 
-	desc->bNbrPorts = VHCI_HC_PORTS;
-	BUILD_BUG_ON(VHCI_HC_PORTS > USB_MAXCHILDREN);
+	desc->bNbrPorts = vhci_hc_ports;
 	width = desc->bNbrPorts / 8 + 1;
 	desc->bDescLength = USB_DT_HUB_NONVAR_SIZE + 2 * width;
 	memset(&desc->u.hs.DeviceRemovable[0], 0, width);
@@ -329,7 +334,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	unsigned long	flags;
 	bool invalid_rhport = false;
 
-	u32 prev_port_status[VHCI_HC_PORTS];
+	u32 prev_port_status[VHCI_MAX_HC_PORTS];
 
 	if (!HCD_HW_ACCESSIBLE(hcd))
 		return -ETIMEDOUT;
@@ -344,17 +349,18 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 	/*
 	 * wIndex can be 0 for some request types (typeReq). rhport is
-	 * in valid range when wIndex >= 1 and < VHCI_HC_PORTS.
+	 * in valid range when wIndex >= 1 and < vhci_hc_ports.
 	 *
 	 * Reference port_status[] only with valid rhport when
 	 * invalid_rhport is false.
 	 */
-	if (wIndex < 1 || wIndex > VHCI_HC_PORTS) {
+	if (wIndex < 1 || wIndex > vhci_hc_ports) {
 		invalid_rhport = true;
-		if (wIndex > VHCI_HC_PORTS)
+		if (wIndex > vhci_hc_ports)
 			pr_err("invalid port number %d\n", wIndex);
-	} else
+	} else {
 		rhport = wIndex - 1;
+	}
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
@@ -707,7 +713,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	struct vhci_device *vdev;
 	unsigned long flags;
 
-	if (portnum > VHCI_HC_PORTS) {
+	if (portnum > vhci_hc_ports) {
 		pr_err("invalid port number %d\n", portnum);
 		return -ENODEV;
 	}
@@ -1188,7 +1194,7 @@ static int vhci_start(struct usb_hcd *hcd)
 
 	/* initialize private data of usb_hcd */
 
-	for (rhport = 0; rhport < VHCI_HC_PORTS; rhport++) {
+	for (rhport = 0; rhport < vhci_hc_ports; rhport++) {
 		struct vhci_device *vdev = &vhci_hcd->vdev[rhport];
 
 		vhci_device_init(vdev);
@@ -1244,7 +1250,7 @@ static void vhci_stop(struct usb_hcd *hcd)
 	}
 
 	/* 2. shutdown all the ports of vhci_hcd */
-	for (rhport = 0; rhport < VHCI_HC_PORTS; rhport++) {
+	for (rhport = 0; rhport < vhci_hc_ports; rhport++) {
 		struct vhci_device *vdev = &vhci_hcd->vdev[rhport];
 
 		usbip_event_add(&vdev->ud, VDEV_EVENT_REMOVED);
@@ -1441,7 +1447,7 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
-	for (rhport = 0; rhport < VHCI_HC_PORTS; rhport++) {
+	for (rhport = 0; rhport < vhci_hc_ports; rhport++) {
 		if (vhci->vhci_hcd_hs->port_status[rhport] &
 		    USB_PORT_STAT_CONNECTION)
 			connected += 1;
@@ -1525,6 +1531,15 @@ static int __init vhci_hcd_init(void)
 		vhci_num_controllers = VHCI_MAX_NR_HCS;
 	}
 
+	if (vhci_hc_ports < 1) {
+		pr_warn("hc_ports less than 1, setting to 1\n");
+		vhci_hc_ports = 1;
+	} else if (vhci_hc_ports > VHCI_MAX_HC_PORTS) {
+		pr_warn("hc_ports too high, limiting to %d\n",
+			VHCI_MAX_HC_PORTS);
+		vhci_hc_ports = VHCI_MAX_HC_PORTS;
+	}
+
 	vhcis = kcalloc(vhci_num_controllers, sizeof(struct vhci), GFP_KERNEL);
 	if (vhcis == NULL)
 		return -ENOMEM;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index d5865460e82d..19d67717180e 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -81,7 +81,7 @@ static ssize_t status_show_vhci(int pdev_nr, char *out)
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
-	for (i = 0; i < VHCI_HC_PORTS; i++) {
+	for (i = 0; i < vhci_hc_ports; i++) {
 		struct vhci_device *vdev = &vhci->vhci_hcd_hs->vdev[i];
 
 		spin_lock(&vdev->ud.lock);
@@ -90,12 +90,12 @@ static ssize_t status_show_vhci(int pdev_nr, char *out)
 		spin_unlock(&vdev->ud.lock);
 	}
 
-	for (i = 0; i < VHCI_HC_PORTS; i++) {
+	for (i = 0; i < vhci_hc_ports; i++) {
 		struct vhci_device *vdev = &vhci->vhci_hcd_ss->vdev[i];
 
 		spin_lock(&vdev->ud.lock);
 		port_show_vhci(&out, HUB_SPEED_SUPER,
-			       pdev_nr * VHCI_PORTS + VHCI_HC_PORTS + i, vdev);
+			       pdev_nr * VHCI_PORTS + vhci_hc_ports + i, vdev);
 		spin_unlock(&vdev->ud.lock);
 	}
 
@@ -109,7 +109,7 @@ static ssize_t status_show_not_ready(int pdev_nr, char *out)
 	char *s = out;
 	int i = 0;
 
-	for (i = 0; i < VHCI_HC_PORTS; i++) {
+	for (i = 0; i < vhci_hc_ports; i++) {
 		out += sprintf(out, "hs  %04u %03u ",
 				    (pdev_nr * VHCI_PORTS) + i,
 				    VDEV_ST_NOTASSIGNED);
@@ -117,9 +117,9 @@ static ssize_t status_show_not_ready(int pdev_nr, char *out)
 		out += sprintf(out, "\n");
 	}
 
-	for (i = 0; i < VHCI_HC_PORTS; i++) {
+	for (i = 0; i < vhci_hc_ports; i++) {
 		out += sprintf(out, "ss  %04u %03u ",
-				    (pdev_nr * VHCI_PORTS) + VHCI_HC_PORTS + i,
+				    (pdev_nr * VHCI_PORTS) + vhci_hc_ports + i,
 				    VDEV_ST_NOTASSIGNED);
 		out += sprintf(out, "000 00000000 0000000000000000 0-0");
 		out += sprintf(out, "\n");
@@ -221,11 +221,11 @@ static int valid_port(__u32 *pdev_nr, __u32 *rhport)
 	}
 	*pdev_nr = array_index_nospec(*pdev_nr, vhci_num_controllers);
 
-	if (*rhport >= VHCI_HC_PORTS) {
+	if (*rhport >= vhci_hc_ports) {
 		pr_err("rhport %u\n", *rhport);
 		return 0;
 	}
-	*rhport = array_index_nospec(*rhport, VHCI_HC_PORTS);
+	*rhport = array_index_nospec(*rhport, vhci_hc_ports);
 
 	return 1;
 }
@@ -255,7 +255,7 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
 
 	usbip_dbg_vhci_sysfs("rhport %d\n", rhport);
 
-	if ((port / VHCI_HC_PORTS) % 2)
+	if ((port / vhci_hc_ports) % 2)
 		vhci_hcd = hcd_to_vhci_hcd(hcd)->vhci->vhci_hcd_ss;
 	else
 		vhci_hcd = hcd_to_vhci_hcd(hcd)->vhci->vhci_hcd_hs;
-- 
2.43.0


