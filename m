Return-Path: <linux-kernel+bounces-848254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D70BCD03B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859703BA093
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E928750B;
	Fri, 10 Oct 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l44pI/Wn"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356B53A7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101447; cv=none; b=X/FJQrFtT2aBY/VEDns5/j+DPSJXGhmnX4diE0HVKghgPFTS/9ig5iEyWXUL3ikP0Z6FtkFADpkT4ksAXpmddCsKehWvpADmjviN8AcJ9J5do1yM9QyCfv+1KkvQnKcpW/HFFl5kvh4KttIfYlbrUrIKwt87uWX+Sh/OKJ5l0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101447; c=relaxed/simple;
	bh=2fBUTn5JHSmdXy1l08iLHS3auLWgcZKX0u7ZoOON8iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na78GYxS9e2FL0Yd1S1Rt94spuZXBUvIiv9ct9qDOn/W/0rTVOKBcOo4tltIbN33f9I+98olpHRvemH23cnWd1645jUwouhsjKz8I03oPT05chTtXUePfJjzWDDydutHzafqGYkMGdBOT8NVGgzAeENLBEjsXtt633xVohcO1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l44pI/Wn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so15642975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760101444; x=1760706244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUep6nRJRENnGzYGA7OV1aJqhmKF9x6S8pmHSkpOTbI=;
        b=l44pI/WnLyK6xvfT5YGbswVVnOFpoG8N07EtSssEpSuMEsomts9BqX3cd6I/NfmVQs
         LcFTuNrOiCjDHNT2+oZCI/VgdZHUFrXoBR+Zl8FgkijHCef5UfUHeMFQllBK4xkqT9s+
         m6i40hdKc9K5whxsAmgu0vRIvc7qnejs4GD5xkBuxArNEzaHf1XMlWDpeT+3MOCylYuO
         iAx3CMLKHNF+GhS0mKmHnnzgAY8xQqWKF/GX3kwAVNDlS+nelIbwFYKergT9Cn+WtXpg
         6GcxlaO0/rzvZLBnsF3pGAEbsYbhAmgD9//VlqM9PI6IEzTKMmOcMLlPm4sjXhQ+Dvk1
         389Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101444; x=1760706244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUep6nRJRENnGzYGA7OV1aJqhmKF9x6S8pmHSkpOTbI=;
        b=diK0z/kmeoSnEzJE4mUQwQ35qBf0Nv1BxGdJtYVO9yYlIVZJvsJW8mnnpgUhB4yenJ
         IWDgIQGpalxkMsuwg2meU0OMkknRCbAzdAGbt4p4cj3hdwIcnHUBjz0wWr7b5B5xpTOW
         dvzbInDuxKVipwJIJQMnV1eLdidslh5vNxvT8yex+eQyq0cwW+801jfT9a/HvbhnUHCc
         U7ZbgvI6tSMXGKJdyAT/xINIO4uox1hSYKmUDvxnA3IWd8+TqvVh2oTDy84wVI8aJVOT
         Upv1ExrVakzxn62Bk6Jd0riyvNhzA/cH+lePu/Fq8MUm6RZADqIeruUna1EyvR4hTOK6
         tCKg==
X-Forwarded-Encrypted: i=1; AJvYcCUlskBlwWt/8PUVNUfimgtYTz1uoKMEMX68fY1k5tvBYszKr6Cq4q31HBsWepcRS8Iw1Xc3ETDMoDTKf2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsPJBXJqFBcUJLa4a3r7JZgKF0X/I/zU9JboAegYs7x2f5Sht
	qTaFIcoVk1PoKWtzjaZaN9x/yCir2zrAwxViitbNp1npvyT5EgpH78io
X-Gm-Gg: ASbGnctGGxr1re8eVSsojKF+f0YFTAKjJcO0HY4MGw03KUFKNPG/Tai6i1ru/+KH1Fo
	ikHwM9E5QyhA/UgQWkL7pJn89CjJvt80EvAua2+CkMwUh+R8EU8qa1xZw2Wn0lZZ3vY+PKISGhy
	qQLBOdWM9q1KZgur+Cva9dFjnzgJ3SEYCUcA0uLVQC//mC/5A2hbMiB1L8evPO6RD6SS9aIYgGo
	hxERMmZqatrYkLjl3hB6dQg4n3wc0l1NeTHxxguihGPNPrmL8OZEr5YGJCmssWf7Tsm5UMCRRC9
	JB+Y5cqRjXMGp8rrnJxWyKwsLe1/ZeKsQxcf67C7iNLFWl4/ALyB74cFv/dgKX93W875+74l9zQ
	76WTt0M3FJYm38G3hX6aD90WxfA7QiL1c+IqCDFpQzlE4cCL9c7rjPFMNLZi0ZZTsoExAwG2N5v
	rubLapR2kAsKEcTani2qFvGJHXgIUqNsy2rqh4G4c=
X-Google-Smtp-Source: AGHT+IE/ARTh5Bc+/UOnITq0Iw6DNobv8+7UuMp4WV8aSSdfi9Oc51R8SOVJL7vW64ESh0Zm/tV/Gg==
X-Received: by 2002:a05:600c:6011:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-46fa28bbca1mr81018285e9.0.1760101443287;
        Fri, 10 Oct 2025 06:04:03 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb48a6069sm46763055e9.20.2025.10.10.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:04:01 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:03:59 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Prathamesh Shete <pshete@nvidia.com>, Nathan Hartman <nhartman@nvidia.com>
Subject: Re: [PATCH v4 2/2] gpio: tegra186: Add support for Tegra410
Message-ID: <jcfsvqesvpvip3gj5gu625khah3as64lohpevjco5v5mlpekss@tq7u2g4iewsi>
References: <20251010101331.712553-1-kkartik@nvidia.com>
 <20251010101331.712553-2-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y3y5hlym57ezrkmm"
Content-Disposition: inline
In-Reply-To: <20251010101331.712553-2-kkartik@nvidia.com>


--y3y5hlym57ezrkmm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] gpio: tegra186: Add support for Tegra410
MIME-Version: 1.0

On Fri, Oct 10, 2025 at 03:43:31PM +0530, Kartik Rajput wrote:
> From: Prathamesh Shete <pshete@nvidia.com>
>=20
> Extend the existing Tegra186 GPIO controller driver with support for
> the GPIO controller found on Tegra410. Tegra410 supports two GPIO
> controllers referred to as 'COMPUTE' and 'SYSTEM'.
>=20
> Co-developed-by: Nathan Hartman <nhartman@nvidia.com>
> Signed-off-by: Nathan Hartman <nhartman@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> ---
> v3 -> v4:
> 	* Remove TEGRA410_COMPUTE_GPIO and TEGRA410_SYSTEM_GPIO macros
> 	  as they are not used.
> v2 -> v3:
>         * Add a generic TEGRA_GPIO_PORT macro and use it to define
>           TEGRA410_COMPUTE_GPIO_PORT and TEGRA410_SYSTEM_GPIO_PORT.
> v1 -> v2:
>         * Move Tegra410 GPIO Ports definition to gpio-tegra186.c
>         * Rename Tegra410 Main GPIO as System GPIO.
>         * Add Compute GPIOs.
>         * Update ACPI IDs.
>         * Set instance ID as 0 for SYSTEM and COMPUTE GPIOs.
>         * Added Nathan as co-author for adding compute GPIO support
>           and renaming MAIN GPIOs as SYSTEM GPIOs.
> ---
>  drivers/gpio/gpio-tegra186.c | 76 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--y3y5hlym57ezrkmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjpBD8ACgkQ3SOs138+
s6F57w//URrSrOC1Q7LkrOnqIzjycY+wbsk0E8W+eaDuBt6RlP8R2EyPUquLTKRf
NtBFtLaGjCwTcUpmOzD0gzlwY/Jjre3OeSZtLdkuwzcmeR8b/BCjz0h/1CXKroF7
bB8RFJ+Y+i7czGr6J965DjYGw0Ou/rHBQuoi1Ah8AHLGGk1FqgARILV2O/EE+t97
5gzuqqSkNAeacMb2tZzvObGVK6VXUNtaUBSkZU7N+tbOcuzxq85JYN12vHr0VX/b
KoHOLsXFI6J0yECazzk333cxJq6GVJn3luT5L/QDQgqYglMuDX7sPs2PvS0cXyVp
51zp6npK1fNVbB5D0SxT7VOryPmU39H48vnFWkLF7v1Ty/YS+f7jpBUJX+mYVc09
hVXChW8UdvQ8EKeEALrzhJ0iVRGeamYoaAyaOigbgcN9NI6mX08QeD6VmmY7vncF
wk6cxt0d9WRXOlOdTbhpWpEXocy/y8ulEV5nxI6xQhqatRIh+BEmNIc3G+cCjJIy
XTa7p+u6JA54DBU5JHJVILDReNb395cY4+yoVDbCxBqTuypzuV4ovLII6ZYNr5GY
3jzlsU27Q3cljqkbcHEbpg2GmkK/cu9u9AA8N6vb8ggzLdwUOS0JAPKVKEw2DaRk
oL4mi+DfX587Tgv5NUdrPNF8vrQM4cpwyAsbIKbuwbwz0xIShec=
=ZcE3
-----END PGP SIGNATURE-----

--y3y5hlym57ezrkmm--

