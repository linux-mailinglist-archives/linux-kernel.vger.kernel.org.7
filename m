Return-Path: <linux-kernel+bounces-862513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B8BF57FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5069A4F3818
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E832ABC3;
	Tue, 21 Oct 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="V4hWNgts"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF8221FCF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038862; cv=none; b=If13Jbbu1+mHgmjHYFodpnCcmV+2DCmsRR6Qmz92u7BZRfu85JPFt7SlBLQB5Kg4UKkTq+61X03XssKXiE0PXb4yoior4Hod6rYUO+ExWoUhYltu8ws5SBCIUwfBIyQZ7AEX+ME5jRT8IxfFMlLpKZkz123wRHGuaMidHFkctnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038862; c=relaxed/simple;
	bh=P7z2gScypkXsCTEfcWrJhYzB1SDqV1mmRGQM3Gk7S9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqrpiPlCgmJHhxia+lWkYJeveUgedtfooGD6u2NGoFSs5a/Y6NSCOETMzAWoWgLBhICrGgTCweW9BDkakVAgEcmPf9F2DIJopQ9tQVeqYvZ4hahPOjlj8VzOoQmYGM9jl5n03m3fXmcM+/y4TAkYfMWoe5/D2fqNWPnXr1hPf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=V4hWNgts; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36295d53a10so45297201fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761038859; x=1761643659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7z2gScypkXsCTEfcWrJhYzB1SDqV1mmRGQM3Gk7S9E=;
        b=V4hWNgtsX0nHo9y30R/HNtN9/pw0rP1dvKo53R3ZkLgztA3ZFZNjjDovB2FC0LZb1w
         Hmghorx8Bxgur7UZnh9duRWwpgabzGbpkt3QXpUJAs5Es765Aa6nxc0BbJIkmACCqs3n
         2p665rwgEo+z+D/AOCk7mbTHPUudelhc3cIhURZuG35gWVjVkrWPcS0Q0r858e4Z0esy
         TdIm85vXWGk90+65zICj4gT7wmHduAg1Qc8igkKbXaK+QZBt0guQy/uoFwtOyuyXGl5/
         DN7oi43gI1+BqK7QTOSt1iuA1jhf5WH2epmlxd9Yf0gbG9fvB6jcBg23XkLzeeiAtZ/m
         YStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038859; x=1761643659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7z2gScypkXsCTEfcWrJhYzB1SDqV1mmRGQM3Gk7S9E=;
        b=PsvV+jWB/t+wHle4OjDJx2/W2VBERnjXPZCJPDi07h5hYLHlQELm/xMAxpSVo93xY2
         YS6Us90sa5nA9BJtBfg4eSDalnkY5ZF+4+1S7q/xVZ2D20My/pigRBhNS/XUAeQBclmG
         5LrUiaPlpjr+qtXmDebivMPJ2fJjme/A16/Dc7SoSjS4KNCW76IKbDPUXtm3T4SNz3YJ
         bW2tTuRfO0S4Ucnd1o4vFkXeL4l+0YZZsMdDzpha7zcw2YfADW/lqqwzlb0PJ6vdwcGG
         gJRsRrftBL5a1gF1cmbh0SLwHexqiWNNj2KwV22VSAdpa8IAAwEL9e1X4g2tv9OMEUS3
         eMxw==
X-Forwarded-Encrypted: i=1; AJvYcCUj1GRF83OmVGjIaCMVDIJAEvDq2c6s7RFHrk8lK3RXR18jLFmHOoAAXrABGv7pKEugh2skzT3c76orL4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVrJhG+5Gd1dW2biYUa9pnBRzkkwp1Nqa/DOkgRJf1ww7HSX3l
	wEi5DOmHT2L+Pgfm3CLzAHYqYyOoSmTkvD2uZwCPBXPtPEEBz1qob19Ns7Y/PpFefUCIQ34Gjsw
	rOix9LHwJ7IyHEKhUAOlvj6njvKlOeVJF0OgHOeM7Qw==
X-Gm-Gg: ASbGncscXMl8PTHElK4iVXR1mBvCjXwT+30Xt1/RIQVJ2YeJHVSsaBm3oDyC7A2QV+2
	Sm7831Xnpz1VJeDfRSBNJ3JbeflQw+B/s6NJM6lfGB8TvKKFN3vdrgSGo9O9Ze/mMJTUtusymLo
	reSizmFv6dPEC88kD42jYuTsDYIeETi4rCCTTpqPz913D+Xr6CT3eeeHnLmlPvx4sbgoI65uN99
	EyLC7fjqusZFZdeaYymkl7l6QEuqAhLG2cNbGs8vtFBTJzIJxujdJe0rpNA8Xxh0TBCU1ToJ4de
	Teuk4ncxu4p3EDihkQ3hNBP2c3M=
X-Google-Smtp-Source: AGHT+IGcqahLfKSaPq3awX9rBHq412FeWkuYZKlnUWbJU5x4mCNhy4NKrxE77gwoikcyWR8JVYkFw8yaJVdN+5pc3a4=
X-Received: by 2002:a05:651c:1ca:b0:36d:bcc:bfaa with SMTP id
 38308e7fff4ca-37797a5f17cmr50360261fa.40.1761038859288; Tue, 21 Oct 2025
 02:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com> <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
In-Reply-To: <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 11:27:27 +0200
X-Gm-Features: AS18NWAqzshJ751MyC_I5LHfM-95oy0012vlyyZ7HFzAJN8zex77zf83nZAiBoE
Message-ID: <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:17=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Mo, 2025-10-20 at 17:25 +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 6, 2025 at 5:19=E2=80=AFPM Philipp Zabel <p.zabel@pengutron=
ix.de> wrote:
> > > [...] could you take this
> > > opportunity to prepend a patch that splits the part under guard() int=
o
> > > a separate function?
> >
> > If I'm being honest, I'd just make everything else use __free() as
> > well. Except for IDA, it's possible.
> >
> > That being said: I have another thing in the works, namely converting
> > the OF code to fwnode in reset core. I may address this there as I'll
> > be moving stuff around. Does this make sense?
>
> Yes. There was already a previous attempt at fwnode support [1], but we
> abandoned that when there was no use case anymore.
>
> [1] https://lore.kernel.org/r/20220323095022.453708-3-clement.leger@bootl=
in.com
>

Ah, what was the exact reason for abandoning this? It's not clear from
the email thread.

To be clear: I think that we can convert the core reset code to fwnode
without necessarily converting all the drivers right away.

Bart

