Return-Path: <linux-kernel+bounces-822650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59883B8465F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D01889884
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBB283153;
	Thu, 18 Sep 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="C5yfP8g2"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FD253956
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195946; cv=none; b=JQ5FkwESaSgRt7Zl4sl5GFWcL38pvguMbJrRtm2keumVCIaop60ijgBoHwOtIp00FFJZzQ6ynzHWG3zJrZMQZ8iQa2mgFD1P8bmZJcH5AxuzgEQ7DM9NRI9f2iuTa3tCiDZX1ReE2njCJmz6VgTxZpnSh8KkolZuOWX8OBwBRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195946; c=relaxed/simple;
	bh=94PMZIXrpwiOTu6RfaFA4nNpgWSw4GpIqgTLr4I7xmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmTJLD2z8O7QbH7n+hXk/tEdCQ5kfv3uu/KwUvUQTP+LBU/PV3uqP4ba4FBy64s6DxmsYnQ4T0XD9TiaOKdtjSMk531I7DcCBOeAqEhpNm74Otpzq1f1ksqUF1IFon99U7FI695Ue9cSqv7HdqoRCiJrA+MjAWnMtzJSOPLHjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=C5yfP8g2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so1646805a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758195943; x=1758800743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymLWBfJeHa+AAF5LWXk/aJtIpCAEk7N1D5WL9NzAOZw=;
        b=C5yfP8g2vPyhAIEUzYsMxEtMIguaLCE6kdXF1HAd+7yapDX8Dl7x+pQdU3JXimbalV
         yD2CvMFa/nqmGrIQAG+FHpYMfsZn9s3YQJphIlBiMYxzlgyy4uDUfTVvldL64dU8IiAm
         KjybhKTW+hwWS7SoA44VEDYeocxX71W3EQQEeFvPZ5EqLn5+n9gqcVWqOldy+FsCC+9S
         WO45cvqLLVeNPjtcwfXzbBP3kdKjrCDZlGS73hO/DlY0fKlH4b9GE7TDoK3fv1DJxC4V
         Q03R9Gr7NteVNcbG+6uwWmrkjfkYrj/5JJOwydEEhPtUfstVAhUuf72TULnDNbzYAzVw
         oyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195943; x=1758800743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymLWBfJeHa+AAF5LWXk/aJtIpCAEk7N1D5WL9NzAOZw=;
        b=wGwwIUaqwZ0CG2HCv1Jg+6YUepleXM90pwSpLFxwVIe/nlEEG0BB5H59witAecRYHz
         /NTi3VAQhGIc/JpwNsU7WUrj8EUU1keLqU7J12Uke2sb60lSYYcfIPkUQ17FdZYMLoC8
         VIenpjoQhu0KAVuxBO9j+3/Or9WPgedp99BSfVOkEu1StFPmAzIXk5DFU+6vv1SV9fZn
         upfLbp/QM9gfUJaNGxLMwcm0Dd8Yu1OGr01ohlCHT4WF+ZS+KffM8LDbHgXsD/P109ib
         H98KyFnDnHQJdQVXCCstUR3Xg9+RNxsj9RP52GCbAdW5KgjFXft+etjBv5iuslNL90fp
         D6dw==
X-Forwarded-Encrypted: i=1; AJvYcCU8OxaRxOKrxIXry29nCK3SAFdTWXFqhNWC7GE58r6L75pchstjjxc4cdyLiC5M5XZyGachdOmXXMG3YoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8d4cBxwupiCBHhdt3bLmDn81ZDWP2vLLAawLUjypRHTuwkA4
	L1WrMO69Ha8t8qThP2HjP2Out4/dujapPmgSTVyrsJE+NdKUc2wXhoGdWoi+IjtFzAHjRgNcqWw
	buOXtuZe0x7Og+eaCHkUmoRW7j6o/G5Ab9sDXTGvNOybGxRP2M6vEUW/K+g==
X-Gm-Gg: ASbGncuOJhKuweDagRAKSuXwGJM6rWUHm82B5Zv7it9tQsWbnoEVyWJfhgMXYuIQ6sP
	yTGgkmcINK5FGrPN5MNqpafm0CF69s+tGdeegDt72Tp9B/XZXvE/cy/J8DDW47PPJVxCh5+PQxs
	U7WV53vs7vCzlETA+tWVTjqvjHP1LiRaUB5bdauBm4K6vyDMgMJg3n337zdjzpeR/SmYDoaYjTc
	dgKIu/iufb7JXnNg064p5mAhZg=
X-Google-Smtp-Source: AGHT+IHFids55hjFx9tAzd9HjZcFGiHI2LRl4FHiE0hZ24A9EqDyegxHm6xC2ZWRH8V+3GqUEFGFc0HVJ77f2C+o9Nk=
X-Received: by 2002:a05:6402:5341:20b0:62f:a3ae:fedf with SMTP id
 4fb4d7f45d1cf-62fa3af0280mr2223555a12.34.1758195943526; Thu, 18 Sep 2025
 04:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917111323.60781-1-robert.marko@sartura.hr> <20250917-paparazzi-hermit-3a4aa686add3@spud>
In-Reply-To: <20250917-paparazzi-hermit-3a4aa686add3@spud>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 18 Sep 2025 13:45:32 +0200
X-Gm-Features: AS18NWA_6zldq5uxIKmy94PXw-Gq_9sPBdCM2sajgaSERKRbYRyea3BZcHITxFQ
Message-ID: <CA+HBbNHS9TMd5u_Mysv21=nsqjeEb44oHFj06kS_hxkXZWutnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: microchip: Add LAN969x support
To: Conor Dooley <conor@kernel.org>
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, 
	lars.povlsen@microchip.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:38=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Sep 17, 2025 at 01:12:35PM +0200, Robert Marko wrote:
> > LAN969x also uses the Microchip reset driver, so document its compatibl=
e.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  Documentation/devicetree/bindings/reset/microchip,rst.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml=
 b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > index f2da0693b05a..4d4dd47f830e 100644
> > --- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > @@ -23,6 +23,7 @@ properties:
> >      enum:
> >        - microchip,sparx5-switch-reset
> >        - microchip,lan966x-switch-reset
> > +      - microchip,lan969x-switch-reset
>
> Driver patch makes a fallback compatible seem usable.

Hi Conor,
Will respin to simply use the fallback compatible, that will avoid
adding more compatibles to the driver
for no reason.

But, can I ask what do you think about the
microchip,lan969x-switch-reset compatible?
Is lan969x fine or should I just make it lan9691 or like cause the
whole series uses the same
reset setup?

Regards,
Robert
>
> >
> >    reg:
> >      items:
> > --
> > 2.51.0
> >



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

