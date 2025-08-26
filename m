Return-Path: <linux-kernel+bounces-786765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74EAB36876
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C6B566E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB134DCC0;
	Tue, 26 Aug 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETxHM3AD"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDE42AA4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217224; cv=none; b=iEu9K0asNrK6XEj03dMOPFkc6hGejGo2LK+0tYEmrFY+ESiVjSaZb0J8L5h2ZKKzP5xZ28rC2a1kK19Cg6c96ow9VHflSbeBot18zRUHf/u9xL7ghKFLmbMyIy5ycdGna4z4z4j4kAmQdM645Y5V4b3BibAhlPcoiXNq7zKwyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217224; c=relaxed/simple;
	bh=ch7zapkbifVrVlNXs7zZCY/pU6FG/cdoykXi/3wq5rA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nh2S5FkawMJNdydlp9pjYD4XxykJjJ+qZ9hmt6qbyjbiDqdGNmCWCOQ0oJu8Jzwy56Lm4A8tl79hq462XNDeddDlovPm6Tzr1jOtK0/jZXAh/W2Yl+tgLATMpfbawXhONB5+fTDmHw/XLn0oiuUopp97hEcRccQ4zh8kxs8gWco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETxHM3AD; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c75de76cacso2357999f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756217221; x=1756822021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIM/U1loAWy1WHGaIaxXWm/mISmivdeS4MOXtnSHfXI=;
        b=ETxHM3ADQXoxgExz6bFyZa0qo7xgFScSaI7pOw3gfIveCfIwgPjBopLI40bYazRByO
         GCa8MWema0kW1jSJuI7b8QaANv61ciVtOr/Z9WpZAZ6kWTOVdmsuB2HB5zysLkIIODrl
         WSI8fMctthZMpmmeCRaR7D4l06WJ44Fwe2iaqvBBoxQucY9LGDRT0rsyI0ZmekArlKMZ
         goHoATWXIBngUea/yZkq6e7rjjHI5ShPyhvHYG9LRL575V2ZgClsETn3xo3foIoaJ1Pm
         h9hF/QQXw2Q1TDHtaoPmhww9F4a7eqiJdDPky01Bsv8QA3fYSB8Xm9ddefoqDcDRJ2ZX
         BNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217221; x=1756822021;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIM/U1loAWy1WHGaIaxXWm/mISmivdeS4MOXtnSHfXI=;
        b=k+xfCmFJWQWP25n0znPq8gr7pJVBkZfPEEvnm6V5mcyTcjHzHKOTx9/sITXqA3ZZDD
         y7x+3zPxUSmAM/g6scu5o59c9e/c7kppCSSnofd7mq1nUOKP30+bVve+zJo0ubTEMzKQ
         By1vUij9+Bw2dGwR7UZzS1E0ledb01QmsGSuFuNzfLFFA78KGx6MsSD7K/p3ySjo/Px1
         EmNOKprMW4VfenIel5XUih2c/ACGiJdwHKc8q3QhHB+0NKV8KsIJnP3v9kLgBtS45tax
         SCidDcquUtDTfThv9qBNFXxsERzC9oubFCu9XMgVbl/JvYtxmZ5YNgq4lLmOD5z2/6Sy
         S1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXe3wTeGxQhpWZQg3fC9LiMhI7WRxLinMvxASXsW3Mk5Y/jlx32+ojrd66E6FN70+oJn9RLNOoi4JU6kEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+j71gp0AdgNZ2cLoTykpE3ia+Cpz6R0MXQupgvyq+Lrb1AbTT
	XKVactQUPKd5YrDW7Ooz0iLS0LXpwpqvXh+8AqPZrkMDeoHC8BaB4fbD8GJ9v9g313NmePmFIKo
	5LmiwrNTU5V320g==
X-Google-Smtp-Source: AGHT+IE5PDrKa9lrBaPKlhqfT8IBKuaqTzSTLSoAm/eLHLIugHPgVuptHw9Og68GQkPrK5CfjMfI5EsdL9bWgQ==
X-Received: from wmsr15.prod.google.com ([2002:a05:600c:8b0f:b0:45b:5f83:6ae4])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:652:b0:3cb:a9e4:5a56 with SMTP id ffacd0b85a97d-3cba9e47299mr1276970f8f.30.1756217221050;
 Tue, 26 Aug 2025 07:07:01 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:06:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH2/rWgC/x3MSwqEMAwA0KtI1ha04Ge8iojUNI4BbUuqMoN4d
 4vLt3kXRBKmCF12gdDJkb1LKPMMcDHuS4ptMuhCV0Wra4UrGXcEFRd/rHZEvwWD+yi0y199sJ4 qtHNrdQOpCEIz/96+H+77ATQ84N1uAAAA
X-Change-Id: 20250826-cleanup-should_compact_retry-9c6b5cdf8d27
X-Mailer: b4 0.14.2
Message-ID: <20250826-cleanup-should_compact_retry-v1-1-d2ca89727fcf@google.com>
Subject: [PATCH] mm/page_alloc: Harmonize should_compact_retry() type
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Currently order is signed in one version of the function and unsigned in
the other. Tidy that up.

In page_alloc.c, order is unsigned in the vast majority of cases. But,
there is a cluster of exceptions in compaction-related code (probably
stemming from the fact that compact_control.order is signed). So, prefer
local consistency and make this one signed too.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5fc76f8a7739e8515d7593e0ad44f9..8faa0ad9f461fbe151ec347e331d83c2fdc8cad2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4182,7 +4182,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 }
 
 static inline bool
-should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_flags,
+should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)

---
base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
change-id: 20250826-cleanup-should_compact_retry-9c6b5cdf8d27

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


