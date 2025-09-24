Return-Path: <linux-kernel+bounces-831134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6CB9BA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F607A6EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F018B0A;
	Wed, 24 Sep 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INQUvJ0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E6258CE7;
	Wed, 24 Sep 2025 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741296; cv=none; b=uu520QjXRnoelHs9GWFZoYaeA3XKt1GF1LXLvASGV2q0tDG1+GLSTfow6mKWpZkk1AL5a5l9GC70b4/LHnaHFYaqu4AwyaNTF5Ykh1W8HDX8hHMGycW8M5/YbDiFabVAuwiZEZmkT/H6CvSC62EHn4FkNdb0bP7VbJ+OAcqJlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741296; c=relaxed/simple;
	bh=T1TL9FcBEKBPktZuNee9w+LuTn6dwsMRfe/Fei5GdKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQQkFCIOEy7asegalHaHXCVcu1pT1oApVlN9wlHyKXzj1kLjyyiH/sxbygtpcjldW75bjizaKszW0tRH/GeoEUhQQp6IHNmNtJedEW6BtaIstYeWuK61xkFTxS9uAysP2X0GUqsf+RpiTZPKTcZNjssy6G19k013eKPK2vSyxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INQUvJ0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCF4C4CEE7;
	Wed, 24 Sep 2025 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758741295;
	bh=T1TL9FcBEKBPktZuNee9w+LuTn6dwsMRfe/Fei5GdKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INQUvJ0OY0IOTHbUTZKHChE61SxueHG7+lMs0JuSjmuGlq4BYPz0ltJxR8CRUrD6D
	 y5EKM7acqcikuGbOf7gjtZMjHttBwb2iz6jhVKtAFY1KInbmzYbXu+mQAoyoNQFQ4n
	 Hj/JEUhZq18XXYDiJ5vfhnA61l7olASU7WiPfPkzCQ9FPDcrKPP2lKktBU22aZqI/A
	 zlY91HSMQx4zd2vB1cOe69qurZzOl7crwf8g5B1/Qr1gUJ9bNYe+MW8/ZqM4HP6YLA
	 w61zu1+fmOZDoRMD5Pa4ZxNx3bZLWi7PmjfIFZ74T1hxkWpgXFdYOkkqG6R+wYjVSQ
	 yuZUc9pXAr1Aw==
Date: Wed, 24 Sep 2025 20:14:50 +0100
From: Conor Dooley <conor@kernel.org>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: nvmem: imx-ocotp: Add binding for
 i.MX94
Message-ID: <20250924-chomp-shakiness-c1882c9ea038@spud>
References: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
 <20250924-imx943-v1-1-0d32d7852ecb@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+IiXT27lUb0BdT98"
Content-Disposition: inline
In-Reply-To: <20250924-imx943-v1-1-0d32d7852ecb@oss.nxp.com>


--+IiXT27lUb0BdT98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+IiXT27lUb0BdT98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNRDKgAKCRB4tDGHoIJi
0hTiAQCYzrrbAXZdYICVu4J1no5zRkudK4GVF6AHWu8BHe/eegD/cymuT+8GmqkU
zWJ12fxOOaXL19LJlF/sxDbSY1sHago=
=yioo
-----END PGP SIGNATURE-----

--+IiXT27lUb0BdT98--

