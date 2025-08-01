Return-Path: <linux-kernel+bounces-753574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC5B184BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250414E15D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B6270569;
	Fri,  1 Aug 2025 15:13:52 +0000 (UTC)
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1C26E71F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061232; cv=none; b=NQ2ZY4Dh+6gEzJYeMajwdCLVvsM/vTN72Cd/ptCfDwAAt726XpB2+ZJNxmJuYSCLO7SexeMTgSYDssFrKGV+Lz5mJ5PSh8Vqt86F5C/G8Gb2RwW6ACxQXPXXMLaGYG+6Qxq4a4xamCpcnYO9m94X99NL0z2VBCwdh/3GIIYm4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061232; c=relaxed/simple;
	bh=C2y32lRSVTMtr1KeNFOZCFbVFkLJg6Owjmr4DXQmCgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uObh1yjoe/onu3w5ZSTRKA28YtTlApVk0QkyjPXrWpaYShp5JPqkWnD0lluweaKwAIzOvOb93f5pw/6m2cm6qItWeY6yTNV+cgdf1aoRL8kLRJsn/b3TDnC7t+aP58AFqF78Yk80cX1n1J1Be6ptCPMA7dpRw1T++7ZMsjiGvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40] (unknown [IPv6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 241D03F116;
	Fri,  1 Aug 2025 17:13:45 +0200 (CEST)
Message-ID: <8f8ad642-bc62-4210-be11-6a5bd64411c5@hogyros.de>
Date: Sat, 2 Aug 2025 00:13:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Mark xe driver as BROKEN if kernel page size is not
 4kB
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <460b95285cdf23dc6723972ba69ee726b3b3cfba.camel@linux.intel.com>
 <20250801102130.2644-1-Simon.Richter@hogyros.de>
 <274fefe9b46bb856e5968431ed524ebe1b8e8cd4.camel@linux.intel.com>
 <37abb9a1a4fde174a54a9d7868d31b2615df0e47.camel@linux.intel.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <37abb9a1a4fde174a54a9d7868d31b2615df0e47.camel@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wNpcGvIeCpp5TfJ0uKxU5349"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wNpcGvIeCpp5TfJ0uKxU5349
Content-Type: multipart/mixed; boundary="------------CTEnt37qgnx0gBPXTd3N0LIT";
 protected-headers="v1"
From: Simon Richter <Simon.Richter@hogyros.de>
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <8f8ad642-bc62-4210-be11-6a5bd64411c5@hogyros.de>
Subject: Re: [PATCH v3] Mark xe driver as BROKEN if kernel page size is not
 4kB
References: <460b95285cdf23dc6723972ba69ee726b3b3cfba.camel@linux.intel.com>
 <20250801102130.2644-1-Simon.Richter@hogyros.de>
 <274fefe9b46bb856e5968431ed524ebe1b8e8cd4.camel@linux.intel.com>
 <37abb9a1a4fde174a54a9d7868d31b2615df0e47.camel@linux.intel.com>
In-Reply-To: <37abb9a1a4fde174a54a9d7868d31b2615df0e47.camel@linux.intel.com>

--------------CTEnt37qgnx0gBPXTd3N0LIT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDgvMS8yNSAyMzo1NiwgVGhvbWFzIEhlbGxzdHLDtm0gd3JvdGU6DQoNCj4g
V291bGQgeW91IG1pbmQgaWYgd2UgZGlkIHRoZSBmb2xsb3dpbmc6DQoNClsuLi5dDQoNCj4g
QW5kIGluc3RlYWQgaGVyZSBhZGQNCj4gCWRlcGVuZHMgb24gUEFHRV9TSVpFXzRLQiB8fCBD
T01QSUxFX1RFU1QgfHwgQlJPS0VODQoNClRoYXQgaXMgYSBsb3QgbmljZXIsIEkgbGlrZSBp
dC4NCg0KICAgIFNpbW9uDQo=

--------------CTEnt37qgnx0gBPXTd3N0LIT--

--------------wNpcGvIeCpp5TfJ0uKxU5349
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEtjuqOJSXmNjSiX3Tfr04e7CZCBEFAmiM2aYACgkQfr04e7CZ
CBELugf8DqUbmek/kQtrnhBllfJ7bBzpmAmD+F0ojUiPgJS9JT+rKEvRLJYaboyK
EbwvUNQkcks0/dWYLoo0+nSCeeabgxCmADS9qwE7Q/aS4y+m2CmgIeKqnnTsgVt9
ImIyfH+p5XJSFAAJ0VgaYN89z0mfCkmOfN6Y7ULBGamEEyu/21qXUS/6yP1xM4e9
1XlklQuIoekGfdpJzdrQ80zj69DU+iOvnoG0u00CsZDYBvhWZnPgMj3P6LW8E7Fu
N88a9Lbm09KvX7f1jv0V+Q0Ip5YoipkdrAflcIkr/aFn8bW2ECzcbyYojioZZqTF
iXNF1QKNvbPmK5Vk+phNqG1HSmmcKQ==
=Sg8e
-----END PGP SIGNATURE-----

--------------wNpcGvIeCpp5TfJ0uKxU5349--

