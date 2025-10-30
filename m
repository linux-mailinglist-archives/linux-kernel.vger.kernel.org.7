Return-Path: <linux-kernel+bounces-879082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89CC2234B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD09F189318C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F79B34D396;
	Thu, 30 Oct 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="JP0wlqwV"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031B34D389
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855504; cv=none; b=sYwwY66/BEv+Gpc+mRFMYrqJnvt35J88bAQ6JxaJzBn9GpgSFXVppxtj3IjzE2hF4OG44oRcvq8hfUOQUZz0ZWj96vWGf/h+rnKPtmYOyj3V18jWnBmSLv0uDcuPqWoF/RfCgN1/Dv1zvD15u8tGlBfZUlm8CtdhcpJ1lLMr+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855504; c=relaxed/simple;
	bh=vP1/XH3V9zLnC5XNJbufEeUOKzGorO8X/yWiNJGjcOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UO/dTPB+7bpFwQaR043SfMybJK+yhnlnwleLoCY5cjF/RIez8wuFL/HteWwJkSXBjFLmyjD9VtAxCDbETkzUboYmoNV9hO8gLmiIBeh8TqSIWnEXe0vxPl94VprfK7TaSfoOJGEB07+lbRzKoWDK9cs9fh6sMWpOxVNjCPgPUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=JP0wlqwV; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [IPv6:2a02:1812:110a:5400:17f3:a8ff:d314:780e] (2a02-1812-110a-5400-17f3-a8ff-d314-780e.ip6.access.telenet.be [IPv6:2a02:1812:110a:5400:17f3:a8ff:d314:780e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 7DA8F69191D;
	Thu, 30 Oct 2025 21:18:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761855493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65aeBmABHspFcuewFMYqe7wuqXF1ivGXvP+vdA10MlE=;
	b=JP0wlqwVV4jU0ZJ4D4t06+FhdkH94RHounLZ76hAqhcQ0sxFG6SJ2WJJHXcUQNhDa2Yjcu
	YQfvczVgaRTCBfh1Bh8JTxhxI6NqspzU+dm6HOUjJz67XOwztVkFP83Nz5OcaPbsfF6Y2p
	qD2cdulGzHW00vSGArWzHPYEtoDwIQSA4aKJ1xMS/KTk8imbcQz2bwouiXYgNLYjbmlvY7
	cEOjjrINrrzURbg0+puqOBDPc11D2kT17nRrdGLVCjW6I0h/vhiSO89GXosD1o/6t/Xarf
	T4Gp3FlFjKNJ/MUw0NVDZf9tXGFaA6jv8X4nu6f29Gwn493ImmbryQ1KeGdWPQ==
Message-ID: <39f251f542baf2148c9e75f94baf0b2188c38e95.camel@svanheule.net>
Subject: Re: [PATCH v2 3/5] regcache: flat: Remove unneeded check and error
 message for -ENOMEM
From: Sander Vanheule <sander@svanheule.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown
	 <broonie@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Date: Thu, 30 Oct 2025 21:18:11 +0100
In-Reply-To: <20251030173915.3886882-4-andriy.shevchenko@linux.intel.com>
References: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
	 <20251030173915.3886882-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andy,

On Thu, 2025-10-30 at 18:37 +0100, Andy Shevchenko wrote:
> There is a convention in the kernel to avoid error messages
> in the cases of -ENOMEM errors. Besides that, the idea behind
> using struct_size() and other macros from overflow.h is
> to saturate the size that the following allocation call will
> definitely fail, hence the check and the error messaging added
> in regcache_flat_init() are redundant. Remove them.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Makes sense, although I couldn't find the failure path myself in the code (=
it's probably
too deep down in the memory management code). But I see now there are unit =
tests that
check allocation failure for overflowed=C2=A0sizes.

FWIW

Acked-by: Sander Vanheule <sander@svanheule.net>

Best,
Sander

> =C2=A0drivers/base/regmap/regcache-flat.c | 10 +---------
> =C2=A01 file changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/re=
gcache-flat.c
> index 3b9235bb8313..bacb7137092f 100644
> --- a/drivers/base/regmap/regcache-flat.c
> +++ b/drivers/base/regmap/regcache-flat.c
> @@ -30,7 +30,6 @@ struct regcache_flat_data {
> =C2=A0static int regcache_flat_init(struct regmap *map)
> =C2=A0{
> =C2=A0	int i;
> -	size_t cache_data_size;
> =C2=A0	unsigned int cache_size;
> =C2=A0	struct regcache_flat_data *cache;
> =C2=A0
> @@ -38,14 +37,7 @@ static int regcache_flat_init(struct regmap *map)
> =C2=A0		return -EINVAL;
> =C2=A0
> =C2=A0	cache_size =3D regcache_flat_get_index(map, map->max_register) + 1=
;
> -	cache_data_size =3D struct_size(cache, data, cache_size);
> -
> -	if (cache_data_size =3D=3D SIZE_MAX) {
> -		dev_err(map->dev, "cannot allocate regmap cache");
> -		return -ENOMEM;
> -	}
> -
> -	cache =3D kzalloc(cache_data_size, map->alloc_flags);
> +	cache =3D kzalloc(struct_size(cache, data, cache_size), map->alloc_flag=
s);
> =C2=A0	if (!cache)
> =C2=A0		return -ENOMEM;
> =C2=A0

