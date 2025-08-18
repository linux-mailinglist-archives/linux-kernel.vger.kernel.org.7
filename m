Return-Path: <linux-kernel+bounces-773641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB6B2A3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497B917ACE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1028031E0F9;
	Mon, 18 Aug 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LjBd65TU"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981530F7F8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522384; cv=none; b=rkjFSlPNwQkdVdyUnN5uNI5unHu1WopQ1ZVvp4KLMk6KxSOiMrsLEYIvcJAvpbgUeh/XBenCK7y2hgZNDx5xT39dXdCW4mnWML+TecZqo1heFPJqZ5fvc4+o7OyBvW/Wk9iYb4Ztem030qVbbJYEAyK5muaQPcIADM1ZvlBEVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522384; c=relaxed/simple;
	bh=hJubqCza+faRhnm7uKGNg1RG6HMVPDkgGCJUFb/OCJE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mF+Et54HiDbEUpbu8BrbT+Ny7+dzhkvpUhK9NUMMdh8S2g3HJMm3MMjY9Oxm79Ny8PUapsvTR9tJwaiRRLMwn2s4dsV3kD9TIbYqVDVOfoYyoq+ClsrFL+kZ1hUFMi1yymU+0OtC0OYTnSnqqmUscyBRcDZxNSAQV/UVZpeMXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LjBd65TU; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57ID5ijE3083938;
	Mon, 18 Aug 2025 08:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755522344;
	bh=G/dZgny3HqdfA7AWtx2mQOrx+Lcbf5Q9l2n2ndqcyls=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=LjBd65TUWw6YkiXnw9PWg309LjELR9/eAq/AbIF96ljNNseRM6rufIXSQaBtj+Zg1
	 qKYgqqqaIxddfBzwO19GBm1eYosKG8kXithItDoAiRFQSxzTfwEp5GAz44KX7OnFcf
	 +YiL4rWbtH4vd7ttFCugDXfVS7d/pcJMeC38KgLE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57ID5iF1528241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 08:05:44 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 08:05:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 08:05:43 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.233.62])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57ID5eEf1056903;
	Mon, 18 Aug 2025 08:05:41 -0500
Message-ID: <b0f176de-3476-4e66-ade3-0df39578c3ac@ti.com>
Date: Mon, 18 Aug 2025 18:35:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] phy: cdns-dphy: hs-clk improvement and a cleanup
From: Devarsh Thakkar <devarsht@ti.com>
To: Vinod Koul <vkoul@kernel.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Parth
 Pancholi <parth.pancholi@toradex.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Aradhya Bhatia <aradhya.bhatia@linux.dev>,
        Jayesh
 Choudhary <j-choudhary@ti.com>
References: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
 <cc0e4cf5-1bd9-4ae3-a130-0483dbfc6335@ideasonboard.com>
 <aJM0WPVDUkte9E_D@vaman> <cac3d853-11aa-481b-90bb-aeb2cd4608f8@ti.com>
Content-Language: en-US
In-Reply-To: <cac3d853-11aa-481b-90bb-aeb2cd4608f8@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Gentle reminder.

Hi Vinod,

On 12/08/25 11:32, devarsh wrote:
> Hi Vinod, Kishon,
> 
> On 06/08/25 16:24, Vinod Koul wrote:
>> On 05-08-25, 15:03, Tomi Valkeinen wrote:
>>> Hi Vinod, Kishon,
>>>
>>> On 23/07/2025 13:01, Tomi Valkeinen wrote:
>>>> A cdns-dphy improvement to return the actual hs clock rate, and a
>>>> cleanup to remove leftover code.
>>>>
>>>> These were part of a Cadence DSI series:
>>>>
>>>> https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02%40ideasonboard.com/
>>>>
>>>> but are now separately here for easier merging.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>> ---
>>>> Tomi Valkeinen (2):
>>>>        phy: cdns-dphy: Store hs_clk_rate and return it
>>>>        phy: cdns-dphy: Remove leftover code
>>>>
>>>>   drivers/phy/cadence/cdns-dphy.c | 24 +++++++++---------------
>>>>   1 file changed, 9 insertions(+), 15 deletions(-)
>>>> ---
>>>> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
>>>> change-id: 20250723-cdns-dphy-hs-clk-rate-fix-a8857a5789dd
>>>
>>> Is this good to merge, and if so, do you have any estimate when? While
>>> this is independent from the DSI series, I'd rather push the DSI series
>>> into drm-misc about the same time, so both would appear in linux-next
>>> relatively together.
>>
>> I will start taking patches after merge window closes next monday, so
>> next week should be a good estimate
> 
> On top of this series [1], we have the cadence DPHY fixes for fixing PLL
> lockup timeout [2] and one more patch which enables lower resolutions
> [3], both have been reviewed and tested too.
> 
> Would it be possible for you too merge all 3 together in below order ?
> 
> [1]:
> https://lore.kernel.org/all/cc0e4cf5-1bd9-4ae3-a130-0483dbfc6335@ideasonboard.com/
> [2]: https://lore.kernel.org/all/20250704125915.1224738-1-devarsht@ti.com/
> [3]: https://lore.kernel.org/all/20250807052002.717807-1-h-shenoy@ti.com/
>

As I understand we see [1] got merged to linux-next but [2] and [3] are 
still pending. Could you please let us know if anything further required 
on our side for these two i.e. [2] and [3] ?

Regards
Devarsh

> Kindly let us know if anything required from our side.
> 
> Regards
> Devarsh
> 


