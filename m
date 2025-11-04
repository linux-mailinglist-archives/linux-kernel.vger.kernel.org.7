Return-Path: <linux-kernel+bounces-885238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAE5C3258F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF06E1920410
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E710334681;
	Tue,  4 Nov 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULvu/WLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556783314D9;
	Tue,  4 Nov 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277140; cv=none; b=hJ85r3ymrH8CfEiw2JN4MDvCwWrae4bv2LlssHgHZRhils6h/rZ4MHCh4Z4mrarkGTzihrqUbxAkIrwCUcVTUl+qpm7ypxlf+iMzlun0d5OTFICbgd6cVeddssrfpLUZTiKuroEaHXx+oXHnI90NYK4BRTUyT91wLIHu1I7RssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277140; c=relaxed/simple;
	bh=H/T5BiJZf4ItNx1oEwDxh0qIkoG2N0Jmmg4VQezS5Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjQn5HtHusket/HS2KMMTFnfTcNLVR6o61+myO7+u5zFZYpDS2lYpq9E5ICbI45j2+xgCnSkIFt1o44G5ynVs6eZCScDovCXBlb6X7oUIIIUhoh4vPJDH4fsACstfPGAcUGKFjnDh19GGVTCMrezr+Icd8BSnhrSGHzm+nze8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULvu/WLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2438C4CEF7;
	Tue,  4 Nov 2025 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277139;
	bh=H/T5BiJZf4ItNx1oEwDxh0qIkoG2N0Jmmg4VQezS5Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULvu/WLPItAYw0dChORCQGUPDmeO+B++jq13dlJWXq0GS1gMXxCo0uPQ5+ZaF+kol
	 ap/l2m+CfQn9ivpMh03sL3L5cOmvRzPIgIvya5H5Ub9bVS4LpHQB+9dtE0TTF9bsh5
	 Hufsx0htjjPw+Hu9HRl0GUIxooSMqugklsA9xxqIPubB7fRFEm0Gi0bi5pMQjWB3bE
	 BvcH5O+pH6IiScT8qdXaKfplDuZE7zDuEJvgD+zYDQq6lERRdqZOZg/gXzXq1DkuJx
	 12sIQXMvjveLH+O1IClakDAutauFVRhXZdd0pxpQCDLNfJXRAkrdThPmcvQGUEqCG+
	 rTSYkZdwdZxYQ==
Date: Tue, 4 Nov 2025 17:25:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: Re: [PATCH 2/2] dt-bindings: clock: rk3568: Drop CLK_NR_CLKS define
Message-ID: <20251104-verdict-siding-1400c49da950@spud>
References: <20251103234032.413563-1-heiko@sntech.de>
 <20251103234032.413563-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="59LUUKSSW6sp4+oA"
Content-Disposition: inline
In-Reply-To: <20251103234032.413563-3-heiko@sntech.de>


--59LUUKSSW6sp4+oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--59LUUKSSW6sp4+oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo3DgAKCRB4tDGHoIJi
0tg9AP9gEnwmbj/eb+41CL+w1IiPVkYa5Gjq4MWTJRllMKI98gEAq+xKR97MKd4e
c//+Nj/S1XhjetsO4KZX9ZwZSsmbPQA=
=nRAO
-----END PGP SIGNATURE-----

--59LUUKSSW6sp4+oA--

