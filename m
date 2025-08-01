Return-Path: <linux-kernel+bounces-753872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1EB18947
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AA01C8283B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405622CBD9;
	Fri,  1 Aug 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNYM91T0"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39D8836
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089234; cv=none; b=JptNbg7JItqBdKu19wyaTDSPZYVzwB+WV0vQ0PjY/GiXSCs56u0Cy+2S2Ip5cUDXqsFpGWSYZ9bn+S6g8FiyXQ5AKRFnneZLqxwiuvBi4VpppzVzHG6DdZFOLcBv5RlKHxupKaeY584lk3IsKd32nujRRdiOndsHaaVbdQtz9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089234; c=relaxed/simple;
	bh=6VWhFqgFIIIqZ6lhYXMM3FSKkMvZt2i3RrAM7/Vd2mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTUHaEHkfh4Iop/1wDY+4zYKMEJyVQHWccC+O2+ZVefS7VUwyPdKk9tDGmG1BHx2GLEIy2yHdUCfW5COmHMn+7fbX/n7wzTcO0OLhPkH05gzsDBNBkq49Tu/B/F+o6CbrJJ0am5dk0hQDpeg3iF8B2bANcI82r0uSQnbOmAsSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNYM91T0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so1887633a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754089230; x=1754694030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abqEG4k6EI+O4I+vteJ6XJztfIuJJUkYy/PS43p6Afw=;
        b=iNYM91T0Rh86cH1+gtZp618XT7ndYuhA/ligGHJXyJq1w35RoEKVhOnE+NMNPT7uaM
         vp3G3G3dvRfIGdbVuDpKv7ogPjMTcQZihmLSswNLTZFVTEyOsLOTMbsyo13+T6Dn/Ah8
         aWwOr3excadSWw6KX31I1re8bYYun5685a3HpQxVmWBHY6rzg1z/G+1Hc5ERZXPTipUi
         DXy7os3FgS6ROTBg/cHKNAzN+vIoPLEopPjlop/p8qQQaOrlVPuEERngGDQRx3NRXwbj
         i4kN+n/YljIe8WwRdCY0Jtu6UWQ60M8abCwwwDQXv57951DH3mYBPOhBJ6WnAg/sD1MA
         HFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089230; x=1754694030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abqEG4k6EI+O4I+vteJ6XJztfIuJJUkYy/PS43p6Afw=;
        b=bOCvLcXyjgspUDWvJOQ9e0eYX7WZatsibT9FdzDRD+dMF95W7mEneRrZU2iq0UGe2p
         dg/JJhCn9Uvk9Eo/mXNF8zt8YAyGNBuqlOQqt2v1XQiTV1ORFp+aFZsoSmOsRlR2c3/r
         zg77EF9gN0/dzDoiiFnsEJN43ZtvomUqkK1kJ4SFCs7tcIQfGwsbqJ31w0qGIDn0mZe2
         QEJk3BOLaG/O92me+nUy3QXHXRvls7MZNwB6rGpdfZ70/ML7GDuZrNP58YChuhLNygt3
         rTlx7NrG5Cb9YUoDFRcg4HX87OLS7xQO7q3Q/3lup1Tm+Dln6MCkSs6JCtMjmfr1qdiB
         FBSg==
X-Forwarded-Encrypted: i=1; AJvYcCWW90BzEALI5BW0tIAw9BUungUu/0kIM2Uy/p+EwbIwKXL6t1XY6aJAoMC2wEdHsfB/bxhG5UndX6YZ0sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0EhYTr2BmBaRlxdz+5WrPtyKDcUYLfbvzbBoqf3a7cySGMnK
	ubQcBEE/59CDqemHe1KWNwFuiuhtN0QUshTmXA7gXQ/w5Dk+SD2RyXOo
X-Gm-Gg: ASbGncunByetbykcEavTH0pKrnvz5iQBCltJXxtZb+9XOuWcej1Nw1Rl9Rqugq1cE/M
	IwGcTadKfRxpkf4ZsPQLxGV8vHSmQ+uxHdo6LbCzn05d1+qx97jvyiYXuNiXse0K0FG8naw4tLP
	4nZvzWwgEhVZv3M0A739K8q7ZwSohFfXT/LVSbtAcEI9onhtwrhSErmGnjjzjHPCNq2uF1Fj9St
	sPahBe8FTTgkCNz5+f8HmNcy5wgtj6YjJbGuAzs4wxl1W3nuSeEKpMkVD6nEj1D316J7YCSdTz5
	BaojAhNRJpVCteKOIQWDiIUfAyK69kY9IX3CHCa2o8QLlyyQF0ySSkHeMAFMN+5tjf8SgTXPcDE
	WJCKo2fPp8DCFHzKCL7zbb3oOqPGGmrSEM+hbR3hAlB4STfbDCYeFkVGj0SLEcbMN8eQHb1I=
X-Google-Smtp-Source: AGHT+IGJBab9bvw4VnN4YTk8kzAMWhGzABK21zAIbErqjtzD57IzqR8o7kVbKYxaiRnwlzZ5i9LCkw==
X-Received: by 2002:a50:cc03:0:b0:615:b6b9:d873 with SMTP id 4fb4d7f45d1cf-615e715d669mr677090a12.24.1754089230336;
        Fri, 01 Aug 2025 16:00:30 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa17csm3279290a12.49.2025.08.01.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 16:00:29 -0700 (PDT)
From: pyyjason@gmail.com
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v3 1/2] mm/damon: Move has filter to ops-common
Date: Fri,  1 Aug 2025 22:59:50 +0000
Message-ID: <a290e7913a1c39f605b8cceafd86d41c2dbebf82.1754088635.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754088635.git.pyyjason@gmail.com>
References: <cover.1754088635.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yueyang Pan <pyyjason@gmail.com>

This patch moves damon_pa_scheme_has_filter to ops-common. renaming
to damon_ops_has_filter.
Doing so allows us to reuse its logic in the vaddr version
of DAMOS_STAT

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/ops-common.c |  9 +++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 11 +----------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..de5404477242 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damon_ops_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..d3d36bca90b9 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damon_ops_has_filter(struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..9d9cdcc10b8e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -262,22 +262,13 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
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
+	if (!damon_ops_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
-- 
2.43.0


