Return-Path: <linux-kernel+bounces-762549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD6B20858
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8529516649A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1532D3753;
	Mon, 11 Aug 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXRTV7GV"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5122D323D;
	Mon, 11 Aug 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914022; cv=none; b=rmkpBilBi/h5yomGkIrbP+zOyOg8F9s6owaJzGhWmjsZiLxTU/ZLd07kfCrtgB+lAJMPYfrqAH/p35jgI5a6W14q/jAolYNVeLmOE5Iofze0xCKjqWWxqxtyDzHzc7+g44kdkU/GBl9d5UNDt3vS7GnOqBtZYnrGj7Z6C4asx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914022; c=relaxed/simple;
	bh=7XkeTVeR7AUVclSQxB89lgWFvzEFYt+AP7RBVupiRSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ32AVp7FOixOR+ml2gFJMxMYrVeDKxJ6Dci+tj1DR/1dBhkjO9Ow/1Ye+M72PPAKCVKIXTEvN7Xlt3/GLeWrufXN9ZMT74f2MrwhbugeE6uLxbmoj4+FxuVC9lCM2+mIcCOIvDHc7MSGz94nUA+TUDwxwdBUlJ2tg5rMQ/VSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXRTV7GV; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-332612dc0d1so32770061fa.1;
        Mon, 11 Aug 2025 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754914018; x=1755518818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XkeTVeR7AUVclSQxB89lgWFvzEFYt+AP7RBVupiRSs=;
        b=EXRTV7GVed1KLNZU1dGB0GE0Uf2FAi3KoQP6LsCEeTPrOw8AtEcQRIRy29p0Mib53T
         sq86xuexa7r29M9zdvUVLhMzsrLcFpxNT/PPAyoT0AdvMSYDeliwz/ZySm+Y3IOgfTD4
         kdebPFRN+5J2fmRpNMyjNOydfm8b3+Z7vn7/3+fQAFNSPWrQ7L0qzIy/d1m4vPfd3l7O
         eS+sg0sjb1r2uxY1PeIueSySoQBNby5pJnKl+eHNiyDSczSMoB7j8s/in1Hbc9BIxmhM
         uVS8dur3FnY/+mDlaNwczUqL/tSqyKg7/Q6FpD1j5dSb3TO+Vpe3HPZllHUrJUzdiJaB
         EHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914018; x=1755518818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XkeTVeR7AUVclSQxB89lgWFvzEFYt+AP7RBVupiRSs=;
        b=ZhkJXIMcFhXNg9ptyTkr8BP8p8LNnHtauM3mkUDposMAlIF4fXc2Hmhpg5Sm5/nr/6
         WkXj/yjBGZ6PPVTHg619USCviFAxugLNb/IJjD18rww4SjGKy5FW73pvPY2OLbNAP8/5
         26HlGPA0f1Y+r+x47Obd09woM9WqRbph/uZRMBuJt6E8QDwQj+NGxdSbSpjx+kjgvP1e
         w7i4QIUyzAr8GK1S+Bx7xWKgBBGKRoZ5VFv2eXijj9ZVAXt1HwKMzezh/PSbt0g3IQXr
         YJ2hks234+i45pmsC6VRbLg3eQrBsCzvgOp4w6ZvotoYs9HS1EipCOK6TO8LQ9i2chkM
         RscA==
X-Forwarded-Encrypted: i=1; AJvYcCUqK1cAsG/mkKuom9EI6YvF0KgQMpnPriCVjzDqDcNni03iJsJNb3UFxG+WAT+04LbzwlOiCvx5lqf2@vger.kernel.org, AJvYcCUuXaEmMTwwdX4xpD5xOaWTItgq2Yjmz26LqasFkHsgL2zhGFRzSR7OxmAgE1l6eB5yMliZDfb4bbsLP1ah@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv92teTJmGaS6H+MM4h3ZpTDd9sPeDAE9w73AKlLIlahynFGTo
	yVt/lT0Jd2aNBGhknE0Ubx9zVnFitEHKz4GLmWd3ZI8ffP4NkdHY1Y8X
X-Gm-Gg: ASbGncthCARHCLmPdVxl9y2StcBtd8+mm5iLUsD88n6rUzwFE6mx9WhUW7K12jMQI8V
	qWev7aAc9+DNqe5s526Uxp669jbGnsKsgR1+HJa1+EBWc71Z+ljzjVCMee05AuTnV/IFMJmxTJ1
	z60ylYRSVMWPBv9Y/gflu5zww7fh3TFfx66hT9ROpHpIiPnVfgCkuvC1sG7mn5T33gRaaXJfE9F
	0lu3BUiNFEUwMoko+jC581VQ4nAiLscwFbMgbDTFwEq87wfa4xwmkLILoW8X3lswfKMmNxKSIML
	NwP1QRxaMocJ/7d3b16nGF3pVSU2QN6m9J4JxM12wiU+OhHzaMGAXxzdLY6greYsl8mfqn2kMA1
	XKc36C16ssnocODlynVis81bIVbk0T371amvLiN8l1rkvEm8dzMvIyHghBMMKkPyq
X-Google-Smtp-Source: AGHT+IE/GuxIoYIqqBjeZWYH/UUn6opwNIUilcCy9C1u/SwFZxJoBETzQorqokFMCXPJ/42zsdhbAg==
X-Received: by 2002:a2e:a007:0:b0:32e:525:5141 with SMTP id 38308e7fff4ca-333a2191a95mr20143711fa.16.1754914018203;
        Mon, 11 Aug 2025 05:06:58 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333bab6a92bsm9580081fa.45.2025.08.11.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:06:57 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:06:55 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/6] drm/format-helper: introduce
 drm_fb_xrgb8888_to_gray2()
Message-ID: <aJnc36ojqSb3-Ti2@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
 <20250721-st7571-format-v2-5-159f4134098c@gmail.com>
 <87y0sh947w.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NeiL4LulPAn3q9/h"
Content-Disposition: inline
In-Reply-To: <87y0sh947w.fsf@minerva.mail-host-address-is-not-set>


--NeiL4LulPAn3q9/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 01:24:19PM +0200, Javier Martinez Canillas wrote:
> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>=20
> > Convert XRGB8888 to 2bit grayscale.
> >
> > It uses drm_fb_xrgb8888_to_gray8() to convert the pixels to gray8 as an
> > intermediate step before converting to gray2.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
>=20
> I would like Thomas to review it too, but for me the change looks good.

A friendly ping to Thomas.

--NeiL4LulPAn3q9/h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmiZ3NoACgkQiIBOb1ld
UjJOqA/9EFOMhbu0wbyYAVNPEb2bgZnVC50sjd0XuH36BRN6gOkc8bi4LvPwhcqt
8V52Ql7zUgXLREU/YsWHPHvPyz0l4lcGkAhyAcJK1rHjbttG7QeCbZIYfVB0P4kq
f9bzMPMz6rQ77GkGlGvSTYuWn5DtqIFP908ldJPF9pzz7GKH2GsIIpUz5uxPWpsQ
FQndGwLyX/NXf3dayJs+GQATHIV1M8RSCAxpAzUkaLrB2caXWi5lE49ycMtpq2AL
IG7bloPDUuq9oiX/i2h/CaqP9m9x28iSiKpsqTJyHnP755INqiHbnFCwMyqs5PpF
Nnx/x9gpYacu1LQ8EZm49cASVQPrDpgdZ0mzbwaWzSR9LzcjTqwDyvyFpbxkuPj8
oKJsdG8Q5SetI7p/fZeth9cd5EINmG3NQTgL2mDFfxdPl1L3Y7KWhNaSo1g3oXRQ
HEfqkRoiDtkq+b8W+/VgfAuzYpwW+In/GzGbFGD7+ma5TbiO7yiimnSHPW0ZIXyr
bhmubETE8d08OjoKPBZjWsGkSzO+1np5ugqVmxZZdcBC/9oUuagz6JLResG7NuqQ
Ie/ZDBC6Np/ZW262DMDfk0cFNaM6I6IYtdIBhiss34UxbpTsYCzetUnoDk9wgi5l
2a4kfjLmwQjQDyfxO46DJ9N6a/KUCAWm7Elzv1lbvWfRp27BNAI=
=cZqy
-----END PGP SIGNATURE-----

--NeiL4LulPAn3q9/h--

