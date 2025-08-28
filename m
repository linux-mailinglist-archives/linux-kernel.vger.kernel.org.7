Return-Path: <linux-kernel+bounces-790430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98550B3A70F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A2563193
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BC32BF42;
	Thu, 28 Aug 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6baMZT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80118322A26;
	Thu, 28 Aug 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400229; cv=none; b=PoAB0ykS1x35hXeryLNvrURJs3vpvFpFn4vcGvl8bgN7L5DT1QcWCbQcxVKa6RWYmNK/rfeVCghiZpWO4gydL7USav90KtpAIx9blDYTGxori0LsPvUJrpgiCkmXwjmUILUyOU6Csrc03wqiKnYvAuC/x8iKhLQJLlgdk4uoN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400229; c=relaxed/simple;
	bh=twbEl6RIop6nZrrZWjYGdwphD6aGwt1zB9C3V1gHSlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHLQFo5PGcPnIlYkXUgW1UIQCzLvodNNad9x5dsYDCdzrsTkVXOy1resNHPUT1ebWZKyf9R+tppsMNsqkap1C2WHED6GtJyim0Bpq8VwocVcbr3Gacu7hxBjI01g+ge/B2777e8OMmlsmGjbRfYmgsCJH58ZkfknwujgQ3+t92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6baMZT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35398C4CEEB;
	Thu, 28 Aug 2025 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400229;
	bh=twbEl6RIop6nZrrZWjYGdwphD6aGwt1zB9C3V1gHSlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6baMZT0HtqWBcrbX+fYbmZkLsk+3QnIsdA0VS4USY0L3HGXsilySuDBdrDLeWYZ0
	 uiwngObcZqJylx3m/I/vc5EGSlbzbL2qOJedAfvuLkQnW4ALGSYGm061j3Ba51VVwS
	 xgJbVxaVBfh3NrGqpS0xvLq3rrBNHhWyDCVm4QXzhvsdqfgLfoFxb3Ay9EW1V19vfK
	 XHcKn3LdodfBQN6icZ2CJ6hMEsZWevGfMIvAjlR4owY0a2j0CFjRpMygUMj0X2f8cY
	 fWOFXJoQg8HHnO60Jc3HnIvUMbXcuxCI8q/Z0jAY9IWdpnHAgL5NR5ITnOBDOG8sc9
	 A6pW9uU1ti6wg==
Date: Thu, 28 Aug 2025 17:57:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: soc: rockchip: add missing clock reference
 for rk3576-dcphy syscon
Message-ID: <20250828-shame-stinger-e1443c61d31a@spud>
References: <20250828131107.3531769-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p9ZbeHQWfYofwOCV"
Content-Disposition: inline
In-Reply-To: <20250828131107.3531769-1-heiko@sntech.de>


--p9ZbeHQWfYofwOCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Acked-by: Conor Dooley <conor.dooley@microchip.com>

--p9ZbeHQWfYofwOCV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLCKYAAKCRB4tDGHoIJi
0glBAP9334cjtxvGihXrVmnI3SiWQWYFgyyt8jz2Ht0U/JaZ7gEAy3V7xRCiRHkx
ARtCHT1yuoOGr+Lio1IlQih2X4fixQM=
=VoQr
-----END PGP SIGNATURE-----

--p9ZbeHQWfYofwOCV--

