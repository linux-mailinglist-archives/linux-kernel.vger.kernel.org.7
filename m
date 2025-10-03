Return-Path: <linux-kernel+bounces-841056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3FDBB626B
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AF0C4E8637
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08923815D;
	Fri,  3 Oct 2025 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjfOhuCq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3D22F14C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475681; cv=none; b=WEg6t3gfPIEJPUTE2wwHU+IFXjQeBK0HRHLthJ0nz/gPWMW9UArOil6qa2MuOwl3FCwPAN1JHuoGJjNjYh3kkRJP4YJ0WzF6Vppu9h6vRpLvxbM6T7kASWNSyT5puf5MeVgJCRFnmHAxihjjh2UKLE5Yg/CN+3lNLcDttE41mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475681; c=relaxed/simple;
	bh=e1mankBQsqTlkT/47qns+yAsg9e8OdnU7wK4bL7Cxj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqR8jTl7/qvbF7UlHMACUhdgxmnjpYgfAa8rMUykLgUMLEwrGtyrxGyKOj17CPBydV/zZajKCweFBHoWq/sw2tPhGM7YAHhVDGQytDXpo1ecdB393ZjUyE+VzRGoT2Qje5hcFrcwoU9xTwvGRiXvoLPOZM99l/4C8KlvYR2C+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjfOhuCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6ABC4CEF7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759475680;
	bh=e1mankBQsqTlkT/47qns+yAsg9e8OdnU7wK4bL7Cxj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FjfOhuCqhrGurzKPj5qtOc4txo94/YK345QuMjbsEB/SdGtont6m3dxDMd/6ENl15
	 onIDvfcF1D9h8jHHraNxqY40V+nyAbIg6Xu8/gDhQr1RttZ24/hiDsMrANjYrbsNYO
	 hL1AY/Sc/bdlsKBZmwd8LFWDcXsy1NL55Y6kPcTFjNTY38Z7dkmAN1yy7lfmXKCKZr
	 jlOiP0kFFhdTpjBDRq3t8qPARm9b5UR+MIVDsjIWO9AU4hRLUKoBL3vqH9oqlbRy6A
	 pJTi/lHWJbN82u9LEK0oKUWs/G0KzKDS173BUvpuIeiu906QLHJbBNXC7vt2GkR04f
	 s0DjQWVIeVzcQ==
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so1284738a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:14:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1K/eLTycbAmT2nJzEZbknFNsqQJKQjNPXbIyO7YrrXZ80glYFlBze8/syoiMmYJHnV+Ac+4OQvOO9cVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVUpCRniqVb6usElbZFmD3Yd2hjAUnFhjpjvqOWvde8LD9MkZ
	wPHKgr2IJuddDnaXYG9JG2w0gF+1EskH2NR4wg9ZlztKwX85TYHR4r/4swQlj/wwtPm9n2fosIM
	28tihjCNcVHb/bs7JoBLA8lJedEbKtXA=
X-Google-Smtp-Source: AGHT+IFi1G5SGzoCfQoYo09oOXzVchVUQnwqXoK2qsgzd7cvdMuGwR0SLJFyyWeKdqGyWBExudnAw/kwmPrFyMTs9Xo=
X-Received: by 2002:a17:902:e78e:b0:269:8059:83ab with SMTP id
 d9443c01a7336-28e9a6639dfmr21972375ad.51.1759475680482; Fri, 03 Oct 2025
 00:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250901054234epcas5p1e4b34b6ccb304b0306b1fe616edda9e2@epcas5p1.samsung.com>
 <20250901051926.59970-1-ravi.patel@samsung.com> <CAJKOXPe7Hn0qwg8jDMg4KoF-n4kziLQnvAx9vbNKEcS_KjzEdw@mail.gmail.com>
 <000001dc3428$dc2990c0$947cb240$@samsung.com>
In-Reply-To: <000001dc3428$dc2990c0$947cb240$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 3 Oct 2025 16:14:28 +0900
X-Gmail-Original-Message-ID: <CAJKOXPft4eHTbA6qPA2MzyKZPhcxGUbJmfR3ykPaGuXRvacnEw@mail.gmail.com>
X-Gm-Features: AS18NWBorturPBW47S-AOdo4x9Et0GYnS5dR5FsCvXZoQdPFULPyyy5QFJ7b8vw
Message-ID: <CAJKOXPft4eHTbA6qPA2MzyKZPhcxGUbJmfR3ykPaGuXRvacnEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add support for the Axis ARTPEC-8 SoC
To: Ravi Patel <ravi.patel@samsung.com>
Cc: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, ksk4725@coasia.com, kenkim@coasia.com, 
	pjsin865@coasia.com, gwk1013@coasia.com, hgkim05@coasia.com, 
	mingyoungbo@coasia.com, smn1196@coasia.com, shradha.t@samsung.com, 
	inbaraj.e@samsung.com, swathi.ks@samsung.com, hrishikesh.d@samsung.com, 
	dj76.yang@samsung.com, hypmean.kim@samsung.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@axis.com, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 14:45, Ravi Patel <ravi.patel@samsung.com> wrote:
>
> Hi Krzysztof,
>
> The dt-bindings patch was merged earlier in v3 series (https://lore.kernel.org/linux-samsung-soc/175664688891.195158.13270877080433356384.b4-ty@linaro.org/ on 31st August)
> into respective maintainer repo.
> Then I have been asked to drop the applied v3 patches and send rebased v4 series (https://lore.kernel.org/linux-samsung-soc/15508cb4-843c-42d1-8854-5eabd79ca0df@kernel.org/)
>
> Since the 4 patches from v3 series has been already merged, I have not the mentioned dependency while sending remaining v4 patches considering
> It is going to same maintainer repo and it will be applied in sequence.
>
> For future patches (like artpec-9), I will mention the dependency even it is merged in same repo.
>

I know what happened, so no need to explain that. Single maintainer
repo doesn't matter, it's irrelevant and you mentioning it means you
didn't read the maintainer soc profiles I asked. You still don't get
the problem about what happened, at least judging by above expansion,
and this means you will repeat the same mistakes.

I will not proceed with further artpec patches until you really
understand how the process works, through existing documentation.
Please do your homework, to reduce the workload on maintainers.

