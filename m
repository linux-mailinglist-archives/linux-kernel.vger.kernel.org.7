Return-Path: <linux-kernel+bounces-779702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C1DB2F77C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 788B14E2B91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633631064D;
	Thu, 21 Aug 2025 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzzFcGxt"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF930AAD6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777985; cv=none; b=Y/QK39+N+GZYeb8TwHtjyvGoBQmDxfY6t1z+7GXJ4c/tbcBBb+37h05MHKWkDR8xlFHowW6YacJTloeShtnjva3svav/J1AGn1Fp1Nje4VYKfnJkj42uM2n/8a/CyeyCNBG61o1l25j8zPBPRrHUdu8PCdkS494u4Sd04TQ3C2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777985; c=relaxed/simple;
	bh=EqOATe6lxC8lL+rMjGZLssQp3T91Kjl3xSz+jvx0DUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLjK5M7Do/Fgu24dQy5QOaRCvzDNuORGhHqsAqXv632Zy4DRJfh9+UuWHETHooiaWRmUIp8L9p+joDzn8muLqGth4zHvIou/Q58lI8HrpvaTjmT3OuDdHY0ut4gEq0je+v5k7PrS38KFocVkBVXkVGZlyJw0vu79biASBaBwfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NzzFcGxt; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-333f8f5ca72so6756691fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755777982; x=1756382782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqOATe6lxC8lL+rMjGZLssQp3T91Kjl3xSz+jvx0DUc=;
        b=NzzFcGxtagRSaXmQ90qDHpMpg0V+GJbMNS2fMBIsfgZTfzijlYbpMr+k7eo/JxCxip
         DNz1O7FPLl9CEUERoghlQkigiooJ48pppA+nTJBxK8iArpXE7bWo3Ie4L7mbKeuCY/Kz
         zMDQ1pZF2pfiKSyMJ3vzVw7a3imKVC3uj8nSYNQ/X2MkwSa1CT3+58yXllYrAwSYWhKz
         5PebktTTpKQodCnxnU/LKYXmta3it+hOE2UA34wJgGCJ7iAqqIFrWvLnYQua9k/Zj1ow
         KYYAoacyUQF6ef93EgZ+r8F1oVS7NHim1DLVubXi4GW4yO18GnTwCo76S5fvDkYXzkAa
         YiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777982; x=1756382782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqOATe6lxC8lL+rMjGZLssQp3T91Kjl3xSz+jvx0DUc=;
        b=kzRDkQfGIzuzPATP2jR1YpO4rKbt2WLwBWY5TmlqaNprdQKXeZ0oc/t9ru313Zv7/d
         LUf7Ux0mM+39LRtfxn5xKe9mJndKBsm0gGzuCVv6Z3cxDPhEOLcBpiIL+Obn1ferz7gj
         HdLfmHV9Eo8vJ+25T+rVr7xez2en4aTRyg2jmaR1zBtEbbNHxxHKci160i8FNZvAcCv2
         w7Fuz3miKW5kt4xS2qnb9dbXABf8uXFspdmz3+pv+Ua4m+SX8ln08u2CqIitNLTaFCEX
         /BATFGk4toR9XnY8hwt5K4iBZ4rCDyytD5p6s6ruuSxMgObThQfqimgZg/hZWakHWWDK
         NDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq/PlFoi3EoLb+AgoWPpo4SnjkSkCzjq1E3tWlQtckY/6jkxIgf8X7aRmd8iWN5yGmDfWJTE3vET/TPTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHl7l80Xw+BDFDClQcfTFnkUTo5516ntz8Zzf+4Y+1Tk7bRBaQ
	m2fg3QYVH4myQWB2ef39DwfwDOPY3YTgybKS9TYoHUDt0wo+XjcbYXZL+Z7JBya05GODR8K1b92
	HXGjEIJScVp5tGtO8hXor5Z0af9OkGxpGgHHLJP8zRA==
X-Gm-Gg: ASbGncuE5eTsOWq8VYlDoPA+u9ivxpQibnuSnRwA/DobEP+nRHaGNzr1tP1EkiDULNj
	rwG9UM156vmbOsz9BOMY4J3B+F51VAWfxhOiZTe0M95a8AkqnEjBgAuxK9sbxejt2bMtl8v5+k9
	s7vrwLXkbF1TIZA3ywiqX2rhXybPpiIUzIKjK6T/iaZPEx0NDpq5I1a+cqIEFFn6inADc2H/5Y3
	lY/crc=
X-Google-Smtp-Source: AGHT+IGVtqYhx03rZLGlR0AUldfQFleIV8XTQ56VN7QoZ+/jtWggdq8uZGuLFW7FEnNgvU5NHrdHkWFWoRsaEWfWGQg=
X-Received: by 2002:a2e:a272:0:b0:333:be30:5adb with SMTP id
 38308e7fff4ca-33549ea13e1mr5180611fa.14.1755777981770; Thu, 21 Aug 2025
 05:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-ltc4283-support-v1-0-88b2cef773f2@analog.com>
 <CACRpkdYWNgU8PxVaxDe3F6Cbb15J5cgEV1-kgDooOHdBoXXs3g@mail.gmail.com> <5f456224-d26f-4cca-a2f2-31418da287c2@roeck-us.net>
In-Reply-To: <5f456224-d26f-4cca-a2f2-31418da287c2@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 14:06:10 +0200
X-Gm-Features: Ac12FXxIcyY_DhShmyxPbMRYnHac2dfkJsh4yDQXH3sgZV0u5dJUBt6Cww9nAa0
Message-ID: <CACRpkdYQa21PeAHTUPY2XRVnknnDS+v3Ci8DGyiYSdJdYVJCEA@mail.gmail.com>
Subject: Re: [PATCH 0/6] mfd: Add support for the LTC4283 Hot Swap Controller
To: Guenter Roeck <linux@roeck-us.net>
Cc: nuno.sa@analog.com, Jonathan Cameron <jic23@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:11=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On 8/19/25 05:36, Linus Walleij wrote:
> > On Thu, Aug 14, 2025 at 12:52=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >
> >> The LTC4283 device features programmable current limit with foldback a=
nd
> >> independently adjustable inrush current to optimize the MOSFET safe
> >> operating area (SOA). The SOA timer limits MOSFET temperature rise for
> >> reliable protection against overstresses.
> >>
> >> An I2C interface and onboard ADC allow monitoring of board current, vo=
ltage,
> >> power, energy, and fault status.
> >>
> >> It also features 8 pins that can be configured as GPIO devices. But si=
nce
> >> the main usage for this device is monitoring, the GPIO part is optiona=
l
> >> while the HWMON is being made as required.
> >
> > This main device just screams Industrial I/O, IIO.
> >
>
> Really ? I would have assumed that the sensors on a chip like this are su=
pposed
> to be used for hardware monitoring, and that IIO is supposed to be used i=
n cases
> where the data itself is the relevant information. What exactly makes a h=
ot swap
> controller screaming IIO ? Am I missing something here ?
>
> I am not going to argue about this if IIO wants to extend into hardware m=
onitoring,
> I just wonder about the rationale behind it.

It was mainly because the text talks about regulating currents and current
rush, and an onboard ADC. There is admittedly even a bit of regulator
framework-related business going on.

On second look it's fine to keep as hwmon, discard my previous
opinion, I should have looked closer and now I changed my mind.
I'ts good with some pushback!

Yours,
Linus Walleij

