Return-Path: <linux-kernel+bounces-829855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF6BB980FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D92A7247
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D321C176;
	Wed, 24 Sep 2025 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="A5MwtSpk"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F86218AB4;
	Wed, 24 Sep 2025 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680017; cv=none; b=WATMoYCEZqcHm6fq2KfPCK5w0MaxVYhQZyQu3KyUV36qNBZHzSbiUcu83EQXleh/ZwQrwocumhiGvPNKpc/DfON7G5XTSOIK1eoD7JEByWWOC/UmBnw6aR9ceYHxpjPDz0kk4brP3V86f+6OcitH/TFx5/r2+NBwEkEvBl1Dkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680017; c=relaxed/simple;
	bh=75gJs9kCB4GtmOyT/l1Wj0RBq7NK2ywXUcAlhD7QHDE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPJk1Qeq3kMsHDZvQeYUpQ2QJrK99a3YnyyCQEeZxbuJqpIutEx36fnjITfXUViqA4i3KN95HuYdlM9Yae0t7dOQshj2DCqpO/XPAhf9B3EBBOahtzi2+w2EQeBmBFQn9aU87zyxwwDnagqxAazWVmolDFoRzXPSLdHFTdcyhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=A5MwtSpk; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758680013;
	bh=B4+vMC3mMORtvsHhkWNQq4UX2Am1Y6Z4F6Rf3tApsxQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=A5MwtSpk99lhf+43cgkAKPPojgLx74pqY+r+UQSh4x/5AiKNOiHZgfCH2HNZ4xHL/
	 PO4mbROfKEipns/AEsgGIC3OVbEwfj+7LkRhufn7AijYUfXbqTFgdS2/0HRr8m+l3n
	 Fa9OOm0nJK+5zUEQmCfsOAC/CJ3YySS+tqc7M3xul4f9p9/9D2rdkXv0b/X68vX6sb
	 8jNkuIzkI8J+3K/oQYMbUN4cOyFp1ifU89pCZ7b5fZKDYWg985Hxe1CB4wDowxEJj+
	 FCxECcS1NSweh+r859CgR+ADCcGoLCRUaJKMqQF9pZo3kLAPqM81ihaVQyerjjbPmW
	 PL7hsmRlFRX7g==
Received: from [IPv6:2405:6e00:243d:a853:dbe5:4849:b82e:5665] (unknown [120.20.205.123])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E7AED647A7;
	Wed, 24 Sep 2025 10:13:31 +0800 (AWST)
Message-ID: <9990f63e533c538ca95c3a2bd3401d27f031c330.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 11:43:30 +0930
In-Reply-To: <2cecaf0b-9fb4-49f9-a346-ea3f44627a15@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
	 <dd660ce0388afb61e476f164335600f3fc2b1fb6.camel@codeconstruct.com.au>
	 <2cecaf0b-9fb4-49f9-a346-ea3f44627a15@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rebecca,

On Mon, 2025-09-22 at 14:47 -0600, Rebecca Cran wrote:
> On 9/21/25 20:40, Andrew Jeffery wrote:
>=20
> > On Wed, 2025-09-17 at 12:04 -0600, Rebecca Cran wrote:
> > > aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_addr=
ess_if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicat=
e unit-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@=
400000)
> > It seems odd that the partitions intersect. Are the offsets correct? If
> > they are, can you add comments to the DTS discussing what's going on
> > there?
> I'll delete the code partition. I added it to make it easier for my=20
> script to flash both TF-A and UEFI areas at once.

Okay, thanks.

> >=20
> > > aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells=
', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5=
', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog=
(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
> > > 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yam=
l#
> > This one needs fixing.
>=20
> I'm confused, because in the existing device tree files I'm only seeing=
=20
> 'hog' used in the &gpio node, while 'pca[0-9]+' is commonly used as the=
=20
> node names for pca95xx devices.

The error above is referring to properties and sub-nodes of your
nxp,pca9557 compatible node, rather than the name of the node itself.
That said, node names are preferred to be generic (e.g. gpio@) rather
than specific.

>=20
> Does the gpio-pca95xx.yaml file need to be updated?
>=20

It depends on what you're trying to achieve. At v6.17-rc1 no other
devicetree in the kernel defines an nxp,pca9557 node as you have here
with gpio@ subnodes, and neither does the gpio-pca95xx.yaml binding
allow them. What caused you to add them?

I expect what you need to do is remove those sub-nodes, along with
#address-cells and #size-cells.

Andrew

