Return-Path: <linux-kernel+bounces-857924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDDBE841A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF41AA33E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3633A009;
	Fri, 17 Oct 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cIzL5Ck/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3333CEB1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699400; cv=none; b=XZmXQf3lzb6ElIZUJ/Vu92v7/soY14ubQW4MMZMpJ7Mog2tW8/jS3/i9RcJOZPZ9wV6lbgJiZ5U6RQ50CezYlzOP36SieJvjJbPhlyENj0QvAT1+TUAwNWcOCaKWmOzGq96qtd8UlyOQDq6Q6SnYTzyzMcmG2lLFpqa9M/LBXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699400; c=relaxed/simple;
	bh=jJ3sJSfGGDZPPWMFLprjMHiW/EllfBTeLQIZoh/ZyxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZuUWxLfzY9PzW/wxY/TPWD7ki0S8KekG41uZFgWb09KTBecZuHXt0oT++KZdmtxONHPQwDPD0gH91bsJ0C/8/LnQZBUdHK1fEu8n/MxOPLLw3Kv31BJ1SsI42aTdMK8a7TecJbc2yowtZ8vMUXhJqEjD1aqXwfg/fRSr9VhiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cIzL5Ck/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57a604fecb4so2151109e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760699396; x=1761304196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ3sJSfGGDZPPWMFLprjMHiW/EllfBTeLQIZoh/ZyxI=;
        b=cIzL5Ck/8wNnAqKxninMiulfKB+lAxTj8XIrxSS+iiRAcsawulROWtwlmJks4eMX9H
         atmf234J/YT3RmK7vU6F8DHOb661sc5v1x6O27o/8H5Ud4eJ+uKzOUoLd3SiHzsDSoiD
         Kw7nffjX5GxU3YxFgGapg00/9VfD5zTt3HlBXmYSa2FVUHznEGuu6Dapc53yohmiHPZu
         cMYJ0nbkoanZnpgE+Dl2sbronm9lea2LLe2sp5JI6TyEdED8TZYU+cnNbW+geOKTtnlS
         PXfPn0ctDbcz87Yg8BZWOxVmmbHqtg5vALxJcsXpl75RYQCV6NhyXHVMcII87hMVt6zs
         T2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699396; x=1761304196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ3sJSfGGDZPPWMFLprjMHiW/EllfBTeLQIZoh/ZyxI=;
        b=aQtDmlbUeYCNIZid2X1aiaaLl55EZw/YNZi5Z6xeHujGxnZFrAAcwIUcH9FRQgNY1p
         VihggOCDWpDeP72hikHId/165TvOUDkV0/ZAk6gvTuXluy4xeAHUtdlprbMnFycWSB4s
         YkVHsZ5zFTQ9XgBvCW/uCqQJZJhOo4hpqo57toAOHUc9QHAjM0o/uPIFPtJ+2+VKMrRe
         qNGTvAOokEBIl2qy6d4cV1/0FAPq53k6qSFyL68Hg/BgzsMWoE1aPFiQZsD/OpSopOvA
         z4m8YxZWLt3Lb/kUB3eIHZ2BSmfD65XO3jf95ycDXTZErnS3zTYpMCVEbEoZh8GJsXB+
         ZNLg==
X-Forwarded-Encrypted: i=1; AJvYcCUrpOcXN/AsQTG7wCsQOjGbtA6IxyinWnOXN3gjVYN3B2+D/Zhk6YHuWwcVePjIzWlR6VLCb19aSBx+gB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTwzHHgAfUHsf/kvfJ33TOxtEERWGHOctp5B7yY+XEe5wmwum
	xdZoS5HhwXbOelSr+noyjR6ISKOzuGPpvSRpO0oAlu/Magjwlcg6Fq456Lp8GZPxvQpOEPXd9rA
	CeVnqCY6EoMeUGH7WJW6Ah6TU2NLEuHb3wVyVi9aet8OqwoiWTYpuIk1oCg==
X-Gm-Gg: ASbGncvW3Br9bHC6msKcExUp5pAZcjtFWiyFPD2o7uY/W0jXKvkbihQYHldCjIURzcr
	yWg8wQEYg7zhUTm0ZbrKngxAbCN47h5oW4gNzJaq8PoU/wrVEP7mgya2flea3akOBAXDjHd+Nx0
	qUc7gYzXeZScjhlIFH9E8xI8t9kDA7NrMjRTLb9zPlMMINu4r2gXSH6oIcytv0/1kWFzN6wwW+S
	cQy1z+8G5u6fPyntiOS101IfhqAW4F+PoeChN6AbsDO5CzbJO+E1oPHHZl5THsHJvznCkULqqkV
	OP8dwh24uncU8NwL
X-Google-Smtp-Source: AGHT+IHAQb+PujZ3FlhVbP/5obfB82tUK18MuZgZkVjEsCxRPkQtT5FNrzDdnND37AsMEzZd7iYSCgmCJUb3JOw9GHc=
X-Received: by 2002:a05:6512:1324:b0:563:3ac3:1ec1 with SMTP id
 2adb3069b0e04-591d857942amr1167284e87.54.1760699396306; Fri, 17 Oct 2025
 04:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <20251015205919.12678-6-wsa+renesas@sang-engineering.com> <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>
 <aPEAx8ZGHBcWZKJF@shikoro> <CAMRc=McsbAirEYjoo455mbKU495VEvPmMEqBmZCq2hw113YHOg@mail.gmail.com>
 <aPIfF-3SgzW5V_gs@shikoro>
In-Reply-To: <aPIfF-3SgzW5V_gs@shikoro>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 13:09:44 +0200
X-Gm-Features: AS18NWA8jH3FhagHn3D8_Lt6AEhdFJCJ9BjuVsTGnGPGq3eRCDcchI99tLK0230
Message-ID: <CAMRc=MfVPO292xmnXBWJzWuhNADA_u1yvpJ4kkK8TgZyQgaP+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: always include RESET_GPIO driver if possible
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:48=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > Interesting topic. In fact, I think we should make RESET_GPIO bool. I
> > > think the fallback mechanism of the core should work without any modu=
le
> > > loading infrastructure. It should be there whenever possible.
> > >
> >
> > You have not said *why*. How is this different from any other device
> > whose driver is only loaded when actually needed?
>
> ? I just did that, but let me repeat:
>
> I think the fallback mechanism of the core should work without any
> module loading infrastructure. It should be there whenever possible.
>

It's not really a fallback, is it? This is the path we'll always take
if the driver requests a reset control on a firmware node which has a
reset-gpios property. If the driver goes with the gpiod API, it will
get a regular descriptor. It's deterministic enough to not warrant the
term "fallback".

> I might add that module loading infrastructure might be broken in
> userspace. Been there. Also, some drivers might need their reset early?
>

Then I believe the platform's config should make sure the driver is
built-in. I don't think it makes sense to just cram it into the kernel
image for the few users it currently has.

> Looking more into it, I can't find any 'request_module'. Am I
> overlooking something? The fallback feature is only present if the user
> loads the driver manually? If that is true, it would make it rather
> useless IMHO because consumer drivers cannot rely on it. I must be
> missing something...
>

The reset-gpio driver has a MODULE_DEVICE_TABLE().

Bart

