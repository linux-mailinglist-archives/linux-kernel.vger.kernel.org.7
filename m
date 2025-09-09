Return-Path: <linux-kernel+bounces-809129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F276B508F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B59917F5DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD126F285;
	Tue,  9 Sep 2025 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTRrEs6B"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690624BD04
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457875; cv=none; b=k08S1ip1R0OK4bn/zst1z9jEEKTnnaJNlU8jyWsvSNOtkbVSTfHz1zZtZoNlhRCee/da0ZPVRkVn4tyTJ9Gu978NN97qdNBj0U34okAbKPUfVO/3ST47KOJLyBI5DkmSnuRQJCbyeTBKcrAfHePeAdtlAl2dQKiYTQn37ONhO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457875; c=relaxed/simple;
	bh=fHEIhXL5J/DwZVzuOIC1PVUyNE5gy9b51HvDo9CjZp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG5JZjPKbixvkyyk2mwLuDYwPA1GRYKu4iz3+soozPJe89u33fGb17mwm+9DsQIRYgbpoNBnp7tLlygovPLFHnC8SrJUsNqlNVB8JhmvXCCUFZHo7Dj7NsHjMfJ/xaSWfNL7eIK6Nplq7IeyJd/gD7BOY2j85PcFWV/QsguTtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GTRrEs6B; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-329b760080fso6062727a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757457873; x=1758062673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4yfBU9AYetve95lMaxYZGTwSsv9zgxSypdrW9Vf/Ik=;
        b=GTRrEs6BpR+Bmqfzjf1h0+Re6XcSROBq82MLaOf8VHAEicRlpwGiEcfaU4jfj+m2ZU
         IwQeZuL30xUZbFTaHFP5BUgF0BRnUqazM6OqmkD/0H6YVDd/CKp1RCf/t5xCW32GO81F
         HvwBlgDFhYoQeD5EGvhbNTYeB4bDZU6K9gAqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757457873; x=1758062673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4yfBU9AYetve95lMaxYZGTwSsv9zgxSypdrW9Vf/Ik=;
        b=OglbP50OAwMKrQkouRYbtfQNxotHElNKqrv9sZ/gaHmmO/U8XRUs/Em7m3sHmH6lzf
         T8wkA1drM6mpAzUYIS1YurDW1AMrbf2PlKZKOAyWBtNIbHSD7z5fRhWB2evvDUCguULF
         zmfhsZ26OLFZWLvrQSye6Ipoqgvdf5Ul+CJ/tzu0+tkIgcSyqCQXkGGcDZctwMC/b8ic
         0lb22UROWDWlDLNvsYj9jmD1FcbesPnqVOwcEDWTtfPOdkvwtBPXtzx86063A+ZsVa7p
         hXgjhKZa70S7KfNs90LD+t2M4eSBpr9YtCz4H7zei4tzw3ko0fYfUnIbbnQMLf4sjGrm
         zbPw==
X-Forwarded-Encrypted: i=1; AJvYcCVEWabzAPbKw88vZwidzrNEhLM/VuF2qbns5GigmF/9tTLI2T1Ann4D3V6r9fiRe2iDBHEOqiNhCssM9Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfHweHT1AEBkKQe3da6cx0mR1svo06UcNShJjDIT+7IpFM5mG
	ls61fvp7MGsqW7gJShkckKm4DPFHiFwlj8lCwDxPB8J8TCvhhtrdoTHYdwBHOdr4tzOx4arXe1Q
	MVAg=
X-Gm-Gg: ASbGncszu09vKZwPX+FhngnbyoUSot27eT5eP9agrL625Rg1bLnW1oUd4FKQJ170xiD
	t1EkZMVCKrmN//N5FxX1NmzmxU3N2/mDXPelUiHwkmm9YzmrAI4s9pmjaH+Ejkku0LnxGJ4R9Bb
	2IwP99hxtv7zyB+GIwQOpEIGxmk9fzxqihfMl8BtDRm5mZ0tjNtMaGmMp/+hFzHgZaANagmHNvr
	8D1+egmWmE6vZnpyAiS+AKZ6OfC31Cs9NXsqYfkmKzPv1C+owbLHfGRvdRO33EpskXgRoQzztOk
	W6AOAUieKcISuBHdWFec90tlJOgCL2gPZksxd+difslBJL30wn1NqyI3IFiLzt5BuF3LC6IcuQ9
	N6hvzyJUhQrfJzlA4fDQNfZoXcbRL8UqgtwW+hdbOqT2R4ezvTTpJZK3eEi2b5exQ8ffm5QtoVW
	qb
X-Google-Smtp-Source: AGHT+IGY64YiG6x4PUk/zr64N7ouqs2Xo6feJbv/kzsCKIYgXdBLwpqw7OPh2W9iN+OTgRT3xaikpg==
X-Received: by 2002:a17:90b:1e4a:b0:32b:6964:1474 with SMTP id 98e67ed59e1d1-32d43f00776mr20239666a91.15.1757457873217;
        Tue, 09 Sep 2025 15:44:33 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32da897e2dbsm1356666a91.1.2025.09.09.15.44.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 15:44:33 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b52047b3f19so3663844a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:44:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUp+K5xk9HGB4MhGW3HrLVe/zRYXWXjgAZeN3K8VR25ghbfu78qT+mBsic9VQcuiDA36SSPHR9Kl+jVN4=@vger.kernel.org
X-Received: by 2002:a17:903:b0e:b0:249:f16:f086 with SMTP id
 d9443c01a7336-251718dbaf3mr161248035ad.42.1757457871970; Tue, 09 Sep 2025
 15:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=XWhDtFWegUUeACxcrSTFh7kbmwVFy3sioboh2fgk3Evw@mail.gmail.com>
 <20250909193641.236527-1-john.ripple@keysight.com>
In-Reply-To: <20250909193641.236527-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 9 Sep 2025 15:44:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WwYYQ67j9vTV-xYLcALPN3J3nj56PvEOOhMQ1T3sqJuQ@mail.gmail.com>
X-Gm-Features: Ac12FXw1reTwaSFLkM9n4dHmDjCjlmvWRm6UTmr6JNR-KB3ItUYGPK10m1cxbG8
Message-ID: <CAD=FV=WwYYQ67j9vTV-xYLcALPN3J3nj56PvEOOhMQ1T3sqJuQ@mail.gmail.com>
Subject: Re: [PATCH V2] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, blake.vermeer@keysight.com, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	matt_laubhan@keysight.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 9, 2025 at 12:36=E2=80=AFPM John Ripple <john.ripple@keysight.c=
om> wrote:
>
> Hi,
>
> >> +static int ti_sn65dsi86_read(struct ti_sn65dsi86 *pdata, unsigned int=
 reg,
> >> +                            unsigned int *val)
> >
> >This is reading a byte, right? So "val" should be an "u8 *". Yeah,
> >that means you need a local variable to adjust for the generic regmap
> >call, but it makes a cleaner and more obvious API to the users in this
> >file.
>
> The regmap_read function takes in an "unsigned int *" as the "val"
> parameter and I'm using it to return u32 values (which could probably
> be u8 instead). Would it be better to leave this as the more generic
> int type or change it to u8 so its more specific to this driver?
> If this function gets used elsewhere in this file at some point, I'm
> not sure everything that could be read would be single bytes.

Sure, the "regmap_read" takes "unsigned int *" because it's a generic
API. ...but we initialize the regmap API with:

  .reg_bits =3D 8,
  .val_bits =3D 8,

In other words, each read/write is 8-byte AKA 1 byte. So you're not
returning 32-bit values, but 8-bit values.

There's already a 16-bit version of this function:
ti_sn65dsi86_read_u16(). Reading that function and yours next to each
other makes it seem (at first glance) like yours is returning 32-bits.
It's not. It would be much more documenting showing that it returns
8-bits. If we need a 32-bit version for some reason we'll have to
actually write that up.


> >> @@ -1219,12 +1246,28 @@ static void ti_sn_bridge_hpd_enable(struct drm=
_bridge *bridge)
> >>          */
> >>
> >>         pm_runtime_get_sync(pdata->dev);
> >> +
> >> +       /* Enable HPD and PLL events. */
> >> +       regmap_write(pdata->regmap, SN_IRQ_EVENTS_EN_REG,
> >> +                    PLL_UNLOCK_EN |
> >> +                    HPD_REPLUG_EN |
> >> +                    HPD_REMOVAL_EN |
> >> +                    HPD_INSERTION_EN |
> >> +                    IRQ_HPD_EN);
> >
> >* Shouldn't this be `regmap_update_bits()` to just update the bits
> >related to HPD?
> >
> >* why enable "PLL_UNLOCK_EN" when you don't handle it?
> >
> >* I also don't think your IRQ handler handles "replug" and "irq_hpd",
> >right? So you shouldn't enable those either?
>
> The IRQ_HPD_EN documentation said:
> "When IRQ_EN and IRQ_HPD_EN is enabled, the DSIx6 will assert the
> IRQ whenever the eDP generates a IRQ_HPD event. An IRQ_HPD event
> is defined as a change from INSERTION state to the IRQ_HPD state."
>
> I thought that meant the IRQ_HPD_EN needed to be enabled to get any irqs,
> but when I tried removing the IRQ_HPD_EN and it doesn't seem to change
> anything, so I'm not sure what the documentation is trying to say.

IRQ_HPD is defined in the spec. It's basically an "attention"
interrupt from the panel to ti-sn65dsi86. It (and replug) are a
temporary deassertion of HPD while a display is connected.

See "Figure 17. HPD State Diagram" for a description of all these
things. Note that the min/max values there are (I think) because
sn65dsi86's HPD timings are implemented by a very inaccurate ring
oscillator.

If you see that "replug" or "irq_hpd" are needed then your interrupt
handler should do something with them.


> >> @@ -1309,6 +1352,32 @@ static int ti_sn_bridge_parse_dsi_host(struct t=
i_sn65dsi86 *pdata)
> >>         return 0;
> >>  }
> >>
> >> +static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
> >> +{
> >> +       struct ti_sn65dsi86 *pdata =3D private;
> >> +       struct drm_device *dev =3D pdata->bridge.dev;
> >
> >I'm unsure if accessing "dev" here without any sort of locking is
> >safe... It feels like, in theory, "detach" could be called and race
> >with the IRQ handler? Maybe you need a spinlock to be sure?
>
> I tested a spinlock added to the ti-sn65dsi86 structure that gets used
> in the ti_sn_bridge_detach and ti_sn_bridge_interrupt functions and it
> seems to work. Is there another spinlock created somewhere that I could
> use instead? Is using the spin lock in the interrupt and detach functions
> the correct way to do it?

In this case you could probably use a mutex since you're running a
threaded IRQ handler and sleeping is allowed. You could probably
create a new mutex for this case.

I assume you'd need some sort of boolean variable instead of just
checking if "bridge.dev" is non-NULL? "bridge.dev" is set by the DRM
core before your attach is called (and cleared after detach). Maybe
just have a boolean about whether HPD is enabled and only send the
event if HPD is enabled? Then use the mutex to protect access to that
boolean between the IRQ handler and the HPD enable/disable code?

-Doug

