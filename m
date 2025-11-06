Return-Path: <linux-kernel+bounces-889160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F8C3CD77
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744F61899FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5634F265;
	Thu,  6 Nov 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ/RhAlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B334E770;
	Thu,  6 Nov 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450108; cv=none; b=WvXPPIlaBLM5K9CNV1fOls8UF7Pp54rkrvj16/ag+Lax7dFvYEzmR8xbC7VXIKtS00h5Za22d6y5eNF0YSn8B2hJFJUUS/QYjT7UMHpu9gUlG3h/ylXRtoI+5OlQPJ7LhKQdUZgHiYGPW7MLn6NPhSpmFFyfrCgI67Gw+8TO5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450108; c=relaxed/simple;
	bh=iC6Sx3olaO5GIbhILXITGGp5LFe0wk6ZVESyi6YJa2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A71S21JlyvEIeD/OTJV96ax8LhSfhofvshDDSD+2U0rrbTWklMG0ibjvurBQKvfVNB+S+3HmILL64u4vSBQabMZnijcCcYiHwLjcdZXfKy9Ff2ne2wK271MF/1irKMFe4joy6/3ROWIK0m6FnriK+Y4eNLd7rKd/JmwIg8Wk0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ/RhAlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818A5C116B1;
	Thu,  6 Nov 2025 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450107;
	bh=iC6Sx3olaO5GIbhILXITGGp5LFe0wk6ZVESyi6YJa2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZ/RhAlPp91Mcy1gWTPrw7f3QWkfcTayy9dLFwOf2tcTfXVkM0kPETL+M35yIWeD8
	 Z7vRAcMc7Gih4uILpZ85GUThjO5PmTL3ZoynkD1DBRl0/Ra4aCjINSqgAIGGZbjI0Y
	 5vevItUdsd7wjA69sCF7U4GKYAbVy06qJRMCmq9Pm9IIUzOQzvSKXxqGotopm95QEz
	 v26R4Zc4ZhQdM2K1xSmJMhM2K63QMdZkXTPOkDnW3GFF7pvdhh16q380+vw4TfLEO+
	 1hpDKGr1+VtdnU7UeJdRDBqjpJStrgXPORz2PDGKWkFI3nn7c4X2v13DY1r/FVY83d
	 Ucj6JVHe60/Eg==
Date: Thu, 6 Nov 2025 17:28:21 +0000
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
Subject: Re: [PATCH 1/9] dt-bindings: ili9881c: Add compatible string for
 Wanchanglong w552946aaa
Message-ID: <20251106-kung-lunacy-c5d7abc9208d@spud>
References: <20251106020632.92-1-kernel@airkyi.com>
 <20251106020632.92-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ofQ0I7gBfCHdH+8t"
Content-Disposition: inline
In-Reply-To: <20251106020632.92-2-kernel@airkyi.com>


--ofQ0I7gBfCHdH+8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ofQ0I7gBfCHdH+8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzatQAKCRB4tDGHoIJi
0rwnAQDmcL+k21bj18YzPi7gOSkRemWwpLsYjKt9s2bYSP+QyQEAxoCT6xwaVu0E
/KkqsLi7QzzgY/xbeYqQKIK693W4pwI=
=sGc8
-----END PGP SIGNATURE-----

--ofQ0I7gBfCHdH+8t--

