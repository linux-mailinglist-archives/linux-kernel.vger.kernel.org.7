Return-Path: <linux-kernel+bounces-890883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A43C4146E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF15F4EB573
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8632779A;
	Fri,  7 Nov 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbFtGopI"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D37338F26
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539994; cv=none; b=DTTD0NqmXqYcMRl0LJ68GfVn6f2hr1mRDhI0VhMoQGFztn+EUvivzrGKp5uixRLWsYqWqL8G2NPYr/Ol1ySL7/KpAdniN2CF1gUQvgP2gfqlJKO/1zGNhfooT7Oa1zj1xqCTcsoqX/N0wgWovRRgHo/wD2ARSX3yu0WV2qw4qaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539994; c=relaxed/simple;
	bh=JC1j6urnvkNvSsIzRQ9B98PsVzHqekonCvD1bHmUnYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FP6W9eZwl6TaqdRSa2dxlOcShRuv4udRueBikux8wqfFurIzG2IczCf7s6xzxVtbYCSkRtthfjiY2cseMtiUj/pM0Lbs9wTczT1hurNpo+d/ct+fUfGVy1gHAeDNH3oKRSBQFma1KNvWdkNazX1CGqWJWjx2M1d+T9aPG2PmOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbFtGopI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so1205655b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762539992; x=1763144792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0k2DDkmTgl9KtJMxVJka+jshTEvze38uwk10/MjPY4=;
        b=JbFtGopIiM6a7Qf12LpRvClrXlMN9q8hsSOHeZ1xdEWwcK2fz+9M4buYZT72bWoHS2
         ljbUCbKmjyuokl/C3cELSCCpdGxkk+qOv3MnxbJJnmUqgU4ZuGjJUYDbVXU/8OMzdktX
         5HNZ9OnAkG+t1FiM9Vi0AQOYI7K/RZkSLMJO/vCTUZHtRTFpeFTT9T0OQdRISPg3Vx6K
         AuuR+u+0qfDgbyqGueyL9YWIJmlJBUzgH4twTx0lNG2lDJy8uaBRL9MgwzkbCcBaVeIi
         8xlMpJrpYqn8LLgW6M/PnqDPiaanwmo30v9gSyvOQ6Xii+jFI8O6JAVd4wRcr04v7Jv3
         SZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762539992; x=1763144792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0k2DDkmTgl9KtJMxVJka+jshTEvze38uwk10/MjPY4=;
        b=jY3Lxc61npcJHe66MfQtOMTzs3N+qLmW2MGhoW8Xle4M3gQ6VHkgI94WPfkeqHS2p3
         KIekUNGNU7HHXmMasjLdiIfH8p2T8NeQmofoIT4mLT9n4O3cdQTv5B1bdV9IpKEgfSMS
         GXTXftjJ87MhYNXDWUMwzJBNutjdeNC0UYzgqGdNA7DUkcDI3RwM++sectoEQdCdq17G
         Zl2Ayklyvka++yOqPjUe4Ovf8qch84ZWdsgcc37uQZZCE6asE0gUV9V/r8/29RQQaBLv
         xnrf/hD8lB6b5IGJmKbmpeTfN25C/L/feDENJRtwkJBDyeJosAPrjiDGEooiMqo0Bcn3
         veAw==
X-Gm-Message-State: AOJu0Yz+82w+uWi0yvb7wywinj6jvmqinpSjPEYHk1PCdLz8rOvxpotW
	acFn4SOhj8GMI8WModRL4MWjQcEnyqTnEl0DwUqAn89L4L3K7MygyvCZ0erjPhlC
X-Gm-Gg: ASbGncvwj7dtrATK32vOwrEqo4Ocu5QDzr0/6fyQKYhL1WMzSHcJDZ0Z0kTvsI7qC+l
	hldffQC+5aFLsYCFVtNopZvGDJ/Qp1J7RwQ8KNABB3/RIn99X7M1z3coxyp4MrR6gQAHXMSzt63
	CsQXCVH46ihf81R0xcMuWLnspDhVOcQ10s1oQmf85QV/8wPOiwPchKAJdRv7dGxrgnVTPCrST4L
	UNzWKZBnnRfY0M0DJmYe+hY+6v8gzjbRIZtd3p7ZpIVljOrOi++63jKVcaNSRbyh9yooCtZk37l
	DRrge/UczgmP+M6Ni/f76VCuTL86BznCdtnhkv/TilxduwbHGIx99NJ4oL1J1yOHQEhl7aND4Ts
	Ijc4IpbxQQFjFtYqsWDFhdxKmqwFD1mEO8YF9UC4ixuBhRfcYN3Qom0lIuQyc+vXFVffGnFeIrj
	oxTY4mjSCBaOJcznCMWUgORMQ+fmEFI29nYhI3D2qkJvM=
X-Google-Smtp-Source: AGHT+IHSe2DuTKN+iySHuSuemUDwdpe2NT0TqDwGf3BvYJQXiTrsA2dFXT6+qgpOxZlnSFQ8U5p5gQ==
X-Received: by 2002:a05:6a20:7f9b:b0:34e:eb6a:c76e with SMTP id adf61e73a8af0-353a19e5eb2mr127179637.27.1762539991429;
        Fri, 07 Nov 2025 10:26:31 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7b0c963613esm3709868b3a.1.2025.11.07.10.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:26:30 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] riscv: Remove __GFP_HIGHMEM masking
Date: Fri,  7 Nov 2025 10:26:20 -0800
Message-ID: <20251107182620.95844-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary __GFP_HIGHMEM masking, which was introduced with
commit 380f2c1ae9d4 ("riscv: convert alloc_{pmd, pte}_late() to use
ptdescs"). GFP_KERNEL doesn't contain __GFP_HIGHMEM.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d85efe74a4b6..addb8a9305be 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -441,7 +441,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
 static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
 	/*
 	 * We do not know which mm the PTE page is associated to at this point.
@@ -526,7 +526,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
 static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
 	/* See comment in alloc_pte_late() regarding NULL passed the ctor */
 	BUG_ON(!ptdesc || !pagetable_pmd_ctor(NULL, ptdesc));
-- 
2.51.1


