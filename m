Return-Path: <linux-kernel+bounces-825152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3278B8B1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176D11B28AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EDD322C80;
	Fri, 19 Sep 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWf1+A62"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F2322753
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311552; cv=none; b=r81K4ducVjPzlpypOq9U1t+dbTRtl7VjRfORct7foL7Md6WFaKZXRmnh4rlYzNb2NiwQtRday72kQ4Ddmbs+6ng2/yi9mNWn1RJ48m1i6uuJKSnkR6AlysEzk38s0lsg+nLlBnwQ3dT02Ly2bh9JXeAgVb8GlYBuEkSYpjJQUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311552; c=relaxed/simple;
	bh=/DJi6ZU0FtcXqFd9Nu5mKpK8PpkyQYwpqq9uwgCiJuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmEh8WKv4uEXAA+2lVMtmUOA7D9EP5Aj9u+MsvVSBKfTIpgGrwiwszFT3VKZZhmADjMxWe4GtqOTRbGovkBS+r/yXjowqMq8Pm/pn+09uIqQU6MvvcGRqJnE7yRL1GvqGI9/llICoNH1KW9PvDmuykEVIZNHP4CyYIK8raLQus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWf1+A62; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5b96d2488so1878138276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311548; x=1758916348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeFP7YZ+0ipT42W2voI8x5bVWJQwIjHVnEimGCqA+fo=;
        b=YWf1+A62Bv6ktG7AtHEj7U4gELZJFiVV1IX6XEAIQgPM5yHsKlxY5vMXQApXxlM+AY
         4zawzFL237Ivi+kG+tk/PpD2MgZCl288HMwT9zKinOYtbDKOyqUvjnuboPRX6TBStMQb
         PVXm4xB6pUsymFB2p4Xp/0ylDW6ee1qpGKKNv3lauZHkbiVHJLThnEIAqSZ6oVkr3dWV
         qXIrjcTRw6xTQHD6pCLz33tcd4QsXVM/mnQ5ZmjlySM1YMc4GlPyQPmJS3OGlWAo6UHJ
         9BHulcubeeST8V/SPXjIsN0AVwufdUS4epLBFzvvkAv4t/seTClFLWzETpocF7yV2Wjy
         VChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311548; x=1758916348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeFP7YZ+0ipT42W2voI8x5bVWJQwIjHVnEimGCqA+fo=;
        b=Eiqapdz6vGQkSg/mK975X3LpOcWUnCvSKLzIiF4haGGvujSyNAjUrLu92TGXghLcYP
         WxR//sl82g0YFYMdT/fbqQN+9+nUu1OUvP57yM1dBT7xYLTY6lX30GcH+KNAkxOseMEP
         ZnZbX612SONSrbVueu6k1DgaL82uLCXdVO7utOctDSPNi7UtKtmPetQ+BSIPPMVgjklo
         4IEytFOWEOOiBaGpLLdLkEUuwdXVl8MeIQv36bAjj37FqiBvtOHghbSpV3KH8AEMDTVK
         q1DGHObazBxXxf+A2k3PfiwN9JxKplrcykCZbwyUlGQgxeoeO9orgu+zYwxmgYbEC53h
         Q1ig==
X-Forwarded-Encrypted: i=1; AJvYcCXiNL615kVdEzCiv6LhR9JQUFCbgjb58dL1G6IPrqidiA8qI4gqdINMbqGBqd1CQWmoWQKmLPRJMckmq4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cUtneOijUVqQ5UK3Vq9YHunzvhjt2tGWGAtPQP5+d/iRR5g2
	0Jap3JEVP/KR3vgiQ98jBnJHFILbNPGSQgoH9qMJ/8tmRoWWl5KItc4AQ/E7Qw==
X-Gm-Gg: ASbGncsy2H9g9QQWR5inj7qlKmyBd9qyl8JCk4zUpsO70sCU8wbzwMfIKPoGXg2McrT
	8UnbBUgh7lv2hLz9v5HQX6YedI7haHTa6uX/5UgjE2IqXODlWLM8UbfXYgTnZt3QN4XfZLAZhE7
	PYcSJG0bX0cW4dtOGW99KVDUhBa1fdlbBd8yhykm07CtADUJOVsy60Q6PweUaTrI9EkoLaTafgI
	qGObFOfykxTd+o7y+lcuosdtPQjcIUeR8uaryXIm3H71HEb/v3GX9LElzFL0792q2ZTH8n8zCkv
	/gh2ymZ+7rxKhUks+qk8lYNbXlz/o+um7anUfvogT1/motBz+VyVX46OH1K0wfgvj3YY5r/uPBz
	EAUnbJXA5UThsn1VQT/7PlEMWC3BgkuzvLzOj61dAqDWKXk5usbaAdw==
X-Google-Smtp-Source: AGHT+IEsrmhTSR/Ouh5RyIoB6jxstfFRsj47OaTQJsuUNGkSTK4pmk8eUUNqdr9I9Afg7H4rSVdbiQ==
X-Received: by 2002:a05:6902:70f:b0:ead:1e1c:2754 with SMTP id 3f1490d57ef6-ead1e2b7e0fmr137258276.42.1758311548027;
        Fri, 19 Sep 2025 12:52:28 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce974386sm1950713276.28.2025.09.19.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:52:27 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH 3/4] mm/page_alloc: Batch page freeing in decay_pcp_high
Date: Fri, 19 Sep 2025 12:52:21 -0700
Message-ID: <20250919195223.1560636-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
References: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for pcp->count - pcp->high to be greatly over pcp->batch.
When this happens, we should perform batching to ensure that
free_pcppages_bulk isn't called with too many pages to free at once, and
starve out other threads that need the pcp lock.

Since we are still only freeing the difference between the initial
pcp->count and pcp->high values, there should be no change to how many
pages are freed.

Suggested-by: Chris Mason <clm@fb.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b861b647f184..467e524a99df 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2563,7 +2563,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	int high_min, to_drain, batch;
+	int high_min, to_drain, to_drain_batched, batch;
 	bool todo;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2581,11 +2581,14 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
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

