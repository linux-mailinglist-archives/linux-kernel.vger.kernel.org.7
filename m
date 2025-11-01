Return-Path: <linux-kernel+bounces-881605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E92FC288CE
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 00:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3357B3BC4C3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 23:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B667283FCE;
	Sat,  1 Nov 2025 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhuBfwxQ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D052727E0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762041331; cv=none; b=S0heTadYWAayEYs91XbkbvxlRSva+X5nZdLw8EkmSgphOUVFxAZEPzs80/sbYuZ4cfPMLjnFM1ouaAgmf8666VS/xlVrIZ6RoEjOdZUytkm74nZS4Bh21wITRi68wuKtyFgbplA35UDRIgGtfMZGBgI71jGQI50TZaplFS/5o4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762041331; c=relaxed/simple;
	bh=tZnELm08j7of0Xfv0WmU01hVCDM6ZuupveTtZqvPt5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSxDPrSCfrh3ArnaemFK4RqpBorctSPODQ2lE9S6Lob3hu0FmLC4EAyZeXqp20icnvJFu6pDpsWAQnTUwN/5M6gIB23qZ1zeTqcdpM0a71GdAZYSkDL3t+BJ2csMrpI2biPSUJvTy1VjN6WqZL3C21ecGsjQJy3vk0zx2IRikBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhuBfwxQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b9a6ff216faso81718a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 16:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762041330; x=1762646130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4d9NbVLbZ71yjIsFOR25rdS14CzByZ0HAq9jJrJxxc=;
        b=IhuBfwxQhYnNqmvubr8HtWIjxNvyj8eiuRipA2CZoPDL3TAe1UQ18GO67goNCSGKwe
         9MgoL5mi5zmyBrOvDrbJuGmOvktX/S2WiatpotD+GPJ41ERFlnBhPjHMsWp39xWir9uq
         b1rESD1I3+MYmtomvr15oLJKlYzpWHWOZqFthzMYQPDiZwXJFzApNtJllvqXezrF99r0
         oblOeY/6yZz/H4RoSzHQptZ6dIn7ZztbpXhF4sNIylTqigfTp2DAz3fdHTXgpZJngWoR
         0mkYpoiBR4Yz00wCYAxaSWmRSPafVvyiksd46IIRfgmnAe1QWipiKAQDdhcLolvD+mrJ
         JuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762041330; x=1762646130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4d9NbVLbZ71yjIsFOR25rdS14CzByZ0HAq9jJrJxxc=;
        b=rds7etgLfzfjjzg+auQZz8aIgmMxS47BJgT0n/Z7wEMwX5FlAv3F73voUPC0s4aUp6
         /9hH2NS4NLzCYeh4exiTcigg13PHk3zcZJTEs9GZ52qYag5fWobnenSMD2Ieo77IUQ+0
         JqMd3fcKr4fTs7Cdila4xmm48IRHcLCitLLV+P2jctWWa8T+9nTt2WIlUr3yChIE2Uxg
         SyEM2AXN6qLWS61CynDCSLNzLf9j3m4kcIQA0QUKb+2EpPz7wXfuqeOdAOLPTbKsCBfM
         Qk1Vs/CqVqzn6PMhkhirvaZdYLu+lOq54bJUUq1OFXD5eh5iJuHt97o3jcqGVqAgA7Y7
         Epew==
X-Gm-Message-State: AOJu0YwcVtkNW+venOLaMtdRl57KeVNwm1yATyya3ChBIF2XfIE4ad8m
	rUifYfqFOih6alCCZABkK4o/hkE4Be+6QgfIngwALX2QZHeW2XrsDvSu
X-Gm-Gg: ASbGncs1tF4HH5zMvfydP49Hr6qno/6ADHUYXVCMRo3IcM06EXe4RGWThT0h9YfaEHn
	UXZkpSJCwh6VvGOq2tzo96QAAFViXEohaEdBoGFYax00LydO8iUj0wmdWsJp+kaMSE18l9kzeSR
	6XE0mEF0xos4Z50V367mMRbdR+JVVV12pszNM0Ktmp8r9jdKiq6FjbLipR6OVEec6egaxgTiuwz
	XD96z1c/0sFaPvJVOvoyulMGD2l+2O5ol/2FmdjGgzqs9IXqpdNwCQ58LIubtJ7FDkYHyjLynmy
	aeMU6yV/nTobZF426xE/FAM/CtBBdrp9pWkFNuO6aKra6ok55ake3SRXXkWZNmulqT63ArabBFw
	Obzs+f/zxX16edhh2SLG9aaQb8FTUdIJtfhcfJh0oX7Qr5REthNVGqRwz6+3OUnXDfIUqxEQOuS
	il
X-Google-Smtp-Source: AGHT+IGRpA4EWSge9FEynJVlD/uzoZDN7jjxeaAWcd0tXEWkjk8DFuvwHJ/1T+lQA11kadREYpegYw==
X-Received: by 2002:a17:903:2f8f:b0:295:19e:487b with SMTP id d9443c01a7336-2951a39060cmr108779475ad.5.1762041329538;
        Sat, 01 Nov 2025 16:55:29 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295424bcc39sm49189165ad.17.2025.11.01.16.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 16:55:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DB5154206924; Sun, 02 Nov 2025 06:55:26 +0700 (WIB)
Date: Sun, 2 Nov 2025 06:55:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] staging: Pull in staging drivers docs into documentation
 tree
Message-ID: <aQad7uZ-rxCKs07Q@archie.me>
References: <20251101124053.62544-1-bagasdotme@gmail.com>
 <2025110115-nineteen-diner-186e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5NhrSJKm/+QMYFc"
Content-Disposition: inline
In-Reply-To: <2025110115-nineteen-diner-186e@gregkh>


--t5NhrSJKm/+QMYFc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 03:24:51PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 01, 2025 at 07:40:53PM +0700, Bagas Sanjaya wrote:
> > Some staging drivers have documentation that are spread out in
> > drivers/staging/*/Documentation/. Pull them into kernel docs tree by
> > using the same technique as in 1e9ddbb2cd346e ("docs: Pull LKMM
> > documentation into dev-tools book"): wrapping them with kernel-include::
> > directive as literal include.
> >=20
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> No, please do not do this.  staging drivers are "self contained" and do
> not spread out into the rest of the kernel.  If/when the driver moves
> out of staging, then it can be included in the normal kernel
> documentation builds and the rest of the stuff (i.e. include/ locations
> and the like.)
>=20
> So leave them alone.  Documentation does not need to be built for
> staging drivers, there are much bigger things that need to be done for
> them instead.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--t5NhrSJKm/+QMYFc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQad7gAKCRD2uYlJVVFO
o7RhAQC0xzjwMgYiLreuKLkmTjcmM51HZTpIv8zjWVHi3f6mUQD+NPHKZvvycT38
Na4hPtfWLiY/vsvsW1I/rzyMKGKusAY=
=KA70
-----END PGP SIGNATURE-----

--t5NhrSJKm/+QMYFc--

