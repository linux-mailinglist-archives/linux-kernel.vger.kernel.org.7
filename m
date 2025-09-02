Return-Path: <linux-kernel+bounces-797258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1EB40E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A5856363B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8F2D5957;
	Tue,  2 Sep 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BawJS0vt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC0350835;
	Tue,  2 Sep 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842406; cv=none; b=sgmIlgFdNDdMf61x4T27a9HuXRfui7PCqvTYYugvHbIZNOow64jvNR0JqitsGZwTH9WiSsmGLLCnhr3FOE/9YC9NWQXgRcJEv7ltvEciGmGH0QNiNRmOivtkZm74Gn4gh/+s3c4eqUr+sD+LjyjXzcF0+kEa8NAbhqSs+HnuKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842406; c=relaxed/simple;
	bh=CdZRISA+gHEiKLzaBnl6L8jh3RJF2Z38OQtqosUs1iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msSfTNXIAL1mvHAcGjo+1djp1Wj17Mpcwtc+UxEQ8zX2FlrLrr2s6F8GXlLWUHeCWKMP5WOI0ttF6ilx1WVBdkowuDvROcw8vba6PBuGxGd2k97WKUBL4VhY6eNjWc+xw8zbBhdQOwx4yztH/RW8VWiylGZAIl2sFWWKW3LJr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BawJS0vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99B3C4CEF7;
	Tue,  2 Sep 2025 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756842405;
	bh=CdZRISA+gHEiKLzaBnl6L8jh3RJF2Z38OQtqosUs1iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BawJS0vtxYtH/xFhNdiDLcwJiKEHO2uI1LWPeQSZRCUC6juDn5PqmtiFNXi87Lioy
	 dSKsRqzIUQ/e1LMiFo6XWSL4FGZhQ8+4Q3KY+Z7iVzHj/GQs8Si6ZBy2TTx1bJQVdf
	 rskvoXOd4aNemMT9v6Fn7G+efiNxQT67zaHyizNN2dvAY8sS6APQQJzsNG9d6QDCBO
	 PUKOxZoR4aOK7JiyKDv+ihx2sfEKk8xfczoJ/CXShPQjmXx6Zke+k/6ImyE37S6dH7
	 AcGlyOZork/DYtqVayJtKMhafwMoIDTQpvyqQmLQ/arL9MW9rNPzRvNX81xxYhFl1M
	 0JjjevjgMHOGg==
Date: Tue, 2 Sep 2025 20:46:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, ajones@ventanamicro.com, brs@rivosinc.com,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Subject: Re: [PATCH v2 2/4] dt-bindings: riscv: Add Zalasr ISA extension
 description
Message-ID: <20250902-embattled-pandemic-254a71360f10@spud>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
 <20250902042432.78960-3-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F5KiYL1bGp+1NxlZ"
Content-Disposition: inline
In-Reply-To: <20250902042432.78960-3-luxu.kernel@bytedance.com>


--F5KiYL1bGp+1NxlZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 12:24:30PM +0800, Xu Lu wrote:
> Add description for the Zalasr ISA extension
>=20
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--F5KiYL1bGp+1NxlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLdJoAAKCRB4tDGHoIJi
0ptIAQCaoWjxj52htgtd1T5cupEX6Xxhi7rM5bR8frrLzgpAXwD9H7LxrnzkSQw0
70FLm2xEp7XUSwoUAZ8eefbM5SZvfAQ=
=Nxrs
-----END PGP SIGNATURE-----

--F5KiYL1bGp+1NxlZ--

