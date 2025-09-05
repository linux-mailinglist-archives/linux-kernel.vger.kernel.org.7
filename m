Return-Path: <linux-kernel+bounces-803556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E203B46248
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A64B3B677D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AB2741AB;
	Fri,  5 Sep 2025 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmmJ9Mfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D949305947;
	Fri,  5 Sep 2025 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097099; cv=none; b=O0rcPbK5cpzTecSW94/OCwely+aaspoGlsc8jtMjemMYPqoCZv05kZOA7Jpl8I4imlXkKVZCOkxCbMNAgpwfqcycuJSUZMVLmD+q8/Z6cyQtyy0QGjXxrUSZuGptbdoUIQ3wqQL6mNYh9+D/2eGfrzzFXlaTfMK0/SsrBvfozS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097099; c=relaxed/simple;
	bh=+0k9zSsrRaAgBuIpWMVva+/xd63Gms5V3Uc47aoBR/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLHZByHABb+/RF2mcN5K/QLtDO17gICpdy2hW+j2gohmEk0TQUoDBvZWWyH9Wfzmo3KrHSQ9ZZfpCLeoHZ66Bc6GCHy20ZS2VeC2vvK1eJQ+vx5RTnEGpFrqY2b8it7QFsZibV5WfvK+w8ZepXpWbnAwx9ZKJV2d3B4Fe7zF+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmmJ9Mfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F6C4CEF1;
	Fri,  5 Sep 2025 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097098;
	bh=+0k9zSsrRaAgBuIpWMVva+/xd63Gms5V3Uc47aoBR/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmmJ9MfrhWCErNS8Ex44NuU8P1ZE7acYA+VNTxBIkbmwwPJkCPLhm9IQkElVxTxVY
	 7reHJX7lzwOaI5PCwCpQniFwajwAitTwD7dOxu6A6ZdXrpoqK3VEVtI5j5H9nmIu0x
	 BfNC2pU1ISX1ywM08AyktGcHSolASvh6xmchj5s3GHPTUMihHb2lpB9bHk86BER6xk
	 /sWN9f1hFx6TApC0pQDuwhD0PV2XaFS3KxcGE2SWUUzqR6hwlysfeepcCMlm/g+r8o
	 bktQFnoWGi3837AroRL2TiWVuS+xQhINHXeNuJgZKn2/NAhL01azHYgSLilmtWCx+3
	 BbnD3nIn1gxbw==
Date: Fri, 5 Sep 2025 19:31:33 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jianxin Pan <jianxin.pan@amlogic.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"hongyu.chen1" <hongyu.chen1@amlogic.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: keep alphabetical order
Message-ID: <20250905-vexingly-crudely-36f9e510e9c5@spud>
References: <20250905-pm-fix-order-v1-1-3596e03d66e6@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P0lPMlRfexJbfzXl"
Content-Disposition: inline
In-Reply-To: <20250905-pm-fix-order-v1-1-3596e03d66e6@amlogic.com>


--P0lPMlRfexJbfzXl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--P0lPMlRfexJbfzXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLsshQAKCRB4tDGHoIJi
0k6NAP9CeDhBrMHAGGTDXecCGYptogB2rhgtMISin8uWUx6DhwD/UQis763f9CZ+
Na/sRpHns2qf9+LJX1POz1BTVll6mAQ=
=Wyyq
-----END PGP SIGNATURE-----

--P0lPMlRfexJbfzXl--

