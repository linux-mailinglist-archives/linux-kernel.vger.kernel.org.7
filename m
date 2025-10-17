Return-Path: <linux-kernel+bounces-857846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C68CBE8101
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AED1AA1CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D263126A4;
	Fri, 17 Oct 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivyB4e0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C254311C05;
	Fri, 17 Oct 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696843; cv=none; b=XfoJ4lpI6gBd1owvgXZF58/TjC9zyHmILyl1I8ArL3JwI5vIAZedGeb54UfjjbgSTn9vs3svzWZwdQBVxKRrIDfTzDXBC/5YjCMMS8ub39pHqK3ANHWH38QsGE3BYtyFXckpohpfJQC1bBlxY0GCz1LmyVsyCd6zbBJXyQDbj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696843; c=relaxed/simple;
	bh=AXb2xoWF36PJ82m6BEQX2BdaIWmKUFdyItrBQFX0b8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=c6QLXEhGP2Z68ZyczSx277uqrocgnRNjbMnI7OIOFWO6mzg/SkVi/hYedXcTHprjAZASj9JR2iZDwgZUtH1aUqJW96T0I/2sDBbpi34EAUd+Cqps4pMNuIbqGQZz0s5DI4WasXv/1q0wHn7DvE29+q0uPv93Ugl/hmMzeonyP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivyB4e0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4ACC4AF0B;
	Fri, 17 Oct 2025 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760696843;
	bh=AXb2xoWF36PJ82m6BEQX2BdaIWmKUFdyItrBQFX0b8c=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=ivyB4e0+t/GWg+1SNSB43y07tXoByzNyL5FagwcIOvm/vwYuJGFvPkac++hLkjZFg
	 gi/QmUs86qqqH9c1OOwq1pfIwq0ooGvegZODBLL27kaWwKkb5L+kZtzbwFFRFRPBII
	 KJ+LMHtEKKhObCscaZra1PV9fj3VsNG4E08+JMrOKqkRN/z9N6k4CFz5Q1t4ga5iVg
	 IrFA4enPWxzurEv+mkZ2HM0GjBublSHznMwhAwrbRSGeCsXnbTQ6YPiXUWgCGwsZ5N
	 N2zfXogkrJJtT3sn7nr705gDpKZGvh+Imyi849qPBjGE8L4MU5d4ZIo8Mh+0zZGXfE
	 9gV+S93/twu+A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=209572d5d449fea800561efc9231a1c1fc1c44a605e3fc288225d653e647;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 Oct 2025 12:27:18 +0200
Message-Id: <DDKIXTB6YXUM.3VY1GNCC6GFCN@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Nishanth Menon" <nm@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/2] rm64: dts: ti: k3-j722s-evm: explicitly use
 PLL1_HSDIV6 audio refclk
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251017102228.530517-1-mwalle@kernel.org>
In-Reply-To: <20251017102228.530517-1-mwalle@kernel.org>

--209572d5d449fea800561efc9231a1c1fc1c44a605e3fc288225d653e647
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Oct 17, 2025 at 12:22 PM CEST, Michael Walle wrote:

> [PATCH v1 1/2] rm64: dts: ti: k3-j722s-evm: explicitly use PLL1_HSDIV6 au=
dio refclk

Dang. I just noticed the subject has a typo. Will fix it in the next
version, or if there are no futher remarks, could it be fixed while
applying?

-michael

--209572d5d449fea800561efc9231a1c1fc1c44a605e3fc288225d653e647
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaPIaBxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gJfwF+MlA538hR89tlDMYyXTdFilZkhwrQOqDO
KX70l82R34q8yCx2xEAatnjiIiI4D9FvAYDevXZvMHZLxxjOJwsBxB2A0CyDYCAr
eos4cbNK+BO7LLznbJ+6BkL4Gy2I9IQviL0=
=jeCh
-----END PGP SIGNATURE-----

--209572d5d449fea800561efc9231a1c1fc1c44a605e3fc288225d653e647--

