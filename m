Return-Path: <linux-kernel+bounces-772062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BAB28E60
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B161BC54AE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999F2E9738;
	Sat, 16 Aug 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="USFgHKsW"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A0347D0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353495; cv=none; b=KdU5+7FI38Ix016QbQEbFRn/Xn7G3+AU5hephK+bVxU37zU5g9dipiDtkI/i3f5vp+m/M88s05/4o0l2Ta30VObayEZEKlptgj6Km9rNXLz0Gwh0RLcohylToPPeaiGlmzACHDmuK4s6Ucw2D9Fq47N4hQ7FLbp+DL17X40Df48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353495; c=relaxed/simple;
	bh=olXWmm3jSFvSdhRPnxNlNEgEC2/BOJswPUCg764FGOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pdV4HIFl/ST9EPEpzILDUkGgImty4KGYhk/Y2B645Cw6E8T+oyUD11ez9Tx24HsOG9yEWbl8omKuKljxyKnvjn94yK/5cujb0e3/WCWIXEh+zqSmssFueyXLH2TpXuJ8mZlhwxDJPpqZW7Ob2k3NELRL8qq3Yf07jIqvEo+MSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=USFgHKsW; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755353490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXOtsIBUt5Q8GjGEEyrG9hdfarb8U4iDDYTRYZfEMLE=;
	b=USFgHKsWMRwclD+dOKPvxw3L05Nmw54SaqWFKKCtdtAgcAPvQDBugNjn1H6Dj/nyOVx7Ii
	dDfeXXVAs53e4Flkqlt+Lkc6BzbZaGKZ8HIQBtJFOhEKJ//Q8n2mkIJcYzMPrUw/Ft0vC8
	8dF8y2opMvnRH4gqEIxKI795X7uwwRuOzKruPKzEYNVkcr/UtFpeNYV56zsww3xakszOGo
	uFuy+WwLD+Fme6BfIdK0i40jECgainadzECXo5gMem8cfi5iW6+ill1TUNXOrMej3BTVfR
	gWZ8JwV8oHXCK6aZFdE5NIKahpbAYov4LAWFSf23Go1tihYRQZW39eSeuPGQmQ==
Content-Type: multipart/signed;
 boundary=ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 16:11:00 +0200
Message-Id: <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Diederik de Haas" <didi.debian@cknow.org>
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Keith Busch" <kbusch@kernel.org>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp>
In-Reply-To: <aKCFjzai3Y0RcGHP@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT

--ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
> On Sat, Aug 16, 2025 at 01:40:44PM +0200, Diederik de Haas wrote:
>> I have a Samsung 970 EVO 2TB SSD and I see these kernel warnings:
>
> ...=20
> =20
>> I wonder if something can be done to fix those warnings.
>
> Are you talking about this message?
>
>    nvme nvme0: missing or invalid SUBNQN field
>
> You can't do anything about it, but I wouldn't worry about it either.

That's indeed one of them; good to know it's not to worry about.

> If you want to see what the driver is reacting to, you can check the
> subnqn from command line:
>
>   # nvme id-ctrl /dev/nvme0 | grep subnqn
>
> It'll probably be all zeros. The field has been required by spec, but
> the driver tolerates ones that don't implement it.

root@nanopi-r5s:~# nvme id-ctrl /dev/nvme0 | grep subnqn
subnqn    :

So it seems to be just empty?

> It's just a message that the device isn't spec compliant, but
> otherwise perfectly operational.

But still worthy of a warning (instead of info) msg?

The other kernel warning is this:

  nvme nvme0: using unchecked data buffer

The SUBNQN message appears every time, this one appears often, but not
always.

When researching this/these issues, I discovered the nvme-cli package
(with the nvme command) and via its manpage I found this command:

  nvme get-feature /dev/nvme0 -f 3

I didn't even know NVMe's had namespaces, but this didn't look good:

  The namespace or the format of that namespace is invalid(0x200b)

... without actually understanding what it means and/or what its
consequences are. It could be harmless and/or normal though.

Cheers,
  Diederik

--ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKCRiwAKCRDXblvOeH7b
bsMOAP467UvBdOwLTCTyaNzSEfLdNs09O66h8luJumIRs2fs2wEAgmhYVurmWFBA
TqpVQhTLqv4KBJri3VBLPBP7uamUAAI=
=23W7
-----END PGP SIGNATURE-----

--ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c--

