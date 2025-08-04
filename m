Return-Path: <linux-kernel+bounces-755535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B18EB1A81A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59B618A4409
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39042192F4;
	Mon,  4 Aug 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WAa6u0yu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7A285CAB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326133; cv=none; b=R4xXNopH/S+4HRHdapZ3iFPGSsOUJhEaDvGUF3JzJQexlT/iBt/lb5IpKNKIC8WdZWTlx9o/ruEG/3DrIE7Emn5u0k6antrihXEode/SQxxLP/lc0xKNRkdrgdkKFwBLRlRc9z37p5zmJFupvx50kkqH2JpPdkx8Oede+GleEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326133; c=relaxed/simple;
	bh=dyXLvbyX0FNuGYodzaofF83ZOEJjme4sOefY4RBgiEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz8EhMffKbRaxUiGIMZkhyrq4C+rHDj4GvsZQ+YAFRCVPE72qL5K4OMgAj8oM/nHQ5Ll3l+pUuKMoNC/3awRnuo772AECKMlAQWceo8TN017mskCw2xlyN1K8mu7CB6UB4TTDNhUis/ydru57aIoQ7mNU5qBoTh7kfCcH5+UtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WAa6u0yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23759C4CEE7;
	Mon,  4 Aug 2025 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754326132;
	bh=dyXLvbyX0FNuGYodzaofF83ZOEJjme4sOefY4RBgiEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAa6u0yu9ZR71w7fjsHHG37g7UiqbQOV+VMjnhO1IYF8HhPHOQk1+jSLOu1ohX/Px
	 93YioLpUe8eTqCjBnrOtozlIAUPx0XeJ+yCaif1fQ4RL1aGE1D5SQGcLPVkz3UOO4L
	 Bv8+XSQUEe4qmrQpzCQ8BmYPKPUFO/vUOgvBuo1w=
Date: Mon, 4 Aug 2025 17:48:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Sandeen <sandeen@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: fix mount options not being applied
Message-ID: <2025080435-dictate-giant-3eaa@gregkh>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>

On Mon, Aug 04, 2025 at 02:30:04PM +0000, Charalampos Mitrodimas wrote:
> Mount options (uid, gid, mode) are silently ignored when debugfs is
> mounted. This is a regression introduced during the conversion to the
> new mount API.
> 
> When the mount API conversion was done, the line that sets
> sb->s_fs_info to the parsed options was removed. This causes
> debugfs_apply_options() to operate on a NULL pointer.
> 
> As an example, with the bug the "mode" mount option is ignored:
> 
>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>   $ mount | grep debugfs_test
>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>   $ ls -ld /tmp/debugfs_test
>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> 
> With the fix applied, it works as expected:
> 
>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>   $ mount | grep debugfs_test
>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime,mode=666)
>   $ ls -ld /tmp/debugfs_test
>   drw-rw-rw- 37 root root 0 Aug  2 17:28 /tmp/debugfs_test
> 
> Fix this by restoring the missing sb->s_fs_info assignment in
> debugfs_fill_super() and by calling debugfs_reconfigure() in
> debugfs_get_tree() to apply options when reusing an existing
> superblock.
> 
> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220406
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>  fs/debugfs/inode.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index a0357b0cf362d8ac47ff810e162402d6a8ae2cb9..ffe6402c77126b2a23beaa85160dfe578f59599c 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -275,6 +275,7 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	set_default_d_op(sb, &debugfs_dops);
>  	sb->s_d_flags |= DCACHE_DONTCACHE;
>  
> +	sb->s_fs_info = fc->s_fs_info;
>  	debugfs_apply_options(sb);
>  
>  	return 0;
> @@ -282,10 +283,15 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  static int debugfs_get_tree(struct fs_context *fc)
>  {
> +	int err;
> +
>  	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
>  		return -EPERM;
>  
> -	return get_tree_single(fc, debugfs_fill_super);
> +	err = get_tree_single(fc, debugfs_fill_super);
> +	if (!err)
> +		err = debugfs_reconfigure(fc);
> +	return err;
>  }
>  
>  static void debugfs_free_fc(struct fs_context *fc)
> 
> ---
> base-commit: 3c4a063b1f8ab71352df1421d9668521acb63cd9
> change-id: 20250804-debugfs-mount-opts-2a68d7741f05
> 
> Best regards,
> -- 
> Charalampos Mitrodimas <charmitro@posteo.net>
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

