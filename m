Return-Path: <linux-kernel+bounces-830752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7FB9A719
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D317B966B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42630E0E7;
	Wed, 24 Sep 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7luoj/O"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F91C8630
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726019; cv=none; b=O4+JqjGLVHshBoo8zubtyDtNSvcBk1nkCWQ5kxlfewAFsYMVXrfl+2nEMsjAzsOb5MlHAOdeF8+nDg+xF3txqeDbpkShswSKMU5Z5iLqeYOhgHcbRxNidCp/W6L9/0720iSfp8lMTyzIhj1QJVmrIm7pZipBtZMfdu6QACH2Z3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726019; c=relaxed/simple;
	bh=ehl3w1CyI570eR6ZXmEHxOSAvE6+tVJmDVrz20BaSIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jo4geaYTa5O7bAdPitl11rIOu0yR5KR+KbOdNXcTUndvs9DMi5ry5qvuCmVoRxqK+cpROwyrQkBrgajJ60G9YA5JxBd/uTJuFTNX+VMZqJN+juNcH+j644C2BPCQ0fPl05ztq9ERbzIzz35YieilpH7G7tp4fldOiVndrOKHkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7luoj/O; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e1b906bf3so23560355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726016; x=1759330816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKJT4vpnX5xVBMK5mB1lNcuXbTDuRuXg8xoq8hiioZw=;
        b=h7luoj/O9Fl5hauvrdTtmu3TNEC+Wfuf2f275Qog3D0Gg5DHt7lqDyi7jKZ20W52Y1
         YgYu8SpivOPis/AtJe+yvvi2oVcz8F/QkW7ivwgaL7okGo9xYyYhQYd9WIgQTyRNt95k
         LK7ydQZIsS1BJ0j0VDIyMOy453N3gCFcvfr2pxlII5hILRH0R4CbqoEg0PAaiehl09zx
         7Tf1uj2CYK1h5M5JXZ8CBdxrpmJi21Y+SKLbIj+Rm3w2Ohl3jbJ5KH3Eys/Ca3zIW7Iv
         2x5iiYMXGs7imqdB7xGSg4f0otYR1JQUenemWmU4wL3shKg6bDhwqNvTPdpguqD/2QgA
         3gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726016; x=1759330816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKJT4vpnX5xVBMK5mB1lNcuXbTDuRuXg8xoq8hiioZw=;
        b=QSmq+6nB03Ty/NhmPb/jxLkXMcGDAHOS6AE2IgTUJ7AOY4Ku7GtmU9wiMqC0bdfuuQ
         5SAuKBSmY8ehCInjPtUzSrhgwjeG2HYJjxyJ1Oeo9bb5Wd9jCW99D7Dpv83tWE9UR+qj
         kt/Ly5Ix4jDH+Iko9UxiXYib1R0mq7uYKsl0+9X8zQq/z19c/PAScIl4W/LfzMtbnIKg
         muhNnpBDNMEiWp7K3N6kN1tRLOlgL+ynqBTfKCiCA7OAH5KMFkIuFxmag+9VHSRQwH9c
         +hIs4/jsHBt+M8VVtxzMfBqneCHIv6xiGMeicKzflLkfSAfdY33HDyxyyeGYU1Y8Hub6
         4qPA==
X-Forwarded-Encrypted: i=1; AJvYcCUQs4Cygt/lstqzkUbNAh5SbEJ3AixzUqeYin5ucs5g3k10sUt960NwdpAwMYqX+hwJsKH4OPjudMuQf8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmS3J+T0tDXvojEG1oQ4/FDkOYKTTmnAKEnIpCQD+9PQmAcg2
	2kNcOvXfUvug1MgjC8op5/30nAGCpAlSxucF6EoeAu3gO7pwkB1YRy4oSQBOI+EK0ewJ/Ua7bSO
	GLorkM9L4vdwC6A==
X-Google-Smtp-Source: AGHT+IEwpH5Oza9iuA/SA1ZMp2dUWj5FnIP9hJFno7WJD+Pwhp72Tuy9jz82MKe39ZlHCf09lf2CtXpfs4Ad2A==
X-Received: from wmim22.prod.google.com ([2002:a7b:cb96:0:b0:46d:712:e422])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b9e:b0:45f:2f0f:6649 with SMTP id 5b1f17b1804b1-46e329d474fmr2189815e9.8.1758726015769;
 Wed, 24 Sep 2025 08:00:15 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:43 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-8-2d861768041f@google.com>
Subject: [PATCH 08/21] mm: rejig pageblock mask definitions
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

A later patch will complicate the definition of these masks, this is a
preparatory patch to make that patch easier to review.

- More masks will be needed, so add a PAGEBLOCK_ prefix to the names
  to avoid polluting the "global namespace" too much.

- Move the CONFIG_MEMORY_ISOLATION ifdeffery into a separate block, this
  allows the various conditionally-defined masks to be combined cleanly.

- This makes MIGRATETYPE_AND_ISO_MASK start to look pretty long. Well,
  that global mask only exists for quite a specific purpose so just drop
  it and take advantage of the newly-defined PAGEBLOCK_ISO_MASK.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/pageblock-flags.h |  6 +++---
 mm/page_alloc.c                 | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index e046278a01fa8c37d898df94114d088933b6747f..13457e920e892c1c5083e0dc63e2ecfbed88f60e 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -36,12 +36,12 @@ enum pageblock_bits {
 
 #define NR_PAGEBLOCK_BITS (roundup_pow_of_two(__NR_PAGEBLOCK_BITS))
 
-#define MIGRATETYPE_MASK (BIT(PB_migrate_0)|BIT(PB_migrate_1)|BIT(PB_migrate_2))
+#define PAGEBLOCK_MIGRATETYPE_MASK (BIT(PB_migrate_0)|BIT(PB_migrate_1)|BIT(PB_migrate_2))
 
 #ifdef CONFIG_MEMORY_ISOLATION
-#define MIGRATETYPE_AND_ISO_MASK (MIGRATETYPE_MASK | BIT(PB_migrate_isolate))
+#define PAGEBLOCK_ISO_MASK		BIT(PB_migrate_isolate)
 #else
-#define MIGRATETYPE_AND_ISO_MASK MIGRATETYPE_MASK
+#define PAGEBLOCK_ISO_MASK		0
 #endif
 
 #if defined(CONFIG_HUGETLB_PAGE)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0d1c28decd57b4a5e250acc0efc41669b7f67f5b..a1db87488296a6d2d91a1be8d4d202f1841c4dfd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -370,7 +370,7 @@ get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 #else
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 #endif
-	BUILD_BUG_ON(__MIGRATE_TYPE_END > MIGRATETYPE_MASK);
+	BUILD_BUG_ON(__MIGRATE_TYPE_END > PAGEBLOCK_MIGRATETYPE_MASK);
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
@@ -443,7 +443,7 @@ bool get_pfnblock_bit(const struct page *page, unsigned long pfn,
 __always_inline enum migratetype
 get_pfnblock_migratetype(const struct page *page, unsigned long pfn)
 {
-	unsigned long mask = MIGRATETYPE_AND_ISO_MASK;
+	unsigned long mask = PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK;
 	unsigned long flags;
 
 	flags = __get_pfnblock_flags_mask(page, pfn, mask);
@@ -452,7 +452,7 @@ get_pfnblock_migratetype(const struct page *page, unsigned long pfn)
 	if (flags & BIT(PB_migrate_isolate))
 		return MIGRATE_ISOLATE;
 #endif
-	return flags & MIGRATETYPE_MASK;
+	return flags & PAGEBLOCK_MIGRATETYPE_MASK;
 }
 
 /**
@@ -540,11 +540,11 @@ static void set_pageblock_migratetype(struct page *page,
 	}
 	VM_WARN_ONCE(get_pageblock_isolate(page),
 		     "Use clear_pageblock_isolate() to unisolate pageblock");
-	/* MIGRATETYPE_AND_ISO_MASK clears PB_migrate_isolate if it is set */
+	/* PAGEBLOCK_ISO_MASK clears PB_migrate_isolate if it is set */
 #endif
 	__set_pfnblock_flags_mask(page, page_to_pfn(page),
 				  (unsigned long)migratetype,
-				  MIGRATETYPE_AND_ISO_MASK);
+				  PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK);
 }
 
 void __meminit init_pageblock_migratetype(struct page *page,
@@ -570,7 +570,7 @@ void __meminit init_pageblock_migratetype(struct page *page,
 		flags |= BIT(PB_migrate_isolate);
 #endif
 	__set_pfnblock_flags_mask(page, page_to_pfn(page), flags,
-				  MIGRATETYPE_AND_ISO_MASK);
+				  PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK);
 }
 
 #ifdef CONFIG_DEBUG_VM
@@ -2122,15 +2122,15 @@ static bool __move_freepages_block_isolate(struct zone *zone,
 	}
 
 move:
-	/* Use MIGRATETYPE_MASK to get non-isolate migratetype */
+	/* Use PAGEBLOCK_MIGRATETYPE_MASK to get non-isolate migratetype */
 	if (isolate) {
 		from_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-						    MIGRATETYPE_MASK);
+						    PAGEBLOCK_MIGRATETYPE_MASK);
 		to_mt = MIGRATE_ISOLATE;
 	} else {
 		from_mt = MIGRATE_ISOLATE;
 		to_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-						  MIGRATETYPE_MASK);
+						  PAGEBLOCK_MIGRATETYPE_MASK);
 	}
 
 	__move_freepages_block(zone, start_pfn, from_mt, to_mt);

-- 
2.50.1


