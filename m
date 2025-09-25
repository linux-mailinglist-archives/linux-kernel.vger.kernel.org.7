Return-Path: <linux-kernel+bounces-833094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097C2BA134C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F207A5B38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9931CA5D;
	Thu, 25 Sep 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHmrWuBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F685286D6D;
	Thu, 25 Sep 2025 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828806; cv=none; b=QAjlnzQnXshawXxOHQN7AkOI2XUR3u5a/0PU7tvtjQL58WTKeFOizL9Ysx98Wmc3ksLSRrcFuW9P3m8LOG7qNvHwG+BeqeRcsQD/cQT8vUQp0zcw3PI8N8fO16K17VGflJa5FOyrP0+rDKOQK44nugyF93i+YUq+hr7Yg8Ft8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828806; c=relaxed/simple;
	bh=ULdj9AHVTVpUuL+Js997kCg/tbr9m/L8H0ggaLUQtLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsGg8kgwGTTh98qOkwnTRmo3q/szyi9S4BhksCwSWysqTB82IJNh7wBrJx87qDu6RMPitG6ml0XxhW6xtmzlg34sVVfCMZP0uU10rV/mmhQn03YQ9HIzpXuV9IqH0DZy38JmuBzoLiUArKRtjvsXALdT62KzhAW4S2X4Fjb3WUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHmrWuBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098BBC4CEF0;
	Thu, 25 Sep 2025 19:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758828806;
	bh=ULdj9AHVTVpUuL+Js997kCg/tbr9m/L8H0ggaLUQtLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHmrWuBbJHzQ74ps0zJVLFpRkbvqo8HdBGh/idwWHcj9fRBvwI3JCWIP87+BoXow0
	 SATGMaec8x/Eo63KNklGFgMVwZzQaZ/RHVXOVFhLtJoTItz0UNjk1A/CO59IwdKLWz
	 6w5DwoJdmjgpG1aN2jgdLsc8YPhpGYLI4adK/nG8X8dbyBmLCEy0D3DrVZtYOHU9uW
	 8x5lxfYIktDfBqytkYAlk0zSrrPdZCXdKIzO4/H71v6CwWqZNTa7jRfnMjSZF+3q3M
	 4dKnXTIMgqswyeX1BPSyZUyKTxqeGmU+1NO2QZi3plmv0N8cduVySWCrptD/1FJU9K
	 n+ZCFOl2Hrceg==
Date: Thu, 25 Sep 2025 20:33:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Liangbin Lian <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Message-ID: <20250925-print-defog-992c12970b37@spud>
References: <20250925055906.83375-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cd5RNYca77adNE/E"
Content-Disposition: inline
In-Reply-To: <20250925055906.83375-1-jjm2473@gmail.com>


--Cd5RNYca77adNE/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Cd5RNYca77adNE/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWY/wAKCRB4tDGHoIJi
0oTqAQCMVKxXz3Gt+ub4awEIlatM+y/2A5HvdEHQ4K5VQOfQygEApi9RY5SD4YUH
o/Sh1CDbdRCzbzfnSsibcBzFSC75/wU=
=kd+z
-----END PGP SIGNATURE-----

--Cd5RNYca77adNE/E--

