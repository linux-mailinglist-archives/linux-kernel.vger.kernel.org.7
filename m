Return-Path: <linux-kernel+bounces-819537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27747B5A24F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C219584A52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A002F7459;
	Tue, 16 Sep 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="IiZ4tN0G"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E32D6E4C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054255; cv=none; b=bi8PtfKymRu8a8eWtXRPejX4jkIPwmzxid3QXOXb1f1n/wtvraX5kX2FKUVKfuNRwe2HqQi2zMZbG9XltFi40o6RciBdm4gu6c8QyfgtXmsj3DI3gDINMGZ6rKy7BKQR8htmpbg2n3ws5oScKhRNXLFk4LEI2at0rw3hwfPDVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054255; c=relaxed/simple;
	bh=Cc7omW4q7JP28urIsO2ZKspLyuitYi54V/d+iUGc99A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MELx6VOdlg0I+Kabl/8PR035SuVMj1WFjKLL2wKvsp9J4svvkPfvHB0BHsIuK6cjaNxMRM9WQGuPNIUhfgnOEwvdXMlCoaQj6tXgNeQ6QToyitXZXkC+hL45XExB3xltMX/K9Bi0JEAuWivqEi3JzhcXhcBvYaUsZ0Azg7mA03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=IiZ4tN0G; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UFmjREzWYFiMkZWMadwN5GVfDDLgdw6R68iY+O9sTBE=; b=IiZ4tN0GLaamaAqIZzQjs9MpgJ
	eRMp0OlPdWzEY7RNe9YBSNfeNFCcJjWQnJqvaKjeeCNxdg3DP/dPWY3/j6PY5zzIJHaeIzSTbB0Tf
	lhWGt1h9sfEr0SEnNpasHNLfv+4QDoyKCnIKAGPw6Aot3Sh12C2ctsiFgexHwAFAFxrbfrsWQArl5
	qthNs1RMeEoTxToy0kOzWGMmMU2Z2AA0H3KlUoFeYjXdtrJpoB376uqX/Pd3KQIxZx42ZcHKaJsUI
	+wOhjQYEVjNHH8uAUax9Vgq0EENk4meeE2Da7ZD9QPHrNqr14vJd0yMjcimj5Q9M0ibsh6PvHnnHz
	NXItkZUg==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uycCr-000000008Qk-1kDu;
	Tue, 16 Sep 2025 16:23:17 -0400
Message-ID: <cf407a37403360ca8c74982a5ebfd7ed1f8b34fb.camel@surriel.com>
Subject: Re: [RFC PATCH 01/12] mm/cma: add tunable for CMA fallback limit
From: Rik van Riel <riel@surriel.com>
To: Frank van der Linden <fvdl@google.com>, akpm@linux-foundation.org, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev
Date: Tue, 16 Sep 2025 16:23:17 -0400
In-Reply-To: <20250915195153.462039-2-fvdl@google.com>
References: <20250915195153.462039-1-fvdl@google.com>
	 <20250915195153.462039-2-fvdl@google.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 19:51 +0000, Frank van der Linden wrote:
>=20
> +#ifdef CONFIG_CMA
> +	{
> +		.procname	=3D "cma_first_limit",
> +		.data		=3D &cma_first_limit,
> +		.maxlen		=3D sizeof(cma_first_limit),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE_HUNDRED,
> +	},
> +#endif
> =C2=A0};
>=20
I like the code, but the name is a little confusing.

Maybe something like "prefer_cma_percent"?

--=20
All Rights Reversed.

