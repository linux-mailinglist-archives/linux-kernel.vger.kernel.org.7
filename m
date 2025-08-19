Return-Path: <linux-kernel+bounces-776089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C7B2C87E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4391A02C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56629285412;
	Tue, 19 Aug 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc+iRFfT"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E81E9B1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617337; cv=none; b=pja8f1G6HBk4+pBJtPvmxZ0at6ndQXpvaKRXYnhrEXQIvWCUiU0RLGb3yTf4MggZWTty9wJMSJhqo0OKDLRqWlWNcsYTfdOlF1l2lR+GJAuNNfJ1MILanaZ0iLRn1tr8qei1R3uIJzeTNu3exkGU9ovBmDrRsVj7e/1pD05fsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617337; c=relaxed/simple;
	bh=rm/Xj1AyNH9px6ebOIWAPX1JrVkAZ5oDS3+XzOARCgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUEFW4BxBNfjitmqDGt1VdH5tlt5oZ6COlfLttWRmvT4A7CBW2hYqqLiyLSFWYd8/XnnKY877kxNzHqVN1qo6+ffQ4TqV/+f++WoePRHoKzWEQtusRLQcHqPl9At59xRBZ2KukNoEkc+QjjmlwGRi3QqJqtwiN+9rynrhsolqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc+iRFfT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60110772so48735997b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755617335; x=1756222135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUjpFijA0j4k1JtqfgmhrWzqVw3LyNcsCEew0K6S8qI=;
        b=Sc+iRFfTZpDjzDRa9nLcKQoeze9mtTtL5H0zw7B2KA724JeZIzwr9N6FMJPwSocXnQ
         mf3QeIwVnOO9kzyrDE/+cH8h5QOPEbTE2T2oQZ/V+qSCEWdDTIWRhdulRmq9rAGKX9b5
         9ZQNH17YAilSJeirgWGuBoXWZHz+49mm3ky0vGhOI7Q9lDuRpHstewI6qgpGZydgAqe3
         FT0R9z16zEcRQyIY6CG0x/ANTa9nBD1g73aRfZ9QsToPlTYCS1DavaMmIvVt4WnvC5Pc
         bAkfrOHgPlpL+2M8OFo6uaA77zkJBcVX0nvLjByuHIihJSJUHmvlNw/3r5W+1aG6aVdG
         E3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755617335; x=1756222135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUjpFijA0j4k1JtqfgmhrWzqVw3LyNcsCEew0K6S8qI=;
        b=YhWgdIb0+1zjjR0VlPblKFnuRQlAabgFMfUwygFK7mT91zsUBH4hr0Sh4IKYXJtx3h
         VqWO3E3oyAV7kEsEzklB/JRixgjX9sOky9goeY2ab0LSA1/uoIDeYg4iYmQCZ3BULs/D
         2tv0iqwLj+ZXo84e/MQI5c3rOvhdZqK40pFlC6p4YLRSylZNuegDtHpwhD1X9uHQ6Zgb
         JWrvLEOLZW6HaIfisVAMzjdVCL8NL+58466GsTcgx1GOOSU8zkNL7635HAse6GOghVTo
         YCvOZK5IGjNXyndLtTvZqw60CSwxAhC84td71a3RUYIgGtKjb+eUPS07tI/iCHLX7OaE
         R21g==
X-Forwarded-Encrypted: i=1; AJvYcCU46RO8BvSk2dar24Qmb4eOwSL4jvnyNhLr15QHhAQEe6w7yS4wkK5hNSYd75gLbbSpoOSB3SUd9Ua72N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzisY/RjddrDm4nxHCYiHFk8cDSGpUiau8HA3dCYYn5M8bbU0y+
	dsf8CthpOIdCKcbXktDkbLeFyxQLbt9/fPU82fuJael94gXdlquYmWLX
X-Gm-Gg: ASbGncvGamo7w3fakHq5k97u83fLlL0VwAaTmrMOnEmET/HDaGlN4XmU7Ec/QVSGHLY
	b3I+VfjOMuPIllOEIB13jNMFHWIPSseyLQlo0TH6Qo3CwCZ6wRA5hNAEqrMU0r1KVkdYrx6QO2z
	WB8zDodnzBH7IydS4hF4hzF57vPU9GIFDkqfhSEKlOrXwrILj3o9tB+/KcXygWqpaAIqODTyhOo
	0zHA79HHeHhLGN6B/MFf2xz+pE/piWdZ1WWie/yAEghyHDqemRsTzbNcA6eg86+8dK+0kIoCLuO
	W1pZyI916yF31EoQRxph9D9hq8w9mv52RtJ49qxsCYxg0vwB27NjWTpYkiABwY2GaHeuCcC/hn9
	a7M+2H8Z1vxmN/7sysDPghg==
X-Google-Smtp-Source: AGHT+IHvvrVwro7ray1QAZTpQIjyhwo8QR0jcpyTSwSpXqLp+chsKKcafMt+YNVzW4XMcgHOHgC8DQ==
X-Received: by 2002:a05:690c:6512:b0:71b:fe47:a1de with SMTP id 00721157ae682-71f9d64d65cmr38206667b3.24.1755617334957;
        Tue, 19 Aug 2025 08:28:54 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fab5bdc20sm2010877b3.8.2025.08.19.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:28:54 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@gogle.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Tue, 19 Aug 2025 08:28:52 -0700
Message-ID: <20250819152853.2055256-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <k6fpx5adh45t4jrxgiccq7acubwcgmi746crggxi6e4oihtvpt@thks5zrn53n3>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 10:15:13 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

Hello Kiryl,

Thank you for your review!

> On Mon, Aug 18, 2025 at 11:58:03AM -0700, Joshua Hahn wrote:
> > While testing workloads with high sustained memory pressure on large machines
> > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > Further investigation showed that the lock in free_pcppages_bulk was being held
> > for a long time, even being held while 2k+ pages were being freed.
> > 
> > Instead of holding the lock for the entirety of the freeing, check to see if
> > the zone lock is contended every pcp->batch pages. If there is contention,
> > relinquish the lock so that other processors have a change to grab the lock
> > and perform critical work.
> 
> Hm. It doesn't necessary to be contention on the lock, but just that you
> holding the lock for too long so the CPU is not available for the scheduler.

I see, I think that also makes sense. So you are suggesting that it is not
lock contention that is the issue, but rather, that the CPU is not being used
to perform more critical work?

I can definitely test this idea, and let you know what I see. With my very
limited understanding, I wonder though if 1 busy CPU will make a big difference
on a machine with 316 CPUs. That is, my instinct tells me that the zone lock is
a more hotly contended resource than the CPU is -- but I will try to run some
tests to figure out which of these is more heavily contended.

[...snip...]

> > ---
> >  mm/page_alloc.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a8a84c3b5fe5..bd7a8da3e159 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1238,6 +1238,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  	 * below while (list_empty(list)) loop.
> >  	 */
> >  	count = min(pcp->count, count);
> > +	if (!count)
> > +		return;
> >  
> >  	/* Ensure requested pindex is drained first. */
> >  	pindex = pindex - 1;
> > @@ -1247,6 +1249,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  	while (count > 0) {
> >  		struct list_head *list;
> >  		int nr_pages;
> > +		int batch = min(count, pcp->batch);
> >  
> >  		/* Remove pages from lists in a round-robin fashion. */
> >  		do {
> > @@ -1267,12 +1270,22 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  
> >  			/* must delete to avoid corrupting pcp list */
> >  			list_del(&page->pcp_list);
> > +			batch -= nr_pages;
> >  			count -= nr_pages;
> >  			pcp->count -= nr_pages;
> >  
> >  			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
> >  			trace_mm_page_pcpu_drain(page, order, mt);
> > -		} while (count > 0 && !list_empty(list));
> > +		} while (batch > 0 && !list_empty(list));
> > +
> > +		/*
> > +		 * Prevent starving the lock for other users; every pcp->batch
> > +		 * pages freed, relinquish the zone lock if it is contended.
> > +		 */
> > +		if (count && spin_is_contended(&zone->lock)) {
> 
> I would rather drop the count thing and do something like this:
> 
> 		if (need_resched() || spin_needbreak(&zone->lock) {
> 			spin_unlock_irqrestore(&zone->lock, flags);
> 			cond_resched();
> 			spin_lock_irqsave(&zone->lock, flags);
> 		}

Thank you for this idea, Kiryl. I think adding the cond_resched() is absolutely
necessary here, as Andrew has also kindly pointed out in his response. I also
like the idea of adding the need_resched() and spin_needbreak() checks here.

I still think having the if (count) check is important here, since I don't
think we want to stall the exit of this function if there are no more pages
remaining to be freed, we can simply spin_unlock_irqrestore() and exit the
function. So maybe something like this?

		if (count && (need_resched() || spin_needbreak(&zone->lock))

Thank you again for your review, Kiryl! I hope you have a great day : -)
Joshua

