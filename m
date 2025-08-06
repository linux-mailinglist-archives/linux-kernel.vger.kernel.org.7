Return-Path: <linux-kernel+bounces-757140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B64B1BE38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BD7183A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6B7261C;
	Wed,  6 Aug 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Phvbf0Z9"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5252A1BA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442930; cv=none; b=BC3Js28OcmXfJWPzKdD1f4Ku3gBYn9qQRyHv/T9pTXv35JFH+nvZP6vdWOE+5IaLdBQThfG6GJKkNfmQzRP4XSQhxDfGijrznAnHy7tQ3VO5ZOoKEDXZD80FkfCcD6vZDqRjxz0FNSWY8uz0AGAQut4ezjDVOmb+xzU2u7lZ7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442930; c=relaxed/simple;
	bh=q16sqgrcDh4TW6b6QGnthsd0Rh9/8L6NGJ8pTp9TjsQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbWKCCGO9a37oZXBuw7AoBiXkYpbUDCxtA2MIcoREVREYxhOrbejJzB1r1yDIV35QNaZt7OpdeTYCSRjmOxft+iHQTgXfZ+Eruyys0IbL1t81ihnu3tnSiBYfIRycLx4zQU6IcgGl5R75x89g5Uwft+W7bYo0or+3O448ldG+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Phvbf0Z9; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754442926;
	bh=q16sqgrcDh4TW6b6QGnthsd0Rh9/8L6NGJ8pTp9TjsQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Phvbf0Z9KeOg7rHlR0UiPwm32b3qtbFS8lDlSG/PwVIw4TIwlThELZnZVwv+O6ILz
	 DrGVUl+Oo9PkULcyyHBgHV/Wxa6mm2kAnT4DFA4XmRKSLhNZjY9jueaPe0k+BRYCFZ
	 xzO6UTEgpsVjY7r0A47KjJ/sF8+1S0OU1pIT9xO4qg43tHsc0yjekRvw0KgrCOu8gP
	 tm3yN/TCZVdQisfqQjPwKvySpr15wYSZjXPpnzlpd6xRUzwE5abW2vJH/h8eNR3Y4c
	 NK5rjs88ErIgU/GaeIrxy4ybhMXj4ZeJLqYsAFcKFNriwC1LrBuANg3qP+ldg4M9xm
	 Zqo4VangpeT/w==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 544F06BFF3;
	Wed,  6 Aug 2025 09:15:26 +0800 (AWST)
Message-ID: <182db4f2848dc7b8c110d45bb606e6219983c237.camel@codeconstruct.com.au>
Subject: Re: [PATCH] drivers/soc/aspeed: Add AST27XX SoC ID support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 10:45:25 +0930
In-Reply-To: <20250805063957.1452653-1-ryan_chen@aspeedtech.com>
References: <20250805063957.1452653-1-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ryan,

Regarding the patch subject, can you please follow the patterns
established by other commits under drivers/soc ?

Separately, can we concentrate efforts on trying to get the platform
definition bits upstream for the AST2700? Arnd's recent newsoc PR adds
several new SoCs (as the tag name suggests), which is a helpful
reference:

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=3Dsoc-ne=
wsoc-6.17

Cheers,

Andrew

On Tue, 2025-08-05 at 14:39 +0800, Ryan Chen wrote:
> Extend the ASPEED SoC info driver to support AST27XX silicon IDs.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> =C2=A0drivers/soc/aspeed/aspeed-socinfo.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/asp=
eed-socinfo.c
> index 3f759121dc00..67e9ac3d08ec 100644
> --- a/drivers/soc/aspeed/aspeed-socinfo.c
> +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> @@ -27,6 +27,10 @@ static struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2620", 0x05010203 }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2605", 0x05030103 }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2625", 0x05030403 }=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* AST2700 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2750", 0x06000003 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2700", 0x06000103 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2720", 0x06000203 },
> =C2=A0};
> =C2=A0
> =C2=A0static const char *siliconid_to_name(u32 siliconid)


