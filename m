Return-Path: <linux-kernel+bounces-861608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73DBF32CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79FC18C2519
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D762D6E6E;
	Mon, 20 Oct 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FwKR/Q3C"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3632D5A16
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987950; cv=none; b=MOqeNT1WFmzSaDSoOJFss9ZrdAl+64RKOwGF6ycFhy5PFfTpcOUS7VW+tQLP0ZPLxmJndEWr4NiWDDjniLMcvxOgHI20eoeug8XBMZiKprJg5X676fYU/A4upV9rCoejbSSy+g4Kx97GnksK5ua7TNWhGMGb2mYYmWiEUwPUpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987950; c=relaxed/simple;
	bh=xyCI5IsABsyRN5E0PfGElo1mx1NfJv1InbwBvkHN9Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9dotfWIkns2cm1W41qli2p4gv7VrtOSBkMMLn+mskiglEPfAOM+fmyX0ffSRhwuQhNtWGffLJsMHmkBakE2In2p062n1Mvk915elW8Zx64cSZuEyHbtg53Slm/+l2kIbHd32RLVVlEGb1GLmpn/PSF2vfNpWI+P9EpS7ZkrXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FwKR/Q3C; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b303f755aso49635815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987947; x=1761592747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQYtr/7sEDmmMLc6ugUR4fjhLSuMYN4opd792ZFPWlQ=;
        b=FwKR/Q3CP5RGd1Z7vj5jjgmkUaBpwxNfU4MmE1xvam68CSaYHl8woKUv90oOd6m36S
         qtLruRUFNBSf7ey9ZqcxfV4/i05524Cz+n4JCZyq3b+igQihMdRtY6vjYWKQSzL+aGEs
         kahfdL3mklUUgCyRT72qOMuHiVJeDVcMvazhCQUHgzgF+bSboQLschzR8MNMHTiRCWVN
         B7g0FxjahimfJAbQk+gWru3qjO0GEN4pRsS6dNrS+EUuS+o4oBwH32WOkGdzNCMGx1vp
         5xPiOuVSf6amKPvg0P57Ok0xvjYdZI2LiXx0duDGxiZdk/EOQzm7awwVKN3a/zSorg+B
         qxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987947; x=1761592747;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQYtr/7sEDmmMLc6ugUR4fjhLSuMYN4opd792ZFPWlQ=;
        b=b6lL/Ughtb9QSpWeLc9CDCc8ecotpdZCcLKxVSUnZ43TD1jji6tCD2ANrVrtBGeCuU
         63WOjjwDi4bNhSIWnGTix2Ye/8Fv9g6NHXKfDiKlLqu3jC4SNyWjcSW1fRMileH628hv
         rKvovB3xJvn+WUXDAJ8Tiu4LbGST9t/WXMff4Bxwo54UB1j0hlViGLFIMG4KOHxPsOUa
         68oOb5M/6QIQi/nP7NeAQjyYXWjGzE2KJmOzaqH+jmkzYvhZ/rXQrJ8RklCsmfORn+Dv
         XO2C1yu5GtROT9gh00P8dRwC3ZaKsvD+aeIC/s3zV3am7a483tgdopsAGhxcVCpUNavn
         yHQg==
X-Forwarded-Encrypted: i=1; AJvYcCWJPSWS8W5R1ZpQcRFefGSWVGaimNe54TWifb8Pzt1GPLSz5WPx1Lnls18ghBVi6sSwTiOYd20TMG9DNjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTw2IDGpzgl0DSh5Nrdqj+BCoblj31mTLBWtiMCHHTPxdRozRz
	PCBAJ+WtblfMzj/yMsF/PHN5ijC4YJwwU4h8jtd4e3G1bXZU2Z7mBW/zRLBGQ3fcnOw=
X-Gm-Gg: ASbGnctd6SGlXI6hvntQhKq2mxMcaaucaIzgJIn9JEJb7ZzUWt1CilGE3huLwantMze
	O1zhjy1s0jEf5ghPL+rnkFYfbR8/7ofeJkNfZHkZiKrbfTp8oxta4MLL8TmgE+k/PVihapE64ap
	devQHX/PDWypzrczNjRF4f5cLaOjH4vWhtcTxxRikfMR0Pc2d8bTulwdaAjQ8whCaNRyfBj2tFy
	sFpzo+TtQ80yCrlbGiWEn4Wd9O1+F2glYLNSiN2LhKI9Vh9NbzRmA39pGIuSM9WM/OMXGzpQpyx
	X2P3RgGPpDNa30EDhjJac3KKlIoF6A/qrNjeWeJEkeUIU7SOnIjrhVZyR0D33vXEXkse5p9fD8d
	KI6EOihlUeB78a9ScktlhhiV2rSYc2e3JEADAOnuXmZ1bQ5bJPHeHSZEfVUkIf2gjqXzJ4TWd08
	02u5W9Qtu3EX+Z2YTNBRc=
X-Google-Smtp-Source: AGHT+IFVCGpeA2+bow5Xc59mcHd54jCuOxCx/IBPo7BEfszluf4T2+SmNyRQJAdcjVO6TmsyG6PpVg==
X-Received: by 2002:a05:600c:4507:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-4711787276dmr107545445e9.4.1760987947193;
        Mon, 20 Oct 2025 12:19:07 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f7dsm16419723f8f.4.2025.10.20.12.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:19:06 -0700 (PDT)
Message-ID: <068736a0-a5ef-4905-b311-9376e8fcbc16@tuxon.dev>
Date: Mon, 20 Oct 2025 22:19:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/31] clk: at91: sama5d2: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <a2f7cce73739fc795d17710a3bb017158c090735.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <a2f7cce73739fc795d17710a3bb017158c090735.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:16, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Switch SAMA5D2 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration

But only a small part of conversion uses parent_hw. Could you please
improve this description? Same for the other patches.

> speed and re-parenting.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Adjust commit message.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/sama5d2.c | 157 ++++++++++++++++++++-----------------
>  1 file changed, 85 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index f5d6c7a96cf2..231cec1f80e1 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -37,9 +37,9 @@ static const struct clk_pcr_layout sama5d2_pcr_layout = {
>  	.pid_mask = GENMASK(6, 0),
>  };
>  
> -static const struct {
> +static struct {
>  	char *n;
> -	char *p;
> +	struct clk_hw *parent_hw;
>  	unsigned long flags;
>  	u8 id;
>  } sama5d2_systemck[] = {
> @@ -47,14 +47,14 @@ static const struct {
>  	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
>  	 * to keep it enabled in case there is no Linux consumer for it.
>  	 */
> -	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
> -	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
> -	{ .n = "uhpck", .p = "usbck",        .id = 6 },
> -	{ .n = "udpck", .p = "usbck",        .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",        .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",        .id = 9 },
> -	{ .n = "pck2",  .p = "prog2",        .id = 10 },
> -	{ .n = "iscck", .p = "masterck_div", .id = 18 },
> +	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
> +	{ .n = "lcdck", .id = 3 },
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
> +	{ .n = "pck2",  .id = 10 },
> +	{ .n = "iscck", .id = 18 },
>  };
>  
>  static const struct {
> @@ -164,12 +164,12 @@ static const struct clk_programmable_layout sama5d2_programmable_layout = {
>  
>  static void __init sama5d2_pmc_setup(struct device_node *np)
>  {
> +	struct clk_hw *hw, *audio_fracck_hw, *usbck_hw, *main_rc_hw, *main_osc_hw;
> +	const char *slow_clk_name, *main_xtal_name;

Please specify in the commit description why did you changed the variable
names or keep them as before. Valid for the other patches in this series
where this pattern appears.


