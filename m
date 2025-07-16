Return-Path: <linux-kernel+bounces-732895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF5B06D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5281D1AA7F31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514D2E7BA9;
	Wed, 16 Jul 2025 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fBE8WM2X"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469102E7651;
	Wed, 16 Jul 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644555; cv=none; b=rWExxFDkCmLGp73PZ9HR0RjjBtLxDF2+NcgBUeFaDPYu7Pj8LSHsannuuX84WsqsTWsScLpnV4+2erZ59czYxk6KDLMoNKU6rsZw1L3YeHqwKdR7ER/9CjE6lA9s4StASgRfXLIq8XXa4cZI4CPH84S6+13L0cCljj/E6vCh7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644555; c=relaxed/simple;
	bh=Q2X7Prq6z8hmWmGjJYGXR2JZUPrs5Jb2CTLdVm01taY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dvnzwiV8E+wm6D5DmUQcMobqUkBLUcjZPNLalpvMmD8EUsUBgWi7UbR9fbzQMfPcbF6IrfBoeLhSiEFhyu/NIOjBmhzS/uqpZLdopFE2Pm3gYsK73PO+0eixyfz+a9ZIGyiRq/8fBHnI+zkyBiPXIgMmKuEchxQT6JLZ9LpuNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fBE8WM2X; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G5gQGj174361;
	Wed, 16 Jul 2025 00:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752644546;
	bh=96YPy9Cz6b75Fg+10gBa9dQ34i3KQ+E5Y0QaJuwByK8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fBE8WM2XgpbwjDoy0MQj5IeJs5KeYID1aIIMUpgQU0OkXTbUbgATZIvQgDoeUy5TF
	 i9VsF0mFsfUf8T992le0BkXXxcLEubtxAtxA9C9t32GAY7shLzJv3UgJr2G36Xa3c0
	 Tm+ihGzns0jPICW2pa6ovGPeIvrHoCUh8HjOnaDw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G5gQM31782819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 16 Jul 2025 00:42:26 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 00:42:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 00:42:26 -0500
Received: from [172.24.227.166] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G5gMBn3807419;
	Wed, 16 Jul 2025 00:42:23 -0500
Message-ID: <710b546f-f898-4b20-8302-db0de69a3d80@ti.com>
Date: Wed, 16 Jul 2025 11:12:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: ti: k3-j721s2-common-proc-board:
 Enable DisplayPort-1
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>
References: <20250624082619.324851-1-j-choudhary@ti.com>
 <20250624082619.324851-7-j-choudhary@ti.com>
 <b37efc4e-0959-47a0-8fae-6cb35899752e@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <b37efc4e-0959-47a0-8fae-6cb35899752e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Udit,

On 26/06/25 16:04, Kumar, Udit wrote:
> 
> On 6/24/2025 1:56 PM, Jayesh Choudhary wrote:
>> Enable DSI display for J721S2 EVM.
>>
>> Add the endpoint nodes to describe connection from:
>> DSS => DSI Bridge => DSI to eDP bridge => DisplayPort-1
>>
>> Set status for all required nodes for DisplayPort-1 as 'okay'.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 89 +++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts 
>> b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> index 793d50344fad..efe857a50bb1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> @@ -93,6 +93,29 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
>>                <3300000 0x1>;
>>       };
>> +    dp1_pwr_3v3: regulator-dp1-prw {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "dp1-pwr";
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        gpio = <&exp4 1 GPIO_ACTIVE_HIGH>; /* P1 - DP1_PWR_SW_EN */
>> +        enable-active-high;
>> +        regulator-always-on;
> 
> Please check once, if this regulator falls under regulator-always-on case,
> 
> I can imagine a case, where DP1 is not used and still regulator is kept on

Yes it is not required.
I will remove this property from j721s2-common-proc-board and am68-sk
board dts.

Thanks,
Jayesh

> 
> 
>> +    };
>> +
>> +    dp1: connector-dp1 {
>> +        compatible = "dp-connector";

[...]

