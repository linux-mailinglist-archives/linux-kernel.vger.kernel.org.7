Return-Path: <linux-kernel+bounces-817729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF2B585B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9497A3C68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211128C874;
	Mon, 15 Sep 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmx2116K"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8A285C9E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966966; cv=none; b=nJ9CydJZk5lvNEdKMlhem9VRCz2EoQtDBluTDhfJISeVaCQE+gloOPbfj4yiAVFGflxtQBLictbHSrEI+hO937JLIOeJ5o9GlEVOPRfhTpKQd1EiKRxDDJFBwCtqXU6yqISJEaRS5ycTC3tAcD51/g9Wy749W5ljyNz05tBWgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966966; c=relaxed/simple;
	bh=GJlUdQQFEEyij2bCCUq4jMjDPlMzhjEk2ZEz0qtOETA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgbAo8fczujcn/saNS87chlugqh/jlVXzbo2W3J1VLZ4mt4nTpLXiUWR0R44K0n1/OdKzinDgNQF9YOrJai66UNIr2o7igsmTAJSf/QDOyVS6iOPHCnZOlRLSEuCM2WIpc9fOZbRZIk9opZFF+SSsznHrCQ+DOoKFab25ThE7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmx2116K; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e00c72c0bso2171142a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757966964; x=1758571764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibj1DZeI6DujSHcNfRa4mHa6id37sgMiM15loCqZ4m8=;
        b=cmx2116KC4Si12WHcWX1tHWWiKg7uMwEQDsvO0qnGa9jLCKKESJDUk1fN0ClUJ0FTA
         le1bIY3F+UEAWNKLDysRuKkDDIasY0i49omri4b1JGR+H2DRG94qHEyNwGw/+BHZAOAB
         pj1SnGQC/rmnbEPF77NytKecsaZQjUlKpOHBia9prRhlOTS370pEIdRvVjDr+hRW4D1K
         uHwo3bU9nZPc1HlDapItmOe9BflzfTXPrtW4+7N23GGbIVV4s2ne4OAnwGdSkDqObJti
         z7p/J3N3lIBV7DeHqA00c0RfIImltXbtrPlTUpzZSrL6AjGsP4rPSBSzlQNJvoiZ/2vx
         XOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966964; x=1758571764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibj1DZeI6DujSHcNfRa4mHa6id37sgMiM15loCqZ4m8=;
        b=iPVAANftZ51rT+ruszpNSUREZTx0ixwNjDBhY/NySRGpOFuUF3k0wgnnrrsQjLgeSe
         qEQ1ddXsFBZAi+OKzpzOh5AC/G+yNZGfhZOHHsaFtZgzA7/pPoXoBUWrTNSJsvYY3guo
         cnn3KJCDEgfjHXDCaE5uzcHcfbYfXjtma2lbUlx+AB0AFf3oQ/CiMPicjIqxBR6QBQ0f
         VIOZryrmq/kowqoLyvFyzc/9KZ/Bx36XncnzNYZMEVhtWPEvJRKnsCPCHNPra0SpyLbE
         CuHPzDHuQyHYEOHoFl4FeWBL+zcG7kYa6prgexnvkVVlzKSKbksLdJ6SUehXlVq+gqFs
         2wVA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Mm8aP4PFyisNJ1I1UsMxjB9Ct7M9qlplYLh3ul16iL4TNLhYgFsUCiCdRFkc7x7MMXCZj5BdJfmXauk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctHAaWZR4ArERG4USP+GvLsaQBJr/G1kfPct1bmHR4L/RJ2So
	fQmUT2Y5wREY3P3n55JNZ8RZm3naTOXCYwBHt/eN+v0g6EebxOE1W0IEjpHUltkhUxYRypSo2/D
	VgxXjhw==
X-Google-Smtp-Source: AGHT+IE9+G8Ng/84dVBNdtIEgBnECFOfJf1D0wcN0DZsNSGryUzvVxVuPH4z3IvZrC3hI4ZRRiLJKETXuFA=
X-Received: from pjhu61.prod.google.com ([2002:a17:90a:51c3:b0:32e:18f2:7a47])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5786:b0:329:e2b1:def3
 with SMTP id 98e67ed59e1d1-32de4ec338bmr15775459a91.10.1757966964082; Mon, 15
 Sep 2025 13:09:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:09:17 -0700
In-Reply-To: <20250915200918.3855580-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915200918.3855580-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915200918.3855580-2-surenb@google.com>
Subject: [PATCH 1/2] slab: prevent warnings when slab obj_exts vector
 allocation fails
From: Suren Baghdasaryan <surenb@google.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev, 
	alexei.starovoitov@gmail.com, usamaarif642@gmail.com, 00107082@163.com, 
	souravpanda@google.com, kent.overstreet@linux.dev, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When object extension vector allocation fails, we set slab->obj_exts to
OBJEXTS_ALLOC_FAIL to indicate the failure. Later, once the vector is
successfully allocated, we will use this flag to mark codetag references
stored in that vector as empty to avoid codetag warnings.

slab_obj_exts() used to retrieve the slab->obj_exts vector pointer checks
slab->obj_exts for being either NULL or a pointer with MEMCG_DATA_OBJEXTS
bit set. However it does not handle the case when slab->obj_exts equals
OBJEXTS_ALLOC_FAIL. Add the missing condition to avoid extra warning.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Reported-by: Shakeel Butt <shakeel.butt@linux.dev>
Closes: https://lore.kernel.org/all/jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10+
---
 mm/slab.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index c41a512dd07c..b930193fd94e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -526,8 +526,12 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
 #ifdef CONFIG_MEMCG
-	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS),
-							slab_page(slab));
+	/*
+	 * obj_exts should be either NULL, a valid pointer with
+	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
+	 */
+	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
+		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 #endif
 	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
-- 
2.51.0.384.g4c02a37b29-goog


