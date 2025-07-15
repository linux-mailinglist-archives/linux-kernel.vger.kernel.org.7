Return-Path: <linux-kernel+bounces-732583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C47B06919
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8517693F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C832C1586;
	Tue, 15 Jul 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3+eysP0"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B4233704
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617401; cv=none; b=LQRUNFJkvXVQIvvEXZ3ABcFR2OkAcV2Dqq24/Z5gihzQKwOH5oWn6aKyl0yIUqecbLpnPtQkfFTofew3oR4+7X9giptv/YJV49Dm0XfqXBD6gVYJhvZbSMPmU9hxdM8Jup0Lr28BdyKRRvw0b1eGNu790G7odpc+zsP8MZopcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617401; c=relaxed/simple;
	bh=zXOwnM5Xw664/idgeu2fr0kJa5QxFI+AYe2ku/qCW0Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j31Vyblzf46XCc5mh3m49/ixnHn7rBW1NQ7bkR2M0rJXXXygla0cyPL9DYy2c5UD2z0JCsaVanKr5pQkV36MWQ81LsJobxPfqfb20Ev9B8KHNXxNGZh/SWFv1GDd86PsuQntXocjVg0Kf2tlq0lrOWB2IVafUVDzMdYFNLO7joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3+eysP0; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8bbb02b887so904341276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752617399; x=1753222199; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj69YVPgDsBYJLwWf7UFdLjsqFVYz9hvxR1Xc0h3BfE=;
        b=r3+eysP0o/0OzJoQAtesiqAtpiMIe7XqdaTFTqJX8VzyrNiGyZ+u4OGY4Gj4qJgh1l
         CkrG0n7XAkjmi78lJ6ctXSn/ZPGWs50iYan3v3QakhrtZOFC1Sh1CHk9+2sJOyWH8RUm
         0fSotG1FqgOOGG7MSAt713DM9JYWYq5dTajbKqsA3VNLpgnt/oMuxGzBYPFd23OpBnRV
         qcK3A+S2p/QAx87kM7Hhqh8+nHPcRYENsIBs8pXEOv9gS+RQ9RjtYIWMd03nY59srPRs
         7UVDhuq9jEByymU0NfvcfjRd0pciwfXBwogjkW1XQWmyHnNjAGQzG9FdxowCh2ceFARl
         CMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617399; x=1753222199;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj69YVPgDsBYJLwWf7UFdLjsqFVYz9hvxR1Xc0h3BfE=;
        b=uLIVa16rUxiuIEBwK+VxQliUcEr4mAQECHby9GANqgVtZaqMT6RxL/7xScfZNdVvWI
         CSs2L583DaDC/r3i2vuL0CuyeTVNq1yFoRPA2R4A+RPgSWIwwmcl6lh3esKMCoVEHS2o
         oq3pxGJREWxQxqq/dDt4fKN3V6zxogl7ONiAWczfi7G+Oztyafx6BnXso5kbJ6kLg00D
         zIYv2JrEHS5R9zPyu5mtiIQ7tvOe24GDNQ9lbaKiXBkPvY+KHbLb1be5thnEGw3S9ywO
         sFBTPTMfLyyS3htIW51dXZYYSmAt0IaO0MnnwaT4I7d7BctI+sJ4UXYRLAudOdGGrow8
         rbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTd4QaKNzft0CcKFd+Fk2vbXIZswKeMUCnQNKETuNx/MdHfNHrEB8hmZt6ZNrcAB00xRKKSwkyF0nasFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55igT0IxoGuqVS1uoYBeWdDYupsZTVH1V3IULOPMtqYxVS4Rl
	eBI2xwszZVFytFqlvkFk00xfKNeQffgiWnpdhNUsGgDGJmpukdsaJuG7QWHO7bu8Ow==
X-Gm-Gg: ASbGncu4eVveiGqvKtFy8tKYV6mhoXKRxNHjML9U02vvpmK3Qap1qgKAJEb5XDpJzOa
	X//d2obyNKnlfFKplHnpWVQrekkep1SsI0ABJB2JnaxENcxZJarsjvdGaiuZ3ACakJO01pHlOBF
	w9v9Per/EbngjuVC87HjRplPuJ+RU9Mo4nOnjRzDq4agqtpvotevkD+kq4/UJUxqIBenYFzQ4PK
	N45rPagZpdcJqRmZqunhlaCfY/Hu+4kwgqdU6eaBXNqNimiZVkzWk6GkeoVgks7V7Lt7tMm/vkB
	Tk/cuQl37JeMOYNyW/scCFIZEjziyDZEdfIsyqCJttK9IojGd4Jka6EcNvkgi48miIvbMZw+//D
	w7wd49P5XHqGoQLbfHP/f7tPMPwLd+wojkSLEmSl4wm2c4K87sq9NbN3SR+/YfsFmfWGgHRbvOo
	ZqY4PHU4LlBXzX0HvPAA==
X-Google-Smtp-Source: AGHT+IFwnU432pVCd61p2LCze+MeZNWpzIDHh/J148rgvRqwhTzDwd5qLDgOAD7fjvOUL1jO7ZoLrA==
X-Received: by 2002:a05:690c:350d:b0:710:ee42:5c37 with SMTP id 00721157ae682-71835154458mr15467297b3.17.1752617398891;
        Tue, 15 Jul 2025 15:09:58 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b4ccfsm26066777b3.59.2025.07.15.15.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:09:57 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:09:40 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kairui Song <ryncsn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
    Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
    Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/8] mm/shmem, swap: simplify swapin path and result
 handling
In-Reply-To: <CAMgjq7CoFf52Wa9-6GoowFnaU0+VC6Lb+mzgjipB0nrhLeA8yQ@mail.gmail.com>
Message-ID: <7454d5b3-e8a4-29c2-ea00-435821ebfd37@google.com>
References: <20250710033706.71042-1-ryncsn@gmail.com> <20250710033706.71042-7-ryncsn@gmail.com> <57e82add-b8d5-49cb-8a3e-58c7c65768d0@linux.alibaba.com> <CAMgjq7CoFf52Wa9-6GoowFnaU0+VC6Lb+mzgjipB0nrhLeA8yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-387016046-1752617397=:11996"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-387016046-1752617397=:11996
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 11 Jul 2025, Kairui Song wrote:
> On Fri, Jul 11, 2025 at 2:23=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 2025/7/10 11:37, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Slightly tidy up the different handling of swap in and error handling
> > > for SWP_SYNCHRONOUS_IO and non-SWP_SYNCHRONOUS_IO devices. Now swapin
> > > will always use either shmem_swap_alloc_folio or shmem_swapin_cluster=
,
> > > then check the result.
> > >
> > > Simplify the control flow and avoid a redundant goto label.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> >
> > LGTM, with a nit as follows.
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >
> > > ---
> > >   mm/shmem.c | 45 +++++++++++++++++++--------------------------
> > >   1 file changed, 19 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 847e6f128485..80f5b8c73eb8 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2320,40 +2320,33 @@ static int shmem_swapin_folio(struct inode *i=
node, pgoff_t index,
> > >                       count_memcg_event_mm(fault_mm, PGMAJFAULT);
> > >               }
> > >
> > > -             /* Skip swapcache for synchronous device. */
> > >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> > > +                     /* Direct mTHP swapin skipping swap cache & rea=
dhaed */
> > >                       folio =3D shmem_swap_alloc_folio(inode, vma, in=
dex, swap, order, gfp);
> >
> > Nit: the 'mTHP' word can be confusing, since we will skip swapcache for
> > order 0 too. Please drop it.
> >
>=20
> Yes, thanks for the review.

And a few words after that 'mTHP ', I keep wincing at 'readhaed':
Andrew, you already did a fix to remove the 'mTHP ', I hope we can
also persuade you to change 'readhaed' to 'readahead' there - thanks!

Kairui, I'm a little uneasy about the way this series does arithmetic
on swap.val, in the knowledge that swp_offset(entry) involves no shift.

Perhaps I haven't noticed, but I think this is the first place to
make that assumption; and a few years ago it was not true at all -
swp_type() was down the bottom.  Usually we would do it all with
swp_entry(swp_type(x), arithmetic_on(swp_offset(x))).

But I guess, let's just agree that it's easier to read and get right
the way you have it, and make no change: if I try to "correct" you,
or demand that you change it, we shall probably just bring in bugs.

I'm particularly glad that you now avoid SWP_SYNCHRONOUS_IO readahead:
that stupidity had very much annoyed me, once I realized it.

Thanks,
Hugh
---1463770367-387016046-1752617397=:11996--

