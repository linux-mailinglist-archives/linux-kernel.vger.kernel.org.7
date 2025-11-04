Return-Path: <linux-kernel+bounces-884724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE15C30E77
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03B9B4E7AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F762ECEAC;
	Tue,  4 Nov 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kllIFGal"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CE2EFD80
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258248; cv=none; b=cc1FzA2pcQzSBzCgnhPeL+w4WGfN8huwADugnV8N4l5Yc/p1kUcyvG5bf8kwF8UbmoDi9zt0ybppQqGL3tmT8P+9TrEGK7oB7yT2LfRODmTgEEjUQOnMf1RHLDe+5HjeEjiRjbqbhXmD5W4zCIyRVDTukGb8sZpnGGL93zLbWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258248; c=relaxed/simple;
	bh=Dzj77OltBvkgDDn8952TkOFzMhRy0pNivm62rHqrknk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ri2KGLmI4UA8WlUf8KR3JH38QN01CSdjlawH8kWtUyRstJCqHsbTg8c8WFH2wa2eVLn0oQG4vXdhO6tUeBkxA7ipeTy5190eIvUjK9mMP2BVvdldzCAVj720FTN6Dw6ShjGIlnUs/d9phz0lsOB15ZJG8ILWVBTwT9CERlp6AEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kllIFGal; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b7200568b13so180436866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762258245; x=1762863045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzUjjBieESWl/eKHRRME8VO1FyP4Xh2Gr78dnGWZR3M=;
        b=kllIFGal8Q4VzaPhV62Wo8vb1RCA1Tlz17GOkGw/P9pAOwOlZQehgqE9fvwNGIf1Gz
         kj3G7ArTvZwlclxlcAMAs+WOBDyZodPmB9YbunvvcRYOb9/4QOLVY3FyvoECCAH29zf8
         QiqH9r9ac0H39gb5SS37rXRQ8RJmokz3j7DsrZPazKXmk1IzhHJ1D+yJTvo/hcr69+cF
         KTWJnkNPdEpfBkozGuhC77XXGM/NQ5jEuj0ie7QtRvhfAxvtNw2VOfPz1/JA2yrDvU5K
         MOUpHFab+UOlg5Nwfcm7GYaGBNqGlELLSkwvk0ru3Kov/ndutsqZEAcDyim3QdEi/Agr
         iB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258245; x=1762863045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzUjjBieESWl/eKHRRME8VO1FyP4Xh2Gr78dnGWZR3M=;
        b=qmceNVY4NC2XyYUAP3L5nwqK5AektDnuObyBx3dyrgh9wRDC84km55kig7+3ReaTA4
         J4zhLgR8DiDxK1omoWc+NrRidVvHLu8ADEk2Wza2ErjJgLq0jF+ifH0xzvrCA0Bg99OI
         XSkn9H6uQpMZWsZr0JKOWqdSYovxsRh7QcXThe/PCz7xCnU77LN9eFmEkkmuPlcO6p+H
         QKq7O9sAbNhH2rr2c3pHEkdl0im+fI6YxoTpd34Gd9clBc+m/sGcjA4O3qvH50N0y27w
         Z1DLzwv0OvcsFUrdEGeR3PvzI0exwIZlI851pRM5Qm5LpJYMSYn3ARvQr2jORbBfdzyv
         +yYg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6rZRYNcYcT9KIAjyQLW3ztIxCZxunoFPnV0Mu9swhdkt2JSagKc1ZutG8uvJ6hpmmBHXGpvmFgZZ51Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aV+QKJCEwSX1Rzg3HPMd+QHP1hw2dwUe3y6kst6wbNtTAEXs
	178cKBUL1gmaHeg4BbrkbdcSUs3m8Mr0UBOdnw5invDhN7sjVkLqaW3d0WVPcEHSst1YU07Oghp
	JLqaXvLSRgCWVIfubn9usuSmMtPtG0xM=
X-Gm-Gg: ASbGnct9OJExaEEU/ZCL+9tSU+sK6BwxktmTTSTqz41ZjBj84nU2gpwTgIctx5q9q1V
	+IrOEuIDrIp7yaWUWgkumCm8L8NkVLPrFMAv4yZsWovhKVMRex9CypJxIdn4nAEeAj2qkH0s7lU
	+iOx6KJIAwSnBJNnAhHLnoL2UjEd2nHCSYkr9Bcc9VBANoJAtdrpOzgl5Bn4ooHZDCNzSkA28Gh
	/ZUmekxZPagiiqnvJXUZdmfOrxurxIGVyKqGt0EYPhwkW2H1uq5bY8VxwIA
X-Google-Smtp-Source: AGHT+IFYNmK4p8ZzQreCCOl4PXO/MkzLrFaWoACxm/O8s2bicL/zOLsbm8jPi41+2YZ1Lhpc6tL1AcArgolgsFl++YU=
X-Received: by 2002:a17:907:3faa:b0:b72:5983:db09 with SMTP id
 a640c23a62f3a-b725983e06amr109317066b.32.1762258244771; Tue, 04 Nov 2025
 04:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103110648.878325-1-caojunjie650@gmail.com>
 <20251103110648.878325-2-caojunjie650@gmail.com> <20251104-dancing-panda-of-patience-49bcc7@kuoka>
In-Reply-To: <20251104-dancing-panda-of-patience-49bcc7@kuoka>
From: Junjie Cao <caojunjie650@gmail.com>
Date: Tue, 4 Nov 2025 20:09:05 +0800
X-Gm-Features: AWmQ_bkkyexGfBD5XHzrBd-xICWXFb2FCbbahEGY3fitC4E7OLdD5Bwvl1yJFfQ
Message-ID: <CAK6c68iy0vwgKJTgXr=YptyENTWC1MJrsJWsbsyp9KQkAtOYVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: backlight: Add Awinic AW99706 backlight
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:30=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Nov 03, 2025 at 07:06:47PM +0800, Junjie Cao wrote:
> > From: Pengyu Luo <mitltlatltl@gmail.com>
> >
> > Add Awinic AW99706 backlight binding documentation.
> >
> > Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
>
> Messed DCO chain. This wasn't here, so you must have altered v1 to add
> some weird change.
>
> This is a blocker, please read carefully submitting patches and DCO.
>

Apologies for the DCO mess.

The tablet device is currently with Pengyu. He helped with testing and
tweaked the .c driver file (patch 2/2) after my change. The entire
series was then re-formatted on his machine, which caused his git
configuration to be incorrectly applied to the From: line of this
dt-binding patch (patch 1/2).

I am the actual author of this dt-binding file. I will correct the
authorship and DCO chain in v2.

> > ---
> > Changes in v2:
> > - use proper units for properties (Krzysztof)
> > - drop non-fixed properties (Krzysztof)
> > - add properties(max-brightness, default-brightness) (Krzysztof)
> > - Link to v1: https://lore.kernel.org/linux-leds/20251026123923.1531727=
-2-caojunjie650@gmail.com
>
> ...
>
> > +  awinic,dim-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: >
> > +      Select dimming mode of the device.
> > +        0 =3D Bypass mode.
> > +        1 =3D DC mode.
> > +        2 =3D MIX mode(PWM at low brightness and DC at high brightness=
).
> > +        3 =3D MIX-26k mode(MIX mode with different PWM frequency).
> > +    enum: [ 0, 1, 2, 3 ]
> > +    default: 1
> > +
> > +  awinic,sw-freq-hz:
> > +    description: Boost switching frequency in Hz.
> > +    enum: [ 300000, 400000, 500000, 600000, 660000, 750000, 850000, 10=
00000, 1200000, 1330000, 1500000, 1700000 ]
>
> Please wrap code according to the preferred limit expressed in Kernel
> coding style (checkpatch is not a coding style description, but only a
> tool).
>

ACK.

> > +    default: 750000
> > +
> > +  awinic,sw-ilmt-microamp:
> > +    description: Switching current limitation in uA.
> > +    enum: [ 1500000, 2000000, 2500000, 3000000 ]
> > +    default: 3000000
> > +
> > +  awinic,iled-max-microamp:
> > +    description: Maximum LED current setting in uA.
> > +    minimum: 5000
> > +    maximum: 50000
> > +    multipleOf: 500
> > +    default: 20000
> > +
> > +  awinic,uvlo-thres-microvolt:
> > +    description: UVLO(Under Voltage Lock Out) in uV.
> > +    enum: [ 2200000, 5000000 ]
> > +    default: 2200000
> > +
> > +  awinic,ramp-ctl:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: >
> > +      Select ramp control and filter of the device.
> > +        0 =3D Fade in/fade out.
> > +        1 =3D Light filter.
> > +        2 =3D Medium filter.
> > +        3 =3D Heavy filter.
> > +    enum: [ 0, 1, 2, 3 ]
> > +    default: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - enable-gpios
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        aw99706@76 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
>

I see. backlight@76, thanks for your detailed explanation.

Regards,
Junjie

