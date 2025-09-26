Return-Path: <linux-kernel+bounces-834346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C558BBA4804
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170A21899566
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720AF235358;
	Fri, 26 Sep 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTp4w8qd"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97BE2580F2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901719; cv=none; b=mwmkZQxmdUk9J2YM5ULRWwNcyfTNIiPw1U1t6Vw4GRp/0+BHVqSW/4T+0vYkHdE8CHjMR+LXdW4M7oAn9UZTyf5ZCblZ7YTZ0HF/92U/G08Y6fuxrtEBWvv2WEPaKtYAHfe/7+rHVkVwrF67D5R/DKUvKQVrSJg3pZmgfEfFwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901719; c=relaxed/simple;
	bh=zljWxy5CwvIsp4HQ/vcIgKs94qa7Cp48lrj6Etcpz5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQkl5U0PKlmh0wBT7jzQJKIV3rQ/9zDeIQd3wIxWRN6yuxy/T2DN9QoKfPj2v5ElB9eyTKLHzxMoT858hdNwB+J7YseyRyOdt5wEZJgKW3Oztlh8JrtNRduzmw1uxeeJcw8jEqYJEWJtEO6j9/h2/Dv9obStcZzPhk9Q48wwyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTp4w8qd; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6352a77add0so1335808d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758901716; x=1759506516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESIjBxRBQaFXab+YuRgwHn4pBu5p/ZSufLb4LCbBcAs=;
        b=WTp4w8qdckyEEI9n4mtGLSW/3/kp4QVBonCn79I69SuzDMCInL0zrJqICe1kcJ6r4W
         c3nu0HhevJb957+wCvjk3xTph3wE4FUXwgm5GVtSA6ZNl8rOE0/R+Xj3UeDyJXn+8/9k
         MXAbMI+rXckNEviIQ7JDCq+7lCKHSb+xljwsWXWgCDuIyN6GRY+Z6h2ET1CvBBF7xVgs
         6FHZfnwIIygdxldQSDFvl6A5OWL2l6TN9Y+wCa/o+uqJ1Z6Go7yBC2ai9oBtJVFc4Y+q
         +T5aZn9Q33xKX5jb1iXzwFCDloQJHjN0Jfb3DLLe+KBIQf9rJ0Pum/50EOVi/909yoLZ
         a0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901716; x=1759506516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESIjBxRBQaFXab+YuRgwHn4pBu5p/ZSufLb4LCbBcAs=;
        b=l7l1U/IhadTiMzbTl/bjuRUL4N44CkffnqLiwGk1vqOT5ZBz8TfEzbXBPpNBWxfJAu
         W1Sr5ghhEdv5VHF+ni4RE4qH5HzgSqsbznj6ZqbH0T7FG7/kmlCNcLTMsZseY+c7A1+H
         ODF/yDik8BdQAlw45cNDCiwXsAp3dl3I47PgTNF+JxIOtuIR2AW7bGJw8cGjidMDb5In
         5HvQY9AkVelKxA75mJvU+/3WE0nH8FlLp+b1wnLH+++zNyt/3l/V+78X/ymbgNgyWaZy
         6i7B0ZAKykBj7PNCr91SuchXpsH7Pdbr1SrePyrWuxppp+hYa5V723ZMWMJy5B0Ta7Fc
         Z4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZt+kzHK7dcmc7tiUJa6XEczwYZi4Ym6nIS6HKT6rE67ivKdN/bnEMifsQko86DapPbEC2QG380IcdNI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD81n+T3lqc3cq09A1lE9aqoWNfzS5UNfB1GG42HVQmm5GkbZ5
	kXvJyOVb2vF6DzgQRYBPJ3HbU1UtzqKPOH+2ICsc5zzhjyorwy6Z/Bae
X-Gm-Gg: ASbGnct1eVjWyGl/6LB/7UegyGSVIlhE538UtRtTcwVt/YeI1PjUIKs0LhjXfbCAiIF
	uMva1Vkpaj1LZd9MG5AjrOPmDd6RBsAGQqNNVyxmS8xf4OqB4s/T3EPmjm+mbsfopCJrDcgWzLe
	7Y5wFWNpxti9F2NSdGJ6eAJLVVV6cwr8kVd9ySiYXlInAgpjoFj1PzUf/kQMg8BVHwm0+0tjvO+
	9mqlJMBgrkMWuhnZrBlgs/D07LJHvWxcMT8s64B3TJ8di9pOcHGpy+OD07tFjxOqul4Ujx2OFmX
	cJP4Q4geRA03LLa74CMU9DnXnxd9NgdEezwUDkVfCbXlw1VqjMerFysHsqyYyvF/SYAiAMkzTNd
	0YsCPF6USFMbTJB5m5UkFDDCfQC3upgJ7jcxc6AUPNOkM07ErBBZEDX1YpZlOC6eL
X-Google-Smtp-Source: AGHT+IH5v5oEleHS+hhobpT1fPu/dGJzQLGt0YwAygbvnJZKb6RzhqZPSdR0+T1YCZa1xLc53b6QBw==
X-Received: by 2002:a05:690e:1590:10b0:636:1fef:e725 with SMTP id 956f58d0204a3-6361fefea7cmr5781546d50.2.1758901716427;
        Fri, 26 Sep 2025 08:48:36 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb383929a6asm1447970276.16.2025.09.26.08.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:48:35 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Fri, 26 Sep 2025 08:48:33 -0700
Message-ID: <20250926154834.2327823-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DD2SCJF0CLN5.1824PA58HFFZF@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Sep 2025 14:01:43 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> On Wed Sep 24, 2025 at 8:44 PM UTC, Joshua Hahn wrote:
> > drain_pages_zone completely drains a zone of its pcp free pages by
> > repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
> > In this loop, it already performs batched calls to ensure that
> > free_pcppages_bulk isn't called to free too many pages at once, and
> > relinquishes & reacquires the lock between each call to prevent
> > lock starvation from other processes.
> >
> > However, the current batching does not prevent lock starvation. The
> > current implementation creates batches of
> > pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX, which has been seen in
> > Meta workloads to be up to 64 << 5 == 2048 pages.
> >
> > While it is true that CONFIG_PCP_BATCH_SCALE_MAX is a config and
> > indeed can be adjusted by the system admin to be any number from
> > 0 to 6, it's default value of 5 is still too high to be reasonable for
> > any system.
> >
> > Instead, let's create batches of pcp->batch pages, which gives a more
> > reasonable 64 pages per call to free_pcppages_bulk. This gives other
> > processes a chance to grab the lock and prevents starvation. Each
> > individual call to drain_pages_zone may take longer, but we avoid the
> > worst case scenario of completely starving out other system-critical
> > threads from acquiring the pcp lock while 2048 pages are freed
> > one-by-one.

Hello Brendan, thank you for your review!

> Hey Joshua, do you know why pcp->batch is a factor here at all? Until
> now I never really noticed it. I thought that this field was a kinda
> dynamic auto-tuning where we try to make the pcplists a more aggressive
> cache when they're being used a lot and then shrink them down when the
> allocator is under less load. But I don't have a good intuition for why
> that's relevant to drain_pages_zone(). Something to do with the amount
> of lock contention we expect?

From my understanding, pcp->batch is a value that can be used to batch
both allocation and freeing operations. For instance, drain_zone_pages
uses pcp->batch to ensure that we don't free too many pages at once,
which would lead to things like lock contention (I will address the
similarity between drain_zone_pages and drain_pages_zone at the end).

As for the purpose of batch and how its value is determined, I got my
understanding from this comment in zone_batchsize:

	 * ... The batch
	 * size is striking a balance between allocation latency
	 * and zone lock contention.

And based on this comment, I think a symmetric argument can be made for
freeing by just s/allocation latency/freeing latency above. My understanding
was that if we are allocating at a higher factor, we should also be freeing
at a higher factor to clean up those allocations faster as well, and it seems
like this is reflected in decay_pcp_high, where a higher batch means we
lower pcp->high to try and free up more pages.

Please let me know if my understanding of this area is incorrect here!
 
> Unless I'm just being stupid here, maybe a chance to add commentary.

I can definitely add some more context in the next version for this patch.
Actually, you are right -- reading back in my patch description, I've
motivated why we want batching, but not why pcp->batch is a good candidate
for this value. I'll definitely go back and clean it up!

> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  mm/page_alloc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 77e7d9a5f149..b861b647f184 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2623,8 +2623,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
> >  		spin_lock(&pcp->lock);
> >  		count = pcp->count;
> >  		if (count) {
> > -			int to_drain = min(count,
> > -				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
> > +			int to_drain = min(count, pcp->batch);
> 
> We actually don't need the min() here as free_pcppages_bulk() does that
> anyway. Not really related to the commit but maybe worth tidying that
> up.

Please correct me if I am missing something, but I think we still need the
min() here, since it takes the min of count and pcp->batch, while the
min in free_pcppages_bulk takes the min of the above result and pcp->count.
From what I can understand, the goal of the min() in free_pcppages_bulk
is to ensure that we don't try to free more pages than exist in the pcp
(hence the min with count), while the goal of my min() is to not free
too many pages at once.

> Also, it seems if we drop the BATCH_SCALE_MAX logic the inside of the
> loop is now very similar to drain_zone_pages(), maybe time to have them
> share some code and avoid the confusing name overlap? drain_zone_pages()
> reads pcp->count without the lock or READ_ONCE() though, I assume that's
> coming from an assumption that pcp is owned by the current CPU and
> that's the only one that modifies it? Even if that's accurate it seems
> like an unnecessary optimisation to me.

This makes a lot of sense to me. To be honest, I had a lot of confusion
as to why these functions were different as well, so combining these
two functions into one definitely sonds like a great change.

I'll make these revisions in the next version. Thank you for your valuable
feedback, this was very helpful! I hope you have a great day : -)
Joshua

