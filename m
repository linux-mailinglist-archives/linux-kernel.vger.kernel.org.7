Return-Path: <linux-kernel+bounces-749873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1AFB15401
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2383D1899C37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A034729B8CC;
	Tue, 29 Jul 2025 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="xH6bv/Vl"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D08239E62
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819163; cv=none; b=MKKWWdhA3GQWvFy+QJZ6SJfdeS4k3EW9Bi4Sifo8F/r+bmU2Sh2VqT9w/5PBz4plM4dF00f9nU3UMmObZU8EYOM37cm4o5cWZF36uONiDwwHGCmr+vuzX0yclDboKHH662SoUsBX7hr4nuj0stYTrTkwVSp2ehkM/1l+Ab+c5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819163; c=relaxed/simple;
	bh=AxtkY3zpWxRWMeZZ93rMiHKBDA4jBLbUFfRgPxvdCHk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rOkFMNAXoVXeLL6lmzRbg0FJIDInIKcpBTOFT72e0AK+oLxwOGsLmjsc2tnfo3BATXfNwWlPbfijkBH6Cx2RdckX+wlcCZAzrLALjbUlNLuw+W+BcNlVku5gKNFS/xpu4K3lZMciKBbHe5mMnCPljU9dNEf8rK7nfBqiRcHZC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=xH6bv/Vl; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1753819157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OcthrL0Xe+fdbwJ+7ct553yzhsg4eVUVDzsOcSB6eAI=;
	b=xH6bv/Vl6xdZ1vLDAdzZn5s3YjOUgRr+1aTVe6G+zr84L6yRGGOVX8FLfWGaUOvAUNnlE8
	OkJnIsxTPLgZPwebAIBIXU7JOWLjxBeLZadQnyYcyV+Y2Vfgkp+aCcSlX7UpwqmPpScSHw
	YNl6ErX0r7qmEXJMigEFrzj+eF52Z8nbqK4AhrYbWaMXjiGQpixAa5p5AkJXzTjPk2TNKY
	3CwvGNBQZyVzE5aSpvyt8P+KqlQRTV4IXH3fqrGTUEFoluwLKK8OInxSTONR6iuXkLLqf3
	hlc1zw9l4s/WOFJWkT9fyDHI25o1uymTqosLMs6a2gIyxx6PNBl6s7qtaftYpA==
Content-Type: multipart/signed;
 boundary=2fd07b92180be8290edbe889ada7baa056994820fa28317a2cadcfeab9c7;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 29 Jul 2025 21:59:02 +0200
Message-Id: <DBOSZZ7TMD2P.U0MGKUR3DXN@cknow.org>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 4/5] arm64: dts: rockchip: Add missing dp_out port
 for RK3399 CDN-DP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Chaoyi Chen" <kernel@airkyi.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Sandy
 Huang" <hjc@rock-chips.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Yubing
 Zhang" <yubing.zhang@rock-chips.com>, "Frank Wang"
 <frank.wang@rock-chips.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Amit Sunil Dhamne"
 <amitsd@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Chaoyi Chen" <chaoyi.chen@rock-chips.com>, "Dragan Simic"
 <dsimic@manjaro.org>, "Johan Jonker" <jbx6244@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Peter Robinson"
 <pbrobinson@gmail.com>
References: <20250729090032.97-1-kernel@airkyi.com>
 <20250729090032.97-5-kernel@airkyi.com>
In-Reply-To: <20250729090032.97-5-kernel@airkyi.com>
X-Migadu-Flow: FLOW_OUT

--2fd07b92180be8290edbe889ada7baa056994820fa28317a2cadcfeab9c7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 29, 2025 at 11:00 AM CEST, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>
> Let's make the ports nodes of cdn_dp in the same style as the other
> display interface, and match the style of ports's yaml.
>
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-base.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3399-base.dtsi
> index 9d5f5b083e3c..edeb177bc433 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
> @@ -618,7 +618,11 @@ cdn_dp: dp@fec00000 {
>  		status =3D "disabled";
> =20
>  		ports {
> -			dp_in: port {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			dp_in: port@0 {
> +				reg =3D <0>;
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
> =20
> @@ -632,6 +636,12 @@ dp_in_vopl: endpoint@1 {
>  					remote-endpoint =3D <&vopl_out_dp>;
>  				};
>  			};
> +
> +			dp_out: port@1 {
> +				reg =3D <1>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +			};

Patch 5 adds a single endpoint to dp_out (without a reg property), so it
seems that #address/#size-cells is not needed?
If you run ``make CHECK_DTBS=3Dy W=3D1 rockchip/rk3399-evb-ind.dtb`` it
should spit out a warning about that.

Cheers,
  Diederik

>  		};
>  	};
> =20


--2fd07b92180be8290edbe889ada7baa056994820fa28317a2cadcfeab9c7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaIkoCgAKCRDXblvOeH7b
brfGAP91vbmzqtSHHq487babaTkFfCZ5yunCKjR4z8ny048RbAEAionq5YOmCJoU
pi+lTvFwVYBJkyoMcr/Yv7tpfvlC2w0=
=ePLo
-----END PGP SIGNATURE-----

--2fd07b92180be8290edbe889ada7baa056994820fa28317a2cadcfeab9c7--

