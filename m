Return-Path: <linux-kernel+bounces-771994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8757FB28D95
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254DF7BB538
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262F02C3745;
	Sat, 16 Aug 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="NsPx8h9b"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459C15855E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346306; cv=none; b=OU5btwKdS6AV6jLDX+birexcIi5ZjGLkqCMiUSNFBmvKa8ZNW9Gec/CyI1sv9ppoiZ+IqUB5xcVq5D4n1quFpjXlO13kgNGlQZzLSDTegZ/wlcL9ojTTlQMsf3ZPCczt7xMsfWTVlFD+gUbwVuJ5g8szROzwGpu0/2bXm1O0IyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346306; c=relaxed/simple;
	bh=l1HV51eeOe//1ENlHj2vPC5fQBsOIDDWI6hgM44BWFU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From; b=FRXTwHTXZBFyQSDIgXmUC5KfhG6yTdhWo2Q84cXpo3hEu5r3Mdp9s8RGNG36M7ViVvB9qPBJZ4plsvMqcYD3WzRhEXZy4PJPHabJT5QILrSWY43bdM2Q/zAaLOtqlPNkLEu2PDRy7ukzNGgcgsezDE/bHHliJiEPk+dcL+5Xb+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=NsPx8h9b; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755346301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xS69j102n0ByNFn9L2SZpcPeFarUyQ36TTnQuxb0VNE=;
	b=NsPx8h9bbz4hoKypWGLeRdYBCQRLP3wpDloyQjLXWKqVC49EdL3A3GPIr774Aeqa8mm1DT
	H9GYGpmI4C9kXUOprS3OAdxdsqNY70L6zbNDxXCTN6KewoHjlIO2Y1E4qxncKFGUcbdRQo
	qMBjkUu8tIrxuk33FMCDF1r50qQCY5ut7sraYNNeqyecFwGZUisbemi9BRoH7RRa0V9hTu
	kecpovbng6GlFdBjuKu/QEj20XZ6YIDWnTzDA4bAna4g/8dZG7MLRVwrEtPbKzxPiQgABA
	O899LXpeYhFjwZt5Rc6cYlnhvtAsJ6SNwXBkOBQBGp8ORzqiUwC1WS3356Uuiw==
Content-Type: multipart/signed;
 boundary=b7b54b391ee81a599eecb973d0e72162a04a74d25f02b6d6c2a8380b6b6f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 14:11:24 +0200
Message-Id: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>
Cc: "Diederik de Haas" <didi.debian@cknow.org>,
 <linux-kernel@vger.kernel.org>
Subject: RFE: Make ANDROID_BINDER_IPC tristate
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
X-Migadu-Flow: FLOW_OUT

--b7b54b391ee81a599eecb973d0e72162a04a74d25f02b6d6c2a8380b6b6f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

Programs like Waydroid allows people to run Android in a Linux container
but it needs ANDROID_BINDER_IPC to do that.
It would be really helpful if ANDROID_BINDER_IPC could be dynamically
loaded when someone wants to use Waydroid (and unload when no longer
needed). But currently ANDROID_BINDER_IPC is a 'bool' so either you have
it at all times or you will never have it.

So hereby the request to make ANDROID_BINDER_IPC tristate so people that
want to use it can load it when needed.

Debian has a patch to make it tristate since 2018, but it would be so
much more useful to have it tristate upstream.

Cheers,
  Diederik

--b7b54b391ee81a599eecb973d0e72162a04a74d25f02b6d6c2a8380b6b6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKB1dgAKCRDXblvOeH7b
bmjxAQCncu7/Kh4GayigJVsF/knt7h8otcqUSrrm77Wl3MQVWAEAhzKUTMX5IrIO
I1DSnId12U+sYED6aS8oR7F8vStxjQo=
=+1pu
-----END PGP SIGNATURE-----

--b7b54b391ee81a599eecb973d0e72162a04a74d25f02b6d6c2a8380b6b6f--

