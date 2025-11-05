Return-Path: <linux-kernel+bounces-886960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A82C36D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26E564EC528
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B931C56F;
	Wed,  5 Nov 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVpbhQKs"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71762FFFBE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361527; cv=none; b=QpqAFgm6I5tgaq23qSd2XnEzs+xB8fAJUXD4B8vhzs76iGHw6I2/+Q+9bJr1S+RzrKKFCB8erAeq9+2Jwnh8Bk5sKb30L+mcAAcn/pb1G0H9NvjT0az4muP6YwjdJXwjASscbDEy/k6APS/Flfq8Jc3K0dm1d46E/RAaoscPrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361527; c=relaxed/simple;
	bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxgf9f0zPxVxTOXWrNdexrOasw5SrknBSBxc+49hp8tIGcEj1tZH34K2Fq4QaEugsqosda02aJMsB1WMMfzMheb/l+thJonIBjKUpd9PunMs+2DVkwDHkud3EqgEu0RImf4fV8tICOVANUU2zRW3XkMEM9+jc4VEn1oNJmEPosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVpbhQKs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47755a7652eso173185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762361524; x=1762966324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=AVpbhQKsWHsJPurkBtpFjS569EuYKUxy0Ewl5KvxLz11TynIudTMz6x27b6A6doKWz
         ip2xD5KKY1oMJCK0Dweum3CzpsfSfe5Azmrly9qy+6lx5DTGxHpK2A+42y5Z3pqNqWXK
         5oMVmrIxCr+TXfau1fOpH55Ds8Gfkw+SKMup3+25IM0tOOtYD8mCPcmX3YHevXG3I9fS
         voKjd3O+6JkWCl7xwg0Uy4qskOwo95lmPAQUzNV1zgopuIouOGjmjNsUQ0iiplG4NNw3
         pJwe6bLtD5Fb+hz4cFTbQ+dE2Dx8twHim57o5xVAlYBYEkIZ+8VVi9pnTa3HqwZj4o61
         JDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361524; x=1762966324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=CVB6m9tyDVbHfkvYOUW00daX4rqO+Jeu5bbRsGcfpvYBDMYEbqdj+M3n9fUzJz9g1f
         GIJS4tRu2lCMfAiN1ZC9OwFfjg43C6/HWYd2kEZGP0b4m5JPA1cl6Ds6EngKl+DopFEQ
         BfOfBFFkYoFGZJ9IK2EP01wtJyQh4aHjSrQ/XgWUjodSt2TmgT/ZaFkaxE3VhtIc3Ttz
         7/0CkBp25xU7rKMgx/Tte37Za7tvdiL+7ncq8h5zNwAWceJIiWKKKaf17bUQnOalsOBX
         a6gra442n7CqhNw4L1YXO7REDVMztFg9tSMZY+k2PLc7Kl37YFwAWv/PAmqL4Egdnhjf
         jE1A==
X-Forwarded-Encrypted: i=1; AJvYcCWtLugSCNOa7XBK56IIyVDw0DgmbxO0Wk1YgBOAjLIOyVLHnzOJ3Cdmn0e6pxrNhYR1QHGCzbCYxM67apo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNt0jG6aQmk95BCKcnHjB6Qws1tTVFHXoyvlE10CxB/hFO0Bo
	cuSPdp86817UhnuGzulJLAFBB3x32nZimWchmMhwKsfM4BIkK7f8Fhq+
X-Gm-Gg: ASbGnctkfmvP17OrwMgNokEUWYyIk6TxNEH3gy9dIssvhXg2ltqELY+erf+ZLtvFkGt
	/TORwYec8zW22FVTWH8uYfDwB2ua9j+xn66CIzPy1kUnYuyyQDfSZg4WZD9Xn6eoZ7ANYoE3nsY
	ABx4W4YGq6khkKe+iG1SbY3MH3wESWU9KEF1EIcDYJJAnR39+ocFhfAXn72/Ef05Ldx4Rv35mUu
	pwbsiU8HBMf27YWR79XPiN9ZzGOxdwlQqa6Z5rmREjPWjdzIBhKcvDbzPBg0AA0lvlp3DRuPNOa
	2leBnK6XzcWr95539OnM455x7FWiwZFnN1csJIxP/L1rEs8eKrXDM9orBq4dZFlPwIDRCyMfRJe
	EprB8/XdJyj3Nlc/mNaaBcBRbZ/SEYAH5+E8Eb6zw5Ohz24OU47ALnFTHuXNRGn6m1hcGprV60R
	A+K3w0+zQVpPuMd2JpH18dVPNtEeQgaexW9bjzNDHh5Jk2yiQpAjouqqL+H/Weegk=
X-Google-Smtp-Source: AGHT+IF1eT04urNHEfsD9kdCj32CNL1YcHJ6oGuMVK3cU2BLT/aQRFRmm7ox5OYZe77ML31HK9v5ow==
X-Received: by 2002:a05:600c:1c94:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4775ce23efemr42468465e9.17.1762361524090;
        Wed, 05 Nov 2025 08:52:04 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce210a7sm59725725e9.12.2025.11.05.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:52:02 -0800 (PST)
Date: Wed, 5 Nov 2025 17:52:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
Message-ID: <3dzha4qyqdrbutxby3n5nkvihnxrhniqr6w726eumhzgln2w5l@fbu72mzmjz4m>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
 <20251029163336.2785270-2-thierry.reding@gmail.com>
 <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykyajizgfjgayrmb"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>


--ykyajizgfjgayrmb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Mon, Nov 03, 2025 at 05:18:08PM +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 29, 2025 at 5:33=E2=80=AFPM Thierry Reding <thierry.reding@gm=
ail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Several drivers can benefit from registering per-instance data along
> > with the syscore operations. To achieve this, move the modifiable fields
> > out of the syscore_ops structure and into a separate struct syscore that
> > can be registered with the framework. Add a void * driver data field for
> > drivers to store contextual data that will be passed to the syscore ops.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> This change is fine with me, so I can apply it unless somebody has any
> specific heartburn related to it (Greg?), but in case you want to
> route it differently
>=20
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

I have a few follow-up patches for the Tegra PMC driver that depend on
this. 6.19 is what I was targetting, so if we could put this into a
stable branch that'd be the best solution. I can set that up via the
Tegra tree if you and Greg are okay with it.

If that's all too complicated, I can probably wait until the next cycle
to merge the PMC changes.

Thierry

--ykyajizgfjgayrmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkLgLAACgkQ3SOs138+
s6F0Lg//dTn1/PUCYHRhF8cm1xB6JKggiLC40TRct49fcf9eF5gAdCqXm44qKoaF
67aqiXAiwzovTctJIu3rz8p71/FeXp/qGWDdPm/+wI7yD+BoCcVO0nmvXuPwCzhd
ZMwqeaRVm57JX4M9S5BdkOGtDLgAjyZ/6Qq/2isiQSPiWWl/IT3YiLyzw8vq8mcY
VoepQGK5hm7CHFf8FOBs+sMt6q5JJDm0VjNi+seVcCNg9U25GaXCRc2D9ztAqRib
3768/KMhlftnoJKsizCwWq2Gyw0Se7ifz66djjf51sHd064LLDv7OZpfeGyiFK01
MvVGXoPFuIJB0yqIoMRBbeRULm4kq+dkUkt1JWwYAMw9ZJnhXPJJI8bal2IASj8/
E6NADiYd9HS8kAXWYvLkm0xHv4FN5WXWG2a+Gf6K2vpBm07zG2xnI+eVjYQSnb9W
O9TcZf3jDWvgEQ31plH5JFY32sI4vjLAdcKS2oRfkbxFDJvTS+RRjj3EPqFshNXf
B5E6pXTCltOkUepuhbGDzIifVWzYgg/GyXNfwzdnJUXcAz7QPPJySfMraf/dn+8S
hggVgAivRFDEtaNEqKU6iqoePR3HIUJe/Ebjrb199RV9t4FcnVYOpviJRf5EWpsF
2YEUJPiA7neiac9fPLwCoRh33bJTIzanmWVxmFF1nQ2vozIt68U=
=3Mmd
-----END PGP SIGNATURE-----

--ykyajizgfjgayrmb--

