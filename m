Return-Path: <linux-kernel+bounces-721913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BFBAFCF6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE73A3E70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367482DF3F8;
	Tue,  8 Jul 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xj0hRcUd"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8ED2DC357
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989030; cv=none; b=hnC3/p0x8j+IV5GBt6yNunc5OGlZWuoNLMpfrusnU6FLRKE3HegjQhdt5OxsL+cjS/hNtfQDQyIFHGvTFQvWaKVynj7HAKxBy1w6YOwaGgNzCUr+u03HtQQ5bpWVYkyA36gfeSnxyx5BjXRfIVHBwWOE+gpp/gqVHshRpwbZMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989030; c=relaxed/simple;
	bh=0RbTi4D1IRWwRmEwd+EtWP8T7PyJew8LCrBFX/p/vN4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FBb5broEH5FRSBvNALLjianNLzfgdHOFxtJo75vOCktBgl/qFshw4ChmcgfsFTcACrQ4lux1xGwVXV0WrEjSIybcDuu53sV2HBqoL3rXxnmknWmy/gfo5NjyKzvCNUYsYq62SqGzS+2KoiNpec0/jLueR63KkXRYQn1dYF1ZA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xj0hRcUd; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751989019; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=l2uN4Cfwt3rAItEjrl964sCyBiqBYAj3m9Q/YHLFzGU=;
	b=Xj0hRcUd5ph1UVBr694YoW0fkFKzJZCWR7Q/1LANMyHcul/YKAj6tJXBRO8JoqUyn2kEtNiijc3zUnYaCuZW3SPTuY6kEcnqv28qF/YNjigfojqdrT9kcFxhlEKTStBnk9dvCMnw9Nq/LbNPXycDfeY7HYMadR8DEKUUtk5P1bk=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiPkkGr_1751989018 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:36:58 +0800
Message-ID: <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:36:57 +0800
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
In-Reply-To: <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/8 23:32, Gao Xiang wrote:
> 
> 
> On 2025/7/8 23:22, Jan Kiszka wrote:
>> On 08.07.25 17:12, Gao Xiang wrote:
>>> Hi Jan,
>>>
>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>> Hi all,
>>>>>
>>>>> for some days, I'm trying to understand if we have an integration issue
>>>>> with erofs or rather some upstream bug. After playing with various
>>>>> parameters, it rather looks like the latter:
>>>>>
>>>>> $ ls -l erofs-dir/
>>>>> total 132
>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>> (from Debian bookworm)
>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
>>>>> Build completed.
>>>>> ------
>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>> Filesystem total inodes: 2
>>>>> Filesystem total metadata blocks: 1
>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>
>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>>> target BeagleBone Black. When booting into init=/bin/sh, then running
>>>>>
>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>> # /mnt/dash
>>>>> Segmentation fault

Two extra quick questions:
  - If the segfault happens, then if you run /mnt/dash again, does
    segfault still happen?

  - If the /mnt/dash segfault happens, then if you run
      cat /mnt/dash > /dev/null
      /mnt/dash
    does segfault still happen?

Thanks,
Gao Xiang

