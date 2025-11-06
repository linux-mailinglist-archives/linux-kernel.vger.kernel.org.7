Return-Path: <linux-kernel+bounces-889255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E7C3D141
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 449774E3502
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4334D92F;
	Thu,  6 Nov 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOV+8Ut1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08828725F;
	Thu,  6 Nov 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453988; cv=none; b=cU6vJmkMr+wMqeQgqFuaV29zE8NbsgVvPgX3U/3VfkP98pZgaLzvXkhJIpIwSnDos5XLWLPbEH9O6k0qGobkt8fJshh8Orr9yAhUG00fWoryRwqrgPuc4+nB3NZdRhdH8xphD4DODvG15vNoB8kqEToCI8EIL17Dzgi5Jyvw8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453988; c=relaxed/simple;
	bh=kyEhNYI7HzIpb2ZS57YS899tQPqI51sWObp1JT+wH0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bg5MccuOuDb4tkXkX8+iHyx+gOQf1u9J/yKrVdeUo7CaV3Q3qaxqfWdNS4xxznciIFP63uwqOZb11sJTIiLHgT0C3ABnJMTGvpCLa3S+ySsf9Z84GFuCJGroH/33DyyxbpHnzr7sEEuJJsEleMNy9aoyNZKk27BN+yOOz9FtJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOV+8Ut1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37256C4CEFB;
	Thu,  6 Nov 2025 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762453982;
	bh=kyEhNYI7HzIpb2ZS57YS899tQPqI51sWObp1JT+wH0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gOV+8Ut1d6OcGYc3ICn04IZJW//qT27NjmUtjJ6+mBW1NT1FFiv7zt7i+LtlVYr2u
	 +QyjsqeXE8Sn2oMnEma69cqZnz8E2bs97Zd21gVcE9G+lLR2h4a7HI13S60l+iXsVs
	 u16usha+Jdk67Zl7zF3UaT+UJVxWp7m1yJ0qB6+oG9KS25zWNmVHJlSDFSZzRv2+1P
	 ZAYKzpGNv6p3B4Q/kW+nI41gjOTNrhNvKKK58r6zgnYp52LIMmln8DYOxYVB3Nv6qw
	 s3UQNBSNhXrmD9+XPEWOMgXKSUBynWUYAenY7fGvck8RU/W1+bGVm9+C4zQls2P0Us
	 cwmLU7tUs0DRg==
Message-ID: <4791720d-59ac-4cbb-9a72-74d3dcb55a2a@kernel.org>
Date: Thu, 6 Nov 2025 11:33:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] fs/ntfs3: Initialize allocated memory before
 use
To: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>,
 almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev,
 syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com,
 syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
References: <20251105211808.260893-1-kubik.bartlomiej@gmail.com>
From: Khalid Aziz <khalid@kernel.org>
Content-Language: en-US
In-Reply-To: <20251105211808.260893-1-kubik.bartlomiej@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 2:18 PM, Bartlomiej Kubik wrote:
> KMSAN reports: Multiple uninitialized values detected:
> 
> - KMSAN: uninit-value in ntfs_read_hdr (3)
> - KMSAN: uninit-value in bcmp (3)
> 
> Memory is allocated by __getname(), which is a wrapper for
> kmem_cache_alloc(). This memory is used before being properly
> cleared. Change kmem_cache_alloc() to kmem_cache_zalloc() to
> properly allocate and clear memory before use.
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Fixes: 78ab59fee07f ("fs/ntfs3: Rework file operations")
> Tested-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
> Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Fixes: 78ab59fee07f ("fs/ntfs3: Rework file operations")
> Tested-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
> Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
> 
> Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
> ---

Looks good to me.

Reviewed-by: Khalid Aziz <khalid@kernel.org>

--
Khalid

>   fs/ntfs3/inode.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index ab61388f819c..13720baf079d 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1281,7 +1281,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
>   		fa |= FILE_ATTRIBUTE_READONLY;
> 
>   	/* Allocate PATH_MAX bytes. */
> -	new_de = __getname();
> +	new_de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
>   	if (!new_de) {
>   		err = -ENOMEM;
>   		goto out1;
> @@ -1723,10 +1723,9 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
>   	struct NTFS_DE *de;
> 
>   	/* Allocate PATH_MAX bytes. */
> -	de = __getname();
> +	de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
>   	if (!de)
>   		return -ENOMEM;
> -	memset(de, 0, PATH_MAX);
> 
>   	/* Mark rw ntfs as dirty. It will be cleared at umount. */
>   	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
> @@ -1762,7 +1761,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
>   		return -EINVAL;
> 
>   	/* Allocate PATH_MAX bytes. */
> -	de = __getname();
> +	de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
>   	if (!de)
>   		return -ENOMEM;
> 
> --
> 2.39.5
> 


