Return-Path: <linux-kernel+bounces-720075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5817AFB6AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461591AA5E77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D62E1720;
	Mon,  7 Jul 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZsp0hHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EA8F5B;
	Mon,  7 Jul 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900447; cv=none; b=l3nN7yWXSYEG4sMXIC8eodW55U4/gGk1mnUbBbQUqYC8+/i3nYKUxZUR3oLI4vKFdVSf7buh/iBpPqy5gxUaKiPqxibWeHmLIHno4+6BaPQ6cQKnnQnTOT3wtwM8/j/1YoHXTIcGkgrWemvzt3qpOsmgFnYuM4GZQdSbD+pSRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900447; c=relaxed/simple;
	bh=pKCzgXUP3RArUdzkyp6j3MmrJCmZdV5YrMHXmEkrZX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmAv4CbkE9Y//4ft+hMS4gFXyVxWB6sU92RL0nhK4X5qg23ObdVZcReu0rlP3tbxtLTpv3T1/zMnZgLZd190Nn/7tZdN4iwmFCVsUe0eBwjNSGX1t1hvVMS2dzsKJkscQGS81YMcLv4fIZpPVYQE7xL/xyamolFGImXiplrSNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZsp0hHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFD3C4CEE3;
	Mon,  7 Jul 2025 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751900447;
	bh=pKCzgXUP3RArUdzkyp6j3MmrJCmZdV5YrMHXmEkrZX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZsp0hHrfjmHakwfzc6XC1jQ6bvwoB0f5jMPBYzglG5DlkVYXhA/QUMsxHOgOlOu9
	 sFIsDi8T6U4Ri+QOZJFPNLZ6wxFeUfsFgo7Y1FMO1EHK3ayJ8Zqvd071Bw/V9tNpsU
	 Kk/Iq5tA9sU4/+xT5LbJLDUkt1DZunfQDEhHHvj1NsL4v4aXjJrfBYsJRb75Y3PPdk
	 RPcRfmBliDPypDOTkp1a4OK3zqdkNuNo+3glPO19c96fWUJZ9aiM/skqunntU8Wdnf
	 dXiGINbMXAs0DHTIOj/iWAYcIW7qsnVlYZVPtDQV3rnQCA32Qjy5HjJ1pmCCWpzA4Y
	 2x+V4Thyx+nWw==
Date: Mon, 7 Jul 2025 16:00:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] docs: dt: writing-bindings: Express better
 expectations of "specific"
Message-ID: <20250707-ribcage-spotting-98169a599c61@spud>
References: <20250707095019.66792-4-krzysztof.kozlowski@linaro.org>
 <20250707095019.66792-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LpN4/rg8m5kg9CGO"
Content-Disposition: inline
In-Reply-To: <20250707095019.66792-5-krzysztof.kozlowski@linaro.org>


--LpN4/rg8m5kg9CGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 11:50:21AM +0200, Krzysztof Kozlowski wrote:
> Devicetree bindings are supposed to be specific in terms of compatibles
> and other properties.  Short "specific" has many implications, so extend
> the description to cover them:
>=20
> 1. Mention no family names and avoid generic SoC fallbacks in
>    compatible.  The list grew, mixing DO's and DON'T's, so split it into
>    multiple items.
>=20
> 2. No properties implied by the compatible.
>=20
> 3. Document desired lack of ABI impact and acceptable solution if such
>    needs arises: clearly marking it in commit msg.
>=20
> All above follows established Devicetree bindings maintainers review
> practice, so no new rules in practice are introduced here.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--LpN4/rg8m5kg9CGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaGvhGwAKCRB4tDGHoIJi
0ioTAP0eHfrxWtZfWame9d6gVYsIKsqkPa6z2JEoO3YTuQWV3AEAtgBfhO1HMbQR
FA1HQtmIqq1fTZURDeCo8FByXw4KLQc=
=HrOB
-----END PGP SIGNATURE-----

--LpN4/rg8m5kg9CGO--

