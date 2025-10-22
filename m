Return-Path: <linux-kernel+bounces-865616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B5BFD981
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE719A7F76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D732C158E;
	Wed, 22 Oct 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4W58T1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26015687D;
	Wed, 22 Oct 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154316; cv=none; b=MI2jsO+S2Izm3/Ro9xBWYl+REa2ManlOrUNd/kDqgB0XBtkyQSQG4GyZDRw0X456GqAWp6emoMVfX7MRlrBCmzplOPn2Vq+BbXrzXP95ZjnrcOchoJygMnWUnaxtXm0KNHiYNlTw35rhxQhu86/stvkpUzY2HQV+PCRxjVSowGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154316; c=relaxed/simple;
	bh=fswy1rZQ0TLFPMGWN5XwIyYhQmDROE4MdTqHp9R8548=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZSXa9rqLLmpmtXs7tXn5iviVRBGtqzlVU3ntuBa9qrZMOaRZ3LzLE/ScuPCazHFO4YszLuFnRy5D206RGNe0HGpuQYg8/Mw1sMlALgDKaQown1OOqJIxKWxMV0l7nEtYDF5tpQKKdYI/yA+PEA/yyYFQrKYS8OTo3ksWiC+EHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4W58T1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C831AC4CEE7;
	Wed, 22 Oct 2025 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154315;
	bh=fswy1rZQ0TLFPMGWN5XwIyYhQmDROE4MdTqHp9R8548=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4W58T1ScAlNqCXHBlJyvdgAHsiT/d+HYtZF/vFSI4Xdxe2f722w6JBJitnVBTveT
	 nSxttsD9pW/7B4iMSolH7q9lZr2LyYMBb5aSLDQO3IbMTtj40qhCj+zUpyq57x6yC1
	 YB3xIXqErAEx7gzsPQomhEsugG1c2vjegHBbqZ+K00JCg4d85hNaHVurIh2IHX1cO4
	 ykLL4dNCsee+LXMTqXsR3YY7bNLPnRsQnG9gSNukSJAErAdCk9kLGvqzA7G3+JdUdT
	 x5bxeo8l1ow/GGui21KgNSBJDaH2Bwn5DyIszC61UZ1dXVPkQd85eXMDH+gBtAkToZ
	 xSnCiJh3dkjVA==
Date: Wed, 22 Oct 2025 18:31:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
	airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dianders@chromium.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add Tianma
 TL121BVMS07-00 panel
Message-ID: <20251022-lukewarm-commode-8be0ccc896c8@spud>
References: <20251022124628.311544-1-yelangyan@huaqin.corp-partner.google.com>
 <20251022124628.311544-2-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ilTfaP2sXYTf7i3+"
Content-Disposition: inline
In-Reply-To: <20251022124628.311544-2-yelangyan@huaqin.corp-partner.google.com>


--ilTfaP2sXYTf7i3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 08:46:27PM +0800, Langyan Ye wrote:
> Add device tree bindings for the Tianma TL121BVMS07-00 12.1-inch
> MIPI-DSI TFT LCD panel. The panel is based on the Ilitek IL79900A
> controller.
>=20
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ilTfaP2sXYTf7i3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkVBgAKCRB4tDGHoIJi
0lC7AQDmkB81fazzC9jXb8LdRa2lTC16MefC7XvYeA1h68HhQgD+O8lHMyMHtoK9
o/xLobdgK9idVdHl1BIT5BRFt0DcXgg=
=ACIW
-----END PGP SIGNATURE-----

--ilTfaP2sXYTf7i3+--

