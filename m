Return-Path: <linux-kernel+bounces-799644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36CB42E73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7191566B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43C1A23B9;
	Thu,  4 Sep 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsx7ApRZ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DF14B977
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947158; cv=none; b=PHRzd0No6nqP2lhSJ0WaM1hjP9f/fBtzu4Iwjnfgr2iKPtfQPt6RISzBbU/ymK9GsuAvInwHji+ELyD9CwcfPt8k1I2YtnxTp2/hRa4H/w6k00PaGnfxqILcoJyOzXaNZH/9UDN7N+ARsH4JcBTEJ0Nd2RzBM4ninICliKi8nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947158; c=relaxed/simple;
	bh=GIZugSgwf/IBguNIs/OK7zQTIvb/FRn9sZYfy6LkexM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIBNP1/SLmGA4+lQmwm64EiNr7q2AocYfV7OTav1OXYmZov8z0iwVehqwWkWZOSC796vHbjBoUpUwao1t6JlxOA7DjbrB0cDNJQNIrby3fO+Owtdi6UDB92VFanwbRUtrLAdmCQY9Ra3CVFtrvjB6Kt/0EbvEgfPJXWN7ajz8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsx7ApRZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772301f8ae2so443764b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756947156; x=1757551956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/PtowZWncD7g5yzTgjrgtYoRGlVEb75A6E0NAaBaiE=;
        b=jsx7ApRZkteAr076MZOm3LWed4IcQsWw8CaHNoJpMGRBgBmR4repnZ6l5RvMEdYVq1
         6GCTS7XkUs08dxa8YecHJ+YkZHJPklf/JxDqcBBNMIpztSBy0fWGerCPzBGNGVVhR2i4
         WJvms5m66E+dwmVH/UNRQ5zexohYojmZpUSqmJpvdA2/m/VQxJ5A1s1ZdwuBUMG49vGy
         Cf0bfrXHVCse/bK2uPf5r5Z1YSSlDVWje8clg79tkI3NIDbGvZYJj1/GX0ltD9QXj31W
         CmrcwDL1GRHLqjQsm/ARHR0KBmNoFWoWP1vyZxKK2ECWZ6oUfCKTfRsMOvqIu2UFftFO
         84ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947156; x=1757551956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/PtowZWncD7g5yzTgjrgtYoRGlVEb75A6E0NAaBaiE=;
        b=wr4QuJeevXMxMFVUFXXkQhuVfrA1iZkf56RpzexU73X+/P6QmCxCjOx4pUxltSJElS
         OqUtGNEUaH44d6cuWU40Qm9lPK1LSGkPWmIdYMKDQUnB6FXGra1aCCZuiAk3Wcw0Hd7n
         1nneHh1ZuAeyowz0Vozs+fEUO183Cggcnpz+rdQuzIqb/hEfEN63PdcjYgW86hp6QeLn
         bLN1lBKpphOiITrU3gaq9C4QDXXaac7jDJbZGFB6e4tmKP7FyPVbefidxH1mFjqbF9bE
         alI+o0CbiZU7iN6GdGCWMATZT/68AHpWqZDCSx+dosS2Tn00fSChUR+QOZb3KMDL52Z5
         XRvA==
X-Forwarded-Encrypted: i=1; AJvYcCVgp5dmcLXldSntQ3U1wwl+BaO1ybIxEjxHmAEQt98XQ8kSq5mFhgappGzmvvvEbSB7y4GCf44/Oy/4ch0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznP8JuVQoCps5YCiVS8KW7/+yuokva9g5T3LqRw7pi/96iJqfg
	acO2877FH1L9SykzRDxkfLApEu8mJR1HAuNGWv4sA1ynpMV/zO7TZlTF
X-Gm-Gg: ASbGncsm1lHef/5tw3EfrNpa8imNgFfABJ1UaMKHiPuXxULo3re1GSJwxBMFTX8ZeT4
	6yIyvlcRrwQzrakkDtWFPV9WjIryZnvYZPxxRHXCaDnKxcnD5XP6JLf2YQo1EpQgvKtmIcPmh+g
	FCH4eNIstgHg2egSsBhoi6AMUYJXojL7msKTK3t8Brjm5KkPTT0xmTQjavVUVaPJ2v/ihMxdC/L
	o+z147frj3uhw9f5bD8ifJUAs1s3XBveCIkMdHVLZiip9UEPCvuuJrzkhPoCSg0Oma3TV33Ci3A
	c2bqgukxWMbJMM5UOaCxV9Hcdu2gG8+4nwlz10pIVLtaNYyNPpE4Gak1IBZYMR9MkLC931pbAkO
	wnTgCuhukZYzwvt+6AXsM3+9dyfRgnC3V+03RcHsXAIRPunU9zDh7jnj4i7ly+9oroLoIfU8=
X-Google-Smtp-Source: AGHT+IGZaqd4bARj+mLl0wXBwvmUgoSDL0+9kDhmB01XllE5NOEa7P4aqnIE1ZquOyLN5o/MJ3L6Vw==
X-Received: by 2002:a05:6a20:12c4:b0:249:1867:c905 with SMTP id adf61e73a8af0-24918864e0fmr5294229637.15.1756947155824;
        Wed, 03 Sep 2025 17:52:35 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:882:283c:10f0:c999])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28b3849sm15748931a12.31.2025.09.03.17.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:52:35 -0700 (PDT)
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
Subject: [PATCH v2 1/3] arm64: mm: Cast start/end markers to char *, not u64
Date: Wed,  3 Sep 2025 17:52:07 -0700
Message-ID: <20250904005209.1494370-2-CFSworks@gmail.com>
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


