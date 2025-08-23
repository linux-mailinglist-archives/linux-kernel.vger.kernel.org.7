Return-Path: <linux-kernel+bounces-782920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5620B326F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 07:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9FE7B8F83
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1F218584;
	Sat, 23 Aug 2025 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="mgQrtpUC"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5631A01BF;
	Sat, 23 Aug 2025 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755927988; cv=pass; b=FDrMYSViJ+/cIRQWMAGlX1/GOzSgBDG9zW/ZW2/RrqJRagqQYlcdnKguqhfNhKv2V9AflkkgwuO43vWAOCjIiGmqRsE8a7evvzmFOuZplKGQuYIgkhmMdSWUALw3AT1Ez2IxPqrGgeGYd8+6btsa+s2Twky2pCgmsLvSqzkO31Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755927988; c=relaxed/simple;
	bh=y/5L1LOFiJghDLEs+MG7KIK4n7AgU847WKZtPA9q7AQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TaKTuUMVBMzYdpe5BKj0QqFohDwkXWY6Hhnv51Bq1pRCkuEmTYLfLM2RLvfBd26vVQCrhYZINR9od10gYsouNP1eEI6cIw7qG9BoVHR6qY6XLb2eyyK3usaIOqAvCOMtNzuodJEYQzt38nd0b0zAwhR/Y1JAxemcy1LrZLGjPwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=mgQrtpUC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755927952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KT8b4S2x9J+pu0uPywBdy6Ou0xfDprAOneKq9nK0Y2FpiTpXCDRSNUL1dUMIF9rRRA+OlqyTyA4xPJ9pfYT+kDJEzT4I4sJWQomcnNl2h3uakOIaC+phSsGS1HJCvkF2uYOUqzS9yNCNZ7jiziEtt4QkLycrez/yhFw7ZQkOyQI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755927952; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y/5L1LOFiJghDLEs+MG7KIK4n7AgU847WKZtPA9q7AQ=; 
	b=imNy9eRiTszpTPM+0Myo+YNKTCUugI89WFqAEwTP9zA7hdvg8Q5fqlM4RWkxOX+K94wyuLusQaBdNtBAXmhj1ErBd6AW19jL/u6iy1YJpLuoBbpoahZJvFieJ/nIxe525797j88Y2PNewQWykXH56JY9VshpFNDDnHrSerJJvHw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755927952;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=y/5L1LOFiJghDLEs+MG7KIK4n7AgU847WKZtPA9q7AQ=;
	b=mgQrtpUCUPy3Zf6p2HtWBZC3OQtb3i2z2akSgnrMqOxvXLB5UWuabd/RH7mTD5d0
	Zz6OUqZ/Vwj9uDxKCuXh4hDj9BiKosWh5b8CrLXxTY4F6VacqjdM2wbct77liPir2vP
	8XZ7VC4gMKVvyrT9uLg4Ga8X65+QRltyfzURbRZjVF0HFL7ILNb+PuEObLoWZeuNZpu
	Fzs8W7tU6C48f4G9cdp9XMRvZQw6msl0pMrWdZI+i8uH9wNpx0XQCeqnYsQM6McgTvk
	AuQ6MweHBZvYN9y0dyIQulYYRuD7saMBfI/kDZvDoe/gkfVmXUHezEF5/uY1arduVHJ
	G/ZbyvQppw==
Received: by mx.zohomail.com with SMTPS id 1755927949758986.6712120663119;
	Fri, 22 Aug 2025 22:45:49 -0700 (PDT)
Message-ID: <046e10babcdd391a012d160fed35d8f4d3a42ddc.camel@icenowy.me>
Subject: Re: [PATCH 3/3] riscv: dts: thead: th1520: add soft PWM fan for
 Lichee Pi 4A
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Han Gao <rabenda.cn@gmail.com>, Yao Zi
 <ziyao@disroot.org>,  linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Sat, 23 Aug 2025 13:45:42 +0800
In-Reply-To: <aKjh6hrhrRqUvnSd@x1>
References: <20250816093209.2600355-1-uwu@icenowy.me>
	 <20250816093209.2600355-4-uwu@icenowy.me> <aKjh6hrhrRqUvnSd@x1>
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

=E5=9C=A8 2025-08-22=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 14:32 -0700=EF=BC=
=8CDrew Fustini=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Aug 16, 2025 at 05:32:09PM +0800, Icenowy Zheng wrote:
> > Because of the SoM+Dock design of Lichee Pi 4A, heat dissipation
> > does
> > not work well; fortunately it comes with a fan port with PWM
> > driving
> > capability.
> >=20
> > As the hardware PWM controller of Lichee Pi 4A isn't ready yet,
> > drive it
> > with pwm-gpio driver (software PWM) now.
> >=20
> > A long PWM period is used, because not only software PWM is used,
> > but
> > also the fan port is a 2-pin one and fast PWM might confuse the
> > BLDC
> > driver on fans.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0.../boot/dts/thead/th1520-lichee-pi-4a.dts=C2=A0=C2=A0=C2=A0 | 53
> > +++++++++++++++++++
> > =C2=A0arch/riscv/boot/dts/thead/th1520.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A02 files changed, 54 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > index 4020c727f09e8..f696db01353c5 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > @@ -4,6 +4,7 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include "th1520-lichee-module-4a.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > =C2=A0
> > =C2=A0/ {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "Sipeed Liche=
e Pi 4A";
> > @@ -28,6 +29,58 @@ aliases {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chosen {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0stdout-path =3D "serial0:115200n8";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gpio_pwm: gpio-pwm {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0#pwm-cells =3D <3>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0compatible =3D "pwm-gpio";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0gpios =3D <&gpio3 3 GPIO_ACTIVE_HIGH>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
>=20
> I think the node name needs to be 'pwm' instead of 'gpio-pwm' as
> dtbs_check
> warns that:

Sounds reasonable, although 'pwm' seems to be too generic.

But the recommended names below looks quite generic too... Is it just
some copy-pasta?

Well, maybe just take 'pwm' or 'pwm-0' now?

>=20
> gpio-pwm: $nodename:0: 'gpio-pwm' does not match '^pwm(@.*|-([0-
> 9]|[1-9][0-9]+))?$'
> from schema $id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
>=20
> Thanks,
> Drew


