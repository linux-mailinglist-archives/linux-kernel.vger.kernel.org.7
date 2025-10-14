Return-Path: <linux-kernel+bounces-853434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 411CBBDBA81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E07643565BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC62882CD;
	Tue, 14 Oct 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fybNStmp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1022259D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481216; cv=none; b=gchK7ovqZde4PdFixeU7sn7XBGbqZ6Nz49xJCL9lH4SFWtQW2yeTiWIXAinEw/ay3u0uRRphusf6Qp+d01xLDbryR5oV5+9+/HAA5VvURp4zgEzfU8hhvJAI15ggAmo80gGxXAawxSoWGElnHkZ5ehsSgeS3iPqt7b02J0Zjf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481216; c=relaxed/simple;
	bh=wt70NE8f6KFvKbMTJnQcfwr03llADeeTF2xs7Y9wWOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sShCW5klfAv8q4TthPljh0sJpDyxigYwsCcgr2Kj2dmYtKIyBXD646JDWSCxeDDUNjzamXtugZfWrjzZ299Q3FY5MFviCsgjJgOCgGuEVgUIpxbAI0KdRcfCO4sQRHNR9+fvH+u3HTG79NG2bWMyA8+HBgVKwwCuJjtOIZqHsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fybNStmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0FAC19421
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481215;
	bh=wt70NE8f6KFvKbMTJnQcfwr03llADeeTF2xs7Y9wWOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fybNStmpBFEcWgjeNQXt21hbjiPw/dJwJ6G0vBvjLTyL27w0Edgv0TEsnqAQeZ+6Y
	 4IYoL1Z1IrMRtTybEp1hsmJ5/xQpJb4A6vEDZkdQh21Y1Cs6HTjuoI+cmBycxwI2Ri
	 3lNfXh6SAhPlY2m+iwAiEyb51er5cko063mx24S56pVLZgRmhAA5dhHKfH05Y2LZct
	 ji2ilaZYREHcI2nJyh0v/2H3fzDlRB8FdklZI62pYH/KOiL8l75ZbIXJZXVwy9GOJy
	 8vbi7VqsKmMKABa1a2DSLmTkvhf0Aa2CDOiOloMj0dUGYOQwmWSc9sJ60LehvwNbDx
	 qGvSAdmRX2gUQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deaef9so1048971066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:33:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsK3NUYNr9I9X4nOqDgNgJbuEDFNIDPgfsFn8xL44T2ZboLk6wC4RXqTMaGevVXrcrTI6wSJ8+YcuuGXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZnm2d6/z++KQaCbi4b8V5gaZcaEraYIpgKOCjQK7l5fMLggY
	FQ8Mok3N9GlFmR0FMeYph1nfPWaEzZPfW3YCE+fCKOQ4avmD4wDjeXesWANBvyO+cCA8yqAdfpE
	0tnzn8Yzv3xCpUtxCLIiV429P6JczBQ==
X-Google-Smtp-Source: AGHT+IHBj1+Km/UzpEy9Jq5twAJCougQ+5+lncmhMeNbeGkDOyeCR3tQb5v8gIWNtkarWm76ySjgYwTXXpVNu6/epD0=
X-Received: by 2002:a17:907:da2:b0:b2c:fa41:c1be with SMTP id
 a640c23a62f3a-b50acd299ffmr2893798566b.61.1760481214228; Tue, 14 Oct 2025
 15:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013213146.695195-1-robh@kernel.org> <ea8a57e4464f832d4cce1101d763b56674a1bf6d.camel@svanheule.net>
In-Reply-To: <ea8a57e4464f832d4cce1101d763b56674a1bf6d.camel@svanheule.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Oct 2025 17:33:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJuSy34LLHwUZK=Bj+-Tak6Tj-CzU-9Ky+=9iUNBTO_iQ@mail.gmail.com>
X-Gm-Features: AS18NWCAUW_D8OVrXfCPLusuJjlxDBeJG_b2VxVCqIPkNkpzK1yD_jisP_VT5eQ
Message-ID: <CAL_JsqJuSy34LLHwUZK=Bj+-Tak6Tj-CzU-9Ky+=9iUNBTO_iQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: Convert marvell,orion-wdt to DT schema
To: Sander Vanheule <sander@svanheule.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:22=E2=80=AFPM Sander Vanheule <sander@svanheule.n=
et> wrote:
>
> Hi Rob,
>
> On Mon, 2025-10-13 at 16:31 -0500, Rob Herring (Arm) wrote:
> > -Clocks required for compatibles =3D "marvell,orion-wdt",
> > -                               "marvell,armada-370-wdt":
> > -- clocks : Must contain a single entry describing the clock input
> > -
> > -Clocks required for compatibles =3D "marvell,armada-xp-wdt"
> > -                               "marvell,armada-375-wdt"
> > -                               "marvell,armada-380-wdt":
> > -- clocks : Must contain an entry for each entry in clock-names.
> > -- clock-names : Must include the following entries:
> > -  "nbclk" (L2/coherency fabric clock),
> > -  "fixed" (Reference 25 MHz fixed-clock).
>
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: Reference 25 MHz fixed-clock supply.
> > +      - description: L2/coherency fabric clock input ("nbclk").
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: nbclk
> > +      - const: fixed
>
> Shouldn't the "clock-names" items be in the same order as the "clocks" it=
ems?
> (With nbclk first)

Ah yes, I flipped the order of the names to match the .dts files, but
not clocks.

Also, I found there is a 2nd interrupt in some cases.

Rob

