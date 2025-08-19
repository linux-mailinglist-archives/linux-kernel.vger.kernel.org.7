Return-Path: <linux-kernel+bounces-776296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9CB2CB70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77D5188F5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B730DEA7;
	Tue, 19 Aug 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILkVPYJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801330C37D;
	Tue, 19 Aug 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625901; cv=none; b=g5GQmw45l0gFLxGE2To6m0jAnIh5ke2Nwu76CZ6OfRWOZShRjGcZYB1IjhOhuMPboHjkU5On0otc1B4OVm9WoaDtnzH/iWt7I1RdEaBSW768j7309ZrbLZEScDMb0V5mMLVq0O1DBFvdZQze7RpHAOb7OMkmYFSa565CA7iEM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625901; c=relaxed/simple;
	bh=hlxKC/fZYMkvDgRn/9jFc92mXbXWAaT06wWuJZbE8/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKxa8MDdZywmID2NcJibPPHtyD9eMeKQQLPKMQFZ+PWrt/C/kDkTMc9blg4SLPphN8uGokMAZQfHuVB4EGkzkdqZKrI+oyV8l8qDgMgIprB9zAV0qICsxOPIuFvA9NMNN6PUSoWOmJ0jUT3UoKNotXqSbQDXVcfvdj+Xwx4BgUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILkVPYJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F371C4CEF1;
	Tue, 19 Aug 2025 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625899;
	bh=hlxKC/fZYMkvDgRn/9jFc92mXbXWAaT06wWuJZbE8/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILkVPYJ4KIhl8B+ru/J4UZeLcxaZ6jbQ3RcrQnJ4bz2AS4WAaJu3t/+gwq5gi4hgx
	 MZxtXuAJoURTOmp2K6ad+vWRlBxvQkLOxaC5URqDiOFl8L7jiC99c6nWKgx7zXUm8I
	 VdZSG+tIdc4ZAaULGnoI3FjwSyaxRqVrZqhuqK+Qh6h+s3AZpwWicRiouf0am68YHK
	 NL5hCcHtFBY9rWe2gd0sAJu3UVyjR4FStMFVdesCcHwN1EK65XA82NLk+V2+Ui5dxO
	 z9vG3djSn23mLaiKi3nWo3ZMfboYKc2PkL/M35LHpbaA//2hmg1QVuh3+8dAlloIhd
	 SKTGaLxnCCV7Q==
Date: Tue, 19 Aug 2025 18:51:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Xiandong Wang <xiandong.wang@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Houlong Wei <houlong.wei@mediatek.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, sirius.wang@mediatek.com,
	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/4] dt-bindings: mailbox: add cmdq yaml for MT8189
Message-ID: <20250819-coliseum-unsheathe-0c12a58e65e0@spud>
References: <20250819015948.15450-1-xiandong.wang@mediatek.com>
 <20250819015948.15450-2-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3mGP6X55tJdEsY6"
Content-Disposition: inline
In-Reply-To: <20250819015948.15450-2-xiandong.wang@mediatek.com>


--o3mGP6X55tJdEsY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 09:59:38AM +0800, Xiandong Wang wrote:
> Add compatible string to support cmdq for MT8189.

Is this even the right commit message or a copy-paste mistake?
That said, you're definitely not "adding cmdq yaml" as your
$subject says, just one compatible, so the wording there should match
what you have here (if cmdq is the correct name for this).
With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
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

--o3mGP6X55tJdEsY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKS5pQAKCRB4tDGHoIJi
0kOlAQDYgIAyIQ0B2sEimeK7s/YMdj7wbUWhc/DWFuzMTkKUtQEA74V+NzYV147J
wWB2i0+0VEqPoYtH78IoCJnkulM1KgI=
=6ubp
-----END PGP SIGNATURE-----

--o3mGP6X55tJdEsY6--

