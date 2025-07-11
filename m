Return-Path: <linux-kernel+bounces-727216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D5B0169C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E31B3BC8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B312153CB;
	Fri, 11 Jul 2025 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="lxLITDer"
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6E148FE6;
	Fri, 11 Jul 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223307; cv=none; b=YMFpcUFDHzUC+SKXPzw+6K+U1uwJcQtMFECxbMGwZTKrR5at51Mw0FV6QviHwCSADz6TIm23llytwSOaGdK3CugKlXvnWsZfiNdhDwJz5nYBA4TdpNhn41eNrBeblOwThoLYQrhJywm5gWJssatolN2Akn6e+lk/B0rs+BCY044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223307; c=relaxed/simple;
	bh=aq2NFXtFhdvdGO529/0s8V4wILV4P+WzR0aD43M2I2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YN61JGuOSYJrxegyp/SE3AMDOjvNHXqP5bwbwZPlpjnzLHp1orlB2fQDoqDIkiGnYI3Elqih52UVVgbF4spiy97vb7xkEyUpBSyGmGHIJgH9AcEAAeQUoK5Ko6TPEPeuvFq5DfuxMQ3wndzud3nYpSv3XDxwCN+DMkucDKj2gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=lxLITDer; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b4Duk1ArXxdluAY87Blb383NUqI6E02pnWIrXqcJ6pM=; b=lxLITDertU5X2kyCAzaqBQvTeZ
	rYP8Ngj2ntEfr+c85+54f0G0q0lSrL3+d3M2gbAFbZnVfjw3slZEaiFwXWwUmzZdjpFcNjHexGPFu
	zeoRrllDg5xnfR3wzDI3k7Oq/qBtal8xjqArHIPwR+RET82QcMnIB9zPb/zvcr5WRUGPXCrVZbk9H
	q9itu7YzBzpjeRXiUU/eRFGR1HbKcX1z4TudFKIAKji2MokP0rtpsDghVA0QpTpzhKiJnheDN0WhC
	f7OH/7PLSpIw0wLqM3Fa2w98NhEBxnZEJ6SKtKMnb7YmyHkk6sklGN/oLrjymkqA5Z6D5MESsBd3d
	synugDtw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:16749 helo=[10.224.9.2])
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ua9K7-0000000DVFH-3gDp;
	Fri, 11 Jul 2025 10:41:37 +0200
From: nicolas.bouchinet@oss.cyber.gouv.fr
Date: Fri, 11 Jul 2025 10:41:24 +0200
Subject: [RFC PATCH v2 3/4] usb: core: Plug the usb authentication
 capability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250711-usb_authentication-v2-3-2878690e6b6d@ssi.gouv.fr>
References: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
In-Reply-To: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>, 
 Alan Stern <stern@rowland.harvard.edu>, Kannappan R <r.kannappan@intel.com>, 
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Pawel Laszczak <pawell@cadence.com>, 
 Ma Ke <make_ruc2021@163.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>, 
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

The authentication bulk is implemented by the usb_authenticate_device
function.

The usb_authenticate_device returns 0 or an error code. If 0 is
returned, a per-device authenticated field is updated with the result of
the authentication.

The authenticated field can be used to track the result of the
authentication process in userspace thanks to a sysfs exposed file.

The device enforcement point is done in the usb_probe_interface()
function. This allows for more complex security policy in userspace: the
user could manually authorize a device that failed the authentication or
manually deauthorize a device that was previously authenticated.

If set to false (default), the authentication decision is not enforced,
the device authentication field is set for userspace information. The
legacy kernel authorization decision is used:

+----------+------------+-------------+
|          | authorized | !authorized |
+----------+------------+-------------+
| authent  |     OK     |     NOK     |
+----------+------------+-------------+
| !authent |     OK     |     NOK     |
+----------+------------+-------------+

If set to true, the authentication decision is enforced, the following
decision is made:

+----------+------------+-------------+
|          | authorized | !authorized |
+----------+------------+-------------+
| authent  |     OK     |     NOK     |
+----------+------------+-------------+
| !authent |    NOK     |     NOK     |
+----------+------------+-------------+

Note that combined with the CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=2:
 - internal devices should be authorized and !authenticated => OK
 - external qemu dev-auth is !authorized and authenticated  => NOK at
   first but then authorization can be granted via sysfs.
 - external qemu non auth dev is !authorized and !authenticated => NOK
   and authorization can be granted via sysfs

The default enforcement decision can be configured thanks to the new
USB_AUTHENTICATION_ENFORCE configuration option and can be overridden
using the usbcore.enforce_authentication command line or module
parameter.

Co-developed-by: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
Signed-off-by: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 Documentation/usb/authentication.rst | 15 +++++++++++++++
 Documentation/usb/index.rst          |  1 +
 drivers/usb/core/Kconfig             | 26 ++++++++++++++++++++++++++
 drivers/usb/core/Makefile            |  4 ++++
 drivers/usb/core/config.c            | 22 ++++++++++++++++++++--
 drivers/usb/core/driver.c            | 31 +++++++++++++++++++++++++++++++
 drivers/usb/core/hub.c               |  5 +++++
 drivers/usb/core/sysfs.c             | 16 ++++++++++++++++
 drivers/usb/core/usb.c               |  8 ++++++++
 include/linux/usb.h                  |  2 ++
 10 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/Documentation/usb/authentication.rst b/Documentation/usb/authentication.rst
new file mode 100644
index 0000000000000000000000000000000000000000..828a7f7b07017a684fa039224fdefd6d07a78ec1
--- /dev/null
+++ b/Documentation/usb/authentication.rst
@@ -0,0 +1,15 @@
+======================================
+Linux usb authentication documentation
+======================================
+
+usb authentication
+------------------
+
+.. kernel-doc:: drivers/usb/core/authent.c
+   :internal:
+
+usb authentication netlink API
+------------------------------
+
+.. kernel-doc:: drivers/usb/core/authent_netlink.c
+   :internal:
diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
index 826492c813acd6ec5162c97312ff9a2a4b27633a..9ebf7ef52c3dadd0c2e099ed3570d67109e94e43 100644
--- a/Documentation/usb/index.rst
+++ b/Documentation/usb/index.rst
@@ -7,6 +7,7 @@ USB support
 
     acm
     authorization
+    authentication
     chipidea
     dwc3
     ehci
diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 58e3ca7e479392112f656384c664efc36bb1151a..31dace7e2e794f0f31f77d53bc3c7f3c5339b4ca 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -143,3 +143,29 @@ config USB_DEFAULT_AUTHORIZATION_MODE
 	  ACPI selecting value 2 is analogous to selecting value 0.
 
 	  If unsure, keep the default value.
+
+config USB_AUTHENTICATION
+	bool "Enable USB authentication function"
+	depends on USB
+	help
+		Enables the USB Authentication function. This activates the
+		hook points in the USB stack.
+
+config USB_AUTHENTICATION_ENFORCE
+	bool "Default authentication mode for USB devices"
+	depends on USB && USB_AUTHENTICATION
+	help
+	  Select the default USB device authentication mode. Can be overridden
+	  with usbcore.enforce_authentication command line or module parameter.
+
+	  This option allows you to choose whether USB devices that are
+	  connected to the system needs to be authenticated, or if they are
+	  locked down.
+
+	  With value 1 all connected USB devices with the exception of root hub
+	  require device authentication before they can be used.
+
+	  With value 0 (default) no device authentication is required to use
+	  connected USB devices.
+
+	  If unsure, keep the default value.
diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index ac006abd13b3ad8362dc7baa115124c11eaafc84..7ba1a89cf3de7a398889eee1820f2bfbbc4280f5 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -8,6 +8,10 @@ usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
 usbcore-y += devio.o notify.o generic.o quirks.o devices.o
 usbcore-y += phy.o port.o
 
+ifdef CONFIG_USB_AUTHENTICATION
+usbcore-y += authent.o authent_netlink.o
+endif
+
 usbcore-$(CONFIG_OF)		+= of.o
 usbcore-$(CONFIG_USB_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 13bd4ec4ea5f7a6fef615b6f50b1acb3bbe44ba4..bbb835043a0d452c0e8305ac90b5e99cfb94ae24 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -13,7 +13,7 @@
 #include <linux/device.h>
 #include <asm/byteorder.h>
 #include "usb.h"
-
+#include "authent.h"
 
 #define USB_MAXALTSETTING		128	/* Hard limit */
 
@@ -824,7 +824,21 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 		kref_init(&intfc->ref);
 	}
 
-	/* FIXME: parse the BOS descriptor */
+	/* If device USB version is above 2.0, get BOS descriptor
+	 *
+	 * Requirement for bcdUSB >= 2.10 is defined in USB 3.2 §9.2.6.6
+	 * "Devices with a value of at least 0210H in the bcdUSB field of their
+	 * device descriptor shall support GetDescriptor (BOS Descriptor) requests."
+	 *
+	 * To discuss, BOS request could be also sent for bcdUSB >= 0x0201
+	 */
+
+	if (le16_to_cpu(dev->descriptor.bcdUSB) >= 0x0201) {
+		dev_notice(ddev, "bcdUSB >= 0x0201\n");
+		retval = usb_get_bos_descriptor(dev);
+		if (retval < 0)
+			dev_notice(ddev, "Device does not have a BOS descriptor\n");
+	}
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
 	 * find the first interface descriptor */
@@ -1122,6 +1136,10 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 			dev->bos->ptm_cap =
 				(struct usb_ptm_cap_descriptor *)buffer;
 			break;
+		case USB_AUTHENT_CAP_TYPE:
+			dev->bos->authent_cap =
+				(struct usb_authent_cap_descriptor *)buffer;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 460d4dde5994e783bdcad08b2abb6bb85ab3258f..d393691aced3cedd23bd359a79e7158b41f2729c 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -34,6 +34,14 @@
 
 #include "usb.h"
 
+#ifdef CONFIG_USB_AUTHENTICATION_ENFORCE
+static int enforce_authentication = CONFIG_USB_AUTHENTICATION_ENFORCE;
+module_param(enforce_authentication, int, S_IRUGO);
+MODULE_PARM_DESC(enforce_authentication,
+		"Default USB device authentication enforcement mode: 0 unauthenticated devices can be authorized, 1 enforces authentication for all devices");
+#else
+static int enforce_authentication = 0;
+#endif
 
 /*
  * Adds a new dynamic USBdevice ID to this driver,
@@ -331,15 +339,38 @@ static int usb_probe_interface(struct device *dev)
 	if (usb_device_is_owned(udev))
 		return error;
 
+	/* Simple security policy
+	 *
+	 * +----------+------------+-------------+
+	 * |          | authorized | !authorized |
+	 * +----------+------------+-------------+
+	 * | authent  |     OK     |     NOK     |
+	 * +----------+------------+-------------+
+	 * | !authent |    NOK     |     NOK     |
+	 * +----------+------------+-------------+
+	 *
+	 * with CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=2
+	 *  - internal devices should be authorized and !authenticated => OK
+	 *  - external qemu dev-auth is !authorized and authenticated  => NOK at first
+	 *     but then authorization can be granted via sysfs.
+	 *  - external qemu non auth dev is !authorized and !authenticated => NOK and
+	 *     authorization can be granted via sysfs
+	 *
+	 */
 	if (udev->authorized == 0) {
 		dev_err(&intf->dev, "Device is not authorized for usage\n");
 		return error;
+	} else if (udev->authenticated == 0 && enforce_authentication == 1) {
+		dev_err(&intf->dev, "Device is not autenticated for usage\n");
+		return error;
 	} else if (intf->authorized == 0) {
 		dev_err(&intf->dev, "Interface %d is not authorized for usage\n",
 				intf->altsetting->desc.bInterfaceNumber);
 		return error;
 	}
 
+	dev_info(&intf->dev, "Device has been authorized for usage\n");
+
 	id = usb_match_dynamic_id(intf, driver);
 	if (!id)
 		id = usb_match_id(intf, driver->id_table);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0e1dd6ef60a719f59a22d86caeb20f86991b5b29..088dba8355f850b4cb28863116e3654100bb86e5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -40,6 +40,7 @@
 #include "hub.h"
 #include "phy.h"
 #include "otg_productlist.h"
+#include "authent.h"
 
 #define USB_VENDOR_GENESYS_LOGIC		0x05e3
 #define USB_VENDOR_SMSC				0x0424
@@ -2631,6 +2632,10 @@ int usb_new_device(struct usb_device *udev)
 	usb_disable_autosuspend(udev);
 
 	err = usb_enumerate_device(udev);	/* Read descriptors */
+	if (err < 0)
+		goto fail;
+
+	err = usb_authenticate_device(udev);
 	if (err < 0)
 		goto fail;
 	dev_dbg(&udev->dev, "udev %d, busnum %d, minor = %d\n",
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 23f3cb1989f408ecb6b679e6cbe4857384188ae4..53ad9ffdbc4498b1501677fd2ec336dc22c7ce6a 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -529,6 +529,7 @@ static ssize_t usb2_lpm_l1_timeout_show(struct device *dev,
 					char *buf)
 {
 	struct usb_device *udev = to_usb_device(dev);
+
 	return sysfs_emit(buf, "%d\n", udev->l1_params.timeout);
 }
 
@@ -552,6 +553,7 @@ static ssize_t usb2_lpm_besl_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct usb_device *udev = to_usb_device(dev);
+
 	return sysfs_emit(buf, "%d\n", udev->l1_params.besl);
 }
 
@@ -731,6 +733,15 @@ static ssize_t authorized_show(struct device *dev,
 	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
 }
 
+/* show if the device is authenticated (1) or not (0) */
+static ssize_t authenticated_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct usb_device *usb_dev = to_usb_device(dev);
+
+	return sysfs_emit(buf, "%u\n", usb_dev->authenticated);
+}
+
 /*
  * Authorize a device to be used in the system
  *
@@ -755,6 +766,10 @@ static ssize_t authorized_store(struct device *dev,
 static DEVICE_ATTR_IGNORE_LOCKDEP(authorized, S_IRUGO | S_IWUSR,
 				  authorized_show, authorized_store);
 
+
+static DEVICE_ATTR_IGNORE_LOCKDEP(authenticated, S_IRUGO,
+				  authenticated_show, NULL);
+
 /* "Safely remove a device" */
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
@@ -805,6 +820,7 @@ static struct attribute *dev_attrs[] = {
 	&dev_attr_quirks.attr,
 	&dev_attr_avoid_reset_quirk.attr,
 	&dev_attr_authorized.attr,
+	&dev_attr_authenticated.attr,
 	&dev_attr_remove.attr,
 	&dev_attr_ltm_capable.attr,
 #ifdef CONFIG_OF
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0b4685aad2d50337f3cacb2198c95a68ae8eff86..421cec9966912ccc62ce163733f46cab05503bd6 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -46,6 +46,7 @@
 #include <linux/dma-mapping.h>
 
 #include "hub.h"
+#include "authent_netlink.h"
 
 const char *usbcore_name = "usbcore";
 
@@ -1080,6 +1081,13 @@ static int __init usb_init(void)
 	usb_debugfs_init();
 
 	usb_acpi_register();
+
+#ifdef CONFIG_USB_AUTHENTICATION
+	retval = usb_auth_init_netlink();
+	if (retval)
+		goto hub_init_failed;
+#endif
+
 	retval = bus_register(&usb_bus_type);
 	if (retval)
 		goto bus_register_failed;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index b46738701f8dc46085f251379873b6a8a008d99d..e9037c8120b43556f8610f9acb3ad4129e847b98 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -431,6 +431,8 @@ struct usb_host_bos {
 	struct usb_ssp_cap_descriptor	*ssp_cap;
 	struct usb_ss_container_id_descriptor	*ss_id;
 	struct usb_ptm_cap_descriptor	*ptm_cap;
+	/* Authentication capability */
+	struct usb_authent_cap_descriptor *authent_cap;
 };
 
 int __usb_get_extra_descriptor(char *buffer, unsigned size,

-- 
2.50.0


