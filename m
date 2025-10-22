Return-Path: <linux-kernel+bounces-865126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E505BFC5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBB1624FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC9134C81B;
	Wed, 22 Oct 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vrD7MCFR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF934C15B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140417; cv=none; b=t7KcqBkyA+eFc1QT4aDGrgs0uBxex/DRvSYtFZQdQqpXHk93RLhWMKOtMqy2aSvTqqDIy+vCxwLOyVFTTBN5oDNps0cdUHg+t+NxzR90Tr++/blP7iGkN8/kRsNW+U76ryVxIStUSUiqeANW/7ZFvR3apnUyilbb8hZW9bNbdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140417; c=relaxed/simple;
	bh=orIYgaMNJClTUKA2Pj42SRVGg9kx4atmkKO79VfJkGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYlhHGKSIVq6W8Xhe7Y3osGXy955ZK5hnjYzXVbfgy71WSYBZRSAhq0M/5/bx0YgAjOWUP8EQj+j84uRLRg9Znep0HgaYsa897apgTQNcTiAR5HkWKP9QlXPIbEE+jlDgeN02fAIw24nx4Yv0loRPuD1gPnCYDj9+a/t/282XCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vrD7MCFR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592f3630b69so210916e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140412; x=1761745212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Gx1TCR16ehe+RsUpMtumgWDjpXuT38xi+HNgTYzlg=;
        b=vrD7MCFR5TiQfiyQ4b02oUQqocgr2+soVZ1doqOvsLFk21dlz6ansHvxpg/DOmiPM0
         Ts1epqVzsKPTxIZEgTAPG9E2iwlz02J7DaqDODW1db/2njFkQJbarS6Levwn4DB2q6gi
         ohXRYq70x90qVfc11r+1GmB1lxZfg+Ml8RL/1e+MdroVDnsqQDagTA7w4x/luiWwUnb6
         Kb7fsbnaZGMqIEhPMYWYXn3oxcCxsfcUswJGBDLQkWp63WfpuWv1mjLkguanLZJD6xVq
         x7Q3AK/upmP1LgDrkGUPeyKJLmxAtJs6N38B9cckdbfVEdtCoqnHqdg6YYIUcJ+3qH+O
         t6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140412; x=1761745212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9Gx1TCR16ehe+RsUpMtumgWDjpXuT38xi+HNgTYzlg=;
        b=A+gsw1x3+NNUtNv9sR7wgjVWCYn0rV1iQPnoN8iRMVFEDWB7eK4x4uWCaUuKnVwJgW
         jn1Q+xAENWxsyRwUy+HqNaWt/y+iCFRoFvahTHQdQXD26skotSbdTc1aQ2k7/qqK1+1p
         jY6PxJLXlEz0n8ldJked2urBlAXz/knvRgfiJOgn55VfQASSnUf4ZJ5FDXd+GDFBa2t+
         KIVfPn2a13fOVtpKJxoXJm8j58diKouOkjYvdW+iNtnDGsgjy6coc508pqf+cadQGHEF
         qr2TFIeUDCGOTXZKu8XE5+b0ZMo+OiQCjeCl8XuuXrd0UwWMOCL6tbnQGiP8r7177vEs
         j+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUGx6IPIVIP7ptV4SWk2pl2WgEnLOXP+JFIOQFuCqUWbwrJUtL2HJTPBBKCDj/+hazFS8SifFjAUdvez0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyUH6o68Vmb2fL9yb/ixf4ZHTbl75c0FtU1mYtiZ0CuTQZ5Uh
	pu4GKbTdtfyDLuIttLreQS91Vrb78TNDUj6FMwC5pCKom/yATlVfg614L6QczAaz5gmSfWmut27
	KqfU74NhC+G3Vy54YXvOQzM0lOWByY29wizJquCDofQ==
X-Gm-Gg: ASbGncvA+AOtAJ/+EQ0oPxtudJMQGtycG5QSCGNEq63zLPTaPhuHIJ87Bynhvbnmsis
	h6ycVb9ID5d43NiieHyVFrnhXgh4Ava2L8OgEsWA28dchug6C13PbXivgYHrqfItVP/CrfnWiXi
	Onh2Pj3aPODYjt6pLa9v34yyxM2zLWAvCXbJbSyU3cHEVH2ABe8dgs2lS5NxihqWjgQ23+maUfK
	uAh9XC9nKoMBBiSLTPKENAdZeBSzgJKo4UfMb1eJMxsYpczsVMsKuFQ4Do6qXjJ0P3aHO8kFwKX
	vOmw6Q06DHsiTfrM9rPe5PSbRwU=
X-Google-Smtp-Source: AGHT+IEKqm8lYyfETbDHoX6GlVAlvBKAEAKibR9/ZUGF9ZkgmvVU7aDY+sPQ7pncE4VQkSkH1+uh5CHDb76NK4aZXko=
X-Received: by 2002:a05:6512:694:b0:57a:1846:df77 with SMTP id
 2adb3069b0e04-591d8550fa0mr6598936e87.40.1761140412394; Wed, 22 Oct 2025
 06:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org> <CAHp75Vewc2OoD7=eoFtrkPrGRuB9ZGT2vu4Z_wdHZUDZ8igUtw@mail.gmail.com>
In-Reply-To: <CAHp75Vewc2OoD7=eoFtrkPrGRuB9ZGT2vu4Z_wdHZUDZ8igUtw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:40:00 +0200
X-Gm-Features: AS18NWC2AFr1HYLKJbD6SJ_gfPPZz3lolA3TRfFJfK8fopnOG8MhqaQPJHZTguM
Message-ID: <CAMRc=Mf_qfFzWqy6ND+YDuXcv5NOYiRTo9QY76V719PqJBMxPA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] string: provide strends()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:34=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 22, 2025 at 4:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > Implement a function for checking if a string ends with a different
> > string and add its kunit test cases.
>
> ...
>
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -562,4 +562,6 @@ static inline bool strstarts(const char *str, const=
 char *prefix)
> >         return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
> >  }
> >
> > +bool strends(const char *str, const char *suffix);
>
> Why not static inline as strstarts()?
>

Because it's not a oneliner.

Bartosz

