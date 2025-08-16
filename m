Return-Path: <linux-kernel+bounces-772021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E223B28DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B5D1CC8BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDB2D1900;
	Sat, 16 Aug 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="R4++E+q1"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33211E32A2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348769; cv=none; b=EenHA0x/pvbh7lO8RtWztx8fdbO48JedRI/eb55Qgigdb+cdW1dQ/8aDeCPZ9uQ76Qopknm3ME5zyPCM8lKP+6pXEDV7B8qEJ/BFAQmCTOEzV8LQ+yYHHNqY0wFfmjPh35lSS3HzoW9HPZRRa833a432EJxaY+c5VZ5PzYzyCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348769; c=relaxed/simple;
	bh=DiVDHaOpcA3DK51ZXSmyw2nSo5vZhv7pR2pf1XeiAmk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FJeYzJebm5J7jEMq+ka0DbYJ28kEHtHqhCthnyWWXKIhJlGNEdbf1uK8QEPGQ21wsSlWy5hAE2MSm0XFX5YqJiRfFgnIVkg9kz477e55fv7hYuiLeSIHLmQCjNphTiVYs5nas+mElFPJc6/ndckrrptyfzrBAleIMTUnHENUq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=R4++E+q1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755348763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DiVDHaOpcA3DK51ZXSmyw2nSo5vZhv7pR2pf1XeiAmk=;
	b=R4++E+q1UH+qS1JZ4atkqM/wDu6nG4qONMWdMDK0CKEPdAL2zql5uLCB645B27mjAtUEyD
	7JYfSq9b8yQuNTenU4Wf+e1Fs6ToYUOw90MWV5l/+k0EvpCm0DV34wGWZZHMFMXrdfW2Bf
	AovhE2GdUoibtOwoLLTirA+dzu2bgHP4pfhbOhyLgwjXgfww2PB0THhjuK+gISjfaaTMdj
	+mywkpuo1mNAE8RI7Gkt2OIo7GUNzN8iZ414k9fdPuMcI8jfTem+CpGqzMwXIbxw/2xbGp
	nW2f//aekO2DdMSHf3ouhK37LZ7Jgy1i7rOto1HwRr8lCnbZ9i1WrDqMvnH0vw==
Content-Type: multipart/signed;
 boundary=c7ca901699c7ac3f0671bbbb30feced874bd61b11ef22e9d85078ac466f0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 14:52:33 +0200
Message-Id: <DC3V792JTD1J.LB1A657GBFQA@cknow.org>
Cc: =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: RFE: Make ANDROID_BINDER_IPC tristate
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>
 <2025081642-viewpoint-exemption-006f@gregkh>
In-Reply-To: <2025081642-viewpoint-exemption-006f@gregkh>
X-Migadu-Flow: FLOW_OUT

--c7ca901699c7ac3f0671bbbb30feced874bd61b11ef22e9d85078ac466f0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Aug 16, 2025 at 2:47 PM CEST, Greg Kroah-Hartman wrote:
> On Sat, Aug 16, 2025 at 02:11:24PM +0200, Diederik de Haas wrote:
>> Programs like Waydroid allows people to run Android in a Linux container
>> but it needs ANDROID_BINDER_IPC to do that.
>>=20
>> So hereby the request to make ANDROID_BINDER_IPC tristate so people that
>> want to use it can load it when needed.
>>=20
>> Debian has a patch to make it tristate since 2018, but it would be so
>> much more useful to have it tristate upstream.
>
> Please submit a patch to do so!

I would have if I thought I had the knowledge/skills to do that,
but I don't.

--c7ca901699c7ac3f0671bbbb30feced874bd61b11ef22e9d85078ac466f0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKB/EwAKCRDXblvOeH7b
buJCAQDT/FHOE16APTig+tL/KfgEKbfMibcJQ5BaIwOPBIG7dgD/XsgSW5LpE15P
+myfeJhBrdxqq1YAwpP1rP516t2hCQk=
=wWgM
-----END PGP SIGNATURE-----

--c7ca901699c7ac3f0671bbbb30feced874bd61b11ef22e9d85078ac466f0--

