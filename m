Return-Path: <linux-kernel+bounces-805043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9548B48363
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C2217AD77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB72206AC;
	Mon,  8 Sep 2025 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PwOSnvJZ"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB35315D3A;
	Mon,  8 Sep 2025 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307035; cv=none; b=L3JhmGzHLiXuGXNecKpt9GEWs+5OTNuHjvP0y3bS4EWFTpxksWY3siFigngV0s5CBjlZeFrbQZSS3vfoHOOE68J3W50hy04j94pUEdW81a9VNyo4g1rhmW4hUQlEglbZQctBw8nczD9hfGoNrMf6x6qs7DttFfDjeI2UrtWMRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307035; c=relaxed/simple;
	bh=6xBKoKsl00aNMnroSD1wuhk8+zzzYYZP/evlAdwTsUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lUA9wfcp+orwuCuGzvMbZELtUOYuboI8hFGslQJCJ0Ml6+Bhrv1FRCd8CsLMKXwKV+uummkogQXzVdq5za6CJpbyLnh1SjUwZtc51JJw5skfwB3LLmLW3pw6geqGafUxxTqCnKlyXJdRkmn778OgeSWnvmkLYuGPc7dtxAmOBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PwOSnvJZ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5884oMbF3783000;
	Sun, 7 Sep 2025 23:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757307022;
	bh=UHbxk4G3dD2LMx2NeIsopF4l2D9Ue6grU65JJ7uOsM8=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=PwOSnvJZFjq6g7KO6sslNnZFLIe0mH7cZ11iFSgTYkwmm0kEW8D3RNJym1/aL6j8P
	 tc8VvYoGqd6pACv0GzhkyQsdI0TeDQyW2TPOTqIOzLc+i/dFTJlknJIDYf2bBzBle4
	 yXDun2ZdZ10qE0o0lWqSbyQk4/juJzJRvO0B/iMU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5884oM9x3506260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 23:50:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 23:50:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 23:50:21 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5884oGt04185829;
	Sun, 7 Sep 2025 23:50:17 -0500
Message-ID: <d7031274-efac-4837-a8c2-9efef094d71c@ti.com>
Date: Mon, 8 Sep 2025 10:20:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4-j742s2-main-common:
 Update DSS EDP integration configuration register
To: Beleswar Prasad Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <m-chawdhry@ti.com>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <aradhya.bhatia@linux.dev>,
        <devarsht@ti.com>, <s-jain1@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
 <20250907182806.1031544-3-h-shenoy@ti.com>
 <7cf605e3-e1be-43e4-ba14-c1310b4f5869@ti.com>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <7cf605e3-e1be-43e4-ba14-c1310b4f5869@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/8/25 10:07, Beleswar Prasad Padhi wrote:
> On 07/09/25 23:58, Harikrishna Shenoy wrote:
>> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
>> TRM Table 2-1 MAIN Domain Memory Map.
>> Link:https://www.ti.com/lit/zip/spruj52/SPRUJ52-J84S4 AM69A TRM
>
> Broken link

https://www.ti.com/lit/zip/spruj52 , this link will download the zip and refer the SPRUJ52-J84S4 AM69A TRM.

>
>> Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a common file")
>
> Above commit only refactored the changes and carried the bug.
> The commit that introduced this bug should be:
>
> 603669b16701 arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
>
> Thanks,
> Beleswar
Noted
>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> index fbbe768e7a30..f0cda14c2530 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> @@ -2573,7 +2573,7 @@ port@1 {
>>   	mhdp: bridge@a000000 {
>>   		compatible = "ti,j721e-mhdp8546";
>>   		reg = <0x0 0xa000000 0x0 0x30a00>,
>> -		      <0x0 0x4f40000 0x0 0x20>;
>> +		      <0x0 0x4f40000 0x0 0x100>;
>>   		reg-names = "mhdptx", "j721e-intg";
>>   		clocks = <&k3_clks 217 11>;
>>   		interrupt-parent = <&gic500>;

