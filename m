Return-Path: <linux-kernel+bounces-812941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CCB53E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC097565683
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11AA34AAEE;
	Thu, 11 Sep 2025 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKOSrtqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51660346A11;
	Thu, 11 Sep 2025 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628725; cv=none; b=eJyIieytzIbsK77CMpChVYMJzYMutIuR5DY109iwJU28rdvN1xVx2twfpwvHT+47na0ZlUocraTIXgwE7lrg++AOBOx2lPyYld8GFcaWHTTAV8XFU4aTAHwXAoB2Oj6fNFifUOWYjBtyUng8Nr3IKMVQVkGzt2wWmcEHjHDvoIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628725; c=relaxed/simple;
	bh=DeLh3i9NlJmc/TaFuy9SbAsEHHq0KJslJKPRhSgnwfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjI4nL0ii+dtFophBRJIusni8UTMFOBpvi5FVSYFRIo4/8ap0eiRsmFUsyCkt0jUioow3p4Ss0ym02HDBEMN7AHaZnnw8nOPRR379YT+XZx9fc+uYOmeUQhG1WberJxnRrReZUOulc4PfMpRBwy4Pj4heMKKO1mRZRsIUbYStxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKOSrtqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C6CC4CEF0;
	Thu, 11 Sep 2025 22:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757628724;
	bh=DeLh3i9NlJmc/TaFuy9SbAsEHHq0KJslJKPRhSgnwfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKOSrtqKQVZlMs9z6RnoiO9/kj9V+A1VDufGQhBGin6cryYHGL/O1aOqMXF6oTedS
	 sN84d+io1JlNFB2WR8QI54FM8QBQ/VHw7p/P27Q2eKjxZq+cnxIHQo7MLHcshuzxSb
	 Hsb/Fu9WaI01ggTmvYxCHPwvdrOM7wD9BPqsd6pXT5p5KpnpmoZ9HvT5ajYfZjD5jl
	 yUgVi/BBU2LCg61hR1oOYCyb2V9LCWCMuPmoMsLFlqeUg+bD7+ssp6bzXF2+0skMcc
	 Ouo0jKTC/WjXgm64Wsp2dt8HRkJBOTOUG7o6JhVDWkPnq7OyhLhoLx3EbHdDYtw5sg
	 tJoFqPr+ek1xA==
Date: Fri, 12 Sep 2025 00:12:00 +0200
From: Helge Deller <deller@kernel.org>
To: Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-parisc <linux-parisc@vger.kernel.org>
Cc: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
	Helge Deller <deller@gmx.de>
Subject: boot failure because of inaccurate page_pool_page_is_pp() on 32-bit
 kernels
Message-ID: <aMNJMFa5fDalFmtn@p100>
References: <5a004aef-9df1-4126-b167-1aae27d4240d@gmx.de>
 <1756327287@msgid.manchmal.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1756327287@msgid.manchmal.in-ulm.de>

As reported earlier in this mail thread, all 32-bit Linux kernels since v6.16
fail to boot on the parisc architecture like this:

 BUG: Bad page state in process swapper  pfn:000f7
 page: refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0xf7
 flags: 0x0(zone=0)
 raw: 00000000 118022c0 118022c0 00000000 00000000 00000000 ffffffff 00000000
 raw: 00000000
 page dumped because: page_pool leak
 Modules linked in:
 CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc1-32bit+ #2730 NONE
 Hardware name: 9000/778/B160L
 Backtrace:
  [<106ece88>] bad_page+0x14c/0x17c
  [<10406c50>] free_page_is_bad.part.0+0xd4/0xec
  [<106ed180>] free_page_is_bad+0x80/0x88
  [<106ef05c>] __free_pages_ok+0x374/0x508
  [<1011d34c>] __free_pages_core+0x1f0/0x218
  [<1011a2f0>] memblock_free_pages+0x68/0x94
  [<10120324>] memblock_free_all+0x26c/0x310
  [<1011a4d8>] mm_core_init+0x18c/0x208
  [<10100e88>] start_kernel+0x4ec/0x7a0
  [<101054d0>] start_parisc+0xb4/0xc4

git bisecting leads to this patch which triggers the crash:

 commit ee62ce7a1d909ccba0399680a03c2dee83bcae95
 Author: Toke Høiland-Jørgensen <toke@redhat.com>
 Date:   Wed Apr 9 12:41:37 2025 +0200
    page_pool: Track DMA-mapped pages and unmap them when destroying the pool

It turns out that the patch itself isn't wrong.

But it's the culprit which leads to the kernel bug since it modifies
PP_MAGIC_MASK for 32-bit kernels from:

-#define PP_MAGIC_MASK ~0x3UL
+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)

Function page_pool_page_is_pp() needs to unambiguously identify page pool
pages (using PP_MAGIC_MASK), but since the patch now reduced the valid bits to
check in PP_MAGIC_MASK from 0xFFFFFFFC to 0xc000007c, the remaining bits are
not sufficient to unambiguously identify such pages any longer.

Because of that, page_pool_page_is_pp() sometimes wrongly reports pages as
page pool pages and as such triggers the kernel BUG as it believes it found a
page pool leak.

IMHO this is a generic 32-bit kernel issue, not just affecting parisc.

Do you see any options other than:
a) revert the patch (ee62ce7a1d90), or:
b) return false in page_pool_page_is_pp() when !defined(CONFIG_64BIT),
   which means to effectively disable the page pool page test on 32bit
   machines

Helge

