Return-Path: <linux-kernel+bounces-667621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC7AC8758
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 06:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74DD1BA5BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13D1C5F1B;
	Fri, 30 May 2025 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WgdqL6gq"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18484685
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748579968; cv=none; b=aEq56xbL9FBJdrOrK8wOhv42N2ZcbD93W1/+55M83O7O1eQTpEoJa/R9+AaNEldGQPHK0Gq7vHRaLPT0aOVZqpnNlN2MFEb8cJJmv/8uvZCNX7vLzQrT48eq/xN9jnzDqU/f8EMpVAjp8ZfDTeQEUZV3CMGR22Qtu4/OofFZIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748579968; c=relaxed/simple;
	bh=zbTSaxnssCPvb2qltwiAHT0BNGjubLbhKJp7/VptBpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM+JnyXxv7/C4u4Gko+UFIeXTrgZ6Gbx+Hfm2JBi+NRUW98HoBuL/ndmeU3YtDelYTzCztsnEwhAe23S8mzDQTujyURK58rCcTOa80cycH65ELlACxA+ID8YHZy1lgy6q/+7epf3MaLQVn+kGf4Yxbj8gu0ag1kvGwySVv+JEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WgdqL6gq; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 May 2025 00:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748579962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgZ6uh8kfi/EBIHAyh230akWXNFstDoaF0ea/dpWw9k=;
	b=WgdqL6gqPrLcUBZ6MNFvUwzMSDgixE87L/YbE9FZh0rakfHmFmVcOHZqmNagMKEm8s1M1Z
	djHdXM4dnMUf135YklWr0bCodBAMJDcpC5+F4aUZOhidOMa0ez95cLuyd0JlwYreh3PnzA
	y5UhSOE9resYu8RVxgaYvBTQfkF0MvE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix uninitialised-access bug in
 bch2_alloc_sectors_start_trans
Message-ID: <y3ojfcuvlj4vk3fz7z7meky4ccvbgcb24hdzfrxldvpungvmgy@oiwjlmqbut7c>
References: <20250528190610.50604-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528190610.50604-1-qasdev00@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 28, 2025 at 08:06:10PM +0100, Qasim Ijaz wrote:
> During bch2_alloc_sectors_start_trans() if bch2_trans_relock() fails
> the code jumps to label "err", skipping "cl" initialisation. Once at
> the "err" label "cl" could potentially be accessed leading to a uinit
> access.
> 
> Fix this by moving "cl" initialisation before bch2_trans_relock().
> 
> Fixes: c2e7fa88544d ("bcachefs: Use a loop for open_bucket_add_buckets() retries")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Thanks, folded this in.

> ---
>  fs/bcachefs/alloc_foreground.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/bcachefs/alloc_foreground.c b/fs/bcachefs/alloc_foreground.c
> index 1410a4afb36a..ccd51bcbcec5 100644
> --- a/fs/bcachefs/alloc_foreground.c
> +++ b/fs/bcachefs/alloc_foreground.c
> @@ -1277,6 +1277,11 @@ int bch2_alloc_sectors_start_trans(struct btree_trans *trans,
>  
>  	req->data_type		= req->wp->data_type;
>  
> +	/* If we're going to fall back to the whole fs, try nonblocking first */
> +	struct closure *cl = req->target && !(flags & BCH_WRITE_only_specified_devs)
> +		? _cl
> +		: NULL;
> +
>  	ret = bch2_trans_relock(trans);
>  	if (ret)
>  		goto err;
> @@ -1285,10 +1290,6 @@ int bch2_alloc_sectors_start_trans(struct btree_trans *trans,
>  	if (req->data_type != BCH_DATA_user)
>  		req->have_cache = true;
>  
> -	/* If we're going to fall back to the whole fs, try nonblocking first */
> -	struct closure *cl = req->target && !(flags & BCH_WRITE_only_specified_devs)
> -		? _cl
> -		: NULL;
>  	while (1) {
>  		ret = open_bucket_add_buckets(trans, req, cl);
>  		if (!ret ||
> -- 
> 2.39.5
> 

