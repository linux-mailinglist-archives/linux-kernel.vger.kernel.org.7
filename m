Return-Path: <linux-kernel+bounces-880107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72991C24E44
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2B774E8E44
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2289347FE9;
	Fri, 31 Oct 2025 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Yr4acq+/"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CB347BD3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911967; cv=none; b=pjMYRTcLorDMrNJI/p6zarE5hU8neNkrwO173mRp2xpwnqncrcjMOAmdW8exC56fJuofhsauD6c6V66kG5UJwbqHvj0SutROPFxpqRwc+UpkSGIVlf5jw3trmUyc8aKE53EpJpkJ4uLn+SRP667+XtaypesdjiRKRBM0rzFWlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911967; c=relaxed/simple;
	bh=D42feF7Ra4/K72e9drq2XRHrZVi3EwpbjwQpI372NEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKZkfmFBVR03IhJnrXDlH5h+YcrCT8IdWE3YJP+6LegvPjQQ2dPjzyWV/8LjxU+hIPhfJWGvCsWvESpi/Tw0rcFHDcuil5xb8Oa3uhP429F0BA62orS/ZhUAupn3PUBjli3HcwnvamKz5Zwc3n43RgvPopc0GbDCimtqoPxE/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Yr4acq+/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5509894ee9so216310a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761911965; x=1762516765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L/hLbOSJZ62/cohmFNCdfLoT09DKZ/2Z5/IUj8+nso=;
        b=Yr4acq+/QV6YxQntWGLGy0aOcVXu+lrMKDpH6QM7GudSLyukKwIdcp8ILU7jEgbl96
         fnUWacKLeEPRMT+cmYlTU21HpJohYX7AiUgXgj9P5seIlO7Lvebd75bZFF5WUCpY4z1T
         Wut8eqnt4+vHGh2bylkQ5jJmbqJI27cjCEO1p+aaKx9lZO5WmwB/7op8wPjEBOru8xFR
         ZWZtHcIoUVdX/RR3zj4fNB06Om786DY4lV6Y2NXdbrkUSuBSEilNp8C6I0h73AO13FaG
         3tZ+BndDPd22j7ANu+2Ng+OWaLEuGIMwgEqRC/2/m/1vvFU2LqYEaT+pO3+EOrDxD80A
         ihBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911965; x=1762516765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9L/hLbOSJZ62/cohmFNCdfLoT09DKZ/2Z5/IUj8+nso=;
        b=Q1Sw8f81ZUTsx82ecAlrqFiLp4Ci5hKNYe7sSbGQu+kjEfTcnZKgh9kQ9EfS5Xg9+j
         RHp8kNi+vGThod842dcXJEF4gwSTcMuW7esr/yj7QOnOkYMBys3hN/dzLJIGtKClAWxh
         uX+vUksIXbCY9xE7+3u8xR2Nct0sXVR3kZdj++Qj6jGCDa4Xhj8j+YagoIPbgi3HZ84z
         MxGJEJC1m809BViz0ClOncMmaSImz0lTSLGo/2WbYqXNdj1/KjQ77RMPkwwEiEJafSYF
         4SzeEdLRMTDyXV/L4YLXrOET0aAGvAsvptmnfiIFzAr7sRr03vIuQCtaPMCfLnfQCeoW
         PDmA==
X-Forwarded-Encrypted: i=1; AJvYcCUaYU3NCCoHogf0WQNhJK/88vPK/V3Tlo2FARGMBasfiLV/GiZ/LxzfKqLydOrco7ee4K4OhknavVBa0Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE6IBANQI77mSykyPBVNzu8Y7MJ/kHFHYaBKmHGrjkwG+LmLP
	qoQaBtF0F7oHSNrliCXHXZtseXxR1OI2y5zY7WtSvJ5BVLiTw3QJIu2zxVsVloPqKQ==
X-Gm-Gg: ASbGncuiGcsEO/gY381knDpxg2lr3OagK74LUfEQOFISt5r6GRdTTsFPDR/c4BSBSQE
	fbvvDI+Qit3JoTt/VCAPZSCTqeY/TMx2Eo0nslUb3FjoNrQ4V0cldt7SFCbx0esCCR5A9SYcVZ2
	/PwJ/3V4Dlou328cYFrirFzCaMyXD05gUKniejs8tktcwfURYpnk1WU3Q2OoHvn43f+8SbYhttJ
	1boiGaghGILQ77SJYnLhqew30gCSeusMNUWnxZX2U+/l0XR2aqg6Rp6BNQRuuk9Xf7QgdxAPdED
	MgFrCES+g2RRwL8FhlZToZbZF2Yq3pDy2TV2FKgCJkhZ4rvhZXp8nfl1kUI1X27ZQHXw8xpyGJc
	UwePelmiJX4hemwPfqydCRexr19ENacxgXVfYilFmnYn6WfdUvvTMt6JaWxdgoGtLexgzLhX/bd
	zcaawg8esnELU6kDc0wnQtyN1Sdk4DYJ2bC7Z1
X-Google-Smtp-Source: AGHT+IHpdOm2VD1n2Q7JgSULhaxQAGxS24N8LsCwk6ynnldxFPyu7tTqUMeajeJ5eRtPPaJqzMrAKg==
X-Received: by 2002:a05:6a00:3a0e:b0:781:21db:4e06 with SMTP id d2e1a72fcca58-7a7745559b4mr2256138b3a.0.1761911964694;
        Fri, 31 Oct 2025 04:59:24 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7dbb61839sm1973837b3a.71.2025.10.31.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:59:24 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com,
	robh@kernel.org
Cc: krzk@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	arm.ebbr-discuss@arm.com,
	boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org,
	uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org,
	adriana <adriana@arista.com>
Subject: [PATCH v5 1/1] drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT
Date: Fri, 31 Oct 2025 04:59:17 -0700
Message-ID: <20251031115917.713105-2-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031115917.713105-1-adriana@arista.com>
References: <20251031101009.704759-1-adriana@arista.com>
 <20251031115917.713105-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bootloaders provide SMBIOS/DMI tables at a specific memory address,
particularly on non-EFI ARM platforms. The kernel's standard EFI DMI
scanner cannot find these tables.

This patch adds a fallback mechanism to the DMI scanner to read the
physical address of the SMBIOS3 entry point from the device tree.

This scan is performed only if the standard EFI check fails.

Signed-off-by: adriana <adriana@arista.com>
---
 drivers/firmware/dmi_scan.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 70d39adf50dc..82f1848e79fd 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -10,10 +10,12 @@
 #include <linux/random.h>
 #include <asm/dmi.h>
 #include <linux/unaligned.h>
+#include <linux/of.h>
 
 #ifndef SMBIOS_ENTRY_POINT_SCAN_START
 #define SMBIOS_ENTRY_POINT_SCAN_START 0xF0000
 #endif
+#define SMBIOS3_ENTRY_POINT_SIZE 32
 
 struct kobject *dmi_kobj;
 EXPORT_SYMBOL_GPL(dmi_kobj);
@@ -670,6 +672,51 @@ static int __init dmi_smbios3_present(const u8 *buf)
 	return 1;
 }
 
+/**
+ * dmi_scan_from_dt - Find SMBIOS3 entrypoint address via Device Tree
+ *
+ * Checks if the bootloader has passed the physical address of the
+ * SMBIOS3 entrypoint structure via the "smbios3-entrypoint" property
+ * in the /chosen node.
+ * Returns true if a valid entrypoint is found.
+ */
+static bool __init dmi_scan_from_dt(void)
+{
+	struct device_node *chosen;
+	const __be64 *prop;
+	char buf[SMBIOS3_ENTRY_POINT_SIZE];
+	void __iomem *p;
+	bool dmi_available = false;
+	u64 addr;
+	int len;
+
+	if(!IS_ENABLED(CONFIG_OF))
+		return false;
+
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
+		return false;
+
+	prop = of_get_property(chosen, "smbios3-entrypoint", &len);
+	if (prop && len >= sizeof(u64)) {
+		addr = be64_to_cpup(prop);
+
+		p = dmi_early_remap(addr, SMBIOS3_ENTRY_POINT_SIZE);
+		if (!p)
+			goto out;
+
+		memcpy_fromio(buf, p, sizeof(buf));
+		dmi_early_unmap(p, SMBIOS3_ENTRY_POINT_SIZE);
+
+		if (!dmi_smbios3_present(buf))
+			dmi_available = true;
+	}
+
+out:
+	of_node_put(chosen);
+	return dmi_available;
+}
+
 static void __init dmi_scan_machine(void)
 {
 	char __iomem *p, *q;
@@ -718,6 +765,13 @@ static void __init dmi_scan_machine(void)
 			dmi_available = 1;
 			return;
 		}
+	} else if (dmi_scan_from_dt()) {
+		/*
+		 * If EFI is not present or failed, try getting SMBIOS3
+		 * entrypoint from the Device Tree.
+		 */
+		dmi_available = 1;
+		return;
 	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)
-- 
2.51.0


