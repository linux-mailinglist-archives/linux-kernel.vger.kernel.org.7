Return-Path: <linux-kernel+bounces-791823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD8B3BC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C505A0C95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2566274B30;
	Fri, 29 Aug 2025 13:17:57 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28131A564
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473477; cv=none; b=JTB0D0ZonZRMyVkl5Hqs3S++omPC9UkVdnlIqmROB3lA7qmXY7rJbcn6VWF0eYexwOfBFITdD+HP+O7aFojzWST5fTpMTczV3liIuA4GyD5Huf/pSTXxwqM0k4KzvJ3dGoCZJe+r8TUzQpUGnsSHIBWit2OGbk734SUSJXrPiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473477; c=relaxed/simple;
	bh=net2BfpbVb1x3fgVh4qlwboER9HMNZvBJ4M4ssIr42c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=N2MFQuo5sR3VsGzp4WAz4LDwey75/Qj42HGtvbnEfJPk1qwGuGVO32Fpm7z7TXPfpGgsVWJyluLTyRp1+QvqGNKdcvAWvWE6s36Xa0bMCy+8Z50ppKmUJlfo3gzAiqJDNVKhcfOxIinJab3vvlGSoRWsAJinhvLmqGSfEyfOxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57TDHiDA046149;
	Fri, 29 Aug 2025 22:17:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57TDHiP5046145
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 Aug 2025 22:17:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dca0c449-547e-42fa-a8b7-53787e64e2ec@I-love.SAKURA.ne.jp>
Date: Fri, 29 Aug 2025 22:17:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cramfs: Verify inode mode when loading from disk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Nicolas Pitre <nico@fluxnic.net>, LKML <linux-kernel@vger.kernel.org>
References: <ff7dc567-1db3-4939-9b0e-77e91a8d898b@I-love.SAKURA.ne.jp>
Content-Language: en-US
Cc: Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <ff7dc567-1db3-4939-9b0e-77e91a8d898b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

Any questions? Should I find someone who can take this patch?

On 2025/08/12 23:52, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk can be invalid. Do like what
> commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
> does.
> 
> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/cramfs/inode.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index b002e9b734f9..12daa85ed941 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -116,9 +116,18 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
>  		inode_nohighmem(inode);
>  		inode->i_data.a_ops = &cramfs_aops;
>  		break;
> -	default:
> +	case S_IFCHR:
> +	case S_IFBLK:
> +	case S_IFIFO:
> +	case S_IFSOCK:
>  		init_special_inode(inode, cramfs_inode->mode,
>  				old_decode_dev(cramfs_inode->size));
> +		break;
> +	default:
> +		printk(KERN_DEBUG "CRAMFS: Invalid file type 0%04o for inode %lu.\n",
> +		       inode->i_mode, inode->i_ino);
> +		iget_failed(inode);
> +		return ERR_PTR(-EIO);
>  	}
>  
>  	inode->i_mode = cramfs_inode->mode;


