Return-Path: <linux-kernel+bounces-861417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4AABF2AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1472A18A50A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466628CF42;
	Mon, 20 Oct 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSfz08Ns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B2C8FE;
	Mon, 20 Oct 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980742; cv=none; b=GG/Xjvdp5p9WlmlJM8N0qesOhW2x1SZBRoSYXM1ICBjAnuLtyrxEHQt7ZeXZyUtbogDGwkqiOstP2eRcmhQnn5utcML/Luf5gcPBQrw1ItPBbmuvw1cQ7JOOAdAiJhDy6K+VA8UEPu0WFxb03KpLzH/Qy/ArbWiAldhwafW1kEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980742; c=relaxed/simple;
	bh=d2jINvzcEowHYXUQtyByG0BLnrpPSoNJ9KYOgYddVTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiWBu7PWdMk6t5oRzzvqcDuse6KmHIkD5u1Sy1OlAWuvHsu2E+PdGPiTzBsG5Y83t2HbYSzGRxJljwBRbDUzwbsAUcfcXmxITNS+KE/kxjMCkInX0nny0lW3poJehFLhB0/Spjuq+SpbdaVFD97bk+UNEde4gkNaMvJ7QIAdWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSfz08Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559C4C4CEF9;
	Mon, 20 Oct 2025 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980742;
	bh=d2jINvzcEowHYXUQtyByG0BLnrpPSoNJ9KYOgYddVTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSfz08NsopoJBlCTowu9oCXd//s4JDWGOFYx3omXLXJefUl1UzZL5Mj0T1IQc2mhg
	 vjerZuHSwJ2gZUmIvMwly4gwcb3GG8PvnLIeOQFv5UMVnBSWDQPQkl7Ceaoy1/zUim
	 EHm/rD/S4Y36etd0uOEnCn7OZDn1ydWG/SzOlX6bnpkc6qmIht7vX8MBqL0csrtdsr
	 rzSnz+qwouug/Z1RNrXtIL9Uj9l1WNPC/Q8uQtDFY0pe3+v2UFcdNTL8g887y9APim
	 Kj0wJCYBA3qdka/oR7GbS4x8E2y+i2znYcmB7Q/42VhGaW+jEYL4Q9VAIiYCvQfFJ9
	 q17inbhmJaWZg==
Date: Mon, 20 Oct 2025 18:18:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, quentin.schulz@cherry.de,
	andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 1/9] dt-bindings: display: rockchip: dw-hdmi: Add
 compatible for RK3368 HDMI
Message-ID: <20251020-showcase-crayon-660e4f67881a@spud>
References: <20251020082508.3636511-1-heiko@sntech.de>
 <20251020082508.3636511-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7YQcMoFn8RBCI1lI"
Content-Disposition: inline
In-Reply-To: <20251020082508.3636511-2-heiko@sntech.de>


--7YQcMoFn8RBCI1lI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--7YQcMoFn8RBCI1lI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZvAAAKCRB4tDGHoIJi
0gdnAP9UKaGnCPV2zaldvnd211nAHuvWh9YTAsetUvI6810yKwEAvc3hLDjMN6Zn
5Mim/845bWOoq9O19ETLpIYckAc7uAE=
=7vaE
-----END PGP SIGNATURE-----

--7YQcMoFn8RBCI1lI--

