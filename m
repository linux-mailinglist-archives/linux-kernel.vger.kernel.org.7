Return-Path: <linux-kernel+bounces-764086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F5B21DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE32500DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AD2D780D;
	Tue, 12 Aug 2025 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WZIFBMLo"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3E29BDBF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978585; cv=none; b=c9MX9sjnKizBTNCj2RVtwfYFoS221Q/8hCZ9gvTphr1L4jMr7GfmaJ6D1ZeQG/FGTBbyoD3vuRVXLaxRAYW/acK/AhzMA1bkcYFtqLWrjMHu7f8ZOzmZkL8bDq76DYf7Db8Qs0tGMVp1PJYMnVTs7g0l8pA3Lhrsu/4wLoqzQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978585; c=relaxed/simple;
	bh=u7dRIzZHSo4Khna4vqdpUnZhyi1UcOV9U5XrIiawOE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kw8tX+FQOnu36poKeT1HLrspJZRuBB0qadI7xZ+/a5QwUH/YM4vH1ztCoSMqgAcAykNIvAji2QLRVLazCHD10i54dhNL3Mz/rJQKMb7AzsxgbTJDT1XO/UIgsy4UdTJ2Ay8A0WObWLH34YbKbSTrnZc2xpZDPqbj7IFQ9z5soIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WZIFBMLo; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57C62No81813763;
	Tue, 12 Aug 2025 01:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754978543;
	bh=LKxlbDvFLQZ0H4jE21FQwtxVpoVXTA6dd8wgZE2a5v8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WZIFBMLo0CW8OoHP906jfiQSuaM7Sj+4uKbiiPUuVlJtg9tAZ17Kzpk4qiKitNAvt
	 mc+M5PkSW4r2BO5cJj4Kt/T/Qk9Oa1zVFCeM3Qlk3lc1ozhpAcXgZeC4gnhL8KmGac
	 jWJtuSKJrDSSYKhCyftfvbe72jrXq8/8xK+JER3k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57C62Ncl023237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 12 Aug 2025 01:02:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 01:02:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 01:02:22 -0500
Received: from [10.249.145.16] ([10.249.145.16])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57C62ISw182509;
	Tue, 12 Aug 2025 01:02:19 -0500
Message-ID: <cac3d853-11aa-481b-90bb-aeb2cd4608f8@ti.com>
Date: Tue, 12 Aug 2025 11:32:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] phy: cdns-dphy: hs-clk improvement and a cleanup
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
 <aJM0WPVDUkte9E_D@vaman>
Content-Language: en-US
From: devarsh <devarsht@ti.com>
In-Reply-To: <aJM0WPVDUkte9E_D@vaman>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vinod, Kishon,

On 06/08/25 16:24, Vinod Koul wrote:
> On 05-08-25, 15:03, Tomi Valkeinen wrote:
>> Hi Vinod, Kishon,
>>
>> On 23/07/2025 13:01, Tomi Valkeinen wrote:
>>> A cdns-dphy improvement to return the actual hs clock rate, and a
>>> cleanup to remove leftover code.
>>>
>>> These were part of a Cadence DSI series:
>>>
>>> https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02%40ideasonboard.com/
>>>
>>> but are now separately here for easier merging.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>> ---
>>> Tomi Valkeinen (2):
>>>       phy: cdns-dphy: Store hs_clk_rate and return it
>>>       phy: cdns-dphy: Remove leftover code
>>>
>>>  drivers/phy/cadence/cdns-dphy.c | 24 +++++++++---------------
>>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>> ---
>>> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
>>> change-id: 20250723-cdns-dphy-hs-clk-rate-fix-a8857a5789dd
>>
>> Is this good to merge, and if so, do you have any estimate when? While
>> this is independent from the DSI series, I'd rather push the DSI series
>> into drm-misc about the same time, so both would appear in linux-next
>> relatively together.
> 
> I will start taking patches after merge window closes next monday, so
> next week should be a good estimate

On top of this series [1], we have the cadence DPHY fixes for fixing PLL
lockup timeout [2] and one more patch which enables lower resolutions
[3], both have been reviewed and tested too.

Would it be possible for you too merge all 3 together in below order ?

[1]:
https://lore.kernel.org/all/cc0e4cf5-1bd9-4ae3-a130-0483dbfc6335@ideasonboard.com/
[2]: https://lore.kernel.org/all/20250704125915.1224738-1-devarsht@ti.com/
[3]: https://lore.kernel.org/all/20250807052002.717807-1-h-shenoy@ti.com/

Kindly let us know if anything required from our side.

Regards
Devarsh


