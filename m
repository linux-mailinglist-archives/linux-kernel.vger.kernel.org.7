Return-Path: <linux-kernel+bounces-749916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1CDB154BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9331649AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739A24676D;
	Tue, 29 Jul 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW5ruKUE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C81581EE;
	Tue, 29 Jul 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825099; cv=none; b=j/TBFUm+Oe1LHkcy6foLrMCvynG+EzJahaQSeZoGBluQJKOf7glgJS7n0fcA2ju5RkfQhKUOel4TzT3m+fspFo9AUFsgzYzl9BwBEXfINmDmKn7rrfr2vIrqpIWlWJSS8KB5/ZipE+Kdl7+8IZZkUhrnNLaWHhAeA5hlhLPXF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825099; c=relaxed/simple;
	bh=RbiX5C9ZNSVgqywJgaDdT3SU5ZxrC7DIKMkAgMjIHqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGbgx5Q7mGw55U0dK2mEEtItXZZIdrbnjLbbduWF57bhUwsg/tU1ujhhDdxkItOFtIMa5Jy69lQ0JJF3eXMobZX6kZBAf4irRTfNsUqBCPLlVDA6VMTE8Tp1LBxyi5lwFcIWoJy9K7s+MBYVStCqoDJSK9s4kXtotxL1KKv4F0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW5ruKUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2FEC4CEF8;
	Tue, 29 Jul 2025 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753825099;
	bh=RbiX5C9ZNSVgqywJgaDdT3SU5ZxrC7DIKMkAgMjIHqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qW5ruKUEVp1+6NVwIxqqua6H+75nhw53XjZF2b+D4+Y4ulEiX4Y+9oykKNozGyW7A
	 ED7Or2wprVZxFf00cp486qOXJuu1LvYw3yfa3/A3riRvSi0KKehyVLr0FBm9VFyvml
	 xNRF13XdK/RX6UeWx6metByEufKtswSAVa6jbzIYd1i5N2C3Sf1nWnZV12b5zMQaj+
	 T8XOJo4ebvSNaCNiPesKmK6vbny5LUvnAwIs8JYoQ2vIn7Go8kcsirGv1EQKlKfY5E
	 M+gqIIipH/qhyZeCHbOPg/Q5pQ17qRdi4qzs+iekH63QRdYmBepGutZO+xpre3ZmAt
	 sTp/+YwHvqZTA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso492143a12.1;
        Tue, 29 Jul 2025 14:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUx4E/+uqMDRJ4aiY1BCAgycKSBsyxqpExOlcEtWgToIubnuJdmFogK8boQpos2pGGqUng+Sji/LEp03YOa@vger.kernel.org, AJvYcCWEc14+OJKfaB9aWZVipB3p7XOBUgqQahHANaLVfEGgfaT/zidHbgWesy/OvI5J1N+epUzMHexLcUHq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bRv9FuJTWl1jEOwGscLHVrAtHYHm2286mxWeZMzlBFybG+GT
	LfPH2jfbOtaQYLT8vbDtkd5nItCcGeRQbUEZ3IL4ua4MBHohhI7rTJgiHkE1od/oFyv38mcU3Xo
	PnsqcgY2hmn7lAMFEpXMUK/BU/wFqLg==
X-Google-Smtp-Source: AGHT+IGvBZ0btfZgJFG9HmTwKXOD3/MSQXfb+Qs2Tts90trK7pL2qm2BE0USLaxZ5PIPuS6byX7/Tet5ZaY65/Y+43k=
X-Received: by 2002:a17:907:9802:b0:af2:4a7e:ad64 with SMTP id
 a640c23a62f3a-af8fd6e5f65mr111254066b.2.1753825097587; Tue, 29 Jul 2025
 14:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727180100.15961-1-kjw1627@gmail.com>
In-Reply-To: <20250727180100.15961-1-kjw1627@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Jul 2025 16:38:04 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+J+6gxOzsXe9t9==GGJ721jrbNhaGMHZyfCTxkM8B0eA@mail.gmail.com>
X-Gm-Features: Ac12FXy8QPjafdy9u2G_MjJ36oKb7qYl68BAVkZFJ4Q8P3yCBh8fAC5XN8o-02g
Message-ID: <CAL_Jsq+J+6gxOzsXe9t9==GGJ721jrbNhaGMHZyfCTxkM8B0eA@mail.gmail.com>
Subject: Re: [PATCH] of: address: Fix bug to get the highest cpu address of
 subtrees for dma
To: Joonwon Kang <kjw1627@gmail.com>
Cc: saravanak@google.com, nsaenzjulienne@suse.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 1:01=E2=80=AFPM Joonwon Kang <kjw1627@gmail.com> wr=
ote:
>
> The function of_dma_get_max_cpu_address() for a device node should choose
> the highest cpu address among the ones that nodes can access.
> However, there was a bug of choosing the lowest cpu address and this
> commit is to fix it.

Please provide a test case in the DT unittests or at least details on
the DT that is affected by the bug.

> Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
> ---
>  drivers/of/address.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index f0f8f0dd191c..5e984e0d372b 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -969,6 +969,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct =
device_node *np)
>  {
>         phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
>         struct of_range_parser parser;
> +       phys_addr_t max_subtree_max_addr =3D PHYS_ADDR_MAX;
>         phys_addr_t subtree_max_addr;
>         struct device_node *child;
>         struct of_range range;
> @@ -992,10 +993,17 @@ phys_addr_t __init of_dma_get_max_cpu_address(struc=
t device_node *np)
>
>         for_each_available_child_of_node(np, child) {
>                 subtree_max_addr =3D of_dma_get_max_cpu_address(child);
> -               if (max_cpu_addr > subtree_max_addr)
> -                       max_cpu_addr =3D subtree_max_addr;
> +               if (subtree_max_addr =3D=3D PHYS_ADDR_MAX)
> +                       continue;
> +
> +               if (max_subtree_max_addr =3D=3D PHYS_ADDR_MAX)
> +                       max_subtree_max_addr =3D subtree_max_addr;
> +               else
> +                       max_subtree_max_addr =3D max(max_subtree_max_addr=
, subtree_max_addr);
>         }
>
> +       max_cpu_addr =3D min(max_cpu_addr, max_subtree_max_addr);
> +
>         return max_cpu_addr;
>  }
>
> --
> 2.46.0
>

