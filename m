Return-Path: <linux-kernel+bounces-829524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E667EB9744D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D403B2F72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9219302CB3;
	Tue, 23 Sep 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFE0L+0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525F26E706;
	Tue, 23 Sep 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654164; cv=none; b=GgGpLkWEBkr0mSnBfNsE4fETwH0ud7Jv64uvjUtTELFucj+6GeIYcjoHhkwwcMhujVgMHrSQWjD1nybkmV1sAtHfb4FVsbEULgJ/5FJ31g52W8K5X3Y4sygUnY6wXoQA3Kd+IfNPdUjPsxwcZ5q9wKPefNJ4EExOsr28DY7V71M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654164; c=relaxed/simple;
	bh=MNCGLYKm4on4u/ee0QpshIh7g/1iu74HGsb1YK+Aibw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJx1ZtlgXxEoT318AO0PxtjU+wqr+EhgLzXU4Ao4pPYIa1fWKZuA5fcUQuH0ZEEgOali0xmDewIKO69dStTe4u6YjUl8QNgy47FQmm4043XHHc+FNvuDvfyJBH2rx3EF+oppW6oGz9sgkBpc8wA6Yc/P81ceDRpmS8tx2oELjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFE0L+0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA248C4CEF5;
	Tue, 23 Sep 2025 19:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654163;
	bh=MNCGLYKm4on4u/ee0QpshIh7g/1iu74HGsb1YK+Aibw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFE0L+0+CvqhghdBr8GrcfXgzMghGeuzg82fZL/ANbMx8p06EM+pmPK6qW7giVxMY
	 4lezfrGeVb3lwff6JszTyLnYRHLZvQMUpuHS9QXgWnK4lkAy9vBWiDrKnWDi8YDf9S
	 SZAsgeMVH2YnSwg2cUd8lhnT8XY5kA6KnMpy/h0c16NI0UY6EcznUXuCWPTKBgVyu1
	 wJctx6hS/CrMzwwmw6i88ZSHiQpFDG/KAInowVijjdSTR85m+jqZerjrw353nxOZuA
	 q3B4rOlHp869XST1wzhNcyJ311w4OrBDauYJAjja59Wq++RUMsxI2JXsTWJZJpth94
	 5mFHF04PKnX6g==
Date: Tue, 23 Sep 2025 20:02:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	"fushan.zeng" <fushan.zeng@anlogic.com>
Subject: Re: [PATCH 2/5] dt-bindings: clock: add Anlogic DR1V90 CRU
Message-ID: <20250923-cork-clarity-40358e06d361@spud>
References: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
 <20250922-dr1v90-cru-v1-2-e393d758de4e@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cXQbIvmswZwfd+Xe"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-cru-v1-2-e393d758de4e@pigmoral.tech>


--cXQbIvmswZwfd+Xe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--cXQbIvmswZwfd+Xe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLuzgAKCRB4tDGHoIJi
0rwtAP0fn0XwIXbjq5PVgdtSJxA38UMz2JFYXsDJnwLnKO8rUAD+MHiGKBTenito
DVaMH1nw1vvZWEhPOZgX/2B/yC+LzQE=
=BIbT
-----END PGP SIGNATURE-----

--cXQbIvmswZwfd+Xe--

