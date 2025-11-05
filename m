Return-Path: <linux-kernel+bounces-886512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCBC35CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BE61A21942
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6484315D50;
	Wed,  5 Nov 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="nuFi3+XJ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ECC315D53
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348609; cv=none; b=ZdLM8IB113Dhkx8aXHdh9H8Nw2kkFbVWeDF4Rndxg7rLQHcjOzkevOqMGh6M8aSIyzROwKsh9LVip2OpZpsFddTz6UpcUdsi/WrOgXiH89vcm9JCgSkVnd4H7ugZeuUrcvd2ysGUa2vMaSBh57e1DHwiBHiPqx+JG2GIXYrim/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348609; c=relaxed/simple;
	bh=fUTwJNDHUgzPs1TItc0+dwsS8UK7KycrT4JxNbiktpg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=uyzWI2rLb0KOkASR/xZS8WccX7i5bcoICEuR76byWqRquYhgAZ79QKEOAaAmMA+mQQMQwZe33kr+wfa9QPQ+52eheVfz1leeoddWqBYKApbxzyug58By28x3z9FYxAnpy4e+73yDLWFik9WWlGoGCDM4uZYUO1NuRB593sYioZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=nuFi3+XJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762348604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06qBPm1fhFSKR8WuXfgSJkBHchOvYaGI3r+Tq1ruRHM=;
	b=nuFi3+XJIUC4IMIZbpTNvnro4Irl5tYMnQEv6fg/Kkvl/IljVEvTDKotl6REwLqxDISxs1
	jThgRGnSFy2QBbD3kavo6bUiH81wPE88IxmoVUcgZFaqwcJLuolnq0lVd9iUCAbB9WtBZJ
	DXX7B1rwDawDtBkYA6jbdjAFiuSeJaLipBy5O2IdmxEimmOSL2m/teOlY/62usQ0UKCA72
	YkJeImAlO5eo6SX7oI+p+l20fKbwhNW8ixTRCMvu3x/THQH8TppAJ4pAC9gO8W/4fDyLSb
	ORun7XhsHZ7QsaF72kfVFoe81YBN2F09k+BeOKzG5qgJotzcvXV4PRBCVeQZOQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 14:16:42 +0100
Message-Id: <DE0SFV203UMS.1ZV2JE6QEPN29@cknow-tech.com>
To: "Heiko Stuebner" <heiko@sntech.de>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <michael.riesch@collabora.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: use SCMI clock id for cpu
 clock on rk356x
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
References: <20251103234926.416137-1-heiko@sntech.de>
 <20251103234926.416137-3-heiko@sntech.de>
In-Reply-To: <20251103234926.416137-3-heiko@sntech.de>
X-Migadu-Flow: FLOW_OUT

Hi Heiko,

On Tue Nov 4, 2025 at 12:49 AM CET, Heiko Stuebner wrote:
> Instead of hard-coding 0, use the more descriptive ID from the binding
> to reference the SCMI clock for the cpu on rk356x.

Any particular reason you only did it for the cpu, but not the gpu?

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk356x-base.dtsi
> index a3361527d4fe..d0c76401b45e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -53,7 +53,7 @@ cpu0: cpu@0 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a55";
>  			reg =3D <0x0 0x0>;
> -			clocks =3D <&scmi_clk 0>;
> +			clocks =3D <&scmi_clk SCMI_CLK_CPU>;

Regardless of the above comment, feel free to add

Reviewed-by: Diederik de Haas <diederik@cknow-tech.com>

Cheers,
  Diederik

>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
>  			i-cache-size =3D <0x8000>;


