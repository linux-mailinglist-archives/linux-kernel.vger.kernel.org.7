Return-Path: <linux-kernel+bounces-828429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE7FB9497A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D01901DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAE30F81A;
	Tue, 23 Sep 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLzxBodV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D222ACEB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609831; cv=none; b=b9WtaDyhIR3uJuRO4CsUFYKZvZN4RsxXPGosSYyENZCDxqq9uLFMjcwoNDqDjRWm6iKQt5KRJsZET3Wm53p+dzCnEM1PBI+jH45KZLLASWg9nJG39u4b7uUrg8iqAF3zlgZPYb5EuhFsBnhgsIyc0y2dGT8wpnFAYWiSiSbvAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609831; c=relaxed/simple;
	bh=WI+kDG0NBORR0mxqib21mmZ3G6zmcmkGVUr+Cua6OwA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WLOlUPZ75De6+PNS9Gdv1nkoidnfMqDj++axSV0uEWc53wq0gU7U4sHd7lAvX/dTjjVMyUc/a9dgNleQ3V+b/zvwGmD1CeeWOvqepDO0b1S1DFWSlu5Ku/Hvhxj9CTW4P6zTdZuQ/eXhQbE7GIPo90q1pR9TW/PUnEBsns4Am34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLzxBodV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D928FC4CEF7;
	Tue, 23 Sep 2025 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758609831;
	bh=WI+kDG0NBORR0mxqib21mmZ3G6zmcmkGVUr+Cua6OwA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rLzxBodVlb5Dgqb5oDjWe+3JPhr19sb0jTaAKZHS2xKZQXmDaz7laeVruHSOcg2mo
	 QTGa8itrh6LZsG64jjjJt7Ovhg+aTU3u5UaGVrEmA0k1eDNkyOcfnHyKblc1+zy30g
	 NWUqa9beOMA1qngB8YZ65eajTe2ZQyBkgcP4iRnfVnMC49Vz5dT2nvatGz5pgOs/kN
	 Je3lTO8amgzh1KHhJQQlqbl8YzEBK/QxcI/CobkF4N7X3QpJyOohs8kOIVGVHxqYH0
	 XbYvIVZcQuhfpCzYzEA5UkgwcTyq+nnve/Fq0kHyVXY8f9KPgMQF/kAWLuaDUaS83I
	 fpmF+z9tA6pqQ==
Message-ID: <21aefe8c-b737-41ea-9efc-9390b6a23c76@kernel.org>
Date: Tue, 23 Sep 2025 14:43:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH 2/2] f2fs: Enhance the subsequent logic of
 valid_thresh_ratio to prevent unnecessary background GC
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
 <20250909134418.502922-3-liaoyuanhong@vivo.com>
 <b42b161d-cd5d-45dc-8e84-c2b28eb632e5@kernel.org>
 <a508b9b8-3c81-4a2c-a525-baac822563b3@vivo.com>
 <22d9f9d1-1db0-4bad-a782-212ab3da630e@kernel.org>
 <3cd3bfb5-857f-4b61-a1c1-55805bed4609@vivo.com>
 <b7b20efb-8cdc-4cf0-a057-d4d41ae66aba@kernel.org>
 <c2c7fbdb-f71c-46aa-a47d-8bd4bec688d4@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <c2c7fbdb-f71c-46aa-a47d-8bd4bec688d4@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/20/25 10:49, Liao Yuanhong wrote:
> 
> On 9/18/2025 10:16 AM, Chao Yu wrote:
>> On 9/17/25 16:13, Liao Yuanhong wrote:
>>> On 9/17/2025 3:57 PM, Chao Yu wrote:
>>>> On 9/17/25 15:08, Liao Yuanhong wrote:
>>>>> On 9/15/2025 4:36 PM, Chao Yu wrote:
>>>>>> On 9/9/25 21:44, Liao Yuanhong wrote:
>>>>>>> When the proportion of dirty segments within a section exceeds the
>>>>>>> valid_thresh_ratio, the gc_cost of that section is set to UINT_MAX,
>>>>>>> indicating that these sections should not be released. However, if all
>>>>>>> section costs within the scanning range of get_victim() are UINT_MAX,
>>>>>>> background GC will still occur. Add a condition to prevent this situation.
>>>>>> For this case, f2fs_get_victim() will return 0, and f2fs_gc() will use unchanged
>>>>>> segno for GC?
>>>>>>
>>>>>> Thanks,
>>>>> You're right, segno won't update in this scenario, and this patch feature is redundant.
>>>> Oh, I meant, if f2fs_get_victim() fails to select a valid victim due to the reason you
>>>> described, f2fs_get_victim() will return 0, and f2fs_gc() will migrate segment #NULL_SEGNO?
>>>> Or am I missing something?
>>>>
>>>> Thanks,
>>> Yes. In this scenario, since it won't enter the|p.min_cost > cost|condition,|p.min_segno|will retain its initial value|||NULL_SEGNO|. This is consistent with what you described.
>> Do you have a script to reproduce this bug?
>>
>> Thanks,
> 
> I didn't explain it clearly. What I mean is that this patch is redundant, the original code is fine.

Oh, I see. I don't see any problem in f2fs_get_victim() as well.

Thanks,

> 
> 
> Thanks,
> 
> Liao
> 
>>>
>>> Thanks,
>>>
>>> Liao
>>>
>>>>> Thanks,
>>>>>
>>>>> Liao
>>>>>
>>>>>>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>>>>>>> ---
>>>>>>>     fs/f2fs/gc.c | 5 +++++
>>>>>>>     1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>>> index 4a8c08f970e3..ffc3188416f4 100644
>>>>>>> --- a/fs/f2fs/gc.c
>>>>>>> +++ b/fs/f2fs/gc.c
>>>>>>> @@ -936,6 +936,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>>>>>>             }
>>>>>>>         }
>>>>>>>     +    if (f2fs_sb_has_blkzoned(sbi) && p.min_cost == UINT_MAX) {
>>>>>>> +        ret = -ENODATA;
>>>>>>> +        goto out;
>>>>>>> +    }
>>>>>>> +
>>>>>>>         /* get victim for GC_AT/AT_SSR */
>>>>>>>         if (is_atgc) {
>>>>>>>             lookup_victim_by_age(sbi, &p);


