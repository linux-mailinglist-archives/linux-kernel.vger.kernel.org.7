Return-Path: <linux-kernel+bounces-820468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B07B7F3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750913BAD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB985304967;
	Wed, 17 Sep 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRb78puj"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98642F549A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104422; cv=none; b=L4U4VIypzCdajpcp3x1htXCRwig8lO9cPNQC+im853qIEnnRjARH8HvochzBB6Zu8juJfWoOdJ85CQO59M+bLmPzcneMvY6kIRiRry9T/uVQAvFHILtHdtC37AV+mXcdYNpAUzvE1MQCpCZeIZxnJt77PJc1UTwWCmUncvLuj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104422; c=relaxed/simple;
	bh=RbSliuAms+T1/oEf4poSq5WXHDdyjz9hx0wGQTXLmYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck2hEhrlmQ7Uqhb1nWuqmf4cbAmebn1neNXnEo0x69efRZIcIphBADUxN4Al6oNBTG2LMDYrDOHqPWaeeAjKRICt9oJN9Egb4i7C/e6dP1jVnyd33wkvHL8+tuhnmFTi34hpuq5mPqWLlRc1YLHKq+utyxUYrqs+lBk3tIWAfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRb78puj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so4301655a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104420; x=1758709220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVtB2XnXFBAhKHtc8c94UgaEAWBIxaaO7KZyHAUIalg=;
        b=aRb78pujMcxlBYHhzNou1UjICEuI5fQdy+b1Sr+RkUZi8D3vT6yVd0ohlNEafEx8Ok
         KkD8bPF36U5CTiy5S+D3XVO/adawuNqZDtLBAjrSZ7Yi+tFh8D8HXQpRCaTgq3KZgcmL
         ZmgjsvNpPrh3Xse6qtD6wWlCSoJcrT1Vw7wOc6XFAEtJ8DD9R7RP1jbkeXepSj8lXaQK
         qWTQZqM1Q+wbJWGx6m/jJKZ5H7oCqrvJqUwstc1x2QGAYeWDan3Dktg1gx6B1lmA16Za
         3z1G5GghdDgi64IBV7kVAjfyZRatX3YqEpcF6Rd+Oz4WNB5wLjDjRzONoZGOU+9O9SDR
         SoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104420; x=1758709220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVtB2XnXFBAhKHtc8c94UgaEAWBIxaaO7KZyHAUIalg=;
        b=gslvcvSAhHgkkwTfPou1RSgjbmD/Ydw+Uz3HfiaYCa0B3uHX1tpRw6uuAc6Z72hEpb
         DAkzDjAWsRzQGg7QeXE8Y21ZHbB0+dmCRed+pfBNUgRVDPtfrh+FilHBN0ZoPrCM/i9Y
         CuNqV2Ie7OXZerQ6KrqbAuwqzdCxZv4XIWsg5Q8RAC1ml7Q2mKWjYPVuA2rmmwxcgEEO
         iV8+bdnrDxnHdmPKazy4mlHgaYa4u7jGxFH9e8YckFup81RalcWPGOaG9qtVfu9Ha17b
         H02nFGkWUzJUij0njQOBuJ6QJBOh0OeZ983NP+KJZPajZ56S3uTT118AfI8qDPNL9CtT
         6oFw==
X-Forwarded-Encrypted: i=1; AJvYcCU8F3FLIQKmGPwk8JJhRdV6ioFQuZY5Yfg+8S7Yvlbj/w+xVGCB2Y6onprfgBwpRFXC+DeSkqjzRmXaB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rPTdyii4/n1+qTgEwPeya15KtgCC9SsdHbbKA0KvVqGOXc5S
	BC6MOrtQ70QU6KOsjj8kM8JRq89TJfKhwCgDoA6+NIeuNTK4UvWxNJyG
X-Gm-Gg: ASbGncskyDLrbVu/CtExnvc5Z6higFs5ssZviZyLo03f6gFB6FcHEfqk2MYxUn2zwHj
	O5vRR2pGWAdLZlJwGpIUSv7zrrO07iI4z3lPyhjHlRlbumlIZVIv64J+plYeC5KmRkyEtw23era
	swCXQj/AQfHO0od4Zo+GxZertnqSQfBNCF1O9H4/kvz7dNeGUsd2xM+IjVb07ltWmEZgwOdCCfY
	Sqr17LryCHa+HNDc1I9g7VWKFXErn4tWPsvP9ThMAJlF1quh3KSHf1iFAZHByR1M2h6Yx5iaN3n
	ySwZKinBapBHDTrzaDCMULoP1eqcKzohOiPQw6uxs2MLcq1j269XWR7gd3brcnz/BWcrUEEvVYS
	l1Ngz00UfzONdcEOLcElHRXSaJg==
X-Google-Smtp-Source: AGHT+IGMjlu8QTGQX57ITiL9KCnMud/ogOrmy0cuuut0FtOLq5QjpY9rRCAKcvK2iL9ACZcABzzd8A==
X-Received: by 2002:a05:6a20:938c:b0:259:27ca:2503 with SMTP id adf61e73a8af0-27aa5b90662mr2151663637.50.1758104419990;
        Wed, 17 Sep 2025 03:20:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7762c225d2asm12554290b3a.65.2025.09.17.03.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:20:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 00B8341F4135; Wed, 17 Sep 2025 17:20:14 +0700 (WIB)
Date: Wed, 17 Sep 2025 17:20:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: maintainer: Fix ambiguous subheading formatting
Message-ID: <aMqLXk-VyIKR3PtH@archie.me>
References: <20250916222944.2547948-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MMbNuiJ6ivfhL3YT"
Content-Disposition: inline
In-Reply-To: <20250916222944.2547948-2-thorsten.blum@linux.dev>


--MMbNuiJ6ivfhL3YT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:29:44AM +0200, Thorsten Blum wrote:
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Docu=
mentation/maintainer/maintainer-entry-profile.rst
> index cda5d691e967..d36dd892a78a 100644
> --- a/Documentation/maintainer/maintainer-entry-profile.rst
> +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -59,6 +59,7 @@ week) that patches might be considered for merging and =
when patches need to
>  wait for the next -rc. At a minimum:
> =20
>  - Last -rc for new feature submissions:
> +
>    New feature submissions targeting the next merge window should have
>    their first posting for consideration before this point. Patches that
>    are submitted after this point should be clear that they are targeting
> @@ -68,6 +69,7 @@ wait for the next -rc. At a minimum:
>    submissions should appear before -rc5.
> =20
>  - Last -rc to merge features: Deadline for merge decisions
> +
>    Indicate to contributors the point at which an as yet un-applied patch
>    set will need to wait for the NEXT+1 merge window. Of course there is =
no
>    obligation to ever accept any given patchset, but if the review has not

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--MMbNuiJ6ivfhL3YT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMqLWAAKCRD2uYlJVVFO
ow71APoDRGRehVx0J1kc5ZjRa8U+stIDa3UZtJsrzo//dDCK8QEAkA7/GdtGXBvi
wfsFzT05Sb6q8vaGDc3c1/vlx5rAGwU=
=6rFv
-----END PGP SIGNATURE-----

--MMbNuiJ6ivfhL3YT--

