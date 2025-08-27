Return-Path: <linux-kernel+bounces-787532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B116FB3778F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2583BC684
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332C1F2B8D;
	Wed, 27 Aug 2025 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20230601.gappssmtp.com header.i=@manifault-com.20230601.gappssmtp.com header.b="jG0E6kcY"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA01E5705
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260650; cv=none; b=GR/OHv9BO0OoN0dpRXNwkHAxcGnxSUl5JfciA9dbF+LWPIcei+LxNa39TpmTWRjvsvN6scVsQ+vUUB7XiBK8omvGibs9FGpUmi74BJG6lc8DZA9rgvH63TNL7YIE+DgkqKL3KoRNtcEYoOjMI9WVwYaZX2wANYhHS+ZVp+iLQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260650; c=relaxed/simple;
	bh=D9/sWfBiW6mkU+rH9awTtCDdwHOVLON3nmyyIGkNOy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh15994agujRo8ruqvAYZaNpOQ9jhFrMwhczw9bzvxXaaoQNSPH+0z/PhvS6yuTAsemyaq0m2kaWzEunb4h5P/Oaxi6TRkrZE1dG4PIgyydwzKFGfZQtw80XrgPB+4cKzow1i+sb8OcuwviDQi8ZINU2ASsEmpIo8UoRR4hEA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20230601.gappssmtp.com header.i=@manifault-com.20230601.gappssmtp.com header.b=jG0E6kcY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ee6485e7d7so17274805ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20230601.gappssmtp.com; s=20230601; t=1756260648; x=1756865448; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9/sWfBiW6mkU+rH9awTtCDdwHOVLON3nmyyIGkNOy4=;
        b=jG0E6kcYE5bUp33x/9Yrit1cSYvNaHQjA7mawPRhdsXudwBj4MY1fAfnyS+9EwUGrs
         mPx3CpxRMK3g0ZEb/og5N3IhJSxpFMK9RHN4UAPy421F//2vDi16yLYg85uoX6tAS+kH
         fJoQEchH3kBNDPoxcdqTn6TUxZQjv++4UcYtYz/MSXzTpq8eAbM+AbWZC8OBOz6umrmR
         jiGlUc72RTrvVsS2RuT0JFt1zlaImyuoSTo324Y5jxtBF6Y+PWk7PuwtI0Maksrp4Xy9
         T3FdZRPQk4+sVvtST/g403gzYviNhzXCn/5NVgAM8pHJuv2ZO/VQG8wS6XyXnyNAoF2/
         dXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756260648; x=1756865448;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9/sWfBiW6mkU+rH9awTtCDdwHOVLON3nmyyIGkNOy4=;
        b=vUqDU9RdO5inUtiapv1TqzBIyrHhuH9/7fi6wbBzoGHvoxH6oIgeYyuO8hZySzKlad
         4qtzjrx0eBBFsZa4QQFBJRkZ+pun+h2R4ofIiZmbe+O4ncbE7zgQNeAQtphYOi9PCIrc
         KenNBqk7GbMtN3Ub5YWynfW1/HvBhmfiBbXFVeufuXmmAzGhMM0xcVkQd6TlWt2yQ1QF
         h9GdbCnRDX6UQIyumKpuTUHiMLazbG1f0pCID6yR1AwXW7ETWTnY8YAVs7QI9Ch1JtT2
         tDAhTtmDjiT9kgtYJ3pHEB4e9g7hc6/xk6/tXiwxfLLcoW0S59+tXE0eHbM6ctooNuts
         QY2g==
X-Forwarded-Encrypted: i=1; AJvYcCW7B2hUM9fpMnPgLKMfYNZTjXapoHAbOwzVB5PkGYvS4A/edI+EtyW61J4Gtj3z1CwTYqmNFztYEl4yfSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWeETafxYSNfKc4Y5BR/H4D4u9dxAdbaL4EScUWpVk0a1hq7pa
	zlvDoD+9xq4S4yLUWRT+phobyW6Ca7w2WC8CKtXAlViFDeJrNKZbG4n7M7T+D52j/yPk
X-Gm-Gg: ASbGncvu6pZXA7YM1m0FCJXxXc7LmHZUhvbRXq/Ey2MRFBlIu0Kya2moHUS0ldZjtTY
	9sMItLSPDIuBTL8vH2jm+sE3/N4xzkrJ+9GZqN5SVM96Y05LUfDAadrTWkuMTbV77M9C8KXm1bE
	l7qLCzj6ZTJBBOj0FZ3wNIMQ62IaAQXHnLVK/PBnxf6CCrOAp0+Obs5dEIFxz7RLmCZGnEIUDds
	SiozSZczo0qNPPCqsm9vbh0KKFuxJCrYzFYx4R8wE5m9YwbKKnTG7IYFfilSZ3KqcwCo9IFsEAM
	1ul4NEdlp9jMKgiuGPllHp0dkK/1TmGZO/FX35NqhsvyYKeOtwjOZ6tLf2jHxLmjdSETh1ZLKcw
	0Snb6GTNiX0WmDO5FY+nqBh1kQr2alDeF/rNEKa4hC1Yum/Xn2V2TewcdoREU
X-Google-Smtp-Source: AGHT+IGZ2fGfrnNOXzoUjFy+/a+JAYKd+HVWdNeFfzR1qbIpVkRyvWo5owB19e02agwFmwdVyEAp7A==
X-Received: by 2002:a05:6e02:1647:b0:3ec:555e:1341 with SMTP id e9e14a558f8ab-3ec555e14c1mr146793715ab.20.1756260648093;
        Tue, 26 Aug 2025 19:10:48 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ea4c75cfd7sm78885395ab.22.2025.08.26.19.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:10:47 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:10:46 -0500
From: David Vernet <void@manifault.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Message-ID: <4vfoqnabquaeeewaxqi6xuflha6c542or6vsiiuvfrgcmqbrli@yyeuhp45relh>
References: <20250822140553.46273-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iltknzzx5xj5qlrf"
Content-Disposition: inline
In-Reply-To: <20250822140553.46273-1-arighi@nvidia.com>
User-Agent: NeoMutt/20250510-dirty


--iltknzzx5xj5qlrf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
MIME-Version: 1.0

On Fri, Aug 22, 2025 at 04:05:53PM +0200, Andrea Righi wrote:
> Some distributions (e.g., CachyOS) support building the kernel with -O3,
> but doing so may break kfuncs, resulting in their symbols not being
> properly exported.
>=20
> In fact, with gcc -O3, some kfuncs may be optimized away despite being
> annotated as noinline. This happens because gcc can still clone the
> function during IPA optimizations, e.g., by duplicating or inlining it
> into callers, and then dropping the standalone symbol. This breaks BTF
> ID resolution since resolve_btfids relies on the presence of a global
> symbol for each kfunc.
>=20
> Currently, this is not an issue for upstream, because we don't allow
> building the kernel with -O3, but it may be safer to address it anyway,
> to prevent potential issues in the future if compilers become more
> aggressive with optimizations.
>=20
> Therefore, add __noclone to __bpf_kfunc to ensure kfuncs are never
> cloned and remain distinct, globally visible symbols, regardless of
> the optimization level.
>=20
> Fixes: 57e7c169cd6af ("bpf: Add __bpf_kfunc tag for marking kernel functi=
ons as kfuncs")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: David Vernet <void@manifault.com>

--iltknzzx5xj5qlrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCaK5pJQAKCRBZ5LhpZcTz
ZJ5cAP0RqXc8nswxXR8ZetRLblzGRS8/BE47jY9Y1rOe0ZXm5AEAy+qn1m1DQ5+N
wRhyf6IB5t12Om0L1I6prfc5H/WwBgw=
=2jk1
-----END PGP SIGNATURE-----

--iltknzzx5xj5qlrf--

