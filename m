Return-Path: <linux-kernel+bounces-886514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9668BC35CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 582AB4E76D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F431A803;
	Wed,  5 Nov 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="aa6b5568"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C431812E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348719; cv=none; b=gxdWqT3u5d+0BUkKvL6dBOa6xObWrBk2WNCF3xj/w5gVq/k8Gbu108+FULsNzUKr990pL6rZn2kWnBawAK8F35gvCXxMg1RD1LxcXgz81qo2GpfwNLntogzZseRaeoA41j5Tr0QPyCvpB4FELRdNZ9aioyF74+6RbbdalVqeozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348719; c=relaxed/simple;
	bh=wl4aysANLOfX0B50JiWajRXky1BkXyekiwA8JCZUlIY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=juNgjs8tPoJMFg+8a2qNOxM0MJ3Vtk4vKYBqPwH8W53wOT9zWKEXZYJxkJxslTLsjSrRvGpYY8/HE0r9z8GSZl5g+Kuzd6ZLWssrg4UkXMOku8bKS/yYNgCnWWIXSKk3rqsZVuQodJtLMIN0jrcVDNdxScVEb1GH5RFkKaM+otA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=aa6b5568; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762348704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anJy0kovOnmwnKwTf1uVV5HwRBu0s+Xw6msJvdrAWkM=;
	b=aa6b5568Qh3/bE4wzKB/hpYPvmdW4nlyMx41tGjnmZuoU64FMmoh4cXl1BRU5DJ6tuo+nI
	3HSYeLTC7A200JHb4jozfS3Q0HgGytOBgeky7yw/BxPCMnlkdGUMCr+Xooh2VOJaWNvruP
	BbBMVUyM3OUs1s+qs+7rdLcCskHKQe7q47xlfLhSUdGa4V0LtZvnYUjzOa+HAbeokkQGPq
	Xe5gFcTNi0N3+crmQfPC192PhyQd03iDeVnEwTxdEwVRH2R2MCNzUfbPSO3XYuzSqXY4+i
	IWJzneP/ljxJaSA6odMvzs1zM5cn/jb+7sYU87vOWDBcBTGBP/ObrAsTfnVg3g==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 14:18:21 +0100
Message-Id: <DE0SH4UBVXBH.77ADEH3224GK@cknow-tech.com>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <michael.riesch@collabora.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add missing clocks for cpu
 cores on rk356x
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Heiko Stuebner" <heiko@sntech.de>
References: <20251103234926.416137-1-heiko@sntech.de>
 <20251103234926.416137-4-heiko@sntech.de>
In-Reply-To: <20251103234926.416137-4-heiko@sntech.de>
X-Migadu-Flow: FLOW_OUT

On Tue Nov 4, 2025 at 12:49 AM CET, Heiko Stuebner wrote:
> All cpu cores are supplied by the same clock, but all except the first
> core are missing that clocks reference - add the missing ones.

I noticed it myself some time ago (but failed to sent a patch), so

Reviewed-by: Diederik de Haas <diederik@cknow-tech.com>

Cheers,
  Diederik

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk356x-base.dtsi
> index d0c76401b45e..a1815f8a96e1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -69,6 +69,7 @@ cpu1: cpu@100 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a55";
>  			reg =3D <0x0 0x100>;
> +			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
>  			i-cache-size =3D <0x8000>;
> @@ -84,6 +85,7 @@ cpu2: cpu@200 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a55";
>  			reg =3D <0x0 0x200>;
> +			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
>  			i-cache-size =3D <0x8000>;
> @@ -99,6 +101,7 @@ cpu3: cpu@300 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a55";
>  			reg =3D <0x0 0x300>;
> +			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
>  			i-cache-size =3D <0x8000>;


