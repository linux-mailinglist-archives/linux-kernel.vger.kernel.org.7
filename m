Return-Path: <linux-kernel+bounces-852798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADFBD9F67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638EB547B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62EB31578F;
	Tue, 14 Oct 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6782QOK"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4231577D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451205; cv=none; b=u3JqgInX4szDrlCREI+6+5Oe7NTv+el0YDNhnW8pGbb9VXLnxnCHBt22rUP8q4UPznEcSB7kWz5/yIVjPSXLhcqNPZnycaXHCtd7UWbblL0Nb3u1OzwX6rpYBnln95+CKsrOcSecyGJlY6zuavdD6BVvnFrggRqkvGRr4GkxA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451205; c=relaxed/simple;
	bh=mTYnJPNoAg22IY/krKLRgI2oWuAXT8sxqyIgCxPtuLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM1J20daR1iHHSSTP1Ga8mLp5+Hz9L7+4yhaSdzrvYGLc+iqUyYgYvuSEUHrg+qV5VJby2OA18sHIIehwtUoUPCXifzVDIYfqtHMstdpFGDf2oqT4dO2iSpXSugYaTpXWD8ZXihqXo+3jKg7c6ku5XcQiKhQZKE2wXNgnnxJ5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6782QOK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37777912136so3717051fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760451201; x=1761056001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2MtCooci01DsFhVORv2Xd0IZSv5uSvTDLsmJesa9HE=;
        b=R6782QOKWahnMzCBSDZ3I/6Og/BtAXbVoNhVTZpYVq9eXxHoMbfEZAdBeJZsIqi3H9
         DZBT0fJpGT3/g0xxXcbkH5w2DRYkqN+SA7uSJUTOAFqxL0NG1N2I4EwwucYBmXx7o8l4
         Xlfyu9U22eFq5kR57UnD1ipIMdi6FRaSJZPzNvAehejdFjwCvCU8ixmvk/tZ36TX6/6U
         o68XxSWOoVHHcpBJ0KlhMPmHq35XRcu1UKhRqXnIUVvXLmFkEIwkCpDkZio2jHFQhTD7
         Jo5n8CrBKaII4ry8bbvs9ArNBwgVNRgxlfwNngb6FnU7oeh+dJOagDG7By+/qAS+9Jgo
         anag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760451201; x=1761056001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2MtCooci01DsFhVORv2Xd0IZSv5uSvTDLsmJesa9HE=;
        b=DaDI2H/D4/iWvujNw825UEfeYlVu56F/uRFnUqYL+Pf6f17C6SIjz8nF9HEBXegl7c
         G2npBYQG4peF4TLLSY/PjGxUfqpwuQnhQpf22nNQKDZNBXvDWlYipSkMv/DeUrwiLwg4
         KtpQUevUfKzBXw4UXYJWifI4UP2+SLb2EAUbQKTvhyBMWuwrLgoD4+zssEnLv1cm3+nc
         KQro0Kth/1EhjdW5cnh2j/890A7emp5iHiSFU2RD2T+X0YkLjp8VxSZBie8YV7swJAIw
         GdvlbZFhQrfn9AAuAdVteCxRoLEXclu5CBB8yZSp5gXSGSMawyc/J6rMCRPdOfBOQ3TR
         vKAA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVWMGTwB5nemew1sRLWH0BO5QBmNa872h3SQyn/SkZFnW2862XdfolLygAgPOlJrRuOf8i+Xk9MQLPSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJAti+OXKkm/8GTGGwtbWdfskuMCL6XsGUKgrqQRYG0HtKqJm
	tf4Jf44Xl56gxi7tehO53ocJ98cUke5tujUJnND+Wxl8uTQoGCOn5Xi+
X-Gm-Gg: ASbGncvN7bUAbX8Nf0K8SGoRgudUk8FZS1rwUuSA2dN+Uocp99NnCMzAJWyiFuXpHE8
	RZN/IelsXVg/QSJPqPe5C02wSj4LXA4sRhB+lesJ4i1SEa18ypDUrJ0nX8Gb8hikVc7c7zBUZUm
	zNKqKF1YZ8day97Mdkc9raP80lMoJLkb3+KAzIXEqtfeg+9FXzLzRfQ6CFNWOtyVw1HdDo4ysg9
	d6heVee6p7SiZh1gXwe9xZdBaiBRL61ICa/+VTvieK5nFEhM3JLWJCYP89xkPPkcSaNIgf8ER1M
	MuvvmHzMDbKMOvniMUtGOPVDcGcs7rUhWKkXnlX5m+xNCIt8umJLsZm5Ase1ETZC/FarPnCEIjo
	0nGMInTe8CfergNgRjDPuncF/NLstlJgTOaMicLA3eQpYZDhuRwFFI9ieOFY4NhdQSbCKULn/l/
	q+EzRoKfQPp1qi
X-Google-Smtp-Source: AGHT+IFeEMUY1hlZMIO7vaQDHfSuMopLPItnuGA64biSepIE+VCQtt3fHMYNGXlZMqO0KMdKPxM+lQ==
X-Received: by 2002:a2e:a9a8:0:b0:355:e2d9:9c83 with SMTP id 38308e7fff4ca-37609cea115mr65031261fa.8.1760451201065;
        Tue, 14 Oct 2025 07:13:21 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37634aed265sm38378101fa.8.2025.10.14.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:13:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:13:18 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/5] I2C Mux per channel bus speed
Message-ID: <aO5afkSgjvDViMId@gmail.com>
References: <20251002-i2c-mux-v2-0-b698564cd956@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UtyZG84lIxvJbmRv"
Content-Disposition: inline
In-Reply-To: <20251002-i2c-mux-v2-0-b698564cd956@gmail.com>


--UtyZG84lIxvJbmRv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, Oct 02, 2025 at 04:41:31PM +0200, Marcus Folkesson wrote:
> This was a RFC on how to implement a feature to have different bus
> speeds on different channels with an I2C multiplexer/switch.
> As no major complaints on the design came up during the review, I
> decided to submit the series without the RFC tag.
>=20
> The benefit with this feature is that you may group devices after
> the fastest bus speed they can handle.
> A real-world example is that you could have e.g. a display running @400kHz
> and a smart battery running @100kHz using the same I2C controller.
>=20
> There are many corner cases where this may cause a problem for some
> hardware topologies. I've tried to describe those I could think of
> in the documentation, see Patch #5.
>=20
> E.g. one risk is that if the mux driver does not disconnect channels
> when Idle, this may cause a higher frequency to "leak" through to
> devices that are supposed to run at lower bus speed.
> This is not only a "problem" for changing bus speed but could also be
> an issue for potential address conflicts.
>=20
> The implementation is split up into several patches:
>=20
> Patch #1 Introduce a callback for the i2c controller to set bus speed
> Patch #2 Introduce functionality to adjust bus speed depending on mux
>          channel.
> Patch #3 Cleanup i2c-davinci driver a bit to prepare it for set_clk_freq
> Parch #4 Implement set_clk_freq for the i2c-davinci driver
> Parch #5 Update documentation with this feature

Any more comments on this series?

Thanks,
Marcus Folkesson


--UtyZG84lIxvJbmRv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmjuWnkACgkQiIBOb1ld
UjKh+xAAkkGlqFuabpDZx0DeOU2tT5KZTfA5XMjR9YkT64Z+9kug4zZ4NxpjjnrN
2+zg81cG9ca1QqErpq0jM5SSp+KxhZJLFElsecig905+4D+oSsDL4XyU59Krwv/s
M59mcKQMKRTsr9D+J7WWoNuPa84qbG3nNusgqZRmHaS/59B5FGOtmWwnpkDbEyg5
sgBupn0y0idAIV+RDoh4YjFXZsXndEmr9lkRDHhmChL5tHC970dsq183ttJSG/tQ
K0kUQ3ilst6ZnDoZ+VIdsTRX60IRzxntAL6N2cay+NNxk1J7NGX2CDZUJpllmzhJ
JER+LjODXPGz86zi7yRCYRiLAQvZbCgrElk0IglfwdGpFWohh+9LD8Q5gmh8Nn9P
X1eDcrR+FFzmSkBt9O4BGsuBZ6U/Op62fpccLooibFbFWuCyKjfZHxVn3MgeJveY
Z9spR5F/G117fESQj+Dn8daAQCwjmMbgUtPKvPSoeh0mPoTXgk8lWx1twsAl9gzL
qJ4/AHjkH0M4bjUkxC6RL3p+GbF/22jgig176Fu3WUSnfjceZK96EmuCsAslGTBC
itO0Grs7yFsWBa5W/EmYKEktqUnrbRPkNkBvqt0Hq/czG88/HkJc0WucI3y0njX0
1vD6sIQ+wdRvx1C+fjVJC5wmGYOLX8VTpuVj0r0vvOQBWry3wEU=
=4xG5
-----END PGP SIGNATURE-----

--UtyZG84lIxvJbmRv--

