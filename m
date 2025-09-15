Return-Path: <linux-kernel+bounces-817806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70766B586C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB96203C15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFF2C158F;
	Mon, 15 Sep 2025 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETnzgaJY"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F812C11D5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971688; cv=none; b=fccM4vVhfhaabyklABqRKGBzvZddeHf+1+65i7iz69W9wHhFPWjn9iy9U0lGAW7c7SOpd5dSUZWzv6Zd4xO5ja46ffST5p60kx+R0vMD68dSlVkhc94Ze7fswxfQApyL0AhBAiGWYQEUu3xg0cHNjp9L6TlsOuGKGG6JJX/A6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971688; c=relaxed/simple;
	bh=JAKRLFebOpbcyKXt+Iou4Yo/KY8c1E/crm+zwHsW/QE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mClA8upZJZXoMlKlzExj5/KuhJBEI598T4BnZrXQycAowDMYpGt9/Mrvb+CZFMBDXHn/MkhRHovz0vEwoIkSANOJn78u/7FN8f+OxLxq6WO2hDpY+tObqrgB689keHnnZ/dZQoOV6Y/nGXtgCpW22p0bnE/M8ioS8CS9TvfLy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETnzgaJY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32df93c793fso2666559a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757971686; x=1758576486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fEJ6IElFOeZzP9UWymvXhcSMMsB3bmGnSn0zKtn7xw=;
        b=ETnzgaJYufxMTTcRGVMsYAkj5YYz/vkLNdz6y2e6g3tvRNcEOHneww0QhCuk3OLOt8
         3pGgx3DQDPjE1GD799QV9iBDbkVuZ/si7cJd0cIBUY4jmtI/08jHe1+a1LMVUwk3MMTb
         rfUr1gNe1xH68CuJldrnucHC1PB1ql55AV/AzpvTJGh9zmxArClVGCA90WciEKrIXMO8
         gwd3OaRk7cZi71BMKXJSkKXQTNzSccyyC/DWS46aeKSIdbeMXlE8VHj65NilcMj0FA4X
         oTxaTQ+XJTGXo4IQAaroIZspA46+AWiJtT5CL1i+6MhhznWg5iue+uSOtg126WNraq5f
         Tpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971686; x=1758576486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fEJ6IElFOeZzP9UWymvXhcSMMsB3bmGnSn0zKtn7xw=;
        b=PPtdyzkt9L2s/qTa2X2QVZ9p89hCHzsIlKc4PmzpX9F1fbOXy48jWWvWNbVwydSt9b
         4TlaKZPiDJSfbi1/ESMOfEpBJ+ZyN5B4Vh/V3F/4Rta4jQLyQrMAb5pra1kOEFYgdfHV
         20WJQy8wbjET+tB5n1iX4EeGMJQsysA/lZo89+ZD5JdySmlmnmRcQ7GMW6eR8kvK2F76
         c2H5Ra6jK/hB6dp7PDQAJGFVdWh//IBv8MHep3TShO/HDgARd66LYaOWFXdfT2pGHchi
         3R68UnNFl5aRh0Nu2Iy8N9UgbbXHjsJAlOE+D9iAZJ+7J0b+PxOFjA1frUIjoGGj6jRh
         R45Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJPIDVYRA+aM4JEctmivT9xxIYKW+m7yg3FscKqaSELMDcTOwoR7G5gOQyZxbaKVaN7O8vsbLN9NAtVXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JGlYoX7S5Yp5hssLjVKDS7yO3FDKHFTvK4MV9BKLw1oNQPIt
	kvAvD4dIYNZSSnec0OA9iaN4X6tFP3lVL2hWE/fcVtYisYUD0lo+uIt2ZW0qPCOlvW9jKaS1m4/
	Kl8okQQ==
X-Google-Smtp-Source: AGHT+IFJUPo9LPvtAkRuwP8Wle8PNDVxYyAftN39GDpSH2OdOqb+BpCFXVNO3SkD0W3Pv7ttuYAJ7A5yC60=
X-Received: from pjtq15.prod.google.com ([2002:a17:90a:c10f:b0:32e:8396:7798])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec5:b0:32e:8c14:5cd2
 with SMTP id 98e67ed59e1d1-32e8c1466b2mr2709252a91.28.1757971686028; Mon, 15
 Sep 2025 14:28:06 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:27:56 -0700
In-Reply-To: <20250915212756.3998938-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915212756.3998938-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915212756.3998938-4-surenb@google.com>
Subject: [PATCH v2 3/3] alloc_tag: avoid warnings when freeing non-compound
 "tail" pages
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When freeing "tail" pages of a non-compount high-order page, we properly
subtract the allocation tag counters, however later when these pages are
released, alloc_tag_sub() will issue warnings because tags for these pages
are NULL.
This issue was originally anticipated by Vlastimil in his review [1] and
then recently reported by David.
Prevent warnings by marking the tags empty.

[1] https://lore.kernel.org/all/6db0f0c8-81cb-4d04-9560-ba73d63db4b8@suse.cz/

Suggested-by: David Wang <00107082@163.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f54c5ee1e318..2bfab96c207f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5240,9 +5240,16 @@ static void ___free_pages(struct page *page, unsigned int order,
 		__free_frozen_pages(page, order, fpi_flags);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
-		while (order-- > 0)
+		while (order-- > 0) {
+			/*
+			 * The "tail" pages of this non-compound high-order
+			 * page will have no code tags, so to avoid warnings
+			 * mark them as empty.
+			 */
+			clear_page_tag_ref(page + (1 << order));
 			__free_frozen_pages(page + (1 << order), order,
 					    fpi_flags);
+		}
 	}
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


