Return-Path: <linux-kernel+bounces-817804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6DB586C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F5D1B24CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E422C0F8F;
	Mon, 15 Sep 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RoJMP28"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84C2C029C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971684; cv=none; b=ukJerjZ7GY1NxHi9emuNve5pRPDvnTHtuNTZohcDZVTy8hNXZEVTrE5nUK5dFNpviMzcOXaxi56Vh+M7+cGLhG32Awl2JWZ0YWeBQvgCHfP0+8dMCBf9KwCELeLX/QgLLfSgjoO8aurTaQwmepixcFNKFmfrutl+nnW7jyKh2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971684; c=relaxed/simple;
	bh=BWHI3euYFhYckei4nX2XlLs2/iu/aWT7eLB3tkhlhVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nhzJ4mJTSiJdY+LkuSz3udNxLVMP44Gh6p3k6Q95rtrt0y04nFKN943HzBADaeou8oW9u5Fw5HAXe7Rd33aVybLR8CheH/kUbFdKv/oycxON0BAqRLcvUxH0rNo0XEj5PinFJO1tcdepmtUPuPgtOYkC9ipHpUbdj/t86be0hG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RoJMP28; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2675d9ad876so15510015ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757971682; x=1758576482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2Hz1JL08Ae9YH9Hn+DIDbn8r5v52DDgbIHCorDchyE=;
        b=2RoJMP28KLpFDlozZJ/PqzDGIapebFpvroX2agwaMIf9SC+69nzhenC3vYcYPOvrHf
         94n3sK8IqCEjBGSrLTIA+CY3QWumsEFB9VIxYt+T0GYoSqZni+4fCzWTZlg6Je4SeSoZ
         dZ4NnIztnRU+SZvx3GA7owKsPjKUM8pLwmFmN2x6B0yAPZDDB14Gc1djFFpgYw09XeYJ
         x2r08dUVgLY0ChaewSvaClCm24gBFte1D+syTRBo6NqpuvsZw9jKAAosz8oUalYljZr4
         6Qk5FF/kX3zANqJIg4tdQa96lBUO7S8XaI1Ho762ZLjhEIlpod7BEu0qd8rfgsAfLpNx
         kkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971682; x=1758576482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2Hz1JL08Ae9YH9Hn+DIDbn8r5v52DDgbIHCorDchyE=;
        b=WpKMCv4F7vEbdG4nxVsg03hIdkIXuSF6h8mUy8x61xb4crkBVRytXzKiQDe+WG11rm
         nfpMnBW6JhT3HNtqBF+FvMuRR1jYYStaONhfS5y4dFmG5wou97VloZl0mL+AnR1lvUHg
         aBBETxuonJskY8A21JydTHJrwM2pM3OQKxdgJdg/s24Jm0khNeQfIzNUErSKRa7dniqb
         rg2UhgJzC5zVZaNEXrN4h4HuyBTPPl6uwVbhbDtALJy/Uva4hwEbjeptZkOk1GqgEvCE
         iytLPVnJfaEEVS3KgfC//aTvgBd08uZDYxI12Uf4TaqBiqkgDT+0J1/I9qCVcIw4HZJC
         aidw==
X-Forwarded-Encrypted: i=1; AJvYcCWnTR9zXqLj3SBF5vwAKG7D9gO9rpg677qVuAb9fy4fmLHb3ri8xUCOFEjOoCMr5s3d1RfJfg6LQlFcff8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ssPou+tlBfyXOQLiHkQ2FNaKsDZxlepadGQLD4eR1ToIAZQX
	n0RMZHMKblzlDJkr8fdBl+C0R0dw6KqS1fZ8bM/JRNJojVpreiO7wTID6zxbMIyBVRsfVYvCHiy
	fgD7lXg==
X-Google-Smtp-Source: AGHT+IFXwkTqMiXydSMPHIxdCSNKA0S/hLuGJlzEf2CG2PJ0l2U3kHl7v2nc4f6XLR3nxDEpOSny0E2guYs=
X-Received: from plar21.prod.google.com ([2002:a17:902:c7d5:b0:265:9878:486c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22ce:b0:264:4e4a:904a
 with SMTP id d9443c01a7336-2644e4a929cmr82325055ad.53.1757971681831; Mon, 15
 Sep 2025 14:28:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:27:54 -0700
In-Reply-To: <20250915212756.3998938-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915212756.3998938-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915212756.3998938-2-surenb@google.com>
Subject: [PATCH v2 1/3] alloc_tag: use release_pages() in the cleanup path
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When bulk-freeing an array of pages use release_pages() instead of freeing
them page-by-page.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Usama Arif <usamaarif642@gmail.com>
---
 lib/alloc_tag.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index e9b33848700a..715315f5d9ba 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -438,9 +438,10 @@ static int vm_module_tags_populate(void)
 		if (nr < more_pages ||
 		    vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHIFT), PAGE_KERNEL,
 				     next_page, PAGE_SHIFT) < 0) {
+			release_pages_arg arg = { .pages = next_page };
+
 			/* Clean up and error out */
-			for (int i = 0; i < nr; i++)
-				__free_page(next_page[i]);
+			release_pages(arg, nr);
 			return -ENOMEM;
 		}
 
@@ -682,11 +683,10 @@ static int __init alloc_mod_tags_mem(void)
 
 static void __init free_mod_tags_mem(void)
 {
-	int i;
+	release_pages_arg arg = { .pages = vm_module_tags->pages };
 
 	module_tags.start_addr = 0;
-	for (i = 0; i < vm_module_tags->nr_pages; i++)
-		__free_page(vm_module_tags->pages[i]);
+	release_pages(arg, vm_module_tags->nr_pages);
 	kfree(vm_module_tags->pages);
 	free_vm_area(vm_module_tags);
 }
-- 
2.51.0.384.g4c02a37b29-goog


