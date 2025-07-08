Return-Path: <linux-kernel+bounces-722068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C8EAFD4E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A41B3A46F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600BE2E54DC;
	Tue,  8 Jul 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cHqCTJgc"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEAD2E49A8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994598; cv=none; b=lTwo9gUZjhp9J27fOoTHwh2CkmaH+58USnq13QgYQ0umBdCwDwvgmtun58h6xRSqZ10bSk9psj0HjSKxq3iHiHG31igGPhKEsE/FqFnD2y7YDMz1BoCkkhuISZ2nQSaqIvJ+swwPWdC/n6iklerAjUIRswVKApSqj2jHRNbbcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994598; c=relaxed/simple;
	bh=RJ8lKK34jtZAsxlEvSZTzCYjrP0R66bVRllGawGdVKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bu7kNz6XRXzwoIMY4Yf4PPlPBYQaw0AixZvO4YZDVcgQNdcSis7TN821A5HtuovPTOQJFYZxFJ6lF/KgTAc2XQh7UeBiRhvCUH4MgnriPO3M6VnhcvUFxab0CS5kl4xKb2SAO4uGp5HNyzhZa7SCUAj+Pjhsm/FT9YNTL6LhZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cHqCTJgc; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751994592; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XX/LTMe6pPkmdt3MpUQdcGQ1iSxrolB5ZnpeGne6jZ0=;
	b=cHqCTJgcGwmanPjqEeAkDDGRKF+h89OKV3lULfddU+/yy0wDC7zRIkDVQuWbE8BjtqxfLw0rd13pPR8YSqaasD8+XLaCjbpx2CfABW4nRiB/5v1bQPVsEtZpJx32LQONBRf4y3NAu260u4vAq5ZRzRZiXQTiT948xw4hGNWGOB8=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiQuW0K_1751994590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 01:09:51 +0800
Message-ID: <17432623-6d5d-4a8d-b4ae-8099c589b5e4@linux.alibaba.com>
Date: Wed, 9 Jul 2025 01:09:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Executable loading issues with erofs on arm?
To: Jan Kiszka <jan.kiszka@siemens.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
 <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
 <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
 <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
 <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
 <7f9d35af-d71b-46c5-b0ea-216bbf68dfe7@siemens.com>
 <eb879ced-600a-4dd3-a9d6-3c391b4460c2@siemens.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <eb879ced-600a-4dd3-a9d6-3c391b4460c2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/9 01:01, Jan Kiszka wrote:
> On 08.07.25 18:39, Jan Kiszka wrote:
>> On 08.07.25 17:57, Gao Xiang wrote:
>>>
>>>
>>> On 2025/7/8 23:36, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/7/8 23:32, Gao Xiang wrote:
>>>>>
>>>>>
>>>>> On 2025/7/8 23:22, Jan Kiszka wrote:
>>>>>> On 08.07.25 17:12, Gao Xiang wrote:
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>>>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> for some days, I'm trying to understand if we have an integration
>>>>>>>>> issue
>>>>>>>>> with erofs or rather some upstream bug. After playing with various
>>>>>>>>> parameters, it rather looks like the latter:
>>>>>>>>>
>>>>>>>>> $ ls -l erofs-dir/
>>>>>>>>> total 132
>>>>>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>>>>>> (from Debian bookworm)
>>>>>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm
>>>>>>>>> 1.5)
>>>>>>>>> Build completed.
>>>>>>>>> ------
>>>>>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>>>>>> Filesystem total inodes: 2
>>>>>>>>> Filesystem total metadata blocks: 1
>>>>>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>>>>>
>>>>>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>>>>>>> target BeagleBone Black. When booting into init=/bin/sh, then
>>>>>>>>> running
>>>>>>>>>
>>>>>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>>>>>> # /mnt/dash
>>>>>>>>> Segmentation fault
>>>>
>>>> Two extra quick questions:
>>>>    - If the segfault happens, then if you run /mnt/dash again, does
>>>>      segfault still happen?
>>>>
>>>>    - If the /mnt/dash segfault happens, then if you run
>>>>        cat /mnt/dash > /dev/null
>>>>        /mnt/dash
>>>>      does segfault still happen?
>>>
>>> Oh, sorry I didn't read the full hints, could you check if
>>> the following patch resolve the issue (space-damaged)?
>>>
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index 6a329c329f43..701490b3ef7d 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -245,6 +245,7 @@ void erofs_onlinefolio_end(struct folio *folio, int
>>> err)
>>>          if (v & ~EROFS_ONLINEFOLIO_EIO)
>>>                  return;
>>>          folio->private = 0;
>>> +       flush_dcache_folio(folio);
>>>          folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>>>   }
>>>
>>
>> Yeah, indeed that seem to have helped with the minimal test. Will do the
>> full scenario test (complete rootfs) next.
>>
> 
> And that looks good as! Thanks a lot for that quick fix - hoping that is
> the real solution already.
> 
> BTW, that change does not look very specific to the armhf arch, rather
> like we were lucky that it didn't hit elsewhere, right?

I may submit a formal patch tomorrow.

This issue doesn't impact x86 and arm64. For example on arm64,
PG_dcache_clean is clear when it's a new page cache folio.

But it seems on arm platform flush_dcache_folio() does more
to handle D-cache aliasing so some caching setup may be
impacted.

Thanks,
Gao Xiang

> 
> Jan
> 


