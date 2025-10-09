Return-Path: <linux-kernel+bounces-846191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477ABBC73F2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506EB19E362A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192391C3306;
	Thu,  9 Oct 2025 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2YBtp+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCF15D1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978480; cv=none; b=rZLsF23ZQyHv5SgKHFxLnKqY73JJb0QTLC65QJPc8bp31B9FOSRv6Y4vi2i7UfGvhbEylqRWMPMLNbEE9ewomA9nlBP/+7GxyEcvJhax3sItARm4+8hFQOAEaeGWVp28GaFbVBI7CUl/woQeai0MWd8jcdMk2wCFlzlt5DphKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978480; c=relaxed/simple;
	bh=kU5PxDxBp1d0PsDmsVzbq+Nz2rncNHm3ujLYt76sjLY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N+2Gx/VoYRiZASUx6zeLrII0GPxFHt7nHJpPMHPgctRlE2MlF0O8AQ9kZCDE7+g/V10R0vPu/o7Kw6ZSvRjihUAtUc8Wmd6Wr9m+SrDasWQAyxgQJVPNFCvO8OCTPZmogFABqyxZ/zQj842XYHTEd19gY033CXXtB8nDgqkE4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2YBtp+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C88C4CEE7;
	Thu,  9 Oct 2025 02:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759978479;
	bh=kU5PxDxBp1d0PsDmsVzbq+Nz2rncNHm3ujLYt76sjLY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=F2YBtp+Hr7oeHB53LuWJDS2ZGtvsB+33yOPbkCZnPdlGUCr+7nl13LNGL7JLJrANq
	 /HN03mDlHraJQe0zByt9dNNuT/AhAw3P9ekE+/bTkWCXcehaHinwvM8WrS9Ys1SfRy
	 VAGQhlYRXyuSJ6xtbLxU8OYlpw56DWeIl8YR2hv8Qp5CAx6kCQih6Vm6jSUwJi+vLB
	 9Tk5fF3JLFXzHNtf1CZI8YRguU/Giyl3RSvCRHBV8LOy372zE6ZP3vTLeIfxIasnHP
	 6pXWuimXc/i41MG2V6mtvKiRlsLuj+A86EcxPoB33DDYFkOzeevSunBV3aOWIieW5t
	 X6i8b6fMugG0g==
Message-ID: <839306c1-5f7a-4e89-b2cf-7534d279a03c@kernel.org>
Date: Thu, 9 Oct 2025 10:54:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Perform sanity check before unlinking directory
 inode
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20251003134731.470392-1-zlatistiv@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251003134731.470392-1-zlatistiv@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/2025 9:47 PM, Nikola Z. Ivanov wrote:
> Current i_nlink corruption check does not take into account
> directory inodes which have one additional i_nlink for their "." entry.
> 
> Add additional check and a common corruption path.
> 
> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> ---
>   fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b882771e4699..68b33e8089b0 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>   		goto out;
>   	}
>   
> -	if (inode->i_nlink == 0) {
> +	if (unlikely(inode->i_nlink == 0)) {
>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>   			  __func__, inode->i_ino);
> -		err = -EFSCORRUPTED;
> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> -		goto out_iput;
> +		goto corrupted;
> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> +			  __func__, inode->i_ino);
> +		goto corrupted;

Can we detect such corruption in sanity_check_inode() as well? So that if
f2fs internal flow calls f2fs_iget() on corrupted inode, we can set SBI_NEED_FSCK
flag and then triggering fsck repairment later.

Thanks,

>   	}
>   
>   	if (IS_ENCRYPTED(dir) &&
> @@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>   	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
>   				ino, IS_ERR(new) ? PTR_ERR(new) : err);
>   	return new;
> +corrupted:
> +	err = -EFSCORRUPTED;
> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>   out_iput:
>   	iput(inode);
>   out:
> @@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   	if (unlikely(inode->i_nlink == 0)) {
>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>   			  __func__, inode->i_ino);
> -		err = -EFSCORRUPTED;
> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> -		f2fs_folio_put(folio, false);
> -		goto fail;
> +		goto corrupted;
> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> +			  __func__, inode->i_ino);
> +		goto corrupted;
>   	}
>   
>   	f2fs_balance_fs(sbi, true);
> @@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   
>   	if (IS_DIRSYNC(dir))
>   		f2fs_sync_fs(sbi->sb, 1);
> +
> +	goto fail;
> +corrupted:
> +	err = -EFSCORRUPTED;
> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> +	f2fs_folio_put(folio, false);
>   fail:
>   	trace_f2fs_unlink_exit(inode, err);
>   	return err;


