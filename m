Return-Path: <linux-kernel+bounces-771708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D7B28A8E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64637AC7F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BDF19D081;
	Sat, 16 Aug 2025 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBOOD4S2"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948318B12
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755318794; cv=none; b=gJWkYy/cw4tMkBrLMOt+oiJdFnnY08UJ7P/bEm5CdAKIeHPXpLJzXWfmn7BpMguBejbNDqsUsCSoNkaK0lCbKeP5iWv2OMMn45IRWbu8NBOuM8PNT5zS0luoZjch2iYMSytJxaLhKrJ1uogrBRPoc2W8Kj+r6Nz8oqiE24UUL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755318794; c=relaxed/simple;
	bh=rcJszxXK8P0mEG137zcHYraV1EH2lNkG7npEmwXAKzk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dgwmFK1VE5KrghKbUKbTq0yw6ncVpbIUiGlySwrbqvV7R15L67ndGcIRMRuBjgfRFQdbsW9E8VzFJPggffBE3QMgeLtoivpuj1eiokT2Hdvb633VAZuv5ITyyWHvbenWhYNcMj7I34F+nHxrRG3yPuZlIeIf1MdB8IS4HWWKSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBOOD4S2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso2334778a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755318792; x=1755923592; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsRxtwwK15Bg0qbKyAiNtrwYfp9IiiWX2XFwbSp/aNA=;
        b=oBOOD4S2Vh3cPOhyQK5oPlvksCBWeEqWbWfrbVRWWQiSHhpg6u96+OV5mldm/Dsx4+
         BOMLooovX6qct4S37liSMqsgX9JoPwhVbMcAXjvyq+GGyXG1IUKoPrxrr1hF4vwBPyu1
         WwvZ4tS3QEpCA1kcoERWoxuNe87ogtFZlogU8StPjc59RPIJo/K9zQ0+WVVsynM1Nsao
         Z2p4rT4D7K5OnfsktJPytVn8IYpvJbsgQyts/o8755wk8hzRVAfxx6hgMXfKR27B0agr
         4ac+kJUAZhP1Z6XKDV41HnLUbcAYIChkiFByBeF2orUxvuaXJA6I4g84r55tNuQSFxWk
         kHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755318792; x=1755923592;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsRxtwwK15Bg0qbKyAiNtrwYfp9IiiWX2XFwbSp/aNA=;
        b=FEk6GLAoM423tCRBzR80V22qous0Wcvp/BlCMXfXi0JB8VEMdvIzpQb2gTKBdiSiBI
         Gio/lo2QsT5DPuxiYLR5NFmoWMgbX/x/tuQH9UG1TRUruvVMqLY2DW0gN77z84NY7UCE
         YUX8JiUQvt9/FSfMV5h9sjSmf/QCi8wXLumTwoRiknZWt/Z+dfHET7nSEVFKWAjIPuEo
         Z/3uITM7PDRSrT9buHJGsD2nO/JJ/ABvX2zaWTxR1+a24gA7A/x6jzAB5Q20VnRmAos2
         pekVDTz25KjReVNBLIQZh1jHFtezIqFuVneEgLBg/8+8YJ4uDj9q1GtOMUrI0qjnB8kR
         rYiw==
X-Forwarded-Encrypted: i=1; AJvYcCVsA96Eebfa67TQG+zvNCW9Xg7olwtXLXyXiDCLCCywkrFlFErSXnP1rDik0UsibCHBXvrrUCjTvTNWXX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHr2Lk6+5n70ZcD9x7W5WUSgZtQGIj54pxQlexORCs6d/Sh80
	EzfzO8nKbzTOEsld9aEveipokDGoooIxiuMkeSFv6fr6OypAPUS/ZdaTfKirhLG22g==
X-Gm-Gg: ASbGncsvYqZ5tb4IRl+1dt2gwkNf4jftdcyUnyHgJqwuMhE8NGHOW73lp1S4qmD9mYC
	/DGRivCc+YnJeEyiN3/hA9BnwNBL7acQMJgO5jrmU0M6M+xCBnA98X+1rPx6Xfl0f9X/GaQEEzS
	mJwxR8U2U4ipLXRSjw6RVcNuKk1wNZP4Q6gqsU1rkoHmdLr6DFWZ6WKFnLeKHvz1KGRrsxL+Ekp
	Z1Zzbt9qoI7YMTJVXR2AeFn+mX9Jkkb5M0jwAaduGHjcL8L9XlK+QexV5STTfWarEMQntEkIPlj
	tXNqjE+Rjy2sJ7uWarE8cCNxIuG7FWb3wUU98EQ04F0DthtyuQxBHAlcLntvB6mvjHKVrfp4NGW
	nggmpyqXFujk3Fbr34Qjq+pE2klDNL+UKSGkUqH5Vm+GEflmSistUwph9U+Zp4xs1yhu+mf4DUq
	lJdMjt25XA2k61kQ==
X-Google-Smtp-Source: AGHT+IFRvkHkV/M4v52bM46SWACcSKG/8sC45sXQrlbrPp0hgPn1IBR5PeJOCfpEfjyh07P94QuUHg==
X-Received: by 2002:a17:90b:2d83:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-32341ed8debmr6549218a91.15.1755318792114;
        Fri, 15 Aug 2025 21:33:12 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d794a39sm2619964a12.53.2025.08.15.21.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 21:33:11 -0700 (PDT)
Date: Fri, 15 Aug 2025 21:33:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: John Hubbard <jhubbard@nvidia.com>
cc: Will Deacon <will@kernel.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
    Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    David Hildenbrand <david@redhat.com>, Frederick Mayle <fmayle@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
In-Reply-To: <ef85aa74-180c-4fbc-8af6-e6cca45eed43@nvidia.com>
Message-ID: <9a406ab6-0da8-fb8c-968c-2b403be6781d@google.com>
References: <20250815101858.24352-1-will@kernel.org> <ef85aa74-180c-4fbc-8af6-e6cca45eed43@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Aug 2025, John Hubbard wrote:
> On 8/15/25 3:18 AM, Will Deacon wrote:
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index adffe663594d..656835890f05 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> >  			continue;
> >  		}
> >  
> > -		if (!folio_test_lru(folio) && drain_allow) {
> > +		if (drain_allow &&
> > +		   (!folio_test_lru(folio) || folio_test_mlocked(folio))) {
> 
> That should work, yes.
> 
> Alternatively, after thinking about this a bit today, it seems to me that the
> mlock batching is a little too bold, given the presence of gup/pup. And so I'm
> tempted to fix the problem closer to the root cause, like this (below).
> 
> But maybe this is actually *less* wise than what you have proposed...
> 
> I'd like to hear other mm folks' opinion on this approach:
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index a1d93ad33c6d..edecdd32996e 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -278,7 +278,15 @@ void mlock_new_folio(struct folio *folio)
>  
>  	folio_get(folio);
>  	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
> -	    folio_test_large(folio) || lru_cache_disabled())
> +	    folio_test_large(folio) || lru_cache_disabled() ||
> +	/*
> +	 * If this is being called as part of a gup FOLL_LONGTERM operation in
> +	 * CMA/MOVABLE zones with MLOCK_ONFAULT active, then the newly faulted
> +	 * in folio will need to immediately migrate to a pinnable zone.
> +	 * Allowing the mlock operation to batch would break the ability to
> +	 * migrate the folio. Instead, force immediate processing.
> +	 */
> +	 (current->flags & PF_MEMALLOC_PIN))
>  		mlock_folio_batch(fbatch);
>  	local_unlock(&mlock_fbatch.lock);
>  }

It's certainly worth considering this approach: it is consistent with
the lru_cache_disabled() approach (but I'm not a great fan of the
lru_cache_disabled() approach, often wonder how much damage it does).

But I think you've placed this in the wrong function: mlock_new_folio()
should already be satisfactorily handled, it's mlock_folio() that's
the problematic one.

I didn't know of PF_MEMALLOC_PIN at all: as you say,
let's hear other opinions.

Hugh

