Return-Path: <linux-kernel+bounces-846175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F9BC7323
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AF304E8B37
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1E1A0B15;
	Thu,  9 Oct 2025 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUoRsDNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81441C2EA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759976728; cv=none; b=XjPFc73NvhyU6p8r1zeyzNSM/3h0bdC9cEo3dH2he09kOehvUIvIJgn26m7zXjJl2v9sA11h3Zyb7eCmEJQoQeMUzrkcf2BgHZ3i75Q657OB1reSig05VZNOJTc9HPfikGU9Xhz4sK4wkm8FZoLEmOFRcXnq+vh37jv0Bo1zeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759976728; c=relaxed/simple;
	bh=vTHUzqFcW/mNj3h30ZYRTuoryqWPNMypz+oxpm5+J2Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UnZFVOPrW1q1tr4Zh7Upl3x087XFgW50XObMMElfpRyLyKqnHDSHrCd8h1CfiQ5EB+dIH0Jk+Mtpf3QUCAPl265rMZSL0gDbfuR30wkHVI8s+OoNGl1FXjGRWwJPbnHnw+J/bBzYj2WudOENIuVV5yEGM/Y6u7OW9Lf6JowL/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUoRsDNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F00C4CEE7;
	Thu,  9 Oct 2025 02:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759976727;
	bh=vTHUzqFcW/mNj3h30ZYRTuoryqWPNMypz+oxpm5+J2Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kUoRsDNyMTjv+cj67esksGIfpPFtp8srOdqrWxjZ5l6L7YaZXT+id9VcnpoLtemfD
	 FApDJAT7tfoGXMhZV0A3zqqorfAOwR00zWkWOhpZ6n9DMRH8eCmmivOQbhu/cjAMpi
	 5rE2Q5d03+rBQe2uieLD6OvzINzZuLxArJlIn1xYosiWHXSLp5qpBdG5NHd06lSADr
	 yGYeAn53AGJYq/EEs+FUMCU48OuINKPnthnBzhiVNC5DTsiKgi8SjWq0MDbAOgKux3
	 XULbTH8cMV/s6F37Gfp6FvpUABdTR0gNY5EU3AeZT7iSVaCpxb46uXPZKNvNmfifd4
	 bpBRWYdyEc/XA==
Message-ID: <849959ea-b86e-400c-a33f-d1d6b1745267@kernel.org>
Date: Thu, 9 Oct 2025 10:25:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, tuan.zhang@amlogic.com, jianxin.pan@amlogic.com
Subject: Re: [PATCH] f2fs: Use mapping->gfp_mask to get file cache for writing
To: Jiucheng Xu <jiucheng.xu@amlogic.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250918-origin-dev-v1-1-8d9877df9e77@amlogic.com>
 <d6609f12-78c2-4a42-b4fd-689b310ec615@kernel.org>
 <f64a9a4c-a90f-4d30-bca2-9d9bc7724121@amlogic.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <f64a9a4c-a90f-4d30-bca2-9d9bc7724121@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2025 11:17 AM, Jiucheng Xu wrote:
> 
> 
> On 9/24/2025 10:25 AM, Chao Yu wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 9/18/25 11:32, Jiucheng Xu via B4 Relay wrote:
>>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>>
>>> On 32-bit architectures, when GFP_NOFS is used, the file cache for write
>>> operations cannot be allocated from the highmem and CMA.
>>
>> Hi,
>>
>> Have you suffered any problem w/o this patch? Can you please describe more
>> details about it?
>>
> Hi Chao,
> 
> Thanks for your comments.
> 
> Our a platform uses a 1.5G DRAM, and the kernel is aarch32.
> We have a critical scenario where system need to record multimedia data
> while replaying the previously recorded multimedia files. However,
> stuttering often occurs during playback. The problem does not arise on
> aarch64 platforms with the same memory size.
> 
> We have analyzed the root cause as follows:
> Data written using GFP_NOFS is only allocated from normal memory. Since
> the normal memory is only 768MB, it easily triggers the kswapd to
> reclaim memory, which in turn reclaims and clears the file cache of the
> recorded data. As a result, during playback, the system fails to hit the
> file cache and thus has to re-read data directly from the storage. Given
> that our storage has relatively poor performance, concurrent read
> (playback) and write (recording) operations lead to significant IO
> latency. High read latency then causes stuttering during playback.

Hi Jiucheng,

Thanks for the explanation.

>>>
>>> Since mapping->gfp_mask is set to GFP_HIGHUSER_MOVABLE during inode
>>
>> GFP_HIGHUSER_MOVABLE includes __GFP_FS, we should avoid using __GFP_FS here.
>> f2fs_write_begin() uses GFP_NOFS like the most of other filesystem to avoid
>> potential deadlock, as __filemap_get_folio(, .. |__GFP_FS | ..) may run into
>> memory reclaim to call ->writeback in where we may suffer deadlock potentially.
>>
> Since our platform only support 5.15 kernel, I have checked
> EXT4/FAT/ntfs3 and find they all use mapping_gfp_mask(mapping)) as GFP

Yes, but also we can see iomap gets rid of using __GFP_FS by default:

struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
{
	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;

	if (iter->flags & IOMAP_NOWAIT)
		fgp |= FGP_NOWAIT;
	if (iter->flags & IOMAP_DONTCACHE)
		fgp |= FGP_DONTCACHE;
	fgp |= fgf_set_order(len);

	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
			fgp, mapping_gfp_mask(iter->inode->i_mapping));
}

> flag to get page cache on kernel 5.15:
> 
> 6100cca:
> ___GFP_HIGHMEM |___GFP_MOVABLE | ___GFP_IO | ___GFP_FS
> |___GFP_DIRECT_RECLAIM |___GFP_KSWAPD_RECLAIM |___GFP_HARDWALL
> |___GFP_SKIP_KASAN_UNPOISON | ___GFP_SKIP_KASAN_POISON
> 
> therefor that's why I recommend this flag.
> 
> I'm not sure if the above flags has some problems on f2fs, so I submit
> it and would be very eager to learn about the views of your experts.

IIRC, f2fs uses GFP_NOFS in ->write_begin for long time w/o any problem, in order
to avoid any potential issue by using ___GFP_FS, and also to consider allowing
memory allocation w/ ___GFP_HIGHMEM & ___GFP_MOVABLE, what about changing as below:

folio = __filemap_get_folio(mapping, index,
			FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_NOFS,
			mapping_gfp_mask(mapping));

Thanks,

> 
> Thanks and Best Regards,
> Jiucheng
> 
>> Thanks,
>>
>>> allocation, using mapping_gfp_mask(mapping) as the GFP flag of getting file
>>> cache for writing is more efficient for 32-bit architectures.
>>>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>> ---
>>>    fs/f2fs/data.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 7961e0ddfca3aaa332b7dbd4985ae7766551834f..9fbc41f9accb2626da22754f1a424da4805ca823 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -3587,7 +3587,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>>>          * Will wait that below with our IO control.
>>>          */
>>>         folio = __filemap_get_folio(mapping, index,
>>> -                             FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
>>> +                             FGP_LOCK | FGP_WRITE | FGP_CREAT,
>>> +                             mapping_gfp_mask(mapping));
>>>         if (IS_ERR(folio)) {
>>>                 err = PTR_ERR(folio);
>>>                 goto fail;
>>>
>>> ---
>>> base-commit: c872b6279cd26762339ff02513e2a3f16149a6f1
>>> change-id: 20250910-origin-dev-8a5ff6bee1f2
>>>
>>> Best regards,
>>
> 


