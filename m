Return-Path: <linux-kernel+bounces-864786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE239BFB8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 932FF4F27A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100BC32B9B2;
	Wed, 22 Oct 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aizQs/xl"
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366032AABC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131239; cv=none; b=BGZJtkywV4HDNqBLbHRDkrQ6o2ejKeAyBsi7GknNiYV6LnlnwCuEw/7cR01c7scIGk8JYz/MeG3cbTcDz79z2Uh/MLn+b4eCyHakRXdfRxc/pbmwuGgwhi1PbUMQBmg7bqcmNlZlK6ihT6DAMp7jVh2V3K78OHGiJuZm4ZkvZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131239; c=relaxed/simple;
	bh=FwmuKze520gii68OMa9zuCrP0na+LNpw1uC7/S6jaX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqxWb4TCPXSp/1BUU81CxYnBJYqR+wSLuvWg6CwhwtDM7b0OUDWcPdmqlayL/UgcU0XpWeg22qVy9/6rcAjI+TM9KsKVlfp2E1EGhGRnv3j5eYLKzS+n07dx3ySrgd8BeI/dCtgfJkR1tV/QdKPzCHZEEh02awvXBB4Op7PSVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aizQs/xl; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b6cdba26639so728102a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131236; x=1761736036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fB5PRpKOjT2mJVqyOTvbhIcOjE9XXiUVHYGkgGRTqY=;
        b=DWh1JuwSHa4mINVcrxhy+6otXesCk5jQOfrnhUKbX78lum55TOzC9HuQj0jqRllyM6
         pxB7fY0Hh8N4hCT+yuPvjFYFeaOtz4hr2c/KCHrrFoXts4cqnaJCas7kySfRCS10B401
         DD2RGuStF6EGvfOK6I+fL3anTxlWHGt9iBeG3A2NV7xt13CDp2ffGafmYe7jGGodbq9r
         bNYs2efqh0kUSG37gmFGwtimQZdr3RR9aCiFYqdLpKBTkE/RNrrwcJcZ4O/yyTas8CSo
         wyoN/sudJhG7Y5yNGgir1c2ZmYPFUJhyp2J6L/G2YadW82VldvgeUToCADDpFEMbOeMl
         iJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMzBdy+V3HAAYrTLWF4SATNHlv+CGPbgga7VAa17VgC66IHD5OOypbqMY/Z2yWtrfGdaUTvwuN2jGC//M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwFRYyjppPWgUhUN6seGhRg40FDyyhn/hpDj43IlsULHMesbB
	2zVxEjTXXmw7+Df+q2fh9gl0E+YZV9zuiL5XG3E4vqptQokJZA/iVDUBV/Kx8lB3rD1a7sXd5c7
	NcitHsawGmOwilpTKKXJyoYgrVy6lNME3myPthnhMSYz+VTa/oukw6nK5cAv3pj/VhuA7V7QioS
	4ZxLhiEel/9INffPPJD9OkBUegcTRkYNpAUdQkuwtY1lxRObHavQQDupOA9CbyBZyVxyU/SiEpT
	9d+JmNekoO+VOk+5w0=
X-Gm-Gg: ASbGncuZfDYoCLEtKSEozB0ceUkOkLqCFAm9G36rInX/F/RjFhECnmNQbR8jDsCJX+1
	8MYQffluL14cjbInCUPdEvJtSbDKw9p3w9sHBoBujQBMB9LCJuSGytuIPsxaVatowwo48vPtSse
	WYYGIuS/x6FU5/2BT6itFXpyn/ktZUswbaXNNwXMKsUUr5t6bvCa303983qRfNB0YkuMY0RQjqP
	f4nJUWY6zHLTfeGubza5AhBvJ5kwbtdPes9DfvgciNoeXr0+9i/42PhGHTWhTzYiZ3uTggO2FTT
	ru5iLFf0mw08Hm1TYPWT+e3TXkHcEPT50dPIpv/U1AH90t2Og8ZHltfiReXsj+Yrm1Qj9xVSRO+
	4kxs8RGtLbgJVIkadWTAqU3ijC/cYo9svHOsQ5FDrBtPf2UcumH94qv154TqVoUzq+/Uh81ic9T
	JZZXRUPVLxd37wcZMxJigBkE5Ts0iiqawxTg==
X-Google-Smtp-Source: AGHT+IHC6UXhfJVWFAAAgdeTZc6vXcuiZuPo79UrqpIwmSoqMw6qSBELHay3kjEUxaLSkQeY7VJooPvq7t4Y
X-Received: by 2002:a17:903:37c4:b0:290:ad7a:bb50 with SMTP id d9443c01a7336-2935e126d63mr10580785ad.27.1761131236072;
        Wed, 22 Oct 2025 04:07:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-292471c6169sm13917175ad.34.2025.10.22.04.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:07:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290992f9693so7275715ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761131234; x=1761736034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fB5PRpKOjT2mJVqyOTvbhIcOjE9XXiUVHYGkgGRTqY=;
        b=aizQs/xl1mUCkYcHScPFtQ7m6Xo42IEhSXoVn1079raFotWqloKvt13J4bHOCksUzb
         gdzZyeKpbkjSMGuytQ4A2X60bUX/59GitketaHL/ueN++ZAU/RR7S5ZTWk37c2r+W8uH
         mY6ELD3BEHGQlWKjjzPUg41NxEAvwoZ3lO5Ag=
X-Forwarded-Encrypted: i=1; AJvYcCXyrXXXw1pnLpo/zXARHMMe2m6xh/n0t3v3fRYpRKmo916U7T/lpy2rJQouUwJMnDBR443CDlUR05av4nk=@vger.kernel.org
X-Received: by 2002:a17:902:d509:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-292ffc97bfamr41948665ad.29.1761131234306;
        Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
X-Received: by 2002:a17:902:d509:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-292ffc97bfamr41948175ad.29.1761131233780;
        Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm135964955ad.52.2025.10.22.04.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	richardcochran@gmail.com,
	nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	jiashengjiangcool@gmail.com,
	andrew@lunn.ch,
	viswanathiyyappan@gmail.com,
	vadim.fedorenko@linux.dev,
	wei.fang@nxp.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	cjubran@nvidia.com,
	dtatulea@nvidia.com,
	tariqt@nvidia.com
Cc: netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	shubham-sg.gupta@broadcom.com,
	karen.wang@broadcom.com,
	hari-krishna.ginka@broadcom.com,
	ajay.kaher@broadcom.com
Subject: [PATCH v2 2/2] ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
Date: Wed, 22 Oct 2025 10:51:28 +0000
Message-Id: <20251022105128.3679902-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
References: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

For scenerios when ACPI is disabled, allow ptp_vmw driver to be
loaded by directly probing for the device using VMware hypercalls.

VMware precision clock virtual device is exposed as a platform ACPI
device in its virtual chipset hardware. Its driver - ptp_vmw - is
registered with the ACPI bus for discovery and binding. On systems
where ACPI is disabled, such as virtual machines optimized for fast
boot times, this means that the device is not discoverable and cannot
be loaded. Since the device operations are performed via VMware
hypercalls, the ACPI sub-system can be by-passed and manually loaded.

Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
Cc: Nick Shi <nick.shi@broadcom.com>
Tested-by: Karen Wang <karen.wang@broadcom.com>
Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/ptp/ptp_vmw.c | 70 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 7d117eee4..a3978501a 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -98,25 +98,41 @@ static struct ptp_clock_info ptp_vmw_clock_info = {
 	.enable		= ptp_vmw_enable,
 };
 
+static int ptp_vmw_clock_register(void)
+{
+	ptp_vmw_clock = ptp_clock_register(&ptp_vmw_clock_info, NULL);
+	if (IS_ERR(ptp_vmw_clock)) {
+		pr_err("ptp_vmw: Failed to register ptp clock\n");
+		return PTR_ERR(ptp_vmw_clock);
+	}
+	pr_debug("ptp_vmw: ptp clock registered\n");
+	return 0;
+}
+
+static void ptp_vmw_clock_unregister(void)
+{
+	ptp_clock_unregister(ptp_vmw_clock);
+	ptp_vmw_clock = NULL;
+	pr_debug("ptp_vmw: ptp clock unregistered\n");
+}
+
 /*
  * ACPI driver ops for VMware "precision clock" virtual device.
  */
 
 static int ptp_vmw_acpi_add(struct acpi_device *device)
 {
-	ptp_vmw_clock = ptp_clock_register(&ptp_vmw_clock_info, NULL);
-	if (IS_ERR(ptp_vmw_clock)) {
-		pr_err("failed to register ptp clock\n");
-		return PTR_ERR(ptp_vmw_clock);
-	}
+	int ret = ptp_vmw_clock_register();
 
-	ptp_vmw_acpi_device = device;
-	return 0;
+	if (ret == 0)
+		ptp_vmw_acpi_device = device;
+	return ret;
 }
 
 static void ptp_vmw_acpi_remove(struct acpi_device *device)
 {
-	ptp_clock_unregister(ptp_vmw_clock);
+	ptp_vmw_clock_unregister();
+	ptp_vmw_acpi_device = NULL;
 }
 
 static const struct acpi_device_id ptp_vmw_acpi_device_ids[] = {
@@ -135,16 +151,46 @@ static struct acpi_driver ptp_vmw_acpi_driver = {
 	},
 };
 
+/*
+ * Probe existence of device by poking at a command. If successful,
+ * register as a PTP clock. This is a fallback option for when ACPI
+ * is not available.
+ */
+static int ptp_vmw_probe(void)
+{
+	u64 ns;
+
+	return ptp_vmw_pclk_read(VMWARE_CMD_PCLK_GETTIME, &ns);
+}
+
 static int __init ptp_vmw_init(void)
 {
-	if (x86_hyper_type != X86_HYPER_VMWARE)
-		return -1;
-	return acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+	int error = -ENODEV;
+
+	if (x86_hyper_type != X86_HYPER_VMWARE) {
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (!acpi_disabled) {
+		error = acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+		if (!error)
+			goto out;
+	}
+
+	if (!ptp_vmw_probe())
+		error = ptp_vmw_clock_register();
+
+out:
+	return error;
 }
 
 static void __exit ptp_vmw_exit(void)
 {
-	acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+	if (!acpi_disabled && ptp_vmw_acpi_device)
+		acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+	else if (ptp_vmw_clock)
+		ptp_vmw_clock_unregister();
 }
 
 module_init(ptp_vmw_init);
-- 
2.40.4


