Return-Path: <linux-kernel+bounces-856012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8914BE2DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F081A63564
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A32E54A7;
	Thu, 16 Oct 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTTCzsA+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9A2D0C7D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611267; cv=none; b=WPrcx70PohELj0UINAzLPraXsm7SD/MsdV8MUccu6QYoL4sllx/vJQ/lEuZo6i0O4GFpYIClweU0C0y0O5ae97ttjUf0VXniPr5V3m2VBwM4guKMUwknYvEpBwBQBVqqQbqgikI7WDqKMojlCvzeDPnswJL/D4Q5kv9yMs6WrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611267; c=relaxed/simple;
	bh=jnT7eA0MwQzti6UldYfk9G+OiPEhUoWsNhvVPZmZfYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=All66bmRT7hk8SbpqRgO9R7OAoyLAWKEFu+yHLRn/HiWqDCoBzXW35wh2featCLqKzJYktuznKBpHt7Ysta1ByGproYwKdlc4VmmFbkd4oSmha9SeJxmG+4ceRaYct+dmOzJCCTAg7c6AUtzVhiw4el6FYXG6Z/36fHKtTbKKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTTCzsA+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-793021f348fso592560b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760611265; x=1761216065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVSu3v5hQ+mkImsLsDrLueW7tnWFr04YL/mKk3BRmmc=;
        b=RTTCzsA+54gYQ/CBNkEZDIsr2RZxIy+QRMua7OKLRo4utBmX8lVmaq0KQpPPYJyBxM
         X2BAAMrzv5QxaKsU6CICIkwcS25qTWGP7k1VbIEhqk2bU4D7n19ZJF6kw2hXs1SXFjmo
         jBgADgKCftajWdT1hxU8aIV3XY2GHfaUoIdEfXJ/2smuBLIe0ionWm6IviTzNmzQ4Z/5
         dgbyvI8LMupeP244ALuLcRcmUOpQMElQQof/3y7JKzlqhl9X8GVhX/e2wb3hNHnKi+Ma
         iUKWTUUcX2RNUyeQWZ7nFE9TBJbDAaUWX+cD9tgQFt729qMtCk8CzdYasW5Bfed25tYj
         r1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760611265; x=1761216065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVSu3v5hQ+mkImsLsDrLueW7tnWFr04YL/mKk3BRmmc=;
        b=XRqJ7BF7oiAEQEnoUkw35zYfRhiFS5gonyKZrPH9BZGwnz0O6oJBg79hr7QbsDLbBf
         RKPkSO2MkMmT9cke/IcoT17q7BDRVh20JR/EC09o97SrIAilXuI4h7FMxdsOsYN9pDj4
         WWQZo1fTRFo+totpfscvXEFBE/ffd9hwYi3eZgGyjJ7xthLWrBBsiWVUoFt7jvlTio+P
         cpFi2QHZa4yRP3i0o28xSTetKardEqkX5f1K3ApdqZHanhaBP1btaRyWDnOUYFk9/rTY
         kVPxLX0dwiNhSu5+TqnnD5pNxmwGls/2oTivYGSGN3YCCKbC4R/yfgkJIIZUPDZYl2nn
         zOMg==
X-Forwarded-Encrypted: i=1; AJvYcCXOki6lTvbFryRwVoj/QPeq/dEI7ZJko3mDRZR5Q0XLmt19gHNV0LQZgdV+4c+xzjnZsVhj0bVS0SIISNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3G18lQX0ZKvo0sv+nqZUmsy5tpqtfj1qFR3RzDAnsywW90iH
	RNE6/3+8biguh99xzm55PEnwfm9xmYtAgY1XRI7ZCW0bE6+EuWq1x5J7
X-Gm-Gg: ASbGnctxBRDaB0YlL5ObnPL9jZhFDPRW8hC4d/A4Ov4BmCEVIn+OVM35istyI79OzAn
	Mg4vasVfB1+fdyn8IMqcpPdNH1/tPwaxUwkRd8PBaPNo5j7iuzpZQ6mj6TBd6HfAyFCy1sioS2D
	FMrEDM2C6oxePHUG9ZmgJazc8/hjqdzJzSNFdKJBob148DU7asGhjpuVHJ4GRP18DeQdgja5LzO
	8ChSbokPkemBW8CvI/0Rn+PUo9/cgblm1Nh4nJgerdFCPwAJ/6z3tW6gWiHwd+AYGz7AUrc0Dxl
	z6928y8OSq96sC/SLtjzHaP2ODtBvg1Qfuj/VI4/kTT18iOmg1LAUnU/H3hOzd38ugU7d2dIHIN
	5m4sw+tpIwA0ILgNWFpNn6s+3otrT2ZnI+55I0MC2s501Knw7GtDqiNFN+rRXl3mkNthdBnNrjb
	Fm7LE/7oTIbp/cUw==
X-Google-Smtp-Source: AGHT+IE1H0Qo6arbd/0sw3nK8Wog5439Kuk67M2dNIEm8atK9BLJ3NAIUD/arp5nW0PclXPHJb8yBA==
X-Received: by 2002:a17:902:ecce:b0:271:b6b3:71ef with SMTP id d9443c01a7336-290273737a0mr409664895ad.43.1760611265161;
        Thu, 16 Oct 2025 03:41:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099385d9esm25928775ad.45.2025.10.16.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:41:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 02548400365D; Thu, 16 Oct 2025 17:41:01 +0700 (WIB)
Date: Thu, 16 Oct 2025 17:41:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, corbet@lwn.net
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] htmldocs: userspace-api/dma-buf-heaps.rst: fix block
 quote warning
Message-ID: <aPDLvQaZX7M5D1tv@archie.me>
References: <20251016020912.1653230-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ldeZ5wTTs5GzBIeN"
Content-Disposition: inline
In-Reply-To: <20251016020912.1653230-1-kriish.sharma2006@gmail.com>


--ldeZ5wTTs5GzBIeN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 02:09:12AM +0000, Kriish Sharma wrote:
> diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentatio=
n/userspace-api/dma-buf-heaps.rst
> index a0979440d2a4..c0035dc257e0 100644
> --- a/Documentation/userspace-api/dma-buf-heaps.rst
> +++ b/Documentation/userspace-api/dma-buf-heaps.rst
> @@ -26,6 +26,7 @@ following heaps:
>     ``DMABUF_HEAPS_CMA_LEGACY`` Kconfig option is set, a duplicate node is
>     created following legacy naming conventions; the legacy name might be
>     ``reserved``, ``linux,cma``, or ``default-pool``.
> +
>  Naming Convention
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ldeZ5wTTs5GzBIeN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPDLvQAKCRD2uYlJVVFO
o9hmAQDFQdWAy7dyIyVP0SLEEl2pGTkPA49V3t68gWb/RcemuAD9EEE+wGcnfP5g
y0D3QS10Sw9x4aNHuLSknmnEamh0YAg=
=ADLh
-----END PGP SIGNATURE-----

--ldeZ5wTTs5GzBIeN--

