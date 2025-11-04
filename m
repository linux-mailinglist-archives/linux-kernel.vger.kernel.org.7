Return-Path: <linux-kernel+bounces-884674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F2DC30BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 997EC34E022
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4FE2EAB8E;
	Tue,  4 Nov 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzERjgCF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DD2E03EC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255979; cv=none; b=Ea8cOGei1paxok0XGclkPW9usoCxxReZHfdiy0Jz5PQCTGp/rpLJ6NSxo+zfvLxxlLEdvC3/h5A/2NttivDW1RodXOx1ed7l/EYCeupyPXT/Hk4wgQr9QE52L18Q2ZEsNk5vNJUzsCV85FdWzpLrwXqEuB3znpHTz4b07KV2pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255979; c=relaxed/simple;
	bh=BrmEyFX5UaDMOI+HZP7uLh1hwRFA3aEfIDrRqMAcmaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aixgywpTH2HMJIXtm4UCxkpfp8cahYKsFNNPjMgiLiOeLdDwr6556Zgf9TdqYuEOBj0QalvM8HStba5C2tU04oCauwEhO0GdX+CLAcuD0QiOd2aAle6adevNfuzZk9Dr01nSLB2Pud1o/wj69NptDi82eSdv+XVlWvsUcYdvPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzERjgCF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso166022766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255976; x=1762860776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB5oUHRN+sjBEDImJtxc/YP5+xfGRdtBoe5sSbvsoHs=;
        b=AzERjgCFEMkGNhA5vEUfCmDCa+1His+ZGgLVb7cUNuvaNfhFKDdg70CpHR9Wbdnmx8
         HSJHWCC02UrZzF2e7xWvX30PqUSV6aH+bqKkYb3wqEj7Me7VpHTh1i2EglKyFqnWe6Mk
         +b3hJjbiQC1N6NR0ldiNJgmLVqbJR/e1gmTZcGwOEenQn7Jxg4yP1eA9EUU81EqMNl3W
         s2XM9qVNfpXWyquM3jBaxczGrFq251pxC5cGrMMYL8M+k/a6sR/2h7lJTA+16znDoFwe
         56Ies0O9lmeE9DqxNsG3H5OqA4MWmcwxf9cykleMN4vFB4jCmeIzaZC/PwttP0Nq2kcG
         78hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255976; x=1762860776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB5oUHRN+sjBEDImJtxc/YP5+xfGRdtBoe5sSbvsoHs=;
        b=meqK5Sb6+C8F9dXnLHEpZgRhbHbM+RGFuOiatglOA5OoiZ077rb05uAKL4uD6/WI2C
         alJlSnXPxPr8MQL704Huh4i92EVtUTnk0toPlbrxWnKdT0yUY8nLJOdmR33qrjDx/tev
         nXWBURtc7l7UmNLLklPEmJ5RA47/7mlgj77mcm/6x3QJiuJhbV5D4Wswn2frhbUiHxTG
         CZdRds+N27Maa2VmbbhKGI/QU1kA5Z1tYfh3nCyrilc38qHeq/NAgz43n/HDhxJqDwJz
         cV+HeWeNjyWb4P45rWYMMvSIO+3RRaIStklyLbb1svqUZZEZuNMfb71MzU8rqDfMk7NE
         dInA==
X-Forwarded-Encrypted: i=1; AJvYcCVi7F0TQYHqEN4stW0VidJKP9laiZm8gEN7EU9wu2KE+VW57zZd1wyin/g5UDHT/LK00qJFYC/UHSG3wgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9W8SmN488ii+7jff4dqJUG7I1jiMXQ8dFd0iW7LbSNVcemJM
	sfBV9yrdad5MDXVZxNGyhAmOaWb70lTGIQAafpZYAIFqlZPrG6tOzBGg
X-Gm-Gg: ASbGncsC4tuxNr5VmDZIOF1tlANHIX+udji4Y3vp+85Qy4TCfJcDpjwdT4fqyVoFzRe
	xs2tzMazVFx1gXlvYWbdmE6ePVb5qEJV1/5zHiFNSysaJqvXZFjtaOGJZkdFdji2zHya+r9OA3w
	Appz81Ta2k19xztofJfZEL4FsFwcUbCM3C4+RKKLJSXHc1IxGU0/giLEli1eYvLnXta3XDYxvG2
	pPIwTtghJFoVUpNWBBIogV8jX2A5jW+AirqdpC8T2dAZsiwTX7mrkQj7gnu+nMYpcFq1/9hNoXt
	qe8Q6KgQh1HSI4ZPMwDHgrKTduh1XL4EHQUr2hcTKn7hvOfCyYG7AC5ZrJ/jCtYhW24A3hgt5oM
	jKkRLnJsk6zmhbmL4HJMUJTUaxGiAaARrq1IsUecvDvlwq4eEV5QBHtVQeF3MtSQiIBOLZfJgFk
	Q3puoo+dq7cYaaiCpX5PnHL9VbYVRUYSFKPWsElqCLNGr9vDYiutYNoz/zP3TdgZjy73cxpmvG
X-Google-Smtp-Source: AGHT+IFOV3Ps8Sz7eT1jCBUyreP4B59BwW2YbE+VTDC+/GsVpvA9CcWro96lBn32vwcYP5LatlPrLg==
X-Received: by 2002:a17:907:961e:b0:b2d:e514:5348 with SMTP id a640c23a62f3a-b70704c4014mr1830235466b.33.1762255976028;
        Tue, 04 Nov 2025 03:32:56 -0800 (PST)
Received: from jale-pg.. ([2a02:2a40:17ee:2900:8627:17a2:2166:4084])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72404470e9sm182469766b.70.2025.11.04.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:32:55 -0800 (PST)
From: Jakub Lecki <lec.jakub@gmail.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Lecki <lec.jakub@gmail.com>
Subject: [PATCH 1/3] usbip: Convert CONFIG_USBIP_VHCI_NR_HCS to a module parameter.
Date: Tue,  4 Nov 2025 12:32:46 +0100
Message-ID: <20251104113248.223594-2-lec.jakub@gmail.com>
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

Allow a user to configure the number of USB/IP virtual host controllers
via a new 'num_controllers' module parameter to simplify the usage of
this module.

VHCI controller structures are already dynamically allocated during
module initialization, so the only change is switch from assigning
'vhci_num_controllers' via Kconfig to using the module parameter
framework.

- Remove the USBIP_VHCI_NR_HCS Kconfig option and replace it with a
  module parameter.
- Trim the value of the configured 'num_controllers' parameter if it
  exceeds bounds, and emit a warning.

Signed-off-by: Jakub Lecki <lec.jakub@gmail.com>
---
 drivers/usb/usbip/Kconfig    | 11 -----------
 drivers/usb/usbip/vhci.h     |  9 +++------
 drivers/usb/usbip/vhci_hcd.c | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/usbip/Kconfig b/drivers/usb/usbip/Kconfig
index b9f94e2e278d..bdcb6f4fdbec 100644
--- a/drivers/usb/usbip/Kconfig
+++ b/drivers/usb/usbip/Kconfig
@@ -38,17 +38,6 @@ config USBIP_VHCI_HC_PORTS
 	  host controller driver, this defines number of ports per
 	  USB/IP virtual host controller.
 
-config USBIP_VHCI_NR_HCS
-	int "Number of USB/IP virtual host controllers"
-	range 1 128
-	default 1
-	depends on USBIP_VHCI_HCD
-	help
-	  To increase number of ports available for USB/IP virtual
-	  host controller driver, this defines number of USB/IP
-	  virtual host controllers as if adding physical host
-	  controllers.
-
 config USBIP_HOST
 	tristate "Host driver"
 	depends on USBIP_CORE && USB
diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
index 5659dce1526e..30b8540e0b49 100644
--- a/drivers/usb/usbip/vhci.h
+++ b/drivers/usb/usbip/vhci.h
@@ -82,11 +82,8 @@ enum hub_speed {
 /* Each VHCI has 2 hubs (USB2 and USB3), each has VHCI_HC_PORTS ports */
 #define VHCI_PORTS	(VHCI_HC_PORTS*2)
 
-#ifdef CONFIG_USBIP_VHCI_NR_HCS
-#define VHCI_NR_HCS CONFIG_USBIP_VHCI_NR_HCS
-#else
-#define VHCI_NR_HCS 1
-#endif
+#define VHCI_DEFAULT_NR_HCS 1
+#define VHCI_MAX_NR_HCS 128
 
 #define MAX_STATUS_NAME 16
 
@@ -118,7 +115,7 @@ struct vhci_hcd {
 	struct vhci_device vdev[VHCI_HC_PORTS];
 };
 
-extern int vhci_num_controllers;
+extern unsigned int vhci_num_controllers;
 extern struct vhci *vhcis;
 extern struct attribute_group vhci_attr_group;
 
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index e70fba9f55d6..93c3fa3e1c53 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
 
@@ -44,7 +45,12 @@ static int vhci_get_frame_number(struct usb_hcd *hcd);
 static const char driver_name[] = "vhci_hcd";
 static const char driver_desc[] = "USB/IP Virtual Host Controller";
 
-int vhci_num_controllers = VHCI_NR_HCS;
+unsigned int vhci_num_controllers = VHCI_DEFAULT_NR_HCS;
+module_param_named(num_controllers, vhci_num_controllers, uint, 0444);
+MODULE_PARM_DESC(num_controllers, "Number of USB/IP virtual host controllers (range: 0-"
+		 __MODULE_STRING(VHCI_MAX_NR_HCS) ", default: "
+		 __MODULE_STRING(VHCI_DEFAULT_NR_HCS) ")");
+
 struct vhci *vhcis;
 
 static const char * const bit_desc[] = {
@@ -1510,8 +1516,14 @@ static int __init vhci_hcd_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (vhci_num_controllers < 1)
+	if (vhci_num_controllers < 1) {
+		pr_warn("num_controllers less than 1, setting to 1\n");
 		vhci_num_controllers = 1;
+	} else if (vhci_num_controllers > VHCI_MAX_NR_HCS) {
+		pr_warn("num_controllers too high, limiting to %d\n",
+			VHCI_MAX_NR_HCS);
+		vhci_num_controllers = VHCI_MAX_NR_HCS;
+	}
 
 	vhcis = kcalloc(vhci_num_controllers, sizeof(struct vhci), GFP_KERNEL);
 	if (vhcis == NULL)
-- 
2.43.0


