Return-Path: <linux-kernel+bounces-773990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A395B2AD50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A048468756A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301D320CD4;
	Mon, 18 Aug 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkiZiFm8"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEA321455
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531972; cv=none; b=RIowKskUVbc7Y/Pc9T42H0wJlJJV7JBFJy62mFvbtU1KA9DwdrOEP31GLVIcxMxAJkVsSYaIYu25/f3tn1qqNzgw0LeHED4txntrA8ouHJeUo1bXezTt6v3TpKhSyvyYihDdP1P+QhktbSPmMo/wfU+6SPaWjn1k0BYZ9gk/whA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531972; c=relaxed/simple;
	bh=FxHr6cWcJyl9Gy9CK27ObVGVSKhIH1BuiovYHEEKEpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLIDfOqQHtGm1R9xtrdZA4gT+hgX2UGsXBgX2aqbSvaFPDmr7KJTDg2mqq+il6bqljprLyMaS5LGOqU0wS0zM6K1RWqztf+o+cRrVySi4AtcP1ORfDzdv5nxwNrONmu1W3/9qbLTLBr7whzpKFzpN+yw43rIx1lUMcNNYmCmnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fkiZiFm8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so2628542b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755531965; x=1756136765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL4a5MAx53SYD7+WOx5HJxIWAtu+xXDJ6eJQwEroQJM=;
        b=fkiZiFm8MvHnLHUU+Rnk2Fl2GRSylLVhhMtjP6bBbbj5jZ8NKbdckAQarOScnkGMH+
         MhfuU2GD+SGY6njBNi+zRr7CT1LbTVM/3Bl/TA43dOcnP8sccZKZBgo/zxkGNg2Ivryu
         s3g+bGUtw5au36pZhyMqtO8C3cksNhFSngrCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531965; x=1756136765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL4a5MAx53SYD7+WOx5HJxIWAtu+xXDJ6eJQwEroQJM=;
        b=GsxTpi7zZkmezBsSdtxABXnbip5k8yGKkcO86Av9VCibn0uu/75POVrE2vUhMtcoTP
         bRISX6BaeuzPy8Au0TXCPkGbSsT5XPMWK11BQOGxS5yWDq5+jUo9qasNSedYmIHDE6tL
         t92d5R3C/7y9Zba+YhbjZiG8E28/+x+jW237xRNGE2BMHUJRj45qsxBaAti4fKySV91h
         /iAbVnCuC/uVB3yg/3lVTkzBQd/eaj60mD37+maLNOb9paFOGZD+1vy2IZMQICPxwF3z
         yp3C6dEhvddLoojuFgAttKB0i0oz7A2LHUL32n82/mdOk0Jc7RUaYI8xmhhVHvpr3pUs
         CM7A==
X-Forwarded-Encrypted: i=1; AJvYcCUytC1Vp70eBXJAuO0SbQbK7aM19WUDNarJLenX0WbFx1wyOiFNO5vwWBkbYDJitIlmSVO8U3KGsamoZl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqVRNZ51hy8/xvjsmK1B2Ywo4Gp5tJd3TsqQr/bn02/uAPLBd
	3eOtB0nm3bl/HR+PfPvLY8hYhIJhYJYyNu1+6E7ohW68NmzbZA8T3X0Uxc8ddrO2UStBxPFzGSV
	EkUg=
X-Gm-Gg: ASbGncs9AqNv9X0CaEz3PeEUuSwf1RZupawRQikxgjNVeiqK5WJV4pC/2RLUKxRvzKP
	dSGN1Iw4jzih1+XqvpUJoG9KFmG7X6AGHYIzIDG8KJIqTK3hT5/3NLJoLJm97WC6DQWJPrbSNAL
	tYVAzCkr5J97k5GKiAa+ZwCpzKyO79q1ZEnLv1FwaMyUbZhbU0i9G9X/67rqhE1yNy/Wf1jsYI/
	Lj8PYXGU27SlbzYVzDWxQWNQRl1R4HOSJ9Pd1DoACwrXOCNnWYn0Nfx65cxTFAZ1VAKo1vTGlwF
	0FE9am5quGef+fP5f9CgGtvcz7xkndXf4BGK4TNnmUaV7aDIv2ty0T9y53KnBZgmZa7SoafTDCb
	RzDztxeRZwn5rfqgcV0r3J3h2HGI9HCoglKE1bcq276wjhYycwfeN5tmDOnIL+PBQNA==
X-Google-Smtp-Source: AGHT+IFjVdnrvUzxzPnD641JngNSOFN6JlxHG2a51KY7sOM6Ybh+PNlg4OFPVLTggqStx3evc4M6zA==
X-Received: by 2002:a05:6a20:7348:b0:240:21e1:cbb9 with SMTP id adf61e73a8af0-240e63732a5mr14417263637.36.1755531964778;
        Mon, 18 Aug 2025 08:46:04 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4752228154sm318440a12.24.2025.08.18.08.46.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:46:02 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4716fa7706so2955232a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTHbDb+DyLmxsJPtk5fUjskCaIOc8q00lwhxRdw2RXxHPivHkzA9cz9dRQsfKvu3F2tIqRem57DivAT04=@vger.kernel.org
X-Received: by 2002:a17:903:22cc:b0:234:8a4a:adad with SMTP id
 d9443c01a7336-24478f71be3mr130935345ad.26.1755531961668; Mon, 18 Aug 2025
 08:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813125132.1319482-1-treapking@chromium.org>
 <20250813125132.1319482-2-treapking@chromium.org> <CAD=FV=XmMwocA_oZVi2OS2Z4+5LBT4BXZE2C1mx1U-Tcs+5SOg@mail.gmail.com>
 <CAEXTbpcTJVCqR-NAfddd2H9oLUitcUi3XnX1GQf7hA06-Vx9UQ@mail.gmail.com>
In-Reply-To: <CAEXTbpcTJVCqR-NAfddd2H9oLUitcUi3XnX1GQf7hA06-Vx9UQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 08:45:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UV8_XGmxC=7Z18PEnj6wKz+yZQuV_4h+LJh_MNCqszvg@mail.gmail.com>
X-Gm-Features: Ac12FXw4q2jsZWPukvpps6uXMC47W9riQkJS9EcpIvFu79iTZtix4Q66btupXkE
Message-ID: <CAD=FV=UV8_XGmxC=7Z18PEnj6wKz+yZQuV_4h+LJh_MNCqszvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: Make elan touch controllers power on after
 panel is enabled
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 4:49=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Hi Doug,
>
> On Fri, Aug 15, 2025 at 8:27=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 13, 2025 at 5:51=E2=80=AFAM Pin-yen Lin <treapking@chromium=
.org> wrote:
> > >
> > > Introduce a new HID quirk to indicate that this device has to be enab=
led
> > > after the panel's backlight is enabled, and update the driver data fo=
r
> > > the elan devices to enable this quirk. This cannot be a I2C HID quirk
> > > because the kernel needs to acknowledge this before powering up the
> > > device and read the VID/PID. When this quirk is enabled, register
> > > .panel_enabled()/.panel_disabling() instead for the panel follower.
> > >
> > > Also rename the *panel_prepare* functions into *panel_follower* becau=
se
> > > they could be called in other situations now.
> > >
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > >
> > > ---
> > >
> > > Changes in v2:
> > > - Rename *panel_prepare* functions to *panel_follower*
> > > - Replace after_panel_enabled flag with enabled/disabling callbacks
> > >
> > >  drivers/hid/i2c-hid/i2c-hid-core.c    | 46 ++++++++++++++++---------=
--
> > >  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 11 ++++++-
> > >  include/linux/hid.h                   |  2 ++
> > >  3 files changed, 40 insertions(+), 19 deletions(-)
> >
> > This seems reasonable to me.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Given that this affects devices that we already had support for
> > (you're changing the behavior of two touchscreens), should it have a
> > Fixes tag?
>
> I'll add Fixes tags in the next version.
> >
> > We'll also need to figure out a process for landing the two patches. I
> > can easily land the first one in drm-misc-next, but then it'll be a
> > while before the i2c-hid one can land. Is it OK to wait?
>
> I'm okay with waiting for the next release for i2c-hid patch to land.
> Or should will ask the HID maintainers to ack this patch?

I'll also respond on the v3, but probably the easiest is just:

* I won't wait for a response for the HID maintainers before landing
patch #1 into drm-misc.

* If HID maintainers don't want to Ack the patch for landing through
drm-misc, we'll just pause landing of patch #2 until things percolate
to mainline.

-Doug

