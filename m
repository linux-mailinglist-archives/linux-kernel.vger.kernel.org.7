Return-Path: <linux-kernel+bounces-887498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F5BC385FE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 325174EC921
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B42F5473;
	Wed,  5 Nov 2025 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWw1J20y"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB8259CAF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385560; cv=none; b=CiMPp41hYTJ5euMozp67+12YPLpW5t0iYUvE1NSM7l7YXf1VbZfeWSL0cK6gFPvCwphBRN9VxhSw+wIEKp6yptbfLoaaprrXN2L2Mma/GICKgqYiNQeZ9NZFlBAwvmZPoEPn63ZLJ3IYEnS987dqBUlJJsz/1hSE+oxJpqGaXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385560; c=relaxed/simple;
	bh=vnTm+ozSRZaCK9bpPSSeJvTXgMs06nW1kYwVBeO3ndE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYocUDVBDd9AxUN2kexkLaE2Fj74S2sgGRzpbjm/ry49my/hyMJFRRTiHp4aG3XD57vit8MFMbkX9FfFX4OmMh6Ml29czVH5pXyfrNlcUOVf2puzmvaJyHFwRtheNXk4k0E3R82Cl5Aub3Oc+V86ePW61wNGS3VB7YpNhmScj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWw1J20y; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-341c68c953bso540408a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385558; x=1762990358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnTm+ozSRZaCK9bpPSSeJvTXgMs06nW1kYwVBeO3ndE=;
        b=FWw1J20yRloskHdSuQWug5keqgd/8WSM/HclUUIknagWX4nXL+HnS9SzgtDPAhTiTA
         MfxUQoE4wh3xS/TZGb/eMkxvuzI9RMOR23MLwdJgevFkv6obOvbUnA/JgX5FTgOTqOVH
         B4ULf/UgKoE5kbXlQ/y9io0kOwJI+ZFhohcY9mdc2lNwY37Y0Z6rbimuOQCnGKlwhuYA
         TgEDHAxCR4AcFprtUMwUAf46Lm2Y02V8K32mpfXIcfVhfmQHSgpzRnxOmhXIBCLjvi6L
         ppQOj80IDomIQiZ2dQvGHJ+MgoL84yuFJOvGmIxY7czD0Fa19/p4z5Usms35sBGNcX0j
         berw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385558; x=1762990358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnTm+ozSRZaCK9bpPSSeJvTXgMs06nW1kYwVBeO3ndE=;
        b=ued0T1x/jzuTe3rH36OJiV8myXd717uTRUd5V+qNs4VPIBSvpc3Oy6ClIw4nVK4bfo
         GwHtb6qs3Y5LrP9I9ZNTMxRBavpfm+OClXQ0VtCsl3oLvTVLRwimxzLN1jryAUUX6OI1
         ai3/zDIXuS7pHhY0gFKLA15FgMVmOQfUR65iehmdBFE4tI0ITlKJZ7t7KRXwVBw75/mS
         mGNPjMlN3qt7dBufya4xW1wNuHsdx2hTb7V0h53H19/XPAL1blLg4WgLElPZQQe7e0ID
         GUZEonoSSQ9B9QuV0I9xWX77Euhkz9GJI7+Erpb0JYNjwCY1lEofMf1pmn+tWv3jdaGd
         Pc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDgoixNaBGHKx9zrZ78PFq6KaEHfYe7Y8dNZy9xA71Hubiges8CifkOjT/cTpmD5eriI+4wa8sGYJHcVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyonbn4+EVijHCWgqht4554v48AVsd4BNa9ZYQxLO7/2CS4pu+
	6RSXW+fHTpOmF79LrIuBtFee7UljsD5F06XlKCzG4jo/fwLOqne2PauU
X-Gm-Gg: ASbGncsiyLxLn780oGIxDslWwIyahW9eo5yiQnOpPAc+Xik52Jf2NZwsv/bTSlJxXC/
	UhA+uV56I82xsKaRR38fZ2mhWA4hV4GloEqpF49HJa1IVKG8qw/xzuVpGd0gE23RUDZUJeVHbkE
	eYZWiMTtqehRblG2PYcdN+7zI0i+iGY+ncBZA/v17AflSnT8j0xi5vE3lZYwrvVdSXIeBvWAIRu
	rmdNkqYUabbEdnedmPpXQ14bXUgZuc/DtlOmmxDsHZBlvIl469cUKRlRhwG2nqeTs+nlOKzpykZ
	V5IFviKGtxfe6a14RcUkby+QoInjYtIh2db+k6h41aiX8i4BCbuih75YTOJQ4Pgw6Pxwmdm8IS9
	flcZZF2rIhXaAIAFukLuFVSRq8Jl+tpszsOGlVAxc8Qn7E9m5iq+AwgTmLPYfM2FtNZfAs5XWod
	PrGT6tocphN90=
X-Google-Smtp-Source: AGHT+IEhPmuR4erigmmxR9eFUPzgSmw6sxAsUVA7h4flt4tHbzQCGMOXFc5w95RmdKQlTP3Q4hRRPA==
X-Received: by 2002:a17:902:d4c7:b0:292:fe19:8896 with SMTP id d9443c01a7336-2962add623emr67834225ad.52.1762385558111;
        Wed, 05 Nov 2025 15:32:38 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c5ccsm6499405ad.57.2025.11.05.15.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:32:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DC583420A685; Thu, 06 Nov 2025 06:32:29 +0700 (WIB)
Date: Thu, 6 Nov 2025 06:32:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 01/14] ipvlan: Preparation to support mac-nat
Message-ID: <aQvejbf52_GDs9vn@archie.me>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-2-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aE3/3REKYeQ2PROd"
Content-Disposition: inline
In-Reply-To: <20251105161450.1730216-2-skorodumov.dmitry@huawei.com>


--aE3/3REKYeQ2PROd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 07:14:37PM +0300, Dmitry Skorodumov wrote:
> +4.4 L2_MACNAT mode:
> +-------------

Please match section underline length to the heading text.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--aE3/3REKYeQ2PROd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQvejQAKCRD2uYlJVVFO
owVcAQDm0PZzhhqLqUC27UoEFbWfodx6ifxImkkq/tQWbG9OwQD/XNmP5oJqoktv
FtqxdYVTu3c9wN0sp329mXF1ZLKppAk=
=OcFx
-----END PGP SIGNATURE-----

--aE3/3REKYeQ2PROd--

