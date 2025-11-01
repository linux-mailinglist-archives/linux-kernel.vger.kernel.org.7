Return-Path: <linux-kernel+bounces-881187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79080C27AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EB51A26A36
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51FD2BE7D5;
	Sat,  1 Nov 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsEDrVzY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9BD27E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988484; cv=none; b=NBQjAV/u2ynIjUdtRkvCjLqEoe/vstahGBxq+fRGeDioIsOAa9r9NqU3YZSIO9TsiJK2AwrP7J1hKTPDA2TrR0hnMaTUHZCCRH2ISp090qaWxF4m8LM/A3tHWsZeAijO7Mcto7MlLne/+4HqLbc4yB4Rt3aSYaNmvgJRzBcVTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988484; c=relaxed/simple;
	bh=bcrlFnjZggziM0QjMVr/YX7dISMIrIzKScqkwXuRVEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvvzD+NCSWxEpHFujhvPAxkwZuBM3T3J0yVGCYa6LddMgHJTG/NuHOxjGIhTs7Gp4x9X/rWQ0pUgH2/+zcg5w15khwOVAdTH/crTlZHjfMTNyF1lkntGu6ORUaMqnIIF55C6TE/YzyPccvw+gTpQ34pgFcb/nxXfMO5xcKzKpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsEDrVzY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso514264366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761988481; x=1762593281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjIH77hSFGTlPjPYXJoBf9VYrU+klsU2kyIOYwEmpag=;
        b=ZsEDrVzY2Sw7IOsPUFyPEquNjVCBKVmnWv8CvhQqnIXQeq+H3BHzFJk06V8dJmX8mx
         jUzED/yole49OUO3wPQB0SMnFsN50Zamz40+5u+uNNBJliE53/Xs7rsTJad/myMNzX8Z
         ykkrhhTowNOpP4XGqdNiyNmrWmcDHv4sfPLVAtFzeren6yPOTsC9AAIKn2vwcC0A4BMn
         k2urr8yCc4mpTKmaOkm41WP0ajzsZxl7YlymErFfc+6AuG5o3mOcng0R2tIFg0Aaaj1x
         C0NJhhVAkAlGbDWnFmeWjNGXXcbYOCN5ILwgK1CNa9uW5ijjQVnOtkoSOxN0zvTskwsS
         CX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761988481; x=1762593281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjIH77hSFGTlPjPYXJoBf9VYrU+klsU2kyIOYwEmpag=;
        b=KcbBy4zutYjZ9KymPZuJrcotE1YQWNZJipGYTzJiHDwhuyk3pBrMaQ9sjoQp2X5Ark
         lkbqIdx+d/N12cEOLC0MTRxHD7jRoePhFE1hZlk8ANj5bc3FVWfff8kgBAoveVCKz3rD
         nDYn/mW87KNTaz7nB1LpYZh1lgtfD4eh70Ky2X2sM9VThyir93KEK1Ahrm3jO/fcRFJt
         lFTc2KVrL2oGmXgffTSjfg6A9swV8Tcc8WPXl0lPUIOZtXQZO3XgyHTJ2Nya7pvaZshj
         w5UxO2i3FmF4zJ/pmvPk9HPcstsbu4T31x+0uAlSYpH505DuNt5eemJVqN0CYChX4smZ
         iL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfMdoideFqn4ZvSZ3U+u4gZ38bPpnsu7yIQEPaEyLjKYuQb3KGpHn/i5Pc9qwre0RNGTyuceyc00GmV1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6uIRMr8s5r9IsL0I5iYk7zy/q56OIsfhV3n4phaNSDgcr6FV
	dZ7J86UbWA7/P0MPW0At+CGfa+D/qT/oY5Fuunn7jOlaEaRuysKCeZUb
X-Gm-Gg: ASbGnctikNLy/tm5we1wcWQ8Qgu5YBl7KZ0vj+/QWLHx3o2QaFp8iF5dJmfuRl9Q/Mi
	DTqgvKBfKiy5qKMzTGYvTLT3f+MgFNeWhUyEHVPF2MJLRExHw7QFoUsdJ3Ls3t/KvyaG7mRR0Tn
	kQOYMVOILaFq5zMwVNktt7ktSD2t6oyxP948bsD659DLEgKRPgzl8mVk8wnehcWwx8u3JPQ6DJO
	s2HdVULT58wYz5vWfOSYdw4VPs+6alqPPNeYPpi4KIUjGIuF/wnontTnY6S77Zrb/ubsrrUCweG
	t4A7b4/gndc5JBKgw+QoBX+0jCfxWpRLjVIb5WOXD2gjKJND2Ag6+MIgx3Z0JhozyAHuWpmxvIV
	gc/4luHY02/6ZIA4ZXpkUFEFZtTdJSFPUxTEeD2dukLyp+ZH2txM0lIAFeaRK8Yjqglu420/Agd
	jKyM/b2C6BrVc=
X-Google-Smtp-Source: AGHT+IE4m8jWVnUeKVDtexD4VIUk1rWLovwGz6eGHJUc/54gMaEdRZBIb1qgJ3mc6oZKZWsrxXePlQ==
X-Received: by 2002:a17:907:3f82:b0:b6d:2773:3dcb with SMTP id a640c23a62f3a-b7070138988mr589022366b.14.1761988480766;
        Sat, 01 Nov 2025 02:14:40 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779a92c9sm409785466b.22.2025.11.01.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:14:39 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9B9D14209E50; Sat, 01 Nov 2025 16:14:35 +0700 (WIB)
Date: Sat, 1 Nov 2025 16:14:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next 0/6] xfrm docs update
Message-ID: <aQXPe49BkkZ1W1uM@archie.me>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
 <7148e00e-14c4-4eb7-a940-112e86902bc2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6h14tAqlT9+a5/Iu"
Content-Disposition: inline
In-Reply-To: <7148e00e-14c4-4eb7-a940-112e86902bc2@infradead.org>


--6h14tAqlT9+a5/Iu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 09:58:33PM -0700, Randy Dunlap wrote:
> OK, one small nit. 3 of the section headings end with ':'
> that should not be there.  See xfrm/index.html:
>=20
> XFRM Framework
> XFRM device - offloading the IPsec computations
>   Overview
>   Callbacks to implement
>   Flow
> XFRM proc - /proc/net/xfrm_* files
> Transformation Statistics
> XFRM sync
>   1) Message Structure
>   2) TLVS reflect the different parameters:
>   3) Default configurations for the parameters:
>   4) Message types
>   Exceptions to threshold settings
> XFRM Syscall
>   /proc/sys/net/core/xfrm_* Variables:

Sure, I'll clean them up in v2.

>=20
> Oh, and could/should
>   Exceptions to threshold settings
> be numbered, 5) ? It looks odd to be unnumbered.

Ack.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6h14tAqlT9+a5/Iu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQXPdwAKCRD2uYlJVVFO
o7MJAP9oppzWwRobyPNTMy/S+a83Bl9LCyQUEYE9ompFmbp8rQD+PNBr+LTiJ8ac
5XEpfnhav7RYgjmpzWnVM2z5LwA5agY=
=jv2q
-----END PGP SIGNATURE-----

--6h14tAqlT9+a5/Iu--

