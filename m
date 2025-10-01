Return-Path: <linux-kernel+bounces-839414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E332DBB1944
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ADA1926E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5DE2D8781;
	Wed,  1 Oct 2025 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hvpmYxh0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866352E54B2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346316; cv=none; b=meXxTDQ7EW/FuKZ+uQL95cnwEfuNC6yZpqlivEJiAtxGsvJ8R7x63LAi79H0bhiiw6k32gPqTGAVjxp8k1eo3xLEtEPcxnK5Yv8T9RHz05uCwq+R8ZD9Y6uNcUdBzgGl/5i6tH3dcOOvrL8EgUnIvPOOOxi72Ez2/agle8HchkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346316; c=relaxed/simple;
	bh=duPcS0wfMeB+YtIDMwyoth5EHINr1H5VM9YOTBe0lDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEb76zTXIqe+aYjp2ROWVHUryw48ayAgZmVS6QIUBPwy+nj0ZWConxrSUVGT09iAwyDqEtyMzNoOAkjdIOCRD8YJ4Xf5toy+GB4OD7PEb7XogRIx9VdB4X62UST7Tp8kH4eyy7UWm4NXCoB0VeUKYrY+rWPb5ZxzqOnJthRu6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hvpmYxh0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so1638081fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759346313; x=1759951113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ika2EwTLbPs/hB14my45j17pHFrdQm4poatSi0eQJhA=;
        b=hvpmYxh0u7SqMc63OqX5wEXGXQQWEIOhgyt9KqsanJ6K1yzlgZ/p8ynsJ+4o5d0Q0Y
         //X3ZqRUJqyPhAg9TE1fHUr0X5PIOCBjFNbCXlTO6zrnxbLo/RK/BUCkBYrUZ6pvsx40
         H52oU/JFQQFF65ciQeYSK3xlMEq8md1x39OzojEgoju/trJ7Ut+HHJDIPhIIprKy1Sd9
         Q+GpA4USAAIxVjqqOS7h/ajPmFdkenCm4jNqqRKh4vzAm5nHd4yciXsanLyp4AeizNKj
         Rlb/VG41Ff7rkm9dBUdTBzGEeqIZNVjrabba107YFBde8Snt/BZ7ZnsAAYocg6SuoIDq
         Zv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346313; x=1759951113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ika2EwTLbPs/hB14my45j17pHFrdQm4poatSi0eQJhA=;
        b=tkm515TC4FZ4F131bn5tJPGHzk0nCH6cEq8t3nkbKxJs9Eg1fMYv0SJqxZoLEvUAYV
         TZuORrstZKI4/2RsO5BoH/jRwNA04EoF7m+t3D8gCEjcInACoXLz2soaCqgaf/+s6KZc
         CmuCjPX4onnN6Z1a+PR8OKuE0tbAK+6DpsutVIExgex9+GVFebQCwWIGdEB3Nv+JXKYw
         9dtXGcu4HyXG3ke7lmKSbFJIqzgiy/GqLlRuBcT5XsblvRtg1iGkRpNZ140zlvy3V2O3
         YdfQydsjlC5QSR1lrBoWh4gVPj2CtMG01TfcA7zjLe4dNn9FXK2JkXDE9RUeWjtmZuSj
         DF6w==
X-Forwarded-Encrypted: i=1; AJvYcCX2mDaVEmi5kTkDNgl8Nyvufm15u9XrlCt/pGhxQPr2Vdfb6UxMCSo2GQgoHxhuBWCbDRX+rbIddgjR7XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkVohk54DuEwNWCEfGDLOi6O7UffuL7FslcOD5uhc5IszZG4o
	Hh0YN/AsDqx3MFQ+WzXfG3PbCeKHntnrsGpdoesmKf3Z4Lv1Z3EOkfH15s51lwtQxiqHtHkY9n5
	trem+wTGxMQvZj1t6wiD6osP1SbeFcaGdXgabt1JNuQ==
X-Gm-Gg: ASbGnctki5ovMt4tx3/M3WGA7KjFNbaBStiLVMCTcvUKc20z+zXy7Gxc4VOK/aRweJD
	CbTEEBo36GGzaudJXte1Z/xt8WdIelhzIxDMTrkUQUHtDbJhvHuLqVU/PlSGuRtvvu3aYj9CmbK
	7HbDrzam0C7jsd/2SsS124vCyGRTjg5ELt+2Nb3vttB83tufM7BM+M/WtASKr+3I6YWETGOUH2K
	marE+WVkwH3wjDYw6+b3aU1hI9dkJ+qq68VhKoICswnhSGA+ri2ue/0eqbAivc6zMZgYKND/A==
X-Google-Smtp-Source: AGHT+IHdKtzst+020FzI9gZfNJFk/Y8mES72dcb0M1Lunet0OYSDf8iqU3erDstle92eJI6mXzgIdHwjDya8pxKfaCQ=
X-Received: by 2002:a05:651c:548:b0:373:a5ad:639 with SMTP id
 38308e7fff4ca-373a70e3f74mr12786451fa.8.1759346312603; Wed, 01 Oct 2025
 12:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929094107.34633-1-brgl@bgdev.pl> <CAHk-=whnmvjsan9Y=LcV0encJungD451VkdqYAKrRpk6YyA6-w@mail.gmail.com>
 <CAHk-=whPqa8YnjjH=Np_Q8r+9xDrypJVL4SPtFzgN-Znjb6knA@mail.gmail.com>
In-Reply-To: <CAHk-=whPqa8YnjjH=Np_Q8r+9xDrypJVL4SPtFzgN-Znjb6knA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 1 Oct 2025 21:18:21 +0200
X-Gm-Features: AS18NWDziKtG5ep_vpgTvGBSV3_avAhsqs2_NmERRWgOx-Xl5t9ov70C9jXbNqM
Message-ID: <CAMRc=MeFzn1CfjAaLJgFNyEybCudmaFfQ-9GQDCb6k5FureNsQ@mail.gmail.com>
Subject: Re: [GIT PULL] gpio updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 9:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 1 Oct 2025 at 11:36, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It's trivial to fix, but I should not be in the situation where I have
> > to fix it, and I should not be getting pull requests that don't even
> > build under trivial configurations.
>
> I see that it got fixed in the MFD tree, but this is not how things
> should work. At all.
>
>                    Linus

Hi Linus,

Sorry for that. All the patches should have been a single series going
through the MFD tree but the GPIO patch was sent to me separately and
I applied which of course caused a build problem in next. I thought
the fix was to have just the core MFD patch in my tree which we did
with Lee and due to the order in which branches are merged into next,
the (unfixed) problem remained hidden. I'll pay more attention next
time to these MODULE_* macros.

Bartosz

