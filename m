Return-Path: <linux-kernel+bounces-847395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4005BCAB44
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19EC4FCE9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C0257852;
	Thu,  9 Oct 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEQHpCpR"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97925A2B5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038180; cv=none; b=eoFYcbCylo4FQadWkfR/1bXyUghIzOyOdA4Dq/ybUFUtsCW+QVQDIp7Kk8+kN3HZ1wOqQ9T2GSSPTUyJOMwOztHsax9JoLyAhcyB37E7eB075whRuJyCncLWAowq7DBBcjwNHzzVW9TR9hzz5X5luDcLCZlD8Uh1g7bckMzicjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038180; c=relaxed/simple;
	bh=dcE5dWinPOnW6dG5FZDsIa9G3Fo9Ggz25utihzouMFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2EoCHw/IxvmWRygucFqH/mxbkffEWuN+jjpMnrBZWTGnznAxqJP15+wbXQ4O09M9ERl1WdnndFRzuEhY/xSBh9dz0YFdjt3amVxIG0IfJru1EjcszTXcFH0dr39OKA6EfsC54jsw2EoutIIYe8s9DfC+nwa6EF1NxiGnakqw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEQHpCpR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603b60cbso12513017b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760038178; x=1760642978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qxvsBMuOQfc43PpisqPeuFF1CopwPLNmzcHAKY7Z3o=;
        b=MEQHpCpRccamVIzgeWlZ0Vn9aakHaY+u5CJVtAwqAwdYnXzX59aGRiIYOB6wHPGwBo
         XUW/lbj9z5GE+w8gAIBFGYClC0BHHgo7Ly5RK63DNgHJcib6Sk//iVtGtFZQ8L15Y13R
         vKeo/9jglPkGZx5PIJc9Bm0n8B/9wVY2a7v/RySARbeiH2tjijsBq/hmQqlsa46iJ5nC
         xDajWSD6WSoyWIRlvdnjSOBnA2+SbT9Vl37UkS4PwjNInQOuxqphLvt7PT6x5qMP4Y9F
         E+HCUlpd5sqN8bUOsMqn+bZ7P44s2S5q5+wHUDrF2N9qSykvFRvVc6xIYkUbTWTFCGrI
         gFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760038178; x=1760642978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qxvsBMuOQfc43PpisqPeuFF1CopwPLNmzcHAKY7Z3o=;
        b=LmhFzM7yWnRLhXakWAHkYNPfXAvBKLgL+DzwH/Z0IVVddcXlq38F7TNj3qomxnOIb6
         xMa26Pv2/jLEeIcbyQr9/Gu0PuClCGImzMV9V1S/4RQvn/ZvxuED6Z2JwojJVCYa/PJu
         Drc8VI+RIWcKhc3BqaciwWn5+5tmr1f5jMMvTFLTpO0q3zI2sUJDMO5+o3cRXaLavVhd
         IFxMf20m4zROViB/OiRFjPc+Yd1l15RIB2E64nvqxTo0DsyLXfpM9HFhLwVNCdsnGR2b
         8g+L58rS9xvN3o1xi4LV/4dQ5ty/0gjf8lR3+sQ5Alqi2klYSx0iTBTZCkuqkhSkitkp
         I3DA==
X-Forwarded-Encrypted: i=1; AJvYcCVJxwaEF5Ct1Hg+wAsjQeUgKniYV9NZwGO62pKSlLEEpkYjLNcSWrHZx99GFfaf/+7I5yO69oZRrozB9W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhZ0n8ENyeznbOMo6s068u+qh08Fp8tYbHDRkN1EUmH1btzwv
	kbGSErnt9WvAAqpR0ZcC9yqb+iv3cao6dhO3yQa48DkpeeFlj/jlhBXf
X-Gm-Gg: ASbGnctOiUq7jVVxUScdB+lbEWOqk+sYuSdF6gJD3K6pP6HBqPjODnoHyzYTp6W5Y2P
	ApjDJejuQA7yVZczJ8KPEypOHPbICVuYMBtPSflOJjaIP7r4XpYpOCOqLi11K71abBixzMaJwqf
	soNnkt/8otP2AUavJZdwz/PHLE8lrPYThSkBehvL5/7gzI7kGxtAl5CzUWHvAKQmJ5/fyVx2HX+
	ebwqNmUkmXMFbSIKg4uSYbqXNBTjwoga1FR0SxaUGFi2yDq+9tMo/aQsOwOECCykkB2Cv61+omQ
	qSgkVi6kfOSTz1/TW/T0xzJoNQjMgM3d+4rl11vreScQ3KqFJRpysZtjBVoU0BvcmvOKU21pkTp
	dOkNRSgVnoCOvbgCzSnr3mo3u1NhKqXMnQKvS8YA1H6OIPVlBRN8JpkkpMEXs82KcBC8KAq7yG8
	Fa375VcvrMc9t+VA==
X-Google-Smtp-Source: AGHT+IFFrfW3ILemW4cB8ZZurRWe7VEN4uNbGMupGllsLF9Wh35T1ff7WKXL5RItyXZTP/x4xzRK+Q==
X-Received: by 2002:a05:690c:6ac4:b0:71f:ecde:87ac with SMTP id 00721157ae682-780e164aeb0mr107739457b3.16.1760038177739;
        Thu, 09 Oct 2025 12:29:37 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7810724444bsm890717b3.43.2025.10.09.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 12:29:37 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v2 2/2] mm/page_alloc: Prevent reporting pcp->batch = 0
Date: Thu,  9 Oct 2025 12:29:31 -0700
Message-ID: <20251009192933.3756712-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009192933.3756712-1-joshua.hahnjy@gmail.com>
References: <20251009192933.3756712-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zone_batchsize returns the appropriate value that should be used for
pcp->batch. If it finds a zone with less than 4096 pages or PAGE_SIZE >
1M, however, it leads to some incorrect math.

In the above case, we will get an intermediary value of 1, which is then
rounded down to the nearest power of two, and 1 is subtracted from it.
Since 1 is already a power of two, we will get batch = 1-1 = 0:

	batch = rounddown_pow_of_two(batch + batch/2) - 1;

A pcp->batch value of 0 is nonsensical. If this were actually set, then
functions like drain_zone_pages would become no-ops, since they could
only free 0 pages at a time.

Of the two callers of zone_batchsize, the one that is actually used to
set pcp->batch works around this by setting pcp->batch to the maximum
of 1 and zone_batchsize. However, the other caller, zone_pcp_init,
incorrectly prints out the batch size of the zone to be 0.

This is probably rare in a typical zone, but the DMA zone can often have
less than 4096 pages, which means it will print out "LIFO batch:0".

Before: [    0.001216]   DMA zone: 3998 pages, LIFO batch:0
After:  [    0.001210]   DMA zone: 3998 pages, LIFO batch:1

Instead of dealing with the error handling and the mismatch between the
reported and actual zone batchsize, just return 1 if the zone_batchsize
is 1 page or less before the rounding.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 39368cdc953d..10a908793b4c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5866,8 +5866,8 @@ static int zone_batchsize(struct zone *zone)
 	 * and zone lock contention.
 	 */
 	batch = min(zone_managed_pages(zone) >> 12, SZ_256K / PAGE_SIZE);
-	if (batch < 1)
-		batch = 1;
+	if (batch <= 1)
+		return 1;
 
 	/*
 	 * Clamp the batch to a 2^n - 1 value. Having a power
@@ -6018,7 +6018,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone, int cpu_online)
 {
 	int new_high_min, new_high_max, new_batch;
 
-	new_batch = max(1, zone_batchsize(zone));
+	new_batch = zone_batchsize(zone);
 	if (percpu_pagelist_high_fraction) {
 		new_high_min = zone_highsize(zone, new_batch, cpu_online,
 					     percpu_pagelist_high_fraction);
-- 
2.47.3

