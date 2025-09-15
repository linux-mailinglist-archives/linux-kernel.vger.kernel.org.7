Return-Path: <linux-kernel+bounces-817700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC1AB58580
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952301AA2BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64E22882D3;
	Mon, 15 Sep 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="le4FBNZE"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850962874E3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965943; cv=none; b=o8hy2UNpk8fixYai2rTKs+kWxz7sxL3IemVZx/aCLCPEvfvDC3EQgAG1WOZtA4ncafpr8aczfhxLHpd7Yf/2TuRqkWrQvcUVaeNA/J571EC7l4C+nCfTt0CyrupFko9q4FMyxHzrwfVp7McIPZXYkGzRtYi3OUjhu1kb5lAezRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965943; c=relaxed/simple;
	bh=tEeg41JOEhGl7jTUXcSujf5WUTFOd4ZDMEOebrtmoXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h35TXfnVfqS2XRimsLLFb+pJTpdoRFMzlEkcopnR6FuE0+J18eW37Jo28V0eKTclHHDOMEkXNeTzIgdSW2R1Q4evRrk2KaMeSybOTFvEuAXNgKJRCfE4VaRql3Qa3a3gES816cCTmo9qmWSPbHDrw4YV/fm14B/gGOMGCn8Ev6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=le4FBNZE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54b37ba2d9so2252299a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965941; x=1758570741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cc6GKOWoQL6x3lNuALuf8+hLk7kZZixPtZ6cf9+vrNU=;
        b=le4FBNZETBgcDkUyiEQMktl9GqyzwVDXvhfDqfvqXCgLFVH5eyNmp+Cb7zTMLdh5jW
         6bZI5Eu9gPWsNjVe+LHc3QWncpTYbJGt8MdxNGu9Sis22bsDip1zvlM9/sToKnWQ0OoH
         iIl/7KM1A0GZ4s+NFGe36mINOX8LQrTHilbyDywEVhCj6MbdrzB1d/PbsnJ76jc8mVqX
         v1I5NxsVN7HIVFjl2JAKz2zWu+M3AGvGi4qGufXH9Zizr9j4xqr0+GmumuSX/xgzGiDZ
         frWCPBBH+JaStZhnoud4DDt7GS6H5S6+EMJh/eL67ouiVyzv/V/mI0Ya8j0zg9fGy6+S
         gG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965941; x=1758570741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc6GKOWoQL6x3lNuALuf8+hLk7kZZixPtZ6cf9+vrNU=;
        b=MA89pI47exuFFDohKXh+z6wSOp/CK/80HVj5igqu7xcctKLc4JrmagLzKS1F5BLkiR
         zT04jBjDA6IukkwhAKOtKtdCGpRG+MWbriUU5cqv7XTqjNyoz9tl+oiEYdohA0zYFZ9O
         RArW1+wRRHToE5UEmKObDOF8grzl564UrKlT5rtlnAh8Ayc8ysPM9TBRMayTKIzsmNSM
         hPwrqcoPk3wX9nxOx7/Us3MFbuMDPw+74MjF7kyyZVltWk6kjnBl/euytLmn6Dkf51mn
         uxLbOOukUT8a1WqqtUCjfC0JTuicwb6MpzhkQW/WEV/5AZbrSqY6+nS4rFQH2RJ0XmFi
         8YAw==
X-Forwarded-Encrypted: i=1; AJvYcCV5PyhMWWRL7jDAeyI8V9R7vbeK0Jw8zkFNqePnyBMdSfwyLAV7wlHjioNGfHQOdDkgA58dMX5o4sJLwXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnq/rumj4xauIriNJAjukzY+HUKbJ+RAQMVql/adXpoXvs58H0
	pi1KA9N+LHKDCpbIYuP5xX8x4e3IpZA3/nMjYIKiia5rNgHST4wBqkSxJqSELQO13HBgTQcpqQ=
	=
X-Google-Smtp-Source: AGHT+IEWXitsQ7F/mFPysA89lJUOW5nGMTirfNQGq+Ms7D0jQCKeShp6e1b1+4LCWTQ/gzoNFF4WxIpN
X-Received: from pjcl16.prod.google.com ([2002:a17:90a:3f10:b0:32e:1604:8630])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d92:b0:32e:72bd:6d5a
 with SMTP id 98e67ed59e1d1-32e72bd7001mr4041613a91.1.1757965940695; Mon, 15
 Sep 2025 12:52:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:43 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-3-fvdl@google.com>
Subject: [RFC PATCH 02/12] mm/cma: clean up flag handling a bit
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Atomic bit operations aren't needed for the cma flags
field, so switch their manipulation over to normal
AND/OR operations.

Also export the bit values in linux/cma.h, as we will
be adding publicly used values later.

No functional change.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/cma.h | 12 ++++++++++++
 mm/cma.c            | 16 ++++++++--------
 mm/cma.h            |  7 -------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 62d9c1cf6326..5c3fdc5da908 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -20,6 +20,18 @@
 #define CMA_MIN_ALIGNMENT_PAGES pageblock_nr_pages
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
 
+enum cma_flags {
+	__CMA_RESERVE_PAGES_ON_ERROR,
+	__CMA_ZONES_VALID,
+	__CMA_ZONES_INVALID,
+	__CMA_ACTIVATED,
+};
+
+#define CMA_RESERVE_PAGES_ON_ERROR	BIT(__CMA_RESERVE_PAGES_ON_ERROR)
+#define CMA_ZONES_VALID			BIT(__CMA_ZONES_VALID)
+#define CMA_ZONES_INVALID		BIT(__CMA_ZONES_INVALID)
+#define CMA_ACTIVATED			BIT(__CMA_ACTIVATED)
+
 struct cma;
 
 extern unsigned long totalcma_pages;
diff --git a/mm/cma.c b/mm/cma.c
index 2ffa4befb99a..549d85b2e3a3 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -111,8 +111,8 @@ bool cma_validate_zones(struct cma *cma)
 	 * check has already been done. If neither is set, the
 	 * check has not been performed yet.
 	 */
-	valid_bit_set = test_bit(CMA_ZONES_VALID, &cma->flags);
-	if (valid_bit_set || test_bit(CMA_ZONES_INVALID, &cma->flags))
+	valid_bit_set = (cma->flags & CMA_ZONES_VALID);
+	if (valid_bit_set || (cma->flags & CMA_ZONES_INVALID))
 		return valid_bit_set;
 
 	for (r = 0; r < cma->nranges; r++) {
@@ -126,12 +126,12 @@ bool cma_validate_zones(struct cma *cma)
 		 */
 		WARN_ON_ONCE(!pfn_valid(base_pfn));
 		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count)) {
-			set_bit(CMA_ZONES_INVALID, &cma->flags);
+			cma->flags |= CMA_ZONES_INVALID;
 			return false;
 		}
 	}
 
-	set_bit(CMA_ZONES_VALID, &cma->flags);
+	cma->flags |= CMA_ZONES_VALID;
 
 	return true;
 }
@@ -176,7 +176,7 @@ static void __init cma_activate_area(struct cma *cma)
 	INIT_HLIST_HEAD(&cma->mem_head);
 	spin_lock_init(&cma->mem_head_lock);
 #endif
-	set_bit(CMA_ACTIVATED, &cma->flags);
+	cma->flags |= CMA_ACTIVATED;
 
 	return;
 
@@ -185,7 +185,7 @@ static void __init cma_activate_area(struct cma *cma)
 		bitmap_free(cma->ranges[r].bitmap);
 
 	/* Expose all pages to the buddy, they are useless for CMA. */
-	if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
+	if (!(cma->flags & CMA_RESERVE_PAGES_ON_ERROR)) {
 		for (r = 0; r < allocrange; r++) {
 			cmr = &cma->ranges[r];
 			end_pfn = cmr->base_pfn + cmr->count;
@@ -211,7 +211,7 @@ core_initcall(cma_init_reserved_areas);
 
 void __init cma_reserve_pages_on_error(struct cma *cma)
 {
-	set_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags);
+	cma->flags |= CMA_RESERVE_PAGES_ON_ERROR;
 }
 
 static int __init cma_new_area(const char *name, phys_addr_t size,
@@ -1085,7 +1085,7 @@ void __init *cma_reserve_early(struct cma *cma, unsigned long size)
 	/*
 	 * Can only be called early in init.
 	 */
-	if (test_bit(CMA_ACTIVATED, &cma->flags))
+	if (cma->flags & CMA_ACTIVATED)
 		return NULL;
 
 	if (!IS_ALIGNED(size, CMA_MIN_ALIGNMENT_BYTES))
diff --git a/mm/cma.h b/mm/cma.h
index c70180c36559..25b696774c6a 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -64,13 +64,6 @@ struct cma {
 	int nid;
 };
 
-enum cma_flags {
-	CMA_RESERVE_PAGES_ON_ERROR,
-	CMA_ZONES_VALID,
-	CMA_ZONES_INVALID,
-	CMA_ACTIVATED,
-};
-
 extern struct cma cma_areas[MAX_CMA_AREAS];
 extern unsigned int cma_area_count;
 
-- 
2.51.0.384.g4c02a37b29-goog


