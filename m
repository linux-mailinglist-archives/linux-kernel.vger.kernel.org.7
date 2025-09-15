Return-Path: <linux-kernel+bounces-817711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3165B5858D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202114C6602
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9AB28751F;
	Mon, 15 Sep 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Ek9skAL"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C029A300
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965959; cv=none; b=A7V7OQNaTqpjx0aobFiMtr7N7E0EipTshdsUrh5QUWxO//SSPYVKGfpUMvwVMi/k5TS0K5LcM9IrDDE4dCsI+R0OXrwRRkIRS1AmIeEdpZFlfTNnnc35lXx6ipqrv2Cl9bRYmfuFDhiNmWXLFj68MB2Yha7rChkGOfeNElh9Dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965959; c=relaxed/simple;
	bh=E823T6HixBrikb26EDcwlUd1cuW3LPFnDlttoF3Syzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxqnbbohnhrw84YnkrK+LINKA1qFIAvayd/Jx3ffuovrIHZGglInyN8cNJZCEXsKgJncNPJLHL+CunC+hLHUOXRJuyhXbeKhZNXgQFO7WzYBI+Ib7T09eIogs+dlauFuZ21Znvew9vMIBGFhmQmBqg+TVo4o+UpFpd4ns3/CrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Ek9skAL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e41e946eso8237487a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965957; x=1758570757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=II5IQOV7eE0UCj316osBsFAD6qW3Vm1Z7tYAX1f0u8c=;
        b=1Ek9skALuvF30rujg7D7S4FZLGjsGFjZTMIW5ptcudn+AugCCRQ9aqCpEmx7fINLY0
         VTiuDUDgVP7LJ+YyEAqS/JtJwLI2l/Gg8wDlEj2SMKPU6nBUTSIrZwcDU2BHJHbWUY05
         N/foIrOhvhmCJU4wtwvA6RiUML22jACuMnhOs0+JMLNn+lpxA7l4FubiUxtIvtqRb4VE
         A1MNd7VcBAcoSivkfaTgDmcO5exen3nISr4DpjRNPeZ3fNNTw3OOKHRXs5IfhbYSw5rZ
         6dj8lv1MHUWwoTHaCxoqhLDH0f7B6vn1+NcMLdcE8Tm9toU06342ry1Sjs20IKPkfpZS
         TT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965957; x=1758570757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=II5IQOV7eE0UCj316osBsFAD6qW3Vm1Z7tYAX1f0u8c=;
        b=rUZ4pUNe6xUgfWzh7Wst3+76P2Yc2iFM+yha9a4PVRQPNqnpe1SHqhpGe+Hr0Fd3Bb
         1RAr1d7ztm81xSO9CfUjQgJ6Qwarq616GWYG4b1T4RNl1i7D8/mqgdzYUJwzGQAZpD0+
         675vI2KFEOK2RDQq6HDYhhop1Y4H2aORs+ilk5/hZHMDQ5N1DD/MKCkxVVF2NQKmPNbT
         xk3WRbJkreErg9lPLsO2RE64/T/zDaEwaOC4dWaQSvQTqhcHc3BuNF4eMMUkNvvDl2Yw
         GKS6n0YYKBA5AEtRIcyxazFh2J3uLM69V2lGDxKrq+OKp33HWR/0NKl4iDsBDim1nrmb
         tOVA==
X-Forwarded-Encrypted: i=1; AJvYcCXQoN2z00P9xOGOOGWRQEjuFhkSm/zgBd8qhuUKdhwVGc8MNAmNwZPQwD/b2yBzgKLACoG9sUW8xHvOUus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTMtmrT2Ibd/OrVDMWntnFQv+blJu7Pn1Oq1MS1fh1LjJroJV
	6cR5Fk6mvBlKQ0lfcBEUGh7BPiUhMe9jbe74IJzEzDftkSGTngMzAR8KJk33kqPAKCNNhbn2GQ=
	=
X-Google-Smtp-Source: AGHT+IFMJxaxylkV9OFVgqxO/4qqXvhUjwfCwnpPmGFdHD+wNdYJe1GQz83T1fH2gji69vii59G7U8uJ
X-Received: from pjah8.prod.google.com ([2002:a17:90b:5908:b0:32d:e4c6:7410])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acf:b0:32e:685f:cce9
 with SMTP id 98e67ed59e1d1-32e685fce45mr5253405a91.18.1757965957450; Mon, 15
 Sep 2025 12:52:37 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:53 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-13-fvdl@google.com>
Subject: [RFC PATCH 12/12] mm/cma: add CMA balance VM event counter
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add VM counters that record the number of migration
success / failures during CMA rebalancing. This is
similar to other migrate counters.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/vm_event_item.h | 3 +++
 mm/migrate.c                  | 8 ++++++++
 mm/vmstat.c                   | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 9e15a088ba38..1711ff85a02f 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -87,6 +87,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		CMA_ALLOC_SUCCESS,
 		CMA_ALLOC_FAIL,
 #endif
+		CMA_BALANCE_MIGRATE_SUCCESS,
+		CMA_BALANCE_MIGRATE_FAIL,
+
 		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
 		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
 		UNEVICTABLE_PGRESCUED,	/* rescued from noreclaim list */
diff --git a/mm/migrate.c b/mm/migrate.c
index 9e5ef39ce73a..63d771daa3bc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2144,6 +2144,14 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
 	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
 	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
+
+	if (reason == MR_CMA_BALANCE) {
+		count_vm_events(CMA_BALANCE_MIGRATE_SUCCESS,
+				stats.nr_succeeded);
+		count_vm_events(CMA_BALANCE_MIGRATE_FAIL,
+				stats.nr_failed_pages);
+	}
+
 	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
 			       stats.nr_thp_succeeded, stats.nr_thp_failed,
 			       stats.nr_thp_split, stats.nr_split, mode,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..af811328db09 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1392,6 +1392,8 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_CMA
 	[I(CMA_ALLOC_SUCCESS)]			= "cma_alloc_success",
 	[I(CMA_ALLOC_FAIL)]			= "cma_alloc_fail",
+	[I(CMA_BALANCE_MIGRATE_SUCCESS)]	= "cma_balance_migrate_success",
+	[I(CMA_BALANCE_MIGRATE_FAIL)]		= "cma_balance_migrate_fail",
 #endif
 	[I(UNEVICTABLE_PGCULLED)]		= "unevictable_pgs_culled",
 	[I(UNEVICTABLE_PGSCANNED)]		= "unevictable_pgs_scanned",
-- 
2.51.0.384.g4c02a37b29-goog


