Return-Path: <linux-kernel+bounces-838507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD8BAF57A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A795B7AE5DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06530278E67;
	Wed,  1 Oct 2025 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHXtSLst"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADB23C8CD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301976; cv=none; b=MuIrMejF2aVdI54dvWdbkMOkbLC/dEb05NZMrh57zxIsQTplfp5p05sKslGka0mCKnLpHgdB2E3XbYwwGpCKvdSgy7FyEo0w9U2pZnNLEx3mvBwMQhfMIa1k0+L8Y1y3ThD+/0K5HU8rhTwj41UjIiHHCS/gnnXcvmsNrsFimqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301976; c=relaxed/simple;
	bh=1yJxZK3byuLEeQPsQJ6XJ43/ahRJPZuvJfz7COfwWkA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Yt1FbxmCUwIV6arFxlwhx5w8Ub7IRUPaZD+izJZVjobsQQp75gS6p2mNfeUsx4qBodygi3SwysRun6ct3xgizr3oEHa7vml7klsWEzBbOaWIFptd/EHkLKHz5T+BZ5FroxiJM8o1I4MhAy3ZzzO2KLAQz9AytwzNs7JE4L/rgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHXtSLst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FE0C4CEF4;
	Wed,  1 Oct 2025 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759301975;
	bh=1yJxZK3byuLEeQPsQJ6XJ43/ahRJPZuvJfz7COfwWkA=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=BHXtSLstPI8e8tMP+yHELucjuefDahdhaKs0MUmyXwi4hRD1dOQfPrBP5rG3PcaWe
	 lpxGM7dy9E3tkUdHtM0iL9+EMmet9lypUwhqBM1tahnUDNadV9C/DpIEzjomeLi48v
	 uED4P64eOS0O9WuSXwiwqdrvqAzo9E/1r5Pr0h8Hyj4TdJ65ryq8OyHUZiqw30ox1M
	 zND92Kc1w6TUYpfWzOfb8QbgAIS6uTyIxMaQ7SGdeuU8GOBr8Nr82hbmA4yR73ci9d
	 recBekhXWmGkxL27wN3xMDqIdj5sJLLvEHgA4p7MgcPUs8uVl5JCwSysb8xshaIZ07
	 ZkfeME4JXszEw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=59e99ccff2b1627692d0a8b7f4bbfe00a63a16e6c6d961c2c4ba750aa455;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 01 Oct 2025 08:59:31 +0200
Message-Id: <DD6SI06QNEE4.2YCRTWJHEAAQM@kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: macronix: Drop the redundant flash
 info fields
Cc: "Cheng Ming Lin" <linchengming884@gmail.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Guenter Roeck" <linux@roeck-us.net>, "Cheng
 Ming Lin" <chengminglin@mxic.com.tw>, <miquel.raynal@bootlin.com>,
 <richard@nod.at>, <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <alvinzhou@mxic.com.tw>,
 <leoyu@mxic.com.tw>
From: "Michael Walle" <mwalle@kernel.org>
To: "Maarten Zanders" <maarten@zanders.be>, "Pratyush Yadav"
 <pratyush@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250407075400.1113177-1-linchengming884@gmail.com>
 <20250407075400.1113177-2-linchengming884@gmail.com>
 <d98f6eee-d5f7-43b7-bbc8-d6e7e274723a@roeck-us.net>
 <mafs05xh6pf7s.fsf@kernel.org>
 <da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net>
 <a2a0c40e-69d7-4408-add2-88616c92b0ca@roeck-us.net>
 <aa2a4480-9b78-4ed9-8f9d-b18a87eb01e9@linaro.org>
 <CAAyq3SYybDgBvkTKh2ZB4UdKq1XV_nnzx3Tj1P915W5x_7_nNA@mail.gmail.com>
 <DD10QMSJVZ2K.26U45JAXV5EY7@kernel.org>
 <CAAyq3SYyqi-oR8T039Zd0uaF6UieX3SdF9UF2kxOG6+yJqAEUg@mail.gmail.com>
 <mafs01pnoceum.fsf@kernel.org>
 <CAPB_pE+f7QGNaBgWz6OSOmfBAdCoOgnUhCV=KzUR94vWt_pEYA@mail.gmail.com>
In-Reply-To: <CAPB_pE+f7QGNaBgWz6OSOmfBAdCoOgnUhCV=KzUR94vWt_pEYA@mail.gmail.com>

--59e99ccff2b1627692d0a8b7f4bbfe00a63a16e6c6d961c2c4ba750aa455
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 30, 2025 at 3:15 PM CEST, Maarten Zanders wrote:
> Hi all,
>
> On Tue, Sep 30, 2025 at 2:19=E2=80=AFPM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>> > I agree with reverting this patch. When I initially verified it, the
>> > devices I had on hand all supported SFDP, so I did not catch this issu=
e.
>> > After checking again, I confirm that some older flashes without SFDP a=
re
>> > indeed affected.
>>
>> Do you know if these flashes are used in any devices that are actively
>> used and maintained? If so, we should revert. If it is likely they
>> aren't actively used, then maybe we just keep things as they are?
>> Dunno...
>
> The non-SFDP parts have been obsoleted in 2009-2010 according to
> Macronix's PCN's. So they're pretty ancient.
>
> If we choose to keep the patch in, I think we should make it more
> consistent and drop support for the smaller flashes without SFDP as
> well. The behavior is different in the spi-nor core for SFDP-parsed vs
> non-SFDP-parsed cases.
> In particular ID's 0xc22016 and 0xc22017 could be handled in the same
> way I believe?

Being EOL doesn't mean they aren't used anymore. SPI (NOR) flashes
tend to be used because they are a rather reliable. So I could
imagine that they are still in use somewhere. My main concern is,
that if we just drop them now and thus make newer flashes work (like
the one from Maarten), we might find ourselves in an uncomfortable
situation in the future. What if someone is reporting a regression
with older flashes? We can't just revert this patch then because we
already support newer flashes. Actually we are in this situation
right now, but not *that* much time has passed.

If we decide to drop older flash support just like that, I'd vote
for a grace period where the user is informed about it.

But I still think we have a better solution: always parse SFDP.
Pre-populate the flash parameters with the info from the flashdb and
then just try to parse the SFDP. There was always the concern to
issue the RDSFDP command on flashes which doesn't support it and
cause unknown behavior. But we are already doing that today with
unknown flashes. So far there was no single report and we have that
behavior for years now (commit 773bbe104497 ("mtd: spi-nor: add
generic flash driver")).

-michael

--59e99ccff2b1627692d0a8b7f4bbfe00a63a16e6c6d961c2c4ba750aa455
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaNzRUxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jC3QGAvM2LLUFf1p0n0KiQZRdrXOutgVN6J6Tf
TM9WL6ezcuCuNUkJH8fKfC0y59aPVjPgAYCr4DEqdDowo76gJ7h9Ikqetua4oyfv
NlYLZ9MQc3kRKZD07XwJaqT6rqOn8Jt5U5A=
=tm4a
-----END PGP SIGNATURE-----

--59e99ccff2b1627692d0a8b7f4bbfe00a63a16e6c6d961c2c4ba750aa455--

