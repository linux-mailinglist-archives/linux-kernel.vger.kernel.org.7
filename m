Return-Path: <linux-kernel+bounces-790350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F27FB3A5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC33686C54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF90E2D24B5;
	Thu, 28 Aug 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4jH8f0L"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959472C236C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397567; cv=none; b=SEyciXgg6unn8lf1wg1MUIYTaMcDfiNtcNjgnyb2lpXJj5/8uOUSAOqqXuSofcdAjAkxrHJ7i1n74csmuMQAe200sDzf4xSbRz/ILZdQTtG1r+fm2b2NksS1DvSi5wZRc+bamD8ttZyXiP7s9E4vbk7EGBJLFXvtfdtev2fPA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397567; c=relaxed/simple;
	bh=/uzPQn8RLNZhltur5dOmD2vxBoNNfcNWviFh+3iH7IA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F1P9YEklfsVzQB35MekU9xblJmSNvlgPO3DO5zLpFBii9rmBZS6tKO+CMHT0Bor9wtrpuJsICnIL7tCBIHAHbuDlKZh71cCggZ/nWvziLwESOOsJDLHAr64QqmmrtdaDUzQIWpqJcZXcK920tC0z4aeZLdwR6TU8+1ciUDARieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4jH8f0L; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e931c71a1baso1619278276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756397564; x=1757002364; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKrdECwCL/S2DsNGSmoGvfvwMbZyFm9pz9Oh0/KdiMo=;
        b=U4jH8f0LywYC6OUbtsi31uq6nH2YvEvt7c8FPnqU1dEqhEpN+P0kbzdYdUZZhguMys
         iiv4PKeV/rUs04MJDMEL+g+hDhOlAcg4V64UFlAOmi0ikPHHwh/J4QE9GTQWheDCOCPC
         A8Wv8wDjKszs7GulLQQoYbhvSs6MUOT+Q9OIzzwwccoE7hzD8VSNqwJMBiUKAO/ahGLj
         tCHhAO7WcviejZ8h0EtyDL1en7Ax89w2XFQIUigzGuT7ORdFHroUDVgx1Zbj+Yv9p4fU
         60qUbX4y45cEwtzT5aQDISIBbNfkHzJBhnQzwqEFjLuvLZLKFi1LjC18p0WEjdbwA9Bc
         U7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397564; x=1757002364;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKrdECwCL/S2DsNGSmoGvfvwMbZyFm9pz9Oh0/KdiMo=;
        b=wJaTrFY8JzxoUIODPbf6iZvs0G8/CqmaxsWaQJduBrZQxSbFkx045N02OB69a4f/5Z
         9mS2ZfMbmtM4oQ4OWwdDw1p4kG6Yy6VQ6u0XeL28p6Zf4pD/jraRnVAWlXgpPi2knYkF
         0h1+unxBnsHoLodTq8Cga6bva8fjnSjgvrfUxhxiS3K9p1r+sBLYd8kV1prQYtv/arlK
         SrowY5XXh/sjk5KLJ1mleDB/OG9F3TXFlLWSdlZzHCWOjjkodQ5mwXmyNeoWWPFkqC94
         NHhlYdU/TDuRpv0xce/hUBqc+hUXhW7HRXtIKsuGt5pU89qU4KQBJlX9T4wHaDiRvoqW
         AL4g==
X-Forwarded-Encrypted: i=1; AJvYcCWb8dIR7UvgQmNdBiO1VP26tx1wBL+aa7GgMVnxm0/8kspdLuVQ7+Jm1PyukM/GJg9J59t706NmcVWrdtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEanqrCQaMTNxVCWU9cso2fDNjtu2egKz2JH26xjOupHDaiJVu
	Z/OoGEIzVVlFNycAHLJW54353hhxCIb6NeGADfNjmb0gmvgipOChM9HDKzMMTw3a8g==
X-Gm-Gg: ASbGncs79U2AhQNTO+QUspdu5gtwu59xSrPe3MYXLwshXSacUw61XZxMQSejtVOutFj
	PBBGbmsNltPA+mBbwKqyJFJZGPnoN1/LmxNeSAEKouLHdoTsFb6kc42zQPq6DLHC4osbEAZELLb
	BbtvGLqS9PLDvWjdeOfwtawhVJjBKuoj8JdhgfhBiSrrV+/c+Cm+dLH1R8gQWnMJZiUyyHrV71A
	Zfg4MDAA56S50oPSCVWeUg/rqnnM+ImtSAy4gagP9/FVl9qCUPimsxZ6AVTGBZNpAZb/LEg3/yk
	oBELEdSn5r9l/lX6/4iOvq9CMEIQejEFHMvUh6pY4+571tXRDSDSaAT3/huhIiiTsaJrIlaWzSi
	/xGrlYKhn5dSoJBk6Wv0D7hMj1jzTUZ8OEJO2ZeQzu4EHv4g6gE/Yvm6xg4NVRHI57Rj/6mo5S5
	Tf3IKLk4vR60Sq6Q==
X-Google-Smtp-Source: AGHT+IEs3OYNfV4fyshSQdcWOMf+X4BHAcpfnqkUSzdEGPE+H8y4jjrbJGNSYkDTCZ5Vd59EXR/FKQ==
X-Received: by 2002:a05:690c:9b0a:b0:71b:f712:2a2b with SMTP id 00721157ae682-71fdc40b326mr301211777b3.36.1756397564135;
        Thu, 28 Aug 2025 09:12:44 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721ce5cd204sm295187b3.59.2025.08.28.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:12:43 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:12:30 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
In-Reply-To: <a0d1d889-c711-494b-a85a-33cbde4688ba@redhat.com>
Message-ID: <3194a67b-194c-151d-a961-08c0d0f24d9b@google.com>
References: <20250815101858.24352-1-will@kernel.org> <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com> <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck> <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com> <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <a0d1d889-c711-494b-a85a-33cbde4688ba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 28 Aug 2025, David Hildenbrand wrote:
> On 28.08.25 10:47, Hugh Dickins wrote:
...
> > It took several days in search of the least bad compromise, but
> > in the end I concluded the opposite of what we'd intended above.
> > 
> > There is a fundamental incompatibility between my 5.18 2fbb0c10d1e8
> > ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> > and Ge Yang's 6.11 33dfe9204f29
> > ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> > 
> > It turns out that the mm/swap.c folio batches (apart from lru_add)
> > are all for best-effort, doesn't matter if it's missed, operations;
> > whereas mlock and munlock are more serious.  Probably mlock could
> > be (not very satisfactorily) converted, but then munlock?  Because
> > of failed folio_test_clear_lru()s, it would be far too likely to
> > err on either side, munlocking too soon or too late.
> > 
> > I've concluded that one or the other has to go.  If we're having
> > a beauty contest, there's no doubt that 33dfe9204f29 is much nicer
> > than 2fbb0c10d1e8 (which is itself far from perfect).  But functionally,
> > I'm afraid that removing the mlock/munlock batching will show up as a
> > perceptible regression in realistic workloadsg; and on consideration,
> > I've found no real justification for the LRU flag clearing change.
> 
> Just to understand what you are saying: are you saying that we will go back to
> having a folio being part of multiple LRU caches?

Yes.  Well, if you count the mlock/munlock batches in as "LRU caches",
then that has been so all along.

> :/ If so, I really rally
> hope that we can find another way and not go back to that old handling.

For what reason?  It sounded like a nice "invariant" to keep in mind,
but it's a limitation, and  what purpose was it actually serving?

If it's the "spare room in struct page to keep the address of that one
batch entry ... efficiently extract ..." that I was dreaming of: that
has to be a future thing, when perhaps memdescs will allow an extensible
structure to be attached, and extending it for an mlocked folio (to hold
the mlock_count instead of squeezing it into lru.prev) would not need
mlock/munlock batching at all (I guess: far from uppermost in my mind!),
and including a field for "efficiently extract" from LRU batch would be
nice.

But, memdescs or not, there will always be pressure to keep the common
struct as small as possible, so I don't know if we would actually go
that way.

But I suspect that was not your reason at all: please illuminate.

Hugh

