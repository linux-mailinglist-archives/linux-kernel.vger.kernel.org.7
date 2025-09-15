Return-Path: <linux-kernel+bounces-817578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A907B58406
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B72A0039
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563242C0281;
	Mon, 15 Sep 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teYt+F55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EB5C96;
	Mon, 15 Sep 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958762; cv=none; b=gUIwbtEZLaTFsTtIDlroJp9dagcxdOvVjDDwdcsAlal8jnAcfaOZbMxi9RDScasmyYZs8pJW0Yoia22l/CMK9Gts6hBFa5XOV8t1vUOqtzVbYfqjF7QTLgWw5kWmfXeaqPTJKXBIug5mj/r20VPKYg75WFt7j1keQ2Mzi7+QrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958762; c=relaxed/simple;
	bh=QVjtWRQj//qcsIk5ldU0SmXs/R0deh67fLAsxifApOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCntIuq3+ncULoDRRuPHdYW3+dYzGUrSFZm0VkQXqLtR07cE0mf5w4dCERr7cdTewuZuJzj0MuSSh3NvGZN+2btAmiiCod/XHorrez9pTc5+xnaVfY5HQKx+kMdcClek2ceJXiuLg3UslZr3/l1fuqMXzYkrDWAG9u9dKaoZ4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teYt+F55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9434C4CEF1;
	Mon, 15 Sep 2025 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757958762;
	bh=QVjtWRQj//qcsIk5ldU0SmXs/R0deh67fLAsxifApOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teYt+F55IKAnrnN0DZru8mB8wI5H4tTsk7wt33eSj/xn6gfkjRBn4gLKUSBL9UYr5
	 UZ1GCuBUvYn9PHoAbzvjfFvik9bz0u9zyDfuaey9guJ0I3KYuHEuRNqlmA3qrrhOY8
	 CegsA90hjs/Q+XEWmrv/tbYvqQN+UKZtUSLRjRS511mPcTv92vkYztU1QNfywHwQA0
	 A7VXZbH7r+oPzFg4UFr5AJbMBdvCb8+HcKh+vh9PtlXC7WlrApvgWecqzGPqAgvJuS
	 PGfXC48ip+Q9Zw9B3cYeuQ4jAGsp52T3c841rbLTGv7gGrSs7++GuOBo1Eh3lFZtru
	 eYNflOjXdhjOg==
Date: Mon, 15 Sep 2025 18:52:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek
 MT8196 compatible
Message-ID: <20250915-deodorize-proxy-b18e41fa8668@spud>
References: <20250913002155.1163908-1-olvaffe@gmail.com>
 <20250913002155.1163908-2-olvaffe@gmail.com>
 <20250915-numerate-makeshift-c076500aaec3@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zj/IpRh5L7G4umUF"
Content-Disposition: inline
In-Reply-To: <20250915-numerate-makeshift-c076500aaec3@spud>


--zj/IpRh5L7G4umUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2025 at 06:51:16PM +0100, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Hmm, actually there seems to be a more complete binding proposed here:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912-mt8196-gpufreq-v2-1-779a8a3729d9@collabora.com/



--zj/IpRh5L7G4umUF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhSZAAKCRB4tDGHoIJi
0h7OAQDrJvvwez35Fxek/+gxVlWQMSUkdCozpI6UIMXqKSSfyAEAgfq/22/qmjlG
oPynLEW/PzKMbJDGm3gR2kAUCl+J9gQ=
=LQXY
-----END PGP SIGNATURE-----

--zj/IpRh5L7G4umUF--

