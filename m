Return-Path: <linux-kernel+bounces-852095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4873BD826E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64DC3E8BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354030F927;
	Tue, 14 Oct 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5F/ktAF"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE781A5B9D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430202; cv=none; b=dWvZqEfIXhRto9yAA0EQWfJHa4t7HTwwKvfGEKc0cTeq8GrYzr662gjBLPzy8Oof/rgRFNtV1/xgxg4O2UQlfLQuDEeKCYfZxW3k4PffynyE/HDTsA9ALIUQ69vQf5JtblwP5ZeJee6EooLhKehWYknPbI/KTMOa1RUPg4C4ZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430202; c=relaxed/simple;
	bh=QpLLN7omLU7FVeu70pu6uFOP+AtOBErrgm75t8rLSRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZIOFtrG5RoxPOEjibYB8mm/k9U46TMT6fugMjbt8VzRtqH0+cUVnH5SU4ItrILTS8ov9r2wWNP564OocvsvDDQLHXv/PVXQ14/TP6ze+mzWjX1rhkRmhCRe+GkskCVay3cEJI18wbzx0gQw8oMHjUtvFjkKq1X2cF8OdB3GqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5F/ktAF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7815092cd0aso2393697b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760430199; x=1761034999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9TclHM+FlxL8k/EdZlfp0sKQpkcWovBD/evGnk/JRY=;
        b=d5F/ktAFXiAlca/nL4hv1iOe9/I8zrpQX5eD+YjxQvMcYsXB3gO0yt6NdWCwZZ1Q8f
         YGm/uQWNq9Z302yY+mMQLJSQTzyTGw64d4voZuBwYDnLfJjZ/9ZYGSzDaRVh1Oihsyvh
         8oKbrs+cvUN7M5292eAW5DZCwfjbkCyQXaGP/YhGeWcgOw4qkwYQ815xURYyl2yt/suN
         XZtcl4QSVC7UHy9+ml8+wKOZ5EGmBnY0j9EpKCpNTrYcnDyF2qc766x2kqReFaBw0Zo7
         yOZp27Y1L9JGsiD2XKQhRQdoRk8SF2q0YzB3vHEjTo0/lrv5Tv+y87v8+kcC5qHSnvJ0
         5IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430199; x=1761034999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9TclHM+FlxL8k/EdZlfp0sKQpkcWovBD/evGnk/JRY=;
        b=g/Z28wV4fHtXNkcLEqeEi7qwRuW91h/xPplwR3GPDjYQO6+EpYBA45D9yDTyAnSNtg
         sZprDb7Kk0DHG6N5ZEEYhq9ESmQ9h9/Gq95LYl1UIFdIILrhoKu38p0uSgM5veNA2vas
         iNRFVf0vZ5DZbRP3C+iIXYHe4KpApKUjMa7YsG4F/IzekDT3KsBMb9GKOst0Crsgo4sb
         8WSzGElaSmhRnx7gjSEF76B7CebhZm7vwUtXKslbHBsM1KdXlDH6MLNXyPzhz2gfzWXa
         U8wF/UTbFECyCZW89SnmCbwTQU/0ze8CuS/fJm4eSBNYMQ3VJL0q6zjHEitDABiC0fnp
         cr6A==
X-Forwarded-Encrypted: i=1; AJvYcCU8060sE41fow8vjKN66ab/frcU9goK0xN9yhoUyaT8VL9UghnrJJS2jZFgOuDswXslnwCyuQAkgjt3TI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQElBofd/zqI/6oId+6GA+otnrRyn33hSPt5D2YAnrZURmf3s
	NpQRz+brtDm2XtaSYTG0eOVUmD4BnVasPLVmsJnftsne9mzOCQvScMNmU9gs6DRZPMFP2SsWQbi
	+UtGb19WP8k2gKfizts8+V+q9bcK14o/6tiFxm5FcXw==
X-Gm-Gg: ASbGncsUj23hWhbDqRPQ81SYBVaNclZBVPxs9Ylh1OlSYTRPR5rWMFAaL2nMEYkJ0SG
	96nPGlEPs5tIlTW+gljHdVYpsJmuBJ6XSQo5MG3OFs8DVeIgq7c5vR4I5oQq4dQNoNAsooso6SH
	3wyCbjfvws2tn4RWNoI9Kdjq0ZDhWLZMhVaM8g8D9PUDkeHi2/RGCDBEcW2B/rRw8xwyZPFpb2f
	qGvqSaEoGr/4xruITDjUeqUiODQg1uqylU9PtNK
X-Google-Smtp-Source: AGHT+IGUPFI5jCPwxpBaBsUtA4t105DOhgNvQsDGVLBIPQELjrZFFsrZcl9lsa37EFuLVIbBf5ZvE7ZH81SU0iQy1BA=
X-Received: by 2002:a05:690e:424d:b0:5fc:5d98:3478 with SMTP id
 956f58d0204a3-63ccb7fabcfmr16158005d50.7.1760430198919; Tue, 14 Oct 2025
 01:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009223501.570949-1-jelonek.jonas@gmail.com> <20251009223501.570949-2-jelonek.jonas@gmail.com>
In-Reply-To: <20251009223501.570949-2-jelonek.jonas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 10:23:06 +0200
X-Gm-Features: AS18NWBS0RiqVLOn6OGw-S2jkVsKedTw5UCNSQ2_7gUR2ne-WB-LpCsCs8TF6SE
Message-ID: <CACRpkdb6bTFbTtNsO59GXFa9eMK9x=+BGK5Vx4bKv62wxiSpiw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: gpio: add gpio-split controller
To: Jonas Jelonek <jelonek.jonas@gmail.com>, Peter Rosin <peda@axentia.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

thanks for your patch!

Including Peter Rosin (the gpio-mux author) and Geert Uytterhoeven
on this review, as they have worked with similar stuff. Please include
them on future postings. The result definitely need Peters ack before
we can merge it.

On Fri, Oct 10, 2025 at 12:35=E2=80=AFAM Jonas Jelonek <jelonek.jonas@gmail=
.com> wrote:

> Add dt-schema for a virtual gpio-split controller which exposes virtual
> GPIOs for a shared GPIO controlled by a multiplexer, e.g. a gpio-mux.
>
> The gpio-split controller is a gpio-controller, thus has mostly the same
> semantics. However, it requires a mux-control to be specified upon which
> it will operate.
>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

So if I understand it correctly this models a 1-to-many input-only
GPIO multiplexer, we need an illustration such as

        +----- A
IN     /
<-----o------- B
    / |\
    | | +----- C
    | |  \
    | |   +--- D
    | |
   M1 M0

MUX CONTROL

 M1 M0   INPUT
  0  0   A
  0  1   B
  1  0   C
  1  1   D

Is this correct? In that case include something like this
verbatim in the bindings (feel free to copy/modify this)
as it makes it much easier to understand what is going on.

That's a very minimal example of a way to turn 3 GPIO
lines into 4 GPIO lines, which is a bit crazy but I'm not
the one to tell vendors what to do :D

> +  mux-controls:
> +    maxItems: 1

So this needs a description, it is a phandle to the
gpio multiplexer (reference /schemas/mux/gpio-mux.yaml
explicitly!) used by the splitter.

You should also in the same patch add an example to
/schemas/mux/gpio-mux.yaml showing how this is used
to muliplex GPIOs so people find this new usecase easily.

> +  shared-gpio:
> +    description:
> +      GPIO that is shared by the virtual GPIOs and controlled via the mu=
x.

So this one is shared one-to-many, and I think the bindings
overall makes sense.

Maybe "gpio-split" is a bit ambiguous?
We have io-channel-mux, so what about "gpio-line-mux"
simply?

The fact that GPIO lines are used to do the muxing is just
a detail since a mux is an abstract concept, it could have
just as well been muxed with some I2C device for example.

Yours,
Linus Walleij

