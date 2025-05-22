Return-Path: <linux-kernel+bounces-659407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A181AC0FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 17:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BCF3A59E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B5291144;
	Thu, 22 May 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuGurj2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F51C4609;
	Thu, 22 May 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927294; cv=none; b=ZSejeTUwiMmY5x3R7M2h0XG2NOFGJSw7RFMTo7HAU4ohv+D+c1VbHhvJin+dLQ1OIAHs3w/bFqjRjS+YY91MwggeSf0t7aSsjTCFTwtN4O5keaS+4LiXfoHgoWXSRjx4Ic/j2THZ1KKfVUfvns62IVMZ1ZEgWfR8xZc/Jm0+N3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927294; c=relaxed/simple;
	bh=tpteHR4j4RW8B5bGrxwkjmVxwT1rmhw2u37kWPPCBU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0RJhl5c5pGwSuImimCwAn6EgY0jDv6gxlctJ1pnUkNAeoqUWVrjtLgOi6zZTgKIJgpR9jhG21jdIfkTM07CmIOKVLs50rDWSIBLRAvWYLkTKZLPhNFoiECGPUqymHg/uAR80nygM410WM8hcsdLedecV+GVmM8hB9ybLrWpqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuGurj2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67606C4CEE4;
	Thu, 22 May 2025 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747927293;
	bh=tpteHR4j4RW8B5bGrxwkjmVxwT1rmhw2u37kWPPCBU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuGurj2lcnxWSiV65uFPDXeyYIIcA/Ege0JFRQTY+yuVXAYNCfPnaI/6sAjRiu6UY
	 gbRszGGEu6GkcPylHhLc2v3lb8Uc0HWEldny8P/oSccTpBowdF4MUgArWT09XX4pWZ
	 dWMIxLTAKOUZOVNJfCsFfltudEND1hzo66pQqIUGYKlMKye0rmqQ9FRtMjhElurLbd
	 iSaX3ePvBGN0fa7DRtU/k9N43hs7JVIYX8naXRVJ92/c2m3OlOKdq9GJ0vkERFmV0i
	 J5AttV7bKfJor2pPLyd3i3yFSyI2MpAloWan6EP7doKApstzg4OqYEUWuOnGu2ghEk
	 iDQoCe2nZpVgQ==
Date: Thu, 22 May 2025 16:21:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH ath-next 1/2] dt-bindings: net: wireless: ath11k-pci:
 describe firmware-name property
Message-ID: <20250522-elves-appealing-8ecff4971f4a@spud>
References: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
 <20250522013444.1301330-2-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DOVqCIfPjKAtLcqy"
Content-Disposition: inline
In-Reply-To: <20250522013444.1301330-2-miaoqing.pan@oss.qualcomm.com>


--DOVqCIfPjKAtLcqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 09:34:43AM +0800, Miaoqing Pan wrote:
> Introduce 'firmware-name' property to allow end-users and/or integrators
> to decide which usecase-specific firmware to run on the WCN6855. This is
> necessary due to resource limitations such as memory capacity and
> CPU capability, or performance and power optimization for different
> application scenarios.
>=20
> Two firmwares are supported: 'WCN6855/hw2.0' and 'WCN6855/hw2.0/nfa765'.
> The former is the default firmware, suitable for most WiFi 6 STA
> functions. The latter adds support for commercial-quality SAP and
> optimizes power consumption for IoT applications.
>=20
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--DOVqCIfPjKAtLcqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaC9A+AAKCRB4tDGHoIJi
0r/0AP9lmNp1y/LqEal+ClxcWGKPEJiDGBkHW5NbPiRHcRSJswD/Tg9dzDCG6wvf
GEE4QzIxtB0xIL3syZHj6PjYN9/n4wg=
=92db
-----END PGP SIGNATURE-----

--DOVqCIfPjKAtLcqy--

