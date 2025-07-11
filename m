Return-Path: <linux-kernel+bounces-728070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C64B02358
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23831C22298
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8D2F1FF5;
	Fri, 11 Jul 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BExMbpdx"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8571FFC55
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257452; cv=none; b=R5T0cvc6rVlvFA7tFKA96LOyb7Co7+EzpAjolwS4Tjo4Q7iq70DKsdfYaUlT5MmjY1tgktCoqLoSLm5p02C6k9cjONdqBG5xE6ZHw6SOu3TDk/k7J+mqK19N8Cvvd2nE3pWLUjMAObPF0ZqIJS4sIZpyb4APrIL7MftgM7YZSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257452; c=relaxed/simple;
	bh=Y8lKCTsdmMcsbQ5KqJC2bzKvDDr0kMdS+WRZLZHAKrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJT8yA0hXal4uuDJzhDJmMYMmWGre/aFFpqcaw3LrErFkCSc8m3Xj10nCElCToE53wKVC5zRanG43v/e0K8ekiNPPSlwzLXLjb+6pU5sBi2pI8DNqcdMpfNgDsaDUzlU8/4ulPMFOk1dQaxmCKc2lzV1/qcps7f9PHJKPA925AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BExMbpdx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32f1763673cso31373201fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752257448; x=1752862248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8lKCTsdmMcsbQ5KqJC2bzKvDDr0kMdS+WRZLZHAKrE=;
        b=BExMbpdx9LJax9JZbb7A+FOPqVt7plgRTbftYBVx9C1tI0QCQ8w6gkrFqGGDp9Suee
         ac/KsUD+Q9bmoLJTk3DpF+94jEQWVKwwysnIZ2ZRIiD8GCdPaFQqVQuNXnaqeHzmIOwe
         CC1vDjMj7wuy3c3bhh+RGycbFIgnOnPgK/hAzCeEtnF5i9Ap5LdlgtY+ZMk1cDo77VzT
         tqb8Bu/6CE/S9DCN6Lo5RKNV0vRsQarqt1YiflY8mymELChIfMH/6YsdqouLSf5TEM+0
         SKCBKcTCyrcpD6BX7t7ELSyyJETDXRfL+miaoL73w2RwNWoupTdpCgn4mYP6i2Of5JaB
         o7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257448; x=1752862248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8lKCTsdmMcsbQ5KqJC2bzKvDDr0kMdS+WRZLZHAKrE=;
        b=GIy+VKnD7DxRa9LwasUoRJQyfeq0v3NBDVD6aGOkRYpyJyyC9wn8P7KCmmgkeZ+mOh
         7784xoEJWdlbIJtt89HEMbahh8Bna8QE6fxNM47CVr2Yr5JFheyd3GlfsyJCCPAXa/VV
         iEc94m9za5E60QTBFwgJA93riLkNPuJ1Jdeyudo72ymIsnc4J951oGO/CJ9eMUDASUKG
         W8Vdl9PvwBa0OvanCQe5ygoT7kdaYQtJQcgcPTL0lQmO2Dnn/017Hn6KyRwvBM7njlN0
         DJ+isEkg1fIwe1B7SqYC4dnivoSDmeGJUCfICbn0ygsT5Fe6npb+Pe9EFxRnww8s4med
         uBbg==
X-Forwarded-Encrypted: i=1; AJvYcCVOsb7eBcgvdf5J25/FyTj9TrJYnbm8u7jUX50/Lmxs48PieEtPf+IR8pbeSzjsw3jrEXFA8Sd0PCM9IVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXfrNydNwxq9g3nZfgFgqdFP0N5zwHQ2rqBWMlLTvDgLkBjIk
	gUL4LgvXINJkRqz32lsWvXq6xpFtpCSO0K7rb6Xm/A7FSlg6KqEsoPl+x/ezhoyhzPnXuSAYaPp
	NB9ynmXmz2yLa3r6kN8pEViLHDtwOzXLoyEU3dDxNrQ==
X-Gm-Gg: ASbGncsXjswdGS+oEIY+YPRt7dD9R94XfiK/CAONF84cQHZhrk42wIMHKCFnrVAsBNK
	gXBcALP7xnNLZ0MsDdx7uYoJEnfH3ZWgW6bQh/B7LHYpUu83zEoA2wzn9KH9MXggqnLytmA7FY8
	yNkbRl/Yb8ZTqImkN5ncUqZKfNbR3IwW/oXXPJrgzSgHMTKVGuejJ5ufVrinmjZxwpfdgei5sJK
	O4bGuc=
X-Google-Smtp-Source: AGHT+IEVqrHZJLE1/F9OpcrUYWiIuDfn/vgx+mA/zV5YNTzBbNYfBxup4N2mlr5XNgR7YzYyLdLpTrBGk0Jqsdo+rQc=
X-Received: by 2002:a05:651c:b28:b0:32b:70c9:5d2c with SMTP id
 38308e7fff4ca-3305345d70dmr13793141fa.32.1752257448305; Fri, 11 Jul 2025
 11:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707141313.73169-1-brgl@bgdev.pl>
In-Reply-To: <20250707141313.73169-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:10:36 +0200
X-Gm-Features: Ac12FXxyutF9lvP8d8DmKuDDIfVDjdNrAQLUHXwpimZxgqoAbM3VY2wAwoPhpS4
Message-ID: <CACRpkdYQ8AhZOiBV0L66p2gh23GQHoK+y98nuXOjM9bf3xK6Tg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't use GPIO global numbers in debugfs output
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 4:13=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> One of the users of global GPIO numbers in the kernel are the debugfs
> callbacks in GPIO drivers. Before converting any custom .dbg_show()
> callbacks in individual modules, let's first make GPIO core stop using
> GPIO base in debugfs output. Use hardware offsets instead.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

