Return-Path: <linux-kernel+bounces-868058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E4C0441C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2B4EB0D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20426F462;
	Fri, 24 Oct 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCmyaho3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62526CE0A;
	Fri, 24 Oct 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276599; cv=none; b=fmfYKZu9iOcUK6ZqUDxf491pHH/SE8So22UmpT8Ir/NzFpWrQedDn6pVg/TDOSoEyC1h9heSyg2ghWWjkTxDhDrW7kWHRCtlLHk7PVGJxPp2KdCidTdbSO+6Hd29WeTYartJ2jSwFAy0H5wJSYnyyhV+5Ub6hh9OAWbBhLa/q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276599; c=relaxed/simple;
	bh=dw7PBOXGc2HtIYPfqP+CIdoC2IoORW63uomW2/Jytr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R5zeN5BHWxCLuD6YqNU93WKhYmfR8tf0J0iekefb3ho+YsOVfVJTbqeEZz9aTpc+Q257pSvr7UxHwoLiEsn8hJXJT675fB/O2vpcMvYz6AamYXnRXvHKU/xsq69NNhFcXINmdXwsvJDy5f75KO6h2KR/PVYXxvhSJM4ln8KtH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCmyaho3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F747C4CEE7;
	Fri, 24 Oct 2025 03:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761276599;
	bh=dw7PBOXGc2HtIYPfqP+CIdoC2IoORW63uomW2/Jytr8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MCmyaho3k96GhAPpIRBE6c0xNy/NGPRGrQd2pLm2dS8LSE6RfoT7bbH4e5jzxKNaL
	 2KFyTcomib/ZoXRZrC7Ok0OQ6BZG8AjhEc/oLEgp1EtiNZ1GsCWgdiazVieo10KZbw
	 1yVK50xJarxPq4mCgDFyB9V4ebNB29V87VLuO3iacJx/ZeiNLluuIPu61lepT9t3kw
	 UhwgD0J/tXf9ptemutUGEOUVANVW7SA5RpLskPllk0KOywDhcxTGePAkXwUOQALzwq
	 w1U9h3pmkuUu8XfTLpZMibFPrAJLh9giAOHrKfnHivUBEQul6CnLoAryqgTr1s4Ss5
	 ufrYSQrxDw/SA==
Message-ID: <a1e9afd0-b977-42c8-88cb-e82ea89dedaf@kernel.org>
Date: Thu, 23 Oct 2025 22:29:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm64: dts: socfpga: agilex5: add VGIC maintenance
 interrupt
To: niravkumar.l.rabara@intel.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, nirav.rabara@altera.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250311033601.1940199-1-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250311033601.1940199-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/25 22:36, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add VGIC maintenance interrupt and interrupt-parent property for
> interrupt controller, required to run Linux in virtualized environment.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 51c6e19e40b8..75397e84bd2c 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -75,8 +75,11 @@ intc: interrupt-controller@1d000000 {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		interrupt-controller;
> +		interrupt-parent = <&intc>;
>   		#redistributor-regions = <1>;
>   		redistributor-stride = <0x0 0x20000>;
> +		/* VGIC maintenance interrupt */
> +		interrupts = <GIC_PPI 25 IRQ_TYPE_LEVEL_HIGH>;
>   
>   		its: msi-controller@1d040000 {
>   			compatible = "arm,gic-v3-its";

Applied!

Thanks,
Dinh


