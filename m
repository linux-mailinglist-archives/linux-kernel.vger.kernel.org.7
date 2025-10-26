Return-Path: <linux-kernel+bounces-870620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CAC0B4C1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97194E581E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEA2F6911;
	Sun, 26 Oct 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4I8beub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B41AAE28;
	Sun, 26 Oct 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761515058; cv=none; b=lOn8r4zYvgtRNNVtHfNbyYujAB6qjRbfbXl6TQxAGAtIPtxZvdgtQoDH5mgm7gkU7pgDvWlWHBo8Po/tkX5LCRPEW4BrNoH09H3Qg00+lDT57VhJ12klMa2VITD5iGKqkZkZALDsBA/X/caJ4C0RORcXiWIC1ZpjvBYFZsdd8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761515058; c=relaxed/simple;
	bh=R0wcc8nBYPNtNsZgoclsUuWvcDYQ/fWNcQurv3oEFFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqp35sPd5YQoIQgmK3oxnBpw2hdpGc2nDLowu+DedtFjM3tr2Wqr3ZLO/9DI3Ur8VEvulF+uR+Mo7zw8+RC2OHJWJsZHiZKTphjZkY5dmOMNKpTiQMRV/8nBqDQm1qzHVuEZ4BruEWW7an+BLMx6bbMKHLxpYxsydLylf+uRqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4I8beub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0191CC4CEE7;
	Sun, 26 Oct 2025 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761515058;
	bh=R0wcc8nBYPNtNsZgoclsUuWvcDYQ/fWNcQurv3oEFFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4I8beub56lCXDtQIIagRhZqCf1bllEDpY3pxIA5Dcbx7FonZGyEcgla/0yTWVv8N
	 8BqIY+tucyymuIdV2DPISSxzeeXVFrwQ6QjiXiUE35LcDNXWn8Lw9XowOdA17NVbdr
	 6Wtmkd9zZs4MCmQr3U1b+o6KLW2N1769htiwx+YuEc25ish0S2nx/yBUw4239n4WRO
	 7V+B6Gnr8vlewOifX/Rhi5YKOcnQxTe14oHdnJW7CZtzPX/PUgo6Rz/ugjqrRSs+N1
	 89S1fmoI2Rb37fl4yUG/7OaCCSyoSYn5jv01asHXGeUW54TmI797JQ20loFvabHJQN
	 PJ1h/DoOtDzsA==
Date: Sun, 26 Oct 2025 21:44:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <20251026-registrar-impart-0f714e11e410@spud>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
 <20251024-hangout-designing-33e96c0d35fc@spud>
 <oymxspgopaqja63nipufgzn6kpobkdopemfaw3azhom3ikvk5f@e7cg4lq64j2o>
 <20251025-shakable-jujitsu-3a5e9c8895a5@spud>
 <ugmphokne6ssc7ou7apvbldxg7xxk24wp5jrzdasjiplnu6gfy@ebbuxnjqlsw4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdoDAXfg92n9Nn02"
Content-Disposition: inline
In-Reply-To: <ugmphokne6ssc7ou7apvbldxg7xxk24wp5jrzdasjiplnu6gfy@ebbuxnjqlsw4>


--rdoDAXfg92n9Nn02
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rob, Longbin,

On Sun, Oct 26, 2025 at 05:47:32PM +0800, Longbin Li wrote:
> On Sat, Oct 25, 2025 at 01:44:00PM +0100, Conor Dooley wrote:
> > On Sat, Oct 25, 2025 at 10:27:13AM +0800, Longbin Li wrote:
> > > On Fri, Oct 24, 2025 at 05:46:03PM +0100, Conor Dooley wrote:
> > >=20
> > > > > ...
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +          - const: sophgo,cv1800b-top-syscon
> > > > > +          - const: syscon
> > > > > +          - const: simple-mfd
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  "#address-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  "#size-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  ranges: true
> > > >=20
> > > > Do you actually use ranges?
> > > >=20
>=20
> Actually, I do not use it.
> I added it following Rob's suggestion in
> https://lore.kernel.org/all/20251015134144.GA3265377-robh@kernel.org/.
> Should I drop it or not?

I don't know why he suggested it, if it is not being used. Rob?

--rdoDAXfg92n9Nn02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaP6WKQAKCRB4tDGHoIJi
0ineAQCnx3f0EpPMqkkkFJY8iwI9lwZHPviAEyjHA0s0o85JLgEA7KvXDig05rNH
efVLx5OW3aA366PJ2D35x3+QPI785go=
=H40P
-----END PGP SIGNATURE-----

--rdoDAXfg92n9Nn02--

