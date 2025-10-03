Return-Path: <linux-kernel+bounces-840903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A82ABB5AED
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463424261EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534112F5A5;
	Fri,  3 Oct 2025 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAc4Eb1X"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4002D7BF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452413; cv=none; b=SVWayQdpS1RNUAUuElh2CnIR06P+dV3LXlE3TeXn9ZBA7VJdtPwOnCA56f62IUjRzfalZcdbPudStN4RjN3DvhCvgs7iH9g42dfW28s8WXc5E1DZcnI8+JfY7k7OdceB0MP2gMw6QOWgKLG0PQFP6QaBpogpBjdyulSIMu2EJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452413; c=relaxed/simple;
	bh=mS2wAnSHHTiyxRO9Iimvy0OYVSzTSVEW+cz3TyzjlAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nELm/D6LVbuKtLIL1JcrER8CjJvrIFlelgImJiUAfbnaXQqF+FVyD5GMXSma30oHRlQqpJuAX3uWfRtTy+VhxnxrUPOpSxIwqj/Vi7DWX7L7L2v0iI7SztcBmcAOmIm376jzxwC1ZUpY0robZDNdCEMf4kzaEgVws8BhdZX5WvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAc4Eb1X; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63497c2a27dso2206159d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759452411; x=1760057211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCpVlKn6CtsiaycmR9mmep0pvp7Jm/KhrpmquGLOTuo=;
        b=MAc4Eb1XG8WILimPQBhwyQkBV+tQrf7313Q5HntOWUp7ikB3qOq/dbshuvBngGvJuF
         s8Cpy9+xw8eBonHWlsNMAYafjfHJEF1fDC24Xs5fCkhYVl+h7GwyAoWK0HKO7Y46YYuO
         7nN1W84c9U5Jq8vje52TSCIHrDMk64IB2L2J40D6n+2bXXfxxxvFuBrAjYwOOx205xxs
         fdVmKxZAyZ0fy2+AhjP8rcWilOfzrjCpWK1CZnvJaD/YmIF+0zcV8+zZKVJ0UKFEIOuE
         uGXmuvoPSRyGdYW0c/lxDQJt+fW5osmQoA7lo8d2JkTlbstZXmLXjNgLv5Lf33EYCPd9
         cHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452411; x=1760057211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCpVlKn6CtsiaycmR9mmep0pvp7Jm/KhrpmquGLOTuo=;
        b=hH2Kb7qxBDfLzZmGEKhdnjG/iyVBh3afVDbL1kgZfOEvdERgbpXo67D7NYje25xJeF
         2D5UiXcpPBBHnEZun8xSNDHP9WgxxMDbOEcRPfhqA1S7yVvIFqYK5CdYZNQo184d3Vhx
         a58kNmAytMyW1v5RVAwuQqxM+YJ5d83+g/LPali/mYGgSSHafF728cIUM+zBTSCLB/g9
         k2TWPEAYyNBpE+QgAKUOI6u8QDnTdKlm59ZgWFbncYYYHSB/FsEO3qGyEuGb7zvxJ8po
         pWl634XaGTS5ftWVnmppPP6eDd7VF8VsnBXELXxfnX49EC11eRRkmmfhdlSdGyUlyZTV
         h6gg==
X-Forwarded-Encrypted: i=1; AJvYcCUyqlsHga1B+KBroAGZXP13R/Pis24HsGLP3nPBBlgyGjNKRxy6EEVKsrreIeEnmsJROd+cIKiPplLdezY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnuy2XL1iIsJKy+m06pcL9Ld+0BkXpfXm/GwNLy7L7Tm/l/4L
	PKqmDPAzUWolsfa/N090pXzjIKKfVpj5zT85DTX8PRmXz0csyp/0NwKtgIzxIc/lcZa+C0MW5pW
	qXItbmDfjMRywtoN+iHBWfqW4oh83xD4=
X-Gm-Gg: ASbGncv9FYGx5fucWmrBCmg8yAOEUjuAXg+Oi+BmHXh94z8gYfZAX77io8/m/QROV3q
	qKuxwylZDFruNpggiX04Z8fp8RfSfTQ8k7xly+/DevNrwUjXTdcKpV5YBtKWO0XolAFMuXWQ60B
	Hq3eJwCjp8C4hQOr9Z64rJqrml8aakLRFmJsXpVXAn99wUsVcISBl5PGYfTX1Bxsk7DXqsB/8lw
	GT3g+xLxr+OYDJgSgRtnw1SlnzMazOw3k0Am64jA2l5m8VwyiYchj407Qhzc7fhv/pti/m/PvvD
	lTBwOhDViZMmcHrcLxcL
X-Google-Smtp-Source: AGHT+IEkgxflzs7m0J5lByB1Z3Uo+kW2Fj5iD65ymCUQ4r3Wul/h5Hy3+msSm92r3D9So8jKB8gDA+eu/LK6yro2Moc=
X-Received: by 2002:a05:690e:1594:20b0:633:bd73:1368 with SMTP id
 956f58d0204a3-63b9a060cafmr1175668d50.21.1759452411058; Thu, 02 Oct 2025
 17:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916210823.4033529-1-olvaffe@gmail.com> <20250916210823.4033529-3-olvaffe@gmail.com>
 <c521f2be-85b2-4f4e-9e5c-6105129b3fc6@arm.com>
In-Reply-To: <c521f2be-85b2-4f4e-9e5c-6105129b3fc6@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 2 Oct 2025 17:46:39 -0700
X-Gm-Features: AS18NWBqIjju3_O0T3H14G7XSdDx9qO5JPJP-DEILwJcXtN4x4qXrCsTmpn734k
Message-ID: <CAPaKu7TT_Uph+ccNQ4q2+y9Pbmm-nLnPOgsLwEuZGnON26EStg@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/panthor: rename and document lock_region
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:41=E2=80=AFAM Steven Price <steven.price@arm.com> =
wrote:
>
> On 16/09/2025 22:08, Chia-I Wu wrote:
> > Rename lock_region to mmu_hw_cmd_lock.
> >
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pa=
nthor/panthor_mmu.c
> > index d3af4f79012b4..8600d98842345 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -545,8 +545,17 @@ static int write_cmd(struct panthor_device *ptdev,=
 u32 as_nr, u32 cmd)
> >       return status;
> >  }
> >
> > -static void lock_region(struct panthor_device *ptdev, u32 as_nr,
> > -                     u64 region_start, u64 size)
> > +/**
> > + * mmu_hw_cmd_lock() - Issue a LOCK command
> > + * @ptdev: Device.
> > + * @as_nr: AS to issue command to.
> > + * @region_start: Start of the region.
> > + * @size: Size of the region.
> > + *
> > + * Issue a LOCK command to invalidate MMU caches and block future tran=
sactions
> > + * for a region.
>
> The LOCK command doesn't invalidate the caches - that's the UNLOCK
> command. LOCK just blocks any memory accesses that target the region.
>
> [I guess the hardware implementation might flush TLBs to achieve the
> block, but that's an implementation detail and shouldn't be relied upon].
Hm, for LOCK, the doc I have says "MMU caches are invalidated." And
for UNLOCK, there is actually no invalidation when the region is
LOCK'ed.

> I'm also not entirely clear what the benefit of this rename is? It's a
> static function in a xxx_mmu.c file so it's fairly obvious this going to
> MMU HW related. I also feel "_region" in the name makes it obvious that
> there is a memory range that is affected by the lock.
A big part of this file is for in-memory page tables. "mmu_hw_" prefix
is used by some functions that write the regs. This (and following)
renames prefix other such functions by "mmu_hw_" for consistency.

Then there are "mmu_hw_cmd_FOO" for each hw cmd FOO. That's why the
"_region' part gets dropped.
>
> Thanks,
> Steve
>
> > + */
> > +static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u=
64 region_start, u64 size)
> >  {
> >       u8 region_width;
> >       u64 region;
> > @@ -609,7 +618,7 @@ static int mmu_hw_do_operation_locked(struct pantho=
r_device *ptdev, int as_nr,
> >        * power it up
> >        */
> >
> > -     lock_region(ptdev, as_nr, iova, size);
> > +     mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
> >
> >       ret =3D mmu_hw_wait_ready(ptdev, as_nr);
> >       if (ret)
>

