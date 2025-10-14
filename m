Return-Path: <linux-kernel+bounces-852704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8CEBD9A82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C721E355509
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D42E1F03;
	Tue, 14 Oct 2025 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPE4y6Ja"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CC2D8DB5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447732; cv=none; b=QodIvZsYKZc5EVczMgcDaK9QCoBhCpSefOWgH4kiism6hDRV14v3zfpFX7JJGkQnmYFg52l9zHkrA45Kx7HiVQmjnbeMY5mhpt451rl0VAkA5px1hvS7xDIMBJvMMElczAOfWzT9XFpLGirExJcGewa/WGAboZqw6L7twSL4XWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447732; c=relaxed/simple;
	bh=iMlcpqMusfhWhhclO35Xz0jVpejNOc9L4BnLsFBcWlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acqtMkYYH2kUrlFGylX2n3PqhmY2PHTUHZTKXlhtaXvT0xI/GVQNLw3/rgBUMEZRz2vQZyk0vabKDP303U0xY8OREs9L+0sq+UnyGC49CwFhjnhuuX/p13JnlFwOsZJrrTcxoToBJfn87eMjIO7tVNya+61OMYc3APtTPbPfHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPE4y6Ja; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-781421f5be6so18029127b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760447730; x=1761052530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDuVlQoM0GKjXHqLFZaHd1hl5+Amiaz43y1oJczL34k=;
        b=mPE4y6Ja7F9pETjeMy91DqRLyYeX1FSFwOuXKW0O0sVMheqUsfS5bOTJTWoC6wtJLo
         SAqSwVl9Wikgt3CJS8cr5Y5n5F9VCFKIM7RQFQEM+k75njme2GkayxJe7pFFo7e16FOP
         xBLRpdxJZNMtJgO3hK4Qvr7ds4TXo+H0YMcG7CElYXMRlAIJ90P8VtSKO5z3E0X0JLbd
         YYM0t0I5/Yebo6iN9CTqjwxL6UtVz+GSrdq1UnMSHuNTIQArsK329ypQ1cj2TBWwUhvl
         sqSIM9y0Ezl1Qrx07r/ESfXiLj80x2kobyI/AWbMxMAOviUWGpIqXcylvDWM72YMLK/5
         iPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447730; x=1761052530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDuVlQoM0GKjXHqLFZaHd1hl5+Amiaz43y1oJczL34k=;
        b=VrN1VvNZpqNWPznNJCdd8IxxS9NmXeVanPzjTnY5DC/KCvslyKHWGmgqV61x+wVIaz
         DGCPOHnD+sQFB+ebHmrGuVm4l7Alfd7fAMsUbuBmbsAhJI9i4BKHfdgAWWYjt3Gq+gti
         Xr2zwOonmsxiwW0EH+MnLlj7xJ4lokPi2JmS/KMboYdy/Pkfm1jcE77dNTzXKBektTcQ
         FSpo5eSLw/9l0UFd39Ugh25Lpg8jkE5AEmsNDjJHmvNXoyMlLGSqCHE+4toGzM24pMFZ
         t/M1hPAWMzQRHeOysAJlOfq7aO5+pjFsHw9kkI/UEjLsQ7ZhZ2zsYYp7soHtARO9VEK/
         3XvA==
X-Forwarded-Encrypted: i=1; AJvYcCXpJE2mq3zulUB8CJHpr6lpic4vGEHOkCFxKNrpqmVAld2gbiuqEuDJ5LuOx1YIvoqDEzAPdkTL25dt7E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4pEh5xtSbWBQJiB6J7+VrKpFgXqlgAPqnlgVZKtL9N4WjogR
	DlB2qi7+IBG6aaM23D04qbqj0b6M+krXXQRlZqpkwfAjWKlvoBZfE16f/3mRaw==
X-Gm-Gg: ASbGncsc3GTNbATBdbApiH95EgULZdlDgMr9DUjhn6unCVjrInmX+BXjQ6nKy11u26P
	jiighFFSTc7WSCUhDZ86pqnLfWYW3ynYfTZ+ppZ6WDVsma1z8ooev5xFhEAeYZTtQ5o2yO+ZOSX
	227leY7IbVDi2SzvA7h9mN3XMuc9oEhYArHaEfxzH/PZhL6Ma37M5rMSGBv/TXZUEHpzctHv/IV
	TLb+ML5wlxY+bODeSYQlVE30EqbKbJRF3X8/vwJiJyHK0NzPe4pGndGgDOUHorE6MY0OdzvLimd
	ukDFW9MzC7447W9YCIubjznWy2bChIJqhhVUWQYJt6ve3vPkcC/A1uSB9M+Zhm3myA0DU9qc7av
	6XpipdG+shAFDTM5U3QDubUZBZBCQbUWtNrV4UTNR7+FliZclJjo3RP5M4956T2zdkKYNwyBm8f
	/IHrREZf00
X-Google-Smtp-Source: AGHT+IGsvcYYsClEsFTY4tHK/30S2COTBACDT7BSIyOjc1D+rhzPyWmHlUmxYc4FgFdDi9X48dV+ew==
X-Received: by 2002:a05:690e:1599:10b0:63c:dadd:6b8e with SMTP id 956f58d0204a3-63cdadd7d33mr15517240d50.2.1760447729783;
        Tue, 14 Oct 2025 06:15:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cdec375bcsm4392139d50.17.2025.10.14.06.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:15:29 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 3/3] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Tue, 14 Oct 2025 06:15:27 -0700
Message-ID: <20251014131527.2682236-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <428ec528-5471-4152-bcb6-d36dd32c3311@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 11:38:00 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 10/13/25 21:08, Joshua Hahn wrote:
> > Before returning, free_frozen_page_commit calls free_pcppages_bulk using
> > nr_pcp_free to determine how many pages can appropritately be freed,
> > based on the tunable parameters stored in pcp. While this number is an
> > accurate representation of how many pages should be freed in total, it
> > is not an appropriate number of pages to free at once using
> > free_pcppages_bulk, since we have seen the value consistently go above
> > 2000 in the Meta fleet on larger machines.
> > 
> > As such, perform batched page freeing in free_pcppages_bulk by using
> > pcp->batch member. In order to ensure that other processes are not
> > starved of the zone lock, free both the zone lock and pcp lock to yield to
> > other threads.
> > 
> > Note that because free_frozen_page_commit now performs a spinlock inside the
> > function (and can fail), the function may now return with a freed pcp.
> > To handle this, return true if the pcp is locked on exit and false otherwise.
> > 
> > In addition, since free_frozen_page_commit must now be aware of what UP
> > flags were stored at the time of the spin lock, and because we must be
> > able to report new UP flags to the callers, add a new unsigned long*
> > parameter UP_flags to keep track of this.

[...snip...]

> > @@ -2861,15 +2871,47 @@ static void free_frozen_page_commit(struct zone *zone,
> >  		 * Do not attempt to take a zone lock. Let pcp->count get
> >  		 * over high mark temporarily.
> >  		 */
> > -		return;
> > +		return true;
> >  	}
> >  
> >  	high = nr_pcp_high(pcp, zone, batch, free_high);
> >  	if (pcp->count < high)
> > -		return;
> > +		return true;
> > +
> > +	to_free = nr_pcp_free(pcp, batch, high, free_high);
> > +	if (to_free == 0)
> > +		return true;

Hello Vlastimil, thank you for your patience and review on this iteration!

> I think this is an unnecessary shortcut. The while() condition covers this
> and it's likely rare enough that we don't gain anything (if the goal was to
> skip the ZONE_BELOW_HIGH check below).

Agreed.

> > +
> > +	while (to_free > 0 && pcp->count >= high) {
> 
> The "&& pcp->count >= high" is AFAICS still changing how much we free
> compared to before the patch. I.e. we might terminate as soon as freeing
> "to_free_batched" in some iteration gets us below "high", while previously
> we would free the whole "to_free" and get way further below the "high".

This is true, and I also see now what you had meant in your feedback on the
previous iteration. 

> It should be changed to "&& pcp->count > 0" intended only to prevent useless
> iterations that decrement to_free by to_free_batched while
> free_pcppages_bulk() does nothing.

This makes sense. Sorry, I think I missed your point in the previous version,
but I think now I see what you were trying to say about the count. Previously
when we were re-calculating high every iteration, I thought it made some sense
to make the check again, since we might want to terminate early. But I do
agree that it doesn't really make sense to do this; we want to preserve the
behavior of the original code. I do have one comment below as well:

> > +		to_free_batched = min(to_free, batch);
> > +		free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
> > +		to_free -= to_free_batched;
> > +		if (pcp->count >= high) {

Here, I think I should change this in the next version to also just check
for the same condition in the while loop (i.e. to_free > 0 && pcp->count > 0)

The idea is that if we have another iteration, we will re-lock. Otherwise, we
can just ignore the case inside the if statement. I think if it is left as
a check for pcp->count >= high, then there will be a weird case for when
0 < pcp->count <= high, where we continue to call free_pcppages_bulk but
do not re-lock.

So unfortunately, I will have to check for the same condition of the
while loop in the if statement : -( I'll send a new version with the changes;
I don't expect there to be a drastic performance change, since I think the
early termination case would have only applied if there was a race condition
that freed the pcp remotely.

Thank you as always, Vlastimil. I hope you have a great day!
Joshua

