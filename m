Return-Path: <linux-kernel+bounces-871317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21374C0CE80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A916403303
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493172F1FE7;
	Mon, 27 Oct 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ogPnYKH"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01927467E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559835; cv=none; b=kK68zm8RnQqruQWz9TOzs7MDuysNrrSkJgZYW98AITRDGbIPMRjF09iQMmwRGdU6sB9KLNbTYh2zIfiVHptI6sW7KJD24I9FdA1GukU5I/GXlc7jXDQryjNlszwlKQi9PR3kGrCXgnGEEulM2qdTQegn1dWxqXDN7m500LSe9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559835; c=relaxed/simple;
	bh=LlJybQoZRGNZY3cDoRfP4NaAXY415sQlZ8td6FcHW4E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=onY67iRRfMwjEvryzL7HsB6wHRFkY93VqM0j+Iv1lMvC4iyInVHzedhpaQmIqLMwXvauLF3GXSSQ/pFK2NKmj5SnAk9ng+Npm5UHqs/tlMU1cmEVaPnQosigig4/UMf7rVXgmAcEkPZQntL0C3p6cCUfWqoRm27Mcb+14BEaq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ogPnYKH; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63bcfcb800aso4967754d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761559833; x=1762164633; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUhyKQSng3Y0nFruy6J+JGnvlCGsArioA9tG6LAGPJM=;
        b=3ogPnYKHFVXwxTOIoe8IVRD5/siQXjUBF5c7Ex+sDJt51EK/m2JbOwV86YW9eNNfq7
         xUiwmKmXoB8oz86EWVZ1cwhlx8jhxEft/MY/HOMSfuHKXCTgLBvnLbBmDxG9vqyeg2UW
         u+D1EJLzbggG+hjUcXuWUcEW7LAI3gI7BIEFJwKWxLm7ypc2k7NbtNqp+QC5fuPhQ8/y
         eBRVh2JKottHBsa1Kb7sio8pmepkvRxCmQoXJ7e7IXgPA0RX8SnJVhU4d9XHoQhs6Qx4
         T6BtRkkLBg22r8j+cGk9RxncTDAfAKL1ogCFb31BqVIABzISOTw2ptwM4vI9Z4u8YqC6
         65KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761559833; x=1762164633;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUhyKQSng3Y0nFruy6J+JGnvlCGsArioA9tG6LAGPJM=;
        b=PyB6yYtYjA+lLTNfww+GQwXCj6XtZHY/xJxWZDTjjWWan8OsTfb0d0yZNNae1SihZ8
         mRn/NtYe+2DXARO1s5npAAS4SCxUHihaifFdKpzh3TGdg9HS8SMkdlh1mAwaqf51rhon
         OWsoFZfpwKwCUGZT/1yZw1XI0brLUrSwY8KJhEHbPFEP0tTKks3A6IdS+1i8RcECp4gj
         xtkgX4LEsbl2jfxK3VCpzKnemAqSYNT4PNy1/BpPjmV3iku/r+cZE2eRcgXqGDvH+zLc
         mc0buFyAWE+rGJv899WgSpcPlVRjQD7MJxDrics/7oM3y7fOdzJsrbO+BJ/oIg7456BH
         wGJw==
X-Forwarded-Encrypted: i=1; AJvYcCV18nlwj2rqhcjVtoDVOQN3Aw5Q83u5oAdUPJtl3pnkQbWLsZCC5sPg/a7S064TwwCvdhFb9QYUxqppAPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2D4P4ruJf0dUdegFAqmSxzTfbtcOS9OiZgw8qqEuW7dEAzSLk
	7KFn1FlOZqPqewftBFOTzE7BJsKAdc4xZK/Blvg2FsRWm9g+xhKHVTqe92OaR0mMpw==
X-Gm-Gg: ASbGnct7npGrND2Ltkw1oCA/ibWZjH5cAJvhEAboW983OJA+uYHfMrGN7XknIIVsYtf
	eJP3YSVjluy5riLXeUB9pY+IP2vb5jh7dwPwzVP5el6RDssZg1xCULtFR2yT/PG2YPiWKMU9JUO
	b+zTYWULbELfHDDbqCkWyAXuwu1UnUSryVgJIIjNalcmMIMJrCUWKDVze4MaakfsEq9ZzzW532C
	FNAsXDjRrDZxQtPvK0QWXn9nQZWbVWooKparZ7hC+YTmBmtolfyh1vAj+PDYkqcNFRrbqJmXziW
	IdKxYF0LBWWsJxAdyMRtzQ4iqZOSUt3KfyamntYdqbLyCoSW368dvp8Dw7gsuPCaz9xfoGp1jkD
	pFRoJZ142yLMmh+NteDB3hJV+FylNjgrFgzT4MeMW9yKkAQb21RzlAbBZ9ExF3crz63A3a8HXib
	Ki+mcQWkP8mycfN1tZNp7kEU9d2kkvKEz4wFfu6A7aE/n9vMgAyTkQFQJR3hGy
X-Google-Smtp-Source: AGHT+IHAsqrJNcSoY8LjTbIk76DeRsubW3n8U1csW4hXw8uoXLM1KAlPHNJLv1iQQr1PXd5rpnOY7A==
X-Received: by 2002:a05:690e:155b:10b0:63c:ec55:321c with SMTP id 956f58d0204a3-63e1613dc04mr25781815d50.26.1761559832808;
        Mon, 27 Oct 2025 03:10:32 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed14081dsm17731987b3.6.2025.10.27.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:10:31 -0700 (PDT)
Date: Mon, 27 Oct 2025 03:10:29 -0700 (PDT)
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
    linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
In-Reply-To: <20251023093251.54146-3-kirill@shutemov.name>
Message-ID: <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Oct 2025, Kiryl Shutsemau wrote:

> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> This behavior might not be respected on truncation.
> 
> During truncation, the kernel splits a large folio in order to reclaim
> memory. As a side effect, it unmaps the folio and destroys PMD mappings
> of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> are preserved.
> 
> However, if the split fails, PMD mappings are preserved and the user
> will not receive SIGBUS on any accesses within the PMD.
> 
> Unmap the folio on split failure. It will lead to refault as PTEs and
> preserve SIGBUS semantics.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

It's taking me too long to understand what truncate_inode_partial_folio()
had become before your changes, to be very sure of your changes to it.

But if your commit does indeed achieve what's intended, then I have
no objection to it applying to shmem/tmpfs as well as other filesystems:
we always hope that a split will succeed, so I don't mind you tightening
up what is done when it fails.

However, a few points that have occurred to me...

If 1/2's exception for shmem/tmpfs huge=always does the simple thing,
of just judging by whether a huge page is already there in the file
(without reference to mount option), which I think is okay: then
this 2/2 will not be doing anything useful on shmem/tmpfs, because
when the split fails, the huge page will remain, and after 2/2's
unmap it will just get remapped by PMD again afterwards, so why
bother to unmap at all in the shmem/tmpfs case?.

But it's arguable whether it would then be worth making an
exception for shmem/tmpfs here in 2/2 - how much do we care about
optimizing failed splits?  At least a comment I guess, but you
might prefer to do it quite differently.

Aside from shmem/tmpfs, it does seem to me that this patch is
doing more work than it needs to (but how many lines of source
do we want to add to avoid doing work in the failed split case?):

The intent is to enable SIGBUS beyond EOF: but the changes are
being applied unnecessarily to hole-punch in addition to truncation.

Does the folio2 part actually need to unmap again?  And if it does,
then what about when its trylock failed?  But it's hole-punch anyway.

And a final nit: I'd delete that WARN_ON(folio_mapped(folio)) myself,
all it could ever achieve is perhaps a very rare syzbot report which
nobody would want to spend time on.

Hugh

