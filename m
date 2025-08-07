Return-Path: <linux-kernel+bounces-758495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E8B1CFDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73A7563597
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B37478F34;
	Thu,  7 Aug 2025 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEoExSir"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CE4A11
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527739; cv=none; b=VLM2Pq/cA/wv7yG2/L9Jvl7ACybfc+r2xYPw6I/PcyGLPJeemlv+Y0Y2+B1+yWLcdFE/gy0xu6dvIriijWaSQtG326qpWew6o4RD2tBVFU7lqi0KODEAO+R/zqTZWMNy69MyJ8a6QSzNgGhySeFcaKAbmbWiXpcWq5t9y+3eylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527739; c=relaxed/simple;
	bh=ZjOifc3000tlaK0hGk3I5QgSPMkVhf0anMnWrqSVVcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImDW4+N1Tf2ky+Mpxyprf4ZDpY0XK+cscuen4JfKgVRJ7JyobTUJeMaWLuF2o3vVgeR1WekuGUMpLq2dZdDP1WffXwjaccPkPCkDPhJuzjTDzdXNVkVG/77a9QrBtCFAYk5jE+GFqrD7ugtssDWNiVxojxDdyoR1ok/sLpB2uHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEoExSir; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so77955966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754527736; x=1755132536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyU0sgZz9qTulaKfMDXTxb3hNbzZ1ImXa4EG7joeiFI=;
        b=CEoExSirjhBSlyCf2XMBkToeE1A7931BW50F44qfpVYIJzwhTffMVYdZ25lvvny3qk
         kK7PzpFNlueE9+fcmNpvJp2OaczLfuLEkcGRrdCvMWC5CL/2cLnqEtdzKomPhM5IhA1e
         u4KT0a0v6mKotykOw/LH/fnBJ+Skyer55WXPruhIG6qk14yo5xXdyo7WMcur7bAIu0E5
         cL8YYDmt6ksN0QHxtvXghfXYkqtBBcfKVeLKKwVlzcrpWhINs/JTmHwG3U+8lKISeucr
         o40vm5K1zQi6dm1vG2N1B3ssyUaxAPNjp0bYKy45g2djGsM19nbmxygCyes1GPw8K/mM
         lE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754527736; x=1755132536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyU0sgZz9qTulaKfMDXTxb3hNbzZ1ImXa4EG7joeiFI=;
        b=P5TIvDaJCnTxE7Fxwqxu1luj5BwO41IcIkCj6ilb/a+iY/aITsnxbA2gKE3IkQMMub
         u3xkeuo9Dj7xT2kYFeiCjc5KlDVKew0fxRdiMG1ivd8MavQdAtYNS751WmC8BN1xGTA2
         kk8U+ky1wT9nrj1qz6rqAoXhny3pIG0FYMGD+KKf4/SUfGqIzAkd8FQ7Krojt4YuwuLn
         jzaC+1xsnmuX1GoZG9DJ0YXlATWgF+kWDRVvOgmvmDi0la2GZhBFsso8+qhuKeOG+D4s
         5+YWvTdGfCKZD8grhIgtp/EZ/6WYuVOW93ag7r/wHVhK30Twlkc3ianMvyG/21vRQ9lj
         h0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr7ysSb5NaCAzOd+2Jnm9tkjaohA+4qYI8b2AqExLT8raIdxQnGDQipzqcPb+drv6wttT7CpSqfD5HGmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3OQgH504nw+aq3IVDJydTgouRBw6acAs4E8LUIfTGlfi4RSB
	Mzrh4BEg3+4B9+KEqauJlO3luV0r9Jwx0Oor4VoSdyU+fNsmteFsw3XQTZoVws6CEAUKY+wOsQ+
	eBiD/uAAz7StcNj/AdGhQNEN4v9Uq4qmn8Q==
X-Gm-Gg: ASbGncvSvEIYjxN9liCDJpJM48Ur3tSsKHqZhrz4WrK6Ocv0GhRVxFn2MM5FBFPPAn5
	85cxiSNYkYSz6+qWbJFDFNXBs9jHcAKEgIUXGkEse1uuCVH8Hq/FcnfblfV/mgi6Z/mEz4Em1aZ
	JsnMsdn7yg42hubC2cLVTXTjsde2FFBG0WcRX81wmfbaVgn7s6yI0elf444MoAI7Tl/6GvPpNvN
	321rPzIXHElzFsjQtgeTiljBSbutB8KDkxsU55ZMGHJgJf0nlFWvoMi6E9mtHY=
X-Google-Smtp-Source: AGHT+IFQwMopH6azHH9WIpfqyaRZ5dbJlxtTcRscsdnncSFoc6hUjK52CP/r7T5PFLOBcK4Y/4ju5GykKep2RTRqt/w=
X-Received: by 2002:a17:907:7e9c:b0:ae3:5e70:32fb with SMTP id
 a640c23a62f3a-af990105cdcmr469979166b.4.1754527735982; Wed, 06 Aug 2025
 17:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806234254.10572-1-bijan311@gmail.com> <20250807001924.76275-1-sj@kernel.org>
In-Reply-To: <20250807001924.76275-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Wed, 6 Aug 2025 19:48:44 -0500
X-Gm-Features: Ac12FXy1RsWB25PBoiuQCuL0TSug1jNHZq5fTiL_FTzQznrao8zQPdz3aIU7wRQ
Message-ID: <CAMvvPS7mcevjD-b2vz1P+grQfffVA0bx-x5WcUQ8=JApD+UkHw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: skip needless update of damon_attrs in damon_commit_ctx()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 7:19=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed,  6 Aug 2025 18:42:54 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > Currently, damon_commit_ctx() always calls damon_set_attrs() even if th=
e
> > attributes have not been changed. This can be problematic when the DAMO=
N
> > state is committed relatively frequently because damon_set_attrs() rese=
ts
> > ctx->next_{aggregation,ops_update}_sis, causing aggregation and ops
> > update operations to be needlessly delayed.
> >
> > This patch avoids this by only calling damon_set_attrs() in
> > damon_commit_ctx when the attributes have been changed.
> >
> > Cc: Bijan Tabatabai <bijan311@gmail.com>
>
> Maybe above line is added by a mistake?

Sorry about that. I added it because my internship ends this week and
wanted to make sure I get notifications on the status of this patch
(e.g. email notifications when the patch is merged in Andrew's tree).
If it's inappropriate I will remove it in the next version (unless
Andrew does it himself).

> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> I have a trivial comment below, though.
>
> > ---
> > Changes from v1[1]:
> >   - Compare entirety of struct damon_attrs
> >   - Apply logic in damon_commit_ctx() instead of damon_set_attrs()
>
> Thank you for doing this!
>
> >
> > [1] https://lore.kernel.org/all/20250806164316.5728-1-bijan311@gmail.co=
m/
> > ---
> >  mm/damon/core.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 6a2fe1f2c952..80aaeb876bf2 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -570,6 +570,24 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
> >       kfree(ctx);
> >  }
> >
> > +static bool damon_attrs_equals(const struct damon_attrs *attrs1,
> > +             const struct damon_attrs *attrs2)
> > +{
> > +     const struct damon_intervals_goal *ig1 =3D &attrs1->intervals_goa=
l;
> > +     const struct damon_intervals_goal *ig2 =3D &attrs2->intervals_goa=
l;
> > +
> > +     return attrs1->sample_interval =3D=3D attrs2->sample_interval &&
> > +             attrs1->aggr_interval =3D=3D attrs2->aggr_interval &&
> > +             attrs1->ops_update_interval =3D=3D attrs2->ops_update_int=
erval &&
> > +             attrs1->min_nr_regions =3D=3D attrs2->min_nr_regions &&
> > +             attrs1->max_nr_regions =3D=3D attrs2->max_nr_regions &&
> > +             ig1->access_bp =3D=3D ig2->access_bp &&
> > +             ig1->aggrs =3D=3D ig2->aggrs &&
> > +             ig1->min_sample_us =3D=3D ig2->min_sample_us &&
> > +             ig1->max_sample_us =3D=3D ig2->max_sample_us;
> > +
>
> Unnecessary blank line?

Sorry for missing this!

> > +}
> > +
> >  static unsigned int damon_age_for_new_attrs(unsigned int age,
> >               struct damon_attrs *old_attrs, struct damon_attrs *new_at=
trs)
> >  {
> > @@ -1198,9 +1216,11 @@ int damon_commit_ctx(struct damon_ctx *dst, stru=
ct damon_ctx *src)
> >        * 2. ops update should be done after pid handling is done (targe=
t
> >        *    committing require putting pids).
> >        */
> > -     err =3D damon_set_attrs(dst, &src->attrs);
> > -     if (err)
> > -             return err;
> > +     if (!damon_attrs_equals(&dst->attrs, &src->attrs)) {
> > +             err =3D damon_set_attrs(dst, &src->attrs);
> > +             if (err)
> > +                     return err;
> > +     }
> >       dst->ops =3D src->ops;
> >
> >       return 0;
> > --
> > 2.43.0
>
> Other than the above trivial things, looks good to me.  Thank you again!

Thank you!
Bijan

[...]

