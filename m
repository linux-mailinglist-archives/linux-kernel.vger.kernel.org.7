Return-Path: <linux-kernel+bounces-763114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C3EB21064
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B4218A6786
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C992E5417;
	Mon, 11 Aug 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4gBaytI"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C972E540A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926033; cv=none; b=niUY+ADAlnsoGpkz0l2Oj9RxNGDHLhpI7/DK7S3KO6u1+kkbgCmqiTvD//v28UJa96ARcmmgzb4mrHTlFIlkgYOVearU3YwzbZVNXlraXLuB3GAZdSai7MZsXpOLtbU8BdW/jaMGOatW3lGlgjbvlxxdp0LzR7MAVPUtOBfL+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926033; c=relaxed/simple;
	bh=xysz5ZWfeLJU14XdQgH88fCcxawJLmGd/fO1hsQ3BdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXQGB+M6eGLuU0Jun/9FLmUWWh6ksmy5yV4qK6R4kT8j3DajseIzoNzmZYJRZPXUjA6jnk5AVn1F2ksV2l9v46YWpPh/FAyzzodOQ/9ykpxGBvdiZOF7Bo7GTvDqj2gn4EjWJUdEOoe75xn2IirG2YXivWHKAtGqQrCNhcd/7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4gBaytI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4af2019af5aso51250731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754926030; x=1755530830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9V4fdqKDbSNOCsKA58nuVOImljGAbwCF2ERoqUReLI=;
        b=V4gBaytImdhkXW3SFy1CpMSJ96x+Mrg/llOSagOm6kCKEx5+QMHAVLpW5/k9MqtNLo
         YFo0BjO4FrCiHViZvp+34op54xjBKUWtXVQhcwTptYKqtsmKIt3KWj5cKjpFOzP6P7nq
         +Ris/oqit6gIdw4tAedA1zUoYzCouVPvoF+UZdyt4Qv+SR3G/ARFqvUIRp849S4HgGWC
         KaEEj0H6jrEx4wxP2wWRS3s2LugFPQyPZrbiCoe7rgScz54+uShus74MJkr1nqW0oKqK
         TJDWfGGHrfDZ9VNmyUpeAdEHs4vmtwuUb+mBM5nenWTVTMVNIQgTeY7Wx/U9Hyr7ZYlp
         TkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926030; x=1755530830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9V4fdqKDbSNOCsKA58nuVOImljGAbwCF2ERoqUReLI=;
        b=UZtlKaZZDLVGEyUm3D7IrsxfU5QbOURveylT/r/NRl/Ag9onMttW34rpQ5CFkHjKvR
         6CfxgI2TTR+ezRWL7ffFBD1m4P0b/69wZflJ77kssM4m2yLwpU7cDM8zEyqBD8Psem0g
         04XpakkYYetC9zh2ERMlZ34AfuD3v3Qv2lPEZ1LNu0QWrMuLQQVmDIxUDaNn8cPgIHFX
         A0o0MknMmaufCVIMUoWsPlgJ9G0yypECOLG5BdeedkJGcx4NLybmYwoBluUmvP50bhxY
         wYi3yVJxsOzfVAGJgquwZ9vDi/V7PIPz+6jF3b8h7isE75a3OpzMmLVM+KHcIPjW87HJ
         H48Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtiSefmbR3+pT9sftPkF7mD69CDmiBYtX579eQqf4zsY6Of3yib2TQblm9W07PJqlHNFsGt7TIlpr6hjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+iQ2sQgk6GyFL4a1NYQce9Ry4pJpjT+FpUXhVEyrhJGA0QOw
	WF2wqiBzhpuVZVYz6iuYNKpB8PlXiWnjAnFrR8r9tTB69nyPsdx/q4u4tDe4NTDlktM7VA5Bgch
	ji50kf8un70zpEy9WHFW9TUpCw6O+t62iI0THWtxh
X-Gm-Gg: ASbGncsAXDIvwGDBVvlrvw3PoH9urxbqe3VLOsdHdORkpn6BYQsFESc3K1gHzrvNF5S
	8Ln05j5pdPALsLAfJph3Mem0SgtIROw87rWqQQcr5t3aRcjNXsFl8jWBEocYceJbrzE7oq1FtHu
	qoNAUgL9dmMpepix3LX0jGKf2sa5QvVW+QtaJsb1416Hrx1ql3I00f8tTrQyzZbvQHfFFW4GFa1
	3w3TOve7MgULO4nLQk3r+4IGT6e+fnI534uh40=
X-Google-Smtp-Source: AGHT+IFTgZDMvFHmjjPzgK1Fji+VGq66s9RspgwGr/T3ooHUEsXJrGoRHZnsVlLK0nC1vN2pF/wHZFESxcTNFee1OZs=
X-Received: by 2002:ac8:5cce:0:b0:4af:1f06:6b41 with SMTP id
 d75a77b69052e-4b0aee5c2bbmr162894701cf.59.1754926029195; Mon, 11 Aug 2025
 08:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
 <20250804-support-forcepads-v2-2-138ca980261d@google.com> <c7e398e92ecc75f05b575581e79d4cebfa8efb47.camel@gmail.com>
In-Reply-To: <c7e398e92ecc75f05b575581e79d4cebfa8efb47.camel@gmail.com>
From: Jonathan Denose <jdenose@google.com>
Date: Mon, 11 Aug 2025 10:26:57 -0500
X-Gm-Features: Ac12FXzy1BsmaPYFR1zQrb-XAlFj4H3YXVTyxhiF9usZrrs0vF9zsoXijGk5nc0
Message-ID: <CAMCVhVNb5N+KR-8+pSixKhH7SAOcbO7o1ewv7NYY3JB4gNn3ZA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] Input: add FF_HID effect type
To: tomasz.pakula.oficjalny@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Angela Czubak <aczubak@google.com>, "Sean O'Brien" <seobrien@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 3:34=E2=80=AFPM <tomasz.pakula.oficjalny@gmail.com> =
wrote:
>
> On Mon, 2025-08-04 at 14:11 +0000, Jonathan Denose wrote:
> > From: Angela Czubak <aczubak@google.com>
> >
> > FF_HID effect type can be used to trigger haptic feedback with HID simp=
le
> > haptic usages.
> >
> > Signed-off-by: Angela Czubak <aczubak@google.com>
> > Co-developed-by: Jonathan Denose <jdenose@google.com>
> > Signed-off-by: Jonathan Denose <jdenose@google.com>
> > ---
> >  include/uapi/linux/input.h | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> > index 2557eb7b056178b2b8be98d9cea855eba1bd5aaf..3ea7c826c6fb2034e46f95c=
b95b84ef6f5b866df 100644
> > --- a/include/uapi/linux/input.h
> > +++ b/include/uapi/linux/input.h
> > @@ -428,6 +428,24 @@ struct ff_rumble_effect {
> >       __u16 weak_magnitude;
> >  };
> >
> > +/**
> > + * struct ff_hid_effect
> > + * @hid_usage: hid_usage according to Haptics page (WAVEFORM_CLICK, et=
c.)
> > + * @vendor_id: the waveform vendor ID if hid_usage is in the vendor-de=
fined range
> > + * @vendor_waveform_page: the vendor waveform page if hid_usage is in =
the vendor-defined range
> > + * @intensity: strength of the effect as percentage
> > + * @repeat_count: number of times to retrigger effect
> > + * @retrigger_period: time before effect is retriggered (in ms)
> > + */
> > +struct ff_hid_effect {
> > +     __u16 hid_usage;
> > +     __u16 vendor_id;
> > +     __u8  vendor_waveform_page;
> > +     __u16 intensity;
> > +     __u16 repeat_count;
> > +     __u16 retrigger_period;
> > +};
>
> Wouldn't it make more sense to call this new effect ff_haptic_effect?
> hid_effect sound generic, too generic. One could say, all ff effect are
> hid effects because most ff apis (linux' included) are based on USB PID
> spec.
>
> > +
> >  /**
> >   * struct ff_effect - defines force feedback effect
> >   * @type: type of the effect (FF_CONSTANT, FF_PERIODIC, FF_RAMP, FF_SP=
RING,
> > @@ -464,6 +482,7 @@ struct ff_effect {
> >               struct ff_periodic_effect periodic;
> >               struct ff_condition_effect condition[2]; /* One for each =
axis */
> >               struct ff_rumble_effect rumble;
> > +             struct ff_hid_effect hid;
> >       } u;
> >  };
> >
> > @@ -471,6 +490,7 @@ struct ff_effect {
> >   * Force feedback effect types
> >   */
> >
> > +#define FF_HID               0x4f
>
> Again here, FF_HID sounds confusing without having the broader context.
> Constant, Sine, Inertia, Spring are way more descriptive. FF_HAPTIC
> would be a great name to distinguish such an effect. Or maybe FF_TACTILE
> with ff_tactile_effect?
>
> >  #define FF_RUMBLE    0x50
> >  #define FF_PERIODIC  0x51
> >  #define FF_CONSTANT  0x52
> > @@ -480,7 +500,7 @@ struct ff_effect {
> >  #define FF_INERTIA   0x56
> >  #define FF_RAMP              0x57
> >
> > -#define FF_EFFECT_MIN        FF_RUMBLE
> > +#define FF_EFFECT_MIN        FF_HID
> >  #define FF_EFFECT_MAX        FF_RAMP
> >
> >  /*
>
> Overall, I'll keep an eye on this as I'm slowly working towards a
> proposal for a revamped and extended ff api on Linux that would make it
> fully featured (we're lacking things like device control and querying
> effects and their status, arbitrary number of axes and arbitrary axes
> themselves).

Thanks for your review, your comments make sense to me!

I'll change ff_hid_effect to ff_haptic_effect and FF_HID to FF_HAPTIC
and upload a new version of this series.

