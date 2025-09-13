Return-Path: <linux-kernel+bounces-815146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41951B56043
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3332E1C80552
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E02EBB93;
	Sat, 13 Sep 2025 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ30YJFI"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA33243958
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757759507; cv=none; b=gcB9Wg+jnVN6NH2WNmRGlxa6jmuUiR+PiX4DGSMturM3oNQqo5TQB9aGmy5ZTCqotNtLky2kORqrYUHoGya++38o2tleJNvKbAwv8Pq7PNQJiFmL5eYxOk1Aj3vnL5lLQcDoe2TDG7oYYf6RahkLxSKTOgAGHfP285+t5voBQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757759507; c=relaxed/simple;
	bh=kLjujwuai/vpVgO0CVp+hKYrEhCuNSFv89vDY2WVAtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwjLv0nNPpIEG+JxMSVEMKRyCA5PWu/6751LSQ5Eo4F19k5Eky4jMcpq90wTkm7DTpHkHh05fxAMvEd9X3nPPGOIwfDfXB+rht9EKGNht9IryqB7lYcurVuBz1L6m0y96/mjXu0jhSeEvAsL/JUN2brvWbEP3O9Y/4EvOvsSuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ30YJFI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77615d6af4fso1723434b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757759504; x=1758364304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ir/ou5rnkwOqwXWRi/QtrwXILS7ZMKlDX7jKwfdf6bk=;
        b=eZ30YJFIfsiU5z3icVuoPChp1JDUYPQ+Y0xRUsbwscuJYquJBggi8FVXwgQYISVSXB
         79U3c7OyN74ajw2wtFM1MZ41L5D31jqkqyd2bUJ4Wkx6bYi0ptJivDKa0Qdd6s8JXUyD
         0o7UrZca/YX0bkhIHlnPRo7coHdjULBUHrQrwmlgzphqGaDAyilmW/cPazjLbLqb9M3s
         DlMfooEpdvAVYw22SPZiXNFwLrVbSwV6E+Fnvufx0OrTjTOijGPw0VBG5TrbNtA+R9R4
         /hnNBa78lsOlSXv7sbKlsli1nLsWE2nOCsAGNmJkOjqg4KuU+xY0SGFEouMArhrc6Yu1
         SBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757759504; x=1758364304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir/ou5rnkwOqwXWRi/QtrwXILS7ZMKlDX7jKwfdf6bk=;
        b=S/RzuTW//29qFvuwJOkwcjmNG4A+3gPALkEMTradAbLVId+8+xwtEcV/OjJIRJ2xOW
         CDVnuDFR1v5WcOIig+q2Se+iP89sRe0bsDYBFx7ZCIO24w1NNIxkM+ZtBMyYZYjWYTJN
         b6UBWk6jhbuLb9Si94vSI4OuOGObOxi3DrSL1QlYFHIC1u+6Q4KpNyvZUx8cxvXGiYwq
         yVdtkvCDNART1XRPkZI2llZKWcsVb8A/Pz6UqWIfR9wPoomRrJPjKFu8kV9yGBkMyaE1
         HIZQsJnfKDRcRxz6t765Xpf1tlObwhFLGdJcX1WzErQNKzgFHNy7IpmTJh+wxFW1Rv3Y
         wjbA==
X-Gm-Message-State: AOJu0YyJsAKBqDYylg/ou39Lz2Rnh7NBiLc4PxTEa75VOauA19Lb/Zx9
	lTbptl6UvmW5jRbH2jxaveQ958XFky6q0D128zrsWrVYiMRmd2m3nBcR
X-Gm-Gg: ASbGncskSivlY71XtJzpVhlGej6hciW4U7FTLqREUADbAhiN7r21iGYHP/IdTVKqdMg
	Ls3kiHlQRYkjvQo8ls6qMLgT6Hz/oZRj9uC9XiNIgN0EHMdztJhHCeGASe0XZu0Gl+bUXMe/GAb
	FV2pimXQYl9cdMqBmp72ZgXLxMfjbmxHotKK8Xs3zm2fHLJrk1odNWiqU/1CJd/STghohssupDt
	i67Wm1961iZX3jGoA3F+Y4iRhLT3NyQrdOFLk1BNfiUG3uxK+ZJN66JgGdhL6NFhJFF1jFGBu5o
	3X5/AG/6wMzsW74XahtaaH4xZF9TqjmPpIETUefjGazq69nwMyYVi6hB1GUMDM4KfI5rSA+3MIf
	//hJsJbmE0DROSbltm7OHwlsWyQ==
X-Google-Smtp-Source: AGHT+IE1M/1765Yw0DM9+sKSZqF04QztVs/dVj/lsNzSSoRC0dhJ9gntacDaXmIdc0UtyGw2H3M2AA==
X-Received: by 2002:a05:6a00:a8a:b0:774:52b9:b17e with SMTP id d2e1a72fcca58-776121a116amr6003596b3a.30.1757759504326;
        Sat, 13 Sep 2025 03:31:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm7622198b3a.78.2025.09.13.03.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 03:31:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4A1184206928; Sat, 13 Sep 2025 17:31:40 +0700 (WIB)
Date: Sat, 13 Sep 2025 17:31:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Avery Pennarun <apenwarr@worldvisions.ca>
Subject: Re: [PATCH RESEND net-next] Documentation: ARCnet: Update obsolete
 contact info
Message-ID: <aMVIC1w5-Lm5KBXX@archie.me>
References: <20250912042252.19901-1-bagasdotme@gmail.com>
 <20250913085926.GI224143@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4hOK/4Qme/73oVSs"
Content-Disposition: inline
In-Reply-To: <20250913085926.GI224143@horms.kernel.org>


--4hOK/4Qme/73oVSs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 09:59:26AM +0100, Simon Horman wrote:
> + Avery
>=20
> On Fri, Sep 12, 2025 at 11:22:52AM +0700, Bagas Sanjaya wrote:
> > ARCnet docs states that inquiries on the subsystem should be emailed to
> > Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
> > since the beginning of kernel git history and the subsystem is now
> > maintained by Michael Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add
> > arcnet and take maintainership"). In addition, there used to be a
> > dedicated ARCnet mailing list but its archive at epistolary.org has been
> > shut down. ARCnet discussion nowadays take place in netdev list.
> >=20
> > Update contact information.
> >=20
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> I think it would be good to get buy-in from Avery (now CCed) on these cha=
nges.

OK.

> >  Because so many people (myself included) seem to have obtained ARCnet =
cards
> >  without manuals, this file contains a quick introduction to ARCnet har=
dware,
> > -some cabling tips, and a listing of all jumper settings I can find. Pl=
ease
> > -e-mail apenwarr@worldvisions.ca with any settings for your particular =
card,
> > -or any other information you have!
> > +some cabling tips, and a listing of all jumper settings I can find. If=
 you
> > +have any settings for your particular card, and/or any other informati=
on you
> > +have, do not hesistate to :ref:`email to netdev <arcnet-netdev>`.
>=20
> nit: hesitate

Thanks for the suggestion!

--=20
An old man doll... just what I always wanted! - Clara

--4hOK/4Qme/73oVSs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMVIBgAKCRD2uYlJVVFO
o6VhAP9ZHl+3iy4x+Rd15oqUntPdAeEv9b3hRwXxVnaB8WxFSAD/WmtZ92mVhxV/
pPCAWlZCduMo6eJb8etByHzxQAp7GgU=
=rMpI
-----END PGP SIGNATURE-----

--4hOK/4Qme/73oVSs--

