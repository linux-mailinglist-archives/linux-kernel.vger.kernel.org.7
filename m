Return-Path: <linux-kernel+bounces-712739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4CAF0E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C933A4CF7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AE23816B;
	Wed,  2 Jul 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uugPSulg"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893222F769
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445497; cv=none; b=ds90RYXBll7uwD2PUBtyKo8cCap41+eCwROemdPTHAguksOMHTBMfRcsbyCLuit+IorW02Wty5w89ghjAWqODfJyHxZQeMkJACApheVAYrRdTdpBikM/bjhzWv37vSrTyz0RrnssX0Wc4CVDN9XxokgR9Nw2ZyPb7houIyQj/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445497; c=relaxed/simple;
	bh=8MWI5iiH098s95XJH568ru7FVxWbKtkalmjuKkx+M64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lRKcOk2L4f7Ls/Mp6qt0uIC/1VlsFmDUKWm4pIerlqRr29xw6PpYqOv0QlB/hx+fvq9nAlgPdaBaK5eCb2R/F+XTnj3Zd6/1UgR9O0RhnySyviKemS8lr8swYqwhjK4oe8GiDZWZN82FL3WQOWMUk0muS0zaTeRwQ0ZJzbtE0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uugPSulg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5628bnML3182023;
	Wed, 2 Jul 2025 03:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751445469;
	bh=t1zdbnyiWh8u1SR9sO0+G5ymI2WgryouqWTt/VzIYx0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uugPSulg7qlwsxwqoc++DUagJCz2wJ2ttSS/L1kmCgcX7hCAHBrKyeoU50tDUHesc
	 ub8IRTqHBy1yp9Dwk3OmECuGOaLmnc8WX/ikKQ2gh7GHdvSHKzPZOPZEsP8lKfRlXr
	 zr6fNQQiTiKvOxZeOn7MbIBW+w1QJ6l8cvLon+7k=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5628bmSH3746060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 2 Jul 2025 03:37:48 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 2
 Jul 2025 03:37:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 2 Jul 2025 03:37:47 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5628bibs3108249;
	Wed, 2 Jul 2025 03:37:44 -0500
Message-ID: <a04215a1-3100-45d5-968f-742e09baf9aa@ti.com>
Date: Wed, 2 Jul 2025 14:07:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Decouple max_pclk check from constant display
 feats
To: Jayesh Choudhary <j-choudhary@ti.com>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ideasonboard.com>, <mwalle@kernel.org>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>
References: <20250701095541.190422-1-j-choudhary@ti.com>
 <a0489fea-8c06-4c89-a530-8be691f4705d@ti.com>
 <71b4bd21-573e-4b48-a57f-6496e97d2eff@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <71b4bd21-573e-4b48-a57f-6496e97d2eff@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 02/07/25 12:31, Jayesh Choudhary wrote:
> Hello Devarsh,
> 
> On 01/07/25 19:00, Devarsh Thakkar wrote:
>> On 01/07/25 15:25, Jayesh Choudhary wrote:
>>> In an effort to make the existing compatibles more usable, we are
>>> removing the max_pclk_khz form dispc_features structure and doing the
>>> correspondig checks using "curr_max_pclk[]".
>>>
>>> Changes are fully backwards compatible.
>>>
>>> After integration of OLDI support[0], we need additional patches in
>>> oldi to identify the VP that has OLDI. We have to do this since
>>> OLDI driver owns the VP clock (its serial clock) and we cannot perform
>>> clock operations on those VP clock from tidss driver. This issue was
>>> also reported upstream when DSI fixes[1] had some clock related calls
>>> in tidss driver. When "clk_round_rate()" is called, ideally it should
>>> have gone to "sci_clk_determine_rate()" to query DM but it doesn't since
>>> clock is owned by OLDI not tidss.
>>>
>>
>> As series is fixing above issue (abnormal behaviour while calling 
>> clk_round_rate from tidss for VP clock being used by OLDI), can we add 
>> "Fixes tag" for the patches?
> 
> 
> This seems like a preemptive fix. So I was not sure what to add.
> 
> If it should be added then which commit?
> 7246e0929945 ("drm/tidss: Add OLDI bridge support") ?
> 

Yes, this looks good. I think good to add it as a bug fix since 
otherwise it causes an abnormal behavior while setting up the VP clock 
from tidss.

Regards
Devarsh


> Warm Regards,
> Jayesh
> 
>>
>> Regards
>> Devarsh

