Return-Path: <linux-kernel+bounces-720873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BAAFC18D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4F817ED2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16713241CAF;
	Tue,  8 Jul 2025 03:43:54 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0F23F299;
	Tue,  8 Jul 2025 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751946233; cv=none; b=OBp+CrrDr/+1MPHznYKpz5NMNIeaM8BH0mtgS/0ZEzjp5lg1SGTPn9MiyeQR1R37KchN87/Uy/O16JXtQcqkGz2pLKNhG/gUb8xFTmjEaf3N0zF4TQIK4frXqcMpKVNkAydg3iA6YyWjBtUcMhN/tx//OBDUT1RlUQiXy7eRmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751946233; c=relaxed/simple;
	bh=qDuUJYM1LJXP6KqTu/ry7W53Diu11Fscq4h73EvMeUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhGd/tQELV5fWMtXkKkcwZlnQCgHUAZdp7NwV8v5N1rkDQmNSKY/NRrSbBKUe3KpflC2K4+1ff/Vt9k0kNIV3LAgOghFOmms5ldrmtd1mdMDYfRAC9XHAgTYRzgKFJmtb8YP4gBAOAlXCjS2SAjr5TFTUg0tiJdQJ8qWah1x81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553b60de463so3920806e87.3;
        Mon, 07 Jul 2025 20:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751946229; x=1752551029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6qI+uivx+bnd0zwfJl1YVkWkeyiKKg4Fij4wbpWozY=;
        b=geKrkE/vVqDzh0dEEeQF0SGfPs5Eyp+sLQccuaH1xVBEcoC1tkUmQw/U5JLCYFmOno
         Zy9ZMkEottngDK+FFcbC5Q6aOtkWm/SJGwKv9/scp94BbU0EiaycoXrhrZTfCeL0OLnk
         LwBPhbPJPhRZ3p/5ZSHEvMbaC3YR3A2O/oNr5ew88CnHwbo0QsFmr8M09LH1oLAD9/zT
         J9VLO5I6uAmmjTtUM59XKLt2tcaCOY32ac7QGkbJMYM5qQHEzkAEdKA4kA1ifmbuBPmu
         iDiByr8J9Ee/qfOrpfu0dZfnxohGTiwaxMP7FP5gjgTM9ppje1w9zCVaedNovyRddZng
         4Kmw==
X-Forwarded-Encrypted: i=1; AJvYcCV2SJs8Wpdf6MU5oECCSSu473fAn7Nl4AvIq8YZq9bxneC1+9kibR7TI9rrsS3vLFScs5GEqnKFhMUuYHtF@vger.kernel.org, AJvYcCVqVH6ZE4HYHyebpPazpgtghVjdzizqD1lilERv4Hod8xXgUQ/vXOWsIY6qKegq8q8OzKikWDT8EaKh@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyB+S/GRGTzNwDG5IslTrrZoP+fZdFR/2onboHBZDMYh+tpHv
	fkupW9lW7ot/oiGE6SZXMysMgL4Dh9JlgxFQHBB+jxxxMsZGdDnQ+rNRJfHZTEAB
X-Gm-Gg: ASbGncsC4h7U7mUOHdw4g5yKgbGGb1okvcnUTfn4ogSAsZ0zrbkce86+yqYo34vMt+w
	kEibXMs9gOcKWxNnE8+RFiUdAxO071FNH1WwzhU3zhHGDm+A4c+QXt57bWKmulTl4cLyHmKm+Co
	ozgrRr2tkh9TD2XmZSGLrO89NmEAQAroVolPyydkYy7t6Bv6YO0XT9MECg/lCsAWEEVDdmuSw1R
	WKa5wDlH7S6xkOfJwADYDClJPwFg2oLHtHIyV9JCLma04cusLXAL10WqPySMB0SrkjFo/szjFlI
	b1/Jr+j84aaFReo24JH6OkP/9hFIpqdWo5g/GKVVdOb/IeFd92oJ9q+MdOXHWo9qikb8FNXm1es
	Jul7IWvblEOkYs3iVPy4=
X-Google-Smtp-Source: AGHT+IE8YUmqN4BJzAHjcnKofP+uppUq89PP4L59a6IvpS6GAOkgKsw6DMoAPPV00+8yAKehSQN1nw==
X-Received: by 2002:ac2:51d1:0:b0:554:f9c5:6b30 with SMTP id 2adb3069b0e04-556f13b0a35mr5227882e87.38.1751946228593;
        Mon, 07 Jul 2025 20:43:48 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d31a6sm1529494e87.61.2025.07.07.20.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:43:48 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b7123edb9so43943691fa.2;
        Mon, 07 Jul 2025 20:43:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+cc5nkfmOs2Z107xAfhupN2P6oZkssIe9wzB6T5HDIVr4nI5E5VNqrxsF6UDXsR9P6ab9GpeQaBm3JJ4B@vger.kernel.org, AJvYcCWQxhXm6syhQYRxqSo664nXPKWVGiGWdLFB7Pxj71sBmCrY29YYz8jobVOKot+1z1wgWmenRb5Wo8iR@vger.kernel.org
X-Received: by 2002:a2e:a7ca:0:b0:32c:102a:f02d with SMTP id
 38308e7fff4ca-32e5f61e89emr40266751fa.30.1751946228111; Mon, 07 Jul 2025
 20:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706025625.2707073-1-iuncuim@gmail.com> <20250708004458.15a2feae@minigeek.lan>
In-Reply-To: <20250708004458.15a2feae@minigeek.lan>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 8 Jul 2025 11:43:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Pu7CTJx3K=3CVSbQ9mNB-4Vrq+iaA+hUWtxdwS2aD0Q@mail.gmail.com>
X-Gm-Features: Ac12FXyZmm99FipGMPnPhGzlT7tlbKyfxwlUr8RD3z4V1vxu7PoX_X4yAfDEgUg
Message-ID: <CAGb2v67Pu7CTJx3K=3CVSbQ9mNB-4Vrq+iaA+hUWtxdwS2aD0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: sunxi: a523: Enable Mali GPU
To: Andre Przywara <andre.przywara@arm.com>
Cc: iuncuim <iuncuim@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 7:46=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> On Sun,  6 Jul 2025 10:56:21 +0800
> iuncuim <iuncuim@gmail.com> wrote:
>
> > From: Mikhail Kalashnikov <iuncuim@gmail.com>
> >
> > This patch adds gpu support on devices with a523 processor. Since there=
 is
> > no support for image output yet, the gpu is disabled after boot up.
> >
> > $ dmesg | grep panfrost
> > [    3.826968] panfrost 1800000.gpu: clock rate =3D 432000000
> > [    3.832305] panfrost 1800000.gpu: bus_clock rate =3D 200000000
> > [    3.838353] panfrost 1800000.gpu: mali-g57 id 0x9091 major 0x0 minor=
 0x1
> >                status 0x0
> > [    3.846050] panfrost 1800000.gpu: features: 00000000,000019f7, issue=
s:
> >                00000001,80000400
> > [    3.854134] panfrost 1800000.gpu: Features: L2:0x07110206 Shader:0x0=
0000000
> >                Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> > [    3.866011] panfrost 1800000.gpu: shader_present=3D0x1 l2_present=3D=
0x1
> > [    3.874108] [drm] Initialized panfrost 1.3.0 for 1800000.gpu on mino=
r 0
>
> So what confidence do we have that this really works, apart from these
> successful initialisation messages? Has this been shown to work with
> some (yet-out-of-tree) DRM patches, to produce 3D rendered output? I
> wonder if we should wait with upstreaming until we can really test this
> on some kind of screen.

I ran glmark2-es2-drm using vkms, and it seemed to run correctly.
The GPU job interrupt was triggering frequently, and the GPU mmu
interrupt was triggered twice for each run. This was with Mesa
25.0.2 from Debian bookworm backports.

So this is sort of

Tested-by: Chen-Yu Tsai <wens@csie.org>

If anyone has some idea about how to capture the output, I can give that
a try.

> Cheers,
> Andre
>
> >
> > Tested on x96qproplus and walnutpi 2b devices.
> >
> > Based on v6.16-rc4 with patches:
> > https://lore.kernel.org/all/20250628054438.2864220-1-wens@kernel.org
> > https://lore.kernel.org/linux-sunxi/20250628161608.3072968-1-wens@kerne=
l.org
> > https://lore.kernel.org/linux-sunxi/20250627152918.2606728-1-wens@kerne=
l.org/
> >
> >
> > iuncuim (2):
> >   arm64: dts: allwinner: a523: add Mali GPU node
> >   arm64: dts: allwinner: a523: enable Mali GPU for all boards
> >
> >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi    | 15 +++++++++++++++
> >  .../boot/dts/allwinner/sun55i-a527-cubie-a5e.dts  |  5 +++++
> >  .../boot/dts/allwinner/sun55i-h728-x96qpro+.dts   |  5 +++++
> >  .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts  |  5 +++++
> >  .../dts/allwinner/sun55i-t527-orangepi-4a.dts     |  5 +++++
> >  5 files changed, 35 insertions(+)
> >
>

