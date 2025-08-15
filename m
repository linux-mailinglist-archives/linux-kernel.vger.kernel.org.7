Return-Path: <linux-kernel+bounces-770661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE7CB27D91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270E05A6C16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32EC2FCBE2;
	Fri, 15 Aug 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="dGiTHQlJ"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAC2FC872;
	Fri, 15 Aug 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251640; cv=pass; b=UkY7l8WN8+dzev4xSk27BRMTEAWY8/SrH9dypZSr1dh1DKN4GvR7oplzlFiVmpO+3R9nh55mMFoN/J7+FSvxWmY3loLQbb+4PIkRkfx+IFeubhRaytCCXwwiYceRDyay2VpVoQ6zMB/Jb58jfhr1M39/psKnwS+bymWpoFdNF2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251640; c=relaxed/simple;
	bh=4R7tfCuYW4ZartBCW5YVMr9XfWVj465U64fgiTEkXis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7xOlDxokquYVxhhXsTW0kQVVcHT5QaIRStKNeqb1gFX7K9S7EP9P6+QdnsCyj/Cn+QaiWc0ziEvEh0Lu2ecX2rdLg6tLo5x4ImBJo1kpLAi+PD4IIlJ7v2XwCGzh3vG81y2GG1KNK4EBYAgZabViupDgD1A6e67CRExWa4EtZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=dGiTHQlJ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755251602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=koHlOkAgBWsUbUj+b24o/ctUd2mqOBqSeG4hv5l5rm+kkMCxaBfgD8KyfJGwIblmsj8SbL5UP6lbO/cyGtSNFmvJYwfXiO5zcDsRP4GTvaJ3HPAkNqdpPadOuNDiioSPAnQrI0l8iPOmqfc3wqiuhgFNu43E0tBase2P0TwBilE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755251602; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4R7tfCuYW4ZartBCW5YVMr9XfWVj465U64fgiTEkXis=; 
	b=ZiJTO94CyuhBtoV18GI/qII0uRZ5oGao6SZwUEzQQbC0mN4oapdpdlNxUQ2tNzD3w4JIu1wQtM0QnyM7CY8Qjv9b5rtXKF07FDb/8LIpZx3WjSfN3jXF4z4hJ0cADjAyM9kiVCKVdYfTFUYnwDNVwsJ7YYYaNUmwwpE0udlCI3I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755251602;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=4R7tfCuYW4ZartBCW5YVMr9XfWVj465U64fgiTEkXis=;
	b=dGiTHQlJXwDfK3pjDKBjJBKsOC68jlD1/jjKV8gxOixvhk8FxYn2D1xZeR8o56xq
	DR9yBVRnAQkFWf+oFZ7eh7+qjNnfpXlly8RlnClnL3viSri4Hnd1HEiDhOjcu9K5rMO
	lWFbQwWEFWUAoPhmKzH8MCtMy+p40PtYnv31E6mI56V1oPaxsc37t0hRyDa9eqWSkpp
	IGzja9J56MTPWH2+Rbctn7WEC0ldB2Za/6Z6WPkNWmCiG8yUFhGci9u1y7zD9fQZimY
	2XbTcVLeSLL9NJkpCyc/bqQ+WKJajubKPav4XqNU0JV1+FmxHh6xhzN5UD6XRqDZIr6
	ovEjMhg0Pg==
Received: by mx.zohomail.com with SMTPS id 1755251600358465.4611508627105;
	Fri, 15 Aug 2025 02:53:20 -0700 (PDT)
Message-ID: <4655d43b17c732947246f0e0deac14265fa07ca1.camel@icenowy.me>
Subject: Re: [RFC PATCH 2/8] dt-bindings: display: add versilicon,dc
From: Icenowy Zheng <uwu@icenowy.me>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Drew Fustini
 <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>,  Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner
 <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Michal
 Wilczynski <m.wilczynski@samsung.com>, Han Gao <rabenda.cn@gmail.com>, Yao
 Zi <ziyao@disroot.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
Date: Fri, 15 Aug 2025 17:53:10 +0800
In-Reply-To: <5af90b60-d65b-4e80-9a27-44938bbd450b@kernel.org>
References: <20250814164048.2336043-1-uwu@icenowy.me>
	 <20250814164048.2336043-3-uwu@icenowy.me>
	 <20250814220444.GA3988176-robh@kernel.org>
	 <5af90b60-d65b-4e80-9a27-44938bbd450b@kernel.org>
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

=E5=9C=A8 2025-08-15=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 11:09 +0200=EF=BC=
=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> On 15/08/2025 00:04, Rob Herring wrote:
> > > +
> > > +maintainers:
> > > +=C2=A0 - Icenowy Zheng <uwu@icenowy.me>
> > > +
> > > +properties:
> > > +=C2=A0 $nodename:
> > > +=C2=A0=C2=A0=C2=A0 pattern: "^display@[0-9a-f]+$"
> > > +
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 const: verisilicon,dc
> >=20
> > If the clocks or resets varies by platform, then you need an SoC=20
> > specific compatible still. If these clocks/resets are straight from
> > the=20
> > RTL and any other number of clocks/resets is wrong, then we can
> > stick=20
> > with just this compatible.
>=20
> Shouldn't we have here always SoC compatible? Can it be ever used
> alone,
> outside of given SoC?
>=20
> I could imagine now:
>=20
> items:
> =C2=A0 - {}
> =C2=A0 - const: verisilicon,dc

I followed the `vivante,gc` situation here, because the registers
before 0x1400 (where real display-related things start) seems to follow
the same scheme with GC-series GPUs, including the identification
registers.

>=20
>=20
> Best regards,
> Krzysztof


