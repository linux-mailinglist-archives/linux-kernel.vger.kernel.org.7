Return-Path: <linux-kernel+bounces-867529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C6C02D60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C463B0CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623634CFCD;
	Thu, 23 Oct 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I16DAE8U"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497B34C12E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242527; cv=none; b=E5qpLBtmoaitQHWe38GZZRHlDCUKBzrn2YsYdooooHUMXoGI2CGOVsKt6/L8NvVzv16HBpjSVf4EWfIsIzZsIHAEcHnEgNnGOtweSzR+EziqwN3l47XhxBrmGiVNE8M/MkduMfd14zonytiVAfJjoEWAqkJQ/6hsGMLhSf5iS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242527; c=relaxed/simple;
	bh=9qn6zNWsfFcbHFESOoC9xd7aXwGd0GCzaR/zSa3kq58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBdiJdDHXluLODejwsiZeZf9UGy+IwN7Dc/DkD4Xc3re09ThQ8iUWqUjBoIdatzgi9ywcXM6a2h+lhLKPBxSbBDmNI+GdvaKrYy35FLOx+NqqNResitbK3ky5TKHzVl+8kH7x8yBL4fsILtSqNho60u35smq0HmQgA7hGZ84/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I16DAE8U; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26b9a936aso741869b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761242524; x=1761847324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lk62vnASvkBxJgkC6Qb/LY2NePGcYntSkBsPsS8b6vw=;
        b=I16DAE8UX/4v97BvG7mPRuHP5XwwHwKJleY9nKgjjCFlp7IucNJWpnO7U8LQHss8xe
         kwAQAJCMPW/s96Vc1oXSaLgSpOUzQBotmsK8i8aZQeaZhLIfsr/oivyxh/PTQBNmtuJJ
         31bY+YTOZRRF1zVJeS6hRf+1Ihq+TmWJjirVUBqiz9QbuKUoOTIVG3abxlh4iomsNkIa
         8UaG4gmM+e/L/lsT3/5sKc1k/cowEQEbuL77VCsTNVbm3DCRtQt4zvdP32p2P9ciDJko
         hUe9FcQtxk6Rfrs9VcTKSC5x8j+cvjqakt/nxRZ1tKbowvd8z8q1TYo6GIAQTwWkCyAY
         3OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242524; x=1761847324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk62vnASvkBxJgkC6Qb/LY2NePGcYntSkBsPsS8b6vw=;
        b=UTMbrJg0hAqUB2h8MGJmW3fPy2ro4DjPUYCc+wXBBKtTHmJk2UQs68uVS3R/Sn/OiE
         6OmlHTmSjEkzJ/pYGlJQam9RMWiYQgrgI8K88GgOVn5kf6VYZS4vDmzaTGcoQ2OYkTjf
         fxSoftBohEwaeBkslaQVNiqEXEIr6Q/jIVrk1kXVB1VjU8TVRlLk1M348o5WOaVTEooT
         Lr4hYsf73anp/FI3AhFs2V+a+5tB5XhbB2W4VqBpZCR8lzwiqjfUfF89vkL4Wc3tkDzP
         vAE7C0m96lKAs7BCQzK654JAb5um7EpXu9XAAcqweTLXu6SBgTHMEGKrUeeNgH2oi4x5
         2iNg==
X-Forwarded-Encrypted: i=1; AJvYcCUgH+od6GxRPtld3kpIaznaQu1uCgV2TniEhA8iRe2aRfeiit9ZACUZtbhrh/6AasZS808G/1kgaAjldfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjfl4fEd4Iyh8VD4wiooFkLqfIsKzDWKnBjQWTndBfoxnOFaZV
	SpbUyJEP5kExWydTwV1yGMRYM95Vbppq1Ge2PRTUAYkrjeBsGWu1pPuI
X-Gm-Gg: ASbGncsA4fF+6JT82I8pkjU5ngz46ykyGh/6M39FK6oulb/rgP6fWgk6CZm+e4o1lIC
	sMwP5hcltBs5Im8eNd1cTG1fo8I3DXP+SfYeT5nHLEBQyu9DyVsYmXMqSPaWm3yk6yPO7DS9FE/
	I6MnB8pUPJbehI0/vBAfprOEF797D8lvOBPl3E0YLvXz4eGYEOhuhngVJBRSYcLoydevnCETFoS
	Ia3y5L57l0d3yfaMvbrRurCQX0qv4ZSLfiunvCepCgKgKw8OQ8rCrI1XdKMdhkkaQczXrwDLmWY
	njcrLLeefIQ6IbR3zKOlk6HyxMvfVHkcb+BNvlxrC8Yv/MWyoZfZEbl6mgkc3cFh3xMCqce58kT
	H6ZapY9FRMPpI7WJNqCBWf7tyK0zSwT1wvz3zl1pH+fYafIs8cxt7/XuhWFvL8tcgDhh/GpN1op
	ARBh0gRA==
X-Google-Smtp-Source: AGHT+IFPUrlbvn8DuW25skZvpIHzGvxrGeq0n5tQxV88E3xMkZ9FaMz7plJmoiS9eWwPcZAFgSQvBw==
X-Received: by 2002:a05:6a21:4613:b0:334:adbe:752a with SMTP id adf61e73a8af0-334adbe757emr30117578637.31.1761242523824;
        Thu, 23 Oct 2025 11:02:03 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm2734532a12.18.2025.10.23.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:02:02 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 02:00:43 +0800
Subject: [PATCH v2 5/5] mm, swap: remove redundant argument for isolating a
 cluster
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-swap-clean-after-swap-table-p1-v2-5-a709469052e7@tencent.com>
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 YoungJun Park <youngjun.park@lge.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

The order argument was introduced by an intermediate commit and was then
never used, just remove it.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 42e2b2759240..214ccd1f69cd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -594,7 +594,7 @@ static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info
  * this returns NULL for an non-empty list.
  */
 static struct swap_cluster_info *isolate_lock_cluster(
-		struct swap_info_struct *si, struct list_head *list, int order)
+		struct swap_info_struct *si, struct list_head *list)
 {
 	struct swap_cluster_info *ci, *found = NULL;
 
@@ -957,7 +957,7 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 	unsigned int found = SWAP_ENTRY_INVALID;
 
 	do {
-		struct swap_cluster_info *ci = isolate_lock_cluster(si, list, order);
+		struct swap_cluster_info *ci = isolate_lock_cluster(si, list);
 		unsigned long offset;
 
 		if (!ci)
@@ -982,7 +982,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	if (force)
 		to_scan = swap_usage_in_pages(si) / SWAPFILE_CLUSTER;
 
-	while ((ci = isolate_lock_cluster(si, &si->full_clusters, 0))) {
+	while ((ci = isolate_lock_cluster(si, &si->full_clusters))) {
 		offset = cluster_offset(si, ci);
 		end = min(si->max, offset + SWAPFILE_CLUSTER);
 		to_scan--;

-- 
2.51.0


