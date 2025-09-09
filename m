Return-Path: <linux-kernel+bounces-808885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AEBB505D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C533E3A7071
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71C302172;
	Tue,  9 Sep 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N6SD+vUW"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348D3019AB;
	Tue,  9 Sep 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444644; cv=none; b=AwHBXSTNaUB/m+Nluz0NnDWImaXMxMqNZdL1wDokvkDs5Yf6Ys70O7St1tcQM0pr7XMNMkgUEkGZOkZ+LcZ+1dBzdRncxD6V/1Fm6c3f+ezWMYgocksQtKiZe/DQqOtqjhHwFokJU40BHnVS0RlSBdf17n8lkENpqztGifunSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444644; c=relaxed/simple;
	bh=4ZXWkkS7sHen1h1ofq/ZfAtK2C6D5hCira19oGgWqQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aCAw7N0Th3fRpvJDDrUc02nPQa/Y2NYiOU7izT9OshCFtZq8gk5KtFmiUYoHNdCTcl8PUbWYgxWFTBIt29O3gHFVcMf7vvDRqdiVmF+zSQGJYmwsOQ3MLwSKu0LrKpobXI08itFo/p8G/fU19fykMOjwrQRLnEKEjI6++OpCGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N6SD+vUW; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589J3tfP4168950;
	Tue, 9 Sep 2025 14:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757444635;
	bh=jBsiXYAMRGts/9k3UCrLTmBAn+//joQ0H7f/4sUU6zw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N6SD+vUWXvy3L7yNEBXbyp2CVVjZbhP4/HEhd9dp9eacbws00tbhA494j3NoQKBDf
	 fMsYNg3WqkH3znfLrWRNlmgS0gIIE2Y+H1Uu2vYd4HhE58KqI3FRwn26yh8h3fMxVH
	 fU9UhKL5V3QSjscFTo78rpAhfQSWI2eIck2hfyPI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589J3tqS3990699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 14:03:55 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 14:03:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 14:03:54 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589J3sxK3365664;
	Tue, 9 Sep 2025 14:03:54 -0500
Message-ID: <5eab6ae7-a343-4101-8ae3-fccd5f7ef85c@ti.com>
Date: Tue, 9 Sep 2025 14:03:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62x-sk-common: Enable Main UART
 wakeup
To: Markus Schneider-Pargmann <msp@baylibre.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <khilman@baylibre.com>, <a-kaur@ti.com>
References: <20250904212827.3730314-1-k-willis@ti.com>
 <20250904212827.3730314-2-k-willis@ti.com>
 <DCO4RGJBMTRM.1XNHG5EHBPS24@baylibre.com>
 <DCO4T9E3SGQ5.1J2ARMXFB9ONJ@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <DCO4T9E3SGQ5.1J2ARMXFB9ONJ@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/9/25 03:37, Markus Schneider-Pargmann wrote:
> On Tue Sep 9, 2025 at 10:35 AM CEST, Markus Schneider-Pargmann wrote:
>> On Thu Sep 4, 2025 at 11:28 PM CEST, Kendall Willis wrote:
>>> The Main UART can resume from suspend to RAM states when PIN_WKUP_EN
>>> is enabled. Add the necessary pins needed to wakeup the system. Add the
>>> system idle states that the Main UART can wakeup the system from.
>>>
>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>>> ---
>>>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 +++++++++++++++----
>>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> index 13e1d36123d51..72801cf890d20 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> @@ -163,14 +163,26 @@ &phy_gmii_sel {
>>>   
>>>   &main_pmx0 {
>>>   	/* First pad number is ALW package and second is AMC package */
>>> -	main_uart0_pins_default: main-uart0-default-pins {
>>> +	main_uart0_tx_pins_default: main-uart0-tx-default-pins {
>>>   		bootph-all;
>>>   		pinctrl-single,pins = <
>>> -			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
>>>   			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
>>>   		>;
>>>   	};
>>>   
>>> +	main_uart0_rx_pins_default: main-uart0-rx-default-pins {
>>> +		bootph-all;
>>> +		pinctrl-single,pins = <
>>> +			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
>>> +		>;
>>> +	};
>>> +
>>> +	main_uart0_rx_pins_wakeup: main-uart0-rx-wakeup-pins {
>>> +		pinctrl-single,pins = <
>>> +			AM62X_IOPAD(0x1c8, PIN_INPUT | PIN_WKUP_EN, 0) /* (D14/A13) UART0_RXD */
>>> +		>;
>>> +	};
>>> +
>>>   	main_uart1_pins_default: main-uart1-default-pins {
>>>   		bootph-pre-ram;
>>>   		pinctrl-single,pins = <
>>> @@ -342,8 +354,12 @@ &wkup_uart0 {
>>>   &main_uart0 {
>>>   	bootph-all;
>>>   	status = "okay";
>>> -	pinctrl-names = "default";
>>> -	pinctrl-0 = <&main_uart0_pins_default>;
>>> +	pinctrl-names = "default", "wakeup";
>>
>> I think you may need to add this to the DT binding of the uart device
>> as well.
> 
> Nevermind, I just saw your other series, can you please mention the
> other series as a dependency in the cover letter?

Yes, I will make the dependency clear in the cover letter.

> 
>>
>> Best
>> Markus
>>
>>> +	pinctrl-0 = <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_default>;
>>> +	pinctrl-1 = <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_wakeup>;
>>> +	wakeup-source = <&system_deep_sleep>,
>>> +			<&system_mcu_only>,
>>> +			<&system_standby>;
>>>   };
>>>   
>>>   &main_uart1 {
> 


