Return-Path: <linux-kernel+bounces-824037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED3B87F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32104526C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5693299AAA;
	Fri, 19 Sep 2025 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpMXdrC2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68749298CCF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758262386; cv=none; b=OxnTHq38vL/atTd1zuuMgkhSFq2YLzeFtapSwWhm3WW3M/iYULvAJFYcwxq6pfD1OZuS0lIjgQ1CkQ0epmXzmDKr1FpT9VUqjTlXTSTSFXaUa2o1OvEWuvsCupKHynZUEtD3EEfESr3/p7Z3cn1eKbAtqSxAE1eNVK1MPEJh7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758262386; c=relaxed/simple;
	bh=QaU0XZrFsINteJt0IIMDvEMBnerjNmnmQy4PXU2LX/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbSwn2n/S9xgRbTvr8z2alC6BTtSXnB3HfSlV02REiJJoWt1/78c/WsIPjn2Rqf08RY05mq648FpukEmB3pnADYzr7IWjlz3QRIzZEC2METzbH3pLuaky+4JKSjsunojxLPxT2ys34srJwOFU9CnfyXm1/o7DJCyVquPSOCVeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpMXdrC2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267dff524d1so12631155ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758262384; x=1758867184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaU0XZrFsINteJt0IIMDvEMBnerjNmnmQy4PXU2LX/E=;
        b=QpMXdrC25/0ld1j/5QNBgRE+YuuqHy5fapd4SXRjsQ5R70ZKw3W6AnOyBIQGLhPzHo
         2A9UNgCJeeiNiJluVYyiu6VGASblAxdpzryTbFtFLrslMqTrdb2av1qnONgcazarmCdT
         f/KrR+o/2xr0kfuo6ZusfFta8M6p0l8J2d+nOls+J6NuwdcG3t2vnN9TzM+HodxjwMAb
         WHwb9Ddt09wsKiDvjWBNLEsDQCSqmcZYFENhSWlk2x+wk/ztErbey/ivB1a4JahfpgMT
         vLNzuqnlg3DeCkHM8BUTHyftTGrsxhhyb5E+TRXvT+hBj3lmNT+WEeXCJeDoJOxgunUE
         yLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758262384; x=1758867184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaU0XZrFsINteJt0IIMDvEMBnerjNmnmQy4PXU2LX/E=;
        b=O8Oocig5aOWqRsYWAhQ7uMz9MbbEYfhfMOPLyJphTNCgGEd32M4P5lDMSOIJfxBQez
         ba2esXBVFB3D7KvkpSh9qn8xBUEnCs5i1aO4xB4NkY7Y509+mTOfeS3Hl+rGEwdbZ4W8
         eqJzFXXWfYKFyQy1pErO+/ITmknV3UaY9zTkNixdkVq3g91VzrVwm/VCzbPF8CbZanKI
         EJKYNrVpK3Zx1lYQpNqpnAdN/ScY2JhIp6AjlnCo04bayX27XHLoxcc38ByIWKEkk3Xm
         82PKg110YwkLNOZSDc8DAOw0nOKR5hqO7CHhCeZOJzMTjgQZkP5VdNT+1RoGhAy3o9RE
         rkwA==
X-Gm-Message-State: AOJu0YwrltkpnmOlvXwXURAotcHYePW6C0+LuaSCJUi4N9LV4A1gaill
	T1sHU3wTiwamQk2dTZXORPWSzSg3sXy0W64bm5FgqzZSnbR7/1XZmcLN
X-Gm-Gg: ASbGncshTp5nm+oDV9M1K4gmtLR8+gmpJix4Y3iyM5BkxgLoccc4O4RGb+yp9Wam/oE
	C6R/1STm+eOiaxtoeHZ7fCkzwOmDQzt2BaXjKh4reNGcgDLRgoOb0owqwgWZl/vb77Pk5AdwDSx
	OMFY1srbxXmiAmVlbmhffbl2fjyh4U8iBFVko0jvbFRnQXHMqCsbtrsRKKUf8IdYqCo17PRPhdv
	LLE+RkGz4/PWkOHKtNIxJEb/+5/VaokD+rfEA8/YvH2F7zPWwlmJsPv20YQncjaS2rpF/aISk2J
	v8dh47kyczPgrsvnjXgr1Vh2eNSgfu9TeoUy8x+j3axGdBe8dmi/QbaiI9uf8yQQT1HTRjigVWg
	B2xzwIBlro00nnx7S9x/QWheUH37H/VKI
X-Google-Smtp-Source: AGHT+IH1zlcrCsnnWY05Td89Szx91jOSar9oJ32+Ot2pPsbfIjo96otYgzFoT3ZIJABk2eJTuUWEZw==
X-Received: by 2002:a17:903:3850:b0:269:936c:88da with SMTP id d9443c01a7336-269ba53910bmr30423905ad.41.1758262383441;
        Thu, 18 Sep 2025 23:13:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5524c329e6sm368477a12.42.2025.09.18.23.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 23:13:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 32DDE4227234; Fri, 19 Sep 2025 13:13:00 +0700 (WIB)
Date: Fri, 19 Sep 2025 13:12:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 4/4] Documentation: cgroup-v2: Sync manual toctree
Message-ID: <aMz0a_7_8AfpwoWT@archie.me>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
 <20250915081942.25077-5-bagasdotme@gmail.com>
 <aMwtI44JEXFuNPA5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifSAKz44nzz4QM1K"
Content-Disposition: inline
In-Reply-To: <aMwtI44JEXFuNPA5@slm.duckdns.org>


--ifSAKz44nzz4QM1K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 06:02:43AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Mon, Sep 15, 2025 at 03:19:27PM +0700, Bagas Sanjaya wrote:
> > Sync manually-written toctree with actual list of sections in the
> > automatically-generated counterpart.
> >=20
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> This doesn't apply to cgroup/for-6.18. Can you please respin?

OK, thanks! I'll do that in v4.

--=20
An old man doll... just what I always wanted! - Clara

--ifSAKz44nzz4QM1K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMz0ZwAKCRD2uYlJVVFO
o3x8AQCm6hbm1X92Lu/K21794EnjnfNjcuWONZ8nr0ikKMbNsAD+OVrnNOuylGrN
CZEmONzzDLJ8o4kT0W8HNPNzsJBArQM=
=WWlA
-----END PGP SIGNATURE-----

--ifSAKz44nzz4QM1K--

