Return-Path: <linux-kernel+bounces-817705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7EFB58585
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0011AA56DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACB28F948;
	Mon, 15 Sep 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8uFDZ6B"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835E28C5DE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965951; cv=none; b=ByOC1d+Mk2QOaA+QTiRVzZQL3hxBIuNoN6XJEJ8F3/bkkDiXfDvHJdAM/0TZ3fNFyCJ+lgNiZoUg3NGhQPu1PXVkrrbna4S6LvyEQxJv9M0NKnv27H9H+LoljDiAJR9gLu43o3+rgPCxuNPlML/HVKCLQWoapxVXDGyCpaL6Xgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965951; c=relaxed/simple;
	bh=RhVlmsWTYqoH5W1St65CGuBNh9719pQ0bYzXCGJTNEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VP7RAcg1uphxB/pCi56NUl8/go/JW0nksn4OugL7TpFAhd3XH3xDs0Id+uzpO8sGxvEdBOzi6mu130LD4qfUO5V2mC3jM57uSUL2O04ISi0DrNZaKmpItIn3ocYvKO2GEuluxBrAWICmoIvte1YCAX/PL1yG1L+Mq7eWr8wpW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8uFDZ6B; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77422201fd8so3846090b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965949; x=1758570749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0svEd+gVOCVsfCPBdmnwBog7VppNcoJfmCv6ADiIbr8=;
        b=B8uFDZ6BNplEqvOGZx4qKLGCW/At/gjmtg4v7i6rtXfuDEjBjYiUB4GIXkOhDQOzSc
         XEe0soQRuHiQFfYKaWPZqrPjdkETAYstIyPBFdWrbPe5qwEw3gkjJOVVuezSOauuJeSl
         f+02XYIJywWqCFOQXEq9tgXBL0DbuazceY5fbb4sJvdyTlxb5uVc9bt4XyYADPiSeXSz
         HzKfKm0XIE86tk2umfO1arWApAyNvhTDHGgkKfRKvGe2/KhC4aa4uxQN89s9SIjllSUd
         LSeM4UT/kBvvW0JJCqPFD0EA48INEXS3aENiq2FcQsHu9hfMjR8wOArNt746+e30vBod
         jaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965949; x=1758570749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0svEd+gVOCVsfCPBdmnwBog7VppNcoJfmCv6ADiIbr8=;
        b=dYHu1wN5c7LQCK0pE7d5O5q23ehJz7bZoLsN1zb9J1KEUAgTWgkvdZ3eV4DjJL4t4g
         h7BNkwn+clw152HL31nk7kQI8ET2WgYQTQRfPWLzYjrv+VuPAEBdwOsbGSdvug00CcmR
         eRijEGQpGWwZS71JZWHyvBTJBcpdf4WddDTkl/tD2GiIozfIwZ4YIOgWArIPuDVidiiU
         zP/pJ9kCwU6jn1anqoGJ1KIrNKbXkSf3QYhn2t6ikHrGFhW14ZaXhvTvk9EcapramAr6
         C42PCj01MF9+Mrp9ohb/LrKJ0h2IYB7nqAa2J6/Lrgzh4JuxERifJwOOI+5HZRCoflyU
         +/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVTkRTs690Rxq6hxTxga9DFoXbaMrq0wHRknxbYeDldYcnq2vxa0l2uWxgqTBjrYhnv2EmC+r8NmJrnd8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9etJOEI9rLtWw+W04czlUzBIlmuBnS7zAf4wbcMnha8kvcEXH
	u7EOn5wLbByEYl8cy7CP103R4LPAaN8BkEabGxZWRypBOHeHHL6ZAvVSLMAjvyrCFPiEfhrsWg=
	=
X-Google-Smtp-Source: AGHT+IGSSnGP60FTHWub2ijESGSasTj/5U4SKgrsznRVHg7jm6k4jw2NVaDNXlZHD1qi1VzPFvCEZCsL
X-Received: from pjbhl16.prod.google.com ([2002:a17:90b:1350:b0:32d:a0b1:2b03])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6705:b0:24c:cb06:f0db
 with SMTP id adf61e73a8af0-2602bb594afmr12621549637.35.1757965949116; Mon, 15
 Sep 2025 12:52:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:48 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-8-fvdl@google.com>
Subject: [RFC PATCH 07/12] mm/compaction: optionally use a different isolate function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

For CMA balancing, the compaction migration hooks can largely
be reused, except a different function to isolate free pages
is needed.

So, add a pointer to the isolation function in the compact_control
structure. If it's not NULL, use it, else use isolate_freepages as
usual.

No functional change.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/compaction.c | 5 ++++-
 mm/internal.h   | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index bf021b31c7ec..6a2c06e356c5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1813,7 +1813,10 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 	if (start_order == NR_PAGE_ORDERS) {
 		if (has_isolated_pages)
 			return NULL;
-		isolate_freepages(cc);
+		if (cc->isolate_freepages)
+			cc->isolate_freepages(cc);
+		else
+			isolate_freepages(cc);
 		has_isolated_pages = true;
 		goto again;
 	}
diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..7916d8be8922 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -873,6 +873,11 @@ struct compact_control {
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
 	unsigned long free_pfn;		/* isolate_freepages search base */
+	/*
+	 * Function to use to isolate free pages, if applicable. If NULL,
+	 * default to isolate_freepages().
+	 */
+	void (*isolate_freepages)(struct compact_control *cc);
 	/*
 	 * Acts as an in/out parameter to page isolation for migration.
 	 * isolate_migratepages uses it as a search base.
-- 
2.51.0.384.g4c02a37b29-goog


