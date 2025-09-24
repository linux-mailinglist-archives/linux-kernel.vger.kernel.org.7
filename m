Return-Path: <linux-kernel+bounces-830753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8BB9A6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E83D1B24E47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF6430F95E;
	Wed, 24 Sep 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSk4GrjQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77A30DEC4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726021; cv=none; b=bPQDaSAIvdZbYykbuOtvrzLAexmzChNSle8L6cYVgBIabshRqj4QdodOqwALbzh0YHBJx33w5EgmOJSen8mnn5BZk9hDlvMezezyI6Ncevi0tASBN57KEU2Ud7cP96RGhuAiDG3vibG0Tm6ic9njgtVkhqDzgOsK/yZZ/8nQvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726021; c=relaxed/simple;
	bh=jxWvtMYDjx6V4MJnRkjEO23tCw+cOjtftYS5Dsn4+ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CXM+pP/P2lx91Z96NFJdu8JPMXE7iD9N/rgADYGsels+BoIhPV73X3ryuhNy82mbXLgt+GdkUfL2yEwzVbRjtnKcC7XrowzqbFLJqVBb4RGvygy0NBJBERYFJMQe7dRGHHIWRcJxZ7nwJ4ql4R8zrF6ajXpZonM8SdrgUUDK9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSk4GrjQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45df7e734e0so56609135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726018; x=1759330818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QF2cRHh8FytPgxr8dpYOGpJvCeadM1546zJy7s8ewQ=;
        b=fSk4GrjQqYOf+m6TMI5UlU3RtEE2tz4RbcOkoP8pfVAPAFH86dJ0ylXy1Le8u97wKS
         2smiN+4Sf6344So2tiuQXVVE4J7Z1fcl4+TwZdDn9nf3iXlYqUVNbu2OsjLekQ4ntgWt
         tVlmbI0puFQdX2ndfFgdxpuqACv/RBJF/K11k0eV3Gvs7qzXXSFKrR8/1B1mQTN69Is0
         f4a699YjQBvBRVvO/lUUY8B/XSQYSL/pPSwnQHTdlZOOZyt0znfuLJzsibwNfSRdOG2I
         8rKGz/SFt6dFC2zierrR4KYTQU1PE+IM9FnwAkZsZfQtIp0e2RpjZUJyHkFXhMYFJJc6
         UTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726018; x=1759330818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QF2cRHh8FytPgxr8dpYOGpJvCeadM1546zJy7s8ewQ=;
        b=b+eL6GDhC5KF9ZtmAbAzSN4U+KsTqhykbeZPGYFbPSgCmA7cUjQeePzL1TlPF7gHyl
         NGZjPw/T5e9Jc4kL5c1fgsT66YWEMa6DfEgUEZ1SgKDCTY1y5AXoMW/7XvjfhWNYytBd
         z73xAIZ8pWLnfwYiDzLRRcTodbtXcutodQjybLdimOr9boZ+Y7mwCsa5ch6Q9TqvyM6i
         9YnLsdgmN2K9I/sGdtMrbj3DQfWSD3EW26QVsn7RCGPBw+IUIq/mSX5r0eAzwZ+knlDA
         hS5GaR8cnK0xseZDMpvJVP41XlHnke6hagbLtTJoPBogECwIoMn30KiAASj1sV4Sr5kS
         qZiw==
X-Forwarded-Encrypted: i=1; AJvYcCUUe1NigPuk7Ewp9CNgwFVLyiDMtdogcz9Cfciv4Tqu/4PR+GjvoklzeZ/R9kZLt9lgkd8QaHIgj62Ia5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxftDx2+KYdknb6SDZX+ZpZmO4bxVBQ+HR/msyhC92NDITc35So
	SyKW/TcYYMx9moIYO+ZexbuXGh7Q3NLZY40LnfsNjPLZX4gIWuhtdmv4uGdtNhDHpAw4mUZlxlW
	DMvfGmh8U5cQxUQ==
X-Google-Smtp-Source: AGHT+IHJnBZBPS1nMKaaZcgp71cKjbeNO0YRmTqlXBuWFLXJWbiztOh0lMCy2GikS/TH3xlbidCnHScZxYe/Iw==
X-Received: from wmpd40.prod.google.com ([2002:a05:600c:4c28:b0:45f:2be0:b17e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198f:b0:45d:d197:fecf with SMTP id 5b1f17b1804b1-46e329229ffmr2453735e9.0.1758726018015;
 Wed, 24 Sep 2025 08:00:18 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:45 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-10-2d861768041f@google.com>
Subject: [PATCH 10/21] mm/page_alloc: remove ifdefs from pindex helpers
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

The ifdefs are not technically needed here, everything used here is
always defined.

They aren't doing much harm right now but a following patch will
complicate these functions. Switching to IS_ENABLED() makes the code a
bit less tiresome to read.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 10757410da2127b0488c99c5933422fc649f9a1d..08e0faab992fcf3c426d4783da041f930075d903 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -656,19 +656,17 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		bool movable = migratetype == MIGRATE_MOVABLE;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	bool movable;
-	if (order > PAGE_ALLOC_COSTLY_ORDER) {
-		VM_BUG_ON(order != HPAGE_PMD_ORDER);
+		if (order > PAGE_ALLOC_COSTLY_ORDER) {
+			VM_BUG_ON(order != HPAGE_PMD_ORDER);
 
-		movable = migratetype == MIGRATE_MOVABLE;
-
-		return NR_LOWORDER_PCP_LISTS + movable;
+			return NR_LOWORDER_PCP_LISTS + movable;
+		}
+	} else {
+		VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
 	}
-#else
-	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-#endif
 
 	return (MIGRATE_PCPTYPES * order) + migratetype;
 }
@@ -677,12 +675,12 @@ static inline int pindex_to_order(unsigned int pindex)
 {
 	int order = pindex / MIGRATE_PCPTYPES;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex >= NR_LOWORDER_PCP_LISTS)
-		order = HPAGE_PMD_ORDER;
-#else
-	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-#endif
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		if (pindex >= NR_LOWORDER_PCP_LISTS)
+			order = HPAGE_PMD_ORDER;
+	} else {
+		VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
+	}
 
 	return order;
 }

-- 
2.50.1


