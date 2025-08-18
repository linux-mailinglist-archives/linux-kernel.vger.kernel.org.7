Return-Path: <linux-kernel+bounces-774182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73030B2AF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A7F18A5535
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4F27B348;
	Mon, 18 Aug 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6yxmlbd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FD2773E7;
	Mon, 18 Aug 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538793; cv=none; b=Z5oPGPAHUzozKMB8lLVBXbpTLILXWtJK0o1xN6DfQiML/0SiYRw4ntOx6c95TtSJ1Jt/7lapXJ7JUA3U66u9kdyuYkl0bJtj4bFgOvqwSZCDAqJS9+LS0g5TYPTQG2nXU4HRsuWYRRcRS4RagjihLW89yX1Ori0nqzZcxTrYMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538793; c=relaxed/simple;
	bh=8QD47a7++31VLJAfDRpwGB9If1CqGaTD17f/6FYz41Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrzF5FxyAzE7njG1rcBY6E7uZF+R/O6sddjq6TdRSotZnAUVj2ts7jKTl2kAbk/+0ajHovN6Q9cz4zxlrkstcZt7o+Bv5Yl4L7e+NR9W5gGPv9cj3AZcK0m6z38x8S6tXU+sTnzSbElp2UwkQKpuaoIkvOstsW57HUVh9Ww6bus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6yxmlbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9F8C4CEEB;
	Mon, 18 Aug 2025 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538793;
	bh=8QD47a7++31VLJAfDRpwGB9If1CqGaTD17f/6FYz41Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6yxmlbdC2RlSs2jljtekiKsQM5jIWqZJ+Ku7aZvynEbE/xmQPM6pzL4AHVbkmtX6
	 WpuaP5/BWQ5lVKSNyon1Z6LudDlLO2Pt4aaFeE95plzAB3vR1jQH8uEVMpmcKC3Y0n
	 UP4W3DM14xC0UUFmMefhjWckaXTyiIw5jGReRuuzTEvvyaqFt7ZeW/KZ/HKfd5QtRD
	 wb92NzcXPg4NtebYqv4MAwso+RaPedkvBm6TMWw9vkF/87c8uGK8KdBjfKS833je9o
	 OwiN1xQ+OkS1huVmYCYis4+uS/t8am83zztULl5bJr3hrn6mKmWIDZPPMGBIxd0Nv2
	 y45pD4a22zJhQ==
Date: Mon, 18 Aug 2025 18:39:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Mateusz Koza <mateusz.koza@grinn-global.com>
Cc: angelogioacchino.delregno@collabora.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com
Subject: Re: [PATCH 0/4] Add support for Grinn GenioSBC-510/700 boards
Message-ID: <20250818-paddle-grief-9f74d59d1b89@spud>
References: <20250815160837.371592-1-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QNL9t9AvLv0U/IlF"
Content-Disposition: inline
In-Reply-To: <20250815160837.371592-1-mateusz.koza@grinn-global.com>


--QNL9t9AvLv0U/IlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 06:08:33PM +0200, Mateusz Koza wrote:
>   arch: dts: mediatek: mt8390: add Grinn GenioSBC-700

s/arch/arm64/ in this patch.

>   dt-bindings: arm: mediatek: Add grinn,genio-700-sbc as a valid
>     platform
>   dt-bindings: arm: mediatek: Add grinn,genio-510-sbc as a valid
>     platform

These two are
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--QNL9t9AvLv0U/IlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKNlZAAKCRB4tDGHoIJi
0rFUAQCieJA2LUW0GoG6nElADTuacveifnWDgRu5M1KHYSHLzAEA13WqioahHbk6
zMMp9bCk4IrCTNMBEKF69re78v7WsAM=
=UkIe
-----END PGP SIGNATURE-----

--QNL9t9AvLv0U/IlF--

