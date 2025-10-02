Return-Path: <linux-kernel+bounces-840753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78007BB525B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A5F4852AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A736221555;
	Thu,  2 Oct 2025 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um8Uxy3J"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBB1C4A10
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438003; cv=none; b=dS4VjP7+FqJe6L/PGsWOle2wk3jzVzEzqC4Jra3bZp3cbv11KQQUbYyoGF3etp3NMZdmR5E6BspwRbhQFzGVIuCqNa4y3vm/OECNcRH/rGnzHCK7fAwEamBqYnHm+ujdgwgSODEc8ngD9rZIB/4bErn5pZq+WknSZa0H5FjHIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438003; c=relaxed/simple;
	bh=LpQAUeGmcEFMDxio1VSUeBPLxCuWe9iLxX++cXo0OC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBRFQtZ6iPLQhbzqVhchHw0PawSWNb1QQgaoubgErzh2Vg5rxiG0lkXYeSqWj24JnZ0NF45lOnByOhf1KnV2sP/gIGCu8WrmAgL5l09eIw4KOSADhvn+FjsELgoi7VyGVFStqSNphqcsH7gXFfoe0iTL5ez6l3p2bUJ/aYcdKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um8Uxy3J; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6051aeafso16483957b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438001; x=1760042801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtg5K7mFEUovxKHIKqKvsg9K7Q6jEbo/PlbyX0ggh/g=;
        b=Um8Uxy3JxqRfdTagbLel+7wHMclWZlYyAMXR/P0nUe5FESqPJjRJiveQvb5K6s5hUl
         0bKKH6RI6TKhJc/lZderkOExbMdaJ3hL1sgWtxrjTPSq+pujwxLtarn6+UOy7bRi9xnx
         0qyW52IdOFXmcoPz/E/20OnLnDaZjQ2S4w4+VXBpE8Lz1Kajj/rZYKZiBQmmq9jPm63Q
         KKZBvuug5H4aFBa6Tt56Jof5UbDwhLFcaNbdlF/5R50Nj2VHWQjJE64xfJilyz+XPVgh
         Vbgcn+zy9NgcUb+k6xHRiUySzkfzxMbGQbmoVUCYeIe6ryopH+ZWzms7WvluLlyYWIT+
         rY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438001; x=1760042801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtg5K7mFEUovxKHIKqKvsg9K7Q6jEbo/PlbyX0ggh/g=;
        b=rJ6huRzBucO2gpYJp+bqc7/lnXYLqAUt2FpRk/CFBxeON8cJcOzgIYqCycF4wv546+
         yqoIgJlh3H7XLyHRdrHTKkx1ar83sdGUnieMnA9em+VDkzUxZZFGIq0+IIhLfwmw5emo
         RgDUCuILtE0g4ubhv+RwQbHoh2W7i9hQjZMrhK/+wG2FUUBF4uuTMwlYcQ0EjQbRBLv4
         kgau2GgzDXlp7xVGNvU0c712xQDO+3SlY26PP7agaE3z1/LvxFS+jNvB7ViT7etqybkE
         inXQVnmy3YshYW1m1PdNSsdCq2iMds+DtDqaHPH8Xokwa0JSyqZEuTDeisba5cINi7BZ
         MrqA==
X-Forwarded-Encrypted: i=1; AJvYcCX+wKXFCEuWDHH0YHLh0ujGGBAdGvK7P8f9cyJH4BVspO82mrCMFnQi0q07QfEppsOU1ea8EBw6gLWsTLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOB1pNcsNwp23MF6wsWBu7faxcZEPmYz9kF/VWQZ1eY77ZdZSK
	ww7Z2VGPkMVNkozlsbeVbFIjvmnuxXSvDEhdU7MHMRJD2IkcZVZq+1yG
X-Gm-Gg: ASbGncv8++qKLHBLTe09rGCgBmDmPD6UaNDJLID8hZS5hnGcpd70l2CQSyAELkQ7UlW
	1F2qjwsQRgDU4K5maLDjR4NEx0x7cVuhicNASvrouXrUoTrzcEi43dsY4yhfNrDfAlU4NLV+td6
	9ii+meCxB2VNarbYWeT1UVa/hCgWdYMVL1FCjNkoMSl/V8WBHU3R1WAW9tg1lJWQkIEHvtZM1oo
	rhI3D9IkfS1QfE2/aPGrojFxYewRjvYEmegzhG2jBHH5qSmqqdkqSrAJBAPGyCHUl58JWuDhslP
	4KH/jL62tSMKH8lPs2WVdDZ7hu6T+oHIRmRbUg0F2RQ0ug+XO1vyEacCSwkKR3/dRLC0ApEAsOe
	HU+rt/aski9axHbqAu94cGuQA+faY8KJOxyB6gyPRQ+Obf0UELpz4+pJzffs9LrUZC1G+z6TbX0
	YLHAYhE8IPh5+gLa+l/bd2IFoC
X-Google-Smtp-Source: AGHT+IH1dK4l8EVgnO4Il3oHYv3U0XOv5jcIZNNZM8+Kj7vgvveFLxrmq74ZKJzTaehh0HFqLOPNkQ==
X-Received: by 2002:a05:690c:6085:b0:772:2b5e:1f10 with SMTP id 00721157ae682-77f9456fdf6mr14998337b3.1.1759438001032;
        Thu, 02 Oct 2025 13:46:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81e63e8bsm11224447b3.67.2025.10.02.13.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:46:40 -0700 (PDT)
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
Subject: [PATCH v3 2/3] mm/page_alloc: Batch page freeing in decay_pcp_high
Date: Thu,  2 Oct 2025 13:46:32 -0700
Message-ID: <20251002204636.4016712-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002204636.4016712-1-joshua.hahnjy@gmail.com>
References: <20251002204636.4016712-1-joshua.hahnjy@gmail.com>
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
index b9fc357d2d48..f525f197c5fd 100644
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

