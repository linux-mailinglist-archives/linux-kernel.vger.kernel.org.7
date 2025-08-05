Return-Path: <linux-kernel+bounces-755817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F13B1AC18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E85188D141
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757435968;
	Tue,  5 Aug 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Loh6LdQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E410FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357529; cv=none; b=FdloMZ7z4tdsc3wqdd1mHH02HqzdQ4Vd5Akx7/1qYojXtIrpkO3LQjEHQkDDypj6ztllsRMtfZIuMZ5Zlg28adTWQWWs5ohakpTp2EJFPOcMZJh8DzY8Y79LKSBO5HumW+dG8Xt38T+wcigEOpZkJwDGGAkwhkgYJXDFGN3YE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357529; c=relaxed/simple;
	bh=FLM7uKtAbdnMkOUiRu41DomYtQ7x7+M3uhDurqbo8io=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=royisXzyo0elVysqejswhJgKTsOkoMItW751U3eREKJSlLmDcuxbioIzLj1UrLabh/8PcYDOpHvc7RR9fuuKyZgeiJXh0EtBHKSHrMfrDdLVKwASZMtVNM36RjhtEoRilKFI3cuJDJEHL9OCNml48ONpmFJVCgUFxSzdMOw7Ba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Loh6LdQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E037DC4CEE7;
	Tue,  5 Aug 2025 01:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754357529;
	bh=FLM7uKtAbdnMkOUiRu41DomYtQ7x7+M3uhDurqbo8io=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Loh6LdQP6tbmD/tbw95uN0wCKkPpBYUHtOEMxHcRkSB+9JKpoCvlsly3q84O+skTC
	 4r7DNlFDUbYNev8AWu+x65Jt1RXjxi87L2BFWbQAuFVuM0JjppDvbA0k1QjM6IimrS
	 7VrxX0z/m79BhjjodIY7oSFc1BJA/GJ13mMG5147Vk9Lrqv9f2wcQROJymztxEPWYb
	 vPM+i3BKDDwAE9Oo2p+wSFc8B5Q+GUmKHgxGzXgPku7+VP2M2gNQQWcQwkSvCS/ETE
	 MWs33fJqY+oIYjEZ12+u1l46JrZjx/eWN8DDiWkKupe/FqzK11+DNYn3oNCr3If4hI
	 E+KIgL59xDnaA==
Message-ID: <f8ab5bbf-79b0-42ac-9c61-d906593b5d8f@kernel.org>
Date: Tue, 5 Aug 2025 09:32:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: Jens Axboe <axboe@kernel.dk>, hanqi <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
 <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
 <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
 <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
 <68c061ad-cbb7-44e8-a905-c13b9ec81c62@kernel.org>
 <e163bbcd-b4d7-4a76-a42f-950f3cb5a644@kernel.dk>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <e163bbcd-b4d7-4a76-a42f-950f3cb5a644@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/25 23:35, Jens Axboe wrote:
> On 7/30/25 8:35 PM, Chao Yu wrote:
>> On 7/30/25 23:20, Jens Axboe wrote:
>>> On 7/28/25 2:28 AM, hanqi wrote:
>>>> ? 2025/7/28 16:07, Chao Yu ??:
>>>>> On 7/28/25 16:03, hanqi wrote:
>>>>>> ? 2025/7/28 15:38, Chao Yu ??:
>>>>>>
>>>>>>> On 7/25/25 15:53, Qi Han wrote:
>>>>>>>> Jens has already completed the development of uncached buffered I/O
>>>>>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>>>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>>>>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>>>>>> as Jen mentioned in below path, right?
>>>>>>>
>>>>>>> soft-irq
>>>>>>> - folio_end_writeback()
>>>>>>>    - filemap_end_dropbehind_write()
>>>>>>>     - filemap_end_dropbehind()
>>>>>>>      - folio_unmap_invalidate()
>>>>>>>       - lock i_lock
>>>>>>>
>>>>>>> Thanks,
>>>>>> That's how I understand it.
>>>>> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
>>>>> you can walk around for write path in this patch.
>>>>>
>>>>> Thanks,
>>>>
>>>> I think the read and write paths can be submitted separately.
>>>> Currently, uncached buffered I/O write requires setting the
>>>> FGP_DONTCACHE flag when the filesystem allocates a folio. In
>>>> f2fs, this is done in the following path:
>>>>
>>>> - write_begin
>>>>  - f2fs_write_begin
>>>>   - __filemap_get_folio
>>>>   As I understand it, if we don't set the FGP_DONTCACHE flag here, this
>>>> issue shouldn't occur.
>>>
>>> It won't cause an issue, but it also won't work in the sense that the
>>> intent is that if the file system doesn't support DONTCACHE, it would
>>> get errored at submission time. Your approach would just ignore the flag
>>> for writes, rather than return -EOPNOTSUPP as would be expected.
>>
>> Jens,
>>
>> Do you mean like what we have done in kiocb_set_rw_flags()?
>>
>> 	if (flags & RWF_DONTCACHE) {
>> 		/* file system must support it */
>> 		if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
>> 			return -EOPNOTSUPP;
>> ...
>> 	}
>>
>> IIUC, it's better to have this in original patch, let me know if I'm
>> missing something.
> 
> Right, that would certainly be required to have it functional on the
> read side but not yet on the write side. Still leaves a weirder gap
> where other file systems (like XFS and ext4) you can rely on if read or
> write support is there, then the other direction is supported too. f2fs
> would be the only one where the read side works, but you get -EOPNOTSUPP
> on the write side.
> 
> Unless there's a rush on the read side for some reason, I think it'd be
> better to have with setting FOP_DONTCACHE until the write side has been
> completed too.

Sure, let's wait for dontcache support in both read&write side, unless something
is blocked in write side, let's see. :)

Thanks,

> 


