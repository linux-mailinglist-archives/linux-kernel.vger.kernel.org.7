Return-Path: <linux-kernel+bounces-871514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E3C0D89D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954D43BE386
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF582FBE01;
	Mon, 27 Oct 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="C23rvOE/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EA34CDD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567817; cv=none; b=Stn11wPxzwcMyIvNCB5tyFtqCu/xBbQBtuwLf9rv8nK1oj7FaRIS9faEmyD6WJeBe32j+63amoh+Pp2CTiWZ+4dykbXimGZ3lt4926bd17vtLunWONeNBRFArhzbEOOGhMm9Hwqio4/nIixO0m1V76uFUgAYCapWxJnHKfwK55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567817; c=relaxed/simple;
	bh=d88UCqzm/BRl4RoM9gzbXqgbUadA237ovz+ngF2Qano=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ3ebV/ExqWAFFd99qXIUm07wpgumV4Ez3cGzSeSSsLa0rRbZcxYU4QgcCK7AXJzFNwxopg3PwuiRXphYvZ+z4bDh/lFbOK/0trM0OzL1CSTSCoqVUGBZE6VQ8x3++Vq2rl2VTaetrTRoyFV23Rw5vKFjdqpBfzt4KfPdb2rNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=C23rvOE/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so7242454a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1761567813; x=1762172613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rwg4RdU9/S/DCDYFa84+lfxA0r6Yx3IlD8K+TOMC9M=;
        b=C23rvOE/p1Rer4LO0wVI/neOicjALJt99yUrtuzUFQDiSOm1kL2FFJLZX9P40lbXdq
         iHk9ee7BQWoOyBs3hYWSKMfpACvGg4hwrNo+puX9VBsiP8oMZIdH4bVfafwwzVKOl+BG
         FzS6/4KUkmaW8ffqaPkKn4DcMZwE3N04k7rxkZUZSH3eCNiO8DS40MvFyE4fekqcKkad
         hQYpugHK6wOhgBNX1CKtGMV9pI062EJ5YqMHHRW4eMrDNvJVqZw6cuvylmUwcCtnTuMr
         igLyRvx4MLNCysGzOSh7drJ87M6dgeVMCbrrbyh2JieUNKW63b6ZRgZsJlZ0rhfGNILU
         68ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567813; x=1762172613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rwg4RdU9/S/DCDYFa84+lfxA0r6Yx3IlD8K+TOMC9M=;
        b=gg34wlFAJglih4QwC5tRwdiVNuO2lBKa9gAePRV+RPK9y8zJoIVjmKK7A5L6p/s5/Y
         FfmCDPTBq7gxZVU7uMMER/YunwbeF2VqQCFLKInuAPCtUHGSWFgTzEz9ymlLm7K64a0Y
         cdSxi1Ncr5ghopEpyvmnAnhTZwezs7wNkKcOuKtPaKiTniLYYYpKNGCZEI1Bf97ikmdT
         yH+s13QLY9SQvgIbhhIwkmwP9vCtWZPGZfZx1YK4QLEkXgCyivrNVJ4vdvE++ZsL4tPR
         9nbUXWGcF3dT+wFW9fAqa+xaW5p4p1WzNIONv2aPbts0x/X+RGTVBQp/lAHL9XbhSYPX
         w7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+fPwK3M0Lyll9Y5rgQi/h7t1kHiTFs8KwLmSf7Xfs/396MrBKWcDu+t3v5I88vKfNROXxF0q5iwKYZE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsplZ94wprgJQgu0MckBkalR7bHJafs2kI0H0EgNDxJG/Mv49f
	/VBk0lAYW6XCeKLON6W5a/+uF9O3aUovZSGaIyACRIHgOkmubdi0WxnlEzhmU9HfzChOFp0XFow
	6z/zA8HN/mjKSwprrT7LGd0eGku2gliS3fb/0qEWJ5TUUD1o7eusMCs9hmQ==
X-Gm-Gg: ASbGncuO59PbaXOBopKhEkUyquZm3fIZ2V2J8uRErVqYBimc6WWDRe50Jhen0NzlXsd
	0HjnfNKHmM6uKn4pFBznckS3zUIZ5/eap4+EWAL9Ctk6iBYYiMmIeTfl1wFvaz8F5aPO8UaQka2
	iMozKMEVaDmL4k4C6oFKcjuKZZM/GetkQ1CANUrrtc+ecPOqck7upK46XQ7tvAND+AJ8BbKdLHv
	KYDRGzbd6VIg1MQowLmLdeOD9bjHgbz6m1GiJ67CShzjpnX2Ntjgt38avsEDASoWgryYN8=
X-Google-Smtp-Source: AGHT+IF+BgjszyFXX/x4Nolc6aZVuXbe/fVp1I6m1HgOqoLTnKC+UhczCsAmebRMYM0mrQ7elw+gmukeql590E5d9Ns=
X-Received: by 2002:a05:6402:5c9:b0:63e:988:f115 with SMTP id
 4fb4d7f45d1cf-63e0988f4a0mr18134909a12.15.1761567813178; Mon, 27 Oct 2025
 05:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024192532.637563-1-robert.marko@sartura.hr> <f3bd99c8-eb70-40d3-9b43-fba56546f591@kernel.org>
In-Reply-To: <f3bd99c8-eb70-40d3-9b43-fba56546f591@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 27 Oct 2025 13:23:20 +0100
X-Gm-Features: AWmQ_bk9BrVtS_VU4383_snZ8tAl4VvlaevHaqgtibd5mFRHM2zru3PS4OqDYN0
Message-ID: <CA+HBbNGZ3FwrGCtHX=mc8LQR9DCU84jqfhjFRGVDCJWtt+gdkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: lan9662-otpc: Add LAN969x series
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	horatiu.vultur@microchip.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, daniel.machon@microchip.com, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 11:10=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 24/10/2025 21:24, Robert Marko wrote:
> > LAN969x series also has the same HW block, its just 16KB instead of 8KB
> > like on LAN966x series.
> >
> > So, document compatibles for the LAN969x series.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  .../devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml  | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-=
otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.=
yaml
> > index f97c6beb4766..f8c68cf22c1c 100644
> > --- a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.ya=
ml
> > +++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.ya=
ml
> > @@ -23,8 +23,15 @@ properties:
> >        - items:
> >            - const: microchip,lan9668-otpc
> >            - const: microchip,lan9662-otpc
> > +          - const: microchip,lan9691-otpc
> > +          - const: microchip,lan9692-otpc
> > +          - const: microchip,lan9693-otpc
> > +          - const: microchip,lan9694-otpc
> > +          - const: microchip,lan9696-otpc
> > +          - const: microchip,lan9698-otpc
>
> Why are you changing lan9668? Nothing on this is explained in commit
> msg. Also, list of more than 3 items is not really useful.

I am not chaning lan9668 but rather lan9698.
I agree that a list of all possible SoC models is not ideal but I was
just following the current
style in the binding.

As far as I know, the whole LAN969x series has identical OTP so just
using a single
microchip,lan9691-otpc compatible is enough.

>
> >        - enum:
> >            - microchip,lan9662-otpc
> > +          - microchip,lan9691-otpc
>
> Why is it listed twice? First you say lan9662 is compatible with
> lan9691, now you say it is not.

They differ in OTP size, LAN966x series has 8KB while LAN969x series
has 16KB of OTP space.

I am open to suggestions, for me just a single microchip,lan9691-otpc
compatible is enough.

Regards,
Robert

>
> Best regards,
> Krzysztof



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

