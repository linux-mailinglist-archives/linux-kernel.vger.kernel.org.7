Return-Path: <linux-kernel+bounces-820189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1FB7E6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46BD4626C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81C2F261F;
	Wed, 17 Sep 2025 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7K0rv1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFF1F5820
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095830; cv=none; b=IxmZtChkiNmeRiQrqHSDZw+R5zUu1NSFFkJpVTKTRfNS1TwzTKXYcWSH7MFxp9DW7AfhG1eHh6+j8fyzzK1ew41uDzVAUuZZtERkNvtnB1pu5VwvlCAVG48jzAtq4xVgItNHCxAEa38CKa6FJ7HvqEXi5JWCHYSuwb9DJMVBj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095830; c=relaxed/simple;
	bh=gqi+Je9O1n+GdXxCwk4Oc1By7Xpu7yNWj4QRpQLsigc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yi0hdj3sTRGWoqeRTbau1tgFd/pJ3WkV+wvGQayJNn8hXtNgmwuVnjcXjROmBHtkXKz53ClMKgb+TFQiuMnZzL0m2N89DkDGadI/slkJ9B2USoPP2ccwIM0d4ucrcfhjJ62djHMYf5gs2rYlCnybwdvAVCKSC/mOmbg0zSJvrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7K0rv1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED502C4CEF0;
	Wed, 17 Sep 2025 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095829;
	bh=gqi+Je9O1n+GdXxCwk4Oc1By7Xpu7yNWj4QRpQLsigc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=d7K0rv1nfYJMKSEpfQg8eREexP6zGEDjiRdCBfGFBI0ObsZuOg2U5ifTG4B+eWmAL
	 KioDVDxasKiU/Yta/7N7fo87KrL1z2rGOkVNULfs9ZHt5X0KraQVqN3D/1so35Q8L0
	 vYxZ/AqPskY1tKMwUVVgTRSgxUrbeP62xbg/65kqBr/ShySPC2r8NWByqkDfjFWOYD
	 mizkk77l0Lt9dbDRIJOUtDBO8aIv0PbtDIm0DMj/WhFF40NIPA9dO7EdzaprQS2lyl
	 wktFXxI8QyGD3ckE3WOV5xtUMCy2XiZY8cXd1hu0khrFm1OkAoUJBA+uApaWkaURMB
	 QSJ5DZe0FlIrQ==
Message-ID: <22d9f9d1-1db0-4bad-a782-212ab3da630e@kernel.org>
Date: Wed, 17 Sep 2025 15:57:06 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a508b9b8-3c81-4a2c-a525-baac822563b3@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/17/25 15:08, Liao Yuanhong wrote:
> 
> On 9/15/2025 4:36 PM, Chao Yu wrote:
>> On 9/9/25 21:44, Liao Yuanhong wrote:
>>> When the proportion of dirty segments within a section exceeds the
>>> valid_thresh_ratio, the gc_cost of that section is set to UINT_MAX,
>>> indicating that these sections should not be released. However, if all
>>> section costs within the scanning range of get_victim() are UINT_MAX,
>>> background GC will still occur. Add a condition to prevent this situation.
>> For this case, f2fs_get_victim() will return 0, and f2fs_gc() will use unchanged
>> segno for GC?
>>
>> Thanks,
> 
> You're right, segno won't update in this scenario, and this patch feature is redundant.

Oh, I meant, if f2fs_get_victim() fails to select a valid victim due to the reason you
described, f2fs_get_victim() will return 0, and f2fs_gc() will migrate segment #NULL_SEGNO?
Or am I missing something?

Thanks,

> 
> 
> Thanks,
> 
> Liao
> 
>>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>>> ---
>>>   fs/f2fs/gc.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 4a8c08f970e3..ffc3188416f4 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -936,6 +936,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>>           }
>>>       }
>>>   +    if (f2fs_sb_has_blkzoned(sbi) && p.min_cost == UINT_MAX) {
>>> +        ret = -ENODATA;
>>> +        goto out;
>>> +    }
>>> +
>>>       /* get victim for GC_AT/AT_SSR */
>>>       if (is_atgc) {
>>>           lookup_victim_by_age(sbi, &p);


