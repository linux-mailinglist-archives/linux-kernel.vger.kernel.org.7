Return-Path: <linux-kernel+bounces-885682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B0C33ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4C23B15BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F972147E5;
	Wed,  5 Nov 2025 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JDt5jey8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D111CA0;
	Wed,  5 Nov 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306363; cv=pass; b=mbfTpfTzOyIHQKjx+V5JN/J8a/e/k3Xo2eirgUkEhROtHFBUlWNoqAgJNUcjwwUHmbxfi88mU5TTV32Gtb8V2U4SZKUXhzGEab4uhV2tzLRKvJAyJPx0FDXRRnXeD4h1Pqf38wLjgRGgIWpZ4Y1IEljC7U1/qyiIMy01kh1gcBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306363; c=relaxed/simple;
	bh=cWNp6TU3/FPOztph4HqEi05jEKxvSMDQt+Vsw4CPS/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnaxuQrSJeWW7Klh7QRf3HHjvLTixt1Lit6jV+L+/e8hgnyw7cz4czHoQysAJmXcjfqMkq7xXo8pY3dkTzBRubrA/2VTpbEYnEGQoFM0g4roSU6u9P7lt2si7nIG6HALSVe3sPvfdtO2O21jxAWnLD3rwZpNgxT4ubmmRqoABEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JDt5jey8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762306343; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M8QTzl9KNZlXmjR3YMDovKOYchplT1lIc6GV8squykdhQsXUNyo1r8JwfRWbianIrcvoX6B+KJJrw4I85rD9Nl1Af7geebnPhiUdMqbdY7ORCKVo0+ui45EsCQrEStvRd2UTG9FuAAcHXmMrVKlAgyLFQgg3CbBNfuUN5XdLYE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762306343; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KpI087FtIxYg7DySMe2xZlGjptQaVJmuv7g4F0pvfNs=; 
	b=VAxI/o3zqc8z7ATovB9IoJZVyXGZYxodLmPO6Y3lp6gVEtRWxca0oD8/DI1jNYaI8njExT9ssdE05MHPOl9GwCIf3OdhioFDm9XpwuDAGRUs7wbRste+WvMcZ9w0X0lzz4/qeE2F2Vl9B+TWhv4SdqaF4+mEGLLW0JO6VN2lOTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762306343;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=KpI087FtIxYg7DySMe2xZlGjptQaVJmuv7g4F0pvfNs=;
	b=JDt5jey8SvN8si02kdmL+oa14yTKsRgWMZ3GH3W2MxskumPE21Z/FucNUD4qsQ2Q
	zRQ8/0y+mBgEPrQXbqFynkKqaz8s4p9MkPuy9BRxaOKXwCR4LL8nrSU8qb6X2z5kkVi
	UyiuLrzM3fxMhzsZdFpYvIk2wm+ssq4MCqycQkHk=
Received: by mx.zohomail.com with SMTPS id 176230634046419.149111498046977;
	Tue, 4 Nov 2025 17:32:20 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 51B7C182F6F; Wed, 05 Nov 2025 02:32:07 +0100 (CET)
Date: Wed, 5 Nov 2025 02:32:07 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	michael.riesch@collabora.com
Subject: Re: [PATCH 1/2] clk: rockchip: rk3568: Drop CLK_NR_CLKS usage
Message-ID: <x7xja6v2ssq3mesj3bnuzsz522tew4lobbn5ftcgfrusdnabjm@rd47kgjdnoz4>
References: <20251103234032.413563-1-heiko@sntech.de>
 <20251103234032.413563-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6bmfeioxjbjj4jf2"
Content-Disposition: inline
In-Reply-To: <20251103234032.413563-2-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/262.252.53
X-ZohoMailClient: External


--6bmfeioxjbjj4jf2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] clk: rockchip: rk3568: Drop CLK_NR_CLKS usage
MIME-Version: 1.0

Hi,

On Tue, Nov 04, 2025 at 12:40:31AM +0100, Heiko Stuebner wrote:
> In order to get rid of CLK_NR_CLKS and be able to drop it from the
> bindings, use rockchip_clk_find_max_clk_id helper to find the highest
> clock id.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/clk/rockchip/clk-rk3568.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk=
-rk3568.c
> index 97d279399ae8..74eabf9b2ae2 100644
> --- a/drivers/clk/rockchip/clk-rk3568.c
> +++ b/drivers/clk/rockchip/clk-rk3568.c
> @@ -1652,6 +1652,7 @@ CLK_OF_DECLARE(rk3568_cru_pmu, "rockchip,rk3568-pmu=
cru", rk3568_pmu_clk_init);
>  static void __init rk3568_clk_init(struct device_node *np)
>  {
>  	struct rockchip_clk_provider *ctx;
> +	unsigned long clk_nr_clks;
>  	void __iomem *reg_base;
> =20
>  	reg_base =3D of_iomap(np, 0);
> @@ -1660,7 +1661,9 @@ static void __init rk3568_clk_init(struct device_no=
de *np)
>  		return;
>  	}
> =20
> -	ctx =3D rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
> +	clk_nr_clks =3D rockchip_clk_find_max_clk_id(rk3568_clk_branches,
> +						   ARRAY_SIZE(rk3568_clk_branches)) + 1;
> +	ctx =3D rockchip_clk_init(np, reg_base, clk_nr_clks);
>  	if (IS_ERR(ctx)) {
>  		pr_err("%s: rockchip clk init failed\n", __func__);
>  		iounmap(reg_base);
> --=20
> 2.47.2
>=20
>=20

--6bmfeioxjbjj4jf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkKqRMACgkQ2O7X88g7
+ppKnA/4pNi7YhTXOsHnSmYUks9GbObvEULNO2W/tb0LY0/gy2kOMYLUBAYOykI5
hlWa8M4urf04qDi+xrtaaTGj6YggGQiEMh2vbUsLv00rbD6WYSdf2gLuqYfLw/Rd
5L0OBKzsOFYWVc0nGZtwmSfjtq0cSf7GBVXaLCPsOoI2d9K67ocVGKCxBYBKbQzu
J0SK/4DCS6ee8N/k1ERLNZHdSvSlYCwRPuhDxIj0FP61I+t7k+zd3u8wJBDKlVvy
lzy+qIXLvrPXDyErQgRDsbjKESLfp2U3WZLlYn1o779PWDty+x1wuiUePPmDSI3C
TLdDj23gOBicQzKtRJ/229yLe5eo8H4xs5Dgei8JDrmKZm0ochU7z4NVFozePUma
+rNXmqrURdm7p8PDaP4PLRNfjfqDV7mucxgy8FrlsMDPinJCKhZ8b9eMU8UG1GJI
Jn6zGDvcidwWuz+/QHqWdhRhZbqTHwjDyJ4NhHBO5uk40GJwu6u00hE3JOsWeAiv
KJV7tCV8NkzzF4EaW8OgJiKqWqV+uOfkLhnA+GZu7ggs7F8YS64nvRKAfOW0mxqB
UlPbb2DABRMxUx76MHHPaDriUjvk6W0lm43H6UaltohYCXrjhZbiUyzAxP5HCkx5
mm5Hkv4qY/FQjUbHVTlM+Ug22PRuN82sCHXh5aD3xvHQoav5AQ==
=C3fB
-----END PGP SIGNATURE-----

--6bmfeioxjbjj4jf2--

