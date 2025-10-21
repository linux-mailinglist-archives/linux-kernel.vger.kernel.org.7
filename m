Return-Path: <linux-kernel+bounces-862237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BF5BF4BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907D34047F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9425F973;
	Tue, 21 Oct 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgObkyJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB1223707
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029524; cv=none; b=tRAjRnFPfx9BMSYe3CrFAB4ECOr2bqpODs/eZ4QFiZaqdVljolip/aA1luILqlq5PBAcxVV6yMbYNsirsJypXJsz9LicIIb0bKoOd5gkCsQwT0qhE7OVQmoiSfMruYn2rZeQ/EJnagCrvy0exNVdai7sTJ1W2WibhupnpzmCg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029524; c=relaxed/simple;
	bh=9aRMxBHEJ8ae6174ZkI8n/5rBXpR8DVeI+noC7rRjBc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LCLNEWF4CvPprgRMxGRG19yYnyt+vLPfXp63YOJWLOKBzSFpmgGP4zm3IXADzq9c4n8pwDcLWnyUv5YT6AreXbaBTSZjNytge5jsU0bkNyN3Ycyqpa3QG0rPLJZJVVmXh9usmUcc6O1/tQwuplfQIusycjxT1mlqFx0i4jH9bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgObkyJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F42C4CEF1;
	Tue, 21 Oct 2025 06:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761029522;
	bh=9aRMxBHEJ8ae6174ZkI8n/5rBXpR8DVeI+noC7rRjBc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CgObkyJsAreKnTeUArXWl8ovk8KSq2zg+KUrJfWc1FETiqTvgx7lXmjtcSW2qfJ3T
	 SLq/oG46PpSp38FODmJ4/U8cRg8Yc6fIMOdUxU3Wn8LOOdvs+mAPR4fBeLmL5r1oGJ
	 f+C0n9O95rji9lDtDN/ReCrCyasCwPoGlIwuSB1RwL9G+02pgS2oIarRrepWYxb6e8
	 Lh605r0mGWEMKC6fEoew8b+mcIhTAcqOuV5vVmSoeGh+88kAKFy0JN6eEo7HlfJwcS
	 CUtLQO8VC8cetqNp7gNT4exinW2/saAFTfPCfFQ1g91fWFdA8iBuJNnTk8AVG05ZlI
	 v4ABmiknzgduw==
Message-ID: <75d0a52d-1662-45f9-ab67-909b906004b3@kernel.org>
Date: Tue, 21 Oct 2025 14:51:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, jeuk20.kim@samsung.com,
 d_hyun.kwon@samsung.com, gyusun.lee@samsung.com, hyenc.jeong@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com, jieon.seol@samsung.com,
 keosung.park@samsung.com, wone.jung@samsung.com
Subject: Re: [PATCH] f2fs: serialize writeback for inline-crypto inodes
To: Jeuk Kim <jeuk20.kim@gmail.com>, jaegeuk@kernel.org
References: <20251016051621.7425-1-jeuk20.kim@gmail.com>
 <5257fece-d947-4a33-8f66-4db5e8b73a28@kernel.org>
 <e26ec66d-36db-429f-befb-8baad14779d9@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <e26ec66d-36db-429f-befb-8baad14779d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/21/25 11:33, Jeuk Kim wrote:
> 
> On 10/16/2025 7:12 PM, Chao Yu wrote:
>> On 10/16/2025 1:16 PM, Jeuk Kim wrote:
>>> From: Jeuk Kim <jeuk20.kim@samsung.com>
>>>
>>> Inline encryption derives DUN from <inode, file offset>,
>>> so bios from different inodes can't merge. With multi-threaded
>>> buffered O_SYNC writes where each thread writes to its own file,
>>> 4KiB-per-page LBA allocation interleaves across inodes and
>>> causes bio split. Serialize writeback for fscrypt inline-crypto
>>> inodes via __should_serialize_io() to keep foreground writeback
>>> focused on one inode and avoid split.
>>>
>>> Test: fio --name=wb_osync --rw=write --bs=1M \
>>>        --time_based=1 --runtime=60s --size=2G \
>>>        --ioengine=psync --direct=0 --sync=1 \
>>>        --numjobs=8 --thread=1 --nrfiles=1 \
>>>        --filename_format='wb_osync.$jobnum'
>>>
>>> device: UFS
>>>
>>> Before -
>>>    write throughput: 675MiB/s
>>>    device I/O size distribution (by count, total 1027414):
>>>      4 KiB:  923139 (89.9%)
>>>      8 KiB:  84798 (8.3%)
>>>      ≥512 KiB: 453 (0.0%)
>>>
>>> After -
>>>    write throughput: 1760MiB/s
>>>    device I/O size distribution (by count, total 231750):
>>>      4 KiB:  16904 (7.3%)
>>>      8 KiB:  72128 (31.1%)
>>>      ≥512 KiB: 118900 (51.3%)
>>>
>>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>>> ---
>>>   fs/f2fs/data.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index ef38e62cda8f..ae6fb435d576 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -3217,6 +3217,8 @@ static inline bool __should_serialize_io(struct inode *inode,
>>>         if (f2fs_need_compress_data(inode))
>>>           return true;
>>> +    if (fscrypt_inode_uses_inline_crypto(inode))
>>> +        return true;
>>>       if (wbc->sync_mode != WB_SYNC_ALL)
>>>           return true;
>>>       if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
>>
>> Jeuk,
>>
>> Can you please try tuning /sys/fs/f2fs/<dev>/min_seq_blocks to see whether it
>> can achive the goal?
>>
>> Thanks,
>>
> Hi Chao,
> 
> Thanks a lot for the suggestion.
> I tried tuning `/sys/fs/f2fs/<dev>/min_seq_blocks` as you mentioned, and it also achieved similar performance improvement on my setup.
> 
> Your approach looks cleaner and better than the one I proposed.
> 
> From what I see, even after reducing this value from the default (2MB) to 512 KB on my local system, there doesn’t seem to be any noticeable performance drop or other side effects.
> Do you see any possible downsides with lowering this value that I might have missed?

Hi Jeuk,

We're using sbi->writepages to serialize large IOs, once you tuned default
value from 2MB to 512KB, in Android, there are threads issue [512K, 2M)
sized IOs, they will join into racing on grabbing the .writepages lock,
I guess that will cause potential performance regression, right?

Thanks,

> 
> Thanks again for your help.
> 


