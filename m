Return-Path: <linux-kernel+bounces-888248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73DC3A4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE64FC04D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38204248F5A;
	Thu,  6 Nov 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq5vMYFt"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD6245020
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425201; cv=none; b=XTnPDpsvJkzDxj9sPxL1u4i9GhhFVyHvp5XwBH65ZCD991WexM4q4AS8O0CCj7Gmul7+1MpCV0swrSRApWMr3KNASpca6gGZfCgKOu6Q7VLQCYEwQWCKo6Z15rnTEI8TeYdL+lxWR7cHk27Hs79cadnucPlgTEi62+K8dPNrNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425201; c=relaxed/simple;
	bh=IQipCRpVFfui25dKlyIy/WSGyJHEdXiJ7zhFimN9ZT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRlj/a41foo9X5QgQWyagUrqny924UMhHkPMnnVdZWnrr1rhkm42QZbFgImvB5DNGHRxh0GW0SQ3KSdBGqI0SLRhYu3QeGUVcrGIZax2kWcrOQGWpQgR+uQG3byo7whFvUZe0wm7ALgM1oXP5JknM4982W0zlch8i+A6Xx9gUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq5vMYFt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso481222f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762425198; x=1763029998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQipCRpVFfui25dKlyIy/WSGyJHEdXiJ7zhFimN9ZT4=;
        b=Fq5vMYFtNBf3r66JZJZRoTBAVXW7EyLf+8vC5W1ol01pFX6UubaTJ4gouBU7fDYGLb
         F5RiSk6l6AJVRVHYmOmm9r1F5xRMA5W/T716DSxiglc4zNIMxSPALy+A22oQMk7N1YSw
         MxBYi7Xp03pbfp79nhdiECcsyufVCb0zlYhGtsW4SNABeOFqzbJ+Z7t/JiVyRn5my725
         yrSji4uw0l3WlTOJZeT9Db+vBqK0WhzCiADkuqfpHHxlZ4W5FueE7RXaE3NuLvMcrDJr
         NaxLI+x9PrZtjqULm3mbwBiUjqSw/jrMUExDGE/v6OxVz8PGRafTG9Jk7tGMr/MVIG69
         IfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762425198; x=1763029998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQipCRpVFfui25dKlyIy/WSGyJHEdXiJ7zhFimN9ZT4=;
        b=cPjf2sOn0ekTe/r5n166NMJQ4i8ZO+wCyyEfalR1VMOMd3vFgT+EME49mlE+PbcaCK
         I9KF6Nr2KWi0D3RWlA35qXQu8w/42R6SpvH7auK9vTzLYXLDze325D246s5NbbbnBNik
         kDXQG4XKIFTqOFmqxzdHUnidRqo916hMhIAS6CMbF609szP8yh1jAnT2lMYIVM1XrJ0m
         58XC89Q5QXrY04vrROQ9c6QYq7erAyrp34G32SXw52/49hKKSqHVaJrCyl1u7xiHiePN
         9aJ7FcyYElIICjaggkxbFs6Q7kNkITtLoidIvDph5WnjGSXAJXkCIxgo2CFClhox7MCG
         IWFw==
X-Forwarded-Encrypted: i=1; AJvYcCWFd9i5YIl5ysC42JefKQeqBkbmNG/L166W5AyY8tWnq3UZvtK0Q9D9lHjru5E3+eY19mJ2t2d6n0dkCUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0izEsaIznnHV+bbcRZdaZmxPEdlstlBrho6E92cCg0w+o3L/X
	kbO/WI4+PJzzdN5HlW+SXYHNw+1PoK64475FgZrwYQWS8eM9GFtSnPXa
X-Gm-Gg: ASbGnct+qNDyq800pMj5E9rEzr8mw7ti859OeHbo1SnX5ebG+8B+6IWlgMUTVs9bG8x
	SJzH1fAIpNIHUr6/tWawfNMPXQ6nH3oCbjn4Cf8hr0t/R/p9h2/GRrIDKHCT5ZA7Sq6GbE1MSFc
	nVs8Wm1Vmx53pxu+iOsOJjdsfShQAsqWTamCrncIItgS9sHhi1naeZ8O8p+vFVezhevAzGZxLKV
	QRUH25Kzt/LscU1CVyrSu7meNMk7peLD1q9+gQ//MlX93VwgxzQPerTu7bcFWb+4PRdzYZN07vQ
	vq04Se/TAaytJkd7geSr0dJ6+Dvt1ncqBaJ/GoKoTm3RtSQQmnsKDNG7r2DmQHXVTNXI8aGAWiH
	NQe0PoqkRj2czyKlVzWfRkU3G2a8+dYWtm7Zv2oDBSCXRVf0XjBb6rRMSlgw3W8b4YljdXCPap2
	6zZV0J/SQ4mZ9gH2XB5K12sg==
X-Google-Smtp-Source: AGHT+IFtY317gqE6KkPCPF8CEMqlY4XSqSHpCQgEggJ0wgh6u+xUqljo6I5F0N5V/IXa3Sh4CqPFig==
X-Received: by 2002:a05:6000:615:b0:429:c9ab:2cb5 with SMTP id ffacd0b85a97d-429e32c817emr5341842f8f.2.1762425197999;
        Thu, 06 Nov 2025 02:33:17 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403854sm4173231f8f.5.2025.11.06.02.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:33:17 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 046AC420A685; Thu, 06 Nov 2025 17:33:12 +0700 (WIB)
Date: Thu, 6 Nov 2025 17:33:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/ttm: Fix @alloc_flags description
Message-ID: <aQx5aAR3DjengjVt@archie.me>
References: <20251106005217.14026-1-bagasdotme@gmail.com>
 <f935574c-67d1-4a7c-bd8e-e9dff7aa97ea@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmZmydHKAYCDjdz2"
Content-Disposition: inline
In-Reply-To: <f935574c-67d1-4a7c-bd8e-e9dff7aa97ea@igalia.com>


--rmZmydHKAYCDjdz2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 08:28:15AM +0000, Tvrtko Ursulin wrote:
> I assume no one merged it yet to any branch so I can push it to
> drm-misc-next?

Of course!

--=20
An old man doll... just what I always wanted! - Clara

--rmZmydHKAYCDjdz2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQx5ZAAKCRD2uYlJVVFO
o6KUAQCdWlX+bS8tZGT/WzXuutPy13eM3ApLgSLVthbWq2XiFAD/dr6KLftQULXk
HX5cf0yZ85lJ3S9nW+31ZKHhTSUppwM=
=gYHU
-----END PGP SIGNATURE-----

--rmZmydHKAYCDjdz2--

