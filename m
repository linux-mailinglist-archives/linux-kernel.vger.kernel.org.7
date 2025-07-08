Return-Path: <linux-kernel+bounces-721901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A0AFCF43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82151645C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6D21B908;
	Tue,  8 Jul 2025 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tBmnK4KD"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5D233713
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988732; cv=none; b=fPOsj3L+uml4eDCECg5zOsvvj14K2Jiau5kq6HzRFi27ETTzz0ylS8dGLCD6XbYcsETFEDhE9NZfNjSVGd1lf3ua0UJDloRIZ1w2YGDwhYedxqwR7rK/dh5XpY++TvVfMtE5m+1PD92rHCTDyumuLWHx1eleaYfPaC+2Z/+MVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988732; c=relaxed/simple;
	bh=/wv1ujVVYsKxfD9Gx4YbkGRQTRO9miJk819wGwlJTuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cx6wcsnX/XEmwR6pdcQBQvOQZHcBYlbCNFBETZXGRHDzXOLRJLIv3HcpYl/xnAisXVM9Dn6iRgbrelkyYLtRM/ZEN8Dse/M3e+e0N8pdlZr0LnB9znNXSY9CxgDUqerlJlmtVjY9jAR+K00KFMU/AeW8LrSdtiahJwy3K7isah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tBmnK4KD; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751988726; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EeG7VhJ+3VL+xoKGwYSETtPL5tcP8qm4ksM/Bn5qQkg=;
	b=tBmnK4KDH636pBRDuHr9aNhj5NP9hTS7VRSodi/5kFhl0Ik5tH0xLK4R1+x7N7Ux+oxPq414uVHqE8DzkXtmTxeY/TxsZNRAomPO+Xqpwn4So1HSu7KA/x87SL1W+SYXPU/0VQtipJxmtILVDWtRcf8ZV31nLJ7O84oUysMlpmU=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiPlTZ4_1751988724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:32:05 +0800
Message-ID: <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:32:03 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/8 23:22, Jan Kiszka wrote:
> On 08.07.25 17:12, Gao Xiang wrote:
>> Hi Jan,
>>
>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>> Hi all,
>>>>
>>>> for some days, I'm trying to understand if we have an integration issue
>>>> with erofs or rather some upstream bug. After playing with various
>>>> parameters, it rather looks like the latter:
>>>>
>>>> $ ls -l erofs-dir/
>>>> total 132
>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>> (from Debian bookworm)
>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
>>>> Build completed.
>>>> ------
>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>> Filesystem total inodes: 2
>>>> Filesystem total metadata blocks: 1
>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>
>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>> target BeagleBone Black. When booting into init=/bin/sh, then running
>>>>
>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>> # /mnt/dash
>>>> Segmentation fault
>>>>
>>>> I once also got this:
>>>>
>>>> Alignment trap: not handling instruction 2b00 at [<004debc0>]
>>>> 8<--- cut here ---
>>>> Unhandled fault: alignment exception (0x001) at 0x000004d9
>>>> [000004d9] *pgd=00000000
>>>> Bus error
>>>>
>>>> All is fine if I
>>>>    - run the command once more
>>>>    - dump the file first (cat /mnt/dash > /dev/null; /mnt/dash)
>>>
>>> Forgot to mention: That first dump when done via md5sum or so actually
>>> gives the right checksum. So pure reading of the binary is also ok, just
>>> trying to load it for execution fails on the first attempt.
>>
>> Thanks for your report.  I rarely take care arm32 platform
>> because I don't have such setup.
>>
>> but could you share a reproducible rootfs image and
>> I wonder if qemu could reproduce this?
> 
> The image can be generated from isar-cip-core
> (https://gitlab.com/cip-project/cip-core/isar-cip-core), bbb image with
> swupdate extension and erofs as immutable rootfs. As I wrote, those will
> be 6.12 or 6.1 based, but I also injected a mainline kernel into that
> with the same result. But all that only helps if you have some
> beaglebone black in reach right now.

Could you check 5.4 lts, 5.15 lts, 5.10 lts if possible?

I wonder if it's a regression or it does not work from
the beginning. Anyway, I have no chance to look after arm32
due to lack of use cases and hardware resource.

> 
> The same configuration, just for qemuarm as target, unfortunately does
> not reproduce the issue.

That is too bad for me honestly because I do think it's much
easier for me to quickly shooting down with a reproducable
environment on my side...

> 
>>
>> Otherwise it's hard for me to debug this issue...
> 
> If you tell me how I could do that, I'm happy to instrument and analyze.
> I just have no understanding of erofs yet, specifically how reading
> files might be different from loading executables.

I have no idea too.  But it seems this issue is quite similar to
https://lore.kernel.org/r/76f0ea6f-d4c2-434a-8ca5-4bd93921209f@linux.alibaba.com/T/#t

I've given several ways to help finding the cause, but it
seems that data checksum is all good, and that issue is
still not resolved now either.

Thanks,
Gao Xiang

> 
> Jan
> 


