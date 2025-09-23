Return-Path: <linux-kernel+bounces-828779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3620B956F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243DF19C0264
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470CF31A057;
	Tue, 23 Sep 2025 10:29:43 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B330FF21
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623382; cv=none; b=WL4oj+W9IfBzbrRX+/AWLlyKMnT0MTdxAmxT4ki1CQhEBcqa2OFP5AdVQTQolrMmJB4S2SLKezwkBZe9S7DgRFojf7uLV9Lh0/rQuV/YfWIv7zFc2OJFTvCLTlB10fbnazpQaX7DJqjq08XMKQjXWBIeH5oxNyPHnMr8JYdeMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623382; c=relaxed/simple;
	bh=eSsu031VVGwPsLfNPlmNXIySQd3w7MuDIZQkN2cj8lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sed2Rn1lg8lLPRSOlc08vSqJYJRC8bXXF9yjZisX2CTjYiXDgHPyZyZIkpAyvPr4rcTfEWUaPA18j5LZe0Xovfu+rgH4KJ4bT10hDIvGMkwU2YJF0nXaaGjBf+luLWlc06kyTNH/ug5JetIBtR5+JN7Ln907Bm2vCrPgu/fh/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e364003538so2372013241.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623380; x=1759228180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy5YqCkw1QkAzxS1ADiBH2hURCJ0LLs39K3eOvsbTdU=;
        b=q/ogCkt8czwGFlcFSzQyKPEBOBWDqv6gfoyQNIVPyENjG/Rz9fKQBRs9F/Q2SHZNR2
         wv991H6U9jvpEBWwMBbsfZ8uUSvFezpADdbSJGda285gsc87VEzspw+hc4A2vLH5DXrS
         A7Y3xeTnVXMtgaOCK+Oc8DAc5LUesmsdjg2czixZ9X66T4uw4cDChfWmHrgrkBym+QCs
         X9CP/o+iR9GyMpwsG0MmmybrHwnINFlGAdE4aL6Mn89m4A9jzQXcVis6TywyPijCWRTu
         mp0o8V48PkNdE2RQsqfLppED6+FqRgNTn71Z+56w1a995WMtuVUGdWcjrdyJG7ziULcW
         jnzg==
X-Forwarded-Encrypted: i=1; AJvYcCVqfDlMaOrSXkjj4NvVvfDG+Dhb7S7WqFxR0H/VsHt3ly0p05JQUQyjzbN0reYcOm8X6VRkDTlKHUzbEUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyue2VnHEBC/rd3OeISt+1IxHprsoiQV9XEkbev9wDQ84ot6SjC
	D2npyXiT496om9WwmsAJ5qiPvpAIVu4Xqfg1lmM2gojojzawJOmU52KnEvsCavwy
X-Gm-Gg: ASbGncughiyFlKLMkS/yxnVVZ7aP59l/mF7zogmPoBSj+DBpuk1qmcKSDi90MxViGSI
	Iby2LPIJqXrGj7QxLgSv/xe4YDJnAH3MFTNPFnukmsJJ398ohYb0Ssn6Bum1V347m2DLiicp3pT
	xcQ5/X9GCWUhfWExf0eNLspHhLiV5OuiKAVZORzcprZ+lH6h5ne/Tfnyu6eH1Qi456LuHzsLBc5
	acLIm3D55atNTAgI1UCD8vYEt4D6AkW7RqD6A7ppuVUM4IwaZutIdDkazvAeWhw7gac7v+2xw1M
	iMM6TuNq6hpKXFh0bF9a3a4p7xJPJe53bsHd7elpbf8oruBXC8FRu/j7vKVAgwvXpq+NugjwrqZ
	lko2rt7An65Itfd3FP2nHi2m0Ma2b6o0JGh1W/UVTr3xApYq6P35IMlZ1HoCixe1knNg95jM=
X-Google-Smtp-Source: AGHT+IGg7rbEAGIfuAWC5QJhP3G1WsVHs3iFzoXJuW5YGWz96l1V2mNk4fSvO2j696uvAs5T/HQldQ==
X-Received: by 2002:a05:6122:1daa:b0:544:9f73:9b46 with SMTP id 71dfb90a1353d-54bcb1c1485mr610865e0c.16.1758623380026;
        Tue, 23 Sep 2025 03:29:40 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a9d1cf721sm1783804e0c.7.2025.09.23.03.29.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:29:39 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-904d71faab6so1363227241.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:29:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJAFyon3dp34KpL1l6+C1cAMVlDGxpKY1A8Nd91raaiWPCqD5Jh86innGJ96Rd+8duue0/3a73V9qFLtI=@vger.kernel.org
X-Received: by 2002:a05:6122:2516:b0:539:44bc:78f1 with SMTP id
 71dfb90a1353d-54bcb09972fmr689351e0c.5.1758623379127; Tue, 23 Sep 2025
 03:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aL-2fmYsbexEtpNp@zatzit> <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit> <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit> <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit> <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit> <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit> <20250923114849.2385736d@bootlin.com>
In-Reply-To: <20250923114849.2385736d@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Sep 2025 12:29:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
X-Gm-Features: AS18NWAbRnZBKwbUs1mL6i0jpGKTu9bSTEeBLQtsdhJWW-X3mhl84YZ9AdBBLbQ
Message-ID: <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Ayush Singh <ayush@beagleboard.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, 
	Jason Kridner <jkridner@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Tue, 23 Sept 2025 at 11:49, Herve Codina <herve.codina@bootlin.com> wrot=
e:
> On Tue, 23 Sep 2025 18:09:13 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> > Ah, right.  To be clear: we absolutely don't want multiple addons
> > altering the same nodes.  But I think we could do that in ways other
> > than putting everything under a connector.  This is exactly why I
> > think we should think this through as an end-to-end problem, rather
> > trying to do it as a tweak to the existing (crap) overlay system.
> >
> > So, if we're thinking of this as an entirely new way of updating the
> > base dt - not "an overlay" - we can decide on the rules to ensure that
> > addition and removal is sane.  Two obvious ones I think we should
> > definitely have are:
> >
> > a) Addons can only add completely new nodes, never modify existing
> >    ones.  This means that whatever addons are present at runtime,
> >    every node has a single well defined owner (either base board or
> >    addon).
>
> In this rule I suppose that "never modify existing ones" should be unders=
tood
> as "never modify, add or remove properties in existing ones". Because, of=
 course
> adding a full node in a existing one is allowed (rule b).

What if the add-on board contains a provider for the base board.
E.g. the connector has a clock input, fed by an optional clock generator
on the add-on board.  Hooking that into the system requires modifying
a clocks property in the base board, cfr. [1].
Or is there some other solution?

I was also wondering about endpoints, as they have two sides: one on
the base board, and one on the add-on board. But it seems that typically
both ends are added by the extension, so these fall under rule b.

Thanks!

[1] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/boot/dts/renes=
as/white-hawk-ard-audio-da7212.dtso#L165

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

