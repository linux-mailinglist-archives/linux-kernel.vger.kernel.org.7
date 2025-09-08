Return-Path: <linux-kernel+bounces-806680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900CFB49A50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7A57B392D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB12D3EC1;
	Mon,  8 Sep 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P75I/mNA"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C82D3743
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360894; cv=none; b=efCFyTMq61ZDaBkpVfPN86KOGbrEy7mSgixDmTXfAcXlYIOgzv/YROctZR49CMThQkNo7Lohq+K0H1dbGrEQ3VGINWZ+T54cEa8PAkIWj3W/UkpI44NHXAQfA9nmkhfScUWScuIY8jznxLg/iNJQsmLEUVdrKtRW8dSoITe1zXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360894; c=relaxed/simple;
	bh=3omYiVett5KT69OkLw6cgQRfDeNeE/hk5f2AnLMqdpY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eSXSP10+KrxT/dyUmbUm28FY8YlBacGWQCLs0ksZwiW8WwHEVwm1MsKC0Aqx/YK2BAATAo53HvkZhFGJ0uic0ObeQ3Os42qqhU6/7TnscPTylRYK6LVaKpftHxxWDrYWO90rDtB5qM5z/Vtho/mPn5+4DX/jnmDjcD3XJczSwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P75I/mNA; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-5fe42994547so887891d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757360892; x=1757965692; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkWutJuoMHFChanlNo58aMCO1DUKKA6gzqFMsdXKD24=;
        b=P75I/mNA5tBUoM9rBXhoelsHenVVgG9C/CsXqhHBEAuOCWy9BYVXFvCX+KZ3SQ2ODY
         dCt/r2XjVW/DNc7ro30rTyR61gYIzWj4p8cTm6sheu2KWmEftfYeRSTbPhoSx3DpHF9c
         X0Zuq7E7lxyX9mWY1mzgRIx6TTTI83LYy+7xDNCQx038b3tV7/i/Nu3Criu4CgDVLuzo
         y6ZBkIleLeu5Knil0hUqUE6JCepgcH5pl/3kEQ/7vRCsiH5FQcsy1LC/nD8Y7i+C90Nc
         l0Lpnpafvwd4E8XHW4n5bDs1GD38kFpkEZDoFnHcJvszUrDTunxjZiieE9Y9TwMbjiqZ
         Pung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360892; x=1757965692;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkWutJuoMHFChanlNo58aMCO1DUKKA6gzqFMsdXKD24=;
        b=Ob2kF1BAgM/M6/4vTfcwROqP+s/76iIvyTCyrUBnWsVoklj84dfQC7VQuA9NP2CoDP
         HIbLhzd0K/YmojxvE/hTPNxDpP2rrW+Ll1+X5UObMXpSPmm3rUuCvkMnq3henbE4eeAO
         b6auAHPxLtZi6ocS6KU7sF6p3Of5Ks0wtNY/j1JjR5pyoH1AWLQ0jNNuxKh4kF01thLb
         L+AwBOIGR9RYMsQ0OLqp+sKmWYVd/HJjbEpjtpfgGDVfQPxOyADgP4TiF8e27ODvQnmc
         Oz9HUTQ5RI5rfi7MFyGXqIJysUA8dvvwM0mSTMUY324QLYpMjFax2TBC8vGI6RnzXCDq
         xVgA==
X-Forwarded-Encrypted: i=1; AJvYcCXmo6fd/wOKp+U7/casGT9Khn9qMfNB/vk1pnSgxLuEntwe25VqsSpMs4xv8UlwCtUTRR4n87D3rUP2NI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIyv+ahLmBmQxmt7euXYAAn3KMeDdbIa2kjuos4EZqzIN3tGlz
	hYZMmXKi1iRvHtgtpxTcjrGxT89uVfOV/m6lxQU+uRF9OfaM+zsoazDXc2D7bBan0Q==
X-Gm-Gg: ASbGnctc1lVsK9mZT0jiFKjlndOopkgJJu4eym/i9X8zcJYsY1SC9xulYZvLyBfFX51
	U4mgvxN/a1vkMMW+8SEuh9kejLlOoQzx8uYDbEnbmF5M07SHpQfm+FjhyCkKRlpETkGVxc6gF4Z
	d2LDIHwv65SX2FlQJ9N8UFG+Yu/6D+8qQbN7LBlrYQ90MZi4ZIrluVsHMk/VBwlAF4mgMVCy1Su
	uBKVB8eW7f54jzOcmtGHRddNuoZTRDWBRWPWXpG1j6U+rBLHbZBAJHYyUxqvIcZlsx4/DDHg5I8
	lc8NbisMqt8G/vLoVyvGdLrWPHYuBm7hHDGbD7a0F4rjQMUoVf0XvmPzYPbsBkPeoGv9YBbKmpc
	DIuEOMbhwWZRmlxuOnPb04ouRL2blEyWMNn3qAPKhpsVu8CYUiRU6rs/WFLyHIYkrThhxNJDTzk
	O23WUPbEk=
X-Google-Smtp-Source: AGHT+IG4PW91kFyjbmPgXJLgM5A2EFr+Ploj908V1ZohpTeRJB9+gDbvi/48Raxp7i+jqIStykUZkQ==
X-Received: by 2002:a05:690c:3681:b0:721:29fe:1d49 with SMTP id 00721157ae682-727f5a347b5mr89278617b3.52.1757360892016;
        Mon, 08 Sep 2025 12:48:12 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a82d58b8sm55941157b3.9.2025.09.08.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:48:11 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:47:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
    Shivank Garg <shivankg@amd.com>, Christoph Hellwig <hch@infradead.org>, 
    Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>, 
    Peter Xu <peterx@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, 
    David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/7] mm: fix folio_expected_ref_count() when
 PG_private_2
In-Reply-To: <aL7w4qrJtvKE1cu5@casper.infradead.org>
Message-ID: <685fa6c1-e343-ae92-b673-48524918548d@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com> <f91ee36e-a8cb-e3a4-c23b-524ff3848da7@google.com> <aLTcsPd4SUAAy5Xb@casper.infradead.org> <52da6c6a-e568-38bd-775b-eff74f87215b@google.com> <92def216-ca9c-402d-8643-226592ca1a85@redhat.com>
 <2e069441-0bc6-4799-9176-c7a76c51158f@redhat.com> <3973ecd7-d99c-6d38-7b53-2f3fca57b48d@google.com> <aL7w4qrJtvKE1cu5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Sep 2025, Matthew Wilcox wrote:
> On Mon, Sep 08, 2025 at 03:27:47AM -0700, Hugh Dickins wrote:
> > On Mon, 1 Sep 2025, David Hildenbrand wrote:
> > > On 01.09.25 09:52, David Hildenbrand wrote:
> > > > On 01.09.25 03:17, Hugh Dickins wrote:
> > > >> On Mon, 1 Sep 2025, Matthew Wilcox wrote:
> > > >>> On Sun, Aug 31, 2025 at 02:01:16AM -0700, Hugh Dickins wrote:
> > > >>>> 6.16's folio_expected_ref_count() is forgetting the PG_private_2 flag,
> > > >>>> which (like PG_private, but not in addition to PG_private) counts for
> > > >>>> 1 more reference: it needs to be using folio_has_private() in place of
> > > >>>> folio_test_private().
> > > >>>
> > > >>> No, it doesn't.  I know it used to, but no filesystem was actually doing
> > > >>> that.  So I changed mm to match how filesystems actually worked.
> > 
> > I think Matthew may be remembering how he wanted it to behave (? but he
> > wanted it to go away completely) rather than how it ended up behaving:
> > we've both found that PG_private_2 always goes with refcount increment.
> 
> Let me explain that better.  No filesystem followed the documented rule
> that the refcount must be incremented by one if either PG_private or
> PG_private_2 was set.  And no surprise; that's a very complicated rule
> for filesystems to follow.  Many of them weren't even following the rule
> to increment the refcount by one when PG_private was set.

Thanks, yes, I hadn't realized that you were referring to the +1 (versus
+2) part of it: yes, a quite unnecessarily difficult rule to follow.

...

> So the current behaviour where we set private_2 and bump the refcount,
> but don't take the private_2 status into account is the safe one,
> because the elevated refcount means we'll skip the PG_fscache folio.
> Maybe it'd be better to wait for it to clear.  But since Dave Howells
> is busy killing it off, I'm just inclined to wait for that to happen.

Yes, that's where my internalized-Matthew brought me in the end;
though killing off PG_private_2 seems to have been just around
the corner for a very long time.

It's a pity that there isn't much incentive on ceph folks to
get it fixed: the one who suffers is the compactor or pinner.

Hugh

