Return-Path: <linux-kernel+bounces-767840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE9B259B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2891C25A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E43321CC59;
	Thu, 14 Aug 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG9ByopZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7907146D45;
	Thu, 14 Aug 2025 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141027; cv=none; b=GYhNA9z+YKkPOm305oHZauI2zxD/SSuC90QKtddDw6tmMYKWIf/HZg0GEqyV5UMxmbls9GqwaJAGUbYTWknGZGEgA2sf4Tn5Y8r97H+vQOCTcHaLvJ0R4taO4Sw4QotalOwkZWvy1ASrKJluAl6CU9onl3D/V1kvMTLEC6ML+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141027; c=relaxed/simple;
	bh=EhxvoJDEdXNbO/JDpXEfw4ZJIF5Vn/4NQDHkXy07FqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/a05Bu4HJc+ynKLHd+CtUOBNdYMG9Cyd7TNp1Rv6BRKt6MRBJyL0uZBcOYRbjKXsDPhDflkiO+Bk61kEpaSqAZCGekKDQknvUyIZRQ+uwejqZmYjwPxHUpvNhfjpTvIzlWYnQlWUg+SDaVBYRw5F8YV+fpLZPGFe0iTI8vvAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG9ByopZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA512C4AF09;
	Thu, 14 Aug 2025 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755141027;
	bh=EhxvoJDEdXNbO/JDpXEfw4ZJIF5Vn/4NQDHkXy07FqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZG9ByopZuGdSahvikX0tCjBFYrv7xOhabC18u4E9Qs2PlOZdqyi6n3zWvSdJsoTZd
	 lMhn3f+d0aa92E2oMamfzljPHVsMyztnGv0HWFoo6QzVhGqu1gFPrhYZcbtF0HnFcG
	 w87nnptjVwQYvjXqFImxw+v9/jtduG8kL3jX8xOwtQVJva7dE7MMgVjaMfMdIk4fHy
	 3nbxM65f32o+Nkcz0bcGAg4WpvWLEzCweTroLKWZITpSFnGTc60LZZsRq0oPBfLCBh
	 JhdrdqFcbYBgnxOk7VxS723j/ZKRy3QKWcC0C2UDxJqCm5Scoen8uibgLwplKWEZen
	 sPQycJMV2+iJg==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso388272f8f.0;
        Wed, 13 Aug 2025 20:10:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJtVr/eV/fQoRtjP/L5uuVGM35zoT0WaTzyOR/soXgAystm6BNC7o9sC1hNAzNwL+t66HOw3BuA9kZjaY6@vger.kernel.org, AJvYcCX0mnSAH58Xli0j666BAuCbA6ydmm8MGWDJM+15fbEvTz/SkMfdLyBU3zeJRQEsJjqJ00NMWHKT9Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOiVWFQn13wByk7vjjAjJrpzzuWI1yKZQhvVsbPfA7cJi9KPA
	kYLb5LYco7CXNsbNII2rBwR6mnmdZD1D89AcNeXOxPvvfs4R0Ha8NDVOeZr5WOqoFGBXlnirOdO
	W8kNqBpRC6k9dG5GUmRWI55zJLHMeGEI=
X-Google-Smtp-Source: AGHT+IEdDNM+oHvM0odMnS6iZu7bn6bpKV8KqHvBF/3W73fga0J3j8CYKIz5P8HqpkXsUOqPrFXZM6cI3pDyreGCKfg=
X-Received: by 2002:a05:6000:22c6:b0:3b4:9721:2b13 with SMTP id
 ffacd0b85a97d-3b9e4179d4emr1082182f8f.14.1755141026267; Wed, 13 Aug 2025
 20:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813171136.2213309-1-uwu@icenowy.me> <eedd44480a76840e1fec73d4433c772c5bdc7011.camel@icenowy.me>
In-Reply-To: <eedd44480a76840e1fec73d4433c772c5bdc7011.camel@icenowy.me>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 14 Aug 2025 11:10:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQXR9W6G5ygvGVdH_iiynZ85E3c_XJ4HKj+_wWMnRpkpw@mail.gmail.com>
X-Gm-Features: Ac12FXziswa33lxyZbESbnI29DNxMMJPeobEtHWCp-qmsz_ElJcNnUvP2p8IeoE
Message-ID: <CAJF2gTQXR9W6G5ygvGVdH_iiynZ85E3c_XJ4HKj+_wWMnRpkpw@mail.gmail.com>
Subject: Re: [PATCH 0/2] clk: thead: th1520-ap: allow gate cascade and fix padctrl0
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi <ziyao@disroot.org>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fixup, don't forget the "Fixes" tag and Cc stable@kernel.org=
.

Others LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Aug 14, 2025 at 1:16=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 01:11 +0800=EF=
=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> > Current ccu_gate implementation does not easily allow gates to be
> > clock
> > parents because of the waste of struct clk_hw in struct ccu_gate;
> > however it's found that the padctrl0 apb clock gate seems to be
> > downstream of perisys-apb4-hclk, gating the latter w/o gating the
> > former
> > makes the padctrl0 registers inaccessible too.
> >
> > Fix this by refactor ccu_gate code, mimicing what Yao Zi did on
> > ccu_mux; and then assign perisys-apb4-hclk as parent of padctrl0 bus
> > gate.
>
> Forgot to mention a easy test of this patchset:
>
> Just install `gpioset` from `libgpiod` on a Lichee Pi 4A, plug a fan to
> its fan port, and run `gpioset 3 3=3D1`. The expected behavior is the fan
> starts to spin (because GPIO3_3 is the pin controlling the fan),
> however without this patchset Linux will fail to switch that pin.
>
> >
> > This patchset depends on the display clock patchset at [1], although
> > a
> > rebasing to get rid of this dependency is possible.
> >
> > [1]
> > https://lore.kernel.org/linux-riscv/20250813072702.2176993-1-uwu@icenow=
y.me/
> >
> > Icenowy Zheng (2):
> >   clk: thead: th1520-ap: describe gate clocks with clk_gate
> >   clk: thead: th1520-ap: fix parent of padctrl0 clock
> >
> >  drivers/clk/thead/clk-th1520-ap.c | 385 +++++++++++++++-------------
> > --
> >  1 file changed, 188 insertions(+), 197 deletions(-)
> >
>


--=20
Best Regards
 Guo Ren

