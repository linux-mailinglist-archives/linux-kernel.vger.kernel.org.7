Return-Path: <linux-kernel+bounces-887504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8400C38649
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C5E3B1B2E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCA02F6597;
	Wed,  5 Nov 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cfli0nwc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85D2F5A06;
	Wed,  5 Nov 2025 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386217; cv=none; b=ttQqMeRyxxsoOuuKvKII+4SCLC266hiN6M51jjwFdmvwbd23bXNWxf2lsCaixtIiM7aSpPvFsNeV13AfoYSjgED4mN6FGvY0Pc94aF8RJ0vtpYNKQTqqExjMVQyf+nj/1mD0LLcfWX62NwbT1E118gW4brpiyWMZOgIPVpCuhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386217; c=relaxed/simple;
	bh=X5LSadPdbxiYrUIw1dL7CsFHmVdyRdU/x3HkzDa/SmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaR8UnE/aO0m8SnD1kD1pBwxDFTMexIHdnsfQAV4/WkW794LyzmTA2tpi5Z34fjbpz8y+nyyHt5hyGQ/yHf2xgZqgIiOZE9mDzr9hdPvl6wNqBl/vsnDFe+0HVv6RJsvbPTFGt2VD6rtfG3tOud6fkEVL0fT5EuMT/DOT3LI/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cfli0nwc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=vqGD0QYI7TiTsk6Wh+7QyORQeVGQ1Q1viVMxjGD/NsM=; b=cfli0nwcgYEtYaOCBzK2Fuw+we
	hezAoitjvDzh6bFK9jUW/nj2qqVYaDTVNY1sOs/SOeFcH8JhQjbA7aZrby9THQVAGI+C0JlQNOvce
	h4g3Sz7OcY/x78yJxDFeZ8pt1BLLt0MVb1A9TOGWFjkZ6xDSqAkIBfO9nrPuKKCeg4ZTFn8CwvoFG
	MpD0mgzYOAsLqnW7yWE2ZRq4hr8EWFp3uomyB+EvGHHlTu0S1QWMg8dgAex5Rcqp7Nm/ymvtTFlGU
	Q+eGzHOpp+CmMTSrrmsvX2vppJoJfUriPDuzid+V3hs3kZv/2QV1bFN+rt2LskszVrOdW/ymSePrd
	kAHdXf8w==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGn9z-0001MR-L9; Thu, 06 Nov 2025 00:43:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, michael.riesch@collabora.com
Subject:
 Re: [PATCH 2/3] arm64: dts: rockchip: use SCMI clock id for cpu clock on
 rk356x
Date: Thu, 06 Nov 2025 00:43:26 +0100
Message-ID: <5996423.DvuYhMxLoT@phil>
In-Reply-To: <DE0SFV203UMS.1ZV2JE6QEPN29@cknow-tech.com>
References:
 <20251103234926.416137-1-heiko@sntech.de>
 <20251103234926.416137-3-heiko@sntech.de>
 <DE0SFV203UMS.1ZV2JE6QEPN29@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 5. November 2025, 14:16:42 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Diederik de Haas:
> Hi Heiko,
>=20
> On Tue Nov 4, 2025 at 12:49 AM CET, Heiko Stuebner wrote:
> > Instead of hard-coding 0, use the more descriptive ID from the binding
> > to reference the SCMI clock for the cpu on rk356x.
>=20
> Any particular reason you only did it for the cpu, but not the gpu?

Didn't think of if at the time :-) .

Will prepare another one for the GPU.


Heiko

>=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64=
/boot/dts/rockchip/rk356x-base.dtsi
> > index a3361527d4fe..d0c76401b45e 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> > @@ -53,7 +53,7 @@ cpu0: cpu@0 {
> >  			device_type =3D "cpu";
> >  			compatible =3D "arm,cortex-a55";
> >  			reg =3D <0x0 0x0>;
> > -			clocks =3D <&scmi_clk 0>;
> > +			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
>=20
> Regardless of the above comment, feel free to add
>=20
> Reviewed-by: Diederik de Haas <diederik@cknow-tech.com>
>=20
> Cheers,
>   Diederik
>=20
> >  			#cooling-cells =3D <2>;
> >  			enable-method =3D "psci";
> >  			i-cache-size =3D <0x8000>;
>=20
>=20





