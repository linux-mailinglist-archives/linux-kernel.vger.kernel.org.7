Return-Path: <linux-kernel+bounces-816869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14968B579A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29709189CA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACF3054FA;
	Mon, 15 Sep 2025 12:00:47 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65530505F;
	Mon, 15 Sep 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937646; cv=none; b=b6CEHKe/ZMuaq5cPznE5sp8jfh/52pJPDRX4A8vPTQwpGdJc4QbxJffxalRklYSA1DgTiIvtUFL2dgdDfFDd7CccHuhrGGMdI6y0kNT3A+slh7QHKV5o0Hh2YPZ7Ot0ZYNhB7hCA3rxWJreKMCFGD/FbpQiVz6rPNl2SdtdZwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937646; c=relaxed/simple;
	bh=YmQSaeS3oa78hAqZRlr9GX5sXtTS72xKUCDUCMaOA0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA2R3u3DS4jyD8t/ProduERve/Nf0x4FRBVhjsCA/N8HPflP7aDSSHWE7M9N/mdv8XnogLb2nusQHRucIrzQ4bCHrFNiMfk+VQqSST+gzazbyN1g5zTGkDbuWbMuvXbnOpp59qbvi+QKq0XRyq7UZo0CX8w99iO8Y/NkJhGWQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 91C7F340F3A;
	Mon, 15 Sep 2025 12:00:43 +0000 (UTC)
Date: Mon, 15 Sep 2025 20:00:31 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: spacemit: add UART pinctrl combinations
Message-ID: <20250915120031-GYA1251948@gentoo.org>
References: <20250915112845.58134-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915112845.58134-1-hendrik.hamerlinck@hammernet.be>

Hi Hendrik,

On 13:28 Mon 15 Sep     , Hendrik Hamerlinck wrote:
> Add UART pinctrl configurations based on the SoC datasheet and the
> downstream Bianbu Linux tree. The drive strength values were taken from
> the downstream implementation, which uses medium drive strength.
> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> hardware flow control conditionally.
> 
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> ---
> Changes in v2:
> - Split cts/rts into separate pinctrl configs as suggested
> - Removed options from board DTS files to keep them cleaner
> ---
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 389 ++++++++++++++++++-
>  1 file changed, 386 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> index 381055737422..8f87f8baaf77 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -11,12 +11,395 @@
>  #define K1_GPIO(x)	(x / 32) (x % 32)
>  
>  &pinctrl {
Generally I'm good with this version, only have one minor comment

How about adding a "/omit-if-no-ref/" before each pin cfg?
This will shrink the final blob size if no referece to the node

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
> +	uart0_1_cfg: uart0-1-cfg {
> +		uart0-1-pins {
> +			pinmux = <K1_PADCONF(108, 1)>,	/* uart0_txd */
> +				 <K1_PADCONF(80, 3)>;	/* uart0_rxd */
> +			power-source = <3300>;
> +			bias-pull-up;
> +			drive-strength = <19>;
> +		};
> +	};
> +
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
> +	uart2_0_cfg: uart2-0-cfg {
> +		uart2-0-pins {
> +			pinmux = <K1_PADCONF(21, 1)>,	/* uart2_txd */
> +				 <K1_PADCONF(22, 1)>;	/* uart2_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart2_0_cts_rts_cfg: uart2-0-cts-rts-cfg {
> +		uart2-0-pins {
> +			pinmux = <K1_PADCONF(23, 1)>,	/* uart2_cts */
> +				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart3_0_cfg: uart3-0-cfg {
> +		uart3-0-pins {
> +			pinmux = <K1_PADCONF(81, 2)>,	/* uart3_txd */
> +				 <K1_PADCONF(82, 2)>;	/* uart3_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart3_0_cts_rts_cfg: uart3-0-cts-rts-cfg {
> +		uart3-0-pins {
> +			pinmux = <K1_PADCONF(83, 2)>,	/* uart3_cts */
> +				 <K1_PADCONF(84, 2)>;	/* uart3_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart3_1_cfg: uart3-1-cfg {
> +		uart3-1-pins {
> +			pinmux = <K1_PADCONF(18, 2)>,	/* uart3_txd */
> +				 <K1_PADCONF(19, 2)>;	/* uart3_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart3_1_cts_rts_cfg: uart3-1-cts-rts-cfg {
> +		uart3-1-pins {
> +			pinmux = <K1_PADCONF(20, 2)>,	/* uart3_cts */
> +				 <K1_PADCONF(21, 2)>;	/* uart3_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart3_2_cfg: uart3-2-cfg {
> +		uart3-2-pins {
> +			pinmux = <K1_PADCONF(53, 4)>,	/* uart3_txd */
> +				 <K1_PADCONF(54, 4)>;	/* uart3_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart3_2_cts_rts_cfg: uart3-2-cts-rts-cfg {
> +		uart3-2-pins {
> +			pinmux = <K1_PADCONF(55, 4)>,	/* uart3_cts */
> +				 <K1_PADCONF(56, 4)>;	/* uart3_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart4_0_cfg: uart4-0-cfg {
> +		uart4-0-pins {
> +			pinmux = <K1_PADCONF(100, 4)>,	/* uart4_txd */
> +				 <K1_PADCONF(101, 4)>;	/* uart4_rxd */
> +			power-source = <3300>;
> +			bias-pull-up;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	uart4_1_cfg: uart4-1-cfg {
> +		uart4-1-pins {
> +			pinmux = <K1_PADCONF(83, 3)>,	/* uart4_txd */
> +				 <K1_PADCONF(84, 3)>;	/* uart4_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart4_1_cts_rts_cfg: uart4-1-cts-rts-cfg {
> +		uart4-1-pins {
> +			pinmux = <K1_PADCONF(81, 3)>,	/* uart4_cts */
> +				 <K1_PADCONF(82, 3)>;	/* uart4_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart4_2_cfg: uart4-2-cfg {
> +		uart4-2-pins {
> +			pinmux = <K1_PADCONF(23, 2)>,	/* uart4_txd */
> +				 <K1_PADCONF(24, 2)>;	/* uart4_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart4_3_cfg: uart4-3-cfg {
> +		uart4-3-pins {
> +			pinmux = <K1_PADCONF(33, 2)>,	/* uart4_txd */
> +				 <K1_PADCONF(34, 2)>;	/* uart4_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart4_3_cts_rts_cfg: uart4-3-cts-rts-cfg {
> +		uart4-3-pins {
> +			pinmux = <K1_PADCONF(35, 2)>,	/* uart4_cts */
> +				 <K1_PADCONF(36, 2)>;	/* uart4_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart4_4_cfg: uart4-4-cfg {
> +		uart4-4-pins {
> +			pinmux = <K1_PADCONF(111, 4)>,	/* uart4_txd */
> +				 <K1_PADCONF(112, 4)>;	/* uart4_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart4_4_cts_rts_cfg: uart4-4-cts-rts-cfg {
> +		uart4-4-pins {
> +			pinmux = <K1_PADCONF(113, 4)>,	/* uart4_cts */
> +				 <K1_PADCONF(114, 4)>;	/* uart4_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart5_0_cfg: uart5-0-cfg {
> +		uart5-0-pins {
> +			pinmux = <K1_PADCONF(102, 3)>,	/* uart5_txd */
> +				 <K1_PADCONF(103, 3)>;	/* uart5_rxd */
> +			power-source = <3300>;
> +			bias-pull-up;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	uart5_1_cfg: uart5-1-cfg {
> +		uart5-1-pins {
> +			pinmux = <K1_PADCONF(25, 2)>,	/* uart5_txd */
> +				 <K1_PADCONF(26, 2)>;	/* uart5_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart5_1_cts_rts_cfg: uart5-1-cts-rts-cfg {
> +		uart5-1-pins {
> +			pinmux = <K1_PADCONF(27, 2)>,	/* uart5_cts */
> +				 <K1_PADCONF(28, 2)>;	/* uart5_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart5_2_cfg: uart5-2-cfg {
> +		uart5-2-pins {
> +			pinmux = <K1_PADCONF(42, 2)>,	/* uart5_txd */
> +				 <K1_PADCONF(43, 2)>;	/* uart5_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart5_2_cts_rts_cfg: uart5-2-cts-rts-cfg {
> +		uart5-2-pins {
> +			pinmux = <K1_PADCONF(44, 2)>,	/* uart5_cts */
> +				 <K1_PADCONF(45, 2)>;	/* uart5_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart5_3_cfg: uart5-3-cfg {
> +		uart5-3-pins {
> +			pinmux = <K1_PADCONF(70, 4)>,	/* uart5_txd */
> +				 <K1_PADCONF(71, 4)>;	/* uart5_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart5_3_cts_rts_cfg: uart5-3-cts-rts-cfg {
> +		uart5-3-pins {
> +			pinmux = <K1_PADCONF(72, 4)>,	/* uart5_cts */
> +				 <K1_PADCONF(73, 4)>;	/* uart5_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart6_0_cfg: uart6-0-cfg {
> +		uart6-0-pins {
> +			pinmux = <K1_PADCONF(86, 2)>,	/* uart6_txd */
> +				 <K1_PADCONF(87, 2)>;	/* uart6_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart6_0_cts_rts_cfg: uart6-0-cts-rts-cfg {
> +		uart6-0-pins {
> +			pinmux = <K1_PADCONF(85, 2)>,	/* uart6_cts */
> +				 <K1_PADCONF(90, 2)>;	/* uart6_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart6_1_cfg: uart6-1-cfg {
> +		uart6-1-pins {
> +			pinmux = <K1_PADCONF(0, 2)>,	/* uart6_txd */
> +				 <K1_PADCONF(1, 2)>;	/* uart6_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart6_1_cts_rts_cfg: uart6-1-cts-rts-cfg {
> +		uart6-1-pins {
> +			pinmux = <K1_PADCONF(2, 2)>,	/* uart6_cts */
> +				 <K1_PADCONF(3, 2)>;	/* uart6_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart6_2_cfg: uart6-2-cfg {
> +		uart6-2-pins {
> +			pinmux = <K1_PADCONF(56, 2)>,	/* uart6_txd */
> +				 <K1_PADCONF(57, 2)>;	/* uart6_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart7_0_cfg: uart7-0-cfg {
> +		uart7-0-pins {
> +			pinmux = <K1_PADCONF(88, 2)>,	/* uart7_txd */
> +				 <K1_PADCONF(89, 2)>;	/* uart7_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart7_1_cfg: uart7-1-cfg {
> +		uart7-1-pins {
> +			pinmux = <K1_PADCONF(4, 2)>,	/* uart7_txd */
> +				 <K1_PADCONF(5, 2)>;	/* uart7_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart7_1_cts_rts_cfg: uart7-1-cts-rts-cfg {
> +		uart7-1-pins {
> +			pinmux = <K1_PADCONF(6, 2)>,	/* uart7_cts */
> +				 <K1_PADCONF(7, 2)>;	/* uart7_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart8_0_cfg: uart8-0-cfg {
> +		uart8-0-pins {
> +			pinmux = <K1_PADCONF(82, 4)>,	/* uart8_txd */
> +				 <K1_PADCONF(83, 4)>;	/* uart8_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart8_1_cfg: uart8-1-cfg {
> +		uart8-1-pins {
> +			pinmux = <K1_PADCONF(8, 2)>,	/* uart8_txd */
> +				 <K1_PADCONF(9, 2)>;	/* uart8_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart8_1_cts_rts_cfg: uart8-1-cts-rts-cfg {
> +		uart8-1-pins {
> +			pinmux = <K1_PADCONF(10, 2)>,	/* uart8_cts */
> +				 <K1_PADCONF(11, 2)>;	/* uart8_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart8_2_cfg: uart8-2-cfg {
> +		uart8-2-pins {
> +			pinmux = <K1_PADCONF(75, 4)>,	/* uart8_txd */
> +				 <K1_PADCONF(76, 4)>;	/* uart8_rxd */
> +			power-source = <3300>;
> +			bias-pull-up;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	uart8_2_cts_rts_cfg: uart8-2-cts-rts-cfg {
> +		uart8-2-pins {
> +			pinmux = <K1_PADCONF(77, 4)>,	/* uart8_cts */
> +				 <K1_PADCONF(78, 4)>;	/* uart8_rts */
> +			power-source = <3300>;
> +			bias-pull-up;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	uart9_0_cfg: uart9-0-cfg {
> +		uart9-0-pins {
> +			pinmux = <K1_PADCONF(12, 2)>,	/* uart9_txd */
> +				 <K1_PADCONF(13, 2)>;	/* uart9_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart9_1_cfg: uart9-1-cfg {
> +		uart9-1-pins {
> +			pinmux = <K1_PADCONF(116, 3)>,	/* uart9_txd */
> +				 <K1_PADCONF(117, 3)>;	/* uart9_rxd */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart9_1_cts_rts_cfg: uart9-1-cts-rts-cfg {
> +		uart9-1-pins {
> +			pinmux = <K1_PADCONF(110, 3)>,	/* uart9_cts */
> +				 <K1_PADCONF(115, 3)>;	/* uart9_rts */
> +			bias-pull-up;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	uart9_2_cfg: uart9-2-cfg {
> +		uart9-2-pins {
> +			pinmux = <K1_PADCONF(72, 2)>,	/* uart9_txd */
> +				 <K1_PADCONF(73, 2)>;	/* uart9_rxd */
> +			bias-pull-up;
>  			drive-strength = <32>;
>  		};
>  	};
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

