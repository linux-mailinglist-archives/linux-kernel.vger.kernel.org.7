Return-Path: <linux-kernel+bounces-861791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2AFBF3AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18EFB351D11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB703333434;
	Mon, 20 Oct 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XbdaJLkK"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AFC2E719D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994515; cv=none; b=PbTnBiWzAjjZSZRMzjknPA5uoOGXHeEVNJFEsYuVsUzI0a1vx3IBODXkjc0G1a5gkCeAJsjJs3zpRCbDFr4tnm2Gxl6IjDO/oJ0+29dE30HCkOMC1BrTxIIPV0c/Da7gatRsQH4lhDS2LQhevuN82BviBxw8dpTYLVN5hcYXrlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994515; c=relaxed/simple;
	bh=7K7KLvfaS0Usr5K3wM/J3ax0dReD9wF0dHhsCvlpJfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9pYL75STCgArfqyDyJ+DwHjciWotEIFfT/ZM97pmIJrO5npkQB+gU3NrDvPcoWUkiwX27ebvWJgtfwsEcrOQi0VQYfj0Wyki/XNq8c0cYm3muu7O4APtK0CXak8oys4WOO0mFXvzg9QmYsVs783LpNCY31vhRJAuI3/Vv+1mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XbdaJLkK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7f04816589bso773103985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760994511; x=1761599311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWs3rixB8Mzl55PE6ULVQfSrvZtFhlgG1JKGhyoVWm8=;
        b=XbdaJLkKcEETA2JETomNmzu6zuPtVoqLG36NiAPM1q+ZdDPHlDD5z6afRsI0Gpky77
         YNErw2uHKPWHajkWjUTTW0Sb5H3soH7ZH/c2jbGP5DgjZAUP7PEzdqySlG1KxsVHPj0u
         V6JL413K91udaA5Ml/LVLMZX2VZkN9cI4iCyBGg0rTayWZG7yNI/yCY4v9Bhrg2fRgT4
         +IRU/LaxC2F+qdgr0hwOGZMGRDZXz+h2JULZaNIOA8oJyDzXdfIfLO8rH3MvK5J7IMUH
         GaivlHuMJtH+UeEo9xWre3K+CXw7tjmoBxa/+xVZtLV1RW+7syFUdQytZAgZEkvx3Wl5
         YSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994511; x=1761599311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWs3rixB8Mzl55PE6ULVQfSrvZtFhlgG1JKGhyoVWm8=;
        b=IRtsT/Qdlq4L+Ju6ZjtHkP2IEIlekssNQlHEDeIqrml/FqhhRPuTEZNtvFgJLqDMDc
         BW3cyoXjrlcq9khcSULCb2X8UBU+jDcMVhfHmwAIeSr7/3k6t++LWKGYC+vMFPILhBaF
         m449eABuhIS45Jtv3nwMo1/WnfMAdlHaNDLPBwrCvk7UeBKF6KVWZSxKzDH3QJGfo7qn
         ob+sJjAHfAxrC92mpS58cpWGVu/W/XhHhg1d02QgrP64oO9zouwMhvBWnX0jpdXfIapM
         fmRL1lgOP52ibL9b7Gkr1uKFa4MkJXGZJjEhuSdDji42j01zliRClRfPcGttiNz0O9y0
         v+3Q==
X-Gm-Message-State: AOJu0YyDDpsx79vzDa3wnoF0/IfcDbhECcZRZleEVMA6/L3Bt5zYKLFQ
	ETYci44XtyS+x9WvitGy2NQdZzz9fI0g/G4z9s95tXl7EnFvMOudlaxvqIeGF/YNC/Q=
X-Gm-Gg: ASbGncsgwjLpHKGYd75TltsiA7oLvsb+s1BqKFRHzdPdDezO8JPfO8gSO+o9hP/qO+v
	oCOpRTbWSmAPRubq5loEBd18Hqt0sYcnTXyK4mXrPzUZjB0VarHYcsupE6L/sC3bY5Bu+mo+0N6
	9OpoaZFv2TnVTe9zuluytO8GrsUMQWv+SdVqXoz49xq+qND6+jLrbXwcrHTjPDiZMVBxhCKOoVt
	BTTmiUI9W5R2Tx3bTqS0J2+QZMhbh96qf1tba2nGSKzA2+EMIi9ldPoklOjsHKYBe8enWbfXWXu
	km6y/8SbWeBPmY4fQx4/4Nd2A6tDn2T6877xm5GjFyPGuFmTQl4yNq3kx7PWd9wOyESHxmDx/S8
	bqb0fnPsrSAfpN3zoUF7IV00SSoImL6pebpHqJbnDVkvbm11FrMroEtwcebm6UWuTWpEJCjLrEI
	n5B6+42iXyZ6WzLiDOGEgaB3Ff8R0BCOgWgdPNfTC8sb0DtgAZucS7H5roNqJvL1akKlJC8owm5
	8o=
X-Google-Smtp-Source: AGHT+IENfTNM2VO5U6qloud+UsMTLsA87azdHw6yWf8IBWAYsxqF8ZYo9h/XbXj3UiJ3yHUAuGEmrA==
X-Received: by 2002:ac8:5a8f:0:b0:4e8:ae73:f548 with SMTP id d75a77b69052e-4e8ae73fe70mr96782901cf.82.1760994511076;
        Mon, 20 Oct 2025 14:08:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aadc2032sm61826211cf.0.2025.10.20.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:08:30 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages during contig_alloc.
Date: Mon, 20 Oct 2025 17:08:16 -0400
Message-ID: <20251020210816.1089910-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We presently skip regions with hugepages entirely when trying to do
contiguous page allocation.  Instead, if hugepage migration is enabled,
consider regions with hugepages smaller than the requested allocation.

Compaction `isolate_migrate_pages_block()` already expects requests
with hugepages to originate from alloc_contig, and hugetlb code also
does a migratable check when isolating in `folio_isolate_hugetlb()`.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..da2e65bf63e3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7048,8 +7048,19 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 		if (PageReserved(page))
 			return false;
 
-		if (PageHuge(page))
-			return false;
+		if (PageHuge(page)) {
+			unsigned int order;
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				return false;
+
+			/* Don't consider moving same size/larger pages */
+			page = compound_head(page);
+			order = compound_order(page);
+			if ((order >= MAX_PAGE_ORDER) ||
+			    (nr_pages < (1 << order)))
+				return false;
+		}
 	}
 	return true;
 }
-- 
2.51.0


