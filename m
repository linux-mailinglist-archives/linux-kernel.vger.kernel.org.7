Return-Path: <linux-kernel+bounces-900018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049AFC59644
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7FB3AA0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BB328B5E;
	Thu, 13 Nov 2025 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XL+w0aXz"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F12FBDE2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057116; cv=none; b=Yi5Ans8xN6bOw669jeIX6XWC0rRDPIqu2b6IC91kfgcX40+wxAN+s58bS75fbGI1MbK1wg5ifzqQuv86fKmEEGhMt7inRvE2XjDslCWa/Ntcr8+LLTjNcx5g1KPvYeseOTMuWAkl0by6Id/hgYgyUkcYpzjTVNWCMJ/TdgNqP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057116; c=relaxed/simple;
	bh=pf1IXO1BZpdM2zhduHtSifJzEC4zT6MOU9JeXX7SMOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blyZ2pllToGGkYlWrZc8f5fWbU22KE6nNzNGGaffCTUU/NzY7AJ0YhrDzuq/MYZf3Y7eY4G11qk9oHD6dG729q/rl6pRzDui02qvZDybnBG2T2SsM4r6i7XAo4uzr488+N1+dRCNGTeDawm5/Bx3J3mshaNxJ6GdWuQq6QujIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XL+w0aXz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72bf7e703fso184785866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763057108; x=1763661908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6uac0xj8a+6k+KJ/TLozw+bMuDmR0K+Bzcv/b4RoLw=;
        b=XL+w0aXz3M3Nw6LB56xNxpe42rJZBinLtofeGpZnV6hhQjSkXm3LbxeSk3evulJtKh
         q+0UhlaJb3ZPiluRBDBqX9ryC8LM6n6KDXdd+uuX0jN/4UHJlkYKNwIjiuFDmu8p0ZEv
         NybDGRPmUUsbsaYVJMGwLxZHrKhn4SKBbYMhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057108; x=1763661908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6uac0xj8a+6k+KJ/TLozw+bMuDmR0K+Bzcv/b4RoLw=;
        b=KCwWG5H7HSzsZLul/FAQ/MzErY7+oAoN7N1lit1U8xFO6Q706HPbWYXtDgx3YlR1jx
         04h7BDPi7b+kB0mlFiMVDTHV1MXfbRxPR6FPCAzQJd00WbvpPt2yUx5vpYOyWlakjFTo
         9UOZfjxX8Ctf1nAFntxwkAD1x51ccosXHMePVFf7QHWGlKQbiZhOKQNIwb5QUGX/V0lF
         oarKhG8hkT0U+CnbQ2FV/i4VeZ/NZ+4V1onhVgyU183HmQXZE0Ly9VpOR8+/mlJ2Ygle
         EGzg2IQspgCKrMugyLkxqwra3vr2m3lzL5bEZ9p8ottdU90ny2fsywH5Ar7YrQeKXKNq
         rFFA==
X-Forwarded-Encrypted: i=1; AJvYcCUVgTmFPNrbTsaBLu84K9+vN2DodwXHOycSXLiefZDbkaeWAeHVyQSDJSp3ZrkU+YMdz5qpX4rmbBlgntQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPPIvrnjyJuhDJlDt8gcrN07fdIV3kBomKm8fj93Z5HSECvsZ
	n9QaBDE0i5/WSCjZu35kOXaO1gVXCU0fiqfPMZ0Nd7cqhNsjGPX92f1ba6x/PGq2dT+culYienv
	G3VsQTNf8
X-Gm-Gg: ASbGnctuBAFuZf0n9Ps5dd8CQzgSvba85ABgC7wstmhKoCCaa0K7gftSGXRpALOO12k
	q+m3oa0yxvNDQoBGvttYEd1q+6fRHJJjLXLp7ZckAVkxVPdTwauZvYQw3GKt1rBwm+vsfcvIRO/
	3ZilOR44XvrTe/qWRtWw0BMcCCe7sllfgG9te0NqWGQ0dZ91aDrK4tCc6xF/giSKjg2lFWckSBX
	OVra6XtZZ+JKhfAlLreqcAoolDFwIKL292jd2arCn0TyBQELMD0JSOA3Y3lx24FRle1k+8TN5pU
	TPXYBQSy4dceTrj9pwVMxvLeZy7IHDiIO1t6SjUUeL2HTykda4CNRGdEXjyWJPPYvV0+MP9DsLJ
	RHibaO3O1QDsnUoJ9ziveSbJ/wYVE9ChkDQlXqNF8AN8pf6hTjdZVCPCrhxfaSOhqCNMK2B59HH
	eWrWVaFV5MwZDlUHS5pQoeKAJsGSFL3hjTMDr+ZbzCYTbhc8PaUA==
X-Google-Smtp-Source: AGHT+IEGicKtA/pzADJ4hF1TJB4nCI35V1np0b4ATY4PyZNx8ZwFO4FoUeX2xz5ZynNICEb5xFHE0w==
X-Received: by 2002:a17:907:3e8c:b0:b73:22fe:3abc with SMTP id a640c23a62f3a-b73678cba23mr17694066b.28.1763057107622;
        Thu, 13 Nov 2025 10:05:07 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed80f0sm205667566b.66.2025.11.13.10.05.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:05:07 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so724060f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:05:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV85hDnDrGLuxLbCCksPt1LHY3/EquAXig4PSXmtJPNcoi6+lHDUPrNONsrGASsr4wAETE8NZy94+aVpgk=@vger.kernel.org
X-Received: by 2002:a05:6000:1863:b0:42b:3023:66a9 with SMTP id
 ffacd0b85a97d-42b59367802mr289626f8f.22.1763057105007; Thu, 13 Nov 2025
 10:05:05 -0800 (PST)
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
 <abb77afe-c285-46ba-88ac-08574bd67712@kernel.org>
In-Reply-To: <abb77afe-c285-46ba-88ac-08574bd67712@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Nov 2025 10:04:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VcAbgv41tjgWQN4i8Wqk6T6uvdpQ261Q_hcKM4AMpGEw@mail.gmail.com>
X-Gm-Features: AWmQ_bm88XdKzAi5IStwbrVdXDDrbTXMC9ViB_9-mq5L9vr4mmyrArKaiYvTgn4
Message-ID: <CAD=FV=VcAbgv41tjgWQN4i8Wqk6T6uvdpQ261Q_hcKM4AMpGEw@mail.gmail.com>
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


On Thu, Nov 13, 2025 at 9:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> >>> Yes, the complexity of just "hooking up" the components on an SoC is
> >>> an order of magnitude harder than a Raspberry Pi, but it's still just
> >>> hooking it up to external components. In both cases, we are modeling
> >>> the core "brains" (the part that contains the processor) as the DTB
> >>> and everything else just "hooks up" to interfaces.
> >>
> >> You mix the topics, so I don't follow. I speak here about bindings - y=
ou
> >> cannot have the that compatible alone, because it is incomplete, just
> >> like compatible for "transistor" is not correct in that context. You
> >> speak what could or could be DTB, different topic.
> >
> > A "SoC" is "complete". It has a processor that can run instructions.
>
> Then show me executing any piece of software, which is the consumer of
> the bindings, and runs on the SoC without the rest of the hardware system=
.

Show me something that runs on a Raspberry Pi (the models that don't
have eMMC) that runs without hooking up power and plugging in an SD
card. :-P


> > In any case, maybe we can approach this a different way that I alluded
> > to in one of my other posts. Can we just call the SoC thing something
> > different and make everyone happy?
> >
> > 1. Rename the SoC file to lga-b0.dtf (device tree fragment) and
> > _REMOVE_ the top-level compatible. Problem solved--we're not adding a
> > top-level compatible.
> >
> > 2. Add a special node at the top level of the "dtf" file describing it
> > (so someone could figure it's useful for). Like:
> >
> > fragment-info {
> >   compatible =3D "google,soc-id";
> >   google,product-id =3D <0x5>;
> >   google,major-rev =3D <0x1>;
> >   google,minor-rev =3D <0x0>;
> >   google,package-mode =3D <0x0>;
> > };
> >
> > 3. We can compile the "dtf" file using existing tools into a "dtfb".
> > This looks just like a "dtb" but has no top-level compatible but
> > instead has "fragment-info".
> >
> > Now we're not violating any spec because we're not adding any
> > top-level compatible.
>
> Didn't you just describe an overlay or DTSI file?

Sure, you can look at it that way. ...and since you're happy with
"dtsi" files I assume you're happy with my "device tree fragment"
files, right?

The difference here is:

* A "dtf" file must be able to compile (with dtc) on its own. Contrast
with a "dtsi" file could rely on labels that are provided by the file
including it.

* A "dtf" file needs to have "/dts-v1/;" at the top, unlike a "dtsi" file.

* Kernel (or other OS) build rules will be happy compiling a "dtf"
file. This is in contrast with a "dtsi" file.

* A "dtf" file is _intended_ to be compiled and hooked up to an
overlay. This means it will always be compiled with "-@".

* We can document the requirement that a "dtf" file needs to live
together with the overlays that it will be combined with to make
complete device trees. This means that there is no need to set a new
ABI boundary here and we can be flexible with what labels are exported
by the "dtf" file.


If that all sounds reasonable, I'll get working on it right away.

-Doug

