Return-Path: <linux-kernel+bounces-804914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09CB481E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B163A6970
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB6919F13F;
	Mon,  8 Sep 2025 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA1/iPeg"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBC1A0BFD;
	Mon,  8 Sep 2025 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294106; cv=none; b=udYAlb5+ahgAQpVveumx1k9xV5AwOe49bY92AGyWUqUIudkPJKu1jtoqdXieX0QhMIycosNY0gRxKPGndTH36Lk+6sGQUCG/SBvMFVZm+zfA6DFqX1zbXdq6/GD6RVjeHO5MZ/n3KvvpzbSO+hBSyzy5xvnA6obr4mhamr5M31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294106; c=relaxed/simple;
	bh=DGvSUHulO0rb7yojPeJ6rvNq/SJEDgZ4kYjGVB5EqSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIYdOfcml6zvimsuV5T11XUrFUV2Y2RXxrzg7WNLWa9UadD/j+0caOsGVFUeHzdDHCzhPd8UcLbce+W6t+GZSuS+OGduiUfK23ZyBLPuVy/q4gUsTzpx+6SkIN7ROvu262SohH4sj4g6dSpgWy+05GJq7Fa36sv8MuOCKdQD0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA1/iPeg; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f65fc9b073so43266945ab.1;
        Sun, 07 Sep 2025 18:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757294104; x=1757898904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+tkzswrapgR/dTsqQ2m3nGst/xjQe0rpu8h5I2gUJc=;
        b=NA1/iPegMHke6hd5o55/jtiUq77iVqLVikdGoGDtmSiq3yiX5Oyi05HR0yBZjGHy2t
         kCVhm51lVN/+bmdDMHGS6RmRAYjYNm/vylLC8mrvVGhSab214GivvXyyJnJ6fqEE9ST3
         kC1i9JAeibU+uqJAFiLrxWYMc9Y+Mlkk8/qo+fI+qYwcmEjTAry9M+hwjHqF6lzEI2Pz
         EedQ8W4o0VFcFWvbUOKK48lAdX5WVyVTLKu8Zb7xZLqffo+cvczZxNrjOs5DQkSZa5N1
         p+K7TBEqFad4E7QpgWEE2RBmMJbK33jMuGiHo2ZzPMUeEc/b448/JGxfMTdvsnNcklu8
         KyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757294104; x=1757898904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+tkzswrapgR/dTsqQ2m3nGst/xjQe0rpu8h5I2gUJc=;
        b=AD0D41GsAJUMBCJPJy/9SKpzVOW+KnY2JzTw9Ey85Z4gkC1v97SPYRG8Oj5LzS4jYe
         Y+1Ik6oqZd103tU6Vk26vX2ruDrHEucGFPRljbbmltKolNeOqbKVcywhjZOzUPUk737d
         7w0QyDjvdOUvaKIOv1JvFHcS0WjlfOxNrIWuDrtJbafHWgJF9CqoueLGCyktyZzRauF1
         auPO6tUVZWzfxvGfbDxhJxJDwn5f6kIJN2ilWo3ZX6Y3mtuD2m836F3JsPzcC9N5/y1L
         Mp7AW7b6py5a/w/tB1WR5FFK7hkxG5eC9ppZUw0ifmlFojsu5aJCWb+X6XY97Gw0K7Xn
         PZoA==
X-Forwarded-Encrypted: i=1; AJvYcCVJM0j+eahBbJyta6abvpuNokP9Y+hMk3B7WVl9+KZ3RoLLgrQl/X/ShHEVRDi+kN8p/eGxYn9Xm7hq@vger.kernel.org, AJvYcCX4HWNIt1sgtE8T3OjvqSzBVt7pJ9OXEoxpvG+7hDuovpsJ3wN+T5YWRi9XKVQY6R9gnOYodI01TVZK067+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rY3T2DdKJx63IivcZA4NlBZBrLklFRRl5pEKyH0DZEsYgxJ8
	dRMelTHEgm/rMFvQGIkmRPvUNlYxlmzCNdVX5XCJvh921VpwBvdPagQkW/0ka167cW6FKEtIZmv
	LNh70tNqA0Omfw2YhTrx6dGJpwODHnP5D+D5KWqY=
X-Gm-Gg: ASbGncvaYwBaO+D01lNktWEirFZBFWdJ+DPNY6LyvQsq1TRQS27soOh0nt2wVs2K63c
	OjGUDDR7O29MiaJLPDBzvlCKo1s4KcHEhh29cx/YlRByOLVY2F6jTPrJjDsaGFK8f5sxIzjUiLd
	hz7pL0iTqCcUYrl5D25oy/k4llE7bMJwv9Mbvdc7UlKDHpUL063KOmePrZIL3ntmacWaLKeeRJ8
	lAOP34=
X-Google-Smtp-Source: AGHT+IGCzNtDdcTIjk3YHf6PYBrzcTsEkAwN/He/H1kEd/P0IrQQ3wvmVpZ7FffYNSbribuhhyfTeTLpNI+r0FnmXJ8=
X-Received: by 2002:a05:6e02:1605:b0:3ed:8fef:f855 with SMTP id
 e9e14a558f8ab-3fd877827f6mr95214095ab.26.1757294103735; Sun, 07 Sep 2025
 18:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903123825.1721443-1-syyang@lontium.com> <20250903123825.1721443-3-syyang@lontium.com>
 <24rahlm4kkob7knapdxxnjixye3khx3nv2425y4kkirat4lmam@gjey7zqsnzks>
 <CAFQXuNZUfAJe4QEDfi+-1N99xO0_z5_Omnsn_-SXr2QPtvdL_g@mail.gmail.com>
 <7cyypk5j7o5fglmibshg45iysffpdl75m6rqvv4b5zntfevhiz@zlt7ybuzkvrg>
 <CAFQXuNb+Eq6KPFvsnmGvn7KKjn4WRtMy1x4pn4ZvZoQ-_S_fYQ@mail.gmail.com>
 <d3e3b838-26fa-491e-8c4f-63a1693f2391@linaro.org> <CAFQXuNbZfnySYmizY2=PJGLkk38WHOYbVcbPTRZvgY7bFdK8yg@mail.gmail.com>
 <zv7twvfxlira5wmg4zwk6kgkldgdiesgqzjky4733lp2us2hmx@tohls6czl3wz>
In-Reply-To: <zv7twvfxlira5wmg4zwk6kgkldgdiesgqzjky4733lp2us2hmx@tohls6czl3wz>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Mon, 8 Sep 2025 09:14:51 +0800
X-Gm-Features: Ac12FXzTbwajMxg_nAOij4ahFseJuHB8oy3QA60h5prxACC-Ryd33JDiCP3ZO4Q
Message-ID: <CAFQXuNa7z=RHtbx6zrtGGDK4dpa++m_BPxTNj8iemLkxYPP_zA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] This patch adds a new DRM bridge driver for the
 Lontium LT9611C chip.
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, syyang <syyang@lontium.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	xmzhu@lontium.com, llzhang@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=E5=B9=B4=
9=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=94 22:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 05, 2025 at 04:58:59PM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > HI=EF=BC=8C
> >
> > As a vendors , we have begun to attempt to contribute to the Linux,
> > and we are very willing to do so.
> > there are still many rules that we don't understand and need to learn.
>
> Not top-posting and trimming your emails would be nice things to learn
> too.
>
> > <neil.armstrong@linaro.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=885=E6=97=A5=
=E5=91=A8=E4=BA=94 16:10=E5=86=99=E9=81=93=EF=BC=9A
> > > On 05/09/2025 04:55, =E6=9D=A8=E5=AD=99=E8=BF=90 wrote:
> > > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=
=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 22:39=E5=86=99=E9=81=93=EF=
=BC=9A
> > > >> On Thu, Sep 04, 2025 at 06:48:13PM +0800, =E6=9D=A8=E5=AD=99=E8=BF=
=90 wrote:
> > > >>> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E202=
5=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 10:52=E5=86=99=E9=81=93=EF=
=BC=9A
> > > >>>> On Wed, Sep 03, 2025 at 05:38:25AM -0700, syyang wrote:
>
> > > >>>>> +     }
> > > >>>>> +
> > > >>>>> +     if (lt9611c->bridge_added) {
> > > >>>>> +             drm_bridge_remove(&lt9611c->bridge);
> > > >>>>> +             lt9611c->bridge_added =3D false;
> > > >>>>> +             dev_err(dev, "DRM bridge removed\n");
> > > >>>>> +     }
> > > >>>>> +
> > > >>>>> +     if (lt9611c->regulators_enabled) {
> > > >>>>> +             regulator_bulk_disable(ARRAY_SIZE(lt9611c->suppli=
es), lt9611c->supplies);
> > > >>>>> +             lt9611c->regulators_enabled =3D false;
> > > >>>>> +             dev_err(dev, "regulators disabled\n");
> > > >>>>> +     }
> > > >>>>> +
> > > >>>>> +     if (lt9611c->audio_pdev)
> > > >>>>> +             lt9611c_audio_exit(lt9611c);
> > > >>>>> +
> > > >>>>> +     if (lt9611c->fw) {
> > > >>>>
> > > >>>> You definitely don't need firmware when the bridge is up and run=
ning.
> > > >>>>
> > > >>> The previous text has already described the working logic of the =
firmware.
> > > >>
> > > >> It's another topic: you are storing the firmware in memory while t=
he
> > > >> driver is bound. It's not necessary. You can release it after upda=
ting
> > > >> it on the chip.
> > > >>
> > > > I understand what you mean.
> > > > Based on the above conversation, your intention is that when the
> > > > customer needs to upgrade the firmware, they should modify the
> > > > comparison conditions of the version, then compile and burn the
> > > > kernel, and then perform the firmware upgrade, just like the LT9611=
UXC
> > > > driver. Instead of loading the firmware every time.
> > > > My design intention is to avoid the need for recompiling the driver
> > > > when upgrading. Instead, a file named "LT9611C.bin" can be directly
> > > > sent to the "/lib/firmware" directory via scp. Then you can either
> > > > perform a reboot for the upgrade or execute the command manually fo=
r
> > > > the upgrade.
> > > > Perhaps you are suggesting that we could follow the design approach=
 of
> > > > the LT9611UXC driver?
> > >
> > > Yes no need to rebuild, just use sysfs to trigger an update.
> > >
> > I think you haven't attempted to understand the intention behind my des=
ign.
> >
> > If during the debugging process, the customer discovers that a certain
> > parameter in the chip's firmware is not suitable for the current
> > situation, then he requests a perfect firmware from our company to be
> > updated onto the chip.
>
> That's fine.
>
> >
> > When there are hundreds or tens of thousands of devices that need to
> > be updated, simply use sysfs to trigger the update. It is a very bad
> > thing.
>
> Delivering updates to devices it off-topic here. You can use SWUpdate,
> Mender or any other system to deliver updates and to trigger the
> firmware reflash afterwards.
>
> > If you want to use version number comparison as the upgrade condition
> > like in lt9611uxc.c, then the customer will need to modify the version
> > number comparison condition and rebuild the driver. This method is not
> > as simple as the one I have designed.
>
> Well, no. If there is a firmware update, it should be shared to
> linux-firmware and then everybody can benefit from it.
>
> Think about one company using your chip in their SoM or compute module
> and then another company integrating that module into their design?
> Who will contact you? Or a company selling devkits with your chip.
>
> Having per-customer firmware is a nightmare for developers and for
> integrators.
>

We are a company that sells our own developed chips. After other
platform design companies purchase our chips, they will design their
platforms based on the hardware schematic of our chips. During this
process, they must contact us. We will communicate about the design
opinions of the platform, the configuration of parameters, and the use
of custom firmware. We cannot provide a common firmware. This is
determined by the characteristics of the chips.

> > > >>>>> +
> > > >>>>> +     lt9611c->kthread =3D kthread_run(lt9611c_main, lt9611c, "=
lt9611c");
> > > >>>>
> > > >>>> Why do you need extra kthread for that???
> > > >
> > > > Upgrading the firmware takes time. execute it sequentially in the
> > > > probe function, it will block the system boot.
> > > > Using the kthread method will not block the system boot.
> > >
> > > Just follow the drivers/gpu/drm/bridge/lontium-lt9611uxc.c way to do =
this.
> > >
> > In fact, I think the method in lontium-lt9611uxc.c is a very bad one.
> > My clients often encounter situations where the system gets blocked
> > during the firmware upgrade process, and they have no idea what has
> > happened.
>
> Patches are welcome, please help us by improving LT9611UXC support :-)
>
> E.g. it would be nice to control InfoFrames or YUV output capabilities.
>
> --
> With best wishes
> Dmitry

