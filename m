Return-Path: <linux-kernel+bounces-819848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20CCB7C86F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45D2483BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519321D59C;
	Wed, 17 Sep 2025 01:29:48 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82059214A79;
	Wed, 17 Sep 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072588; cv=none; b=usR5U7fJ277DC5AhMLStqtiuUpt/lGdSd9MQMU5isHaIJ2cKlrEc7s1skFWK5l77WWbm/WcuCXa3Qts8B8rOVLUngjdJSMRCqUUlpa2SFmwSugBeFC6rm6sWyV2E1aX8fPwsDIIROU3ZfbrHEN6/7PeQfYGb9V8koDQcJZPfKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072588; c=relaxed/simple;
	bh=hhZVsw3zt3A/oYqZ99Gjxd13hAnEOnscKFd/+BWn5Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGsxPH/1pwf41HSLIhJeP8MWEFPYrbP5gMg3O07pwTnSoF5K0WADYVHZx73s5toLVekhCRA9iOKfnrSvxWIwGwFEJbeUTnQVBYLC5UiSFI9m0CELnw19DfOJcDPypjxta2Ev5aVcduKg4vhfQdqkOaqZPLUbsac2yPyKGAanhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 71C89340EF8;
	Wed, 17 Sep 2025 01:29:45 +0000 (UTC)
Date: Wed, 17 Sep 2025 09:29:41 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: dts: spacemit: add UART pinctrl combinations
Message-ID: <20250917012941-GYA1263349@gentoo.org>
References: <20250916064739.196695-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916064739.196695-1-hendrik.hamerlinck@hammernet.be>

Hi Hendrik,

On 08:47 Tue 16 Sep     , Hendrik Hamerlinck wrote:
> Add UART pinctrl configurations based on the SoC datasheet and the
> downstream Bianbu Linux tree. The drive strength values were taken from
> the downstream implementation, which uses medium drive strength.
> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> hardware flow control conditionally.
> 
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> ---
> Changes in v3:
> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
> 
> Changes in v2:
> - Split cts/rts into separate pinctrl configs as suggested
> - Removed options from board DTS files to keep them cleaner
> ---
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 432 ++++++++++++++++++-
>  1 file changed, 429 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> index 381055737422..7811fb485bd4 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -11,12 +11,438 @@
>  #define K1_GPIO(x)	(x / 32) (x % 32)
>  
>  &pinctrl {
> +	/omit-if-no-ref/
> +	uart0_0_cfg: uart0-0-cfg {
> +		uart0-0-pins {
> +			pinmux = <K1_PADCONF(104, 3)>,	/* uart0_txd */
> +				 <K1_PADCONF(105, 3)>;	/* uart0_rxd */
> +			power-source = <3300>;
> +			bias-pull-up;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart0_1_cfg: uart0-1-cfg {
> +		uart0-1-pins {
> +			pinmux = <K1_PADCONF(108, 1)>,	/* uart0_txd */
> +				 <K1_PADCONF(80, 3)>;	/* uart0_rxd */
> +			power-source = <3300>;
..
> +			bias-pull-up;
here, see comment below
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
>  	uart0_2_cfg: uart0-2-cfg {
>  		uart0-2-pins {
> -			pinmux = <K1_PADCONF(68, 2)>,
> -				 <K1_PADCONF(69, 2)>;
> +			pinmux = <K1_PADCONF(68, 2)>,	/* uart0_txd */
> +				 <K1_PADCONF(69, 2)>;	/* uart0_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
>  
> -			bias-pull-up = <0>;

Sorry, I've overlooked this, the bias-pull-up need to explicitly set to
a vale of 0, 1 - normal pull up, or strong pull up.. for uart, the normal
pull up should be ok

please refer Documentation/devicetree/bindings/pinctrl/spacemit,k1-pinctrl.yaml

Since the rc6 is already tagged, I'm about to prepare a PR, so If you able 
to respin a new version quickly, I'd be happy to take, otherwise let's wait
for next merge window (which shouldn't be a big problem)

btw, please always do a DT check: 
  make ARCH=riscv dtbs_check W=1

-- 
Yixun Lan (dlan)

