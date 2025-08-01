Return-Path: <linux-kernel+bounces-753475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD01B18383
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1525D1C829F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F86F25C833;
	Fri,  1 Aug 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQrB/Zo+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5A1D52B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057784; cv=none; b=U1TN2OhTQw0hV1ebiUxIRMB4vDa3pOjCp7mH7Ve2aVEXdajPQ3AuPcL+S0OI4aGpA3SghdAam/etT99IFvwYDN4Yys5LXWZecFjv6NYEdBTB4s1oro+m1+afdNyG/atfj+yfnBN/aYE1Xk4su0UMeKDVbm+CBwPl0SQ4f/cGDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057784; c=relaxed/simple;
	bh=fkicVuLv0/RUgxzAMew1rsJVx1staOCi9qLzOdfW1T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nznCs6jWRU+0bMJzQCajhj7TTCKEVpo+0nX2i4l2Jpz3KZ46e2/l2R9WU2zL2BoYLyZPCcxdHIuIr5u0y9MKI0sDWZpqvo6ukiVHdztB+wIqW94seBfOjoS7pxYuHMfejUGaoLFzaYtu3pdToVKK2YEf4ItsyD5bzlzZbF1mHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQrB/Zo+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754057781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxZ9pu4hPNnD/ub+/DxG4Ghav/BT/6VOf4b/nhk7vKQ=;
	b=JQrB/Zo+zjsJ6p+hz9v8U7xfDzl9MvOB6NcrRA+r9JVzAA5HOAXX3cxbwFMhTfiY7aT/UP
	E9uuQ5DHpULqj4qASUoVsyzMvTP/5/uYLqccv2A5VqRAEgOSY/F3a0nxsCUDfpmzMtFVIk
	IqRY8VFAMuT/RiDdxZpkxnPI4w4wWeE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-cKHw1dRxP9CtbIBW2CHh-A-1; Fri, 01 Aug 2025 10:16:20 -0400
X-MC-Unique: cKHw1dRxP9CtbIBW2CHh-A-1
X-Mimecast-MFC-AGG-ID: cKHw1dRxP9CtbIBW2CHh-A_1754057780
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7418ef2dbdaso1625175a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057779; x=1754662579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxZ9pu4hPNnD/ub+/DxG4Ghav/BT/6VOf4b/nhk7vKQ=;
        b=L1zYiyajVtv9DlNBR2xIC9J9PZ5Zqel7NyTq1Nph3kT22ggRdqIYWTrPScd8BLGdsh
         LDTYhqDnuodqyoYbu/g0nABizPzLTncm5hvQe+XkDvYo+h2W953TRiXcvrcY0kaYyWfU
         +Ur0y5O4SBK05384JWer/Bj0dxv4Z77kda3dDFnSfUGDRZ9245gu+yXVhcS0q/TuLGN+
         YgYuEsVTeouYgiVcOqC1EuFucOEAwoO8LROzxedwNtc7VhpSYcYFj2NfJypQyCG11Geu
         Y4o+T8oFop+I6CTQpTcvyCM2ISWBg39pWY1vTzIvFelpI+QqxOqOX1M4uZQHFnjJPjDK
         TLyw==
X-Forwarded-Encrypted: i=1; AJvYcCVqtbolNRYGM1izdsBGQM4OYS+4XykjuhxSxB1fBYzgE/cf6s9m31cw5/Nk+m10CVfouuRB8EWbuUAEh70=@vger.kernel.org
X-Gm-Message-State: AOJu0YySywBVHJIwwMxcUqr8hhlQg56cKUNFqWQwbmQ2nvyA307Oyh0e
	LRBUJv72YsibqdOdimhtcZjar5sku0o9otXlcbmxrHIBPbQCSYW9M16i70n5tzRvKKIbI8+ldv/
	nBfmX5ubKGsMRfJJZBpwekAN5iueZvJC4ZHwpPeO4bkacbhU9zUwWHoAT6Oty/LWpPVp3EaaT4w
	==
X-Gm-Gg: ASbGncsuO1XrB45HQj71CVLOX0FneVROqeRPsgTdIY6lbWnD3U4YLwpfj95uWoB5/N+
	uPxbur+0QSUoy9qGhgn1bq2iHToqG9tEbo//f7nqC/xdtt7fhEhVklZlQu/ZwuDcSFev2jzubKI
	ioCj8t85F4P0wnIB11QHV2EsC6cGD8FWy90xxBC4pi4e1XXxupXELlpu3i3x1Wfut4BnPJpt9Ip
	Thk2OXs6F7FCYUN5uAierntaabO23SlRRn1CgpwftE5non91euBGJ/cfxNXzi4e4sHB2O1eKCLm
	ir4KF7wI0/QpKNMLb27/viZfWTJ/5c7Q
X-Received: by 2002:a05:6830:6289:b0:72b:9316:d596 with SMTP id 46e09a7af769-74177b255e7mr8145634a34.3.1754057778985;
        Fri, 01 Aug 2025 07:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0HREDaQfPbkGMZZI9Cdn9rppctb576Z8m/N9WTc3IgN7JerdXDwBFB53QUPtyMVn+vGbl1g==
X-Received: by 2002:a05:6214:494:b0:709:355d:6bbb with SMTP id 6a1803df08f44-709355d6d79mr522926d6.19.1754057766004;
        Fri, 01 Aug 2025 07:16:06 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca3621asm21820476d6.33.2025.08.01.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:16:05 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:15:54 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aIzMGlrR1SL5Y_Gp@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>

On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> On 31.07.25 17:44, Suren Baghdasaryan wrote:
> 
> Hi!
> 
> Did you mean in you patch description:
> 
> "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> 
> Talking about THP holes is very very confusing.
> 
> > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > encounters a non-present THP, it fails to properly recognize an unmapped
> 
> You mean a "non-present PMD that is not a migration entry".
> 
> > hole and tries to access a non-existent folio, resulting in
> > a crash. Add a check to skip non-present THPs.
> 
> That makes sense. The code we have after this patch is rather complicated
> and hard to read.
> 
> > 
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v1 [1]
> > - Fixed step size calculation, per Lokesh Gidra
> > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > 
> > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > 
> >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> >   1 file changed, 29 insertions(+), 16 deletions(-)
> > 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..b5af31c22731 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> >   		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> >   		if (ptl) {
> > -			/* Check if we can move the pmd without splitting it. */
> > -			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > -			    !pmd_none(dst_pmdval)) {
> > -				struct folio *folio = pmd_folio(*src_pmd);
> > +			if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {

[1]

> > +				/* Check if we can move the pmd without splitting it. */
> > +				if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > +				    !pmd_none(dst_pmdval)) {
> > +					if (pmd_present(*src_pmd)) {
> > +						struct folio *folio = pmd_folio(*src_pmd);
> > +
> > +						if (!folio || (!is_huge_zero_folio(folio) &&
> > +							       !PageAnonExclusive(&folio->page))) {
> > +							spin_unlock(ptl);
> > +							err = -EBUSY;
> > +							break;
> > +						}
> > +					}
> 
> ... in particular that. Is there some way to make this code simpler / easier
> to read? Like moving that whole last folio-check thingy into a helper?

One question might be relevant is, whether the check above [1] can be
dropped.

The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
before returning the ptl.  I didn't follow closely on the recent changes on
mm side on possible new pmd swap entries, if migration is the only possible
one then it looks like [1] can be avoided.

And it also looks applicable to also drop the "else" later, because in "if
(ptl)" it cannot hit pmd_none().

Thanks,

-- 
Peter Xu


