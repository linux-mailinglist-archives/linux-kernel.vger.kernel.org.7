Return-Path: <linux-kernel+bounces-788692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3063B388C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531F468541C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF4278143;
	Wed, 27 Aug 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqWg0qOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB034086A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316716; cv=none; b=F21SCtlbTrk09GgUjh5mtzMRYwMptwJJRO5SimE0lUuyMj4PHat6QkYazEBpoMWGZErtNEMSJj2wmOEkM3EXbph/zmE1ivRXxvpRgxdQ63U1H2PFXiOp3zzpI5OWjMVGkdnxFP9s+Q7fUhBqr2MimSvuB09NbrJ6jBBYf2Y0BeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316716; c=relaxed/simple;
	bh=xNXfkQNLNU/BZsp01k5SlSuBU7HR3c29BlOg7gV0ovI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWvWOrgnY9x6q/Q802onmaT21r13JvbvNf3XsHMDlJyyKO3JvlH8KMlR0ncKD8IxDV3KYo72NmbQoJq8pGhfk0+ZmlwoJkjgabb4br0mT4VflWkk9PNmJo3EHsxRFnSs3XJ3sLroScYk5pspEIAydlJMQgZxHZfBh4sduoP1gWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqWg0qOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2842C4CEEB;
	Wed, 27 Aug 2025 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756316715;
	bh=xNXfkQNLNU/BZsp01k5SlSuBU7HR3c29BlOg7gV0ovI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqWg0qOkA4M0KvkNSQboRV2/gRMhu963zpbZfFBU2EnOYYCph/tVq8MRRXEQDbrWl
	 UsQEm5EVyNNG0rC9qwR/AORLxw/UPyO3C8fed3sVLzafRYnpt4iFMUFOvk83HWoBpK
	 zl5Sn9VPzhDXM7NqXgauYnK9bvSBe4kQNdG8EI71huvvoL/i79zARblG2+zgpOyNxy
	 CtFtvuNlWHHS8b6eeG4y36AMQACsyvOYiRYExF8Al2418ipTmSkxBWOKQ4wwRFKXnc
	 CBLBkSXX8+HWGTVhRS4DwS0b/KkDSITU2MHY0Xuv6GG6z5OKDXJIg6DdPsqEwXtpuG
	 ZxZkFU/pvlbww==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v5] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Wed, 27 Aug 2025 10:45:13 -0700
Message-Id: <20250827174513.47171-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CACePvbWzyqJJxP8BFXS_NDLcXCz-YXkt8eYBxv3CER9RpnJVXA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 10:33:38 -0700 Chris Li <chrisl@kernel.org> wrote:

> On Wed, Aug 27, 2025 at 9:18 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Tue, 26 Aug 2025 08:52:35 -0700 Chris Li <chrisl@kernel.org> wrote:
> >
> > > Hi SeongJae,
> > >
> > > I did another pass review on it. This time with the editor so I saw
> > > more source code context and had more feedback.
> > > Mostly just nitpicks. See the detailed comments below.
> >
> > Thank you for your review!
> 
> Thank you for the good work.
> 
> >
> > >
> > > On Fri, Aug 22, 2025 at 12:08 PM SeongJae Park <sj@kernel.org> wrote:
[...]
> > """
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -952,6 +952,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >         struct zpool *zpool;
> >         gfp_t gfp;
> >         u8 *dst;
> > +       bool dst_need_unmap = false;
> 
> A bit nitpicky. That variable name is too long as a C local variable.
> We want local auto variables to be short and sweet. That is why you
> have "dst" rather than  "u8 *destination_compressed_buffer;"
> The local variable name is too long and it can hurt the reading as well.
> Can we have something shorter? e.g. "mapped" or "has_map"

I agree your points, and thank you for suggestions.  I will take "mapped".

[...]
> > > > @@ -1007,6 +1031,14 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> > > >         acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
> > > >         obj = zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buffer);
> > > >
> > > > +       /* zswap entries of length PAGE_SIZE are not compressed. */
> > > > +       if (entry->length = PAGE_SIZE) {
> > > > +               memcpy_to_folio(folio, 0, obj, entry->length);
> > >
> > > The following read_end() followed by acomp unlock() duplicates the
> > > normal decompress ending sequence. It will create complications when
> > > we modify the normal ending sequence in the future, we need to match
> > > it here.How about just goto the ending sequence and share the same
> > > return path as normal:
> > >
> > >  +                  goto read_done;
> > >
> > > Then insert the read_done label at ending sequence:
> > >
> > >         dlen = acomp_ctx->req->dlen;
> > >
> > > + read_done:
> > >         zpool_obj_read_end(zpool, entry->handle, obj);
> > >         acomp_ctx_put_unlock(acomp_ctx);
> >
> > I agree your concern and this looks good to me :)
> >
> > >
> > > If you adopt that, you also will need to init the comp_ret to "0"
> > > instead of no init value in the beginning of the function:
> > >
> > >         struct crypto_acomp_ctx *acomp_ctx;
> > > -        int decomp_ret, dlen;
> > > +       int decomp_ret = 0, dlen;
> > >         u8 *src, *obj;
> >
> > We may also need to initialize 'dlen' as PAGE_SIZE ?
> 
> If there is a code path can lead to dlen use not initialized value? If
> not then we don't have to assign it.

The success return path of zswap_decompress() checks dlen together with
decomp_ret as below.  So I think we need to initialize dlen, too.  Please let
me know if I'm missing something.

    if (!decomp_ret && dlen == PAGE_SIZE)
            return true;

[...]
> > Thank you for your kind review and nice suggestions!  Since the change is
> > simple, I will post a fixup patch as reply to this, for adopting your
> > suggestions with my additional changes (adding dst_need_unmap bool variable on
> > zswap_compress(), and initializing dlen on zswap_decompress()) if you have no
> > objection or different suggestions for the my addition of the changes.  Please
> > let me know if you have any concern or other suggestions for my suggested
> > additional changes.
> 
> I am fine with a fix up patch or a new version. Does not matter to me
> in the slightest. I care more about the final landing code itself more
> than which vehicle to carry the code.  Assume you do all those fix up
> you mention above, you can have my Ack in your fix up:
> 
> Acked-by: Chris Li <chrisl@kernel.org>

Thank you, Chris!

I will post the fixup by tomorrow morning (Pacific time) unless I
hear other opinions or find my mistakes on the above plan by tonight.


Thanks,
SJ

[...]

