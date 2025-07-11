Return-Path: <linux-kernel+bounces-727217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A23B0169A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E916378D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A8921771F;
	Fri, 11 Jul 2025 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="bke9qQyZ"
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E41198A11;
	Fri, 11 Jul 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223307; cv=none; b=X2tOOmVght4f5Rl6Zz9xglFfzvGIuUnTpOn8DL6Lq3xzYHM4mVyq2qGsqCVVhf7R5Qgh3nbMqNd0+dYIQ6d1Y493EcqRC/3Yem2TO8s2nSxJxlgNXxPlYXYoU43S/KMcENbKi2a2AqfvqqFnzBT+52PzMBlF+7qDZMQobhEqJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223307; c=relaxed/simple;
	bh=zTHB4hJlY161JLI5sZk0fMz9boITT7j07uRbioWEq6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3w3rlzmmDChshhFN/B5PfmqPvR3F1dPHlDlE8G34ejp1n2++EpJPlua4MESTdhxO70U/MKzZmE311LZ+yqMoov77LIyD+Kwv/tu605fxhT0SF2hjrZkmumAYM36SEQu3pgtk16uQ7rghhq2/P++CUdRdE7gKrBidx+Jq5Yakbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=bke9qQyZ; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bXZZPHhYhs3NROUrn2Pw9xRIp4mzednHSudkcwoo9VY=; b=bke9qQyZud7VsACxSw3v3nwMX8
	0aNv7ALivbogtyDy6BKklWNMBayV1t0lnXEHuz34AOi5lYNQ4PnLf6vtHvHRQFRayhsfjDhnUIN10
	XNXY+xTjhWznI5jK0byrXh8lzZ01p051uswtHKK1AIuf8Wu/hZZg6LM2GCeibBg8+/Dz010LjXVjw
	izCARQnnCtDYDmPsP1l7L4anwjRTgFNWr6D0iPo8WAxvhDJhNwHqfbk7mtY25NOAStHFT35cBT1vk
	2WYD8ZevxteHt3iC0uv+QeW4VUipz20WX2xG4FQy/PShgVo+ewFh1cYp1h9w6HeRoXYHbtFo0oMhv
	wSIeZmug==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:16749 helo=[10.224.9.2])
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ua9KD-0000000DVFH-2hsS;
	Fri, 11 Jul 2025 10:41:43 +0200
From: nicolas.bouchinet@oss.cyber.gouv.fr
Date: Fri, 11 Jul 2025 10:41:25 +0200
Subject: [RFC PATCH v2 4/4] usb: core: Add sysctl to configure
 authentication timeouts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-usb_authentication-v2-4-2878690e6b6d@ssi.gouv.fr>
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

The kernel.usb.authent_engine_register_timeout let a user configure in
seconds the time the kernel will wait for a userspace usb authentication
policy engine to register itself.

The kernel.usb.authent_engine_response_timeout let a user configure in
seconds the time the kernel will wait for the registered userspace usb
authentication policy engine to reply to messages.

Co-developed-by: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
Signed-off-by: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 drivers/usb/core/Makefile          |  1 +
 drivers/usb/core/authent.h         | 14 ++++++++++
 drivers/usb/core/authent_netlink.c | 26 +++++++++++-------
 drivers/usb/core/sysctl.c          | 55 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c             |  8 ++++++
 include/linux/usb.h                |  9 +++++++
 6 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 7ba1a89cf3de7a398889eee1820f2bfbbc4280f5..2ec59764fe5ade682368890b4cd30bb3cdad7746 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -15,6 +15,7 @@ endif
 usbcore-$(CONFIG_OF)		+= of.o
 usbcore-$(CONFIG_USB_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
+usbcore-$(CONFIG_SYSCTL)	+= sysctl.o
 
 ifdef CONFIG_USB_ONBOARD_DEV
 usbcore-y			+= ../misc/onboard_usb_dev_pdevs.o
diff --git a/drivers/usb/core/authent.h b/drivers/usb/core/authent.h
index 2cf6d577131084a97f5c30fadaace1eac7e83c11..7c3264793c6ab5d44fa453b3b70c41882c96ff0d 100644
--- a/drivers/usb/core/authent.h
+++ b/drivers/usb/core/authent.h
@@ -169,6 +169,20 @@ struct usb_authent_error_resp_hd {
 	__u8 errorData;
 } __packed;
 
+extern uint usb_auth_wait_userspace_timeout;
+extern uint usb_auth_wait_response_timeout;
+
+#define DEFAULT_USB_AUTHENT_WAIT_USERSPACE_TIMEOUT 30
+#define DEFAULT_USB_AUTHENT_WAIT_RESPONSE_TIMEOUT 300
+
+#ifdef CONFIG_SYSCTL
+extern int usb_register_sysctl(void);
+extern void usb_unregister_sysctl(void);
+#else
+# define usb_auth_init_sysctl() (0)
+# define usb_auth_exit_sysctl() do { } while (0)
+#endif
+
 #ifdef CONFIG_USB_AUTHENTICATION
 int usb_authenticate_device(struct usb_device *dev);
 #else
diff --git a/drivers/usb/core/authent_netlink.c b/drivers/usb/core/authent_netlink.c
index 9848f219e0e4807563f0f0432a0f1108cd6a0454..731ecadee934ae712735dae5932c0e595720245d 100644
--- a/drivers/usb/core/authent_netlink.c
+++ b/drivers/usb/core/authent_netlink.c
@@ -21,11 +21,15 @@
 #include <uapi/linux/usb/usb_auth_netlink.h>
 #include "authent.h"
 #include "authent_netlink.h"
+#include "authent.h"
 
 #define WAIT_USERSPACE_TIMEOUT 30
 #define WAIT_RESPONSE_TIMEOUT 300
 #define USBAUTH_MAX_RESP_SIZE 128
 
+uint usb_auth_wait_userspace_timeout = DEFAULT_USB_AUTHENT_WAIT_USERSPACE_TIMEOUT;
+uint usb_auth_wait_response_timeout = DEFAULT_USB_AUTHENT_WAIT_RESPONSE_TIMEOUT;
+
 /**
  * struct usb_auth_req - Define an outstanding request between the kernel and userspace
  *
@@ -609,7 +613,8 @@ int usb_policy_engine_check_digest(const u32 route, const u8 *const digests,
 		return -EINVAL;
 	}
 
-	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0, HZ * WAIT_USERSPACE_TIMEOUT)) {
+	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0,
+				HZ * usb_auth_wait_userspace_timeout)) {
 		pr_err("%s: userspace not available\n", __func__);
 		return -ECOMM;
 	}
@@ -675,7 +680,7 @@ int usb_policy_engine_check_digest(const u32 route, const u8 *const digests,
 
 	if (!wait_event_timeout(usb_req_wq,
 				usb_auth_outstanding_reqs[index].done == 1,
-				HZ * WAIT_RESPONSE_TIMEOUT)) {
+				HZ * usb_auth_wait_response_timeout)) {
 		pr_err("%s: userspace response not available\n", __func__);
 		usb_auth_release_reqs_slot(index);
 		return -ECOMM;
@@ -740,7 +745,8 @@ int usb_policy_engine_check_cert_chain(const u32 route,
 		return -EINVAL;
 	}
 
-	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0, HZ * WAIT_USERSPACE_TIMEOUT)) {
+	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0,
+				HZ * usb_auth_wait_userspace_timeout)) {
 		pr_err("%s: userspace not available\n", __func__);
 		return -ECOMM;
 	}
@@ -814,7 +820,7 @@ int usb_policy_engine_check_cert_chain(const u32 route,
 
 	if (!wait_event_timeout(usb_req_wq,
 				usb_auth_outstanding_reqs[index].done == 1,
-				HZ * WAIT_RESPONSE_TIMEOUT)) {
+				HZ * usb_auth_wait_response_timeout)) {
 		pr_err("%s: userspace response not available\n", __func__);
 		usb_auth_release_reqs_slot(index);
 		return -ECOMM;
@@ -852,8 +858,8 @@ int usb_policy_engine_generate_challenge(const u32 id, u8 *nonce)
 	struct sk_buff *skb = NULL;
 	u32 index = 0;
 
-	/* Arbitrary 30s wait before giving up */
-	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0, HZ * WAIT_USERSPACE_TIMEOUT)) {
+	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0,
+				HZ * usb_auth_wait_userspace_timeout)) {
 		pr_err("%s: userspace not available\n", __func__);
 		return -ECOMM;
 	}
@@ -902,7 +908,7 @@ int usb_policy_engine_generate_challenge(const u32 id, u8 *nonce)
 
 	if (!wait_event_timeout(usb_req_wq,
 				usb_auth_outstanding_reqs[index].done == 1,
-				HZ * WAIT_RESPONSE_TIMEOUT)) {
+				HZ * usb_auth_wait_response_timeout)) {
 		pr_err("%s: userspace response not available\n", __func__);
 		usb_auth_release_reqs_slot(index);
 		return -ECOMM;
@@ -953,7 +959,8 @@ int usb_policy_engine_check_challenge(const u32 id,
 		return -EINVAL;
 	}
 
-	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0, HZ * WAIT_USERSPACE_TIMEOUT)) {
+	if (!wait_event_timeout(usb_req_wq, pol_eng_pid != 0,
+				HZ * usb_auth_wait_userspace_timeout)) {
 		pr_err("%s: userspace not available\n", __func__);
 		return -ECOMM;
 	}
@@ -1016,9 +1023,10 @@ int usb_policy_engine_check_challenge(const u32 id,
 		       __func__, ret);
 		return -ECOMM;
 	}
+
 	if (!wait_event_timeout(usb_req_wq,
 				usb_auth_outstanding_reqs[index].done == 1,
-				HZ * WAIT_RESPONSE_TIMEOUT)) {
+				HZ * usb_auth_wait_response_timeout)) {
 		pr_err("%s: userspace response not available\n", __func__);
 		usb_auth_release_reqs_slot(index);
 		return -ECOMM;
diff --git a/drivers/usb/core/sysctl.c b/drivers/usb/core/sysctl.c
new file mode 100644
index 0000000000000000000000000000000000000000..a9f917e34e8e914cb60653a56fa90a4790bf6011
--- /dev/null
+++ b/drivers/usb/core/sysctl.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPDX-FileCopyrightText: (C) 2025 ANSSI
+ *
+ * USB Authentication netlink interface
+ *
+ * Author: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
+ * Author: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
+ *
+ */
+
+#include <linux/sysctl.h>
+#include <linux/usb.h>
+#include "authent.h"
+
+static const unsigned long max_ms = 3600;
+
+static const struct ctl_table usb_sysctls[] = {
+#ifdef	CONFIG_USB_AUTHENTICATION
+	{
+		.procname	= "authent_engine_register_timeout",
+		.data		= &usb_auth_wait_userspace_timeout,
+		.maxlen		= sizeof(usb_auth_wait_userspace_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void*)&max_ms,
+	},
+	{
+		.procname	= "authent_engine_response_timeout",
+		.data		= &usb_auth_wait_response_timeout,
+		.maxlen		= sizeof(usb_auth_wait_response_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void*)&max_ms,
+	},
+#endif
+};
+
+static struct ctl_table_header *usb_sysctl_table;
+
+int __init usb_register_sysctl(void)
+{
+	usb_sysctl_table = register_sysctl("kernel/usb", usb_sysctls);
+	if (!usb_sysctl_table)
+		return -ENOMEM;
+	return 0;
+}
+
+void usb_unregister_sysctl(void)
+{
+	unregister_sysctl_table(usb_sysctl_table);
+	usb_sysctl_table = NULL;
+}
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 421cec9966912ccc62ce163733f46cab05503bd6..0d88a072146dc0ec88314733ae92c835585f722d 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -46,6 +46,7 @@
 #include <linux/dma-mapping.h>
 
 #include "hub.h"
+#include "authent.h"
 #include "authent_netlink.h"
 
 const char *usbcore_name = "usbcore";
@@ -1082,6 +1083,10 @@ static int __init usb_init(void)
 
 	usb_acpi_register();
 
+	retval = usb_register_sysctl();
+	if (retval)
+		goto sysctl_init_failed;
+
 #ifdef CONFIG_USB_AUTHENTICATION
 	retval = usb_auth_init_netlink();
 	if (retval)
@@ -1127,6 +1132,8 @@ static int __init usb_init(void)
 bus_notifier_failed:
 	bus_unregister(&usb_bus_type);
 bus_register_failed:
+	usb_unregister_sysctl();
+sysctl_init_failed:
 	usb_acpi_unregister();
 	usb_debugfs_cleanup();
 out:
@@ -1151,6 +1158,7 @@ static void __exit usb_exit(void)
 	class_unregister(&usbmisc_class);
 	bus_unregister_notifier(&usb_bus_type, &usb_bus_nb);
 	bus_unregister(&usb_bus_type);
+	usb_unregister_sysctl();
 	usb_acpi_unregister();
 	usb_debugfs_cleanup();
 	idr_destroy(&usb_bus_idr);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index e9037c8120b43556f8610f9acb3ad4129e847b98..b616c0fb79be33aace2c052ea3ecd1dd0641a024 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -2062,6 +2062,15 @@ extern void usb_led_activity(enum usb_led_event ev);
 static inline void usb_led_activity(enum usb_led_event ev) {}
 #endif
 
+/* sysctl.c */
+#ifdef CONFIG_SYSCTL
+extern int usb_register_sysctl(void);
+extern void usb_unregister_sysctl(void);
+#else
+static inline int usb_register_sysctl(void) { return 0; }
+static inline void usb_unregister_sysctl(void) { }
+#endif /* CONFIG_SYSCTL */
+
 #endif  /* __KERNEL__ */
 
 #endif

-- 
2.50.0


