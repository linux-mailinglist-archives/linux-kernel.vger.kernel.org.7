Return-Path: <linux-kernel+bounces-832935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F2EBA0CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F7B1896961
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659030C604;
	Thu, 25 Sep 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1r06cGW"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA125F988
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820577; cv=none; b=IOTY3He2ihuO3gycWBOeBnylrYiujBF+45fwnvQ6J8Y4NJaXtc3/gIrF0ZFDISVPN4XFSrM1f+8AWTTea1zeq02f1u7zYhkM5Z5EzuJ+C1M+/I2PaSidF0Ah115UCR6gyMut8w4nzY/ucfWotVlRJSzwiTtQHX4kMRmJtX6eldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820577; c=relaxed/simple;
	bh=Zv82gIXaLAAzi9Py9v1c5XK2EiDFpXVZ/NJKU+kigKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0j/i0NPLpCXGFRkYqUhJoYrMP9u6fH5ptyCrd8l/O9BJcnmxzs8bOvXpfHeSFxoCNNDc+o0yccwepRTelEKRTVkgekCKo1CMP0IBZu32BNeBLkY4Rrs1mfPlX7aavwCP8VhEFR2ABU4qt5ZFqA4FW92DIBfmwyKwoVWiBowqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s1r06cGW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so1940368a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758820573; x=1759425373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gfSUBmjDQGS07XOuZOfB4dv6p+6TOkn4sFnsfwrItDc=;
        b=s1r06cGWbBgRKji5umAfulK1J80i1/kiXpCjnMxS1IkEdryInPSC1MjkBM/+Rc5lL+
         KgAw3dS3Mq/2JMZuJBZU+cDUjTyqYT0isBUfXsev30dNqGjBk5c4wfhgjoDsm6DuYktY
         +onO1nc8/sDbW9HLpsOJrTEaCGdF7g0/h3zwQ90SO3WNAzfGGFOkqTL/A4nCqmO30AVM
         I9hTClY3pOr8Rh3GVOThPiv+/D90KeC9H25dBwB7DQbeG4PzE7Ih9y/NskQDyYF7lfoh
         GNURJ5S5BnSWKt3lTJnXjKg7FCMeCsDSMY+oF2OQYrxKoIti+EeXcdCtAznJx64/hQrk
         bRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758820573; x=1759425373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfSUBmjDQGS07XOuZOfB4dv6p+6TOkn4sFnsfwrItDc=;
        b=aZxLhZma7yX70aImK1NRuIpQOhJHQSSnk6b12maRajn1uFVH5XxzEBswudhS1BsjeH
         sueDHWGNuebMQl2C2DPViBgjYGvVGKcKYgKlBgrUvd0iUtipelRH9mUjF8/iDmr4o+Xa
         Am/InWBW1zvaJ3XIJHt58f15/SFnaZOkqHjf7nXKvVY3ZuFQKnUhTg73uF2C5SLXc+hk
         tZK/Nbeby/MEu0Uk79N9o6foFUjUtGEg3Jg7oEaBA3vM37CQKu0icNd60oCro5bA6aJ2
         RsU20yiMjrCk5H+7mbovYPD0Ilrj9Y/BHA3TiVw9Yx71Ao4cx6j7YR2tB7AWQXaWUdP1
         hL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLApnV46cpXw1KX2yu6bw7e4al+opZRngo5yMveimBJudUVV5sU+VFIF4ym1mmSBUjaE+VSxT2BtyxEX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDpxoRiugeP4efqumH8+wmkTnKr2F9lv+5eFy4B0a9FNoIg469
	YRwezHHc1OgvWvWGgHyFRW7LpprCqfeFoVZDg3tE5GRNF6fri3d3aYxNavZLNkFztoYDIT+GU/X
	5Evh5LW5b0XKlY2xH/rPU2SjTi+YmQJAEtv0gb+pD/A==
X-Gm-Gg: ASbGncvfqULyZJpst6wWKrO7tozGSMkSV+9YCarCt+e1uUCezCjS/dqGc3rFLIQHReN
	xM3kE/wUKK5qYEdD+bBkh8mVtFJfnEGyDq4hVLZChvO1SQlXP1G1UeV0THFb03pAqia2bNfX4Fi
	e4LTPFDt01GU/L6GUnI6MpGPvb+GkbFTQd2bxxaxhBeDXzVS/fd5OgVEmrtrruD4FjeTDlyy1ZG
	nRRfy9N4KnYdeXbtZOBWjLUIBw2QoGnQ61R
X-Google-Smtp-Source: AGHT+IGDhhdx+YuZcr8I4Tult1/nPYdF84/cpZUAmbh+gOazNWoxtTztWVZU1nAmJ8EOHh1jeTaA57QtgllGSnlOLdQ=
X-Received: by 2002:aa7:d441:0:b0:62f:68c3:57d0 with SMTP id
 4fb4d7f45d1cf-6349f9cbc18mr2542494a12.4.1758820572615; Thu, 25 Sep 2025
 10:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-4-vincent.guittot@linaro.org> <aM2L0C4SsGTzLQwi@lizhi-Precision-Tower-5810>
In-Reply-To: <aM2L0C4SsGTzLQwi@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 25 Sep 2025 19:16:01 +0200
X-Gm-Features: AS18NWCvFPXEZU7r1XpqWeh25XNcMYT0B_gX-68ydY8oAsZKJCM-yUYMplLol9w
Message-ID: <CAKfTPtC4TS-PwMa7-BSV6qS=YjnFczwj42USqJ8=YX3X0cdTxA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 18:59, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Sep 19, 2025 at 05:58:21PM +0200, Vincent Guittot wrote:
> > Add the s32g PCIe driver under the ARM/NXP S32G ARCHITECTURE entry.
>
> I think common ARCH maintainer part should only include core port of SOC.
>
> PCI driver should be sperated entry.

I can make a dedicated entry for s32g PCI


>
> see PCI DRIVER FOR IMX6
>
> Frank
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  MAINTAINERS | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd7ff55b5d32..fa45862cb1ea 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3084,12 +3084,16 @@ R:    Chester Lin <chester62515@gmail.com>
> >  R:   Matthias Brugger <mbrugger@suse.com>
> >  R:   Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> >  R:   NXP S32 Linux Team <s32@nxp.com>
> > +L:   imx@lists.linux.dev
> >  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:   Maintained
> > +F:   Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> >  F:   Documentation/devicetree/bindings/rtc/nxp,s32g-rtc.yaml
> >  F:   arch/arm64/boot/dts/freescale/s32g*.dts*
> > +F:   drivers/pci/controller/dwc/pci-s32g*
> >  F:   drivers/pinctrl/nxp/
> >  F:   drivers/rtc/rtc-s32g.c
> > +F:   include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> >
> >  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
> >  M:   Jan Petrous <jan.petrous@oss.nxp.com>
> > --
> > 2.43.0
> >

