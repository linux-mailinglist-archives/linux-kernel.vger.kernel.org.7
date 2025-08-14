Return-Path: <linux-kernel+bounces-769073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E960B269F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46AF5E8335
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0262208CA;
	Thu, 14 Aug 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQuL1dcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3613635E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182073; cv=none; b=o+ayNojMZ9i2BCc2GOZWhChkeJ0CEBtH9oe3aY64yExKlzGAU2zw51wwz+YGD5TtzuzUfi+TpQ4BWiV8dvPasZ7ulEMn3UiQfyyDw67xRb+gaGz5a5N8Gzl+CHg1pO0yVHdgrOTJqcNovVWSEDmVdi8qMF0Qj4SYteQNmXMeM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182073; c=relaxed/simple;
	bh=v5M0Qos1gNG9BhySlvlZJoHLGeHj6L3mYrNuRgeHmNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlbCVqYngiMd6O+TJGjm0nMGh68e9YmI3mv+tK/lFQztHoVgFU9UneYlapUt8DMbzQ3Uy5/sZIqC3iZTB2zyt8G2BynIEB/4VvZZ2HBEXxib1MxMKHxPVzze6bQWWsLZU4KEmGNpk9pQahtO0/twz8cqRQOZJTKEh7ak6Z/g6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQuL1dcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7D5C4CEED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755182072;
	bh=v5M0Qos1gNG9BhySlvlZJoHLGeHj6L3mYrNuRgeHmNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lQuL1dcfA9Mh6kS+gpg/fIYiacslravvCVw6R20RG0t2oFKNFR8Nl622gdyMn6wmJ
	 knWfr+Ohdof410k4MScHUh2oM+RCxxvJFYcCG9cV4q1zE7pdO4w++3gOEcvBytXuWF
	 yuIF+9ELzArxsSVTyDi4wgrb37Bn+eq5SMH0fRZLDKLlFKKyEmqSwSgruCptRptaZm
	 KF2v42p6XWvW8BUyH1HrqzuVkmtphWs5FzzX7GbB0usgPipI0PGnwR62+U66hMRNDW
	 ExQQ4KhIZON93Vv2DqFAfTU8grgfHdZIPiolbgN8AfxyIPsYXyhR66BnepgDrpzeSH
	 /hDeXieIhlwwg==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso1025369a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEJC+kTRaNPqSleiQQFJgGjzoQmWJ9cZOonfJyN5/ILEVqkBZZzsVS676a3Mr1HegPx/2B2E59tgo6Lkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+yIUJYO5cSnSLxLEvtGoBm4dRzM7+KOKbYgsq53yulXzywpP
	pG0+q5EfsorLG3ZQvrjtY06YUen6HvROP5m9EQne9T2+Wi4fzNT679G37vZfKnjJUHpJ4u/Gv8L
	/XpC/6qchq/V2AQF6hWMWNubaykn/UQ==
X-Google-Smtp-Source: AGHT+IFZBGHiyx4R8I0ZtPt03HyzJ/h+SHoNTrWb26RWZtlcu/LuBo3basMRoZchAXRPaCN5XUhmJgnvc08y4GlhQHw=
X-Received: by 2002:a17:903:1ae4:b0:23d:f986:6472 with SMTP id
 d9443c01a7336-24458a65075mr40000145ad.25.1755182072478; Thu, 14 Aug 2025
 07:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8a64686-f1a2-44f1-9d13-fd5b4f923e0f@molgen.mpg.de>
In-Reply-To: <c8a64686-f1a2-44f1-9d13-fd5b4f923e0f@molgen.mpg.de>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 14 Aug 2025 22:35:41 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8vLqU30L3+ijYJPLrioRsUwVwJAeumtVYfRJ9e5tjp4A@mail.gmail.com>
X-Gm-Features: Ac12FXy0NDb8BGMAM7k-PNcb_9DgKIcM0T0DGazslGHWEE6YexmPG9CoPZcHXNE
Message-ID: <CAAOTY_8vLqU30L3+ijYJPLrioRsUwVwJAeumtVYfRJ9e5tjp4A@mail.gmail.com>
Subject: Re: MT8183: Only maximum resolution 1280x720?
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paul Menzel <pmenzel@molgen.mpg.de> =E6=96=BC 2025=E5=B9=B45=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=882:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dear Linux folks,
>
>
> On the older MT8183 device Lenovo IdeaPad Duet Chromebook, running
> ChromeOS with their Linux 5.10.x, connecting a 1920x1080 Dell monitor to
> a USB-C adapter using HDMI, only the resolution of 1280x720 is
> configured, although the adapter also support 1920x1080. It happens with
> all adapters, for example, LMP USB-C mini Dock [1].
>
> I reported it to the Chromium OS issue tracker [1], and the last comment =
is:
>
> > It seems the display pipeline for the internal display (DSI) has
> > higher clock rate. Also, the resolution support depends on the
> > refresh rate as well, so the claimed 2400x1080 might only work on
> > lower refresh rate.
> >
> > For the external display, the display modes are mostly rejected by
> > the pre-defined max_clock_khz in mtk_dpi.c:
> > https://elixir.bootlin.com/linux/v6.11.4/source/drivers/gpu/drm/mediate=
k/mtk_dpi.c#L940
>
> Can you confirm this? The font rendering seems not so good in the lower
> resolution, and strangely, playing movies these seem to be rendered in
> higher resolution (or the monitor or hardware does a good job in
> up-scaling).

8183 max_clock_khz is defined in patch [3] by Rex, but this is a
prepare patch for mt8192 [4].
I'm not sure that Rex has test it for mt8183.
Maybe you could try to enlarge 8183 max_clock_khz and see.

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek/mtk_dpi.c?h=3Dv6.17-rc1&id=3D44b07120291c4b7a67=
22ccb7149f6b9d938cf5a2
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek/mtk_dpi.c?h=3Dv6.17-rc1&id=3D38eaef2dca4ec8dfb9=
ea84d9dde0f76da5c8caaa

Regards,
CK

>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://lmp-adapter.com/product/lmp-usb-c-mini-dock/
> [2]: https://issuetracker.google.com/issues/295666708

