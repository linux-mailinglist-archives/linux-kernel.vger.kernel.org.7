Return-Path: <linux-kernel+bounces-875635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A2C197E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79A0561CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A93233F5;
	Wed, 29 Oct 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTPyymV1"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5172DE1E0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731159; cv=none; b=qDQnTyfz41bqoJocdKBrFRWqoAHVJQwFSyEpBOvPrlqgS1D4ySVMoDN+rfEHG7zBfMSyeaHDktVHe5WpbJynbPj8+D6Uqsm/z6MmXYQiDhdCSn5wjANe+yidBfSS+fmrY7CeY8Y+IusBBXv1sGzy5n+K0m3LXwWzYvTsVokKyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731159; c=relaxed/simple;
	bh=+eG+DZh4Mcc3z1uy4MNUctOCZyufRjLsNAdxEe98Jz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ow1GK2HvWpFPV1ux9YJi2nar1Tah65L3gmZs7kUmhogYiROAbtW19kWrjmerXhQdkTZzyuKZQgnXMZ5zfIiiqmzAz+1HBKNrzErFLCZhSDOlansXpB0KLpW8POyvTYqBVXKtNUo4K0opSLCpYcs+1bhIbHrkeXVQ6PPghBCoPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTPyymV1; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63e1e1bf882so6584914d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761731157; x=1762335957; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/9ZZO0rhubaMghlPDWYbVAhM+q6Jydtc36d3XX5xX8=;
        b=oTPyymV1cMSv99kCQqg/jKHU2+by0oW/w97dRRMHDohPhEWOZeFfe5d/Wi5lve69XN
         cHV3X9/wNEFGYFg/dsMOUXLgmMk5yEimY0aD6nzV8RXg4uvdnsbEuHMZAeeo8dUutw+5
         upTGuE/qPGQV2fgKmIdrM5SI+hD2TwMVTtrT24NlVlcYwktUrb0r1lwnU0nrfvIFHikX
         Sg5s4KlEcO/GGUIHYvMvyw9Q0+af1lLobxIuNmS1aE48SDXVE9VNae7GmKg9TNpFGi+W
         Zfzh8qDXE/AW9BJoQc/eAxbeW9V7/K/SQwGnGUEjLLFm5nRM3BhyqqAiZTaFk8NmrFrF
         PTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731157; x=1762335957;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/9ZZO0rhubaMghlPDWYbVAhM+q6Jydtc36d3XX5xX8=;
        b=sHPBo/XCywJgBM12hvQw4ZmQCPDn/Ew6ICZI/s5yefWWs/+H8FYLeh6swkqquYw2m1
         omot9v+uYKEdxxRZViB+Ptld6dLbnKxn7U73Ep1z7Dyb/bakhk24VbPZp1Ov9dGZ5H81
         OFLx+nGVxUlo2+ZG+DUnTIu7eWGkQn5YgswhA4RR4krFU+WJSQhAtkntIlYOkNQV2v1f
         OYs7oS3mBMOOFonOUfIga0vysHkAjEvkc4BPoqThAJQGoBxB0dqrv2fWiLu0hU+6oZui
         YoJooVk9e/hdOz5+VU8IvQPh7eYFxXv+kctLzDgkG6+quEEw1499nVAbXB9LEiX2VoUW
         B9yg==
X-Forwarded-Encrypted: i=1; AJvYcCWlVsRWv3hjq/2TWxAT43sHBRxkrw1A73+3O1sXDr1g949UmBVlqvNFFDeV4x4tk9iJgWgs8hDxA6uOMkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CtalHndopIzim7sBvU7jb9kbX4CBqIbSTeprCWh+xk1WT+dd
	vRpjIFy8Vl6fdx63nhs80vYyo7Cb295A12t+F4hisjuQXzPPV6HOnMMgGry8B4CDLA==
X-Gm-Gg: ASbGnctqGBGcogvc3fRPiEQFiONHAJEVXjuSIqi7Sf7d0fBZ3sjqaxjaP5dsEIr+rfw
	LMRLCqs9KqqM6pVNBXCWcy7VilEyPV1tJHVcJHmmKOiK1sccovl6ilcmgLD727wOlnc/mTy6si8
	oAgQX8PYwSF4E5SI2lOwTE9IFg9xT6ycf6MwHlwvBYutlYHWx0E52d/OINGfpCwbVMucWUWfb9n
	xNRZwDJz8R6EFAlAQgb6cioZ1OMwBTD5xu9xHzmsdDmOt3uDtrz7UdaZqovW7hUsEjmLOeNp9k9
	wXH0BabfEmVap/MVH09QMlr13AZn081Ku6TBdZUtl289u5apWthCudjwGfe7xlZyR/ehURqyuDv
	zlhZym9I554cI/KAEgn4Q54MEEyyNDfOQ9+DLz5UZxst+gUzZ2+dOzzFRAkRTf4UFIYLhsQWS6p
	Z/VxztZHxoGdiMIf6mviSLofKl1GEoOEWgdizBbiF2ldVrF5d/5J6FiCFIwR43
X-Google-Smtp-Source: AGHT+IEeP09fuX5a6/tVT4haAmvdF3K7vyTy354JjeQP1tfCemInfRx1yyo5g0HaztI92HwXX6vV3g==
X-Received: by 2002:a05:690c:4a05:b0:783:7081:c479 with SMTP id 00721157ae682-786293b13admr37307107b3.65.1761731156381;
        Wed, 29 Oct 2025 02:45:56 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed199f95sm34481207b3.28.2025.10.29.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:45:55 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:45:52 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
In-Reply-To: <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
Message-ID: <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
References: <20251027115636.82382-1-kirill@shutemov.name> <20251027115636.82382-2-kirill@shutemov.name> <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org> <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Oct 2025, Kiryl Shutsemau wrote:
> On Mon, Oct 27, 2025 at 03:33:23PM -0700, Andrew Morton wrote:
> > On Mon, 27 Oct 2025 11:56:35 +0000 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > 
> > > From: Kiryl Shutsemau <kas@kernel.org>
> > > 
> > > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > > supposed to generate SIGBUS.
> > > 
> > > Recent changes attempted to fault in full folio where possible. They did
> > > not respect i_size, which led to populating PTEs beyond i_size and
> > > breaking SIGBUS semantics.
> > > 
> > > Darrick reported generic/749 breakage because of this.
> > > 
> > > However, the problem existed before the recent changes. With huge=always
> > > tmpfs, any write to a file leads to PMD-size allocation. Following the
> > > fault-in of the folio will install PMD mapping regardless of i_size.
> > > 
> > > Fix filemap_map_pages() and finish_fault() to not install:
> > >   - PTEs beyond i_size;
> > >   - PMD mappings across i_size;
> > > 
> > > Make an exception for shmem/tmpfs that for long time intentionally
> > > mapped with PMDs across i_size.

Thanks for the v3 patches, which do now suit huge tmpfs.
Not beautiful, but no longer regressing.

> > > 
> > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> > > Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> > > Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")
> > 
> > Multiple Fixes: are confusing.
> > 
> > We have two 6.18-rcX targets and one from 2020.  Are we asking people
> > to backport this all the way back to 2020?  If so I'd suggest the
> > removal of the more recent Fixes: targets.
> 
> Okay, fair enough.
> 
> > Also, is [2/2] to be backported?  The changelog makes it sound that way,
> > but no Fixes: was identified?
> 
> Looking at split-on-truncate history, looks like this is the right
> commit to point to:
> 
> Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")

I agree that's the right Fixee for 2/2: the one which introduced
splitting a large folio to non-shmem filesystems in 5.17.

But you're giving yourself too hard a time of backporting with your
5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
flag then was tmpfs, which you're now excepting.  The flag got
renamed later (in 5.16) and then in 5.17 at last there was another
filesystem to set it.  So, this 1/2 would be

Fixes: 6795801366da ("xfs: Support large folios")

> 
> It moves split logic from shmem-specific to generic truncate.
> 
> As with the first patch, it will not be a trivial backport, but I am
> around to help with this.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

