Return-Path: <linux-kernel+bounces-846481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927BFBC81F6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0C23A6F60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2D2D29D6;
	Thu,  9 Oct 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="comC2TKL"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C366274B44
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999846; cv=none; b=prnH+O3BdAFcT2Q5Lpm8MlSYO3D4OTu+eD06URbMwzd7amHurr9AVQDSfRlFPJXUEGy3jsQKzluoyQF1FiaAppFzjRmmN6iBm9aCPxFD+Vf40zDar8L9lLKFzzgZElPMg+hVhT4qFWrXxt2sy5SUgrT3a8f/suofROAy9iWp6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999846; c=relaxed/simple;
	bh=mqcknWB6eCX2VYrA61jN3BkPJkr8rXkQ5glVIbwi/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbmcUbmd2eCtx1nXwyPFTMmeFoA2Kzt4emJmdP6S6T8wTBU9CII5uCRR557KdnKqCRwnnjhIRQd9fngHjBZdLkiZJcRE6RstAPPa89F/LfDXQ7A537lycrSYVjcItAEiQerCu2Ddcu01Zep1HPeQxCFqkEOqPB8nawN67lyRvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=comC2TKL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e44f22f15so95591766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759999842; x=1760604642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqcknWB6eCX2VYrA61jN3BkPJkr8rXkQ5glVIbwi/1I=;
        b=comC2TKLTVkXpOQd5tgY24/IZSoA75vbSHAvabiCNutXVL8vsh+9LBvYRpsxG57/Vk
         mU9cmg7mgRrsFrxJzn9tEYf3tVyfQa8WnG2MnVGv3TGC4kHh/yJl3Je6P21b8v3dx5aP
         zewlyqucaS4huLhzmydnvENiZYqf1WM33XQSQInRfEj3P4SunVi0eZx4mYMKkYNSuPaZ
         /yVm7gJvfNblmk+NpF0GXxyXlUApCh1np/MtmWpl++oWJpMjEJzskLP0FDd82tW65WMq
         1F3e4rafzm8Nr4QfGUKRKjmKvNQpK+ygPj5Ptkse0ISe8nZf7v1ptQvBxdjw/b9jXSl4
         xIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999842; x=1760604642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqcknWB6eCX2VYrA61jN3BkPJkr8rXkQ5glVIbwi/1I=;
        b=eKnFSgI6mYFyLDzBuWlgVsieA8V3SaC310U1BnGDsaRYEw3dDEqANjyYco8wrEiCUm
         yax5sZUqkCW39HsZrFloZCf79ciE1nWaOVCRtMirYum3Gp8j3X4BScPyYBSjzzckDFVE
         DkVmVuvQT0VJXyFFYs+QAeGD5mYYcfYOGGGk7XBC0piVcOySP9mt4Zkp6iUoNWHU4WCI
         tWdWMDlQINcy0NIFISNcnuw5KgaNe++MLTMW6W3n0kOhQ9rdn28aOdDF5qmQaDY91lc/
         1CN7kKSsbN85pC90SPa38GsGbT6Mt8dbNhd7um1ZrsHSF4N5BPDFRC3vD7V7ymqzrtIQ
         4WhA==
X-Forwarded-Encrypted: i=1; AJvYcCWsmisenq1lVztEDSFB/IctfYJb2Bu116L1BR5bhj9WGK5WltgFBrd0AbarQr+X19IODKPtHR3x05uE+bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJ5X40qA2l93N879zWEW1/lRqEjaTNRaslqruhZw35EMowaVV
	IW8st83nTdLxNZg1DqrW/wCnNVRtykQ+Op0cyufohVDN7Cdj5tCk7A2a0PZKOnThGoBKChtHIlA
	H3eqB
X-Gm-Gg: ASbGncthBxgzacdef0LeRyhdW0TCtmVl6/BzaI0NTqrdWnaRG2uSP78r/8GUwlq84nn
	Cm5gxgJmwCY3RNw8iJ2tISaqGFDWK4PL6YQ+vsyXHJHTDMa4tQDOGtHr2bjAkEo6gtOPr9CfLAx
	2aWB0dN9WpLsAn6p+Xv0pxHFHsedIsPS7PR0WmFt0+aMtYXCt4fM1GG2g/mjl9LwBv0N5nbO/Xs
	Ki2bLeuCyhPetPg+qFe+LvAEKNsZ8uGPfgdQUSkpE47tB1BSRRy1CyePH7jMcqOB4Vv/TvhVEzf
	mmMaYq/et5i/1+YmUW1qAvCyZmfS3oE29VuqQpDyRX1nijaqftQhyO2snYq5HCS3V4gn0miKdEv
	MiZyfck3IZW3VhsJHDKJns1hahwHnyRffboho6pNCo+nJq+bdXXE=
X-Google-Smtp-Source: AGHT+IHTCsyomQHU3pUrJjrilmhEN+1Nd+VpUwPLw6bAW+0LgCwbEc5fSDmHQ9jLfCM8ldZVWEaKhA==
X-Received: by 2002:a17:906:d54b:b0:b45:66f6:6a0a with SMTP id a640c23a62f3a-b50abed1a00mr678418766b.44.1759999842334;
        Thu, 09 Oct 2025 01:50:42 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4c855585d1sm1116706366b.67.2025.10.09.01.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:50:41 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:50:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Javier Garcia <rampxxxx@gmail.com>
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v3] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Message-ID: <dis2jb72ejrbmv26jdj3rwawrdmhmde5fahrkdn6y3elsgg4p7@wsjopejnmz5f>
References: <20251006164143.1187434-1-rampxxxx@gmail.com>
 <20251008183627.1279115-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2pqbmbzj5q22iux5"
Content-Disposition: inline
In-Reply-To: <20251008183627.1279115-1-rampxxxx@gmail.com>


--2pqbmbzj5q22iux5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
MIME-Version: 1.0

Hello Javier,

On Wed, Oct 08, 2025 at 08:36:27PM +0200, Javier Garcia wrote:
> This patch wraps the relevant code blocks with `IS_ENABLED(CONFIG_FB_DEVI=
CE)`.
>=20
> Allows the driver to be used for framebuffer text console, even if
> support for the /dev/fb device isn't compiled-in (CONFIG_FB_DEVICE=3Dn).
>=20
> This align with Documentation/drm/todo.rst
> "Remove driver dependencies on FB_DEVICE"
>=20
> I've not the card so I was not able to test it.

I still don't understand why the creation of the dispregs sysfs file
should be conditional on FB_DEVICE. Either they have nothing to do with
each other, or I'm missing something. The former makes this patch wrong,
the latter would be an indication that the commit log is still
non-optimal.

Best regards
Uwe

--2pqbmbzj5q22iux5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjnd1sACgkQj4D7WH0S
/k7BbAf/QLsyGkuDfs6LkdXxSM3JUBB+yt7DzUjuOuGak31kVLqt/53SRBN6dK5H
hutjVuB8TOyFnQe5u+U5sL4xHApig5CPAl6OZmT+rAiNMTf78uJI5vO0kHeDhhcE
9dvxQvzxWZ1v52BcqSmNZNN0zXF+K8PvCSmbsTK5dqGYWi0YtrI1/U7SGzaUuPHY
jfMHmpOs9nNjJw0xjaXgSt2dP5Qjp7OvhAMf/VqXZVU/xTgKyndHZykUV4HnmVWb
RojLM4msHiUv14Njgqio0sR90BzGq734oI9JZE50PcMhB/Ch/1LGCKNJOVHfRNcQ
9/kD0Fn12tVy8Zz5XjBV+Sq9rUPI4A==
=RLfl
-----END PGP SIGNATURE-----

--2pqbmbzj5q22iux5--

