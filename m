Return-Path: <linux-kernel+bounces-683519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02CAD6E76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D5F179765
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C423BCED;
	Thu, 12 Jun 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6nN+AaH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BC238172
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725961; cv=none; b=bCI8MQdhHS8dn+Yhrbhn7lQOP/j4a9hovLBEwRVjXzczkk2/HYdRFljIjna65p0yetfGME41o5wTsIlawDmThX+ZftDiDUTAQYuDb4AYL/k7RUGUrH1Cwax055otZvJNz4ddP6IXPytb20aujh+LK6AZhML/HpyecDnRvawA7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725961; c=relaxed/simple;
	bh=WWPYYggyKVUIqcpZRwtY3ch16mcUxM6fvmZKKpyOsWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNDXYPWOiVWoBXHmIPMOX2N/JtyajbZrfvZlkLmgcCSFtHXW1RvzjRzr1ktBCQVlwe6wzd97xr6sSiT2gf7M7WsD1NQawXJk8siZrxsXlMklhqvpDgPf7r1eBPpFtQnsCki+258HjEOWe7ObBqO01MjElgM29kW7moow/P2wj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r6nN+AaH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso544601f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749725957; x=1750330757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OxVFpXC9gE/NnptI7yasZSeAwdsDwjZxI1xtlSOfvvA=;
        b=r6nN+AaH1FFt9eiD/oBB6xuxgOlHpttnmzJhBx3WCbi/KaDm+x7tLBZyac03mSdqFT
         n75/2p6JKdJjfULVxmhhVzlSK1CoWfbvx5ZN94xlE/oCvExe7Mpg/3DrCfHFBg38SpHw
         AZbxEyi81sDmbs6yXTlIWc7Hcf82sdtAv/myAQnpqMUwIZOHCL9FCLTX/CZYOXeeTojw
         ckQjb0s/Su47ljH+lKQ7oMYRtYI17ATM1q1zIqJjW2rNLvK6w0QCOxZ6WTYaUmTyURZo
         6P96e6qJ076z6uZXdapfKqBNGdoQxxjyN9Uwfwu3kSwDbprln1I3fE14n8rVDFcPp6iL
         4A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749725957; x=1750330757;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxVFpXC9gE/NnptI7yasZSeAwdsDwjZxI1xtlSOfvvA=;
        b=cQfYEzzH7wM/2knD/bl6ZDp9gAppBtN3+2tfnoJRsX2U7iapZXEPzQ5OPgL3xIxYga
         IWlKdAzme4kI6/Qhiis+ScPWyxOibHeHnRYXR2slgyh66F801gZygmCAYyek5V9ukemw
         geOx8HEAd/DVueOjLFpU0kXFpaYXrsJs2wpE2e1ZHNW3F3zQeWoZ2K6y+rHO8Nmne+wl
         e6Jtd8QLqi1YT8mycAEybNFmxvYt5kue0/vvS6k+H13bo0Bp8ZsQ9pRA4rvOPfqpbz10
         IjHML5FbgoHwrYcptMVlvep8sqCGp1XOT87r/5xb7jTBLlUuUx7HZgHrEdyVE6sNQtlL
         kbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCapWHX0GHCe0F23qAiBHs7bxs/Ip4hDGlt79Hmh3CiLzs1IIAGCAsLx9Z8GtlDROu0rK7l2KMT0tTdAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ls3kNUL87lqejDAhqUKqqgGmnfbTPxUWaGEftUtKzJ0eqKU6
	ac+yObft3YWVKI7ac3agZcGAwfI7Hk7mu/y6WsaoT7k2iTehFYKsUVaVIVyAzw5M56k=
X-Gm-Gg: ASbGncv3awKQNalYTMeoUksUh+aE/gMITvd1C1uFoJnOpm2tb6eOfdadRTTzrfY+xSH
	/iWU+5uqPmIrLgwMH2VZ1zSKK1ZMTkt9s/3PJS36o4wxLXR3NGn0QvAK7WZdnHPwCnAKR/Ddm6H
	gQWxW40ziWXvoFQUvLntgPRze7LvfzC+QmI7BQcgo8iWLgi2c1MLk/rjV03xIgstn/Wl11jDI+P
	YGKh177dvGp3TMXrlHy0khyeotQNylFUlcCQ4k3+FSkz7vTSuKRDRFHHMunjbJBwAb795SLSSiH
	pQVZ/xCw6R1M7PsFelQBYpnij+lHT3UJm5x8g5PUHs3FBcVJLr6KIbjRSltLq+A2vg==
X-Google-Smtp-Source: AGHT+IHqd8/I6PcH/SsGO4ZHasePxLhvFKcF2xtJG5ImKC1vi9knPoEYRyrNOkQXYTNCKl3KYXGlKw==
X-Received: by 2002:a05:6000:4028:b0:3a5:1f2:68f3 with SMTP id ffacd0b85a97d-3a5586e9764mr5499812f8f.46.1749725956635;
        Thu, 12 Jun 2025 03:59:16 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561976a20sm1681124f8f.19.2025.06.12.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:59:16 -0700 (PDT)
Message-ID: <b090594cb2e61160a830b4cd73d7d8a529872130.camel@linaro.org>
Subject: Re: [PATCH v2 02/17] regulator: dt-bindings: add s2mpg10-pmic
 regulators
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Peter Griffin	
 <peter.griffin@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Date: Thu, 12 Jun 2025 11:59:14 +0100
In-Reply-To: <f5fcaac5-fa8e-41da-b1d2-e84197992e3c@sirena.org.uk>
References: <20250606-s2mpg1x-regulators-v2-0-b03feffd2621@linaro.org>
	 <20250606-s2mpg1x-regulators-v2-2-b03feffd2621@linaro.org>
	 <20250611-statuesque-dolphin-of-felicity-6fbf54@kuoka>
	 <f5fcaac5-fa8e-41da-b1d2-e84197992e3c@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mark,

On Wed, 2025-06-11 at 14:53 +0100, Mark Brown wrote:
> On Wed, Jun 11, 2025 at 10:55:44AM +0200, Krzysztof Kozlowski wrote:
> > On Fri, Jun 06, 2025 at 04:02:58PM GMT, Andr=C3=A9 Draszik wrote:
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For S2MPG10 l=
do20m, the following values are valid
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 0 # S2MPG10_PCTRLSEL_LDO20M_ON - always on
>=20
> > No, use standard regulator properties - regulator-always-on
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 1 # S2MPG10_PCTRLSEL_LDO20M_EN_SFR - VLDO20M_EN & LDO20M_SFR
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 2 # S2MPG10_PCTRLSEL_LDO20M_EN - VLDO20M_EN pin
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 3 # S2MPG10_PCTRLSEL_LDO20M_SFR - LDO20M_SFR in LDO_CTRL1 register
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 4 # S2MPG10_PCTRLSEL_LDO20M_OFF - disable
>=20
> > I don't think we allowed such property in the past. I don't get what is
> > here the actual signal - you described registers in multiple places, no=
t
> > signals. Few of these duplicate standard properties, so this looks like
> > exact copy of downstream which was doing exactly that way and that was
> > exactly never upstreamed.
>=20
> It looks like we can infer the configuration needed here from the
> existing properties,

For this ldo20, yes, and I'll update binding+driver to do so.

>  if a GPIO is provided then use value 2 otherwise
> use value 3.

Close :-) There is another register to say if this pctrlsel should be
respected in the first place. Therefore if a GPIO is provided, then use
value 2 for pctrlsel, otherwise the value doesn't matter, as pctrlsel
will be ignored anyway. But doesn't really matter in the context of this
discussion here, just for future reference :-)

Thanks for your review!

Thanks!
Andre'

