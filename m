Return-Path: <linux-kernel+bounces-865841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB4BFE250
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C934E7FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15EC2FA0F3;
	Wed, 22 Oct 2025 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="IzQHUWcx"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756F26F46C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164477; cv=none; b=lnfQ+wzmrcSLdBVni8tdl9uwoNdKPOWDli17jorSUa+GFsJyyqI8ZPJV/DtxGOa3tTQTeUiY8cPKz3su80N3IxcLhrjJRgMqmi7VGeqgduNtAA4Mhf2ZQ/XTMPA5MVqjRb/184R+JJcDQjPoP7OJjKUJ/dFXJiEPdC18DzXkRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164477; c=relaxed/simple;
	bh=8jcUFCa6WkdWMPIKIvDk0frR/KjqcYNQy6lmd0MxBbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJIsraXkW+EpTk7DrIMkdG1jttn+scPNU1Gr5x9sYL8SwUx6dBFOjlLhkUf4aMyZ9+g0RWbSzAEWR+LybTfZypiV150Alsi+pV3p3fiYbONg2UjSwWwatdhA2Zmm2rqBWel91xLJdLxVzyoT73PoKLwSi3Ui7wAZ74u/WHOJ/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=IzQHUWcx; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [192.168.47.19] (unknown [91.183.56.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 8800468B9C0;
	Wed, 22 Oct 2025 22:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761164473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jcUFCa6WkdWMPIKIvDk0frR/KjqcYNQy6lmd0MxBbA=;
	b=IzQHUWcxaz9Xo4WcPi8Luatks6+AkI8Up1+QsgbiBOaUPKAu9l82u9MZcgl8YTDrushZHs
	CMgyTKRbUEJMo8HPbzlkWzIlResiGAgcQnRKpeSWTOAVMKeUH12m1atQEKMlR6kbctLnsK
	+0667I8i+wtaiH/WerwlUg4ZS/4v+1y9My/uZUzv2PGt5rrbkxh/ceAwmOM7NViiyXVxxr
	P2F0pmnUKWLEYOxvtS9iBOhBrrMuZb9oWMc5fkq1soGFngpADgnF2XrOSYMc/oKU4Uq8y3
	iCcWwKiUIu+dJ3LPBleIdykUoaYUtijjUhXc/Cmym0UMbbq4c7oV1Ear+mj9kA==
Message-ID: <9742ddcaa921caa5e3ea70adcdfbe34f0a52c1cd.camel@svanheule.net>
Subject: Re: [PATCH v3] regmap: add cache validity to REGCACHE_FLAT
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>, linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 22:21:12 +0200
In-Reply-To: <26abcd6d-ae3a-4ef8-890a-9b209c3c8e03@sirena.org.uk>
References: <20250109180256.6269-1-sander@svanheule.net>
	 <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
	 <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
	 <ca528e3e-39f1-41cc-9f46-ad787af48a77@sirena.org.uk>
	 <187bc058ff944dbde0e876efa6e72046bcc2a124.camel@svanheule.net>
	 <143f0597-7cfa-4b16-ada9-72922f566284@sirena.org.uk>
	 <baaa378164ae45c43a521eca467b49e0eda38818.camel@svanheule.net>
	 <26abcd6d-ae3a-4ef8-890a-9b209c3c8e03@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mark,

On Fri, 2025-10-17 at 14:56 +0100, Mark Brown wrote:
> On Thu, Oct 16, 2025 at 10:49:40PM +0200, Sander Vanheule wrote:
> > Some quick grepping turned up 35 drivers which use REGCACHE_FLAT withou=
t any
> > cache initialization (see below), thus defaulting to the all-zero cache=
. This
> > includes the driver I think you found issues with on the pine64: sun8i-=
codec.c
> > If this driver (accidentally) relies on the zero-initialization, I woul=
d expect
> > the spurious interrupts to also pop up when switching to a maple cache,=
 or when
> > using the num_reg_defaults_raw workaround.
>=20
> Yes, that driver is relying on the current behaviour - I'd expect at
> least some of the other drivers are too.=C2=A0=20
>=20
> There's two separate things here, there's what the driver you're working
> on should do (which is to use a maple tree cache from the sounds of it)
> and there's potential improvements to the flat cache, or adding a new
> sparse flat cache.

For my driver I went with a maple cache, as that's the one I can get functi=
onal.

Meanwhile, I also noticed others on the linux-gpio list being unaware of th=
e pitfalls of
the flat cache [1]. So I decided to send a v4 [2] of this patch, albeit spl=
it up in a new
flat-sparse variant and a warning for the current flat cache. Even with cle=
arer
documentation on the limitations of the flat cache, devs/reviewers/maintain=
ers would need
to be aware. I feel like it's better to just have less surprises.

[1] https://lore.kernel.org/linux-gpio/e461ca08-ad28-44fe-85f1-afe332c1d43d=
@topic.nl/
[2] https://lore.kernel.org/lkml/20251022200408.63027-1-sander@svanheule.ne=
t/T/

Best,
Sander

