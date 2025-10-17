Return-Path: <linux-kernel+bounces-857570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA6BE7294
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D202426236
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878F283C89;
	Fri, 17 Oct 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Kw8bQLFb"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFD28469B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689632; cv=none; b=Mm+9Yrgb5ag+V/PdeQLWVAs95a4+naNqzTEZPQ5XiQ7L+BnBubd9RB/oGEzyC/8ejmbeA5O1CAT9IMdfsnlLUAMqbukVgm8bHtRqhdhG58tO6KKs7Oxy09egE8RKX3/elIKVLlFB29TN8AmVU9XBg06j6K0PlwVFwz9sWkhTtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689632; c=relaxed/simple;
	bh=p0fkPR07R3AjfCc+3PqgoNjeMw3Dpbanig7t2u2fafM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYmUuJ3huftuQOivYXzwBDc1wWj8e8yy8/GfYlyHNKoo6+ISqVRiHY9ejQ54121V/PKrgsHrjrrJY9jHZQwbKbIIhXyD1yFlcdVnhidpnViIneGHu9uF6Untfra+soQW64V8eOLA7cY+FerpHFGeoMYO9VeanQq3/VgCfpifP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Kw8bQLFb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57ea78e0618so2015561e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760689628; x=1761294428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15+cvikOEb/N+bxSV8FiJMWqJU144Pr8Ahk8t+ghMq4=;
        b=Kw8bQLFbwdI6GT9TTZC3waIBDVhOGFYg8ApAv+uObPhivdrN6hgAbKy8nhNwBDlXVV
         65VbCWJKYWxxpBRbqVMIJBSgZs+VOtB/hCf9u+rDKqUFCJgzO0zIXDTNYZOW1rQFgTAD
         dGzDZyLqTa7GwNh6FYgSzumFUtdfULSVljFARuApDrxOiGcW5VoAzouLQpi/WIn4ADp2
         o36uqtDJbuPg5q9oVFMeSsEZ9UU7PuGiGv2LuZDeCziVM7Q1731RtEfV2XeH+ZoZDM48
         QZtzgthv0LL5S9gSJqgtalS6rF8YBzDl8DZKBRM8DVnHaEy6yseeAsErYIxQDHYQVrzz
         x2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760689628; x=1761294428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15+cvikOEb/N+bxSV8FiJMWqJU144Pr8Ahk8t+ghMq4=;
        b=si74sFNN61u03rJ4VI/RWwo159q9gPr9lsIl4iiFfzbmPBdBtwJbWsiOYwRs2gwMR9
         iKWsSoCSgUiw8gcbVgAEv8eCdo/+AD38AoiAwD8ovpgyQO6ECIJFSOEn4mLahOOKjW85
         R/TpUJrY2fFcYtqkU/oFZNhmTydthWOJ5TCgNVm4+TF+BwVt+IiOOWQIo4ewscYDvOc7
         2gsuKUFysdCWbVDrLxDLcoyNCCk3kvAtHGSItt2mlTR76SJRGgTEO7C6/XEKp33lz4W6
         Z/tDlNfG4AxrJdMRqAc+FvstuK7SAXZJkFc1ws9i9LCqzAk0VNv5ZyLzf/ZmQXeexJnt
         QbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaMr/VvOM1MXGVJW0wILkQ1JSQIx6STVuZu7TY6QT6VjDvVrLYX+Ztl1lrzczxN9+kgkA40S2ogM6KogU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0aytjilP90DJYyhGDe8Qixvp5LVOLLaypdEHk6+BZucEHLIe
	y9qRqH8KRJvmtfBKsb6yYThTG66vuR3SdmeTgK8+MyssDgRoJ2ZQUiiEGNpggnNj0btEb7R2Jv5
	zzgdwHYTPmAsy5FbdvTIGRKr1+lNCADSPsRjjiUzAOA==
X-Gm-Gg: ASbGncuefAXFt4N8CEGSZvQeXQExCw3DMMylK7JSp0JJWL8Lws1+Ui2pLjrGmhPpyq7
	usVe7I5MMQWlxBr0hrmS6RWr5bPJT2G2xSL4N3jss0ojHX7A05+U85u2oChd2tQFD/+oxyQavMI
	j8auspGDr6eauCDioASBzFKoac4mPPyoPPZDS9E0bPjBbJZDz6pD2NFRITyO8icgoPpi+RENFAF
	kLvL/ihyqzuW8r1qFGHlLhPkJA8BG509dpqnsg6O8QyzXoh2lYOFvXbOsiIhdBqLUQxtpKJtKNa
	qnmEZNbqJuExwJE0q+yRk5WAQL0o76RwerX5TA==
X-Google-Smtp-Source: AGHT+IFwBncw2Alu/QrgMDtxyBQtfNfh1dxGwzHw2WYd6BMmIRW7GTYerndPtj3BFzplWGL9rnd33K0LzXn6GGDseB0=
X-Received: by 2002:a05:6512:131f:b0:58b:151:bc0f with SMTP id
 2adb3069b0e04-591d85aa254mr1018570e87.54.1760689628553; Fri, 17 Oct 2025
 01:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017-fix-gpio-idio-16-regmap-v1-0-a7c71080f740@kernel.org>
In-Reply-To: <20251017-fix-gpio-idio-16-regmap-v1-0-a7c71080f740@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 10:26:55 +0200
X-Gm-Features: AS18NWAvJs_3O-y2cqSEZ1ia1pDDJUTRQDnpYtzwKwzQdQqAvSOQieJIv9e3Y7M
Message-ID: <CAMRc=Md0iMkYtLZseccidLvhacsRRM4CXhL48Y1O2Ri-ZTeK9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: idio-16: Fix regmap initialization errors
To: William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:58=E2=80=AFAM William Breathitt Gray <wbg@kernel.=
org> wrote:
>
> The migration of IDIO-16 GPIO drivers to the regmap API resulted in some
> regressions to the gpio-104-idio-16, gpio-pci-idio-16, and gpio-idio-16
> modules. Specifically, the 104-idio-16 and pci-idio-16 GPIO drivers
> utilize regmap caching and thus must set max_register for their
> regmap_config, while gpio-idio-16 requires fixed_direction_output to
> represent the fixed direction of the IDIO-16 GPIO lines. Fixes for these
> regressions are provided by this series.
>
> Link: https://lore.kernel.org/r/cover.1680618405.git.william.gray@linaro.=
org
> Link: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nuta=
nix.com
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> ---
> William Breathitt Gray (3):
>       gpio: 104-idio-16: Define maximum valid register address offset
>       gpio: pci-idio-16: Define maximum valid register address offset
>       gpio: idio-16: Define fixed direction of the GPIO lines
>
>  drivers/gpio/gpio-104-idio-16.c | 1 +
>  drivers/gpio/gpio-idio-16.c     | 5 +++++
>  drivers/gpio/gpio-pci-idio-16.c | 1 +
>  3 files changed, 7 insertions(+)
> ---
> base-commit: eba11116f39533d2e38cc5898014f2c95f32d23a
> change-id: 20251017-fix-gpio-idio-16-regmap-1282cdc56a19
>
> Best regards,
> --
> William Breathitt Gray <wbg@kernel.org>
>
>

Please use get_maintainer.pl or b4 --auto-to-cc. This is the address
I'm using for reviews.

Bartosz

