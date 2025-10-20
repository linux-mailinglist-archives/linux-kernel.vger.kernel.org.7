Return-Path: <linux-kernel+bounces-859955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A780BEF096
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB0DC4E7FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9CD1DED49;
	Mon, 20 Oct 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VzOcQ5L9"
Received: from mail-m32120.qiye.163.com (mail-m32120.qiye.163.com [220.197.32.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378A54654;
	Mon, 20 Oct 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925228; cv=none; b=CCTSfWVvKlbmrgbehfBCjnQyJ7odnqTefiImCryQeB28kmqhPqs1yuyImjfqgNuSXuWR86W0tn7HMPIsDdJoPQWKrr8I3Y9hakdVrPX5bVM7ZcmER9j4WCKDBuM5gEY11jc+DyQ3SNH2fIXVLp8yJeuUvHuNp06LhgMdk7PzNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925228; c=relaxed/simple;
	bh=q0fAelmGh3WEDpJfJewg6gAvFbc2YcrDQ07mPYnJLUA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MeDRsJZldad23j74nY68A3Ck8ZRA2Po21/K5oU1Ualj0PrA4MNf2SqDp0OLoy9WnsRNkPWdIV7x7SwwP5TtkxWGaUs7yD8WKlvCPR09MUAbrWRBrRa/2cbOEPgqYqi8n7uNNVCujaFT2UfvMPynWT03SKjq8gfeyHX7+iziXW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VzOcQ5L9; arc=none smtp.client-ip=220.197.32.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 266f5200f;
	Mon, 20 Oct 2025 09:53:35 +0800 (GMT+08:00)
Message-ID: <d70c0eb5-9aa2-47b1-8205-81b724180319@rock-chips.com>
Date: Mon, 20 Oct 2025 09:53:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Grzegorz Sterniczuk <grzegorz@sternicz.uk>,
 Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Tianling Shen <cnsztl@gmail.com>
References: <20251017073954.130710-1-cnsztl@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251017073954.130710-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a99ff526ae609cckunm1697cb9843f00a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSR1PVkMYGksZSUNIGkgYTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJSEJIQlVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=VzOcQ5L9Hs7pSFuZJX/CkQaQxwR0raBnNyF6mYu66reDbPuhjA5vWSzWj82+r31xLB9lgVcHcBUNaD1zdl9a0V4ElbyBGyj+nu5EKR6fMNSjCB63wgPAkGS+EdknLbBbeRcCY24ki5o+bllSJEtItVg4u5Z3U4QlSfOBzKSFKlA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uE23dvljygAYOD4lrf+KZIVsIgCT2mrCL/r5xFRmJLk=;
	h=date:mime-version:subject:message-id:from;

Hi Tianling

On 2025/10/17 Friday 15:39, Tianling Shen wrote:
> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> 
> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
> stable operation.

May I ask you to test another patch I just posted to see if it fixes
your issue?

https://patchwork.kernel.org/project/linux-mmc/patch/1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com/


> 
> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> index fafeabe9adf9..5f63f38f7326 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> @@ -717,8 +717,7 @@ &sdhci {
>   	no-sd;
>   	non-removable;
>   	max-frequency = <200000000>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> +	mmc-hs200-1_8v;
>   	status = "okay";
>   };
>   


