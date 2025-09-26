Return-Path: <linux-kernel+bounces-834353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8FDBA483D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06547B9726
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9D223DFF;
	Fri, 26 Sep 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HDuFKx+3"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B8223DF6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902180; cv=none; b=RJhEbVXTTggh7jaen/xH+rgOX02jFwjo5D0RNIy1cqVX1Hc/DIiTQnQ3zjg1jTiDcOD+Owpd2iVxVjQ4z+IruLntHbD6+OGcV7ozYgYyMJ/ufKdEr6D5SChQ2tNsByvJG93cHqTv0j3NLCMxDeq0jN/0E9MptfYR/RPeC7/7oCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902180; c=relaxed/simple;
	bh=jBT3t9TqmOvUuXo+L5JgeOAfWMxl3Fw1uFkWEKBH+JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKXcr1B16H6k8wAFWiX9I9elbsdKslFxrZGyZYfmIzo7i+OuYLWAdSfBwE3bM6/0SQeQ+8/M27w1f9CoWyaj6CQI/gEh0E6jLP/Q9opd75L4/ymM5BRg2Gm6aFaLFj4E6KubgrFmW43crq9VztDPJ7b0Rd7uFarQtYCjkk+wfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=HDuFKx+3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32edcc68e0fso330569a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1758902176; x=1759506976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9GEj0KJXkJKEPz0qj0H1HIYcm4p2EKm3HqV/LUjGF4=;
        b=HDuFKx+3t4Jnjl6+C+NKQBhwkURFsZZpLQRBRmst905xxxtRmxPA4NPe4+ozfNZG+w
         9FuBgTTky+X2eyxeHQ1JchVyrGDsbJGRKMNxfM7X4a0AfhVXqIRUliZnLY2HY2a0niCH
         rig/Gq5iBwTKZtzcKde0Y2oLjIWxGpEvWhauGkVExMGrYtrqWCyVWThM0e7WNG72HO9y
         XA1Ykfzp4yP2VTEcwpki9RFvdRjCioqIA9iMlcdOD45hDW33i278uCX0o1/W4AEZ9Qzh
         6W1fod4HC3beJSS3FULrdFKxvHyMCtrxTNZPKQbdZQ3k14jrorAtZwRzaad4iuLiyI9O
         PNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758902176; x=1759506976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9GEj0KJXkJKEPz0qj0H1HIYcm4p2EKm3HqV/LUjGF4=;
        b=lyQtaRS5yco7j3Ou/4euYhr1rtnywewnvGPD7jxzvOy4kgSKPKDyWR4KEyCJPaNM0i
         ODwAHCKGbYdelMT33B7k5BLVGmKXRnOnzfZaqNzj+X4k7X90q4zB5bTgZ1oN/wk+NvLl
         ZtS+CBWU92ob5lV6AcPBZg8RTBzIVGVgpn9d/BpZF1DS9N0ieEuumyLPyWsTGnlKBPD+
         CTSRB7C5MU/f/kV71JP2VOhBjLOKDHFFE3XAjLTPGgP3INRFZpx9IzdDe8xismFyRmls
         yfjV07PdZtaL0kHvsyTh1k9XcaMaqiUu/GGjL9Z+ZCGKY0TiBF9cVajAtK6qUi8jInFV
         J0VA==
X-Forwarded-Encrypted: i=1; AJvYcCWT6KObCbKKP1/GvT17zKfK0b3idd/q06Rnvh3mr3cpj0yXQe25gAODysqpn4R+zRJe9MYkbB4yqEfUnDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZPf/zoCSfxmkWdounpuaDj2AD6zH6k01DzolvkdJ3teUI8HTZ
	cI5LbPNU8zJAf1xkbdG/zuj4Ur6S1CPhibB3BVXSdLAEesxdiYRaAffQKB0UAc+PbA==
X-Gm-Gg: ASbGncuZRfd5D2G2yNqZISI3e9IN/FcPj5eHLJ6njkisa5XwJ5+KZdJUIkXKP8+XIYU
	rSO0smPw0M1SWuNR1qsz+kMye49P7tpfxEwSKjjtpy4cbhUajccoKrgqtvzhd+hFFlfLNMIyIDC
	FYEV8LWlRb3oMHZjHczaMdFn/1ok0PqVAdFU/Qu2wP5G9y9oJs+skJ8/+rmbx/visPw4XYDwOXN
	U/zfMGcuQzx94px9DHM9C6EXcYVhUBWVC1kQotB4UhsanT7TFqnqGzSxCGUfZAVwc91LhQ4qJeo
	GH2KQJ9F54WsKjwaVzAvtCNueaovdNMDJQ7ANIlsmcpUPowbSkb1cIzEyiLlLtGj20XhTMc8F0O
	LjFPEqcDMqXIYPcHMTeAoRPYra8PiOg1x1E78i3vDS/H00oo9CMYVzSwOqcjNSg==
X-Google-Smtp-Source: AGHT+IHYpvURx0gsBG+sKKY2cK33Fv6rQpyBMdPeWuWSvN/csxr26Q5vqgtuPzsMtltBJ3eGHRR4gQ==
X-Received: by 2002:a17:90b:3b81:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-3342a2c67a0mr4583143a91.5.1758902175962;
        Fri, 26 Sep 2025 08:56:15 -0700 (PDT)
Received: from adriana-tpm-wp.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d710f8sm5950277a91.1.2025.09.26.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:56:15 -0700 (PDT)
From: adriana <adriana@arista.com>
To: jdelvare@suse.com,
	linux-kernel@vger.kernel.org
Cc: Adriana Nicolae <adriana@arista.com>
Subject: [PATCH 1/1] DMI: Scan for DMI tbale from DTS info
Date: Fri, 26 Sep 2025 08:56:12 -0700
Message-ID: <20250926155612.2737443-1-adriana@arista.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow DMI decoding to use custom addresses stored in Device Tree

Some bootloaders like U-boot, particularly for the ARM architecture,
provide SMBIOS/DMI tables at a specific memory address. However, these
systems often do not boot using a full UEFI environment, which means the
kernel's standard EFI DMI scanner cannot find these tables.

The bootloader can specify the physical addresses of the SMBIOS and
SMBIOS3 tables in the /chosen node using the "linux,smbios-table" and
linux,smbios3-table properties. This patch hooks into the DMI
initialization process to read these properties, map the tables,
and parse the DMI information.

This extra scan is performed after the standard EFI check fails but
before the fallback memory scan, not to alter the order of DMI scanning
for current implementation.

Signed-off-by: Adriana Nicolae <adriana@arista.com>

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 70d39adf50dc..ea3ed40d0370 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -10,6 +10,9 @@
 #include <linux/random.h>
 #include <asm/dmi.h>
 #include <linux/unaligned.h>
+#if IS_ENABLED(CONFIG_OF)
+#include <linux/of.h>
+#endif
 
 #ifndef SMBIOS_ENTRY_POINT_SCAN_START
 #define SMBIOS_ENTRY_POINT_SCAN_START 0xF0000
@@ -670,6 +673,70 @@ static int __init dmi_smbios3_present(const u8 *buf)
 	return 1;
 }
 
+#if IS_ENABLED(CONFIG_OF)
+/**
+ * dmi_scan_from_dt - Find and parse DMI/SMBIOS tables from the Device Tree
+ *
+ * Checks if the bootloader has passed SMBIOS table addresses via the /chosen
+ * node in the Device Tree. This follows the standard kernel DT bindings and
+ * assumes a fixed 32-byte mapping for the entry point.
+ * Returns true if a valid table is found and successfully parsed.
+ */
+static bool __init dmi_scan_from_dt(void)
+{
+	struct device_node *chosen;
+	const __be64 *prop;
+	char buf[32];
+	void __iomem *p;
+	bool dmi_available = false;
+	u64 addr;
+	int len;
+
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
+		return false;
+
+	/* SMBIOSv3 (64-bit entry point) has priority */
+	prop = of_get_property(chosen, "linux,smbios3-table", &len);
+	if (prop && len >= sizeof(u64)) {
+		addr = be64_to_cpup(prop);
+
+		p = dmi_early_remap(addr, 32);
+		if (p == NULL)
+			goto out;
+
+		memcpy_fromio(buf, p, sizeof(buf));
+		dmi_early_unmap(p, 32);
+
+		if (!dmi_smbios3_present(buf)) {
+			dmi_available = true;
+			goto out;
+		}
+	}
+
+	prop = of_get_property(chosen, "linux,smbios-table", &len);
+	if (prop && len >= sizeof(u64)) {
+		addr = be64_to_cpup(prop);
+
+		p = dmi_early_remap(addr, 32);
+		if (p == NULL)
+			goto out;
+
+		memcpy_fromio(buf, p, sizeof(buf));
+		dmi_early_unmap(p, 32);
+
+		if (!dmi_present(buf))
+			dmi_available = true;
+	}
+
+out:
+	of_node_put(chosen);
+	return dmi_available;
+}
+#else
+static bool __init dmi_scan_from_dt(void) { return false; }
+#endif /* IS_ENABLED(CONFIG_OF) */
+
 static void __init dmi_scan_machine(void)
 {
 	char __iomem *p, *q;
@@ -718,6 +785,13 @@ static void __init dmi_scan_machine(void)
 			dmi_available = 1;
 			return;
 		}
+	} else if (IS_ENABLED(CONFIG_OF) && dmi_scan_from_dt()) {
+		/*
+		 * If EFI is not present or failed, try getting SMBIOS
+		 * tables from the Device Tree.
+		 */
+		dmi_available = 1;
+		return;
 	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)

