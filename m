Return-Path: <linux-kernel+bounces-797922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715AB41738
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EF93BABFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853802E0927;
	Wed,  3 Sep 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="nDC4+i3H"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D52DD5F7;
	Wed,  3 Sep 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885884; cv=none; b=ZD9S7RRx5aJZLsj64DxFd+7lhTiJV4Ip3gDKKumJlmfrlB2/5BMPxqM8ybq8VrCgCgd46BwvL3ZKzbWLVkYFzQHq7ZIMee8bE39nGRTimzbLufzAGYNTd/ZqZxekmV5C4veOqaaCwB0lxuAktRlsdPXO2YdkYZY+ZKgxF9L7eec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885884; c=relaxed/simple;
	bh=MWChdqGfz64clvYWyBodzdC+R5zPCzHKItkW4A4hgFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r+7eV0fPah3WA5a7O1j9RysU0dq+g4uIZ1A1GQXOs+R66wWayuq9/xs0sT1jqsy4B6atj5m2MhUtbjl9XHgda+LCyWYcB16gPNbOtIhysqfOFi0B5egCkYYoi880swTPT4TN6Mqe/lOyF7+h+ZAQEHeYCdoJxqE79qlaQTM0svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=nDC4+i3H; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1F39BA06F3;
	Wed,  3 Sep 2025 09:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=QElgaNiZq1zvMjZCZZcc
	+Tq8PfTitADDIX5munfHjFY=; b=nDC4+i3HL9AigOmaugF0rG+1yYi/J6AQS+G2
	ZK618COiL36xqptql1G4POu4Rdz4pjX3xrRs3MEQx7y42It1ylBAHQxaxNIKWZUx
	tTtWV/fEgtp2ofebJQuErJPly7LvUjlG22sU8kcr51s49ItVmooS1Ks2xWdkUDEB
	POrsYRb/dsh4SbrVrx1AHolBMsK0B1cu9oNI8+VyExlgYPhSnpUq4P81OsBNATeO
	JsQxweubc88BattPT7pSYiZtDbB9QnOZacmWMWa3aRQB5PfXgOpqDmGbDnp0LCWm
	4ub+QbERocY1mFM81RsqVkFP1aZiqA9uqzDfSrvnE+54HiZ6sqV5sBTmHlW3cjhV
	i2ajUKr5U0wv+UfETIBoc6YZOhn3DXl3eEU+miGaq8L+MnFwpyz7evysSGe8oBTc
	X4PS0Yr0td58pVKolpdyY3olarr6GenKXGQ6UePpIgiBf0A+be0Dar4WcEpUmMyK
	Lsm5Jvn5ammypt9kq60q4j1x2I6G1bX7HUlSWx+pO5Dd/2NLJhcKb/+BvPyAxLVI
	fN1Rzch82+Ze+pCQ1g3EbReeiUEDauKOF3lkpgaOLdkv5yhAbVkxrXSQ3g4uO1Sx
	pdUq7uq1EhvRzIq0eT0IicxJ8932eHmzW90RfJrndDiHhUAZWN/erXOBDs+5SBC9
	/0FfcqM=
Message-ID: <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
Date: Wed, 3 Sep 2025 09:43:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>, Csaba Buday
	<buday.csaba@prolan.hu>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
 <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E637062

Hi,

On 2025. 09. 03. 9:28, Ahmad Fatoum wrote:
> Hello,
> 
> On 15.08.25 17:17, Bence Csókás wrote:
>> The Ethernet PHY's reset GPIO should be specified in the node of the PHY
>> itself, instead of the MAC (`fec`). The latter is deprecated, and was an
>> i.MX-specific extension, incompatible with the new reset controller
>> subsystem.
> 
> One reason to do it this way is that the PHY is in reset when the OS starts
> and the external phy-reset-gpios allows MAC probe to get the PHY out of
> reset, so it can be probed after reading its vendor/device IDs.
> 
> Does switching to this new binding address this scenario? If so, it should
> be noted in the commit message.

Yes, but after it has been reset, if the platform supports Power 
Management, the PHY's clock will be turned off, which some PHYs (in our 
case the LAN8710) don't tolerate. This has been reported many times, 
just search LKML for "lan8710 reset".

So we want a more general solution [1] where the PHY subsystem resets 
them before enumerating. However, if the MAC driver claims the GPIO, 
then it can't be used by the PHY.

I will clarify the commit msg with this in mind.

[1] 
https://lore.kernel.org/lkml/20250709133222.48802-4-buday.csaba@prolan.hu/

>>
>> Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
>> Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>lan8710 reset
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
>> ---
>>   arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>> index f053358bc9317f8447d65013a18670cb470106b2..0a5e90704ea481b0716d6ff6bc6d2110914d4f31 100644
>> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>> @@ -246,7 +246,6 @@ &fec1 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
>>   	phy-mode = "rmii";
>> -	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
>>   	phy-supply = <&reg_3v3_etn>;
>>   	phy-handle = <&etnphy0>;
>>   	status = "okay";
>> @@ -262,6 +261,13 @@ etnphy0: ethernet-phy@0 {
>>   			pinctrl-0 = <&pinctrl_etnphy0_int>;
>>   			interrupt-parent = <&gpio5>;
>>   			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
>> +			/* Reset SHOULD be a PHY property */
> 
> Comment belongs into commit message.

Agreed.

>> +			reset-names = "phy";
>> +			reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
>> +			reset-assert-us = <100>;
>> +			reset-deassert-us = <25000>;
>> +			/* Energy detect sometimes causes link failures */
>> +			smsc,disable-energy-detect;
> 
> Unrelated change not described in the commit message.

Oh, this has accidentally made it into here from our DT. Thanks for 
spotting it!

> Cheers,
> Ahmad
> 
>>   			status = "okay";
>>   		};
>>   
>>
>> ---
>> base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
>> change-id: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907
>>
>> Best regards,
> 
> 

Bence


