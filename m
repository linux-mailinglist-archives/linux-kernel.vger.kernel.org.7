Return-Path: <linux-kernel+bounces-890292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC3C3FBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316EA1883208
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5CC321420;
	Fri,  7 Nov 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="j/YUeIQc"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DC2C9D;
	Fri,  7 Nov 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514700; cv=none; b=m0aBdyDBSorbxCxk6Zo5Y7nNiz3f98Z2vnFyEAcYPBlvDNxNzSuc+iQvtfG5QVBcQjxyyaOOvjNv9JFN08WiPqTrKRTB3TxWNX83w33XC1Fu1ADu+o8NQLsJcJwhmWm8wfMEXFf2R97lB5CoGShAXKFvyzY9icnHfyxYYeoRUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514700; c=relaxed/simple;
	bh=ANs81aV/Ae12SW8xZAtD4FqwsvXxe9WMx3g7ou7OpUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mar5mrG6m7j6HtI1LMp4wowUciy2XCeTDHjJMvE+cBMiKtAvzKNDbQ9LcY8XUMUZhxz+HpkbjVO77xPAK/6pavpUR7lE5uwhIHBoXKXnu5nsfvVHyXZet0aKcOUTrw9M3ABkT0wsyvAiN3jKPL0qzPb9SB+9QYNxPJMEFCsUM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=j/YUeIQc; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1762514669;
	bh=HGs0/L8ncOabUNWXYKXnKsQ79vn23oo0qvYbvXQ7sWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j/YUeIQcHC8otLzqCl7XpD3lZAAcXH6zlMPgZl66YW+pPG648ixllD55b1yBs5jby
	 venUESrF5aERiu2flcb/HktBi7fP3KD5YMLfjJc8qkyUHEAtDJS02U0RdV0ThSh1Fo
	 5nL5lZht2VJuw/+8TeV+s6keLu1wciw09H/r8obnh2NZC8v58C66BQyLFjbpgD/J/m
	 oB5mFvqsgqZs/2T97iGSasVF77dhqPiBpgLPZfo+teiJNHNF1qxEDIBbdsKwPDe8Ez
	 bStr0/iUkeVznjhNx/pf2JCLh4NZuUs6SG84Q3N/0uhH0babn2t7fHFVirAEqTQ0Tt
	 PTw/APnqFGJ2A==
Received: from [192.168.2.54] (unknown [98.97.27.87])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id E2640B2201EE;
	Fri,  7 Nov 2025 12:24:25 +0100 (CET)
Message-ID: <5b7c7ecc-38db-483b-87fc-4199a8bd52c3@freeshell.de>
Date: Fri, 7 Nov 2025 03:24:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] riscv: dts: starfive: jh711x-common: Move out some
 nodes to jh7110 common dtsi
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <20251107095530.114775-6-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251107095530.114775-6-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 01:55, Hal Feng wrote:
> Some nodes in this file are not used by the upcoming VisionFive 2 Lite
> board. Move them to the jh7110 common dtsi to prepare for adding the
> new VisionFive 2 Lite device tree.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 14 ++++++++++++++
>  arch/riscv/boot/dts/starfive/jh711x-common.dtsi |  8 --------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index dd5805ef70a1..cdc362b8d58b 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -25,3 +25,17 @@ opp-1500000000 {
>  		opp-microvolt = <1040000>;
>  	};
>  };
> +
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};
> +
> +&mmc1 {
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh711x-common.dtsi b/arch/riscv/boot/dts/starfive/jh711x-common.dtsi
> index 809274625615..42b8f60725fb 100644
> --- a/arch/riscv/boot/dts/starfive/jh711x-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh711x-common.dtsi
> @@ -281,14 +281,8 @@ &mmc0 {
>  	assigned-clock-rates = <50000000>;
>  	bus-width = <8>;
>  	bootph-pre-ram;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	cap-mmc-hw-reset;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> -	vmmc-supply = <&vcc_3v3>;
> -	vqmmc-supply = <&emmc_vdd>;
>  	status = "okay";
>  };
>  
> @@ -298,8 +292,6 @@ &mmc1 {
>  	assigned-clock-rates = <50000000>;
>  	bus-width = <4>;
>  	bootph-pre-ram;
> -	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> -	disable-wp;
>  	cap-sd-highspeed;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;

Reviewed-by: E Shattow <e@freeshell.de>

