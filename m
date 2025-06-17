Return-Path: <linux-kernel+bounces-689792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEBEADC678
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 11:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2B1164882
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF932BD013;
	Tue, 17 Jun 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idk3egZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A492957CE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152647; cv=none; b=f+B1JoJ0i6NeGbgAVDlc7NSulvFzV6vsHq7eHXO5fh+pjZK5TOtwalk8K25miwnGzBkTyvnkDLJuIRJyoV9c9wQJkFhysMCsEfioxqc73Pu5AH+G+tfVmwutBEhnsRnurH9Z9Kx6wehuZkWPF22j+MdaiyOE23u8V7kWY/ksBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152647; c=relaxed/simple;
	bh=RuBj++1/pe3YouI4HYElxKXPKmVAfwO/glPTZFQJIqg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JLllXNuBYYj2WQelgxskovX/KuNYXsA2dv6B4AE5c4SPHzFJEEjaMSth6UB64dD5Fo+AoeEG187O8SgFvZ91XmT71Vl5LLGjX16+Uy+jLnTQldg964a7wHsB2HmanG1z1vEhZSl2NHK8XPs8lZaLAGQ+CcbbBz1x2Hc9ENYFXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idk3egZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F636C4CEED;
	Tue, 17 Jun 2025 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750152647;
	bh=RuBj++1/pe3YouI4HYElxKXPKmVAfwO/glPTZFQJIqg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=idk3egZ5D7RzFAAQDUK7wM0d6wOWzgqMB6AcmczQVn9lTChWCwO6gtX6w+cDflfKK
	 5P/aCrahSeKH5onrDZaqHDRkWQmsFkBkAcNWR+OMXAPYodRs3W2YOqRijc0a/uSTtG
	 FjMvpXKlfcf1fsi0auxg1W8wcEJUQThGqnkaz3xEyuNLjdgUDUaLMaaT1s5znTr+4t
	 8Xavpi6a5r13dQbzZABuyP0bzepgaKdTp2MLRzJDZ4+Gq3n0+zrIevG83I4qWQ7M+8
	 7gUJ9vsIxGaEeRuYWbzPQ+Ii25fxZ3c+QK7uEG+6yXb4PffCRAOx0pH6SuUubW9vLf
	 j5gl/haEAzjqQ==
Message-ID: <e6a2233f-5f32-4e1a-87b3-4ecb935e3997@kernel.org>
Date: Tue, 17 Jun 2025 17:30:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, feng.han@honor.com, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid non-section-aligned size
 pinned file generation
To: wangzijie <wangzijie1@honor.com>, linux-f2fs-devel@lists.sourceforge.net
References: <6ccfdae1-13f7-421d-b7d3-76883c2e7b8b@kernel.org>
 <20250617073643.2361088-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250617073643.2361088-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 15:36, wangzijie wrote:
>> On 6/17/25 11:57, wangzijie wrote:
>>> To prevent non-section-aligned size pinned file generated from truncation,
>>> add check condition in setattr.
>>>
>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>> ---
>>>  fs/f2fs/file.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 6bd3de64f..72f7d1b4a 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1026,6 +1026,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>>  {
>>>  	struct inode *inode = d_inode(dentry);
>>>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>  	int err;
>>>  
>>>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>>> @@ -1047,6 +1048,11 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>>  			!IS_ALIGNED(attr->ia_size,
>>>  			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
>>>  			return -EINVAL;
>>> +		if (f2fs_is_pinned_file(inode) &&
>>> +			attr->ia_size < i_size_read(inode) &&
>>
>> Do we need to consider attr->ia_size > i_size case?
>>
>> Thanks,
> 
> Hi, Chao
> After commit 3fdd89b452c2("f2fs: prevent writing without fallocate() for pinned
> files"), when we want to write data to pinned file, we need to use pin+fallocate, 
> and we did CAP_BLKS_PER_SEC roundup align when fallocate pinned file:
> 
> block_t sec_len = roundup(map.m_len, sec_blks);
> 
> Even if we truncate the file to a larger size(maybe larger than sec_len, section
> align or not), and write data to offset beyond sec_len, the write will fail(commit
> 3fdd89b452c2 prevent it). The scattered pin block cannot be generated by this way,
> so I did not consider attr->ia_size > i_size case.
> Do you have some suggestions?

Ah, correct, so what about adding comments here to describe why we don't
need consider attr->ia_size > i_size case?

> 
>>> +			!IS_ALIGNED(attr->ia_size,
>>> +			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
>>> +			return -EINVAL;
>>>  	}
>>>  
>>>  	err = setattr_prepare(idmap, dentry, attr);
> 
> 
> 


