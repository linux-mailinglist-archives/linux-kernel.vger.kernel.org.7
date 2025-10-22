Return-Path: <linux-kernel+bounces-864863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DCDBFBB85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D79188FC60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71342344051;
	Wed, 22 Oct 2025 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="irN70r0l"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95334027C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133542; cv=none; b=Bv4VwsF8RtqN3rqAEJuVkTP7bG9gpD2TvWEHG9xuOV4wI1+sIMUyyXgAkOQeAUQcld9jj30Ur0khIVkty3iYi8F2/2gUyvn9h3u7fHEVia0nnu7QPzBuqjrY20e+Sv45ci1KYUo+6OOtBYOseRnTTny+v6zamF9BepPPsPfa+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133542; c=relaxed/simple;
	bh=L6JltfCgzavNx7wMkMNh/+Sx1qS8gsYLxOCNUpGaA9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAsE6b6qwiX7ESss2i4RYLLqZ/M3AAmNWHfZpwf+m08sucec2rLXcwBUNvX0zwgPnTz7JW4MBOsZcxv/2eWWKk/SETq3BlJ/GrbN+0zjQTWi5ugp6BncRI5EEOU+tCD04YhUdIQMlAEXVeGrkHEMynMUhnmjruG1CvxIR7kCApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=irN70r0l; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33ba9084e8bso870217a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761133540; x=1761738340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUX8HZ6vji5tBt32jdysfYoNvgGz6oeEx0DeGQXcliE=;
        b=irN70r0lD8wWlavJD1oe8iNSvBWviU1QShS8zUdLoX5uwLmNiLy5o7o+E7k+oVPBqd
         cEef2Xx9XMQhxdfE7NWnE8TmYJ9ZMLCyY6gevOUi025v2c/MTe3czvPVJXYtk9P6HIDB
         lKCTTEJNAEuNOAeE7i44QNgTnx9sTd9/TmFx4GxX7/ToGF8h1zsoTvrkf34xJa7PdRTj
         2UVSkUJ5XERIM+/7gFeLEaPoObfVYKgom9xS8l5/lkdbTmop0bkE5Xa35DJ1u7PLcE/h
         PZK3OW98uhj0OELj67Go0r68hhqdm/BZGtENukb0fMkwxshex4Oy1dy86R7xLVaacgKb
         b6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133540; x=1761738340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUX8HZ6vji5tBt32jdysfYoNvgGz6oeEx0DeGQXcliE=;
        b=dPyktNL8wAKaEjEKOPACQo4+ncKcSW8hWRduI5pXICb6e1xXAimQAG5FA+iQMgpgWq
         vo3BJUrksy4Nwf3z0Co4Ax4P/Fusm8DtgZtzL+yV+ubDsf3WbNjlgWFs3ig9ILQpOMcE
         ghqsIC+OPA9Eje3sClJhQ8jvR7p/qx9gpA/9gbK51ZFSCYyvzYRoZuhPbj73Ar7cXNGQ
         6npZkcVZD+X9CLKAH8p4AIFyzmU0w5Jk+TZ7l60kHRvELjrw2vqnW0sXLbDhoybGd3/w
         4w5vh3xbHfElCWy3RfseHkxdgVrfGVFNkkoh9lNOlRjQPowMWeaPFoPsbB4lTL5dOkuZ
         aptg==
X-Forwarded-Encrypted: i=1; AJvYcCW6mXQIB9AYkQgIZedUe5kGsvxFIIY7UGZ8kXMjKYY121AP/L3KiK8rsjNaxqdk6LiLsFOVsojeUwLg0CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgriVM73NkIgjwHiL5F88Gx3J7nwAJFK/Ybvcv08EvR6wAnZJ1
	Y0yuIa40AlpVUsQDDLSPMiiYcAJUgYHMpzYQgEHaUG8NfLhOszQAIhDFs/fnWl9ipg==
X-Gm-Gg: ASbGncvstw2/63GZHvXF+NmnF5AtK8a/QdBjW2g3+xUKX0hX3niEHI5NubEFQWYamSj
	LiFikqyyRc1kr5Uo138edjX7SwS6X1c7NeZ79NuDPF9WWSaTZE9gGe8yBr6zyoCtlWK49X8MteG
	K+3GxiXsGw1n2s4n3Io6yPNwWamS9TRpw1uIgK2cTc18LDDvkD+NVRVuHDAwQdKvit+dbPvAS/B
	Mg3T/XM8jUfr7SF/41Z88vNKHphRH4GMqDC2TxpfElF06chIFjzpQDyKWBDd2hG7DYpJYGD/XW3
	wPs4jYo0DGm6SqRYl8yw26gnNRp9PXOOtspNgDFiEqmKS76/vjLQoZbEb2md6qvc/jk9u/3ioij
	mVbhe9zoWw1O+OMOP5mSDX996Gb1S8WM967hAKuSY6d4kaNA7sdyD4k/dei/pj+pSiIim4rXZG6
	ZOrL1/Q/y2nBPo3CPuceMkXOg87Mv9JQCI5F55MJUxU6b6Lro/9WC09mEIEaj3oT4=
X-Google-Smtp-Source: AGHT+IF6fs9LU+FUhR5ZsckfVqatI9W+gmk2N89hg8LOW5kKhLh+JL5lxioJxKuw+nOPcN8XHnqdOg==
X-Received: by 2002:a17:90b:3852:b0:32e:8c14:5cfb with SMTP id 98e67ed59e1d1-33dfab10b4emr4732611a91.1.1761133539850;
        Wed, 22 Oct 2025 04:45:39 -0700 (PDT)
Received: from adriana-field-alert-pcie.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22416d3csm2399895a91.18.2025.10.22.04.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:45:39 -0700 (PDT)
From: adriana <adriana@arista.com>
To: krzk@kernel.org,
	robh+dt@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com
Cc: linux-arm-kernel@lists.infradread.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	adriana@arista.com
Subject: [PATCH v2 2/2] drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT
Date: Wed, 22 Oct 2025 04:45:27 -0700
Message-ID: <20251022114527.618908-3-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114527.618908-1-adriana@arista.com>
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: adriana <adriana@arista.com>
---
 drivers/firmware/dmi_scan.c | 74 +++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

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
-- 
2.51.0


