Return-Path: <linux-kernel+bounces-749907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2981AB15499
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6068C5476F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B7224898;
	Tue, 29 Jul 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fCd4wtJf"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D32222D0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823765; cv=none; b=SJOIpLxPsoVr3c4xe6vyAONsTBCucV0/w+F5Mb4RNulq1ferRDlbTMa4bLdjiNmfhpxGyGDVRHCi/G7m7lSEyROElkJM4cFaGXiRgfVzxvhITdolKh0irNBXtL7vN2MAD6n7YFgUnTFqCU+hXVuGFE+wGba1mYY9bv0afAjKzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823765; c=relaxed/simple;
	bh=/mQ5plFUE244s4TmafZw/Z9a9lfv/swUjPEG4ElKJNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbB8aE73OkQuEH9RjnClTHeccRyBPuFZF81Y4ftUxviG6GrVhtpZY4sQllKU48s71bBigTj5c7U97PwBcnFkry1cYK+ASdx0j7MRSaiuZ9OyRhke6YCnW9Tc+wrMbpmpKwJFAMYMu1Fp/ReIEQhOOzMdTkMUJJKIibNqLnHzaa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fCd4wtJf; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753823762;
 bh=e76LF6aEcRNEARMGNURIVQyVQToNTotfPN3MrqTtWjs=;
 b=fCd4wtJf/CjpclsjDkr1C14Wr7l/o7bz45ikC9e6R+LWRI/4JhxUCxmZy5oiAolFkGa/MF0CS
 0MrK6L0xzrr/UZT6t3RZgm1UEWdnXioTr+lvVkbGn9wXgsKlMMSClSsOpfI6PEQG3VSqICADuoM
 HaV0T0y+KqmhrCo6k1uXF09ugOuMMGHiNdqqNagplb7pdLb6/7+A1RktNE91S9eH2Uo27+KyvO0
 5rjdFPxYy8m8djA8st9s7p4efFqTK4bWUuiMEWFTBrU1P+k1FJmyo6WZ1HlnWwcjJw4I5CscU6g
 v8iklTjTiAE/tg/dNc+dGZ94IscQLMWagvVTB03oxTpw==
X-Forward-Email-ID: 688939dd5983c8a2f4b4c57a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <dcbc1c43-748b-479a-878f-569428e09f45@kwiboo.se>
Date: Tue, 29 Jul 2025 23:15:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 ziyao@disroot.org
References: <e2fd11db-543a-43eb-b118-9f246ff149b5@kwiboo.se>
 <20250729132025.2359761-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250729132025.2359761-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2025 3:20 PM, Chukun Pan wrote:
> Hi,
> 
>> Both avddl_1v1 and avddh_3v3 are controlled by the same gpio, I do not
>> remember if using two regulators with same gpios is supported, can only
>> remember it being an issue in the past, so I opted to just describe it
>> as a single regulator and gave it a new name and added labels for the
>> name used in schematic.
>>
>> Would calling it vdd_8367 (after gpio_8367_en) be better or do you have
>> any other suggestion on how to describe these?
> 
> Would it be better to just call it avddh_3v3 and add a comment?
> This makes it easier to find in the schematics and match phy-supply.

It already had a label for avddh_3v3, I am currently thinking something
like following, includes the names from schematic and a name for humans:

	/* Common enable line for the avdd rails mentioned in the labels */
	vdd_switch: avddl_1v1: avddh_3v3: regulator-vdd-switch {
		compatible = "regulator-fixed";
		enable-active-high;
		gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
		pinctrl-names = "default";
		pinctrl-0 = <&gpio_8367_en>;
		regulator-name = "vdd_switch";
		startup-delay-us = <10000>;
		vin-supply = <&vcc5v0_sys>;
	};

> 
>> See above, I had issues using the reset-gpios of the switch, because the
>> switch was probed twice, once deferred by gmac, and by the second probe
>> failed with -BUSY because of the reset-gpios still being claimd by the
>> first probe.
>>
>> I can change to describe the reset pin in the switch, however that will
>> likely mean Ethernet is unusable until the issue in devres/gpiolib is
>> tracked down and fixed by someone.
> 
> I don't think it's a devres/gpiolib issue.
> It looks like these two resets are competing:
> 
>   priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
>   priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> 
> reset-gpios works if reset-names is specified:
> 
> -	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
> +	priv->reset_ctl = devm_reset_control_get_optional(dev, "switch");
> 
> Or just remove the reset controller, I'm not sure if it's really needed:
> 
> -	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
> -	if (IS_ERR(priv->reset_ctl))
> -		return dev_err_cast_probe(dev, priv->reset_ctl,
> -					  "failed to get reset control\n");

Very interesting, my initial testing was to include a call to
devm_gpiod_put() in rtl83xx_remove() but was afraid it could result in a
WARN_ON in case driver was properly unloaded/removed.

  void rtl83xx_remove(struct realtek_priv *priv)
  {
	if (priv->reset)
		devm_gpiod_put(priv-dev, priv->reset);
  }

With reset_control_get using a gpio fallback, this complicates things a
little bit, will run some more tests and probably include a driver patch
for v2, thanks for finding this!

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 


