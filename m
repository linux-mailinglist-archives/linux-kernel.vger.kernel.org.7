Return-Path: <linux-kernel+bounces-765390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE0B231AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED116E0DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC3B2FF170;
	Tue, 12 Aug 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc1fu6CX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D902BEC2F;
	Tue, 12 Aug 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021863; cv=none; b=V8c9ZVy4KMjsGfy0BYvKUgOXiutGTERRTHVvtZv9O/P6Sn4D4HQmc+StsI/a/hrOYuuCs9JN+XgvzOYA4kYUAYWDa2JRffrJFgkvWpHpTuHLvg8TxLjcXrPatqvwgFilH9MRyxn51NDZKnr56sameKriBHETr0yCCpBdVl0x9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021863; c=relaxed/simple;
	bh=M+Z0eS10SwonwtWVyijlh48EzuFQRgyP4fZWIjEAAMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd7BzTxr3t+xVvgPaZKvwhRtb4Mpd9anbl4HTDQsVpQl81ohPTpFzOo8NuyWNNtGaqWtSLVCWYKN6v8jiGAUKTID78LQMWnW4HgY4aVPr1IaRigr/7LKF6yg705B+y/s+oyhwMnKkpbCrIHt3L6pkFcW3+eTUgmk36TYs2+YJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc1fu6CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A847C4CEF0;
	Tue, 12 Aug 2025 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755021862;
	bh=M+Z0eS10SwonwtWVyijlh48EzuFQRgyP4fZWIjEAAMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oc1fu6CXkSQrsq1WR6782QF+WDcM+p89+zlSRfEwIdUSKZo59f9H4UvhKs4FkNkxU
	 xfHPSEM6Qf7OCL3hrqLovnBOHHEKUuBrtHYaE9IQNuPsH5WvJpjlpOhCg7B6KtGoGs
	 wJRVp91pZblP+IBQ9IoScDQ0vP641HQ+upYYzAwiqBV08+Q3Ay/KZBUsf/tM3fvKIm
	 ed3XaDx1B35Rk+XqMaQhcF9ecUxHe25Hnx5Xs+w9TsQKmEYjzFd2hUsRJgqPOgLGQw
	 bX97o1vGQreeCMhawLcDqPgqQ9l11NIagMuayYsiEOGE4vQRwLVbDlM0yz34jgwMh1
	 /WL1mN2166Amw==
Date: Tue, 12 Aug 2025 19:04:18 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: adi,axi-clkgen: add
 clock-output-names property
Message-ID: <20250812-hedge-cohesive-24d38a57ea43@spud>
References: <20250811-dt-bindings-clk-axi-clkgen-add-clock-output-names-property-v1-1-f02727736aa7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mGfDyCaNb20uxoLU"
Content-Disposition: inline
In-Reply-To: <20250811-dt-bindings-clk-axi-clkgen-add-clock-output-names-property-v1-1-f02727736aa7@baylibre.com>


--mGfDyCaNb20uxoLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 05:17:01PM -0500, David Lechner wrote:
> Add an optional `clock-output-names` property to the ADI AXI Clock
> Generator binding. This is already being used in the Linux driver and
> real-world dtbs, so we should document it to allow for correct binding
> validation.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--mGfDyCaNb20uxoLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJuCIQAKCRB4tDGHoIJi
0ni0AP9gIxv/QtLhCt7M7e2LAxaqBAWctbmrbHVuFf5oX7RexwD+O28wmxVF0n9x
tDrgsnv+ItDXcA9WrVn6IXKXvfUVxg4=
=PPvg
-----END PGP SIGNATURE-----

--mGfDyCaNb20uxoLU--

