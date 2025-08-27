Return-Path: <linux-kernel+bounces-788871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E06FB38B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E5B68159C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5630DD26;
	Wed, 27 Aug 2025 21:38:48 +0000 (UTC)
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBB1A073F;
	Wed, 27 Aug 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330728; cv=none; b=hwr7VTWIBoI+ZBc4GJlJOSjaCem56Lps1T+mpJdt9s5VusLMF2Fli67v/Hk+39BGX4aaDEt+mRAqvvaNXadQnpIxvgGfWOG6zZBWehGaeu9Ul0TNmY7s+Zt3NKJXylyNUmdMo2egQvP/Lo05l6n1sdQhev3xeqM8eT9N3aUg/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330728; c=relaxed/simple;
	bh=cNnfe3h2A6/RCyh5rp0YKdwXKN20aOpO3jek1QYuGgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuII/za7v3gUWCz4QG7JiMXHMkWrgU2+xVCKsi4Y+vU8KRz+NLJT8qYtdY7YZqf6WPlyEQpx/y2zJLbwj4t5pkaawJ2dBosaVP1agpOJhlM+ajH5BwZu35y0afoqwB/tl6lAFlWAT+ENUPh1PLUvMhHo5FehGmq7Qoq7v8sgM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Wed, 27 Aug 2025 23:31:02 +0200
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: Helge Deller <deller@gmx.de>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-parisc <linux-parisc@vger.kernel.org>
Subject: Re: 6.16-pre-rc1: BUG: Bad page state in process swapper on parisc
Message-ID: <1756327287@msgid.manchmal.in-ulm.de>
References: <5a004aef-9df1-4126-b167-1aae27d4240d@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a004aef-9df1-4126-b167-1aae27d4240d@gmx.de>

Sorry for being somewhat late to the party ...

Helge Deller wrote a few weeks ago ...

> I'm facing a kernel crash on the 32-bit parisc platform with git head.
> 
> git bisecting leads to this patch which triggers the crash:
> commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
> 
> Syslog:...
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 131072
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] stackdepot: allocating hash table via alloc_large_system_hash
> [    0.000000] stackdepot hash table entries: 32768 (order: 6, 262144 bytes, linear)
> ..
> [    0.000000] MEMBLOCK configuration: (I added this output during debugging:)
> [    0.000000]  memory size = 0x20000000 reserved size = 0x01f0ed2a
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x00000000-0x1fffffff], 0x20000000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0xa
> [    0.000000]  reserved[0x0]   [0x00000000-0x0008a0b0], 0x0008a0b1 bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x0008a0c0-0x0008a130], 0x00000071 bytes flags: 0x0
> [    0.000000]  reserved[0x2]   [0x0008a140-0x0008a143], 0x00000004 bytes flags: 0x0
> [    0.000000]  reserved[0x3]   [0x0008a150-0x0008a153], 0x00000004 bytes flags: 0x0
> [    0.000000]  reserved[0x4]   [0x0008a160-0x0008a2d3], 0x00000174 bytes flags: 0x0
> [    0.000000]  reserved[0x5]   [0x0008a2e0-0x0008a5e3], 0x00000304 bytes flags: 0x0
> [    0.000000]  reserved[0x6]   [0x0008a5f0-0x0008a6b3], 0x000000c4 bytes flags: 0x0
> [    0.000000]  reserved[0x7]   [0x0008a6c0-0x0008acc3], 0x00000604 bytes flags: 0x0
> [    0.000000]  reserved[0x8]   [0x0008acd0-0x000f6d8f], 0x0006c0c0 bytes flags: 0x0
> [    0.000000]  reserved[0x9]   [0x00100000-0x01f17fff], 0x01e18000 bytes flags: 0x0
> [    0.000000] BUG: Bad page state in process swapper  pfn:000f7
> [    0.000000] page: refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0xf7
> [    0.000000] flags: 0x0(zone=0)
> [    0.000000] raw: 00000000 118022c0 118022c0 00000000 00000000 00000000 ffffffff 00000000
> [    0.000000] raw: 00000000
> [    0.000000] page dumped because: page_pool leak
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc1-32bit+ #2730 NONE
> [    0.000000] Hardware name: 9000/778/B160L
> [    0.000000] Backtrace:
> [    0.000000]  [<1041d1f4>] show_stack+0x34/0x48
> [    0.000000]  [<10412dd8>] dump_stack_lvl+0x80/0xc8
> [    0.000000]  [<10412e3c>] dump_stack+0x1c/0x2c
> [    0.000000]  [<106ece88>] bad_page+0x14c/0x17c
> [    0.000000]  [<10406c50>] free_page_is_bad.part.0+0xd4/0xec
> [    0.000000]  [<106ed180>] free_page_is_bad+0x80/0x88
> [    0.000000]  [<106ef05c>] __free_pages_ok+0x374/0x508
> [    0.000000]  [<1011d34c>] __free_pages_core+0x1f0/0x218
> [    0.000000]  [<1011a2f0>] memblock_free_pages+0x68/0x94
> [    0.000000]  [<10120324>] memblock_free_all+0x26c/0x310
> [    0.000000]  [<1011a4d8>] mm_core_init+0x18c/0x208
> [    0.000000]  [<10100e88>] start_kernel+0x4ec/0x7a0
> [    0.000000]  [<101054d0>] start_parisc+0xb4/0xc4

The same occured here but due to time constraints and hardware issues I
couldn't dig into this earlier.

Bisecting in the 6.15.y stable series led to commit c30ae60f41f9 which
was cherry-picked from ee62ce7a1d90 ("page_pool: Track DMA-mapped pages
and unmap them when destroying the pool").

The problem still exists in 6.17-rc2.

| HP-UX model name: 9000/785/C3600
if that matters.

    Christoph

