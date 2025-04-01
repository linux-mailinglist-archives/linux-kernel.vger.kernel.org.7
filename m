Return-Path: <linux-kernel+bounces-582684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8330A7716E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 01:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F459188B350
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DC21CA1E;
	Mon, 31 Mar 2025 23:41:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3641A3BD7;
	Mon, 31 Mar 2025 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464514; cv=none; b=MQ5qAgnpVlZarPWWnuUQ3GNZxzubQ5FEpOAtabAkY59EL57+oq3mAcrdUGiYtrTBDBIbjsD9Zi1iIbI6oAMgEH+koc1AEEtGTotMPfnO4VhrohNsG1iFNEg+ogU3vkcdLuEvcVKz01/LMSSXPTYEDcQapZ+7e2vi7PVyXmlK9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464514; c=relaxed/simple;
	bh=9KZxB4m0z1ElUoj2DcNAzurAKPTG9+rqDgzLzLTebUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9D+BH75P6xJuLyCnlr87lEfbcvg4a3NEGgInd+ojT+i5yQYY1lr3so6UdIXgMqVS+qje67cAVNuKBZ5u/Mi4/9ZuNSpy7FGiR+9NF4I09aPqRIgPtFZLOspc945tmq+i3Z2goQY0EFA5YLUc4wzULOuE2PbT0VptP4OA1igUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977B2C4CEEA;
	Mon, 31 Mar 2025 23:41:52 +0000 (UTC)
Date: Mon, 31 Mar 2025 19:42:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331194251.02a4c238@gandalf.local.home>
In-Reply-To: <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
	<20250331165801.715aba48@gandalf.local.home>
	<CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 14:42:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> .. and *after* you've given it back to the memory allocator, and it
> gets allocated using the page allocators, at that point ahead and use
> 'struct page' as much as you want.
> 
> Before that, don't. Even if it might work. Because you didn't allocate
> it as a struct page, and for all you know it might be treated as a
> different hotplug memory zone or whatever when given back.

Hmm, so if we need to map this memory to user space memory, then I can't
use the method from this patch series, if I have to avoid struct page.

Should I then be using vm_iomap_memory() passing in the physical address?

As for architectures that do not have user/kernel data cache coherency, how
does one flush the page when there's an update on the kernel side so that
the user side doesn't see stale data?

As the code currently uses flush_dcache_folio(), I'm guessing there's an
easy way to create a folio that points to physical memory that's not part
of the memory allocator?

Matthew?

-- Steve

