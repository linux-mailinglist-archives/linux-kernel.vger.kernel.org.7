Return-Path: <linux-kernel+bounces-889152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D464C3CD89
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A21124F126F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456C34EF12;
	Thu,  6 Nov 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmMzs73V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EB34EEE7;
	Thu,  6 Nov 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450039; cv=none; b=OnftZ/Kl2k4XOcsCEpah+keY73ycsWJMOoiLSADjOTSawgMmtSqrtiH6aV8226ive2tOYkDLqq/qDBNj60Z3Qo4B9TGRLZ1QRFO/ByAaylW3IXm6GSeArrPTzxveEeVvn0qj/SMhE8dkwbun4N4iYm+vTTa1ldiQVgPoYex60p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450039; c=relaxed/simple;
	bh=lUYNwn621b4INnVv6cYUd9i8ygchqkVKYYeeytWLys8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF829dC1I41O2/JgLTglzLWEad7tkGjSMj3ebuZKHDdrqIAtWIcf0erR+5GmLE+WZSO73idR91ogNZ2xUYnse4vaPxPBXZoJYn42+GLcK27mRxBANRvo4oaJ+/TH9OfLHl012F3a69HVS0oZ/hRDpJcGgSDYZHUc46RPY6ixgVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmMzs73V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC827C116C6;
	Thu,  6 Nov 2025 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450038;
	bh=lUYNwn621b4INnVv6cYUd9i8ygchqkVKYYeeytWLys8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmMzs73VnjPXmC/0CawgwdAAECJ1wJXAWnwMQs7cvyNsJ8gcIKEmofrUeLkYBv1bd
	 1dwbVsduZY9Hh2P4Er88otWdF/OtGWQBj59m5EtsoxzMWIQqz4I/gg5CSBj2A1TXk5
	 +CDYE5TE1HSL3IZtGbNZ/4X9hMqqYJj3wEvS3IweFoWj2AE2jtIarNJYcPWV3e6Try
	 T5g4cl/zNIMVWgstSipeHjVO7I4mYPDg0HSmdLE1UpofGJZx4AuNIgH3xfYWXSof1Y
	 TW1r3xus5GPisF2NMyuBSwOVbEIQhFCmZEWc+SbXjqHg69Zu9aFNrWLLQm5Z4gR/u/
	 7DpEB7V12nwxg==
Date: Thu, 6 Nov 2025 17:27:12 +0000
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
Subject: Re: [PATCH 2/9] dt-bindings: phy: rockchip-inno-dsidphy: Add
 compatible for rk3506
Message-ID: <20251106-litigate-cultivate-75a4aac333c7@spud>
References: <20251106020632.92-1-kernel@airkyi.com>
 <20251106020632.92-3-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V33MzIjcuA2BZAPY"
Content-Disposition: inline
In-Reply-To: <20251106020632.92-3-kernel@airkyi.com>


--V33MzIjcuA2BZAPY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--V33MzIjcuA2BZAPY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzacAAKCRB4tDGHoIJi
0hUTAQD7NwjnqRmBmopmm9xS3ZqfaL4Lj+EawXUG/K8Qy/2v1QEArBXv4nDqLv9S
VD0Fl63GQYh+57qF0vwhbIjEcBRyQgs=
=XWuK
-----END PGP SIGNATURE-----

--V33MzIjcuA2BZAPY--

