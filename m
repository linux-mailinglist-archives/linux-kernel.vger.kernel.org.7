Return-Path: <linux-kernel+bounces-810281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28710B51838
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC68A188B2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82522217F29;
	Wed, 10 Sep 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DPKPpw/T"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6F215F6B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511978; cv=none; b=DQVFKpMHqiG9vf7YBeYbblo0Y8GvBSFFN1GQkaHI242Bnz01ijcLEUSSgcXMaPxhOHo1QtConIOi4IlfdekuCH/XfS5d6LIaaj+SLcviedkzgj79RBtmeTJoqW5MuIJiqGnieQVbjy7mipChuvDutR8MdxooRTPCg+9QuVTEcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511978; c=relaxed/simple;
	bh=jckwo4DzWJoSXQynmvCEPazuqxT9RAb0hM2+LiiTOlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhmNQug+DYgbtKMmacZ3tR+TaKxI7JD1njBFf6s0w/D9j4aTDexnjd7GI07RecgV19kWmWwsB/tXnG8MTm3gdBi8x5Q3bCEfTpmys18CGb1Lh6rcT/8u2dDC1gHY6ExfON7eYXvTrqVEH4Ht/kKVh+o1LZ+F3DvaFRcYDxKO6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DPKPpw/T; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f720ffe34so1015529e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757511975; x=1758116775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jckwo4DzWJoSXQynmvCEPazuqxT9RAb0hM2+LiiTOlE=;
        b=DPKPpw/T4+1ANv37rWNGiwrv4mFDUEF/kI/qHHC2eqsjaKEjAlw1yJGaEhQy7ZiRk7
         Z7vqbcwsdWgQM1a5fj0+wn9zqtl5EyszM/LLqa8sjicgWdje51UDtTSypvOreG9pEl5a
         LYdNniilkUIptAhota1wpcwcGIUjQTU/Tvp0lCkjJFeD7a82imhh2aNhgLsK4WxdyWNA
         qvByQHSxyGbZ7vUTDu/dYSeoUji4mv1dF11p7CBO99N3fNPkDgYp/MI+5rfNLtcq1Lmv
         TiipLz6MkYpvRLqSWRMhylc47q+0svyBdoZzM016bPhJA46cWaVkqLZOxp6kqOmxqBC0
         KOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511975; x=1758116775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jckwo4DzWJoSXQynmvCEPazuqxT9RAb0hM2+LiiTOlE=;
        b=nJM+6lRYuz3FQ16d8mDcTTXkdVtCKDYIgaiXL8HvVYNitev/um9qOXQf/pr823E6+i
         xOGG4v+zpUldzDseiurQZjisNUHNmUGpUMsRtI8WvisldXYdUbr3+yG8XC/kZrt3sKq1
         TdHkB9HwWITgjcJ1hYerQfHKUuEoDhPL1+qtt+A5PII8GMuRbBT8gpgz5eqJTxdz5Kaz
         5Wb65oPeA3UTHU23zBdtWhLVdn9as4+6ldPG/OQFnzB1gsKlirPMXdA9kS4dISttmDVe
         /2LEMTLMzXhMvLZQ1uFbTcZsl/AEpV2eoMAmbKAcoxggc8ZIwY7B/DF1S64H/oWe6F5M
         si9A==
X-Forwarded-Encrypted: i=1; AJvYcCXHPNJNSwwb/31LRhmsHEcpmj/8DTzE4Quwa/Og7t0LrS6Fdu6QXAesIbMrRFcDJ+dU8uvHFgKM+/I4Ovw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy370kBWU5KAtBouhiKkaRg+S8gqpDXVedywGFWmykks/Qwq97K
	36VB2MYxJRBE/uJZrTKtjoT+zN2pAUyx/eDd78nM1rf1xNviWWs3gcyT9uqRW8UJ9xh6pks6Fml
	Xt+lm7VUcmV6dibnhLDumH/wHbYW8eWEmRBgQUm+hRw==
X-Gm-Gg: ASbGnctF7WPAMJ//XV3atwfKtz5oXQiGXXwqPr8GK1I4lGG6ixOB/gZCKaFy7vYQoiO
	XK5xTkibX6MH6OtX5QU28edjXrvxchetBqTlCKBw9czYTYlZq5kJQKDq1pASysYXBVHJaUk8FFl
	WHuxPCxDR2w79RYrwKgql4QQQWftibZKWXR0ugbHW1WKDVA1j0kr7OxJlL9GMFQ3/Xb/jLKD8k4
	0SfG2+p10sGXLtKbzrPEpyhT+u/lK38o4DKP08=
X-Google-Smtp-Source: AGHT+IFgj2ppHdy6zATwu9/GkdKc4tc5zX1z5/CmlY1l1JQXLE6h9ZkRqOvbziFLq6eYgZNZaXGJJCpLLoi+L5GfeRk=
X-Received: by 2002:a05:6512:1195:b0:55f:3c0b:9ca9 with SMTP id
 2adb3069b0e04-56273118a03mr5943244e87.1.1757511975363; Wed, 10 Sep 2025
 06:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173804.3816149-1-mstrodl@csh.rit.edu> <202509092305.ncd9mzaZ-lkp@intel.com>
 <aMFzTaO7zGVgWNRK@ada.csh.rit.edu> <CAMRc=McBdJ16RYvJM_R7pL+u3zcs_+A0nj5_5twP7KxWhW6VDw@mail.gmail.com>
 <aMF9QFIvXC5kI_9J@ada.csh.rit.edu>
In-Reply-To: <aMF9QFIvXC5kI_9J@ada.csh.rit.edu>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 15:46:03 +0200
X-Gm-Features: Ac12FXw_b4dB1oBOSKat4kUqj6UH_gOF4z0OMCLiQ9S83rqNOEKPvjJcoe2D9qs
Message-ID: <CAMRc=MfSOTTBv3spbyiedpMifMyfmTkpmbvuDuKcbs5S1B+Esg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpsse: support bryx radio interface kit
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 3:29=E2=80=AFPM Mary Strodl <mstrodl@csh.rit.edu> w=
rote:
>
> On Wed, Sep 10, 2025 at 03:15:46PM +0200, Bartosz Golaszewski wrote:
> > I cannot really give you much feedback because this patch should be
> > first split into smaller chunks that explain what each change is
> > doing. As it is: it's so complex, I simply don't understand it and
> > don't have enough time to try and decipher it. Please try to make it
> > into a series of smaller patches.
>
> Got it. That's why I offered to break it up.
>
> Here's the order I did the work in:
> 1. Add quirk support + brik quirk
> 2. Label format (Only a few lines, could go into 1 or 3 if preferred)
> 3. RCU stuff
>
> Is this a reasonable order for the series? This would be the easiest
> way for me to do it given what I have in git.
>
> In a perfect world, I would like to have had:
>
> 1. RCU stuff (These are effectively bugfixes)

If these are bugfixes that should be backported to stable then they
should indeed come first.

FYI: Maybe consider also adding lock guards for rcu read locks if you're at=
 it?

Bart

> 2. Label stuff
> 3. Quirks
> 4. Brik quirk (possibly squashed into 3)
>
> Let me know what you think... Thank you!

