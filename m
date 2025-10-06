Return-Path: <linux-kernel+bounces-843103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2C3BBE68B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD45E1899378
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA272D6603;
	Mon,  6 Oct 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4prSP9Q"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE442D46DD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762476; cv=none; b=sVr/N16p/ED6VXeq4qL/XuwT+kn/IOzMrmUQFvsAC1Z3j+Dl0LKi500XB4+nKYUupuZf3azzdLcA3q+6WdwIHXqmCDvzz/WctJQjpTsxrjqrVW6Ay4a6ykenWTNQzjj7KUOEF+ts5R7Equ3vFysoPK90k4UPJSXR0V8Fb6v4iR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762476; c=relaxed/simple;
	bh=XldaXHh6+du9dYKEt6FrRfY8L6LJ6MnUzLvdUEwiC88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPxlBnkq8mDhLgpg4BIzD3o8z22CTxwzO6DvouhyN2b9QeP/rQyAb4XqPJ35xARvYIHWkyl/V4dzcGFbUPl8zuLKbsd1unNNHa6bRqNpRAnlqiS0Sf+CoLKp2l+aff10dqn2NOn2IOlK18KFmV5JnYop9EKtqnnLKUxF0lTR3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4prSP9Q; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603b60cbso52639547b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759762473; x=1760367273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nMWZC6mx2lLvBlTIQHePU7b4rUHTiXGBCIFc1BcdqQ=;
        b=N4prSP9QDWfogMQIAHW8YYHCCho1Fvn13whpXKeBS4d8ku7a7xas6lNgWhUoqj/Kgb
         y2hYapga5NRY+f6aI1D1wbAJaw1hg8cCRrF1ZszyW01454CDL8dknvf5iqjmqhmqoAcq
         UOrqokHrK9owNVntkMisIM7a9ZUlj9u1ykhzX08k8P3cocqm082iWxbw3tHP/c2muafE
         J76hEtIr02En5ezP/YBvgaCI5A5nhp1g1E/fxGquPnH4/n8Xo8ogRg6o2sHW09YlpsTL
         8krp0Y35R7mRPYabQ1uJyyNJtJBW1nFJ9OJFBA7kUZmkdDQ6ZHCpkGAKytGDFwbe4HB3
         JueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762473; x=1760367273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nMWZC6mx2lLvBlTIQHePU7b4rUHTiXGBCIFc1BcdqQ=;
        b=ovO5hsmO+NTCbBGQ05Pbrz0Ewg8MlJ2+lB1j81M61pNyl3fIWaWgdiZ8Xlt9cW+yyf
         oi+b0Gp0DEW/FOrURUBmKiEsG50wqkcfFilWel/gx4OSgO0a08ewFFyf4HLb3j1TFPDk
         S57QFqQ5OLC3nZ5vUqsksxzrtoKKLvieEXrGcs7Gu0iGOlZY5TDdZwEtypky7Q0MZVVw
         +tX+D6AD3zwA2CeNpYjYDit7HJIBc/NzRBie6AtXlAYNcJyqRb5wOPSBolUSVZGLDT73
         +rs59tTzk8QsMKjwx+mrFduQtDCyhT0FwxnwxOTC5fwGbt4qtBQSgFLcik6MIeduwcG2
         OCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGqFekCw0YIwcQSiSEZbpwfFyhW+xdc+0bE2RC1KADltHRelcn4hWPy7wmWD5aUQi/UsbdskPlqtYmrF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyCv3IFjzQLhToqLalfWxOE0vpsIJZHoiCW6w6zm4lF5v2mRW
	6tFk+9n/3GFYUuQRsyHAjnv/pGNerNsQgYx/0nOKOUz/kIcGTcTLLB15
X-Gm-Gg: ASbGnct4Ngvan4PDCoFvENFDl+GoHxMm4rd/0ak7ch1aStiATJdxT6P3XgKwEVntpGA
	Fxe8vyQZOwFA/nzjtXXLLHLQvzacgs7VO0NijYh/1+IFUvk7w8WA9gltSwAalbH+jUYMXl16PRg
	6+U5rTo1kdztjDs60/4c6SWhCNxIRFbt1pCVWwQKf8GNOWDn92dZNul6c6Kl8xxTgGMU3U8J21K
	ZP3XZ3Zh3NGdPNioVpi85ZDcbMDF1KyWj+W4Doq+h4ITLWsXEMUluYluhrNjitJKZHb3dBkIR6B
	VehKqk4FdI/vdBFCX02fi3PeUBl0VHMNlHE6j7ZN3lQ387O3GT5YlgR0lUG9An4g6Eu6vQYZ9cj
	WDBf5YhNgpUIgEUjIQEx/HDlw2o52rJDTYD8VShMHBzbRaHRjHywmuE6BOuMD/THey6BWqvWH/m
	Z712DVf8Qo//aw
X-Google-Smtp-Source: AGHT+IGgzF4VnegrQWIU5b5yBOpwKcD6TgCX+7ECIXBS4CzsiVPeoDVDYAGiYdKi3P9JWovBlwsomg==
X-Received: by 2002:a05:690c:6202:b0:729:62ec:9185 with SMTP id 00721157ae682-77f946783e2mr158179967b3.39.1759762473144;
        Mon, 06 Oct 2025 07:54:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77fa470f315sm26419187b3.10.2025.10.06.07.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:54:32 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC] [PATCH] mm/page_alloc: pcp->batch tuning
Date: Mon,  6 Oct 2025 07:54:31 -0700
Message-ID: <20251006145432.4132418-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently while working on another patch about batching
free_pcppages_bulk [1], I was curious why pcp->batch was always 63 on my
machine. This led me to zone_batchsize(), where I found this set of
lines to determine what the batch size should be for the host:

	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
	batch /= 4;		/* We effectively *= 4 below */
	if (batch < 1)
		batch = 1;

All of this is good, except the comment above which says "We effectively
*= 4 below". Nowhere else in the function zone_batchsize(), is there a
corresponding multipliation by 4. Looking into the history of this, it
seems like Dave Hansen had also noticed this back in 2013 [1]. Turns out
there *used* to be a corresponding *= 4, which was turned into a *= 6
later on to be used in pageset_setup_from_batch_size(), which no longer
exists.

This leaves us with a /= 4 with no corresponding *= 4 anywhere, which
leaves pcp->batch mistuned from the original intent when it was
introduced. This is made worse by the fact that pcp lists are generally
larger today than they were in 2013, meaning batch sizes should have
increased, not decreased.

While the obvious solution is to remove this /= 4 to restore the
original tuning heuristics, I think this discovery opens up a discussion
on what pcp->batch should be, and whether this is something that should
be dynamically tuned based on the system's usage, like pcp->high.

Naively removing the /= 4 also changes the tuning for the entire system,
so I am a bit hesitant to just simply remove this, even though I believe
having a larger batch size (this means the new default batch size will
be the # of pages it takes to get 1M) can be helpful for the general
scale of machines running today, as opposed to 12 years ago.

I've left this patch as an RFC to see what folks have to say about this
decision.

[1] https://lore.kernel.org/all/20251002204636.4016712-1-joshua.hahnjy@gmail.com/
[2] https://lore.kernel.org/linux-mm/20131015203547.8724C69C@viggo.jf.intel.com/

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..b4db0d09d145 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5815,7 +5815,6 @@ static int zone_batchsize(struct zone *zone)
 	 * and zone lock contention.
 	 */
 	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
-	batch /= 4;		/* We effectively *= 4 below */
 	if (batch < 1)
 		batch = 1;
 

base-commit: 097a6c336d0080725c626fda118ecfec448acd0f
-- 
2.47.3

