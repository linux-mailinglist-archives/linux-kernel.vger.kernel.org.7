Return-Path: <linux-kernel+bounces-791822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D7B3BC54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D7FA27D31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D881031B118;
	Fri, 29 Aug 2025 13:17:28 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608431A564
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473448; cv=none; b=taUUMCnw4iWt6irOodlVQi1hQTaqO651uKyCt2vFj5MjVa86eS2f5Dh7holCq+ThkfWuvkbrWDLl+7Dzoi7qcS8pwXt4siEESgwbMzrrAsMX13+HO2DlNX8SoN+Gp8W6Ovt2kb1YRLoXKU5wCtDGdSVeC2YI2QKFjwK1/YmHX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473448; c=relaxed/simple;
	bh=81vorNURBy1UDAOLAp1nBIOzaimgDR5VllJfsNL22bQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ckkF1uY/C1y/j8awzOap5gC442Wl5rJlVXHzIaMpEeZE4J8HBpiQtganHCtNaLfhPwtm0c0MFyQdWQEkODohY0ftbkS9D1ROplCIPJcKvFB40SFElDRMlp2fPAeVRz0RvTXfzDr7Z2N2c5zXoBciUQGW4IYzGSu+iE+rIe2oz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57TDGxB6045971;
	Fri, 29 Aug 2025 22:16:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57TDGp9A045942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 Aug 2025 22:16:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dce0adb2-a592-44d8-b208-d939415b8d54@I-love.SAKURA.ne.jp>
Date: Fri, 29 Aug 2025 22:16:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: Verify inode mode when loading from disk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1cd51309-096d-497f-8c5e-b0c9cca102fc@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <1cd51309-096d-497f-8c5e-b0c9cca102fc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

Any questions? Should I find someone who can take this patch?

On 2025/08/10 23:55, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk can be invalid. Do like what
> commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
> does.
> 
> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/jfs/inode.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index fcedeb514e14..21f3d029da7d 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -59,9 +59,15 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
>  			 */
>  			inode->i_link[inode->i_size] = '\0';
>  		}
> -	} else {
> +	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
> +		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>  		inode->i_op = &jfs_file_inode_operations;
>  		init_special_inode(inode, inode->i_mode, inode->i_rdev);
> +	} else {
> +		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %lu.\n",
> +		       inode->i_mode, inode->i_ino);
> +		iget_failed(inode);
> +		return ERR_PTR(-EIO);
>  	}
>  	unlock_new_inode(inode);
>  	return inode;


