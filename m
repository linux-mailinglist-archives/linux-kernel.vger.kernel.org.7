Return-Path: <linux-kernel+bounces-792681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64CB3C78A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0191C80430
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41F26B2D7;
	Sat, 30 Aug 2025 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrKYrwnL"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D166F06B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756522951; cv=none; b=VwD8QEkUWzMvxGrbTIXCXQtvPuIk3HGU0rqQWUkZXaGfcm6XcCzDaxObTy1Rwu2lbZYxNQOHzU2Z0bTKKf3Aoz2fHyQNt4HFZQ5QojwdIZSDjIbT00fMI5O+ijaBn0HeCCHn/fUhfw9UsBso1JJ4hrw/Ucxe28xUTRxv4wJauhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756522951; c=relaxed/simple;
	bh=6zr42pHjg3OpSQ/sPk0BGRH60ITzGAG23tjZ44RvbEg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bm5y03zcHtdB0FSEIJupMOGx1Su5jJwRuUa0spa/vROjg1N5emY9p8veDhLCiHup1stsWgaSUD6fWg7YN1k2ibhCCTXptalLSWLi3YFD46wLKAFJVnas6txOPrZ7ngRMO1JnweegAgxocuSpkyVM1jVrhamGR7uRG/lI9ENpxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrKYrwnL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771ff6f1020so4548123b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756522949; x=1757127749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=osREpVin4Y/mpmkRw1fC7OWCaK3AWMsIQyO6EJyT6ZI=;
        b=YrKYrwnLfZSBZSpFjxJo7PJVdDxEDkUOybz/hSpX1YcIE2xUtdf4AeiIgHKF9CuO6l
         HVYLNxMYL/sP6A9TE8P40kw1M20+tDLUWNX9pdgVgeTrorryABBnSqXZHJspOI2LjKr2
         VGfJlUy7ng1B2KhgqAyvW4U+mz3rKkgRR/Sri0yZBHU8D0y3wjIHc0Bzq5qwsZhH3/jE
         w91q0GMwsydLmQm0uUwwoS3c7iBeRNiLyi/8Lydxppojic/12Mc8YmZn5Iz1h97zYvfV
         GhR/K3ucDf3WPvYi+nM8YLlRwsvgX8QvN+HmDl1Lqeowit23r5rW0ECcglr3y6Cf8VMI
         aWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756522949; x=1757127749;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osREpVin4Y/mpmkRw1fC7OWCaK3AWMsIQyO6EJyT6ZI=;
        b=UTDfFfJCoQ5E6Ev1gTHmB98eZ8mhJBZZaJPNPslC7iCtgtQ2cDhRduWuVIHZPNmt1D
         Ao3Bh3f5vQbnSuJ1bT3Eg8XE3YjobuttiOUq0MZudad7mP7bpmS5Jh9HnRywXPAJlm5y
         4vGmoQzHrpVS5j3jgzxthP0aJvDp5E/IkpmZCNiTUzZU56gtkTwKLrlXqWHbKa7ZNBIp
         5iBkRbN92Kgt01WwgfplQqcbCixwdboaK8yqJjeZaiQucr8MfbJC82ATX2K6gcF2zlaf
         FttEOoqfEBESv14AKwTjFBba5c3hYjStzkBZOhajamL9SsDgHJLNWv2CaY05MzBzRnUd
         T9MA==
X-Forwarded-Encrypted: i=1; AJvYcCXlLsKUjTMOtnFJ3GcPXR2P2F3RQcsyUj5X0Zby4daRDEFqrj67KBqj9TpPgQ550ORDNY0RJtVrUnRvpdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuISpm8XNIkWcrlkGDNglex+LRSmEvHzpcoAb96CDI0zPibmZj
	Qx4r+hRo1HibVAo5Ktn42P1TfCTUJLfLuLl8fQOgjnTPTcBCqdVPbbcP7WgBoH8uWsP6JkMi+6g
	Z1pJbKErh7Hi4JQ==
X-Google-Smtp-Source: AGHT+IGX5cXdB+M3jm6/ruARhMtqvA/JI6+JYqlEuKbtgMUa/fCn/5NVUhdpDm9OSn8XJZG3sXF8vZxeGpuHaA==
X-Received: from pfll14.prod.google.com ([2002:a05:6a00:158e:b0:772:29b7:66ce])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9283:b0:772:270f:58ab with SMTP id d2e1a72fcca58-7723e33853dmr1031378b3a.15.1756522949350;
 Fri, 29 Aug 2025 20:02:29 -0700 (PDT)
Date: Sat, 30 Aug 2025 03:02:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830030226.918555-1-jiaqiyan@google.com>
Subject: [PATCH v2] ACPI: APEI: EINJ: Allow all types of addresses except MMIO
From: Jiaqi Yan <jiaqiyan@google.com>
To: tony.luck@intel.com, rafael@kernel.org
Cc: dan.j.williams@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

EINJ driver today only allows injection request to go through for two
kinds of IORESOURCE_MEM: IORES_DESC_PERSISTENT_MEMORY and
IORES_DESC_SOFT_RESERVED. This check prevents user of EINJ to test
memory corrupted in many interesting areas:

- Legacy persistent memory
- Memory claimed to be used by ACPI tables or NV storage
- Kernel crash memory and others

There is need to test how kernel behaves when something consumes memory
errors in these memory regions. For example, if certain ACPI table is
corrupted, does kernel crash gracefully to prevent "silent data
corruption". For another example, legacy persistent memory, when managed
by Device DAX, does support recovering from Machine Check Exception
raised by memory failure, hence worth to be tested.

However, attempt to inject memory error via EINJ to legacy persistent
memory or ACPI owned memory fails with -EINVAL.

Allow EINJ to inject at address except it is MMIO. Leave it to the BIOS
or firmware to decide what is a legitimate injection target.

In addition to the test done in [1], on a machine having the following
iomem resources:

    ...
    01000000-08ffffff : Crash kernel
    768f0098-768f00a7 : APEI EINJ
    ...
  768f4000-77323fff : ACPI Non-volatile Storage
  77324000-777fefff : ACPI Tables
  777ff000-777fffff : System RAM
  77800000-7fffffff : Reserved
  80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
  90040000-957fffff : PCI Bus 0000:00
  ...
  300000000-3ffffffff : Persistent Memory (legacy)
  ...

I commented __einj_error_inject during the test and just tested when
injecting a memory error at each start address shown above:
- 0x80000000 and 0x90040000 both failed with EINVAL
- request passed through for all other addresses

Changelog

v1 [1] -> v2:
- In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
  door wider and only exclude MMIO per suggestion from Tony [2]
- Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

[1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqiyan@google.com
[2] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094DE6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 drivers/acpi/apei/einj-core.c | 50 +++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2561b045acc7b..904930409fdb2 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -656,6 +656,44 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	return rc;
 }
 
+/* Allow almost all types of address except MMIO. */
+static bool is_allowed_range(u64 base_addr, u64 size)
+{
+	int i;
+	/*
+	 * MMIO region is usually claimed with IORESOURCE_MEM + IORES_DESC_NONE.
+	 * However, IORES_DESC_NONE is treated like a wildcard when we check if
+	 * region intersects with known resource. So do an allow list check for
+	 * IORES_DESCs that definitely or most likely not MMIO.
+	 */
+	int non_mmio_desc[] = {
+		IORES_DESC_CRASH_KERNEL,
+		IORES_DESC_ACPI_TABLES,
+		IORES_DESC_ACPI_NV_STORAGE,
+		IORES_DESC_PERSISTENT_MEMORY,
+		IORES_DESC_PERSISTENT_MEMORY_LEGACY,
+		/* Treat IORES_DESC_DEVICE_PRIVATE_MEMORY as MMIO. */
+		IORES_DESC_RESERVED,
+		IORES_DESC_SOFT_RESERVED,
+		IORES_DESC_CXL,
+	};
+
+	if (region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
+			      == REGION_INTERSECTS)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(non_mmio_desc); ++i) {
+		if (region_intersects(base_addr, size, IORESOURCE_MEM, non_mmio_desc[i])
+				      == REGION_INTERSECTS)
+			return true;
+	}
+
+	if (arch_is_platform_page(base_addr))
+		return true;
+
+	return false;
+}
+
 /* Inject the specified hardware error */
 int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      u64 param4)
@@ -707,14 +745,10 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 	base_addr = param1 & param2;
 	size = ~param2 + 1;
 
-	if (((param2 & PAGE_MASK) != PAGE_MASK) ||
-	    ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
-				!= REGION_INTERSECTS) &&
-	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
-				!= REGION_INTERSECTS) &&
-	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
-				!= REGION_INTERSECTS) &&
-	     !arch_is_platform_page(base_addr)))
+	if ((param2 & PAGE_MASK) != PAGE_MASK)
+		return -EINVAL;
+
+	if (!is_allowed_range(base_addr, size))
 		return -EINVAL;
 
 	if (is_zero_pfn(base_addr >> PAGE_SHIFT))
-- 
2.51.0.318.gd7df087d1a-goog


