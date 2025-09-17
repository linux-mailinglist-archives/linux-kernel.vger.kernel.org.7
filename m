Return-Path: <linux-kernel+bounces-821397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7CB81265
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C70587ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0C2FC006;
	Wed, 17 Sep 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7xNlPl3"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0562EAB61
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129680; cv=none; b=RITKuV/igf5HVcdLIXAddHgp5Y8vhIr+2k/Gf1Dkxs/OM5om3UIVSl/BQTflSyydafu5c8ADjrTUyWI17GRGAy1Dp4nUfAdCjMYwb9FJvZvXYa3YVRHf1xxbCiHacoyLUacNR4QNwsvxp+8dSB7Jb4UgE/ctQt44g0oqhDKViS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129680; c=relaxed/simple;
	bh=1aoUAbCzO9b1WkCL1uGdzZ9KLosTf9Mi2eCsOLd4jP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1SJbb8BlJSnjRy/cgaz90tjX2MLQpm7BdPe+qjiNAX5kXRfSNu6yucKvphD6M28L2EZeZ0aeUER5D7MBnEjxbCoZA6W+qC02H4ijgxYnumjyBcmE2WyXobFqvu4tqyPmZKjBbBJJI0bPBNRuGd6qW9oDsSrEVJkVQEDMtnjZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C7xNlPl3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f7bcde405so2382146a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758129675; x=1758734475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jE5z6SStGstCRNv9ltTlbMEXuvhA93B8hSvu3mrmaPk=;
        b=C7xNlPl3wMA8f5w/dNNhkhoXThE3Z0SfiUA4+LoqR03UzdJ1IQ/7kTuBRTp6K3uuCx
         v3gpARv/B/Ms9w8441V8HRjKRZXkCUDioy46bA+VZDRa/dv4rFarA2i/4+d/YptUrpw3
         3GcD4l4hL0p19S8CPWp01veHbqN41vUj3vKsc5nISh45uCGH1BwWovQxlRz4sdtqWbyL
         Yo9WLmSKaNa7I0PdtJ7/kIXT7wSQoeIrpWAZenxz41j4HWyAfXuXgGIRSP9oXKBMFFYP
         kbcwxKrK5IuXMRv3x7q54Oysq0uDykZ2hU38LlPNpT8C4kX7DBIr31Nl+ull5uFkXUdp
         epuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129675; x=1758734475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jE5z6SStGstCRNv9ltTlbMEXuvhA93B8hSvu3mrmaPk=;
        b=CqyDUezb3B2XKd0hoBC42e5h8PSeLiL9r6YYoV1a5AQtN+bsrlgtJvxtMOjlj4MhvN
         SflfUwjYHnQmVxY9hwzb/8QY5pwIWt/kLraqqcjC0+W6beSXJTtEfn934HrmRbjqQ1Bk
         cNaHC+HVeKj7o1BZqrhrfNmQ2fxUnscyycx1lVDOpGoG2Yl2Nu2OskfzzHVyiuglf9X9
         WjW1k7Dxe/I/dXs/8fZ8DPv8qA7rqCMmSXgT+l/7Dzfni2ucd4vQJ9/KWVXoymvSQCGt
         OIT3XhUn+o9msfzyXw43fdL2TJ1Hzmm/igig6isoY/4M53tJg/uB/yKqM63zAO7NBlbq
         BFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqH4dnmvuDtYK/pTG1FBp6G1ahDCKTGweK2H6O0AAW8H+qY06bfOBmaU4IXDX+YEcQ+Z9RXAoaIGVyxH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3U8/U309J1HsRz6H7pBYA4kICNjKeJXYxUHVxhG2HcMnQHxTh
	8gaacc2qk3Ahygt5dpAnsEnZ4B54wj6+/fZqjAi+u0e2fsOvACfo03IqLbkH6/mVgD1HHTOz0re
	72rN81L52pAnxTvpww3/CdOaikxTFX9UbZPbcUBjB+Q==
X-Gm-Gg: ASbGncsiQoIc4Esoki6OAOLXhJuy7O7s/l3PQfIZvl8pbUNmQD7qTjlbHPDjuf9+4fu
	2gSrMj7705RULd9sAiQr+qi1i2QsQTe0wnqiyfXSXL4sazAesmsNYnDAXwojkpdSDppfjJtQ/qw
	RgMSetT6aTgBn/TBU2nbHitg/KkZ7zqPkd92Hhcgd3XP9qnBief/NvivkEQ/IvXYNxMECgBPEnU
	7ObnRrKG+zKXSa5eAztb0/mbPT8eZjCe9gljpCwzNGy+Pk=
X-Google-Smtp-Source: AGHT+IEkd1wU5hGZ/gLYNvwM0MAW/mjMU6QrKeYk8BM4gj6vi/UmJm+Bn6+Gz2aNpC1XRxR9/RFUm05c3RIj8Ydo0XM=
X-Received: by 2002:a05:6402:5205:b0:62f:5968:ae0c with SMTP id
 4fb4d7f45d1cf-62f83a3c874mr3294259a12.16.1758129675198; Wed, 17 Sep 2025
 10:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-2-vincent.guittot@linaro.org> <aMp0hNnBUwTV5cbp@ryzen>
In-Reply-To: <aMp0hNnBUwTV5cbp@ryzen>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 17 Sep 2025 19:21:03 +0200
X-Gm-Features: AS18NWCc9Wuje5i2tQbCh3xBqxRFBZcfMF6Z2ZM58muUKw4hiti-IcbYy-eSg-E
Message-ID: <CAKfTPtDTnzyksa4Om1HgZTJX7dGeM_vYiEV2eQnEi9AmZK7KEw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Niklas Cassel <cassel@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

On Wed, 17 Sept 2025 at 10:42, Niklas Cassel <cassel@kernel.org> wrote:
>
> Hello Vincent,
>
> Nice to see you sending some PCIe patches :)
>
> Quite different from the scheduler and power management patches that you
> usually work on :)

Yeah, It's always interesting to explore different areas

>
> (snip)
>
> > +  nxp,phy-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: Select PHY mode for PCIe controller
> > +    enum:
> > +      - crns  # Common Reference Clock, No Spread Spectrum
> > +      - crss  # Common Reference Clock, Spread Spectrum
> > +      - srns  # Separate reference Clock, No Spread Spectrum
> > +      - sris  # Separate Reference Clock, Independent Spread Spectrum
>
> This does not seem to be anything NXP specific, so I really think that this
> should be some kind of generic property.

I agree. Thanks for having shared the email threads on the subject.

>
>
> Note that I tried to add a similar property, but for the PCIe endpoint side
> rather that the PCIe root complex side:
> https://lore.kernel.org/linux-pci/20250425092012.95418-2-cassel@kernel.org/
>
> However, due to shifting priorities, I haven't been able to follow up with
> a new version/proposal.
>
> My problem is not exactly the same, but even for a root complex, the PCI
> specification allows the endpoint side to provide the common clock, which
> means that the root complex would source the refclk from the PCIe slot,
> so I would say that our problems are quite similar.

yes, they are all the same

- common or separate clock
- Spread spectrum or not

and finally which clock to use as the reference behind internal or external

In my case, I only need to know the first 2 items


>
> Rob Herring suggested to use the clock binding rather than an enum.
> I can see his point of view, but personally I'm not convinced that his
> suggestion of not having a clock specified means "source the refclock from
> the slot" is better than a simple enum.

Having a clock binding to define where the clock(s) comes from could
be a good way to describe the various ways to provide the ref clock
and an empty "ref" clock can suggest using an internal clock for those
which have one.

But I don't see an easy way to describe common vs separate and with or
without spread spectrum.


>
> To me, it seems way clearer to explicitly specify the mode in device tree,
> rather than the mode implictly being set if a "clk" phandle is there or not.

I tend to agree that getting the common/separate and w/ or w/o spread
spectrum is not straightforward.

> That approach seems way easier to misunderstand, as the user would need to
> know that the clocking mode is inferred from a "clk" phandle being there or
> not.
>
>
> I also note that Rob Herring was not really a fan of having separate spread
> spectrum options. Instead, it seems like he wanted a separate way to define
> if SSC was used or not.
>
> I have seen the following patch merged:
> https://github.com/devicetree-org/dt-schema/pull/154
> https://github.com/devicetree-org/dt-schema/commit/d7c9156d46bd287f21a5ed3303bea8a4d66d452a
>
> So I'm not sure if that is the intended way they want SSC to be defined or
> not.

The above provides much more than what we need as it is mainly a
boolean for pcie than characterizing the spread spectrum itself

>
>
> I apologize for bringing up my own problem in this discussion, but at least
> it is clear to me that we cannot continue with each PCIe driver adding their
> own vendor specific properties (with completely different names) for this.
> Some kind of generic solution is needed, at least for new drivers.

I agree.

Regards,
Vincent

>
>
> Kind regards,
> Niklas

