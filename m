Return-Path: <linux-kernel+bounces-771550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8764B288AF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A183562E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D32D29D7;
	Fri, 15 Aug 2025 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoJDXFYH"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8327144B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300066; cv=none; b=D9CPIU/WXzSqz0/9cHmIi0pn+32py8hDzcl68yh6gQA+NYy2bXo+yJyLQjEx4XkMX32KDKf3S0MM3rEGweVHjWmT2dQgxkJbzZo4Liit/z5yG/YfNWXpa+R+yvvHDjr3cY2IQmlafO2Oj+Es+ZNZYOoUGd815Ip9fvHkjuVKGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300066; c=relaxed/simple;
	bh=JR+PdEFhK6pkykcHRI2c26gH3tdQyy+AvIHjaGcA59M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qgWWHCHTpgxCrMthjvwL8FGz7D3eCexjvtHucqXkR4GTZLRsLQIxZvCKeP8KmpzhzlyonZrdhpKgrwAD5yt4gOWc1t/33UsFStocSHF7LT1Qz8xicEC5JaiP5zVJl5fNjyeTE/DVHSJrjf/M3jfB0f41q5Z1dLL+FVHawDzyuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoJDXFYH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e8e54f8so2117668b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755300064; x=1755904864; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njADXc20sh/OCU5iT2CRpP+DigdW8OrQiBCgtQJIZO8=;
        b=OoJDXFYHH5up0rvdYjoSH08kmKk2mdK9u0xnuR5HL7kOPd4EE4xTOCd9EpH7yXO91H
         fEFRpNIapuWc5+NX3xE4bO7nGzL0Si0OlqIRaIf65MRSOoZYYa7UjkD0gBFW0MZTe7rQ
         X46F+sS2XJhi/0CzwhfjpE1sZk0KWJmUw2GXMe3AT2YMZsYdLrdCAdf15FHbVWVu9DLj
         wFmMIUmFw6PvQbB3aV7I5RCUJemYLPGqMVY0msM6X6/goDJke2LURPtRHQeE4RemNpNQ
         RPZhZaGj1qN/DA+up/UbJILE1WyxkqTs+Y/v6EL3u1CRUbZxrVLZwNzaVAycYjJ0+nRp
         hWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755300064; x=1755904864;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njADXc20sh/OCU5iT2CRpP+DigdW8OrQiBCgtQJIZO8=;
        b=UBcBeAdw0051cmIQdLxY9Rx4vCsnF49Eunv3jR4PG/VVGZS8awJnnzHIvSqHCYXaOU
         iU7QcGm/R5QWSI5L+2JF7wHFrlUMkj2PSQBHrVsbzzMKBUGahuPg7utVVjc436efZ9ZV
         vOa8NzCUyp0KbKs32jqK4b1Vrtuw0OU9O4pPa8lo7fIh1uymJm7obz6GHFDUC0moyN16
         sV+JVtTsvNI7UrNENZJspmBPsBRuDUslMGE/G3z5A5bzWBDI7Ui1KqRbPB+8su9vG+KX
         iCI75QeqQwOkRfb2C2b9oGhQQbDkgN0yd+SEJ6DUgN9ZBqiDN8ARvpasZ1AJU8V0j8ky
         6iwA==
X-Forwarded-Encrypted: i=1; AJvYcCVSWLD5oPxuPT5883LLhmiHAHtMQul/T9nl6DQMJCpZM+VeM56yhJMeeukHIueYxTh6P4AWdr8+Odvx2VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDzoZ1AcFvoE0zdapGQCEi19Ng3YPJffZuJdu/vKOotolUgB7
	rWICTg1wpkptmHR/ti/oVBt9Kvp6QmJ7JNHbu8/2+MkM03ZFqQXzmIC6zQFThdxt3+k=
X-Gm-Gg: ASbGncuR2NDdQEi1MJps+VQ9qVFp2wIRqWxHVH5YkmDOfVq0HddrwUShCJU24mCwhqb
	CkrAaE6l0voValVCAJX+zDwFBjmQa3mTjT0OzdJGdTSZBRJW8RZjNf8s+jT/9sunj4DI2EbVDUk
	7ZzMoe8JCZ/5bNrTdSZ3xJ6kMiMsWQQdu65+rtBaEuI125Bzc4VUIPbKQfgLO6Wz4qNkhQDkcLQ
	39/LajLurDCnDlEqqnRen3FIZR33mL1JjjJrv0EmnoonGlOCbwum6hRBOHzEqwCqnCZIb6wb9dP
	4TaRVatxWSPgL5dHBSFe8lwimwf/m8fEbDbuLMWmtvxeuwUxe9agUSkXTRCPdA25RU2tdGu3izT
	rkKZPCGiks/Nakt0U9sgJUga937n8d4aH63IWXRdi+VyHK9j+sHCWHA==
X-Google-Smtp-Source: AGHT+IHQwblCtiW4OKod+oWI/UOjOgD4r99npyAbPInRuLkjKDCabLumlShODzC25BJStPQwRrNB5g==
X-Received: by 2002:a05:6a21:9992:b0:23d:781f:1516 with SMTP id adf61e73a8af0-240d2ecc63dmr7194836637.22.1755300063861;
        Fri, 15 Aug 2025 16:21:03 -0700 (PDT)
Received: from localhost (syn-047-229-141-083.res.spectrum.com. [47.229.141.83])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b472d74d477sm2195395a12.30.2025.08.15.16.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 16:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Aug 2025 16:21:02 -0700
Message-Id: <DC3DXWOJ6E18.HVR7WZZCRV6F@gmail.com>
Subject: Re: [RFC PATCH] drm/amdgpu: Enable async flip for cursor planes
From: "Christopher Snowhill" <kode54@gmail.com>
To: "Alex Deucher" <alexdeucher@gmail.com>, "Christopher Snowhill"
 <chris@kode54.net>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Leo
 (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: <amd-gfx@lists.freedesktop.org>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619125507.54384-1-kode54@gmail.com>
 <DARA1U86AS72.QOIEVZWCFPYC@kode54.net>
 <DATUOZZD8316.2INSL3KL5RA80@kode54.net>
 <DATV4CAOHVGV.1UJ803EX21II6@gmail.com>
 <DATYCMWH1X28.NE3M8KJ3SPV9@kode54.net>
 <CADnq5_OjUp+YpXSdvWrYN+6ofFfyES9Jvwkswf3JmTTMGL=MVQ@mail.gmail.com>
 <CADnq5_MdosN34TH=L3Zv1K2_Lroa8Y69JK1wy_zbBFRDT-Q=4Q@mail.gmail.com>
In-Reply-To: <CADnq5_MdosN34TH=L3Zv1K2_Lroa8Y69JK1wy_zbBFRDT-Q=4Q@mail.gmail.com>

This may be a more appropriate patch:

https://lore.kernel.org/amd-gfx/20250723150413.18445-1-xaver.hugl@kde.org/

On Fri Aug 15, 2025 at 6:17 AM PDT, Alex Deucher wrote:
> @Wentland, Harry
> , @Leo (Sunpeng) Li Can you guys take a look?  This patch fixes a regress=
ion.
>
> Thanks,
>
> Alex
>
> On Mon, Jun 23, 2025 at 11:33=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com> wrote:
>>
>> + Harry, Leo
>>
>> On Mon, Jun 23, 2025 at 9:38=E2=80=AFAM Christopher Snowhill <chris@kode=
54.net> wrote:
>> >
>> > On Mon Jun 23, 2025 at 4:06 AM PDT, Christopher Snowhill wrote:
>> > > On Mon Jun 23, 2025 at 3:46 AM PDT, Christopher Snowhill wrote:
>> > >> On Fri Jun 20, 2025 at 3:10 AM PDT, Christopher Snowhill wrote:
>> > >>> Here's another alternative change, which may be more thorough. It =
does
>> > >>> seem to fix the issue, at least. The issue does indeed appear to b=
e
>> > >>> no-op plane changes sent to the cursor plane.
>> > >>>
>> > >>> If anyone wants to propose style changes, and suggest a proper com=
mit
>> > >>> message, if this is indeed a welcome fix for the problem, please l=
et me
>> > >>> know.
>> > >>>
>> > >>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/d=
rm_atomic_uapi.c
>> > >>> index c2726af6698e..b741939698e8 100644
>> > >>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> > >>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> > >>> @@ -1087,17 +1087,22 @@ int drm_atomic_set_property(struct drm_ato=
mic_state *state,
>> > >>>                     }
>> > >>>
>> > >>>                     /* ask the driver if this non-primary plane is=
 supported */
>> > >>> -                   if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
>> > >>> -                           ret =3D -EINVAL;
>> > >>> +                   else if (plane->type !=3D DRM_PLANE_TYPE_PRIMA=
RY) {
>> > >>> +                           ret =3D drm_atomic_plane_get_property(=
plane, plane_state,
>> > >>> +                                                               pr=
op, &old_val);
>> > >>> +
>> > >>> +                           if (ret || old_val !=3D prop_value) {
>> > >>> +                                   ret =3D -EINVAL;
>> > >>>
>> > >>> -                           if (plane_funcs && plane_funcs->atomic=
_async_check)
>> > >>> -                                   ret =3D plane_funcs->atomic_as=
ync_check(plane, state, true);
>> > >>> +                                   if (plane_funcs && plane_funcs=
->atomic_async_check)
>> > >>> +                                           ret =3D plane_funcs->a=
tomic_async_check(plane, state, true);
>> > >>>
>> > >>> -                           if (ret) {
>> > >>> -                                   drm_dbg_atomic(prop->dev,
>> > >>> -                                                  "[PLANE:%d:%s] =
does not support async flips\n",
>> > >>> -                                                  obj->id, plane-=
>name);
>> > >>> -                                   break;
>> > >>> +                                   if (ret) {
>> > >>> +                                           drm_dbg_atomic(prop->d=
ev,
>> > >>> +                                                          "[PLANE=
:%d:%s] does not support async flips\n",
>> > >>> +                                                          obj->id=
, plane->name);
>> > >>> +                                           break;
>> > >>> +                                   }
>> > >>>                             }
>> > >>>                     }
>> > >>>             }
>> > >>
>> > >> Upon further testing and reflection, I have come to the conclusion =
that
>> > >> this is indeed best handled by a kernel fix, rather than breaking u=
ser
>> > >> space.
>> > >>
>> > >> I attempted to work around this in wlroots, adjusting 0.18, 0.19, a=
nd
>> > >> 0.20 git with similar patches. First I attempted to stash all the
>> > >> written properties for the atomic code, storing an initial value of=
 all
>> > >> 0xFE so it was always likely to write the first time, and only sett=
ing a
>> > >> property if it changed from the last commit.
>> > >>
>> > >> This resulted in whole commits breaking for one or both framebuffer=
s
>> > >> until I ctrl-alt-fx switched to a tty and back again, and this woul=
d
>> > >> work again temporarily.
>> > >>
>> > >> So I went back to the drawing board and only withheld seemingly
>> > >> duplicate plane properties. This "worked", until I attempted to pla=
y a
>> > >> game, and then it started glitching spectacularly, and not updating=
 at
>> > >> all if the game was doing direct scanout and vrr.
>> > >>
>> > >> Clearly this is wrong.
>> > >>
>> > >> The wlroots library queues up properties for each commit. On every
>> > >> commit where the cursor is disabled, it queues up both fb_id=3D0 an=
d
>> > >> crtc_id=3D0. Every commit. Is this wrong? Should it only be queuein=
g up
>> > >> the disablement properties once? It also queues up the full plane a=
nd
>> > >> hotspot properties when enabled, even if the cursor doesn't change
>> > >> position or appearance.
>> > >
>> > > Probably should have CC'd the drm misc maintainers when I started po=
king
>> > > drm misc instead of amdgpu. Pity there isn't a list for that...
>> >
>> > I am a dumbass, I didn't notice get_maintainer.pl. Added more people,
>> > and the correct list. Not sure if I should remove amd-gfx, since this
>> > affects them, somewhat...
>> >
>> > However, the intention of this thread was to seek commentary on the
>> > situation as it is.


