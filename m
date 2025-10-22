Return-Path: <linux-kernel+bounces-864472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB98BFADD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B7D3B8330
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B16302767;
	Wed, 22 Oct 2025 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PxBc25pC"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461173054F2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121318; cv=none; b=agTeO+4apyRWsq/BJwWM7laKarUvmLbQmrZKLxIcYzZr2lEgbv36zZ7arUmG7pMSEHhTg/jZdmWxgugvLkopZ3YuVWdHVfF6n5OBCcQ/IKp7rG5PeY0qmJr5l12ZjGLAYGIxcztvJ3zRVqgDWRQM1EO0ukF/qo8iW4fNh540l6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121318; c=relaxed/simple;
	bh=lv2uVhZqfWH9WVsgYRtW9amrl5GZHACKCdqnmaRN7GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHeiUWwTJGfUOM4Fi6Kd6C9RMOKRGjGSUPkS0Miwa01ZX1UqfYSz2NzyFowA6ChUNdlgWuKu3rteVBtO/gE8X+FtpYt1dvHHtxKCbSRbRjGdWs/eLnXQ8wOBSuQiNSk8997/ous3kGmjBLYEWYSTMgsK37jQbccHbzedtTwR2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=PxBc25pC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso502165a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761121316; x=1761726116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbLHC9QwAR9eOpe2xgT+y+OECBmxM2cqKB9QacBZTUs=;
        b=PxBc25pCLCfHnGVE4yrG9ZdK3XFrGGJb5WstUYZDRNgXjPBqy1ztPTURS9jo24QQcf
         3DE6JXdAWWZ+1NThIw3bUBUxjrP2M+Jf7G/CRKNFSzCcNTK1cktWM3GC23L95FQpozIm
         F3i4Y/mo5+aEBYfAFDiEEveENp1TTddYHwGRT7blxj8eUf9GL2S9JNZOWsHdQYYZMX+3
         lTqyyjvUuVXPM6LuRveBxrjshIgltC11lfnLiUMntUsrhas6Dx1Sc6pAcPvvKuOOT7FZ
         TBdnYUXVzyGm5gHp7v6tE9LmOFwqM+s/Wqa/NKnsaxl3wRZK12NW6cOurZPAxz706xB4
         z82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121316; x=1761726116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbLHC9QwAR9eOpe2xgT+y+OECBmxM2cqKB9QacBZTUs=;
        b=GX2mx2OIQz7t9zXVZnsBGhMt0D6YGT7oSzA9JGUMrtBAWCO+YFqMR9RzeGbWEskcTO
         OMhBnMut30fKCXDQPX5BNVtLv/8KK5vQleq5efnXoUb4BpbqRyrxyyHaeI8aX7ZJ6rAC
         AFIdbYW5+5xLYSFR50meDIZ58EDn2GdtlaxHGRxtPtUh87eeubYLpv/1Ml9pqmLXghDr
         14jP6+KJKl2Q9fAFvnv9fdN6owMUBK473y/FpP4x4VMy54V/AGIC2FJJLukPPVv2QtxE
         Uoikzm9qsyFPtpXHxMPZJt9G8zNO2Cn7Sv7P3XdwFZn5bCxs369YBdxZoroiKrm+17Cx
         lIVQ==
X-Gm-Message-State: AOJu0Yw7/Y63yr3nxKtcM6YdqIhfOl0KAPhiuOf2hAu1kp04GnF8dSLu
	G5MnmLXasON1LOKCLAz3E/QDC2fKvHloPzjwqtHBWaLbP8kTR7YyYYWyHn+5cYNCAQ==
X-Gm-Gg: ASbGncuoNpv8YoyejOUrYHXkMdaAxhOLlucSyMqCkv9RHZVxw8YgSKtZCyby2X7r+o+
	mWEZRvw3UBWDLt8+GuAdcfz6AepszW+aqP5SoCwb7iBGSvZ4ngjObGntXe+40wTo1K1e+7abTYO
	WJWYOMG/SYYg0JQSRl7iW4brvX3+sjm7Lxj9sE7bmxxAWmYk/q/yfDa1wnO7EKxnjkDBj83094K
	x4owTFWh1WeET0lBil0aA24BXEeqUdE0cBfd7xE4m//v9KP7jMfH95lb2uvSgadn6qtEcaXV7jx
	hfOQmJPk8M96WHuRjnleamOsnFtAHSf7aeSSA+Ml0JMjand9I+evC3Yb+HqTFuFJvb6lrGmBuNd
	GYBOyybq6sqL2nTGzhFgrYgP2z73FbebzlzI6Q2nZUk3kYtDa22wwdtoyRTChP8ICb6g0IrnmGn
	wQGasIovjUx6T7d5/LLwaPDWLoCVhneKWaH+McaXq16K+Rr+iNFAQxsA==
X-Google-Smtp-Source: AGHT+IEq1VTnJQxlOmueu6s2GebaKNeFLbAzcYm2sgg1sCqMQhIRzeaeT1dxwWuPL3kl8Wo0a8Ua8A==
X-Received: by 2002:a05:6a20:430a:b0:334:8d22:f94a with SMTP id adf61e73a8af0-3392f61dc01mr4867714637.1.1761121316207;
        Wed, 22 Oct 2025 01:21:56 -0700 (PDT)
Received: from adriana-show-mem3.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223cba14sm1854292a91.2.2025.10.22.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:21:55 -0700 (PDT)
From: adriana@arista.com
To: linux-arm-kernel@lists.infradead.org,
	jdelvare@suse.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: linux-kernel@vger.kernel.org,
	vasilykh@arista.com,
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH 1/1] DMI: Scan for DMI table from DTS info
Date: Wed, 22 Oct 2025 01:21:29 -0700
Message-ID: <20251022082129.138217-1-adriana@arista.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

