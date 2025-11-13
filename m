Return-Path: <linux-kernel+bounces-898390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90588C552EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF694342BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F41EBFF7;
	Thu, 13 Nov 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="e/XQGG6G"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930781DB122;
	Thu, 13 Nov 2025 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994988; cv=pass; b=A3csg2k9ZvMpXq0AvlXChOa7LCTjyctHHzqasTO4J5O4gaNsvXAKc0v7nvfk7vhrQOuTkDo2jNt/JomnPwLDNlR23GH9nrqmG6/IQllFPO/ITMyuOoY7h2Kc/88Nc7eVGj0Lwwduia9M21DpHWXNi37Oila1CdWAxuMsLO4kxio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994988; c=relaxed/simple;
	bh=CaqYrXe8Ge+kPBFlhZjMdu1CeT964d9IlL/4u4InQzg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBPg/yhlT2+HMNvhRi6iHGOelPz0+zR1K7KVG2/UInQw+3kLhMfy3P+x+HJz9D/4dvkJ9AMz5o00agZu2DgpMw/uUjOEHQrz5fP4BV171oQy3dhgIsCj/Zvx7pAlPBVGofuSpeqKEdMLRiJ7UmCwfyB7GFs6WPk3KfaNF/E5mTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=e/XQGG6G; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1762994927; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H6LzGbP5dJZM746g0tHRH07iUvv90mFC1ovHkOxCf70dTMiaabPLP6JE4HObK+VFAaIA8aX8VeNn9qhua0P4h6fcM7z/2ObxAYspfjy/0rVOKWFsMtr0krNQ2zUCRhmEkYWBGmNjV2jmcOJ5OkNSWISSpM3OhJOgoCGA6ftkhuY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762994927; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CaqYrXe8Ge+kPBFlhZjMdu1CeT964d9IlL/4u4InQzg=; 
	b=E/uPDJNh+zJVd0hkFHDmkNmRzFnMfMIX+VwdBSR0A57MWSIsiA5AJ+oftIrlyy1wBuKh3cP1sJKHCPjTFkbyD/29zM1YMfUxFpnHBUPegAvFsdLRCod2L0LJL2XpklThhtfxdHdWz3LMTMFktAjKmg3xDzRpeUURSNOVfz+FQAk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762994927;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=CaqYrXe8Ge+kPBFlhZjMdu1CeT964d9IlL/4u4InQzg=;
	b=e/XQGG6GKNFqKSgfgsMobkmts6s5b2JIFfEeTnauhiARBxrzFOiqcu1y6m50CxBa
	UC0gn0804/nPbVDNvUgFXc/j59KJ0kBqP3mktrx5smdDG3DgMw9DC3fF280ly+cqXO1
	HgwRKOgZMZVEHhR08hjQ0v0ZLjAKhh7fu0UXNbRjU15MzSN03RQQZtrBiIb1Me+wVm6
	ERHC+BkxoP37ZC/xdNyugN4uSw597sCux35E8/jxI9sGdMshHSZa9NvjjoTU8hcDgzG
	t7fOu8ebnKcmH4OqbUe2M8+RWw5cQvKONtcdeNFm8HAkIwMyKBtQXf9CkIamYZ3dGTq
	fpfMqJ17Nw==
Received: by mx.zohomail.com with SMTPS id 176299492610942.753891752546224;
	Wed, 12 Nov 2025 16:48:46 -0800 (PST)
Message-ID: <1d54524d7ef939232b4512ca59c78794484103ca.camel@icenowy.me>
Subject: Re: [PATCH RFC 01/13] dt-bindings: soc: starfive: Add
 vout-subsystem IP block
From: Icenowy Zheng <uwu@icenowy.me>
To: Conor Dooley <conor@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Emil Renner
 Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Xingyu Wu <xingyu.wu@starfivetech.com>,
  Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Maud Spierings <maudspierings@gocontroll.com>, 
 Andy Yan <andyshrk@163.com>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org,  linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org,  linux-riscv@lists.infradead.org
Date: Thu, 13 Nov 2025 08:48:33 +0800
In-Reply-To: <20251112-skating-robust-81be8dee0a8b@spud>
References: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
	 <CGME20251108010453eucas1p2403ec0dd2c69ae7f3eabe19cf686f345@eucas1p2.samsung.com>
	 <20251108-jh7110-clean-send-v1-1-06bf43bb76b1@samsung.com>
	 <20251111-massager-twistable-1e88f03d82f8@spud>
	 <20251111-unsaid-rockslide-67b88b2e34bd@spud>
	 <0d8e3a626b037dd348378e5ebca8005c1e715871.camel@icenowy.me>
	 <20251112-skating-robust-81be8dee0a8b@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-11-12=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 18:36 +0000=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Nov 12, 2025 at 02:34:39PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-11-11=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 18:36 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > > On Tue, Nov 11, 2025 at 06:18:16PM +0000, Conor Dooley wrote:
> > > > On Sat, Nov 08, 2025 at 02:04:35AM +0100, Michal Wilczynski
> > > > wrote:
> > > > > Add the dt-binding documentation for the StarFive JH7110
> > > > > Video
>=20
> > > > > +patternProperties:
> > > > > +=C2=A0 "^display@[0-9a-f]+$":
> > > >=20
> > > > Personally I'd like to see these being regular properties,
> > > > since
> > > > there's
> > > > exactly one possible setup for this.
> > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0 type: object
> > > > > +=C2=A0=C2=A0=C2=A0 description: Verisilicon DC8200 Display Contr=
oller node.
> > > >=20
> > > > Can you add the relevant references here instead of allowing
> > > > any
> > > > object?
> > >=20
> > > I don't think that if you did, this would pass the binding
> > > checks,
> > > because there's no "verisilicon,dc" binding. I think I saw one in
> > > progress, but without the soc-specific compatible that I am going
> > > to
> > > require here - if for no reason other than making sure that the
> > > clocks
> > > etc are provided correctly for this device.
> >=20
> > Well I didn't specify any soc-specific compatible because that IP
> > has
> > its own identification registers.
>=20
> I still require one because I want to make sure that clocks etc are
> handled correctly. You can ignore it in the driver if you wish, but
> when
> the next user comes along with one more or less clock, I want the
> jh7110 one to be forced to use the correct configuration.

I don't think for those generic IPs requiring a SoC-specific compatible
is a good idea.

In addition, `vivante,gc` requires no SoC-specific or even model-
number-specific compatible strings too, and `verisilicon,dc` is from
the same IP vendor [1] and features the same set of identification
registers (see also all GC_ prefixed identification registers in [2]).

[1]
https://www.design-reuse.com/news/202527446-verisilicon-completes-acquisiti=
on-of-vivante/
[2]
https://github.com/milkv-megrez/rockos-u-boot/blob/c9221cf2fa77d39c0b241ab4=
b030c708e7ebe279/drivers/video/eswin/eswin_dc_reg.h

