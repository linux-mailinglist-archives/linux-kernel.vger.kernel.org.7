Return-Path: <linux-kernel+bounces-899824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAFEC58D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21C52547D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C335B122;
	Thu, 13 Nov 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GzMG7oVS"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527033BBCD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051446; cv=none; b=OCBqI4PHB/bx01GZ2RPnqRMN32YO/DGWb0DTKiloRHSlbVyniWDGI4H2E1AKfx8HwZJXsKUXnD3pUAkFCZ0DT3Gm2wCO8mBGxrRfnSxgjtpFYY7d//eBMg0Q4z9wDHxBgWSVJZCJ4p8iadqzNCN3FKBICWzDqcCkEyRJhLKSuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051446; c=relaxed/simple;
	bh=YrHg4D4Rn+vC2SZi4KRny6/RVdR+R0c8DKxuDoshRZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uti77ukLI/x9uwLmjPaeig65NRTV59SelIGeXNk85ayuOJSTI5jOVNThBmhq7SBCW3KIr94tmFFHRW9vXFcIRgUz0YBDVwa116Q+Fxn0Rve3UcMeYYBCE7NTcUj5QIaQ2p6jEg/Qx9pmWMgIvjoQjht9Iuw/f6TiobNwet/CS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GzMG7oVS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so1571639a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763051442; x=1763656242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5wt2b9AIytvZm3PkDsPhENWn/BTbuYs0T0/KW2/iVE=;
        b=GzMG7oVSfsSWuCO/T4m68xnX/AnrB//zJamwSRcTccliw/W59DWXw0UK5m8cwLBool
         B/DjqyaPLs2fz0EqSCZaKwxFT5+M7zQTAxkiBfmHmtnP3MC2bT+iRU5hzMhBZaLyW6Wb
         k1/Nlv7xbIiiXpVAolVHXWadJ6goCGDGS3D6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051442; x=1763656242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5wt2b9AIytvZm3PkDsPhENWn/BTbuYs0T0/KW2/iVE=;
        b=GW3JCXfQfuAYfXTMY32u30baDA38jg9TWDbQLiSIyMM2jstStOnmi2hdxLT8jJuQdx
         CXcbNRHAHtI1kIjVqJx4rG4hI7/xa+fOAI3C9lCkqqnO4aidJ0edrOZIGAFNy79ndWji
         qhuWpqWknu/GaIb4fAm5uzl+sb1kmAXKzMMLwelMmPTYr+CunJERW2mu1ULV7tEAMXSX
         D8jtuF33Js2irhwsmQRxpwKc2Leoh3aWpoaPHDXyEjQdJdOlh4G4wc4RjkKMMxIJA6oP
         e76DUuDa9CN+KLT6UTLoWfTreoTliHT8vnIH9BF8YFCW22etadysy2kJoUcaoqty8Y+b
         h+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6hOScSQHDGDUiHGwHWNJP3Jwo2ioAlT2eTTcNte0+tEn++DiKslLjwbYC3NKebd1DSd2cJ+WN9fMsII8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGb3E+F83aXlp+HB7KcvTlvGf2b58yEzH8Cg19G78lbs0Qch7
	4U7e9L2npVbDJmA1g5tAZaXYal4qjiWf4lQ+GzziwKcwC6mq49vejgUuIu78UOPT8J3md9zFkkq
	DhosWB6DI
X-Gm-Gg: ASbGncunRffb86UZMjitEBI/2wfE32yebvn+9qEMrhWPKIaAGOrTpbX0LIB3n2LlSxL
	dYNWyhX1TVoSLM5BaBrfLVndfeDOBevsGshki3JYrL8HSiwON+i8iB1ILwiy3MY8F0V4yGLNCqT
	+FiAbYsoVJdMgTNm8GAU78UcCNq5y0llIk/i42MwJMaHQLpLTc0qFKRovX3qvk/p2H2rzAV2VUg
	0O/uSg4Hia/6WkwEj+g5MCo+PTdAWgtKfPPBH26urY+QV3bnLijnKya/C25+SLW07v+ZKQS9d80
	QESRzB5Ro9J6V8zFuyzd71paLf9gXj20B1yFK2czu8I+8cfqCmBjNoa9zOiFd7sbyoTN0ST84yS
	7sMSdPAiz6EF3/v/NtaJoYYod22K05itH4GdQub3wWMnXWLzInzNh9ouPSCixU2+lElCEMC5859
	ixxN2jO7VMDNMl5FkFOx0+U2CdrpMZv/3qnb8wFuUPd4+nn+dVkQ==
X-Google-Smtp-Source: AGHT+IFrf6WhEW0FrCfiSLhkX+djiV1Yo0G5Ys/WFLc/kLwPcyUP+Zx+0TL9Uw7lPP6DkzufhA/0FQ==
X-Received: by 2002:a17:907:962a:b0:b6d:67b0:ca0b with SMTP id a640c23a62f3a-b7331c06865mr693594866b.61.1763051442116;
        Thu, 13 Nov 2025 08:30:42 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a06sm193830966b.38.2025.11.13.08.30.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:30:41 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477775d3728so10557455e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:30:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVweTGx1emfKFK3LOkIA9VfzFOoVtlqS3RSYKhOtAU1PI1+bDvx6yemCSkiKltJAsueq23g/nVc0Nta2Kk=@vger.kernel.org
X-Received: by 2002:a05:600c:350d:b0:46e:32a5:bd8d with SMTP id
 5b1f17b1804b1-4778fe553famr1167935e9.3.1763051043969; Thu, 13 Nov 2025
 08:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111192422.4180216-1-dianders@chromium.org>
 <20251111112158.1.I72a0b72562b85d02fee424fed939fea9049ddda9@changeid>
 <05c833f0-15bc-4a86-9ac4-daf835fe4393@kernel.org> <CAD=FV=XXWK9pmZQvNk6gjkqe6kgLXaVENgz0pBii6Gai7BdL-A@mail.gmail.com>
 <00ea821c-5252-42cb-8f6f-da01453947bd@kernel.org>
In-Reply-To: <00ea821c-5252-42cb-8f6f-da01453947bd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Nov 2025 08:23:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VSxeKgGcsRb9qiXq7nsbOWZjPvzmGEOhFA+pmABWdknQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkn8U9vLweoLL7ChsWq65S9_NbSZw7csl7J0f4Er_fIbKu-AjDA18N3giM
Message-ID: <CAD=FV=VSxeKgGcsRb9qiXq7nsbOWZjPvzmGEOhFA+pmABWdknQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: arm: google: Add bindings for frankel/blazer/mustang
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	Roy Luo <royluo@google.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
	Julius Werner <jwerner@chromium.org>, William McVicker <willmcvicker@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 12, 2025 at 11:23=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> >>> +      # Google Tensor G5 AKA lga (laguna) SoC and boards
> >>> +      - description: Tensor G5 SoC (laguna)
> >>> +        items:
> >>> +          - enum:
> >>> +              - google,soc-id-0005-rev-00  # A0
> >>> +              - google,soc-id-0005-rev-10  # B0
> >>
> >> SoCs cannot be final compatibles.
> >
> > Right. I talked about this at length "after the cut" in my patch. See
> > above. I wish to relitigate this policy and wish to know more details
> > about where it is documented, the reasons for decision, and where the
> > boundary exactly lies between something that's allowed to be a final
> > compatible and something that's not. I made several arguments above
> > for why I think the SoC should be allowed as a final compatible, so it
>
> Because this represents a actual device users run. It is electronically,
> physically impossible to run the SoC alone.

I'm not convinced that this definition is as clear as you're making it
out to be. It's physically impossible to run many "boards" alone.

Want to boot up a Raspberry Pi? Provide it with power. Hook up a
display to it. Hook up a keyboard to it. Plug in an Ethernet cable.
Plug an SD card in it. Without those things it doesn't run.

Want to boot up a lga-B0 SoC? Hook up power to the power pins. Connect
a MIPI panel to the MIPI pins. Connect a UFS chip to the UFS pins.
Without those things it doesn't run.

Yes, the complexity of just "hooking up" the components on an SoC is
an order of magnitude harder than a Raspberry Pi, but it's still just
hooking it up to external components. In both cases, we are modeling
the core "brains" (the part that contains the processor) as the DTB
and everything else just "hooks up" to interfaces.

If I had to make a definition for what the base DTB should be it
should be the component with the boot CPU. _Why_ is that the wrong
definition?


> There are few - one or two - exceptions for the SoMs, but never for SoC.

OK, but the big question: _WHY???_

Where does it say that a DTB has to be something that can run "alone"
and (most importantly) what benefit do we get for making that
requirement (AKA _WHY_)? This is the question you're not answering.
From Rob's response, he doesn't seem to think that a DTB needs to be
for something that can boot alone and he seems OK with allowing a
fairly flexible split here. Rob's response was focused on making sure
we can do validation and I'd love to continue on with that discussion.


> > would be great if you could respond to them and tell me where I got it
> > wrong.
> >
> >
> >> Your commit msg does not explain what
> >> is 'soc-id' or 'soc_id' in this context.
> >
> > In the commit message I do say: "SoC: an A0 pre-production variant (ID
> > 0x000500) and a B0 variant (ID 0x000510) used in production. The ID is
> > canonicaly broken up into a 16-bit SoC product ID, a 4-bit major rev,
> > and a 4-bit minor rev."
>
> >
> > ...then, I further say "In this patch, put the SoC IDs straight into
>
> That's fine.
>
> > the compatible. Though the bootloader doesn't look at the compatible
> > at the moment, this should be easy to teach the bootloader about."
>
> But nothing explains why this SoC can be run alone without board.
> >
> > The idea here is for the bootloader, which can read the ID of the
> > current SoC, to be able to pick the right device tree from among
> > multiple. I am certainly not married to putting the SoC ID in the
>
> I am not discussing about style of the compatible. I said - you cannot
> have SoC compatible alone. None of above gives any argument for that.
>
> > compatible like this. As I mentioned above, in downstream device trees
> > the SoC is stored in a custom node and I thought upstream would hate
> > that. I also considered giving the `soc@0` node a custom compatible
> > string and adding properties about the SoC ID underneath that and
> > teaching the bootloader how to find this, and I can switch to this if
> > you prefer.
> >
> > If you have an alternate technique for which the bootloader could pick
> > a device tree based on the current SoC ID or you have specific wording
> > that you think I should add to the commit message to explain my
> > current scheme, I'm happy to adjust things.
> >
> >
> >>> +          - const: google,lga
> >>> +      - description: Google Pixel 10 Board (Frankel)
> >>> +        items:
> >>> +          - enum:
> >>> +              - google,pixel-id-070302-rev-000000  # Proto 0
> >>> +              - google,pixel-id-070302-rev-010000  # Proto 1
> >>> +              - google,pixel-id-070302-rev-010100  # Proto 1.1
> >>> +              - google,pixel-id-070303-rev-010000  # EVT 1
> >>> +              - google,pixel-id-070303-rev-010100  # EVT 1.1
> >>> +              - google,pixel-id-070303-rev-010101  # EVT 1.1 Wingboa=
rd
> >>> +              - google,pixel-id-070304-rev-010000  # DVT 1
> >>> +              - google,pixel-id-070305-rev-010000  # PVT 1
> >>> +              - google,pixel-id-070306-rev-010000  # MP 1
> >>> +          - const: google,lga-frankel
> >>> +          - const: google,lga
> >>
> >> So what is the lga?
> >
> > "google,lga" is the name of the processor. I was under the impression
> > that the last entry in the top-level compatible string was supposed to
> > be the SoC compatible string. Certainly this was true in every board
>
> google,soc-id-0005-rev-00 is the soc compatible string.
>
> > I've worked with and I seem to even recall it being requested by DT
> > folks. It also seems to match what I see in examples in the kernel
> > docs [1].
>
> Sorry but no. Writing bindings do not request having two compatibles for
> the same soc in two different, independent (orthogonal) lists.
>
> So it is rev-xyz + google,lga-frankel + soc-id + lga, if you need that
> soc-id part.

Probably not worth continuing to discuss until we can agree that the
SoC can be in its own dtb. If we can agree upon that we can talk about
if we need the SoC part in the top-level compatible and how to
accomplish that. I had a few ideas / suggestions in my response to Rob
that roughly break down into:

* Don't model the SoC in the top-level compatible. Maybe put it in the
soc@0 node.

* Come up with a rule for "merging" top-level compatibles if a base
and overlay both define.

Whatever solution we come up with, I want to make sure it handles our
socketed dev boards where the SoC can be removed and replaced with a
different one.


> >>> +allOf:
> >>>    # Bootloader requires empty ect node to be present
> >>> -  ect:
> >>> -    type: object
> >>> -    additionalProperties: false
> >>
> >> Please keep it here
> >
> > "it" being "additionalProperties", I think? I'm not sure I understand,
> > but let's discuss below in the context of full examples and not diffs.
>
> I meant ect node, existing hunk. Properties must be defined in top-level.

OK, much clearer. Thanks!


> > The best my brain can parse your request, I think you're asking for thi=
s:
> >
> > --
> >
> > properties:
> >   ...
> >   ...
> >   ect:
> >     type: object
> >     additionalProperties: false
> >
> > allOf:
> >   # Bootloader requires empty ect node to be present
> >   - if:
> >       properties:
> >         compatible:
> >           not:
> >             contains:
> >               const: google,gs101
> >     then:
> >       properties:
> >         ect: false
> >     else:
> >       required:
> >       - ect
>
> Yes, actually now I see you could drop the "not:" and exchange the
> "then:else:" branches.

For the sake of clarity, I'll go with this:

properties:
  ...
  ...
  ect:
    type: object
    additionalProperties: false

allOf:
  # Bootloader requires empty ect node to be present
  - if:
      properties:
        compatible:
          contains:
            const: google,gs101
    then:
      required:
      - ect

additionalProperties: true

