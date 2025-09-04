Return-Path: <linux-kernel+bounces-801516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B3B4460B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8F518939F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897321ABA2;
	Thu,  4 Sep 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="mbDF70rb";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="vs+mdioG"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D572625
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012515; cv=none; b=laWS9nDWshOAad4ooIa1Acs7jJEsQlgVGYTtOdgDfB5gBp4LHbrIEgKzeE3xckqrmWjIfe+8W28Q+8528LXm3VYE1QCUirl1eHFtPN7Uiy+5r86LkfimXgRs546oqN89cMoUk3rYkVhXaau6qreYBn4gMkg+LfMDEP9oDuZYWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012515; c=relaxed/simple;
	bh=mztVttCjCLkYbnRTSdT8LNvuhpPCokgAATSa0KbuFtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mp2NxTXhqZlddOI1fu9ZlFofjTUG3RUk2nGekT5r4ER7A/VrIOnUV7pxMSX7JOHI8RGIDddFMe+O1iwL5XK/sWeytvjg9mFyeGTUKdprgClK8Epz204NRmeMClNt2RwKNZnE2JZr8VkUc/PRQCkB4IulSz6gFWn9YMeYpjLPPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=mbDF70rb; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=vs+mdioG; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id C635F26F75D8;
	Fri,  5 Sep 2025 04:01:44 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1757012505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUVswyxulafXpYRZJGqtlxZFD5w64Y2Pb8m4yULcfFc=;
	b=mbDF70rbvS6hIUOG1ezul7b2NpKMC5xFTulBkHs4Q6ky9U7UIGRkVhWr3LzyLHq996YuQ5
	99EgsU04X2FYPp3QXEW3g/QKRZABw8jqDKpah7FL2LTLPRdB1UjtR68DjZASFAe4xXsHzp
	D4AtG21Pxx1dM7nonOH8JDEHq7gAPAES4BxRHd7y9j+ULk5OjgymiUpoAok/yefcv3pEc7
	bfZmiKCIrpUqYwa7RJglYBy3sMGo16j2sioCaRDefFl2ywXMUbwYqmGTHQs7S2Hcl8VNuH
	IFBem7M7iOgS+3ozGd3H50Mi8EMk+3j2lDzkJeACF0sFrsgdOC7bHElzX6E9rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1757012505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUVswyxulafXpYRZJGqtlxZFD5w64Y2Pb8m4yULcfFc=;
	b=vs+mdioGGslqoifUj0CRWgRLhiXvC1evmFzfoCI2skzNbvJ2SV31Wyo9hUZwM7e+1RpwZo
	Ap4yUVLuHzx7dSDw==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 584J1hs7271443
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Sep 2025 04:01:44 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 584J1hdf644220
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Sep 2025 04:01:43 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 584J1hbK644219;
	Fri, 5 Sep 2025 04:01:43 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: zhoumin <teczm@foxmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vfat:avoid unnecessary check
In-Reply-To: <tencent_C19E4D9448D8514A505A9FE439D01C333B08@qq.com>
References: <tencent_C19E4D9448D8514A505A9FE439D01C333B08@qq.com>
Date: Fri, 05 Sep 2025 04:01:43 +0900
Message-ID: <87bjnqkpns.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

zhoumin <teczm@foxmail.com> writes:

> Remove redundant and unreachable name check code in dir.c.

Looks like you changed the logic, but no explanation.

> Remove flags check in fat_update_time since fat does not support
> inode version.
>
> Optimize fat_truncate_time to return a meaningful value, allowing
> the removal of redundant inode checks in fat_update_time. This
> ensures non-root inodes are validated only once.

Also changed the logic, you removed the check of flags.

The change may not have the issue, however please change and explain
more carefully.

Thanks.

> Signed-off-by: zhoumin <teczm@foxmail.com>
> ---
>  fs/fat/dir.c  | 12 ++++--------
>  fs/fat/misc.c | 11 ++++-------
>  2 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index acbec5bdd521..4f1be9939292 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -337,11 +337,11 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
>  		if (ds->alias_checksum != alias_checksum)
>  			goto parse_long;
>  	}
> -	if ((*de)->name[0] == DELETED_FLAG)
> +	if (IS_FREE((*de)->name))
>  		return PARSE_INVALID;
>  	if ((*de)->attr == ATTR_EXT)
>  		goto parse_long;
> -	if (IS_FREE((*de)->name) || ((*de)->attr & ATTR_VOLUME))
> +	if ((*de)->attr & ATTR_VOLUME)
>  		return PARSE_INVALID;
>  	if (fat_checksum((*de)->name) != alias_checksum)
>  		*nr_slots = 0;
> @@ -491,12 +491,10 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
>  			goto end_of_dir;
>  parse_record:
>  		nr_slots = 0;
> -		if (de->name[0] == DELETED_FLAG)
> +		if (IS_FREE(de->name))
>  			continue;
>  		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))
>  			continue;
> -		if (de->attr != ATTR_EXT && IS_FREE(de->name))
> -			continue;
>  		if (de->attr == ATTR_EXT) {
>  			int status = fat_parse_long(inode, &cpos, &bh, &de,
>  						    &unicode, &nr_slots);
> @@ -608,12 +606,10 @@ static int __fat_readdir(struct inode *inode, struct file *file,
>  	 * need to parse long filename.
>  	 */
>  	if (isvfat && !short_only) {
> -		if (de->name[0] == DELETED_FLAG)
> +		if (IS_FREE(de->name))
>  			goto record_end;
>  		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))
>  			goto record_end;
> -		if (de->attr != ATTR_EXT && IS_FREE(de->name))
> -			goto record_end;
>  	} else {
>  		if ((de->attr & ATTR_VOLUME) || IS_FREE(de->name))
>  			goto record_end;
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index c7a2d27120ba..41f6362a0428 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -335,7 +335,7 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  		inode_set_mtime_to_ts(inode,
>  				      inode_set_ctime_to_ts(inode, fat_truncate_mtime(sbi, now)));
>  
> -	return 0;
> +	return 1;
>  }
>  EXPORT_SYMBOL_GPL(fat_truncate_time);
>  
> @@ -343,18 +343,15 @@ int fat_update_time(struct inode *inode, int flags)
>  {
>  	int dirty_flags = 0;
>  
> -	if (inode->i_ino == MSDOS_ROOT_INO)
> -		return 0;
> -
> -	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> -		fat_truncate_time(inode, NULL, flags);
> +	if (fat_truncate_time(inode, NULL, flags)) {
>  		if (inode->i_sb->s_flags & SB_LAZYTIME)
>  			dirty_flags |= I_DIRTY_TIME;
>  		else
>  			dirty_flags |= I_DIRTY_SYNC;
> +
> +		__mark_inode_dirty(inode, dirty_flags);
>  	}
>  
> -	__mark_inode_dirty(inode, dirty_flags);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(fat_update_time);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

