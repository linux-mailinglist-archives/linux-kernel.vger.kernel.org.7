Return-Path: <linux-kernel+bounces-749899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2FB15478
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0511547E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92127934B;
	Tue, 29 Jul 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="gqCIwiG4"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59D24EABC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822585; cv=none; b=jZE5hCHs37Fr6yNKUBjwXq5a44SjiEsbtSjahcVFBH3zNYg9pmUOnMN/gh64qeLP5X8CuzlBMa5YwsXQpicNuy4rA4pHLHZ65kvJlKfSwj2kbjWH6yx2x+JXtVwnrru4b5VvhtCT0c3n7qEjSNEUeFCswv6yptmtwxaHVA8WgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822585; c=relaxed/simple;
	bh=Z1Kr26XwW405L9j7UMRlKke0625JiBNeN1OtSRfhsDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVGFe88nvFgm0s4P5e11zPdBMHTaEcdVRKahQr5MLC2kXG2HmNl6rOuZP+BhYRyiDEbwO09YY6Y/0PjPh2AxyT3uNLc/GZFsDJROZO4K8K+UF/1Gzk7UTTkZe2yoywVd2XJxfgW3wew/cCHCEAHxuhUfJs1JzixVzj01UK4xSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=gqCIwiG4; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753822582;
 bh=v+EFRhrySWl3zLJ7XlS9rNLMc1j/yRIrm57mAagtY1s=;
 b=gqCIwiG4BMiE0mElqmp4QBZdK5D9DlxDxEj63+YqL5l9ivG2AvG4FVitWjVC9fZT6ZyYETkCq
 9JPrSL1/wro0a4p3Jha4XmVs1i2eVrxhENzNG5DU0MfnkHbtLnWPHN61qwrP6qjjHJbUWGRxbAf
 yIB+79L5TAjb/CDDlp6CyK19IVRfdkqQegkK9/FB/PWeMC5/13JTRGG2wVOzCUPqibBJ8xNyUl+
 2Ldo1wUCIAPJ3AwCN/qmu8JhQ13/X4Vm55zxYYbSF1T8KVbnPGx/Xjf6fSJghppY8CvVvjlayiK
 UtI6S/Pg+dew807b8SuTVdHViYbaftQshO8WT1VMPu7A==
X-Forward-Email-ID: 688935605983c8a2f4b4a751
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>
Date: Tue, 29 Jul 2025 22:55:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "heiko@sntech.de" <heiko@sntech.de>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "olteanv@gmail.com" <olteanv@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
 <robh@kernel.org>, "ziyao@disroot.org" <ziyao@disroot.org>
References: <5bdd0009-589f-49bc-914f-62e5dc4469e9@kwiboo.se>
 <20250729115009.2158019-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250729115009.2158019-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 7/29/2025 1:50 PM, Chukun Pan wrote:
> Hi,
> 
>> The issue is with TSO and RX checksum offload, with those disabled on
>> the conduit interface (gmac1/eth0) my issues disappeared.
> 
> I did a test today and the same problem occurred when running the new
> kernel on my rk3568 + rtl8367s board. This problem does not exist on
> older kernels (6.1 and 6.6). Not sure where the problem is.

I had only tested on a next-20250722 based kernel and on a vendor 6.1
based kernel. And similar to your findings, on 6.1 based kernel there
was no issue only on the newer kernel.

I will probably drop the use of "/delete-property/ snps,tso" and include
a note in commit message about the TSO and RX checksum issue for v2.

> 
>> With a 'mdio' child node 'make CHECK_DTBS=y' report something like:
>>
>>    rockchip/rk3528-radxa-e24c.dtb: ethernet-switch@1d (realtek,rtl8365mb): mdio: False schema does not allow { [snip] }
>>          from schema $id: http://devicetree.org/schemas/net/dsa/realtek.yaml#
>>
>> With a mdio node the driver is happy and dtschema is sad, and without
>> the mdio node it was the other way around.
> 
> On older kernels (6.1/6.6) only realtek-smi requires mdio child OF node.
> Commit bba140a566ed ("net: dsa: realtek: use the same mii bus driver for both interfaces")
> changed this behavior, both MDIO interface and SMI interface need it
> (rtl83xx_setup_user_mdio), but the dt-bindings has not been updated.
> I think this needs a Fixes tag.

Thanks for finding this, and yes I can see that commit bba140a566ed
changed the behavior of the driver and probably broke out-of-tree users.

My current plan for a v2 is to:
- include a new dt-bindings patch to allow use of a mdio node
- include a mdio node in the switch node
- add a Fixes tag to the driver patch

Then leave up to maintainers to decide if they want to accept this patch
or not.

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


