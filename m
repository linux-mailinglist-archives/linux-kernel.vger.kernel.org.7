Return-Path: <linux-kernel+bounces-790515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7943B3A98E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C3E7A61B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A7262FD4;
	Thu, 28 Aug 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1DHj3Jq"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184C257423
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404361; cv=none; b=JT3JHW4UJ7Usx0pj+fYuLriR8q9uUqOQyelF7Ea9MI6B/r9Bi/5WBGvhY/s/9M2hqhFL0TJDZcjh4iOVylBTEoiZhKGkMRZaWrV30qNwLgCOtgEoSkx+oxA+JW2fATiyUZ14Ju1QD59nN3n0t1edCKmVCJ4Mb8iung14IgCqviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404361; c=relaxed/simple;
	bh=f1DTY6+ZxoHrzYNzfN2MR1BGeXu9xSEJI2tXuDtECSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9ZcZjOqodmdfueqHCbf//7lzNengJdJfklD4EbxnYM0WFtXIxL2Dhu0/MPdkIR9+SKJZr46qrjUX1QVfOFfttVLU+Wval6FDqaTXZj23xpA9+XW9OLnhTPw3oHkV+y52YAaH8jP4GHY0ynY031GdKsVvUNliPtw1C9RRT1Go9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1DHj3Jq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f901b2d2so10649381fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756404358; x=1757009158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1wcerDY9ZxMErqt5APhVLmL7gKLDhYWEmpEHHKGi0g=;
        b=K1DHj3Jqp39NZzN10DLB2ZmIkhCuhJKWiUWGJ/I9NPaiKj6vUR65PELRsAgRnrK+X3
         a9b5NuxuQnyxeM1Xc4qx42QKsvpbxhZMQPyyz4zg4ap7zkp+k0lsA6WLvUs19WRQ2CZf
         t010V/xhNeo/flpB/8gxiqEcFXI91RqBBRUrLBVNaVMrcy48hIi7sYpZ+SEtLjaI3Eym
         iwhHSudYSWKz8i46oEpBXDqxZ3yJGywV+vdHe4m4r4x94O0u+I4Usz3dI5kZocaxw+1H
         DefXTu4oaWz0tneX2UmaVD4XIXz3e3nVSyRx3rcron3aY6AhE/lKbBsa43yr/5OKljRO
         4g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756404358; x=1757009158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1wcerDY9ZxMErqt5APhVLmL7gKLDhYWEmpEHHKGi0g=;
        b=OCkDhp02fSjp2MTFK6ste+Heu96QCljEG/adIvhbodhHeevoixSE1XBucQgTv7cg/S
         sIyTv4UD1Z0l1UGMl1rzWFJlnkFIGGcigiUXnN6LkFSpEybSFpEwaGkijsVBNaXycWiz
         /iMJ5JLpbLTxfpr9zRWOcd0CXNmQ9d652SF4m1hQGoMpxjEM3aMHWB79YANKOOgMWNl7
         pQpFD0H2IguBb+gMM+B6zxFHjZjvhgmjAtGKm5AEq9jlRJRDiEbSvxM7lFDP8jSbNHlZ
         M3DlmWhM34oqIduwljfC2vD2fOq7dJBG7uuabfJnO5GVqNNe1gFqY3I6jQZS8Dt6YLlu
         u3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsUV2KiyS3I41VnmPRJiapHwd3obtX4juffUvvw68HotrOrZzSgjcJSeHZrkAVh9+xS/lfclakwChTaGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHAU25w9XDWMdqi8RzQWkHTCVX9ZPgPXwFMlhYVDbq4JuQlIA
	p9TC0utGl33CvpCKgxX3iotEl6365lihaddibQL8PO3XGtkcuusNlG9w3Evy7QJzARL0Em0WziI
	6dR1jLQxcmOfZsL+QlMUK5/QSn5u6hEc=
X-Gm-Gg: ASbGncu4l3Ap6TXoVgQCZJjWg+kIZqgJj7TZYsSL032dxvsyZQuKZ8vRwnMrXkcLE0n
	AUSb/6DnXK9KfBvYHN6clZ15Xa3G9pyqe4wXBt7ScVwX35Taux20Ta9LZUJ/HBMzViocnuODAef
	mnnFRbsNIR1qw/5sSengujocMCfjMTbaUlZjGt90wfY8Mw+CInJv0bmtjSQNc50fAeHTlyz7MCH
	IPPiy88
X-Google-Smtp-Source: AGHT+IGB6TrFNT4SQJTwC8ZhmYP+oI3RCBH1w0gudce3W73CXC0aZ0kpMuhoSB7evC/LMmmDi5YOkrTutjtvnvf6RJ8=
X-Received: by 2002:a05:651c:20cc:20b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-33650faa9c1mr49163651fa.32.1756404357298; Thu, 28 Aug 2025
 11:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
 <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com> <c12b9236-903f-4a8f-aa9e-fd4d9ca1bffd@linux.alibaba.com>
In-Reply-To: <c12b9236-903f-4a8f-aa9e-fd4d9ca1bffd@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 29 Aug 2025 02:05:19 +0800
X-Gm-Features: Ac12FXyG4DY_-h7AMdrWx7jUmFgnl0-nMz4w3-tUx0Uy-hQLA-KPFCjc3BR-vIo
Message-ID: <CAMgjq7CRWeozoMbkJV43B+06UjakJw6bc0Wn1=2ai=E70=WE3Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:41=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/8/27 22:35, Kairui Song wrote:
> > On Wed, Aug 27, 2025 at 4:21=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> >>
> >> On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com=
> wrote:
> >>
> >>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>> index e9d0d2784cd5..b4d39f2a1e0a 100644
> >>> --- a/mm/shmem.c
> >>> +++ b/mm/shmem.c
> >>> @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >>>                          count_vm_event(PGMAJFAULT);
> >>>                          count_memcg_event_mm(fault_mm, PGMAJFAULT);
> >>>                  }
> >>> -       } else {
> >>> -               swap_update_readahead(folio, NULL, 0);
> >>
> >> Also this update readahead move to later might have a similar problem.
> >> All the bail out in the move will lose the readahead status update.
> >>
> >> The readahead deed is already done. Missing the status update seems
> >> incorrect.
> >
> > Thanks for the detailed review.
> >
> > The only change I wanted here is that swap readahead update should be
> > done after checking the folio still corresponds to the swap entry
> > triggering the swapin. That should have slight to none effect compared
> > to before considering the extremely tiny time window. We are only
> > following the convention more strictly.
> >
> > In theory it might even help to reduce false updates: if the folio no
> > longer corresponds to the swap entry, we are hitting an unrelated
> > folio, doing a readahead update will either mislead vma readahead's
> > address hint, or could clean up the readahead flag of an unrelated
> > folio without actually using it. If the folio does get hit in the
> > future, due to the missing readahead flag, the statistic will go
> > wrong.
>
> Yes, that=E2=80=99s what I thought as well.
>
> By the way, can we do it right all at once in patch 1 (I mean the shmem
> changes)?

Hi Baolin,

Yeah it's OK to do so but it's kind of a very slight behaviour change.
Currently patch 1 has zero behaviour change, so maybe just leave it in
this patch where we sanitize all swap cache conventions all at once.

