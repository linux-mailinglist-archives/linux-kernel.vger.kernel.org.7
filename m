Return-Path: <linux-kernel+bounces-889154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70492C3CD36
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9177618905FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70D34F246;
	Thu,  6 Nov 2025 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tafTi2xp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2533FE33;
	Thu,  6 Nov 2025 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450059; cv=none; b=qjG39/brc+KmAH+4Rdo47l50kyfyuTNVlWtGbWCyy9UxZa4GHa0mGVRF934Glviln0FYo9b3dAmTK/Q6CmdaBM2oSHhswrEMGB+hzxWlB7CkzQkPSw8THsI0KvXqPsJSFd5eookfoLviP+kmmn/QGfiV9cDMkrTjJdm86XZ1HPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450059; c=relaxed/simple;
	bh=exgWbHID0vmaigzS4XnqckayK/oGniZO4zHXBr3W8jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF2rNWwFPIyTCTb9/N2a5/5DCl4wPxFR11mnDMNdtOZfC55ZJNRs0cf9kEi/EKulyUd6K1QleHel5gE7G8xKCxqgb7Y8ATP+X8PRVGflgPf5olc8L+hUHf4jvuBiglFZ19ZtM+yyPhx+Gxti9uBvNLrqcLajvI/hePx25wmMjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tafTi2xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2F5C116C6;
	Thu,  6 Nov 2025 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450058;
	bh=exgWbHID0vmaigzS4XnqckayK/oGniZO4zHXBr3W8jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tafTi2xpDg1xI/M2nj4GljTLfLTsbyxwZiMGVTKUEAl3EgFK9dTECbbexROmMwX+o
	 XpYvQJPxy57OUx/QXLeG8tyERm6CZ41Xx5b/assW8XCanFyiiMlrGMGZ0I2TflUkYW
	 z0Pt68TTHuOAVR7iDzngDfsEhbd0qH+43zQSksbPcPZECaaEnlN7DaFunvs8FJGABp
	 pnqDEWvP6TCRvO9kRHT0fvp8EfuAQ2aUZDKy3XAHkAOMdtIqBr0xcqN8r+MTDtKjxq
	 rkkonfeqhLFVSvXtTNLLNUuDkaofWLhfXkKWQN6aAUD45uDkb/VjMbAoVLG/0GfW50
	 vSBUwU35rf2XA==
Date: Thu, 6 Nov 2025 17:27:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH 4/9] dt-bindings: display: rockchip,vop: Add compatible
 for rk3506
Message-ID: <20251106-handwrite-dragging-3b3412f31f73@spud>
References: <20251106020632.92-1-kernel@airkyi.com>
 <20251106020632.92-5-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iFxwStVh54SvJg7o"
Content-Disposition: inline
In-Reply-To: <20251106020632.92-5-kernel@airkyi.com>


--iFxwStVh54SvJg7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--iFxwStVh54SvJg7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzagQAKCRB4tDGHoIJi
0tnQAQDjtDyPUwx20IW0HISJbhMIsNUDBRBA3cRm4dNIzlL4BQEA6j3h6HtparPK
FhH4LmHt/FFmIyYclVhg33+tCXx2dQw=
=VFYI
-----END PGP SIGNATURE-----

--iFxwStVh54SvJg7o--

