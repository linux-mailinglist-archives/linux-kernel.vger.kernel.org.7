Return-Path: <linux-kernel+bounces-721030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D5AFC3C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019D717F22B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B026158C;
	Tue,  8 Jul 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDOWvthk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD1261574
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958624; cv=none; b=q9DlXw+wXVffuFBDmUwUF3GIaStuxnN8Ad4nhp27QIwNGNu7wFxeV8PBP49WSbodjOAqKIm9s2LpifRAk2VMD45sEZ3KjEpjIlis2FqZcUpyuqUPo6NkVOvKtyBO5ybbKbSJoqOuadtJEYtXkcPxX9UWcL71lea1L7duArFCQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958624; c=relaxed/simple;
	bh=P45Jk/EmJUMA81OY9ojg02wzUNzOoajhvXGsnpXs8Ys=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=At3eV+Hb4HPXX+odePt3UfqEr5y6eJX+KLJGA5EvchxgU4tEqrkwRS8oShx2xFOVhfJiHSs4YO6Xzt+fQkzHwjTu5JllhPJeBLWYMrwfnlrHwd0iOpMUYeqNY/2zFqP1sai1lre/KMc5H8jV80AmWFjgEL4NV11Ohlx5ze9s5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDOWvthk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E6C4CEED;
	Tue,  8 Jul 2025 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751958623;
	bh=P45Jk/EmJUMA81OY9ojg02wzUNzOoajhvXGsnpXs8Ys=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fDOWvthkF/PYY1fFyalR5jpp7QEJLtaZoppHEoYiEUJG02a3bYcDmMSISpa3oMvb0
	 yWlCBQDr83jKppejL5tdrYw2vg4zGGHldEwgorVP0lByMAr7Gy2zYDJOFHVkk2eT65
	 7VUpkxepp9+pII95ix77NMFpzURiTGPRhvmcDwTJef4k7rfEGtWN42prr37wOzLbHD
	 3J7yQensvq3+SnrPD2HOKVRPJFbnsCwyMOHF2UvKzfrt8O1Sv/b74dEoMLalj1otaa
	 xWlcYhEmr5R4f4tlS58rhpwWdQ/a9C8EzhzDXMfq+RgQWbpivHlt7kdqN3mebeYiBm
	 3WGbfo0yt0JWg==
Message-ID: <6edacba6-a97e-460f-af06-96e8acf5546a@kernel.org>
Date: Tue, 8 Jul 2025 15:10:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Hongbo Li
 <lihongbo22@huawei.com>, xiang@kernel.org
References: <20250707084723.2725437-1-chao@kernel.org>
 <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
 <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/25 10:35, Gao Xiang wrote:
> 
> 
> On 2025/7/8 10:30, Hongbo Li wrote:
>>
>>
>> On 2025/7/7 16:47, Chao Yu wrote:
>>> All below functions will do sanity check on m->type, let's move sanity
>>> check to z_erofs_load_compact_lcluster() for cleanup.
>>> - z_erofs_map_blocks_fo
>>> - z_erofs_get_extent_compressedlen
>>> - z_erofs_get_extent_decompressedlen
>>> - z_erofs_extent_lookback
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>>>   1 file changed, 22 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 0bebc6e3a4d7..e530b152e14e 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>>>   static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
>>>                          unsigned int lcn, bool lookahead)
>>>   {
>>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +        erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
>>> +                m->type, lcn, EROFS_I(m->inode)->nid);
>>> +        DBG_BUGON(1);
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>
>> Hi, Chao,
>>
>> After moving the condition in here, there is no need to check in z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo,
>> the condition has been checked in before. Right?
> 
> I've replied some similar question.
> 
> Because z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen()
> use the different lcn (lcluster) against z_erofs_map_blocks_fo().
> 
> So if a new lcn(lcluster number) is loaded, we'd check if the type is valid.

Yeah, Xiang has noticed that previously [1], the case is as below, so we'd better check the
condition in z_erofs_load_compact_lcluster() rather than z_erofs_map_blocks_fo():

- z_erofs_extent_lookback
 - z_erofs_load_lcluster_from_disk
  - z_erofs_load_full_lcluster
  : m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
 - z_erofs_load_compact_lcluster
 : m->type = type;

[1] https://lore.kernel.org/linux-erofs/04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org/

Thanks,

> 
> Thanks,
> Gao Xiang
> 
> 


