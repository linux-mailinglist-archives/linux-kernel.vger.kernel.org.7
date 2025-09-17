Return-Path: <linux-kernel+bounces-821358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E3B810F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9955525C41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04482FA0CC;
	Wed, 17 Sep 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHjgSOP0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E251A9FBE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127249; cv=none; b=a4ll9qXdrt01SAqAqjnSOXd9Aq/tkax8rDtt/ez2u78xuUYR6Qy8LMnuzrXUIsRSicvl1FnQkn6dcLeYbzohpD8FF1N+Sjak1HYIk2gC3a35urN9QU309tadBm/nQD3RUige4PmQhO6oX6pHen4gFEABIUYotwvfhII7TN2DMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127249; c=relaxed/simple;
	bh=t265j7wNSfpNgOBxQuSzDaR6dcQPQOBwaaoIlTZ29HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfbV4mR1m3Z7yVsPIMcCr9t36b3YHgSvJJ6vUndrGwdsi1lhmdHWFmtlwBnZpxggFyjeu73REYkPI+29Z0MGOSjUh0S5rgTVLmoKhts9yfl/Z+xgcYIYbHvwT9mVyWbl0F7FVQ2+QUpu/s+gq4lKIZjauK/oNnLwu2I2kdUFsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHjgSOP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A759C4CEE7;
	Wed, 17 Sep 2025 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758127247;
	bh=t265j7wNSfpNgOBxQuSzDaR6dcQPQOBwaaoIlTZ29HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHjgSOP0ShEtUf2XQIGYxRFK7jVnslydi9EFONQnBN9uirIzJDxAbujHSZpEPoiL+
	 KxY/cnu8MsY0ss/w082BsG5l+gF64oF4ypnkmt4ghjgQKXjxFv3xloMQFeqx+3waGV
	 N3JRrEs2Enm2qAjJTo8nQKLjBAtFomW1oQ4Prnih2fLjwe/J1d9D5m8OYiF6KM1X2c
	 d+DeSqIISmfKze88Dh2u8u481fqgm/O9qoCr30L+Y3ZelIUkIm4zN3oEpOpfFgh3Y8
	 hgQN2WRaQtjAkjk1xuYBRCBWDXIsRCFwExcNLjEXfhCKRY0hBkJ3eBwf1NZaHr5vtU
	 +VB+MXb5ziTjA==
Date: Wed, 17 Sep 2025 16:40:45 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	wangzijie <wangzijie1@honor.com>
Subject: Re: [PATCH] f2fs: add sanity check on ei.len in
 __update_extent_tree_range()
Message-ID: <aMrkjSRJ0yyEfvfl@google.com>
References: <20250916085243.4165099-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916085243.4165099-1-chao@kernel.org>

Do we need this?

On 09/16, Chao Yu wrote:
> Add a sanity check in __update_extent_tree_range() to detect any
> zero-sized extent update.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/extent_cache.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 199c1e7a83ef..3070d1cb0676 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -664,6 +664,15 @@ static void __update_extent_tree_range(struct inode *inode,
>  	if (!et)
>  		return;
>  
> +	if (unlikely(len == 0)) {
> +		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
> +			"extent [%u, %u, %u], age [%llu, %llu]",
> +			__func__, type, tei->fofs, tei->blk, tei->len,
> +			tei->age, tei->last_blocks);
> +		f2fs_bug_on(sbi, 1);
> +		return;
> +	}
> +
>  	if (type == EX_READ)
>  		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
>  						tei->blk, 0);
> -- 
> 2.49.0

