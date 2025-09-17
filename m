Return-Path: <linux-kernel+bounces-821568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68DAB81A63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AF017EA52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C632FFDD5;
	Wed, 17 Sep 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfVN5yUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289E2DAFCA;
	Wed, 17 Sep 2025 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137560; cv=none; b=Ct4rb2cbSxLZYRkyF3zW0hAmrWs9iXPscDdU4ox9sfplKWgPkTJeDxr8KBriUKLiu0z2HzNJvpU7BkXQ6X0/l+YaM2KfWXj4t3H4oO8UonLFzTXHxiiJrSz6wasKvvIz9la5LHMML3VkrkQfy/qgbBFRMUd91o9SsPnHRX6lqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137560; c=relaxed/simple;
	bh=9gUuYG0/AfVljxVjoeAhuZ6GhRyks5zOw/l/5c8VnCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHW9TQLiJzFo2vBEVpBuWq9MRO3n/xT8RGCXzfdsvHVd7Ny6YFEl0dWmhR5rjohmfgnGgNy2JPnVXcj01K15Eu3TQxSHXhc9mUzn+bMc/RAlWNqgw/3uuKjW3YbWIjhuzLNualQcyI2D3O2sJQQ/SC5HlKP3biM+EHBtygHHS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfVN5yUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AD2C4CEF7;
	Wed, 17 Sep 2025 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137560;
	bh=9gUuYG0/AfVljxVjoeAhuZ6GhRyks5zOw/l/5c8VnCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfVN5yUkCQGO+bzwQ51dJuP6XctWgNxnL/TWRIsWRQfQaNxyu59gS6Q2J5iqPcJQg
	 0bCV769gmxZIDF5WyKIfXXFGt98BzWqX8aNk/gS2Crmzs0jvgKHO3mVFj36hD5lixz
	 INRQjsTWTWUjo4Y2DbJYeVH5/MtRxffGP0UM4BY2w6nD1kbXIN7bQbyQUPLasjdine
	 EKn2ow/ZK0okUqK7M+buVI2YasOUq2bXXL7aB3oostDyEkmA0hAZCDfDWRlKvdMC55
	 +I/RQiPTujek8i1nsGZCCQUVsvJU7BseuWro0c1Nd/SgRdCt0WdBmOR5pMJmcpv1un
	 KWcjb2bk7U1qw==
Date: Wed, 17 Sep 2025 20:32:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: uhci: Add reset property
Message-ID: <20250917-unsolved-thwarting-df2ecb073dc4@spud>
References: <20250917021926.3692137-1-ryan_chen@aspeedtech.com>
 <20250917021926.3692137-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmNo4lOHtwxZfDxc"
Content-Disposition: inline
In-Reply-To: <20250917021926.3692137-2-ryan_chen@aspeedtech.com>


--pmNo4lOHtwxZfDxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--pmNo4lOHtwxZfDxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsM0wAKCRB4tDGHoIJi
0oyzAP9DNkFwxH23oc/iXzGyVofh6CPc12IAHVCsfBtYmUC6JAEA590KG0Ads9J9
3zU17P0dT11oRco429a3uu6Sgm+mIwo=
=m5lc
-----END PGP SIGNATURE-----

--pmNo4lOHtwxZfDxc--

