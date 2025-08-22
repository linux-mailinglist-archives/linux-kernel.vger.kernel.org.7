Return-Path: <linux-kernel+bounces-781094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC695B30D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E64173F82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2628D8DB;
	Fri, 22 Aug 2025 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjOIaMxO"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420EC2874FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836346; cv=none; b=ZZ9n2OeUCLz0xj0QR3au6DB1opeTgCfNIWHG+NBBhPna9bCoB9GCYpSXDi0RqcxzUtpuYATBP0XfpxPKsCb0V+9+KN/6O5o1xpEBPDrfBK9IQY7ObQYlqxwDRX4HOfVDRNjbweNDp5N7qGGdECTaiDhlOAFC0vjPk/8ulUA6YuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836346; c=relaxed/simple;
	bh=tWp6hE3wqtzBGGf1wcrFiqMq81hqBs2TkYqcSSLJN80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGHAIU1QagqzydEYwglGrSZbmIfEGfw4/2CVSZEq/xc2tpRuytIBNs4XFw+Kwu3evLHYP3We4Mhe7Y5/RgOP2MtcFxrYjuDZAJZe7VqDUORSftPQ8C7jnBL3uTAsPX14LpjCHkgQMWrmQ9D4v4SV8XyuF+WMNh3cZ3HvwMY2EBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjOIaMxO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so1565647b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755836344; x=1756441144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/th4jop1O0kFuAVgwskLm3Kft+pDSyOKRwu3IMOkLA=;
        b=DjOIaMxOH4BHCBdBEvugzvlJMn5H2hU0/wxXXklm6jaQFxYzGz+Nz1L5mT9MsbnGui
         YbymGtAJZZ3ZGbtRKu38ort+wryyq/Zhk8K4qzfbIxWtR3woQ+3haHGg0YstatgkTqlK
         whyrFAQR3TU9a6agWKrWUYyFk5ztMYEPwe/CNo4tQnkVW0g8L1gosErusrypIzz/9OVF
         EuZ2Y9Vz+4EPVtB2AuQUi0BTqXWMRTP0BQ6HEFb4ZrMmDML+wu1Xev5nOaZyIl9+80TU
         VzzCaSuCVTTQZpYMXLA7Un11f2tZHsUmIKRhlxoQtl20dGg/6ctR/IAw4NHpdcr+YTN6
         GyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836344; x=1756441144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/th4jop1O0kFuAVgwskLm3Kft+pDSyOKRwu3IMOkLA=;
        b=SPB7hAbmucSTHnksETJ4grWhmMetlZZjFILvziAG3ngTyb5XFjrHOZ3Fmp8PPGuL6A
         jqN6GSX2w0uUw3Uvlg3ggnTP7oGapq2XbYILnbyMq4J7Gbmyc6bb5mNnsI9MMhnpD2B2
         8SI//w9VcD4peLn9+VYFbecaBuWwKPFzj4bVMIwvOdeSR8rct/5CZVz3GxoF77Mdy4GX
         LH/i9waRrqz8v68xX6nx/ioK4pI+03seY2uJM7KGbcCyGX+no7T2SQR/fNJc10rObmB8
         5TC0HByfP5UP+KfyTAsOryZ73C9jNk6buOEONSYBWW0domniylU6tQWYZKIDNpnAMHV9
         PiJA==
X-Forwarded-Encrypted: i=1; AJvYcCWbONh6W3UonJezYuY+4mww674b/xRcl4E8RsvICzQAxftYh8ldJukuzpUYp7Q6AhQyffPnxffLEFBn1wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAKLNJtpkdTFtYC6RGvMY3v+9wvAMYxDaG3rpg6IzoEhbRyYa
	73HB6ZVnVbaa+UBajtnVmHR29aK1giufBYBec2EHWtp+w+ZqKjmZncBv
X-Gm-Gg: ASbGncs8HSIKqpQ5r1QeKXvaCUpaGipMc3A6ePZV6doMfkXxmD9l8UQpBdn74ZIB1sT
	2Pn1MwgelhUTv6+YhTJENM0VR55ObmRXRrQBNICuYjF5ET1S9QkfIykRHGJj5zr6k5C/sE8JvhH
	mDvP+maboMWOn4OYeBDIWBGiF34fN4kGMLFQwTO5xv90rtrtV3tUuy0RsQ8DZtzWOMNt+UDKAtB
	KsSsHyPm1EkSY3JK7CY1kOoDwU1VhjtHoHzhmC//X29FLMahezqFoXeEl5CJAHQwkVr6XD3wSHQ
	O5syBQkxKfVThvFWUa/YJZzT8wknXcpZRkwb+vMQMUOmASUK+7HXtRzyCAIzAE9bXanfpx2Tden
	qASPZ8PjGOf4S14cD20mG19PkUQFUStz5tneiRN6NbBv/yt5eAKQo2MXjZ5SwKg==
X-Google-Smtp-Source: AGHT+IEli5jcECjFb9Oq0WbfZLt07FMhg6/dC/kxKv6cWdo3v9Z2pQFAHs+/6NRV69eweeHR/lMWFg==
X-Received: by 2002:a05:6a00:3c87:b0:76e:3a11:d23a with SMTP id d2e1a72fcca58-7702fa0f07dmr2276936b3a.4.1755836344270;
        Thu, 21 Aug 2025 21:19:04 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:ba38:b533:dcf5:1e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1375a3sm9534559b3a.43.2025.08.21.21.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:19:03 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 2/3] arm64: mm: Make map_fdt() return mapped pointer
Date: Thu, 21 Aug 2025 21:15:37 -0700
Message-ID: <20250822041538.467514-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250822041538.467514-1-CFSworks@gmail.com>
References: <20250822041538.467514-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently map_fdt() accepts a physical address and relies on the caller
to keep using the same value after mapping, since the implementation
happens to install an identity mapping. This obscures the fact that the
usable pointer is defined by the mapping, not by the input value. Since
the mapping determines pointer validity, it is more natural to produce
the pointer at mapping time.

Change map_fdt() to return a void * pointing to the mapped FDT. This
clarifies the data flow, removes the implicit identity assumption, and
prepares for making map_fdt() accept a phys_addr_t in a follow-up
change.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/kernel/pi/map_kernel.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index 2b3047860230..5dc4107b5a7f 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -191,7 +191,7 @@ static void __init remap_idmap_for_lpa2(void)
 	memset(init_pg_dir, 0, (char *)init_pg_end - (char *)init_pg_dir);
 }
 
-static void __init map_fdt(u64 fdt)
+static void *__init map_fdt(u64 fdt)
 {
 	static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
 	u64 efdt = fdt + MAX_FDT_SIZE;
@@ -205,6 +205,8 @@ static void __init map_fdt(u64 fdt)
 		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL,
 		  (pte_t *)init_idmap_pg_dir, false, 0);
 	dsb(ishst);
+
+	return (void *)fdt;
 }
 
 /*
@@ -238,15 +240,14 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	int root_level = 4 - CONFIG_PGTABLE_LEVELS;
 	int va_bits = VA_BITS;
 	int chosen;
-
-	map_fdt((u64)fdt);
+	void *fdt_mapped = map_fdt((u64)fdt);
 
 	/* Clear BSS and the initial page tables */
 	memset(__bss_start, 0, (char *)init_pg_end - (char *)__bss_start);
 
 	/* Parse the command line for CPU feature overrides */
-	chosen = fdt_path_offset(fdt, chosen_str);
-	init_feature_override(boot_status, fdt, chosen);
+	chosen = fdt_path_offset(fdt_mapped, chosen_str);
+	init_feature_override(boot_status, fdt_mapped, chosen);
 
 	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES) && !cpu_has_lva()) {
 		va_bits = VA_BITS_MIN;
@@ -266,7 +267,7 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	 * fill in the high bits from the seed.
 	 */
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		u64 kaslr_seed = kaslr_early_init(fdt, chosen);
+		u64 kaslr_seed = kaslr_early_init(fdt_mapped, chosen);
 
 		if (kaslr_seed && kaslr_requires_kpti())
 			arm64_use_ng_mappings = ng_mappings_allowed();
-- 
2.49.1


