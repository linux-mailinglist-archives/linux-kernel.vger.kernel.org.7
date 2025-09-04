Return-Path: <linux-kernel+bounces-799646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97DB42E76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0DF1BC44A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FFC1CBEB9;
	Thu,  4 Sep 2025 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpr8od7W"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098029D0E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947159; cv=none; b=lujUBP3y2oq4LCDYL3ClZQBL8ZNBejEzMOTU331MtUTG2xNf1JgWV9NkWsrMrnlfXPupqwPXcStD8OAdC7X80F9yiw1SR6ty4yVeXGI1RcqOInTGOG6QgrGwmIGneo8tzOu3rfQ53OGYlk5nZk21d1+hG9GXvnuhMqSFSIWge2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947159; c=relaxed/simple;
	bh=tWp6hE3wqtzBGGf1wcrFiqMq81hqBs2TkYqcSSLJN80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7Ne9UH4wiByTvyNVethc5CdAzdFSlSKxqueoGxJZzJCAR3/bcEzZsEQ9+ryltqAkcFZOcTWGbyfvFmg3unvm/0k0FkPDCCHgejmia49A+bqTBuXy//MUGyglDdOxbhjNP79dDfJ4PWSy56nlRH9hvgiji0XX9FnMWx4Ijl4npY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpr8od7W; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso349662a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756947157; x=1757551957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/th4jop1O0kFuAVgwskLm3Kft+pDSyOKRwu3IMOkLA=;
        b=kpr8od7WitkMbzNkjit0+IGsDgt1hOCLNVsKUsDOL+F77Gbh0QwgJCM9LpAxSQt2tT
         RH26qHf8UpczWWd7wwaYvyML9QtTKNXlTXkG7BENw1BKf1+IWNT6ctfj3hSSA6dPYASu
         E81SGPYB96209v4ECUO2xBSnCbXmL+fdAudrGQjQmFH50ic0Ax7FP0XoYrynczft4kY9
         kFtn7vq76v5OJFJENs2MsRhwlNeMQr5gl0pq29wNb0SVwMtHu8kURFTRIa6H8vJ2+FXQ
         Zr9FWUhBfR8Lg6cgRtco0nw/5dCGS5qc6UQZiRfspBvDiMcwpZup0KRKbBmeUIGxpvst
         rDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947157; x=1757551957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/th4jop1O0kFuAVgwskLm3Kft+pDSyOKRwu3IMOkLA=;
        b=Qs5zCWfsqMOJK/oxuZC1kMfu2VMnofYd1wDep4uV0xpfuNaU2wcbjhfsKo9qJ/g6YM
         NABgcHLAFIBQslSnDKMFthnMVdmfwt8KTzSURX3vA/xwjauvR2WXW/Z1HOX3swPzztAE
         6UWJIo/ssiejpD61B1P+GoAS42djctZ+w24dFMnsqjIm74bNHlAQyBaH7p5959x5PgfW
         cte60Ex1h7/JuDAO3hDISROCNPszK+Wrj1+nxu/orHRcf1d3EcLeZSgUwjiUbtEGtoN7
         jHmZjJFIcxOYkQJOyJH7sof4kK2lpAz2RgsZZxC9vidcH3ttXUZKKALtFMeoxRBhgFIg
         DVdw==
X-Forwarded-Encrypted: i=1; AJvYcCX9Rrc2IXPDq3mL1nqZK6E/iqyHHpkBVyPFWCzbzuXWvLuzXPQqfzBlGNj2sEPrWTQcC0C7aFOz/FCzrw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBL8AvGHthDLahr2JGJ+tgk2NeH3MerTX8UWOSUZMhuasQAoi
	RrjsEegnCw5txZimNnGVdnyFgwwpAGUzc6tl7Bjp8/FHDG0/L/d3m+1Y
X-Gm-Gg: ASbGnctFWiEvLk5pzMorqruPzKCIcbRX6dG1/zLYjyK2VRv2PMxe937OCwU5Ca2q7gC
	8ZS1W9NQRd+GXZ4DNsERfB7Hn3fLZ+RpqoDVEorZohhJPfwzineofnZzZSuTgYXqvp9JnMI+B+5
	eWzh7aFSwCeCPK/MHSIUK0pe6tm/iF7F4CvXsv1B+VQeDeKbgpVg0gJqUSrNn0kigrLSByqbnzY
	adhED0hsNQs1LPTLMrPBE9SPSKsrBNDecwidMBy+sn0Zs43KTKenP+CgcQFN2XNQuVsZUKrsMAR
	hrnrUR5fEjP1icWSBf158S+mvwXokXAFUyvCoMI2mzCTlbLM4PYdQ7WqqFlHAwqURtIFf0ZhBo2
	07jZ9ViLb2pe2fKcLcOxUMExvkMWTjtxKLkyAVssWTIk5CmBp6WQ6cmv/kw3P
X-Google-Smtp-Source: AGHT+IHXTSNI5t71w5e+WgB8B52Hvu9vci+qQdskTPpSKSg3A5yenk7DiQMoYc/Whz1X4xBXi6xZAg==
X-Received: by 2002:a17:903:2cf:b0:248:79d4:93b5 with SMTP id d9443c01a7336-24944a9d32bmr220968295ad.33.1756947157070;
        Wed, 03 Sep 2025 17:52:37 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:882:283c:10f0:c999])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28b3849sm15748931a12.31.2025.09.03.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:52:36 -0700 (PDT)
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
Subject: [PATCH v2 2/3] arm64: mm: Make map_fdt() return mapped pointer
Date: Wed,  3 Sep 2025 17:52:08 -0700
Message-ID: <20250904005209.1494370-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250904005209.1494370-1-CFSworks@gmail.com>
References: <20250904005209.1494370-1-CFSworks@gmail.com>
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


