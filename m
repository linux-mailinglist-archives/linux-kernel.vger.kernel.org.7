Return-Path: <linux-kernel+bounces-891466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D61C42B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188D03B14E6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473B3009C8;
	Sat,  8 Nov 2025 10:53:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EB28E9;
	Sat,  8 Nov 2025 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762599196; cv=none; b=EK1d316kY3mMiLcEMM3vbFvLS3wQfeOUavCKPynF3mMjLIzo2QOs5zGo7nLaCoVXd8aOna1kf3Pp8ym95rg4G5HRIlZ2GGuW5q8tFycnX7AqogGgvHU37dHYObjaZysZof8yolwYQ9ERpVDGHydMpqR8qnD5A4uHEwmu+UVWywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762599196; c=relaxed/simple;
	bh=+T8UbxmRUBElbs/l/meuBSbogs0rWAfpBjF1yTwFVME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVwoFQvw9zVl+MlKnp5Pf+hUMMWupKEQp3G3Oxf0ORWieCGdLqZN0j+5vbcFLk57UGet7/AwaMyQ+rDVm4bkEyWpO4xc4j2UBhyAlmkQQOw8rCkpzTLbZwf8wRMPixM0O0d4grsJ1yK5SSeB5GNRTYwAPM9fXcoTFk1G7VGHFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vHgYw-000000008Kw-0aJw;
	Sat, 08 Nov 2025 10:52:54 +0000
Date: Sat, 8 Nov 2025 10:52:16 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] clk: mediatek: mt7988-infracfg: fix USB port0 function
 for U2 only
Message-ID: <aQ8g4HM5XwlYim--@makrotopia.org>
References: <20251108090726.7787-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108090726.7787-1-linux@fw-web.de>

On Sat, Nov 08, 2025 at 10:07:25AM +0100, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Fix the functionality of USB port0 U2 when U2 is enabled without U3.
> This change addresses the issue where port0 U3 is shared with PCIE2,
> ensuring that the port0 U2 function operates correctly without U3 support.
> 
> Additionally, add support to enable the U2 function instead of disabling
> the entire USB port0 in the configuration for the 4 PCIe case. This
> change ensures that U2 functionality is properly activated.
> 
> Fixes: 4b4719437d85 ("clk: mediatek: add drivers for MT7988 SoC")
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/clk/mediatek/clk-mt7988-infracfg.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> index ef8267319d91..da4ad365e30f 100644
> --- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> @@ -229,8 +229,9 @@ static const struct mtk_gate infra_clks[] = {
>  			  CLK_IS_CRITICAL),
>  	GATE_INFRA3_FLAGS(CLK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1", "usb_frmcnt_p1_sel",
>  			  9, CLK_IS_CRITICAL),
> -	GATE_INFRA3(CLK_INFRA_USB_PIPE, "infra_usb_pipe", "sspxtp_sel", 10),
> -	GATE_INFRA3(CLK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1", "usb_phy_sel", 11),
> +	GATE_INFRA3_FLAGS(CLK_INFRA_USB_PIPE, "infra_usb_pipe", "sspxtp_sel", 10, CLK_IS_CRITICAL),
> +	GATE_INFRA3_FLAGS(CLK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1", "usb_phy_sel", 11,
> +			  CLK_IS_CRITICAL),

I don't agree that those two clocks are critical. There are boards using
MT7988 which don't even come with USB at all.
Instead of marking the clock as criticl, the dependency of the USB host on
them should be expressed properly.

