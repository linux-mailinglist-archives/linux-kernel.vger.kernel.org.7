Return-Path: <linux-kernel+bounces-753636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCA5B185A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BF8A877C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59728CF40;
	Fri,  1 Aug 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWSkAt6N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714428C5BE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065405; cv=none; b=ZKqQ2BSWFtkkNiSPSX7LsEY142TXgUwShp19ZNJ4yL3dq7DwGaGoNUOoMI0d7oofCu957xh5J+SumvQ5WpCu9Q0w+toR08AyjstPS7585A8m08qlTa8GvOsTrr6tY3BlFfwHHTIA6uSZWeigodTbXQRFF9O2lFA/SXyBb0FFW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065405; c=relaxed/simple;
	bh=uFcUdzw4z2rKbbLnA5yGBGQkIqGE+6Mg+Uk8DrHKiIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzNXwSMCOaqDX4bZenp1iInDigzbtyjtOsIuhPQOtnk4N0ro01CCdH+Ugd8b5xpEqhZ0Hdg6cs5iq/lvpZoTCPxjwUoNczqkgCDt+Y3BdgNE13eMkqKHCjNTy0nNQca3S2a6CfAQ5YBWL7NYNRbnqogIK11z3Hov4fbEHY0dUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWSkAt6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754065401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Sqvb7JAqSKhuY6yKaHlPytiCq88KcrtpeNVaMME5GA=;
	b=JWSkAt6NWKogVbWQfB6pgsgg0UN1XD5TFpxGuOM+e7gzWU6nGP1ghVf8lgVjK/mV9zNBjZ
	fQtvoi5qsAe65rHEx8bOy7zjMfGrszEdb80J3N/0U0tCR7TJ5xXTrywE4OgJiKz8DR7MTN
	2weAQz5DhFd0fHFw0NagKRBptvtWjGc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-5O6Hoes1MxucNC4p2dflBg-1; Fri, 01 Aug 2025 12:23:20 -0400
X-MC-Unique: 5O6Hoes1MxucNC4p2dflBg-1
X-Mimecast-MFC-AGG-ID: 5O6Hoes1MxucNC4p2dflBg_1754065400
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70748301f71so34759606d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065400; x=1754670200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sqvb7JAqSKhuY6yKaHlPytiCq88KcrtpeNVaMME5GA=;
        b=Q39o9KcGeb2Jb0+OAvJ2/cuWdldlnXF/Rb2zmtxjTKG0nuYIqxWCOpBxUM7bVizZbu
         vEeL4yHXJPqCuKCz3t7EG3UWR4IfUOGFWxz5f6dNIxmtsI0AZqV6F44K4Giz/el1xKQm
         Lx/zuWqY88QZ2cgKFrEl/iS1fuhrjX4rDbq/ND/7Alby3Lvv7O75d4FNWVfmJbYQIFqy
         ZXo5W7w3zflaq0lY/JIfKMjiH1k6MB1kKpWlNDHSowzDixDuBdxSs1brhs4zHdrXaHdh
         WOtttMz1vqCdE3QwnzT5JtXKbCCcizge7hz6T6opTnTW2kJLT3tcWjbzwOHtVSWQ3vNe
         6vmw==
X-Forwarded-Encrypted: i=1; AJvYcCUFdBLiQAX/lSgV2jIEyR8x0bMOp5JmW7xdlD9U4FsTRyuAp+ZnlwwQ6XpxxVC/gq4cf7O0HMbmGM+q8yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziqNwdV3/fw02HnUlumspldXxwhbo0yVZVOK1tQDTgZlWUIToG
	/8sO0abmPHK3ZSnGtLw025zON6QlHCc2gnBrWbKIRoDTA0rwpb+R2blksjdV3R3zhQl2d1t4U45
	bWBPhhddKrNUGFG3wVYobF0bshVA+LB/ejN/nxQy4TMfpDtNZe3agEHV8Ips5+M1lEA==
X-Gm-Gg: ASbGnctU20RG+QJhGj1Co2+GQcaCOuywLHwSmGQmj9lKKkvmwIYyRG8UrXkQGPLDYPj
	mDVR1UugG0hMnD0PQSWmv3DXw63cugnuv6X/na1cFvoIQWTmduY9MCb4qcdfYX+Dtduu3ASxp55
	fcobMgkZtoHj5/PUKdK5U/gIXm2OrOpGFN8UTtxF7/jUF0vjpakv7fv0FOC1uIl78riDJZ0ho7X
	Av+cxx76uqjZRdL9wBgfjJwR7+17i5F4bzXVrB2cJ+eNsFysfOPnDa5oDuhmPr3OyrPCVTROvtt
	6Cf1z93x71m/8Gnd6OMvJAfklbJ2HZjg
X-Received: by 2002:a05:6214:623:b0:707:1eae:17e9 with SMTP id 6a1803df08f44-70935f6c42emr3328406d6.21.1754065399942;
        Fri, 01 Aug 2025 09:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpZI71GEayMeGwYSIqUSspyQlyLLtHuQaSsWRKAdHTVneK9AyXLakZUxoMF71iimA1I9hOJg==
X-Received: by 2002:a05:6214:623:b0:707:1eae:17e9 with SMTP id 6a1803df08f44-70935f6c42emr3327936d6.21.1754065399325;
        Fri, 01 Aug 2025 09:23:19 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9dc383sm22996276d6.16.2025.08.01.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:23:18 -0700 (PDT)
Date: Fri, 1 Aug 2025 12:23:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aIzp6WqdzhomPhhf@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local>
 <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>

On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 1, 2025 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > >
> > > Hi!
> > >
> > > Did you mean in you patch description:
> > >
> > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> > >
> > > Talking about THP holes is very very confusing.
> > >
> > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > > encounters a non-present THP, it fails to properly recognize an unmapped
> > >
> > > You mean a "non-present PMD that is not a migration entry".
> > >
> > > > hole and tries to access a non-existent folio, resulting in
> > > > a crash. Add a check to skip non-present THPs.
> > >
> > > That makes sense. The code we have after this patch is rather complicated
> > > and hard to read.
> > >
> > > >
> > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > > Changes since v1 [1]
> > > > - Fixed step size calculation, per Lokesh Gidra
> > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > > >
> > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > > >
> > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index cbed91b09640..b5af31c22731 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > >             ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> > > >             if (ptl) {
> > > > -                   /* Check if we can move the pmd without splitting it. */
> > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > -                       !pmd_none(dst_pmdval)) {
> > > > -                           struct folio *folio = pmd_folio(*src_pmd);
> > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> >
> > [1]
> >
> > > > +                           /* Check if we can move the pmd without splitting it. */
> > > > +                           if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > +                               !pmd_none(dst_pmdval)) {
> > > > +                                   if (pmd_present(*src_pmd)) {

[2]

> > > > +                                           struct folio *folio = pmd_folio(*src_pmd);

[3]

> > > > +
> > > > +                                           if (!folio || (!is_huge_zero_folio(folio) &&
> > > > +                                                          !PageAnonExclusive(&folio->page))) {
> > > > +                                                   spin_unlock(ptl);
> > > > +                                                   err = -EBUSY;
> > > > +                                                   break;
> > > > +                                           }
> > > > +                                   }
> > >
> > > ... in particular that. Is there some way to make this code simpler / easier
> > > to read? Like moving that whole last folio-check thingy into a helper?
> >
> > One question might be relevant is, whether the check above [1] can be
> > dropped.
> >
> > The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
> > before returning the ptl.  I didn't follow closely on the recent changes on
> > mm side on possible new pmd swap entries, if migration is the only possible
> > one then it looks like [1] can be avoided.
> 
> Hi Peter,
> is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> && !pmd_present()) PMD to pass and that's when this crash is hit.

First for all, thanks for looking into the issue with Lokesh; I am still
catching up with emails after taking weeks off.

I didn't yet read into the syzbot report, but I thought the bug was about
referencing the folio on top of a swap entry after reading your current
patch, which has:

	if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
	    !pmd_none(dst_pmdval)) {
		struct folio *folio = pmd_folio(*src_pmd); <----

Here looks like *src_pmd can be a migration entry. Is my understanding
correct?

> If we drop the check at [1] then the path that takes us to

If my above understanding is correct, IMHO it should be [2] above that
makes sure the reference won't happen on a swap entry, not necessarily [1]?

> split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> indication that split did not happen. Afterwards we will retry

So we're talking about the case where it's a swap pmd entry, right?  Could
you elaborate why the split would fail?  AFAIU, split_huge_pmd_locked()
should still work for a migration pmd entry.

Thanks,

> thinking that PMD got split and leaving further remapping to
> move_pages_pte() (see the comment before "continue"). I think in this
> case it will end up in the same path again instead (infinite loop). I
> didn't test this but from the code I think that's what would happen.
> Does that make sense?
> 
> >
> > And it also looks applicable to also drop the "else" later, because in "if
> > (ptl)" it cannot hit pmd_none().
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
> 

-- 
Peter Xu


