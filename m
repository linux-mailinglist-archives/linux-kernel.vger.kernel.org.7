Return-Path: <linux-kernel+bounces-699456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 981ACAE5A54
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 05:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FDF7AFA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC14192D87;
	Tue, 24 Jun 2025 03:05:07 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9B17D7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734307; cv=none; b=POaSG5soNTMpiqGFOA21aeFfRXHoU9DDfpVXjErGK0NJe1zbwIJZlkAbja17MEfOmg405UsxpfkUw0Lj5gYyl/7biyjGQk9cnWmKGLcEGiMhlmAell5Gcsrjnei+dhDvWwTpKJG2Olo7yIqE3QOHzVxqZXVryvB1kC/esb2BLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734307; c=relaxed/simple;
	bh=hvEHYdNnqgBgvpHotKT4vzaUquIfnuX1xhx2B3im+vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhSVH4sSrnZPVgl3hk6IT7V7oEAktpMrXQmsO7LLg2wdwx5V/OPFU0NK8WHwcx7FHm8DrMPn/dzPHYCON0S1AmGbBIIwj2fRownRiCAIQO+S2iRhhPuAe85SCqcfuq7jsYCPmBahxuErc667q/PxrC9oIjC0EqHGEUOfamvmmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55O352gs084330;
	Tue, 24 Jun 2025 12:05:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55O352vA084324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 24 Jun 2025 12:05:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <beff7425-af8f-41af-b47e-6914c9028172@I-love.SAKURA.ne.jp>
Date: Tue, 24 Jun 2025 12:05:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: kill osb->system_file_mutex lock
To: Heming Zhao <heming.zhao@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        jiangyiwen <jiangyiwen@huawei.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        ocfs2-devel@lists.linux.dev,
        Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <934355dd-a0b1-4e53-93ac-0a7ae7458051@I-love.SAKURA.ne.jp>
 <faf70481-09dd-4c7a-bd43-f1e8bec877cb@suse.com>
 <675ea747-5c05-410c-888c-fe6dd2b48d87@I-love.SAKURA.ne.jp>
 <c9467d9e-5cac-49b8-b839-179dc79d0bce@suse.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <c9467d9e-5cac-49b8-b839-179dc79d0bce@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

On 2025/06/24 11:40, Heming Zhao wrote:
> On 6/24/25 10:17, Tetsuo Handa wrote:
>> On 2025/06/24 10:33, Heming Zhao wrote:
>>>> @@ -112,11 +110,10 @@ struct inode *ocfs2_get_system_file_inode(struct ocfs2_super *osb,
>>>>        inode = _ocfs2_get_system_file_inode(osb, type, slot);
>>>
>>> In my view, the key of commit 43b10a20372d is to avoid calling
>>> _ocfs2_get_system_file_inode() twice, which lead refcnt+1 but no place to
>>> do refcnt-1.
>>
>> My understanding is that concurrently calling _ocfs2_get_system_file_inode() itself
>> is OK, for the caller of ocfs2_get_system_file_inode() is responsible for calling
>> iput().
> 
> We have different perspectives on calling _ocfs2_get_system_file_inode().
> In the current code logic, _ocfs2_get_system_file_inode() is expected to
> be called only once. Subsequent local system inodes will be retrieved from
> the cache (via get_local_system_inode()).

That expectation is wrong. Since get_local_system_inode() involves memory allocation,
get_local_system_inode() might return NULL. Therefore, ocfs2_get_system_file_inode(),
which is the caller of get_local_system_inode(), has to be logically prepared for
calling _ocfs2_get_system_file_inode() for multiple times.

This cache is only for speeding lookups up.
This cache does not provide "lookup only once" requirement.

> 
> In my view, your patch has logical errors - at least from my perspective,
> I have to vote NAK.

If you NAK, you have to make sure that get_local_system_inode() never fails.


