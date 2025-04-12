Return-Path: <linux-kernel+bounces-601078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8A3A868CC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 00:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6F59A77C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79992BE7C8;
	Fri, 11 Apr 2025 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MBxwcFJA"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A02BD597
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409497; cv=none; b=jebNHZEWdgm4Qpjq+rdtTu9E7edoyWP0UVxdLYtidGgde9qXk7fr/nBqoz/4INcsJ8KNydYuW1TuKIwxlKEVgxpU6driceAWVWFdIh0ojQJhLclBqpoGOrNMz2pgzLKEpdjLFcaMg9qIGIfRyOq1wa4z4qU8P4b4SNyH2ALJ4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409497; c=relaxed/simple;
	bh=2v63zeJJ3qyNW130IYWsx6Y2dRfyeqo3wdMnGBLseKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk95KVuxk+qqeoeftPfEXzoekHa+7HdMu4a1FNN+yUQ+JDxhtFsha9NfHxG2KTmYao3WYXtymayh+7G2h5xSDFsWhXNsX1Kd8+J0PrAods+6rDvfxJzWsbfUT+/quFA++G27olelPJgT04iwT7soso2UCc2yEl6HXPbFKYK03Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MBxwcFJA; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c58974ed57so239908385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744409494; x=1745014294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQiBfRqPk8mw1dZkgLepdccSbpRToMErHEtsnH4pLbA=;
        b=MBxwcFJAwyaHVdTY4d1ulzA8U65YmPxEO7ZRxjJdaY9FKRBmKM+tYrKf96yG9ppUs7
         fjDWaeikomndNvxIGJNo3cy7ZfiC0vIXiY3z5iOfW7GdPs0wZmLTmEz9II1tLi7rcGsl
         VHgHb+K7ISXII9fa8Y8YSc19WZF4oavcT0Lcczri3WcWjXMO02HzyD9prL2bRFYJ4ZYy
         ULVUM77ZuBVpzZiCHl/mMSrYfp3tX/o7QMts6Y/45KAn0+SFIs4WaKC2LpAcb726HF89
         6EZ5NUCJeQHvfir9ndEzdT2k40ppYtsh2HHGhEoWKfCT50O7dnbmhdMeCqCLdiX5ig9/
         cL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744409494; x=1745014294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQiBfRqPk8mw1dZkgLepdccSbpRToMErHEtsnH4pLbA=;
        b=Mw0kQatJLjt3zNPOAOuxOAAwdgl17SX4x19LUHfpCK2kOXjv7ZUM63ys/5eTxTyNUN
         BZ5tWaCAgzy29qxdunvP70yzOPDTGnXq0+GZh7/2r79KO/k7PR1u6R/ojF4lk62HoEtk
         XO/tt8u7h6fV3WdDVhu3KyCJejQbcaMmGP4+T26l6mXdg9oqn7lvbK6ZfAg1tyOM3amb
         IbFaE9//ShUVPBrPGTYUX3EiyHKprzmmpStV6760BQEGaQQizKGe/yubdN7oTRXlMYk9
         7Y/RfVzBnveNAG5wq/kY1tEq0tdyBvX7xrweIKkPzEAKpZc3B8UywvHJqD4HpeL22ojh
         EOjg==
X-Forwarded-Encrypted: i=1; AJvYcCW40Cj6aVgGpLbOynN3Wiy7vJHdBrZAjpzPbkfA8NER4cqNMpCFvKSzEOsbYyBX85gH90o+Z/YSLXhk0TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULxmg6134cCsnVg+Abs+6r2OFoX3Xt1XmIWz1sGZjspWz1a/q
	LMUa6v62a9xLUR87fa5a0n0T7usPHN+2SLsA2zs5nrVc3cU4Fudj47KzlyOfEGE=
X-Gm-Gg: ASbGncvITBnqtT7E49WYctyh7Zycwp3FOlqooKa8PkmckX7jqV64LEho90mr1IfhxVU
	OK4ttXn3DjdXuAMFV4fYFjh0eQYWIBmcT3wCbuMNIHGp+PAaZniO6c0psWJSMfhnf4nT3TxDYl8
	cWxRL+7Tx5HmtEHqGudZ5mv5FggAFfgCSGbLJ+ZUA29PF6QU4COLMJtugLXoLrs8rKahl4A6txK
	ytAdL0MxnHr2IQz1247b1m/e9u0u1B01ZzKsWKLXX+ShSnjhTt0Gbm58BWdTjXJjUtsMFBgbX7v
	ybbcCVaWuAzL6Qqh4ktMeHMXATtXhqrHutYbsrji9zKlSrK6UcTWK/oWUmLqPk5I+u9qWkjU0/W
	vyXWdh+xsvSyTSkoVpvZ6KvS2q9Tt
X-Google-Smtp-Source: AGHT+IHFJC0NN/wSPotsTklWaXCxqH3AtdGqhorgwESblRoLtPrItNQuVu4sWimxPm4HxktfyaglUg==
X-Received: by 2002:a05:620a:2586:b0:7c5:aec7:7ecc with SMTP id af79cd13be357-7c7af0d3f56mr657187185a.13.1744409494387;
        Fri, 11 Apr 2025 15:11:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8943afcsm321264485a.16.2025.04.11.15.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:11:34 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: [RFC PATCH v4 4/6] migrate: implement migrate_misplaced_folio_batch
Date: Fri, 11 Apr 2025 18:11:09 -0400
Message-ID: <20250411221111.493193-5-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411221111.493193-1-gourry@gourry.net>
References: <20250411221111.493193-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common operation in tiering is to migrate multiple pages at once.
The migrate_misplaced_folio function requires one call for each
individual folio.  Expose a batch-variant of the same call for use
when doing batch migrations.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/migrate.h |  6 ++++++
 mm/migrate.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 61899ec7a9a3..2df756128316 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -145,6 +145,7 @@ const struct movable_operations *page_movable_ops(struct page *page)
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
 int migrate_misplaced_folio(struct folio *folio, int node);
+int migrate_misplaced_folio_batch(struct list_head *foliolist, int node);
 #else
 static inline int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -155,6 +156,11 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
+static inline int migrate_misplaced_folio_batch(struct list_head *foliolist,
+						int node)
+{
+	return -EAGAIN; /* can't migrate now */
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/migrate.c b/mm/migrate.c
index 047131f6c839..7e1ba6001596 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2731,5 +2731,36 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 	BUG_ON(!list_empty(&migratepages));
 	return nr_remaining ? -EAGAIN : 0;
 }
+
+/*
+ * Batch variant of migrate_misplaced_folio. Attempts to migrate
+ * a folio list to the specified destination.
+ *
+ * Caller is expected to have isolated the folios by calling
+ * migrate_misplaced_folio_prepare(), which will result in an
+ * elevated reference count on the folio.
+ *
+ * This function will un-isolate the folios, dereference them, and
+ * remove them from the list before returning.
+ */
+int migrate_misplaced_folio_batch(struct list_head *folio_list, int node)
+{
+	pg_data_t *pgdat = NODE_DATA(node);
+	unsigned int nr_succeeded;
+	int nr_remaining;
+
+	nr_remaining = migrate_pages(folio_list, alloc_misplaced_dst_folio,
+				     NULL, node, MIGRATE_ASYNC,
+				     MR_NUMA_MISPLACED, &nr_succeeded);
+	if (nr_remaining)
+		putback_movable_pages(folio_list);
+
+	if (nr_succeeded) {
+		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
+		mod_node_page_state(pgdat, PGPROMOTE_SUCCESS, nr_succeeded);
+	}
+	BUG_ON(!list_empty(folio_list));
+	return nr_remaining ? -EAGAIN : 0;
+}
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
-- 
2.49.0


