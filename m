Return-Path: <linux-kernel+bounces-758216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1EB1CC9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3198A5667FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3718FC92;
	Wed,  6 Aug 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTDIEhXe"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C101FBCB5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509776; cv=none; b=M8J7P14/odZg6ATzPYJnVnx1i8c8IcbaY36yGX95EIPDLjavm1Up/kHuxaobMIa7L4mozrxyHuG3yrFRGowlocbX/SWIDpuSoclTtzxvL0fUt+ZgGWblDNPix/7uJmXknLR/ugwM92t0zQDm/zp0+2rSktqMNaQfFc+aWHfF6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509776; c=relaxed/simple;
	bh=GfCriFzxRrWEtaC+Am2QR0otEdYtr8VGmprO/3rEIdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivEPa3jiW8/z5jZ9uT2dH/6lVtZsodB28060Le7mLTKgszzN0pm5n6mq73AmARKSohM9Cpr7tmwNcLFU/Jfj4MKwsoWOt8WWq8u94KCZxh8o7nKjw64uqr0QTEJj5DRykElIiVWL222NlR/9pFbYlWXvwv5L4QUDClAqiICVPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTDIEhXe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso518910a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754509772; x=1755114572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzyWsZ2VS7UdwxNHeGlEc8995qxMO9wJq8rXT5/QHs0=;
        b=OTDIEhXe7X5LVlOaVkz0tgWQ7HiK2h/nka0cCmFSQ5B56x0GBcYYPiG9/o2Zks4bE9
         Z9nlO/KOhtQL3cifGg6PIZlpzwKaVWWepono1uA2USWUWAviHgRR35ggJTeaKVMARfZh
         lSMuCFHnUfQlpZvntMQ+1sH+iov9Ck7oVKNGa1PV/Zm0d6d+O0hayFeSKpIUnTfw8TGL
         AI/jKFHZBGYCzP0MgieXPZLIxCFRJSkvhY8wHuljNKCfumSIYX6t26ZBR4iQ2i98Ektd
         QUxM3jqSDdo0/WbQ1pdc9dWKEFLdXvmc1mzUt9bLPFKT57CNO6bwo3ZBliX1sYBrUiXm
         e6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754509772; x=1755114572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzyWsZ2VS7UdwxNHeGlEc8995qxMO9wJq8rXT5/QHs0=;
        b=IrWmUkFJs0BPnPEF4+6bb0hOUgD6qst3j3Q0Egaxf6oVOqcht3RYB6vWO32QCKTZUz
         TwPGy0Cl+gRSrW+L4ZTacL8imnoR8pOKvvvIzXOO4oqI5hQTj0ZWlCxYLu8U4jDJEc3t
         3LCl8cIw0BNmhPWWjWCA0XSURXPrLxXFZ/ghH0YsjbAxdo/a3mh6n6NxjSBBIZD35Re+
         Fz+XQnChIbz+DbZW/9iTRjhs/2OUVaGK3nJJ/1/mEBCEQRVd1vHgl+o9FfusGmwX0ecI
         zj4ypOGDjJaxNpQ1ctmiM7fOFPvt7MUcgJJjcMNl/qbrmnvzgemRsNvigenqwls5Z3T8
         swtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI3tSetTPoy0ZDLUUPnEBCbUiZQywNso+JiqUFTmE2R7jX8fFoD6QB0z5qVfBcfzuBjOe7P+w5SRrsIew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHz1vidWEW/VAUs3G8AfCA2r0ihDgORPu9UV3gpMT2VdhsW+q
	GBs4jFNCSKKb1WUPMHJlXKY7FTRaFHejmRgjIO5VYIKujsLcZFlA6fr3y6BDMCaXmLocq1lh1Sl
	aGyuDciGcXKSXrk3WQTLrCukVoMDiWMI=
X-Gm-Gg: ASbGncsgTja5Pmm20NN4p1+3lSpCVzNMOVzNRKV6n6Om92KHJG+3XX6ymwi4VdgyQLg
	O0JQiPn4+e4TLIGcPnGL47AqpRcu723bF1NL9CxVBpm9P3Ho1E0jyZDKufU5ZFMV37Pc53v3eer
	aKCvDIhfhONXsejDMrvo0+2GXUb4iwhEhJuLKnp111g9YdrHXNZHvpFAAZlAWE2Y0mPX/ZSHmnR
	lSrZzcv3jJ8hfxo1NaKjV3BAKIWzWTzlNIzGSUQ
X-Google-Smtp-Source: AGHT+IHukw8BGGSuW8sM5wvXX1qfAZ4M93eqA3YKb60zFiqlp++MkcgH8j5+d0SXTAfe/GHRE+5PKfydrhljxI3QUEY=
X-Received: by 2002:a17:907:3c89:b0:af9:3c4d:e978 with SMTP id
 a640c23a62f3a-af992bcfc70mr330720966b.41.1754509771931; Wed, 06 Aug 2025
 12:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806164316.5728-1-bijan311@gmail.com> <20250806190911.49728-1-sj@kernel.org>
In-Reply-To: <20250806190911.49728-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Wed, 6 Aug 2025 14:49:21 -0500
X-Gm-Features: Ac12FXzxEB8wSXoRu-3qE9z6QIyTH6H8gAezWdHjpR1Yn4gq7IihQeGGFcbaJHQ
Message-ID: <CAMvvPS7Anh4qZu-VewZ61_QqfU9PDCaUpGjxZWeCdioTWkr5vA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: skip needless update of next_{aggregation,ops_update}_sis
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:09=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Bijan,
>
> On Wed,  6 Aug 2025 11:43:16 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > In damon_set_attrs(), ctx->next_{aggregation,ops_update}_sis would be
> > reset, even if the sample interval, aggregation interval, or ops update
> > interval were not changed. If damon_set_attrs() is called relatively
> > frequently, such as by frequent "commit" operations, aggregation and op=
s
> > update operations could be needlessly delayed.
> >
> > This patch avoids this by only updating next_{aggregation,ops_update}_s=
is
> > if the relevant intervals were changed.
> >
> > Cc: Bijan Tabatabai <bijan311@gmail.com>
> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> > ---
> > This patch came from discussions in [1].
> >
> > [1] https://lore.kernel.org/all/20250805162022.4920-1-bijan311@gmail.co=
m/
>
> Thank you for sending this patch as we discussed on the thread!
>
> > ---
> >  mm/damon/core.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 6a2fe1f2c952..1c3d8b92257c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -693,6 +693,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct =
damon_attrs *attrs)
> >       unsigned long sample_interval =3D attrs->sample_interval ?
> >               attrs->sample_interval : 1;
> >       struct damos *s;
> > +     bool sample_interval_changed =3D ctx->attrs.sample_interval !=3D
> > +             attrs->sample_interval;
> > +     bool aggr_interval_changed =3D ctx->attrs.aggr_interval !=3D
> > +             attrs->aggr_interval;
> > +     bool ops_update_interval_changed =3D ctx->attrs.ops_update_interv=
al !=3D
> > +             attrs->ops_update_interval;
> >       bool aggregating =3D ctx->passed_sample_intervals <
> >               ctx->next_aggregation_sis;
> >
> > @@ -710,10 +716,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct=
 damon_attrs *attrs)
> >       if (!attrs->aggr_samples)
> >               attrs->aggr_samples =3D attrs->aggr_interval / sample_int=
erval;
> >
> > -     ctx->next_aggregation_sis =3D ctx->passed_sample_intervals +
> > -             attrs->aggr_interval / sample_interval;
> > -     ctx->next_ops_update_sis =3D ctx->passed_sample_intervals +
> > -             attrs->ops_update_interval / sample_interval;
> > +     if (sample_interval_changed || aggr_interval_changed)
> > +             ctx->next_aggregation_sis =3D ctx->passed_sample_interval=
s +
> > +                     attrs->aggr_interval / sample_interval;
> > +     if (sample_interval_changed || ops_update_interval_changed)
> > +             ctx->next_ops_update_sis =3D ctx->passed_sample_intervals=
 +
> > +                     attrs->ops_update_interval / sample_interval;
> >
> >       damon_update_monitoring_results(ctx, attrs, aggregating);
> >       ctx->attrs =3D *attrs;
>
> Long story short, this (original) code is bit complicated and hence I sug=
gest
> to make this change less optimum but simpler.
>
> damon_update_monitoring_results() assumes it is called only just after
> next_{aggr,ops_update}_sis are  updated.  And the assumption is important=
 for
> the pseudo-moving-sum access frequency maintenance.  As a result, this ca=
n make
> the monitoring results temporarily corrupted, and splat warning once.  Pl=
ease
> refer to commit 591c4c78be063 ("mm/damon/core: warn and fix nr_accesses[_=
bp]
> corruption") or the patch thread[1] if you want more details.
>
> Also damon_set_attrs() is called not only from commit situation.  So I th=
ink
> this maybe not an ideal part to modify.
>
> What about modifying damon_commit_ctx() to check if new and old
> damon_ctx->attrs are entirely same, and skip calling damon_set_attrs() in=
 the
> case?  Doing the entire damon_attrs comparison might be suboptimum, but w=
ould
> make the change simpler.  I assume the suboptimum comparison is not a rea=
l
> problem for your use case, so I think that could be a good tradeoff?

I can definitely do this. Checking a few extra fields is no big deal.

Silly question, but think it's best to get it out of the way before
sending another patch: do you think there's a more elegant way of just
having a dumb comparison function like

bool damon_attrs_equal(struct damon_attrs *a, struct damon_attrs *b)
{
        return a->sample_interval =3D=3D b->sample_interval &&
            a->aggr_interval =3D=3D b->aggr_interval &&
            ...
}

And I assume I shouldn't compare the aggr_samples field because it's
private, is that right?

[...]

Thanks for your patience,
Bijan

