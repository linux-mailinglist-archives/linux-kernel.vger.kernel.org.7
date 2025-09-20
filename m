Return-Path: <linux-kernel+bounces-825570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4BFB8C3FA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8556F1C021F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B772F2836A0;
	Sat, 20 Sep 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="KIX9+q9k"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235B2820DB
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357394; cv=none; b=qVLFZOnPnWWD1Wa9HbLcyZ60x/XPmIp2S+iZrfVtZSSlHdr7LSpnbSKkrqjrzT0o1XPXey5f/URjhk/bEfPyXb3zbi8a6LspcRfQArV3gn03vWWBV9IO5beoIiIOzaktcJMYcDteLNaCb7SQAzaaa7pT8GhSMSIMAhuhKo38E+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357394; c=relaxed/simple;
	bh=QJQGLbxn9lFCmMtOVMZa34rVYSu5IRYrBvI46GE1S7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ka4CNchOED41fV1g3PorsLMrcobvIKA6xEpeTnhFQyEoN6Z8KR5rqWfx0wbpkdY4HRdJdGW7UnwLjp6wIYZQxyigz0wSci4vjjm6WSgqSO8hHe6fsvmcp4h1nGuB3jHG4BvbQ/NMmHsZBd6/wuiep2ajS2ZVX1rUfnFZZjELvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=KIX9+q9k; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: Cc: From:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1758357391;
 bh=nhhXvyJU4Q/ep+pG2LVNeGtKFMmPOfCIGjE2903J/IY=;
 b=KIX9+q9krMXHdfedhQg37ioqSyXm2HvaKmHozGxjCB8pnvJXJdMAqwmHvyD7ALfiEmqt1h2j0
 +pRnDxh7Br8YNVVUZHlg1Jy1hTEwYfFN5F8ubFqFhM5vpTIkkrKYZ3/nRgLPy2mb8SFnOmjoONz
 y9Cl89sntnYdqk05VL4bpG1KoVUcqWUXvPgKb2X929FOZIKAVbRmAlQRzcoSggl9qrachs58cKb
 VKOLOerhcgs48oGHSd1hr4ERsKYl9s98T1/LGWhIDDDVfye5ILV2JsMXjE6Q85GqgiLGg3Mtyre
 flelavFiY7Og+bnLziYKhP4sPmE1mN6zBT3PR41AFvBA==
X-Forward-Email-ID: 68ce627a528963d4864a57f8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.14
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <07560892-6672-45a0-aa3d-79e47d145ff4@kwiboo.se>
Date: Sat, 20 Sep 2025 10:14:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: correct uart mux for Radxa ZERO
 3
To: Ed Wildgoose <lists@wildgooses.com>
References: <20250917114932.25994-1-lists@wildgooses.com>
 <20250917114932.25994-2-lists@wildgooses.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20250917114932.25994-2-lists@wildgooses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ed,

On 9/17/2025 1:49 PM, Ed Wildgoose wrote:
> The rk3566 has multiplexed pins and the uarts can be moved to a choice
> of 2 pin groups. The default rk356x-base.dtsi appears to default to mux0
> for all uarts, however, specific hardware might choose to implement
> alternatives
> 
> The Radxa zero 3 shows that is uses M1 for uarts:
> - uart4
> - uart5
> - uart9
> 
> These aren't normally enabled, but we should at least correct the
> default pinctrl definitions. Without these changes there will be
> conflicts with mmc0/mmc1, leading to the SD or eMMC going missing.

Please rephrase the commit subject and message, currently it seem to
imply that there is something broken that needs fixing, however this
mainly make it easier to apply an overlay that does not include
description of any changed behavior for pins on the 40-pin header.

Current expected behavior of the hw, using pins on 40-pin header as gpio
pins should already be correctly described in this board device tree.

My original intent when submitting board device trees, such as this one, 
is that a device tree overlay will fully describe any required changes.
Also I do not expect that using an overlay intended for an old vendor
kernel device tree will work as-is on mainline kernel device tree.

> 
> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
> ---
>  .../boot/dts/rockchip/rk3566-radxa-zero-3.dtsi    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> index 1ee5d96a4..41b3c4403 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> @@ -492,6 +492,21 @@ &uart2 {
>  	status = "okay";
>  };
>  
> +&uart4{

nit: missing space

> +    pinctrl-names = "default";
> +    pinctrl-0 = <&uart4m1_xfer>;

nit: seem to use space instead of tab, same for rest.

Regards,
Jonas

> +};
> +
> +&uart5 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&uart5m1_xfer>;
> +};
> +
> +&uart9 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&uart9m1_xfer>;
> +};
> +
>  &usb_host0_xhci {
>  	status = "okay";
>  };


