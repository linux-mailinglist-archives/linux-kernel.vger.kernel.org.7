Return-Path: <linux-kernel+bounces-853177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A17BDADBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 394AF4EEFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB667305064;
	Tue, 14 Oct 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGPwcq7v"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9024DCE6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464462; cv=none; b=TRerIgsxQx/tkmUOZTXIzUWMka757VSpHCeXtCvaKSrm1tmfHajElZG9BAZJg3kSzL8deh0JOpUWPld8k8+4KqFnNpAOaNS/wx/Mf29kNtek9zS5e5Gat9wcZIqnjUi8x6jNBFZUh27gieFGVUmJ1Tubiz2HmN5VVBGu9hfvTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464462; c=relaxed/simple;
	bh=M0ijwDZ3MwE/VJEfiOycDb/wmja5XxYrLbL3ZABStD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3GIWOWNIK4AWuai7jNPG1EY/yajz/aBoTvCDzUAzh6ITXKv1e8JzC4G7M0npLWZ8zYZri5Uv2xnBnDV/mJrq27pIbEzZFlwdWi4VnUQc/TaUByBrsJjm9M7DrfUKf0n7jz+sgWQDRW3Rs5jIZyTtUOkKaDWXostsO7SdRJCgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGPwcq7v; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5797c8612b4so6891998e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760464459; x=1761069259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L34c2igKzAl+y7faUaRQQ6fgbb6gd8h/e7yU5YjEm5c=;
        b=YGPwcq7vqzwmxRtsw5LhfA/DEOi/SaAE9rRwiYulyjpgtOhqA45ASkqLo9ub50zPbS
         LH2Qw+i+dG1ngEWASHqwQpc0qixvh2kpGTJ6pZDqwbdDlMwujI8/uTq0uP9Iz8Pext6r
         2PTelnajsEO2MSHHiLeaIzLtZSSe1rgfqtJgKINjGC431hO4ux1CR+5vN2xRX8fwGKQg
         cXcLfiCF0Wl0ScByJdUuydSx9STXdKY93Ti/7pMu9UUiFdUxrNWmCyuPjhIN05ASORdr
         BOYB39r6FpLn/cMljreaZMsUETF7INda2Uat8ckOAYY3k+OXN7Ljc9iq2Q0Ieei/bMcV
         R2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464459; x=1761069259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L34c2igKzAl+y7faUaRQQ6fgbb6gd8h/e7yU5YjEm5c=;
        b=HA0VAt9EXbcB7a6huR9buCzJf0gsY/fqcSQTiKSMVU9a+SywBnP9wxOmuWSOckQJVn
         UMfOXXyin+gKEp6uhLbn2Jo8nLd43bBZn0CHuHBW6j5bqRckurTaIPFjAB6pF4/n4qhz
         62BRe9/Dq4ee2z7wzW6Sfqu2twt0On3ez+i3hH+VfGYQ/9bBUh5tQqDtu5gwZC+zQIBC
         P/EaZnr0eFdDj6HLbarZFQ0pKq8wbPFGnrrLemiGNU32hKS4g8cHPh6U1vpDo/VL4kzX
         oS7DD3LF+iUHLlfn0l2/GUQYJqTFY6f7yWjFpr4Q5vqkkNQpuLEW+jGF82DAY98srbdR
         bK/g==
X-Forwarded-Encrypted: i=1; AJvYcCXk6qZkrqFbQt5XwFzvIRSI89GbAW/CIavQa0Wz3PzTAk/OBNg3F3MneFVCENQ/ub83eABzpErsocTfRPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/vNL1BiqvpO2TcDQSsOcxb5SIsZ6lhABH+oU4z+Nclr2ehBH
	djmOVbL/NGzf7IBIN3HBoMInRSgRV7dUrwsEA5QI/BO/ETUseuPPMYY0nFQ16hXRSoUN9fFgcUf
	veajdALyzkEtcv392bWC353Wo+26kv5s=
X-Gm-Gg: ASbGnctFdUlVf+yQIVV4fSxqGK6nyJ8dDTdJSmjRDWiane64sHMnMVKuYACFELF9FuZ
	Q/ewaGAM5tpQUKfn52I5LDt5omucJ1e2YQDYSU7NWmvESz5UZu90VgZHNSjKpMXEB3OCd1ldmKU
	foqdpGpiXXxNudfG/JntQ56GnsBswkG1+1M3DKUeW7r+QnqZg0cj6hD/C7x8NI+TtXgyyCX/I1T
	B1pviehfdn0AuEpb0v+9n/hpRoBlP49oW1A
X-Google-Smtp-Source: AGHT+IF9+8vhtrxqH7QnmXwbacZFNb3DZNzy7OnXFeJzxvLDNzi7O/QJeqOMolpXCiVF+ZPs25ZX5GVlP4y2ObIM8ds=
X-Received: by 2002:a05:6512:3b96:b0:58b:114:b7e2 with SMTP id
 2adb3069b0e04-5906dae5ef0mr7670933e87.32.1760464458427; Tue, 14 Oct 2025
 10:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-tegra186-pinctrl-v3-0-115714eeecb1@gmail.com>
 <CACRpkdb=U=h5OguMuy9G6avCCN6Aem=2_60C+_uBsrY+UvD5ng@mail.gmail.com>
 <CALHNRZ-dRvaN_SyHRfAsq2MO-ec8rzkeCy6CtJpYdWTobf1-Wg@mail.gmail.com>
 <CACRpkdb46OwzNQuSp0+QQVjy2LojMyhdE7XrNwdsyqGi5okASw@mail.gmail.com>
 <CALHNRZ_+Oh2AGZTvJ66EjBEKEf7PdQsMM_BTNNnjENJpbOKiog@mail.gmail.com> <czukh3b6lb7x3uwn2khcgzrkccyveokdpksxban7arhod6ygh3@uukoulmn5gil>
In-Reply-To: <czukh3b6lb7x3uwn2khcgzrkccyveokdpksxban7arhod6ygh3@uukoulmn5gil>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 14 Oct 2025 12:54:06 -0500
X-Gm-Features: AS18NWD7TZf0Odmt-TAH5heuCe6IG8XyPr57Ljb0DD_wuWQD_jZFSXnz2IurYx8
Message-ID: <CALHNRZ9J2VFLm39wm7+8Le8rt2HpfeHgDOm6mc-s7_Ya8aXe1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pinctrl: tegra: Add Tegra186 pinmux driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:09=E2=80=AFAM Thierry Reding <thierry.reding@gmail=
.com> wrote:
>
> On Wed, Sep 03, 2025 at 12:58:06PM -0500, Aaron Kling wrote:
> > On Wed, Sep 3, 2025 at 1:55=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 6:54=E2=80=AFAM Aaron Kling <webgeek1234@gmail=
.com> wrote:
> > > > On Tue, Aug 19, 2025 at 6:30=E2=80=AFAM Linus Walleij <linus.wallei=
j@linaro.org> wrote:
> > > > >
> > > > > On Tue, Aug 12, 2025 at 11:24=E2=80=AFPM Aaron Kling via B4 Relay
> > > > > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > > >
> > > > > > This series adds support for Tegra186 pin control, based on a d=
ownstream
> > > > > > driver, updated to match the existing Tegra194 driver.
> > > > > >
> > > > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > > (...)
> > > > > > Aaron Kling (3):
> > > > > >       dt-bindings: pinctrl: Document Tegra186 pin controllers
> > > > > >       pinctrl: tegra: Add Tegra186 pinmux driver
> > > > >
> > > > > These two applied to the pin control git tree.
> > > >
> > > > On patch 3, Mikko noted that I accidentally amended the formatting
> > > > changes intended for patch 2 into patch 3. Linus, since you've alre=
ady
> > > > picked this up to your tree, is it too late to fix this properly in=
 a
> > > > new revision? It doesn't appear to have made it to the main tree ye=
t.
> > > > Or do I need to send in a fixup?
> > >
> > > It's one of the first drivers I merged with plenty of other stuff on =
top
> > > so I can't amend it, just send a fixup based on my "devel" branch
> > > (or linux-next, it should work too).
> >
> > I am highly confused now. When I went to make the fixup series, the
> > fixup didn't apply. Looking at next-20250903 [0], pinctrl-tegra186.c
> > looks like I wanted it to, the base commit has all the format fixes.
> > Which doesn't match the commit on this series. Which leads me to a
> > couple questions:
> >
> > 1) Does anyone know what happened? I'm not particularly a fan of not
> > knowing why something happened, even if it's beneficial at the time.
>
> Maybe auto-formatting or something else that Linus did?
>
> > 2) What should I do with the dt commit now? Ask the Tegra subsystem
> > maintainer to do a manual fixup when pulling? Even without a manual
> > fixup, the bad part of the commit would fall out when getting applied
> > on top of next.
>
> I can drop the extra hunks when applying, no need to do anything.

Reminder about this series. Patches 1 and 2 are in v6.18-rc1. Patch 3
is not. And I have seen no indication that it has been picked up or
will be picked up within the 6.18 cycle.

Aaron

