Return-Path: <linux-kernel+bounces-871488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AABC0D6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE782189BBED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1333002BB;
	Mon, 27 Oct 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDDV/f6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F01EEAB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567167; cv=none; b=g72T2AEd79yD4psAFrG8x1JJVBLa3VRuw2emIC9TncU7VPC80V9E+mHGdb1m3yk52bqTJaHBPhSH1II7FKq/vIXU6EIl713ul0FOeTuCXGX7ckGxhy/bAB2jE4NulRxW6vx9qvs6C64LybGIB+R+sAFVKXT7MuaxY3SfPI/87mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567167; c=relaxed/simple;
	bh=yxef0NHM2utsOMEg/gVqcZ+hf2V0uBp9qRNolXJ3x/0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=srx/t9irlTcEPVX8qKYdDSGL8NKTMBwCYyXO9oklDQQx+3O9w3xBKKuDWEqRSxIZ3a9NPiJr4zlXEcbQ1vYSJnwJRVM3CioYPLkonDHOo0ZXi9IaS3A5BJP0M4ErtcB833chcIPm1eBE8KO4/yJ4D0iN8I9BQ9iBgcE1Z3iM0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDDV/f6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A34C4CEF1;
	Mon, 27 Oct 2025 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761567167;
	bh=yxef0NHM2utsOMEg/gVqcZ+hf2V0uBp9qRNolXJ3x/0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XDDV/f6noadEpzW+gSKkl93XGLApBf9BgaCFvb6fd70xPGsXjhLK0Sfr0WxNgdYIh
	 wnAplGkIVTm/DcHNIC9xY2BNjc2Oq70m1HlEd65yGUHytNOtF7SyT72u21LO0n+vTh
	 GwH/p5NDlcOF0a1V+FDoKCeiobTaOB/Er3gDM+kXQresqWyY6gbiY+jwoxx+JEXvdi
	 QsWI9q8A8Y43GM1JTFLPGa5jGJRYHVNIzVUPD/2rKtH/jfbuYZBLvezuhIhDYXLsfc
	 xrXUu7wNoHU6HHd83EU4dQ0O12lezvFmM9zV09fOoxw3VywRP2trGIVtUJySFFnm1h
	 jeoKyjZOuH+NA==
Message-ID: <a6dc6438-7aaa-4c21-8df7-ecd618b826ea@kernel.org>
Date: Mon, 27 Oct 2025 20:12:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: invalidate dentry cache on failed whiteout creation
To: Deepanshu Kartikey <kartikey406@gmail.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20251022233349.102728-1-kartikey406@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251022233349.102728-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/25 07:33, Deepanshu Kartikey wrote:
> F2FS can mount filesystems with corrupted directory depth values that
> get runtime-clamped to MAX_DIR_HASH_DEPTH. When RENAME_WHITEOUT
> operations are performed on such directories, f2fs_rename performs
> directory modifications (updating target entry and deleting source
> entry) before attempting to add the whiteout entry via f2fs_add_link.
> 
> If f2fs_add_link fails due to the corrupted directory structure, the
> function returns an error to VFS, but the partial directory
> modifications have already been committed to disk. VFS assumes the
> entire rename operation failed and does not update the dentry cache,
> leaving stale mappings.

Nice catch!

More detail is in error path, vfs won't call d_exchange to exchange old_dentry
and new_dentry, result in new_dentry still link to new_inode which has zeroed
nlink, once we try to remove this new_inode, it will trigger the bug.

Can you please add above info into your description?

> 
> This causes subsequent operations to use cached dentry information that
> no longer matches the on-disk state. When a second rename targets the
> same entry, VFS attempts to decrement i_nlink on the stale inode, which
> may already have i_nlink=0, triggering a WARNING in drop_nlink().
> 
> Example sequence:
> 1. First rename (RENAME_WHITEOUT): file2 → file1
>    - f2fs updates file1 entry on disk (points to inode 8)
>    - f2fs deletes file2 entry on disk
>    - f2fs_add_link(whiteout) fails (corrupted directory)
>    - Returns error to VFS
>    - VFS cache still has: file1 → inode 7 (stale!)
> 
> 2. Second rename: file3 → file1
>    - VFS uses stale cache: file1 → inode 7
>    - Tries to drop_nlink on inode 7 (i_nlink already 0)
>    - WARNING in drop_nlink()
> 
> Fix this by explicitly invalidating old_dentry and new_dentry when
> f2fs_add_link fails during whiteout creation. This forces VFS to
> refresh from disk on subsequent operations, ensuring cache consistency
> even when the rename partially succeeds.
> 
> Reproducer:
> 1. Mount F2FS image with corrupted i_current_depth
> 2. renameat2(file2, file1, RENAME_WHITEOUT)
> 3. renameat2(file3, file1, 0)
> 4. System triggers WARNING in drop_nlink()
> 

Can you please add Fixes flag and Cc stable@kernel.org?

Otherwise it looks good to me.

Thanks,

> Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
> Tested-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/f2fs/namei.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b882771e4699..712479b7b93d 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -1053,9 +1053,11 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	if (whiteout) {
>  		set_inode_flag(whiteout, FI_INC_LINK);
>  		err = f2fs_add_link(old_dentry, whiteout);
> -		if (err)
> +		if (err) {
> +			d_invalidate(old_dentry);
> +			d_invalidate(new_dentry);
>  			goto put_out_dir;
> -
> +		}
>  		spin_lock(&whiteout->i_lock);
>  		whiteout->i_state &= ~I_LINKABLE;
>  		spin_unlock(&whiteout->i_lock);


