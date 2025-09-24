Return-Path: <linux-kernel+bounces-831245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BABAB9C2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91EF1707C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4CE32A809;
	Wed, 24 Sep 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcGiDa1V"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0B329F2E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746655; cv=none; b=DQZs1Bf0At5mrp6Cx9GXlPbf4NXCHhTejo8+y43EuXnSPeMXdUoZIKvJOkeeAdL+rTZZ/S30DDDBfXJpSZ1rIPWb+6/kG+eLaeudhd8FhzIOOqkKi20FHUKP435QYCwNc+nW1AR9m1knt2RHqErT/wBGpeFxtqrsh39jyzo1h0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746655; c=relaxed/simple;
	bh=42+eESs+hNHeT/GrhhilKtr9b3BDoXjdJa2yGQYtxfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCTdiSHcalSVja880VyHWMPToD9uIImEPQNvzIPaiWEM0jM4uueSqPlzLkF3I0ietUuAquffS1G/fmf7E9KBv39n/DE7dLn1nJ7R4a4heQl4bFA4DcGF5PMZB57T5MYnueGfSKzsPYO2KhRK0YHNrncHRxvQMthE0m5qa6Ew8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcGiDa1V; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea473582bcaso1630935276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746653; x=1759351453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRPftj4LaqpBRfvv5a/Vndy5zTyggHCJw7J9EdAecUc=;
        b=OcGiDa1VJRHJ+UwQUd0WXotATWhtO8+asGnTo6Sfq5vW+O29g1O4DRZbRDAkkwv0cV
         e+otqxBAX1LTF1MKBSxh6uRU3Up23ZhqRXzRsu7eIiXvh10wES3pFcRnKxlU2YNJtXA1
         6YNGSXI0lNo3PBZ3/QKaYrMuHphQzGpMmYCqUfyraGwY155Odr+UJNQIztfEYj6C2diB
         9W/UNZ5Z1+jkzlaFuzgonUqmyL1Vmz/cHXVEQVV5INqLA0hdqSxs8o0TefolRnAc/zxC
         Vv08b+/a32xuaoQHJXkBuDbEo/Vbqo3i/e683TNohysh05St3jrZYDKnQ87Zob+f8lsR
         5SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746653; x=1759351453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRPftj4LaqpBRfvv5a/Vndy5zTyggHCJw7J9EdAecUc=;
        b=ba04cfMFkNizRttUdDj6HnB4IrDspAKDTbzLP9j1Ad/Hz4S8ljh01ph7MTdZ8KydFt
         qmpiApAMpaXlvcPli9NKQPEb0XDN+puIuGmF/oxsXeFZbLC4Me7TSuvRgBCYK7evYUnw
         NP6q3pRbfR1JaeJvgI2CuKWJ/YC4UzAWM9WKwBplbN6C3eAXIlCg3u89c0fhM88A2wk2
         dqyDzdLMJSlVEOeB5VmO0PFjvZYZ0jTHvL4N/+7qrKQFqcBj2VA5qb6jxsGeT9GGbZSj
         z7djMFj5oMFyQgH+zRy16XyGcO3hyE78X3n2xUp3yXmGQOEU1UuEK/C/mldZQqmjT2Yi
         iEdw==
X-Forwarded-Encrypted: i=1; AJvYcCWQG3oOQNe/yZnqhlX22n9ugByIzzoS1lOldqh/VP85bkaThGZFaDzYc7DQBwP5i+grTc8FWpke5/iQ/Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPXhbFaRMeB2m+sz6GZ2qU+mHsvmojm0VJlRgpczHKA3RcMJs
	HqZXHb6jFy6IDdYDBEDpxGFraCwcDjrK0KMKEc7QBq3CzzyHE9UhAmHr
X-Gm-Gg: ASbGncsvs8Pnxsq/nMyJRkeED2ZC50q9cV9hKpZ1/7xLB/MYAZNlXynSQ1KW8lTGyi6
	S0QieKbmLtemPmkzdHoDVe9br9Kt2jyUh7yBIeqzLsbSq/DdrV62QV/n9PHh57ROm52Bv5ax9Je
	tS0ywTW4LLHKxTD3sxMS7KVfEtMJU+Nzt8XRQRCwI5trQCPOomWdtUi5b+CmcBjtRl6cU2E4GFK
	DNGIvkryjDTh6IGZ8BpU63s87exSJ/LcSOnoWQqhBuMl/ZhGJZVXToCgvVCGfMjbM0IPMN68gH8
	JE9oUMtc69dEkhHfJWCa3VsMpS4VK8Zu1KBRNAByb9kvobAFwRVJokFhcyeTvC9Omvpf11w//XE
	pRyIEFtpQPJ7QpEYOYj/UJFUqHG0iRSkMlUOVIJHVUbhFMgrFGaS6jw+yEKqMYWZarzhG26Sf
X-Google-Smtp-Source: AGHT+IHfhhzK64JkchKmyZ4OxX6jC8GQ8iup5LOuPMS1FSzRPwBkHev63GwoqUvBPaPAxK8OGtVKzw==
X-Received: by 2002:a53:d5c6:0:b0:635:4ecf:f0cd with SMTP id 956f58d0204a3-6361d701cb5mr118609d50.25.1758746652609;
        Wed, 24 Sep 2025 13:44:12 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6361e8c25dasm6544d50.4.2025.09.24.13.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:44:12 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Wed, 24 Sep 2025 13:44:06 -0700
Message-ID: <20250924204409.1706524-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drain_pages_zone completely drains a zone of its pcp free pages by
repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
In this loop, it already performs batched calls to ensure that
free_pcppages_bulk isn't called to free too many pages at once, and
relinquishes & reacquires the lock between each call to prevent
lock starvation from other processes.

However, the current batching does not prevent lock starvation. The
current implementation creates batches of
pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX, which has been seen in
Meta workloads to be up to 64 << 5 == 2048 pages.

While it is true that CONFIG_PCP_BATCH_SCALE_MAX is a config and
indeed can be adjusted by the system admin to be any number from
0 to 6, it's default value of 5 is still too high to be reasonable for
any system.

Instead, let's create batches of pcp->batch pages, which gives a more
reasonable 64 pages per call to free_pcppages_bulk. This gives other
processes a chance to grab the lock and prevents starvation. Each
individual call to drain_pages_zone may take longer, but we avoid the
worst case scenario of completely starving out other system-critical
threads from acquiring the pcp lock while 2048 pages are freed
one-by-one.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 77e7d9a5f149..b861b647f184 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2623,8 +2623,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 		spin_lock(&pcp->lock);
 		count = pcp->count;
 		if (count) {
-			int to_drain = min(count,
-				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+			int to_drain = min(count, pcp->batch);
 
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
-- 
2.47.3

