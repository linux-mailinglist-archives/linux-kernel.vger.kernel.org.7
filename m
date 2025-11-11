Return-Path: <linux-kernel+bounces-895169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF3C4D1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54028188AA36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0334F466;
	Tue, 11 Nov 2025 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsBzDYgd"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54C34EF1C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857699; cv=none; b=evsKH9WEYhglyhQhbdCx30tiJerd2qN0YgGqE55DbS3YWEsDynKZt1qgY1pRprAjEFtOzij7I84FXwubHemzfVTJjNLBAzwz/IG4MsgX1b8e4OJGjGMj9FNpD3wBDZ7AherblmGDzksHNKyC701lEioS1xBeqJ+pZfj47RPTLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857699; c=relaxed/simple;
	bh=0cCxQ4zVWtY3CYLsY1wEHVW86S85uWrXzNYWN3lThqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8W6rcCgCqbJv05OHy6+pzi4B4WhCsGeM3FJKCHtMU+Yd4NsIowSHo1bc/xgK8c5ZALkTwqw+3e22INtL9MCBPDIr+yStGAZEOvyxd3xgP3TbCx/AfZFZEui61BWYp8jIMz/oJweeI7wstHbz0JWpzQE8IgqyozsFxly5PNaJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BsBzDYgd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcac45so37212807b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857695; x=1763462495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cCxQ4zVWtY3CYLsY1wEHVW86S85uWrXzNYWN3lThqE=;
        b=BsBzDYgdLq5JYwIPqSNeLozEHIi9qdflkd/j+ui5ZkmusTeSLTraVh0m1pdGS7gOCV
         64pTgt6ji6t0/RlTTav+AJBDlWDXohuCpjSaYCqbZZMCQXwfYjDLgsAje2blEWsbDPza
         ZLkyEtyiLklNhaHYyqwFdzZrtH+Zp4Bbqerbkrwr7weYuMQmI1CQUNcfE9lrJSBzCuRy
         Sk6lKnxRtyVwNdW8vfFhBIVU71FHD+tbM4GY6sacppRZUjIG2NJuiwAkbcSiml8mD1ah
         eSJXv/ko8om9hSU1bk0k35hMHNajUUhmz8o8BDZozzGF1fXDgHO5xFoiTGcSjcqgd5Q4
         Lz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857695; x=1763462495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cCxQ4zVWtY3CYLsY1wEHVW86S85uWrXzNYWN3lThqE=;
        b=aW1ZbMhzxN3EazEbNBP+zhJLe4O6wSlYr9iesrwCrlQA6rdn1OwWJOqXt7gWzk+DcS
         IYAP9SI91hAru9YHEZ+XSItL5KzZJjpBOCRTLUR3/FxNfVFYvDa+WZaxUxxHUFwDOw81
         pV/03Svann4eWa2z+5xvnJ64RRJvya4WrhFhenaWIgViFtfUbkTLZ69kju5ozxwF/NC2
         16fuXx9UO6TMA59bMl08dpIoAwCZgdMoboea4o2rz2ZbP8SHXTDRDDSpHhhjnkBQhZfO
         eaiKYt7YIrsm9jU966IBK/ops6Ixa0laTay/Wz8XjpRvc0I85c9y9tLAi6bXmz2SCt12
         NZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+MhAokKAUs0NbtSNHMdo6gxGaXTGpkTojCVVqXBWHWVtGs09vBrXHUDKCO9yCedXDMrymtmsYcWZU+bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWXw0yewPBUmTmBskQF1b2/hDvJb0lsmNKX8w/5C7heUZNIy2
	Y76s7elaGxXjQn9LrEuzotfs0f2yP4oyXLa0U40O3OupmzMWpEdc/UTEyuBeUtzle/mlu7BR0ma
	n8iLztu3NgRR6HadbDFXZEUlE04sN/k54dJofXPerTA==
X-Gm-Gg: ASbGnctaw6Hu8R6FMw516eW3eZ63YtTuB4O77fODPccm/taz9aklMf4UTIoSQURGcEE
	qDnELmLUCD4Ia5lCtLvIySbeAOmYjaKq6dsejiw6ShnDO8Amg9abjRUQ9MQjgpnLmOoPAhJROHl
	dI4xEy7O1jE43s/IZF2vJu3eRnue8jD/pdZxVnlAKDF1AUk4Eyt5/RHWgWHwqcX1p1V58uuhEv7
	N8bc4VswFdHIQMTMNluajP8yEG6suHatvVZJj0Q++WJNp5qbX1Bq9ets6IT
X-Google-Smtp-Source: AGHT+IHoTEqTIMeK7JCIYihCqYCVhAe4gzTa4C+3j+k47suT30AzzIQmG9wEWL0FkhepDKD6CvXqSafZZ1SR1+atEmQ=
X-Received: by 2002:a05:690c:8687:10b0:787:cab5:79a1 with SMTP id
 00721157ae682-787d543ce2dmr101353817b3.32.1762857694963; Tue, 11 Nov 2025
 02:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <20251029-gpio-shared-v3-3-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-3-71c568acf47c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:41:17 +0100
X-Gm-Features: AWmQ_bn0WFQEeQmuj7iPjvAHMQKL1gkynLIxqjiJlR4NSYtZ2qnuSvoaANZDav4
Message-ID: <CACRpkdZwO8mXvjwS7xgVvHmcpF+_pgKYsj3c3QRUcYWPdCt5ng@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] gpiolib: implement low-level, shared GPIO support
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This module scans the device tree (for now only OF nodes are supported
> but care is taken to make other fwnode implementations easy to
> integrate) and determines which GPIO lines are shared by multiple users.
> It stores that information in memory. When the GPIO chip exposing shared
> lines is registered, the shared GPIO descriptors it exposes are marked
> as shared and virtual "proxy" devices that mediate access to the shared
> lines are created. When a consumer of a shared GPIO looks it up, its
> fwnode lookup is redirected to a just-in-time machine lookup that points
> to this proxy device.
>
> This code can be compiled out on platforms which don't use shared GPIOs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The concept is sound and we have to begin somewhere, optimizations
for code reuse and cleanups can be done in-tree.

So:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

