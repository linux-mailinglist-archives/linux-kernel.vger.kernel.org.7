Return-Path: <linux-kernel+bounces-781093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CBBB30D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11351174AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC228C5D3;
	Fri, 22 Aug 2025 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkdMWD3w"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82952773FC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836345; cv=none; b=YP0ePgknCeHR5iHWUTLPkRReG6p5FgCAcptmyO2C/Vg7HhLS4epqGkLMvS84UUZjtVH+SgO8a3O9MTueVJif/bkDevGtx7bbqqJynlDe8FQcRtkT6K877A+S5Er9cuQ0Irnjexed8Tg2G1MDNsPAvZeCkPdiNTqEsfPYNf+Hq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836345; c=relaxed/simple;
	bh=GIZugSgwf/IBguNIs/OK7zQTIvb/FRn9sZYfy6LkexM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwjRckUyPL/jpiPJgaqmfwbwZuhyU/FQODFa3uW/Bn98yWIw7h1EPu9GT255kox7Zc1i4ncEr8rYjInB1Cru0Pg4GG5YZv4HJcGtOR/92SWp9rVfbaj51QLFU7qObfCVQF3SKzNZmVROcjIhaogu4M4eeW9/9BW9Tb7/8tg2iIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkdMWD3w; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-245f3784edcso16470555ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755836343; x=1756441143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/PtowZWncD7g5yzTgjrgtYoRGlVEb75A6E0NAaBaiE=;
        b=IkdMWD3wfRgALWgAGQAIvEQ4DdBnkwpMjqB8fGVUqJRL7OTSRYkV+PbbxuSQShDhi2
         YsqC4hbJ8VNdrH0UZOtTrwGY1CNtwBPYyfd1ZzloJp4s59A/p15jL0sNBw4th+x5OgUf
         QkwxYQl7Xn0KA3ITKPDZfZSHedMiQi5Ck2UfwwAuSA7PYYofLVE2ieTeBz8WE6+PeKmw
         gDs3jvk5FoVDqGDP48OSjaQ9IZFq+trQu2Kr28p08jNtuGeDAZ/6gVIWNmj3KACd1CHu
         O4YarMvY99sG52otCXVzsVhr3WB6ZOKXDb+j2MfhwxBpdJBj3hGeCzrdxTMZf8TcLcnV
         9Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836343; x=1756441143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/PtowZWncD7g5yzTgjrgtYoRGlVEb75A6E0NAaBaiE=;
        b=Nq+cxhcNM9LFzcSU6Q+fsgVL+5O2aI82MtmDfB4XqJyPn5cPOp0/o8sbVRqxIh5IAb
         aCipaMXgOBhQU/vosu/nJg1CTNfJVtEO/mW1PwfU8v0QBT22ps3kYJv9sZ0uNMEWAWWb
         Ky69y9VjZfnkAtZZHfdxMnBRg1STA3QsYuYW+5ZNPPDrMEoHAmg7LZBCzdz42hT4nDww
         WX4qgGT2f3Gg4HfkcjeutWNASJ7KGEmNwrjG4DYE5N+VwpHSOaexk829UdF8A/382/xM
         QfOzrvpd6TxxsZSJzlfO5qHXkPYZNb4J5T/wGB+dCdJscOOiI36IIPwnT2uc6smB0keh
         zKiw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQRD6+GqXDemggpdlkghqqfqkXIZJfDTnbwDaAZ4jjqsuyRyD/ejtSEv4fKCHPFWq0U6/JQnaqYTLnb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuKhx6MskU5ImVtvpHmS2e+uSYbMbXbmhGCmIolSTz4hC8EQA
	QVEFwDqkA8h2ql2ILjEEHHb14zJsqSdoY/yiCzY4m8D1gWcaTrSav45n
X-Gm-Gg: ASbGncuHeftSQYZlpOx4XlNvRqcJ+QO/D+X68sOUkOQhPX2v3M5a3W+nkmerXb2LI27
	zCNjS+W5/rPAAeURFuKrDsLQcM2hWY4iN8btsAoagvQYITrBTCh/+BF3iH6EovsoZNOeFzm2JnK
	XFT00jCYR+ZW1h+1voK8VPtCGCoqzFx68VIqwjN0nRl2pm8UNtc4+b+N5LXFEeDhCgSH3snJgpU
	x1o8nXuaO+1i/nkESYjJIqSHa5tNcMua5OMd0t0dBTk1aNVhWjdimiRZQDGnlYdSOhGplYhZN9Q
	ReY5jiAKG1Y5H28GKyF2wiTKw4kTBohWsHgsL9+Xi7UmiDApuaqqt6TUXsW5lto8//uW2rhZ8FJ
	aqXQwqcX0O5NkQU2lSJZAWRJL/x/T9FtOOjsmQdMHZUoTRpgFYfYg9nn4SuNwUA==
X-Google-Smtp-Source: AGHT+IHNKJplTG9Jy38Tlom7qmiWaoZeBRK6WRgraG0jbKbTwm9Axuv3DgJMIKeBlkJFFWOqnZNZLg==
X-Received: by 2002:a17:902:db0c:b0:240:483:dc3a with SMTP id d9443c01a7336-2462edee860mr24421865ad.12.1755836343119;
        Thu, 21 Aug 2025 21:19:03 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:ba38:b533:dcf5:1e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1375a3sm9534559b3a.43.2025.08.21.21.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:19:02 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: mm: Cast start/end markers to char *, not u64
Date: Thu, 21 Aug 2025 21:15:36 -0700
Message-ID: <20250822041538.467514-2-CFSworks@gmail.com>
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

There are a few memset() calls in map_kernel.c that cast marker-symbol
addresses to u64 in order to perform pointer subtraction (range size
computation).

Cast them with (char *) instead, aligning with idiomatic C pointer
arithmetic.

This patch provably has no effect at runtime: I have verified that
.text of vmlinux is identical after this change.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/kernel/pi/map_kernel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index 0f4bd7771859..2b3047860230 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -179,7 +179,7 @@ static void __init remap_idmap_for_lpa2(void)
 	 * Don't bother with the FDT, we no longer need it after this.
 	 */
 	memset(init_idmap_pg_dir, 0,
-	       (u64)init_idmap_pg_end - (u64)init_idmap_pg_dir);
+	       (char *)init_idmap_pg_end - (char *)init_idmap_pg_dir);
 
 	create_init_idmap(init_idmap_pg_dir, mask);
 	dsb(ishst);
@@ -188,7 +188,7 @@ static void __init remap_idmap_for_lpa2(void)
 	set_ttbr0_for_lpa2((u64)init_idmap_pg_dir);
 
 	/* wipe the temporary ID map from memory */
-	memset(init_pg_dir, 0, (u64)init_pg_end - (u64)init_pg_dir);
+	memset(init_pg_dir, 0, (char *)init_pg_end - (char *)init_pg_dir);
 }
 
 static void __init map_fdt(u64 fdt)
@@ -242,7 +242,7 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	map_fdt((u64)fdt);
 
 	/* Clear BSS and the initial page tables */
-	memset(__bss_start, 0, (u64)init_pg_end - (u64)__bss_start);
+	memset(__bss_start, 0, (char *)init_pg_end - (char *)__bss_start);
 
 	/* Parse the command line for CPU feature overrides */
 	chosen = fdt_path_offset(fdt, chosen_str);
-- 
2.49.1


