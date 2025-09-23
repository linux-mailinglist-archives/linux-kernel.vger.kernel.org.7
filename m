Return-Path: <linux-kernel+bounces-828076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917DB93E23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C12E2F00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FC26FD9B;
	Tue, 23 Sep 2025 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="bCpDVlLO"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED826B755;
	Tue, 23 Sep 2025 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591150; cv=none; b=GmARzDxcRfS6PB+ut6sjV8tB7ZkPJYFoZY9shJ3G6N7Rwqeo1/Dd+L2JSm4limcouDZknCHeEctGNy547fl7kLc72k2FePb0zwL9rYgXIAR4Ko+XUAFDNWPv6j1kcAC4cHfQLmG8GpTkwa/fwn/maaOU9ttUlhVDo34+qoBv5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591150; c=relaxed/simple;
	bh=feQ3s2NzA4iM0EEPUY60pGpDIsT+fUHIRpfPtbi14hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhgEVMSTlttC6HIsKvL6x6wKx2q/40V0sQDwgNKVc8qI80NWbC9P8BUTCWjgISe5E8gm0R5I3BodRWNXIM05S7+N4ShFskpG98kAW0ZCfSFZCig3/C903IY2EllAn60fTUfaSwyUnvIj2opxOeFGor0Vj5pnsYO0/KJHpulWI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=bCpDVlLO; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758591131;
	bh=pUgkSqa9MbZmdINZwGXwoPZj1dV53mzsqlI9fZEl9o8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=bCpDVlLOwi6ujEnqYNjceLzSqA02Xuh/XrEo6JeRuy4KEC+NdXZKTGzo0mcNVF3lr
	 heA20JBv0nc+/KkMLVxFxMawBz9aljXPk/MsQasa7sFKMT6i1IyeJNTd0g/2YzlFP2
	 J4BE7BsJrwvkRr+T8vAVPBpovC2W3/VQANJi2odQ=
X-QQ-mid: zesmtpgz8t1758591129tcb5cf986
X-QQ-Originating-IP: Uj8zQ9zH/nwD/Kium59nwlgSkK+cmeq2Gg77IVFAYT0=
Received: from = ( [14.123.255.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Sep 2025 09:32:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9038255662737633468
EX-QQ-RecipientCnt: 14
Date: Tue, 23 Sep 2025 09:32:07 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 1/3] riscv: dts: spacemit: enable the i2c2 adapter on
 BPI-F3
Message-ID: <DC360EB139FD9DE5+aNH4l-7SP5KNu-Br@LT-Guozexi>
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-2-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921210237.943370-2-aurelien@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OHMBGvC4grOuGqaTQjdqDq17+2UCKS11EnX6tfsPIbbYA4D76R7pcYsy
	EPXgQFuRB7ufyPmUnOBUSjam4xGBFyhLKCPxhlAENtsDUO64DXDCzFlP2BSMh6Ei9FZ4GMr
	4F41HYQ1bE6+CIYqycUy7lMqZzOdWVXe70A9rSvjaLF8ZmpnsACXN9pQrT5LPPDRopgiMSU
	CLuep4DE6k7APCST/O3MCIw49TLfm2adyq15nbfKgHI8doqKbVwHyXn4wYl/p1XGe+H/3od
	ArYSe6CFNtlAnwwtQdJLNS4LxZMyOM4/H2nL/FG04MAIUUBsm+kVPHJ6YDn/uxxe1rwnkcO
	f0Os3s4Q+Mxhro7yJ9xOt/X5l6S/FnEzWg+JHrLmf6gwVKxDJwMsdOVpu3hsVyft3opd/Lk
	LtCVyW33zK9/IuDQ0Bz2WgHp6A1G12MVXPIzhFz88H55QtCnwO6/32wKOAySqINDJmU/BXX
	XHKljXuf4OEKkfgDcPC74KAmYZB9S3ciz0rOTUegXVtCufq2EmbmpdR0dllqB9Fko6DxpMQ
	J0jSh0Ewcj2BOWMdfDN+F+l6R16Kr2/ee8CQ0KjS85aNPZaf7LOrillK7gB8zFFRy5IMJYJ
	/gbogRIzIi38YWO3RGB6DjWRpoNcga3ARgjZrgjBNDqDSGtwhd1vwYyDFinTRCfBBWgaVhX
	4TOniE1lW+86jp/hLWHiHz8N1QOGPSbmTxyUurwpqm9MU96974kmV48wBsTCE7htp7e5YeQ
	SizgwkAlItlF7denUTYEKO+7bxDPUWMFpyVn+aArkkgbHf3zK6kitPNm6BkmdN+IFPbC8TW
	UeNljZ9pJjU/GTP6hn4qKDEV13HHHPtvsDISw0u4hrJy+T+bmMQAPbLstz3HlV1rXh52ju7
	n7T8MlrjVIVl3iN1bvQ+2rEwIvi4+gYYKNxhcD073P6tsr7H0nqRzqz8cQ2CmYP3C0GWtFT
	dLbDhAOL8T7uqS4BBuSBojT3Y2QkVUajtilQzPBaQaErPG6qSS1fiN3ym5+etdPjfXIH1AS
	wc8oVYyKH0TjSSCHbAcH/mMuwwAlJeIkPOxXpbHnSCvQyjrRlwzi7dF4vCpYWqz7eX8W/tK
	rsip+nKNbBKG+JISO6IQDA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Sun, Sep 21, 2025 at 11:01:41PM +0200, Aurelien Jarno wrote:
> Define properties for the I2C adapter, and enable it on the BPI-F3. It
> will be used by the 24c02 eeprom.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -92,6 +92,13 @@ gmac1-pins {
>  		};
>  	};
>  
> +	i2c2_0_cfg: i2c2-0-cfg {
Should this be i2c2_4_cfg here?
From what I see, in the initial version the second cell was meant
to be the function number rather than the serial index.

It looks like the pwm part is also incorrect.

                - Troy
> +		i2c2-0-pins {
> +			pinmux = <K1_PADCONF(84, 4)>,	/* I2C2_SCL */
> +				 <K1_PADCONF(85, 4)>;	/* I2C2_SDA */
> +		};
> +	};
> +
>  	i2c8_cfg: i2c8-cfg {
>  		i2c8-0-pins {
>  			pinmux = <K1_PADCONF(93, 0)>,	/* PWR_SCL */
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index bc61a380baca8..d4f38ded52c93 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -497,6 +497,19 @@ pwm7: pwm@d401bc00 {
>  			status = "disabled";
>  		};
>  
> +		i2c2: i2c@d4012000 {
> +			compatible = "spacemit,k1-i2c";
> +			reg = <0x0 0xd4012000 0x0 0x38>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&syscon_apbc CLK_TWSI2>,
> +				 <&syscon_apbc CLK_TWSI2_BUS>;
> +			clock-names = "func", "bus";
> +			clock-frequency = <400000>;
> +			interrupts = <38>;
> +			status = "disabled";
> +		};
> +
>  		i2c8: i2c@d401d800 {
>  			compatible = "spacemit,k1-i2c";
>  			reg = <0x0 0xd401d800 0x0 0x38>;
> -- 
> 2.47.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

