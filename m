Return-Path: <linux-kernel+bounces-720797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B50AFC079
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA37AEE9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246972116E0;
	Tue,  8 Jul 2025 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HrxfvQZM"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E891B4236
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940424; cv=none; b=ftClIrj80z766bOqPUZ0o/4pFN8v8R2KON0WKkTSyJWWJ06x4qjuUgYTQbVRh7r86aZqbyXN3NEO4RoHy5r0lFvw9NYJIfYs/pCIFQ2Zay363vowa3sZAhS/fLC9aYydGX6xsMECcRSE1oOAkEp93HhK3L1E9NcKSfnlnpF7spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940424; c=relaxed/simple;
	bh=22aHBNm2PspGv0EtsJjFnQgJ+VWdLmQz4v9JsyG/8T0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOMKFsikWj59wu5OVF04cDr2flL05R73sIn43qw4XShBPFdb/KZ95jzXXr2/UfNjyu9NTvj7rj4vAkk5HoLI5I3+Epvm39myRKbfmYxGzQaWspo00kH9w1Em6cIX3Pbcgv1TmfvHpw11W3aoMr/tKZDjNXSvw2tB0JhPzxbfLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HrxfvQZM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751940420;
	bh=22aHBNm2PspGv0EtsJjFnQgJ+VWdLmQz4v9JsyG/8T0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HrxfvQZMQqxlV3pXxRhc8vFKhJqUddUqywz7ltue+x0o9avwg4/C/7Tyu2+x8F4+Y
	 uLSwX3Soo59Ol+gx+Sl2/YWPD0VqA1iXFh89OzNL3I1wZd2G6Iyza4EkoQDnZNhw71
	 CPF4OhNGGJJno0BrvTmasL+ExIxwNKGS1rNFAV459k2bOlMBvkBQZbUEV/Em19/nnr
	 2IBpFcdfreG7UHRahfoXaFWMAYJ8NcTW97QpghRjVsMZuaC3X54FL6q70XNGsMZJuc
	 ksk8J/tDPelZVLBHwgMdHzanvSFHN7eikJMJP5P3DqigxlvntjJbs0Q3YgJGoCDOuL
	 RGiqDY0xEqS3A==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 08D9A6ADE6;
	Tue,  8 Jul 2025 10:06:59 +0800 (AWST)
Message-ID: <6ae95d064de0c1b6333c234e461eae3e8da80168.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 09/10] soc: aspeed: lpc-snoop: Consolidate channel
 initialisation
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>,  Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:36:59 +0930
In-Reply-To: <20250704171315.30300f59@endymion>
References: 
	<20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	 <20250616-aspeed-lpc-snoop-fixes-v2-9-3cdd59c934d3@codeconstruct.com.au>
	 <20250704171315.30300f59@endymion>
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

On Fri, 2025-07-04 at 17:13 +0200, Jean Delvare wrote:

>=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 51 +++++++++++++++++-----=
-------------
> > =C2=A01 file changed, 24 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed=
/aspeed-lpc-snoop.c
> > index 8dbc9d4158b89f23bda340f060d205a29bbb43c3..9f88c5471b1b6d85f6d9e19=
70240f3d1904d166c 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -294,12 +294,21 @@ static void aspeed_lpc_disable_snoop(struct aspee=
d_lpc_snoop *lpc_snoop,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfifo_free(&channel->fi=
fo);
> > =C2=A0}
> > =C2=A0
> > +static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct aspeed_lpc_snoop *lpc=
_snoop =3D dev_get_drvdata(&pdev->dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Disable both snoop channe=
ls */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aspeed_lpc_disable_snoop(lpc=
_snoop, ASPEED_LPC_SNOOP_INDEX_0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aspeed_lpc_disable_snoop(lpc=
_snoop, ASPEED_LPC_SNOOP_INDEX_1);
>=20
> For consistency with the probe function, I think it would make sense to
> use a for loop here as well, instead of hard-coding the channel number
> to 2. That way, no change will be needed if a future device supports
> more than 2 channels.

You're right, but for now I'm not bothered by it. I'm going to leave it
as is, as the motivation for the loop in the probe() path was to
consolidate the logic required for both channels. This one is an easy
thing to fix down the track.

>=20
> None if this is blocking though, so:
>=20
> Acked-by: Jean Delvare <jdelvare@suse.de>
>=20

Thanks.

Andrew

