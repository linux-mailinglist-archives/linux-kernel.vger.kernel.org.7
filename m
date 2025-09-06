Return-Path: <linux-kernel+bounces-804071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489AFB4697A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95855C48B7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF602BE65A;
	Sat,  6 Sep 2025 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg9K91R7"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F5194A44
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757140250; cv=none; b=bW88CHYZFzgHIAet+wBD2bbvSQLmDHsf8i9k/16xVNQnNkViO59AlPvaWrO1cQeRhi8eR7I8dKow1F3mU1a3QUKRa5AhrxkqHSoRQDXxUeFZoD6hO8JSjBCSKV+tkNmr2Ms1dkq6hOMcJyrZe9o/LdemWAdgGwVAPeEv5XKJ/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757140250; c=relaxed/simple;
	bh=9hgm+0YA0z6mbFwEems0niRCwk7XlVPMqnLGOikUXY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItCi0mF8CiA0r4tu2eHsl8G1E6A82ELiP4AnsFjQkH042FdjncDixjaR4QVRwR9cT8wQ1I0I/kTAHPB+fzOgGnPrNwLSJ8XT47jjLiKoKHVlXiE8sdxvoQdhPG0AjjW4Wh9b2FOcegCFJG6WHjwkQriGXBwe/y8LFYYZ4pjNTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg9K91R7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so3961630a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757140246; x=1757745046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hgm+0YA0z6mbFwEems0niRCwk7XlVPMqnLGOikUXY8=;
        b=Zg9K91R79yiV6xZfdbw1il8aPJDDv65S3oAH4GQCGUn6AX2w414OXUpqqy9RhXaDK0
         sTmBjodfLNDJS66Yroi2zCUQYJs52tNRnAHyjdX/EL+2EXYsjWJ/8REyXoVmW0ZKYw3B
         XL5DLTG3eq4qUoauIwxfUtja6/tt2tFrZzt4psDKe/yaW4Fw3jCf9gInNrWzsf3FTKm2
         ixdFKVVLLEnSJysUSDBODq/yOGut/recBTyqlLw7jRpmd3fjn4qkGlYl2XpJfo29HmnB
         94VdZJfNv6s/0XcXYKsc96fP0kdhzHNqVw2TvfPGUlJLKhc8ZG+T+oWmXExzMWSkkvj1
         fKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757140246; x=1757745046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hgm+0YA0z6mbFwEems0niRCwk7XlVPMqnLGOikUXY8=;
        b=OIJjs+iZOr4o5fxNsOKlvrwgorZwKrLmiZ1pb8bNlCTKY9mCXVmliaVWlpsNKELiOf
         qSbKmu756fR83GZtNx53GIELXs1+cZoeWM2NuECbNsidYLua6gJd2ZQzu4t/4k0HwYYE
         uh6LP9553mcV6RataCufN1S3Ws7C5HXdVSx0kZ8QEFUHIKSQHYaA07V7DozqBFaoeFXY
         cJkACZxPq5U4zx+pSpcXRAnBjYIpMoKG/j4xPeqe6eEcROFYBQ+wj6en3b7UgkkefkuJ
         wI9WQFOPZmKpC2xKe671wgS1kBRXEP1aGNcVw3MNDHpE0pu9xhCth5BuhhHoOP9Tq/uk
         jErA==
X-Forwarded-Encrypted: i=1; AJvYcCXh9j0vhYDISdIqYsV1zDb90rNLo+BpYnv45ocea4lYwTqWetQgsbh9aOh4QG6jHui+02pwlNMRn9d7FuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUh5YInts3tpgD+KpFV3tRqJvMrbrrAtpajaN4XMpNB4yQG8W
	6DB4TYT0ONjqpOrX8TFht9f0EXi2/luUaw/voT9+BAW+x8Hpc40B2i0nD/hfvS8J2b55xcg6ALR
	y8Rekgo9O77I56me9Z7N+zReDRt89Y2E=
X-Gm-Gg: ASbGncu9AWdGYkrZK07gnTXP5JTVkrbcA44aLB4oec+zvwKdtiuoEeeUzbaI013Pe1n
	I7YMplfSegUsCLpcSjf0UD8H6YieZHxLcqyBZv10idGOzge3Nk4AKtwIuHvPOAL5QyhA51/jcSP
	5kiSIiYS27zu++ZdfcIFl1GPgWd9ADB0Td1jfOhcbe6oloOuWZuLp2810O6TqBRO4dU+ssfMmce
	ert1PcYBPM=
X-Google-Smtp-Source: AGHT+IHhUnwWV/6zRC6eqYsx73YcW7log9eFIO8h0gMt9YTfpgMzF0rm5rD3hP044v+LRbf+Ll4g7zZUUItZBNI7sHE=
X-Received: by 2002:a05:6402:34d3:b0:61c:7e11:109b with SMTP id
 4fb4d7f45d1cf-62373276269mr1131671a12.9.1757140246489; Fri, 05 Sep 2025
 23:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-4-ryncsn@gmail.com>
 <CAKEwX=Ndtbsy7UoGhwcd+by6bz2gt82o6EPOkiXbqNv=uPb8wg@mail.gmail.com>
In-Reply-To: <CAKEwX=Ndtbsy7UoGhwcd+by6bz2gt82o6EPOkiXbqNv=uPb8wg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 6 Sep 2025 14:30:09 +0800
X-Gm-Features: Ac12FXzOaVsHaMPwVPiClF7_Kcrhu6nsidLKJMyyXTFAAREjhqJM8WaHCJQ3Hps
Message-ID: <CAMgjq7BTVCc0yY8PunYZnCjnuybAEZMWvJ8+89Wb_EjXnuC78g@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] mm, swap: fix swap cahe index error when
 retrying reclaim
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 7:12=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > The allocator will reclaim cached slots while scanning. Currently, it
> > will try again if the reclaim found a folio that is already removed fro=
m
> > the swap cache due to a race. But the following lookup will be using th=
e
> > wrong index. It won't cause any OOB issue since the swap cache index is
> > truncated upon lookup, but it may lead to reclaiming of an irrelevant
>
> I mean if there is a race, folio->swap could literally be anything
> right? Can the following happen: between the filemap_get_folio()
> lookup and the locking, the folio can have its swap slot freed up,
> then obtain a new swap slot, potentially from an entirely different
> swapfile (i.e different swp_type(folio->swap)).
>
> It is very unlikely, and in many setups you only have one swapfile. Still=
...

Yeah, but fortunately nothing under
the `again:` will touch the address_space, here so a random value only
causes a random lookup offset in a valid addresss_space, which is
completely fine.



>
> > folio.
> >
> > This should not cause a measurable issue, but we should fix it.
> >
> > Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cache=
")
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Yeah that's pretty nuanced lol. It is unlikely to cause any issue
> indeed - we're just occasionally swap-cache-reclaim some rando folio
> haha.
>
> Anyway, FWIW:
>
> Acked-by: Nhat Pham <nphamcs@gmail.com>

Thanks.

