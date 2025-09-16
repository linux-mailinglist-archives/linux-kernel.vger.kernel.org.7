Return-Path: <linux-kernel+bounces-818896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B1B597BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362DF168789
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949F2D3A71;
	Tue, 16 Sep 2025 13:35:11 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B21DE3C0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029710; cv=none; b=GrWkxXoY318pdD/c5hXKLHkzxu0ECKCbFOo41CJaIqORahdA9LagKb2J4wGKTyQ5pV54mGTbUePQAeLdh1Hg2dcExhCzT7WlXplsuDS6yGzF6QTUzEazZG/nqjW1SupPj7Cio5ncrXXspvKho2b85McCHua7fB3iJW7QAfNwf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029710; c=relaxed/simple;
	bh=NOoxReonMuhobJtuMWdYRTzxwSsLvY6z6THmu84JRfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pH2Bg+JEPYlfJihfQgWKjuqQAdKrNyYcEMKSlxn1oAgQCMsKeV15pOJZbpOQs4Jn+9rziWyYbkTi/0RZc2jNTAKT1ngPk3mkwijNNwXcpwmhsOUxCBiKdlJjrZgBwG3avVSUPBVEP83JOQySOh1FLc0momnwAPPvJBrAuTyP0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-89018ea5625so1011890241.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029707; x=1758634507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPlGBFIad4u1SYY+YGVVawgiKQ3X/ZTy7ZgadUaNtos=;
        b=MdhiGgbg6aYIvjjjGXgsrn8PhwQhpp6rv6F3t5f4fGwlVfLLNc6BKEHbBWVwh4F8RC
         lY3VN/9SFMSUKGUT7/eDrH95daYLdA4QWeYM9WqRrUzrTY4ZfDnHpzZjIY/iktL6es2U
         RozD2echQO2Yfz2WFTlCEhs9pGUuT6DxG1gnvzyTmsdDeHZJT8KcA3xIH+pzJGoJtTPC
         4E23YIfLwaXjnGryEy4YurPVeI/TlHfmx2G0LViTU+pXP5Cwgd7wTpKGlMZN4uHlI22z
         ZvebpenphzFkDYMlnVM5gtMsxYaXVHXq7YcmKMsWDonoxhJ+3wvBU7dDGNSv4lQ4w2Vy
         lrRA==
X-Forwarded-Encrypted: i=1; AJvYcCXnP248a9+AGxTOuOEPgJ9IhyO/e8EC1F63+INw8gtD+wz3kT1Naq03+O1XjafhMy3F7o8sNdoiI1g5wt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8rJJDkHQPobWAdQpEpsTWl+ybl1cB/a7hiq4B38o4FeV/1fZ
	jy6o74d3E4LwaQz9UXWLgnTwBB7pBVolTJIsDKUmpQljR+JEYnGj/pNAZI8MGxZ6
X-Gm-Gg: ASbGncv87fV1ycx+JrivT5eu5evqTCaeirhO49F5B2oAez2Lj/I+QFr1jzsJylmUboS
	rmk93H3o7oUaSz8G1UprjYfLCvBJhMxft8RcoP8b4825UyDbbgYEl2Kb9xkHlWY4HLrEZf1eAEb
	U6+p/zjdUjlk5oazNWbArfgGSDnpVJwMAlJiF0+jllQmjyHSFrMuFFNEaV6gUVpJcge67fKPpLa
	OQaJPJanU+PS/NGNkR7DUN8sgVsdhTvH3xNX1S2I4AH0lUd1NtPoWq1MuDkJrvny63AY9iCKxtb
	8jTN+WXc+T0wtmh0xU23ySr+zHahbY1SMyMW0qmkTkIKYBR4qs74rTgQR8aKWOXmwbv9tultSuT
	Nkp2X1UCCyxatOBEoevvwz86uu2WnnLc1hxMcCMl/WfXFSpFvy3Uj5+vrQLDJV6jxHeFRm/8=
X-Google-Smtp-Source: AGHT+IHP9du7AixKZke2Z5+H5eQXZvNWhaDzkYiRRrSGmQ/aoKGwhOhXWdOe54DGlPN++bqp4fHDSQ==
X-Received: by 2002:a05:6102:3589:b0:528:72e2:431c with SMTP id ada2fe7eead31-5560ef96533mr4838609137.21.1758029707007;
        Tue, 16 Sep 2025 06:35:07 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-555bd4fe0a4sm3190543137.8.2025.09.16.06.35.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:35:04 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-55784771e9dso1597882137.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:35:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWk33jbQVzzvPUSJNEC+hZswP7/v7VrnII1YUhNRXjtN4B/7tz35ZUY0o3POyXIlPHKF0LGQUkH0hK1nko=@vger.kernel.org
X-Received: by 2002:a05:6102:3050:b0:51c:3187:e82 with SMTP id
 ada2fe7eead31-55609657675mr5087196137.1.1758029703622; Tue, 16 Sep 2025
 06:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org> <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com> <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com> <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com> <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com> <CAMuHMdXXi97HN-G_Ozbs7vc141GmbMTPD6Ew6U_0ERj5wh6gvg@mail.gmail.com>
 <397483db-91de-4ff2-82e3-52ae785bc343@beagleboard.org>
In-Reply-To: <397483db-91de-4ff2-82e3-52ae785bc343@beagleboard.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 15:34:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgnw4Q90a5yzOcK30iBUAQTgUDgAauzSifnngQf7bwqQ@mail.gmail.com>
X-Gm-Features: AS18NWArFS09GxFXzr9rCLXIPOSv-zNSXEkjGvdknIBx7wlKxz_Awydcjb3L0Fc
Message-ID: <CAMuHMdUgnw4Q90a5yzOcK30iBUAQTgUDgAauzSifnngQf7bwqQ@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: Ayush Singh <ayush@beagleboard.org>
Cc: Herve Codina <herve.codina@bootlin.com>, David Gibson <david@gibson.dropbear.id.au>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ayush,

On Tue, 16 Sept 2025 at 14:22, Ayush Singh <ayush@beagleboard.org> wrote:
> On 9/16/25 15:44, Geert Uytterhoeven wrote:
> > On Tue, 16 Sept 2025 at 08:46, Herve Codina <herve.codina@bootlin.com> wrote:
> >> On Mon, 15 Sep 2025 14:51:41 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>> On Thu, Sep 11, 2025 at 10:48:28AM +0200, Herve Codina wrote:
> >>>>  From the addon board point of view, the only think we can
> >>>> say is "me, as an addon board, I need a connector of type 'foo' and a
> >>>> connector of type 'bar'".
> >>> Agreed.
> >>>
> >>>> Also, at base board level, statically defined in the DT
> >>>> connA is described (type 'foo'), connB and connC are
> >>>> described (type 'bar').
> >>>>
> >>>> The choice to map connA to the type 'foo' connector expected by the addon
> >>>> and the choice to map connB or connC to the type 'bar' connector expected by
> >>>> the addon can only be done at runtime and probably with the help of a driver
> >>>> that have the knowledge of the 3 connectors.
> >>> Agreed.
> >>>
> >>>> I have the feeling that the choice of physical connectors to which the addon
> >>>> board is connected to is a human choice when the board is connected.
> >>> Yes.  Although if the addons have an EEPROM, or some other sort of ID
> >>> register, it may be possible for some connector drivers to probe this.
> >> Right, I think we agree that a driver is needed to help in the mapping at
> >> least when multiple connectors are involved.
>
> > I agree you need a driver to read an ID EEPROM.
> > But why would you need a driver if no ID EEPROM is involved?
> > If the connector types on base board and add-on match, it should work.

> How would a connector be disabled in such a setup? I guess maybe status
> property can be used while applying overlay to check if the connector is
> enabled. But maybe that goes outside the scope of fdtoverlay?

Why would you want to disable a connector?

> Also, I would assume that most such connectors would want to provide
> some kind of configfs based API to add/remove addon boards.

Yes, we need some way to configure add-on board add/remove,
and on which connector(s).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

