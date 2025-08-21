Return-Path: <linux-kernel+bounces-780667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADCB307E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85BEAC7F83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B49362076;
	Thu, 21 Aug 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCgTS1FU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE835334F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809384; cv=none; b=E7CdqjE1kUwWsEYGoO2j5oOijTUcdjAZ6R+bTGUX6eKQEHePS6gYHOKu9ez9niEMbmVOXoUW3ozylM673dSMEpmUMups7RnE16JZuEhOVhBMwZpOHNMhG977T3i4XFQomZUK0JUxNd3jgDpCJ8Ueu4XJ6uMFXu2SCtmdHeIpdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809384; c=relaxed/simple;
	bh=KoIUInjX6RJEpDrGgIm4Hycfp7oY5456rd0zqjDmfjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEigUssiE7usoitUWsmqX5mojIoGv/XnykPd64xXKLIfl5HMKWpnm/BrocVKlzCxcGKPiUumEOMPO4JWtxwBpv6wjA7AvUy+9M26801HApjUTyo/tyvP6hOxI/jnMCDfAV8CsO84hY9TcT8OiYIgDbzUvUHbHwSNIXPsMfGQU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCgTS1FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18307C19422
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755809384;
	bh=KoIUInjX6RJEpDrGgIm4Hycfp7oY5456rd0zqjDmfjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tCgTS1FUJED5X7BKRr1G1uHmLLdl2HxWV5HWRiudFUmEweu/0jCZzpVj982pmN3wF
	 gfbUDV19byGg11HLjIC5AfMnYxgUY0L1tgD/fSWTRJ6I3UoJsMxFBZ/fQrDHdJvTIu
	 9OWEVWE8BSh7wJSI0KcSbmH2xyGYUlRUMkKsNbxWjrs4Yysis6wjO5KQExw7xGsSoQ
	 N0h1ax18NzJuLok/Pdp+GDtqhqyFwbrJWSWluiJLAHNypBucs1ID6K25VIcRm40Yrs
	 cQwUFKd3RNpYQIthqljoUWy/M91EqpwgQCtsrrpv2cWo8VpgbTtb5tjayZvwzXJQ3P
	 EvUEBo5C56kxg==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so20665e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:49:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8o70YzaW+pgr0cSuKdOwWgG+O6yUaneZWSkK9ubjKo2a6zj6FNm5wsSsojEPwXU3c5Bm9eVWSQVfr6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOIMF2s6HH8wdKTOoIVSkInO6TpUFrY9+Z3M/vvfw/TNpagx1
	TfQ3qH0ayJq4B3+iSvoSeZCC8k3GMHgAGUh20NxVUnyl+pUPLGAmjZHKVa7zTNKBgo813mhC4Tx
	vu0jxPnAfgJOxskX5S+QRm9xy06FVmRmBu2DwRKOf
X-Google-Smtp-Source: AGHT+IHl0pS9R9FTkQgIv/5Hdf1X8d4Nj3rq1y1QABgTLUekN9baPu7Uk8DZ+Euo3lzu+Y1TgqaNMZRejMKp976OXZ4=
X-Received: by 2002:a05:600c:2d47:b0:45b:4acd:836d with SMTP id
 5b1f17b1804b1-45b52128850mr12145e9.5.1755809382698; Thu, 21 Aug 2025 13:49:42
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4yLDLvOZ2=3iVcQhu2jnbWQ+iTQsqVefJsx4_YT4bnEZg@mail.gmail.com>
 <20250821164255.78596-1-sj@kernel.org>
In-Reply-To: <20250821164255.78596-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 21 Aug 2025 13:49:31 -0700
X-Gmail-Original-Message-ID: <CAF8kJuM++mc5PjcN_bxjZjbByT7QpVdOqRQte=vGJnuQxSTVfw@mail.gmail.com>
X-Gm-Features: Ac12FXyGjYZaF6MgM88P2QEJUWcwgSvwYevAX28lXk8lha2JfaULLr54VhuGvAI
Message-ID: <CAF8kJuM++mc5PjcN_bxjZjbByT7QpVdOqRQte=vGJnuQxSTVfw@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Barry Song <21cnbao@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:43=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Thu, 21 Aug 2025 18:27:52 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> > On Thu, Aug 21, 2025 at 1:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > On Tue, Aug 19, 2025 at 6:37=E2=80=AFPM Herbert Xu <herbert@gondor.ap=
ana.org.au> wrote:
> > > >
> > > > On Wed, Aug 20, 2025 at 01:34:01PM +1200, Barry Song wrote:
> > > > >
> > > > > We might want to revisit the old thread to check whether it is no=
w safe for us
> > > > > to move to PAGE_SIZE in zswap now.
> > > >
> > > > It's perfectly safe as LZO was fixed months ago.
> > >
> > > Perfect. Then I'll revive Chengming's patch (see [1]) to reduce the
> > > compression buffer :)
> >
> > Nice!
> >
> > But perhaps we should wait until SeongJae sends a new version that
> > addresses the counter issue?
>
> Is there a reason to wait?  I was thinking those are orthogonal problems?
>
> Anyway, for the counter (crypto_compress_fail), I don't have a strong opi=
nion.
> To my understanding, the options for path forward are...
>
> 1. remove it,
> 2. keep it as is, or
> 3. keep it, but account only -EINPROGRESS[1]
>
> If I'm not missing other options, I'm tempted to the first option (remove=
 it)
> since it doesn't change any existing things, and we can revisit later.

I am fine with 1) removing it. Maybe add a log once print error on the
error code if -EINPROGRESS, just to know such extreme error has been
triggered.
>
> Please let me know if I'm missing other options or if you have other pref=
erences.

I just don't want to hide the extreme error case but I am also fine
with just removing it. It is your call.

Chris

