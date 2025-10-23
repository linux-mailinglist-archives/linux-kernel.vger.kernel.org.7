Return-Path: <linux-kernel+bounces-867040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF6C016EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71FE64FF864
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53E133CEB1;
	Thu, 23 Oct 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GoPbJ9ti"
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6D33C52A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226038; cv=none; b=ExmDZCGgBPoE4eKtj1i0dTHRpnIhI6nz5Oi5YiQC3F/0wuuwBR2l4gelENQXfxGj7KmliIRebShSrMUo2z3fg8XcUmo/opag66d7gw3yGkcm+Y+i5E2YIhuz4faxCBdAJSGsNzPCIs6mSWXmqpAaVu78nu1mxw7ARNLWzxiUOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226038; c=relaxed/simple;
	bh=AXr+tzfOn3Q/HLQ3wexAh6fBD+j+XCPeTmgXNdkLmqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MchM1GxH4HupZzIzLSSChk207MVguznAt3sNVxgxmrVLr1fyP6vbfhujiqBhDQmMb9qJbjxdwe7CkaI/ndNmA2iVtyqOgaSZAdFmbCVRsy9EqEDHJcbX+ce4hsCMQ1OYmxiAfKU/qbyo8QjM6vgBZvo9e3r6fY3teCH+5UqOrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GoPbJ9ti; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-7f7835f4478so6003046d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226036; x=1761830836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbV5rahZ/BOf/pG+Df+z4Hvsda1kZ/x4HpNILftqJqA=;
        b=TAF+1CoiCi5aywXc/gcLedy/DLMSFc7G3TfpqlR3+piSP6XGedP4vvnn979Xis9uM7
         5Rb8gosoNcB35MZJ0c5YTZPkxebOkOZ+ZUq/aNtkoXM0AbC8G2dIdI/49pD+NadH5N6Q
         U59Lmj5Yto+yyJk+wU4qVz7Rot/tpMge2gcQiWIMDrCZ1unTTdLdymHlw6l/H3UlyOhk
         pOz1syhejt6ugmCNcZU3VO74sQUXZX8nwH7rK82c9FvVzCtQcT+wIc0LSR+K8M6hHF37
         NTe5gdcqgfq9drLj5YCyWRGw3RAewmL7UBh8YIEsLuSuXv9agdf2blM/pDlC9xqRVzB9
         VNKg==
X-Forwarded-Encrypted: i=1; AJvYcCUxoN11eSFhOwUHgIdpsJm34k+5Z6iwVvJcdnrJUIIzj5Ki/xAKcIxbse8A/WVgjxCHvQqzR666JaiM7AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uZrIgCJ/3kxlI7He1P0jKQBp3zty/PRk3aOxhl8bloWBlEo3
	ebBhxAhf9p5Pct3dPhNYi8TEKCaO8uKxBQcJrNOXlIWRuqFXR0J39JnRhZnfbhVZt2iI1VJNpfQ
	aoBa73MxBsqtiUrCpGd7QmHL0y8sjf+PiwHV36Pc4U3TnXFF2xUv1iP8+6+euJpGHkSdZS7DKwK
	LKByKgCBKvYDN245GjOWlSQvr4u1gZekmeo2Gk4p9h8iuamRDfXSWlNt3KjxjNobgSxe7Ov67tj
	mGB3yvD6JNOp578EAU=
X-Gm-Gg: ASbGnctD3UkI2H1UXdfOd749KWvvG5q4OgHUFBNtM8q85BYbruDAVC9ie8t6ut9DOjP
	cjpKeo5soI40Vy+mPKITIhJy2ZujOr4v1t8W4Vr5xHWQJjEyrh5qZBvy2242xWoxoOp5lkEusz7
	XDRyOnr/Yb9i59pig22nAJ3JTWpwjcvI6e3Uv0m+BBEBx4OjtZKfZZuOPSQyrLfPlqHpYi49pkF
	c0XLKooxYJUoOE07WkCakYfMsKS03q1C84A/7hHusUZchkdzGrWA84Ne9OhNweyHlzKdSgpx9hK
	cEij1smGU729e8eqC/y8xrzYrnmhGSj2nWWmIYE11s1yzVrNdRO1lldV593CHFcVhDWh1J7/CRk
	moTLJO/Yccs4AgfZ3tTWJPM0C+JcpMKTKUYUU2nxSjUVfueRODYsl2IfzgBTL0qPeNpg5PGp0Wl
	CFX7ehciITz8+2NQfMojUwNyb0KHj3iupbxQ==
X-Google-Smtp-Source: AGHT+IFTOqfHlBFa3+SYEFJVPHJc+D4Uvy6+MQk4aAzRwmAbvdDi4plNo54oh8SdtwYxfTP/sGHnYkGoP+rm
X-Received: by 2002:ad4:5ccb:0:b0:70f:5a6d:a253 with SMTP id 6a1803df08f44-87c20638f95mr242302926d6.49.1761226032933;
        Thu, 23 Oct 2025 06:27:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87f9e82e0a2sm1774386d6.34.2025.10.23.06.27.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:27:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-286a252bfbfso22762715ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761226032; x=1761830832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbV5rahZ/BOf/pG+Df+z4Hvsda1kZ/x4HpNILftqJqA=;
        b=GoPbJ9tiqGuFZw4Gxh8twUCh7/IWU6ZXdXcfcnUzhsxHASIbsdvog+4IEkoEned/d/
         ly/HCigb8UnL4gCgPQhadO15TX/k3GwpPGoubQEtT2dLr8GoTiqoGxz2e1mOQRisttDk
         Y5fsj5f8u5MT2pX8dw1Rgubm0YVYRtfNVM7xg=
X-Forwarded-Encrypted: i=1; AJvYcCUREgQcNzINRxX+CNvZes4Ukv/4qvG5aQY4hzaucUFyUpgm3CmBOSHJ/hqeBRnWnYtT5EyymtzLwOEN2EQ=@vger.kernel.org
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr296052065ad.46.1761226031606;
        Thu, 23 Oct 2025 06:27:11 -0700 (PDT)
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr296051525ad.46.1761226031051;
        Thu, 23 Oct 2025 06:27:11 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc204fsm23739785ad.60.2025.10.23.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:27:10 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: vadim.fedorenko@linux.dev,
	kuba@kernel.org,
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
Subject: [PATCH v3 2/2] ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
Date: Thu, 23 Oct 2025 13:10:48 +0000
Message-Id: <20251023131048.3718441-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
References: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
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
index ea1cbdf34..93d33e5cd 100644
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
+	return ptp_vmw_pclk_read(&ns);
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


