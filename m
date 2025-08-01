Return-Path: <linux-kernel+bounces-753746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64415B18746
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137CF3B0690
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40952737F2;
	Fri,  1 Aug 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT2Lz8UJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39CE188CC9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072473; cv=none; b=JmMvLSXDD/DpG7XWyiGEMLjuG0wLdOLrL4HMoQGQra59tBmIf7jrfSlYrg3NfnXfj3oCjh4tXMwNJpTYdqkxKIO5E0hd7Spz1u1FXjc1yLg211EUeNUljixycICDifovGEAAJSHwnojcHgucspD/GWY9hMugAQ7YGW2S6wJwp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072473; c=relaxed/simple;
	bh=ZyhKLAXPVem8Lwhg/0x9FEtKYTT6fl9Yd/aQVwsfu4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIEHAtpWEQmqI8YAjyjEf8s9432o42z2xLKcZ1BBelMA/BBUvTcjLTu0FDuEW0YRW3agdmHvS0g4ut5bRGq8QKOoGfO2ylYFEccNE5hKAgGCrjFSf5xKBc+Si9JAtSDIQI0KSi0eCSFHjHaOVaKfGwRrYttPnwoJUPsax08eYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gT2Lz8UJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754072468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2g39l8sL+vMNhyKGrd5r0iuwpLk0Okh6OkF+13JKUXU=;
	b=gT2Lz8UJ0VEsicsGUlKIwsyVtMp7vipjsq98ODm34Ea5kf34w5ETZqmhG+vyNvW0V/n5YZ
	j10mLtzdO7TxsZ+01arRZUsZaiW2NWhUqzrdCOX2fFwys1kpaEKnzB8JH/duwiX0gQ5F2b
	XW3NH6uBtDnWDrRnGE6M7iPlaLm4pR4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-m5xlWtWJMl2ZaqBw0ZcHow-1; Fri, 01 Aug 2025 14:21:07 -0400
X-MC-Unique: m5xlWtWJMl2ZaqBw0ZcHow-1
X-Mimecast-MFC-AGG-ID: m5xlWtWJMl2ZaqBw0ZcHow_1754072465
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb5f71b363so24177726d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072465; x=1754677265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g39l8sL+vMNhyKGrd5r0iuwpLk0Okh6OkF+13JKUXU=;
        b=VR8eLQBc2nSUkGju1b04cgUoFRJDqPvHvWedvRj9vqr6or/9FhB+ZCu4EH3txVG8lR
         ozI8ldKfuvcodryZxrFyRA0KJX5aORG9BcX7yfM110CpvRH91Gr0RoNpkaF0srzVm+z0
         sq2YhBEgLo8K+gEz7wfBOlGoYrvBobRYivn8PmsMX8+JGgxboz0LN1bW7BT3i1kn64bU
         eHZqrLK+SbaIuaWH+M5z/tx0Qo4e2YOvtp3lkp40EEXyKyzP4YxBKaQj05k8GIBJZMiE
         77N1kw4iJ1MaYEfsV0ahZOvcnPEvQaQoofHQWrL6IoyoYkMVVwBftqZlxF8G8nYIs+GD
         k2JA==
X-Forwarded-Encrypted: i=1; AJvYcCWnWCErF3P9WFYURvr+QXynAfN47tlAH6InUcEq7pONS3MMZrnUJCJ9GrkXgZEJaAtAQN+JAHHOamiZpq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlf3OB86/tVGMXDnZP50mK/MdX9wvWcULtSLIWzBynz2RtbXF2
	mGr3BUxI3ZdSVP/8Dwhqw/t2IxaR3vqPwaU9YQC4lNysnB4UDr5oIqr7qUxyRCliYAcpQLXIZqr
	waB74gLQUnIrj3Z0TY9FjphpyMXwgTY/UL/qIUayn59p2XZZoeCrM5mXn9s0XMrSI+A==
X-Gm-Gg: ASbGncv/GxCpmefll5XcXnzoU2rN+SHu0JrdkXbkaeTEOC7duHhRu+pU+yUs7AgWeVx
	tfACQc2dLE7PB1lpIOqD7I0FtpVzPI5HsTJmXSLbiBvXIErJ7l3X0yU6RNb6y6bcfN4q/FHchFu
	BqFNkkuRHyUaPJjaV8G9+1cRxOo8SiC+bYR0qDbTzMrqfBX9G/YppI57T+51Sj2MMSlLKlQEcy3
	Bqluv00LUZtzv1Q0fWk30YLu6GhYT2mXD8ehji+2xBBLh4b6GHu6ESyYaY7K76VJSONKK7Xap55
	lEf8sl8KAUMuBQVHcbS4iymkTrjMHcnz
X-Received: by 2002:ad4:5e88:0:b0:707:5ccb:6c4 with SMTP id 6a1803df08f44-7093633522bmr10005856d6.49.1754072465242;
        Fri, 01 Aug 2025 11:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJHvaY504H4W8dqLVRQkrI3AZzsoZBUQlKebveXmIXu7VcAHN9hG/HeWlxIkI0yMFKMrPIQA==
X-Received: by 2002:ad4:5e88:0:b0:707:5ccb:6c4 with SMTP id 6a1803df08f44-7093633522bmr10005226d6.49.1754072464631;
        Fri, 01 Aug 2025 11:21:04 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed62d1fsm22935171cf.41.2025.08.01.11.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:21:04 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:20:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aI0Ffc9WXeU2X71O@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local>
 <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local>
 <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local>
 <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>

On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan wrote:
> On Fri, Aug 1, 2025 at 5:13 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Aug 1, 2025 at 9:23 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > > > > On Fri, Aug 1, 2025 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > >
> > > > > > > Hi!
> > > > > > >
> > > > > > > Did you mean in you patch description:
> > > > > > >
> > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> > > > > > >
> > > > > > > Talking about THP holes is very very confusing.
> > > > > > >
> > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > > > > > > encounters a non-present THP, it fails to properly recognize an unmapped
> > > > > > >
> > > > > > > You mean a "non-present PMD that is not a migration entry".
> > > > > > >
> > > > > > > > hole and tries to access a non-existent folio, resulting in
> > > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > > >
> > > > > > > That makes sense. The code we have after this patch is rather complicated
> > > > > > > and hard to read.
> > > > > > >
> > > > > > > >
> > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > ---
> > > > > > > > Changes since v1 [1]
> > > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > > > > > > >
> > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > > > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > > > >             ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > > > >             if (ptl) {
> > > > > > > > -                   /* Check if we can move the pmd without splitting it. */
> > > > > > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > > -                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> > > > > >
> > > > > > [1]
> > > > > >
> > > > > > > > +                           /* Check if we can move the pmd without splitting it. */
> > > > > > > > +                           if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > > > +                                   if (pmd_present(*src_pmd)) {
> > > >
> > > > [2]
> > > >
> > > > > > > > +                                           struct folio *folio = pmd_folio(*src_pmd);
> > > >
> > > > [3]
> > > >
> > > > > > > > +
> > > > > > > > +                                           if (!folio || (!is_huge_zero_folio(folio) &&
> > > > > > > > +                                                          !PageAnonExclusive(&folio->page))) {
> > > > > > > > +                                                   spin_unlock(ptl);
> > > > > > > > +                                                   err = -EBUSY;
> > > > > > > > +                                                   break;
> > > > > > > > +                                           }
> > > > > > > > +                                   }
> > > > > > >
> > > > > > > ... in particular that. Is there some way to make this code simpler / easier
> > > > > > > to read? Like moving that whole last folio-check thingy into a helper?
> > > > > >
> > > > > > One question might be relevant is, whether the check above [1] can be
> > > > > > dropped.
> > > > > >
> > > > > > The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
> > > > > > before returning the ptl.  I didn't follow closely on the recent changes on
> > > > > > mm side on possible new pmd swap entries, if migration is the only possible
> > > > > > one then it looks like [1] can be avoided.
> > > > >
> > > > > Hi Peter,
> > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> > > > > && !pmd_present()) PMD to pass and that's when this crash is hit.
> > > >
> > > > First for all, thanks for looking into the issue with Lokesh; I am still
> > > > catching up with emails after taking weeks off.
> > > >
> > > > I didn't yet read into the syzbot report, but I thought the bug was about
> > > > referencing the folio on top of a swap entry after reading your current
> > > > patch, which has:
> > > >
> > > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > >             !pmd_none(dst_pmdval)) {
> > > >                 struct folio *folio = pmd_folio(*src_pmd); <----
> > > >
> > > > Here looks like *src_pmd can be a migration entry. Is my understanding
> > > > correct?
> > >
> > > Correct.
> > >
> > > >
> > > > > If we drop the check at [1] then the path that takes us to
> > > >
> > > > If my above understanding is correct, IMHO it should be [2] above that
> > > > makes sure the reference won't happen on a swap entry, not necessarily [1]?
> > >
> > > Yes, in case of migration entry this is what protects us.
> > >
> > > >
> > > > > split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> > > > > indication that split did not happen. Afterwards we will retry
> > > >
> > > > So we're talking about the case where it's a swap pmd entry, right?
> > >
> > > Hmm, my understanding is that it's being treated as a swap entry but
> > > in reality is not. I thought THPs are always split before they get
> > > swapped, no?
> >
> > Yes they should be split, afaiu.
> >
> > >
> > > > Could you elaborate why the split would fail?
> > >
> > > Just looking at the code, split_huge_pmd_locked() checks for
> > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > pmd_trans_huge() is false if !pmd_present() and it's not a migration
> > > entry, so __split_huge_pmd_locked() will be skipped.
> >
> > Here might be the major part of where confusion came from: I thought it
> > must be a migration pmd entry to hit the issue, so it's not?
> >
> > I checked the code just now:
> >
> > __handle_mm_fault:
> >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> >                         VM_BUG_ON(thp_migration_supported() &&
> >                                           !is_pmd_migration_entry(vmf.orig_pmd));
> >
> > So IIUC pmd migration entry is still the only possible way to have a swap
> > entry.  It doesn't look like we have "real" swap entries for PMD (which can
> > further points to some swapfiles)?
> 
> Correct. AFAIU here we stumble on a pmd entry which was allocated but
> never populated.

Do you mean a pmd_none()?

If so, that goes back to my original question, on why
__pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()?  IMHO it
really should have returned NULL for pmd_none().

IOW, I still don't understand why below won't already work:

===8<===
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 52d7d5f144b8e..33e78f52ee9f5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1880,13 +1880,15 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
                        /* Check if we can move the pmd without splitting it. */
                        if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
                            !pmd_none(dst_pmdval)) {
-                               struct folio *folio = pmd_folio(*src_pmd);
-
-                               if (!folio || (!is_huge_zero_folio(folio) &&
-                                              !PageAnonExclusive(&folio->page))) {
-                                       spin_unlock(ptl);
-                                       err = -EBUSY;
-                                       break;
+                               if (pmd_present(*src_pmd)) {
+                                       struct folio *folio = pmd_folio(*src_pmd);
+
+                                       if (!folio || (!is_huge_zero_folio(folio) &&
+                                                      !PageAnonExclusive(&folio->page))) {
+                                               spin_unlock(ptl);
+                                               err = -EBUSY;
+                                               break;
+                                       }
                                }

                                spin_unlock(ptl);

===8<===

Likely I missed something important..  I'll be afk for a while soon, I'll
also double check (maybe early next week) on the reproducer.

Thanks,

-- 
Peter Xu


