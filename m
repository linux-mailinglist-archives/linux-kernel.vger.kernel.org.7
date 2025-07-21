Return-Path: <linux-kernel+bounces-739677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E309B0C998
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355FB1885C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D22DC32B;
	Mon, 21 Jul 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD1Tj6Zn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872162D373A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118497; cv=none; b=PPnrqj4LTjO/OdnTx9p0nyoDZCt+h5oCqk4izz01F11kLkf1Esn+uH20VcSe0sx7Zh9IhAfwsZ+wW8zkZlw4PKFETYMx180hIx/SKYHXPYVpHPKWeRzUvsTyejEoU29dkeaT41T9wMbgFX7sWujwlQmJ8iUHvNgcHlHtVQnsWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118497; c=relaxed/simple;
	bh=9s7rQgyjBAgX1bh2xvIo6FiM/DYGBd5vVi5RZuquT1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUi7w9YIskScN8OJfvmyfSix3H9Ojz38VZaODPKKQWn+9ASFSgIqxAQOyxYCI3Tg7VsHd7vus91JhL+DPWocqo3v4/bNaNgz1VNl6e6NGd5cSPUTTXNYsZUKo4q3iZHMT5o/H1bfM22nbgBZ1nWBLiMZyQf5zYAvMRftTSxYqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD1Tj6Zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41C1C4CEF4;
	Mon, 21 Jul 2025 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118496;
	bh=9s7rQgyjBAgX1bh2xvIo6FiM/DYGBd5vVi5RZuquT1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OD1Tj6ZnqcMm2LXliKEFnlj4Y8bEJ+0cIUZQeqWyuVCOKnhVZrQvJARUi9hz8jByM
	 C1Lkklsmt3aXczcVrwPYyu6z/nN2p/9FKOg3mUEaitxIOJp4udbaGXaa0NlKU+DkpJ
	 DCrVUks5C9Py7It6EMnIo0aAmdL7FN5R3GrzMtzw1FaQyEHB3fCi9TQEBgOHOpB6uo
	 Gup5SW4qiFPCN8VUDF+IIhUv3tNAFRovFpGuQ7nJcA6cOnOWhbQd/Qw4DBqX6mHCTh
	 jvWj93/GAEcRDS1j6F/EX15mvbl67fUOCxruirVRlyvLC71hDk082z6kiI9Q1gYq9B
	 96NN06IrGRO0A==
Date: Mon, 21 Jul 2025 17:21:35 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: wangzijie <wangzijie1@honor.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, bintian.wang@honor.com,
	feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid redundant clean nat entry
 move in lru list
Message-ID: <aH53HwGQd2CWOCFM@google.com>
References: <20250718100706.3948806-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718100706.3948806-1-wangzijie1@honor.com>

I think it'd be better to add a parameter like __lookup_nat_cache(for_dirty).

On 07/18, wangzijie wrote:
> __lookup_nat_cache follows LRU manner to move clean nat entry, when nat
> entries are going to be dirty, no need to move them to tail of lru list.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/node.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4b3d9070e..b9fbc6bf7 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -460,7 +460,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
>  
>  	f2fs_down_write(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, ni->nid);
> +	e = radix_tree_lookup(&nm_i->nat_root, ni->nid);
>  	if (!e) {
>  		e = __init_nat_entry(nm_i, new, NULL, true);
>  		copy_node_info(&e->ni, ni);
> @@ -2926,7 +2926,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  
>  		raw_ne = nat_in_journal(journal, i);
>  
> -		ne = __lookup_nat_cache(nm_i, nid);
> +		ne = radix_tree_lookup(&nm_i->nat_root, nid);
>  		if (!ne) {
>  			ne = __alloc_nat_entry(sbi, nid, true);
>  			__init_nat_entry(nm_i, ne, &raw_ne, true);
> -- 
> 2.25.1

