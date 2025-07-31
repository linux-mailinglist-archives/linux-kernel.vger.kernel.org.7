Return-Path: <linux-kernel+bounces-752335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81469B17431
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A229169631
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66451E9B0B;
	Thu, 31 Jul 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8XCqO/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EADC1E377F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977111; cv=none; b=fdBkgaJ0Tv31SIB3CvdCd9/CxEp9eChJocWuhfQzgY9x0o5gBNPbs5wt/TuFVAfKvGfOqGqL4/BFaCUTEbmdO0QkxWYqPkA2kqYynehbjTwg5jXaejnSJrnsK0s2GJ1kz/TAYanDyPyIkzz29YDJ5Yl8IvMFldWQUKrKJD6lBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977111; c=relaxed/simple;
	bh=sGB12Nb5+7kiLqTzx0SVj+FvEp/whs1svfbRU12ISY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1def0zQe8a0T2w87LMBLwyC0dTz5cyibFTYu0esL9+Rvql24I7UY9e3yKxb2k6NB4zihlvpd0Rxt/2k8WbyYdkca6KRAxCGUXxYILOsQy2eOKJvcDPOavvml43qSpAS08jLvuhoHGiIzEJV5nkERQz2qYUK57NJcupx3DMd1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8XCqO/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53349C4CEEF;
	Thu, 31 Jul 2025 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753977110;
	bh=sGB12Nb5+7kiLqTzx0SVj+FvEp/whs1svfbRU12ISY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t8XCqO/GhtH9dT78GjZw3Ht8IVHNOMOQXw5NRBmbC0W2r1Hg8sqDKmlDtpDH25NYC
	 hsIwOBM90sqaAXiiP8NKqpMO+l2x98oGSSc8Si2QvQf9s+8BZJwsptUF9s73+NyCsP
	 gzgJik7DoTZgNpFV5Suuh8Z36XcObm5EoVqqUqemJEwMH9+5GdHY6FouCmDb6WHs4n
	 6s0OAcsyiIqu2RcEisfeB5YUZ6gm9lKszOyXW5qI5bTxORieuydauGUNbiJz7ebpUX
	 4qTeH1f4uMokhttn5nuTm45EiUEoXXFNlSGQs+uavcqzOIGo0GDJVanb65Y5pMdaxG
	 Kjc6/ADOGqPLw==
Message-ID: <af513e6e-b6a0-40ba-acf8-258bd4b95106@kernel.org>
Date: Thu, 31 Jul 2025 17:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Remove forgotten TODO
To: phasta@kernel.org
Cc: David Airlie <airlied@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
 Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250409091413.94102-2-phasta@kernel.org>
 <Z_ZTrZ-dcD5YiSm4@cassiopeiae>
 <481a2808c235f95726d17803503b2b6dc2746dc3.camel@mailbox.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <481a2808c235f95726d17803503b2b6dc2746dc3.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/31/25 5:46 PM, Philipp Stanner wrote:
> On Wed, 2025-04-09 at 13:02 +0200, Danilo Krummrich wrote:
>> (+ Ben)
>>
>> On Wed, Apr 09, 2025 at 11:14:14AM +0200, Philipp Stanner wrote:
>>> commit ebb945a94bba ("drm/nouveau: port all engines to new engine module
>>> format") introduced a TODO to nouveau_chan.h, stating that an
>>> unspecified rework would take place in the "near future".
>>>
>>> Almost 13 years have passed since this "near future", so it can be
>>> safely assumed that the TODO is not needed anymore. Besides, its content
>>> is useless anyways since it does not specify *what* should have been
>>> done.
>>>
>>> Remove the TODO.
>>>
>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>> ---
>>>   drivers/gpu/drm/nouveau/nouveau_chan.h | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
>>> index 016f668c0bc1..3b73ec91c4ff 100644
>>> --- a/drivers/gpu/drm/nouveau/nouveau_chan.h
>>> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
>>> @@ -33,7 +33,6 @@ struct nouveau_channel {
>>>   		u64 addr;
>>>   	} push;
>>>   
>>> -	/* TODO: this will be reworked in the near future */
>>>   	bool accel_done;
>>
>> After having a brief look, it seems that it may has actually been reworked;
>> there is only a single use of accel_done, which is in FIRE_RING(), where it is
>> set to true. But it doesn't seem to be read from anywhere.
>>
>> So, I think we should remove both, the TODO and the accel_done field.
>>
>> @Ben: Maybe you remember the history of this.
> 
> Since we didn't get an answer – how do we want to continue with that,
> Danilo?

Removing the unused accel_done and the corresponding TODO should be fine, let's
do that.

