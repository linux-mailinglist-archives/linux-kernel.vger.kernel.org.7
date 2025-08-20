Return-Path: <linux-kernel+bounces-778440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF26B2E5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E921C884A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11427265CC8;
	Wed, 20 Aug 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHXlXu7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5D8F49;
	Wed, 20 Aug 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719190; cv=none; b=NJbcPVBf6De3ZT0Q6b76cApdy9d/fyzOO+IVZVKpuXZtvPKXPMkBBTid3bcQ4wWymMfdlC2HNXC7jt+goxb7GxvBvv0T2dGV7m8K719RTVwbidzmzgGp4RDUmdLVVxhmos+6Pc/n7ZiW0AQBgVlKxbGyogn5f1IOUKeVDnwZYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719190; c=relaxed/simple;
	bh=P60wwoesTBMO6te6dk7a3L9wvODtWEgPKYSFfA3IV9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoG/Bb9lPytQtU3Q3m+jk5aJvVQI1z0nnbP7LD2pC6WM273xw0HKj9rzLGnEcGy84wKrf8uBpsfb4IWjW4sr5CfxnpwwXi4KkWt5IsRzw7gpeeRRsYzFRwfKa84nFNEnaRGbplA4oeh/ZIfQR98yeasvKxwlVtL1uCPuiBEIrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHXlXu7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D471C4CEE7;
	Wed, 20 Aug 2025 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755719190;
	bh=P60wwoesTBMO6te6dk7a3L9wvODtWEgPKYSFfA3IV9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHXlXu7yMOieX9RRwAvjK0zfFwWqf17kpDMgHbH0XybZ2crRGcSTAeOMIuxBWj4Gz
	 1/BiA7hDZLZnSFHpBqujjSIcc9D/HwpB8Dr28x21xtl7j4TGxxzajPo2trwoi1NvPc
	 eXOj1MpsDHo5U4d5AXtjTs7iaQqn3t5xloxhTu5U7F8loGe6IpDp9rXxqNuBm/R8dP
	 +8o6zFe5Cc//ulkbEihHLCzWn8jx+ST+ZqyYH08O+hK77tXC1yTf2NgcZoNEO6DyB4
	 jQQg+SHXQpgczflvLXVoxF9R2+eWQvbZ7vLwvXNJTmBKB6v4dFXl/Ovfdt6k4diO5Z
	 GPdwe7AEeq5zA==
Date: Wed, 20 Aug 2025 20:46:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Xiandong Wang <xiandong.wang@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yongqiang Niu <yongqiang.niu@mediatek.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, sirius.wang@mediatek.com,
	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 1/4] dt-bindings: mailbox: add cmdq yaml for MT8189
Message-ID: <20250820-conical-feline-ef984cf0a2b9@spud>
References: <20250820093831.23437-1-xiandong.wang@mediatek.com>
 <20250820093831.23437-2-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B6HxqTqUFzbAImUw"
Content-Disposition: inline
In-Reply-To: <20250820093831.23437-2-xiandong.wang@mediatek.com>


--B6HxqTqUFzbAImUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 05:38:20PM +0800, Xiandong Wang wrote:
> Add compatible string to support cmdq for MT8189.
>=20
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>

Please look at https://lore.kernel.org/all/20250819-coliseum-unsheathe-0c12=
a58e65e0@spud/
and reply.

> ---
>  .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml        | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailb=
ox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.ya=
ml
> index 73d6db34d64a..f9718b90d36a 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -23,6 +23,7 @@ properties:
>            - mediatek,mt8183-gce
>            - mediatek,mt8186-gce
>            - mediatek,mt8188-gce
> +          - mediatek,mt8189-gce
>            - mediatek,mt8192-gce
>            - mediatek,mt8195-gce
>            - mediatek,mt8196-gce
> --=20
> 2.46.0
>=20

--B6HxqTqUFzbAImUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKYmEAAKCRB4tDGHoIJi
0oQqAQDPHNuIZcBcVmaKJJTkZVUc6ou8ys3OTfy1DSIdnBdmUgD/djQs/i9p1tUw
TnEoLLHvaQIqQNTRbeNYv6atW+6DKQQ=
=iFbz
-----END PGP SIGNATURE-----

--B6HxqTqUFzbAImUw--

