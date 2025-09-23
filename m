Return-Path: <linux-kernel+bounces-828094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1AB93ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D349918A4DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468126C399;
	Tue, 23 Sep 2025 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="DIubfLZi"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B326290;
	Tue, 23 Sep 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592873; cv=none; b=l+4jl5ApmJudeC2ApGNHGPx49Es51+mFKl96kdl6At0MoStPvRNT5RJibodvqXGEi4SjmvtSkaSr82L+7ttMbe5kb9BEfNrVXpvfslk96kIiIm66N2efIgMGbSqJyZp+rghEL40ZVz+1DAkOAwO2vyMB1WAQgxPgvchcdeTL6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592873; c=relaxed/simple;
	bh=xi/tAHjSbJBoYA4aGt5jM49ClyVBHuelxMuqQ+nqf+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChvljUGSliDFrIJIkp0D+qvbo2taLSh4GYlxWh5KfQHCA2Y6HGa2gZ5JqxJC35OIJucOzCeU4MmiS7XYzcCbmGdS1NNTICM5yRgYAuIdmzTqjauLjnaNNntWTUnzOdqiblPMKFtTTPQGCGFCXarniob9IA3y1S5s0eBrYHRwry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=DIubfLZi; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758592856;
	bh=MEAuKrwM6KdwR90xbDZhYiFbRD7stRJVqn5Ua3qlyBs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=DIubfLZibEAl1tpMz3pAOlgOrwMHejxCnTXrXYnl50cy3+D1i1UImt94ily/legMI
	 j0DBpNJ2/Ft4tChBoMhYTVBbSUVtJ35c0MKMrXBRMTB7VwnFw20+XsCviJFdTUqNZI
	 8g0mpjcerP9gj5gHgE2KFCxG9pm75UHuNNWZgWgM=
X-QQ-mid: zesmtpgz8t1758592839t273fee33
X-QQ-Originating-IP: GzXckMxXGTPsUWDBYYMmo0syLdSfJ5174o/VNKjj6ck=
Received: from = ( [14.123.255.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Sep 2025 10:00:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12168466649984093045
EX-QQ-RecipientCnt: 14
Date: Tue, 23 Sep 2025 10:00:38 +0800
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
Subject: Re: [PATCH 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Message-ID: <6CF6078CFA2EB2F4+aNH_RmNkM_hnsAYu@LT-Guozexi>
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-3-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921210237.943370-3-aurelien@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MllZffuBkEb5uYPmmfjVHXlTxmVnPskfYQE75ozdpCSYNse7h+f2X3tg
	ppQ/wlQoqSqCPpNg0Rg7pzr+d793xi3pcxH69chxLKJJO2r4JRH+fzb6914Asgi/CcKhyHx
	ng08a7pLBDzPKQdR4YMXUE+RSTdSVR5ghDEcEEchXcGoGAYZva4A+gJNeIMkdbDXnZ+wzfx
	NiurChkOd9+udjYC/NivsuLyjC/sKcJT3GbyRsY+nv5U4BR2lojzTodc+V+7FUarGp/nQtT
	llxib3rC5gsm+WcO0I0zI6Ie1O3YLLhqNnHw1PQOngx/EqDoWw0d+FmtEtE7WzRyIx+JKsj
	gdXW+u8xj6aPBSuRH2lPr/PtEirtkAtQ0ffqgoj263gs9lKXGu4D/7LRNNRkPURhiIjvayx
	jDXm5qiBWaq76L5yzOgnrOIXCZahWm8G5cTZkVqJwxeoqfNe73rEBFgEFtJ7tm07OGWKhFp
	oK3qaSLoTcKY8SIHGlaDnR5D0hLKVNQGJtvwNctI5pdz6sf9pZ2Iymtt3PnT5/I5hynXpyR
	bXqDrIS8kim84ZQuHcr+0l05280PwHSlFMRgEMgIKjqkhhOGKITRAIJIuBjrevVvjfWnRAg
	+WyoHPLcCfk2RqA+HWQBtb8RQMydXwz5rSWxgybZBvlYO1J8+wMj65MMNeLQTNVfMrzVsgn
	Lc+KtMFqZZ40zgwn7GeiiqH/7L5uNtkF2saU+MGDSjkxBARJcbTWQnxpJJl6d9d/pApul9W
	aSwXmyyyARCBmOcKNwJD1LKNzp66MEbDT/3NZ+4ohfmx5febAReam57te3S8xM+KTA9jwwR
	a7U0IwHpen5FTO5uhSSOBy7mrhNu68czCr/ezBRliChRKRFrqEU0FHXIa6D0bmbIVCJv9GW
	yYC+oYXHVeXWkQ0B4N+mbAJigEaZaVgdBA57X+FfKLvV82qDUnuvP7OKAWC1qFhOeT3sWq5
	EffaGCo6g6VL4DuzBg9tpUofSwoVP9//5Ep84yPAELU6+CgkDByzEtnQYFWnlrXNScTRk1g
	9awDZG2ilan5GC+LRZ7VA0stY7tNbicIjA6qL/vVGgDO99xhrx6h/+6H/uvCg0t0kAFuWFi
	0HbGvbZvCaogrIT4ojjh/S7ARs7rYzYMpC7XCIvyuEExTFpm44l4aI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Sun, Sep 21, 2025 at 11:01:42PM +0200, Aurelien Jarno wrote:
> The BPI-F3 contains a 24c02 eeprom, that contains among other things the
> MAC addresses of the two network interfaces. For this reason, mark it as
> read-only.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 3b6e4f52e9aad..574d10fdf9b82 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -115,6 +115,15 @@ &i2c2 {
>  	pinctrl-0 = <&i2c2_0_cfg>;
>  	pinctrl-names = "default";
>  	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		vcc-supply = <&vcc1v8_sys>;
> +		pagesize = <16>;
I'm not sure this is 16..
Could you double check it?

                - Troy
> +		read-only;
> +		size = <256>;
> +	};
>  };
>  
>  &i2c8 {
> @@ -143,7 +152,7 @@ buck2 {
>  				regulator-always-on;
>  			};
>  
> -			buck3 {
> +			vcc1v8_sys: buck3 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <1800000>;
>  				regulator-ramp-delay = <5000>;
> -- 
> 2.47.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

