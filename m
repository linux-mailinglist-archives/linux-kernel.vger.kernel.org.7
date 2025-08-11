Return-Path: <linux-kernel+bounces-761795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E7AB1FE87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA091724EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F69F18B47E;
	Mon, 11 Aug 2025 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x5006o8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA71D52B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890030; cv=none; b=t0Hta/liPjN3RbbPe+ATp716daeEjB/ES6J10aZUIhwYk+BX2LBUPDN4dfreUgX5Y3x6GNMOretITb4+bFXJEJMlK0rXDICvEc4bq8xHJuVlbSgKWg5W7e+eCzhCMOeORxlFd1XDjQvmiQ2gYxufx1J00KTVCOhPYUchAetxp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890030; c=relaxed/simple;
	bh=PnIysY3Acp1ildEXnpEXoKVbY/LKFl/zcs0bwAjrAz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hrej2dATJURGegJeXInY2cRuV2OqO3RTMo45bnS0Qg0V1vV/1vHZWxTP1OL2/BdrHTva37h1bkvBQZJIiBokpY9h44o+sLQxNAnjhmpSaLMgCnt7wU8qX9JPI5si/uJYQdWpXEmWe3DLIDpY8u8ajSqkVKrFYNilNVvVhOdIqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x5006o8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE4C4CEED;
	Mon, 11 Aug 2025 05:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754890029;
	bh=PnIysY3Acp1ildEXnpEXoKVbY/LKFl/zcs0bwAjrAz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x5006o8mbTDS9iEkeI5HdANFtI0hw4MnaKRfRRRKRqSILWZjWq1WOg0fOh5KWZ/AL
	 8VJgMEYTp00xUe6o0hghBu8mPkoYRactd3zYf05M3Zl6tK3VTphd1iTfS4n4LFnyU+
	 TOO2TQQlW7AGTFMKHNCTD0Y/cwBtlxhZsyg3WJ6g=
Date: Mon, 11 Aug 2025 07:27:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	rafael@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/vmscan: fix inverted polarity in lru_gen_seq_show()
Message-ID: <2025081158-had-fracture-a5e6@gregkh>
References: <20250727105937.7480-1-dakr@kernel.org>
 <DBYXZ0RQ58Z7.2UBHDTZ2LCT2B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBYXZ0RQ58Z7.2UBHDTZ2LCT2B@kernel.org>

On Sun, Aug 10, 2025 at 07:59:32PM +0200, Danilo Krummrich wrote:
> On Sun Jul 27, 2025 at 12:59 PM CEST, Danilo Krummrich wrote:
> > Commit a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
> > started using debugfs_get_aux_num() to distinguish between the RW
> > "lru_gen" and the RO "lru_gen_full" file [1].
> >
> > Willy reported the inverted polarity [2] and Al fixed it up in [3].
> >
> > However, the patch in [1] was applied. Hence, fix this up accordingly.
> >
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [1]
> > Link: https://lore.kernel.org/all/aGZu3Z730FQtqxsE@casper.infradead.org/ [2]
> > Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [3]
> > Fixes: a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Applied to driver-core-linus, thanks!

Sorry for the delay, thanks for queueing this up.

greg k-h

