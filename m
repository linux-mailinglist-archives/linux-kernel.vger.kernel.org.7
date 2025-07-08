Return-Path: <linux-kernel+bounces-721489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B464CAFC9DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8B5482A21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653E2DA740;
	Tue,  8 Jul 2025 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQH7UWxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661462D949B;
	Tue,  8 Jul 2025 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975724; cv=none; b=CXBvjYRrp7RbVCQcwJV9dOQns2p5AW8EpIkcrttwXf4426C2jsYvV/pHjrmbDKPJ014a0EyZA6z0SDXGga/XWlNwPmShBCu0Z6KXNI+dTfNvxJrW+1HNwWdLk5zgZhEJjzPp9ISFiD+96O4czKaKW8vzosomPSaL2/x2e18/+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975724; c=relaxed/simple;
	bh=+rr5IUZMNLv1aC8gIdC2OTcN+TiRteFK92MBd6ezAYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA5Pq1TxOHi3Zxfv/P/7amxgD0V5+NOxWXwA/jFYFABeL8sWFGmgchqTuVhrpqGVmvIaq9wc+NZLNrDrTqalyPE6ulzUeZEHD26XvuyO1VKIPw3EH6alCG8we4QZ8xbsZsme+BzVICpDYq3J1cJ6yqURmc/EmXllxgGru5/yZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQH7UWxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427F6C4CEED;
	Tue,  8 Jul 2025 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751975724;
	bh=+rr5IUZMNLv1aC8gIdC2OTcN+TiRteFK92MBd6ezAYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQH7UWxnNBi4BoxndCKPTZn+85+ds7CvXHALFDbLeRWOGooAhY6mFhoI8J3IyDZlR
	 7gLu6RO/QUgcKaKHrCV5BFc1Qh/Ehga58W8yKUjWxYp3+iU8uHzZKaYMtZWBWZndai
	 ys0KbZ/WkpCMq46ocy/C6Yp0X4dd4q3MTLmLzJehan8LZL5Q00ih/ctUlgBWNLWJR8
	 R3wgn345vbPxRtJX+dMqrJjxZtEKwx/xWTV4vQ8VqVUvLiK4BotKdPRgRh6NfPKlQO
	 +ActSeB34oHpy+u76senrBTsROrindxj0DZ2/QH18caLVM0+fLsmFjiHlqmkSkUk+q
	 nnUZSiP4um/kQ==
Date: Tue, 8 Jul 2025 13:55:18 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	rust-for-linux@vger.kernel.org,
	Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <aG0HJte0Xw55z_y4@pollux>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>

On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
> +cc Liam
> 
> Hi guys,
> 
> We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
> it's slightly concerning to find a series (at v11!) like this that changes
> mm-related stuff and it involves files not listed there and nobody bothered
> to cc- the people listed there.

What files are you referring to? Are you referring to:

	rust/kernel/alloc.rs
	rust/kernel/alloc/*

If so, they're indeed not under the "MEMORY MANAGEMENT - RUST" entry, which
so far seems correct.

Please also note that we had "RUST [ALLOC]" before "MEMORY MANAGEMENT - RUST"
did exist.

> I can fully understand there being some process fail here meaning you
> missed it - fine if so - but let's fix it please moving forwards.

I agree that this series should have a couple more people in Cc.

Given the existing entries in the MAINTAINERS file the Rust parts seems to be
correct though.

> It's really important to me that the rust efforts in mm are collaborative -
> I really believe in your mission (well - for me it's about the compiler
> _helping_ me not shooting me in the foot :) - and have put substantial
> effort in assisting initial work there. So let's make sure we're
> collaborative in both directions please.

AFAICT, those efforts are collaborative.

Back then I sent patches to introduce vrealloc() and improve and align
kvrealloc() and krealloc() [1]; it was also mentioned that this was, besides the
other advantages, prerequisite work for the Rust allocator patch series [2].

The subsequent Rust allocator patch series [2] was also sent to Andrew and the
-mm mailing list; the previous code replaced by this series was maintained under
the "RUST" entry in the maintainers file.

With the introduction of the new Rust allocator code I took over maintainership.

So, Andrew is aware of the Rust allocator tree, please see also [3].

[1] https://lore.kernel.org/all/20240722163111.4766-1-dakr@kernel.org/
[2] https://lore.kernel.org/all/20241004154149.93856-1-dakr@kernel.org/
[3] https://lore.kernel.org/all/20250625143450.2afc473fc0e7124a5108c187@linux-foundation.org/

> We have rust/kernel/mm/ under MEMORY MANAGEMENT - RUST too, I'm not au fait
> with your approach to structuring in these folders but seems to me these
> helpers should be there? I may be unaware of some rust aspect of this
> however.

The Rust allocator module is a user of exactly three functions of mm, i.e.
krealloc(), vrealloc(), kvrealloc(), with a thin abstraction layer for those
three allocator backends. Everything else is rather Rust core infrastructure
than mm infrastructure.

> Can we please add these files to this section and in future cc people
> listed there? We're here to help!

What's your proposal regarding maintainership? Are you asking me to drop it to
"MEMORY MANAGEMENT - RUST"?

> A side-note I wonder if we also need to put specific files also in relevant
> mm sections? E.g. the slab helper should also be put under the slab section
> perhaps?

Yes, we could. But in the end all Rust helper functions are transparent
wrappers, simply forwarding a function call *without* any additional logic.
They don't really require maintainence effort, and, in the end, are just
trivial boilerplate.

