Return-Path: <linux-kernel+bounces-798026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1878B41887
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C00E547A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43102ED166;
	Wed,  3 Sep 2025 08:28:59 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DA2ECEB8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888139; cv=none; b=oz9Ix9QjdB3sDFr0NN/KiCIy/HV56pXAYRkbUsFOSZeR3fiRdWiwVE7OQHa5Gf8oRB1Et33rv7CQfvUngcq8ilI15fqRsSsALPboZCHg/MQadGd2WAsDeEHlefCjhbgiCIWMUQQdVl1pzkBliISFYh3RF6FLPYOcAW90Ge2EUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888139; c=relaxed/simple;
	bh=NINH+7RW+iIpNTyQMVL/D0TplY6oTWE3aNOfI4gj8H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpXaoAxMnR65fy+ejlrAJrxHulXc6IXiq1G44Gm5wIoLWg4VQZNrlwwwVfiUDNF3pkVe1TSo0QxXVO7Dwh57n5l+JxkpIzgi2Tl9hh2JLFwRqQz/kJGJbIVRxeR+zAXc6Nm9nIdVdM0MsAkarCn12k/DgeAmwq+v4QiPqSkrxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1756888125t2bf0b974
X-QQ-Originating-IP: hNMMUBWBZAMjlucA+xBTHqWVycX+g2+pxJSCJlsVS4I=
Received: from [IPV6:240f:10b:7440:1:81b2:3bee ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Sep 2025 16:28:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13612785056484846069
Message-ID: <57969F385B5AF318+653dac83-8227-4987-84c6-f3e08b10085c@radxa.com>
Date: Wed, 3 Sep 2025 17:28:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add Radxa CM5 module and IO board dts
To: Joseph Kogut <joseph.kogut@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jimmy Hon <honyuenkwun@gmail.com>
Cc: Steve deRosier <derosier@cal-sierra.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250617-rk3588s-cm5-io-dts-upstream-v5-0-8d96854a5bbd@gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250617-rk3588s-cm5-io-dts-upstream-v5-0-8d96854a5bbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OEujKQTXCsr9xOLb3rsDiN5M07As5KSTMarFNZ02KICgUtoEM1FaTkSU
	AoS/OnefB2apHcRVbSwWZqny7OF4SddNHsQdplI//V2unRW6Ob7+dmzcgUo6KXqQgl/xdEH
	P7xjAOX2W1EnYE7oU8ZbSg9rIsAYhcFiEs4dy9zZv3HYRaojgWZ0Hefph3gIOO8Xd0jc8Ae
	IfkrMUsvxDqS/Ml7PS6bAro1k4DpgVPISjF4ebuWXRWQs+w8EzB+Ts0A0RX92se+zceGRJV
	SMPr4Q7DMx1tF5mjr0wtvDmKURVL2iNlW4DhhHWBJ32qLNIfDLErWJASRIdNPDZZQyYsHKi
	DqV7TvCbrRPelofe2i8qdt1N7hMNi68Cg18Pdbt9W5IrM8LVHivWA7HU21R3Y/Olva/6Gmy
	j1w+zloot9eT+Ut5jRf8Wv5RG82LhWNmOwJGJgHk0VrAhZlitr0fLSSuNA57c3+RHFkRv/z
	NlFw/0O+QTCysOXAGDTRJUK6R5CnecS/WSiAvuMrQBsAj0RLJMoXUQwoGw7eiqcpMwNdaMJ
	6jK84wDhX4GQSgJO1HgEGS4qqUy4MMEt8KXUN1e1sXJ87nQ3qU0quAlanvkcmjjk7fXEkHj
	sq51KlogpBAJfiohbIACIQChZEjUiaGSeuWAXck8bZzTNaVvOUMMXOuRS4sqwBqVI8BgO7Q
	b5DhD0MTgW6hhWIv3X+eacNEC81lTpS1jKqrrl/TonSkf29KsFI1pLXkXpWhXDtt95vUnaG
	boXJwfv8vvFB31ZLKozraaiicnk7pZZzbu1dp7aGIfatTD8OnOAhAXgBlV0Hym0n/p4fAm6
	S/4Boe+sjA47CH4JHUHRfHMMz4uB8IBX3bs3IUj9rw/5ewltQDvd/mzEu0b8fZRI//VsG5E
	wa2scbKGoviFFRFOVJ4T/ULHfQMsAnpkygXJpGli85MRXEcV0m5zhr0RbbtZsbcN7InxjtJ
	ejnhPg/k4b81T7SeWUQI3yPbfeSJq5VLRq8UvwHHPQwOMvDwyomIrwvtXaUlzLmf/1GbJCW
	xcc68ynWf19xEiKL76wJNL5PGjckHwcthNRuIFtLY6CLEfXf6BCBikqjKlkYNLBPtWl9lMH
	uXW37rjueHdk8HWpCgwgiMMUKbowDkUwQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3

Hi Joseph,

I'm thinking of continuing your work, so if you've already done 
something, please let me know.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 6/18/25 07:11, Joseph Kogut wrote:
> This patch series adds initial device tree support for the Radxa CM5 SoM
> and accompanying IO board.
> 
> V4 -> V5:
>    Patch (2/3), per Jimmy:
>    - Alias eMMC to mmc0
>    - Remove unused sdio alias
>    - Move gmac, hdmi0 nodes to carrier board dts
> 
>    Patch (3/3), per Jimmy:
>    - Enable hdmi0_sound and i2s5_8ch
>    - Remove redundant enablement of sdhci
>    - Enable usb_host2_xhci
> 
>    - Tested HDMI audio
> 
> V3 -> V4:
>    - Fixed XHCI initialization bug by changing try-power-role from source
>      to sink
> 
> V2 -> V3:
>    - Addressed YAML syntax error in dt binding (per Rob)
>    - Fixed whitespace issue in dts reported by checkpatch.pl
>    - Split base SoM and carrier board into separate patches
>    - Added further details about the SoM and carrier to the commit
>      messages
> 
> V1 -> V2:
>    - Added copyright header and data sheet links
>    - Removed non-existent property
>    - Sorted alphabetically
>    - Removed errant whitespace
>    - Moved status to the end of each node
>    - Removed pinctrl-names property from leds (indicated by CHECK_DTBS)
>    - Removed delays from gmac with internal delay
> 
> - Link to v4: https://lore.kernel.org/r/20250605-rk3588s-cm5-io-dts-upstream-v4-0-8445db5ca6b0@gmail.com
> 
> Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
> ---
> Joseph Kogut (3):
>        dt-bindings: arm: rockchip: Add Radxa CM5 IO board
>        arm64: dts: rockchip: Add rk3588 based Radxa CM5
>        arm64: dts: rockchip: Add support for CM5 IO carrier
> 
>   .../devicetree/bindings/arm/rockchip.yaml          |   7 +
>   arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>   .../boot/dts/rockchip/rk3588s-radxa-cm5-io.dts     | 486 +++++++++++++++++++++
>   .../arm64/boot/dts/rockchip/rk3588s-radxa-cm5.dtsi | 135 ++++++
>   4 files changed, 629 insertions(+)
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250605-rk3588s-cm5-io-dts-upstream-f4d1e853977e
> 
> Best regards,


