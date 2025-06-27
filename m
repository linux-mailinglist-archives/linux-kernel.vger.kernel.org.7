Return-Path: <linux-kernel+bounces-706843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18EDAEBCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9551F1C416CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0589298270;
	Fri, 27 Jun 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wtfC1lj8"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13961DFCB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040047; cv=none; b=pIHieg0TAh0JDqgAugVZp1dxrtB4thSDaa/D6D5nXFOVe1O3H6/xuAiXMLUPLBpYjAXR44fX0x1JvC5NDw98DA9+5qIW+C0Go/kN8kbhORmHoWIzP7xRvholf21MsShYvw5ykidoWDcjM3P7xUYJWZgb6cT6HNLAN4tLlzo7P7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040047; c=relaxed/simple;
	bh=eBobpTH5dO5aFYWBOFgi7YHuDOocnJlbZIlJ/t4tWrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+lv+/vknLK2acgJVI7s6VfFKpJv2B4vBQ0D6Wbra1ihrGDNqBLFp2zQl/27cBTwD5IbPmFDNGlqxrtJ8prXdJR/OR4pivbuNnvGtbTmwgFvhZmVxy8U6gRC5h3RfsBESrbYqBzVlKKaJjZbgUCotI5k2unnG1gMYGEEqTwE07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wtfC1lj8; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Jun 2025 12:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751040043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EFd2TeDZePnyevS06G3vybw5Qpi1D8XzIEjoYS75/gg=;
	b=wtfC1lj8G/k/A9owK6q8rE9rsVurmiVwBf4wimjSsEF5e6ddfCeAq/aGw2cLEAzOgwj2tZ
	JASy5Wswd+rz0+X1pUTPxiXnGiqZ0uLNY2fGmI8/4WOGS5AOfq9j9Wi6H2mgO9WfNZ9+CI
	++SNdvcrMRbAsON5PUDtgMkGkizYlK0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+029d1989099aa5ae3e89@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: use mustfix to check invalid btree IDs
Message-ID: <j2sx5unznfhswob6iuzeh5fp6tirxrbktdxkeednh7p7lfbemv@2ywasorzlvg3>
References: <20250627084033.614376-2-bharadwaj.raju777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627084033.614376-2-bharadwaj.raju777@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 27, 2025 at 02:10:32PM +0530, Bharadwaj Raju wrote:
> Checking for invalid IDs was introduced in 9e7cfb35e266 ("bcachefs: Check for invalid btree IDs")
> to prevent an invalid shift later, but since 141526548052 ("bcachefs: Bad btree roots are now autofix")
> made the parent class btree_root_bkey_invalid FSCK_AUTOFIX, fsck_err_on
> no longer works for this check.
> 
> Change the condition to use mustfix_fsck_err_on instead.

We can mark this one autofix instead

> 
> Reported-by: syzbot+029d1989099aa5ae3e89@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=029d1989099aa5ae3e89
> Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> ---
>  fs/bcachefs/recovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> index d0b7e3a36a54..abcaa0e3e2e6 100644
> --- a/fs/bcachefs/recovery.c
> +++ b/fs/bcachefs/recovery.c
> @@ -489,7 +489,7 @@ static int journal_replay_entry_early(struct bch_fs *c,
>  		if (unlikely(!entry->u64s))
>  			return 0;
>  
> -		if (fsck_err_on(entry->btree_id >= BTREE_ID_NR_MAX,
> +		if (mustfix_fsck_err_on(entry->btree_id >= BTREE_ID_NR_MAX,
>  				c, invalid_btree_id,
>  				"invalid btree id %u (max %u)",
>  				entry->btree_id, BTREE_ID_NR_MAX))
> -- 
> 2.50.0
> 

