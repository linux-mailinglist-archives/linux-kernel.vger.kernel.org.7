Return-Path: <linux-kernel+bounces-790185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75122B3A1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EF91C825EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEE314B6B;
	Thu, 28 Aug 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+nZHf4O"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF611314A6F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391222; cv=none; b=Ou8viPRpclqJw+OfaPGIIDebmtkRjsIjTQ5K7YgLCypKu7sAtv73cvj7p7/mUGrQwOHOcoc8wq+Zare3O4GMvdpBHDK0xqGaSQ/tSSlzZO5+bL8JjV0YQ0i3emcLWGRznOSgTraPtZfelix/qKS1DnqnMcY6c+dS9cE/2TvNCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391222; c=relaxed/simple;
	bh=bxw+xUoOfWMhewdjMuJ7vIXsTA4InV9NWdMQF8fiRDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qe34iE7tjz5ZZDeVy3b4aowP2Nem11tnwrrUJkNTbQKSnuno+Yv+ZH+Py816nxf08In4XgM3WS5erPPy2GQ0pbJoMiY7H67M2o+CxyGOUy2jE9mfueN1KyoX8XNNTKRBube1wu1Xnzvs4NYvWHwmtiOfMH9H3kOARbw37Wbg5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+nZHf4O; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327b00af618so767642a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756391220; x=1756996020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjD5d97R1LAr1xBK44kBhUa1ACBsYphiOf/BSA+9IH0=;
        b=3+nZHf4OoVLOpoEYj2384Vprt8jdVn7RwBVY/33ibTFq8OGrhYORAELGXn1A9GWN3A
         Sgzrasxc4sbiNrAhreO4zlMklfx/6IMDcaIalUSrhtSGk386Eu9LTDlKXZDcl1kPyjwO
         8Kp53nN6L3TkxJl03uIBPC+3WDy/Hs9RW1NUeWQHNAuqAFOi/t9iCKzmJQUQKOXsjlJ3
         mCAAybprSmDWOwRwLcBvwINgnQy4+5WhwXiCdytxHt4Q45yuUOOcV/q/G0P8R3lIa2bw
         fX2PcZLLqu4TeXqsDLeB8MR0YXzESM4PdcbNNnrkfz0mpYpBGTx95gjVCZPad0e/FyhQ
         npKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391220; x=1756996020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjD5d97R1LAr1xBK44kBhUa1ACBsYphiOf/BSA+9IH0=;
        b=TCrs+y78U/MpNag8TFozdGkwgddpH7/aZMvAkObpmJXL60AOsU4vlfxgHyrKZEfECV
         rOrSWPyYXvUoFo7wL2W4R8NPWj3biAyKgTxWR2EtI+kU5vLQ6WcxEbZ7b5LH68FPlvSy
         FVkzo3uOCd+0enndn71HJwXpnOYsY8iuT0NdWXzaj4WpFCQW20Bbz3k6+0Xr/9uc7QYy
         jkRyufjeN/nkw3wx3KSKYQ3pPK4bZRkFJjZSE/rIg7FqAjdG7cjEOYnzongVmFO2vG3e
         7TTOM/QES+vGhV3RG7x4AfeyJBTR580aBpOPhZBFijNrEKMCcQ8t8YTjaOWqnpZdcT/o
         1LFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEBcSG+IzKaiy4gfjto+9LamAV6ZXsX0R6f/c+pTFta5yVx6z9bS8pS+Ai+A/34xYyNwfLNiaVckv6qUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDN+IsHJsoqfsVQXqBXV3j0MgoQnYL+7tGkCYyGiwt5PbMcxZ9
	zuKACaCBEGNjP+tf07K6GGWK9UqZ9jba86eZ2YPiKpUUxRmwjteUHx1/huVEUmHe7KYGBnYA3jo
	ayelYEA2VMNLiXg==
X-Google-Smtp-Source: AGHT+IF9wJepfLkWp6Og7zLWkPVfPHbPoBbta1qRxO+u28C19vYypQNzFjuUung9UUyEScquLFDzTg6qQ/Fh1w==
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:321:c567:44cf])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e190:b0:327:8c05:f89a with SMTP id 98e67ed59e1d1-3278c06016fmr6502149a91.4.1756391220243;
 Thu, 28 Aug 2025 07:27:00 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:26:56 +0000
In-Reply-To: <8a4dc910-5237-48aa-8abb-a6d5044bc290@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8a4dc910-5237-48aa-8abb-a6d5044bc290@lucifer.local>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828142657.770502-1-cmllamas@google.com>
Subject: [PATCH v2] mm/mremap: fix regression in vrm->new_addr check
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	"open list:MEMORY MAPPING" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
checks") moved the sanity check for vrm->new_addr from mremap_to() to
check_mremap_params().

However, this caused a regression as vrm->new_addr is now checked even
when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
case, vrm->new_addr can be garbage and create unexpected failures.

Fix this by moving the new_addr check after the vrm_implies_new_addr()
guard. This ensures that the new_addr is only checked when the user has
specified one explicitly.

Cc: stable@vger.kernel.org
Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2:
 - split out vrm->new_len into individual checks
 - cc stable, collect tags

v1:
https://lore.kernel.org/all/20250828032653.521314-1-cmllamas@google.com/

 mm/mremap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e618a706aff5..35de0a7b910e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1774,15 +1774,18 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	if (!vrm->new_len)
 		return -EINVAL;
 
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
+	/* Is the new length silly? */
+	if (vrm->new_len > TASK_SIZE)
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
 	if (!vrm_implies_new_addr(vrm))
 		return 0;
 
+	/* Is the new address silly? */
+	if (vrm->new_addr > TASK_SIZE - vrm->new_len)
+		return -EINVAL;
+
 	/* The new address must be page-aligned. */
 	if (offset_in_page(vrm->new_addr))
 		return -EINVAL;
-- 
2.51.0.268.g9569e192d0-goog


