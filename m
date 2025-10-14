Return-Path: <linux-kernel+bounces-852881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B2BDA285
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089F53B187B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F92FF65E;
	Tue, 14 Oct 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCNAs7ib"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FEA2FDC5A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453417; cv=none; b=Q6IBuM4XSW8J8V/fWlzT7bVw7XVVq3cdiuZdC1uQOpoqp5MMK+9SHwHh7/UNgKnfKrpVrdtLhHRtHJZyVyJbiJCdDl2/GJivNoMcrD8FhPumNBa0DpzrLiwMdHCnevCMo2PmwBHHe0lTzxRhTpnkoyJ71lLvxmJfKNa2cG6k+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453417; c=relaxed/simple;
	bh=dBI3eakdPMRsK/c3A94rS1c38Jy4VOMXm5ScJs1zjkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFqYvhIb78HZA+sWq4J3hcKsOLhqdJsGdWsk5nOhJKzhrtlKpXV8IbW9Par4BwG4jacJjGS5ExYB6JYyRR9u5vqPP/Pi4Qn2i5byX+6hjfSYBH90BQ+Hu54tB03wvPzXLJ1DPKVszzCZsPzMMg5JUCJTsx82Z5DWNpB9cUUf5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCNAs7ib; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63d0692136bso2164714d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453415; x=1761058215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4PWcq4M+uwGRj6srPkRX14QChgWCsKUHbcguMBrius=;
        b=SCNAs7ibTFvgetJmp+jf0J1JW4XwWCVv13RCJwG03thyz4YIdLGs7eJ1rvsUjzo05t
         Vn0WYTCR/ji0nB0UmAHenFt37eqR3dx5Ghl04lGcAGraggWEqUV52MoEcCNgoNmb4I+/
         ps/oOK0Mv9ivCXvXWRL47JB0i3ElrvHCxKcOhuMuFRO1FvzUwwGqOvzqak7X5nzXHCqW
         Wby4q2UKKt0Yrl3qdJEd+YmCUIGEzoMswrVe3udZg9xDX8G7wGhsxNNN+O2jKdp+rUN2
         A9rVdsVLOkIiRvdvyBzmlV1dtxqFGyBpNXUGqzhUgTIrhUSFYe7sx6yWd6SjQz+b7T4R
         MZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453415; x=1761058215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4PWcq4M+uwGRj6srPkRX14QChgWCsKUHbcguMBrius=;
        b=JL/uFrjWQC+zpQBTj84G3wtMBW2ba1U36PG4H8J58tyFzCJhvB4WBoOR28csVK+05S
         Z1LHBAIaCtgwxuNpOSfRl1oB53gSHnN35aTh6jo47slox9ZYmKl8MvqUv0vs0aj8M+NM
         T8MhtgobNP+7mPznqpjVQb/D55RMS2IObqwwA8hDHdKBfjJPtNA4DDt8c1we9q4xdLnr
         A6oFbrUBTGR9jRRUCEzfpgQhLI48swa+54qYgPkbZKDD5tzE/ZQcIMVPR2ShGIWbUi4D
         H4ayysHF+uwjxcWEmClpNjcaSIKRUHF4r93DCyl7yHgQp7R/6zsf0zjhQEhXfd0hTEo0
         4Khg==
X-Forwarded-Encrypted: i=1; AJvYcCVW5jCQN2fZMFFmBydtaJ2y3EopCEBrw6t3DdC+djZ4cWbW8WsLwjdFVb033CxQAwyZbIEGDfuf0J28prk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU30p8xeksXJAwEGSrBdjuAfkGDBc7SWNeM3zW8ChB1spZc5Bo
	o/9UQQcIW+7nLfViDJGtNnCnQPz0c+37N9Qs3xFzJuuEH5iXJkDRSVl1
X-Gm-Gg: ASbGncvy4JoudJnPg4d6gs76x3UmqvJpWoBshm/MDwKLV57r3Tef37ISaTJ9nk/yJGa
	wJxbBrT+Eh7qysufcPpNC2FXjqFFdg/MGIoNBae1Tyz3Prw69+h92bynKzZIeMwi44BU/2avziX
	/qbUOtNWDkNlhT0g6xtJ6bNvgu8ZRdu8rtr+ZKCXCROLSYAlu/8LTTjIh5Vz4fdBi8x0r5TuICl
	gIopYprSAcfItMwD/rjGSpzwSEu2jO/ku7QO+kqiYjwG+Svh05SpfPDpvLYlRN0sff54JgN3ZWI
	JK5kdHmK5c2p6XKSXOzcLcdock07Fa2JyPugmrrGoyH28an/Kg3c1zB8AHhbmf8qp64odOpo5rH
	ZANwZSimmoeSFbRzmKUk5sBPJLrRirgB7BWyiQ2w6xLHDsUH6o+qScBokRLn0COVQMJaLEBPHIi
	Wk8Uaqk59SeuMKUQs/8Q==
X-Google-Smtp-Source: AGHT+IHvXFVB71mxsQWd49tPQxNk+oc1NWjBVBlPVRmPisF0KBHXyTAe+jCzazw9vyGeZFp4wLQqaw==
X-Received: by 2002:a53:bf05:0:b0:63b:8e0b:fc9e with SMTP id 956f58d0204a3-63ccb8dc10dmr17448464d50.25.1760453414759;
        Tue, 14 Oct 2025 07:50:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781072f75c4sm33746987b3.64.2025.10.14.07.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:50:14 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v5 2/3] mm/page_alloc: Batch page freeing in decay_pcp_high
Date: Tue, 14 Oct 2025 07:50:09 -0700
Message-ID: <20251014145011.3427205-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014145011.3427205-1-joshua.hahnjy@gmail.com>
References: <20251014145011.3427205-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for pcp->count - pcp->high to exceed pcp->batch by a lot.
When this happens, we should perform batching to ensure that
free_pcppages_bulk isn't called with too many pages to free at once and
starve out other threads that need the pcp or zone lock.

Since we are still only freeing the difference between the initial
pcp->count and pcp->high values, there should be no change to how many
pages are freed.

Suggested-by: Chris Mason <clm@fb.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bbc3282fdffc..8ecd48be8bdd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2559,7 +2559,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	int high_min, to_drain, batch;
+	int high_min, to_drain, to_drain_batched, batch;
 	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2577,11 +2577,14 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	}
 
 	to_drain = pcp->count - pcp->high;
-	if (to_drain > 0) {
+	while (to_drain > 0) {
+		to_drain_batched = min(to_drain, batch);
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, to_drain, pcp, 0);
+		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
 		spin_unlock(&pcp->lock);
 		todo = true;
+
+		to_drain -= to_drain_batched;
 	}
 
 	return todo;
-- 
2.47.3

