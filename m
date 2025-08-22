Return-Path: <linux-kernel+bounces-782734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848E5B32480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24225BA05AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8CD338F36;
	Fri, 22 Aug 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOgDQtkT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314B20F07C;
	Fri, 22 Aug 2025 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898172; cv=none; b=X2MKt4Egub+IG1CRZm+w9NEAFSv1ezDedpHEb3D3NqyJHGiOdJoOyfnzbOefMdLMtBjXuPUg1+Rw6kAJ/DCwvKgyysVLy+Jfwuate3MckwS9Mpq0wtDgB7wcGnYBpmMN23i/x7Wjc8qi1G3p2z7OQ0WYc8M6v5kBlOUD9aU6j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898172; c=relaxed/simple;
	bh=XdRfsuCBeE2JPGsoh0xnqLu4uAHzTxPybD5NLEAdrus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFOh+WRUNFeFUnp49JxU0CtzGC8jgHz6SlRG//hvY+HxfB/0hkxl0m9ATHnzmoKInMxpI8U2fSbUp085MeuelhMT9Vnurpws2827Ew+MQW+ayV1XaN4UeKhQJJ0Rv525MDtOZviYsfXFKCBQ4yEowPpUxuX5Zvotay5gmmQM9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOgDQtkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA80C4CEED;
	Fri, 22 Aug 2025 21:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755898172;
	bh=XdRfsuCBeE2JPGsoh0xnqLu4uAHzTxPybD5NLEAdrus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOgDQtkTFuyN6OSUi4Zg7YTx3n4m4lFnUxCOO8c1PiER+3BJMUwdo9DOBrgyzC2oQ
	 nA5Df4iyKsTWLxcNNJVcUf4T5YMs9FGJ+lhcCm15tJn0TuEMrkBTpiLzvA+nF6ynKS
	 Uqmf7/i/Z9ecUybh+xHVtFs6Hedv3jevj7Wif6XOqGv6NQGsZ27EnT6xGq7n34sXEb
	 GKQHVWEHu2vFQzjnLz+jrNJSCn9NzUYDk/ZeG6Q13+GiHdvQvt8v7fKvTWs1HWiPux
	 1SOP7zlaj9wG9gVVVnI6XRnJav0Yq+cxgEgigSWfMrsC9/6YkmxuTVlFrny8ORiZvG
	 GYJxcXitlLM5w==
Date: Fri, 22 Aug 2025 14:29:30 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: dts: thead: th1520: add coefficients to the
 PVT node
Message-ID: <aKjhOuqlQyuLCVEK@x1>
References: <20250816093209.2600355-1-uwu@icenowy.me>
 <20250816093209.2600355-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816093209.2600355-2-uwu@icenowy.me>

On Sat, Aug 16, 2025 at 05:32:07PM +0800, Icenowy Zheng wrote:
> The manual of TH1520 contains a set of coefficients a little different
> to the driver default ones.
> 
> Add them to the device tree node of PVT.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 03f1d73190499..e9c81bdabed8a 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -676,6 +676,10 @@ pvt: pvt@fffff4e000 {
>  			reg-names = "common", "ts", "pd", "vm";
>  			clocks = <&aonsys_clk>;
>  			#thermal-sensor-cells = <1>;
> +			moortec,ts-coeff-g = <42740>;
> +			moortec,ts-coeff-h = <220500>;
> +			moortec,ts-coeff-j = <(-160)>;
> +			moortec,ts-coeff-cal5 = <4094>;
>  		};
>  
>  		gpio@fffff52000 {
> -- 
> 2.50.1
> 

I think moortec,ts-coeff-XXX will need to be rounded to nearest multiple
of 100 as dtbs_check warns that:

pvt@fffff4e000: moortec,ts-coeff-g: 42740 is not a multiple of 100
	from schema $id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#
pvt@fffff4e000: moortec,ts-coeff-j: -160 is not a multiple of 100
	from schema $id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#
pvt@fffff4e000: moortec,ts-coeff-g: 42740 is not a multiple of 100
	from schema $id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#
pvt@fffff4e000: moortec,ts-coeff-j: -160 is not a multiple of 100
	from schema $id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#

Thanks,
Drew

