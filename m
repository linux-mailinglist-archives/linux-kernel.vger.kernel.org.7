Return-Path: <linux-kernel+bounces-721947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3413AFCFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0983B20B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658962E264D;
	Tue,  8 Jul 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ft6OHUXF"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EC2E2656
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990244; cv=none; b=LnT+akacvGq8mcTeeS5pLLzohEW4RFN3acMzoa59r/KuTAhP+lWCyRc9q7WWjr16JH4m6q3R5jsXnida2hnmI8yVlh7rLYE7dHWi49Ym8BYunGnjQOj8+v/yiGPvambKqDbY5Bf/3wIkSB/FG0T+KuYhtdcZOOqy4gDaMunReZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990244; c=relaxed/simple;
	bh=Ff1n3JaeAGK+iU5QmC4+7YAHf5VO1pkIrlZRGnSKG20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LGj8WEkDsd8BIJOpZ01+8zOcJBPS3Uw4Wnv/okUbLRm8IhSK/o+UhZf6G8OC56KSJQ10l42yi+v1NvwPrsdPavmNhcs0Ehe3Srh5fue/o+6fHH6ULG70mJjSQVD+kagbvRhI3l/fZOMmUn3LKJH3WAWB2DoyvWKy2YH+E/uuFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ft6OHUXF; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751990237; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=TqIPF46/tpQFzsQ2Mt6/LXt3YG4aD7B79RZab20n59U=;
	b=Ft6OHUXF5ASR5PEMdkjiUIXEUcQysE+qA6jmnd7pU9IPea9uHdOkcIthUsc76BftZWSqPW94ZH6V6NCbG/xZWRB87PJZBZaPWGNgwLauheXZ3Z0yj6pL/PVWBUMNG1In5tRkuF8WSGNJxAN4NTCN5rcYoHuH06eydRjs0g41StI=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiPxJSa_1751990235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:57:16 +0800
Message-ID: <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Executable loading issues with erofs on arm?
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
 <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
 <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
 <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
In-Reply-To: <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/8 23:36, Gao Xiang wrote:
> 
> 
> On 2025/7/8 23:32, Gao Xiang wrote:
>>
>>
>> On 2025/7/8 23:22, Jan Kiszka wrote:
>>> On 08.07.25 17:12, Gao Xiang wrote:
>>>> Hi Jan,
>>>>
>>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> for some days, I'm trying to understand if we have an integration issue
>>>>>> with erofs or rather some upstream bug. After playing with various
>>>>>> parameters, it rather looks like the latter:
>>>>>>
>>>>>> $ ls -l erofs-dir/
>>>>>> total 132
>>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>>> (from Debian bookworm)
>>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
>>>>>> Build completed.
>>>>>> ------
>>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>>> Filesystem total inodes: 2
>>>>>> Filesystem total metadata blocks: 1
>>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>>
>>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>>>> target BeagleBone Black. When booting into init=/bin/sh, then running
>>>>>>
>>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>>> # /mnt/dash
>>>>>> Segmentation fault
> 
> Two extra quick questions:
>   - If the segfault happens, then if you run /mnt/dash again, does
>     segfault still happen?
> 
>   - If the /mnt/dash segfault happens, then if you run
>       cat /mnt/dash > /dev/null
>       /mnt/dash
>     does segfault still happen?

Oh, sorry I didn't read the full hints, could you check if
the following patch resolve the issue (space-damaged)?

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..701490b3ef7d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -245,6 +245,7 @@ void erofs_onlinefolio_end(struct folio *folio, int err)
         if (v & ~EROFS_ONLINEFOLIO_EIO)
                 return;
         folio->private = 0;
+       flush_dcache_folio(folio);
         folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
  }

Thanks,
Gao Xiang

