Return-Path: <linux-kernel+bounces-889157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC7AC3CDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D743A535F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28534F474;
	Thu,  6 Nov 2025 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLwc/b9C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4426FA6E;
	Thu,  6 Nov 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450087; cv=none; b=dtJ+0GtGMpKwr9BUoOXNE6LRIqZ1gLhd+e9/4eytoHBT3i077p9a46O58oG6E+W3MztXDIuELKrMHXgryAFr1Ev8i2UL1V2BeSm7nhYZKMTo6OPc5c2MeO9C/7x3NI8UaZdx5w/X/r4Av0CUZct/N3jNK68BxA4HITJIOxw+Ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450087; c=relaxed/simple;
	bh=bgxrGX1ncCHXXJp1kwwkg1TSvCMea4zbZRphFSfsxhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krrjcjoNDI4my4d5gkPb62KgYDBFlG1QLVZa347Y7PRyC74Xd4XHd1Hr8WfQi1U/pQUFzY6xDNU0A2T2gQx1+sQL+Ln5o/zRCoG0z9FO1s75lN7VwbfkT44iOwRXwHBMIVmdD1KVnTwzqlIfUSxvu7fbtT+L8KJ1TIg5LKZEVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLwc/b9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C585BC4CEFB;
	Thu,  6 Nov 2025 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450084;
	bh=bgxrGX1ncCHXXJp1kwwkg1TSvCMea4zbZRphFSfsxhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLwc/b9Cj6k5hUXPM9oYxjeswD8Vb1ej4/mcZDVLV0MmuNFlo+hLSwLEDhVYG9FgW
	 2onU3Rj3cj25Sp6p7wA78X45e3lV0E274Qj4/fFwJbhu6X02vf+tVHiDX5nFbppzKk
	 50GP1FEbI7eV5/ocbikVTV9B1i5WUB0+NiRUrBhyEl6byOJ25Ik3kariC2esEEJYPw
	 iFULGRyotJ1WnSPGN6Y933gUd0H5d1YejDHnubSFeTWJy6dWVhtGODA1g5Hvpfxlm7
	 utgvNAHF6d4dpnoaEdW6rUJJPrGoEMTe3GNBVRY6uuAj65ErVMlp986qDmisjXmPK/
	 /8bCy4V5KvAnA==
Date: Thu, 6 Nov 2025 17:27:58 +0000
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
Subject: Re: [PATCH 3/9] dt-bindings: display: rockchip,dw-mipi-dsi: Add
 compatible for rk3506
Message-ID: <20251106-watch-confining-6a3800cf81eb@spud>
References: <20251106020632.92-1-kernel@airkyi.com>
 <20251106020632.92-4-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3yjg8hVehVxlP0SN"
Content-Disposition: inline
In-Reply-To: <20251106020632.92-4-kernel@airkyi.com>


--3yjg8hVehVxlP0SN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--3yjg8hVehVxlP0SN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzangAKCRB4tDGHoIJi
0mJSAP9jViavOmW7ijllM9pi+5hpceEFSeVprT+VVdypRaeBggEAraipNDFhLqIW
QknuBgh9VzGzJrCnn5mz8n4Ul7FO0Aw=
=9Uh8
-----END PGP SIGNATURE-----

--3yjg8hVehVxlP0SN--

