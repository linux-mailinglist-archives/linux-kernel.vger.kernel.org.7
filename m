Return-Path: <linux-kernel+bounces-753685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C4B18660
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D81E7A32EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2E1E1C1A;
	Fri,  1 Aug 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4bFfPKG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0119C546
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068440; cv=none; b=ckKXsN6rLf1W6OOX0WvA9o7g3N3Uzqg1p5Y/PEy2AW4jHeaMAOGdinrhYSXws7Rw0SAZKUmWEjbN0CUljt2h9mH7QQDEumQRfhsS/Lolj+JQz+prHv7uosKIHOLkKo/7s/wwSY6LkOCkF7xqwgkoaNFVUDONR/bWPPODnjHJ1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068440; c=relaxed/simple;
	bh=urjHTNxVtznsZGPK5MfG0R49OKWj2ch5jHzSEmSRmi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYeNbtxh7RNadwp1xMQz2JY6Bp2pcJO6V6U33T5ovUzqR1aD2CUyCmeoFDLtlFcMSDHZF+jxFbO8BQhuwOS6gNV81foPkhalhoYMyOMB/+V9zYs0YE1/+saMA5U1b+x5md/ehFjFGeOorSK1RE75jiFk6EBRmu4CbHFlIOkyj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4bFfPKG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754068437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UapQRB4TdH6jPVjzlLlw/CIcbZ+SS127yBars+dasnY=;
	b=E4bFfPKGADA5XJIVWQDJfLrojC5d6uX81nDf3B5VpmMlLH9zgmLwky9qScNY4l05gIOosj
	S39gQPof8EVukt7EvljDPsAYC0zlxSbbPaMxUcHdxaPmRcZEsE4QCT0lCqJ11qOHKLMwPw
	cnbgxw2yf/DzcUr9OH+kk2OZYh+frxg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-9R0PgB5kMX6m5-Budb_fPA-1; Fri, 01 Aug 2025 13:13:56 -0400
X-MC-Unique: 9R0PgB5kMX6m5-Budb_fPA-1
X-Mimecast-MFC-AGG-ID: 9R0PgB5kMX6m5-Budb_fPA_1754068436
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab401e333bso76098271cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068436; x=1754673236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UapQRB4TdH6jPVjzlLlw/CIcbZ+SS127yBars+dasnY=;
        b=YPkVQHZevc4aEN9lPKbr72BbUAkDey5kkcph9yKB4w516Hp2F9wWzs1otFDpE7d2fq
         UHIfnC/uHuwwL3LHbBKaHb7c/F4o+pEi2btvCdLR5Mt0CXaOFd0ccb1j+fcMEFJ9ddUU
         x07BGlEqADrufbSyAzWRDcq6ubbpH6YiZgNQrskdebPRBcxP2bp8L/CPd9FJ/rerzt+v
         JbBL15UIE1MdskiZ19Hvn77DBNkTnNg7fMY5F685sWw1IYoIDUdbR7LhLf3E7KySsJgW
         a6QM23nApRHUX9T5qBj+jSimLxkncawlDUVFihnrFSSmfMi2s3inGYy6kUWhClM1Nb+E
         p2vA==
X-Forwarded-Encrypted: i=1; AJvYcCVexqX8aHuB+mR73hes3qG0EesKRPzmAF0Ap7QrULSVS4TECCZe0ZF0UW5ZNVZsgYOyX8x+PI/yqXMZ+5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqOKI1rfP5DCjTu35cvtt22WYkzKc1YhNcfpWi9J6NGeFpsb9
	zsP6VgBQ0CcVOQqFSUakoMe45a0O+4c7x9+R+T3uGvl1mjX4q4KiTFFTojfXmtTQysehUW4Wot5
	rf5lmqjscgIceX5A/UCy91RGtBx8HCWOkr2Dxq/wpOgkI1qvh6O0ACYgYWbWTJX1bww==
X-Gm-Gg: ASbGncshW8RVOPKVUIwUngtv5U2TMumugWIAQunhAlNfGacsGwbrmoJfdcejMwdhbZh
	9I4noO8zr18fn+A9A4zRw7WJDwaaBXk4+rXn5JAFcXm25B7wUBiFlDjUWfkjKr+IUgNtgfoLrFx
	Ju0Ra5J4ZoXJ95qFOvwR1muwSGIg8jmFUqd0s19meSZ9pRgyJTnfKwiEEaNgc7Xrddi4ev237e6
	2YiXInYIlRjsupCn3tIf2b3vRvlbZIJQy5ZcymMuNYJpsVFGsw61OhfP1j7sNploUf/y0h3eJeu
	y87YRdD4vHV785dv6dg6NeykA6FOm+st
X-Received: by 2002:a05:622a:a953:20b0:4af:36a:a60f with SMTP id d75a77b69052e-4af036aa957mr25038531cf.21.1754068435404;
        Fri, 01 Aug 2025 10:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8+K6i2QRol52KGBLA9S6CAT2dneVBlknXiG0f/LH2d8sJO8oI3hxjPNdTh/rQMWdVl3tj8g==
X-Received: by 2002:a05:622a:a953:20b0:4af:36a:a60f with SMTP id d75a77b69052e-4af036aa957mr25037891cf.21.1754068434728;
        Fri, 01 Aug 2025 10:13:54 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeebde17fsm22954801cf.1.2025.08.01.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:13:54 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:13:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aIz1xrzBc2Spa2OH@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local>
 <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local>
 <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>

On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 1, 2025 at 9:23 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Aug 1, 2025 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > Did you mean in you patch description:
> > > > >
> > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> > > > >
> > > > > Talking about THP holes is very very confusing.
> > > > >
> > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > > > > encounters a non-present THP, it fails to properly recognize an unmapped
> > > > >
> > > > > You mean a "non-present PMD that is not a migration entry".
> > > > >
> > > > > > hole and tries to access a non-existent folio, resulting in
> > > > > > a crash. Add a check to skip non-present THPs.
> > > > >
> > > > > That makes sense. The code we have after this patch is rather complicated
> > > > > and hard to read.
> > > > >
> > > > > >
> > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > ---
> > > > > > Changes since v1 [1]
> > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > > > > >
> > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > > > > >
> > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > --- a/mm/userfaultfd.c
> > > > > > +++ b/mm/userfaultfd.c
> > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > >             ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > >             if (ptl) {
> > > > > > -                   /* Check if we can move the pmd without splitting it. */
> > > > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > -                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> > > >
> > > > [1]
> > > >
> > > > > > +                           /* Check if we can move the pmd without splitting it. */
> > > > > > +                           if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > +                                   if (pmd_present(*src_pmd)) {
> >
> > [2]
> >
> > > > > > +                                           struct folio *folio = pmd_folio(*src_pmd);
> >
> > [3]
> >
> > > > > > +
> > > > > > +                                           if (!folio || (!is_huge_zero_folio(folio) &&
> > > > > > +                                                          !PageAnonExclusive(&folio->page))) {
> > > > > > +                                                   spin_unlock(ptl);
> > > > > > +                                                   err = -EBUSY;
> > > > > > +                                                   break;
> > > > > > +                                           }
> > > > > > +                                   }
> > > > >
> > > > > ... in particular that. Is there some way to make this code simpler / easier
> > > > > to read? Like moving that whole last folio-check thingy into a helper?
> > > >
> > > > One question might be relevant is, whether the check above [1] can be
> > > > dropped.
> > > >
> > > > The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
> > > > before returning the ptl.  I didn't follow closely on the recent changes on
> > > > mm side on possible new pmd swap entries, if migration is the only possible
> > > > one then it looks like [1] can be avoided.
> > >
> > > Hi Peter,
> > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> > > && !pmd_present()) PMD to pass and that's when this crash is hit.
> >
> > First for all, thanks for looking into the issue with Lokesh; I am still
> > catching up with emails after taking weeks off.
> >
> > I didn't yet read into the syzbot report, but I thought the bug was about
> > referencing the folio on top of a swap entry after reading your current
> > patch, which has:
> >
> >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> >             !pmd_none(dst_pmdval)) {
> >                 struct folio *folio = pmd_folio(*src_pmd); <----
> >
> > Here looks like *src_pmd can be a migration entry. Is my understanding
> > correct?
> 
> Correct.
> 
> >
> > > If we drop the check at [1] then the path that takes us to
> >
> > If my above understanding is correct, IMHO it should be [2] above that
> > makes sure the reference won't happen on a swap entry, not necessarily [1]?
> 
> Yes, in case of migration entry this is what protects us.
> 
> >
> > > split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> > > indication that split did not happen. Afterwards we will retry
> >
> > So we're talking about the case where it's a swap pmd entry, right?
> 
> Hmm, my understanding is that it's being treated as a swap entry but
> in reality is not. I thought THPs are always split before they get
> swapped, no?

Yes they should be split, afaiu.

> 
> > Could you elaborate why the split would fail?
> 
> Just looking at the code, split_huge_pmd_locked() checks for
> (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> pmd_trans_huge() is false if !pmd_present() and it's not a migration
> entry, so __split_huge_pmd_locked() will be skipped.

Here might be the major part of where confusion came from: I thought it
must be a migration pmd entry to hit the issue, so it's not?

I checked the code just now:

__handle_mm_fault:
		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
			VM_BUG_ON(thp_migration_supported() &&
					  !is_pmd_migration_entry(vmf.orig_pmd));

So IIUC pmd migration entry is still the only possible way to have a swap
entry.  It doesn't look like we have "real" swap entries for PMD (which can
further points to some swapfiles)?

-- 
Peter Xu


