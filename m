Return-Path: <linux-kernel+bounces-721853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B3AFCEB3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F3A1605E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7E2E0912;
	Tue,  8 Jul 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bzrORXdC"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211D21322F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987569; cv=none; b=OsY6pNMWr9HmHMQV1qU064wsIvKamLWQSyEQ4pqeKdck/MMDgqQ4M7mWL1HUxTb0/X+Ql85yTXwjn+fsPNZ14KvTxREy2eHVXu+A8fAcX93f7/3eEJdy8wc20R7u5CBv3a6kWKm3ruyxRAap+XAGIx5e0q1U+knnNPHYvk7rOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987569; c=relaxed/simple;
	bh=eMquM51JRSfeYMDza+BVGuZ8kV7EVga+TNgJDqVcsxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zh7YXIc0gBiYolo7YlbhSn789LWBMPlNa4Zvf/peWUVdDIvBgMfMVs3jlsunfWU4HJm9m+EBWHkRiNpvK60ijBD8Q9pHvUhWISg1DHp0k4B2ZPCpQFaB9stJxGRPJTj1Kgjzv++lDhWziADe33e5M+RDg4/2WWAug2ELCLanIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bzrORXdC; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751987558; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iougDzW3D3SBa8Um4dOsc8Bp3F+DjNmLCnoOTK86N+Y=;
	b=bzrORXdCcI+ob0WLOOvgBuPdC+KuHG5aPR4agH6lidnB9wV1ZPHAN5MCPuMibyMwvFG76AQVGEGHVdmuYLR+L8VlEl/QJKTPUEkagCWmVFIFTfRtfshLwsY2ogzi/1tJZkMdbkMZ65UhS6LE1Eqfa0MPJ/y0UDq9ntwWTzK3nZs=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiPkcpx_1751987557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:12:37 +0800
Message-ID: <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:12:35 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 2025/7/8 20:43, Jan Kiszka wrote:
> On 08.07.25 14:41, Jan Kiszka wrote:
>> Hi all,
>>
>> for some days, I'm trying to understand if we have an integration issue
>> with erofs or rather some upstream bug. After playing with various
>> parameters, it rather looks like the latter:
>>
>> $ ls -l erofs-dir/
>> total 132
>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>> (from Debian bookworm)
>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
>> Build completed.
>> ------
>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>> Filesystem total blocks: 17 (of 4096-byte blocks)
>> Filesystem total inodes: 2
>> Filesystem total metadata blocks: 1
>> Filesystem total deduplicated bytes (of source files): 0
>>
>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>> target BeagleBone Black. When booting into init=/bin/sh, then running
>>
>> # mount -t erofs /dev/mmcblk0p1 /mnt
>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>> # /mnt/dash
>> Segmentation fault
>>
>> I once also got this:
>>
>> Alignment trap: not handling instruction 2b00 at [<004debc0>]
>> 8<--- cut here ---
>> Unhandled fault: alignment exception (0x001) at 0x000004d9
>> [000004d9] *pgd=00000000
>> Bus error
>>
>> All is fine if I
>>   - run the command once more
>>   - dump the file first (cat /mnt/dash > /dev/null; /mnt/dash)
> 
> Forgot to mention: That first dump when done via md5sum or so actually
> gives the right checksum. So pure reading of the binary is also ok, just
> trying to load it for execution fails on the first attempt.

Thanks for your report.  I rarely take care arm32 platform
because I don't have such setup.

but could you share a reproducible rootfs image and
I wonder if qemu could reproduce this?

Otherwise it's hard for me to debug this issue...

Thanks,
Gao Xiang

> 
> Jan
> 
>>   - boot a full Debian system and then mount & run the command
>>   - do not compress erofs
>>
>> Also broken is -z zstd, so the decompression algorithm itself should not
>> be the reason. I furthermore tested older kernels as well, namely
>> stable-derived 6.1-cip and 6.12-cip, and those are equally affected.
>>
>> Any ideas? I have CONFIG_EROFS_FS_DEBUG=y, but that does not trigger
>> anything. Is there anything I could instrument?
>>
>> Jan
>>
> 


