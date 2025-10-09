Return-Path: <linux-kernel+bounces-847269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C42BCA667
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF8188B535
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458B246781;
	Thu,  9 Oct 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAWbNK0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409D23B605;
	Thu,  9 Oct 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031469; cv=none; b=UpEMvLZeU9G6hN/t7uvz17Ll1P9QHnHI9rCZAplH0ia6r3aXidcM83lKEDvFVJKHNFRfx//gTJ1xJUrLL4qNHlFEfRqLOW0TPSxvBrrDb1m1+t6Tza9tAyTqiR/L0PGJxR1e7/T/ep5erH6r3V77kB0To7X5BllpqUcCvJ5QNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031469; c=relaxed/simple;
	bh=q0/Tm1rBeGWihtR/SqMZaiZCGZAzw++6LlAYgjIfWTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax+6C/MKJW20OPvuKatQakX88+DvYSb6ktXiLYoBpzo325CS0awHcIf0wMng7lJ625c20/deGHqpaXPT5tQDyq1ObgcCKM443k327BQieet6IvO7VgnQm6E0QxES20dos3PIdx9yHpHd0STfixXXEvTlIu5oyb4pPg1hrYNrAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAWbNK0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C006C4CEE7;
	Thu,  9 Oct 2025 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760031465;
	bh=q0/Tm1rBeGWihtR/SqMZaiZCGZAzw++6LlAYgjIfWTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAWbNK0rzqoCjWzWD2ebGC1xj0JvwZ3ZrtlxoO1G4yVW2ADuwisSM2EjjewAdkXmz
	 94nED2B/fdxZsDIK7FziBYGSHvu2ByUd/PgfXBd02bowi/OokPQs8+JT2tuogzj0Ke
	 q6rhQi8j4eDHLx3UbI3t58Kg0TCRNaetRWPiLT0qoz39wxMVcTYmM5hzdvVaGVPgCS
	 93qC+0oJWqJO2vrTgmUxSQZ0xhE+FeEpfWIrYS07C57awpgkXzV54tTEfu81HfWN1Q
	 8Qu9Pm4UHlsy0qWQQEscNTtMaqTWWQMUwfH6iUj/QNBNdf9p1XMdGpqG40Hstyc+vG
	 JX8WscY2YdLNw==
Date: Thu, 9 Oct 2025 18:37:41 +0100
From: Conor Dooley <conor@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v6 1/2] dt-bindings: clock: eswin: Documentation for
 eic7700 SoC
Message-ID: <20251009-reggae-discharge-e39faaa312f6@spud>
References: <20251009092029.140-1-dongxuyang@eswincomputing.com>
 <20251009092119.198-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2WfRS743DVbdgsZW"
Content-Disposition: inline
In-Reply-To: <20251009092119.198-1-dongxuyang@eswincomputing.com>


--2WfRS743DVbdgsZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2WfRS743DVbdgsZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOfy5AAKCRB4tDGHoIJi
0mo4AP9EOSxes27wxZlUymg+dZRqgQo/RcyxnN75/fR1UqIiEgEA0kf2jwsTsygy
aL8MIP439fiplruu//63r5BSYho1nQk=
=AAw7
-----END PGP SIGNATURE-----

--2WfRS743DVbdgsZW--

