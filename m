Return-Path: <linux-kernel+bounces-805051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3CDB4837D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C807A402C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D32236F3;
	Mon,  8 Sep 2025 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rlXVNLXw"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F017A31E;
	Mon,  8 Sep 2025 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307606; cv=none; b=Cg7FWWbULCXjufs9CIEVON7f63l+lnbvqR/Q7uabSV/BtzEJCrlq2g20IIir6E9F7+kIxdmLVqRuidu8IDx0eudly0gI0dayDhkTcRKZp7VxVvn1TymqVHzEIfWTkE3XCh31o6fqUeIsp7Sa+AEoCHEt+OxD5OxTeYE73bBUPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307606; c=relaxed/simple;
	bh=A3d+GyvmXDWrmDIBTpTQ5kTjwafRE1E9JwzCWI92G7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DeqOv+AMCMLqlsg5Gk0dhZk/l/t3RqlM3O1NEuDtvJrprC+CwFhlNe7PANSos7yHwePVIUa/zGuZf43Qx6tpZB9m8kWQl5JqTVS3akZtsGhrpwJoxxWOEbZ4IYiLPcDNWHTszUbCzXZWP6dywn5N653Koi7e1iBEHI92GIuSB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rlXVNLXw; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5884xugx3711758;
	Sun, 7 Sep 2025 23:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757307596;
	bh=4gjZQgW/xl31RdOITnyAsXky79YG3q21/4jeDxToeak=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=rlXVNLXwB0xUZckCDWkqtZ1LvM2p29hsGHtoHircuuSi7o6IsoA9luVjdUHeFYNoh
	 MIWEjDDdvWXaFofVMY/zVtp7W3nct7bMnnCMxzb4G8m+Ir0+eyQC9fApQQ4fMy2AGg
	 xgY0Eyl808we+RYsKQlta531ix48EZJoFL3POH60=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5884xuBw2704947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 23:59:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 23:59:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 23:59:56 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5884xojr290909;
	Sun, 7 Sep 2025 23:59:51 -0500
Message-ID: <b4f81ac3-2db0-42e2-bbd0-e53252b6f962@ti.com>
Date: Mon, 8 Sep 2025 10:29:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4-j742s2-main-common:
 Update DSS EDP integration configuration register
To: Harikrishna Shenoy <h-shenoy@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <m-chawdhry@ti.com>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <aradhya.bhatia@linux.dev>,
        <devarsht@ti.com>, <s-jain1@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
 <20250907182806.1031544-3-h-shenoy@ti.com>
 <7cf605e3-e1be-43e4-ba14-c1310b4f5869@ti.com>
 <d7031274-efac-4837-a8c2-9efef094d71c@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <d7031274-efac-4837-a8c2-9efef094d71c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 08/09/25 10:20, Harikrishna Shenoy wrote:
>
> On 9/8/25 10:07, Beleswar Prasad Padhi wrote:
>> On 07/09/25 23:58, Harikrishna Shenoy wrote:
>>> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
>>> TRM Table 2-1 MAIN Domain Memory Map.
>>> Link:https://www.ti.com/lit/zip/spruj52/SPRUJ52-J84S4 AM69A TRM
>>
>> Broken link
>
> https://www.ti.com/lit/zip/spruj52 , this link will download the zip 


Then maybe put that part only in the link. Otherwise it just shows 404

> and refer the SPRUJ52-J84S4 AM69A TRM.


and put this in the commit message.


Thanks,
Beleswar

>
>>
>>> Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a common file")
>>
>> Above commit only refactored the changes and carried the bug.
>> The commit that introduced this bug should be:
>>
>> 603669b16701 arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
>>
>> Thanks,
>> Beleswar
> Noted
>>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>>> index fbbe768e7a30..f0cda14c2530 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>>> @@ -2573,7 +2573,7 @@ port@1 {
>>>       mhdp: bridge@a000000 {
>>>           compatible = "ti,j721e-mhdp8546";
>>>           reg = <0x0 0xa000000 0x0 0x30a00>,
>>> -              <0x0 0x4f40000 0x0 0x20>;
>>> +              <0x0 0x4f40000 0x0 0x100>;
>>>           reg-names = "mhdptx", "j721e-intg";
>>>           clocks = <&k3_clks 217 11>;
>>>           interrupt-parent = <&gic500>;

