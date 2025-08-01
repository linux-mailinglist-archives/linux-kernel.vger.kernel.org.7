Return-Path: <linux-kernel+bounces-753887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F47B18985
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF491C8552E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BCA2288EA;
	Fri,  1 Aug 2025 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Yr6cH3Lh"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEDCB644
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091213; cv=pass; b=A6jxVJyVUF/ea/jR/kgAejm/Bnn/m1ZdIN9x3BGxZ+Zp8FGYPKKQl60xndEymhcjZpG5V5LUf86fglK+UkmGjfcqbVOaeeOvWwCx2KAIUg+i7La9W3iyHx0pfwkM3rGl9vwt3qVe44SACAhfJOR0g/4uVhFxuN88KjYhHjXZH1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091213; c=relaxed/simple;
	bh=h2/iozN+Fgiw/quMaVvzKUxUSQOde9PzlsJ6mh3XX9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZHTYTZixL/IsnpxZoucCs6AxPSECZQFe/+hVapPhBeX31U36RZOyf43ozCP3DBVfbraIThQsuAjKk51stJ0cfEbjNbZ/TcGT3n93lV02sqz90UoTX6GfnuNflA7r1qSvmoCnbxQpxqBNMXv6thAC2a8SeM7ewi4s7A3ev+Y+8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Yr6cH3Lh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754091196; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fRDpJONf2JERzF+xDRjDiRp3hdfkZjeJXIkTdZXG3sMXQN28hvbBdF6IMEGCXWQJMvScVJzB3DlrgRV5me5U+dse416gPm5igVtICCE/wDaqQjyisR6JEoQkgwd7VvT0CcfsqKplIEHWiUaSpKUVdQ3pJUkxPd5vRUseEo0rxP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754091196; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7DAXmbrE8zqXTQAY6GkRCYerCmbin4dQaPstr9gxE8I=; 
	b=CVchjrCW+0M8XwWIYaR+72cYjPwXapC1LrNJmeY2luRnJEMgQ2m5P3jGwTYr81FrXm85VkJj6b+5VKOagL+QoKnStu7h6bcGqb/cg3AbryrOp3QSJ3fQxC1C7vOmKuI8MKD/x38CPiHHKfyab4I6JPi0dONRJ2AujaHPpblBkSM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754091196;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7DAXmbrE8zqXTQAY6GkRCYerCmbin4dQaPstr9gxE8I=;
	b=Yr6cH3Lhp8Pi4YRozFGQ1tK05GU8nrrXZvthLC0TzLV49md40KMBfDjpxpvie8iI
	fnzxoqwWY46sYmwYsG+wvYhgVY40Fai/TgysxsORTlhRZ90AHmszbiy/b+v8/ziDB0e
	CEnKK/lNdSWcf20kDIIHXYQTvMdLKz6QtT9WffGo=
Received: by mx.zohomail.com with SMTPS id 1754091194526854.8990153374416;
	Fri, 1 Aug 2025 16:33:14 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 69ED9180B4F; Sat, 02 Aug 2025 01:33:11 +0200 (CEST)
Date: Sat, 2 Aug 2025 01:33:11 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: defconfig: Enable Marvell WiFi-Ex USB driver
Message-ID: <havjh4auwxxnevxsfyepql4ovfivy36whldr6htlxo6akpen3d@qq535p6qbvmw>
References: <20250506130940.2621554-1-alexander.stein@ew.tq-group.com>
 <4669830.LvFx2qVVIh@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4669830.LvFx2qVVIh@steina-w>
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi,

On Thu, Jul 31, 2025 at 11:25:03AM +0200, Alexander Stein wrote:
> Hi,
>=20
> Am Dienstag, 6. Mai 2025, 15:09:39 CEST schrieb Alexander Stein:
> > This driver is used on imx93-tqma9352-mba91xxca.dts.

You need to send this to the i.MX maintainers.

Greetings,

-- Sebastian

>=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defcon=
fig
> > index 8691f0ee44e66..550b2505b5658 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -437,6 +437,7 @@ CONFIG_IWLMVM=3Dm
> >  CONFIG_MWIFIEX=3Dm
> >  CONFIG_MWIFIEX_SDIO=3Dm
> >  CONFIG_MWIFIEX_PCIE=3Dm
> > +CONFIG_MWIFIEX_USB=3Dm
> >  CONFIG_MT7921E=3Dm
> >  CONFIG_RSI_91X=3Dm
> >  CONFIG_WL18XX=3Dm
> >=20
>=20
>=20
> --=20
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, German=
y
> Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneide=
r
> http://www.tq-group.com/
>=20
>=20
>=20

