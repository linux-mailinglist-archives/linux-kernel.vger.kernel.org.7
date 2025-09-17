Return-Path: <linux-kernel+bounces-820975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F54B7FE91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394651C82727
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3C2E371D;
	Wed, 17 Sep 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXrXHs/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7602E0926
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118103; cv=none; b=tEmeovY4ls6P+Ubx47P6xgepZk7wgflc5eoJULXbw9UG9sVpC9qnPrAuJUfsXBNJLc7CPmIkZO0j/vh3Wb5dJFhqPfD47PtAV+lQH8/VbNS8QpCkYUnwKm+uyznCe8CZMRWzkJJJ7NMF3zjbiAQSKcgudHlm5wF6NR5xupUtwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118103; c=relaxed/simple;
	bh=lXCWglnUt90yI4aRsoMOta6ojCYjUYZrQfBXDrQOyNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD25d9uzH55tToprp+RBP7Y6PZGjOVK6+ipnoFg4eJ3Ix5KHrZtDkc2iB7MoHYBHKzG3CNGwPLUcA3b7Y6phrwnbnvFWBbgoVlk89zXBfIbVkoQ24VLSB9Y0h2KT9E7K0jQse0ZJ8KijSvAk2JK6d9jYEz6CZa0y466tFG2WCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXrXHs/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772FDC4AF0B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758118103;
	bh=lXCWglnUt90yI4aRsoMOta6ojCYjUYZrQfBXDrQOyNM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=KXrXHs/g1qw/613j5auhUt3GIPp/QsjHcbCOjwPwoByTRaQfe1HCwKpmUuEvRLM5P
	 ieAavHzuBLh5oRok+jpEDvm9ZuacjnuqhBa8cvZkI15sQsKj+m7VLNAXraT817uh3h
	 hKQZlNeEgDIhIMQbQ0+ezLdyb9KnqeC1GZrnxlYRZNTrP2NrXtihrDz0Q1Bu+tr9Y1
	 eMfCLYldKd/dveVkVrDggkTvfopSbs8uyofOjTe8UH9ftwYQMvOoDdEmxk2t0pQJ3U
	 AAejCD24iU+BEer8SCaDe5evgQp78RlAQ3LdRekoLNzURBMNRTvM6+d/TNxQMv1yn+
	 wuym0xuDm8ZSg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-33ca74c62acso61022801fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:08:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSnkkUYg5w6LyiWXCz2mfnpP0NtSOW/kLjJTh7fAB44efzcgbtwLpNq02RH4ljxIzz+E1OcbCV2yMsLYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQsriPHg1xAJMvcDb+xp6QxHdqNglZAu6qeLv/52+W1aG5FLQ
	ZfrGH8/7Kl+ASGux5vj52iTvvZT3AErdP6ArxJOwqg0uyZ2cVeTCiOAwfSMv3cDxbvdk81PmmJ1
	ox2q0x/Z2uDiwOjHAp4TFrWhK6CzzBGQ=
X-Google-Smtp-Source: AGHT+IGqdaQ8C9lVtjuyq3Lst//zIEIlnNEWTnnZW0oeQInZavtI2ovFzZs+fzDjBgh6Oll2QYo+R+KbyOIjgKRKfDM=
X-Received: by 2002:a2e:a484:0:b0:338:7f3:a740 with SMTP id
 38308e7fff4ca-35f6093b1aamr6295401fa.7.1758118101743; Wed, 17 Sep 2025
 07:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913101349.3932677-3-wens@kernel.org> <20250917070020.728420-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250917070020.728420-1-amadeus@jmu.edu.cn>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 17 Sep 2025 22:08:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v640r+TwB7O+UAB9PehZ2FaXDjhVerK6j_CZ2+caJoJ9zA@mail.gmail.com>
X-Gm-Features: AS18NWACYa7boO8HaxahcwxNgufh9JCYIxjbMd7TaIvgTTRgZ9eVfnU6RZmksT8
Message-ID: <CAGb2v640r+TwB7O+UAB9PehZ2FaXDjhVerK6j_CZ2+caJoJ9zA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/6] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andre.przywara@arm.com, andrew+netdev@lunn.ch, conor+dt@kernel.org, 
	davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com, 
	jernej@kernel.org, krzk+dt@kernel.org, kuba@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	robh@kernel.org, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 17, 2025 at 3:00=E2=80=AFPM Chukun Pan <amadeus@jmu.edu.cn> wro=
te:
>
> Hi,
>
> I tested this on Radxa Cubie A5E and there seems to be a small issue:
>
> When VLAN_8021Q is enabled (CONFIG_VLAN_8021Q=3Dy), down the eth1 interfa=
ce:
>
> ~ # ifconfig eth1 down
> [   96.695463] dwmac-sun55i 4510000.ethernet eth1: Timeout accessing MAC_=
VLAN_Tag_Filter
> [   96.703356] dwmac-sun55i 4510000.ethernet eth1: failed to kill vid 008=
1/0
>
> Is this a known issue?

I don't have 802.1q enabled so I didn't see this.

Can you provide the base commit you applied the patches to?


Thanks
ChenYu

