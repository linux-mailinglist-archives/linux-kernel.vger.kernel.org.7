Return-Path: <linux-kernel+bounces-802316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D489B450E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F288176C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD912FD7B8;
	Fri,  5 Sep 2025 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bn5TQY4F"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003F2FB60D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059832; cv=none; b=rVnoqWkzxAEx4Gh4ptbi7l4PV/8EmloK0IvpYVm2MDBGvzlwOHsM1IvkEUZv95ngLZtnfEgtVEML/n2dhfmoyNneMN1qEW8Jg7kYT2GxT83KyP38halU5sa82Cb2tjYRyd48U1z2SFS0BmA2nbh4f6GvDdggQsbQx0x5lp67DKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059832; c=relaxed/simple;
	bh=BtGTpK92RV2Z6TkeFuzCre6Mq/G4NqRshn0AGkTNf4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pm/XU+iYVkyiw1MGBfozfhz8BJuXtBvr3sa1AoRgTLyI/NSiiLHwxGb2IjfPzO2OYWQL131sWNmiuufFkYZBYTBq0DNRYvtZ6LFsrerE7lNQBB07qqbz9/kA8Mj+ttlckIgkgusVd17FI74Gw4Z9I+I5DMv6iOyU8K37jOR5z38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bn5TQY4F; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33808d9e10bso16841121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757059828; x=1757664628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtGTpK92RV2Z6TkeFuzCre6Mq/G4NqRshn0AGkTNf4M=;
        b=Bn5TQY4FBlGSlUcjEP+x3Di67lMAFi5yaMEi5qM+uA2mKdG79IcWxmnuhjx6zlGJws
         87CUAK4UH4zuWowgtNdTjNQfE6BX/p8oT93qCOZhSx2ygm2iRd+xnNRiqfHIY3edK4wp
         hrytwv8oKbIwmIYNPJmOhNraz05bJUQgJPdVu5AakjpJnhyv/PeXjVgQl/iCzRRf8nAZ
         Vc4To6kk/LcIngsy/Ryr9EMmlvw52hHfFHMNd7tXueiX3Jb8rTXTZyfPD/jFm05PpaxP
         x/MCZcK3qYafQ2wr1/qimNT8iv1hsopNK7dmAq5MuUJ3AD15BbYDtCX06sGg3M0quAjC
         ogeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059828; x=1757664628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtGTpK92RV2Z6TkeFuzCre6Mq/G4NqRshn0AGkTNf4M=;
        b=lLuMV0AXHg53gsHnJK69sjVRICuqSYVXJmqlNLJxKxGNlGM8NPqKI7S9lopogQVie7
         hQ+w1SmjyUQTe63f/4kv8PQC5gGT691PfGraXxOn2U+vMUTC8bpOGJPgm3QnsOEpMxbJ
         MS3ncBkpyTgQm5V/VKViv/QZG2IaZiW/SH/jabQ3Hi4kKOodZR7XHnBUJpwZs8/n7UEm
         RqKPdT2QZ8Firr3VEkSjHhAdDL0pDmBYm5bqDkTyd7cLOo2mYC0wn5JjwTyF6c589Iw9
         eY9b2sM8iWWXklcGKucZdRKa3T5svMBHrh7TKXKDmZeaOM2N98IiDX6HvLPdTvoOysXK
         f5rw==
X-Forwarded-Encrypted: i=1; AJvYcCUwW+shvhLgL3vdSEFcQyQyR2pYEvr11q4BNVF6EqMgvdXmQWN+E1fIct+Vq0VzpByByZJQCtTYcZYtypY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffdphkubNE2ELOqms29yufDR61v753FDuAcBsW6RAmNZVy4tb
	fGWH27tRjpaXYn2nPz3mbxzVqakOOyE1pqcYJTJg9dd8wCVf9RRgMzA35LE2HBSBMRHAY321bI6
	EKtmF3B/qqttwv5CC9iPIb1UA3HdCupxTGQxObzERyg==
X-Gm-Gg: ASbGncvcjEAbNFv4uQYnxAXFzCfD/1/6UqjNyxFc2yUZhN8yss2vVF3FrQvcQxUCbkF
	GfFsIZporuKRJ2Y7p7GWA35hHDOEjI4kl0wolTbDSzjsE6+Of3Oh+6tjkAYb0cXRvaM4JwwuLI6
	nWRgagHYE6D238h2FPj63yKzDeesAsX4C0OabIAOiNUxBlDdWxVwyRJVm7XhCXwjQFV5oSPdcM+
	PuJih4=
X-Google-Smtp-Source: AGHT+IHGuueojXvcDw+IxXf2H0yV1IZv2l/On0WYvOmWs3UEZEA+8rzZONaAnBMOjzPj+g4/KV47tq/0JIxyMnlIPRA=
X-Received: by 2002:a05:651c:989:b0:337:f40b:ceff with SMTP id
 38308e7fff4ca-3381e2bd8bfmr6337601fa.0.1757059828213; Fri, 05 Sep 2025
 01:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757053456.git.mazziesaccount@gmail.com> <fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
In-Reply-To: <fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Sep 2025 10:10:16 +0200
X-Gm-Features: Ac12FXwzrJgD4cqNVEMDwjcqLjGCJuYfaMNmrTkon9AkUOYZTyb9cMdwIMQNW6c
Message-ID: <CACRpkdaY3P7uj8dQfDbauvyJ_sSYPeUC7kK+DTMrkfT+BcLjCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Hans de Goede <hansg@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 8:42=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:

> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>
> Add a device tree binding document for the ROHM BD79112.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Looking good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

