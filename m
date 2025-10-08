Return-Path: <linux-kernel+bounces-844910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D072BC3095
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478A33BC179
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327841D5CC7;
	Wed,  8 Oct 2025 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqPvGvGf"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08C34BA38
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882277; cv=none; b=fhID6u+9vrWE0gJY/wgntn5S8Vv6zT83oHZ5W4wke6R0Wt8JXjHIBGQPKQjPsjWWsLDNYk9YEguZDShwlKsmn3oFZxedzrApJrBo+yjv1l763HmmwRebkf631YyU1nDteEDxhhhoYg/EuWqV1RQnBD7XiHeQtyvATR251VDM/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882277; c=relaxed/simple;
	bh=ZIJx91VEzutYWV6rmjWMuQo94kEzRhO28O6Sss2x0vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n92xn+P5ALS4x+8lVCk0ARIoRpqneivgFUpY64ag8I4Pn8HbFBuKcAjCYyWpYHGHCOktXNsBvhCLm7zDTD2abzlGEzPX1WPyXGeUEw7MMNbLoqfjjvXwp5rmgpMT+MoORlcR2vnSe6yFM0vavkkzisyL3DTGQOyrlqk9KUbWd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqPvGvGf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781206cce18so476028b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882274; x=1760487074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIJx91VEzutYWV6rmjWMuQo94kEzRhO28O6Sss2x0vY=;
        b=DqPvGvGfwdmRIVnyIqALBpWdX64FDmbXB7dT3Vav6Ml3duf8skiIYDkMDlC7nl+WRJ
         mEVcw5P+VN1nNPcT5drAD8DmGBW35eqfDgtUAXmwM1fqedmZZm4UxyyVYz0jYVRcS53X
         RmI25t1t+MfBDs5AH7eroLGROTC25KcAySjpnafYuZ8hDJ3AREQV1fwsarP92qKJHPrv
         CorwO1uDYwI+AMoSih6vs7e6fb8GNfYLsLtVLktjIWum5Faw/lStkM+ViB0B+OWNR5EX
         +YAOXLQjlgE3zDrSEmDDZRqXz5QOoIszog/mvw+UhTlFoTl3ogXu35YEj4sqsAGxQbUa
         RRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882274; x=1760487074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIJx91VEzutYWV6rmjWMuQo94kEzRhO28O6Sss2x0vY=;
        b=ggO9qnkj5uiD1w36O7E5ASYZfCMXKrQvqugkTtbo9D/Q4yFFhYZoG0tW2mVjJb/9mm
         Momtbaaj3m9GbBWFtbwNzY7SZ0T+m17FgxCEbku/7Kpiyf5CUBlvboku9hT/CCgT24+s
         ZqIQzBHdoRBZF3ogZLEcPwYi8vi62FKeuZgIgm6FaKmHjgdRQNWioGteMD9etdYkRuRB
         DHqGbrX/GixKaspYJIl4gQGqSPGrUL/vvHh32lrew4mZGsctZg2CT/JXVyoyxtXceKcq
         XhI3MmI6VIRhKkFbMBiZUfkWYwAvy3frOnTHmgQcB7eLpltGVvBDeGXkDikMGSgvLSBY
         L8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg5aeCVGGWCdpf9/Xa+utwGKeSczUWoJ6cDmbmQ9qEC0LEVbDxie76zUgoTHouRWFrxM+VZmNMkKI3+IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79gMhQxvn0KAz3vltIoWRZolgJN059RruuCVx8bGLVtDH7FE4
	FbzH1zZ3F93FPTjcN6/PuPGhhths7TMENuyE5d+118GK8g6a6YTq334U
X-Gm-Gg: ASbGncvjQ8f+ilU450tgNsTxUQ3CiSlG6eB8pcUok4h2+EotmgkzB20jEDaN+y5/WK6
	A75ffVn4wypmVMrN9NG0dtx8QfyQWoYABpjvjrMoiQByUS6hf5fxnd1tDNMZTrcgUiAN7mby+uX
	Z84ulfwLYD2iaWRGpZngFxiBMEoPgG8vlIT4pjs8uwJMf2AfVlEUDp/msUUwevQznyOcrrcS9Uc
	gAcyIA/8GvYRfLC25G4B2/79w8WHxmiYz++ko0PtBRrNeGlAyhJS4L+eNgEpvVkbQTpyTYqL8V3
	gngQTTUI9KPokOMwn+LCZNFZmi8OMntJH+5ldw4zAPnk1PI7q0xsjgIeBIUBOyVsmfrUyn5B/IB
	LGkBBFmgoMHSwugX9sn0YHLaycc8binoEp7Va2aLWkdSee2auyQ==
X-Google-Smtp-Source: AGHT+IFW3sow5y/lVKkATKYFm04W7RgDI6fSuHLvh6sjhQYKQ7ak+ZYw+RTchKbkNXukK9zwt+mgiA==
X-Received: by 2002:a05:6a20:3d1c:b0:23d:45b2:8e3c with SMTP id adf61e73a8af0-32da8df23aemr1423045637.6.1759882274312;
        Tue, 07 Oct 2025 17:11:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dcb3sm16910186b3a.11.2025.10.07.17.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:11:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A0A074233430; Wed, 08 Oct 2025 07:11:11 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:11:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 8/8] Documentation/rtla: rename common_osnoise_options.rst
Message-ID: <aOWsH5Lgra60g9-k@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-9-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W+2lsue7TXY5gcQ4"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-9-krishnagopi487@gmail.com>


--W+2lsue7TXY5gcQ4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:57AM +0530, Gopi Krishna Menon wrote:
> common_osnoise_options.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_osnoise_options.rst to common_osnoise_options.txt to
> maintain consistency with other common_*.txt files and prevent Sphinx
> from building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--W+2lsue7TXY5gcQ4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWsHwAKCRD2uYlJVVFO
o7BjAQDfo1t5Lr12kg1pMMFioSkS+Xkr4egh4nTgsiztQ9ybyAEAnvnzwOgWbSWl
t5mwwHHqH9/4f2X5NKq6K97vtzUEKAU=
=VmlC
-----END PGP SIGNATURE-----

--W+2lsue7TXY5gcQ4--

