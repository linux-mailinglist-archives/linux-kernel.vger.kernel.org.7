Return-Path: <linux-kernel+bounces-855762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB50BE23A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645219C0427
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4030BB8B;
	Thu, 16 Oct 2025 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kmRWLsEb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EA30B50B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604651; cv=none; b=nXF/fyU/Gw1qZrMXmQXXFubVVwg2S9yFLXkJinidqzByKRXvrIwDxXUlzcyVYTOYGft3H/aWC1AhOzpKnXcMVETdAJT5Joj+ZPRuUk5ki3xnwADY3jxdPcbwDTQ/qiWDO/bSlfimt++ZyUHNjvjoxqTSpDhoS/VezHdkddJuXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604651; c=relaxed/simple;
	bh=5/XS3JraEjxk1JfmUJdTZhej2bh1Sw1yywUdb9kgz+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrBXeNBJXQCmFXhfqEED9V3gHDnKPqUZxJ+XiseUmb8KmjTKdxLxQbIFT3rI1sNHEkEoAeh7CuhWHzYiQFFBS0w3l/FS3bW10uvbajzVFJ45zP/cqWnT8afmxrEM0/yorE4txa7iaGBNLX9JjXVAzrhqVMnQEwEZjsWK7XLjRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kmRWLsEb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b00a9989633so90872566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760604647; x=1761209447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPGh/INSa2zSUyaHqMg9VH3NffLUw7enDRxb7tS1TjQ=;
        b=kmRWLsEb66JdBRTvhWEaSVOf8uv8SVUmZNFoyq7K2ysaQhdkzIjuqdLYrnNraueLZ0
         sswo48kmXbYk3X6VraNcvZQOsDZpniFdkuwwZfZ18e8AwmgSziTJ5U1GkL/yKsKHWPQz
         l4aqRNFxCRAVt13UOXUPb8OesJO18nAvUQcdESwwT3m1F2LbQksVLId+VFLW7Exhc6fQ
         ej7W/Nuig1HZl2ieRYZb+GyWpZ26U0iO6IqGv4KBYW4YfaL5lNYrU5Q+t2ZsNmZBLcSZ
         tThq7BtMRu2flW4Y7lBgQDqxboNNn6aM6b8iMlLHhFqmuyJzP7k5Jsn/J3g7oeLQkOP6
         bgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604647; x=1761209447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPGh/INSa2zSUyaHqMg9VH3NffLUw7enDRxb7tS1TjQ=;
        b=hlK4lY0KgtnwdbhQdenimV4uhUoqcf9JQC1O3gHu++C+Ib+ChnAo45qscfCqK4gcD3
         nbxl/KtcF7n33BgQqCuQU/nEGUnKABjBiK5H5+t6USA59zDZ+LHI7VzKmwcznrQtW1aP
         Jf8oUGJyBJfB5VQLkb2EZEyRZbZJL5yEPscM1QqeWGe5HkRgF+yMRhLOvNwYVDpjVxbS
         jknmJ53tj+zQzArdMxmkh8MNp+0eSfNPZ0r/CiYUbz1n1uO5oeuoBMsoYKOapvuH2LUa
         m0ewLoXPh/cnmuGIctJCTz4w1TNn7zodAI1JntHZFfYgtjeuSdsi/vNSBBRZs2tWNndV
         aQXg==
X-Forwarded-Encrypted: i=1; AJvYcCWm6Uaj6ePM6xelKb/deILtOs6K8qmiBfMqzrtSRiugQ20tLRwyjM6A9j4kwoibCnWSmYA9sp+vM7ANFO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmYwdT+GOe/Ngi5bzh+JP/1eu0Mdu2uuorS5cRCy6h3FX7MXy
	wpTZrbNe/Ye5JauDPiPMipVnCJtzgBqzbkq1nk70z8hsM93KgTctb1+SE+a9/LQggzPkp+dSqqU
	zMV8v
X-Gm-Gg: ASbGnctoYfq61EIKybWzpPPyo4dO32UDy3ZVkb/Y9ZB5mi7iI5BJ+3+yh6WUL1GzA0I
	a0HC7UADjkFdWTFwtJqGfl/3nxqfa3/8qKUgdxNWTP6SbfGKN80aQZpwIpvAfUG/OTDI+oornlK
	Xn3YW4lY1qo3b6DNAHtah7ltkaJvMxzVgG9KnqRjWkCRLG17GkHUQU4Rq2oSp1o1WP/fb//XPlX
	0uaxoLJ3PnorL+5FEyJhmBM43AWE7e6pTqT0K6KvDlVY7EcT1DL88g/cXs8F95xX5ZQS8N9ItmA
	dexl9PUY0dSvUrSaGUKYqr9NIqu1kPZImUqb6aepUC4b7QZEQvpRfzkEAwsVD+iXsfeNmQzCBBH
	CrX67WeYqCWcPYPrgausT8nL2uX+PS61XQTS2D3j0WxqySIrTFUvQVLH2UAW1Xgp6OhSc1OZsKU
	j9U2AQh7XHKhTpf3V6fsPUS8m7t7K08NgoEPb75rKZUmb/Odn6/oA9
X-Google-Smtp-Source: AGHT+IGs/Ex7rQ3pCPhtdm0KlwKe9GFuI3YTsI4ki3K0pfy1MU+O9okm6dWvBIHwMxGo4ooAzD+LEw==
X-Received: by 2002:a17:907:7a86:b0:b3f:f6d:1d9e with SMTP id a640c23a62f3a-b6051dc383cmr402374666b.6.1760604647221;
        Thu, 16 Oct 2025 01:50:47 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b5cccda99adsm457507666b.41.2025.10.16.01.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:50:46 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:50:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: ulf.hansson@linaro.org, chenhuacai@kernel.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, skhan@linuxfoundation.org, 
	zhoubinbin@loongson.cn, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
Message-ID: <o55ujlbvxwezsf3ogqx33pcbg5b2lviy6bv5ufnz6t7yi4v23t@i6uiafh6no6c>
References: <20251014184657.111144-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zooc3ooxgc2c7fb"
Content-Disposition: inline
In-Reply-To: <20251014184657.111144-1-rakuram.e96@gmail.com>


--6zooc3ooxgc2c7fb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
MIME-Version: 1.0

On Wed, Oct 15, 2025 at 12:16:57AM +0530, Rakuram Eswaran wrote:
> This patch refactors pxamci_probe() to use devm-managed resource
> allocation (e.g. devm_dma_request_chan()) and dev_err_probe() for
> improved readability and automatic cleanup on probe failure.
>=20
> This eliminates redundant NULL assignments and manual release logic.
>=20
> This issue was originally reported by Smatch:
> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_E=
RR'
>=20
> The warning occurred because a pointer was set to NULL before using
> PTR_ERR(), leading to PTR_ERR(0) and an incorrect 0 return value.
> This refactor eliminates that condition while improving overall
> error handling robustness.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
>=20
> Changes since v1:
> Following Uwe Kleine-K=C3=B6nig=E2=80=99s suggestion:
> - Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
>   channel allocation devm-managed and avoid manual release paths.
> - Used dev_err_probe() for improved error reporting and consistent
>   probe failure handling.
> - Removed redundant NULL assignments and obsolete goto-based cleanup logi=
c.
> - Updated commit message to better describe the intent of the change.
>=20
> Testing note:
> I do not have access to appropriate hardware for runtime testing.=20
> Any help verifying on actual hardware would be appreciated.
>=20
> Build and Analysis:
> This patch was compiled against the configuration file reported by
> 0day CI in the above link (config: s390-randconfig-r071-20251004) using
> `s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`.=20
>=20
> Static analysis was performed with Smatch to ensure the reported warning=
=20
> no longer reproduces after applying this fix.
>=20
> Command used for verification:
>   ARCH=3Ds390 CROSS_COMPILE=3Ds390x-linux-gnu- \
>   ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c
>=20
>  drivers/mmc/host/pxamci.c | 57 +++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..d03388f64934 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -652,11 +652,14 @@ static int pxamci_probe(struct platform_device *pde=
v)
>  	host->clkrt =3D CLKRT_OFF;
> =20
>  	host->clk =3D devm_clk_get(dev, NULL);
> -	if (IS_ERR(host->clk)) {
> -		host->clk =3D NULL;
> -		return PTR_ERR(host->clk);
> -	}
> +	if (IS_ERR(host->clk))
> +		return dev_err_probe(dev, PTR_ERR(host->clk),
> +				     "Failed to acquire clock\n");
> =20
> +	/*
> +	 * Note that the return value of clk_get_rate() is only valid
> +	 * if the clock is enabled.
> +	 */

The intention of this comment in my WIP suggestion was to point out
another thing to fix as the precondition for calling clk_get_rate()
isn't asserted. If you don't want to address this (which is fine),
drop the comment (or improve my wording to make it more obvious that
there is something to fix).

>  	host->clkrate =3D clk_get_rate(host->clk);
> =20
>  	/*
> [...]
> @@ -759,16 +752,8 @@ static int pxamci_probe(struct platform_device *pdev)
>  	if (ret) {
>  		if (host->pdata && host->pdata->exit)
>  			host->pdata->exit(dev, mmc);
> -		goto out;
>  	}
> =20
> -	return 0;
> -
> -out:
> -	if (host->dma_chan_rx)
> -		dma_release_channel(host->dma_chan_rx);
> -	if (host->dma_chan_tx)
> -		dma_release_channel(host->dma_chan_tx);

I was lazy in my prototype patch and didn't drop the calls to
dma_release_channel() in pxamci_remove(). For a proper patch this is
required though.

To continue the quest: Now that I looked at pxamci_remove(): `mmc` is
always non-NULL, so the respective check can be dropped.


--6zooc3ooxgc2c7fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjwseAACgkQj4D7WH0S
/k6mDwgAsXfmGQvI3EWoF/Xf7HICwAuzocExje3sDIKYBM2h6ePeiozPAL4KW/36
K33TIV+nzcHI2enredvl0hZ45mlc54A0qsINU0PCI06DBSz2ACIPjSvv2iHs3gwL
jTcCuAtQzXWHqYXDN1Gb1x92B/s+sOL3gJkGQMfDQUv6JQDUlM1Ip4yrH/XyNy/F
6VbqxHDWPxjYroGphTanRSJNz3YvtmSRaerx6KzDweCMMI3kDj0xdAMxNS8twViP
PQHwsyW9znXNi/Old+xa0EoTawa0s9xAYsDtWu57LutautBHOLM7qz5+B8CeY0Vf
cxANyYd/x8WF5++m59blZxAtM02bGg==
=Yph/
-----END PGP SIGNATURE-----

--6zooc3ooxgc2c7fb--

