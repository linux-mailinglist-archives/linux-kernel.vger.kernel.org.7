Return-Path: <linux-kernel+bounces-873156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8017C1342D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 645A9350CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCE32C21EC;
	Tue, 28 Oct 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3Gu6eBP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF88286D5C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635612; cv=none; b=UQUpf6kSyKgeyPRBsWdzr9GYzgvrzaFeQgzRcTzFYXN8+7o50yGxgXoYy0yT4tOrtBVnX5iYbOnuAb7R5Ewf/K+Us//7M0YdXmIU9qx1L/aP8wYq6t7GYW7U6fVYmZW0OiB18i/HWnPbgVJ5j1tKBTECXehgwhjFQQZ4fl3aI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635612; c=relaxed/simple;
	bh=eBfOlcTZClEwsmAtGm0Vze9QL3lvs9NIeUIese4ye3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfBcRGSuDrMkPCkMZ6bCzzUJeWOoFEdwxC0owMSMp04NLRYqbZwsVyse1W8C1PAc7WpWj/nDNEnv/+hNknXrtXgUFpQZe4pPhUyYDdv7fFsYVOUV1cQml8uEj/8O6taA9DXPnX7bEfmHSI7ISvfMaKm1YjU+82MMkAjy1HGTeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3Gu6eBP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so3539098f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761635609; x=1762240409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBfOlcTZClEwsmAtGm0Vze9QL3lvs9NIeUIese4ye3I=;
        b=M3Gu6eBPIF/i2qbdFniOB11YphGFQX6NX6UJWCHYfWCReIjr/sRyxWwbaTfnO+z3fn
         NHe5M8rJt6kGbU5HntenereBvFoHfQ18tyBOYndoLo/dh5oIbkF0UKNApZ0fSjcHdoRy
         0GkQN0+paPpQzMk+5P+YDnUr7WGv7a+1ZZ8MCqTnsen/KCcj7+kACXZGMpLBJC+6woS1
         Mr37KfsiKBtWTKospg0XzbY8FugYJQsS26QDxO6JoDX/A5QtbccR3chHlKzQ1FN8pyOD
         mVlGXSh0NQO67FQcJ+1fJl1bDuao12eW1mPYdk8Ij500f2PYzKOmzfqn7pE6ErtlJ2Bo
         lX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761635609; x=1762240409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBfOlcTZClEwsmAtGm0Vze9QL3lvs9NIeUIese4ye3I=;
        b=M8Pb+0eEMiZYOXDwH5x6jsO4gHbKne+0XvvRLAgPpKlZTZ8rc9hVqhnUBV0Pgw5Y3q
         TzpBmA3M5PxH+MSY9c3mw95tJio+laSb6SJlZvrLZ8AE+B1d7m/PpboLegBHJk5hjNb6
         /MsvCXU9b4TzEx9Cyzj3fhtXcz3/uJ57INEmx+QZeVNUTbK3e61plcyzl5OPGgbyTYN/
         qhBISeqyCfZvEBLd0rv+ID8CNe3bXlwxFp7+cqwg0pMLewKWp8dT7riSp5h5WnfT19Tm
         r2PBRcvbiUmpjeShuHzCfKj2DbSkk/rFVC1gSE9BTpKsgVrlKfthyNb4byz3ZB9dCbFx
         5cOQ==
X-Gm-Message-State: AOJu0YyyNV3+z/lfO2y1uFWfFM3hgjW1K4ZMpNq8QMyBpZBXdNobqRHC
	JAVChfxsoNQpjiF8l6kzEz+R6j+wkhcNMVZpV/H5P7ApYdLKGhEeD7OV
X-Gm-Gg: ASbGnctbyGQ1VhwDKUZj/sbCbDxzAkyAaQO+vxnB4dOniCqTxpFfd71weRG/CbfRjbM
	4ja9h/l9x8SgtOJro6iZ2jm31MKgYiuSI7CmW/yjJnmM1CKegntYXlzhnJKftf8itMrlSVrxvNz
	BXKKNjiCkTeBTQr9XtWGSmHkd4WJTJr7v4fx/0q8/s0k4EezOglWZeUPiraHCGegRWzpCQhwked
	H8Y8xojo0gV/BozoyOkHldCYU2I2qOnuF3XrLBIwSoIxgR7buFIZs5dHYtjykU/kFm6hDl2KOI9
	DdMOQRoWl4vBVG7eBy5c5enTt9bBGDiMRt3vcyo0S/qhQNwk7N9q8zTSLdN5eXDJyu91gz7+xJY
	iLhho529SHgpITsbvUPSnAqLoyFft6yk4c3b8lsX0rO53dGtSuSuLYRWcVho4sJKRF5BLB5ZdrH
	11gbw2e/bZPXo=
X-Google-Smtp-Source: AGHT+IH/S+XB892V7dqcXy7SbJ7D9M5C6l4lxx9exSU7rDbfH4t9VdwWc2TwsHhbmzBkHckO8szgFQ==
X-Received: by 2002:a05:6000:3107:b0:3e5:394d:10bb with SMTP id ffacd0b85a97d-429a7e732dbmr1872592f8f.41.1761635608918;
        Tue, 28 Oct 2025 00:13:28 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7ce1sm18315865f8f.0.2025.10.28.00.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 00:13:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2DB554209E50; Tue, 28 Oct 2025 14:13:15 +0700 (WIB)
Date: Tue, 28 Oct 2025 14:13:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Karsten Keil <isdn@linux-pingi.de>
Subject: Re: [PATCH net] MAINTAINERS: mark ISDN subsystem as orphan
Message-ID: <aQBtCrXPA19Rv-_g@archie.me>
References: <20251023092406.56699-1-bagasdotme@gmail.com>
 <aP_H935zm6YwW997@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P6HhC8sYX/Kxx6HV"
Content-Disposition: inline
In-Reply-To: <aP_H935zm6YwW997@horms.kernel.org>


--P6HhC8sYX/Kxx6HV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 07:28:55PM +0000, Simon Horman wrote:
> On Thu, Oct 23, 2025 at 04:24:06PM +0700, Bagas Sanjaya wrote:
> > netdev maintainers: I have sent request message to Karsten off-list pri=
or to
> > sending this patch. Please hold off applying it until a week later when=
 I
> > will inform whether he responds or not.
> <snipped>...
> I agree waiting a week is a good plan.

Indeed because Karsten does not reply to my inquiry (he's MIA).

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--P6HhC8sYX/Kxx6HV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQBtBQAKCRD2uYlJVVFO
o+SFAQCI3fPV36hQhl+wTJCGnVXA/GrEkAUn8eCx5nNwp2ZuJgEAveGJ7ca1FG7f
QEzmZVdzgGGZdP8/obr4tlVKoHsUBgU=
=NudT
-----END PGP SIGNATURE-----

--P6HhC8sYX/Kxx6HV--

