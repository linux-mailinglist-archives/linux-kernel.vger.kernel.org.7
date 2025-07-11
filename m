Return-Path: <linux-kernel+bounces-728257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8327BB02587
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACD418967C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F51EFF9B;
	Fri, 11 Jul 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="s7ElN+sr"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F341DE3AB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264045; cv=none; b=n7pL+IxVSd6xtEy17jkV8jWnLQTQXoH8Wr9KsbLbTim20MvBirOlBChoXdAU5+naTQNNl4bKpP9hID0Dqd8CPaVHbpXr3XE12IfZ6a+oZa7PefPHoscDK1uNZMcHoLAF2q/xV6GwkhPJdbbcGiITuxDRzlDP/ry+zqvV6MwGqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264045; c=relaxed/simple;
	bh=rZi2rCdl13Itq2FYc/am7oHPt2a+dpwp2iEDHnh9MtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lxsl6v9T7fMkKiZ2+8wuqVBIwHuU+/yTVOwDP/XhXmPVzfhyQpNKtkm7OyElzMAYW7AJ9Iw82xNIeA6yL0U0l8JSw7PDdgsGQ5A17/RsjpKizDwzBJRvr5WauN2NMZfGrNpzs6okS1XOJFNePcA/7CmoEpRdyeb8CGYqFoYVm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=s7ElN+sr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6face367320so24126806d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1752264042; x=1752868842; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rZi2rCdl13Itq2FYc/am7oHPt2a+dpwp2iEDHnh9MtI=;
        b=s7ElN+sreRJNoyiNTLESTLZc1tL6zO1KXaQfWAgTq52i5LLEu9v0p94aZSmK7xeikO
         7gtjemhxzhRo68LIoa4IilSjtaj8OzZKtwPp0pUCcDVaTfTMB1dEB38ftVuoLB14U+Ze
         /KNGd/f4yyA7+Ky0WVouOSODiAM5RbuMIGjywl6Y8C2lK5CItBJz43uQWmRwT8QZIWpC
         /3z3jGsayTocuoFZSz2G5E4Oi534pq/vUS3akQ4mSWnxMji6a17XrtIWsALvd9TIMU5G
         lElNUS8maI1MVpufwH7/3w4Iu+25FIalrmRjB6wuBIYY163E3bxJHIt86h7jbMSM4W56
         lRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264042; x=1752868842;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZi2rCdl13Itq2FYc/am7oHPt2a+dpwp2iEDHnh9MtI=;
        b=ldEIX97FrY+g+27KCudTN/qh+m3VFX5eKv9BqA9euvsHwIX6lUx8J6EqNic/HDo2tw
         9KzopLt1WOD/T7paP9plCbGcwZxBWHyRNhbdX1iyXJbjkI1g+vvc9/hf07aacmWeDsao
         86vp0o/ck0kg6evKKHx59oyvja5yF4eIc0DkJjn0gHt5LQIS4FrZ5cDVit6pUKXGwoVG
         d8nl5TZw2AfEJV94shK4UTf4SrtCC7YiNeJ0jemFRB48Le53/yGlTkxc8ppjh3JufqbK
         iZG9NZOe9eXicQMfglqSvmv1YKahwWSESiFzUqhMfRpmzYet1DV4Yay6Axhuu8l4Wagu
         BL4A==
X-Forwarded-Encrypted: i=1; AJvYcCVVZFXYhuOFiYX0937jlOo1P/bzSNLyx7NUQEAUgFaOHYaz2acKuMXwUqEBZrhRK+pRUTg4SuOPdExkbyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6p1vBaG/xczu9i24B5P4irLC0pPt7mKGxwXAlqWYXtTY07ybl
	ftFudB3xCKY0j385Rqh06gZ59wBlpVERyGJ7u5nFrlbEbg6SwFaj99PU2Pk45YEbHtGSCQ9PGwO
	E/zaUzFhCrA==
X-Gm-Gg: ASbGncsjxKf86sG5LlpQGJQ++w3mrffdytFmzItgUIf2Tbx6WsHk4E1ro6LVHEffphP
	naUAAXlossYhfmlAn8dqRzMzvVAxFMyxQ1M2oslJIz+PLVOqA+muG4JqoXaHXSEBLVTXGjgTo3j
	v1FeUlgL2jmCHE49umEoO+nVn0lrWUd6Z4UxvktwTQvigTXumopVtqEnqQW0aDUIREgUdFxiVua
	JQm0L9BuxL9rIaLMiNzACfBLXa7QcUFvhpg/93HU5gnRaVm6ccBDWef+7IGxxOfBqkJ7ZIWepTf
	M/Rl3ypwnl6cnqu19SsU6smIiiFscEJgQNdtDXFIUMGirc+MVxyZaeGAFkjyeMoD6V3SQ5rAJBQ
	icSwHIzO0qtDxkIudu/qN2xuAPi4=
X-Google-Smtp-Source: AGHT+IGM+1hSBakMhrLaq9WY4U9uml++QAtwf0AFvIykTUocyfI+3+molPmoYEJFzOkqT6FmQrqWMw==
X-Received: by 2002:a05:6214:2e92:b0:704:a592:490b with SMTP id 6a1803df08f44-704a592491emr63860896d6.37.1752264042280;
        Fri, 11 Jul 2025 13:00:42 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:b699::5ac? ([2606:6d00:17:b699::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799e874sm23334306d6.18.2025.07.11.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:00:41 -0700 (PDT)
Message-ID: <1f36e0e642a1554f4661f122f7d525d5677ce1df.camel@ndufresne.ca>
Subject: Re: [PATCH 7/8] media: rkvdec: Remove TODO file
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Detlev Casanova <detlev.casanova@collabora.com>, 
	linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel	 <sebastian.reichel@collabora.com>, Cristian Ciocaltea	
 <cristian.ciocaltea@collabora.com>, Alexey Charkov <alchark@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jianfeng Liu
 <liujianfeng1994@gmail.com>, Nicolas Frattaroli	
 <nicolas.frattaroli@collabora.com>, Kever Yang <kever.yang@rock-chips.com>,
  Andy Yan <andy.yan@rock-chips.com>, Frank Wang
 <frank.wang@rock-chips.com>, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-rockchip@lists.infradead.org,
 Ezequiel Garcia	 <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda
 <ribalda@chromium.org>, Hans de Goede <hansg@kernel.org>,  Yunke Cao
 <yunkec@google.com>, linux-media@vger.kernel.org, kernel@collabora.com
Date: Fri, 11 Jul 2025 16:00:39 -0400
In-Reply-To: <20250623160722.55938-8-detlev.casanova@collabora.com>
References: <20250623160722.55938-1-detlev.casanova@collabora.com>
	 <20250623160722.55938-8-detlev.casanova@collabora.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0MU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT6ImQQTFg
 oAQQIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBO8NUoEVxMPCGgRvEtlBlFEpYHL0BQJ
 oLLLGBQkJZfd1AAoJENlBlFEpYHL0BEkA/3qkWYt99myYFSmTJUF8UB/7OroEm3vr1HRqXeQe9Qp2
 AP0bsoAe6KjEPa/pJfuJ2khrOPPHxvyt/PBNbI5BYcIABLQnTmljb2xhcyBEdWZyZXNuZSA8bmljb
 2xhc0BuZHVmcmVzbmUuY2E+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQ
 TvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyy+AUJCWX3dQAKCRDZQZRRKWBy9FJ5AQCNy8SX8DpHbLa
 cy58vgDwyIpB89mok9eWGGejY9mqpRwEAhHzs+/n5xlVlM3bqy1yHnAzJqVwqBE1D0jG0a9V6VQI=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-KQw6nRLQn0EVg5xyIuZ/"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-KQw6nRLQn0EVg5xyIuZ/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 23 juin 2025 =C3=A0 12:07 -0400, Detlev Casanova a =C3=A9crit=C2=
=A0:
> 2 items are present in the TODO file:
> =C2=A0- HEVC support
> =C2=A0- Evaluate adding helper for rkvdec_request_validate
>=20
> Missing HEVC support is not a reason for a driver to be in staging,
> support for different features of the hardware can be added in drivers
> in the main tree.
>=20
> The rkvdec_request_validate function was simplified in
> commit 54676d5f5630 ("media: rkvdec: Do not require all controls to be pr=
esent
> in every request")
> by not setting controls that have not changed.
> As it now basically just calls vb2_request_validate(), there is no need
> for a helper.
>=20
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/staging/media/rkvdec/TODO | 11 -----------
> =C2=A01 file changed, 11 deletions(-)
> =C2=A0delete mode 100644 drivers/staging/media/rkvdec/TODO
>=20
> diff --git a/drivers/staging/media/rkvdec/TODO
> b/drivers/staging/media/rkvdec/TODO
> deleted file mode 100644
> index 2c0779383276e..0000000000000
> --- a/drivers/staging/media/rkvdec/TODO
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -* Support for HEVC is planned for this driver.
> -
> -=C2=A0 Given the V4L controls for that CODEC will be part of
> -=C2=A0 the uABI, it will be required to have the driver in staging.
> -
> -=C2=A0 For this reason, we are keeping this driver in staging for now.
> -
> -* Evaluate introducing a helper to consolidate duplicated
> -=C2=A0 code in rkvdec_request_validate and cedrus_request_validate.
> -=C2=A0 The helper needs to the driver private data associated with
> -=C2=A0 the videobuf2 queue, from a media request.

--=-KQw6nRLQn0EVg5xyIuZ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaHFtaAAKCRDZQZRRKWBy
9F41AP99Ssroc2Ugv8H1VwcSMEFKHPQNBb3wYyF+ksoPrbKbdAD/RUUvTpWPsDfz
ldKo4ficYUoAy5UZisMdhE0ngURfwg4=
=tW+S
-----END PGP SIGNATURE-----

--=-KQw6nRLQn0EVg5xyIuZ/--

