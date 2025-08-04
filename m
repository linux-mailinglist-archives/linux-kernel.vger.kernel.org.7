Return-Path: <linux-kernel+bounces-754904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263CB19E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A24189A817
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1DF238C08;
	Mon,  4 Aug 2025 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbbVYvoX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE0248F4E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298277; cv=none; b=dIBgocyIMdrfYXpH9MIjdIwF8WDTxF8ZRdpHKkYvA6JWBjlKoL+FR9Kfkuovmo2/5Ng2BlEc7f/AGiCGhv2COUDBwfHxxzheFimSHN3lb5CmKQazgFMu7PJD9AiVq+W47kVZUnkuzwGpDzM48HkZRR0vk7P80buHEvkDmA1vpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298277; c=relaxed/simple;
	bh=1yGVPKKthJlH/muny6X7yhCAI1KUFrIYBs43AA5Aokg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ein2ynvz2KlZHHjs07BJq61xbO/b/dXVD3Gz0m/tkv4ckonDzVrxA3mNj7bv8KSrrvPrMdBRYR2Z2ofhKPHbCAKDQ2X9AO7mNbU60OfcxhHYyTM1Ae6pSpA6C8JZsfmo1PF5I8WUiU05tGb1LygSAbioNr7eqjx9MpUHR3vs+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hbbVYvoX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso7160457a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298272; x=1754903072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNFrgeRCwMRLhwjhx4Rv5lD+aMsRG4TVRPHmUSvJSPs=;
        b=hbbVYvoXg6eMCtyV5HhjK5PNjEXY+muB1ULPsLtKJBhoSIl79aSL1n6V/LDM/43sYY
         uY7KEJHnbBO9H4mwKSNHEiejr3wuFl8+j4O/1tisY6LhbXpqH0gwEJpLxVCTWET1TL0L
         MCD0jstnrRdcrtiW/bTUq+8el+3Iw5YonTOp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298272; x=1754903072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNFrgeRCwMRLhwjhx4Rv5lD+aMsRG4TVRPHmUSvJSPs=;
        b=HsbohNzzkXTBJUKV1pc2sHsKvakWTZrUzVd9p4lN1umGHqpP7wWgzLle7lyKV2gnYZ
         glbZ9iO9PyDOUQ2Eb+RSU9kFAnbqjGedSaKaVHTPZMrvpBh5z+g+d1fHHt+pWswteyYC
         t76YsXnaIrDAjfrFBpDNe3/Bcnf5/NqNNZE8OPOHIpvR3SUbBFeMtADPuE7GLWbEobz+
         DNrGhNOflBW9qsVbxKo9ZObyM9oUISyk0OZQcvUBt4cTRm6WIkunhRoNtZOBQnYl+Pbv
         mFH2DqNB2As7wn0gA/ktbqBN4S48ZiHKq2qlHkqcYCyVHAPv7cRP2kuzoIY1BgacCFN/
         CG0w==
X-Forwarded-Encrypted: i=1; AJvYcCVpndlhfxEoS8EVvnlcIUfxKHd/Pk1uxhbnNB9XNhBN5D0T2Ax/e1cx6zURUkIujP8+fu3RRJAX16J9Ltw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDpmZobBVDUh5O36v6y94o5xwiLX/+8VVRrF5gQiFO3Q7tUGi
	yY5gvFxIi74/Qw9kEZvqiCyxgmaLw8VTSYFcOfjwGeMIAPLs03Dch7xVjrFunSn/RA==
X-Gm-Gg: ASbGncutImXfUf/q+ZhtYJLNxSeiIoAgJ/fwsevi/nN9w5+Oinn5h72w71SSXZoiVUK
	toRjeSW5vRATOqgzMBGRyrXfqcbQrdgCqHOu/GAce06IAjBvDOVLCp7gCbEEGlZYFRYtzNzx7UC
	BfcSI6uMLcnWr7oun33SxNz6elpyPQXkl6yPZAR0bOCFe16hUPfufWk4q5jV1McJjMn8eVw9AxT
	+sdYmT2930+ZlI5YXzoE/j6N7A3CVb0m0P3BXWZwNAz8qRSc3g91Jzl4zB9xuEeaNIwgm0X6hSh
	/cMwhiWjB+QtADKqB01vLgPvJuP7iPfsXnAxpS0Rt2bJk0aV94e9/S0gnJ2LE+xtmBapvz8hmFS
	5Yj1l4pxllmtc3TeBohvawVNsUWwP1iZgKU8Iy20AnrHhu7rIlIMSsMAdr3fAG3IQeN9kMpVbT+
	ekszPjA+DNgJb1LWM=
X-Google-Smtp-Source: AGHT+IEW0/btEGJdTsJ4vwLoZORKwTLSPrg3QK8jRK+DiPm6S4hGF5qiKU06prIvAn9GMLYFeiTV5g==
X-Received: by 2002:a17:907:8688:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-af94008422dmr1001051866b.18.1754298271477;
        Mon, 04 Aug 2025 02:04:31 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:30 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v3 05/10] usb: typec: Implement automated mode selection
Date: Mon,  4 Aug 2025 09:03:34 +0000
Message-ID: <20250804090340.3062182-6-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces new sysfs attributes to enable user control over
Type-C automated mode selection and provide negotiation feedback.

`mode_selection` attribute shows a prioritized list of supported modes
with the currently entered mode bracketed. Writing boolean 0 or 1 to
this attribute starts or stops the mode selection process,
respectively.

`entry_result`, `usb4_entry_result` read-only attributes show the
result of the last mode selection attempt for a specific mode.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec |  39 ++
 drivers/usb/typec/class.c                   |  95 ++++-
 drivers/usb/typec/class.h                   |  12 +
 drivers/usb/typec/mode_selection.c          | 445 ++++++++++++++++++++
 drivers/usb/typec/mode_selection.h          |  31 ++
 include/linux/usb/pd_vdo.h                  |   2 +
 include/linux/usb/typec_altmode.h           |   5 +
 7 files changed, 626 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 575dd94f33ab..ed89b9880085 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -280,6 +280,45 @@ Description:	The USB Modes that the partner device supports. The active mode
 		- usb3 (USB 3.2)
 		- usb4 (USB4)
 
+What:		/sys/class/typec/<port>-partner/mode_selection
+Date:		July 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:	Displays a prioritized list of modes that both the port and the
+		partner support with the currently entered mode bracketed. Parentheses
+		indicates a mode currently in progress. Modes listed before the active
+		or in-progress mode have failed.
+		Automated mode selection is activated by writing boolean 1 to the
+		file. Conversely, writing boolean 0 will cancel any ongoing selection
+		process and exit the currently active mode, if any.
+		This attribute is only present if the kernel supports AP driven mode
+		entry, where the Application Processor manages USB Type-C alt-modes.
+
+		Example values:
+		- "USB4 (TBT) DP": USB4 mode entry failed, Thunderbolt alt-mode is in
+			progress, DisplayPort alt-mode is next.
+		- "[USB4] TBT DP": USB4 mode is currently active.
+
+What:		/sys/class/typec/<port>-partner/<alt-mode>/entry_result
+Date:		July 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:	This read-only file represents the status for a specific
+		alt-mode after the last mode selection process.
+		This attribute is visible only if the kernel supports mode selection.
+
+		Example values:
+		- "none": No mode selection attempt has occurred for this alt-mode.
+		- "in progress": The mode entry process is currently underway.
+		- "active": The alt-mode is currently active.
+		- "cable failed": The connected cable doesn't support the mode.
+		- "timeout": Mode entry failed due to a timeout.
+		- "failed": The attempt to activate the mode failed.
+
+What:		/sys/class/typec/<port>-partner/usb4_entry_result
+Date:		July 2025
+Contact:	Andrei Kuchynski <akuchynski@chromium.org>
+Description:	Represents a status for USB4 mode. Its values are identical to
+		the general <alt-mode>/entry_result attributes.
+
 USB Type-C cable devices (eg. /sys/class/typec/port0-cable/)
 
 Note: Electronically Marked Cables will have a device also for one cable plug
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 414d94c45ab9..f9515fc594f8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -479,12 +479,24 @@ static ssize_t priority_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(priority);
 
+static ssize_t entry_result_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct typec_altmode *adev = to_typec_altmode(dev);
+	struct typec_partner *partner = to_typec_partner(adev->dev.parent);
+
+	return typec_mode_selection_get_result(partner,
+		typec_svid_to_altmode(adev->svid), buf);
+}
+static DEVICE_ATTR_RO(entry_result);
+
 static struct attribute *typec_altmode_attrs[] = {
 	&dev_attr_active.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_svid.attr,
 	&dev_attr_vdo.attr,
 	&dev_attr_priority.attr,
+	&dev_attr_entry_result.attr,
 	NULL
 };
 
@@ -508,6 +520,17 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 		if (is_typec_port(adev->dev.parent))  {
 			struct typec_port *port = to_typec_port(adev->dev.parent);
 
+			if (!port->alt_mode_override)
+				return 0;
+		} else
+			return 0;
+	} else if (attr == &dev_attr_entry_result.attr) {
+		if (is_typec_partner(adev->dev.parent))  {
+			struct typec_partner *partner =
+				to_typec_partner(adev->dev.parent);
+			struct typec_port *port =
+				to_typec_port(partner->dev.parent);
+
 			if (!port->alt_mode_override)
 				return 0;
 		} else
@@ -584,7 +607,7 @@ static void typec_altmode_release(struct device *dev)
 }
 
 const struct device_type typec_altmode_dev_type = {
-	.name = "typec_alternate_mode",
+	.name = ALTERNATE_MODE_DEVICE_TYPE_NAME,
 	.groups = typec_altmode_groups,
 	.release = typec_altmode_release,
 };
@@ -784,6 +807,44 @@ static ssize_t number_of_alternate_modes_show(struct device *dev, struct device_
 }
 static DEVICE_ATTR_RO(number_of_alternate_modes);
 
+static ssize_t mode_selection_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct typec_partner *partner = to_typec_partner(dev);
+
+	return typec_mode_selection_get_active(partner, buf);
+}
+
+static ssize_t mode_selection_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct typec_partner *partner = to_typec_partner(dev);
+	bool start;
+	int ret = kstrtobool(buf, &start);
+
+	if (!ret) {
+		if (start)
+			ret = typec_mode_selection_start(partner);
+		else
+			ret = typec_mode_selection_reset(partner);
+	}
+
+	if (ret)
+		return ret;
+
+	return size;
+}
+static DEVICE_ATTR_RW(mode_selection);
+
+static ssize_t usb4_entry_result_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return typec_mode_selection_get_result(to_typec_partner(dev),
+		TYPEC_USB4_MODE, buf);
+}
+static DEVICE_ATTR_RO(usb4_entry_result);
+
 static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_accessory_mode.attr,
 	&dev_attr_supports_usb_power_delivery.attr,
@@ -791,6 +852,8 @@ static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_usb_mode.attr,
 	&dev_attr_usb_power_delivery_revision.attr,
+	&dev_attr_mode_selection.attr,
+	&dev_attr_usb4_entry_result.attr,
 	NULL
 };
 
@@ -815,6 +878,16 @@ static umode_t typec_partner_attr_is_visible(struct kobject *kobj, struct attrib
 		if (!get_pd_product_type(kobj_to_dev(kobj)))
 			return 0;
 
+	if (attr == &dev_attr_mode_selection.attr)
+		if (!port->alt_mode_override)
+			return 0;
+
+	if (attr == &dev_attr_usb4_entry_result.attr) {
+		if (!port->alt_mode_override ||
+			!(partner->usb_capability & USB_CAPABILITY_USB4))
+			return 0;
+	}
+
 	return attr->mode;
 }
 
@@ -893,8 +966,10 @@ int typec_partner_set_identity(struct typec_partner *partner)
 			usb_capability |= USB_CAPABILITY_USB2;
 		if (devcap & DEV_USB3_CAPABLE)
 			usb_capability |= USB_CAPABILITY_USB3;
-		if (devcap & DEV_USB4_CAPABLE)
+		if (devcap & DEV_USB4_CAPABLE) {
 			usb_capability |= USB_CAPABILITY_USB4;
+			typec_mode_selection_add_mode(partner, TYPEC_USB4_MODE);
+		}
 	} else {
 		usb_capability = PD_VDO_DFP_HOSTCAP(id->vdo[0]);
 	}
@@ -1014,7 +1089,12 @@ struct typec_altmode *
 typec_partner_register_altmode(struct typec_partner *partner,
 			       const struct typec_altmode_desc *desc)
 {
-	return typec_register_altmode(&partner->dev, desc);
+	struct typec_altmode *alt = typec_register_altmode(&partner->dev, desc);
+
+	if (alt)
+		typec_mode_selection_add_mode(partner, typec_svid_to_altmode(alt->svid));
+
+	return alt;
 }
 EXPORT_SYMBOL_GPL(typec_partner_register_altmode);
 
@@ -1118,6 +1198,8 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 		typec_partner_link_device(partner, port->usb3_dev);
 	mutex_unlock(&port->partner_link_lock);
 
+	typec_mode_selection_add_partner(partner);
+
 	return partner;
 }
 EXPORT_SYMBOL_GPL(typec_register_partner);
@@ -1135,6 +1217,7 @@ void typec_unregister_partner(struct typec_partner *partner)
 	if (IS_ERR_OR_NULL(partner))
 		return;
 
+	typec_mode_selection_remove_partner(partner);
 	port = to_typec_port(partner->dev.parent);
 
 	mutex_lock(&port->partner_link_lock);
@@ -1403,6 +1486,7 @@ int typec_cable_set_identity(struct typec_cable *cable)
 }
 EXPORT_SYMBOL_GPL(typec_cable_set_identity);
 
+static struct typec_partner *typec_get_partner(struct typec_port *port);
 /**
  * typec_register_cable - Register a USB Type-C Cable
  * @port: The USB Type-C Port the cable is connected to
@@ -1417,6 +1501,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 					 struct typec_cable_desc *desc)
 {
 	struct typec_cable *cable;
+	struct typec_partner *partner;
 	int ret;
 
 	cable = kzalloc(sizeof(*cable), GFP_KERNEL);
@@ -1448,6 +1533,10 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 		return ERR_PTR(ret);
 	}
 
+	partner = typec_get_partner(port);
+	typec_mode_selection_add_cable(partner, cable);
+	put_device(&partner->dev);
+
 	return cable;
 }
 EXPORT_SYMBOL_GPL(typec_register_cable);
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index c6467e576569..281dcb6d675c 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -5,6 +5,8 @@
 
 #include <linux/device.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/typec_altmode.h>
+#include <linux/kfifo.h>
 
 struct typec_mux;
 struct typec_switch;
@@ -26,6 +28,8 @@ struct typec_cable {
 	enum usb_pd_svdm_ver		svdm_version;
 };
 
+struct mode_selection_state;
+
 struct typec_partner {
 	struct device			dev;
 	unsigned int			usb_pd:1;
@@ -40,6 +44,12 @@ struct typec_partner {
 
 	struct usb_power_delivery	*pd;
 
+	struct delayed_work mode_selection_work;
+	DECLARE_KFIFO(mode_sequence, struct mode_selection_state *,
+			roundup_pow_of_two(TYPEC_MODE_MAX));
+	struct mutex mode_sequence_lock;
+	struct mode_selection_state *active_mode;
+
 	void (*attach)(struct typec_partner *partner, struct device *dev);
 	void (*deattach)(struct typec_partner *partner, struct device *dev);
 };
@@ -112,4 +122,6 @@ static inline int typec_link_ports(struct typec_port *connector) { return 0; }
 static inline void typec_unlink_ports(struct typec_port *connector) { }
 #endif
 
+#define ALTERNATE_MODE_DEVICE_TYPE_NAME "typec_alternate_mode"
+
 #endif /* __USB_TYPEC_CLASS__ */
diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
index 9a7185c07d0c..c7d164478787 100644
--- a/drivers/usb/typec/mode_selection.c
+++ b/drivers/usb/typec/mode_selection.c
@@ -5,10 +5,19 @@
 
 #include <linux/usb/typec_altmode.h>
 #include <linux/slab.h>
+#include <linux/usb/pd_vdo.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
 #include "mode_selection.h"
 #include "class.h"
 
+/* Timeout for a mode entry attempt, ms */
+static const unsigned int mode_selection_timeout = 4000;
+/* Delay between mode entry/exit attempts, ms */
+static const unsigned int mode_selection_delay = 1000;
+/* Maximum retries for mode entry on busy status */
+static const unsigned int mode_entry_attempts = 4;
+
 static const char * const mode_names[TYPEC_MODE_MAX] = {
 	[TYPEC_DP_ALTMODE] = "DisplayPort",
 	[TYPEC_TBT_ALTMODE] = "Thunderbolt3",
@@ -21,18 +30,59 @@ static const int default_priorities[TYPEC_MODE_MAX] = {
 	[TYPEC_USB4_MODE] = 0,
 };
 
+/**
+ * enum ms_state - Specific mode selection states
+ * @MS_STATE_IDLE: The mode entry process has not started
+ * @MS_STATE_INPROGRESS: The mode entry process is currently underway
+ * @MS_STATE_ACTIVE: The mode has been successfully entered
+ * @MS_STATE_CABLE_FAILED: The connected cable doesn't support the mode
+ * @MS_STATE_TIMEOUT: Mode entry failed due to a timeout
+ * @MS_STATE_FAILED: The mode driver reported the error
+ */
+enum ms_state {
+	MS_STATE_IDLE = 0,
+	MS_STATE_INPROGRESS,
+	MS_STATE_ACTIVE,
+	MS_STATE_CABLE_FAILED,
+	MS_STATE_TIMEOUT,
+	MS_STATE_FAILED,
+	MS_STATE_MAX
+};
+static const char * const ms_state_strings[MS_STATE_MAX] = {
+	[MS_STATE_IDLE] = "none",
+	[MS_STATE_INPROGRESS] = "in progress",
+	[MS_STATE_ACTIVE] = "active",
+	[MS_STATE_CABLE_FAILED] = "cable failed",
+	[MS_STATE_TIMEOUT] = "timeout",
+	[MS_STATE_FAILED] = "failed",
+};
+
 /**
  * struct mode_selection_state - State tracking for a specific Type-C mode
  * @mode: The type of mode this instance represents
  * @name: Name string pointer
  * @priority: The mode priority. Higher values indicate a more preferred mode.
  * @list: List head to link this mode state into a prioritized list.
+ * @partner_supported: Flag indicating if this mode is supported by the partner
+ * @cable_supported: Flag indicating if this mode is supported by the cable
+ * @enter: Flag indicating if the driver is currently attempting to enter or
+ * exit the mode
+ * @attempt_count: Number of times the driver has attempted to enter the mode
+ * @state: The current mode selection state
+ * @error: The outcome of the last attempt to enter the mode
  */
 struct mode_selection_state {
 	enum typec_mode_type mode;
 	const char *name;
 	int priority;
 	struct list_head list;
+
+	bool partner_supported;
+	bool cable_supported;
+	bool enter;
+	int attempt_count;
+	enum ms_state state;
+	int error;
 };
 
 /* -------------------------------------------------------------------------- */
@@ -128,3 +178,398 @@ ssize_t typec_mode_get_priority_list(struct typec_port *port, char *buf)
 
 	return count + sysfs_emit_at(buf, count, "\n");
 }
+
+/* -------------------------------------------------------------------------- */
+/* partner 'mod_selection' attribute */
+
+/**
+ * mode_selection_next() - Process mode selection results and schedule next
+ * action
+ * @partner: pointer to the partner structure
+ * @ms: pointer to active mode_selection_state object that is on top in
+ * mode_sequence FIFO.
+ *
+ * The mutex protecting the mode_sequence FIFO must be held by the caller
+ * when invoking this function.
+ *
+ * This function evaluates the outcome of the previous mode entry or exit
+ * attempt. Based on this result, it determines the next mode to process and
+ * schedules `mode_selection_work()` if further actions are required.
+ *
+ * If the previous mode entry was successful, the mode selection sequence is
+ * considered complete for the current cycle.
+ *
+ * If the previous mode entry failed, this function schedules
+ * `mode_selection_work()` to attempt exiting the mode that was partially
+ * activated but not fully entered.
+ *
+ * If the previous operation was an exit (after a failed entry attempt),
+ * `mode_selection_next()` then advances the internal list of candidate
+ * modes to determine the next mode to enter.
+ */
+static void mode_selection_next(
+	struct typec_partner *partner, struct mode_selection_state *ms)
+
+	__must_hold(&partner->mode_sequence_lock)
+{
+	if (!ms->enter) {
+		kfifo_skip(&partner->mode_sequence);
+	} else if (ms->state == MS_STATE_INPROGRESS && !ms->error) {
+		ms->state = MS_STATE_ACTIVE;
+		partner->active_mode = ms;
+		kfifo_reset(&partner->mode_sequence);
+	} else {
+		if (ms->error) {
+			ms->state = MS_STATE_FAILED;
+			dev_dbg(&partner->dev, "%s: entry mode error %pe\n",
+				ms->name, ERR_PTR(ms->error));
+		}
+		if (ms->error != -EBUSY || ms->attempt_count >= mode_entry_attempts)
+			ms->enter = false;
+	}
+
+	if (!kfifo_is_empty(&partner->mode_sequence))
+		schedule_delayed_work(&partner->mode_selection_work,
+			msecs_to_jiffies(mode_selection_delay));
+}
+
+static void mode_selection_complete(struct typec_partner *partner,
+			const enum typec_mode_type mode, const int error)
+{
+	struct mode_selection_state *ms;
+
+	mutex_lock(&partner->mode_sequence_lock);
+	if (kfifo_peek(&partner->mode_sequence, &ms)) {
+		if (ms->mode == mode && ms->state == MS_STATE_INPROGRESS) {
+			ms->error = error;
+			cancel_delayed_work(&partner->mode_selection_work);
+			mode_selection_next(partner, ms);
+		}
+	}
+	mutex_unlock(&partner->mode_sequence_lock);
+}
+
+void typec_mode_selection_altmode_complete(struct typec_altmode *alt,
+				const int error)
+{
+	mode_selection_complete(to_typec_partner(alt->dev.parent),
+		typec_svid_to_altmode(alt->svid), error);
+}
+EXPORT_SYMBOL_GPL(typec_mode_selection_altmode_complete);
+
+void typec_mode_selection_usb4_complete(struct typec_partner *partner,
+				const int error)
+{
+	mode_selection_complete(partner, TYPEC_USB4_MODE, error);
+}
+EXPORT_SYMBOL_GPL(typec_mode_selection_usb4_complete);
+
+static void mode_selection_activate_usb4_mode(struct typec_partner *partner,
+	struct mode_selection_state *ms)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	int error = -EOPNOTSUPP;
+
+	if (port->ops && port->ops->enter_usb_mode) {
+		if (ms->enter && port->usb_mode != USB_MODE_USB4)
+			error = -EPERM;
+		else
+			error = port->ops->enter_usb_mode(port,
+				ms->enter ? USB_MODE_USB4 : USB_MODE_USB3);
+	}
+
+	if (ms->enter)
+		ms->error = error;
+}
+
+static int mode_selection_activate_altmode(struct device *dev, void *data)
+{
+	struct typec_altmode *alt = to_typec_altmode(dev);
+	struct mode_selection_state *ms = (struct mode_selection_state *)data;
+	int error = -ENODEV;
+	int ret = 0;
+
+	if (!strcmp(dev->type->name, ALTERNATE_MODE_DEVICE_TYPE_NAME)) {
+		if (ms->mode == typec_svid_to_altmode(alt->svid)) {
+			if (alt->ops && alt->ops->activate)
+				error = alt->ops->activate(alt, ms->enter);
+			else
+				error = -EOPNOTSUPP;
+			ret = 1;
+		}
+	}
+
+	if (ms->enter)
+		ms->error = error;
+
+	return ret;
+}
+
+static void mode_selection_activate_mode(struct typec_partner *partner,
+	struct mode_selection_state *ms)
+{
+	if (ms->enter)
+		ms->attempt_count++;
+
+	if (ms->mode == TYPEC_USB4_MODE)
+		mode_selection_activate_usb4_mode(partner, ms);
+	else
+		device_for_each_child(&partner->dev, ms,
+			mode_selection_activate_altmode);
+}
+
+/**
+ * mode_selection_work() - Activate entry into the upcoming mode
+ * @work: work structure
+ *
+ * This function works in conjunction with `mode_selection_next()`.
+ * It attempts to activate the next mode in the selection sequence.
+ *
+ * If the mode activation (`mode_selection_activate_mode()`) fails,
+ * `mode_selection_next()` will be called to initiate a new selection cycle.
+ *
+ * Otherwise, the state is set to MS_STATE_INPROGRESS, and
+ * `mode_selection_work()` is scheduled for a subsequent entry after a timeout
+ * period. The alternate mode driver is expected to call back with the actual
+ * mode entry result. Upon this callback, `mode_selection_next()` will determine
+ * the subsequent mode and re-schedule `mode_selection_work()`.
+ */
+static void mode_selection_work(struct work_struct *work)
+{
+	struct typec_partner *partner = container_of(work, struct typec_partner,
+						  mode_selection_work.work);
+	struct mode_selection_state *ms;
+
+	mutex_lock(&partner->mode_sequence_lock);
+	if (kfifo_peek(&partner->mode_sequence, &ms)) {
+		if (ms->state == MS_STATE_INPROGRESS) {
+			ms->state = MS_STATE_TIMEOUT;
+			mode_selection_next(partner, ms);
+		} else {
+			mode_selection_activate_mode(partner, ms);
+
+			if (ms->enter && !ms->error) {
+				ms->state = MS_STATE_INPROGRESS;
+				schedule_delayed_work(&partner->mode_selection_work,
+					msecs_to_jiffies(mode_selection_timeout));
+			} else
+				mode_selection_next(partner, ms);
+		}
+	}
+	mutex_unlock(&partner->mode_sequence_lock);
+}
+
+static void mode_selection_clear_results(struct typec_partner *partner)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	struct mode_selection_state *ms;
+
+	list_for_each_entry(ms, &port->mode_list, list) {
+		ms->enter = true;
+		ms->state = MS_STATE_IDLE;
+		ms->error = 0;
+		ms->attempt_count = 0;
+	}
+
+	kfifo_reset(&partner->mode_sequence);
+	partner->active_mode = NULL;
+}
+
+void typec_mode_selection_add_partner(struct typec_partner *partner)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	struct mode_selection_state *ms;
+
+	list_for_each_entry(ms, &port->mode_list, list) {
+		ms->partner_supported = false;
+		ms->cable_supported = false;
+	}
+
+	INIT_KFIFO(partner->mode_sequence);
+	mutex_init(&partner->mode_sequence_lock);
+	mode_selection_clear_results(partner);
+	INIT_DELAYED_WORK(&partner->mode_selection_work, mode_selection_work);
+}
+
+void typec_mode_selection_add_mode(struct typec_partner *partner,
+		const enum typec_mode_type mode)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	struct mode_selection_state *ms;
+
+	list_for_each_entry(ms, &port->mode_list, list) {
+		if (ms->mode == mode) {
+			ms->partner_supported = true;
+			break;
+		}
+	}
+}
+
+void typec_mode_selection_add_cable(struct typec_partner *partner,
+		struct typec_cable *cable)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	struct mode_selection_state *ms;
+	const u32 id_header = cable->identity->id_header;
+	const u32 vdo1 = cable->identity->vdo[0];
+	const u32 type = PD_IDH_PTYPE(id_header);
+	const u32 speed = VDO_TYPEC_CABLE_SPEED(vdo1);
+	/*
+	 * Some USB devices supporting DisplayPort lack valid cable VDO.
+	 * Allow only DP mode in this case.
+	 */
+	bool capability[TYPEC_MODE_MAX] = {
+		[TYPEC_DP_ALTMODE] = true,
+		[TYPEC_TBT_ALTMODE] = false,
+		[TYPEC_USB4_MODE] = false,
+	};
+
+	if (type == IDH_PTYPE_PCABLE) {
+		capability[TYPEC_DP_ALTMODE] = (speed > CABLE_USB2_ONLY);
+		capability[TYPEC_TBT_ALTMODE] = (speed > CABLE_USB2_ONLY);
+		capability[TYPEC_USB4_MODE] = (speed > CABLE_USB2_ONLY);
+	} else if (type == IDH_PTYPE_ACABLE) {
+		const u32 vdo2 = cable->identity->vdo[1];
+		const u32 version = VDO_TYPEC_CABLE_VERSION(vdo1);
+		const bool usb4_support = VDO_TYPEC_CABLE_USB4_SUPP(vdo2);
+		const bool modal_support = PD_IDH_MODAL_SUPP(id_header);
+
+		capability[TYPEC_DP_ALTMODE] = modal_support;
+		capability[TYPEC_TBT_ALTMODE] = true;
+		if (version == CABLE_VDO_VER1_3)
+			capability[TYPEC_USB4_MODE] = usb4_support;
+		else
+			capability[TYPEC_USB4_MODE] = modal_support;
+	}
+
+	list_for_each_entry(ms, &port->mode_list, list)
+		ms->cable_supported = capability[ms->mode];
+}
+
+void typec_mode_selection_remove_partner(struct typec_partner *partner)
+{
+	mutex_lock(&partner->mode_sequence_lock);
+	kfifo_reset(&partner->mode_sequence);
+	mutex_unlock(&partner->mode_sequence_lock);
+
+	cancel_delayed_work_sync(&partner->mode_selection_work);
+	mutex_destroy(&partner->mode_sequence_lock);
+}
+
+/**
+ * typec_mode_selection_start() - Starts the mode selection process.
+ * @partner: pointer to the partner structure
+ *
+ * This function populates a 'mode_sequence' FIFO with pointers to
+ * `struct mode_selection_state` instances. The sequence is generated based on
+ * partner/cable capabilities and prioritized according to the port's settings.
+ */
+int typec_mode_selection_start(struct typec_partner *partner)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	struct mode_selection_state *ms;
+	int ret = 0;
+
+	mutex_lock(&partner->mode_sequence_lock);
+
+	if (!kfifo_is_empty(&partner->mode_sequence))
+		ret = -EINPROGRESS;
+	else if (partner->active_mode)
+		ret = -EALREADY;
+	else {
+		mode_selection_clear_results(partner);
+
+		list_for_each_entry(ms, &port->mode_list, list) {
+			if (ms->partner_supported) {
+				if (ms->cable_supported)
+					kfifo_put(&partner->mode_sequence, ms);
+				else
+					ms->state = MS_STATE_CABLE_FAILED;
+			}
+		}
+
+		if (kfifo_peek(&partner->mode_sequence, &ms))
+			schedule_delayed_work(&partner->mode_selection_work, 0);
+	}
+
+	mutex_unlock(&partner->mode_sequence_lock);
+
+	return ret;
+}
+
+/**
+ * typec_mode_selection_reset() - Reset the mode selection process.
+ * @partner: pointer to the partner structure
+ *
+ * This function cancels ongoing mode selection and exits the currently active
+ * mode, if present.
+ * It returns -EINPROGRESS when a mode exit is already scheduled, or a mode
+ * entry is ongoing, indicating that the reset cannot immediately complete.
+ */
+int typec_mode_selection_reset(struct typec_partner *partner)
+{
+	struct mode_selection_state *ms;
+
+	mutex_lock(&partner->mode_sequence_lock);
+	if (kfifo_peek(&partner->mode_sequence, &ms)) {
+		kfifo_reset(&partner->mode_sequence);
+
+		if (!ms->enter || ms->state != MS_STATE_IDLE) {
+			ms->attempt_count = mode_entry_attempts;
+			kfifo_put(&partner->mode_sequence, ms);
+			mutex_unlock(&partner->mode_sequence_lock);
+
+			return -EINPROGRESS;
+		}
+	}
+
+	if (partner->active_mode) {
+		partner->active_mode->enter = false;
+		mode_selection_activate_mode(partner, partner->active_mode);
+	}
+	mode_selection_clear_results(partner);
+	mutex_unlock(&partner->mode_sequence_lock);
+
+	return 0;
+}
+
+int typec_mode_selection_get_active(struct typec_partner *partner, char *buf)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	struct mode_selection_state *ms, *running_ms;
+	ssize_t count = 0;
+
+	mutex_lock(&partner->mode_sequence_lock);
+	if (!kfifo_peek(&partner->mode_sequence, &running_ms))
+		running_ms = NULL;
+
+	list_for_each_entry(ms, &port->mode_list, list) {
+		if (ms->partner_supported) {
+			if (ms->state == MS_STATE_ACTIVE)
+				count += sysfs_emit_at(buf, count, "[%s] ", ms->name);
+			else if (ms == running_ms)
+				count += sysfs_emit_at(buf, count, "(%s) ", ms->name);
+			else
+				count += sysfs_emit_at(buf, count, "%s ", ms->name);
+		}
+	}
+	mutex_unlock(&partner->mode_sequence_lock);
+
+	if (count)
+		count += sysfs_emit_at(buf, count, "\n");
+
+	return count;
+}
+
+int typec_mode_selection_get_result(struct typec_partner *partner,
+		const enum typec_mode_type mode, char *buf)
+{
+	struct typec_port *port = to_typec_port(partner->dev.parent);
+	struct mode_selection_state *ms;
+
+	list_for_each_entry(ms, &port->mode_list, list)
+		if (ms->mode == mode)
+			return sysfs_emit(buf, "%s\n", ms_state_strings[ms->state]);
+
+	return -EOPNOTSUPP;
+}
diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
index 151f0f8b6632..2238a7200eae 100644
--- a/drivers/usb/typec/mode_selection.h
+++ b/drivers/usb/typec/mode_selection.h
@@ -21,3 +21,34 @@ int typec_mode_set_priority(struct typec_port *port,
 int typec_mode_get_priority(struct typec_port *port,
 		const enum typec_mode_type mode, int *priority);
 ssize_t typec_mode_get_priority_list(struct typec_port *port, char *buf);
+
+/**
+ * The mode selection process follows a lifecycle tied to the USB-C partner
+ * device. The API is designed to first build a set of desired modes and then
+ * trigger the selection process. The expected sequence of calls is as follows:
+ *
+ * Creation and Configuration:
+ * call typec_mode_selection_add_partner() when the partner device is being set
+ * up. After creation, call typec_mode_selection_add_mode() and
+ * typec_mode_selection_add_cable() to define the parameters for the
+ * selection process.
+ *
+ * Execution:
+ * Call typec_mode_selection_start() to trigger the mode selection.
+ * Call typec_mode_selection_reset() to prematurely stop the selection
+ * process and clear any stored results.
+ *
+ * Destruction:
+ * Before destroying a partner, call typec_mode_selection_remove_partner()
+ */
+void typec_mode_selection_add_partner(struct typec_partner *partner);
+void typec_mode_selection_remove_partner(struct typec_partner *partner);
+int typec_mode_selection_start(struct typec_partner *partner);
+int typec_mode_selection_reset(struct typec_partner *partner);
+void typec_mode_selection_add_mode(struct typec_partner *partner,
+		const enum typec_mode_type mode);
+void typec_mode_selection_add_cable(struct typec_partner *partner,
+		struct typec_cable *cable);
+int typec_mode_selection_get_active(struct typec_partner *partner, char *buf);
+int typec_mode_selection_get_result(struct typec_partner *partner,
+		const enum typec_mode_type mode, char *buf);
diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index 5c48e8a81403..20bcf37ad634 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -439,6 +439,8 @@
 	 | (trans) << 11 | (phy) << 10 | (ele) << 9 | (u4) << 8			\
 	 | ((hops) & 0x3) << 6 | (u2) << 5 | (u32) << 4 | (lane) << 3		\
 	 | (iso) << 2 | (gen))
+#define VDO_TYPEC_CABLE_VERSION(vdo) (((vdo) >> 21) & 0x7)
+#define VDO_TYPEC_CABLE_USB4_SUPP(vdo) (((vdo) & BIT(8)) == ACAB2_USB4_SUPP)
 
 /*
  * AMA VDO (PD Rev2.0)
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 5d14363e02eb..f7fd51b4c23e 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -225,4 +225,9 @@ void typec_altmode_unregister_driver(struct typec_altmode_driver *drv);
 	module_driver(__typec_altmode_driver, typec_altmode_register_driver, \
 		      typec_altmode_unregister_driver)
 
+void typec_mode_selection_altmode_complete(struct typec_altmode *alt,
+				const int result);
+void typec_mode_selection_usb4_complete(struct typec_partner *partner,
+				const int result);
+
 #endif /* __USB_TYPEC_ALTMODE_H */
-- 
2.50.1.565.gc32cd1483b-goog


