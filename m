Return-Path: <linux-kernel+bounces-892717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20BC45AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804CE188226A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529628980A;
	Mon, 10 Nov 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAxMBHEs"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA52FFDF2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767393; cv=none; b=a/eTKcAp8E3qaRtKWG9gCLJhFyGDN2yEPXCyn4k8yeZgOiJrhp3GhKhtPPiqgOZMzpG5aQKuhqxXoavOg6GoaGeNhgIBlx85b9Jv3n330n/DAcvRx+bWmrcoKn2VwbT3RZOCbi777Cp1hm1/boHdk+PN7oUxyfWL4sQfnWwdQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767393; c=relaxed/simple;
	bh=aEtCKt3fEUhliG7OG87NC5rVJbhrYdGmWYzuJegLKXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5CNkbszzRghl2KgCexgCG+krAaaOGNoKjPzJM5Qj2UUEs5sfIK+oyXpsPEgwtTic/fsfmg3emScDACNHMaqF6QuDyz4X/U4LJy3FYWdB2AX4YgLIOTpunpf4JzAHb7NQSKSwxGlP38uS1n37M+on/nTIVIfVEMGryj56VbCqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAxMBHEs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-79af647cef2so2288082b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762767389; x=1763372189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fnwk2Rq2943TMve0rH97n9BrZ8ODlnbQT+KR5R8OAPM=;
        b=TAxMBHEsAkR/hmy7u5S9s8VlHCcQa68ddZE9uWbBMl6kAHy29VuoNllmcFChyCBI//
         JzXwpcIgT/Bh9wLHOzhKlEE39/YzMvR7dATpznBWcjd+9udmhVjh3k61Gv3YRosSMvrr
         yNTDn4FPJwjBuQ/bAnc0mNlFUrUe3DD+3DvWtw6C1Tmh1UkennW6bUoSijMKeMIOlK8d
         KIdjjQoqoyJ/H/o29mjrD3GXjn7rkbvfB392SIfAmpBXmT6S8sIjzAYKcQeLeeIsOwLm
         G8nTS3mRDRd5KA+KT3S6EJEO6f+y8leyXAGMsa7a5GTuvZbHKmB/lI9NBw3ip8MQ2/gI
         dq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767389; x=1763372189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fnwk2Rq2943TMve0rH97n9BrZ8ODlnbQT+KR5R8OAPM=;
        b=xVlNsDPmgIfnWk1u2T/GNq4sLPxsvVaLglnkLEFEklumJFRS9Qg4e++tBegZmJXBDy
         4a4MnkzFlBGqGB2rLYYC3naoqGc5H9SD0e1KMRR5pwxHRVlJG2bjZd26qDHC51b9GcBF
         MioewZ5FgoeABCFtForggXFuHs/xTFME55KXDhAKKegbdtEGzoJNSBHAJ51Dn/TXaP6/
         8vBjZYz/Qzksh/2fBsxIx0ZO76QcPcYWlPlaPHWaIyyD7mNeWuIGDZF/hb7Nwc1pg237
         Kppk2mwfzynXtLThRTFh8JxEN5B2LMBAzgZeEbOsVRc0W0gbEczSYCfT0pVIGwnWME8/
         m89g==
X-Forwarded-Encrypted: i=1; AJvYcCVhI8GVaBoOfhjmc8A8LOEem+V4qN3JMUgOtRGdeNphNmbXVZcDmlWdZ8yGCNzvwVBtXqDNN8KqxfMO8qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkof21UFavpsmOeiRttMh+WQLLqfn59boOWVzzOF6Nlq4kVsJ
	TvaaMa/m/1e2azLKSpLMRI6Ql7BNfA6V6ZXCvunfzt9jtC4p0vO34IbK
X-Gm-Gg: ASbGnct5L/GZZYDsElIXn9mooqqfEJwYYUdE49ebmNQPl/50BwRV6l8IGxvOluw3x7Q
	KxBM3lsTVWM2r9so5F8/luKhoTUhovg/gbYvSK6iiC0LRUA+ArMlZ7z2YePqWDkavo796201hZt
	gdv7GMFbeE9aoaaudt/58QYvZHjSBlPFTSM+n57TsiT44+jWczCf5wEOvQUTQTRKBFRV9o7Agoj
	R+IdPCGH88ay22GbjtNBalr7OYvaOogl6ChwOUQHsb6R3wa6nz2B6f9Q8Mh6P2Dh2/lptqX8Nf0
	wjaqF61mX+7/HeeXENeYs36ITPJN0lSM0vJ0BWpAZgtWflrASpuK/oupqvC1OweaY+AdZW3GGO/
	AUFZTCwpX7t4i/nCm3EwS+FAt8eqn4DYVX4E/cOEpgKoOKxdReHrGSiQMe9PYMDwptj4yjqpX18
	y53KDjYJf8W78=
X-Google-Smtp-Source: AGHT+IGCZ9KPYSYPJcdbC+nRldkLNiCFqKVeuzEly19j3aSotFNmFobmMMDw8xD2hgmu6x5xhMa25g==
X-Received: by 2002:a05:6a00:4f96:b0:781:2290:e7e7 with SMTP id d2e1a72fcca58-7b226b931b0mr10100881b3a.18.1762767389184;
        Mon, 10 Nov 2025 01:36:29 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59de7sm11040572b3a.65.2025.11.10.01.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:36:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 83DA04093848; Mon, 10 Nov 2025 16:36:25 +0700 (WIB)
Date: Mon, 10 Nov 2025 16:36:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Masaharu Noguchi <nogunix@gmail.com>, jaegeuk@kernel.org,
	chao@kernel.org
Cc: corbet@lwn.net, linux-f2fs-devel@lists.sourceforge.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	akiyks@gmail.com
Subject: Re: [PATCH v2] Documentation: f2fs: wrap tables in literal code
 blocks
Message-ID: <aRGyGTIyUfQGo1kH@archie.me>
References: <20251109095416.2428351-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cBsjTY+9mfPUQSPu"
Content-Disposition: inline
In-Reply-To: <20251109095416.2428351-1-nogunix@gmail.com>


--cBsjTY+9mfPUQSPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2025 at 06:54:16PM +0900, Masaharu Noguchi wrote:
> Sphinx LaTeX builder fails with the following error when it tries to
> turn the ASCII tables in f2fs.rst into nested longtables:
>=20
>   Markup is unsupported in LaTeX:
>   filesystems/f2fs:: longtable does not support nesting a table.
>=20
> Wrap the tables in literal code blocks so that Sphinx renders them as
> verbatim text instead. This prevents the LaTeX builder from attempting
> unsupported table nesting and fixes the pdfdocs build.
>=20
> Akira Yokosawa pointed out that the in-development Sphinx 8.3 latex
> builder already handles these nested tables. I still want to fix the
> current documentation because Sphinx 8.3 is not released yet, and the
> LaTeX build on the stable 8.2.x series (which also requires
> "docutils<0.22" for now) remains broken without this change.

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

When Sphinx >=3D8.3 becomes ubiquitous, we can revisit this and revert
it to restore nested tables.

--=20
An old man doll... just what I always wanted! - Clara

--cBsjTY+9mfPUQSPu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRGyFQAKCRD2uYlJVVFO
o700AP0UdeB71I3fmnbrd0SE/LHIiB8IUuvQGw5oxeYWRpNPEgEA9VmAas5jDwnA
PoQ3dc093VqqeniYdAlyivLhxQr2Zg4=
=gAAT
-----END PGP SIGNATURE-----

--cBsjTY+9mfPUQSPu--

