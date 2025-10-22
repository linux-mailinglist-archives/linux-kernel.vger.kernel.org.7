Return-Path: <linux-kernel+bounces-863940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E886BF98DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9858E482B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1187A1D5CDE;
	Wed, 22 Oct 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpWnupd6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403E1CEAA3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094785; cv=none; b=HFUH1lctqwbuOmQZW8/iAaKkYLuab4XkUqFiU1yU1QsebBFT4iu45ppxvxx6LduPaAL3S4l7u4hI+WlTvTJoO+/D27MKkHClJwlHr9+DKO9zxQ9pcRzuFVqHhzk/UVMs2MQ5Ue2czifxnJUfavP7jK7XDAxk7TC1jO9crJzQ5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094785; c=relaxed/simple;
	bh=2GjrwFDYdVNv+tpRJWsOPtJi9DEu7XizkxweOnEOd2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGJwY4hVwtw5EVfaNUoaPzlaXFOj/t8YRQ+yxGBL39hCwvRUxmIhIu1CJbF1G4UUdOhTIvEEdSf5SUmF5HfSuFeEHGrrrx63Z3HyKsk4MJqD3H5m6FIp9iS7/9jBpGD20XbBVvgk34OGG7VaPXXT6AigWS3sRZXLs71zNeISvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpWnupd6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711810948aso43334615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761094782; x=1761699582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xEV8oP7/LJpDk2U5jLeRfggXS9CoYgLq/Xr9trinnw=;
        b=HpWnupd6ahlxI/sTzCNoVHJnh+iGAJNsNA/RstOqZMtWiSgg+y0KYA/j2B0ORHF0W1
         owcvSNJpYfTrrFuiwi+ZNFGtta5/J5fwi57u8ikGE2ygPtaW6pz5wo3e7qyv0KXX9SCb
         r9BUBAejkAn18jqtghlnaT83z5fZ4kFEZacvyaDkWqSiOJJQzTlbnH9TH88VChUThtVR
         b4VU71GnC8loR2knCOekKeW6ychk25FtWXmkdlOMTQXVNb8CwUCMRTgcEPOj9JSEW8VL
         BVIIuL6kCUQxvClAsmoEjcEHQkRrFa1CyJ2h/CMeUq3ODxT0sK7BDCpKtxY1TJ9Bvqo7
         ml3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094782; x=1761699582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xEV8oP7/LJpDk2U5jLeRfggXS9CoYgLq/Xr9trinnw=;
        b=b287XQORKqb82sTT10GZDBnCe51diz84Nq5w29Y+pJ/dvIKUVWqi+V2FUhPewdjjUx
         eXWYaio7gXcjo2pPOozktrO7GrfF3MOq1yN4NLZxbFAJ5mNgt21NxwUvlUzdPfHtIEW5
         S8Xte9r9JoTqImWzZvMqojhZi4wxO4z1t8UlizTHnZyDjsvkq4HPEt0Ej8GVmz917KTb
         SO6JvpVS7SZRqqdF7RmphfEeGiCBpSLUuY4Nv/zYyP103KNmkw7qmaSKuq/PLf5+dxvE
         NGsbKBZ7PLdb9AWShex96iImwLyy7JBhK99uStzaW/p/soeAVYbYEoDiGFRA1NscW4N/
         Gokg==
X-Forwarded-Encrypted: i=1; AJvYcCXRVelpud8HCCZ/SmNJRLftvLf68kG65YL46w/Hw1W5GR6OX5cEv/UGFMtCTtoEg4ZwUOZfyEi+NRTVUnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9VUplQMhYd74T7Fkd4zNTDTpxViUrigo/3w+cVsx4o+N4blV
	yRhZ1P7UFaRJvt1Qf8dEunPWUNBUOdCwKm32TEIQMyUxs2+GowHk+uVChEsd4tPWJpn3Qp3VE9g
	gHTrPSrQBCfZmFjHcb8fqku3K+aMDRpRK/ciUxFSw
X-Gm-Gg: ASbGnctsH2ytB6guc77+4yr7cpCYq+SVlD/PU7+AMHw5kJFp8P7H5K8knH3Hvg3uO9m
	5zqrPyF7TqCGQ8l4GSHoeA7fRuv3JLOGmeWgiquWtKK89xItDoFXco+ctmk+yNJCA7osqtqmfdA
	iT3lv4qqCCBUZX9bkHYmhqDQQKKNKVuFwopO7NSTWqmHsflw1/KeHfNT3/Kbx28bGmmtqbtOMED
	f8Ins2LV6Wlit0Qv1Q1WTjq9eXNunnhTQXlMtwS5GDJPjfRm3fkvqVVNYU=
X-Google-Smtp-Source: AGHT+IGx3Qzgr+9yTFCdhHfzYJR0ao2Q/u8VvpEx6LPIGJlsEQvV8faBYF79WSejez6shY/tdzi/USdR7Q8GO8tc8zg=
X-Received: by 2002:a05:600c:4507:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-47117876744mr147970965e9.7.1761094781549; Tue, 21 Oct 2025
 17:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com> <20251001011941.1513050-2-jasonmiu@google.com>
 <20251006141444.GN3360665@nvidia.com> <CAHN2nPKjg6=0QTcSoptxvQW9MpP0YwGUTx_gQDBxgCtSzxY5Pg@mail.gmail.com>
 <20251009175205.GB3899236@nvidia.com>
In-Reply-To: <20251009175205.GB3899236@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Tue, 21 Oct 2025 17:59:29 -0700
X-Gm-Features: AS18NWCV7ujd1_nk4jzUplOGzOVRDyy3XvJOMidHbQL4TGXpAjE_MJA9mRNpbHA
Message-ID: <CAHN2nPJbXeSzLuznWcV+vo80rtk5odd+2GDW_NVDUGPG1KO-Gg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jason, I uploaded the patch v2 according to your feedback.

On Thu, Oct 9, 2025 at 10:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> > > > -#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> > > > +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
> > > >  #define PROP_SUB_FDT "fdt"
> > >
> > > I'de really like to see all of these sorts of definitions in some
> > > structured ABI header not open coded all over the place..
> >
> > Do you think `include/linux/kexec_handover.h` is the appropriate
> > place, or would you prefer a new, dedicated ABI header (e.g., in
> > `include/uapi/linux/`) for all KHO-related FDT constants?
>
> I would avoid uapi, but maybe Pasha has some
> idea.
>
>  include/linux/live_update/abi/ ?

Yes, moved to include/linux/live_update/abi/.

>
> > Agreed. Will change `u64` according to Pasha's comment. And we use
> > explicit casts like `(u64)virt_to_phys(new_tree)` and `(struct
> > kho_radix_tree *)phys_to_virt(table_entry)` in the current series. I
> > believe this, along with the `u64` type, makes it clear that the table
> > stores physical addresses.
>
> Well, the macros were intended to automate this and avoid mistakes
> from opencoding.. Just keep using them?
>

Sure, added two inline functions `kho_radix_tree_desc()` and
`kho_radix_tree()`  back for converting.

> > > > + */
> > > > +static unsigned long kho_radix_encode(unsigned long pa, unsigned i=
nt order)
> > >
> > > pa is phys_addr_t in the kernel, never unsigned long.
> > >
> > > If you want to make it all dynamic then this should be phys_addr_t
> >
> > Should this also be `u64`, or we stay with `phys_addr_t` for all page
> > addresses?
>
> you should use phys_addr_t for everything that originates from a
> phys_addr_t, and u64 for all the ABI
>
done

> > > > +{
> > > > +     unsigned long h =3D 1UL << (BITS_PER_LONG - PAGE_SHIFT - orde=
r);
> > >
> > > And this BITS_PER_LONG is confused, it is BITS_PER_PHYS_ADDR_T which
> > > may not exist.
> > >
> > > Use an enum ORDER_0_LG2 maybe
> >
> > I prefer `KHO_RADIX_ORDER_0_BIT_POS` (defined as `BITS_PER_LONG -
> > PAGE_SHIFT`) over `ORDER_0_LG2`, as I think the latter is a bit hard
> > to understand, what do you think? This constant, along with others,
> > will be placed in the enum.
>
> Sure, though I prefer LG2 to BIT_POS

Lets pick LG2. =3D)

>
> BIT_POS to me implies it is being used as  bit wise operation, while
> log2 is a mathematical concept
>
>   X_lg2 =3D ilog2(X)  &&  X =3D=3D 1 << X_lg2
>
> > > > +                             kho_radix_tree_walk_callback_t cb)
> > > > +{
> > > > +     int level_shift =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > > > +     struct kho_radix_tree *next_tree;
> > > > +     unsigned long encoded, i;
> > > > +     int err =3D 0;
> > > >
> > > > +     if (level =3D=3D 1) {
> > > > +             encoded =3D offset;
> > > > +             return kho_radix_walk_bitmaps((struct kho_bitmap_tabl=
e *)root,
> > > > +                                           encoded, cb);
> > >
> > > Better to do this in the caller  a few lines below
> >
> > But the caller is in a different tree level? Should we only walk the
> > bitmaps at the lowest level?
>
> I mean just have the caller do
>
> if (level-1 =3D=3D0)
>    kho_radix_walk_bitmaps()
> else
>    ..
>
> Avoids a function call

I see. Done.

>
> > > > +     for (i =3D 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
> > > > +             if (root->table[i]) {
> > > > +                     encoded =3D offset << level_shift | i;
> > >
> > > This doesn't seem right..
> > >
> > > The argument to the walker should be the starting encoded of the tabl=
e
> > > it is about to walk.
> > >
> > > Since everything always starts at 0 it should always be
> > >   start | (i << level_shift)
> > >
> > > ?
> >
> > You're right that this line might not be immediately intuitive. The
> > var `level_shift` (which is constant value 9 here) is applied to the
> > *accumulated* `offset` from the parent level. Let's consider an
> > example of a preserved page at physical address `0x1000`, which
> > encodes to `0x10000000000001` (bit 52 is set for order 0, bit 0 is set
> > for page 1).
>
> Oh, weird, too weird maybe. I'd just keep all the values as fully
> shifted, level_shift should be adjusted to have the full shift for
> this level. Easier to understand.
>
> Also, I think the order bits might have become a bit confused, I think
> I explained it wrong.
>
> My idea was to try to share the radix levels to save space eg if we
> have like this patch does:
>
>   Order phys
>   00001 abcd
>   00010 0bcd
>   00100 00cd
>   01000 000d
>
> Then we don't get too much page level sharing, the middle ends up with
> 0 indexes in tables that cannot be shared.
>
> What I was going for was to push all the shared pages to the left
>
>   00001 abcd
>   00000 1bcd
>   00000 01cd
>   00000 001d
>
> Here the first radix level has index 0 or 1 and is fully shared. So eg
> Order 4 and 5 will have all the same 0 index table levels. This also
> reduces the max height of the tree because only +1 bit is needed to
> store order.
>
> Jason

Thanks for the clarification. I updated the logic by keeping the
encoded value fully shifted and adjusting the `level_shift` according
to the current level.

And yes we are having the shared pages on the left side (zeros in the
encoded prefix) while having the order bits shift to right when the
page order increases. I hope the updated code makes this more clearer.

--
Jason Miu

