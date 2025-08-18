Return-Path: <linux-kernel+bounces-774168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D46BB2AF60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847BD17D2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A28320395;
	Mon, 18 Aug 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feEiPGvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9E32C309;
	Mon, 18 Aug 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538026; cv=none; b=HUEK6l+OxAepCD+QmYH5AyM62WrWaAIrmPA2LOcD6vgx/y1VPPfhz8YudOmbvPocG9lUIeg4meOY7kK5D95yI847S10nZnvnCUtlq2GVwidUdB+Hk46fv5/8nlNyKoM3J0eyZEPKPeKq/yRRIJ1kEj2yk+vv0cmkpcEZ3K8a638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538026; c=relaxed/simple;
	bh=AWvl4ook7i2j6QyZOwdHu6wz9TSNrHrcUecRwmKBbzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4lJDloclzHxfi6KNHqp8m24v7CgEDEt3xws2s3ZtmPXXQ6JFjJRdbdGYIcQPgkaOzVRWgXjqwz7FtHd+UFxSrkT8BG9GyZIwj59Nq7duRozmO+AEyZ2K+9qtcYOBYZrTw3/9zhK2+a0lx3zCqzdzJMepxqc9aQxarp59BC1r+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feEiPGvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5176EC4CEEB;
	Mon, 18 Aug 2025 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538026;
	bh=AWvl4ook7i2j6QyZOwdHu6wz9TSNrHrcUecRwmKBbzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feEiPGvwbtsNISgJzePCyWYfDrBSCTVCBHYLFlj9RXVssS3tf5dvrY2WcdKZAi+dx
	 Uj0+zWpcmxc2uB3Tz3z/bkJi7q/o0rv/slFeNz4+xL7WTgCC7faJm8ysfXKOXN7qAl
	 Zdffn7CiIBNRNM1BcmOqrHNmMJKkMfO1HTY6vNuRb741e1jcvcCN27r4JgJ5pwHcOQ
	 zJaWsxZAZ/oOT1Cd0Y4VwxbeNbcSiboPvvqh4DYf0aL6wOKZNDa8xiMg0yJd1VKufi
	 bSXKONa0b3kix8J3jXJLIkRoDKfoJ3rq8BpGhyND3RxyksLTh0ZtyyovbQ/gPxzu8Z
	 ZDX7Eo0158VqA==
Date: Mon, 18 Aug 2025 18:27:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: Add HINLINK H66K/H68K
Message-ID: <20250818-steed-exploit-437c31f61ef5@spud>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gMs5eglHAy8CZyaF"
Content-Disposition: inline
In-Reply-To: <20250818100009.170202-1-amadeus@jmu.edu.cn>


--gMs5eglHAy8CZyaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2025 at 06:00:05PM +0800, Chukun Pan wrote:

>   dt-bindings: vendor-prefixes: Add HINLINK
>   dt-bindings: arm: rockchip: Add HINLINK H66K / H68K

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--gMs5eglHAy8CZyaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKNiZgAKCRB4tDGHoIJi
0saRAQCnDnWIZ/GpxURvHgFTWLcDTyj4Mget697SxvyNqtN2MwD/Yz+ULwirqVd/
2bkbaxELYuAOZPRTEIpjWL0pzwyIxwI=
=iP5d
-----END PGP SIGNATURE-----

--gMs5eglHAy8CZyaF--

