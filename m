Return-Path: <linux-kernel+bounces-820172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD5B7DB55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC83A7B5E10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F8302CD6;
	Wed, 17 Sep 2025 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="WeOhrCF7"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F51F5820;
	Wed, 17 Sep 2025 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095220; cv=none; b=RteOZgF+VNTTFxMG7+QDb9XAOJTmBM2WgWvwLO8yes9Q5vdBbBqchXE9iPELs/pBRHQGpt+jpE3YyjT5xK7cK8BwqzBOT19bd+6WwbaN/YgHOtm/P5t4vr4OGH30lSti5VIuMDN+Oaw6Cfv/0xhFYUa9hnldqqHGy+BnWO2DIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095220; c=relaxed/simple;
	bh=D/PjV4CqoCtKcjVfI6lHDm/ymiGh3tM57Q2YQPC9PsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQrUMCwVwLAG8bsPu5SfMBiy9Bi2LKilrv2asSEQWVTyBYBsVCaQ+Jo7IfST3J8/0iiIy5dRTAyg9LJex7+8Vjln74asUEQCPUqSe+QsiAxqWoDG/xlfvXz3zeZ8S8WQrO3wB90JbD9UWhCMkLlhIg5Y0ECnYUxxT3qCAdrcHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=WeOhrCF7; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758095194;
	bh=yTX0x8gU1Ol11kjsyuMqYbNOX/fW7mmYpB0x86VgsQ0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=WeOhrCF7WeITdtXCH083K1pGBjOXEO2zUHzMC5htsRP4jl+DaKedvCrzLc5puU+RG
	 jIJqsMFFS5ujOT3z4rn4VcaVa0j9T3m0smtiy6PMs+Wm5GAlEXFQ5D7UuSLa3prPic
	 k8FQtz1R1PaDmJ91SpBp5Mvz73s61OBaP1+UDzJc=
X-QQ-mid: zesmtpgz8t1758095191t60bda5af
X-QQ-Originating-IP: v9NVhKXhmwVLHDhgwvRC4v2vtIiR8kazfo72W7ZeXi8=
Received: from = ( [14.123.253.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 15:46:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9741036035539461399
EX-QQ-RecipientCnt: 16
Date: Wed, 17 Sep 2025 15:46:29 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, dlan@gentoo.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v4] riscv: dts: spacemit: add UART pinctrl combinations
Message-ID: <F213A85E78015F1A+aMpnVc9S_ynYGDF8@LT-Guozexi>
References: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OW4JKxETGMY2cXJrVcuIoa87jJ6fiZIfK3s8vMkzyFMH51+uKDQc+hS9
	GZUoHlTNZbKeHpgTV1YcnjhmbKPg89zPS+dOLcLIBliD++hRZx6uG4p8voBC6oefBiQXB1b
	8zq8r37bJ3uiS/f4cmjWk5SBOyX2MyorN/5cvCO3agY4ypG5SiIToH6wJToF7HSI/vQwocZ
	wPZEKktW+87EsGi4r8XbZO4jPareIeCg5pBm/UeT86HK9IXR4VT3LIobKRMS8Bar267mpLe
	0NmuQvoKYWNaCF40S7jpTzBC1LYyrnVCLlwxpZAfeJaCBmKK0qcnU2GlQHGjdCDKH05DXOC
	L7qDLmN31z+K0ztLsLOAyHCeg+Sei8LWHp6WZogMDn6uXWzpZ+b7qC176Jbzaz7BfKQfB9+
	+t2bEAzXFejiRx88e5y4SA2RdGMmC+3sNDPbP3+WxdZIE7Cj7mCB745+GaR7axopWSdkAco
	2+rpmPsmlHq2piUXvebbryZij6/g9rlUInymbniUhmrKT1ejtzNea49ejk5oCExQTRSLanc
	PTNMAlRPiSdZQhHfX9H6+x4jc7piyffN31uMjKA00M2wEkY0Fz3BZdRtMe3ZGcroGqB+xjO
	DprPmth+nFBtxW9uBZjEX0JrYN768qkR5401gM4sBE8nHpX17aRQ/0vNUYAc3Rr4PdR2gbV
	PR5otPC9wyRHlx20ugP+KAOaZYsy8LwWBp4nTuN4cKmhBPow2DVUxgur2gtA8Pgnxuk38+a
	xSq2Bfgaez7QF6ohUi0qjtmTtVVj+kkLClwKu0nZGV6rSp1X6B6prcOJiAWEc/Gjigek9lC
	0pzzhzvu3wRxt2UmOLN9CLDVORrPRCciVeMGDGXlXoATG8EJAzkGOo5y9V7vccxzzi+1p/k
	FjKrjq3w80LAPpKqpYT2BDrtWZh6x8TAYUbQuc83cb2QM49u0UbcEkXN0pqSacYW75J3HFE
	cTaanfx+T8UbN9OW79VH3rYKep+FBaibourVciYmWEqi7dMHSbx2SWVE3kCMsU5MC4o/fxy
	VcICPwlOtwjDXh9CtgOCEb5IaxPoXk6GjHOX/ej4Y+/fUgyOOgroN1/RCj40dWk+A+8lrsb
	A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi Hendrik, Thanks for your patch!

On Wed, Sep 17, 2025 at 08:59:07AM +0200, Hendrik Hamerlinck wrote:
> Add UART pinctrl configurations based on the SoC datasheet and the
> downstream Bianbu Linux tree. The drive strength values were taken from
> the downstream implementation, which uses medium drive strength.
> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> hardware flow control conditionally.
> 
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> ---
> Changes in v4:
> - Explicitly use 0 as bias-pull-up value
> 
> Changes in v3:
> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
> 
> Changes in v2:
> - Split cts/rts into separate pinctrl configs as suggested
> - Removed options from board DTS files to keep them cleaner
> ---
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 430 ++++++++++++++++++-
>  1 file changed, 428 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +	/omit-if-no-ref/
> +	uart2_0_cts_rts_cfg: uart2-0-cts-rts-cfg {
> +		uart2-0-pins {
> +			pinmux = <K1_PADCONF(23, 1)>,	/* uart2_cts */
> +				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
We are currently using the 8250 UART driver, but hardware flow control does not
work properly on K1. We are considering fixing this when time permits.

Should we add a comment here to avoid confusing others who may run into this?
If so, I will remove the comment once the issue has been fixed.

Anyway,

Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> +
> +	/omit-if-no-ref/
> +	uart3_0_cfg: uart3-0-cfg {
> +		uart3-0-pins {
> +			pinmux = <K1_PADCONF(81, 2)>,	/* uart3_txd */
> +				 <K1_PADCONF(82, 2)>;	/* uart3_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart3_0_cts_rts_cfg: uart3-0-cts-rts-cfg {
> +		uart3-0-pins {
> +			pinmux = <K1_PADCONF(83, 2)>,	/* uart3_cts */
> +				 <K1_PADCONF(84, 2)>;	/* uart3_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart3_1_cfg: uart3-1-cfg {
> +		uart3-1-pins {
> +			pinmux = <K1_PADCONF(18, 2)>,	/* uart3_txd */
> +				 <K1_PADCONF(19, 2)>;	/* uart3_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart3_1_cts_rts_cfg: uart3-1-cts-rts-cfg {
> +		uart3-1-pins {
> +			pinmux = <K1_PADCONF(20, 2)>,	/* uart3_cts */
> +				 <K1_PADCONF(21, 2)>;	/* uart3_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart3_2_cfg: uart3-2-cfg {
> +		uart3-2-pins {
> +			pinmux = <K1_PADCONF(53, 4)>,	/* uart3_txd */
> +				 <K1_PADCONF(54, 4)>;	/* uart3_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart3_2_cts_rts_cfg: uart3-2-cts-rts-cfg {
> +		uart3-2-pins {
> +			pinmux = <K1_PADCONF(55, 4)>,	/* uart3_cts */
> +				 <K1_PADCONF(56, 4)>;	/* uart3_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_0_cfg: uart4-0-cfg {
> +		uart4-0-pins {
> +			pinmux = <K1_PADCONF(100, 4)>,	/* uart4_txd */
> +				 <K1_PADCONF(101, 4)>;	/* uart4_rxd */
> +			power-source = <3300>;
> +			bias-pull-up = <0>;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_1_cfg: uart4-1-cfg {
> +		uart4-1-pins {
> +			pinmux = <K1_PADCONF(83, 3)>,	/* uart4_txd */
> +				 <K1_PADCONF(84, 3)>;	/* uart4_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_1_cts_rts_cfg: uart4-1-cts-rts-cfg {
> +		uart4-1-pins {
> +			pinmux = <K1_PADCONF(81, 3)>,	/* uart4_cts */
> +				 <K1_PADCONF(82, 3)>;	/* uart4_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_2_cfg: uart4-2-cfg {
> +		uart4-2-pins {
> +			pinmux = <K1_PADCONF(23, 2)>,	/* uart4_txd */
> +				 <K1_PADCONF(24, 2)>;	/* uart4_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_3_cfg: uart4-3-cfg {
> +		uart4-3-pins {
> +			pinmux = <K1_PADCONF(33, 2)>,	/* uart4_txd */
> +				 <K1_PADCONF(34, 2)>;	/* uart4_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_3_cts_rts_cfg: uart4-3-cts-rts-cfg {
> +		uart4-3-pins {
> +			pinmux = <K1_PADCONF(35, 2)>,	/* uart4_cts */
> +				 <K1_PADCONF(36, 2)>;	/* uart4_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_4_cfg: uart4-4-cfg {
> +		uart4-4-pins {
> +			pinmux = <K1_PADCONF(111, 4)>,	/* uart4_txd */
> +				 <K1_PADCONF(112, 4)>;	/* uart4_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart4_4_cts_rts_cfg: uart4-4-cts-rts-cfg {
> +		uart4-4-pins {
> +			pinmux = <K1_PADCONF(113, 4)>,	/* uart4_cts */
> +				 <K1_PADCONF(114, 4)>;	/* uart4_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart5_0_cfg: uart5-0-cfg {
> +		uart5-0-pins {
> +			pinmux = <K1_PADCONF(102, 3)>,	/* uart5_txd */
> +				 <K1_PADCONF(103, 3)>;	/* uart5_rxd */
> +			power-source = <3300>;
> +			bias-pull-up = <0>;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart5_1_cfg: uart5-1-cfg {
> +		uart5-1-pins {
> +			pinmux = <K1_PADCONF(25, 2)>,	/* uart5_txd */
> +				 <K1_PADCONF(26, 2)>;	/* uart5_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart5_1_cts_rts_cfg: uart5-1-cts-rts-cfg {
> +		uart5-1-pins {
> +			pinmux = <K1_PADCONF(27, 2)>,	/* uart5_cts */
> +				 <K1_PADCONF(28, 2)>;	/* uart5_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart5_2_cfg: uart5-2-cfg {
> +		uart5-2-pins {
> +			pinmux = <K1_PADCONF(42, 2)>,	/* uart5_txd */
> +				 <K1_PADCONF(43, 2)>;	/* uart5_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart5_2_cts_rts_cfg: uart5-2-cts-rts-cfg {
> +		uart5-2-pins {
> +			pinmux = <K1_PADCONF(44, 2)>,	/* uart5_cts */
> +				 <K1_PADCONF(45, 2)>;	/* uart5_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart5_3_cfg: uart5-3-cfg {
> +		uart5-3-pins {
> +			pinmux = <K1_PADCONF(70, 4)>,	/* uart5_txd */
> +				 <K1_PADCONF(71, 4)>;	/* uart5_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart5_3_cts_rts_cfg: uart5-3-cts-rts-cfg {
> +		uart5-3-pins {
> +			pinmux = <K1_PADCONF(72, 4)>,	/* uart5_cts */
> +				 <K1_PADCONF(73, 4)>;	/* uart5_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart6_0_cfg: uart6-0-cfg {
> +		uart6-0-pins {
> +			pinmux = <K1_PADCONF(86, 2)>,	/* uart6_txd */
> +				 <K1_PADCONF(87, 2)>;	/* uart6_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart6_0_cts_rts_cfg: uart6-0-cts-rts-cfg {
> +		uart6-0-pins {
> +			pinmux = <K1_PADCONF(85, 2)>,	/* uart6_cts */
> +				 <K1_PADCONF(90, 2)>;	/* uart6_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart6_1_cfg: uart6-1-cfg {
> +		uart6-1-pins {
> +			pinmux = <K1_PADCONF(0, 2)>,	/* uart6_txd */
> +				 <K1_PADCONF(1, 2)>;	/* uart6_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart6_1_cts_rts_cfg: uart6-1-cts-rts-cfg {
> +		uart6-1-pins {
> +			pinmux = <K1_PADCONF(2, 2)>,	/* uart6_cts */
> +				 <K1_PADCONF(3, 2)>;	/* uart6_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart6_2_cfg: uart6-2-cfg {
> +		uart6-2-pins {
> +			pinmux = <K1_PADCONF(56, 2)>,	/* uart6_txd */
> +				 <K1_PADCONF(57, 2)>;	/* uart6_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart7_0_cfg: uart7-0-cfg {
> +		uart7-0-pins {
> +			pinmux = <K1_PADCONF(88, 2)>,	/* uart7_txd */
> +				 <K1_PADCONF(89, 2)>;	/* uart7_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart7_1_cfg: uart7-1-cfg {
> +		uart7-1-pins {
> +			pinmux = <K1_PADCONF(4, 2)>,	/* uart7_txd */
> +				 <K1_PADCONF(5, 2)>;	/* uart7_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart7_1_cts_rts_cfg: uart7-1-cts-rts-cfg {
> +		uart7-1-pins {
> +			pinmux = <K1_PADCONF(6, 2)>,	/* uart7_cts */
> +				 <K1_PADCONF(7, 2)>;	/* uart7_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart8_0_cfg: uart8-0-cfg {
> +		uart8-0-pins {
> +			pinmux = <K1_PADCONF(82, 4)>,	/* uart8_txd */
> +				 <K1_PADCONF(83, 4)>;	/* uart8_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart8_1_cfg: uart8-1-cfg {
> +		uart8-1-pins {
> +			pinmux = <K1_PADCONF(8, 2)>,	/* uart8_txd */
> +				 <K1_PADCONF(9, 2)>;	/* uart8_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart8_1_cts_rts_cfg: uart8-1-cts-rts-cfg {
> +		uart8-1-pins {
> +			pinmux = <K1_PADCONF(10, 2)>,	/* uart8_cts */
> +				 <K1_PADCONF(11, 2)>;	/* uart8_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart8_2_cfg: uart8-2-cfg {
> +		uart8-2-pins {
> +			pinmux = <K1_PADCONF(75, 4)>,	/* uart8_txd */
> +				 <K1_PADCONF(76, 4)>;	/* uart8_rxd */
> +			power-source = <3300>;
> +			bias-pull-up = <0>;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart8_2_cts_rts_cfg: uart8-2-cts-rts-cfg {
> +		uart8-2-pins {
> +			pinmux = <K1_PADCONF(77, 4)>,	/* uart8_cts */
> +				 <K1_PADCONF(78, 4)>;	/* uart8_rts */
> +			power-source = <3300>;
> +			bias-pull-up = <0>;
> +			drive-strength = <19>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart9_0_cfg: uart9-0-cfg {
> +		uart9-0-pins {
> +			pinmux = <K1_PADCONF(12, 2)>,	/* uart9_txd */
> +				 <K1_PADCONF(13, 2)>;	/* uart9_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart9_1_cfg: uart9-1-cfg {
> +		uart9-1-pins {
> +			pinmux = <K1_PADCONF(116, 3)>,	/* uart9_txd */
> +				 <K1_PADCONF(117, 3)>;	/* uart9_rxd */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
> +
> +	/omit-if-no-ref/
> +	uart9_1_cts_rts_cfg: uart9-1-cts-rts-cfg {
> +		uart9-1-pins {
> +			pinmux = <K1_PADCONF(110, 3)>,	/* uart9_cts */
> +				 <K1_PADCONF(115, 3)>;	/* uart9_rts */
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};
>  
> +	/omit-if-no-ref/
> +	uart9_2_cfg: uart9-2-cfg {
> +		uart9-2-pins {
> +			pinmux = <K1_PADCONF(72, 2)>,	/* uart9_txd */
> +				 <K1_PADCONF(73, 2)>;	/* uart9_rxd */
>  			bias-pull-up = <0>;
>  			drive-strength = <32>;
>  		};
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

