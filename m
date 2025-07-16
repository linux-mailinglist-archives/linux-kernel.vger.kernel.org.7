Return-Path: <linux-kernel+bounces-733003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1484B06EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2508F566A13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9D28C01F;
	Wed, 16 Jul 2025 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS8ulBWy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0D289E03
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650098; cv=none; b=WYWKqnE5DMZZsbKI6BvPZsRAOWGZOgm3FMI6DhWAsqAQenzKymHQd5RcUX5Wx+O7YCJX5l3U/G8KIEWx4HO5IjgO5AmVm1z77a9cwBncJIpjYsbuHs1py23aDbqVJjSLdNUhpdnWSN+JAgVgzwOX0FJqr9bPn8yfJKxrBscSYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650098; c=relaxed/simple;
	bh=ofC7dqfc9DFPG3QgK0WOs3oGutxJmh62HXDeShSISsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5hfxpaeGBHEm6LXfNo/svuZugjW0jUyqDHr3LlPlntcSP9jtQeXDkiK+wdosXm/eijVR0WCy+1d3k6EgKwm6Hpnqg5v+3eQcAt9O7KBePzeDrTPQy4M3hmBZ3OwO1I8SrytOz0HVoKFmnddN2aHJrRWf8U10jRkds1xQBixG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS8ulBWy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso6867179e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650095; x=1753254895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/TskkqgAknmlMUUx/sc2CfLPBj8HFNCTNNUaHiNnrE=;
        b=TS8ulBWyrckJv3wvcMYzt0pBWiOPfHo6rtSuViOXKyuhjN4s3pdGUv9S5W7TZi3jq0
         Zm1IFJenI5qqtcnwkpuwQT+94uD3KAODX78TF4ZyIfrLtTdZq/vMIX5s1UTA8wvWELsq
         PQrBf+ngkl62rqWP7/j5oyTWDLUWqy+vboc8JYlNdnrOY438MWInkovFKFpTW/lCytKM
         Bfs9/RzI7K4BRZ8ph/UmYBoWpOQYJvTqHB8rAKvMJRC2qaZeemq/pPDFT3uFn+A6hnan
         p5ZjN65nK0TMucirGLFjZ9M9K5g/4VWNJlG6ujuS+VRjJ2g+9EPF14nSIRfnbEGm7+Sg
         RL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650095; x=1753254895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/TskkqgAknmlMUUx/sc2CfLPBj8HFNCTNNUaHiNnrE=;
        b=lWJIsey+0h+1+QAkKZQh+reX5KTboIW1TeQ+TEbvS+25uzhOnDwMQeQMCwuF5V/Fn9
         M6k2p8QPZuJvPzc/ySNik5/A3xi6Lg+onjho8CkUC3Lp/soR8LDz197lW0bhFcZ9dT9V
         P5YMEj56JZNYCOF4NfX3BTdleBC/4pjNu01cG+LKiL7SGCTk3BxzPSMpezimejxpJop/
         bj1gh9N5/YIOuYf1PD+T6pnEz5LIU3MdFkyuMvIiOAczbAPtA+ObO6+kHLunPezJwuTQ
         ndhG2PBFtcjjLixafviIPyhrt+czZ0bj7Y56dSZxQw3YpwHhlEYpVBBk28Sjiguf+30V
         pYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpEbOw3yonoFxbTWvtuPALKyv871BoXfQvp3I40NjZI2bkMIJ8bdUa4raVYW+6uHmmRB0BY8Fj1kG8ju4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uMkDlU0I4vy69oBpFL/tEu+WxDNBfOu0xJ18EhoBHvsnIOmU
	Zli++6omwhdOGUsK6JPITl4KIRg/3VsmER7oSilF9NgDy3OshhPczlqk3t7MovUiKb5exsunrrQ
	0OgEyhIMz2QLslXXbmKLpfN3g6h3Io/w=
X-Gm-Gg: ASbGncsHdiOkHwekbkz/k4BhKSGBVH11SiBDqm37Z7dZN0+b2Pm+ixK0w5u/eJBy1j3
	+dAyooOGOCztDKWzJOxGEOJN6oStwnMuZ/+VtyWYjMvA5iKW7+WSzDRb2wb9vnXQtnQkuk0/fPV
	6Rwve/MTIXcrUExaNphAkMv4n0sCU3RD5KHzvko1/M7YKgliweRaB2CEChZj1K0m6m8pM6lwMMO
	hxYrt4=
X-Google-Smtp-Source: AGHT+IE10OfJxxq0wMgT/q6inJbMeGnFb6O/fdLgd9emra6LAIDXacfuGpylhnN7yvgi7/OpTqFIOaP6C6WqelkphNM=
X-Received: by 2002:a2e:b8cf:0:b0:32c:a006:2a36 with SMTP id
 38308e7fff4ca-3308f5c6b99mr4581721fa.20.1752650094463; Wed, 16 Jul 2025
 00:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710033706.71042-1-ryncsn@gmail.com> <20250710033706.71042-7-ryncsn@gmail.com>
 <57e82add-b8d5-49cb-8a3e-58c7c65768d0@linux.alibaba.com> <CAMgjq7CoFf52Wa9-6GoowFnaU0+VC6Lb+mzgjipB0nrhLeA8yQ@mail.gmail.com>
 <7454d5b3-e8a4-29c2-ea00-435821ebfd37@google.com>
In-Reply-To: <7454d5b3-e8a4-29c2-ea00-435821ebfd37@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 16 Jul 2025 15:14:17 +0800
X-Gm-Features: Ac12FXwhNHAkGIzUr7aHpF-30otPMcr6GxMfvF6LW6zD8vDq5BNGf6-ioRiGg0Q
Message-ID: <CAMgjq7A=URzunJD2APwtw=B41zB5JGKUuvOhLDxLrZCS6N_paw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] mm/shmem, swap: simplify swapin path and result handling
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:10=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Fri, 11 Jul 2025, Kairui Song wrote:
> > On Fri, Jul 11, 2025 at 2:23=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> > >
> > >
> > >
> > > On 2025/7/10 11:37, Kairui Song wrote:
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > Slightly tidy up the different handling of swap in and error handli=
ng
> > > > for SWP_SYNCHRONOUS_IO and non-SWP_SYNCHRONOUS_IO devices. Now swap=
in
> > > > will always use either shmem_swap_alloc_folio or shmem_swapin_clust=
er,
> > > > then check the result.
> > > >
> > > > Simplify the control flow and avoid a redundant goto label.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > >
> > > LGTM, with a nit as follows.
> > > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > >
> > > > ---
> > > >   mm/shmem.c | 45 +++++++++++++++++++--------------------------
> > > >   1 file changed, 19 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index 847e6f128485..80f5b8c73eb8 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -2320,40 +2320,33 @@ static int shmem_swapin_folio(struct inode =
*inode, pgoff_t index,
> > > >                       count_memcg_event_mm(fault_mm, PGMAJFAULT);
> > > >               }
> > > >
> > > > -             /* Skip swapcache for synchronous device. */
> > > >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> > > > +                     /* Direct mTHP swapin skipping swap cache & r=
eadhaed */
> > > >                       folio =3D shmem_swap_alloc_folio(inode, vma, =
index, swap, order, gfp);
> > >
> > > Nit: the 'mTHP' word can be confusing, since we will skip swapcache f=
or
> > > order 0 too. Please drop it.
> > >
> >
> > Yes, thanks for the review.
>
> And a few words after that 'mTHP ', I keep wincing at 'readhaed':
> Andrew, you already did a fix to remove the 'mTHP ', I hope we can
> also persuade you to change 'readhaed' to 'readahead' there - thanks!
>
> Kairui, I'm a little uneasy about the way this series does arithmetic
> on swap.val, in the knowledge that swp_offset(entry) involves no shift.
>
> Perhaps I haven't noticed, but I think this is the first place to
> make that assumption; and a few years ago it was not true at all -
> swp_type() was down the bottom.  Usually we would do it all with
> swp_entry(swp_type(x), arithmetic_on(swp_offset(x))).
>
> But I guess, let's just agree that it's easier to read and get right
> the way you have it, and make no change: if I try to "correct" you,
> or demand that you change it, we shall probably just bring in bugs.

Thanks!

I think maybe we can introduce some helpers for things like rounding
the swap entry later, we already have other similar helpers for swap
entries.

There was already same arithmetics in memoy.c some time ago, and I
remember seeing people doing this several times. Current swap values
are OK with this, will be easier to track with a helper.


> I'm particularly glad that you now avoid SWP_SYNCHRONOUS_IO readahead:
> that stupidity had very much annoyed me, once I realized it.
>
> Thanks,
> Hugh

