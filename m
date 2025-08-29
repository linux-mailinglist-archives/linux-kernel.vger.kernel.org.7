Return-Path: <linux-kernel+bounces-791166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD5DB3B2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CEE987CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6131D8A10;
	Fri, 29 Aug 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flugKghJ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5A1A5B8D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447174; cv=none; b=ppkGdPYYZ6chmWuEyK2JUJklHFzzGyj9QkyKjuyG0KqkvNz2aBKOYB5mRi2HJCYvdGLld5ECPVpZgu9zqeljpROpsjVkCqO/ruo4rb5TJVKhQfQOtvvficJZcYwsBQLmWLuHbePHG+A/Z3Lbr5TZ5sjQ7Go88NpcvErfELx+uyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447174; c=relaxed/simple;
	bh=HQHfXVXKCqm565Dn42Z59+LNgV1U4UlkiCvPgaZSeQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpZfsTMiS8dg63HWb58pembKBk+HsFxyU418EoPDK0D/7YWf3sF3wdJEFV4b7zuu3YiAnfMNVs7Xin6JlBekNkVe6aQeJnRBorlXQxeUBGw87enXUjyocxnKoNn6nd4QG60AOosvXtbItZuyVLyttD235oz5rrGcAgscL9i3Ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flugKghJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-336630769a6so16429061fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756447171; x=1757051971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9b89mWcH1WRoi8NB6LCKkiGizr7phQg5j8xmHQXvrc=;
        b=flugKghJYfGrHrmWu5n6xDWoYY4uL0G/5bmZOOtwiqKdHk+Kb6vfw428PSR60W91Z1
         xXFqqG3HScK+ibXsuKTmfjGCNPu/a7edeGERKa4Dz3QGIv5u5Nj1muqxW/uBO8zmA7JS
         vaxBY5uetsyvTpmIbeDIx5g/z/r2DkOlXf4m5kSLSYGiR+Uv3W6x6+tUy4+25SjwTVz3
         iQGNrVgnTTnoi2x2PJSG6HPasEKrYM6AVTQTTGiQU+Pv4xjTjPOfXLK+8LGGDDLp5+E4
         U+TICFsJ0fO7AsDtgRNRmpGrHbRMy7Rw0rzPyjT+/MMUjYLtW54pUO2bujM827yvqrAM
         qxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756447171; x=1757051971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9b89mWcH1WRoi8NB6LCKkiGizr7phQg5j8xmHQXvrc=;
        b=P9d0NkYvNMl9kgb9BVJUeDpgJ5wqOift2GTT9W96cJa7C5/yjlsTgXkoFbjlc21Aq3
         SamHIrYDy+HfQtZW/TQIKCABzrFkdQ0P4oYYhwNcvdwtlo0uUVTsn4h4o5V73PLw09lb
         FeI/ysn4JKqKuqTXsRBRmxc/a8h6Kjxdm3iMvWhNxSvCTpwoEfm7pQNRhGn1mqxPDwcW
         rtOOLCnlH7wBQ+o/i+9fqUhFc3pgT0U2mX39nVx6icibda+WKWwqeawDz9KhWunTsAiD
         gB/PfFvJk+NgXQUhwEXNYYYAjiXVOA3vOPLOmJQQDY1xjG6EY6ORfqCUR8gSSlvRtKqM
         +Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCWAxwRcF9VWq8oQnpMXOH0EGUY38COsdctJa0mLdKWfpCy5vrCgFwbTELhg0MC16CymAW9CQcadvHkw7aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8iqcU09pfSc4TMXNhs23QRtBDtnR0LWYSFi7WscY/ubB1Dt/
	OfTzmpkS+yFh9DJlHXK9x4DMSDVGrQr/+EY4vZHthLdVDw38MrLhZNKWylwpCXewpJ+29Gwwjsl
	4tsg46VpLJpRSEe0IXKW9L8yCbpr2v5rA/6OkByGR
X-Gm-Gg: ASbGnct90nqxy6QmOIbpjK+Rt5VzXS8Adh84T3Fdc8gVpV/to0wTm6OQh2020oXtuo6
	noQfPCx931LrhQl7BnGHD68pi3NVgVcfj8Zf1RUDPXXbTTox4PG+WWXP4zoZgnYamoTe8dVce8b
	jyS5Hrgt2PSuLQ62NaC52dSGv/ZT9Xx6bXiTyBnmYgxIRafnFUnYcWqNCnKpAzPNN7EFSbjc4+p
	/u2E8vZEiLdd8+pv3j6D9CGO6X+vfHpbLX/fFYHsslUlODq9zK8mYC8mw==
X-Google-Smtp-Source: AGHT+IGpsSHWaCkR84qNI3V45LpCTM6KTwnsCQMP483IEziQLGCDzdNJpFNTpDClHjL7Rp31C5D88TK18RjtyhkTPDc=
X-Received: by 2002:a05:651c:1118:10b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-33650ea0b23mr53475191fa.13.1756447171269; Thu, 28 Aug 2025
 22:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKYEpf7xp3NnkBWm@x1> <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
 <aKv_FjtkPIR86inu@google.com>
In-Reply-To: <aKv_FjtkPIR86inu@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 29 Aug 2025 07:59:19 +0200
X-Gm-Features: Ac12FXzOVh7BPaHMQclLjPZcl1R6uL53TzQPya8c8MkZgMLcA8AbQsulHRMdbNg
Message-ID: <CACT4Y+ZxqgqAGoSgUaVKk6_=h1dO7iV8qrVHDOrmbBS3VW8-=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 08:13, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Wed, Aug 20, 2025 at 06:14:08PM -0700, Dmitry Vyukov wrote:
> > On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
> > >
> > > Not combining entries in 'perf top', so we're getting multiple lines for
> > > the same symbol, with the same address.
> > >
> > > To test it, simply run 'perf top', then do /acpi to see just symbols
> > > starting with acpi_ and notice that there are various lines with the
> > > same symbol, press V to see the address and its the same.
> >
> > With this revert, does it show 1 entry but with a wrong percent?
> > I am not sure why there are 2 entries for the same symbol, but if we
> > merge them, we can sum of percents. Is it the right thing to do?
>
> I don't think it'd have a wrong percent.  The hists maintain stats for
> filtered entries separately.

I still don't fully follow.

If we merge a filtered entry into non-filtered entry (with the
revert), now we attribute what was filtered out to the non-filtered
entry, and the non-filtered entry has wrong overhead, no?

If we merge the other way around: non-filtered entry into filtered
entry, then we won't show it at all.

> Based on the position of filtered entries in the RB tree, I think it
> might not merge correct samples together and create multiple entries
> with the same info.

The second thing I don't understand: without this revert we don't
merge filtered and non-filtered entries, top shows duplicate entries,
does it mean it shows filtered out entries? This also looks wrong...

> Filtering by unused sort keys would be undefined.  We probably want to
> warn users instead.

Do you mean that the filtered=1 is set incorrectly in this case?
Do you mean that with this revert 2 bugs just compensate each other by
luck: we wrongly set filtered=1, and then wrongly merge them together,
so it all works out in the end?

