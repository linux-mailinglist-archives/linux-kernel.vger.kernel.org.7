Return-Path: <linux-kernel+bounces-838931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265DBB0729
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85F61926D36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59E2ECD05;
	Wed,  1 Oct 2025 13:17:31 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5E2980A8
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324650; cv=none; b=lheUnl6cfHi1WzQbxP+KhhLZdTCwvgCQHJSbTPvGS1cH7rksb9Ie1WnzZFJANspWcQ+UbZ6GUtvplRRGdbL0RijOaiEcM9weQS9+VxWINUkEcdWdp+KR47DAYI9oidYqVPWnN1JNDKsFjBbIUhyspOtb47VP2J6jvl6BRs73w3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324650; c=relaxed/simple;
	bh=I05mR9/50DLTEHHaHy45Q5YQgLDEg9VchuCah9dVd2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j32dqjWvN5ZfXex5Fvgz9wVbimjEfNJfwe0k5/85zHj1GNPPcnSrb0BatGFQBZRQr1TvRTW3rI6MGgH2HyWQq/Veuu9ImQnaQcVo1MQnyGsatJyrbjI6If/DW9nWE1jFIVLMu8UQvlCdgokIkjnsnJTLUmTleHKYxIhOv0B1uzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8e364003538so4848772241.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759324647; x=1759929447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYdalTnEkJlTI6nAxkZ1pZoLmc57oQNk8+NRjQz1+SA=;
        b=rMoc5pLP15zuI17Zsh0r1WYXAblYyJhi/WLnj6P0t0kKlYlUWIytqQwPzMksL8gjdO
         K/H8TquAd8OYDLVGIcPlhZMSAlKCHLiD71Zk6si4RJlKTVhS4mUvDDrZ6eZHTq52TUWo
         DbncfPZ10lFBqPpoZW0QhoTUw1Fc8H9VWa+IzwvXkuzXOEMmNkpnjU6FyGz7cUU6XDQn
         N5ZKmx3r42x0fc246GbdMoIPO5bRCnsZJppMaNVLXT40eO/d0QdhtTz05DJbyD7/OVY1
         P0wQrozo46R0b7SA4UDJ7IusMtTM8qdMAXD3qoyW7ei/cU8cDb9rL5diLiRMsYsY8ex7
         0Zrw==
X-Forwarded-Encrypted: i=1; AJvYcCU46gAZbgVDmPPwjMEV2xxmYXchSNH3yeI0nWIS0fDddlKh9qKA5pIUN8EbGL7K3j0xTdNB0kJM3n5JfEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUDoPk7LB+YkC90USSPjgQ9jAllV2ULgss9eh2d9qChIWERDSm
	TKlBCPd6+vrrRhsSxvlkv3OPlOqHjCscz16ZB1QsuEHf1YNS4DMFj7RZwr/V9ya6
X-Gm-Gg: ASbGncvzPsPaGDZ7UoN6WJBTmAwJqg7B03f9YrwfwG6/FqHnEjPyCFSQxKcX+3EURNa
	bRQpM+g+SN/KK4Dpubr9OtrlseymQXDcS2ZqH01iXpXjPInreM6Q2mKiILt4Tupmf6++M0xAvpq
	eST3fFk8MJwObufG1C0hRjG1hPZBb5J7M1Jnoj6Xt88COQhuogjkaiE+XPhHR8kWtWC73U7q66p
	pa/8TgOPB2ejqUpQP7SNB7jPg9xewnRPG3EdGcqYY2MKTxcCTnw5IwIEkkNDsbegjgP7KGn/qSa
	ADbHQp9IC/epdIEQGVxu+SPNAtszPZ0XCqwN2dADa3dk4kqXQaKwOqRaKpd0xEsBBT/MTvgxiG2
	GPjBnwFsEu5fFxx1iehrIteAPMOTvccPl/sPxlNzSsSSHAtSrgeAxPJJHjOnnQCE0DbLmWHopuC
	60k/CWp3mi
X-Google-Smtp-Source: AGHT+IHq1Z8myVqdDdGY0uKoGmB/tOcEHBqG9okwjWjmHNSc1U3DTPLw7DlzJvn5j79Nl4YgY1B0dg==
X-Received: by 2002:a05:6122:3bd1:b0:54c:6e3:88 with SMTP id 71dfb90a1353d-5522d338beemr1494166e0c.4.1759324647048;
        Wed, 01 Oct 2025 06:17:27 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bedc9f653sm3443194e0c.16.2025.10.01.06.17.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:17:26 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ce093debf6so2748513137.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:17:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnBRYRmNYhzXRWqT3EZcVAT5HdmJK8SpzF/eHcWO3xYJ7ntYJEzPRwMGXuOvk0C3UfD0sgoVSaxDN1Jms=@vger.kernel.org
X-Received: by 2002:a05:6102:161e:b0:58f:31da:dbd3 with SMTP id
 ada2fe7eead31-5d3fe509ac2mr1393313137.13.1759324645740; Wed, 01 Oct 2025
 06:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903161718.180488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250903161718.180488-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <db2fc907-218c-4688-aebf-4a929f21b074@ideasonboard.com> <CA+V-a8vghwkHKWoqU8NQ3O9ZdHxB+cEvMv7Z9LQOMsZcx9vjPA@mail.gmail.com>
 <f1e671a3-77af-4ae2-aa6e-bde93aaa54b7@ideasonboard.com> <CA+V-a8tosiUkhaWGoZ9yTBe1Kyy0DLUGreqReH2NOWmVeS5_pw@mail.gmail.com>
In-Reply-To: <CA+V-a8tosiUkhaWGoZ9yTBe1Kyy0DLUGreqReH2NOWmVeS5_pw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 15:17:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFSvSGBearGPU61atsHFu7NoDjpbxNNvyGO21j0-_OOQ@mail.gmail.com>
X-Gm-Features: AS18NWDiZs7Ynz61qNNAVC6cUY3oeLbFhcjv_kGBKaaXq5pMP7Ji5m5RgOlqVh8
Message-ID: <CAMuHMdVFSvSGBearGPU61atsHFu7NoDjpbxNNvyGO21j0-_OOQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] clk: renesas: rzv2h-cpg: Add support for DSI clocks
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, 1 Oct 2025 at 14:23, Lad, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> On Thu, Sep 11, 2025 at 3:26=E2=80=AFPM Tomi Valkeinen
> <tomi.valkeinen+renesas@ideasonboard.com> wrote:
> > I still don't see why all the code here has to be in a header file.
> > Usually headers contain only a few lines of inline code. Is there a
> > reason why it's not in a .c file?
> >
> Ok, I will move the functions to rzv2h-cpg.c and export the symbols
> and have the declarations in include/linux/clk/renesas.h.
>
> Geert are you OK with the above?

Sure. The DRM driver would already have a hard dependency on the
clock header file anyway.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

