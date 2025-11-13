Return-Path: <linux-kernel+bounces-900073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AAEC598B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04C09348E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D713128BD;
	Thu, 13 Nov 2025 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dskw5zhW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BC12DDA1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059341; cv=none; b=RSBE2YlfWcVtK2a7C7di/hvWRjj9o+wTTTiqNls0s80jfkePH3UPRFu7DwumD8X5qDoDez0FuoHuIb3WhQ0LFFfWAMonvCmffvtokXrdWTMHZj64NR7gKE8A0mM3b+9J+3m9+BBNfk8HFJF6EoEhZn+UmN0QrPIE2UfRH+AdJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059341; c=relaxed/simple;
	bh=VCK4+5C8NcYq0P9jDNeakspMs/yrMuAbxdcuxCnWLok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cro2hZEiYi2mR5dTsnHg7Xgq9CN5KWUjyc9zMHCelBdD80bjRkDSP4sdjH06DVK/CBqCAUoDEVnISw0zSM/MrwGati1rkIG1plKgKWj0Ej+vBIj4HRBA/eMM57Kl1hdFOf3bFZ0cxDtSlOiIew1rFBL4odK0lZ4SeX+wFzAygE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dskw5zhW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso2554487a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763059334; x=1763664134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pXTM/+Sn5ck0pJjBV1Lup/KQT4FwvuZ93IhS694xuE=;
        b=dskw5zhWogT04uel3cM8jIs9sWQhQ+6FIRvQeLyzP8NveV0ZGqEaLY6Y3ETVBQmwo6
         bw00AqF0KeV25X6SJlzJF61JxaWlZK+9I7VS8zEcnAi6dWuMLTgKQyV3bCl8nqgueaA4
         bIUHiekN/fUgVzdavUYyYe+w/15D7yb6dDaAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059334; x=1763664134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pXTM/+Sn5ck0pJjBV1Lup/KQT4FwvuZ93IhS694xuE=;
        b=aPnwxmL9pBmJRRlaCESeoB5q9IgqZZAz9C10pMRm3UG/KK+Tz3I1c4vQRplgeOWd9y
         Q5W67sH9VL2yevY2vgYoNYU8phJ/eGb5UDZt05JI+AB5oIpivDtfDIAl7ro3mN/S24h0
         bPkP/1JUWQs4y2v3ToaqEy59bT2cCT3mDYiVvoUjJthhPleX/NLD7ffwCBfqJhA1qv+M
         fDX3/GCqZVAF+8QF78QjMVsbABy+Wjxnfqm9EE33Mw+kKP8TAMvhzmEVCOTFAJ77ewbS
         zU4zT+lXefckv+7lECityHjVPF9/R8P4HW+rctqEBsVK1358b7P3SdzfvNcEykYBTWvv
         GfeA==
X-Forwarded-Encrypted: i=1; AJvYcCXM1c5EO8u4DqsuzRWqgpMlRI40+5HqAYin3UCDuth7CYO4XdQsaE9sL9BOS6pBysJVqfYxpwFTjyarENY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKDItwZmgLhL1dqSec2bmaxBeNvT9RkGEtEEJMdCPQFUVMlss
	lR+qYVuVX32WNuRJa3r8a+9CdpnZXM73gd/8UadUADZer1MU81D5PRaH1rgeZuDB0NWEftJvHuw
	ztNUzOPix
X-Gm-Gg: ASbGncs7kNvFhwg6B+v5xnnUgfpy2DBnJRrtBaO0uq2NOIOeNDNCMwRzy/XTU5+salo
	HtZYRFjssxMxgO75Rl6aJ87m6CAmyF9Mqo7ELdFF8g9O1hij1c9bkh5XHENy8ccLfVx/zIdziS7
	9H0uYiU7DABK+mygfp4YxAlP5knNYy8Dp4dhos5hgbvFUyK98Mgtmnxc66+EHSnmE865Gjy/piQ
	IzUWDy2z7JhqOfkTfnwt2XM09TggmWL6jg9i7eTcBnJSIIm1lkVgYQujq4GDjxfmqPa5lMJTxrf
	o2tMO3T4IOhc6zbn15xZrTWgeggwumgMqL1C2gyzA0aAiWtncvAVWz8hrYk/pYg/hHr+hB0uO1q
	q4NrKAcx6HZAjcIITeFWf7GOvfq+4Y0bWtuUQiHwBu73eIyiDnh3MBOZy1pjg+nQkzLOljTYcwo
	goIVUnMCnyJWOpFJxNgX5MmiZ7KQTAas+BaHPuk5extzWhgIk4ULTZTCvLrbLw
X-Google-Smtp-Source: AGHT+IEWx4svGNdii4hjwlEC3pvfhhrXHTj1+njN2micFFO54gknUDA5JuQC4wrU6fPjnEYJ7vT5QA==
X-Received: by 2002:a05:6402:254a:b0:62e:ebb4:e6e0 with SMTP id 4fb4d7f45d1cf-6434f8104abmr595607a12.1.1763059333511;
        Thu, 13 Nov 2025 10:42:13 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f96e2sm2031885a12.16.2025.11.13.10.42.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:42:11 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563e28a3so8021055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:42:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5ozD6uyVddpxXH06qpGRO2x8r1XFNG88pHRch/FY+QxK3jHR1mNqT+Rv2GYse2ee6PheKZx0I+H7QUuE=@vger.kernel.org
X-Received: by 2002:a05:600c:c87:b0:475:d91d:28fb with SMTP id
 5b1f17b1804b1-4778bcb36d1mr39940165e9.4.1763059330721; Thu, 13 Nov 2025
 10:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111192422.4180216-1-dianders@chromium.org>
 <20251111112158.1.I72a0b72562b85d02fee424fed939fea9049ddda9@changeid>
 <05c833f0-15bc-4a86-9ac4-daf835fe4393@kernel.org> <CAD=FV=XXWK9pmZQvNk6gjkqe6kgLXaVENgz0pBii6Gai7BdL-A@mail.gmail.com>
 <00ea821c-5252-42cb-8f6f-da01453947bd@kernel.org> <CAD=FV=VSxeKgGcsRb9qiXq7nsbOWZjPvzmGEOhFA+pmABWdknQ@mail.gmail.com>
 <6490f20a-2492-4ee0-8f34-d529e0df0bad@kernel.org> <CAD=FV=Us7SU_OifVkS4mdfVhc=xGYSBiBpBk9aA1Ki0y+iYBpQ@mail.gmail.com>
 <abb77afe-c285-46ba-88ac-08574bd67712@kernel.org> <CAD=FV=VcAbgv41tjgWQN4i8Wqk6T6uvdpQ261Q_hcKM4AMpGEw@mail.gmail.com>
In-Reply-To: <CAD=FV=VcAbgv41tjgWQN4i8Wqk6T6uvdpQ261Q_hcKM4AMpGEw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Nov 2025 10:41:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X4bV_YdeqymOMb5dphZwW4T4tASJo6hbuCjDMykVtYVg@mail.gmail.com>
X-Gm-Features: AWmQ_bmy1aehQ6uhI85I3Z-_qkNj2-reqpyxguooVv-yaJfHf2TNxdZyFa3FBPw
Message-ID: <CAD=FV=X4bV_YdeqymOMb5dphZwW4T4tASJo6hbuCjDMykVtYVg@mail.gmail.com>
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

On Thu, Nov 13, 2025 at 10:04=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
>
> On Thu, Nov 13, 2025 at 9:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > >>> Yes, the complexity of just "hooking up" the components on an SoC i=
s
> > >>> an order of magnitude harder than a Raspberry Pi, but it's still ju=
st
> > >>> hooking it up to external components. In both cases, we are modelin=
g
> > >>> the core "brains" (the part that contains the processor) as the DTB
> > >>> and everything else just "hooks up" to interfaces.
> > >>
> > >> You mix the topics, so I don't follow. I speak here about bindings -=
 you
> > >> cannot have the that compatible alone, because it is incomplete, jus=
t
> > >> like compatible for "transistor" is not correct in that context. You
> > >> speak what could or could be DTB, different topic.
> > >
> > > A "SoC" is "complete". It has a processor that can run instructions.
> >
> > Then show me executing any piece of software, which is the consumer of
> > the bindings, and runs on the SoC without the rest of the hardware syst=
em.
>
> Show me something that runs on a Raspberry Pi (the models that don't
> have eMMC) that runs without hooking up power and plugging in an SD
> card. :-P
>
>
> > > In any case, maybe we can approach this a different way that I allude=
d
> > > to in one of my other posts. Can we just call the SoC thing something
> > > different and make everyone happy?
> > >
> > > 1. Rename the SoC file to lga-b0.dtf (device tree fragment) and
> > > _REMOVE_ the top-level compatible. Problem solved--we're not adding a
> > > top-level compatible.
> > >
> > > 2. Add a special node at the top level of the "dtf" file describing i=
t
> > > (so someone could figure it's useful for). Like:
> > >
> > > fragment-info {
> > >   compatible =3D "google,soc-id";
> > >   google,product-id =3D <0x5>;
> > >   google,major-rev =3D <0x1>;
> > >   google,minor-rev =3D <0x0>;
> > >   google,package-mode =3D <0x0>;
> > > };
> > >
> > > 3. We can compile the "dtf" file using existing tools into a "dtfb".
> > > This looks just like a "dtb" but has no top-level compatible but
> > > instead has "fragment-info".
> > >
> > > Now we're not violating any spec because we're not adding any
> > > top-level compatible.
> >
> > Didn't you just describe an overlay or DTSI file?
>
> Sure, you can look at it that way. ...and since you're happy with
> "dtsi" files I assume you're happy with my "device tree fragment"
> files, right?
>
> The difference here is:
>
> * A "dtf" file must be able to compile (with dtc) on its own. Contrast
> with a "dtsi" file could rely on labels that are provided by the file
> including it.
>
> * A "dtf" file needs to have "/dts-v1/;" at the top, unlike a "dtsi" file=
.
>
> * Kernel (or other OS) build rules will be happy compiling a "dtf"
> file. This is in contrast with a "dtsi" file.
>
> * A "dtf" file is _intended_ to be compiled and hooked up to an
> overlay. This means it will always be compiled with "-@".
>
> * We can document the requirement that a "dtf" file needs to live
> together with the overlays that it will be combined with to make
> complete device trees. This means that there is no need to set a new
> ABI boundary here and we can be flexible with what labels are exported
> by the "dtf" file.
>
>
> If that all sounds reasonable, I'll get working on it right away.

FWIW, I wasn't terribly happy with the name "fragment" or the "dtf"
suffix but couldn't come up with anything better. ...but then I just
had a realization. Perhaps it would be better to think of this as a
"SoC Tree". Thus:

* .sts: SoC tree source
* .stb: SoC tree binary

...and a "SoC" tree it always intended to be the base for a device tree ove=
rlay.

This also matches with my assertion that really anything with a CPU on
it should be able to act as the base here.

-Doug

