Return-Path: <linux-kernel+bounces-783722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1DB3319C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDF83AAD51
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A32DAFA1;
	Sun, 24 Aug 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="eqoTznau"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD461C831A;
	Sun, 24 Aug 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055690; cv=pass; b=UzeqXTV7FUB2WEMnRltAkDHtfKDavpw5oPv6NS7xHAJfJwy2fYD86q1FVmPDhlLGIKZlKSJK3A3Tq1Yi4L7kLXMcY1ch0LU7NCYH/Dldy1eMuj1ijX6BUbwSJpEwnWxhXtisE/XCQoq4cnpmOr9Cjpx8kd+r9VCm+JallB8ZevI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055690; c=relaxed/simple;
	bh=R1gD2jfyb4BmBrjWz3o7hpNYbWv/+2jGzDA7n8rOWsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bl98o2rPOG/m/2fxcGCO3qqA04epXIEhc6BPJGRbaA2QopB0vHuCsvOUOY/+9uSpIMs5IlgfRrpO8ZEGJMo9SzcVsA88FLCved+tVGZY7Dag1wPVYSk+59jMnWz3GR/+ycwAOk3RvFp+C67/29gXEX7PF9zxC0/1Rdr1KEnxUrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=eqoTznau; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756055668; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F5L+s6CtEJaU9st9+VBI3Sh4QXHcapPHcLRjBgsWbp+hccafZgx5b7OSEAtf0KYDnw1sXInhBM9mE3L9DA1e69OKM0SHkX2lYfI5oFvcqVrorgmVf6xbXAJ9m7JbCnm3szzC+zBOh/JAA8N4JO/DIXIT2Ta7ZGLasDVHlvWublM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756055668; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R1gD2jfyb4BmBrjWz3o7hpNYbWv/+2jGzDA7n8rOWsk=; 
	b=Ztt95mkmsb6Gp87jZOZoBCDhf2GD85YBUF4p1sPYxSjXVLyl9el957W7VDqbaFvodrKrcAV2RXwcGH+Vyj2Rwh+f9zOOd6t/83mZsC655MAtRLy+uW7XNWOMSHh2vdG4c9H7a+WhNvJOD/LhKbwuSeYlTO8AaFoMw5Ax3VhBfFI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756055667;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=R1gD2jfyb4BmBrjWz3o7hpNYbWv/+2jGzDA7n8rOWsk=;
	b=eqoTznau3WYQR8oWtCsVoWN9qkYRcnVzUzUCsxzSyspwSuUbtPoMAmFKpodWzGBs
	atUGeCifFvL+TolR+fD83bU3uijOtT41dXvm39vNmQJGR/Tlv+GDpMh4l9vSxJGX6pb
	/AMLRRRp2MgLphGlmlQQppI7/a1FrXF1Fs81fwCuTc+3yYZfhx12t90kFOsaU4y6H7o
	L9M091EDnCfut8qUw+rJNfc0azGPF68jbq0opYxXm5fqqi2b+q5r7f1vc4jEtI/fwaR
	31UNeIkCE9eu0ttE7fBjfj2xkRV/d4S8vIaxrYKsIACavfbxKPyzLmMbP43t+JKG9LJ
	TgYVe1fRLQ==
Received: by mx.zohomail.com with SMTPS id 1756055665959275.19546769364956;
	Sun, 24 Aug 2025 10:14:25 -0700 (PDT)
Message-ID: <3c2b62e219e50555319da369cafa9a8f79eb71e8.camel@icenowy.me>
Subject: Re: [RFC 1/3] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
From: Icenowy Zheng <uwu@icenowy.me>
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley
 <conor+dt@kernel.org>,  Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2025 01:14:18 +0800
In-Reply-To: <20250821100930.71404-2-hal.feng@starfivetech.com>
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
	 <20250821100930.71404-2-hal.feng@starfivetech.com>
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

=E5=9C=A8 2025-08-21=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 18:09 +0800=EF=BC=
=8CHal Feng=E5=86=99=E9=81=93=EF=BC=9A
> Add device tree bindings for the StarFive JH7110S SoC
> and the VisionFive 2 Lite board equipped with it.
>=20
> JH7110S SoC is an industrial SoC which can run at -40~85 degrees
> centigrade
> and up to 1.25GHz. Its CPU cores and peripherals are mostly similar
> to
> those of the JH7110 SoC.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
> =C2=A0Documentation/devicetree/bindings/riscv/starfive.yaml | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml
> b/Documentation/devicetree/bindings/riscv/starfive.yaml
> index 7ef85174353d..a2952490709f 100644
> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -33,6 +33,11 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - starfive,visionfive-2-v1.3b
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sta=
rfive,jh7110
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - starfive,visionfive-2-lite
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: starfive=
,jh7110s

I suggest adding starfive,jh7110 as a fallback here, as it's the SoC
best known to most softwares, and JH7110S shouldn't have any difference
to JH7110 other than binning.

> +
> =C2=A0additionalProperties: true
> =C2=A0
> =C2=A0...


