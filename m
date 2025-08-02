Return-Path: <linux-kernel+bounces-754119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA0B18E4A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88A7173394
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C722B5B8;
	Sat,  2 Aug 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzooXUeq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E3225779
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135586; cv=none; b=Cv/q9zCXLv9s3kUtGoxSUgFeo1C5xYWvQ5s3v57mGzCWlsXlqeUpzMPQ+CSSi5VngSEoRodz/ANnTsvKIsr9v/6Dz89lCSObnPh3dbu3TNB4x6FUcjSkpvl+NLx/5U4O5djH4B9bM8WTkjQisI+XsHh6UgUfUBui7jQ0XdX32cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135586; c=relaxed/simple;
	bh=kOvxzrWDC5K18/smBEMWYXLhT/zDo1nWowIrW1n8plA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyDVeUIuo5UHmOAelCc8p/8SEGp3vfxAS7bAYOfYlhCr57MOCm9Ky1N8h0eDPcGNsP8SHwvE+zyDm8xsnA/fdsENelyoZ6CXyL6XQhhQPWahA//hhhGt8NNqHsTw/cGgQAIF+UYYiVCcuYcF87BinIMq9kqWLY0CD5WoTB0oWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzooXUeq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae708b0e83eso491369866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754135583; x=1754740383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1uRbOaPx516qagC6F0FtjjMT3s1w0dSsaUvr5gAnQo=;
        b=EzooXUeqO+M+By8q42q0SRQBxRfXhjuIAvCzmNT0xa/AIKuBcrnOhRD41Ym386kAAA
         hENxuILS38Xgvkw9/rup141ukFD7IIKFc9DSaeOIevo96Wnt+qHxi6WNDg9NlejPt761
         cs8wOKsXYPVALQ+ATMZYvufQ8zs1UWIs7j6ruWQRiqfhGsd4/Tkly1S3HojJVciKF2Bw
         2+QBUgMfqu/boKwu+cyGQCb0jEE9iLJSPXU/ykYjPlL+ZbXjkysWo/k6ZDKXyx8hF1tB
         GGh0FXiWSg74AfseXOvRPslZDOx2lJ+9yNLXtm2LVcDKSou5mu/xfPiVVgJLUVfUVGfx
         //JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754135583; x=1754740383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1uRbOaPx516qagC6F0FtjjMT3s1w0dSsaUvr5gAnQo=;
        b=SthOd7noBSYnwLBphQRtQ2P0cKKPPzqO8Wl4yOHRo9nwA3zV0KPRDwjG8VVrQ8hT9k
         F4zO8l3uGoZtlojh+5WVxJ/+5cpofqI7IrTHt6fkTvhgnowNLEi7jZVjqj6ZAj0BI2bx
         Yq+JEDO93OSeXzrOyxkyd2BxlRY9B1rTlqSSnfV2Y8SDwIxI76OD2r3aa7SkJoY4w53j
         0I3qMaq/V5+y2OuaJBl7qp8txIuKk9Bb6AZZQDLmmmL9fplOZo7RZWLXg8YpgPbZUCsJ
         8oBbC4UzUv5VAen1rEIRz2Y/OgnZuiHmCh4MgSEaGU3vg9A/QMIfB2LK57gVlbCbUw+a
         k/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaaH3ZvtfzjjLTQdyywJhoSuL3oc0fqMaDYNArs7EZHEkhudmVWC5uG1hVjxDPfLN2RHJ6FLTWqJBFz5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXuuRhOKcd8qR8cm/l8tFbWpKUhGc3feDwTzx6diCghYTbunF
	MfMoQlXBzKlNgbR4YcsbyE4PSgTpcaUWhw8/Z9ikKGOr80AUBA34YNkX
X-Gm-Gg: ASbGncu6KX6tJx/NMwuom+4MnJd9016jMkaGPL8CjypnZEbZqNTjsqA/vVf3nieBHR5
	ummAPgA8Fr0LaMKFC6nL4xtDpk+pFDqXkI92A97vDa98uZXjfX2xN0b+sNp02oQtFzpBoxnNSJJ
	J7ICWkk36R8MFaQ0kyzvPUZCEklq7PB0nftJFNI87s++S5njUkguylcjcG4XJHLkHmi+umWQPMN
	copTtDvkucraYVkBF8nGoVs5VOvRRItyri65oHfz8AWTKCzQecveMGWT1iJf9PvD0BOYp7IhR0i
	Huvy+EouRgRBzqkqjdjFhZOQPhoxS3IAQDtLlca5dDJHp3wDcrT+Kup4Mlrim53mvmJhrZ47MTR
	/WuBQ0RvyGBXXItPxZm/pkHLSbd5Z64X1LAlSTGc65IMzz+3KG6nk4Nap8h8BrIjxvRPGBpEj0n
	c8+faDEA==
X-Google-Smtp-Source: AGHT+IEeolrbK8Ju/4UkPkf+Jnhr2B2vqnQWZUQZZTD5vJyKAaB8n/76N2YQeS6F2uTGQIcJUUPDEg==
X-Received: by 2002:a17:907:86ac:b0:ae0:ac28:ec21 with SMTP id a640c23a62f3a-af94001468bmr267338866b.13.1754135582908;
        Sat, 02 Aug 2025 04:53:02 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0753f9sm425028166b.20.2025.08.02.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 04:53:02 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v4 1/2] mm/damon/paddr: move filters existence check function to ops-common
Date: Sat,  2 Aug 2025 11:52:45 +0000
Message-ID: <cbe01740f7ac5ac7c9fd1ca367d297c3d7f2a69d.1754135312.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754135312.git.pyyjason@gmail.com>
References: <cover.1754135312.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves damon_pa_scheme_has_filter to ops-common. renaming
to damos_ops_has_filter.
Doing so allows us to reuse its logic in the vaddr version
of DAMOS_STAT

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/ops-common.c |  9 +++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 11 +----------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..2e3409a6c8a4 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damos_ops_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..5efa5b5970de 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damos_ops_has_filter(struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..0b67d9321460 100644
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
+	if (!damos_ops_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
-- 
2.43.0


