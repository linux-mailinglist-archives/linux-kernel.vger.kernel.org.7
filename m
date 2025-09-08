Return-Path: <linux-kernel+bounces-805863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB382B48E87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924C53ABC68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA30309F00;
	Mon,  8 Sep 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuIsOTaI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739F307AFC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336659; cv=none; b=jBcQjjp4Mp/Byi4ABgyjNkzOVkZZ5c+aFAyeehTUYwrYqIB5KHnN20mn27Nxrtv45STMf7E1Y2Uu2rpAu0Q1irmSWumZo4jGwWP8gR00HgufzUgO6LCzWYVxefV5GFFKHFLFFi9hoTFdqLmrJkFODyd07WgHnLK6zrWgRunuGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336659; c=relaxed/simple;
	bh=cbZwiukwDnHDrFq3wQYLcIHXlTy3luajkiLNTJ9nWiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddxawkWRMh05pQ9KbhwNz8qWcx+4fY6orb2vf/1hNfSJc/2ba0VMibgg1Wi2NDmaWJYfQDqoJPWAKBJ7cIvw3qk7kF6qXgAwufK8ndOcNsmyZ0UARBKfikMZyfLYat3kck4Zf1Kac9EjeaCxC9RCFVTV3yw1gBti8gE6IDGZLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MuIsOTaI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33730e1cda7so40327311fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336655; x=1757941455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbZwiukwDnHDrFq3wQYLcIHXlTy3luajkiLNTJ9nWiM=;
        b=MuIsOTaIbDk/Ne+m0B/pMslwiNeAYtXtApwjwNMtoj7EeRIGhnv9kWDsPBtIALLZN3
         1U/spYWmvDSR+I0JF7ztWFbre74L11tS6ht7cPlKITrJgpYZ/MgQdA+SWUmlMPoQODMy
         i4WEzp2bWtdzNaH5TIuL6NgDEHNlFpjdvHEdji+PtwJaol+7LOexLI6zorNvwmV5YcnR
         B0z6T8sYtbOJy4MBe8VCOIy5xAZ82Vs1GU8B1g+j7nptIB39uzvBNpVYV9DTn71ZOZGh
         OtXzumWQ/sTKg8rfWCIdQHHvzIoMI9xjToxUx7WSJEHrtzim5425JTlxGAC3hZIELFyw
         NT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336655; x=1757941455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbZwiukwDnHDrFq3wQYLcIHXlTy3luajkiLNTJ9nWiM=;
        b=MPKQI7SDG5NZrWlEE8PccqxSRk2L8tBBDHhWFoxgcvyygO41NNOzulsCmNXc3BYK/Q
         XctcJ4dRXXdcSZuuhDT2GuvGMAXL6T+EAMV/vxK5pJpEXJLQE4hXPgJWSWW+XlrptJbY
         iCwS0R4QJMrl/mSkFpJdTc4L/X2CxnZ6o1Y9LDUyj9eLmD5I4bPk12QrowkgoO0M0ZHA
         4/wSPz1+jEWEuhcAyWCgATYLpyzceep41wOQ8d0I6yXFoF78hKo7B34SsNYWA9nLu05q
         LSrc09sQKBYiUz4HaMxwAl8XoPqfPGENfnYaiyr8wsNISyKhlcGr52G7HNmTUHW/RQHQ
         tCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZj73Iro9O83Fdv8kP4vklp82oNNqt6SprjCTRnAJ41hzaTglG1VT7hLojO5tDpr49+RYgRXpi8SEr5c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mcunW1Oez5R8pWy1rRc9VDNDRF2raCYUrFgVffYCnAEL/LS3
	JpZPGU1FyuZsX2yfjkKTrLWnBAcNa4usCvChtb20A8WY+62hP1nxgqtcnx8YxqCINMR+s/ZJtyM
	qzxv6r2k96yDpHNmZm6Ox8Gz2bhX8AItthFP8QUyE0A==
X-Gm-Gg: ASbGncuH3O8m9EuaVon8D9eM34qNopnpaDj2pMXzDAtVFeae+Qfq5X93UZwjBePphsR
	yJ/SJt8pcz0t7BR3i4zf5WJIK7dI78LI8zBZq+GncYQ/aGKcnP7aD0IqQkJ8kJKXZ054kIlzwBf
	1xF2HyzcGxsue6ENJt4miYx0WbJrU1WplMAM7RCKN0PjPYoB9NwRAmn9f71TbMih7QpqamCdZA1
	WIFO/c=
X-Google-Smtp-Source: AGHT+IGg4rogX0hb8M3wkRrCGyxcIS8n1x/nra5mMODdrlIDHhbHVFLHqNZGqHHGv1GU+9Sji/glMKNv4ydxz2WaN08=
X-Received: by 2002:a2e:a78a:0:b0:32c:a097:4140 with SMTP id
 38308e7fff4ca-33b485c2616mr21948241fa.0.1757336655209; Mon, 08 Sep 2025
 06:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908113723.31559-1-ansuelsmth@gmail.com>
In-Reply-To: <20250908113723.31559-1-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Sep 2025 15:04:04 +0200
X-Gm-Features: Ac12FXyaXKE0nskg1RjYMc8Puf3_DYZA9QjaZBlexnTSmjTh-Rk2P6swvJ94zgM
Message-ID: <CACRpkdYYYAeqZZg58-2De-gfJkovYxABssuRk4xrS5SAC5=YQg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: airoha: fix wrong MDIO function bitmaks
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:37=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:

> With further testing with an attached Aeonsemi it was discovered that
> the pinctrl MDIO function applied the wrong bitmask. The error was
> probably caused by the confusing documentation related to these bits.
>
> Inspecting what the bootloader actually configure, the SGMII_MDIO_MODE
> is never actually set but instead it's set force enable to the 2 GPIO
> (gpio 1-2) for MDC and MDIO pin.
>
> Applying this configuration permits correct functionality of any
> externally attached PHY.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Patch applied, recorded Benjamins response as Acked-by.

Yours,
Linus Walleij

