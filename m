Return-Path: <linux-kernel+bounces-892432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17353C45156
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB0D34E7DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8B217705;
	Mon, 10 Nov 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5K2ISc6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789A216E32
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756259; cv=none; b=l6tzTczoLU4qXJhWItRZYvlrJ2XYkZv664K38B3yh6+kp/h9LrE/WfsTnvnxT2qh/cz8FUGZ2bGO7ycCvOCTIstjjG35BJCJ5UO1xamtBEW41iV4n8VDqVXneSLALW/IikcAuTf7naZmBo1Vgj6A/HOL+hZPD1KUcJR5Pk0Okus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756259; c=relaxed/simple;
	bh=gz2Tc2+ZpOYG2OzBbxLbgilswkkGbcUQjbej9kT3ykY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxhubVL/rkP7C6hR455h3hQ8d41LRA80KGxsy9wUVZn1B0G6JLAtLh3R64M1NrkFjtBWqCpvX4h5Vv60wDFVNwBHtOYd4nccx4oFTrYywN4BkP8mxQ6mKF5tWKB6QwrDJzfmOh2iKdi2ptiG0bkL5730t3yThqQBidUoYDCLuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5K2ISc6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so7812945e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762756256; x=1763361056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gz2Tc2+ZpOYG2OzBbxLbgilswkkGbcUQjbej9kT3ykY=;
        b=o5K2ISc6bhNVXY8bIHTQ4KKcAedMfYbNe98yDermdBMwnpULRRTdKPKZ3Zvut28qJR
         cmwK2eUxwEOxqO5EkuHQD/7u7OnUAKrhopL2L3XSi6NEbUN1+C2dL4jn/gewrnZ9mXzE
         2y+BsrEIQxSTyOcPON2cc5Uol1PsFSuDLAnBKm/NaipaFdHG6v6vjL+tO1cCnFb0/XAY
         01NGw6434F0cvFxzmB3Y/2nbw392X8uIUo7aaelS0hPTc2ZTZV7JWHz6gDypHZxnii0z
         S2jnPJ+/h7LdB5vdqWS6uj7/mU1ba1hNDmCGgANENjkgbhEu5PPW252M96TViTBBtiqi
         bP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762756256; x=1763361056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz2Tc2+ZpOYG2OzBbxLbgilswkkGbcUQjbej9kT3ykY=;
        b=uVT7I/t5GxSzBRgg5B7odRQ7lW5IzxOa0aMkePOm5RrFuNKQFDZSMrzAD7hCYSc355
         Lqj0Y64NHXos75C4Ntg3c8SkZ24WCnBazRpGTIO2C/b5NFkW9iW22dOJoKk5K5WcboWy
         /afnQUWxSzBmkmwbMtt4CM1Huc37szMxCeKMtg6NDGGhriaDAy1x1Jv3SogvOxeFcpaB
         7H0wv2Fp/yyi9I+RUETsx1oLVETg7L6on6B71r2Oc5z6hhD7IEcnf5tL2R46/oKZrsFz
         eaVejk+x6gF4gDYzNPHJoWsawpMIEiem24RmzVldgI2zZ5G8ptC320D4gN72lPnFwGqX
         09gg==
X-Forwarded-Encrypted: i=1; AJvYcCUc2TzRuTmEll9C2Q4XEYB0sbwp5o/NETlsWBUQSlcKz4hAg/9pcpRBxisMnZdWHECqPCNfjMdIB+Zv8N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKpKFMUxPhnLeV6kyys3S0jVu6SpUUnF0J/TrPQi1LJrO27Dt
	0wqHFmt5Ye2BYWfzYIIUi98Vun5MQjFFEBXtdSpWyADi+BBcheDKylaPYjmfQipW8sE=
X-Gm-Gg: ASbGncvrFSFWXknq04cHSFZMwWJQi2QpwJ9NyzVWTaVMUvyNjEchfQlGHByZ7PBFRaG
	tMSFa0KngtGS/QBCwsBHBadszKwltjh1VNel1PzzB1c08lAErS6tCpV8NwsXH85N+kom3FCwqJr
	e/Gn1Lfi4wivHc5Y/JQujiDHTu1bHPTTF5GHC/FChA16jXNiVRzWe62FVC9PDiwKGGYPEVcqkyw
	01ZwgT/rthhwV0DDCgk8d8JJuabuwUvkMoSMQ97HkWC5CKLO+RveMVaVbMr2FbAKvsIsoG3u4T0
	gGG87FBQ/aYDTrM/kJ4T7+Sw9861AJ2vlaRO+ygCxOqf5ndmyO9llvo7LPEjbPArBz6HmF3QxJN
	A1RVEE91tHy9t/Djr57X70itYHAZ/UeHqlzbXVT+wfsY+R682aLerjAVQ1wvfMF1hMEfkSNQ5oO
	oEONfb8kk=
X-Google-Smtp-Source: AGHT+IEQw4YGmWYhhezCKKZpNUcmlZEpIju4sVG4oIvS3Njw1N4sMl3EeFVFvYxb/VKOCKvrHAj0Vg==
X-Received: by 2002:a05:600c:c84:b0:477:598c:6e1d with SMTP id 5b1f17b1804b1-4777325ab5emr48703165e9.17.1762756255657;
        Sun, 09 Nov 2025 22:30:55 -0800 (PST)
Received: from draszik.lan ([212.129.86.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776419d869sm106249085e9.3.2025.11.09.22.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:30:55 -0800 (PST)
Message-ID: <776ac9f7ec2858a89c03b735653070f2749b986d.camel@linaro.org>
Subject: Re: [PATCH v3 04/20] regulator: dt-bindings: add s2mpg11-pmic
 regulators
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,  Lee Jones <lee@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, 	kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-gpio@vger.kernel.org
Date: Mon, 10 Nov 2025 06:30:47 +0000
In-Reply-To: <7d9fa7ab-8484-4d41-bc3b-be2eff3b6e95@kernel.org>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
	 <20251103-s2mpg1x-regulators-v3-4-b8b96b79e058@linaro.org>
	 <20251104-zircon-lobster-of-agility-cbcbb0@kuoka>
	 <46b008c946e36ea0b317691356ff874c4a78882d.camel@linaro.org>
	 <7d9fa7ab-8484-4d41-bc3b-be2eff3b6e95@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-09 at 20:00 +0100, Krzysztof Kozlowski wrote:
> On 07/11/2025 12:14, Andr=C3=A9 Draszik wrote:
> > On Tue, 2025-11-04 at 10:39 +0100, Krzysztof Kozlowski wrote:
> > > On Mon, Nov 03, 2025 at 07:14:43PM +0000, Andr=C3=A9 Draszik wrote:
> > > > +=C2=A0 The S2MPG11 PMIC provides 12 buck, 1 buck-boost, and 15 LDO=
 regulators.
> > > > +
> > > > +=C2=A0 See also Documentation/devicetree/bindings/mfd/samsung,s2mp=
s11.yaml for
> > > > +=C2=A0 additional information and example.
> > > > +
> > > > +definitions:
> > >=20
> > > defs:
> >=20
> > All existing bindings are using definitions, not defs. Shouldn't this s=
tay
> > consistent?
>=20
> Huh? git grep gives me 3 cases, so how is it "all existing"?
>=20
> But for defs it gives me ~98!=09

Didn't know it's ^$defs:, not ^defs: - thanks Krzysztof.

Cheers,
Andre'

