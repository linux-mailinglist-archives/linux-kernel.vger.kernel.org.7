Return-Path: <linux-kernel+bounces-805575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E78DB48A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433FE1B21A23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3F2F90DB;
	Mon,  8 Sep 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLsGgr6d"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FC2E8E12
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328068; cv=none; b=UQwM3pX3HvN077SOSVP5heV4g21E4gj5TM9iKIYzJpz4gwARleOWpC3R7JTTOKeodKnlECYhoOtxLVjW3RwGQhbJKs4Ppqfya3fRE/MIMhyd9yz2c9wuQwej9iOCsWnEQ/znviL0+NNwW6ySp8q5igDx4iLbpMfoAhVGpuM+iwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328068; c=relaxed/simple;
	bh=h6VoDWt8CewmZp8Ky408f1jHLp4inQpLQ1POCxKfthM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a2M7Rk92hgSR6JG2ir5hiVufeH1moOFIApc85VvjaaGFyp9o13kOz1umAinuGBfMbn1VY40e+bI31+mOJR+OigiD5fuV9dElpt/4q7IVBBISa80ig2XFEUtBb/9W3PQekO4EDvbqsstXwGRFubCxxFHFJ5Q3rLeywZQnwHHEbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLsGgr6d; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e970f3c06b5so3703894276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757328066; x=1757932866; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgQX2wVjrXWCDgPEti9JrRCjB/uTC6KZSt3aT19EMWA=;
        b=jLsGgr6dgUbjbvsO5Q9wug+Grl6Qh0TWS+KHI03j2q4dOVbM9oLlPH7AUO6MVqqaOJ
         kpGeRDVtUozMPqMnzFNk6h/hW+++wUQ76zP4xWd0E+pefXyMLDxJiFw+7YN+qGTQi6EX
         +cseNm7SRip0QUEuJpiCJVqHOVRaAmURYc8gosjBc+sIGPbLA46/pQdwXr3AoGFeWe2t
         3dyPWoHiAZ9c6djVjopSA0iwG+6/dpmpD+ANvz5XwlAQAfacDODRfieIMxeI8eEJL8Om
         UrQxJaGGcTu4VvtOCqYxIMOSMezSrDSS7I7nLSaLPnVAfDJO1RkoTgg1zadY5mLVnS5u
         r+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757328066; x=1757932866;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgQX2wVjrXWCDgPEti9JrRCjB/uTC6KZSt3aT19EMWA=;
        b=MGxgfd1kmSNl0+1WnTOnU5vhWW2a9nRFgfhG5mWSRe0l+qMeKnKmiBXD4nYA0Mdfy+
         P08tL44lXyvOU/t9ctqSr9woxFfHp0uyo5VZy0LytuG6RN6T32qtxpBDDKDAtjQl/pfh
         eUkKT6VHabMDU+nmWgyrgYfC8arajmlBRNNISdhl1wuJ4prumgeXOBgQkVqNdxToveCb
         1AW8hcIWVv9BGhd851B+HmjxJQ7Hc2VZxHKpWpqv/5kbn+Z8G8lF/D84kR8mrojJ+IBt
         jVQUIk++xO3EHtq1qykmkU8qrkQP03jk/6TDoHuj2KrDx9BuJFPIUDw9/huPH3OA4FLs
         Yoeg==
X-Forwarded-Encrypted: i=1; AJvYcCXOzs4jQX9/xrNzgDa0hzDXaDCMij8J7wDJx56hO16qiGL6k/DmdIGUwvy2YRbts0vOttIVw3IEyINu6mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7mKIZ6XBkKMSmXSbTi158MpHFRemHHquwBsPMyLrYERsNEKh
	BFVY+J1WERWnbd55O3GAQXD9ubP9u3ohTtGmrKWeaG8NqGz5V32Qby3DuAxme1BrSA==
X-Gm-Gg: ASbGncuieaWtZfSN9/CID/Aws4dK9VJWTtM7PWpovLSv83lVWNaByAI6ivOlzU+hXht
	cN1YD8c/F0xHny9DC2MtTk7UefobnDmRwnDXO44bBOe1Ctis/e4fSrMzu8A0vsmoqSQuzQPqw/j
	FEC0bAmq3XzURQPKMTccKB6/gDGHmKrzstTfM5oaTKpIDJW7Oi0fZtfFgcTFcbVBN/C+3xAOaqW
	Y/Lsr2IFKLWT7PbN643jfUQsdX8t24BICMEZrMINKLq/JqX6AzYUz/Kcw04GbvsNWx4/RXH5Dot
	9e1u/kq4x/zcOwT9TclXUMXJUxna9KLzW1H2qJW9bwjrSRXD8LOWmA1XIC2SBHzUTv9kliFqb1q
	DJMlyBYuzdvUVo7X6XmkuiejhfSeH8LmrEtcEe11Bw9MBwk3EnqJJ5L3AT1augOh73I60gVPnCu
	LgUhqONWhH1eaF8tfk10h9TpAF
X-Google-Smtp-Source: AGHT+IFPUzPrmMuGqYymtA/EsR5L9cPsDdw3hltvchIp0nKAJ6ffXeCZG+zbzSfw+JCOtbL6FoAJJQ==
X-Received: by 2002:a05:6902:6317:b0:e98:8b69:f437 with SMTP id 3f1490d57ef6-e9f67ea5375mr4369860276.43.1757328065893;
        Mon, 08 Sep 2025 03:41:05 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe08a7b4sm5448785276.25.2025.09.08.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:41:04 -0700 (PDT)
Date: Mon, 8 Sep 2025 03:40:47 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, Shivank Garg <shivankg@amd.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH 2/7] mm/gup: check ref_count instead of lru before
 migration
In-Reply-To: <e54b1d8c-ad63-4c7a-8b1b-b7c3d76446f2@redhat.com>
Message-ID: <b008aef2-f69f-e2fb-d4d7-71a42d308529@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com> <47c51c9a-140f-1ea1-b692-c4bae5d1fa58@google.com> <e54b1d8c-ad63-4c7a-8b1b-b7c3d76446f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Sep 2025, David Hildenbrand wrote:
> On 31.08.25 11:05, Hugh Dickins wrote:
> > diff --git a/mm/gup.c b/mm/gup.c
> > index adffe663594d..82aec6443c0a 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2307,7 +2307,8 @@ static unsigned long
> > collect_longterm_unpinnable_folios(
> >     	continue;
> >     }
> >   -		if (!folio_test_lru(folio) && drain_allow) {
> > +		if (drain_allow && folio_ref_count(folio) !=
> > +				   folio_expected_ref_count(folio) + 1) {
> >      lru_add_drain_all();
> >      drain_allow = false;
> >     }
> 
> In general, to the fix idea
> 
> 	Acked-by: David Hildenbrand <david@redhat.com>

Thanks, but I'd better not assume that in v2, even though code the same.
Will depend on how you feel about added paragraph in v2 commit message.

> 
> But as raised in reply to patch #1, we have to be a bit careful about
> including private_2 in folio_expected_ref_count() at this point.
> 
> If we cannot include it in folio_expected_ref_count(), it's all going to be a
> mess until PG_private_2 is removed for good.
> 
> So that part still needs to be figured out.

Here's that added paragraph:

Note on PG_private_2: ceph and nfs are still using the deprecated
PG_private_2 flag, with the aid of netfs and filemap support functions.
Although it is consistently matched by an increment of folio ref_count,
folio_expected_ref_count() intentionally does not recognize it, and ceph
folio migration currently depends on that for PG_private_2 folios to be
rejected.  New references to the deprecated flag are discouraged, so do
not add it into the collect_longterm_unpinnable_folios() calculation:
but longterm pinning of transiently PG_private_2 ceph and nfs folios
(an uncommon case) may invoke a redundant lru_add_drain_all().  And
this makes easy the backport to earlier releases: up to and including
6.12, btrfs also used PG_private_2, but without a ref_count increment.

Hugh

