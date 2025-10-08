Return-Path: <linux-kernel+bounces-845741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94503BC5F92
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6178B4E4F37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6FF2BE048;
	Wed,  8 Oct 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LtQzG6vE"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3732BDC34
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939998; cv=none; b=HlqAddXa0b4PU+r2/wOtwyGNFYn2P8ZBqRCH3P3pubhCHwt7676E34+ZJmdAKgvXzzfuVe+FJtrvGBmktqlLYgt/RkGhQ6el7NByRro6F5fVs4ZX+MyrJ4bCRZFAsWpUdKBLNuNaZbuHc38VpejNTPsans9OzB5SX7F3LiLRx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939998; c=relaxed/simple;
	bh=2iYsAU6ifLFA4fdkSzc1xSXLitRjDqxAKkIQaGDwGP0=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dHEjqTAHtQHI/WGQHohkG6vnYGqDQMBxajAe6M3L4NXGUFKBnsVM9hYDmJqEMlp8R3/Mao4844za4zEKLIwCjhtsZnXDIY1GXFRfov6361BDd+U8ifsC4Mp1aLmq3rXUU1AUC6e5n0g4AfaSMojX5m9L1/I4LxoZahAtRzvB/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LtQzG6vE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 Oct 2025 09:13:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759939994; h=from:from:reply-to:subject:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GhaQIw0YWCJevxGPseQUuOnhPulu+oVpbQ4S6ejkTkQ=;
	b=LtQzG6vEX+0mnRrrNSWhbb5wvkg3DmJEFE2Wvv+t7ECRR85RzgFqBrNFA4zE4ODmBbPEsg
	a5AHrVJfQ/nA6c2PyyDBXF4CWLps8lwGHsZc2Hn3FI8+1TRyPc9JfUiVksdr9rXjdAsZrE
	TyRTZ59obYWiWIJDANvMbM9YkdA4hsU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, yangge1116@126.com, david@redhat.com, 
	hughd@google.com
Message-ID: <ub7i6tidjmezzgjqxk5wk3ckf2ce25fv3yxuyfgqe7f2f3llfk@eutbtrb5kpyd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Bcc:
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
Message-ID: <mkfwoqg3k66632ltgg2t6rp3l2pmkrhu2jfgip2nsn7qp7aveo@l3ajbhzvzuns>
Reply-To:
In-Reply-To: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>

CC Huge, yangge, David

On Mon, Oct 06, 2025 at 01:25:26PM +0000, Dmitry Ilvokhin wrote:
> __mlock_folio() does not move folio to unevicable LRU, when
> folio_activate() removes folio from LRU.
> 
> To prevent this case also check for folio_test_mlocked() in
> folio_mark_accessed(). If folio is not yet marked as unevictable, but
> already marked as mlocked, then skip folio_activate() call to allow
> __mlock_folio() to make all necessary updates. It should be safe to skip
> folio_activate() here, because mlocked folio should end up in
> unevictable LRU eventually anyway.
> 
> To observe the problem mmap() and mlock() big file and check Unevictable
> and Mlocked values from /proc/meminfo. On freshly booted system without
> any other mlocked memory we expect them to match or be quite close.
> 
> See below for more detailed reproduction steps. Source code of stat.c is
> available at [1].
> 
>   $ head -c 8G < /dev/urandom > /tmp/random.bin
> 
>   $ cc -pedantic -Wall -std=c99 stat.c -O3 -o /tmp/stat
>   $ /tmp/stat
>   Unevictable:     8389668 kB
>   Mlocked:         8389700 kB
> 
>   Need to run binary twice. Problem does not reproduce on the first run,
>   but always reproduces on the second run.
> 
>   $ /tmp/stat
>   Unevictable:     5374676 kB
>   Mlocked:         8389332 kB
> 
> [1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd
> 
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> ---
> Changes in v2:
>   - Rephrase commit message: frame it in terms of unevicable LRU, not stat
>     accounting.
> 
>  mm/swap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 2260dcd2775e..f682f070160b 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -469,6 +469,16 @@ void folio_mark_accessed(struct folio *folio)
>  		 * this list is never rotated or maintained, so marking an
>  		 * unevictable page accessed has no effect.
>  		 */
> +	} else if (folio_test_mlocked(folio)) {
> +		/*
> +		 * Pages that are mlocked, but not yet on unevictable LRU.
> +		 * They might be still in mlock_fbatch waiting to be processed
> +		 * and activating it here might interfere with
> +		 * mlock_folio_batch(). __mlock_folio() will fail
> +		 * folio_test_clear_lru() check and give up. It happens because
> +		 * __folio_batch_add_and_move() clears LRU flag, when adding
> +		 * folio to activate batch.
> +		 */

This makes sense as activating an mlocked folio should be a noop but I
am wondering why we are seeing this now. By this, I mean mlock()ed
memory being delayed to get to unevictable LRU. Also I remember Hugh
recently [1] removed the difference betwen mlock percpu cache and other
percpu caches of clearing LRU bit on entry. Does you repro work even
with Hugh's changes or without it?

[1] https://lore.kernel.org/all/05905d7b-ed14-68b1-79d8-bdec30367eba@google.com/

