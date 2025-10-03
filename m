Return-Path: <linux-kernel+bounces-840930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39139BB5C04
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6223A9D38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60C28313D;
	Fri,  3 Oct 2025 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOcQlOii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918523CE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455575; cv=none; b=Ad7mO78U5fkwkWiorBi9JGH6yY0yIOl3tw4RACOPOoI+T5s9ro+w9pB74KceXv/gsDouX5rxaXEF2EUGvrnKb7Sc9em+wVUm/tuaA4g0l9WmakR4N3aIMKURI0YmEGtr5W9IMEbuo8QDZ+GWSlZ5Rn8H8y8WAVMyNChE23maT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455575; c=relaxed/simple;
	bh=2t8WtuzSBZrNp+wg5ELsadbjX0swbzseuyJ3gNoctCA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aaANIrIwESdUGy/88Fj7S9u1d+dFsZK/q1ovQNJo9roswQG1+lr3zrNyoEIzVeZJOKx5dwO7jKshUnj+F6RKx2AralhO+lE8iW5V07NxC+BovUj5gU+6Z3Hrecj6VszIbR1AVNCT+6HCOc9UK3J8mjqwvenZ13aGk9Z0l28sYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOcQlOii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CDFC4CEF4;
	Fri,  3 Oct 2025 01:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759455574;
	bh=2t8WtuzSBZrNp+wg5ELsadbjX0swbzseuyJ3gNoctCA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OOcQlOiiSu/3uwzm422Y1tEfMH+LEPwRT8fe231g11Z51+tgEZ8FId/90tzHet8/h
	 NeVYZTaqnGAkxThjaWJAmqzqLIBjUoZJdgHO2HMcyCaaxAghGuYp7YUxTh3zVc+lsf
	 csC98vhNl345Mq8vErbIIy2z7D5EazbVI9TP+zQamm/lqryKUVvDYTWHqldc6detkU
	 4HXbT2eE9o1JL7hdxYFf+vJ+pXIx47wtNW6HmUHR0X4squzA0NTbR3JKKfhaV29dkC
	 Za+quClVGzapNtnc2kfNGLuUt9KCjexNueO9w7/zIyb5Y47t5OC96BjKB1ivyrjUV0
	 oitRDQV8iQmxw==
Message-ID: <3bdcdb11-2d67-4842-b21c-2b41ce5faea9@kernel.org>
Date: Fri, 3 Oct 2025 09:39:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Haofeng Li <13266079573@163.com>,
 Haofeng Li <lihaofeng@kylinos.cn>
Subject: Re: [PATCH] f2fs: fix ifolio memory leak in f2fs_move_inline_dirents
 error path
To: Haofeng Li <920484857@qq.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/9/30 17:16, Haofeng Li wrote:
> From: Haofeng Li <lihaofeng@kylinos.cn>
> 
> Fixes a memory leak issue in f2fs_move_inline_dirents() where
> the ifolio is not properly released in certain error paths.
> 
> Problem Analysis:
> - In f2fs_try_convert_inline_dir(), ifolio is acquired via f2fs_get_inode_folio()
> - When do_convert_inline_dir() fails, the caller expects ifolio to be released
> - However, in f2fs_move_inline_dirents(), two specific error paths don't release ifolio
> 
> Fixes: 201a05be9628a ("f2fs: add key function to handle inline dir")
> Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
> ---
>   fs/f2fs/inline.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 58ac831ef704..2496866fc45d 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -425,7 +425,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
>   	set_new_dnode(&dn, dir, ifolio, NULL, 0);
>   	err = f2fs_reserve_block(&dn, 0);

f2fs_reserve_block() will call f2fs_put_dnode() in its error path, it has
unlocked & released inode folio?

>   	if (err)
> -		goto out;
> +		goto out_put_ifolio;
>   
>   	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
>   		f2fs_put_dnode(&dn);

Ditto, or am I missing something?

Thanks,

> @@ -434,7 +434,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
>   			  __func__, dir->i_ino, dn.data_blkaddr);
>   		f2fs_handle_error(F2FS_F_SB(folio), ERROR_INVALID_BLKADDR);
>   		err = -EFSCORRUPTED;
> -		goto out;
> +		goto out_put_ifolio;
>   	}
>   
>   	f2fs_folio_wait_writeback(folio, DATA, true, true);
> @@ -479,6 +479,10 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
>   out:
>   	f2fs_folio_put(folio, true);
>   	return err;
> +
> +out_put_ifolio:
> +	f2fs_folio_put(ifolio, true);
> +	goto out;
>   }
>   
>   static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)


