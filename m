Return-Path: <linux-kernel+bounces-820175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D9B7E02E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A81E189793D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7EB30149C;
	Wed, 17 Sep 2025 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkkyvL+g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388D27A907
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095389; cv=none; b=CuVFM7/zQwVKu2ENyGrofC8m7pK6eKgZcZI7u9rrgABBqcw6D9WSQtVZ8zP9lbqfGHQYbN67VTM8FB0pmGPjOC7eN/ioY39NQ5hY4iBACq7UmOpB+Z9+TiCMD9I9HEYgcKOnLQAnYRLZOXYtBkJ0rb21axXSIaJasZf9pzq1kQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095389; c=relaxed/simple;
	bh=FTOYZyZlQbr9msNJypX5dkpxLMn6Qy9HuPMiesCA/SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWA3//thFUQGzQsEd2Z9VOHkCNG+BRtre8ngPn6pgQGVGbMpWYI+NZQgGmDhCGueGxmNev8vVBkOJhStMt1/M25qHBxi5/X7JKN+rsQxTCtmgUYcxEvjUU6icTkyltUrq4GS/Yaclk6SYKkMlA9k/ucjPwshgAzkv7rU4z/a0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkkyvL+g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so21200875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095386; x=1758700186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBfFDRiXr9nEpDXh/89ReC7/hr9ub6V/By4vj+1KU5c=;
        b=mkkyvL+gSEACYeH6/0MiF7d6iO3atBxUM5EghQiZoM7QeLRQAMDSPG3dg6xGnJZBwL
         mH6XDK2NZlNv+huONTdke3x6wHXBRam/rKPXiZ99GFIHSzEGmveGXtzSfRtVI8c2NOcm
         ry4vR/cKJFNXym18Kgn7aU9vmVPoEtpY0+Zejn/7soQDzkko3EngPM29PAzDx43HExl2
         v7E+I+Prw5dY3EHcbvbOUAk9wlLdt+y29IF+axxKPhVcLVnbhdEoLRiP0o7gLSGCoLAi
         Oi9uImsS4w860UU5Cs+i4VxQZ3TDCwfZsC/Xmd/h17PW4TCp3Oz1fEGQsy6SCaXvsPZI
         9Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095386; x=1758700186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBfFDRiXr9nEpDXh/89ReC7/hr9ub6V/By4vj+1KU5c=;
        b=ba8TXG4e9whDc/FyVWuNpQs4JzECJufetAdP61HYGF7a+AvZapDN6ZGhjJKZS/kDR6
         nE7aju0KwvTvZpb0ITpZZBun9eHHD9K1xMTSBS7FbPhn+slt9iCDe61IwyCbyfqTnbi2
         NVgTqETXteKVf2niJyprkIDOFxnDLnJrWrpKl4S8m+CZ2/pRDZd7yA6eX6wp2n0gF2ff
         uy8H7qgoWLkxv+XteZTliBITcGEaZx1VNfuSl0oZNb4H/r6iaVsEMkrfeyytIPTTk1L2
         /rN/06ymNKkg4Eq7VuiNzcfB+EOFQ0bDsnXjLgUyY7fVG7JbHmB1YNAEeHjYZKglcsr/
         PzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWafEZvq5N8lksDxRfzA8m05B/C0UmrEUORDPUN3x4Cax5EI3T9DiPjeOIO2tGJE3xYxZfaeo/RHZngUSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzinWF8iYILCgGxv6wUUY8fjU2ky6W/sL8EfpSTfpvH7r4CWkke
	fFFDbtPWHWUWhT7lueDLbxlkMP8psrDhCg0Hxu74mimMlwzn5LZCtPMEmKW9jOCT0olQ5XjqzGb
	GJxB9SohAQx56qmbR0kcVP5ropPHNbP5h5fyM
X-Gm-Gg: ASbGncvGRfHfCgF080+i7ZbJTC49Vl2TZGD5LJ3XqZt4KEqudKO451OVE5WCqZhZlKu
	ntRdpMomIpYXDOptmk3iaSNBzTLOX2Q6Gm12vzZPMcA7aEeeOUlTaNIxnmTguCCwRgDNCTyCakn
	F1HCqDo4xWGrqNQs89GkGEZOphBHtfNFjlRs/7zpMQGNGNeuS1YIpuNwvgVSTDiKwv5BhI5WYPi
	DOkVO3c
X-Google-Smtp-Source: AGHT+IF3lmE+Hj7uILLuG4qQmCcnlTdBQLcIILWDDReW6OA5JNsKz4AMqTaBfvmWdQByd126wN9UY2EbvRJzOucYNL8=
X-Received: by 2002:a05:600c:354b:b0:45f:27fb:8014 with SMTP id
 5b1f17b1804b1-46202bf79b6mr10547375e9.3.1758095385572; Wed, 17 Sep 2025
 00:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906135345.241229-1-clamor95@gmail.com> <20250906135345.241229-12-clamor95@gmail.com>
 <20250916180418.3fa270a9@booty> <CAPVz0n1Nvun5yBf_i3NB=kDmLfNFRjbFt1uTUW-hpLbp-h0g4w@mail.gmail.com>
 <20250917092506.311c314c@booty>
In-Reply-To: <20250917092506.311c314c@booty>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 17 Sep 2025 10:49:33 +0300
X-Gm-Features: AS18NWCKU4rZnTXxdA0a9QfyHpWTdRZtRMYt7KcgyNP1Kv6yaXuQBbEuLGoNYco
Message-ID: <CAPVz0n3u1N5NHKYE6d_wNqe=tJ2K10c32YuSnusKDV9+iO5yCg@mail.gmail.com>
Subject: Re: [PATCH v2 11/23] staging: media: tegra-video: csi: add a check to tegra_channel_get_remote_csi_subdev
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Osipenko <digetx@gmail.com>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Charan Pedumuru <charan.pedumuru@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 17 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:25 Luca=
 Ceresoli <luca.ceresoli@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello Svyatoslav,
>
> On Tue, 16 Sep 2025 19:24:52 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=B2=D1=82, 16 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 19:04 =
Luca Ceresoli <luca.ceresoli@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hello Svyatoslav,
> > >
> > > On Sat,  6 Sep 2025 16:53:32 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > By default tegra_channel_get_remote_csi_subdev returns next device =
in pipe
> > > > assuming it is CSI but in case of Tegra20 and Tegra30 it can also b=
e VIP
> > > > or even HOST. Lets check if returned device is actually CSI by comp=
aring
> > > > subdevice operations.
> > >
> > > This is just for extra safety, or is there a real case where the lack
> > > of this check creates some issues in your use case?
> > >
> > > > --- a/drivers/staging/media/tegra-video/csi.c
> > > > +++ b/drivers/staging/media/tegra-video/csi.c
> > > > @@ -445,6 +445,22 @@ static const struct v4l2_subdev_ops tegra_csi_=
ops =3D {
> > > >       .pad    =3D &tegra_csi_pad_ops,
> > > >  };
> > > >
> > > > +struct v4l2_subdev *tegra_channel_get_remote_csi_subdev(struct teg=
ra_vi_channel *chan)
> > > > +{
> > > > +     struct media_pad *pad;
> > > > +     struct v4l2_subdev *subdev;
> > > > +
> > > > +     pad =3D media_pad_remote_pad_first(&chan->pad);
> > > > +     if (!pad)
> > > > +             return NULL;
> > > > +
> > > > +     subdev =3D media_entity_to_v4l2_subdev(pad->entity);
> > > > +     if (!subdev)
> > > > +             return NULL;
> > > > +
> > > > +     return subdev->ops =3D=3D &tegra_csi_ops ? subdev : NULL;
> > > > +}
> > >
> > > I tested your series on a Tegra20 with a parallel camera, so using th=
e
> > > VIP for parallel input.
> > >
> > > The added check on subdev->ops breaks probing the video device:
> > >
> > >   tegra-vi 54080000.vi: failed to setup channel controls: -19
> > >   tegra-vi 54080000.vi: failed to register channel 0 notifier: -19
> > >
> > > This is because tegra20_chan_capture_kthread_start() is also calling
> > > tegra_channel_get_remote_csi_subdev(), but when using VIP subdev->ops
> > > points to tegra_vip_ops, not tegra_csi_ops.
> > >
> >
> > Your assumption is wrong. 'tegra_channel_get_remote_csi_subdev' is
> > designed to get next device which is expected to be CSI, NOT VIP
> > (obviously, Tegra210 has no VIP). It seems that VIP implementation did
> > not take into account that CSI even exists.
>
> IIRC it's rather the initial VI implementation was meant to be open to
> supporting both VIP and CSI but some CSI assumptions sneaked in. Which
> is somewhat unavoidable if only CSI could be tested, isn't it? So I had
> to change some when adding VIP (trying hard myself to not break CSI and
> T210).
>

It may be initial VI, that is not that important since my goal is not
blame anyone but to implement stuff I would like to see working. If my
words offended you, I am sorry for that.

> >  -19 errors are due to
> > tegra_vi_graph_notify_complete not able to get next media device in
> > the line. Correct approach would be to add similar helper for VIP and
> > check if next device is VIP.
>
> I think it's almost correct.
>
> tegra_channel_get_remote_csi_subdev() is called:
>  * in vi.c, where it is expeted to return either a CSI or VIP subdev
>  * in tegra210.c, which apparently supports CSI only
>    (I don't know whether the hardware has parallel input)
>  * in tegra20.c [added by patch 23 in this series] where only a CSI
>    subdev is wanted
>
> Based on that,  you're right that we need two functions, but they
> should be:
>
>  1. one to return the remote subdev, be it CSI or VIP
>     a. perhaps called tegra_channel_get_remote_subdev()
>     b. perhaps in vi.c
>     c. not checking subdev->ops (or checking for csi||vip)
>  2. one to return the remote subdev, only if it is CSI
>     a. perhaps called tegra_channel_get_remote_csi_subdev()
>     b. perhaps in csi.c
>     c. checking subdev->ops =3D=3D tegra_csi_ops
>
> The function in mainline as of now complies with 2a, 1b, 1c, so it is a
> hybrid.
>
> In other words, what I propose is:
>
>  * rename the current tegra_channel_get_remote_csi_subdev()
>    to remove the "_csi" infix, so the name reflects what it does
>    - optionally add the check for (csi||vip)
>  * add tegra_channel_get_remote_csi_subdev() for where a CSI-only
>    subdev is needed: that's exactly the function you are adding to csi.c
>    in this patch
>
> Does it look correct?
>

Yes, if this was your initial idea then I must have misunderstood you,
you are correct. We can agree that each VI source should have its own
get_remote_device function since VI configuration cannot be agnostic
in relation to the source. ATM since only CSI and VIP are supported we
can have only one for CSI and use VIP as default option, which is
fine. Meanwhile, since core VI configuration (vi.c) does not perform
any specific operations with VIs source, we can leave
tegra_channel_get_remote_csi_subdev structure as is, just call it smth
like tegra_channel_get_remote_bridge_subdev and use it in vi, it will
get any VIs source device in the pipe regardless of its type.

> > Since I have no devices with VIP support
> > I could not test this properly.
>
> Of course, no problem. I can test it (but I cannot test CSI).
>

Good, CSI is not an issue, I am always checking if it remains functional.

> > I can add this in next iteration if
> > you are willing to test.
>
> Yes, please do, thanks.
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

