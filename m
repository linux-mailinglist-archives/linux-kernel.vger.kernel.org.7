Return-Path: <linux-kernel+bounces-863972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A81BF9A17
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109EA3A8D67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0E201113;
	Wed, 22 Oct 2025 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg57tflv"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AD1DF979
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097444; cv=none; b=U+Dk8sGlpuEP6iAKw8OWS9Bzasf8n+CTKoSjt6T6LmMMjj2Yc+In0MXVR8tIxJkEGTlZx9/wjdrxCMsXPwKJJ+/rxU9e6NFyebvLQNG929Eyh08F/C35yPYbS6Lah9zNB9HOQS+0DglL+DCfQRqb9gXoXrnvKoRrSQ9c7kpHrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097444; c=relaxed/simple;
	bh=DUuLbrrzupAYsLMVgQOeE0uyJfDJbicP/UZO1h7DRtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/+cyobTBCZUWPAE8+OqpgtkdCJFuKOAQL7ilmf312Q3CJS7Wdxb3rI9ZzhbiksguRn55u7xTZWshFnXZ4NSF0FFmiRGWOAOcWvMVFRUhslyebU4YPfGFaQAdevnKUF8RHp7l6sRSm3jidbYrEpVIB4fbi7ImM1PE+YP6s1uOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg57tflv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7833765433cso7869659b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761097442; x=1761702242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9onf5CBmbSk29wszlhfpjcFikIXhbvWOl4PnOQkDlo=;
        b=cg57tflvIcbgIi+ywEF1kVUBPJwpxRPg57jNRB/UnKEAFwgFlizV9ye/ATPKB8U9HU
         5L6fI+7SuV6nI41LYOg7at+jlmfmDIW/zcVkBL+qT2GL+YwvYVAf9NRTeyYSIVSYyuL0
         g3HH79jQbiAPXIR4DDQfpBgkKJj5bKsYFG1u1jo2VWC1NsQQdwWzLxpQf0CZYcUCUQgl
         Skfo9wskDRafcpdKXt74x1z/0P5GW5T0UFqCeuiGksaB3+kk/NMhqFqViOo9MgxnKyCu
         S2wKeXHkb6Nd8sM0Kq/hP/jfTjm+aViM6a/gurJrfuPwwwEddRvRxF7NcjQtYx183u7U
         gGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761097442; x=1761702242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9onf5CBmbSk29wszlhfpjcFikIXhbvWOl4PnOQkDlo=;
        b=FFUMyHkDvyw4JJ4SRVwEObZHz8Ln9mua9G5bxrsmFcLOusImE4/fTb8WYCQ5Z3VU26
         bDVr/yhM5893dd0YQRo7rxOFfYHOH85HDGKo8zgIAqPk/rAsfbUTKH9FE+iZA0ZEgUEd
         +LPNwX36rVYhbzgidVpIOMl0acRIPi9lFLfTct03dFvXDOgLt6tjQYc8LgfcrRDWdeVq
         Nd8be3Ikf+x9qsF+08RuG5Qud+R3dbzNAoZ9y1wKqtaLy52t4LuTKg5niFogcEvsMXQM
         2woBN53jyUhzEObHB0YgcLl+V0/LGuwbbUyWbvMGtWfP6IF0B4wQR2YxcvI3SlEEm2AR
         tJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSm0kSQWcdTKm2Do5tVxiNy45htZ7KIIaOft7o0HA8A/igsgcbCbJl1hiqF2mdq89JmjZbaNETV/0KIaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNmCruATnigE1pgGdnYG/x9PcqiCrquxnzI0FCfSoiw6hUarW
	6fthDWabrXzzn00mSAUYe3Y6P33yBgr/6M0PCRWdSk3en4GG8rZVVm6x
X-Gm-Gg: ASbGnctOFLDKZDPFYlMGdc4eBRr20tnxB/zsBwOnEg1ajgAxh3g3w//aHJSyBJAqNiV
	MAOXOWcbvzcYyegujgqMuh6pRjNtlleJTjfpYdd7Z0s3fs4hLykTm55FBn7tXbyT9HdIKU3nkgy
	MVtf5pnWSw64E7sLHJw3Lu32fufBdb1sgsxtW1s7Z6BL8T+D/EJfTXDHJ67enM8qCA0zLAlUyCW
	n9KzwxhM/MamtTXTxooiOFSF51NO4X+jup1UjAp7M1UZ3GOGlwvfNmVxXHbyOOvUKaRMzX365gr
	PfdS9haQs1zcfBi3+cnpom1hLxFb0o7gG0gkCja+kIelsY5jR6JpOFCAesKnbZemnLviUVhsbkn
	y28Y1yvDCxX6k3sgnl6buOQDJfO3rGwuxBMDixkAcMw3FOTkgiTdiQ51A1rfUwVSFJElTkIdENL
	H25e5xqyiKRiW0
X-Google-Smtp-Source: AGHT+IHulmK78/tDjF6qU3+kx2KCP7ODYLsRFIvylR8jvaOVGxcaG7BUiBMgRTf0SD5dvUFXuEiNXg==
X-Received: by 2002:a05:6a20:5493:b0:334:84f7:5646 with SMTP id adf61e73a8af0-334a8650262mr27706829637.58.1761097442076;
        Tue, 21 Oct 2025 18:44:02 -0700 (PDT)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301211besm12631232b3a.68.2025.10.21.18.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 18:44:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DA1874209E4B; Wed, 22 Oct 2025 08:43:57 +0700 (WIB)
Date: Wed, 22 Oct 2025 08:43:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH 3/7] docs: gpu: nova-core: Document GSP RPC message queue
 architecture
Message-ID: <aPg23d8wF6iVaWmv@archie.me>
References: <20251020185539.49986-1-joelagnelf@nvidia.com>
 <20251020185539.49986-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iAC4hEmvDvNxfLM9"
Content-Disposition: inline
In-Reply-To: <20251020185539.49986-4-joelagnelf@nvidia.com>


--iAC4hEmvDvNxfLM9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 02:55:35PM -0400, Joel Fernandes wrote:
> +The split read/write pointer design allows bidirectional communication b=
etween the
> +CPU and GSP without synchronization (if it were a shared queue), for exa=
mple, the
                                        as if it is
> +following diagram illustrates pointer updates, when CPU sends message to=
 GSP::
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--iAC4hEmvDvNxfLM9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPg22QAKCRD2uYlJVVFO
o7HnAP4u7KGRLbe+oCN/YmXK+pEcCGjInjoec1YU6PfZzmPKqQD9E7LICAzFtTAr
gFlcqzOanE9DrhfypJiAcTm9yVs4rA0=
=gCXr
-----END PGP SIGNATURE-----

--iAC4hEmvDvNxfLM9--

