Return-Path: <linux-kernel+bounces-793797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF49B3D856
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D4D1897EE6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D178221F06;
	Mon,  1 Sep 2025 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krMcKNxq"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91CB663
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756702104; cv=none; b=QuZfG41i0yfzf7/UJHv3sTpowx3h30HHWjtpSxTSXKMPNCtqGf0TVpLGmWVD2SOpidohwc+ckJwKZEL7/yV6PsAJ/3XoBLHjomXDZCKPxrBrw5DWuEnJ7J+afCq20Nqssh+uDUMLPFxsFw1Yayaq2EbfO/TywEY3i++3Q8LpJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756702104; c=relaxed/simple;
	bh=Ejc4+7iVLBfIxb688IRQFK/gGqFypFduC5exOq4cvps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3ivSbDPNz64jbAbuC129/MG2BGlgCbqGEm5aYeq9pDwf5gomQeRZqXzM5JK60/HZJIxxK23zdq0gsZP1YAdjn9IFjTf+xX6C97RRdUjQpzphB9H5sn0ihjWVrvBK34chYp4STVKXGnh20xeFcNjuGUOb+QvpR3D4TK2su21qxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krMcKNxq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-336ce4a8bfcso9022021fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 21:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756702101; x=1757306901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ItfuYm2JQE614/6hjW72JToirycttAJPocJVdLgsVk=;
        b=krMcKNxqDW8ZxWUTSP2iGYfwfx5IZZNLTmpOVPI/4gXTKUlfx24BUOUEtfUxHGqTPz
         eVxagcXBvbkfJb2VPzXblvBvkRnDeCx6KULJ0py/3XaQ76rEy+k3ucqz+/q2pA1H3Un3
         1DkC6QJG9xyIq2mtJiccoCe7na3Cr+3SjnvNqIbcbyPDr4mlmDvyzVbgS0abCSEOlm43
         +zuuo0yWbQxNH60RfBZW+hXesd3HDD1fW+ukWI4sLdvp4cuIays3QbsdODQtspH7CpG+
         wj5t6XQrZDkLW9LbvNOgJ08vlml6XkqkpJ0RK71zgFHtU9TunFWtuyjSIBJWUGav0b/M
         pj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756702101; x=1757306901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ItfuYm2JQE614/6hjW72JToirycttAJPocJVdLgsVk=;
        b=frEMonPag0qSGMGgj8viR3mdHLpvJ8z+aiHXe4nC46uyJVy5tT86EqhpQddbNPuHb3
         XaGV1X+2AyxGFHXtBr8V0YpakdTs0YuIC98dlTFX6L0lpahRHzmTZpV/bEDDnT+9Rypx
         Rh7FUc408QE40HDVcxrjeVgYR7r88LXP4gRRw4GRRJILleVpd1MTZ9mTivgQ/HKuBgWe
         0YLLEAW4BlMD9BbDgp2t00iMCNcrqzSycD/xR5Pwu0KFui7RP4fzEseHlfiCD0HzB65I
         NG5993cQYzW4QjM83GEkjdhrsRTsbMwSJXJd+6LXHhjW+W1/45jhJgMTMtZRElC6HTba
         lpLg==
X-Forwarded-Encrypted: i=1; AJvYcCW7aX8Of2aRsJL4xPWhqOXLNMSTScCHQoU2Pq+/I9st55MjIkgeaH/nfIOXKZocUBwFyDvlgJInZxu04f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJXz7NAnBabZJsQBcs21l4cOi8n+EY61aUNqd+TNl7PuKm7YD
	rtZPz4+7vSSGJ9ZUVvDr0zQQpn4bBBaJ/LZs2sszKLCRuNSIcsY7jdOCl1C3wViurrjSzkntajK
	Z/fLk19Gaivw41yJgkmP6ns0WRxSW30ttnGedMPdlyBUCJfbi29quo9G4GAg=
X-Gm-Gg: ASbGncss+EeIMUOjWeWBWYQM30B685F7oCyJl7V6d7LtSd8xbrG5eDSLdbBLk9dHMA7
	8eH1Y1VJ0BLusxLGm3aBdQwcDF11yyvdd6xztIUHAxOhPpM0lPcUrWmJ0tHjWsKeF5CgneNXtd0
	XI+kLfQVZvHkYe9f2J5HQry9g/T6ubMMt+jJPJlWVmSHZtDUo2TGuuM1FWuH2WYiQuHCpykEe1N
	gQY8ukKUgghq3HuUw+NKGgBdu/3QzMi5HSlvEt/m1aY0oo=
X-Google-Smtp-Source: AGHT+IFdVUm+IoSF5Ct2TjYReBuRJ5hJNZUnNPK52+RP3kfFx6ElqS+ay4cBA+GA6UXZvTAib3EGqIhBO4FaPoqfj/o=
X-Received: by 2002:a05:651c:1119:b0:336:bb9c:d392 with SMTP id
 38308e7fff4ca-336ca90366fmr12113891fa.9.1756702100852; Sun, 31 Aug 2025
 21:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKYEpf7xp3NnkBWm@x1> <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
 <aKv_FjtkPIR86inu@google.com> <CACT4Y+ZxqgqAGoSgUaVKk6_=h1dO7iV8qrVHDOrmbBS3VW8-=g@mail.gmail.com>
 <aLIixyZOYD3ZE1gh@google.com>
In-Reply-To: <aLIixyZOYD3ZE1gh@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 1 Sep 2025 06:48:07 +0200
X-Gm-Features: Ac12FXya7MQwBjrNruhkQ3vsTZRyqYy763Za_j014hNowF001C1ZrX2GHvqM1kw
Message-ID: <CACT4Y+aeSN3LuejBEmcse7MLnanvv6L02=SKNd_yBkm72iAO1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 23:59, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Aug 29, 2025 at 07:59:19AM +0200, Dmitry Vyukov wrote:
> > On Mon, 25 Aug 2025 at 08:13, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Aug 20, 2025 at 06:14:08PM -0700, Dmitry Vyukov wrote:
> > > > On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > >
> > > > > This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
> > > > >
> > > > > Not combining entries in 'perf top', so we're getting multiple lines for
> > > > > the same symbol, with the same address.
> > > > >
> > > > > To test it, simply run 'perf top', then do /acpi to see just symbols
> > > > > starting with acpi_ and notice that there are various lines with the
> > > > > same symbol, press V to see the address and its the same.
> > > >
> > > > With this revert, does it show 1 entry but with a wrong percent?
> > > > I am not sure why there are 2 entries for the same symbol, but if we
> > > > merge them, we can sum of percents. Is it the right thing to do?
> > >
> > > I don't think it'd have a wrong percent.  The hists maintain stats for
> > > filtered entries separately.
> >
> > I still don't fully follow.
> >
> > If we merge a filtered entry into non-filtered entry (with the
> > revert), now we attribute what was filtered out to the non-filtered
> > entry, and the non-filtered entry has wrong overhead, no?
>
> Oh, my bad.  I thought we track both periods in the hist_entry, but it
> seems it's only in the hists for total.
>
> >
> > If we merge the other way around: non-filtered entry into filtered
> > entry, then we won't show it at all.
> >
> > > Based on the position of filtered entries in the RB tree, I think it
> > > might not merge correct samples together and create multiple entries
> > > with the same info.
> >
> > The second thing I don't understand: without this revert we don't
> > merge filtered and non-filtered entries, top shows duplicate entries,
> > does it mean it shows filtered out entries? This also looks wrong...
>
> I checked those duplicated entries all non-filtered (filtered = 0).
> I suspect an entry can miss existing one (to be merged) when it sees
> unrelated filtered entries in the middle of RB tree traversal.

Does it mean that the sorting and merging predicates somehow end up
being different, while the assumption is that they should be the same?

Will it help if filtered field is checked as the last condition,
rather than the first? Then I assume unrelated entries should still be
compared as they were before.

> > > Filtering by unused sort keys would be undefined.  We probably want to
> > > warn users instead.
> >
> > Do you mean that the filtered=1 is set incorrectly in this case?
> > Do you mean that with this revert 2 bugs just compensate each other by
> > luck: we wrongly set filtered=1, and then wrongly merge them together,
> > so it all works out in the end?
>
> I mean you should not allow users to use filters not listed in the sort
> keys.  For example, `perf report -s comm --tid=123` would return error.
> They can use `perf report -s tid` or `perf report -s comm,tid -H`.

Is it the root cause of the reported duplicate entries, or is it a
separate issue?
Arnaldo said to use just 'perf top' w/o any flags, so I am not sure if
this is related or not.

