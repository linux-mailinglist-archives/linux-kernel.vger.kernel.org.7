Return-Path: <linux-kernel+bounces-852363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E7BD8C54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204561922A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3472D248E;
	Tue, 14 Oct 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdfYgz7Y"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5662F5A17
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437768; cv=none; b=Lr6cEn06zuYPAaYNFcl6ElWMqEghgvqZEk9myJwZqIPKAxgcLk0G3fRHU+ik+JY13xXmlj2hfzG2SfnfgM2/+I3LsCpWX5Gay9UIyIfNypOfmZ8yAb/ykJt9W8cHgBz0GspwH6dEJG5jaAJa3cehWGyQ5rosg42a9mOK3JcEpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437768; c=relaxed/simple;
	bh=hYbEH8aG5/g2lPpfG/EurG4fthUUtSOeRcTH4W6yxtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOGDtBSPufa5bOmyB+XC9QfqXAIQBUpdHxEhNNnRO8ECwwQOr+VYYVLLnvfymSKNzliN4QvgQJFaTz0k/GFY9ERZuxAoBgUpdR97l21QVQuu90GygHPjlVDZ/D0JSWKE6ApJNo5x+xINAwko4gQ0RjTmeJg1PsK6v4xzLvol0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdfYgz7Y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-781421f5be8so17087287b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760437766; x=1761042566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNwslOTb5JOWqs8U+YdiNL7KIGdnAR5sXRre+K3C3ks=;
        b=DdfYgz7Y5rKyJFlUITSxKyldlwkvFkFQZTgk6UA/p2LEY5CQpKFBwncD4udabSboBD
         rrm7E9bZUvkucLxDDq/dee2j3ql/kyuWvNF76DVstATfP4FCeHsXikyQTr70j8gEegzH
         6KBn9Q62DDmtvc6VOh/nVPMqXKRqIMZliBdzMUV3/nvoWOleqspYJuCmx7ThPZhyNaPu
         PpNDgzBbY0qGjQohu1bTNSwB90F1Bg/jp0WGIuOPXch/joPJYuGRP/IgXNu6GZoB3NgZ
         IFXuHOl2RqiBiFiPM7Wc7tPFXEMkBmvdiCn+FmB8KXnMe5/9jHXnh19NqyYjGuwKuthi
         EhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437766; x=1761042566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNwslOTb5JOWqs8U+YdiNL7KIGdnAR5sXRre+K3C3ks=;
        b=WQQDbWnj1TOimkt8HDFIaJWwBOSX/g4Py3wqS9iBzIpIQFnuBuL+JDiNYpkI95cB8E
         mF7wMibt8GZz2lRIE1ogERjbJn96UBMvVU6eMX/gxRdO4JlwvOBGxUZ+BLl4tWS7x7KM
         NFWs9vuk43ihDOhZv8wvABMqeFgBXkOR2KEtUtiJ8frlU8svEeBRwXVlivBcJBnjQ2Lj
         +uWwd/uo1w0dlwMHdSLCxB8HKvSDtmwOWpwEjMreV8+XKQNLz+BZYPyVdOl7/Hb/FBHE
         lBCQLl72GWCiNOLKKV54Bczq6dv/lnMV8MMJRiCgctLqUrKjBswJ9v2Il2K2fvtxLLCV
         WA1A==
X-Forwarded-Encrypted: i=1; AJvYcCVp8bPx9hIQMPyehx+DACEdc549t4MyhqZNRvnU7pMtwI3obkOKBYdPjHJ/xT+eVs6W+7CL7GQ/CxFUYJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzqY8NB55yPi0AqXooNdMdkAEtpSX6JklPXBhhYVUNItFOYDv
	fa2EF9sljA428Oqy7yxctDOmVOEaZi5wd1UEXO9WTLGpa7GcBn53STNnjEjnul7bNW8Seb2H8LE
	ETmQki0d+LGAumE9cZGXMYffMyQ6bJByVrnW4DLt/Fg==
X-Gm-Gg: ASbGncskJJWC1ILWcaq+BCgINosXqzHALFjcsklvV1ZT1xyK0yIhOnw4T3dzcf1eDvu
	wgPPDIad9lDAg3NL83ZNaGwNyMBDAvoKYVcDaIwY9yU6hwWv9CGaXsPyosatGCNqtn1lZ7terju
	15kKy+8u84M49jo283hx14zz2MD5X1IJbsYsC/fVBk0sQVfrWaJsXDk89Aoh+HkLmJFxjJGybbc
	HrLbmCbuoJ2kDX8aFnnvAZYAS11sAQWkuZFTIOX
X-Google-Smtp-Source: AGHT+IFDFh6iWuOmPmvWilDaFBE5YfW3xBkJ2+8+m1/8Q1QTZSI3MhsChmCnpdF1r4INYGcDiNPz/lr8Vbf/DOouGeY=
X-Received: by 2002:a53:ce8c:0:b0:636:19c8:278e with SMTP id
 956f58d0204a3-63ccb84414bmr14226319d50.14.1760437765773; Tue, 14 Oct 2025
 03:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <19d537f9920cae5fa849b649e5bc42ba0b8e52f8.1759824376.git.mazziesaccount@gmail.com>
 <CACRpkdbHBQQnnTUrUzOrYxzQKCzDyy8aNK7w8OEFz-ic8ic1FQ@mail.gmail.com> <f2e6f0eb-b412-4cf6-8615-d669b8066393@gmail.com>
In-Reply-To: <f2e6f0eb-b412-4cf6-8615-d669b8066393@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 12:29:10 +0200
X-Gm-Features: AS18NWDIhtpPAtiexOECYnDlN0ABGxByFw8_QgkDjMMcng7GLnSDiPGnwdY3LaY
Message-ID: <CACRpkdb-Oz4RXWjLEH2ffKhe3jRxVTSN1u5g=tTTfQHpXW1=8w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] dt-bindings: power: supply: BD72720 managed battery
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:00=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> >> +  rohm,volt-drop-very-low-temp-microvolt:
> >> +    description: VDR table for very low temperature
> >
> > Doesn't the four last properties require to be defined as uint32-array?
>
> I have been under impression that the "-microvolt" ending suffices, but
> I may be wrong. At last the 'make dt_binding_check' didn't give me a shou=
t.

Ah you're right, I tend to forget about all the magic Rob has put into
dtsschema.

> >> +        rohm,voltage-vdr-thresh-microvolt =3D <4150000>;
> >
> > This property seems to be missing from the bindings?
>
> I think it is the first binding in the file :)

Ugh I missed it.

Yours,
Linus Walleij

