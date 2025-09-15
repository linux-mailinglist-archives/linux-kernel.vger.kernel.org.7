Return-Path: <linux-kernel+bounces-816895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C581CB57A23
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3520F189A99C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D92306B0A;
	Mon, 15 Sep 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZTRnQ1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF24306B15;
	Mon, 15 Sep 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938515; cv=none; b=lYeA7E1ZjWMT9bbre1AQAfdx4ejkx5A6Mc6vRAbrOgnuR/BCrXQ7HgY8E3E+aCfVPZg1aNEWiWG6uqJTbu0OvB87XiR0dWsVfXyoLGUQeIZwUwTly4cdEfbg3hILwwLTOrxU+g19AtiJzLE0V4pLTmHHyXQA3MTgN80J9QY2HSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938515; c=relaxed/simple;
	bh=Una6Hs/ck9bAAALrjnU+o0p2zO7jFHKyVqQGCI1gvvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc3+p+MoPNJYp+HshFSnHUcj3wcGedXDeSpk8upQC38PHUZ1U62BqkHWphpOQ5CfY2660RJhK8NsWEkXAqpuO57/9q1t/o+Qep/n4ym7ZyT784snGgHO6Rhgk4yO1u+8shmr7PEEp0sdeo6QclTnT8QUlhf15pDvCegYrLOfuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZTRnQ1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12B0C4CEF1;
	Mon, 15 Sep 2025 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757938514;
	bh=Una6Hs/ck9bAAALrjnU+o0p2zO7jFHKyVqQGCI1gvvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZTRnQ1uXjpSZP/w2Ns5p96l1aaB26xge580VvyiG2xWC9dvZ7vo5vJUkfiE6ffei
	 0nN34sQpoXVGn6vEjW7ntfG+xVmNqUBzLGiGT6bn1++xjpdbcfe9o1sU8rTFyUtOP3
	 LpPlf2PswgwjlwunSzUTPP6JhPGFFUHSMfui+dqs=
Date: Mon, 15 Sep 2025 14:14:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: JaimeFine <jaimefine6@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Subject: Re: [PATCH] rust: auxiliary: Fix 'initialialized' typo
Message-ID: <2025091515-prison-eats-cb1e@gregkh>
References: <20250915120235.1942-1-jaimefine6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915120235.1942-1-jaimefine6@gmail.com>

On Mon, Sep 15, 2025 at 08:02:27PM +0800, JaimeFine wrote:
> From: Jaime Fine <jaimefine6@gmail.com>
> 
> Suggested-by: onur-ozkan

What specific "typo" is being changed here?

> Link: https://github.com/Rust-for-Linux/linux/issues/1187
> Signed-off-by: Jaime Fine <jaimefine6@gmail.com>
> ---
>  rust/kernel/auxiliary.rs | 357 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 357 insertions(+)
>  create mode 100644 rust/kernel/auxiliary.rs
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> new file mode 100644
> index 0000000..3626072
> --- /dev/null
> +++ b/rust/kernel/auxiliary.rs

You added a whole file, you did not modify an existing one :(

Also, please use scripts/get_maintainer.pl to determine who to send
patches to.

thanks,

greg k-h

