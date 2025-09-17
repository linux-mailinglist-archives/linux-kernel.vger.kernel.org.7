Return-Path: <linux-kernel+bounces-820749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53DB7F039
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612741C2503B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC677111;
	Wed, 17 Sep 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIh6sWzB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024C31961D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113900; cv=none; b=t1rFSmyR3zqvIKZSnNeDEq9n8wo05XTMhpMpl+1+sdNlDF1/fWL1D5cXdF9QFyOeYpMj2sp8UkSYui2bttD3N6JK/HbFMPSHH03RGE7yNDB1D5djL2GuyWREiUG7Ql11S2e12pER1nnqi57tFvdnuWaXnsyo5qm0obtMp27MfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113900; c=relaxed/simple;
	bh=ak6nV1E2d4LVFci23EGGom8U88I7l+/p87uI9AS1afo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+cpIH71vEx9JtEkMbyazH4piqvjwMjRTpqy5MnCi8Jk3wN8X3SbK6CIJhCuJSCX3xFdbrB011pJlKULASG80iFVGB5zkKviAExNZcy4ZCMRsJPhGRNVMLTj/5Rm3cLCsENMz4Flfh6/WwOsyhprS+XydBrEV7XiIo9H9zyZfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIh6sWzB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-266fa7a0552so31248515ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758113898; x=1758718698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tBuVt9dADqRllJxGjfK4F6lkGev95OLsmgVZv8CmhY=;
        b=SIh6sWzBS9RUMcqsBwh9Vh7edeuWkLq+EehzFg4XsHL5wPsAGLkf/gOODLFIfjaXgc
         2OWy9KWkWNJeC4p3z7Kzoz1DCMmKk0hYcacXfSGiA+zzGURdc9TyyBwKYLm6QOBLkP7n
         O+8v5BFkkR82LNJ1EV+aYwj1LqBcuosXFU4DU8At4z0XB+M1Yz9O8jII8eVlCyOgFIiu
         Z+I6HYm/8VOKU4cYTtB6wS6PQIN334w45hBOhnCKrpc17T94+J1FUhcml98UaIwEtSIf
         ZhxuB9AnBBTQNtGVGqjKV0Dv/79zTR06kKQlnuWA0Twb8Tkcms+Aa6kbEze6OS6ipGqm
         EpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113898; x=1758718698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tBuVt9dADqRllJxGjfK4F6lkGev95OLsmgVZv8CmhY=;
        b=tFu/V14upkHOjxMEQ5pJwP605gzEIEOQy5Lu4Po6KL/a4NMtGcsfpKNoRcSKjGY88T
         JhEElLE/iJiCZv0WH02tzAO2fAEeEiQP5SFOzZium/aQaj5dJ72LM9Y6IBMHe0hSMLrl
         nI+FPxN9YThTvImXdjHYm3Yp2pgJEubvWwLb0giya+pNtkLaiqFbTYCastoO4FRj61Tm
         tQw64Hq6xLp/veOspm2ieFuZCjmklwHi6csVsjSOLtsnYAv6Rj02OjhX4Lggo8RFIiDY
         PvkSjI1Tc6KcY4jSFrhDLKGJc70rA86ygY/0tw5bWVre0ECIsVrd6XlH6pPi3gsDMA1l
         x+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMNfAleaWmzE3VNrHSKpQ9I+DxQ+WGYrOohek0cUXih+3urnF4vllbBIUbCqRBmjFEpZKBxti2nu85tLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6g380Pb9AKLVFBOFrNU0FAL4Mz8TGe6jwDsPZ8XJhSuhIhUc
	CMzXMH8p4heIO/9bCl+mB7ZuNKZrtXZkGCjaRp8wVbN9nreQ47aVseLZ
X-Gm-Gg: ASbGncsUULi5s46nunIgsv0UrilrInFSpKg+blPgPRWOcOFknwfAioReI0quSCZjxX3
	o/L9LBHEmz++HxxnvI+iDMU/QCwpeX4Jnl8JpeQFZxz6SmDE7f8GJnqfSIr2TEPbeabLLZThd1G
	vxjlrPKXjOvv+v2fts2SJkqK++LPZNyFLLkfeHLk0sKMx54VDGYE2uxjhG5L/FkUrVVEK4xuef0
	lbAwZOm2IkiR8THSy8/59ErK4wo18ijWBwAKwDm+NQG5y8HnYhbfUYwT+JjKIPm155Y3MeZJNkh
	LpAE4vcy4Vp/D727Sp8Jao7Yd5TIElLhtWwNIKZpjdwxTZ4X0jSU/vZVPiVtn5DBQMQY3O3qQzV
	B2u6kNmTH4iuPdcJI9kN17txdD1vcx+Yh81S6yrRahW4DAN6u5U4mXrHXfBSljsUUR6YJbStv
X-Google-Smtp-Source: AGHT+IHozZ9Q7uAq/pNvZNUc5jY+HfRIuoihraMhQzo2yxTjbrT6ZZ7seV8ocXx7uimU2ZiSz/L7Ug==
X-Received: by 2002:a17:903:4109:b0:25b:fad8:d7c2 with SMTP id d9443c01a7336-268137f2945mr17341005ad.39.1758113898335;
        Wed, 17 Sep 2025 05:58:18 -0700 (PDT)
Received: from localhost (99-122-55-39.lightspeed.sntcca.sbcglobal.net. [99.122.55.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2697050c4a5sm6669815ad.16.2025.09.17.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:58:18 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Keith Busch <kbusch@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 1/1] PCI/sysfs: Expose PCI device serial number
Date: Wed, 17 Sep 2025 05:58:14 -0700
Message-ID: <20250917125815.722952-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917125815.722952-1-thepacketgeek@gmail.com>
References: <20250917125815.722952-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only interface for reading PCI device serial
numbers from userspace in a programmatic way. This device attribute
uses the same hexadecimal 1-byte dashed formatting as lspci serial number
capability output. If a device doesn't support the serial number
capability, the serial_number sysfs attribute will not be visible.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Reviewed-by: Mario Limonciello <superm1@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..92debe879ffb 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,12 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../serial_number
+Date:		December 2025
+Contact:	Matthew Wood <thepacketgeek@gmail.com>
+Description:
+		This is visible only for PCI devices that support the serial
+		number extended capability. The file is read only and due to
+		the possible sensitivity of accessible serial numbers, admin
+		only.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..b7b7412c9f00 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -30,6 +30,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/aperture.h>
+#include <linux/unaligned.h>
 #include "pci.h"
 
 #ifndef ARCH_PCI_DEV_GROUPS
@@ -694,6 +695,22 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(boot_vga);
 
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u64 dsn;
+	u8 bytes[8];
+
+	dsn = pci_get_dsn(pci_dev);
+	if (!dsn)
+		return -EIO;
+	put_unaligned_be64(dsn, bytes);
+
+	return sysfs_emit(buf, "%8phD\n", bytes);
+}
+static DEVICE_ATTR_ADMIN_RO(serial_number);
+
 static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 			       const struct bin_attribute *bin_attr, char *buf,
 			       loff_t off, size_t count)
@@ -1698,6 +1715,7 @@ late_initcall(pci_sysfs_init);
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
+	&dev_attr_serial_number.attr,
 	NULL,
 };
 
@@ -1710,6 +1728,9 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
 		return a->mode;
 
+	if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
+		return a->mode;
+
 	return 0;
 }
 
-- 
2.50.1


