Return-Path: <linux-kernel+bounces-779012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BAFB2EDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC145A0503A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30928642E;
	Thu, 21 Aug 2025 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="vXAGdynY"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908120330;
	Thu, 21 Aug 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756396; cv=none; b=R+FL+6loEoMAKrZPz7sWcpo5syQC3CS3s0OvXu0umTrpZAFvbDG1UsRBuVSgjTqWTZIUhpP3jxk5OJcjm53bSH03qSCh4RT5T3tbaes9rjv3e+0IUsVGrs/aDtgkPGUNO2ExSvSd50k7/5Uz8WNsOx0H647uIxnauxt6a2dQceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756396; c=relaxed/simple;
	bh=dm3k7OO2F5a6ZxEZX6fQ0JkPscb6j/xn6v9kNebGVFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPFAzgAKTBwDc9hPX55K/J50Oh7aDFSk4m88SWf9lcMAknims6tnZ4luIWu9u18FCJkd7Lh5BBgd3qYuPAjuVPHDKpAlFaOHFv8emV4awZ1yCKE9n1fKLB6H1i7n/w8dnsI/9BDFDEyAi5lpr5Z9Mtpgu3djiMp+YRSBUaJvTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=vXAGdynY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 693211F99A;
	Thu, 21 Aug 2025 08:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1755756391;
	bh=5LeyRtpyuW55yhWUN6UCJJFNU3yjTx94Q5pC/9mD8Go=; h=From:To:Subject;
	b=vXAGdynY/VP5F5OmYQXNvMje6hhApmzcNLSY6ngtZvjmSghuVWQuTQuLEA05pZrnf
	 Aj5zKNypjtmuDmKMhRpX6nPW3UuE2yqAQIAidK+6HtPXXU0yr0wEqsWWswnDv3Cqu9
	 +tqwYExKHQIGm1B84+tmJB5d47VAi/yEismZ+DsItrvmQtW9FcHGGOJAU3fESkxk5o
	 syxsvbU8TBiyckoHiBC5EO0oute5VSzeD2sX4mDi8URj0rAdL+WHUyUu/K6MSUlUkP
	 8tRQeK/40xZso/EwYmU6RbNWo8M6sUIe+ZMVLDU5467qXp8JzlB5yVCkI1PFNrJdeK
	 9uBdICyocm6Sg==
Date: Thu, 21 Aug 2025 08:06:29 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com,
	u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Subject: Re: [PATCH 16/33] arm64: dts: ti: k3-am62p-verdin: Add missing cfg
 for TI IPC Firmware
Message-ID: <20250821060629.GB7503@francesco-nb>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-17-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814223839.3256046-17-b-padhi@ti.com>

On Fri, Aug 15, 2025 at 04:08:22AM +0530, Beleswar Padhi wrote:
> The wkup_r5fss0_core0_memory_region is used to store the text/data
> sections of the Device Manager (DM) firmware itself and is necessary for
> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> for allocating the Virtio buffers needed for IPC with the DM core which
> could be optional. The labels were incorrectly used in the
> k3-am62p-verdin.dtsi file. Correct the firmware memory region label.
> 
> Currently, only mailbox node is enabled with FIFO assignment. However,
> there are no users of the enabled mailboxes. Add the missing carveouts
> for WKUP and MCU R5F remote processors, and enable those by associating
> to the above carveout and mailboxes. This config aligns with other AM62P
> boards and can be refactored out later.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Cc: Parth Pancholi <parth.pancholi@toradex.com>
> Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
> Requesting for a review/test.
> 
>  arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 42 ++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> index 6a04b370d149..0687debf3bbb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> @@ -162,7 +162,25 @@ secure_ddr: optee@9e800000 {
>  			no-map;
>  		};
>  
> -		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
> +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {

Node name should be generic, `memory@9b900000` ?

this applies in multiple patches in this series


> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b900000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
>  			compatible = "shared-dma-pool";
>  			reg = <0x00 0x9c900000 0x00 0x01e00000>;
>  			no-map;
> @@ -848,6 +866,28 @@ mbox_mcu_r5_0: mbox-mcu-r5-0 {
>  	};
>  };
>  
> +&wkup_r5fss0 {
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> +			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
> +};
> +
> +&mcu_r5fss0 {
> +	status = "okay";
> +};
> +
> +&mcu_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
> +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +			<&mcu_r5fss0_core0_memory_region>;
> +	status = "okay";
> +};
> +
>  &main0_alert {
>  	temperature = <95000>;
>  };
> -- 
> 2.34.1
> 

