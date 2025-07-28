Return-Path: <linux-kernel+bounces-747627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23949B1360F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BA13B2F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C9922173F;
	Mon, 28 Jul 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md83gGme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF31DE4CE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690052; cv=none; b=p+xWpjC/DViRaixrRtdyvtDjLkthsuiuPCU9CJxCmCDG83UmQSbn2vNbV0pWKXaKs+VmBtJSyw5p93rBq5Q+dQxdW6sJPB1n83taSwWjkrv3whh8m92PJCNwGLbRprOV0zShmYvedNFVZvaWrHTz2b86FePzxNe1DG8x34Rm4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690052; c=relaxed/simple;
	bh=lqV0tgABHCNr5zK2W1ACEsPKJu5VpCezF5PxxjLbB6Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HLO63ZCYoU+2zv9hGy/o3oIdFhU9Nmr/dOwNf3aNtdj7BojKtliSXDn06lQX3pygtFAf79rQVAPh7o25VBuKbVU/EnNHw1rbOsXnDWPBt8A7QT0zAmSmpHdDCpL2CyE0jPfBIknvI1Se5+tnvhJCRVPy3f1qcW0ZiYFKZScqF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md83gGme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D925FC4CEE7;
	Mon, 28 Jul 2025 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753690051;
	bh=lqV0tgABHCNr5zK2W1ACEsPKJu5VpCezF5PxxjLbB6Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Md83gGme9scPaWP59ypo3l5IxBv1vqyDU4N3bnl2ZwkUPo/+XyaQe8Q5bbVR4WX45
	 tMAVTu9b6JfLKhcLMEeCdEvue1LDWriemaFvSxuZO/NQ/v3Q8rBBuExa/Tzd56vCMk
	 0PHh+beicfcBemckzfVQDy39K5EJbGD58ajOKEaDuW9Kspm9b6SROInptA6CIyuFWj
	 GtFPlWHOl8jcdtH84AHuNy2onOm01w/+ILbGENyGR+E+uuqhUs44mnbJswTzbqAao/
	 urGqNggSBkLn+E4RWT8ky2EY2udmrrdvcxszwMMXFAXOlEpcmKI1NUHO2PEwTfcQM8
	 d6JDuKBV+KjQQ==
Message-ID: <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
Date: Mon, 28 Jul 2025 16:07:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, axboe@kernel.dk, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: hanqi <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/25 16:03, hanqi wrote:
> 在 2025/7/28 15:38, Chao Yu 写道:
> 
>> On 7/25/25 15:53, Qi Han wrote:
>>> Jens has already completed the development of uncached buffered I/O
>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>> as Jen mentioned in below path, right?
>>
>> soft-irq
>> - folio_end_writeback()
>>   - filemap_end_dropbehind_write()
>>    - filemap_end_dropbehind()
>>     - folio_unmap_invalidate()
>>      - lock i_lock
>>
>> Thanks,
> 
> That's how I understand it.

So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
you can walk around for write path in this patch.

Thanks,

> 
>>> I have been testing a use case locally, which aligns with Jens' test
>>> case [2]. In the read scenario, using uncached buffer I/O results in
>>> more stable read performance and a lower load on the background memory
>>> reclaim thread (kswapd). So let's enable uncached buffer I/O reads on
>>> F2FS.
>>>
>>> Read test data without using uncached buffer I/O:
>>> reading bs 32768, uncached 0
>>>     1s: 1856MB/sec, MB=1856
>>>     2s: 1907MB/sec, MB=3763
>>>     3s: 1830MB/sec, MB=5594
>>>     4s: 1745MB/sec, MB=7333
>>>     5s: 1829MB/sec, MB=9162
>>>     6s: 1903MB/sec, MB=11075
>>>     7s: 1878MB/sec, MB=12942
>>>     8s: 1763MB/sec, MB=14718
>>>     9s: 1845MB/sec, MB=16549
>>>    10s: 1915MB/sec, MB=18481
>>>    11s: 1831MB/sec, MB=20295
>>>    12s: 1750MB/sec, MB=22066
>>>    13s: 1787MB/sec, MB=23832
>>>    14s: 1913MB/sec, MB=25769
>>>    15s: 1898MB/sec, MB=27668
>>>    16s: 1795MB/sec, MB=29436
>>>    17s: 1812MB/sec, MB=31248
>>>    18s: 1890MB/sec, MB=33139
>>>    19s: 1880MB/sec, MB=35020
>>>    20s: 1754MB/sec, MB=36810
>>>
>>> 08:36:26      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
>>> 08:36:27        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>>> 08:36:28        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>>> 08:36:29        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>>> 08:36:30        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
>>> 08:36:31        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
>>> 08:36:32        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
>>> 08:36:33        0        93    0.00   75.00    0.00    0.00   75.00     7  kswapd0
>>> 08:36:34        0        93    0.00   81.00    0.00    0.00   81.00     7  kswapd0
>>> 08:36:35        0        93    0.00   54.00    0.00    1.00   54.00     2  kswapd0
>>> 08:36:36        0        93    0.00   61.00    0.00    0.00   61.00     0  kswapd0
>>> 08:36:37        0        93    0.00   68.00    0.00    0.00   68.00     7  kswapd0
>>> 08:36:38        0        93    0.00   53.00    0.00    0.00   53.00     2  kswapd0
>>> 08:36:39        0        93    0.00   82.00    0.00    0.00   82.00     7  kswapd0
>>> 08:36:40        0        93    0.00   77.00    0.00    0.00   77.00     1  kswapd0
>>> 08:36:41        0        93    0.00   74.00    0.00    1.00   74.00     7  kswapd0
>>> 08:36:42        0        93    0.00   71.00    0.00    0.00   71.00     7  kswapd0
>>> 08:36:43        0        93    0.00   78.00    0.00    0.00   78.00     7  kswapd0
>>> 08:36:44        0        93    0.00   85.00    0.00    0.00   85.00     7  kswapd0
>>> 08:36:45        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
>>> 08:36:46        0        93    0.00   70.00    0.00    0.00   70.00     7  kswapd0
>>> 08:36:47        0        93    0.00   78.00    0.00    1.00   78.00     2  kswapd0
>>> 08:36:48        0        93    0.00   81.00    0.00    0.00   81.00     3  kswapd0
>>> 08:36:49        0        93    0.00   54.00    0.00    0.00   54.00     7  kswapd0
>>> 08:36:50        0        93    0.00   76.00    0.00    0.00   76.00     1  kswapd0
>>> 08:36:51        0        93    0.00   75.00    0.00    0.00   75.00     0  kswapd0
>>> 08:36:52        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
>>> 08:36:53        0        93    0.00   61.00    0.00    1.00   61.00     7  kswapd0
>>> 08:36:54        0        93    0.00   80.00    0.00    0.00   80.00     7  kswapd0
>>> 08:36:55        0        93    0.00   64.00    0.00    0.00   64.00     7  kswapd0
>>> 08:36:56        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
>>> 08:36:57        0        93    0.00   26.00    0.00    0.00   26.00     2  kswapd0
>>> 08:36:58        0        93    0.00   24.00    0.00    1.00   24.00     3  kswapd0
>>> 08:36:59        0        93    0.00   22.00    0.00    1.00   22.00     3  kswapd0
>>> 08:37:00        0        93    0.00   15.84    0.00    0.00   15.84     3  kswapd0
>>> 08:37:01        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>> 08:37:02        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>
>>> Read test data after using uncached buffer I/O:
>>> reading bs 32768, uncached 1
>>>     1s: 1863MB/sec, MB=1863
>>>     2s: 1903MB/sec, MB=3766
>>>     3s: 1860MB/sec, MB=5627
>>>     4s: 1864MB/sec, MB=7491
>>>     5s: 1860MB/sec, MB=9352
>>>     6s: 1854MB/sec, MB=11206
>>>     7s: 1874MB/sec, MB=13081
>>>     8s: 1874MB/sec, MB=14943
>>>     9s: 1840MB/sec, MB=16798
>>>    10s: 1849MB/sec, MB=18647
>>>    11s: 1863MB/sec, MB=20511
>>>    12s: 1798MB/sec, MB=22310
>>>    13s: 1897MB/sec, MB=24207
>>>    14s: 1817MB/sec, MB=26025
>>>    15s: 1893MB/sec, MB=27918
>>>    16s: 1917MB/sec, MB=29836
>>>    17s: 1863MB/sec, MB=31699
>>>    18s: 1904MB/sec, MB=33604
>>>    19s: 1894MB/sec, MB=35499
>>>    20s: 1907MB/sec, MB=37407
>>>
>>> 08:38:00      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
>>> 08:38:01        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>> 08:38:02        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>> 08:38:03        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>> 08:38:04        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>> 08:38:05        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>> 08:38:06        0        93    0.00    1.00    0.00    1.00    1.00     0  kswapd0
>>> 08:38:07        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:08        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:09        0        93    0.00    1.00    0.00    0.00    1.00     1  kswapd0
>>> 08:38:10        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>> 08:38:11        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>> 08:38:12        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>> 08:38:13        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>> 08:38:14        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>> 08:38:15        0        93    0.00    3.00    0.00    0.00    3.00     0  kswapd0
>>> 08:38:16        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:17        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:18        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:19        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:20        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:21        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:22        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>> 08:38:23        0        93    0.00    3.00    0.00    0.00    3.00     4  kswapd0
>>> 08:38:24        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>> 08:38:25        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>> 08:38:26        0        93    0.00    4.00    0.00    0.00    4.00     3  kswapd0
>>> 08:38:27        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>> 08:38:28        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>> 08:38:29        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>> 08:38:30        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>> 08:38:31        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>> 08:38:32        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>> 08:38:33        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>
>>> [1]
>>> https://lore.kernel.org/all/20241220154831.1086649-10-axboe@kernel.dk/T/#m58520a94b46f543d82db3711453dfc7bb594b2b0
>>>
>>> [2]
>>> https://pastebin.com/u8eCBzB5
>>>
>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>> ---
>>>   fs/f2fs/file.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 696131e655ed..d8da1fc2febf 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -5425,5 +5425,5 @@ const struct file_operations f2fs_file_operations = {
>>>       .splice_read    = f2fs_file_splice_read,
>>>       .splice_write    = iter_file_splice_write,
>>>       .fadvise    = f2fs_file_fadvise,
>>> -    .fop_flags    = FOP_BUFFER_RASYNC,
>>> +    .fop_flags    = FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>>>   };
> 


