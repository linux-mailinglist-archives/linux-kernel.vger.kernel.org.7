Return-Path: <linux-kernel+bounces-864500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A15BFAE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D29B1A00C50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78E30BF6D;
	Wed, 22 Oct 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQi0SqUi"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74030B51B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121962; cv=none; b=duT0j2trC3TYHxlLFL3Jculq3s7jIDxvSM1/SiFY6/0CatcU9pPmn6UoVHR7uNRuf5wmYWsaVwZZ+HJbPcA39RbGo+UCW9ReanNIsEXBH7iqBjjdILA0g/UBTNcwBunZqNHMnLK6VORkF/uYqrzg6Br3w233YBPeEcgmbvIIVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121962; c=relaxed/simple;
	bh=vG9970yAK0hqIIzyy2jXISYK3FfNYfuuEYB5WhYxbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBVbrfKWnAssy5HrgZsM/quPpzuM/biVvMa4XlvhFi+h/ztH1T20vO/cGzPEFyGl/4d7gJjakciJDh0RlqEnAVA8OByGtoDXeufMu6cH0fTp6c5AXSY82RomRTnIWzJhO68f4Ns/Vfwbtua1HLOggdK83ePdlPMZw9xk2L0RkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQi0SqUi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36bf096b092so81062651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761121958; x=1761726758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiGCLbh/3HzTe3/7IQ4t3TrShEZTnb9ow4sr5HYnYBI=;
        b=cQi0SqUidIC/fhERUIBSWSTqkbDu1NVNxIdiCr11SxrTOHwATmLBiL6SMyWGbom8pJ
         GQu8GUIgjDXhw0AKqoHhgnaQzcE/xr6xt+YPkorr7VDz+jNpdWmhLfwQYnwa/VipnbZ6
         9Dx4Y6WlCG45ldveBFLvqHBo2x5qpWwwEDNvia1uMaoaXUs//ZXAzCTeYRuVe4O9xfO1
         57HtJrKpcC1uivcWEy13Lj791/7E3VHmtzU4pGfRzVsrGBVp52oXb/wwbqqAmgFxKopK
         fJ7c3XSZUz/QE8+VLxWX3VLyzoFFmb5EeY5Yx+mGQdio7ClWJ42CmtpmrHnVVrmtBFnj
         OnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121958; x=1761726758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiGCLbh/3HzTe3/7IQ4t3TrShEZTnb9ow4sr5HYnYBI=;
        b=Qc2nFQL/qhfQM5IDCD70nBauvEC11Vm27SUKDdlZep26iuqKZAQ/gVZjpHpimLUl+Z
         vKxyiwpA7Qj+uKcetafe0iMIOelBWzTfQ6GMoAgNH7P6YiwjrB5ussxUfFQ9F8hnWCzA
         asRpFAm9iznhiJGjKzfUcQ8dcrXlXtHCrSrcEijIfR/W6ppbMR/SpgG3uBPiqSd+sfXg
         MjSchH7ncM/MpF4DxITTxTnSMwBYEREgfN9OU1FHdaDh76/TY6fqqSOBG8KnGyRPbNPF
         3GUYLH9tNiCQh8/cLhhK5RM2cNjUVAMnvxNUr7y6BO+kTNTPEvaDI4rubeWqrpWvjDnr
         zUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXonepvbFo5b7iboU34B0y7+dvZgSQtcHXKgiCO/lbuJJLdOQgMg/mamrcpLIG4gR8Tn47JcSOGWbG5qkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQDXyjrBbvpARq9177DI8t0t5pJk4f128rpJp7rVJtQx675MU
	rSij7qAr7T6o3k7A8BuxxcN3oEig4viRkrgLU6NnPHOEKNEXdcvZXC7J
X-Gm-Gg: ASbGnct8ayNG2tZBdJ4/CINvN3UOQTjJ+t/Jjcn5vUUzoFc0bTKOQreAk9njGsNaGqO
	VOwgTIAKePwXzN8UmhJIdvVdpiysSGqdz77sTU2/yk02kC62espS+Bz1S7B5vnIemTBUchZCEGO
	H/qE+9n/3QhI0KJOM7uuHAWGb+46RsHrGnVN9uLlG5LNsPLwBIUx+j9ct5qjGHn/IW4MnBdMBtK
	LbhwCHmvPRh9eF9BPyCs0A2reHwfvngG/bd0gZAtfK8gMqUrXChTmbhSqeBhi6RE2HS+75FvQcz
	2rWLbGly5pATAwTcewjeN/WDdudQP7RSKjSlSexFcU44Y2NXViT8nTt2mj9uDlUscmFkRwDfA0a
	J7KaVYZ7oPrB5TQaoboG6uUnDY+8du0wfP9SmtPQyWJsxy4AtVsQpVAH69z4lpzIZObkK+ivzRo
	WgkdmWcYu5lbfMWD+5meo0QpqHNBXN/uSfBB4hMww428PIa+M=
X-Google-Smtp-Source: AGHT+IH1CNRr/4ibi1Eb3pAQaaEXOhfp7nk1oRCJbI999kaD84S4h59XYsCeji1Qhx2DPQklnIr3XA==
X-Received: by 2002:a2e:b8cb:0:b0:372:8e26:a4d4 with SMTP id 38308e7fff4ca-37797a83656mr54737371fa.42.1761121957872;
        Wed, 22 Oct 2025 01:32:37 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950a284sm34810371fa.36.2025.10.22.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:32:37 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:32:35 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: remove unneeded semicolon
Message-ID: <aPiWo9UaK7N6SaVZ@gmail.com>
References: <20251022-st7571-semicolon-v1-1-83d322618ff4@gmail.com>
 <aPiOxYYY_dPkShsW@gmail.com>
 <b2021d28-63d9-415c-89d8-2beac80aab94@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="saWeArvJSS/fJjUF"
Content-Disposition: inline
In-Reply-To: <b2021d28-63d9-415c-89d8-2beac80aab94@suse.de>


--saWeArvJSS/fJjUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 22, 2025 at 10:19:13AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 22.10.25 um 09:59 schrieb Marcus Folkesson:
> > On Wed, Oct 22, 2025 at 08:10:57AM +0200, Marcus Folkesson wrote:
> > > Fix style issue reported by Kernel test robot.
> > >=20
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202510221125.Cg0sM4xJ-l=
kp@intel.com/
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > >   drivers/gpu/drm/sitronix/st7571-i2c.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/=
sitronix/st7571-i2c.c
> > > index 32b91d65b768b26caa7dcef42a00d36f236fbc32..4e73c8b415d677dab5b42=
1666b56f4bb3697b982 100644
> > > --- a/drivers/gpu/drm/sitronix/st7571-i2c.c
> > > +++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
> > > @@ -322,7 +322,7 @@ static void st7571_prepare_buffer_grayscale(struc=
t st7571_device *st7571,
> > >   		size =3D (rect->x2 - rect->x1) * (rect->y2 - rect->y1) / 4;
> > >   		memcpy(st7571->hwbuf, vmap->vaddr, size);
> > >   		break;
> > > -	};
> > > +	}
> > >   }
> > >   static int st7571_fb_update_rect_monochrome(struct drm_framebuffer =
*fb, struct drm_rect *rect)
> > >=20
> > > ---
> > > base-commit: c1a7cc00cd412505e070eb4e62bc0b0ca85243e0
> > > change-id: 20251022-st7571-semicolon-bc5287cde264
> > >=20
> > > Best regards,
> > > --=20
> > > Marcus Folkesson <marcus.folkesson@gmail.com>
> > >=20
> > Pushed to drm-misc-fixes.

s/drm-misc-fixes/drm-misc-next/
>=20
> This does not belong into -fixes as it's not a bug fix, just a style issu=
e.
> Also misses the Fixes tag. No need to revert, but please keep in mind for
> next time.

Ooops, it was pushed to drm-misc-next, not drm-misc-fixes.
Sorry for the typo and thanks for pointing it out.

Best regards,
Marcus Folkesson








>=20
> Best regards
> Thomas
>=20
> >=20
> > Best regards,
> > Marcus Folkesson
>=20
> --=20
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>=20
>=20

--saWeArvJSS/fJjUF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmj4lp4ACgkQiIBOb1ld
UjKX/Q/+OetKvifMK/UwdNGuydJFstcdXYk85idcyVnVJUfExv0EHlqXSCS71zkh
ouX0a2rBD1xjfzdwf5gYIOU+Drx1jpaNGTLMnW+e4PCzWAFpB6VbZxdSASsZfvvq
VMzBmL5uSH2jVA/mz7Wc7oVwBLXrSdXAVo9rXaqCjr47U476ITiAGJjJQIGaoRX5
3iW4Pj8K6lcWoDJSlXFgZ9xBCxKmi428yv7P2bEXbaG+RQK7u8a8ZiRxh4wKmzPv
yf7RO0dni4YbeKAZ90yO9OgBsFTjDKINhaegVV77zClnEoKM8AVELExyghgGIC7t
J7yyICFnVXc3dTNUjHCYU5HwyaoFU3v77/AeyazvQxnTNwvlSWQ8phN9Vj1I6uRd
XRzFfO9Wqu4jdBt3EE2UTrk/lVUxMl8Khi4G9WEADKVjlpVZH+RfoUgEIe5dvGKM
84BnyRXpouxFYOjuGaRJjkm0gMOEk37Nx6MyT0ewWNc3yMWPgiqln2P4yIZldaI6
CwKB+yJUMI13M1Q6UFHFujQ42GSFPzAeGFHoxbivbtrHOIv1AqPBP5oAU/kuqBHk
T0vm9i/ctmGhAc6jPoebO8PVZPZ61pPrwWon0/KCp2XWvGJaM2ONjjWWcJEOATcI
V1lCOePlCMMqyBfkFcko+4evPf5n7oHBMWCIV+/fZhDwoAEoHaI=
=Ct9G
-----END PGP SIGNATURE-----

--saWeArvJSS/fJjUF--

