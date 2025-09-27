Return-Path: <linux-kernel+bounces-834995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F2BA5FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9438A7A0129
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7792DF13B;
	Sat, 27 Sep 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFr8+22y"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3C279789
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758980915; cv=none; b=p5BISSrYnhble99ZIEms18M+h8WFRVgAKygW6cmYCmAFUmVFvMMwfuZab082UJ6O0PsGuNIaqx7dka8Qov/KF1WTZT+1FTPZvoda9dm9sJwNQ/QkGDlw0uRJXGJdfSRe/X1XcUCcEjXfP+i59CByO82JFIBk9/WC/JP/08fq1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758980915; c=relaxed/simple;
	bh=ycjD+GaoJf+K++XmPN4L07Vpl5Or9LJ+0MA9nUzsKWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXSHjc8cktfNxMZgYcv+K2H1/ofhEydRkHj88MVfa5yQ7tI8dfJHnwvqKYcPF4x42XaFqpRUMyfqyQXg2GKHnp4UWLIpt8/BBbELJQgxaHbHm1Lwi5mc//nuGwAj+IU/KWgQJCRjZJEAoFo20I1s+jweflF64jLQve/dNhi5lxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFr8+22y; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so2951235a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758980913; x=1759585713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycjD+GaoJf+K++XmPN4L07Vpl5Or9LJ+0MA9nUzsKWg=;
        b=iFr8+22yebv0tRqT/lfxWOw75zo3Ig5zj5E0W4Vg1x7zt+1yW3trrWBWCr+ZJDNvOa
         X5dWZk7aT2kjqOy0c8T2Xan/ZLNrFiLOawZHK5zXyKobolGS0PnYjFIR+ge2tErhov9l
         jl6yQjqMbYtmKZYgZFKjJv1ER11tD0blo45w1Or+KiMg14DbkkGhZJeseSMVxUl78QB+
         TOSYvUyqwy0dQ28y5qV3D/rTZDIzx24MCgM12Qu2dlQTMAbpoYMqVrVAbdtZU0giQJKd
         KTQ2wQUhuoVqNoQPLvK+LuM+p0+5sg1Y2uFPVSbSoBxMwuywG4amwiCFFream60nwgVn
         d3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758980913; x=1759585713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycjD+GaoJf+K++XmPN4L07Vpl5Or9LJ+0MA9nUzsKWg=;
        b=Ida2MpdUGsudPgpRf1aXEeHbC4JTwBW+oJsi+G9xb4nL/ei6e6qzZGS3L16KX6r4lF
         QicIzgyhWTpHmdWzalbnBeiLnoREy065lJ5DKSPArT6sDw4YJnwU/BJZXTqJV/fnGCMr
         8Mwi4PUf6b7BguEpUGIhqu3NhjmXSEAXIt2Ut3jJTqND8lT5QH2Gsx1/DQP1QAQ1UZ0t
         tUz+6y/3qknLm/xJKUpm9ayPcmfp/4A7723IA72s1H1WAIOrC8FQi23SkHJK/jkf6b0u
         ORCrHjkT/hHLDVe95TmkUJt4qnOxu7i+ZiDpKLNtwrUlMX1SPmbezrZjVBpBnMVhlN+n
         Ti2g==
X-Forwarded-Encrypted: i=1; AJvYcCVjU+4reCfivQ/JqeKGDfKrO65MVV6A2t0Pjyh7SdiHAlFMBpqE6NtdCgJVMBlAFHwRaoDw2h/Snt7QvnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXGzfhrFfJoIyDSR47RjhJXQTciDjY5X0VZn1zJUzAJYbAFgR
	njELdM9/clw4SDL76Gn7vKX7M973o0tvxTKs9PYxSB6a+k0TFJJ6olvg
X-Gm-Gg: ASbGnctoMrMAz3SZwRg1l1u6ib+LfijcpKLfmRKfG7a/33237NmlWHo3wlgtAg9CYYH
	J65S8zXdNJWYuK4IEMKlSRFRXrhzSZGkE5FobjUmwrOxj+csoi1p085PhhLtKqBwrfM6rmWwJkF
	1S4pT8L6NcohgC9DLbX3hn7QSGa+X0Rq0ZMu2h4tOPbXHXNauFKKqyUmfLxhR614Y4qHH/PaUs4
	jMwopTDFHeIcuY0OlNDUI1zBq7rG6NZVPKhExMhNPrnlWALa4R9KfUPf2DlX6pDttrDOcJMefYn
	G415WGoPBJ5q1OUgLhRBkN2n262E64GZYQBkUnJscRWaLvkgn1/A3UQPfFk1iv+W4Osxbx1uRa4
	L4amC2OVpoakWyHDnazDrcDzgxsiJIU+W21Up
X-Google-Smtp-Source: AGHT+IHlq36bPDtRaXhQxlBatzHjr2m7hsqlTZFnSIYGIqATigx/sqLVQ5bVIxhmt+m4FmtviBZzpg==
X-Received: by 2002:a17:90b:1d92:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-3342a2c0fcemr11203678a91.23.1758980913343;
        Sat, 27 Sep 2025 06:48:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2073dsm11911785a91.19.2025.09.27.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 06:48:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A179C4220596; Sat, 27 Sep 2025 20:48:24 +0700 (WIB)
Date: Sat, 27 Sep 2025 20:48:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>
Subject: Re: [PATCH] docs: sound: describe 'chan_map' member in snd_dec_opus
Message-ID: <aNfrKBeu17kdl_8D@archie.me>
References: <20250926162658.989479-1-kriish.sharma2006@gmail.com>
 <878qi0b97l.wl-tiwai@suse.de>
 <aNfRhzjqs6Z2fi-n@archie.me>
 <CAL4kbRMp912C+xqO4RYnGBO_VSqXJDSkNMgktd04zcUMOn_4-w@mail.gmail.com>
 <CAL4kbRMLnkJJcC9zoS+vSbwPxsU=82960vc1pOcrDZKsjLbz_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HfmnOL6c3qw3oUjM"
Content-Disposition: inline
In-Reply-To: <CAL4kbRMLnkJJcC9zoS+vSbwPxsU=82960vc1pOcrDZKsjLbz_A@mail.gmail.com>


--HfmnOL6c3qw3oUjM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 06:33:35PM +0530, Kriish Sharma wrote:
> Apologies my previous message to the list was sent in HTML format
>=20
> > Thanks for the feedback. Do you prefer me to send a v2 with the Fixes t=
ag and nested struct documentation?

Sure!

--=20
An old man doll... just what I always wanted! - Clara

--HfmnOL6c3qw3oUjM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNfrJAAKCRD2uYlJVVFO
o39AAPsH6L0/F8hE5Ds7jMn7R2yRWpO37w7+7svlGjv+CnaXegEAwW/qs8CqfGg/
M3srlivPMdJcmao/5aIqEmp0TVCvtA8=
=6hn0
-----END PGP SIGNATURE-----

--HfmnOL6c3qw3oUjM--

