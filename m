Return-Path: <linux-kernel+bounces-795623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D91B3F57E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62962203351
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB242E3B1C;
	Tue,  2 Sep 2025 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VKklBFju"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1720ADD6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794653; cv=none; b=R1JZiwrVKeGFTNiyMNGl6PNhuoxDxaIPxqdKzQGlfajFUlDm6ka5zEOG5DTkYyqXdW8JYRIJYE3EueVZFUhYBcCgyaAyNHT+AJdydDfMOZWpw+DDxLZM2ZY0ugTuaeTmEh5fUIORzNK8YFA4poB4A1DeOH92clXAK3KSkjo59mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794653; c=relaxed/simple;
	bh=Q6SOpAgFsbSqxChGBgtYqn42FMCU7TsqWdMn2A9wyUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlzYHN/qstfmpsJO6y9QwMwVB8BMKrB0XLJDH0TVR0xJ4ljRjYgxPZtwKG1N23477+ol/rruG1REqSU0N37G9MAJOGThBoHxdGMkrl/poZCCVGwJbgD/Id6S2AfZO0gizbbnNPoNE6YfPVMazTW/1HceJ7N+UFORa/4HxMBpT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=VKklBFju; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so3617451276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1756794651; x=1757399451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GldbsHOxwOqRszhiKUe3fdsQM11GQH7faWzrEcD84Hs=;
        b=VKklBFjuRZv7qiusTQX74B9FSWxSIKtH1GjtJlgkKCiV/uXyG1GOdF46QCM+w7Nb2X
         eUBt3AL1r6vfG6pcsFUKoWD1HZVKbgqxKJendcDmNopojbAq5cajzIxkFAj3+sN/TLZw
         8kAykyy/pS6vFFD7sEbae6FwM+9+z+xP7Az68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794651; x=1757399451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GldbsHOxwOqRszhiKUe3fdsQM11GQH7faWzrEcD84Hs=;
        b=sbdBV50C4L1sO63tYgbW8wtZIxnNNtnK7jEMWAJVmDAIGL+mUuAL7kFptErmAsodI0
         jw1BLegzwjWNxDFc6/TrarwlPDWCQUahcI9SzRB7HLws+frGbeklNy+4lEoGr6SiksWt
         C+z6tadzQWSsI5eGl0uyNTAezqLlInFA8OP/JyDFjVVkgpwZ59ADO6zkKa07uIQ1F+V9
         KzS9f/+E7Zu3pJ+rnwGZw0bxN60ruV+TO4Rz9yNfCdhtJDaeOMr+UN4vWfrMmABhX6dK
         G+eaPEvIfLxRKBhY6xzzMa2WShTMom1/SJt2GSWWK+u92MTtNTE+WC/P9VcGuIBcRwAB
         5VJw==
X-Gm-Message-State: AOJu0Yyuv7KzYIzHVexc91+USqobeLdqGH1DGwOzNHQGBdHTukOpdJ+8
	wBGSWSHbUiYoCOWenehbRDVK0/Ya7ODonkwHzmMLdaN9NATpqYoX/4mxaQw+ey/SYC3u9+INcxV
	3zRyBkmFE2mhH2IW8Edl6JsiCG8TC/YtJxeHDKRZppw==
X-Gm-Gg: ASbGnctn4h+5TcTQEEANSdwJ9PGxfWk+/PVkn06q5th2tO7QoKnsDGrLjP14/IXcM7p
	ixdZ3vDQR1ncsHUOTwuzqbVtZk8MAGlyepnPqvZaKp6ZTY3D2ArjIqJKL2DcXnUzAK2tHZNpDuk
	KX+sRgxfAe2GkzTTk/8vS/77vV+Dy9TFHYKEtz94qMzrapueSXamnbaba1YJUjHR7bX1O8Laps7
	WIqag==
X-Google-Smtp-Source: AGHT+IFhB7Yl9/OZwualFBQTMDBb72xbz0Pgu+LMqFnInMFJirNghOMFct+IVEyMhDl89O9Jsjjbl97dtB7oxxL5r+c=
X-Received: by 2002:a05:6902:238a:b0:e98:a36a:7635 with SMTP id
 3f1490d57ef6-e98a578c2admr12602864276.12.1756794651306; Mon, 01 Sep 2025
 23:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723071442.3456665-1-dario.binacchi@amarulasolutions.com> <20250725230342.GA1993803-robh@kernel.org>
In-Reply-To: <20250725230342.GA1993803-robh@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 2 Sep 2025 08:30:40 +0200
X-Gm-Features: Ac12FXxNBkEwJsqkZcDT2ePkxFGLxfZm9eNi6M7jREEW07RJgdKjrq9oLA6y4Bc
Message-ID: <CABGWkvpeKczJVhDbhyKPDgNyYKYkEaTzJ+xDqCgkuqKJAyCa0g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: touchscreen: drop any reference to touchscreen.txt
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-input@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, Jul 26, 2025 at 1:03=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Jul 23, 2025 at 09:14:20AM +0200, Dario Binacchi wrote:
> > With commit 1d6204e2f51f ("dt-bindings: touchscreen: Add touchscreen
> > schema") touchscreen.txt is no longer needed. Remove the file and
> > replace every reference to it with the corresponding YAML schema.
>
> The point of what touchscreen.txt says is to not do this. I'd rather see
> time spent on conversions. But you've already done it, so:
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

this patch is Acked-by, but who can take it for merging?
Please let me know the right path forward.

Thanks and regards,
Dario

>
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> >  .../devicetree/bindings/input/touchscreen/bu21013.txt  |  2 +-
> >  .../devicetree/bindings/input/touchscreen/eeti.txt     |  2 +-
> >  .../input/touchscreen/raspberrypi,firmware-ts.txt      | 10 +++++-----
> >  .../bindings/input/touchscreen/touchscreen.txt         |  1 -
> >  .../devicetree/bindings/input/touchscreen/zet6223.txt  | 10 +++++-----
> >  5 files changed, 12 insertions(+), 13 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/touchscreen.txt



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

