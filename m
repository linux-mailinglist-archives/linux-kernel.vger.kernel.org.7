Return-Path: <linux-kernel+bounces-750853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34056B161DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34325565DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF72D8DB5;
	Wed, 30 Jul 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CL1axfhY"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C1C8F0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883565; cv=none; b=tVLvrIj8UxWMQF9EGM/nlx0oAxh1Q5JU7Pc4YkgqxXD5THnSYcmtRX/LOw94XTdfLTSZvIu+6u0IqhBGL5Ih7Bm4vYLNtPWe1m7V2gqeedEZnEoUDXsKdCXd4sTWA2j8u4XGRnAz8gQ94w+/rrk05FVcEWp7fM7TCHgYEucixOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883565; c=relaxed/simple;
	bh=n+/Al/hya7iKccfkk2/acBwTs2umvyAH+cTmAiASgng=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lvUYyaBhBXUWpzLf9rTVac33rMBk1GTpWwFQEJ5vN9KAqFDyjPXU9S/FUg5q4IYpEWjNAlQ64IM9KPkPOzbS8Iw3Y6NOkdk93OdEckbycR4Sex0P8c1AhQW3PpLKb1RGDx1MR3T9ULsdYkQkRRaFEN8cjGl702EirBFIifmdcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CL1axfhY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso4237282a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753883562; x=1754488362; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rp5BOhOSI3hJlfQlyw0n/QrQz57EFsvEJK12JX37JM=;
        b=CL1axfhYUp1p32DMTs16tlR8K9euMFnYh3Lyy0ktI66sxaftJLwnl4StwvpuK+dmB6
         qj9me9NS/KdvKxvB6LjiDEo0OVy3iAem4nVF7i71v1pYm1iQaXggYrdcqWyeXoqLeUwA
         dPWbrG7qTFssU1wA91c9oQ0ptr1DtaUk9nq6/DpNctscUhmdv7PUTFK+IDyI+hrBLujk
         Cl4kxoxwrDk9tDCB48xUmX7JwG7TWCV0wUiiBidlP2uwhjgUL0IGrEWOnKDVZcHI0eAD
         LhyB7CmIvxBPXuqisPYV+aue1/IFw38mEoEnrjyvq1P3pe/5UApI3JKssgEn9ez+fsGN
         APPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883562; x=1754488362;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rp5BOhOSI3hJlfQlyw0n/QrQz57EFsvEJK12JX37JM=;
        b=Y2kVCs0IyyqIRuuChHqUoaIlY7RrHMI1qbfYHjPdal0bD+GuPV1/fwXuG8PEPdUV8q
         VoP8eYPKNajS6isVqvO2nC5MiBPmf7rijbz6zFfZNb4IFgxt+pXAdeQEka19ZJFvUoEH
         1O73b3zGaoD2QvZR3//geF0n60emJm5EixUe8d/cTY73EhHRdv2EqHepcQBw0KusL8lB
         RkSkKl9e2iMQEIbjsGLu4O5ObaaJtD8Nr6nzJtsZ4w5+doYS5t4tJynk8S3Y30JB2sIz
         KcrwVZM9nflqhpvCUFcYNQTlpvNy4Qofko+DXnTvV3vYDq1JrKjA3IZ/O8sHyf8QjVY4
         +LgA==
X-Forwarded-Encrypted: i=1; AJvYcCWqjz9s15C52CwKkt0JCXnU7mFKaoECQSBH0WI50a5/RR4mpvres/MMzsjEHoAU8tq0vnAw+a7YqIbKD64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1mMdHDorJsJeaVMHGZtI1d4CH0aJk+BD5oiHka3Q1aYVsKx1
	ndlentfUfjV/oZxEyny/vattBbkYmlPFEfiRaDYM/2SjodbHHHP6TpKsGUTufzxP0EU=
X-Gm-Gg: ASbGncs2ga0M99m53VGbZUxgdATlbtv3suESeFf5KNZur1A0C96IJ7E2hHv6i9UD9pV
	HJ0/YiHOA6wgPRDZhWqDC3/L9iGWKjlQZSsISNQRRKB10kIck07IJGxEVs0nSrmTiWzW5+2gjbB
	rolyEFEUzHnh6RCO4lb/Oa3C8evkG1t+sb+FHSBrHmckho74yZi7i2ttW1/cI0PX3bhbVAq0zcd
	IoBciLwcuUbyL1wVhJTSG2ozY1kwBMG2sibX7vZDkRISXBt8+pyJHLC3JKSEWwJx8N0ZF5wyTC3
	WUeIq6acWQCCRWOabkB6C9mADQqrNLp9CtACMi340U2HeEXeskQ+Y0r3Ix3LA5o0/oKXCMi8GP2
	3XMZEONZwEzqvikr27tzuQZLyLTw=
X-Google-Smtp-Source: AGHT+IHmHFD7kf9axGR7OqSKqgBDA0mgn8z8jZ8b9IsKFZAES+c1F4OBGbCYGQRGpeMsepIGLtvF1g==
X-Received: by 2002:a05:6402:40c5:b0:615:9b3c:5918 with SMTP id 4fb4d7f45d1cf-6159b3c5954mr1538590a12.1.1753883562203;
        Wed, 30 Jul 2025 06:52:42 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:a15:2832:36af:7a70])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6158ab9d0dbsm1108310a12.60.2025.07.30.06.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=166989f9f9a66e3cb36fa7f8ad6c45ebf369d74034ef3f270c152a3ef9d3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 30 Jul 2025 15:52:33 +0200
Message-Id: <DBPFTXDNMIS5.1RCL30X7VN5MG@baylibre.com>
To: "Michael Walle" <mwalle@kernel.org>, "Jon Cormier"
 <jcormier@criticallink.com>, "Jerome Neanne" <jneanne@baylibre.com>
Cc: "Job Sava" <jsava@criticallink.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Lee Jones" <lee@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Julien Panis" <jpanis@baylibre.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-input@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mfd: Add power-button option for TI
 TPS6594 PMIC
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.20.1
References: <20250520-linux-stable-tps6594-pwrbutton-v1-0-0cc5c6e0415c@criticallink.com> <20250520-linux-stable-tps6594-pwrbutton-v1-1-0cc5c6e0415c@criticallink.com> <20250521-wandering-tested-porpoise-acbef7@kuoka> <CAKMwjwTP=xSsX3UuK02sKbXWaU7y-ErytNYCL_P0UveDytQW2A@mail.gmail.com> <20250529-wise-tremendous-stork-a7d091@kuoka> <CAKMwjwQOBE651A-5VVjwcv5TspO2eNZfgwWzMpTTWxhR3nGKUw@mail.gmail.com> <0fb4b411-1b27-43fc-8d48-e5220fc85478@kernel.org> <CAKMwjwSZEhXav2U-bd+JNyVDK3JdJoN1kJjnxpfKXBKsW2XxdQ@mail.gmail.com> <DBEDT0OKPYAC.EX6HDQCKUWIS@walle.cc> <CADL8D3bpVVrswNUvS5nSeQYuZbyPOfMoMFG_JrPSFb9YkNEKdg@mail.gmail.com> <DBHJ1S8MTSA2.35ZZDZFQGFNB1@kernel.org>
In-Reply-To: <DBHJ1S8MTSA2.35ZZDZFQGFNB1@kernel.org>

--166989f9f9a66e3cb36fa7f8ad6c45ebf369d74034ef3f270c152a3ef9d3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

I think my mail wasn't sent properly, so here we go again:

On Mon Jul 21, 2025 at 8:42 AM CEST, Michael Walle wrote:
> [+ Jerome and Markus ]
>
> Hi,
>
>> > > > Someone knowing the device should come with arguments whether
>> > > > other states for this are useful at all. Or not useful and then ar=
gument
>> > > > that in commit msg for example.
>> > > The other states are not useful for the kernel. Only the push button
>> > > has a need for an interrupt handler. The other states the PMIC handl=
es
>> > > on its own.
>> > >
>> > > What exactly do you want me to change?
>> >
>> > Because the driver isn't setting the configuration anyway, wouldn't
>> > it be possible to read the config bits (Register 0x3c, bits 7-6) to
>> > figure out whether the pin is configured as power-button instead of
>> > having this property?
>> >
>> > I mean, the correct config is likely stored in the NVM anyway, and
>> > reconfiguring it to another value seems unlikely.
>> Currently, the TPS MFD driver only loads the power button driver if
>> the flag is set.  We could put that discovery code in the MFD driver,
>> but what if the system designer doesn't want the power button driver?
>
> The device tree is not for configuration. The designer can just
> ignore the input event in that case.
>
>> I'm not sure auto detecting it makes sense.
>
> Why?
>
>> We are basing this on the other TI PMIC drivers and how they are
>> configured. I'm not sure I want to reinvent the wheel, so to speak.
>
> That was never a good reason. Maybe there was a reason for the
> TPS65219. Markus? Jerome? I haven't found anything in the commit
> messages or cover letters. Only that it is "optional". Not sure what
> that means. According to the TPS65219 datasheet, that pin if not
> used shall be configured as EN and be connected to VSYS.

I don't think the TPS65219 has a config register to detect if the pin is
a power-button that's why a devicetree description was necessary.
Looking at it now, it should probably have been an enum for TPS65219. It
is not relevant to any software but it is not describing the
configuration fully.

Best
Markus

--166989f9f9a66e3cb36fa7f8ad6c45ebf369d74034ef3f270c152a3ef9d3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaIojoREcbXNwQGJheWxp
YnJlLmNvbQAKCRCFwVZpkBVKUwQ+AQCCSckOjQFmKhWjtgebU+FH8Kv6EqNOhk12
kbOkJ/ZVqwEA3K1IyehD1qEqHEZwyCvmd2D9lIEd1pazKofQxtaTygo=
=YrKw
-----END PGP SIGNATURE-----

--166989f9f9a66e3cb36fa7f8ad6c45ebf369d74034ef3f270c152a3ef9d3--

