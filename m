Return-Path: <linux-kernel+bounces-779879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A6B2FAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250806217B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A434575E;
	Thu, 21 Aug 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ziO273Kt"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B81334392
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782993; cv=none; b=QqsSimdzckgIqoBJzQ5zlGRN0FbgaPE2MeWLIA2FRAc+BYOkolY1ja1lUMBXeVrrncvbCj0knV7pa/IZFjGfkPBxc5r1Se5tyamAj4SSc41qFeQLUVeFMs00aBt/RK64jJ+bqf+TwfdNXqX2cCY2F9krXDFJF6zkIFqslVOJafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782993; c=relaxed/simple;
	bh=edfj4+LF+u0L+sb8Au4VzEuarv/TtOoAcaMBb9E/bmk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W1mKBTpjdCIJwJvUHKLiq+KtIwi3yz1kv1YCu43qA0kf9XRX4qBUWrJSMpBmEPkraGHGLC+2Le+MYEWdzMC8uxVb8e624BvY7Xu+rwTxjO9q7CMcsFT+KT4Ymkb39Ymo7GtpyfZspPLtyf28z9hErEO9ud5oQox1vjEXhO3ULE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ziO273Kt; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e41037e6so659587f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755782990; x=1756387790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DegyuwYleM4jZaA29537JxprXH96T1dxgET4m+CA/9w=;
        b=ziO273KtMZru3OIfpLPyADiAoxRiylw4/85QxNzpbu6AQ2wzfaNiEEZRv66QCDRE2/
         oBTD6fiuTBU9JEaWZEOBB7yFwNt0in/qkAMqOlDIeF3smsI1C2f8xu9Inb4xDet/j0Zj
         SerJOVgC+7Zzsfp95HHuw5E2jJ8FEPOa6sDNxZYeNWnE72t3/SqHPYwO30GpkRYYq3Cv
         brQzc4RW+RBE2YpOQkEId7GiDh2koSOv8f2OyiG/YgK/dmuHhaj78J7c+0zdZVBNvDrY
         fd9YooJe6GOLB8zV35hzG+q4eLj1neiUrWq2DCV04Drfp1wWIQDZUGCh8b6LqJDooyjJ
         Dt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782990; x=1756387790;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DegyuwYleM4jZaA29537JxprXH96T1dxgET4m+CA/9w=;
        b=a9hfIijhv3FvmO3dxt6n3ozENgFJpnsOdubEU/x4dflwFWofzfRgem0qGpaqU+i72V
         WFISsDBoLaCMTCiVW9wuxXSdZYKQHpVE0vZRMiBvIuwk/DeRimWfZ0wzfZ32p/PNcujC
         qlS/VN8JUX8wCERrDkFHQuYI0ZgwMf387oUtyVbst3mKv2G+q3FZdim3kej135FsjZ4R
         vYaVWB7bAdRl5Fm3X15C+qfWdOOVgpPApj2Ho7KgH6ymdh72DGOe+o6Lm9+3U0FosJBS
         eSxsr4azObZbelnt5W2neXasyp9WPsFLAKYeQTMe5udwHlkUMIlkhlVuYeOHLOU4l2m+
         1t5w==
X-Forwarded-Encrypted: i=1; AJvYcCUuHUMB/E4RRZPxwjksI1A5F2hkL1DdGL/k5noPqAtEY5dSImfixj+h0ZiZUPn9Ng/MELdmYBSQTRDi1DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffR7ErBE4taftzJofLiPHj6SRSZBr9VjuQK98EQBf8KMw9XA6
	e46XSlhAs3NHLso7vZB7HkLxx32HBcE86R+3apNonzz6SKI/HdnRbBq4+r9jnqAJE8SjE0YOyS1
	+0kzSKUW4aButOQ==
X-Google-Smtp-Source: AGHT+IHeCbM6UzDocrt4nYe7pS4UHPtBeM7I5iTp4f8ugtwZCLnKyV8JeFtfE5g/7O/wy8nfgW7hflIeEVDT6g==
X-Received: from wmbem15.prod.google.com ([2002:a05:600c:820f:b0:458:be4f:f5e5])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4011:b0:3b8:f8fd:af5d with SMTP id ffacd0b85a97d-3c494fc60e0mr2056119f8f.11.1755782990192;
 Thu, 21 Aug 2025 06:29:50 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:29:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEofp2gC/x3MSwqAIBRG4a3EHXdBpUjaSjQQu+o/6IFGBNHek
 4bf4JyHimRIobF5KMuFgn2r0G1DPrktCmOpJqNMr6zRjMIrYnancEJM7txXeLaD9ioE1TvbUW2 PLAH3/53m9/0ApkhCV2cAAAA=
X-Change-Id: 20250821-is-migrate-highatomic-871c0ff05a84
X-Mailer: b4 0.14.2
Message-ID: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>
Subject: [PATCH] mm: Remove is_migrate_highatomic()
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

There are 3 potential reasons for is_migrate_*() helpers:

1. They represent higher-level attributes of migratetypes, like
   is_migrate_movable()

2. They are ifdef'd, like is_migrate_isolate().

3. For consistency with an is_migrate_*_page() helper, also like
   is_migrate_isolate().

It looks like is_migrate_highatomic() was for case 3, but that was
removed in commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
accounting").

So remove the indirection and go back to a simple comparison.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   | 5 -----
 mm/page_alloc.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030cb22a3cb0ddb262b6300e65ed5a..45da9ff5694f628db18f740718f0a7a06c4548f0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1333,11 +1333,6 @@ extern const struct trace_print_flags pageflag_names[];
 extern const struct trace_print_flags vmaflag_names[];
 extern const struct trace_print_flags gfpflag_names[];
 
-static inline bool is_migrate_highatomic(enum migratetype migratetype)
-{
-	return migratetype == MIGRATE_HIGHATOMIC;
-}
-
 void setup_zone_pageset(struct zone *zone);
 
 struct migration_target_control {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ca9e6b9633f79ff28448a6008749fa6ca2696332..baead29b3e67bb3ae2291b00d7632aaf87ebcc4c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -797,7 +797,7 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
 
 	if (is_migrate_cma(migratetype))
 		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
-	else if (is_migrate_highatomic(migratetype))
+	else if (migratetype == MIGRATE_HIGHATOMIC)
 		WRITE_ONCE(zone->nr_free_highatomic,
 			   zone->nr_free_highatomic + nr_pages);
 }

---
base-commit: 5654520c361a6638f9d9e889257dfce38c83f653
change-id: 20250821-is-migrate-highatomic-871c0ff05a84

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


