Return-Path: <linux-kernel+bounces-821927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A335B82A15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C4A7B0FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0440C1F5434;
	Thu, 18 Sep 2025 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+R5L82H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6B18AFF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161818; cv=none; b=Fy+l0CFD42aGCgQyY4KcjwPNR8DzQt5LPki8tpNHHrKE3emz4Z4WC9Wkmu0Pd/mO1R6GW9sOk0mDdRbkb1uVYpLOYTTMX/quQz46DfMBXbo1KZ+Ram/o91aIBH8ccSvSit+TfHjcD+OMNnx0lkiEZbD9wg8Wzz2Zo0chG3cGgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161818; c=relaxed/simple;
	bh=7Wb0pHEzIG7mtfnM9t7VxEHFQL1mFdj0+KDBCrSulX0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i4g+8kYlbbYlJF/Euk+1A/Xp+oOBaWGt691XBpVSuM9jD+XgygPXZKp3/+A1+w6Er3nJPNaKNJeS6F7ZCC4WDY328wWgvg+86uGN5mf/IYQnPNNRKnQ0ZQ6c4PbhEKLTAeKBrMUZ7hgVCGQxzuug7bnltn/ymxVhl0fDnuTBphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+R5L82H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32094C4CEE7;
	Thu, 18 Sep 2025 02:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758161818;
	bh=7Wb0pHEzIG7mtfnM9t7VxEHFQL1mFdj0+KDBCrSulX0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=d+R5L82HZklANHLi1YzrOxcQmvx8s0shiGA3mUc5B+uhqAeWbhGicG/NSkFsFb9t5
	 OOoFLR8g3El4aaQAqqOW54rzmtsil+ksBfow1E330nZA6BAj07iw2qCsq+mYI4EDOY
	 hdRn/eFHC+mt1ciHFkzOsJScvKwjt9lbUPAYpi+TW9V3JyO6Te7fTqB4tOSRacFJIK
	 Q4gwak5OxYhsnrccyZq9nKlCXw+Zs8ex/H0VGC8cEFhcxFgFzrj7xYOUKu1/SXxxcU
	 PooBCBGSKbi81EjU/1uX/+ylQr/RFEz6AmMSVE8M5I+1+ibsNMZ9JwhvRUXulLwQ2t
	 jIYqhaRzVJlxQ==
Message-ID: <b7b20efb-8cdc-4cf0-a057-d4d41ae66aba@kernel.org>
Date: Thu, 18 Sep 2025 10:16:52 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <3cd3bfb5-857f-4b61-a1c1-55805bed4609@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/17/25 16:13, Liao Yuanhong wrote:
> 
> On 9/17/2025 3:57 PM, Chao Yu wrote:
>> On 9/17/25 15:08, Liao Yuanhong wrote:
>>> On 9/15/2025 4:36 PM, Chao Yu wrote:
>>>> On 9/9/25 21:44, Liao Yuanhong wrote:
>>>>> When the proportion of dirty segments within a section exceeds the
>>>>> valid_thresh_ratio, the gc_cost of that section is set to UINT_MAX,
>>>>> indicating that these sections should not be released. However, if all
>>>>> section costs within the scanning range of get_victim() are UINT_MAX,
>>>>> background GC will still occur. Add a condition to prevent this situation.
>>>> For this case, f2fs_get_victim() will return 0, and f2fs_gc() will use unchanged
>>>> segno for GC?
>>>>
>>>> Thanks,
>>> You're right, segno won't update in this scenario, and this patch feature is redundant.
>> Oh, I meant, if f2fs_get_victim() fails to select a valid victim due to the reason you
>> described, f2fs_get_victim() will return 0, and f2fs_gc() will migrate segment #NULL_SEGNO?
>> Or am I missing something?
>>
>> Thanks,
> 
> Yes. In this scenario, since it won't enter the|p.min_cost > cost|condition,|p.min_segno|will retain its initial value|||NULL_SEGNO|. This is consistent with what you described.

Do you have a script to reproduce this bug?

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
>>>>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>>>>> ---
>>>>>    fs/f2fs/gc.c | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index 4a8c08f970e3..ffc3188416f4 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -936,6 +936,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>>>>            }
>>>>>        }
>>>>>    +    if (f2fs_sb_has_blkzoned(sbi) && p.min_cost == UINT_MAX) {
>>>>> +        ret = -ENODATA;
>>>>> +        goto out;
>>>>> +    }
>>>>> +
>>>>>        /* get victim for GC_AT/AT_SSR */
>>>>>        if (is_atgc) {
>>>>>            lookup_victim_by_age(sbi, &p);


