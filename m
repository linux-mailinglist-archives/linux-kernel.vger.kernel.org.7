Return-Path: <linux-kernel+bounces-749474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E1CB14ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F27A101E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90541C5D53;
	Tue, 29 Jul 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niXo6rGW"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A81A83ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797220; cv=none; b=Y7bRSvYto4egLJuOgP/sXWOWBgiwFjgCdZN2AxGiWiQxFBi28dfrVsy0EDdM+2jvZeEmkzknrD5zyjt/CkMJv19nBkVCRCy14pk9uC2AubglGzOHoMVpDAQ0syi9cF/5dArXvSnSXzqj6T5yeGGvcZBjecqMErsYCD6UaJy+e10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797220; c=relaxed/simple;
	bh=rEYZcKPuEoA+4icI2oULQiQiwjwKdMcQ+KF57c4W68M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OotK6uEYk1dhscFa5dIGfAjd2tBpgTXdJsDbW3pQkVHVUOnNqVJtgHfuczo48DNidU5jotezct8CB67XGmF2ufPWsvqZYVW/FiwQ+YypqytEFQqBMM4FT2MB7vhyFXBi9nSxAH9ztfqHTOBpnSxzGgbKGg/acD6gN2Dk3N3+AMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niXo6rGW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso27309975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753797214; x=1754402014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX7fJLinetNknJ65ovuFB91/gF2qnwRLS3nsv9fgSbo=;
        b=niXo6rGWvtYgTEHu52OYMquYX36h4c3Q/Zx4JtkLw/xARXoCC+rm/iaoJ0J0q4mNSg
         dp1l7eVZdngjgApjejhf+D5doU2CnD9YGiWXbcuHqZoeNhJsbNeho0BrUCcSfBengo12
         GbHWp1WoQa5d1TXxa16MA3n4fhgN+bcOh5LJ7Qn2GgH39mSns0/m4+P6lxIzP4mIUm9C
         9u5wYuUV15tRhVzJRwaSuJgnimOX5SNyrxXFtadZvD6/WKnOqebPC4O3sKrun8E55cAc
         ZRmyui3P/q4H0cwuJIBe3wIViF5HNyD87yOoqo19fAzjXsfFJ33Vo8reO7g3ixNEG3X6
         wJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797214; x=1754402014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX7fJLinetNknJ65ovuFB91/gF2qnwRLS3nsv9fgSbo=;
        b=Ef67ux9NuXA1JE5imZRttz8fIzy36HsiwD8ccUc9hOvYy5Pl0x8NmryOj6jhT70SKu
         7E18J4p/8xT7ffBGe0AFnpSzxbRdbgnjVBUJp5qkTMVbdwWmGq9hw4Tldqy8nZQfR0QP
         bfkFwOfYhGmRVzBtUui/XRVzftFmWueJIsj4EHFIYRpzoOut0VGLWzZw3smKkBBj78Xy
         JAYptfgXhDkl2RKPqQW60zSL5SRV1RWRPHDpu6+ev3ZvvmGyJt96h8zV5l0FH4CgAWJV
         V+eunmpaEy0gbpaSGcsymyPHSfMZhoKv79eMU5PdlaAOieDJKkJzL6PZQzyfDsUAi1Jk
         2Zgw==
X-Forwarded-Encrypted: i=1; AJvYcCV5SRmuApF6fB1EqZoMxRjKKjEUF8nFXG6osnCy47SN9NWvELkFePqI40BdLrvR4aPi+3HIUEaLWkUT8Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlEmFHQlnFHOfaQR+S/0fu5DrsD0IRYnCSd4lHY8ziUZY7wBg
	l2kwgA73AmesFarMbWfqPvbUTdjOOvrTBu5IZHDiRt2gl13xoAGn90QZ
X-Gm-Gg: ASbGncsUfO0a5ac3LMBsdNC6HMcHAJRX/U5KeHKbuYAYUHiMkIIDU5pIZ0oaSDKdBZR
	tbqr1MAqIMWTUECw/gb/LKMw+kJ0nM6r8XSgsV/1bCKFqQ09j6qJv2jLO9xYZBH///o8E2pLXww
	L67pNHQBSmaNT3mx0oyyQwxFcY/35dletfGcgXi102sF92I9ZtGLIrD4Fr6qQw87D8USZWcfwVd
	67CWJ0utiz5JgWhYelMM9V8ztFrvwW1JzTSwcxv83FqzYF97syukXDuaBzocM8TAfVXB1ZhNGHZ
	4DX3VODx9CQzwIMxHXdqIYledZFkJuSj9P6rbQ8ZbEAqP5yAuOGYttjDstpAP90M6gM6xZB25Q6
	8PUtkN1Bcm0WXUQU=
X-Google-Smtp-Source: AGHT+IHiE+mOd2kK/xVH8sQHnsd++XnU+kJq3zliaNuGl67gbnun1ianmf1AcZJq+E+PA+1qbb5MuA==
X-Received: by 2002:a05:600c:3f09:b0:456:1a69:94fd with SMTP id 5b1f17b1804b1-458855d3dbemr84280485e9.0.1753797214014;
        Tue, 29 Jul 2025 06:53:34 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:53::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5e6232sm26786655e9.32.2025.07.29.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:53:33 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	PanJason <pyyjason@gmail.com>
Subject: [PATCH v1 1/2] mm/damon: Move invalid folio and has filter to ops-common
Date: Tue, 29 Jul 2025 06:53:29 -0700
Message-ID: <2e143ff5789954b2c3c5b97b12569bc324cff087.1753794408.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753794408.git.pyyjason@gmail.com>
References: <cover.1753794408.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: PanJason <pyyjason@gmail.com>

This patch moves the damon_pa_invalid_damos_folio and
damon_pa_scheme_has_filter to ops-common. renaming them
to damon_invalid_damos_folio and damon_scheme_has_filter.
Doing so allows us to reuse their logic in the vaddr version
of DAMOS_STAT
---
 mm/damon/ops-common.c | 19 +++++++++++++++++++
 mm/damon/ops-common.h |  3 +++
 mm/damon/paddr.c      | 29 +++++------------------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..7d3b48cc0f86 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,22 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damon_scheme_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
+
+bool damon_invalid_damos_folio(struct folio *folio, struct damos *s)
+{
+	if (!folio)
+		return true;
+	if (folio == s->last_applied) {
+		folio_put(folio);
+		return true;
+	}
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..4e905477fdce 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,6 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damon_scheme_has_filter(struct damos *s);
+bool damon_invalid_damos_folio(struct folio *folio, struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..a8b7048e871e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -114,16 +114,6 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return scheme->ops_filters_default_reject;
 }
 
-static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
-{
-	if (!folio)
-		return true;
-	if (folio == s->last_applied) {
-		folio_put(folio);
-		return true;
-	}
-	return false;
-}
 
 static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
@@ -152,7 +142,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -192,7 +182,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -239,7 +229,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -262,28 +252,19 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	return applied * PAGE_SIZE;
 }
 
-static bool damon_pa_scheme_has_filter(struct damos *s)
-{
-	struct damos_filter *f;
-
-	damos_for_each_ops_filter(f, s)
-		return true;
-	return false;
-}
-
 static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr;
 	struct folio *folio;
 
-	if (!damon_pa_scheme_has_filter(s))
+	if (!damon_scheme_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
-- 
2.47.3


