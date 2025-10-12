Return-Path: <linux-kernel+bounces-849632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1ABD08CC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0533BE0F6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561112EF64D;
	Sun, 12 Oct 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw+Mn5qZ"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29482ECE84
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290930; cv=none; b=erk8v2bCbMzHO3oAYtpSKZIf5xxw/CTmROoBSgh20bQukPwPyTehVxqu5IaOgzyem6b88nkK2r64Kvu+bQS5p9dYtAYc2L7HTZjA/dIS+HumKLrekRu80XlnGb0eMRMfFAhjszeJ8CiVNLyrDVW/D72Y/VlJjDLIvyIXQI+pY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290930; c=relaxed/simple;
	bh=eP9vUD+vnLqburWlbhDBLpx8OtHE5Yk44Bqb+/o3gVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t24CmbNzV5GlSOSD+PYnj7KwrWFRiAEQwEEiisFCfBol1E/cB8VA7vV/K/DLeXParNbx2f6YXNjVcsEwg5bsIj6ZHJHvM1mcbS6DiZOijNK6J1B7h4RHfghw0A6G8+jDCIcjUv8ypQG8lmYy6CEKAkfB0cQJYqIwELGuNMiJ5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw+Mn5qZ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5375814a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760290927; x=1760895727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9Vp913h5vL+QAaTd5YmM73F2Cs5m5TxizRwXZaWP60=;
        b=Hw+Mn5qZUJI+e8Cxa9EV7oM11VEB/z367A0Rlv+hmdGbG6+IdNMjBeeQ3UQ2jteQzk
         8TW/iI3ZvYDHf9S0YcnwtH/eba/FyHF/vzHN+L5AX7OO+x1UHYeBFF9GL4JaEfw5IBta
         idNgUnJnqey3KTB99sEdEKrvceiiD/13kbEpfZV/QszVbAX41Kwir1/tQLLEuivMq/hT
         rf3ruh0EJhXOpGLjqmzCkhWAokDvjoJTOvY1n/ZUqqBdhyYqizPnujDTZpAZ1MgdHQct
         aKW/Y8cvVTK67MNFFxvdLK7jhEyFKM6E8U0nlIzlaKEMNbe+Pz72k0gWsQIv3KeULZ5B
         5QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760290927; x=1760895727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9Vp913h5vL+QAaTd5YmM73F2Cs5m5TxizRwXZaWP60=;
        b=cIJThQKIIiuzvNTt4b18aAN4ZZG+RDDLwxn3wVUFHtKKb8esZpSLDJw4Y4b03cA9MY
         6AuJVVGsqbnprUN2GiQ+MDYJcyGNDOXbE0MJNZqkdbq4HVS2vZ0ZxOdlILLybhe/ZLuH
         fBA/4ubPJDIMBCTr0+Di4VxebGtIid1BfVuiK65kGoWVStwKZHb1l9OZxZYG420DP0uo
         9DyPjPr1Nbjq3xz+4q4kDoYRejn10UHxBc+qJjf4pCspypLxywn88mR9zHsI3j6Qgybf
         foPGq/IzIobbzKXi5HXydv+Pko1VmTA+ikpTwEjzNXfL4medqKnxXWX4RbbxrucDb7fr
         GQow==
X-Forwarded-Encrypted: i=1; AJvYcCVOlZOMg14Cura7XqmiFB9IlwzMA8TpTWHXf1RhebB4SPmjaG7Y6BgUQL123Xqev5R4txVuVGveer7Iqlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtq2mAIL8XpzNq15ne3aQkUv2yG0g8TPf6qeUuhyC/YhzjjBBg
	lvUgNP3bupnI7pCsx5gzvgLfJ0xel1Mzc+JZEF5U+NYV1L+akAgLtWqLTX82wdF0UODcUFUR6uK
	MgbSaB5rkP4mJ1ry1uLR31YTw7unP/as=
X-Gm-Gg: ASbGncuymeiKR4IvLWNMzimR6DN9py1pEasEWsHBbeSvVBU3EHBeHT5fF6XTHe0zBsn
	AfVUG6Z9kI5E+2Y4Z0ZFEpKUiB3w6w526nHUzBpI8S+gb+T4vagGBb+b/3YyGcOuFu3oKHQ6b8G
	OqIWCgZnlXUxRG1iuqmnxjHa0VnkCAqlfAalYmo3eVhhXyuUzVMs8gmgt7T59vo/Ui2g73pIIGP
	qs++oZL2g5TY/kyKfEmW3HAQQ==
X-Google-Smtp-Source: AGHT+IHK/YEDMsxfyxXe6QHnu1EkcbH1GIUSupmeK3Uje3bcpIQzzt6PFoeNHm7/h6JTMXG/uNGnvGRHvfar18LgOMI=
X-Received: by 2002:a17:906:dc90:b0:aff:fe6:78f0 with SMTP id
 a640c23a62f3a-b50ac8e5533mr2061063566b.54.1760290927009; Sun, 12 Oct 2025
 10:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com> <fce1c905-1c64-47b5-91b1-0017809ec12c@baylibre.com>
In-Reply-To: <fce1c905-1c64-47b5-91b1-0017809ec12c@baylibre.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sun, 12 Oct 2025 23:11:55 +0530
X-Gm-Features: AS18NWAjXit-R0YqUEVlsFKx0AtG-hL4GXHhWfTkLW4-ZmK0phkm6xICo2h97SE
Message-ID: <CAHc1_P7W0sU_5dU8Ei9MgGOFA+N7Q=fotk91vdcGUuUGLWLuqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:19=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 10/7/25 10:17 PM, Shrikant Raskar wrote:
> > The appropriate LED pulse width for the MAX30100 depends on
> > board-specific optical and mechanical design (lens, enclosure,
> > LED-to-sensor distance) and the trade-off between measurement
> > resolution and power consumption. Encoding it in Device Tree
> > documents these platform choices and ensures consistent behavior.
> >
> > Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> >
> > Changes since v1:
> > Add unit suffix.
> > Drop redundant description.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.=
com/
> > ---
> >  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max3010=
0.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > index 967778fb0ce8..5c651a0151cc 100644
> > --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > @@ -27,6 +27,11 @@ properties:
> >        LED current whilst the engine is running. First indexed value is
> >        the configuration for the RED LED, and second value is for the I=
R LED.
> >
> > +  maxim,pulse-width-us:
> > +    maxItems: 1
> > +    description: Pulse width in microseconds
>
> Would be nice to add to the description which pulse width this is referri=
ng to.
Thanks for your review comment, I have updated the description and
shared v3 patch for your review.
> > +    enum: [200, 400, 800, 1600]
>
> Properties with standard unit suffixes are u32 arrays, so I think this
> would fix the error and also make maxItems not necessary.
>
>        items:
>          - enum: [200, 400, 800, 1600]
>
Thanks for sharing the fix. I have tried it but 'dt_binding_check'
complains as below: 'items' is not one of ['description', 'deprecated',
'const', 'enum','minimum', 'maximum', 'multipleOf', 'default', '$ref', 'one=
Of'].
Schema expects it to be defined as a single u32, not an array. I have
updated the patch accordingly.
> And we want to know what the default is if this property is omitted.
>
>         default: 1600
>
Thanks for your feedback, I have added the default value and shared v3
patch for your review.

Thanks and Regards,
Shrikant
> > +
> >  additionalProperties: false
> >
> >  required:
> > @@ -44,6 +49,7 @@ examples:
> >              compatible =3D "maxim,max30100";
> >              reg =3D <0x57>;
> >              maxim,led-current-microamp =3D <24000 50000>;
> > +            maxim,pulse-width-us =3D <1600>;
> >              interrupt-parent =3D <&gpio1>;
> >              interrupts =3D <16 2>;
> >          };
>

