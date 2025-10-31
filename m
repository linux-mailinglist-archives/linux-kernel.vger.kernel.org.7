Return-Path: <linux-kernel+bounces-880078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D921DC24D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB8094ECA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E51346E62;
	Fri, 31 Oct 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g+MiLl4E"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720E345CB0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911030; cv=none; b=dgpAl1093TPBzsIUwXDnJNWWaGte4pRUnuVSYEcE5hrAVT9guKdphbkCAQyDQx+v1KHaQVHFS5CXUbqBQIcQKcvDU6IYcLVceDIneng4XKJ5hNhm4dRxf+3k6B3+ePAUXDDdQGdKfKEOWSjSTPHOIK3ECWN47CQZYwHwcmp3a5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911030; c=relaxed/simple;
	bh=UJ99E57Gzp44AGQUn/uVwSyKH+gfNwxwFBUmawztNas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkT1ZyKZCkxhpA0L4LQjTNSN3EUOv5J7t60aYu9g8pqKjV7EPyjulpAjDggIma/rSWqRQmAxasUuepIMsY2hEqH+wNgbkgy6FIVZgTpYvcfxOR911CAT7h/+eTudVP2MoQOP1J97Ie1Jcvxu2pKgrVlQh7YbzRj1UfTwgzG/arI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g+MiLl4E; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4aed12cea3so403090966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761911026; x=1762515826; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJ99E57Gzp44AGQUn/uVwSyKH+gfNwxwFBUmawztNas=;
        b=g+MiLl4ECgQs/h5TEvuS60ZTVFHktP9d4oIrlytxgYYaIG1E8jMlmItbXtX6UfHy0U
         aJ1yx6g0hDH6PWuJjtMnN0SzFaV3ndx3gpw/99nRlkNQCAOjqWBFUDW4PhWrV178baiH
         0G0V7Fv0jZsQvrrqy2tapEYtu5cXIYgD+G6cRt/MdTtuyzzmm0eeHK8bpEVtk7s35l4n
         53qPiYqWs+p/RDMT/+WGsbhBhz1ENqHutMZ08S8IRLewJnAWB22ucBx6WZ/9P0VsTFxC
         sDBjxgExN6oFZVwET3Bisv+U8o23ccijagGX2/TWg4EOyo+SKbz2vXMIK0ldsHJIO4eI
         grHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911026; x=1762515826;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJ99E57Gzp44AGQUn/uVwSyKH+gfNwxwFBUmawztNas=;
        b=GcgEtxMYgKsAyZw2iywvul2CD6swo4JMU8leiWDgwLVKuafPdVZ4OugE+kkVUMW8zO
         sztQQEIHemWpoYaSF6CKM6AIMWVK5VDDDhFz6CcMFX7i4+Wr32a2OcfkODtvqvQ5k49P
         CsZMd8ZdPfDS8G0cpDTPSYXptVcDTTuin/MVn1VwvCfYUwDpbZ+TVVP65Ipb1UzcMBu7
         CVtSfs13v1XoSFBXKUsP7AJQarxyAHp0Sah6N41xv4lIvNDR+DZM+9j1kkRy+uadjOQb
         E7/gv2nnITrlP2+DYCMe0y7qjSYW83ddP0GUbcqUqLYPjJcW6vCwVQgt0a4KoE88Hl7v
         +IKA==
X-Forwarded-Encrypted: i=1; AJvYcCWpq7hdLxi1xzTbKxUahfsZfRtT5d6ts4LI37/SYxuBJCrbIWHI0MWpA2P7aCOybA0DJSWBYZB+QH/Lzy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBB7DMFsgOufBvoLl+qImCSMnk9NaCVW1HnQDg7q2BY+gPyTr8
	EmYo4ozVzwtY/Qg6QQ7Od7p/ov21JISDGWZ9BUzJ+JMcqV5OS9kzgrT1UauKm9XbMEA=
X-Gm-Gg: ASbGncssr758Kx65CavNZPhTyt19HT96jOKlea6QfsWEyHCfiKgh0ZmGSfo7Jdw5BBj
	6k5EYaOAdiJ9+vfkVwnsfnDEGFj87rdDHOz+EKtq0aAsoHlUCs+GQ3DIbLAJnkwj1CNAVYaitme
	XsZoXceGV3ay4HzPkW3EoBJI/VWVTPnSdzQ07DzksvVosgQ6c/GiVPTSUyGFo7RKzmvxG4w4NWC
	VueLXAsx8SSsGtALfahK/KTta2oyhhRF3efhDakK2dxU3H1fyAeIzsINKcAcc/9D+55qs7T5RuR
	u5mPVZHSoIgdFf8xPbO68DKPKUH+7Hm0uM8i6P+WljJOsBttzPI0Vkdxb6PwHPv54s7UpYEMh32
	3p40SsNFi/2+0jU7EmdLKVE+afWChuH6bCBMPLsCkY5qLCNXNcnVitfnTEVH2RnNt7iygyjVmiZ
	XT6e42ZIzvcYyLAmOL0/e3bvgnGUJFUDivQv3ebkzoznsre7nj1JbQx830nM0t
X-Google-Smtp-Source: AGHT+IGl6cehL2XT1Dt5ia4ja85e/cEaMvBzQav3xw1vRSFclSEFYe2UzFwP/UMKQjClT0kQ7aJFMw==
X-Received: by 2002:a17:907:3d4c:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b70704bc39cmr359300066b.32.1761911025762;
        Fri, 31 Oct 2025 04:43:45 -0700 (PDT)
Received: from [10.203.83.168] (mob-176-247-67-93.net.vodafone.it. [176.247.67.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c3ad2fsm153616966b.42.2025.10.31.04.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:43:45 -0700 (PDT)
Message-ID: <e82fc48fadc89014764ad3c0c5f07d0075cf6748.camel@baylibre.com>
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 31 Oct 2025 12:43:39 +0100
In-Reply-To: <aQR0Iy2UJn9-XxpG@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-2-flavra@baylibre.com> <aQOVcCinTd-ZJJX3@lore-desk>
	 <3e7944588d3011b6a144d70ab9027a05a1e230d0.camel@baylibre.com>
	 <aQR0Iy2UJn9-XxpG@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FBmvEx+jh5329MlkkTEj"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-FBmvEx+jh5329MlkkTEj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-31 at 10:32 +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 09:26:19AM +0100, Francesco Lavra wrote:
> > On Thu, 2025-10-30 at 17:42 +0100, Lorenzo Bianconi wrote:
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->ext_info =3D st_ls=
m6dsx_ext_info;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id =3D=3D ST_LSM6DSX=
_ID_ACC) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (hw->settings->event_settings.wakeup_reg.addr) {
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id =3D=3D ST_LSM6=
DSX_ID_ACC &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw=
->settings->event_settings.wakeup_reg.addr) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ..=
.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > In patch 4/9, the inner conditional will be replaced by more generic
> > code,
> > so we would revert to if (id =3D=3D ST_LSM6DSX_ID_ACC) [...]
>=20
> Hmm... The obvious follow up question is why can't we stick with the
> original
> conditional to begin with?

There is no original conditional, this is new code.
So the code here is `if (cond1) {if (cond2) {}}`; in patch 4/9 it will
become `if (cond1) {something else}`.
Or, better yet, as you suggested earlier, in the next revision the code
here will be `if (cond1) helper()`, and in the patch 4/9 this will stay the
same and only the code inside the helper will change.


--=-FBmvEx+jh5329MlkkTEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkEoOsACgkQ7fE7c86U
Nl98lgv+KTuhsLEtskTA1c/naduRtBbctpqlwzDeaO1NTVgCmG0pbKRDd3KuZKKK
LHR1671fi14G9/6bUo4Upr5cD0DHtq1FDy4IS4EaGubI/Ghhng0D22nsCFQfyobE
c4sytsvcZWAlTNfLjkl+6dv+rgRLPRo0hc4bUPZyCiaZ4GOtDa5x7/q0uEI5ppbM
J/AUWtkuWrclvNrDwSxM0oMms38//x61K2yytp0/p7h4dX5mFeYeTNvb28tdgU3V
LcIWQKAGlfN9kzp8Hv6tkLhd+LMg/ldETJwlC15a/s7yjImWTzXjOSLMY1ysUVYK
BEmKuXY/QxmseguaVn3tE6gh06xYFMk2gyFB01sGA3iq6ReU6RBqmRaqmKCuilei
f96po3OQhbC4m0LRj6gBMebmPYqc75YQmstaJ0JuluohwEt8Z/s6G1+Ib1zDhq+q
hIG7hL+lRIHl5X0OBZEe6uPL6lkAGGsUJwS+hzWBgmgEgMJ1UM4yRsWp5z6/hj1i
rWoqhItx
=t1lv
-----END PGP SIGNATURE-----

--=-FBmvEx+jh5329MlkkTEj--

