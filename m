Return-Path: <linux-kernel+bounces-822353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000EB839C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506C572199E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364212FF655;
	Thu, 18 Sep 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7DK4zkq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19702D94AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185679; cv=none; b=cQlgpmTrw6e73s1DWCXnf/BP+mPhCD9EqQKTRBnujI92muJrFdV2TRN0RS3sRjNj6uBi/CdKzvQ3wrl5KbXd8gLk6Z2pgKKCk9tk9kBgCQSOaRmLyCxbaZ8V+uHGo+AhI+SrbaeUN502DJC1qX08VHQBiXUfLr/M1rEQR02pM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185679; c=relaxed/simple;
	bh=L1zfXr+TiF68xYIu/QjAZG5Rv3z8es1PBrKaRHiISSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPSE98FHnpr/QX3vRFqCFawxnedMbaFYqhtGKQA53Y3o/8pb59+7V7/EJo2kiO8j5tWRbkfrTuNXrs4D1JHHeG80LZewWBfrE/ZxrRXgjR89cOavQ+cynhAosj1pviSeMRqXm1KqPZq3X6OWiTAYpWeV3RLA4jMxMEYYpweyCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7DK4zkq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-576d8b85ed1so903303e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758185676; x=1758790476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1zfXr+TiF68xYIu/QjAZG5Rv3z8es1PBrKaRHiISSE=;
        b=k7DK4zkqhrzMkpA1R2KNcl+cx4Md8MTEeX6paffIfE0ar0vbYvqnwemX0Rxg7UUrWa
         O+4HMnt++NUg6YmbrBuYTQYrv2d2lZ/PZWs0kYXfXTV+SV1dpSPwJXZLoHAmHKuPoBVA
         +m8oPVnQ0HJ1YkDVozHEG8VDQU5GG7gsnPBNLOA2o+f23EqAWU3KyGFzgERP1uGOVM1B
         AhLEDbGnL/jISL02MS0JRiHO6krRYbBo2s6jCT/7Ua2kS9UnVYUaNdTZSRACrzs+RZLA
         nbkUv/QTN4Tb+44b6XSvrYCXk8jxyA/xaPVnBcC6r+R2qyxhax+Kx/dqUnqrpF+6Yzar
         ui0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185676; x=1758790476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1zfXr+TiF68xYIu/QjAZG5Rv3z8es1PBrKaRHiISSE=;
        b=JIuRSKbIOBEis3XAzThWMk/IdwWRH965aPECQvBts9+x8tFRfbbhSZnGwcpxBlGOGO
         HaL+lHimFqJ8L2OwYc9RxSKLUuyJbJbFXjfbiHn6w4TkYebnsVexlmaYHikAmDPG+qU4
         AfSZz5YCzRhLSaO2IU0uzvmIpP/WAW8BPexZyJdbjm5Smp1rXQvhl/6ppdYGp1Wv5eTC
         6RaX18J3TRansuhxbB7hB8M+rkM2F7Mjgdeji4hG4XgPbAXSC5uZykhAB8TTmbV1Z8dZ
         7NKxjMECX9VciWd8YBl7ihAVw3vqy6wGrf9ewVLh0xUn5h4gdJt0d0ALPe2eaKMFwc8w
         B1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVSY7VrHuguKDZhmPnNrNvD8dYfIx8jIv2+ScxQcwPb3oRyz8cRddr9qc0X41IYfR5jnsiUX4YxqcyKmKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrtoeePBABtrpdjMjfi8gBYLKX1SFZHZU8A18621CEZEhPPQg
	ruHTuoP2K2hoWUUygpBGWR7WoFFCQMDJGRljNJgZpyc3XIvt/1NV8TGg
X-Gm-Gg: ASbGnctD33vp0xR3Zg01OjyRdHFGDOE/+QqXLftmHoqErLQS/mHTU++HpSsdrP/PDrT
	fZiePmxPIdQmwqGpnWZhcqrTR63h4sukDB28Dm6vR8ac4Q4tJBSUp23rmSRVmqkSBR3T2CPd1aP
	hV65EX5ZQmd38bFPGS3PqSu/H64GTASy+t+8YFTDtkuR2YiLaCukvJM7hrv5h0cPNlgUtg3NQ4P
	7JE/MCCNry/wbAxdHMUP88aoH5AjPh+kdStgCO3aFKPMmxMMdG/CvIiFOqJBpSeaNgPAj2qJx0A
	h8qPkgTFN/h32Xd0ky8vguSKBQpBQpwYuOc7PJX5XsCsS8glI/Iyd6ToCHd1JplonwL6vFr3Kfk
	jtds7s2PaQJeHaIEQE0SV6HfZapLet+/OJGNrpgY6SIj6AI8Fl0QBdvHcYQl+oPJbDp0tG0QFQj
	9nH48bprSV8gzF
X-Google-Smtp-Source: AGHT+IGm2JShN6Sv81lo1T5JnLxBfIgmRooL50eCyiXCHruGwYMx2R2gX19XGt4JW1t8LOnfM1W53w==
X-Received: by 2002:a05:6512:33d0:b0:573:78df:c19c with SMTP id 2adb3069b0e04-57799fa0ac8mr1911319e87.22.1758185675774;
        Thu, 18 Sep 2025 01:54:35 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a99507c8sm498643e87.117.2025.09.18.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:54:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:54:32 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: reset position before clearing
 display
Message-ID: <aMvIyOJkXE39sp8T@gmail.com>
References: <20250913-st7571-reset-v1-1-ae5f58acdf8d@gmail.com>
 <87o6r9o25m.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ug0YIJ+ijkQ2jjPA"
Content-Disposition: inline
In-Reply-To: <87o6r9o25m.fsf@minerva.mail-host-address-is-not-set>


--Ug0YIJ+ijkQ2jjPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Javier,

On Wed, Sep 17, 2025 at 11:32:05AM +0200, Javier Martinez Canillas wrote:
> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>=20
> > We cannot know where the write pointer is, always reset position to
> > (0,0) before clearing display.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
>=20
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>=20
> Marcus, do you already have commit rights in drm-misc or do you want me to
> apply this patch ?

I sent a request for commit rights yesterday, once it is approved I will
apply this patch myself :-)


>=20
> --=20
> Best regards,
>=20
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>=20

Best regards,
Marcus Folkesson

--Ug0YIJ+ijkQ2jjPA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmjLyMEACgkQiIBOb1ld
UjKZmw//WN2aCTIg5Fi513sCawMQyeWG9g8gsNWGqu81U/hM4UOzZnjzhvEND+JT
Ud1R7lIiAvpcigeZvbNbk1v7WZu+PN47d01G/S07zOyYz+yW5lMy1xeS3sqMyJ5F
m8lkvz8/XSdG85PjvgHL5fRGAjATi1oxxm/k0V+BUhFqbGw0STm0tG/ReBfUheXg
O+/90scHHBfuO5e24cfia2kbcaQBg3y8s8S8ionXQIqhJIFogZPsMyhM7twF8xtD
EpyU/iZccX95WHorgIkVejKk8YNZD9dQPYy2lXOjDm499ZdFomyB/YB6eX3qQgmi
eHjVcC71f/4A0002avJJ6ywKSA65YKP/D5J9z/jFyPeVbtnaECR3CWJHQu2v5Zwf
Ak/2ak4M3i9s3Pjua59fQFF1d5405ZRAvpZWVcmky5Hs4dJBFrMHXYVA+4qvLvvG
ospz+JDo0dDArgetNOCtWrM4AQTZ7zMS+gNf/lLrQPIBy7364JKsxIHIaK3AObQO
sB+qZIkXsGC129tfFsr6vZnocGSqhKlnRmJUnrLeZK1Yp8cgR6uNZidsDGJpPfTd
GYs7U1YmD5HTkEDO87edVgDIjwbZSqFra4zHlX5UJ0DpOr0Pgil0bgVoL7Jko1jQ
pmF0IdOuZLyJVFDPa0d4Vxr1Wpqdy+qQIL6JLLmX8wxUetzWzVA=
=+vpd
-----END PGP SIGNATURE-----

--Ug0YIJ+ijkQ2jjPA--

