Return-Path: <linux-kernel+bounces-879294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9990C22C54
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF133B5BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3C7081F;
	Fri, 31 Oct 2025 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L636SIob"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB013BB4A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869550; cv=none; b=pL497RIUBGI7o1EcmCIPKyCzMXh6MHMGKdHrIjkWiG2ey0GnrFOSI1PdYJdEEnW8TNgQu0cMiDv6EY/gvcZmKMrzqptp/dklSaC+jgu10YjO9OGX4M2taOeBCoxQec/Eg0ecIU36aWRxmEwnrWIxvf7R+CZ1eAEkia/RfjJOfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869550; c=relaxed/simple;
	bh=OYK7bpF90lUBkVSRihAcXGkmo5r7+CiEUhECu7W7zAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvlPUZkr+0FJjg7bICWaTXueWNpb2L9zofD0SB3L4pQ1h3DACJNNAY3PIw1a/8HjanJ1RXUvG8V5/Jlmhi8KmAhfZP0pu27y+KwLLkpsrxxqzf3mu6DUJBk9TmccNcXexePmMcZ6IBbMKUA71DaVVZBF9HA7q2w3Y9QLVZzx27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L636SIob; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a4176547bfso1644157b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761869549; x=1762474349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYK7bpF90lUBkVSRihAcXGkmo5r7+CiEUhECu7W7zAk=;
        b=L636SIobdL2UixK1IuXhxEmq7xtobqXFvSWEFpLDY3aC+0duRTEf+QCaZoglEVPVAZ
         j2qvkc3vZVuLnhAVSZLUKiF5I+q0l+NmrhnzDWfesXwPo8oW2b5vI9WVhBqjpSqTJxxf
         qDYFBGt50p6coNPWg2Q8XfMFxRbmaLnqmR945FRjHSMrFD8pei5nXomNhdPz2p0UaIvl
         4icEKdboffpA5g9G4fezmBCbybU2gkVUKxDAcd0wME393v/kcRyOr2gl5Hnrtbwy1Q/P
         e5+MMrscHOuTkxj79t6VjKMD5bPHJQfrfTCS+eEstcxVQSUZ+k0QNEoem/Afudf4TG2x
         A/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761869549; x=1762474349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYK7bpF90lUBkVSRihAcXGkmo5r7+CiEUhECu7W7zAk=;
        b=JjMyMZlU+HHqjpJ4lIJimSAbh5aKP0Nk4R4GK2oHJpndg4G+N/6we0XL9rxJqghsfE
         r9hC5UF0FIz75bkUxNs+1f8jwWdR40c3p74rkzKKfY3mI0Hzu3Ke3cc9KIGjxIh5kncx
         JGNiBZeqT/5Uwu+SjBWE6S9YTN8GCA0jvNCgi5Ui3Ye0uWoSO5+7/CTHHZsP++M8Vv4g
         cL8kXwFVsz6BeZ5oyOzm7CxvWjih6FVaUNbeJk3ddrHOAmp4eCQPSxU0AOPaWvOHiO7y
         SejVoBUdJoRR22qfNJCq/07SMtyB1ppICg7rpFNuafG6HiKKgQsXHoh+WL5Ay/7zd76O
         VsTA==
X-Gm-Message-State: AOJu0YwpL+8Hf+FwqLkhkTZ10sdYNupMimt5gDmR8uO/eLl4mY1RhJ6o
	meNWN2G0YMoObggSpcl72aJ1q3zl/dY48St03lyxQ/daXjMWYgemXA5CqBiXYOHWBHk=
X-Gm-Gg: ASbGncse27nShff4gEmiPlZPwo77YkvXRQwMvFoIddsr3I/crudBo3A6p3Ig8m5IPAQ
	hBD26m4D5sSIUW6EOGR3RWg3vGnK/Xmm9CZcvgvRa2+J+paaudrlMyPkA1mJDe78BeOJY9Kn1Mr
	wG2t3GERVKe/af6g5ywWY9EiQACTmou8xatlisBtwSoVVSjF/Kwwpvl09VQUVCcFwjJ7fdW+lkq
	eMwZj2A0wxB3aNFF4UvWflx1CrS6/fzvNNlkdf4tdkxt1jAn7ejz2M45J/7KmuLS8FnCWQ//TXv
	T1vtJuetAa4jPSdCmM87UQiWrbXUuUKt/gxChw6B+bBPBtHf/eAuJ9MTIF7eu4T6/YUX/s5yTa0
	N+Tng3kdeZv6H+7KZYKOID8slmG34ISOo+OXamhbjwYg4/Bzy5iCAFSlod+SytV84gsLdQ5J/lL
	I6+ouy04LXs1Y=
X-Google-Smtp-Source: AGHT+IELexDJlzNWfGl/5+vJtbg1Bsn4ue6Mg8eRWqqle2QVF1oB4UwzGk4VnwtZwT73neTtyqbuCg==
X-Received: by 2002:a05:6a00:4f88:b0:77f:50df:df31 with SMTP id d2e1a72fcca58-7a778fdf48emr1109262b3a.20.1761869548554;
        Thu, 30 Oct 2025 17:12:28 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm52953b3a.60.2025.10.30.17.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 17:12:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3242D4209E4A; Fri, 31 Oct 2025 07:12:25 +0700 (WIB)
Date: Fri, 31 Oct 2025 07:12:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next 6/6] MAINTAINERS: Add entry for XFRM
 documentation
Message-ID: <aQP-6eQdFIN1wjNe@archie.me>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
 <20251029082615.39518-7-bagasdotme@gmail.com>
 <aQMd886miv39BEPC@secunet.com>
 <20251030084158.61455ddc@kernel.org>
 <20251030084412.5f4dc096@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gb1uviwcsJe1v/2q"
Content-Disposition: inline
In-Reply-To: <20251030084412.5f4dc096@kernel.org>


--gb1uviwcsJe1v/2q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 08:44:12AM -0700, Jakub Kicinski wrote:
> I take back the "Awaiting Upstream" part. This set conflicts with=20
> the big ToC tree reorg patch. Let's either merge this into net-next=20
> or wait for trees to re-sync?

You mean this one [1]? If so, I'm happy for this series to go first then
I can respin the toctree patch.

Thanks.

[1]: https://lore.kernel.org/linux-doc/20251028113923.41932-2-bagasdotme@gm=
ail.com/

--=20
An old man doll... just what I always wanted! - Clara

--gb1uviwcsJe1v/2q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQP+6AAKCRD2uYlJVVFO
o3uiAQCn2eApnNdhBoCFHbk7RH6C5AfjOnHJrOx3QrAwPi2Y0gD+JoziL/V8KP3c
BLsmoE9RWhrc7eMxcBlNU7LoiJxtaws=
=oq6K
-----END PGP SIGNATURE-----

--gb1uviwcsJe1v/2q--

