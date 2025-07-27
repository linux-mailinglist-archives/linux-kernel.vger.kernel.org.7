Return-Path: <linux-kernel+bounces-747067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB8B12F4D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 13:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D546B3A61F5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F71FAC37;
	Sun, 27 Jul 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="198YEp3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C69463
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753614257; cv=none; b=THMNc1xOoydlyl96txGDrwkVpTELFXC4dLb5WBIB+5cvZxxh5wo9eJ61pxFBsVehQ5QH++RXbQhMXj/hmobrYFI7LVLqnCib99RIOJn3pejXc5L2OjUE/qMSieDJz1Ak5AMZ++JwbjWZUiD4BAdYVxFmd9NsGf5KfJbiy27qC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753614257; c=relaxed/simple;
	bh=hOWw/pQy6Gz+KVeHJutSYWukt54uM2KDMCpnL4Q6wYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txsfZGpLzO4MtSJZvqNi7nU+MnR/5iNeqUOVcmZPQ1ttmgTrqFWwDgEKDLsTxxfWAHSnS/Ec/lAIVmWm0PIaAZC6CpVWAYfpMOar93PvX6FrrVUopWVu1mpGoRUsKcnQM5pLIRhutyQF2Zda3mKnu0OQGlGg2AZhuPhtPmWe9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=198YEp3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB47C4CEEB;
	Sun, 27 Jul 2025 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753614255;
	bh=hOWw/pQy6Gz+KVeHJutSYWukt54uM2KDMCpnL4Q6wYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=198YEp3ALIjYytbTi02mn4kw6encHSj1jC2SYJuAv4835uk8JXxqQasyOHKJ/bjRC
	 6eDRHfRRe88iH0zhthwJtrzkQuKCc4MzRozWibL7k2NyYOz3qJ3zBSu7zgZ+y4eodr
	 5iuKcIPnSIYRvvZQ4p5Iu/okgBZcfNffekW9832c=
Date: Sun, 27 Jul 2025 13:04:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	rafael@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/vmscan: fix inverted polarity in lru_gen_seq_show()
Message-ID: <2025072700-jailbreak-canister-2aea@gregkh>
References: <20250727105937.7480-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727105937.7480-1-dakr@kernel.org>

On Sun, Jul 27, 2025 at 12:59:06PM +0200, Danilo Krummrich wrote:
> Commit a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
> started using debugfs_get_aux_num() to distinguish between the RW
> "lru_gen" and the RO "lru_gen_full" file [1].
> 
> Willy reported the inverted polarity [2] and Al fixed it up in [3].
> 
> However, the patch in [1] was applied. Hence, fix this up accordingly.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [1]
> Link: https://lore.kernel.org/all/aGZu3Z730FQtqxsE@casper.infradead.org/ [2]
> Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [3]
> Fixes: a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Nice, thanks for fixing this up:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

