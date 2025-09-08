Return-Path: <linux-kernel+bounces-806693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440FAB49AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8204E1A78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA52D7D2A;
	Mon,  8 Sep 2025 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfOoQof+"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CCD2D77EF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361886; cv=none; b=O0Xrcj5RFHC6M/EcF0/lf/zq4qL4dCtKmVcP3H+8TsC0JLjQgEFiQQlbaJUzGMJhbI0OHAGS9ksIr8c9wIdW0ATVhsbjCzIdk0K2QWtI/GIHTVxn3gOKbzPa2zhYQau+CJgsldN38+iDPGwzvEXmxbNu/iCygV+gQgd9zpBL63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361886; c=relaxed/simple;
	bh=GtaoeHK7kbm4c5MDDt238XRyGTy7HWzvV+UMPWK1D/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F3z+ep06k3BQGlSPMnJCDW7/lDBUVAUmtoQnOAqqpV95cUrx5tm26rR3ji7hq3NGbqTP0n0/TbytupHjZY0dsCPoFNkKdBFYpbVYsYUy9M5ZA5IBwpOGabuvU30SQYx9CWRyhP/LknwmIyrNWf4RWRe5n0aTe3K64acMS6vZVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfOoQof+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603acc23so39910777b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757361883; x=1757966683; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S88T8D3xlLZknE8t5igiZlDLZ/Nmh2tAE9nrL4nfIIk=;
        b=sfOoQof+CJaZsSEOZ1hf1DHH4RGT3+SCII2pZ/SO5U4ugjyAaLknDHghPMmNnFrUlE
         63v3hrAwsnRnSAqe5fYsfrWbgICX5oAAuBhL/gGNNPFjLbpMil1l7WyBasz2BttzQRx6
         cIUo6Dhh1n0ghTtht3KGftMaG9tsYfNLizFWJrHjkWX8EVlXGbKgki0LCxeBNV2qf9ht
         XLkbtbZcAuY59K+9wRZZOoi0WcnVmNxX4G9lZaAJGF8RYosU8Y35XQwVQe/AHMBJQA4R
         6rc+VnTkSPnxvXWKPDFWealou6La2rbfYUtQZlpRcQyzgmHaxy4t5G8eQplMGjYqL7NI
         YQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757361883; x=1757966683;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S88T8D3xlLZknE8t5igiZlDLZ/Nmh2tAE9nrL4nfIIk=;
        b=DGOmGbtsElhZKLY33Qvj3zqHo1WCcWyIBCLhkJGzPY16g4STml7Tqrf80Yr0mAUOyk
         2cqJkXAA5mQdzI3DQSnSWf6/a3BjVREa6KgBuZmgWLrBMso4ugXdO1CX7V8sTQXEg6dm
         Ml77F4k5IX3CSqZtf/hL4VZs738pdwHUEE3aHdRSoUMqSGovF8X0O5b2RDIVxEGJIa3s
         7P81jdfQeIwRp4oYGvb8E1SIAjgDxvfSLm342BpJxAZBHlF0WgH9UU/I+4c5DR99Vl6y
         yX+IcVMvR2z+XurApkC8f6h//5A9eWyKe9MYnon6yqzFqOKHxIDRT8KeLKoJ0gNJqOsT
         TfXw==
X-Forwarded-Encrypted: i=1; AJvYcCXW4lGHSdGoy8+369/jKTelt/QdnvnhpLLX9jAX/RumXBBrr9gJJrJN5pT6/4Q6dG2cWhCUPJ7YfZgV5Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyseyTfYosZmePuzn2axnKVVrGALNtI6yNYK7Gr3bBNcKJmLjns
	VT5bQR/Oa51ebTMHMZvxWDDqgclh8s5p7an1unA3hmuux+ZsEmAKSBlpLWGIlBx/dw==
X-Gm-Gg: ASbGncv8nEJKUXgn/JhLX07UcUd4TFMWjdfNgNbBWZLtJ4gSa7qaVS1GbZ5d6zatqYV
	8rCrEp52E1/bXewKJDlGUPp7qJn+t7MO0+ayiT6a2FpFh/2eCg8IutAdj9bF99jJBdAcquTZVgP
	G418RwsRu9l/hCUZ2v3WRtf9qi37EtRWJBBVE9hgzpIfk5r1N0KmddgZP08DTLwUVt+JZdsJyds
	yaVk4zDUHy0qLx1/kIyUU4RXbLRIny0um7Is7Tgl2zvZ3F5zfbpxXNS9KgCU0FDMk0RB/tJvJwc
	rcTojTEqg3UNd9fWN6lV1sFoLPfU/1GYkTgHGlsxszlxtJPQw/IYHWsWo0V4PR+jccdpdvYzteo
	ZmQGK06ikw5lMqdfYRkzgieQa4aIQ5V1dZD5mj6WmEOfdsnUq6/13+e4D2nNq0mFS+90gByQ//A
	bYlUgvcsM=
X-Google-Smtp-Source: AGHT+IG1vHcxWDhaT0QwHTBPTm1Nq4qv5JXkkuFmNGoZQD89ABIsp1+aVObCMHljyu4a3C0wMv4B1Q==
X-Received: by 2002:a05:690c:4b0e:b0:71f:cf50:c69c with SMTP id 00721157ae682-727f5a347c1mr92682287b3.53.1757361883118;
        Mon, 08 Sep 2025 13:04:43 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a83291aasm55200767b3.18.2025.09.08.13.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:04:42 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:04:39 -0700 (PDT)
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
Subject: Re: [PATCH 6/7] mm: folio_may_be_cached() unless
 folio_test_large()
In-Reply-To: <3f76748b-8f99-4e63-ba39-adadc2f58838@redhat.com>
Message-ID: <2ba8984b-8818-2a7f-7544-4c5fce3e0878@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com> <861c061c-51cd-b940-49df-9f55e1fee2c8@google.com> <7fe2380f-a83e-4a9e-8c5e-8459c9af0d5f@redhat.com> <7113d289-fb8e-4589-7eb5-1f7139965ade@google.com>
 <3f76748b-8f99-4e63-ba39-adadc2f58838@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Sep 2025, David Hildenbrand wrote:
> On 08.09.25 13:19, Hugh Dickins wrote:
...
> > 
> > (Settimg aside that I've never perceived those pagevecs/batches as a
> > "cache"; but lru_cache_disable() gave us that terminology, and we've
> > gone with the flow ever since.  lru_add_drain() would be better named
> > lru_cache_drain() now, I've always got hung up on "adding a drain".)
> 
> Yeah, the terminology is not that intuitive :)
> 
> Not sure if using "batched" instead of "cached" might be clearer long-term?
> 
> > 
> > "may be" rather than "maybe" was intentional: perhaps too subtle,
> > but to a native speaker it neatly expresses both the "we can do this"
> > and "might this have been done" cases.
> 
> I would wish we could find something that also non-native speakers can
> immediately understand ;)
> 
> "may_get_lru_cached" / "may_get_lru_batched"?
> 
> /me could not even phrase it in German properly
> 
> > 
> > kernel-doc?  I don't think so, this is very much an mm-internal
> > matter, and I don't care for the way kernel-doc forces us towards
> > boilerplate ("@folio: The folio.") rather than helpful comment.
> 
> So a comment that this is an internal helper might be nice. Or we just move it
> straight to mm/internal.h ?

mm/internal.h, where we hide things (GFP_RECLAIM_MASK etc!) that belong
elsewhere?  No thanks.

David, I think you're over-thinking this: I'm coming to regret not just
going with your excellent folio_test_large() optimization, and let
someone else mess around with the naming.

I'll post later with my current naming, but if it's the
Suggested-by that's making you uncomfortable, we can delete it.

Hugh

