Return-Path: <linux-kernel+bounces-729779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A02B03B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEDD7A43D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254CE244688;
	Mon, 14 Jul 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJzfRyim"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD3244186;
	Mon, 14 Jul 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486815; cv=none; b=MymWOa3BTTvdE8F5IWOIWd0U29/h8vmfqnCrDe/X0jA8YJMDYDuYraHNlMiUc30mEWOSeRUvDpy5jxDvSzZGjyDCMUNWqB7gWO9wZm8xaDRbKoUUfJcoJ2yuZNG5+rHSde2SiVzb/idItkxDdvyJR3HQJxG5gwOL+C+hESGv3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486815; c=relaxed/simple;
	bh=9X61o1toElFjW4EGc0qCV1uxCE7n857B9KnQrGKNsPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saBf38HXFH9wu2ByUDcNQx/4wRiLT0VraJpDyilWh+g8vv94GLJifJh98+H3hg9oFFyocyUXN7wzI+oMzWWG1cXlZXzSW9Pq+qeWU9uKRx28BX74pzMIH2K40ggM5X+H9sebVy0k7XkjDG5UYcSZYKzYDmPuxI6aZRin6agDR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJzfRyim; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-558f7fda97eso2513191e87.2;
        Mon, 14 Jul 2025 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752486812; x=1753091612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9X61o1toElFjW4EGc0qCV1uxCE7n857B9KnQrGKNsPQ=;
        b=CJzfRyimBx1Tnf4+u8z3LW82MAY98F623GGZrYI1IF5FAwtpOWr5rmR0xYRlhASw9w
         et8XR0x+3NR4FoGUfvLCPtHm5zo4xi7xyku4iLpp5L1KU8mkPECXhSupbHCHd0BV+9bQ
         BNNRJNt3e9zJ+yl/YJ7CylL81CmB3FtJoJQnyhJdhdHOOlSsQwB0b76NVZ7rvkdg80cu
         2PSrcWHTVxsDf2c4a4G/TYDGxAp3z/1KfArwLySgx0PXO0ihIjXKSqgIi88mY8Gf6+q0
         qKl9uLYP/ppjbYDzyAIhiRrlVJo+KmHjRzG1FosXRJL8EEcIwIsz7rAjPaQ3N1sqtt7N
         kVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486812; x=1753091612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X61o1toElFjW4EGc0qCV1uxCE7n857B9KnQrGKNsPQ=;
        b=lDb6Zn/lP3cp3zh2n2GKYlnWK4oADqm6wUM6juTXC06mQGnxz4/R4WBtbFn//W+RF1
         I3bGFTZ6gX0hHqcFNLbsyMs9PwOzqTynX8KC9GfjF44dz07tgXQACzmEWmwdE3V/po9k
         blI65x112Fq9/7TgEFOSpLnNlam8rj56v8qRHflT4NCO6umXDeR2EvSoXq9ekfAzzLBV
         EGdmj539PcXO5itR6LvauL8qG2AGK9OohW6i15TpYuS8dn2yKadYq+pz9CWsK64bBZMQ
         vfdmqoEItYWr8qsLpH1Z1Gb5JSc35bVg2e37HDJ/+3zwejDwsYerB21VCmV6sES0E/KU
         mz1w==
X-Forwarded-Encrypted: i=1; AJvYcCUVxIk7su1D4BxgSXVmoI03a53JJKCLTwImiasvjMr5lRLSLSo3gknkYNRn5QYbiskWqV1FbpN7EDhv@vger.kernel.org, AJvYcCVMdVIXVV7QwW6Xgk2WKlnUVYGOpPJgrkNhMS4f+L42SGrZpyMpa/5VD6g6KV+nR+eCH6mTQuT+qg21p2oE@vger.kernel.org
X-Gm-Message-State: AOJu0YygtVvKByLrcz00ClwoGZyKfeV8kRHqnNJCrxql8xPXAEpRYGSS
	nhtgDnQl/O9rkvUsnIOhiN/dBnoDgyO+PGLJK05BxADWdinrby7dexFq
X-Gm-Gg: ASbGncvkUDsB1BcGLR1T+fP/FbK2IJ9F0X7Stg6jObTS4bsOL2p6cVh/LbK0h2q9Y7P
	widFbi+Z8wc+DXZS0CkPnCWu69frgnNuZNOd5CukgetoPBOzCN/S29ctPJq3yW7ZUnhpj4krNeE
	0oSn8iFP0qZK3Dm499C6kiDa8eHS7lzezXiNogKyr+mECIedM+m6SbTYu4JxOF+wOTm00xwG09K
	7yaggGiJbzHi7sKBPQJ+8iRsRk7N6E6nDBEkxSq0Ld/7JrDEpFl/aIDdWTqWosON8eW2QVWqlfE
	r8cOZf0BsGGn4CSDa0MRpsWraiA+Fq0au+JTT5KjO5xiOWvxH+NqkRBLcteanX/SHbfiUX2ggRw
	qnXdhTlYaYdBWz7vIL5hsHA2KjiqYzljbwAGemFTGh6az/8uMRW0AMVwpA/PY98CxxwxOJw==
X-Google-Smtp-Source: AGHT+IGV0OnVPhct9hOpTRxWG6mjtuDaMUJXFWk9S5aL02iJNxqSWm0eRCQ5NNbKKfS1/BupTCWSXQ==
X-Received: by 2002:a05:6512:6cd:b0:553:3892:5ec6 with SMTP id 2adb3069b0e04-55a0463a2dcmr3780494e87.35.1752486811517;
        Mon, 14 Jul 2025 02:53:31 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d32absm1894249e87.118.2025.07.14.02.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:53:30 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:28 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/format-helper: introduce
 drm_fb_xrgb8888_to_gray2()
Message-ID: <aHTTmORf7aoPxZdu@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
 <20250714-st7571-format-v1-4-a27e5112baff@gmail.com>
 <bc37c3e9-0e58-4d63-b271-d2b026adf3a0@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tWh33p2Y97tbbhG9"
Content-Disposition: inline
In-Reply-To: <bc37c3e9-0e58-4d63-b271-d2b026adf3a0@suse.de>


--tWh33p2Y97tbbhG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,


Thank you for your comments!

On Mon, Jul 14, 2025 at 11:13:04AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 14.07.25 um 10:04 schrieb Marcus Folkesson:
> > drm_fb_xrgb8888_to_gray2() works like and share much code with
> > drm_fb_xrgb8888_to_mono(), but converts XRGB8888 to
> > 2bit grayscale instead.
> >=20
> > It uses drm_fb_xrgb8888_to_gray8() to convert the pixels to gray8 as an
> > intermediate step before converting to gray2.
>=20
> Please don't share code here.=A0 This needs a serious rework anyway. The =
best
> thing for now is to add a new, separate function for _gray2().

I see. I will instead add a separate _gray() function, even though it
will look very similar to _mono.

>=20
> Best regards
> Thomas

Best regards,
Marcus Folkesson

--tWh33p2Y97tbbhG9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmh005QACgkQiIBOb1ld
UjKZ4BAAw/2UefV8Jq9HhLvLy3L1LSnhR0WRTHG0NoEnPSSYqjm3g9FIu8TBZTam
UXsOv3u5txdvZHncT0OGbDk/s9FmcwShRunWCs4NA1+qFFb3ojT5bQwY3VD0Q5CT
MplaW9hXNcjrG1oCIzRvY2BubEJqOtSundpy0yhhRFFchQh6i6OBhXL7Nb0Z2cki
VuBbC4FXBdRUd1pKmApaH9/z2jAqRpfFCvWDbGciBcwajkol9pktjm2GQJz+NP1D
6DY3Pfh93uc3eqJgLQwJS7QfTRV5uYdYUWeXPwHoEs1KZQBukCs1/LPGC2DVpepD
lNELZnnAklnQ0e9J7qSyQR1bPySSvU1aYA6vg6NwXUrIE9DbsebRyTpDcv3ad79P
OMAkYPg9j8xvSaa9Va3nysgMhV/7I0UoZFTFtNMpPzmHLQiKEG09CAGdAmRWlivB
TN2SnV26rmYemhofNnhi437VYqoKZT91om5Au0RbPQEDhVJ1HgQNc4G8nSsnjlcZ
AJGrd7qNBi7ia07MTwezV92eEsmXuZNPrZnb8WkDzjFbg9MOiTq7AD5E8wM/6JaM
B+SMvo/nqAz0HdEYNZW/5h9iROnzXG9TYFmhLI01Sp5HCzrVo0XR6h8wEDlD/QGe
Vfy70LhlVTZlWOWdLIdmBsaSi/sGacB1aQTs+jduTxPj83nZm2w=
=zzGr
-----END PGP SIGNATURE-----

--tWh33p2Y97tbbhG9--

