Return-Path: <linux-kernel+bounces-834146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A8BA4039
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0294B1C00231
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B12F5A3E;
	Fri, 26 Sep 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhywByYn"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482C199385
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895307; cv=none; b=XpLfEdZHtKwT3083LG+RC6Tl2VpTB74Vp20tBhszA1UNSmSt8mmkQWgmTXtcQ+Qk1CgqHVeFPdP3TamRresL9WjATaPPGJjmuBnG0U0M1Jae2B6gJQlC+BgK5A+TyrhGua+qvEu50ODCw0dqwp++0s40QGxtBMZ68FeCJktsctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895307; c=relaxed/simple;
	bh=iyS3DGb79OUtJ74cPmnsl+o7/4tKy71u36cyqNcm844=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbrr8dkUHoUGzrlBskJBrBmPL+y8ftX0iIIauQ+9mKE2wfmLZcHUOzqvaMRd4Fp4uyX1UtMkwKJHT5pf3XVvsfdzTgr/siN3RHWvFPoFYicUV2ReWitQcc7WKuRpLNXkRKMNPd2dJLuZaxrUhAOPtBbGAoTgG0/Jo5QF3Aamcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KhywByYn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45de27bf706so12620775e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758895304; x=1759500104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSgSv5ivUBDbWRK+2F3rymI1CRou1bjS7ledl+wX67k=;
        b=KhywByYnxkfcBukwJXB0J9vMpwvGLA2VZnpEE4tVIBgUYMFHM4Nqz4E1PYm89s6jHS
         VMtXdY6CkS52/VWA9N+H8oGdIVQoHDNAE3V+/9z7fNNbomYT/g8k7BxD5t+hp60N00uv
         QE6De3EEs3q6F8KfX7fuNIzHhAO4wer36zbFGqmuTS3Qj4VHvCW6tvX1lQwbzz5aqjjx
         fmXxtH84xHZPnMN3S/wYIhL3z+B2BKxvgtnowzxpsKABqDmbxp9THN9ztoAhhQwsr7+r
         QIGuZj2QC6O0yB5Trx6lchvY8fwUnWzblEOWYjYdVyFVY6MWpq+M33iwb20TOjBOGNjM
         N6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895304; x=1759500104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSgSv5ivUBDbWRK+2F3rymI1CRou1bjS7ledl+wX67k=;
        b=WV7eULAl3GbznaE8aGYv5pO1r9r3pY4ZYg7T85Pg4CApfNoeVqhahlx3+yf0YZgtKk
         V3ICLv9KAHMLpntPEBMDYvy2prQv+XidHtHUZ23DqDalrXldUTFUdvlQAjGqmhqutFGH
         Pem/vJ8jcGkJqwndj8e/wOdFILijOQzwRF+lVzyoeUHDAMIWgKfGLRIXMKd7ZetI6rob
         OWb7Vc83KB3VZnn7babP6QGcJA44TMZCxWDzDwJhhHVh0KDLljvOvx13VtbTRF/HzmAB
         4YHQFzz6iyQZoAk9f6q9YQUkJILUcBs/U56MEs0fvhtgAO6YjQMoAXJipa9Okt27iAbj
         t3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNuiALtrVkPjY9+2Vhn5N4vbGKkSFLJBSop43lckxo6H1Ze5Lr2e7hW7MKoph+oYOmDWfRGV81QZzruqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMh7Q/tNvo2uvtXQjIRbpiehohgM1oEN6dYEaSxFKHW71Bo2es
	C+zP8+LtXuWrMW4gTBtDDf9zdH38Rd+oLw8q0gHXNYonFf4F4ptDe9Z7HDwrCLVBMBs+V9v37VZ
	nPPJqc0GiBNpnaA==
X-Google-Smtp-Source: AGHT+IEvfWDrFOP5KGjT6l+Sxo3xsiKTHK/jbv85LMBQuJJQFm85+HVdoMS8MFmzfToSyWmUwPyLPGVrMe82gA==
X-Received: from wmbdv25.prod.google.com ([2002:a05:600c:6219:b0:45b:7fa6:f2ef])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a08c:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46e37a74bc9mr51778605e9.34.1758895304152;
 Fri, 26 Sep 2025 07:01:44 -0700 (PDT)
Date: Fri, 26 Sep 2025 14:01:43 +0000
In-Reply-To: <20250924204409.1706524-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com> <20250924204409.1706524-3-joshua.hahnjy@gmail.com>
X-Mailer: aerc 0.20.1
Message-ID: <DD2SCJF0CLN5.1824PA58HFFZF@google.com>
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
From: Brendan Jackman <jackmanb@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>, Kiryl Shutsemau <kirill@shutemov.name>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Sep 24, 2025 at 8:44 PM UTC, Joshua Hahn wrote:
> drain_pages_zone completely drains a zone of its pcp free pages by
> repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
> In this loop, it already performs batched calls to ensure that
> free_pcppages_bulk isn't called to free too many pages at once, and
> relinquishes & reacquires the lock between each call to prevent
> lock starvation from other processes.
>
> However, the current batching does not prevent lock starvation. The
> current implementation creates batches of
> pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX, which has been seen in
> Meta workloads to be up to 64 << 5 == 2048 pages.
>
> While it is true that CONFIG_PCP_BATCH_SCALE_MAX is a config and
> indeed can be adjusted by the system admin to be any number from
> 0 to 6, it's default value of 5 is still too high to be reasonable for
> any system.
>
> Instead, let's create batches of pcp->batch pages, which gives a more
> reasonable 64 pages per call to free_pcppages_bulk. This gives other
> processes a chance to grab the lock and prevents starvation. Each
> individual call to drain_pages_zone may take longer, but we avoid the
> worst case scenario of completely starving out other system-critical
> threads from acquiring the pcp lock while 2048 pages are freed
> one-by-one.

Hey Joshua, do you know why pcp->batch is a factor here at all? Until
now I never really noticed it. I thought that this field was a kinda
dynamic auto-tuning where we try to make the pcplists a more aggressive
cache when they're being used a lot and then shrink them down when the
allocator is under less load. But I don't have a good intuition for why
that's relevant to drain_pages_zone(). Something to do with the amount
of lock contention we expect?

Unless I'm just being stupid here, maybe a chance to add commentary.

>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 77e7d9a5f149..b861b647f184 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2623,8 +2623,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  		spin_lock(&pcp->lock);
>  		count = pcp->count;
>  		if (count) {
> -			int to_drain = min(count,
> -				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
> +			int to_drain = min(count, pcp->batch);

We actually don't need the min() here as free_pcppages_bulk() does that
anyway. Not really related to the commit but maybe worth tidying that
up.

Also, it seems if we drop the BATCH_SCALE_MAX logic the inside of the
loop is now very similar to drain_zone_pages(), maybe time to have them
share some code and avoid the confusing name overlap? drain_zone_pages()
reads pcp->count without the lock or READ_ONCE() though, I assume that's
coming from an assumption that pcp is owned by the current CPU and
that's the only one that modifies it? Even if that's accurate it seems
like an unnecessary optimisation to me.

Cheers,
Brendan

