Return-Path: <linux-kernel+bounces-720796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB97AFC078
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DA03B35B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6190217F34;
	Tue,  8 Jul 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="efnZSxRj"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4420B7ED
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940414; cv=none; b=edwNr8F3p62d9FaURwh2fp563Gk4GoKrrx7tnE66HhesQ46tz12+MZame8B53MIc6bkYMVjX1EMqRco15qDeyjzE69/HNRNL0AEL9lC8B5CnxODD0I8miiHFWVgZCfirt7wXcaA3DvrTOp49t1LmTfu8K9frSVo5RDY3Uy1Jgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940414; c=relaxed/simple;
	bh=nghdqr1TNgA7GTnWXSxnqQpSMH1Jj0RJB/prk1nIUIw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdmRiuhGclSsapnwxixtCDtRvNWc9aal0P6oij5wC1XjsfxusikseZw+BlkKrhr1gs3FGVkXYlaRJ1Brj601GQvPA4b38qYhDMPP/qTLZVYUzE6yS72rqRdnUvwYqUoSa1yJDd5yV0vMt3iObjx0iV2AAH9VU+ZoHuuw1ouD/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=efnZSxRj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751940409;
	bh=nghdqr1TNgA7GTnWXSxnqQpSMH1Jj0RJB/prk1nIUIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=efnZSxRjJWL650CnneLc0hEdvRZaLwoT/UZWjOeiMpODmJ9Qh7k66Ejf1RFGcD+Si
	 RNbW+BHbe8Wbnxg9j5DjAZiT7uANwG9Kl+ZiHYTslCR8NaxSaCDFvl/BPD6lx70ygU
	 gc6kXs/SoeLzq23e6EOWOCW+SEZlnFRaPsCHJsFy9X65evzc+eKBNfCeXPueyyNrWB
	 g678EnZT064/eewjQKeW6naXKWK1grI0oNvOM+1stcQoXJDMJaevtV/6nzBkPw9bBP
	 ZstormeTgESK2Wz847+nLuUXSEAsBD+pYRWcEcJtLBAIpwPLIkb2a8vuNX3xaa3u23
	 7C+Vhb6Sb3ppA==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 26C476AE34;
	Tue,  8 Jul 2025 10:06:49 +0800 (AWST)
Message-ID: <7e4738d944c611cfb0e4eba4ce2926ed55a0096a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 06/10] soc: aspeed: lpc-snoop: Rearrange channel paths
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>,  Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:36:48 +0930
In-Reply-To: <20250704173443.3436f535@endymion>
References: 
	<20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	 <20250616-aspeed-lpc-snoop-fixes-v2-6-3cdd59c934d3@codeconstruct.com.au>
	 <20250704173443.3436f535@endymion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jean,

On Fri, 2025-07-04 at 17:34 +0200, Jean Delvare wrote:
> On Mon, 16 Jun 2025 22:43:43 +0930, Andrew Jeffery wrote:
> > Order assignments such that tests for conditions not involving resource
> > acquisition are ordered before those testing acquired resources, and
> > order managed resource acquisition before unmanaged where possible. Thi=
s
> > way we minimise the amount of manual cleanup required.
> >=20
> > In the process, improve readability of the code by introducing a channe=
l
> > pointer that takes the place of the repeated object lookups.
> >=20
> > Acked-by: Jean Delvare <jdelvare@suse.de>
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 51 ++++++++++++++++++++--=
-------------
> > =C2=A01 file changed, 29 insertions(+), 22 deletions(-)
> > (...)
> > @@ -238,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lp=
c_snoop *lpc_snoop,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_misc_deregister;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Enable LPC snoop channel =
at requested port */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_=
snoop->regmap, HICR5, hicr5_en, hicr5_en);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_=
snoop->regmap, SNPWADR, snpwadr_mask,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lpc_port << snpwadr_shift);
>=20
> This duplicates a comment which is already present in the driver a few
> lines before.
>=20
> This duplicated comment gets cleaned up later in patch 10/10 (soc:
> aspeed: lpc-snoop: Lift channel config to const structs).
>=20

Thanks, I've dropped the duplicate in the process of applying the
patches.

Andrew


