Return-Path: <linux-kernel+bounces-823591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB34B86EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6B01C87CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B972F28E2;
	Thu, 18 Sep 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dGITqn4J"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AE2E284A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227870; cv=none; b=cdR7b7VswPvzYULe/umPmfIxb3LBw5ujdoW0igWJNidU8iiost7bCJpTt+obhNpFKeILt+s4JPkvia57tAwq0jG31MXh6znAWYBwHRWinGU8u1rAC2WWicSeoIf4kN+YRW+bRw3zHqKS2Ti0BRmiygjsVVjT5+CYnak/hBf2Fxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227870; c=relaxed/simple;
	bh=+0R/2T7Tg9D4YiaoqRiplwCZvbPjlzXYv47AHkbl7dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkJ5r/lC76tULuCCaHpR5Te84Gr8YAvb5cb62TBAiZ5i8DmYN8lbsbdAzhREswbQxet3UCebdetfWTHBp/KgbLS4N4YIe7tmqbfLdNZqgd6Wjb4I5Kgk9s6cLjZVGs390fvboWFNC5Xi2WcX4iEwVkU8nzXGI+Dpjguedklh6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=dGITqn4J; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea5aa2fdac8so1353122276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758227868; x=1758832668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPqblTFKrLAe0mzsDyY6YySHuY6Q2kBBLw78NU0KIeg=;
        b=dGITqn4JwTmj5KwN35OD6/w5on0Ky8BtXx72gnPAkmp+/tXztRoUxlrBVs4ZSLAQFl
         0WJTdsR4LIGjuEl1QwUmqXU1ZbKWotDZBJG6uz0fcDJu+Pde2OpvjBLV6Wcgt7ebZaGE
         3IiA0rQaf+FOGwRk4LF2MySoeTtdmVC5ogGWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758227868; x=1758832668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPqblTFKrLAe0mzsDyY6YySHuY6Q2kBBLw78NU0KIeg=;
        b=Qt3CAAADIBYOoKfz9Pe0BML7+BkA/C2ZP7RwBzPhXtexaPhFNLD6IQsSXp2nwitfjD
         8ewmNkQdpFl08QACgy/oTgYXotVF0jF32gkwY6GcuwlYLOn1DOWm+5Yc2goHDP0mLwwc
         kYr5osxG1KMZmtFWCSEhJADPNpMaa6mSC5ohlXJsc+fV5fC/lMv2w/CKleMGDm8hW+E5
         1dykzB9ojprXs56XEivcKHNRgX/tdnANdn03p9i3ZXcZ1PUvCiWfEXeYfTcXryUsM+ku
         xP4zg9Z0XyTu5kejs0Z54ZMijk+hKlFHstxtmIbYoLv61XItXgIrf/X/uwlM38CSp2Lc
         49fQ==
X-Gm-Message-State: AOJu0YwT+qTc0sj6AHSNm7b8QQf2zWF7bP/TTn2xd/5KYjPhnWOwGRjH
	HBc9E3T8gnLtL8GVILGlIL1TQOAISLaX/M1ZEeuce7bRpUHQwQKrpcR8OpyC+jUXW2V7ZtjKq85
	ExFv/Ojk9upOxk3RetntijhPq5ZeDe5Qsql0TcAv7R7++ejc7gqwia90=
X-Gm-Gg: ASbGncvOuaRiHpO18JQe9Z4IAE0YVYNS5OmbV/MDIXhpMgsodTGkkO7wiZ8mN9j3Cc6
	1HegSL7+TmqO4qIgWSJIcnhCB/novmZcFb5VsLu4DducndyW9lJC9g2wDThQLHw5o7llUEzcIgw
	JZXhgJSG3jB7jM9PNBJ3k+5W+oyY4xZNN9yG1kq2hR4We7Ry4mJjOvFp2CemK6Iskx0Vu2EBVJ4
	HPwmCTBC+Rc2nu99rzTfLWH
X-Google-Smtp-Source: AGHT+IH14ML5OeTgfNCjZ+eLR5D0BkEN/X8W7UZQcrAQKu6xXP5etxnsRLfqJ5tS5GUlUf2xOTL9iOYN03VgHVRvQJU=
X-Received: by 2002:a05:6902:c04:b0:ea4:f3f:5498 with SMTP id
 3f1490d57ef6-ea8aa09f336mr791364276.36.1758227867928; Thu, 18 Sep 2025
 13:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
 <20250918155240.2536852-4-dario.binacchi@amarulasolutions.com> <20250918200445.GA2529753-robh@kernel.org>
In-Reply-To: <20250918200445.GA2529753-robh@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 18 Sep 2025 22:37:37 +0200
X-Gm-Features: AS18NWBqzx_QCJLvM1ZupXjBE082LYlK02aLhStfsrL_kkHbqntwv2U3qqpvFFU
Message-ID: <CABGWkvqX9aCxam6UMYsUBkwnMJrMNKjVKrqi5Ca7O5Jk8xRTAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] dt-bindings: touchscreen: add touchscreen-glitch-threshold-ns
 property
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
	linux-amarula@amarulasolutions.com, Conor Dooley <conor.dooley@microchip.com>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Javier Carrasco <javier.carrasco@wolfvision.net>, Jeff LaBundy <jeff@labundy.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:04=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Thu, Sep 18, 2025 at 05:52:31PM +0200, Dario Binacchi wrote:
> > Add support for glitch threshold configuration. A detected signal is va=
lid
> > only if it lasts longer than the set threshold; otherwise, it is regard=
ed
> > as a glitch.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > ---
> >
> > Changes in v5:
> > - Add Acked-by tag of Conor Dooley
> >
> > Changes in v2:
> > - Added in v2.
> >
> >  .../devicetree/bindings/input/touchscreen/touchscreen.yaml    | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchs=
creen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscree=
n.yaml
> > index 3e3572aa483a..a60b4d08620d 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.y=
aml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.y=
aml
> > @@ -206,6 +206,10 @@ properties:
> >
> >          unevaluatedProperties: false
> >
> > +  touchscreen-glitch-threshold-ns:
> > +    description: Minimum duration in nanoseconds a signal must remain =
stable
> > +      to be considered valid.
>
> What's wrong with debounce-delay-ms?

Do you mean that I should rename touchscreen-glitch-threshold-ns to
debounce-delay-ms?

Thanks and regards,
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

