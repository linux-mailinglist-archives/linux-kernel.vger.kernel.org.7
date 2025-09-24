Return-Path: <linux-kernel+bounces-830478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79351B99C65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4AE16C718
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2093002C9;
	Wed, 24 Sep 2025 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvWns/an"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B12E0417
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715861; cv=none; b=kvnLIopGkAcZcaDzsMuFPWoonVYBwtatnbSCIqdPz7r5sJ1ggAiUUnOmJ3EbyxEwE+WFRrHfUZM1xf2VqrAmtHEEQSym5WoTlKFPp9jAP32md7c8Q8ZpapzmEKilFKLllhyDSLAXnb3NyMCaGNLWVEjRNqtnQ+sdgk3mukPMc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715861; c=relaxed/simple;
	bh=NyeYSFx1kQDZbzJ3RfjmVhe8icCQd9sfzVXgN3YTbwk=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Oc/Bb3/Rj3k+IBHIaTsjxgntukPUR4eMb7/2rUnrQC1v8tfOriSN+oEYgEdpqhInd+uqygQixaP+jG85rwF7Fb6vC1qV0UpvW9n19Dce4iluoRW9vc+z/JntkxqRs/p7AQwTucJ9EVaiM2dU3tsJrH8QeI9ptKH8LNYVU86Qd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvWns/an; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20762C4CEE7;
	Wed, 24 Sep 2025 12:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758715860;
	bh=NyeYSFx1kQDZbzJ3RfjmVhe8icCQd9sfzVXgN3YTbwk=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=rvWns/anr0sgMmaaqe43oMV6Kk1+Sq+6Az1SPnyj1WdJouGQXLenyRXA8UUF/0zg7
	 EDeCNpw8kieA7rZ4mHZCwJ70S2TCjZcT7dqwlIoglxtiHhaUrHKXNjip+2h82jcpPo
	 oICFkGySlcCbr10IcTbcX1mjIS9Ek75FzUu+SP/LuXFhqPvUe8TSNzOcbnAjtQfX4U
	 5butg7sGyU/iODGVdNp0Nr9ZCm4QFEZM7nTecmDR8r4kojPwTQ6f/spJrm8htB9HPY
	 b4O6isFawl1ZFEVNfoCnHWB4K0ccaAOEGt23yXmZHU1PHvthaApO7igqhrrwgljsxU
	 d1p5RBy1iY9aw==
Content-Type: multipart/signed;
 boundary=1a5f7e5a91512f293e90383dc31ec41b3d82ae75e36c13b11b72ffba2487;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 24 Sep 2025 14:10:56 +0200
Message-Id: <DD10QMSJVZ2K.26U45JAXV5EY7@kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: macronix: Drop the redundant flash
 info fields
Cc: "Guenter Roeck" <linux@roeck-us.net>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Cheng Ming Lin" <chengminglin@mxic.com.tw>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <alvinzhou@mxic.com.tw>, <leoyu@mxic.com.tw>, "Maarten Zanders"
 <maarten@zanders.be>
From: "Michael Walle" <mwalle@kernel.org>
To: "Cheng Ming Lin" <linchengming884@gmail.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>
X-Mailer: aerc 0.16.0
References: <20250407075400.1113177-1-linchengming884@gmail.com>
 <20250407075400.1113177-2-linchengming884@gmail.com>
 <d98f6eee-d5f7-43b7-bbc8-d6e7e274723a@roeck-us.net>
 <mafs05xh6pf7s.fsf@kernel.org>
 <da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net>
 <a2a0c40e-69d7-4408-add2-88616c92b0ca@roeck-us.net>
 <aa2a4480-9b78-4ed9-8f9d-b18a87eb01e9@linaro.org>
 <CAAyq3SYybDgBvkTKh2ZB4UdKq1XV_nnzx3Tj1P915W5x_7_nNA@mail.gmail.com>
In-Reply-To: <CAAyq3SYybDgBvkTKh2ZB4UdKq1XV_nnzx3Tj1P915W5x_7_nNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--1a5f7e5a91512f293e90383dc31ec41b3d82ae75e36c13b11b72ffba2487
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> The root cause of this problem lies in the failure of parsing the SFDP
> data for the flash, rather than an issue with the patch itself. I believe
> we should not revert this patch.

I disagree. There are Macronix flashes with that ID which doesn't
have SFDP.  And this patch is dropping support for them. See also
[1]. Now I'm not sure it is worth reverting this commit. Nobody,
except Guenter complained, but only *so far* (and that patch is in
since 6.16). Any opinions?

-michael

[1] https://lore.kernel.org/r/DD10GE4EOCD7.CPTN7198QFUV@kernel.org/=20

--1a5f7e5a91512f293e90383dc31ec41b3d82ae75e36c13b11b72ffba2487
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaNPf0RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hmpQF/fyclsXnsAeDOlfobCgo2UCFlVNWwybOt
bZOJ8Yh7jm5W69/keuc/ZKcN0dxqpze+AX9Ph1IPnR1Dd76DHIy+jZBgjryCnAVO
7r0jiQ40LR/OOkdZuYUzI9NkgMZbSpmRT54=
=DMTC
-----END PGP SIGNATURE-----

--1a5f7e5a91512f293e90383dc31ec41b3d82ae75e36c13b11b72ffba2487--

