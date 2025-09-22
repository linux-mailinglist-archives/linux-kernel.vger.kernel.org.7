Return-Path: <linux-kernel+bounces-827043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A72B8FFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823C52A1938
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881D2EDD63;
	Mon, 22 Sep 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUgHYicV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710543EA8D;
	Mon, 22 Sep 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536760; cv=none; b=Cmyw+ZLjSr+gdL8552+wpwy3lrM5DY9Xfe/yivGK3jYvl5aRAyR4rEiYNNqbEXk3t2TeVgIPMmlTxd0hSZNWbHjVRS9ChAZMQ2/FNfiZ9RwJjRjf1gqpxukWWyfpx/LSh9K1cFGryRRGUGL6p0qoyKoc7rVLLaaeszPCGexcWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536760; c=relaxed/simple;
	bh=GesIXJsUp9vEt4svwmGtroGLhz9wKpDtpAOC8MZ2otE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXoywDCHv7ABKzfx8i0GdNP9iCHOA11egFSmanoMSjV9v293OsFPvkCNvYN/bjBrKRZQKLZ9eZjCD5Ot91SKaR6Twpki/9n6Ax2n5dVqGNuLw+2kPp9dVwkEYX/GzdhnoHHNQxvAh8oHVNNJYdj61tJlK9mP2ydGoHzwRR+BrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUgHYicV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E373C4CEF0;
	Mon, 22 Sep 2025 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758536760;
	bh=GesIXJsUp9vEt4svwmGtroGLhz9wKpDtpAOC8MZ2otE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUgHYicVwA8wzrlrilP666bQK9TOFp6Cm3A4SUB3VlWWgSTRCN7s1Eg1jpyOtTHgE
	 vLdgP+onAW9+nTtLV4VLyxRNvF0K/LkeI1GvFQLk2jFRe9DvaNSnND4kKfRUASqSbv
	 2/5U+WvyTtY5hDzWDo+68oJu9Ep/N7yV1YhqcvtiXzkFYCwtFvqxjJhwDCU7bvuyqT
	 BzZTH440JIfDxMmJUEJKQMMeLHsnYEyMj3HsArcGPd3bBzN+AdryeDWLEf7bATPeMR
	 Zn/fXYL9DVv/R6FbZMLElXsnMEKhaHQi1aj2So4GjZ4XKxsMmKvm8NaTyAQX3VFLGZ
	 UJ3RhedKuTF/Q==
Date: Mon, 22 Sep 2025 12:25:56 +0200
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, james.morse@arm.com,
	ardb@kernel.org, scott@os.amperecomputing.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/5] KVM: arm64: expose FEAT_LSUI to guest
Message-ID: <aNEkNF8rvb_e9DKd@finisterre.sirena.org.uk>
References: <20250922102244.2068414-1-yeoreum.yun@arm.com>
 <20250922102244.2068414-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TTjpzkUzOZtHHjFI"
Content-Disposition: inline
In-Reply-To: <20250922102244.2068414-3-yeoreum.yun@arm.com>
X-Cookie: Filmed before a live audience.


--TTjpzkUzOZtHHjFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2025 at 11:22:41AM +0100, Yeoreum Yun wrote:

>  	case SYS_ID_AA64ISAR3_EL1:
> -		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX;
> +		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX |
> +		       ID_AA64ISAR3_EL1_LSUI;

This should be added to set_id_regs, but ID_AA64ISAR3_EL1 isn't covered
by that yet.  I posted a series for that the other day:

   https://lore.kernel.org/r/20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org

--TTjpzkUzOZtHHjFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjRJDAACgkQJNaLcl1U
h9AOOQf/Qx0DwRkeQoNtyU5B2csGJYPd+4eySttDGWCSla061GCxxbnF7+gRkeEd
ZcAzhyQFxW+GLW+xTNOZIwvaK2YIcezXYvrg/xz4WOTUR16XDDxV6GkhXpxFERdg
6O1AtuqKcu9EBSyjjKO4hYFe351fn1Lgg00BhpTgjsF/Xi7s1tk8X5yj+Q9scr0E
KaPB4mOu9mYan1kzD03fXi7cgo4dH9ltT8JhIwoO55DNs+Dxje6+aPE7WjR+Bg/R
dOStoYITnI75ZCf66uFMHo1rCejbxVNoUSDqL5uES5h/Hkkc4aCqOyQf6T6v+E8X
El/9xHABcfTiGt6D/VpzZ/REB7+P7g==
=TrBA
-----END PGP SIGNATURE-----

--TTjpzkUzOZtHHjFI--

