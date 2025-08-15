Return-Path: <linux-kernel+bounces-770921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33ECB28075
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4351BC874A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B73009EF;
	Fri, 15 Aug 2025 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS78w0UC"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F71A76B1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263849; cv=none; b=tC53uVZepk4HBnEE3+KahLqtofJ/E0iBoEL8uEddyeVfvx0oOZtLD6sEN4ApDVyFAjuKnCBY3EPUzqT55w3pA9G+ggILJS5eRSKE1c4QTON7K+HOGk/ju5H196nS7F2iEJzjLzgQNjFffwoggu9HF+5hHbfzD1ylFecMbRAqh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263849; c=relaxed/simple;
	bh=QEyRs9ZWD3KMQKnhpjmN2NUoC/iKwDe92uWzy2lHho0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBp3fRZCRco/LjcLnPnhGCoCLrvxlEN0QSOUNAB88F+o1wBS8KK4u0qSlPOnLI2WF1D3eX7MP9Onr44n0OYQTyRO0I8Rq/3daWe4fIKCUSFlXFljnyr/D8fhcvu2B8qgVnAHwnWvu2POKN7HJEceZunowN1sYDVdVzmdHN1jYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS78w0UC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244581eab34so3077525ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755263848; x=1755868648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaYq3BXdk4W0mHcECsikypLL83w7vWxWky4B3sTN/+4=;
        b=cS78w0UCYaZV2OTmL4zdWIqQmeLbaF+8XhwrbevYAi4zEDUACSTLHj/d1Bn8RSb/sE
         tDlWVgJxmAtCJ5hfy55c8ZZL9uuWbGUomg6EZqUUuH7ZhTINdJ59MmsIXPyGch2V4fds
         CAoKgARZAR8N1VGUJVSxKA3NT+kV1VjiN4ElCjFNwPVKlgUCpBC+HmIuYEnsDxOv5rm7
         58wTHwxdPtKi9fbBRSCTp8HZeH4AlehZajlnm7PnVO1odsX5qpq32N9rqPfaVKfmLEF5
         SwCr1487x0c55sjBeRISZURO4aEW4Y4sX3o/ovfj4bVNFGSdFKssBJwjRVLQlO5dqAov
         aJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755263848; x=1755868648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaYq3BXdk4W0mHcECsikypLL83w7vWxWky4B3sTN/+4=;
        b=U/iJ4rRcE1UPJ6dF6lQMvrRejCkmrU3Rm3Jq2S5FhuBHYxaQgkt7Ge6JfSC20MJObj
         yc12PGrmjVOFY3KY791aR6mUD/4/12bCih002Qgg/Sf8+zvKjXzi7IMPRsuhcSz/DPGE
         fYdjphzq6F4UI7t1+jTknmb6VituxtbS5WPpRAUCa/et40ynmjYcWldlvJxPqiWuXG0x
         ExreQqcCqShQIws1WC2hVJXlw/oP53sIp6Qi9bSTSF8xTwDbBgkxVdEYRdDN9OHPNOym
         n2kNEdtZtWkc16k42qrtdymRpWGBe0TTuv0Z+W9CwX2VFkNmlUCCskliYvzVpsLM5Yg2
         w53g==
X-Forwarded-Encrypted: i=1; AJvYcCXBbWH1ftknROk/7r/Pn6djneUR+NXPKYW5QU5kTVR992EY9b6QNiSk8pASEg8AW/uH+bnmLBESc7OlnYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gjaH8ftgwUekyFkHiBd6FRlMnSzy4q9/WNJ3RMM+QoSPage+
	O3jtkllVh893QCSyRQhkOQBfNAYJib+NIHHpPsy8Z+bxlyszHaMSNVyb8OkqiYYdz2fbGe7Z8Bb
	RzCQcYLseUuRs0qonurs9LsFQOWRN0QQ=
X-Gm-Gg: ASbGncsCu0sqlmsEd//NorxGBYbNOj/gDwkbtiIKK7kw6NWZc0b4J5eTOsu4mnLmSgQ
	WhNzxgQ8GhUQZLcfMnJMhU8bixPMnEN1jOvKnaMwica42cfOjPtJa9JFD0D9EVvirHTxP8lpEpx
	7ypWmh6pZ/c5bwt1UgWYQ1xc13v4AE4//hRWG9G0Ty5FM8fKQDO2hL47hBYwbI+HuxE6QjT66O5
	vbx5BQ=
X-Google-Smtp-Source: AGHT+IH7GHehAz6jm+OtbdZ0QKOtENqBBWnWMR4t4Y41KMeIuGO5yD01p1LE69N5aApixlKWoR59osKT+tonZYwGWls=
X-Received: by 2002:a17:902:f541:b0:240:9ab5:4cae with SMTP id
 d9443c01a7336-2446d5d6193mr13616705ad.1.1755263847339; Fri, 15 Aug 2025
 06:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619125507.54384-1-kode54@gmail.com> <DARA1U86AS72.QOIEVZWCFPYC@kode54.net>
 <DATUOZZD8316.2INSL3KL5RA80@kode54.net> <DATV4CAOHVGV.1UJ803EX21II6@gmail.com>
 <DATYCMWH1X28.NE3M8KJ3SPV9@kode54.net> <CADnq5_OjUp+YpXSdvWrYN+6ofFfyES9Jvwkswf3JmTTMGL=MVQ@mail.gmail.com>
In-Reply-To: <CADnq5_OjUp+YpXSdvWrYN+6ofFfyES9Jvwkswf3JmTTMGL=MVQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Aug 2025 09:17:16 -0400
X-Gm-Features: Ac12FXw5jexccg-BAvytZLhI7_WZrN0ERbOBSkiAjGcPSkTJBUCUIwILhlAKSTc
Message-ID: <CADnq5_MdosN34TH=L3Zv1K2_Lroa8Y69JK1wy_zbBFRDT-Q=4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/amdgpu: Enable async flip for cursor planes
To: Christopher Snowhill <chris@kode54.net>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
	"Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: Christopher Snowhill <kode54@gmail.com>, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Wentland, Harry
, @Leo (Sunpeng) Li Can you guys take a look?  This patch fixes a regressio=
n.

Thanks,

Alex

On Mon, Jun 23, 2025 at 11:33=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> + Harry, Leo
>
> On Mon, Jun 23, 2025 at 9:38=E2=80=AFAM Christopher Snowhill <chris@kode5=
4.net> wrote:
> >
> > On Mon Jun 23, 2025 at 4:06 AM PDT, Christopher Snowhill wrote:
> > > On Mon Jun 23, 2025 at 3:46 AM PDT, Christopher Snowhill wrote:
> > >> On Fri Jun 20, 2025 at 3:10 AM PDT, Christopher Snowhill wrote:
> > >>> Here's another alternative change, which may be more thorough. It d=
oes
> > >>> seem to fix the issue, at least. The issue does indeed appear to be
> > >>> no-op plane changes sent to the cursor plane.
> > >>>
> > >>> If anyone wants to propose style changes, and suggest a proper comm=
it
> > >>> message, if this is indeed a welcome fix for the problem, please le=
t me
> > >>> know.
> > >>>
> > >>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/dr=
m_atomic_uapi.c
> > >>> index c2726af6698e..b741939698e8 100644
> > >>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > >>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > >>> @@ -1087,17 +1087,22 @@ int drm_atomic_set_property(struct drm_atom=
ic_state *state,
> > >>>                     }
> > >>>
> > >>>                     /* ask the driver if this non-primary plane is =
supported */
> > >>> -                   if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
> > >>> -                           ret =3D -EINVAL;
> > >>> +                   else if (plane->type !=3D DRM_PLANE_TYPE_PRIMAR=
Y) {
> > >>> +                           ret =3D drm_atomic_plane_get_property(p=
lane, plane_state,
> > >>> +                                                               pro=
p, &old_val);
> > >>> +
> > >>> +                           if (ret || old_val !=3D prop_value) {
> > >>> +                                   ret =3D -EINVAL;
> > >>>
> > >>> -                           if (plane_funcs && plane_funcs->atomic_=
async_check)
> > >>> -                                   ret =3D plane_funcs->atomic_asy=
nc_check(plane, state, true);
> > >>> +                                   if (plane_funcs && plane_funcs-=
>atomic_async_check)
> > >>> +                                           ret =3D plane_funcs->at=
omic_async_check(plane, state, true);
> > >>>
> > >>> -                           if (ret) {
> > >>> -                                   drm_dbg_atomic(prop->dev,
> > >>> -                                                  "[PLANE:%d:%s] d=
oes not support async flips\n",
> > >>> -                                                  obj->id, plane->=
name);
> > >>> -                                   break;
> > >>> +                                   if (ret) {
> > >>> +                                           drm_dbg_atomic(prop->de=
v,
> > >>> +                                                          "[PLANE:=
%d:%s] does not support async flips\n",
> > >>> +                                                          obj->id,=
 plane->name);
> > >>> +                                           break;
> > >>> +                                   }
> > >>>                             }
> > >>>                     }
> > >>>             }
> > >>
> > >> Upon further testing and reflection, I have come to the conclusion t=
hat
> > >> this is indeed best handled by a kernel fix, rather than breaking us=
er
> > >> space.
> > >>
> > >> I attempted to work around this in wlroots, adjusting 0.18, 0.19, an=
d
> > >> 0.20 git with similar patches. First I attempted to stash all the
> > >> written properties for the atomic code, storing an initial value of =
all
> > >> 0xFE so it was always likely to write the first time, and only setti=
ng a
> > >> property if it changed from the last commit.
> > >>
> > >> This resulted in whole commits breaking for one or both framebuffers
> > >> until I ctrl-alt-fx switched to a tty and back again, and this would
> > >> work again temporarily.
> > >>
> > >> So I went back to the drawing board and only withheld seemingly
> > >> duplicate plane properties. This "worked", until I attempted to play=
 a
> > >> game, and then it started glitching spectacularly, and not updating =
at
> > >> all if the game was doing direct scanout and vrr.
> > >>
> > >> Clearly this is wrong.
> > >>
> > >> The wlroots library queues up properties for each commit. On every
> > >> commit where the cursor is disabled, it queues up both fb_id=3D0 and
> > >> crtc_id=3D0. Every commit. Is this wrong? Should it only be queueing=
 up
> > >> the disablement properties once? It also queues up the full plane an=
d
> > >> hotspot properties when enabled, even if the cursor doesn't change
> > >> position or appearance.
> > >
> > > Probably should have CC'd the drm misc maintainers when I started pok=
ing
> > > drm misc instead of amdgpu. Pity there isn't a list for that...
> >
> > I am a dumbass, I didn't notice get_maintainer.pl. Added more people,
> > and the correct list. Not sure if I should remove amd-gfx, since this
> > affects them, somewhat...
> >
> > However, the intention of this thread was to seek commentary on the
> > situation as it is.

